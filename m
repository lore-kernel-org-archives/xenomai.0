Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CC6312811
	for <xenomai@lists.linux.dev>; Thu, 18 Sep 2025 15:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210978; cv=none; b=TKr1/rEfvOcIq8v2M6pMNY8vDvZAnu0FVn3wv2PEINOnkABX4OYMtEwRFwNkML038PynEzGb14Amf6qvIxf1DZPXGlRsQAXnSNCzKWolP86rzVsQD36mZiGuD8LwB+uNK9bBQ0WFoAVPffYCgtsW2cken0utfRpIHLD/eQ4Ux0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210978; c=relaxed/simple;
	bh=EP8E/UpVc7+OoCo26GGdtX+jQD5Mk1TjxdXQREvWSkg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ngmWhe4k+CPfXUkOWz/yS00f+E47q3Cdqbbfb38x/ogpJdbeGY0YQER8Ox8rxw8rTqqewlsfBv0Qtz8TPngLR8ud/6q/74+LwXOSJvZ2pXY8mNcZfomogt88YUHSz7FxgMRMMJtycqTucWp/6z5lJRMvOfyiQlu7Dxx9lTumWcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=LHPNVv6t; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="LHPNVv6t"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20250918155612015c0ff6280002072a
        for <xenomai@lists.linux.dev>;
        Thu, 18 Sep 2025 17:56:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=cooCg0fcQrsTk/kEH8jIqa/quuXqX5TRtgVaHdIDnUg=;
 b=LHPNVv6toqLMn0Y0wXREtotabuvGze5kdzNWtnis10dCPCfFlcUXc3aqle35v7v8JWMzOR
 YffahRp5pre62NLoH8sEXnqhjsNxaXgHDnU1yt9ceE3oy9nNaUXXOVETm11oBEk1+xp828J7
 aZtJV8zLJPDM1E8hgAO2mjcgM36pgQr1zARFSRHXcWMqygB0T8+QqIzTYW8UT28XV/AbhDfv
 TrwOzy7ltlLAuJSr1wJq9iqeEYuT6mYDoWne4u4+QYue+uc5hhxEKvvoxwbK+oLrULsWfQTh
 PWmz9eHQOG1zX12JJtd+ZFYH1FQpczxz6bFVuRhUvLZHQijO4wSZKdXA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH 07/13] Prefer term "head" over "latest" in menu and kas options
Date: Thu, 18 Sep 2025 17:55:49 +0200
Message-ID: <3c0434463915fb4370dba7b2345a3d11799e87c0.1758210955.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1758210955.git.jan.kiszka@siemens.com>
References: <cover.1758210955.git.jan.kiszka@siemens.com>
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

We already use "latest" in the context of "latest release". Referring to
the head of a specific git branch this way as well can be confusing.

Renaming the opt-xenomai-3.*.yml files at this chance also clears the
namespace for introducing options file referring to the latest stable
releases.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 Kconfig                                       | 84 +++++++++----------
 ci/compat_jobs.yml                            |  4 +-
 ci/kernel_4_19.yml                            | 12 +--
 ci/kernel_5_10.yml                            | 12 +--
 ci/kernel_5_15.yml                            | 12 +--
 ci/kernel_5_4.yml                             | 12 +--
 ci/kernel_6_1.yml                             | 12 +--
 ci/kernel_6_12.yml                            |  6 +-
 ci/kernel_6_12_physical.yml                   |  6 +-
 ci/xenomai_3_1_x.yml                          |  2 +-
 ci/xenomai_3_2_x.yml                          |  2 +-
 ci/xenomai_3_2_x_compat.yml                   |  4 +-
 ci/xenomai_3_3_x.yml                          |  2 +-
 ci/xenomai_3_3_x_compat.yml                   |  2 +-
 ...latest-4.19.yml => opt-linux-4.19-head.yml |  0
 ...latest-5.10.yml => opt-linux-5.10-head.yml |  0
 ...latest-5.15.yml => opt-linux-5.15-head.yml |  0
 ...x-latest-5.4.yml => opt-linux-5.4-head.yml |  0
 ...x-latest-6.1.yml => opt-linux-6.1-head.yml |  0
 ...latest-6.12.yml => opt-linux-6.12-head.yml |  0
 opt-linux-latest.yml => opt-linux-head.yml    |  0
 ...ai-3.1.x.yml => opt-xenomai-3.1.x-head.yml |  0
 ...ai-3.2.x.yml => opt-xenomai-3.2.x-head.yml |  0
 ...ai-3.3.x.yml => opt-xenomai-3.3.x-head.yml |  0
 24 files changed, 86 insertions(+), 86 deletions(-)
 rename opt-linux-latest-4.19.yml => opt-linux-4.19-head.yml (100%)
 rename opt-linux-latest-5.10.yml => opt-linux-5.10-head.yml (100%)
 rename opt-linux-latest-5.15.yml => opt-linux-5.15-head.yml (100%)
 rename opt-linux-latest-5.4.yml => opt-linux-5.4-head.yml (100%)
 rename opt-linux-latest-6.1.yml => opt-linux-6.1-head.yml (100%)
 rename opt-linux-latest-6.12.yml => opt-linux-6.12-head.yml (100%)
 rename opt-linux-latest.yml => opt-linux-head.yml (100%)
 rename opt-xenomai-3.1.x.yml => opt-xenomai-3.1.x-head.yml (100%)
 rename opt-xenomai-3.2.x.yml => opt-xenomai-3.2.x-head.yml (100%)
 rename opt-xenomai-3.3.x.yml => opt-xenomai-3.3.x-head.yml (100%)

