Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0A28BF7
	for <xenomai@lists.linux.dev>; Wed, 10 Jan 2024 04:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="E0+A/qIV"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202401100446031fc1dbda985d90b514
        for <xenomai@lists.linux.dev>;
        Wed, 10 Jan 2024 05:46:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=IQvUjuHwRTC0/RqIqb1yqtrLtwID8CMMLT+iJ6T3pic=;
 b=E0+A/qIVlwFmoW8nA0SCYcbQqSxUwq73ZxNnbpk2ZZmebbkUjQ8m+7vCV9w3rISNLEd/HG
 ylX0amVv4LA1tZ0F58BwprF6uojheUOZBgWBWRmKvuMqYI377zLzoMTIYOhnxLAV1c9LWd15
 reMYlJiRE30Csc7uwingJZ1UNsl0g=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH v3 04/10] linux-xenomai: Rename linux-xenomai to linux-xenomai-3
Date: Wed, 10 Jan 2024 05:45:56 +0100
Message-Id: <08e8454f1922316686fe60b366cca43af07250f2.1704861962.git.jan.kiszka@siemens.com>
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

In preparation for the integration of EVL, files are renamed. Shared
parts for xenomai-3 and EVL are placed into linux-xenomai.inc.

Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
[Jan: fix build, account for new 6.6 kernel, keep more bits in xenomai-linux.inc]
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 conf/distro/include/xenomai-version.inc             |  2 +-
 conf/distro/xenomai-demo.conf                       |  4 +++-
 opt-linux-4.19.yml                                  |  2 +-
 opt-linux-4.4.yml                                   |  2 +-
 opt-linux-5.10.yml                                  |  2 +-
 opt-linux-5.15.yml                                  |  2 +-
 opt-linux-5.4.yml                                   |  2 +-
 opt-linux-6.1.yml                                   |  2 +-
 opt-linux-6.6.yml                                   |  2 +-
 opt-linux-latest-4.19.yml                           |  2 +-
 opt-linux-latest-4.4.yml                            |  2 +-
 opt-linux-latest-5.10.yml                           |  2 +-
 opt-linux-latest-5.15.yml                           |  2 +-
 opt-linux-latest-5.4.yml                            |  2 +-
 opt-linux-latest-6.1.yml                            |  2 +-
 opt-linux-latest-6.6.yml                            |  2 +-
 opt-linux-latest.yml                                |  2 +-
 ...ai-dovetail.inc => linux-xenomai-3-dovetail.inc} |  2 +-
 .../{linux-xenomai.inc => linux-xenomai-3.inc}      | 13 +------------
 ...inux-xenomai_4.19.bb => linux-xenomai-3_4.19.bb} |  2 +-
 ...{linux-xenomai_4.4.bb => linux-xenomai-3_4.4.bb} |  2 +-
 ...inux-xenomai_5.10.bb => linux-xenomai-3_5.10.bb} |  2 +-
 ...inux-xenomai_5.15.bb => linux-xenomai-3_5.15.bb} |  2 +-
 ...{linux-xenomai_5.4.bb => linux-xenomai-3_5.4.bb} |  2 +-
 ...{linux-xenomai_6.1.bb => linux-xenomai-3_6.1.bb} |  2 +-
 ...{linux-xenomai_6.6.bb => linux-xenomai-3_6.6.bb} |  2 +-
 ...-xenomai_latest.bb => linux-xenomai-3_latest.bb} |  2 +-
 recipes-kernel/linux/linux-xenomai.inc              | 12 ------------
 28 files changed, 29 insertions(+), 50 deletions(-)
 rename recipes-kernel/linux/{linux-xenomai-dovetail.inc => linux-xenomai-3-dovetail.inc} (86%)
 copy recipes-kernel/linux/{linux-xenomai.inc => linux-xenomai-3.inc} (52%)
 rename recipes-kernel/linux/{linux-xenomai_4.19.bb => linux-xenomai-3_4.19.bb} (93%)
 rename recipes-kernel/linux/{linux-xenomai_4.4.bb => linux-xenomai-3_4.4.bb} (92%)
 rename recipes-kernel/linux/{linux-xenomai_5.10.bb => linux-xenomai-3_5.10.bb} (76%)
 rename recipes-kernel/linux/{linux-xenomai_5.15.bb => linux-xenomai-3_5.15.bb} (76%)
 rename recipes-kernel/linux/{linux-xenomai_5.4.bb => linux-xenomai-3_5.4.bb} (92%)
 rename recipes-kernel/linux/{linux-xenomai_6.1.bb => linux-xenomai-3_6.1.bb} (76%)
 rename recipes-kernel/linux/{linux-xenomai_6.6.bb => linux-xenomai-3_6.6.bb} (75%)
 rename recipes-kernel/linux/{linux-xenomai_latest.bb => linux-xenomai-3_latest.bb} (98%)

