Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0596FD9
	for <xenomai@lists.linux.dev>; Wed, 10 Jan 2024 04:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="ZuRjKbJu"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20240110044603c397cc7cf496b27419
        for <xenomai@lists.linux.dev>;
        Wed, 10 Jan 2024 05:46:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=wRQQ7t8I8EmIPbK/k5sCnKm/jMRYDEiuCg2I0J75yAQ=;
 b=ZuRjKbJulI0yoim7S09cJCzNaHwUTyKM6s5aqMpFP7NE66LcUyyex3NPLAPU1GgHzBeNbk
 mtn1jGeUOSJuFM5PzpJTyV71/BwYQfd4TWYM1QzrT3m3UNb3ILlAR01HfagA8G0w9Sdx5fZu
 gDMmMiyJv2pw6qrRKEpdKTxl9jOiM=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH v3 03/10] Factor out print-revision class
Date: Wed, 10 Jan 2024 05:45:55 +0100
Message-Id: <2f7c8cf61b71aff10490b45c1c8c68c99bfe0fd0.1704861962.git.jan.kiszka@siemens.com>
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

This logic is already shared by kernel and xenomai recipes, more to
come.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 classes/print-revision.bbclass               | 23 ++++++++++++++++++++
 recipes-kernel/linux/linux-xenomai.inc       | 14 +-----------
 recipes-kernel/linux/linux-xenomai_latest.bb |  2 +-
 recipes-xenomai/xenomai/xenomai.inc          | 13 +----------
 4 files changed, 26 insertions(+), 26 deletions(-)
 create mode 100644 classes/print-revision.bbclass

diff --git a/classes/print-revision.bbclass b/classes/print-revision.bbclass
new file mode 100644
index 0000000..ca4aa7b
--- /dev/null
+++ b/classes/print-revision.bbclass
@@ -0,0 +1,23 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2018-2024
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+def get_commit(d):
+    try:
+        return bb.fetch2.get_srcrev(d).replace('AUTOINC+', '')
+    except bb.fetch2.FetchError:
+        return ""
+
+COMMIT="${@get_commit(d)}"
+
+dpkg_runbuild:prepend() {
+    bbplain $(printf "%s-%s: Building revision %.20s\n" \
+                     ${PN} ${PV} ${COMMIT})
+}
diff --git a/recipes-kernel/linux/linux-xenomai.inc b/recipes-kernel/linux/linux-xenomai.inc
index 4761d01..1d7d78a 100644
--- a/recipes-kernel/linux/linux-xenomai.inc
+++ b/recipes-kernel/linux/linux-xenomai.inc
@@ -10,6 +10,7 @@
 #
 
 require recipes-kernel/linux/linux-custom.inc
+inherit print-revision
 
 FILESPATH =. "${LAYERDIR_xenomai}/recipes-kernel/linux/files:"
 
@@ -28,19 +29,6 @@ KBUILD_DEPENDS += "xenomai-kernel-source:native"
 
 TEMPLATE_FILES += "rules.tmpl"
 
-def get_commit(d):
-    try:
-        return bb.fetch2.get_srcrev(d).replace('AUTOINC+', '')
-    except bb.fetch2.FetchError:
-        return ""
-
-LINUX_COMMIT ?= "${@get_commit(d)}"
-
-dpkg_runbuild:prepend() {
-    bbplain $(printf "linux-xenomai-%s: Building revision %.20s\n" \
-                     ${PV} ${LINUX_COMMIT})
-}
-
 do_prepare_debian_rules() {
     mv ${WORKDIR}/debian/rules ${WORKDIR}/debian/rules.isar
     mv ${WORKDIR}/rules ${WORKDIR}/debian/rules
diff --git a/recipes-kernel/linux/linux-xenomai_latest.bb b/recipes-kernel/linux/linux-xenomai_latest.bb
index c9b2513..d1b0226 100644
--- a/recipes-kernel/linux/linux-xenomai_latest.bb
+++ b/recipes-kernel/linux/linux-xenomai_latest.bb
@@ -12,7 +12,7 @@
 
 require recipes-kernel/linux/linux-xenomai.inc
 
-PV = "9999-g${LINUX_COMMIT}"
+PV = "9999-g${COMMIT}"
 
 def is_xeno_3_0(d):
     xeno_ver = d.getVar('PREFERRED_VERSION_xenomai') or ''
diff --git a/recipes-xenomai/xenomai/xenomai.inc b/recipes-xenomai/xenomai/xenomai.inc
index 26ee654..95b2875 100644
--- a/recipes-xenomai/xenomai/xenomai.inc
+++ b/recipes-xenomai/xenomai/xenomai.inc
@@ -10,6 +10,7 @@
 #
 
 inherit dpkg
+inherit print-revision
 
 PROVIDES += "xenomai-kernel-source"
 PROVIDES += "xenomai-runtime"
@@ -22,15 +23,6 @@ PROVIDES += "libxenomai1-dbgsym"
 
 PACKAGE_ARCH:compat-arch = "${COMPAT_DISTRO_ARCH}"
 
-# use bitbake get_srcrev to get the current commit id
-def get_commit(d):
-    try:
-        return bb.fetch2.get_srcrev(d).replace('AUTOINC+', '')
-    except bb.fetch2.FetchError:
-        return ""
-
-COMMIT="${@get_commit(d)}"
-
 do_prepare_build() {
     # Xenomai currently does not maintain its changelog, plus we want the
     # actual package version in there.
@@ -39,7 +31,4 @@ do_prepare_build() {
     # Remove upstream's "3.0 (native)" declaration so that we can define the
     # package version more freely.
     rm -f ${S}/debian/source/format
-
-    bbplain $(printf "xenomai-%s: Building revision %.20s\n" \
-                     ${PV} ${COMMIT})
 }
-- 
2.35.3

