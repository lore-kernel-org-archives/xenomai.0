Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FDECA4A
	for <xenomai@lists.linux.dev>; Wed, 10 Jan 2024 04:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="GQJa3k2R"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20240110044603875aafdf625c202726
        for <xenomai@lists.linux.dev>;
        Wed, 10 Jan 2024 05:46:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=QwB4PGscfX5cWp1a7YRDhrVC1eqKbX1rxiNuFbkmWSM=;
 b=GQJa3k2RKMV5pHSdaDZgmiLXJq6ZD9f+5iMdifaA4lvoiPWp1/1otL/haCTZ4MY3jTuCN/
 7LDPXiNjdftMObWp/oTSmZPUqVnekK/5r+yg9OBbXVhxuamQOmPPtYhGRQEOcx6iLkVkNK3l
 7tJRMWgi2O2plbTQ/RZLW1ng0fMXw=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH v3 07/10] xenomai-4: Add evl userspace
Date: Wed, 10 Jan 2024 05:45:59 +0100
Message-Id: <4308209312d585ddeb399ced286f216e267b6284.1704861962.git.jan.kiszka@siemens.com>
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

From: Clara Kowalsky <clara.kowalsky@siemens.com>

The libevl recipe allows building the evl userspace.

Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
[Jan: reduced duplications, introduced opt-evl.yml and libevl_latest.bb,
      added required patch for r47, added runtime deps]
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 conf/distro/xenomai-demo.conf                 |  2 +
 opt-evl.yml                                   | 17 ++++++++
 opt-libevl-latest-release.yml                 | 19 +++++++++
 opt-libevl-next.yml                           | 19 +++++++++
 recipes-core/images/demo-image.bb             |  2 +
 .../linux/linux-xenomai-4_latest.bb           |  4 ++
 ...i-Take-Debian-multiarch-into-account.patch | 40 +++++++++++++++++++
 recipes-xenomai/libevl/files/debian/compat    |  1 +
 .../libevl/files/debian/control.tmpl          | 11 +++++
 recipes-xenomai/libevl/files/debian/rules     | 19 +++++++++
 recipes-xenomai/libevl/libevl.inc             | 31 ++++++++++++++
 recipes-xenomai/libevl/libevl_47.bb           | 15 +++++++
 recipes-xenomai/libevl/libevl_latest.bb       | 25 ++++++++++++
 recipes-xenomai/libevl/libevl_master.bb       | 17 ++++++++
 recipes-xenomai/libevl/libevl_next.bb         |  1 +
 15 files changed, 223 insertions(+)
 create mode 100644 opt-evl.yml
 create mode 100644 opt-libevl-latest-release.yml
 create mode 100644 opt-libevl-next.yml
 create mode 100644 recipes-xenomai/libevl/files/0001-meson-setup-uapi-Take-Debian-multiarch-into-account.patch
 create mode 100644 recipes-xenomai/libevl/files/debian/compat
 create mode 100644 recipes-xenomai/libevl/files/debian/control.tmpl
 create mode 100755 recipes-xenomai/libevl/files/debian/rules
 create mode 100644 recipes-xenomai/libevl/libevl.inc
 create mode 100644 recipes-xenomai/libevl/libevl_47.bb
 create mode 100644 recipes-xenomai/libevl/libevl_latest.bb
 create mode 100644 recipes-xenomai/libevl/libevl_master.bb
 create mode 120000 recipes-xenomai/libevl/libevl_next.bb

diff --git a/conf/distro/xenomai-demo.conf b/conf/distro/xenomai-demo.conf
index e6d690e..2915dbf 100644
--- a/conf/distro/xenomai-demo.conf
+++ b/conf/distro/xenomai-demo.conf
@@ -18,6 +18,8 @@ OVERRIDES .= ":xenomai${XENOMAI_MAJOR_VERSION}"
 PREFERRED_VERSION_xenomai ?= "3.2%"
 include conf/distro/include/xenomai-version.inc
 