diff --git a/conf/distro/include/xenomai-version.inc b/conf/distro/include/xenomai-version.inc
index 754a738..bed78e8 100644
--- a/conf/distro/include/xenomai-version.inc
+++ b/conf/distro/include/xenomai-version.inc
@@ -22,7 +22,7 @@ XENOMAI_3_2_KERNEL_VERSION = "6.1%"
 
 # If PREFERRED_VERSION_xenomai contains any item from XENOMAI_3_0_VERSION_LIST use
 # XENOMAI_3_0_KERNEL_VERSION. Same for the other XENOMAI_*_VERSION_LIST.
-PREFERRED_VERSION_linux-xenomai ?= \
+PREFERRED_VERSION_linux-xenomai-3 ?= \
     "${@bb.utils.contains_any('PREFERRED_VERSION_xenomai', \
         '${XENOMAI_3_0_VERSION_LIST}', '${XENOMAI_3_0_KERNEL_VERSION}', \
         bb.utils.contains_any('PREFERRED_VERSION_xenomai', \
diff --git a/conf/distro/xenomai-demo.conf b/conf/distro/xenomai-demo.conf
index c99669d..7b2b0a4 100644
--- a/conf/distro/xenomai-demo.conf
+++ b/conf/distro/xenomai-demo.conf
@@ -11,12 +11,14 @@
 
 require conf/distro/debian-bookworm.conf
 
+XENOMAI_MAJOR_VERSION ?= "3"
+
 PREFERRED_VERSION_xenomai ?= "3.2%"
 include conf/distro/include/xenomai-version.inc
 
 HOST_DISTRO ?= "debian-bookworm"
 
-KERNEL_NAME = "xenomai"
+KERNEL_NAME = "xenomai-${XENOMAI_MAJOR_VERSION}"
 
 WKS_FILE = "${MACHINE}.wks"
 
diff --git a/opt-linux-4.19.yml b/opt-linux-4.19.yml
index 960292d..760cfce 100644
--- a/opt-linux-4.19.yml
+++ b/opt-linux-4.19.yml
@@ -14,4 +14,4 @@ header:
 
 local_conf_header:
   linux-xenomai-version: |
-    PREFERRED_VERSION_linux-xenomai = "4.19%"
+    PREFERRED_VERSION_linux-xenomai-3 = "4.19%"
diff --git a/opt-linux-4.4.yml b/opt-linux-4.4.yml
index e455a38..b026c70 100644
--- a/opt-linux-4.4.yml
+++ b/opt-linux-4.4.yml
@@ -14,4 +14,4 @@ header:
 
 local_conf_header:
   linux-xenomai-version: |
-    PREFERRED_VERSION_linux-xenomai = "4.4%"
+    PREFERRED_VERSION_linux-xenomai-3 = "4.4%"
diff --git a/opt-linux-5.10.yml b/opt-linux-5.10.yml
index ec9dab3..28cf554 100644
--- a/opt-linux-5.10.yml
+++ b/opt-linux-5.10.yml
@@ -14,4 +14,4 @@ header:
 
 local_conf_header:
   linux-xenomai-version: |
-    PREFERRED_VERSION_linux-xenomai = "5.10%"
+    PREFERRED_VERSION_linux-xenomai-3 = "5.10%"
diff --git a/opt-linux-5.15.yml b/opt-linux-5.15.yml
index bc0b9d2..c02ad37 100644
--- a/opt-linux-5.15.yml
+++ b/opt-linux-5.15.yml
@@ -14,4 +14,4 @@ header:
 
 local_conf_header:
   linux-xenomai-version: |
-    PREFERRED_VERSION_linux-xenomai = "5.15%"
+    PREFERRED_VERSION_linux-xenomai-3 = "5.15%"
diff --git a/opt-linux-5.4.yml b/opt-linux-5.4.yml
index 1b43394..4e0ee0a 100644
--- a/opt-linux-5.4.yml
+++ b/opt-linux-5.4.yml
@@ -14,4 +14,4 @@ header:
 
 local_conf_header:
   linux-xenomai-version: |
-    PREFERRED_VERSION_linux-xenomai = "5.4%"
+    PREFERRED_VERSION_linux-xenomai-3 = "5.4%"
diff --git a/opt-linux-6.1.yml b/opt-linux-6.1.yml
index e723454..76c2a8b 100644
--- a/opt-linux-6.1.yml
+++ b/opt-linux-6.1.yml
@@ -14,4 +14,4 @@ header:
 
 local_conf_header:
   linux-xenomai-version: |
