Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773CE6FB1
	for <xenomai@lists.linux.dev>; Wed, 10 Jan 2024 04:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="eQwECuEi"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20240110044603f48c1a44a179e7065a
        for <xenomai@lists.linux.dev>;
        Wed, 10 Jan 2024 05:46:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=Z9vvTUfplD1IesLTnTuyYZygVkciJLiWda/hoiPqMQU=;
 b=eQwECuEi1eTLT5wEQctTAUWdMewIjuB8ycoUju3yb5RHLKK3jKOQUbn6qNUlCZhqGHIsol
 nWaFB5/n8Ph6IoKrbc7sEYFJ6MDPWGjNXLFBIC+wfS//GvI8L9UY5hGHT/JjGijbvz+h+jIh
 8W4xsL182wXUPVlX+DNeLmNRa7hkQ=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH v3 01/10] Add Isar patch to permit linux-libc-dev upgrades in the sbuild environment
Date: Wed, 10 Jan 2024 05:45:53 +0100
Message-Id: <46b62659d3ca20a7ad418d44432e4359bd6d4a03.1704861962.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1704861962.git.jan.kiszka@siemens.com>
References: <cover.1704861962.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

This will be needed by libevl. Upgrade Isar rev along that to make the
patch apply.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...port-for-replacing-pre-installed-pac.patch | 168 ++++++++++++++++++
 kas.yml                                       |   6 +-
 2 files changed, 173 insertions(+), 1 deletion(-)
 create mode 100644 isar-patches/0001-dpkg-Restore-support-for-replacing-pre-installed-pac.patch

