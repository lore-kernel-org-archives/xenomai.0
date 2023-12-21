Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F93A58209
	for <xenomai@lists.linux.dev>; Thu, 21 Dec 2023 16:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="WFp68ggN"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2023122116382058b352e7edc9bd67e9
        for <xenomai@lists.linux.dev>;
        Thu, 21 Dec 2023 17:38:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=IHs0qLx6x7gHHn6nV0Rp6Ayp0Q/CuNiTx7LUDsOgHOU=;
 b=WFp68ggNjy6xkFmmcs89Yg/ApqmDooUDm2+G6ycfdauYUC487l1kTsBEzKLbff7H4y3xd9
 4QDpcUfFycl1FNoSJr/jL2sWcLnqznlHbRjB47n1oJAJlHQ2w7XNTcTLCj9S79lPnauSmQPc
 SB2DoImdX3vFCeazfr7lwXrRWrQ9M=;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev,
	rpm@xenomai.org
Cc: jan.kiszka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [xenomai-images][PATCH v2 1/7] linux-xenomai: Rename linux-xenomai to linux-xenomai-3
Date: Thu, 21 Dec 2023 17:37:37 +0100
Message-Id: <20231221163743.2923801-2-clara.kowalsky@siemens.com>
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

In preparation for the integration of EVL, files are renamed. Shared
parts for xenomai-3 and EVL are placed into linux-xenomai.inc.

Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
---
 conf/distro/include/xenomai-version.inc       |  2 +-
 opt-linux-4.19.yml                            |  2 +-
 opt-linux-4.4.yml                             |  2 +-
 opt-linux-5.10.yml                            |  2 +-
 opt-linux-5.15.yml                            |  2 +-
 opt-linux-5.4.yml                             |  2 +-
 opt-linux-6.1.yml                             |  2 +-
 opt-linux-latest-4.19.yml                     |  2 +-
 opt-linux-latest-4.4.yml                      |  2 +-
 opt-linux-latest-5.10.yml                     |  2 +-
 opt-linux-latest-5.15.yml                     |  2 +-
 opt-linux-latest-5.4.yml                      |  2 +-
 opt-linux-latest-6.1.yml                      |  2 +-
 opt-linux-latest.yml                          |  2 +-
 ...etail.inc => linux-xenomai-3-dovetail.inc} |  2 +-
 recipes-kernel/linux/linux-xenomai-3.inc      | 33 +++++++++++++++++++
 ...enomai_4.19.bb => linux-xenomai-3_4.19.bb} |  2 +-
 ...-xenomai_4.4.bb => linux-xenomai-3_4.4.bb} |  2 +-
 ...enomai_5.10.bb => linux-xenomai-3_5.10.bb} |  2 +-
 ...enomai_5.15.bb => linux-xenomai-3_5.15.bb} |  2 +-
 ...-xenomai_5.4.bb => linux-xenomai-3_5.4.bb} |  2 +-
 ...-xenomai_6.1.bb => linux-xenomai-3_6.1.bb} |  2 +-
 ...ai_latest.bb => linux-xenomai-3_latest.bb} |  2 +-
 recipes-kernel/linux/linux-xenomai.inc        | 19 -----------
 24 files changed, 55 insertions(+), 41 deletions(-)
 rename recipes-kernel/linux/{linux-xenomai-dovetail.inc => linux-xenomai-3-dovetail.inc} (86%)
 create mode 100644 recipes-kernel/linux/linux-xenomai-3.inc
 rename recipes-kernel/linux/{linux-xenomai_4.19.bb => linux-xenomai-3_4.19.bb} (93%)
 rename recipes-kernel/linux/{linux-xenomai_4.4.bb => linux-xenomai-3_4.4.bb} (92%)
 rename recipes-kernel/linux/{linux-xenomai_5.10.bb => linux-xenomai-3_5.10.bb} (76%)
 rename recipes-kernel/linux/{linux-xenomai_5.15.bb => linux-xenomai-3_5.15.bb} (76%)
 rename recipes-kernel/linux/{linux-xenomai_5.4.bb => linux-xenomai-3_5.4.bb} (92%)
 rename recipes-kernel/linux/{linux-xenomai_6.1.bb => linux-xenomai-3_6.1.bb} (76%)
 rename recipes-kernel/linux/{linux-xenomai_latest.bb => linux-xenomai-3_latest.bb} (98%)