diff --git a/Kconfig b/Kconfig
index 17e0885..a155c45 100644
--- a/Kconfig
+++ b/Kconfig
@@ -79,22 +79,22 @@ choice
 	prompt "Xenomai 3 subversion"
 	default XENOMAI_3_3
 
-config XENOMAI_LATEST
+config XENOMAI_HEAD
 	bool "Head of next branch"
 
-config XENOMAI_3_3_LATEST
+config XENOMAI_3_3_HEAD
 	bool "Head of stable/v3.3.x branch"
 
 config XENOMAI_3_3
 	bool "Latest 3.3.x release"
 
-config XENOMAI_3_2_LATEST
+config XENOMAI_3_2_HEAD
 	bool "Head of stable/v3.2.x branch"
 
 config XENOMAI_3_2
 	bool "Latest 3.2.x release"
 
-config XENOMAI_3_1_LATEST
+config XENOMAI_3_1_HEAD
 	bool "Head of stable/v3.1.x branch"
 	depends on !TARGET_RPI4
 
@@ -102,83 +102,83 @@ endchoice
 
 config KAS_INCLUDE_XENOMAI
 	string
-	default "opt-xenomai-next.yml" if XENOMAI_LATEST
-	default "opt-xenomai-3.3.x.yml" if XENOMAI_3_3_LATEST
-	default "opt-xenomai-3.2.x.yml" if XENOMAI_3_2_LATEST
-	default "opt-xenomai-3.1.x.yml" if XENOMAI_3_1_LATEST
+	default "opt-xenomai-next.yml" if XENOMAI_HEAD
+	default "opt-xenomai-3.3.x-head.yml" if XENOMAI_3_3_HEAD
+	default "opt-xenomai-3.2.x-head.yml" if XENOMAI_3_2_HEAD
+	default "opt-xenomai-3.1.x.head.yml" if XENOMAI_3_1_HEAD
 
 choice
 	prompt "Kernel version"
 	default KERNEL_6_12
 
-config KERNEL_LATEST
+config KERNEL_HEAD
 	bool "Head of latest Dovetail branch"
-	depends on XENOMAI_LATEST
+	depends on XENOMAI_HEAD
 
-config KERNEL_6_12_LATEST
+config KERNEL_6_12_HEAD
 	bool "Head of 6.12 Dovetail branch"
-	depends on XENOMAI_LATEST || XENOMAI_3_3_LATEST || XENOMAI_3_3
+	depends on XENOMAI_HEAD || XENOMAI_3_3_HEAD || XENOMAI_3_3
 
 config KERNEL_6_12
 	bool "Latest 6.12 Dovetail release"
-	depends on XENOMAI_LATEST || XENOMAI_3_3_LATEST || XENOMAI_3_3
+	depends on XENOMAI_HEAD || XENOMAI_3_3_HEAD || XENOMAI_3_3
 
-config KERNEL_6_1_LATEST
+config KERNEL_6_1_HEAD
 	bool "Head of 6.1 Dovetail branch"
-	depends on XENOMAI_LATEST || XENOMAI_3_3_LATEST || XENOMAI_3_3 || XENOMAI_3_2_LATEST || XENOMAI_3_2
+	depends on XENOMAI_HEAD || XENOMAI_3_3_HEAD || XENOMAI_3_3 || XENOMAI_3_2_HEAD || XENOMAI_3_2
 
 config KERNEL_6_1
 	bool "Latest 6.1 Dovetail release"
-	depends on XENOMAI_LATEST || XENOMAI_3_3_LATEST || XENOMAI_3_3 || XENOMAI_3_2_LATEST || XENOMAI_3_2
+	depends on XENOMAI_HEAD || XENOMAI_3_3_HEAD || XENOMAI_3_3 || XENOMAI_3_2_HEAD || XENOMAI_3_2
 
-config KERNEL_5_15_LATEST
+config KERNEL_5_15_HEAD
 	bool "Head of 5.15 Dovetail branch"
-	depends on XENOMAI_LATEST || XENOMAI_3_3_LATEST || XENOMAI_3_3 || XENOMAI_3_2_LATEST || XENOMAI_3_2
+	depends on XENOMAI_HEAD || XENOMAI_3_3_HEAD || XENOMAI_3_3 || XENOMAI_3_2_HEAD || XENOMAI_3_2
 
 config KERNEL_5_15
 	bool "Latest 5.15 Dovetail release"
-	depends on XENOMAI_LATEST || XENOMAI_3_3_LATEST || XENOMAI_3_3 || XENOMAI_3_2_LATEST || XENOMAI_3_2
+	depends on XENOMAI_HEAD || XENOMAI_3_3_HEAD || XENOMAI_3_3 || XENOMAI_3_2_HEAD || XENOMAI_3_2
 