+PREFERRED_VERSION_libevl ?= "4%"
+
 HOST_DISTRO ?= "debian-bookworm"
 
 KERNEL_NAME = "xenomai-${XENOMAI_MAJOR_VERSION}"
diff --git a/opt-evl.yml b/opt-evl.yml
new file mode 100644
index 0000000..5cfef59
--- /dev/null
+++ b/opt-evl.yml
@@ -0,0 +1,17 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2024
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+header:
+  version: 14
+
+local_conf_header:
+  xenomai-4: |
+    XENOMAI_MAJOR_VERSION ?= "4"
diff --git a/opt-libevl-latest-release.yml b/opt-libevl-latest-release.yml
new file mode 100644
index 0000000..7468b67
--- /dev/null
+++ b/opt-libevl-latest-release.yml
@@ -0,0 +1,19 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2023-2024
+#
+# Authors:
+#  Clara Kowalsky <clara.kowalsky@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+header:
+  version: 14
+  includes:
+    - opt-evl.yml
+
+local_conf_header:
+  libevl-version: |
+    PREFERRED_VERSION_libevl = "latest"
diff --git a/opt-libevl-next.yml b/opt-libevl-next.yml
new file mode 100644
index 0000000..aa83d1f
--- /dev/null
+++ b/opt-libevl-next.yml
@@ -0,0 +1,19 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2023-2024
+#
+# Authors:
+#  Clara Kowalsky <clara.kowalsky@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+header:
+  version: 14
+  includes:
+    - opt-evl.yml
+
+local_conf_header:
+  libevl-version: |
+    PREFERRED_VERSION_libevl = "next"
diff --git a/recipes-core/images/demo-image.bb b/recipes-core/images/demo-image.bb
index db7e2c7..e19a038 100644
--- a/recipes-core/images/demo-image.bb
+++ b/recipes-core/images/demo-image.bb
@@ -44,4 +44,6 @@ IMAGE_PREINSTALL += " \
 IMAGE_INSTALL:append:xenomai3 = " xenomai-runtime xenomai-runtime-dbgsym"
 IMAGE_INSTALL:append:xenomai3 = " ${@get_testsuite_package_names(d)}"
 IMAGE_INSTALL:append:xenomai3 = " libxenomai1-dbgsym"
+IMAGE_INSTALL:append:xenomai4 = " libevl"
+
 IMAGE_INSTALL += "customizations sshd-regen-keys expand-on-first-boot"
diff --git a/recipes-kernel/linux/linux-xenomai-4_latest.bb b/recipes-kernel/linux/linux-xenomai-4_latest.bb
index c225034..c4a254f 100644
--- a/recipes-kernel/linux/linux-xenomai-4_latest.bb
+++ b/recipes-kernel/linux/linux-xenomai-4_latest.bb
@@ -13,6 +13,10 @@ require recipes-kernel/linux/linux-xenomai-4.inc
 
 PV = "9999-g${COMMIT}"
 
