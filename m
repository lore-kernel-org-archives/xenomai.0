Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0127B1DA43
	for <xenomai@lists.linux.dev>; Thu, 21 Dec 2023 16:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="HtMY5aOV"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202312211638295be6b59ed93c7996fb
        for <xenomai@lists.linux.dev>;
        Thu, 21 Dec 2023 17:38:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=rhlgeOYriFFJwynjAjQEYPpS3ufbBRfwh7JkGGOdhbE=;
 b=HtMY5aOVGKJvWNHahjQNAGW/zz2aFsmnMmQMhiXDE5U/tOklIb9uirW4kYdv+P/sZJ/7tJ
 shReQB9Q4JCtjeC660NvAiYPjhxkAxEvnV55/QRrtpBjZuV+mIisQgA1gj7qWLtN3LN9zEdc
 BNgCd3M5Oh6tV/xYWbwbChMIAKofY=;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev,
	rpm@xenomai.org
Cc: jan.kiszka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [xenomai-images][PATCH v2 4/7] xenomai-4: Add evl userspace
Date: Thu, 21 Dec 2023 17:37:40 +0100
Message-Id: <20231221163743.2923801-5-clara.kowalsky@siemens.com>
In-Reply-To: <20231221163743.2923801-1-clara.kowalsky@siemens.com>
References: <20231221163743.2923801-1-clara.kowalsky@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1047747:519-21489:flowmailer

The libevl recipe allows building the evl userspace.

Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
---
 opt-libevl-master.yml                         | 19 ++++++++
 opt-libevl-next.yml                           | 20 ++++++++
 opt-libevl-r46.yml                            | 19 ++++++++
 opt-libevl-stable.yml                         | 19 ++++++++
 recipes-core/images/demo-image.bb             |  2 +
 recipes-xenomai/libevl/files/debian/compat    |  1 +
 .../libevl/files/debian/control.tmpl          | 10 ++++
 recipes-xenomai/libevl/files/debian/rules     |  7 +++
 recipes-xenomai/libevl/libevl_master.bb       | 47 +++++++++++++++++++
 recipes-xenomai/libevl/libevl_next.bb         |  1 +
 recipes-xenomai/libevl/libevl_r46.bb          | 46 ++++++++++++++++++
 recipes-xenomai/libevl/libevl_r47.bb          |  1 +
 12 files changed, 192 insertions(+)
 create mode 100644 opt-libevl-master.yml
 create mode 100644 opt-libevl-next.yml
 create mode 100644 opt-libevl-r46.yml
 create mode 100644 opt-libevl-stable.yml
 create mode 100644 recipes-xenomai/libevl/files/debian/compat
 create mode 100644 recipes-xenomai/libevl/files/debian/control.tmpl
 create mode 100755 recipes-xenomai/libevl/files/debian/rules
 create mode 100644 recipes-xenomai/libevl/libevl_master.bb
 create mode 120000 recipes-xenomai/libevl/libevl_next.bb
 create mode 100644 recipes-xenomai/libevl/libevl_r46.bb
 create mode 120000 recipes-xenomai/libevl/libevl_r47.bb