-config KERNEL_5_10_LATEST
+config KERNEL_5_10_HEAD
 	bool "Head of 5.10 Dovetail branch"
-	depends on XENOMAI_LATEST || XENOMAI_3_3_LATEST || XENOMAI_3_3 || XENOMAI_3_2_LATEST || XENOMAI_3_2
+	depends on XENOMAI_HEAD || XENOMAI_3_3_HEAD || XENOMAI_3_3 || XENOMAI_3_2_HEAD || XENOMAI_3_2
 
 config KERNEL_5_10
 	bool "Latest 5.10 Dovetail release"
-	depends on XENOMAI_LATEST || XENOMAI_3_3_LATEST || XENOMAI_3_3 || XENOMAI_3_2_LATEST || XENOMAI_3_2
+	depends on XENOMAI_HEAD || XENOMAI_3_3_HEAD || XENOMAI_3_3 || XENOMAI_3_2_HEAD || XENOMAI_3_2
 
-config KERNEL_5_4_LATEST
+config KERNEL_5_4_HEAD
 	bool "Head of 5.4 I-pipe branch"
-	depends on !TARGET_RPI4 && (XENOMAI_3_2_LATEST || XENOMAI_3_2 || XENOMAI_3_1_LATEST || XENOMAI_3_1)
+	depends on !TARGET_RPI4 && (XENOMAI_3_2_HEAD || XENOMAI_3_2 || XENOMAI_3_1_HEAD || XENOMAI_3_1)
 
 config KERNEL_5_4
 	bool "Latest 5.4 I-pipe release"
-	depends on !TARGET_RPI4 && (XENOMAI_3_2_LATEST || XENOMAI_3_2 || XENOMAI_3_1_LATEST || XENOMAI_3_1)
+	depends on !TARGET_RPI4 && (XENOMAI_3_2_HEAD || XENOMAI_3_2 || XENOMAI_3_1_HEAD || XENOMAI_3_1)
 
-config KERNEL_4_19_LATEST
+config KERNEL_4_19_HEAD
 	bool "Head of 4.19-cip I-pipe branch"
-	depends on !TARGET_RPI4 && (XENOMAI_3_2_LATEST || XENOMAI_3_2 || XENOMAI_3_1_LATEST || XENOMAI_3_1)
+	depends on !TARGET_RPI4 && (XENOMAI_3_2_HEAD || XENOMAI_3_2 || XENOMAI_3_1_HEAD || XENOMAI_3_1)
 
 config KERNEL_4_19
 	bool "Latest 4.19-cip I-pipe release"
-	depends on !TARGET_RPI4 && (XENOMAI_3_2_LATEST || XENOMAI_3_2 || XENOMAI_3_1_LATEST || XENOMAI_3_1)
+	depends on !TARGET_RPI4 && (XENOMAI_3_2_HEAD || XENOMAI_3_2 || XENOMAI_3_1_HEAD || XENOMAI_3_1)
 
 endchoice
 
 config KAS_INCLUDE_KERNEL
 	string
-	default "opt-linux-latest.yml" if KERNEL_LATEST
-	default "opt-linux-latest-6.12.yml" if KERNEL_6_12_LATEST
+	default "opt-linux-head.yml" if KERNEL_HEAD
+	default "opt-linux-6.12-head.yml" if KERNEL_6_12_HEAD
 	default "opt-linux-6.12.yml" if KERNEL_6_12
-	default "opt-linux-latest-6.1.yml" if KERNEL_6_1_LATEST
+	default "opt-linux-6.1-head.yml" if KERNEL_6_1_HEAD
 	default "opt-linux-6.1.yml" if KERNEL_6_1
-	default "opt-linux-latest-5.15.yml" if KERNEL_5_15_LATEST
+	default "opt-linux-5.15-head.yml" if KERNEL_5_15_HEAD
 	default "opt-linux-5.15.yml" if KERNEL_5_15
-	default "opt-linux-latest-5.10.yml" if KERNEL_5_10_LATEST
+	default "opt-linux-5.10-head.yml" if KERNEL_5_10_HEAD
 	default "opt-linux-5.10.yml" if KERNEL_5_10
-	default "opt-linux-latest-5.4.yml" if KERNEL_5_4_LATEST
+	default "opt-linux-5.4-head.yml" if KERNEL_5_4_HEAD
 	default "opt-linux-5.4.yml" if KERNEL_5_4
-	default "opt-linux-latest-4.19.yml" if KERNEL_4_19_LATEST
+	default "opt-linux-4.19-head.yml" if KERNEL_4_19_HEAD
 	default "opt-linux-4.19.yml" if KERNEL_4_19
 
 comment "Features"
@@ -200,7 +200,7 @@ config KAS_INCLUDE_DEBUG
 
 config COMPAT
 	bool "Build 32 bit Xenomai userspace"
-	depends on (XENOMAI_LATEST || XENOMAI_3_3_LATEST || XENOMAI_3_3) && (ARCH_X86 || ARCH_ARM64)
+	depends on (XENOMAI_HEAD || XENOMAI_3_3_HEAD || XENOMAI_3_3) && (ARCH_X86 || ARCH_ARM64)
 
 config KAS_INCLUDE_COMPAT
 	string
