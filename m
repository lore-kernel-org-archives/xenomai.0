From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH 01/10] Update Isar revision
Date: Mon, 10 Feb 2020 19:17:40 +0100
Message-Id: <4570f88e3c6c352a7a6ea812e026ff45c2d435f4.1581358669.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1581358669.git.jan.kiszka@siemens.com>
References: <cover.1581358669.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1581358669.git.jan.kiszka@siemens.com>
References: <cover.1581358669.git.jan.kiszka@siemens.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Jan Kiszka <jan.kiszka@siemens.com>

This comes with a switch of the kernel build recipe which allows us to
drop the Isar patch. We just need to set a PV in linux-xenomai_latest
that starts with a number.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kas.yml                                            |   6 +-
 opt-linux-latest.yml                               |   5 +-
 opt-xenomai-next.yml                               |   3 -
 ...nel-linux-build-kernel-Allow-kernel-build.patch | 173 ---------------------
 recipes-kernel/linux/linux-xenomai_latest.bb       |   4 +-
 5 files changed, 4 insertions(+), 187 deletions(-)
 delete mode 100644 patches/0001-recipes-kernel-linux-build-kernel-Allow-kernel-build.patch

diff --git a/kas.yml b/kas.yml
index 78bd83d..26debc4 100644
--- a/kas.yml
+++ b/kas.yml
@@ -20,13 +20,9 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    refspec: a5d575a15285b7f66efbf3e2409a7f65d25ff15e
+    refspec: 18b3e9a15d1f054f5d1e697c66a8f1f9befc0537
     layers:
       meta:
-    patches:
-      latest-kernel:
-        repo: xenomai
-        path: patches/0001-recipes-kernel-linux-build-kernel-Allow-kernel-build.patch
 
 bblayers_conf_header:
   standard: |
diff --git a/opt-linux-latest.yml b/opt-linux-latest.yml
index 25d9606..a55c78f 100644
--- a/opt-linux-latest.yml
+++ b/opt-linux-latest.yml
@@ -12,9 +12,6 @@
 header:
   version: 8
 
-# lava uses nfs to deploy the image. For this we need a tarball instead of
-# full image
-
 local_conf_header:
   linux-xenomai-latest: |
-    PREFERRED_VERSION_linux-xenomai = "latest%"
+    PREFERRED_VERSION_linux-xenomai = "9999-latest"
diff --git a/opt-xenomai-next.yml b/opt-xenomai-next.yml
index 94381bd..6efaa71 100644
--- a/opt-xenomai-next.yml
+++ b/opt-xenomai-next.yml
@@ -12,9 +12,6 @@
 header:
   version: 8
 
-# lava uses nfs to deploy the image. For this we need a tarball instead of
-# full image
-
 local_conf_header:
   xenomai-latest: |
     PREFERRED_VERSION_xenomai = "next"
