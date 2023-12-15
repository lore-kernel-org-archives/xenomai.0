Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5272D79D
	for <xenomai@lists.linux.dev>; Fri, 15 Dec 2023 11:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="MpYDx+Jo"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20231215114452fe78a39b85fa5a36e0
        for <xenomai@lists.linux.dev>;
        Fri, 15 Dec 2023 12:44:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Ddryy4AF1YLSVeeOyZpvAqDu8ggHCGR8HqtE2NEyW8s=;
 b=MpYDx+JoSZEMfZZETRNtdKXebio8xST4uxIaOzrVQIezJmH8qG+wZ6AlCDcYWe5tD7Z2wT
 xCTJJCQPaMQmTcppBGqTQ7GjUxKENJFgmt2My7LWP3VoSDnNGXkXnMdth462MkCM3y+p8mQ1
 ahfk8OsjI/XE4DM4dJTBU40M3dPgQ=;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev,
	rpm@xenomai.org
Cc: jan.kiszka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [xenomai-images][PATCH v1 1/5] linux-xenomai: Factor out base.inc
Date: Fri, 15 Dec 2023 12:43:45 +0100
Message-Id: <20231215114349.2913803-2-clara.kowalsky@siemens.com>
In-Reply-To: <20231215114349.2913803-1-clara.kowalsky@siemens.com>
References: <20231215114349.2913803-1-clara.kowalsky@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1047747:519-21489:flowmailer

In preparation for the integration of EVL, common lines are placed in a
separate file.

Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
---
 recipes-core/images/base.inc           | 20 ++++++++++++++++++
 recipes-core/images/demo-image.bb      | 10 ++-------
 recipes-kernel/linux/base.inc          | 28 ++++++++++++++++++++++++++
 recipes-kernel/linux/linux-xenomai.inc | 16 +--------------
 4 files changed, 51 insertions(+), 23 deletions(-)
 create mode 100644 recipes-core/images/base.inc
 create mode 100644 recipes-kernel/linux/base.inc

diff --git a/recipes-core/images/base.inc b/recipes-core/images/base.inc
new file mode 100644
index 0000000..13bab7b
--- /dev/null
+++ b/recipes-core/images/base.inc
@@ -0,0 +1,20 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2018
+#
+# Authors:
+#  Clara Kowalsky <clara.kowalsky@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+ISAR_RELEASE_CMD = "git -C ${LAYERDIR_xenomai} describe --tags --dirty --always --match 'v[0-9].[0-9]*'"
+
+IMAGE_PREINSTALL += " \
+    bash-completion less vim nano man \
+    ifupdown isc-dhcp-client net-tools iputils-ping ssh \
+    iw wireless-tools wpasupplicant dbus \
+    lsb-release"
+
+IMAGE_INSTALL += "customizations sshd-regen-keys expand-on-first-boot"
diff --git a/recipes-core/images/demo-image.bb b/recipes-core/images/demo-image.bb
index 540583b..4344122 100644
--- a/recipes-core/images/demo-image.bb
+++ b/recipes-core/images/demo-image.bb
@@ -11,7 +11,8 @@
 
 inherit image
 
-ISAR_RELEASE_CMD = "git -C ${LAYERDIR_xenomai} describe --tags --dirty --always --match 'v[0-9].[0-9]*'"
+require base.inc
+
 DESCRIPTION = "Xenomai demo and test image"
 
 # The Xenomai testsuite was part of the xenomai-runtime package until 3.2.x.
@@ -35,13 +36,6 @@ def get_testsuite_package_names(d):
 # arch missmatch for compat builds on newer releases.
 IMAGE_PREINSTALL += "${@ 'gdb' if not has_testsuite_package(d) else '' }"
 
-IMAGE_PREINSTALL += " \
-    bash-completion less vim nano man \
-    ifupdown isc-dhcp-client net-tools iputils-ping ssh \
-    iw wireless-tools wpasupplicant dbus \
-    lsb-release"
-
 IMAGE_INSTALL += "xenomai-runtime xenomai-runtime-dbgsym"
 IMAGE_INSTALL += "${@get_testsuite_package_names(d)}"
 IMAGE_INSTALL += "libxenomai1-dbgsym"
-IMAGE_INSTALL += "customizations sshd-regen-keys expand-on-first-boot"
diff --git a/recipes-kernel/linux/base.inc b/recipes-kernel/linux/base.inc
new file mode 100644
index 0000000..c6aad9c
--- /dev/null
+++ b/recipes-kernel/linux/base.inc
@@ -0,0 +1,28 @@
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
+require recipes-kernel/linux/linux-custom.inc
+
+FILESPATH =. "${LAYERDIR_xenomai}/recipes-kernel/linux/files:"
+
+KERNEL_DEFCONFIG ?= "${XENOMAI_DEFCONFIG}"
+
+SRC_URI += "${@'file://${KERNEL_DEFCONFIG}' if d.getVar('KERNEL_DEFCONFIG') == d.getVar('XENOMAI_DEFCONFIG') else ''}"
+
+S = "${WORKDIR}/git"
+
+def get_commit(d):
+    try:
+        return bb.fetch2.get_srcrev(d).strip('AUTOINC+')
+    except bb.fetch2.FetchError:
+        return ""
+
+LINUX_COMMIT ?= "${@get_commit(d)}"
diff --git a/recipes-kernel/linux/linux-xenomai.inc b/recipes-kernel/linux/linux-xenomai.inc
index ca63fea..df24c49 100644
--- a/recipes-kernel/linux/linux-xenomai.inc
+++ b/recipes-kernel/linux/linux-xenomai.inc
@@ -9,33 +9,19 @@
 # SPDX-License-Identifier: MIT
 #
 
-require recipes-kernel/linux/linux-custom.inc
-
-FILESPATH =. "${LAYERDIR_xenomai}/recipes-kernel/linux/files:"
+require recipes-kernel/linux/base.inc
 
 XENOMAI_DEFCONFIG = "${DISTRO_ARCH}_defconfig"
-KERNEL_DEFCONFIG ?= "${XENOMAI_DEFCONFIG}"
 XENOMAI_DEBUG ?= "0"
 
-SRC_URI += "${@'file://${KERNEL_DEFCONFIG}' if d.getVar('KERNEL_DEFCONFIG') == d.getVar('XENOMAI_DEFCONFIG') else ''}"
 SRC_URI += "${@'file://common_nodbg.cfg' if d.getVar('XENOMAI_DEBUG') == '0' else ''}"
 SRC_URI += "file://rules.tmpl"
 
-S = "${WORKDIR}/git"
-
 DEPENDS += "xenomai-kernel-source"
 KBUILD_DEPENDS += "xenomai-kernel-source:native"
 
 TEMPLATE_FILES += "rules.tmpl"
 
-def get_commit(d):
-    try:
-        return bb.fetch2.get_srcrev(d).strip('AUTOINC+')
-    except bb.fetch2.FetchError:
-        return ""
-
-LINUX_COMMIT ?= "${@get_commit(d)}"
-
 dpkg_runbuild:prepend() {
     bbplain $(printf "linux-xenomai-%s: Building revision %.20s\n" \
                      ${PV} ${LINUX_COMMIT})
-- 
2.39.2