@@ -214,16 +214,16 @@ choice
 	prompt "Kernel version"
 	default EVL_KERNEL_6_12
 
-config EVL_KERNEL_LATEST
+config EVL_KERNEL_HEAD
 	bool "Head of latest EVL branch"
 
-config EVL_KERNEL_6_12_LATEST
+config EVL_KERNEL_6_12_HEAD
 	bool "Head of 6.12 EVL branch"
 
 config EVL_KERNEL_6_12
 	bool "Latest 6.12 EVL release"
 
-config EVL_KERNEL_6_1_LATEST
+config EVL_KERNEL_6_1_HEAD
 	bool "Head of 6.1 EVL branch"
 
 config EVL_KERNEL_6_1
@@ -233,10 +233,10 @@ endchoice
 
 config KAS_INCLUDE_EVL_KERNEL
 	string
-	default "opt-linux-latest.yml" if EVL_KERNEL_LATEST
-	default "opt-linux-latest-6.12.yml" if EVL_KERNEL_6_12_LATEST
+	default "opt-linux-head.yml" if EVL_KERNEL_HEAD
+	default "opt-linux-6.12-head.yml" if EVL_KERNEL_6_12_HEAD
 	default "opt-linux-6.12.yml" if EVL_KERNEL_6_12
-	default "opt-linux-latest-6.1.yml" if EVL_KERNEL_6_1_LATEST
+	default "opt-linux-6.1-head.yml" if EVL_KERNEL_6_1_HEAD
 	default "opt-linux-6.1.yml" if EVL_KERNEL_6_1
 
 choice
diff --git a/ci/compat_jobs.yml b/ci/compat_jobs.yml
index b5ad60a..6f6f1bd 100644
--- a/ci/compat_jobs.yml
+++ b/ci/compat_jobs.yml
@@ -14,7 +14,7 @@ build-5.15-compat:x86-64-efi:
     - .build:x86-64-efi
     - .compat-vars
   variables:
-    LINUX_BUILD_OPTION: ":opt-linux-latest-5.15.yml"
+    LINUX_BUILD_OPTION: ":opt-linux-5.15-head.yml"
     KERNEL_VERSION: "5.15"
     CACHE_KERNEL: dovetail
 
@@ -33,7 +33,7 @@ build-6.12-compat:rpi4:
   rules:
     - if: '$XENOMAI_VERSION != "3_2_x-compat"'
   variables:
-    LINUX_BUILD_OPTION: ":opt-linux-latest-6.12.yml"
+    LINUX_BUILD_OPTION: ":opt-linux-6.12-head.yml"
     KERNEL_VERSION: "6.12"
     CACHE_KERNEL: dovetail
 
diff --git a/ci/kernel_4_19.yml b/ci/kernel_4_19.yml
index 98ecedf..08dae50 100644
--- a/ci/kernel_4_19.yml
+++ b/ci/kernel_4_19.yml
@@ -12,7 +12,7 @@
 build-4.19:qemu-amd64:
   extends: .build:qemu-amd64
   variables:
-    LINUX_BUILD_OPTION: ":opt-linux-latest-4.19.yml"
+    LINUX_BUILD_OPTION: ":opt-linux-4.19-head.yml"
     KERNEL_VERSION: "4.19"
     CACHE_KERNEL: ipipe-x86
 
@@ -25,7 +25,7 @@ lava-test-4.19:qemu-amd64:
 build-4.19:qemu-armhf:
   extends: .build:qemu-armhf
   variables:
-    LINUX_BUILD_OPTION: ":opt-linux-latest-4.19.yml"
+    LINUX_BUILD_OPTION: ":opt-linux-4.19-head.yml"
     KERNEL_VERSION: "4.19"
     CACHE_KERNEL: ipipe-arm
 
@@ -38,7 +38,7 @@ lava-test-4.19:qemu-armhf:
 build-4.19:qemu-arm64:
   extends: .build:qemu-arm64
   variables:
-    LINUX_BUILD_OPTION: ":opt-linux-latest-4.19.yml"
+    LINUX_BUILD_OPTION: ":opt-linux-4.19-head.yml"
     KERNEL_VERSION: "4.19"
     CACHE_KERNEL: ipipe-arm64
 
@@ -51,7 +51,7 @@ lava-test-4.19:qemu-arm64:
 build-4.19:hikey:
   extends: .build:hikey
   variables:
-    LINUX_BUILD_OPTION: ":opt-linux-latest-4.19.yml"
+    LINUX_BUILD_OPTION: ":opt-linux-4.19-head.yml"
     KERNEL_VERSION: "4.19"
     CACHE_KERNEL: ipipe-arm64
 
@@ -64,7 +64,7 @@ lava-test-4.19:hikey:
 build-4.19:beagle-bone-black:
   extends: .build:beagle-bone-black
   variables:
-    LINUX_BUILD_OPTION: ":opt-linux-latest-4.19.yml"
+    LINUX_BUILD_OPTION: ":opt-linux-4.19-head.yml"
     KERNEL_VERSION: "4.19"
     CACHE_KERNEL: ipipe-arm
 