diff --git a/conf/distro/include/xenomai-version.inc b/conf/distro/include/xenomai-version.inc
index a8d40ed..7ca8201 100644
--- a/conf/distro/include/xenomai-version.inc
+++ b/conf/distro/include/xenomai-version.inc
@@ -22,7 +22,7 @@ XENOMAI_3_2_KERNEL_VERSION = "5.10%"
 
 # If PREFERRED_VERSION_xenomai contains any item from XENOMAI_3_0_VERSION_LIST use
 # XENOMAI_3_0_KERNEL_VERSION. Same for the other XENOMAI_*_VERSION_LIST.
-PREFERRED_VERSION_linux-xenomai ?= \
+PREFERRED_VERSION_linux-xenomai-3 ?= \
     "${@bb.utils.contains_any('PREFERRED_VERSION_xenomai', \
         '${XENOMAI_3_0_VERSION_LIST}', '${XENOMAI_3_0_KERNEL_VERSION}', \
         bb.utils.contains_any('PREFERRED_VERSION_xenomai', \
diff --git a/opt-linux-4.19.yml b/opt-linux-4.19.yml
index d5fa5ef..93e09c3 100644
--- a/opt-linux-4.19.yml
+++ b/opt-linux-4.19.yml
@@ -14,4 +14,4 @@ header:
 
 local_conf_header:
   linux-xenomai-version: |
-    PREFERRED_VERSION_linux-xenomai = "4.19%"
+    PREFERRED_VERSION_linux-xenomai-3 = "4.19%"
diff --git a/opt-linux-4.4.yml b/opt-linux-4.4.yml
index 2b9dd14..12e8822 100644
--- a/opt-linux-4.4.yml
+++ b/opt-linux-4.4.yml
@@ -14,4 +14,4 @@ header:
 
 local_conf_header:
   linux-xenomai-version: |
-    PREFERRED_VERSION_linux-xenomai = "4.4%"
+    PREFERRED_VERSION_linux-xenomai-3 = "4.4%"
diff --git a/opt-linux-5.10.yml b/opt-linux-5.10.yml
index ae3b30d..b401b94 100644
--- a/opt-linux-5.10.yml
+++ b/opt-linux-5.10.yml
@@ -14,4 +14,4 @@ header:
 
 local_conf_header:
   linux-xenomai-version: |
-    PREFERRED_VERSION_linux-xenomai = "5.10%"
+    PREFERRED_VERSION_linux-xenomai-3 = "5.10%"
diff --git a/opt-linux-5.15.yml b/opt-linux-5.15.yml
index c7447e9..4977d19 100644
--- a/opt-linux-5.15.yml
+++ b/opt-linux-5.15.yml
@@ -14,4 +14,4 @@ header:
 
 local_conf_header:
   linux-xenomai-version: |
-    PREFERRED_VERSION_linux-xenomai = "5.15%"
+    PREFERRED_VERSION_linux-xenomai-3 = "5.15%"
diff --git a/opt-linux-5.4.yml b/opt-linux-5.4.yml
index 2fb586e..46f25a5 100644
--- a/opt-linux-5.4.yml
+++ b/opt-linux-5.4.yml
@@ -14,4 +14,4 @@ header:
 
 local_conf_header:
   linux-xenomai-version: |
-    PREFERRED_VERSION_linux-xenomai = "5.4%"
+    PREFERRED_VERSION_linux-xenomai-3 = "5.4%"
diff --git a/opt-linux-6.1.yml b/opt-linux-6.1.yml
index fb0df24..00e5f0f 100644
--- a/opt-linux-6.1.yml
+++ b/opt-linux-6.1.yml
@@ -14,4 +14,4 @@ header:
 
 local_conf_header:
   linux-xenomai-version: |
-    PREFERRED_VERSION_linux-xenomai = "6.1%"
+    PREFERRED_VERSION_linux-xenomai-3 = "6.1%"
diff --git a/opt-linux-latest-4.19.yml b/opt-linux-latest-4.19.yml
index 78f4a43..717cebe 100644
--- a/opt-linux-latest-4.19.yml
+++ b/opt-linux-latest-4.19.yml
@@ -14,5 +14,5 @@ header:
 
 local_conf_header:
   linux-xenomai-latest: |
-    PREFERRED_VERSION_linux-xenomai = "9999-%"
+    PREFERRED_VERSION_linux-xenomai-3 = "9999-%"
     LATEST_GIT_BRANCH = "4.19"
diff --git a/opt-linux-latest-4.4.yml b/opt-linux-latest-4.4.yml
index 113ba76..8476d5d 100644
--- a/opt-linux-latest-4.4.yml
+++ b/opt-linux-latest-4.4.yml
@@ -14,5 +14,5 @@ header:
 
 local_conf_header:
   linux-xenomai-latest: |