diff --git a/isar-patches/0001-dpkg-Restore-support-for-replacing-pre-installed-pac.patch b/isar-patches/0001-dpkg-Restore-support-for-replacing-pre-installed-pac.patch
new file mode 100644
index 0000000..3132f06
--- /dev/null
+++ b/isar-patches/0001-dpkg-Restore-support-for-replacing-pre-installed-pac.patch
@@ -0,0 +1,168 @@
+From d65b5f67405dcc83044008e589fa9ff98604d0e6 Mon Sep 17 00:00:00 2001
+From: Jan Kiszka <jan.kiszka@siemens.com>
+Date: Sun, 17 Dec 2023 17:27:01 +0100
+Subject: [PATCH] dpkg: Restore support for replacing pre-installed packages in
+ sbuild-chroot
+
+During the migration to sbuild, support for using self-built packages in
+the build environment was lost if those were already part of the
+sbuild-chroot. This restores it by adding --apt-distupgrade to the
+sbuild call. But that is not enough because sbuild will only upgrade
+packages from already configured sources, not those specified via
+--extra-repository. We therefore have to switch back to configuring
+isar-apt during sbuild-chroot creation.
+
+As rootfs_configure_isar_apt configures the isar repo under
+/isar-apt, we bind-mount the one in /home/builder/${PN} to that folder.
+Another difference is that we now need to run apt-get update explicitly,
+but only for isar-apt.
+
+And because the sbuild-chroots are now left behind with isar-apt
+configured, the configuration in imager_run can be removed (credits to
+Srinuvasan Arjunan).
+
+Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
+---
+ meta/classes/dpkg-base.bbclass                | 27 ++++++++++---------
+ meta/classes/dpkg.bbclass                     |  5 ++--
+ meta/classes/image-tools-extension.bbclass    | 13 ---------
+ .../sbuild-chroot/sbuild-chroot.inc           |  2 --
+ 4 files changed, 18 insertions(+), 29 deletions(-)
+
+diff --git a/meta/classes/dpkg-base.bbclass b/meta/classes/dpkg-base.bbclass
+index 7b054d3f..52baf169 100644
+--- a/meta/classes/dpkg-base.bbclass
++++ b/meta/classes/dpkg-base.bbclass
+@@ -19,8 +19,6 @@ DEPENDS:append:riscv64 = "${@' crossbuild-essential-riscv64' if d.getVar('ISAR_C
+ DEB_BUILD_PROFILES ?= ""
+ DEB_BUILD_OPTIONS ?= ""
+ 
+-ISAR_APT_REPO ?= "deb [trusted=yes] file:///home/builder/${PN}/isar-apt/${DISTRO}-${DISTRO_ARCH}/apt/${DISTRO} ${DEBDISTRONAME} main"
+-
+ python do_adjust_git() {
+     import subprocess
+ 
+@@ -221,8 +219,17 @@ def isar_export_build_settings(d):
+     os.environ['DEB_BUILD_OPTIONS']  = isar_deb_build_options(d)
+     os.environ['DEB_BUILD_PROFILES'] = isar_deb_build_profiles(d)
+ 
++dpkg_schroot_create_configs() {
++    schroot_create_configs
++    sudo -s <<'EOSUDO'
++        sbuild_fstab="${SBUILD_CONF_DIR}/fstab"
++        fstab_isarapt="${WORKDIR}/isar-apt/${DISTRO}-${DISTRO_ARCH}/apt/${DISTRO} /isar-apt none rw,bind 0 0"
++        grep -qxF "${fstab_isarapt}" ${sbuild_fstab} || echo "${fstab_isarapt}" >> ${sbuild_fstab}
++EOSUDO
++}
++
+ python do_dpkg_build() {
+-    bb.build.exec_func('schroot_create_configs', d)
++    bb.build.exec_func('dpkg_schroot_create_configs', d)
+     try:
+         bb.build.exec_func("dpkg_runbuild", d)
+     finally:
+@@ -288,7 +295,7 @@ do_deploy_deb[lockfiles] = "${REPO_ISAR_DIR}/isar.lock"
+ do_deploy_deb[dirs] = "${S}"
+ 
+ python do_devshell() {
+-    bb.build.exec_func('schroot_create_configs', d)
++    bb.build.exec_func('dpkg_schroot_create_configs', d)
+ 
+     isar_export_proxies(d)
+     isar_export_ccache(d)
+@@ -297,11 +304,9 @@ python do_devshell() {
+         bb.build.exec_func('schroot_configure_ccache', d)
+ 
+     schroot = d.getVar('SBUILD_CHROOT')
+-    isar_apt = d.getVar('ISAR_APT_REPO')
+     pkg_arch = d.getVar('PACKAGE_ARCH')
+     build_arch = d.getVar('BUILD_ARCH')
+     pp_pps = os.path.join(d.getVar('PP'), d.getVar('PPS'))
+-    debdistroname = d.getVar('DEBDISTRONAME')
+ 
+     install_deps = ":" if d.getVar('BB_CURRENTTASK') == "devshell_nodeps" else f"mk-build-deps -i \
+         --host-arch {pkg_arch} --build-arch {build_arch}  \
+@@ -310,15 +315,13 @@ python do_devshell() {
+ 
+     termcmd = "schroot -d / -c {0} -u root -- sh -c ' \
+         cd {1}; \
+-        echo {2} > /etc/apt/sources.list.d/isar_apt.list; \
+-        echo \"Package: *\nPin: release n={3}\nPin-Priority: 1000\" > /etc/apt/preferences.d/isar-apt; \
+-        echo \"APT::Get::allow-downgrades 1;\" > /etc/apt/apt.conf.d/50isar-apt; \
+-        apt-get -y -q update; \
+-        {4}; \
++        apt-get -y -q update -o Dir::Etc::SourceList=\"sources.list.d/isar-apt.list\" -o Dir::Etc::SourceParts=\"-\" -o APT::Get::List-Cleanup=\"0\"; \
++        apt-get -y upgrade; \
++        {2}; \
+         export PATH=$PATH_PREPEND:$PATH; \
+         $SHELL -i \
+     '"
+-    oe_terminal(termcmd.format(schroot, pp_pps, isar_apt, debdistroname, install_deps), "Isar devshell", d)
++    oe_terminal(termcmd.format(schroot, pp_pps, install_deps), "Isar devshell", d)
+ 
+     bb.build.exec_func('schroot_delete_configs', d)
+ }
+diff --git a/meta/classes/dpkg.bbclass b/meta/classes/dpkg.bbclass
+index 1d684e98..0cdb5792 100644
+--- a/meta/classes/dpkg.bbclass
++++ b/meta/classes/dpkg.bbclass
+@@ -110,16 +110,17 @@ dpkg_runbuild() {
+     DEB_SOURCE_NAME=$(dpkg-parsechangelog --show-field Source --file ${WORKDIR}/${PPS}/debian/changelog)
+     DSC_FILE=$(find ${WORKDIR} -name "${DEB_SOURCE_NAME}*.dsc" -maxdepth 1 -print)
+ 
+-    sbuild -A -n -c ${SBUILD_CHROOT} --extra-repository="${ISAR_APT_REPO}" \
++    sbuild -A -n -c ${SBUILD_CHROOT} \
+         --host=${PACKAGE_ARCH} --build=${BUILD_ARCH} ${profiles} \
+         --no-run-lintian --no-run-piuparts --no-run-autopkgtest --resolve-alternatives \
+         --bd-uninstallable-explainer=apt \
+-        --no-apt-update \
++        --no-apt-update --apt-distupgrade \
+         --chroot-setup-commands="echo \"Package: *\nPin: release n=${DEBDISTRONAME}\nPin-Priority: 1000\" > /etc/apt/preferences.d/isar-apt" \
+         --chroot-setup-commands="echo \"APT::Get::allow-downgrades 1;\" > /etc/apt/apt.conf.d/50isar-apt" \
+         --chroot-setup-commands="rm -f /var/log/dpkg.log" \
+         --chroot-setup-commands="mkdir -p ${deb_dir}" \
+         --chroot-setup-commands="ln -sf ${ext_deb_dir}/*.deb -t ${deb_dir}/" \
++        --chroot-setup-commands="apt-get update -o Dir::Etc::SourceList=\"sources.list.d/isar-apt.list\" -o Dir::Etc::SourceParts=\"-\" -o APT::Get::List-Cleanup=\"0\"" \
+         --finished-build-commands="rm -f ${deb_dir}/sbuild-build-depends-main-dummy_*.deb" \
+         --finished-build-commands="[ -z "$(find ${deb_dir} -maxdepth 1 -name '*.deb' -print -quit)" ] || cp ${CP_FLAGS} ${deb_dir}/*.deb -t ${ext_deb_dir}/" \
+         --finished-build-commands="cp /var/log/dpkg.log ${ext_root}/dpkg_partial.log" \
+diff --git a/meta/classes/image-tools-extension.bbclass b/meta/classes/image-tools-extension.bbclass
+index 58799fcf..46bdf78b 100644
+--- a/meta/classes/image-tools-extension.bbclass
++++ b/meta/classes/image-tools-extension.bbclass
+@@ -44,19 +44,6 @@ imager_run() {
+             distro="${HOST_BASE_DISTRO}-${BASE_DISTRO_CODENAME}"
+         fi
+ 
+-        # prepare isar-apt
+-        schroot -r -c ${session_id} -d / -u root -- sh -c " \
+-            mkdir -p '/etc/apt/sources.list.d'
+-            echo 'deb [trusted=yes] file:///isar-apt ${DEBDISTRONAME} main' > \
+-                '/etc/apt/sources.list.d/isar-apt.list'
+-
+-            mkdir -p '/etc/apt/preferences.d'
+-            cat << EOF > '/etc/apt/preferences.d/isar-apt'
+-Package: *
+-Pin: release n=${DEBDISTRONAME}
+-Pin-Priority: 1000
+-EOF"
+-
+         E="${@ isar_export_proxies(d)}"
+         deb_dl_dir_import ${schroot_dir} ${distro}
+         schroot -r -c ${session_id} -d / -u root -- sh -c " \
+diff --git a/meta/recipes-devtools/sbuild-chroot/sbuild-chroot.inc b/meta/recipes-devtools/sbuild-chroot/sbuild-chroot.inc
+index 39ced80b..2f07de82 100644
+--- a/meta/recipes-devtools/sbuild-chroot/sbuild-chroot.inc
++++ b/meta/recipes-devtools/sbuild-chroot/sbuild-chroot.inc
+@@ -56,8 +56,6 @@ SBUILD_CHROOT_DIR = "${WORKDIR}/rootfs"
+ ROOTFSDIR = "${SBUILD_CHROOT_DIR}"
+ ROOTFS_PACKAGES = "${SBUILD_CHROOT_PREINSTALL}"
+ 
+-# We don't need /etc/apt/sources.list.d/isar-apt.list' while it's handled by sbuild
+-ROOTFS_CONFIGURE_COMMAND:remove = "rootfs_configure_isar_apt"
+ ROOTFS_POSTPROCESS_COMMAND:remove = "rootfs_cleanup_isar_apt"
+ 
+ # Do not cleanup base-apt
+-- 
+2.35.3
+
diff --git a/kas.yml b/kas.yml
index 1b2e857..2017e68 100644
--- a/kas.yml
+++ b/kas.yml
@@ -22,9 +22,13 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    commit: 216f0721265fcfe965ac48b51a0128d612d89bf4
+    commit: 853784cf1732c093acd537fbb1b0b1c54e6b59ff
     layers:
       meta:
+    patches:
+      01:
+        repo: xenomai
+        path: isar-patches/0001-dpkg-Restore-support-for-replacing-pre-installed-pac.patch
 
 bblayers_conf_header:
   standard: |
-- 
2.35.3