@@ -77,7 +77,7 @@ lava-test-4.19:beagle-bone-black:
 build-4.19:x86-64-efi:
   extends: .build:x86-64-efi
   variables:
-    LINUX_BUILD_OPTION: ":opt-linux-latest-4.19.yml"
+    LINUX_BUILD_OPTION: ":opt-linux-4.19-head.yml"
     KERNEL_VERSION: "4.19"
     CACHE_KERNEL: ipipe-x86
 
diff --git a/ci/kernel_5_10.yml b/ci/kernel_5_10.yml
index 44cd6d6..509da89 100644
--- a/ci/kernel_5_10.yml
+++ b/ci/kernel_5_10.yml
@@ -12,7 +12,7 @@
 build-5.10:qemu-amd64:
   extends: .build:qemu-amd64
   variables:
-    LINUX_BUILD_OPTION: ":opt-linux-latest-5.10.yml"
+    LINUX_BUILD_OPTION: ":opt-linux-5.10-head.yml"
     KERNEL_VERSION: "5.10"
     CACHE_KERNEL: dovetail
 
@@ -25,7 +25,7 @@ lava-test-5.10:qemu-amd64:
 build-5.10:qemu-armhf:
   extends: .build:qemu-armhf
   variables:
-    LINUX_BUILD_OPTION: ":opt-linux-latest-5.10.yml"
+    LINUX_BUILD_OPTION: ":opt-linux-5.10-head.yml"
     KERNEL_VERSION: "5.10"
     CACHE_KERNEL: dovetail
 
@@ -38,7 +38,7 @@ lava-test-5.10:qemu-armhf:
 build-5.10:qemu-arm64:
   extends: .build:qemu-arm64
   variables:
-    LINUX_BUILD_OPTION: ":opt-linux-latest-5.10.yml"
+    LINUX_BUILD_OPTION: ":opt-linux-5.10-head.yml"
     KERNEL_VERSION: "5.10"
     CACHE_KERNEL: dovetail
 
@@ -51,7 +51,7 @@ lava-test-5.10:qemu-arm64:
 build-5.10:hikey:
   extends: .build:hikey
   variables:
-    LINUX_BUILD_OPTION: ":opt-linux-latest-5.10.yml"
+    LINUX_BUILD_OPTION: ":opt-linux-5.10-head.yml"
     KERNEL_VERSION: "5.10"
     CACHE_KERNEL: dovetail
 
@@ -64,7 +64,7 @@ lava-test-5.10:hikey:
 build-5.10:beagle-bone-black:
   extends: .build:beagle-bone-black
   variables:
-    LINUX_BUILD_OPTION: ":opt-linux-latest-5.10.yml"
+    LINUX_BUILD_OPTION: ":opt-linux-5.10-head.yml"
     KERNEL_VERSION: "5.10"
     CACHE_KERNEL: dovetail
 
@@ -77,7 +77,7 @@ lava-test-5.10:beagle-bone-black:
 build-5.10:x86-64-efi:
   extends: .build:x86-64-efi
   variables:
-    LINUX_BUILD_OPTION: ":opt-linux-latest-5.10.yml"
+    LINUX_BUILD_OPTION: ":opt-linux-5.10-head.yml"
     KERNEL_VERSION: "5.10"
     CACHE_KERNEL: dovetail
 
diff --git a/ci/kernel_5_15.yml b/ci/kernel_5_15.yml
index 52710fd..cd0c11c 100644
--- a/ci/kernel_5_15.yml
+++ b/ci/kernel_5_15.yml
@@ -12,7 +12,7 @@
 build-5.15:qemu-amd64:
   extends: .build:qemu-amd64
   variables:
-    LINUX_BUILD_OPTION: ":opt-linux-latest-5.15.yml"
+    LINUX_BUILD_OPTION: ":opt-linux-5.15-head.yml"
     KERNEL_VERSION: "5.15"
     CACHE_KERNEL: dovetail
 
@@ -25,7 +25,7 @@ lava-test-5.15:qemu-amd64:
 build-5.15:qemu-armhf:
   extends: .build:qemu-armhf
   variables:
-    LINUX_BUILD_OPTION: ":opt-linux-latest-5.15.yml"
+    LINUX_BUILD_OPTION: ":opt-linux-5.15-head.yml"
     KERNEL_VERSION: "5.15"
     CACHE_KERNEL: dovetail
 
@@ -38,7 +38,7 @@ lava-test-5.15:qemu-armhf:
 build-5.15:qemu-arm64:
   extends: .build:qemu-arm64
   variables:
-    LINUX_BUILD_OPTION: ":opt-linux-latest-5.15.yml"
+    LINUX_BUILD_OPTION: ":opt-linux-5.15-head.yml"
     KERNEL_VERSION: "5.15"
     CACHE_KERNEL: dovetail
 
@@ -51,7 +51,7 @@ lava-test-5.15:qemu-arm64:
 build-5.15:hikey:
   extends: .build:hikey
   variables:
-    LINUX_BUILD_OPTION: ":opt-linux-latest-5.15.yml"
+    LINUX_BUILD_OPTION: ":opt-linux-5.15-head.yml"
     KERNEL_VERSION: "5.15"
     CACHE_KERNEL: dovetail
 