-    PREFERRED_VERSION_linux-xenomai = "6.1%"
+    PREFERRED_VERSION_linux-xenomai-3 = "6.1%"
diff --git a/opt-linux-6.6.yml b/opt-linux-6.6.yml
index 06e0d5d..1b0bbb4 100644
--- a/opt-linux-6.6.yml
+++ b/opt-linux-6.6.yml
@@ -14,4 +14,4 @@ header:
 
 local_conf_header:
   linux-xenomai-version: |
-    PREFERRED_VERSION_linux-xenomai = "6.6%"
+    PREFERRED_VERSION_linux-xenomai-3 = "6.6%"
diff --git a/opt-linux-latest-4.19.yml b/opt-linux-latest-4.19.yml
index c1a3040..e9272b1 100644
--- a/opt-linux-latest-4.19.yml
+++ b/opt-linux-latest-4.19.yml
@@ -14,5 +14,5 @@ header:
 
 local_conf_header:
   linux-xenomai-latest: |
-    PREFERRED_VERSION_linux-xenomai = "9999-%"
+    PREFERRED_VERSION_linux-xenomai-3 = "9999-%"
     LATEST_GIT_BRANCH = "4.19"
diff --git a/opt-linux-latest-4.4.yml b/opt-linux-latest-4.4.yml
index d4864b7..34b57be 100644
--- a/opt-linux-latest-4.4.yml
+++ b/opt-linux-latest-4.4.yml
@@ -14,5 +14,5 @@ header:
 
 local_conf_header:
   linux-xenomai-latest: |
-    PREFERRED_VERSION_linux-xenomai = "9999-%"
+    PREFERRED_VERSION_linux-xenomai-3 = "9999-%"
     LATEST_GIT_BRANCH = "4.4"
diff --git a/opt-linux-latest-5.10.yml b/opt-linux-latest-5.10.yml
index e9ddd7f..a60e58c 100644
--- a/opt-linux-latest-5.10.yml
+++ b/opt-linux-latest-5.10.yml
@@ -14,5 +14,5 @@ header:
 
 local_conf_header:
   linux-xenomai-version: |
-    PREFERRED_VERSION_linux-xenomai = "9999-%"
+    PREFERRED_VERSION_linux-xenomai-3 = "9999-%"
     LATEST_GIT_BRANCH = "5.10"
diff --git a/opt-linux-latest-5.15.yml b/opt-linux-latest-5.15.yml
index 288836f..aeca6a8 100644
--- a/opt-linux-latest-5.15.yml
+++ b/opt-linux-latest-5.15.yml
@@ -14,5 +14,5 @@ header:
 
 local_conf_header:
   linux-xenomai-version: |
-    PREFERRED_VERSION_linux-xenomai = "9999-%"
+    PREFERRED_VERSION_linux-xenomai-3 = "9999-%"
     LATEST_GIT_BRANCH = "5.15"
diff --git a/opt-linux-latest-5.4.yml b/opt-linux-latest-5.4.yml
index 2d15e06..e1a20e1 100644
--- a/opt-linux-latest-5.4.yml
+++ b/opt-linux-latest-5.4.yml
@@ -14,5 +14,5 @@ header:
 
 local_conf_header:
   linux-xenomai-version: |
-    PREFERRED_VERSION_linux-xenomai = "9999-%"
+    PREFERRED_VERSION_linux-xenomai-3 = "9999-%"
     LATEST_GIT_BRANCH = "5.4"
diff --git a/opt-linux-latest-6.1.yml b/opt-linux-latest-6.1.yml
index 3e9ef29..388f116 100644
--- a/opt-linux-latest-6.1.yml
+++ b/opt-linux-latest-6.1.yml
@@ -14,5 +14,5 @@ header:
 
 local_conf_header:
   linux-xenomai-version: |
-    PREFERRED_VERSION_linux-xenomai = "9999-%"
+    PREFERRED_VERSION_linux-xenomai-3 = "9999-%"
     LATEST_GIT_BRANCH = "6.1"
diff --git a/opt-linux-latest-6.6.yml b/opt-linux-latest-6.6.yml
index 7293d94..2287d4b 100644
--- a/opt-linux-latest-6.6.yml
+++ b/opt-linux-latest-6.6.yml
@@ -14,5 +14,5 @@ header:
 
 local_conf_header:
   linux-xenomai-version: |
-    PREFERRED_VERSION_linux-xenomai = "9999-%"
+    PREFERRED_VERSION_linux-xenomai-3 = "9999-%"
     LATEST_GIT_BRANCH = "6.6"
diff --git a/opt-linux-latest.yml b/opt-linux-latest.yml
index aab2342..795f8fe 100644
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
 