diff --git a/opt-libevl-master.yml b/opt-libevl-master.yml
new file mode 100644
index 0000000..a3fb14f
--- /dev/null
+++ b/opt-libevl-master.yml
@@ -0,0 +1,19 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2023
+#
+# Authors:
+#  Clara Kowalsky <clara.kowalsky@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+header:
+  version: 10
+
+local_conf_header:
+  libevl-version: |
+    PREFERRED_VERSION_libevl = "master"
+  xenomai-4_override: |
+    OVERRIDES .= ":xenomai4"
diff --git a/opt-libevl-next.yml b/opt-libevl-next.yml
new file mode 100644
index 0000000..5e22d43
--- /dev/null
+++ b/opt-libevl-next.yml
@@ -0,0 +1,20 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2023
+#
+# Authors:
+#  Clara Kowalsky <clara.kowalsky@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+header:
+  version: 10
+
+local_conf_header:
+  libevl-version: |
+    PREFERRED_VERSION_libevl = "next"
+  xenomai-4_override: |
+    OVERRIDES .= ":xenomai4"
+
diff --git a/opt-libevl-r46.yml b/opt-libevl-r46.yml
new file mode 100644
index 0000000..53d15f0
--- /dev/null
+++ b/opt-libevl-r46.yml
@@ -0,0 +1,19 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2023
+#
+# Authors:
+#  Clara Kowalsky <clara.kowalsky@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+header:
+  version: 10
+
+local_conf_header:
+  libevl-version: |
+    PREFERRED_VERSION_libevl = "r46"
+  xenomai-4_override: |
+    OVERRIDES .= ":xenomai4"
diff --git a/opt-libevl-stable.yml b/opt-libevl-stable.yml
new file mode 100644
index 0000000..d9ce4a1
--- /dev/null
+++ b/opt-libevl-stable.yml
@@ -0,0 +1,19 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2023
+#
+# Authors:
+#  Clara Kowalsky <clara.kowalsky@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+header:
+  version: 10
+
+local_conf_header:
+  libevl-version: |
+    PREFERRED_VERSION_libevl = "r47"
+  xenomai-4_override: |
+    OVERRIDES .= ":xenomai4"
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
diff --git a/recipes-xenomai/libevl/files/debian/compat b/recipes-xenomai/libevl/files/debian/compat
new file mode 100644
index 0000000..f599e28
--- /dev/null
+++ b/recipes-xenomai/libevl/files/debian/compat
@@ -0,0 +1 @@
+10
diff --git a/recipes-xenomai/libevl/files/debian/control.tmpl b/recipes-xenomai/libevl/files/debian/control.tmpl
new file mode 100644
index 0000000..9880ee9
--- /dev/null
+++ b/recipes-xenomai/libevl/files/debian/control.tmpl
@@ -0,0 +1,10 @@
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
diff --git a/recipes-xenomai/libevl/files/debian/rules b/recipes-xenomai/libevl/files/debian/rules
new file mode 100755
index 0000000..9d9670e
--- /dev/null
+++ b/recipes-xenomai/libevl/files/debian/rules
@@ -0,0 +1,7 @@
+#!/usr/bin/make -f
+
+override_dh_fixperms:
+	dh_fixperms
+
+%:
+	dh $@ --buildsystem=meson
diff --git a/recipes-xenomai/libevl/libevl_master.bb b/recipes-xenomai/libevl/libevl_master.bb
new file mode 100644
index 0000000..d5ad572
--- /dev/null
+++ b/recipes-xenomai/libevl/libevl_master.bb
@@ -0,0 +1,47 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2018-2023
+#
+# Authors:
+#  Clara Kowalsky <clara.kowalsky@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+inherit dpkg
+
+CHANGELOG_V = "9999-${PV}"
+SRCREV = "${AUTOREV}"
+
+SRC_URI = " \
+        git://source.denx.de/Xenomai/xenomai4/libevl.git;protocol=https;branch=${PV} \
+        file://debian \
+        "
+
+DEPENDS="linux-xenomai-4"
+
+S = "${WORKDIR}/git"
+
+def get_commit(d):
+    try:
+        return bb.fetch2.get_srcrev(d).strip('AUTOINC+')
+    except bb.fetch2.FetchError:
+        return ""
+
+COMMIT="${@get_commit(d)}"
+
+DESCRIPTION ?= "install libevl libraries and tools"
+DEBIAN_BUILD_DEPENDS ?= "debhelper (>= 10), meson, linux-libc-dev"
+
+TEMPLATE_FILES = "debian/control.tmpl"
+TEMPLATE_VARS += "DEBIAN_BUILD_DEPENDS"
+
+do_prepare_build[cleandirs] += "${S}/debian"
+do_prepare_build() {
+    cp -r ${WORKDIR}/debian ${S}
+    deb_add_changelog
+
+    bbplain $(printf "libevl-%s: Building revision %.20s\n" \
+                    ${PV} ${COMMIT})
+}
diff --git a/recipes-xenomai/libevl/libevl_next.bb b/recipes-xenomai/libevl/libevl_next.bb
new file mode 120000
index 0000000..85ab518
--- /dev/null
+++ b/recipes-xenomai/libevl/libevl_next.bb
@@ -0,0 +1 @@
+libevl_master.bb
\ No newline at end of file
diff --git a/recipes-xenomai/libevl/libevl_r46.bb b/recipes-xenomai/libevl/libevl_r46.bb
new file mode 100644
index 0000000..a8bc597
--- /dev/null
+++ b/recipes-xenomai/libevl/libevl_r46.bb
@@ -0,0 +1,46 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2018-2023
+#
+# Authors:
+#  Clara Kowalsky <clara.kowalsky@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+inherit dpkg
+
+CHANGELOG_V = "9999-${PV}"
+
+SRC_URI = " \
+        git://source.denx.de/Xenomai/xenomai4/libevl.git;protocol=https;branch=master;tag=${PV} \
+        file://debian \
+        "
+
+DEPENDS="linux-xenomai-4"
+
+S = "${WORKDIR}/git"
+
+def get_commit(d):
+    try:
+        return bb.fetch2.get_srcrev(d).strip('AUTOINC+')
+    except bb.fetch2.FetchError:
+        return ""
+
+COMMIT="${@get_commit(d)}"
+
+DESCRIPTION ?= "install libevl libraries and tools"
+DEBIAN_BUILD_DEPENDS ?= "debhelper (>= 10), meson, linux-libc-dev"
+
+TEMPLATE_FILES = "debian/control.tmpl"
+TEMPLATE_VARS += "DEBIAN_BUILD_DEPENDS"
+
+do_prepare_build[cleandirs] += "${S}/debian"
+do_prepare_build() {
+    cp -r ${WORKDIR}/debian ${S}
+    deb_add_changelog
+
+    bbplain $(printf "libevl-%s: Building revision %.20s\n" \
+                    ${PV} ${COMMIT})
+}
diff --git a/recipes-xenomai/libevl/libevl_r47.bb b/recipes-xenomai/libevl/libevl_r47.bb
new file mode 120000
index 0000000..54ca27a
--- /dev/null
+++ b/recipes-xenomai/libevl/libevl_r47.bb
@@ -0,0 +1 @@
+libevl_r46.bb
\ No newline at end of file
-- 
2.39.2

