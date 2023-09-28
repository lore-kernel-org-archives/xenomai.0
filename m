Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058E83D3BB
	for <xenomai@lists.linux.dev>; Thu, 28 Sep 2023 15:32:57 +0000 (UTC)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20230928153249c4ab540b4ab8e97534
        for <xenomai@lists.linux.dev>;
        Thu, 28 Sep 2023 17:32:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=ge/8jQOM7douD6QWyw7pLCNwVCoJLvzG0V7RqRLSajw=;
 b=GvZ/gCHX+ZSgUStasme8nbVnx/1muCAhPRRcMnNMom2UlSDesYSr0vhoudZJXx6QqqYcNy
 AmKC4z31rthOebQaVbpPtb891tOV8uQXkJFYnus6otuvtNdv7TlqK9M2X2ttnkLbjn+xhU+k
 bruuUmC/B6hTNiBlLyqb+WgcBmf70=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH 2/4] xenomai: Update to 3.2.4
Date: Thu, 28 Sep 2023 17:32:46 +0200
Message-Id: <6fe4e5e291ea04e2a0c5525aa942700898167b79.1695915167.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1695915167.git.jan.kiszka@siemens.com>
References: <cover.1695915167.git.jan.kiszka@siemens.com>
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

This allows to lift the default kernel to 6.1. Also update the Kconfig
menu accordingly.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 Kconfig                                                | 10 +++++-----
 conf/distro/include/xenomai-version.inc                |  6 +++---
 .../xenomai/{xenomai_3.2.3.bb => xenomai_3.2.4.bb}     |  2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)
 rename recipes-xenomai/xenomai/{xenomai_3.2.3.bb => xenomai_3.2.4.bb} (90%)

diff --git a/Kconfig b/Kconfig
index 953634e..3cc4e5b 100644
--- a/Kconfig
+++ b/Kconfig
@@ -87,7 +87,7 @@ config KAS_INCLUDE_XENOMAI
 
 choice
 	prompt "Kernel version"
-	default KERNEL_5_10
+	default KERNEL_6_1
 
 config KERNEL_LATEST
 	bool "Head of latest Dovetail branch"
@@ -95,19 +95,19 @@ config KERNEL_LATEST
 
 config KERNEL_6_1_LATEST
 	bool "Head of 6.1 Dovetail branch"
-	depends on XENOMAI_LATEST
+	depends on XENOMAI_LATEST || XENOMAI_3_2_LATEST || XENOMAI_3_2
 
 config KERNEL_6_1
 	bool "Latest 6.1 Dovetail version"
-	depends on XENOMAI_LATEST
+	depends on XENOMAI_LATEST || XENOMAI_3_2_LATEST || XENOMAI_3_2
 
 config KERNEL_5_15_LATEST
 	bool "Head of 5.15 Dovetail branch"
-	depends on XENOMAI_LATEST || XENOMAI_3_2_LATEST
+	depends on XENOMAI_LATEST || XENOMAI_3_2_LATEST || XENOMAI_3_2
 
 config KERNEL_5_15
 	bool "Latest 5.15 Dovetail version"
-	depends on XENOMAI_LATEST || XENOMAI_3_2_LATEST
+	depends on XENOMAI_LATEST || XENOMAI_3_2_LATEST || XENOMAI_3_2
 
 config KERNEL_5_10_LATEST
 	bool "Head of 5.10 Dovetail branch"
diff --git a/conf/distro/include/xenomai-version.inc b/conf/distro/include/xenomai-version.inc
index a8d40ed..754a738 100644
--- a/conf/distro/include/xenomai-version.inc
+++ b/conf/distro/include/xenomai-version.inc
@@ -9,7 +9,7 @@
 # SPDX-License-Identifier: MIT
 #
 
-XENOMAI_DEFAULT_KERNEL_VERSION = "5.15%"
+XENOMAI_DEFAULT_KERNEL_VERSION = "6.1%"
 
 XENOMAI_3_0_VERSION_LIST = "3.0 3.0% 3.0.% 3.0.14 stable-3.0.x"
 XENOMAI_3_0_KERNEL_VERSION = "4.4%"
@@ -17,8 +17,8 @@ XENOMAI_3_0_KERNEL_VERSION = "4.4%"
 XENOMAI_3_1_VERSION_LIST = "3.1 3.1% 3.1.% 3.1.4 stable-3.1.x"
 XENOMAI_3_1_KERNEL_VERSION = "5.4%"
 
-XENOMAI_3_2_VERSION_LIST = "3.2 3.2% 3.2.% 3.2.3 stable-3.2.x"
-XENOMAI_3_2_KERNEL_VERSION = "5.10%"
+XENOMAI_3_2_VERSION_LIST = "3.2 3.2% 3.2.% 3.2.4 stable-3.2.x"
+XENOMAI_3_2_KERNEL_VERSION = "6.1%"
 
 # If PREFERRED_VERSION_xenomai contains any item from XENOMAI_3_0_VERSION_LIST use
 # XENOMAI_3_0_KERNEL_VERSION. Same for the other XENOMAI_*_VERSION_LIST.
diff --git a/recipes-xenomai/xenomai/xenomai_3.2.3.bb b/recipes-xenomai/xenomai/xenomai_3.2.4.bb
similarity index 90%
rename from recipes-xenomai/xenomai/xenomai_3.2.3.bb
rename to recipes-xenomai/xenomai/xenomai_3.2.4.bb
index f32cd06..0cd1cd9 100644
--- a/recipes-xenomai/xenomai/xenomai_3.2.3.bb
+++ b/recipes-xenomai/xenomai/xenomai_3.2.4.bb
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2020-2021
+# Copyright (c) Siemens AG, 2020-2023
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
-- 
2.35.3