diff --git a/patches/0001-recipes-kernel-linux-build-kernel-Allow-kernel-build.patch b/patches/0001-recipes-kernel-linux-build-kernel-Allow-kernel-build.patch
deleted file mode 100644
index c3ab777..0000000
--- a/patches/0001-recipes-kernel-linux-build-kernel-Allow-kernel-build.patch
+++ /dev/null
@@ -1,173 +0,0 @@
-From 3322d3f1a062b950510028ed50b2f807dc780d24 Mon Sep 17 00:00:00 2001
-From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
-Date: Fri, 20 Sep 2019 13:44:56 +0200
-Subject: [PATCH] recipes-kernel/linux/build-kernel: Allow kernel build with
- AUTOREV
-
-For testing it is sometimes necessary to build the HEAD of a kernel
-tree. If ${PV} is set to latest the check Packageversion equals
-KERNEL_VERSION is deactivated. To allow this build use the KV instead
-PV in the package generation.
-
-Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
----
- .../linux/files/build-kernel.sh               | 81 ++++++++++---------
- 1 file changed, 41 insertions(+), 40 deletions(-)
-
-diff --git a/meta/recipes-kernel/linux/files/build-kernel.sh b/meta/recipes-kernel/linux/files/build-kernel.sh
-index 8b7b23b..24ddd6a 100644
---- a/meta/recipes-kernel/linux/files/build-kernel.sh
-+++ b/meta/recipes-kernel/linux/files/build-kernel.sh
-@@ -12,24 +12,24 @@ source /isar/common.sh
- host_arch=$(dpkg --print-architecture)
- 
- if [ "$host_arch" != "$target_arch" ]; then
--    case $target_arch in
--    armhf)
--        export ARCH=arm
--        export CROSS_COMPILE="arm-linux-gnueabihf-"
--        ;;
--    arm64)
--        export ARCH=arm64
--        export CROSS_COMPILE="aarch64-linux-gnu-"
--        ;;
--    mipsel)
--        export ARCH=mips
--        export CROSS_COMPILE="mipsel-linux-gnu-"
--        ;;
--    *)
--        echo "error: unsupported architecture ($target_arch)"
--        exit 1
--        ;;
--    esac
-+		case $target_arch in
-+		armhf)
-+				export ARCH=arm
-+				export CROSS_COMPILE="arm-linux-gnueabihf-"
-+				;;
-+		arm64)
-+				export ARCH=arm64
-+				export CROSS_COMPILE="aarch64-linux-gnu-"
-+				;;
-+		mipsel)
-+				export ARCH=mips
-+				export CROSS_COMPILE="mipsel-linux-gnu-"
-+				;;
-+		*)
-+				echo "error: unsupported architecture ($target_arch)"
-+				exit 1
-+				;;
-+		esac
- fi
- 
- REPACK_DIR="$1/../repack"
-@@ -43,12 +43,13 @@ else
- fi
- 
- KV=$( make -s kernelrelease )
--if [ "${KV}" != "${PV}" ]; then
--	echo "ERROR: Recipe PV is \"${PV}\" but should be \"${KV}\"" 1>&2
--	echo "ERROR: Probably due to CONFIG_LOCALVERSION" 1>&2
--	exit 1
-+if [ "${PV}" != "latest" ]; then
-+	if [ "${KV}" != "${PV}" ]; then
-+		echo "ERROR: Recipe PV is \"${PV}\" but should be \"${KV}\"" 1>&2
-+		echo "ERROR: Probably due to CONFIG_LOCALVERSION" 1>&2
-+		exit 1
-+	fi
- fi
--
- rm -f .version
- KBUILD_DEBARCH=$target_arch make -j $(($(nproc) * 2)) deb-pkg
- 
-@@ -65,13 +66,13 @@ sed -i "s/Architecture: .*/Architecture: any/" "${REPACK_DIR}/debian/control"
- 
- cd ..
- 
--dpkg-deb -R linux-image-${PV}_${PV}-1_*.deb "${REPACK_LINUX_IMAGE_DIR}"
--dpkg-deb -R linux-headers-${PV}_${PV}-1_*.deb "${REPACK_LINUX_HEADERS_DIR}"
-+dpkg-deb -R linux-image-${KV}_${KV}-1_*.deb "${REPACK_LINUX_IMAGE_DIR}"
-+dpkg-deb -R linux-headers-${KV}_${KV}-1_*.deb "${REPACK_LINUX_HEADERS_DIR}"
- 
- dpkg-gencontrol -crepack/debian/control \
- 	-lrepack/debian/changelog \
- 	-frepack/debian/files \
--	-plinux-image-${PV} \
-+	-plinux-image-${KV} \
- 	-P"${REPACK_LINUX_IMAGE_DIR}" \
- 	-DPackage="linux-image-${KERNEL_NAME}" \
- 	-DSection=kernel \
-@@ -80,32 +81,32 @@ dpkg-gencontrol -crepack/debian/control \
- 	-DArchitecture=$target_arch
- 
- # Add Debian-like link installation to postinst
--mkdir -p ${REPACK_LINUX_IMAGE_DIR}/lib/modules/${PV}
--touch "${REPACK_LINUX_IMAGE_DIR}/lib/modules/${PV}/.fresh-install"
-+mkdir -p ${REPACK_LINUX_IMAGE_DIR}/lib/modules/${KV}
-+touch "${REPACK_LINUX_IMAGE_DIR}/lib/modules/${KV}/.fresh-install"
- sed -i "${REPACK_LINUX_IMAGE_DIR}/DEBIAN/postinst" \
-     -e "/^set -e$/a\\
- \\
--if [ -f /lib/modules/${PV}/.fresh-install ]; then\\
-+if [ -f /lib/modules/${KV}/.fresh-install ]; then\\
- 	change=install\\
- else\\
- 	change=upgrade\\
- fi\\
--linux-update-symlinks \$change ${PV} /boot/vmlinuz-${PV}\\
--rm -f /lib/modules/${PV}/.fresh-install"
-+linux-update-symlinks \$change ${KV} /boot/vmlinuz-${KV}\\
-+rm -f /lib/modules/${KV}/.fresh-install"
- 
- # Add Debian-like link removal to postrm
- sed -i "${REPACK_LINUX_IMAGE_DIR}/DEBIAN/postrm" \
-     -e "/^set -e$/a\\
- \\
--rm -f /lib/modules/${PV}/.fresh-install\\
-+rm -f /lib/modules/${KV}/.fresh-install\\
- \\
- if [ \"\$1\" != upgrade ] && command -v linux-update-symlinks >/dev/null; then\\
--	linux-update-symlinks remove ${PV}  /boot/vmlinuz-${PV}\\
-+	linux-update-symlinks remove ${KV}  /boot/vmlinuz-${KV}\\
- fi"
- 
- # Make sure arm64 kernels are decompressed
- if [ "$target_arch" = "arm64" ]; then
--	vmlinuz="${REPACK_LINUX_IMAGE_DIR}/boot/vmlinuz-${PV}"
-+	vmlinuz="${REPACK_LINUX_IMAGE_DIR}/boot/vmlinuz-${KV}"
- 	mv "$vmlinuz" "$vmlinuz.gz"
- 	gunzip "$vmlinuz.gz"
- fi
-@@ -113,7 +114,7 @@ fi
- dpkg-gencontrol -crepack/debian/control \
- 	-lrepack/debian/changelog \
- 	-frepack/debian/files \
--	-plinux-headers-${PV} \
-+	-plinux-headers-${KV} \
- 	-P"${REPACK_LINUX_HEADERS_DIR}" \
- 	-Vkernel:debarch="${KERNEL_NAME}" \
- 	-DPackage="linux-headers-${KERNEL_NAME}" \
-@@ -122,15 +123,15 @@ dpkg-gencontrol -crepack/debian/control \
- 	-DArchitecture=$target_arch
- 
- fakeroot dpkg-deb -b "${REPACK_LINUX_IMAGE_DIR}" \
--	linux-image-${KERNEL_NAME}_${PV}-1_${KERNEL_NAME}.deb
--rm -f linux-image-${PV}_${PV}-1_*.deb
-+	linux-image-${KERNEL_NAME}_${KV}-1_${KERNEL_NAME}.deb
-+rm -f linux-image-${KV}_${KV}-1_*.deb
- fakeroot dpkg-deb -b "${REPACK_LINUX_HEADERS_DIR}" \
--	linux-headers-${KERNEL_NAME}_${PV}-1_${KERNEL_NAME}.deb
--rm -f linux-headers-${PV}_${PV}-1_*.deb
-+	linux-headers-${KERNEL_NAME}_${KV}-1_${KERNEL_NAME}.deb
-+rm -f linux-headers-${KV}_${KV}-1_*.deb
- 
- # linux-libc-dev causes dependency problems if we downgrade
- # remove it after the build so the downgraded version does not get deployed
- LINUX_LIBC_DEV_V=$( dpkg-query --show --showformat '${Version}' linux-libc-dev )
- if dpkg --compare-versions $LINUX_LIBC_DEV_V gt $PV-1; then
--	rm -f linux-libc-dev_${PV}*.deb
-+	rm -f linux-libc-dev_${KV}*.deb
- fi
--- 
-2.20.1
-
diff --git a/recipes-kernel/linux/linux-xenomai_latest.bb b/recipes-kernel/linux/linux-xenomai_latest.bb
index 7ad4fed..4aa246d 100644
--- a/recipes-kernel/linux/linux-xenomai_latest.bb
+++ b/recipes-kernel/linux/linux-xenomai_latest.bb
@@ -11,14 +11,14 @@
 
 require recipes-kernel/linux/linux-xenomai.inc
 
+PV = "9999-latest"
+
 SRC_URI_append_amd64 = " git://gitlab.denx.de/Xenomai/ipipe-x86.git;protocol=https;branch=ipipe-x86-4.19.y"
 SRCREV_amd64 = "${AUTOREV}"
 
 SRC_URI_append_arm64 = " git://gitlab.denx.de/Xenomai/ipipe-arm64.git;protocol=https;branch=ipipe/master"
 SRCREV_arm64 = "${AUTOREV}"
 
-
 SRC_URI_append_armhf = " git://gitlab.denx.de/Xenomai/ipipe-arm.git;protocol=https;branch=ipipe/master"
 SRCREV_armhf = "${AUTOREV}"
 S = "${WORKDIR}/git"
-
-- 
2.16.4