@@ -64,7 +64,7 @@ lava-test-5.15:hikey:
 build-5.15:beagle-bone-black:
   extends: .build:beagle-bone-black
   variables:
-    LINUX_BUILD_OPTION: ":opt-linux-latest-5.15.yml"
+    LINUX_BUILD_OPTION: ":opt-linux-5.15-head.yml"
     KERNEL_VERSION: "5.15"
     CACHE_KERNEL: dovetail
 
@@ -77,7 +77,7 @@ lava-test-5.15:beagle-bone-black:
 build-5.15:x86-64-efi:
   extends: .build:x86-64-efi
   variables:
-    LINUX_BUILD_OPTION: ":opt-linux-latest-5.15.yml"
+    LINUX_BUILD_OPTION: ":opt-linux-5.15-head.yml"
     KERNEL_VERSION: "5.15"
     CACHE_KERNEL: dovetail
 
diff --git a/ci/kernel_5_4.yml b/ci/kernel_5_4.yml
index 4727178..3a81be3 100644
--- a/ci/kernel_5_4.yml
+++ b/ci/kernel_5_4.yml
@@ -12,7 +12,7 @@
 build-5.4:qemu-amd64:
   extends: .build:qemu-amd64
   variables:
-    LINUX_BUILD_OPTION: ":opt-linux-latest-5.4.yml"
+    LINUX_BUILD_OPTION: ":opt-linux-5.4-head.yml"
     KERNEL_VERSION: "5.4"
     CACHE_KERNEL: ipipe-x86
 
@@ -25,7 +25,7 @@ lava-test-5.4:qemu-amd64:
 build-5.4:qemu-armhf:
   extends: .build:qemu-armhf
   variables:
-    LINUX_BUILD_OPTION: ":opt-linux-latest-5.4.yml"
+    LINUX_BUILD_OPTION: ":opt-linux-5.4-head.yml"
     KERNEL_VERSION: "5.4"
     CACHE_KERNEL: ipipe-arm
 
@@ -38,7 +38,7 @@ lava-test-5.4:qemu-armhf:
 build-5.4:qemu-arm64:
   extends: .build:qemu-arm64
   variables:
-    LINUX_BUILD_OPTION: ":opt-linux-latest-5.4.yml"
+    LINUX_BUILD_OPTION: ":opt-linux-5.4-head.yml"
     KERNEL_VERSION: "5.4"
     CACHE_KERNEL: ipipe-arm64
 
@@ -51,7 +51,7 @@ lava-test-5.4:qemu-arm64:
 build-5.4:hikey:
   extends: .build:hikey
   variables:
-    LINUX_BUILD_OPTION: ":opt-linux-latest-5.4.yml"
+    LINUX_BUILD_OPTION: ":opt-linux-5.4-head.yml"
     KERNEL_VERSION: "5.4"
     CACHE_KERNEL: ipipe-arm64
 
@@ -64,7 +64,7 @@ lava-test-5.4:hikey:
 build-5.4:beagle-bone-black:
   extends: .build:beagle-bone-black
   variables:
-    LINUX_BUILD_OPTION: ":opt-linux-latest-5.4.yml"
+    LINUX_BUILD_OPTION: ":opt-linux-5.4-head.yml"
     KERNEL_VERSION: "5.4"
     CACHE_KERNEL: ipipe-arm
 
@@ -77,7 +77,7 @@ lava-test-5.4:beagle-bone-black:
 build-5.4:x86-64-efi:
   extends: .build:x86-64-efi
   variables:
-    LINUX_BUILD_OPTION: ":opt-linux-latest-5.4.yml"
+    LINUX_BUILD_OPTION: ":opt-linux-5.4-head.yml"
     KERNEL_VERSION: "5.4"
     CACHE_KERNEL: ipipe-x86
 
diff --git a/ci/kernel_6_1.yml b/ci/kernel_6_1.yml
index 1c6a6d7..c32318d 100644
--- a/ci/kernel_6_1.yml
+++ b/ci/kernel_6_1.yml
@@ -12,7 +12,7 @@
 build-6.1:qemu-amd64:
   extends: .build:qemu-amd64
   variables:
-    LINUX_BUILD_OPTION: ":opt-linux-latest-6.1.yml"
+    LINUX_BUILD_OPTION: ":opt-linux-6.1-head.yml"
     KERNEL_VERSION: "6.1"
     CACHE_KERNEL: dovetail
 
@@ -25,7 +25,7 @@ lava-test-6.1:qemu-amd64:
 build-6.1:qemu-armhf:
   extends: .build:qemu-armhf
   variables:
-    LINUX_BUILD_OPTION: ":opt-linux-latest-6.1.yml"
+    LINUX_BUILD_OPTION: ":opt-linux-6.1-head.yml"
     KERNEL_VERSION: "6.1"
     CACHE_KERNEL: dovetail
 
@@ -38,7 +38,7 @@ lava-test-6.1:qemu-armhf:
 build-6.1:qemu-arm64:
   extends: .build:qemu-arm64
   variables:
-    LINUX_BUILD_OPTION: ":opt-linux-latest-6.1.yml"
+    LINUX_BUILD_OPTION: ":opt-linux-6.1-head.yml"
     KERNEL_VERSION: "6.1"
     CACHE_KERNEL: dovetail
 