+def is_kernel(d, ver):
+    linux_ver = d.getVar('LATEST_GIT_BRANCH') or ''
+    return linux_ver == ver
+
 python () {
     import subprocess
     if is_kernel(d, 'latest'):
diff --git a/recipes-xenomai/libevl/files/0001-meson-setup-uapi-Take-Debian-multiarch-into-account.patch b/recipes-xenomai/libevl/files/0001-meson-setup-uapi-Take-Debian-multiarch-into-account.patch
new file mode 100644
index 0000000..3c1f48c
--- /dev/null
+++ b/recipes-xenomai/libevl/files/0001-meson-setup-uapi-Take-Debian-multiarch-into-account.patch
@@ -0,0 +1,40 @@
+From b4447250c7fff6940c1bb6f0308da617bebaa643 Mon Sep 17 00:00:00 2001
+From: Jan Kiszka <jan.kiszka@siemens.com>
+Date: Tue, 2 Jan 2024 14:01:19 +0100
+Subject: [PATCH] meson: setup-uapi: Take Debian multiarch into account
+
+Check also the Debian multiarch include path for the chosen architecture
+so that we can support (self-built) linux-libc-dev packages that contain
+the evl headers.
+
+Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
+---
+ meson/setup-uapi.sh | 12 +++++++++++-
+ 1 file changed, 11 insertions(+), 1 deletion(-)
+
+diff --git a/meson/setup-uapi.sh b/meson/setup-uapi.sh
+index f2d0774..633c5ed 100644
+--- a/meson/setup-uapi.sh
++++ b/meson/setup-uapi.sh
+@@ -17,7 +17,17 @@ if test -r $UAPI/Kbuild; then
+     link_dir $UAPI/arch/$ARCH/include/uapi/asm/evl asm
+     link_dir $UAPI/include/uapi/asm-generic .
+ else
++    DEB_HOST_ARCH=$ARCH
++    if [ "$DEB_HOST_ARCH" = "x86" ]; then
++        DEB_HOST_ARCH=amd64
++    fi
++    DEB_HOST_MULTIARCH=$( \
++        dpkg-architecture -q DEB_HOST_MULTIARCH -a $DEB_HOST_ARCH 2>/dev/null)
+     link_dir $UAPI/evl .
+-    link_dir $UAPI/asm/evl asm
++    if [ -d $UAPI/$DEB_HOST_MULTIARCH/asm/evl ]; then
++        link_dir $UAPI/$DEB_HOST_MULTIARCH/asm/evl asm
++    else
++        link_dir $UAPI/asm/evl asm
++    fi
+     link_dir $UAPI/asm-generic .
+ fi
+-- 
+2.35.3
+
diff --git a/recipes-xenomai/libevl/files/debian/compat b/recipes-xenomai/libevl/files/debian/compat
new file mode 100644
index 0000000..f599e28
--- /dev/null
+++ b/recipes-xenomai/libevl/files/debian/compat
@@ -0,0 +1 @@
+10
diff --git a/recipes-xenomai/libevl/files/debian/control.tmpl b/recipes-xenomai/libevl/files/debian/control.tmpl
new file mode 100644
index 0000000..36eb68c
--- /dev/null
+++ b/recipes-xenomai/libevl/files/debian/control.tmpl
@@ -0,0 +1,11 @@
+Source: ${PN}
+Section: misc
+Priority: optional
+Standards-Version: 3.9.6
+Maintainer: Xenomai project <xenomai@lists.linux.dev>
+Build-Depends: ${DEBIAN_BUILD_DEPENDS}
+
+Package: libevl
+Architecture: ${DISTRO_ARCH}
+Description: ${DESCRIPTION}
+Depends: ${shlibs:Depends}
diff --git a/recipes-xenomai/libevl/files/debian/rules b/recipes-xenomai/libevl/files/debian/rules
new file mode 100755
index 0000000..9c9148f
--- /dev/null
+++ b/recipes-xenomai/libevl/files/debian/rules
@@ -0,0 +1,19 @@
+#!/usr/bin/make -f
+
+DEB_BUILD_GNU_TYPE ?= $(shell dpkg-architecture -qDEB_BUILD_GNU_TYPE)
+DEB_HOST_GNU_TYPE ?= $(shell dpkg-architecture -qDEB_HOST_GNU_TYPE)
+
+ifeq ($(DEB_BUILD_GNU_TYPE), $(DEB_HOST_GNU_TYPE))
+UAPI=/usr/include
+else
+UAPI=/usr/$(DEB_HOST_GNU_TYPE)/include
+endif
+
+override_dh_fixperms:
+	dh_fixperms
+
+override_dh_auto_configure:
+	dh_auto_configure -- -Duapi=$(UAPI)
+
+%:
+	dh $@ --buildsystem=meson
diff --git a/recipes-xenomai/libevl/libevl.inc b/recipes-xenomai/libevl/libevl.inc
new file mode 100644
index 0000000..405be8b
--- /dev/null
+++ b/recipes-xenomai/libevl/libevl.inc
@@ -0,0 +1,31 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2023-2024
+#
+# Authors:
+#  Clara Kowalsky <clara.kowalsky@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+inherit dpkg
+inherit print-revision
+
+DESCRIPTION ?= "libevl libraries and tools"
+
+SRC_URI += "file://debian"
+
+DEPENDS = "linux-xenomai-4"
+DEBIAN_BUILD_DEPENDS ?= "debhelper (>= 10), meson"
+
+TEMPLATE_FILES = "debian/control.tmpl"
+TEMPLATE_VARS += "DEBIAN_BUILD_DEPENDS"
+
+S = "${WORKDIR}/git"
+
+do_prepare_build[cleandirs] += "${S}/debian"
+do_prepare_build() {
+    cp -r ${WORKDIR}/debian ${S}
+    deb_add_changelog
+}
diff --git a/recipes-xenomai/libevl/libevl_47.bb b/recipes-xenomai/libevl/libevl_47.bb
new file mode 100644
index 0000000..1d93e1d
--- /dev/null
+++ b/recipes-xenomai/libevl/libevl_47.bb
@@ -0,0 +1,15 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2023-2024
+#
+# Authors:
+#  Clara Kowalsky <clara.kowalsky@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+require libevl.inc
+
+SRC_URI += "git://source.denx.de/Xenomai/xenomai4/libevl.git;protocol=https;branch=master;tag=r${PV}"
+SRC_URI += "file://0001-meson-setup-uapi-Take-Debian-multiarch-into-account.patch"
diff --git a/recipes-xenomai/libevl/libevl_latest.bb b/recipes-xenomai/libevl/libevl_latest.bb
new file mode 100644
index 0000000..2b57083
--- /dev/null
+++ b/recipes-xenomai/libevl/libevl_latest.bb
@@ -0,0 +1,25 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2024
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+require libevl.inc
+
+python () {
+    import subprocess
+    cmd = 'git ls-remote --tags --head --refs https://source.denx.de/Xenomai/xenomai4/libevl.git | ' \
+          'sed -e "s/.*[[:space:]]refs\/\(tags\|heads\)\///" | grep "r[0-9]\+" | ' \
+          'sort -r -n -k 1.2 | head -1'
+    (ret, out) = subprocess.getstatusoutput(cmd)
+    d.setVar('LATEST_RELEASE', out)
+}
+
+SRC_URI += "git://source.denx.de/Xenomai/xenomai4/libevl.git;protocol=https;branch=master;tag=${LATEST_RELEASE}"
+
+CHANGELOG_V = "${@ d.getVar('LATEST_RELEASE').strip('r') }"
diff --git a/recipes-xenomai/libevl/libevl_master.bb b/recipes-xenomai/libevl/libevl_master.bb
new file mode 100644
index 0000000..a1809ab
--- /dev/null
+++ b/recipes-xenomai/libevl/libevl_master.bb
@@ -0,0 +1,17 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2023-2024
+#
+# Authors:
+#  Clara Kowalsky <clara.kowalsky@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+require libevl.inc
+
+SRC_URI += "git://source.denx.de/Xenomai/xenomai4/libevl.git;protocol=https;branch=${PV}"
+
+CHANGELOG_V = "9999-${PV}"
+SRCREV = "${AUTOREV}"
diff --git a/recipes-xenomai/libevl/libevl_next.bb b/recipes-xenomai/libevl/libevl_next.bb
new file mode 120000
index 0000000..85ab518
--- /dev/null
+++ b/recipes-xenomai/libevl/libevl_next.bb
@@ -0,0 +1 @@
+libevl_master.bb
\ No newline at end of file
-- 
2.35.3