-    PREFERRED_VERSION_linux-xenomai = "9999-%"
+    PREFERRED_VERSION_linux-xenomai-3 = "9999-%"
     LATEST_GIT_BRANCH = "4.4"
diff --git a/opt-linux-latest-5.10.yml b/opt-linux-latest-5.10.yml
index a6bb221..ebb8003 100644
--- a/opt-linux-latest-5.10.yml
+++ b/opt-linux-latest-5.10.yml
@@ -14,5 +14,5 @@ header:
 
 local_conf_header:
   linux-xenomai-version: |
-    PREFERRED_VERSION_linux-xenomai = "9999-%"
+    PREFERRED_VERSION_linux-xenomai-3 = "9999-%"
     LATEST_GIT_BRANCH = "5.10"
diff --git a/opt-linux-latest-5.15.yml b/opt-linux-latest-5.15.yml
index 02e1a61..ab7d7fc 100644
--- a/opt-linux-latest-5.15.yml
+++ b/opt-linux-latest-5.15.yml
@@ -14,5 +14,5 @@ header:
 
 local_conf_header:
   linux-xenomai-version: |
-    PREFERRED_VERSION_linux-xenomai = "9999-%"
+    PREFERRED_VERSION_linux-xenomai-3 = "9999-%"
     LATEST_GIT_BRANCH = "5.15"
diff --git a/opt-linux-latest-5.4.yml b/opt-linux-latest-5.4.yml
index d3164e3..cdd91fe 100644
--- a/opt-linux-latest-5.4.yml
+++ b/opt-linux-latest-5.4.yml
@@ -14,5 +14,5 @@ header:
 
 local_conf_header:
   linux-xenomai-version: |
-    PREFERRED_VERSION_linux-xenomai = "9999-%"
+    PREFERRED_VERSION_linux-xenomai-3 = "9999-%"
     LATEST_GIT_BRANCH = "5.4"
diff --git a/opt-linux-latest-6.1.yml b/opt-linux-latest-6.1.yml
index c5eecd8..2298727 100644
--- a/opt-linux-latest-6.1.yml
+++ b/opt-linux-latest-6.1.yml
@@ -14,5 +14,5 @@ header:
 
 local_conf_header:
   linux-xenomai-version: |
-    PREFERRED_VERSION_linux-xenomai = "9999-%"
+    PREFERRED_VERSION_linux-xenomai-3 = "9999-%"
     LATEST_GIT_BRANCH = "6.1"
diff --git a/opt-linux-latest.yml b/opt-linux-latest.yml
index 4f4dd3b..0ba2808 100644
--- a/opt-linux-latest.yml
+++ b/opt-linux-latest.yml
@@ -14,5 +14,5 @@ header:
 
 local_conf_header:
   linux-xenomai-version: |
-    PREFERRED_VERSION_linux-xenomai = "9999-%"
+    PREFERRED_VERSION_linux-xenomai-3 = "9999-%"
     LATEST_GIT_BRANCH = "latest"
diff --git a/recipes-kernel/linux/linux-xenomai-dovetail.inc b/recipes-kernel/linux/linux-xenomai-3-dovetail.inc
similarity index 86%
rename from recipes-kernel/linux/linux-xenomai-dovetail.inc
rename to recipes-kernel/linux/linux-xenomai-3-dovetail.inc
index 05d775e..a8612ba 100644
--- a/recipes-kernel/linux/linux-xenomai-dovetail.inc
+++ b/recipes-kernel/linux/linux-xenomai-3-dovetail.inc
@@ -9,7 +9,7 @@
 # SPDX-License-Identifier: MIT
 #
 
-require recipes-kernel/linux/linux-xenomai.inc
+require recipes-kernel/linux/linux-xenomai-3.inc
 
 SRC_URI += "git://source.denx.de/xenomai/linux-dovetail.git;protocol=https;nobranch=1"
 