@@ -51,7 +51,7 @@ lava-test-6.1:qemu-arm64:
 build-6.1:hikey:
   extends: .build:hikey
   variables:
-    LINUX_BUILD_OPTION: ":opt-linux-latest-6.1.yml"
+    LINUX_BUILD_OPTION: ":opt-linux-6.1-head.yml"
     KERNEL_VERSION: "6.1"
     CACHE_KERNEL: dovetail
 
@@ -64,7 +64,7 @@ lava-test-6.1:hikey:
 build-6.1:beagle-bone-black:
   extends: .build:beagle-bone-black
   variables:
-    LINUX_BUILD_OPTION: ":opt-linux-latest-6.1.yml"
+    LINUX_BUILD_OPTION: ":opt-linux-6.1-head.yml"
     KERNEL_VERSION: "6.1"
     CACHE_KERNEL: dovetail
 
@@ -77,7 +77,7 @@ lava-test-6.1:beagle-bone-black:
 build-6.1:x86-64-efi:
   extends: .build:x86-64-efi
   variables:
-    LINUX_BUILD_OPTION: ":opt-linux-latest-6.1.yml"
+    LINUX_BUILD_OPTION: ":opt-linux-6.1-head.yml"
     KERNEL_VERSION: "6.1"
     CACHE_KERNEL: dovetail
 
diff --git a/ci/kernel_6_12.yml b/ci/kernel_6_12.yml
index ebf1da0..c2ddf25 100644
--- a/ci/kernel_6_12.yml
+++ b/ci/kernel_6_12.yml
@@ -15,7 +15,7 @@ include:
 build-6.12:qemu-amd64:
   extends: .build:qemu-amd64
   variables:
-    LINUX_BUILD_OPTION: ":opt-linux-latest-6.12.yml"
+    LINUX_BUILD_OPTION: ":opt-linux-6.12-head.yml"
     KERNEL_VERSION: "6.12"
     CACHE_KERNEL: dovetail
 
@@ -28,7 +28,7 @@ lava-test-6.12:qemu-amd64:
 build-6.12:qemu-armhf:
   extends: .build:qemu-armhf
   variables:
-    LINUX_BUILD_OPTION: ":opt-linux-latest-6.12.yml"
+    LINUX_BUILD_OPTION: ":opt-linux-6.12-head.yml"
     KERNEL_VERSION: "6.12"
     CACHE_KERNEL: dovetail
 
@@ -41,7 +41,7 @@ lava-test-6.12:qemu-armhf:
 build-6.12:qemu-arm64:
   extends: .build:qemu-arm64
   variables:
-    LINUX_BUILD_OPTION: ":opt-linux-latest-6.12.yml"
+    LINUX_BUILD_OPTION: ":opt-linux-6.12-head.yml"
     KERNEL_VERSION: "6.12"
     CACHE_KERNEL: dovetail
 
diff --git a/ci/kernel_6_12_physical.yml b/ci/kernel_6_12_physical.yml
index 17e42ad..2d9103d 100644
--- a/ci/kernel_6_12_physical.yml
+++ b/ci/kernel_6_12_physical.yml
@@ -12,7 +12,7 @@
 build-6.12:rpi4:
   extends: .build:rpi4
   variables:
-    LINUX_BUILD_OPTION: ":opt-linux-latest-6.12.yml"
+    LINUX_BUILD_OPTION: ":opt-linux-6.12-head.yml"
     KERNEL_VERSION: "6.12"
     CACHE_KERNEL: dovetail
 
@@ -26,7 +26,7 @@ lava-test-6.12:rpi4:
 build-6.12:beagle-bone-black:
   extends: .build:beagle-bone-black
   variables:
-    LINUX_BUILD_OPTION: ":opt-linux-latest-6.12.yml"
+    LINUX_BUILD_OPTION: ":opt-linux-6.12-head.yml"
     KERNEL_VERSION: "6.12"
     CACHE_KERNEL: dovetail
 
@@ -40,7 +40,7 @@ lava-test-6.12:beagle-bone-black:
 build-6.12:x86-64-efi:
   extends: .build:x86-64-efi
   variables:
-    LINUX_BUILD_OPTION: ":opt-linux-latest-6.12.yml"
+    LINUX_BUILD_OPTION: ":opt-linux-6.12-head.yml"
     KERNEL_VERSION: "6.12"
     CACHE_KERNEL: dovetail
 
diff --git a/ci/xenomai_3_1_x.yml b/ci/xenomai_3_1_x.yml
index 64bae5b..76773ed 100644
--- a/ci/xenomai_3_1_x.yml
+++ b/ci/xenomai_3_1_x.yml
@@ -14,5 +14,5 @@ include:
   - local: '/ci/kernel_4_19.yml'
 
 variables:
-  XENOMAI_BUILD_OPTION: ":opt-xenomai-3.1.x.yml:opt-debug.yml"
+  XENOMAI_BUILD_OPTION: ":opt-xenomai-3.1.x-head.yml:opt-debug.yml"
   XENOMAI_VERSION: "3.1.x"