diff --git a/recipes-kernel/linux/linux-xenomai.inc b/recipes-kernel/linux/linux-xenomai-3.inc
similarity index 52%
copy from recipes-kernel/linux/linux-xenomai.inc
copy to recipes-kernel/linux/linux-xenomai-3.inc
index 1d7d78a..64ed9d0 100644
--- a/recipes-kernel/linux/linux-xenomai.inc
+++ b/recipes-kernel/linux/linux-xenomai-3.inc
@@ -9,21 +9,10 @@
 # SPDX-License-Identifier: MIT
 #
 
-require recipes-kernel/linux/linux-custom.inc
-inherit print-revision
+require recipes-kernel/linux/linux-xenomai.inc
 
-FILESPATH =. "${LAYERDIR_xenomai}/recipes-kernel/linux/files:"
-
-XENOMAI_DEFCONFIG = "${DISTRO_ARCH}_defconfig"
-KERNEL_DEFCONFIG ?= "${XENOMAI_DEFCONFIG}"
-XENOMAI_DEBUG ?= "0"
-
-SRC_URI += "${@'file://${KERNEL_DEFCONFIG}' if d.getVar('KERNEL_DEFCONFIG') == d.getVar('XENOMAI_DEFCONFIG') else ''}"
-SRC_URI += "${@'file://common_nodbg.cfg' if d.getVar('XENOMAI_DEBUG') == '0' else ''}"
 SRC_URI += "file://rules.tmpl"
 
-S = "${WORKDIR}/git"
-
 DEPENDS += "xenomai-kernel-source"
 KBUILD_DEPENDS += "xenomai-kernel-source:native"
 
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
diff --git a/recipes-kernel/linux/linux-xenomai_6.6.bb b/recipes-kernel/linux/linux-xenomai-3_6.6.bb
similarity index 75%
rename from recipes-kernel/linux/linux-xenomai_6.6.bb
rename to recipes-kernel/linux/linux-xenomai-3_6.6.bb
index 7fce714..b20eb19 100644
--- a/recipes-kernel/linux/linux-xenomai_6.6.bb
+++ b/recipes-kernel/linux/linux-xenomai-3_6.6.bb
@@ -9,6 +9,6 @@
 # SPDX-License-Identifier: MIT
 #
 
-require recipes-kernel/linux/linux-xenomai-dovetail.inc
+require recipes-kernel/linux/linux-xenomai-3-dovetail.inc
 
 SRCREV ?= "v6.6-dovetail1"
diff --git a/recipes-kernel/linux/linux-xenomai_latest.bb b/recipes-kernel/linux/linux-xenomai-3_latest.bb
similarity index 98%
rename from recipes-kernel/linux/linux-xenomai_latest.bb
rename to recipes-kernel/linux/linux-xenomai-3_latest.bb
index d1b0226..c65c28d 100644
--- a/recipes-kernel/linux/linux-xenomai_latest.bb
+++ b/recipes-kernel/linux/linux-xenomai-3_latest.bb
@@ -10,7 +10,7 @@
 # SPDX-License-Identifier: MIT
 #
 
-require recipes-kernel/linux/linux-xenomai.inc
+require recipes-kernel/linux/linux-xenomai-3.inc
 
 PV = "9999-g${COMMIT}"
 
diff --git a/recipes-kernel/linux/linux-xenomai.inc b/recipes-kernel/linux/linux-xenomai.inc
index 1d7d78a..8c7df40 100644
--- a/recipes-kernel/linux/linux-xenomai.inc
+++ b/recipes-kernel/linux/linux-xenomai.inc
@@ -20,17 +20,5 @@ XENOMAI_DEBUG ?= "0"
 
 SRC_URI += "${@'file://${KERNEL_DEFCONFIG}' if d.getVar('KERNEL_DEFCONFIG') == d.getVar('XENOMAI_DEFCONFIG') else ''}"
 SRC_URI += "${@'file://common_nodbg.cfg' if d.getVar('XENOMAI_DEBUG') == '0' else ''}"
-SRC_URI += "file://rules.tmpl"
 
 S = "${WORKDIR}/git"
-
-DEPENDS += "xenomai-kernel-source"
-KBUILD_DEPENDS += "xenomai-kernel-source:native"
-
-TEMPLATE_FILES += "rules.tmpl"
-
-do_prepare_debian_rules() {
-    mv ${WORKDIR}/debian/rules ${WORKDIR}/debian/rules.isar
-    mv ${WORKDIR}/rules ${WORKDIR}/debian/rules
-}
-addtask prepare_debian_rules after do_transform_template before do_dpkg_build
-- 
2.35.3