diff --git a/recipes-kernel/linux/linux-xenomai-3.inc b/recipes-kernel/linux/linux-xenomai-3.inc
new file mode 100644
index 0000000..01923aa
--- /dev/null
+++ b/recipes-kernel/linux/linux-xenomai-3.inc
@@ -0,0 +1,33 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2018-2023
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+require recipes-kernel/linux/linux-xenomai.inc
+
+XENOMAI_DEBUG ?= "0"
+
+SRC_URI += "${@'file://common_nodbg.cfg' if d.getVar('XENOMAI_DEBUG') == '0' else ''}"
+SRC_URI += "file://rules.tmpl"
+
+DEPENDS += "xenomai-kernel-source"
+KBUILD_DEPENDS += "xenomai-kernel-source:native"
+
+TEMPLATE_FILES += "rules.tmpl"
+
+dpkg_runbuild:prepend() {
+    bbplain $(printf "linux-xenomai-3-%s: Building revision %.20s\n" \
+                     ${PV} ${LINUX_COMMIT})
+}
+
+do_prepare_debian_rules() {
+    mv ${WORKDIR}/debian/rules ${WORKDIR}/debian/rules.isar
+    mv ${WORKDIR}/rules ${WORKDIR}/debian/rules
+}
+addtask prepare_debian_rules after do_transform_template before do_dpkg_build
diff --git a/recipes-kernel/linux/linux-xenomai_4.19.bb b/recipes-kernel/linux/linux-xenomai-3_4.19.bb
similarity index 93%
rename from recipes-kernel/linux/linux-xenomai_4.19.bb
rename to recipes-kernel/linux/linux-xenomai-3_4.19.bb
index 249ffb4..e6c56ca 100644
--- a/recipes-kernel/linux/linux-xenomai_4.19.bb
+++ b/recipes-kernel/linux/linux-xenomai-3_4.19.bb
@@ -9,7 +9,7 @@
 # SPDX-License-Identifier: MIT
 #
 
-require recipes-kernel/linux/linux-xenomai.inc
+require recipes-kernel/linux/linux-xenomai-3.inc
 
 SRC_URI:append:amd64 = " git://github.com/xenomai-ci/ipipe-x86.git;protocol=https;nobranch=1"
 SRCREV:amd64 ?= "ipipe-core-4.19.266-cip86-x86-25"
diff --git a/recipes-kernel/linux/linux-xenomai_4.4.bb b/recipes-kernel/linux/linux-xenomai-3_4.4.bb
similarity index 92%
rename from recipes-kernel/linux/linux-xenomai_4.4.bb
rename to recipes-kernel/linux/linux-xenomai-3_4.4.bb
index 2b32ae3..09ba2a7 100644
--- a/recipes-kernel/linux/linux-xenomai_4.4.bb
+++ b/recipes-kernel/linux/linux-xenomai-3_4.4.bb
@@ -9,7 +9,7 @@
 # SPDX-License-Identifier: MIT
 #
 
-require recipes-kernel/linux/linux-xenomai.inc
+require recipes-kernel/linux/linux-xenomai-3.inc
 
 SRC_URI:append:amd64 = " git://github.com/xenomai-ci/ipipe.git;protocol=https;nobranch=1"
 SRCREV:amd64 ?= "ipipe-core-4.4.302-cip71-x86-35"
diff --git a/recipes-kernel/linux/linux-xenomai_5.10.bb b/recipes-kernel/linux/linux-xenomai-3_5.10.bb
similarity index 76%
rename from recipes-kernel/linux/linux-xenomai_5.10.bb
rename to recipes-kernel/linux/linux-xenomai-3_5.10.bb
index 986060d..9b01708 100644
--- a/recipes-kernel/linux/linux-xenomai_5.10.bb
+++ b/recipes-kernel/linux/linux-xenomai-3_5.10.bb
@@ -9,6 +9,6 @@
 # SPDX-License-Identifier: MIT
 #
 
-require recipes-kernel/linux/linux-xenomai-dovetail.inc
+require recipes-kernel/linux/linux-xenomai-3-dovetail.inc
 
 SRCREV ?= "v5.10.161-dovetail1"
diff --git a/recipes-kernel/linux/linux-xenomai_5.15.bb b/recipes-kernel/linux/linux-xenomai-3_5.15.bb
similarity index 76%
rename from recipes-kernel/linux/linux-xenomai_5.15.bb
rename to recipes-kernel/linux/linux-xenomai-3_5.15.bb
index 63865eb..9c5ba27 100644
--- a/recipes-kernel/linux/linux-xenomai_5.15.bb
+++ b/recipes-kernel/linux/linux-xenomai-3_5.15.bb
@@ -9,6 +9,6 @@
 # SPDX-License-Identifier: MIT
 #
 
-require recipes-kernel/linux/linux-xenomai-dovetail.inc
+require recipes-kernel/linux/linux-xenomai-3-dovetail.inc
 
 SRCREV ?= "v5.15.85-dovetail1"