diff --git a/ci/xenomai_3_2_x.yml b/ci/xenomai_3_2_x.yml
index 5b90148..0ba0b17 100644
--- a/ci/xenomai_3_2_x.yml
+++ b/ci/xenomai_3_2_x.yml
@@ -19,5 +19,5 @@ include:
   - local: '/ci/xenomai_3_2_x_compat.yml'
 
 variables:
-  XENOMAI_BUILD_OPTION: ":opt-xenomai-3.2.x.yml:opt-debug.yml"
+  XENOMAI_BUILD_OPTION: ":opt-xenomai-3.2.x-head.yml:opt-debug.yml"
   XENOMAI_VERSION: "3.2.x"
diff --git a/ci/xenomai_3_2_x_compat.yml b/ci/xenomai_3_2_x_compat.yml
index 053468a..5584f05 100644
--- a/ci/xenomai_3_2_x_compat.yml
+++ b/ci/xenomai_3_2_x_compat.yml
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2023
+# Copyright (c) Siemens AG, 2023-2025
 #
 # Authors:
 #  Florian Bezdeka <florian.bezdeka@siemens.com>
@@ -11,7 +11,7 @@
 
 .compat-vars:
   variables:
-    XENOMAI_BUILD_OPTION: ":opt-xenomai-3.2.x.yml:opt-debug.yml:opt-compat.yml"
+    XENOMAI_BUILD_OPTION: ":opt-xenomai-3.2.x-head.yml:opt-debug.yml:opt-compat.yml"
     XENOMAI_VERSION: "3_2_x-compat"
 
 include:
diff --git a/ci/xenomai_3_3_x.yml b/ci/xenomai_3_3_x.yml
index dd5f823..3261be0 100644
--- a/ci/xenomai_3_3_x.yml
+++ b/ci/xenomai_3_3_x.yml
@@ -18,6 +18,6 @@ include:
   - local: '/ci/xenomai_3_3_x_compat.yml'
 
 variables:
-  XENOMAI_BUILD_OPTION: ":opt-xenomai-3.3.x.yml:opt-debug.yml"
+  XENOMAI_BUILD_OPTION: ":opt-xenomai-3.3.x-head.yml:opt-debug.yml"
   XENOMAI_VERSION: "3.3.x"
   LATEST_KERNEL_VERSION: "6.12"
diff --git a/ci/xenomai_3_3_x_compat.yml b/ci/xenomai_3_3_x_compat.yml
index 5f64fed..504872d 100644
--- a/ci/xenomai_3_3_x_compat.yml
+++ b/ci/xenomai_3_3_x_compat.yml
@@ -11,7 +11,7 @@
 
 .compat-vars:
   variables:
-    XENOMAI_BUILD_OPTION: ":opt-xenomai-3.3.x.yml:opt-debug.yml:opt-compat.yml"
+    XENOMAI_BUILD_OPTION: ":opt-xenomai-3.3.x-head.yml:opt-debug.yml:opt-compat.yml"
     XENOMAI_VERSION: "3_3_x-compat"
 
 include:
diff --git a/opt-linux-latest-4.19.yml b/opt-linux-4.19-head.yml
similarity index 100%
rename from opt-linux-latest-4.19.yml
rename to opt-linux-4.19-head.yml
diff --git a/opt-linux-latest-5.10.yml b/opt-linux-5.10-head.yml
similarity index 100%
rename from opt-linux-latest-5.10.yml
rename to opt-linux-5.10-head.yml
diff --git a/opt-linux-latest-5.15.yml b/opt-linux-5.15-head.yml
similarity index 100%
rename from opt-linux-latest-5.15.yml
rename to opt-linux-5.15-head.yml
diff --git a/opt-linux-latest-5.4.yml b/opt-linux-5.4-head.yml
similarity index 100%
rename from opt-linux-latest-5.4.yml
rename to opt-linux-5.4-head.yml
diff --git a/opt-linux-latest-6.1.yml b/opt-linux-6.1-head.yml
similarity index 100%
rename from opt-linux-latest-6.1.yml
rename to opt-linux-6.1-head.yml
diff --git a/opt-linux-latest-6.12.yml b/opt-linux-6.12-head.yml
similarity index 100%
rename from opt-linux-latest-6.12.yml
rename to opt-linux-6.12-head.yml
diff --git a/opt-linux-latest.yml b/opt-linux-head.yml
similarity index 100%
rename from opt-linux-latest.yml
rename to opt-linux-head.yml
diff --git a/opt-xenomai-3.1.x.yml b/opt-xenomai-3.1.x-head.yml
similarity index 100%
rename from opt-xenomai-3.1.x.yml
rename to opt-xenomai-3.1.x-head.yml
diff --git a/opt-xenomai-3.2.x.yml b/opt-xenomai-3.2.x-head.yml
similarity index 100%
rename from opt-xenomai-3.2.x.yml
rename to opt-xenomai-3.2.x-head.yml
diff --git a/opt-xenomai-3.3.x.yml b/opt-xenomai-3.3.x-head.yml
similarity index 100%
rename from opt-xenomai-3.3.x.yml
rename to opt-xenomai-3.3.x-head.yml
-- 
2.51.0