diff --git a/recipes-kernel/linux/linux-xenomai_5.4.bb b/recipes-kernel/linux/linux-xenomai-3_5.4.bb
similarity index 92%
rename from recipes-kernel/linux/linux-xenomai_5.4.bb
rename to recipes-kernel/linux/linux-xenomai-3_5.4.bb
index 7796cd3..827cba5 100644
--- a/recipes-kernel/linux/linux-xenomai_5.4.bb
+++ b/recipes-kernel/linux/linux-xenomai-3_5.4.bb
@@ -9,7 +9,7 @@
 # SPDX-License-Identifier: MIT
 #
 
-require recipes-kernel/linux/linux-xenomai.inc
+require recipes-kernel/linux/linux-xenomai-3.inc
 
 SRC_URI:append:amd64 = " git://github.com/xenomai-ci/ipipe-x86.git;protocol=https;nobranch=1"
 SRCREV:amd64 ?= "ipipe-core-5.4.228-x86-12"
diff --git a/recipes-kernel/linux/linux-xenomai_6.1.bb b/recipes-kernel/linux/linux-xenomai-3_6.1.bb
similarity index 76%
rename from recipes-kernel/linux/linux-xenomai_6.1.bb
rename to recipes-kernel/linux/linux-xenomai-3_6.1.bb
index d9655e0..1b41692 100644
--- a/recipes-kernel/linux/linux-xenomai_6.1.bb
+++ b/recipes-kernel/linux/linux-xenomai-3_6.1.bb
@@ -9,6 +9,6 @@
 # SPDX-License-Identifier: MIT
 #
 
-require recipes-kernel/linux/linux-xenomai-dovetail.inc
+require recipes-kernel/linux/linux-xenomai-3-dovetail.inc
 
 SRCREV ?= "v6.1.11-dovetail1"
diff --git a/recipes-kernel/linux/linux-xenomai_latest.bb b/recipes-kernel/linux/linux-xenomai-3_latest.bb
similarity index 98%
rename from recipes-kernel/linux/linux-xenomai_latest.bb
rename to recipes-kernel/linux/linux-xenomai-3_latest.bb
index e5348c6..adda9b5 100644
--- a/recipes-kernel/linux/linux-xenomai_latest.bb
+++ b/recipes-kernel/linux/linux-xenomai-3_latest.bb
@@ -10,7 +10,7 @@
 # SPDX-License-Identifier: MIT
 #
 
-require recipes-kernel/linux/linux-xenomai.inc
+require recipes-kernel/linux/linux-xenomai-3.inc
 
 PV = "9999-g${LINUX_COMMIT}"
 
diff --git a/recipes-kernel/linux/linux-xenomai.inc b/recipes-kernel/linux/linux-xenomai.inc
index ca63fea..03ec04f 100644
--- a/recipes-kernel/linux/linux-xenomai.inc
+++ b/recipes-kernel/linux/linux-xenomai.inc
@@ -15,19 +15,11 @@ FILESPATH =. "${LAYERDIR_xenomai}/recipes-kernel/linux/files:"
 
 XENOMAI_DEFCONFIG = "${DISTRO_ARCH}_defconfig"
 KERNEL_DEFCONFIG ?= "${XENOMAI_DEFCONFIG}"
-XENOMAI_DEBUG ?= "0"
 
 SRC_URI += "${@'file://${KERNEL_DEFCONFIG}' if d.getVar('KERNEL_DEFCONFIG') == d.getVar('XENOMAI_DEFCONFIG') else ''}"
-SRC_URI += "${@'file://common_nodbg.cfg' if d.getVar('XENOMAI_DEBUG') == '0' else ''}"
-SRC_URI += "file://rules.tmpl"
 
 S = "${WORKDIR}/git"
 
-DEPENDS += "xenomai-kernel-source"
-KBUILD_DEPENDS += "xenomai-kernel-source:native"
-
-TEMPLATE_FILES += "rules.tmpl"
-
 def get_commit(d):
     try:
         return bb.fetch2.get_srcrev(d).strip('AUTOINC+')
@@ -35,14 +27,3 @@ def get_commit(d):
         return ""
 
 LINUX_COMMIT ?= "${@get_commit(d)}"
-
-dpkg_runbuild:prepend() {
-    bbplain $(printf "linux-xenomai-%s: Building revision %.20s\n" \
-                     ${PV} ${LINUX_COMMIT})
-}
-
-do_prepare_debian_rules() {
-    mv ${WORKDIR}/debian/rules ${WORKDIR}/debian/rules.isar
-    mv ${WORKDIR}/rules ${WORKDIR}/debian/rules
-}
-addtask prepare_debian_rules after do_transform_template before do_dpkg_build
-- 
2.39.2

