Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7473312836
	for <xenomai@lists.linux.dev>; Thu, 18 Sep 2025 15:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210978; cv=none; b=jawRhO5gF2GQNkSXwL7iZ3QuH2KU4+hWk7GfDq97yRUskbD0mM81ncEDXCYhnYBD+8wYU4BDkUpZN04I6hrMLzBMgcUwBRaYD2lHAIHZA/gUqGM6w1sHIq6sYfJ5Ojs/YMJ8W0uFWtJuw0VQJM6kmCZO7MMp5rHjQi2GrW4jaHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210978; c=relaxed/simple;
	bh=obG+7kkUvA7u0BTofGwDM7Ub2XDrpedQbagxTwakyg0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mGVryiFnMw4a3r3P/uNCHU1Oz5yhgXpafdw+9IbLpUA9wIN2hGDcv/aOY2NAbAx1n6eFbLU1F5MPBf1xOiG42mmzqAxQvF4kVNWTqxKO8vXd3RRWulv2OtBMb1u2MohopgDfBhoX6N06s2i7u7PisrWOJFbbxVUCBPau+V4n050=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=AwTd09th; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="AwTd09th"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20250918155615e60e8f67800002075c
        for <xenomai@lists.linux.dev>;
        Thu, 18 Sep 2025 17:56:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=igCuL+jv88mlNld8M1c8GSrd9k/0lKR/YB6M3BeIwnM=;
 b=AwTd09thBIrhmJqXkvihjTNw/x8YrRIt5UxB5Gv0ICX0v7+JkpAC8ylEu7yqv7WP4FcTye
 5ys1I3m+nkqzGBE245rE1py/wZzCdws9iTEDx62WSwsH0TgVGe3RUpLei3jmMc3N6m4+JuQt
 tS0+J0AyX4hvVRR24xnoOgd6gd4tr8XwZNuBu/PYkIjL8TdOLOT+X4Z5oOIb5V5btvj2u1mW
 Petafe1RzotQlxMDd8ny1E/6KhKvvDV/kfmQb0GBkVNNWKfbCQV793QPhTJrvpTMBpUBzTUE
 NkIdGczsOdALIdgfRKbxgfu6hz2F7LvQCjIwKdoERNbFbUkHs9nKVmnw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH 10/13] kas: Restructure option files
Date: Thu, 18 Sep 2025 17:55:52 +0200
Message-ID: <6be19a3ff8cec0c0cc440c584929692f83d2320c.1758210955.git.jan.kiszka@siemens.com>
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

The main folder is filling up with more and more options and boards.
Switch to a subdir structure to keep it cleaner. Also change the file
endings to .yaml at this chance, the official ending for YAML files.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 Kconfig                                       | 74 +++++++++----------
 README.md                                     |  7 +-
 ci/compat_jobs.yml                            |  4 +-
 ci/gitlab-ci-base.yml                         |  6 +-
 ci/kernel_4_19.yml                            | 14 ++--
 ci/kernel_5_10.yml                            | 14 ++--
 ci/kernel_5_15.yml                            | 14 ++--
 ci/kernel_5_4.yml                             | 14 ++--
 ci/kernel_6_1.yml                             | 14 ++--
 ci/kernel_6_12.yml                            |  6 +-
 ci/kernel_6_12_physical.yml                   |  6 +-
 ci/xenomai_3_1_x.yml                          |  4 +-
 ci/xenomai_3_2_x.yml                          |  4 +-
 ci/xenomai_3_2_x_compat.yml                   |  2 +-
 ci/xenomai_3_3_x.yml                          |  2 +-
 ci/xenomai_3_3_x_compat.yml                   |  2 +-
 ci/xenomai_3_next.yml                         |  2 +-
 ci/xenomai_3_next_compat.yml                  |  4 +-
 ci/xenomai_3_next_long_term.yml               |  4 +-
 ci/xenomai_4_next.yml                         |  2 +-
 kas.yml => kas.yaml                           |  0
 .../board/beagle-bone-black.yaml              |  0
 board-hikey.yml => kas/board/hikey.yaml       |  0
 .../board/qemu-amd64.yaml                     |  0
 .../board/qemu-arm64.yaml                     |  0
 .../board/qemu-armhf.yaml                     |  0
 board-rpi4.yml => kas/board/rpi4.yaml         |  0
 .../board/x86-64-efi.yaml                     |  0
 opt-ci.yml => kas/opt/ci.yaml                 |  0
 opt-compat.yml => kas/opt/compat.yaml         |  0
 opt-debug.yml => kas/opt/debug.yaml           |  0
 opt-evl.yml => kas/opt/evl.yaml               |  0
 .../opt/libevl-latest-release.yaml            |  4 +-
 .../opt/libevl-next.yaml                      |  4 +-
 .../opt/linux-4.19-head.yaml                  |  0
 opt-linux-4.19.yml => kas/opt/linux-4.19.yaml |  0
 .../opt/linux-5.10-head.yaml                  |  0
 opt-linux-5.10.yml => kas/opt/linux-5.10.yaml |  0
 .../opt/linux-5.15-head.yaml                  |  0
 opt-linux-5.15.yml => kas/opt/linux-5.15.yaml |  0
 .../opt/linux-5.4-head.yaml                   |  0
 opt-linux-5.4.yml => kas/opt/linux-5.4.yaml   |  0
 .../opt/linux-6.1-head.yaml                   |  0
 opt-linux-6.1.yml => kas/opt/linux-6.1.yaml   |  0
 .../opt/linux-6.12-head.yaml                  |  0
 opt-linux-6.12.yml => kas/opt/linux-6.12.yaml |  0
 opt-linux-head.yml => kas/opt/linux-head.yaml |  0
 .../opt/xenomai-3.1.x-head.yaml               |  0
 .../opt/xenomai-3.1.x.yaml                    |  0
 .../opt/xenomai-3.2.x-head.yaml               |  0
 .../opt/xenomai-3.2.x.yaml                    |  0
 .../opt/xenomai-3.3.x-head.yaml               |  0
 .../opt/xenomai-3.3.x.yaml                    |  0
 .../opt/xenomai-next.yaml                     |  0
 54 files changed, 104 insertions(+), 103 deletions(-)
 rename kas.yml => kas.yaml (100%)
 rename board-beagle-bone-black.yml => kas/board/beagle-bone-black.yaml (100%)
 rename board-hikey.yml => kas/board/hikey.yaml (100%)
 rename board-qemu-amd64.yml => kas/board/qemu-amd64.yaml (100%)
 rename board-qemu-arm64.yml => kas/board/qemu-arm64.yaml (100%)
 rename board-qemu-armhf.yml => kas/board/qemu-armhf.yaml (100%)
 rename board-rpi4.yml => kas/board/rpi4.yaml (100%)
 rename board-x86-64-efi.yml => kas/board/x86-64-efi.yaml (100%)
 rename opt-ci.yml => kas/opt/ci.yaml (100%)
 rename opt-compat.yml => kas/opt/compat.yaml (100%)
 rename opt-debug.yml => kas/opt/debug.yaml (100%)
 rename opt-evl.yml => kas/opt/evl.yaml (100%)
 rename opt-libevl-latest-release.yml => kas/opt/libevl-latest-release.yaml (79%)
 rename opt-libevl-next.yml => kas/opt/libevl-next.yaml (79%)
 rename opt-linux-4.19-head.yml => kas/opt/linux-4.19-head.yaml (100%)
 rename opt-linux-4.19.yml => kas/opt/linux-4.19.yaml (100%)
 rename opt-linux-5.10-head.yml => kas/opt/linux-5.10-head.yaml (100%)
 rename opt-linux-5.10.yml => kas/opt/linux-5.10.yaml (100%)
 rename opt-linux-5.15-head.yml => kas/opt/linux-5.15-head.yaml (100%)
 rename opt-linux-5.15.yml => kas/opt/linux-5.15.yaml (100%)
 rename opt-linux-5.4-head.yml => kas/opt/linux-5.4-head.yaml (100%)
 rename opt-linux-5.4.yml => kas/opt/linux-5.4.yaml (100%)
 rename opt-linux-6.1-head.yml => kas/opt/linux-6.1-head.yaml (100%)
 rename opt-linux-6.1.yml => kas/opt/linux-6.1.yaml (100%)
 rename opt-linux-6.12-head.yml => kas/opt/linux-6.12-head.yaml (100%)
 rename opt-linux-6.12.yml => kas/opt/linux-6.12.yaml (100%)
 rename opt-linux-head.yml => kas/opt/linux-head.yaml (100%)
 rename opt-xenomai-3.1.x-head.yml => kas/opt/xenomai-3.1.x-head.yaml (100%)
 rename opt-xenomai-3.1.x.yml => kas/opt/xenomai-3.1.x.yaml (100%)
 rename opt-xenomai-3.2.x-head.yml => kas/opt/xenomai-3.2.x-head.yaml (100%)
 rename opt-xenomai-3.2.x.yml => kas/opt/xenomai-3.2.x.yaml (100%)
 rename opt-xenomai-3.3.x-head.yml => kas/opt/xenomai-3.3.x-head.yaml (100%)
 rename opt-xenomai-3.3.x.yml => kas/opt/xenomai-3.3.x.yaml (100%)
 rename opt-xenomai-next.yml => kas/opt/xenomai-next.yaml (100%)

diff --git a/Kconfig b/Kconfig
index 8846b1c..a3e3885 100644
--- a/Kconfig
+++ b/Kconfig
@@ -2,7 +2,7 @@ mainmenu "Xenomai Reference Images"
 
 config KAS_INCLUDE_MAIN
 	string
-	default "kas.yml"
+	default "kas.yaml"
 
 config KAS_BUILD_SYSTEM
 	string
@@ -53,13 +53,13 @@ endchoice
 
 config KAS_INCLUDE_TARGET
 	string
-	default "board-qemu-amd64.yml" if TARGET_QEMU_AMD64
-	default "board-x86-64-efi.yml" if TARGET_X86_64_EFI
-	default "board-qemu-armhf.yml" if TARGET_QEMU_ARM
-	default "board-beagle-bone-black.yml" if TARGET_BBB
-	default "board-qemu-arm64.yml" if TARGET_QEMU_ARM64
-	default "board-hikey.yml" if TARGET_HIKEY
-	default "board-rpi4.yml" if TARGET_RPI4
+	default "kas/board/qemu-amd64.yaml" if TARGET_QEMU_AMD64
+	default "kas/board/x86-64-efi.yaml" if TARGET_X86_64_EFI
+	default "kas/board/qemu-armhf.yaml" if TARGET_QEMU_ARM
+	default "kas/board/beagle-bone-black.yaml" if TARGET_BBB
+	default "kas/board/qemu-arm64.yaml" if TARGET_QEMU_ARM64
+	default "kas/board/hikey.yaml" if TARGET_HIKEY
+	default "kas/board/rpi4.yaml" if TARGET_RPI4
 
 choice
 	prompt "Xenomai version"
@@ -105,13 +105,13 @@ endchoice
 
 config KAS_INCLUDE_XENOMAI
 	string
-	default "opt-xenomai-next.yml" if XENOMAI_HEAD
-	default "opt-xenomai-3.3.x-head.yml" if XENOMAI_3_3_HEAD
-	default "opt-xenomai-3.3.x.yml" if XENOMAI_3_3
-	default "opt-xenomai-3.2.x-head.yml" if XENOMAI_3_2_HEAD
-	default "opt-xenomai-3.2.x.yml" if XENOMAI_3_2
-	default "opt-xenomai-3.1.x-head.yml" if XENOMAI_3_1_HEAD
-	default "opt-xenomai-3.1.x.yml" if XENOMAI_3_1
+	default "kas/opt/xenomai-next.yaml" if XENOMAI_HEAD
+	default "kas/opt/xenomai-3.3.x-head.yaml" if XENOMAI_3_3_HEAD
+	default "kas/opt/xenomai-3.3.x.yaml" if XENOMAI_3_3
+	default "kas/opt/xenomai-3.2.x-head.yaml" if XENOMAI_3_2_HEAD
+	default "kas/opt/xenomai-3.2.x.yaml" if XENOMAI_3_2
+	default "kas/opt/xenomai-3.1.x-head.yaml" if XENOMAI_3_1_HEAD
+	default "kas/opt/xenomai-3.1.x.yaml" if XENOMAI_3_1
 
 choice
 	prompt "Kernel version"
@@ -173,19 +173,19 @@ endchoice
 
 config KAS_INCLUDE_KERNEL
 	string
-	default "opt-linux-head.yml" if KERNEL_HEAD
-	default "opt-linux-6.12-head.yml" if KERNEL_6_12_HEAD
-	default "opt-linux-6.12.yml" if KERNEL_6_12
-	default "opt-linux-6.1-head.yml" if KERNEL_6_1_HEAD
-	default "opt-linux-6.1.yml" if KERNEL_6_1
-	default "opt-linux-5.15-head.yml" if KERNEL_5_15_HEAD
-	default "opt-linux-5.15.yml" if KERNEL_5_15
-	default "opt-linux-5.10-head.yml" if KERNEL_5_10_HEAD
-	default "opt-linux-5.10.yml" if KERNEL_5_10
-	default "opt-linux-5.4-head.yml" if KERNEL_5_4_HEAD
-	default "opt-linux-5.4.yml" if KERNEL_5_4
-	default "opt-linux-4.19-head.yml" if KERNEL_4_19_HEAD
-	default "opt-linux-4.19.yml" if KERNEL_4_19
+	default "kas/opt/linux-head.yaml" if KERNEL_HEAD
+	default "kas/opt/linux-6.12-head.yaml" if KERNEL_6_12_HEAD
+	default "kas/opt/linux-6.12.yaml" if KERNEL_6_12
+	default "kas/opt/linux-6.1-head.yaml" if KERNEL_6_1_HEAD
+	default "kas/opt/linux-6.1.yaml" if KERNEL_6_1
+	default "kas/opt/linux-5.15-head.yaml" if KERNEL_5_15_HEAD
+	default "kas/opt/linux-5.15.yaml" if KERNEL_5_15
+	default "kas/opt/linux-5.10-head.yaml" if KERNEL_5_10_HEAD
+	default "kas/opt/linux-5.10.yaml" if KERNEL_5_10
+	default "kas/opt/linux-5.4-head.yaml" if KERNEL_5_4_HEAD
+	default "kas/opt/linux-5.4.yaml" if KERNEL_5_4
+	default "kas/opt/linux-4.19-head.yaml" if KERNEL_4_19_HEAD
+	default "kas/opt/linux-4.19.yaml" if KERNEL_4_19
 
 comment "Features"
 
@@ -202,7 +202,7 @@ config DEBUG
 
 config KAS_INCLUDE_DEBUG
 	string
-	default "opt-debug.yml" if DEBUG
+	default "kas/opt/debug.yaml" if DEBUG
 
 config COMPAT
 	bool "Build 32 bit Xenomai userspace"
@@ -210,7 +210,7 @@ config COMPAT
 
 config KAS_INCLUDE_COMPAT
 	string
-	default "opt-compat.yml" if COMPAT
+	default "kas/opt/compat.yaml" if COMPAT
 
 endif	# if XENOMAI3
 
@@ -239,11 +239,11 @@ endchoice
 
 config KAS_INCLUDE_EVL_KERNEL
 	string
-	default "opt-linux-head.yml" if EVL_KERNEL_HEAD
-	default "opt-linux-6.12-head.yml" if EVL_KERNEL_6_12_HEAD
-	default "opt-linux-6.12.yml" if EVL_KERNEL_6_12
-	default "opt-linux-6.1-head.yml" if EVL_KERNEL_6_1_HEAD
-	default "opt-linux-6.1.yml" if EVL_KERNEL_6_1
+	default "kas/opt/linux-head.yaml" if EVL_KERNEL_HEAD
+	default "kas/opt/linux-6.12-head.yaml" if EVL_KERNEL_6_12_HEAD
+	default "kas/opt/linux-6.12.yaml" if EVL_KERNEL_6_12
+	default "kas/opt/linux-6.1-head.yaml" if EVL_KERNEL_6_1_HEAD
+	default "kas/opt/linux-6.1.yaml" if EVL_KERNEL_6_1
 
 choice
 	prompt "libevl version"
@@ -259,7 +259,7 @@ endchoice
 
 config KAS_INCLUDE_LIBEVL
 	string
-	default "opt-libevl-next.yml" if LIBEVL_NEXT
-	default "opt-libevl-latest-release.yml" if LIBEVL_RELEASE
+	default "kas/opt/libevl-next.yaml" if LIBEVL_NEXT
+	default "kas/opt/libevl-latest-release.yaml" if LIBEVL_RELEASE
 
 endif	# if XENOMAI4
diff --git a/README.md b/README.md
index 61cb358..00c0c8b 100644
--- a/README.md
+++ b/README.md
@@ -25,12 +25,13 @@ You can also select the desired image configuration on the command line.  To
 build the QEMU AMD64 target with debug options enabled, invoke kas-container
 like this:
 
-    ./kas-container build kas.yml:board-qemu-amd64.yml:opt-debug.yml
+    ./kas-container build kas.yaml:kas/board/qemu-amd64.yaml:kas/opt/debug.yaml
 
 ### Physical Targets
 
-This repository contains recipes for x86 (`board-x86-64-efi.yml`),
-armhf(`board-beagle-bone-black.yml`) and arm64(`board-hikey.yml`) targets.
+This repository contains recipes for x86 (`kas/board/x86-64-efi.yaml`),
+armhf(`kas/board/beagle-bone-black.yaml`) and arm64(`kas/board/hikey.yaml`)
+targets.
 
 Each physical target will generate ready-to-boot images under
 `build/tmp/deploy/images/`. To flash, e.g., the HiKey image to an SD card, run
diff --git a/ci/compat_jobs.yml b/ci/compat_jobs.yml
index 6f6f1bd..ccbb15b 100644
--- a/ci/compat_jobs.yml
+++ b/ci/compat_jobs.yml
@@ -14,7 +14,7 @@ build-5.15-compat:x86-64-efi:
     - .build:x86-64-efi
     - .compat-vars
   variables:
-    LINUX_BUILD_OPTION: ":opt-linux-5.15-head.yml"
+    LINUX_BUILD_OPTION: ":kas/opt/linux-5.15-head.yaml"
     KERNEL_VERSION: "5.15"
     CACHE_KERNEL: dovetail
 
@@ -33,7 +33,7 @@ build-6.12-compat:rpi4:
   rules:
     - if: '$XENOMAI_VERSION != "3_2_x-compat"'
   variables:
-    LINUX_BUILD_OPTION: ":opt-linux-6.12-head.yml"
+    LINUX_BUILD_OPTION: ":kas/opt/linux-6.12-head.yaml"
     KERNEL_VERSION: "6.12"
     CACHE_KERNEL: dovetail
 
diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
index bf1734f..ac688fc 100644
--- a/ci/gitlab-ci-base.yml
+++ b/ci/gitlab-ci-base.yml
@@ -34,7 +34,7 @@ default:
 
 .sstate-prepare:
   script:
-    - kas checkout kas.yml
+    - kas checkout kas.yaml
     - echo "=== Prepare for sstate at ${SSTATE_LOCATION} ==="
     - ./isar/scripts/isar-sstate clean "${SSTATE_LOCATION}" --max-age "${SSTATE_MAX_AGE}"
     - ./isar/scripts/isar-sstate info -v "${SSTATE_LOCATION}"
@@ -73,8 +73,8 @@ default:
     - !reference [.common-config, script]
     - !reference [.sstate-prepare, script]
   script:
-    - echo "Building kas.yml:board-${TARGET}.yml${XENOMAI_BUILD_OPTION}${LINUX_BUILD_OPTION}${BUILD_OPTIONS}:opt-ci.yml"
-    - kas build kas.yml:board-${TARGET}.yml${XENOMAI_BUILD_OPTION}${LINUX_BUILD_OPTION}${BUILD_OPTIONS}:opt-ci.yml
+    - echo "Building kas.yaml:kas/board/${TARGET}.yaml${XENOMAI_BUILD_OPTION}${LINUX_BUILD_OPTION}${BUILD_OPTIONS}:kas/opt/ci.yaml"
+    - kas build kas.yaml:kas/board/${TARGET}.yaml${XENOMAI_BUILD_OPTION}${LINUX_BUILD_OPTION}${BUILD_OPTIONS}:kas/opt/ci.yaml
     - du -ah -d1 build/downloads
     - if [ -n "${USE_S3_BUCKET}" ]; then scripts/deploy_to_aws.sh ${TARGET}; fi
   after_script:
diff --git a/ci/kernel_4_19.yml b/ci/kernel_4_19.yml
index 08dae50..d0e532f 100644
--- a/ci/kernel_4_19.yml
+++ b/ci/kernel_4_19.yml
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2019 - 2022
+# Copyright (c) Siemens AG, 2019-2025
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -12,7 +12,7 @@
 build-4.19:qemu-amd64:
   extends: .build:qemu-amd64
   variables:
-    LINUX_BUILD_OPTION: ":opt-linux-4.19-head.yml"
+    LINUX_BUILD_OPTION: ":kas/opt/linux-4.19-head.yaml"
     KERNEL_VERSION: "4.19"
     CACHE_KERNEL: ipipe-x86
 
@@ -25,7 +25,7 @@ lava-test-4.19:qemu-amd64:
 build-4.19:qemu-armhf:
   extends: .build:qemu-armhf
   variables:
-    LINUX_BUILD_OPTION: ":opt-linux-4.19-head.yml"
+    LINUX_BUILD_OPTION: ":kas/opt/linux-4.19-head.yaml"
     KERNEL_VERSION: "4.19"
     CACHE_KERNEL: ipipe-arm
 
@@ -38,7 +38,7 @@ lava-test-4.19:qemu-armhf:
 build-4.19:qemu-arm64:
   extends: .build:qemu-arm64
   variables:
-    LINUX_BUILD_OPTION: ":opt-linux-4.19-head.yml"
+    LINUX_BUILD_OPTION: ":kas/opt/linux-4.19-head.yaml"
     KERNEL_VERSION: "4.19"
     CACHE_KERNEL: ipipe-arm64
 
@@ -51,7 +51,7 @@ lava-test-4.19:qemu-arm64:
 build-4.19:hikey:
   extends: .build:hikey
   variables:
-    LINUX_BUILD_OPTION: ":opt-linux-4.19-head.yml"
+    LINUX_BUILD_OPTION: ":kas/opt/linux-4.19-head.yaml"
     KERNEL_VERSION: "4.19"
     CACHE_KERNEL: ipipe-arm64
 
@@ -64,7 +64,7 @@ lava-test-4.19:hikey:
 build-4.19:beagle-bone-black:
   extends: .build:beagle-bone-black
   variables:
-    LINUX_BUILD_OPTION: ":opt-linux-4.19-head.yml"
+    LINUX_BUILD_OPTION: ":kas/opt/linux-4.19-head.yaml"
     KERNEL_VERSION: "4.19"
     CACHE_KERNEL: ipipe-arm
 
@@ -77,7 +77,7 @@ lava-test-4.19:beagle-bone-black:
 build-4.19:x86-64-efi:
   extends: .build:x86-64-efi
   variables:
-    LINUX_BUILD_OPTION: ":opt-linux-4.19-head.yml"
+    LINUX_BUILD_OPTION: ":kas/opt/linux-4.19-head.yaml"
     KERNEL_VERSION: "4.19"
     CACHE_KERNEL: ipipe-x86
 
diff --git a/ci/kernel_5_10.yml b/ci/kernel_5_10.yml
index 509da89..0d44681 100644
--- a/ci/kernel_5_10.yml
+++ b/ci/kernel_5_10.yml
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2019 - 2022
+# Copyright (c) Siemens AG, 2019-2025
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -12,7 +12,7 @@
 build-5.10:qemu-amd64:
   extends: .build:qemu-amd64
   variables:
-    LINUX_BUILD_OPTION: ":opt-linux-5.10-head.yml"
+    LINUX_BUILD_OPTION: ":kas/opt/linux-5.10-head.yaml"
     KERNEL_VERSION: "5.10"
     CACHE_KERNEL: dovetail
 
@@ -25,7 +25,7 @@ lava-test-5.10:qemu-amd64:
 build-5.10:qemu-armhf:
   extends: .build:qemu-armhf
   variables:
-    LINUX_BUILD_OPTION: ":opt-linux-5.10-head.yml"
+    LINUX_BUILD_OPTION: ":kas/opt/linux-5.10-head.yaml"
     KERNEL_VERSION: "5.10"
     CACHE_KERNEL: dovetail
 
@@ -38,7 +38,7 @@ lava-test-5.10:qemu-armhf:
 build-5.10:qemu-arm64:
   extends: .build:qemu-arm64
   variables:
-    LINUX_BUILD_OPTION: ":opt-linux-5.10-head.yml"
+    LINUX_BUILD_OPTION: ":kas/opt/linux-5.10-head.yaml"
     KERNEL_VERSION: "5.10"
     CACHE_KERNEL: dovetail
 
@@ -51,7 +51,7 @@ lava-test-5.10:qemu-arm64:
 build-5.10:hikey:
   extends: .build:hikey
   variables:
-    LINUX_BUILD_OPTION: ":opt-linux-5.10-head.yml"
+    LINUX_BUILD_OPTION: ":kas/opt/linux-5.10-head.yaml"
     KERNEL_VERSION: "5.10"
     CACHE_KERNEL: dovetail
 
@@ -64,7 +64,7 @@ lava-test-5.10:hikey:
 build-5.10:beagle-bone-black:
   extends: .build:beagle-bone-black
   variables:
-    LINUX_BUILD_OPTION: ":opt-linux-5.10-head.yml"
+    LINUX_BUILD_OPTION: ":kas/opt/linux-5.10-head.yaml"
     KERNEL_VERSION: "5.10"
     CACHE_KERNEL: dovetail
 
@@ -77,7 +77,7 @@ lava-test-5.10:beagle-bone-black:
 build-5.10:x86-64-efi:
   extends: .build:x86-64-efi
   variables:
-    LINUX_BUILD_OPTION: ":opt-linux-5.10-head.yml"
+    LINUX_BUILD_OPTION: ":kas/opt/linux-5.10-head.yaml"
     KERNEL_VERSION: "5.10"
     CACHE_KERNEL: dovetail
 
diff --git a/ci/kernel_5_15.yml b/ci/kernel_5_15.yml
index cd0c11c..4f86d10 100644
--- a/ci/kernel_5_15.yml
+++ b/ci/kernel_5_15.yml
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2022
+# Copyright (c) Siemens AG, 2022-2025
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -12,7 +12,7 @@
 build-5.15:qemu-amd64:
   extends: .build:qemu-amd64
   variables:
-    LINUX_BUILD_OPTION: ":opt-linux-5.15-head.yml"
+    LINUX_BUILD_OPTION: ":kas/opt/linux-5.15-head.yaml"
     KERNEL_VERSION: "5.15"
     CACHE_KERNEL: dovetail
 
@@ -25,7 +25,7 @@ lava-test-5.15:qemu-amd64:
 build-5.15:qemu-armhf:
   extends: .build:qemu-armhf
   variables:
-    LINUX_BUILD_OPTION: ":opt-linux-5.15-head.yml"
+    LINUX_BUILD_OPTION: ":kas/opt/linux-5.15-head.yaml"
     KERNEL_VERSION: "5.15"
     CACHE_KERNEL: dovetail
 
@@ -38,7 +38,7 @@ lava-test-5.15:qemu-armhf:
 build-5.15:qemu-arm64:
   extends: .build:qemu-arm64
   variables:
-    LINUX_BUILD_OPTION: ":opt-linux-5.15-head.yml"
+    LINUX_BUILD_OPTION: ":kas/opt/linux-5.15-head.yaml"
     KERNEL_VERSION: "5.15"
     CACHE_KERNEL: dovetail
 
@@ -51,7 +51,7 @@ lava-test-5.15:qemu-arm64:
 build-5.15:hikey:
   extends: .build:hikey
   variables:
-    LINUX_BUILD_OPTION: ":opt-linux-5.15-head.yml"
+    LINUX_BUILD_OPTION: ":kas/opt/linux-5.15-head.yaml"
     KERNEL_VERSION: "5.15"
     CACHE_KERNEL: dovetail
 
@@ -64,7 +64,7 @@ lava-test-5.15:hikey:
 build-5.15:beagle-bone-black:
   extends: .build:beagle-bone-black
   variables:
-    LINUX_BUILD_OPTION: ":opt-linux-5.15-head.yml"
+    LINUX_BUILD_OPTION: ":kas/opt/linux-5.15-head.yaml"
     KERNEL_VERSION: "5.15"
     CACHE_KERNEL: dovetail
 
@@ -77,7 +77,7 @@ lava-test-5.15:beagle-bone-black:
 build-5.15:x86-64-efi:
   extends: .build:x86-64-efi
   variables:
-    LINUX_BUILD_OPTION: ":opt-linux-5.15-head.yml"
+    LINUX_BUILD_OPTION: ":kas/opt/linux-5.15-head.yaml"
     KERNEL_VERSION: "5.15"
     CACHE_KERNEL: dovetail
 
diff --git a/ci/kernel_5_4.yml b/ci/kernel_5_4.yml
index 3a81be3..5f63aea 100644
--- a/ci/kernel_5_4.yml
+++ b/ci/kernel_5_4.yml
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2019 - 2022
+# Copyright (c) Siemens AG, 2019-2025
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -12,7 +12,7 @@
 build-5.4:qemu-amd64:
   extends: .build:qemu-amd64
   variables:
-    LINUX_BUILD_OPTION: ":opt-linux-5.4-head.yml"
+    LINUX_BUILD_OPTION: ":kas/opt/linux-5.4-head.yaml"
     KERNEL_VERSION: "5.4"
     CACHE_KERNEL: ipipe-x86
 
@@ -25,7 +25,7 @@ lava-test-5.4:qemu-amd64:
 build-5.4:qemu-armhf:
   extends: .build:qemu-armhf
   variables:
-    LINUX_BUILD_OPTION: ":opt-linux-5.4-head.yml"
+    LINUX_BUILD_OPTION: ":kas/opt/linux-5.4-head.yaml"
     KERNEL_VERSION: "5.4"
     CACHE_KERNEL: ipipe-arm
 
@@ -38,7 +38,7 @@ lava-test-5.4:qemu-armhf:
 build-5.4:qemu-arm64:
   extends: .build:qemu-arm64
   variables:
-    LINUX_BUILD_OPTION: ":opt-linux-5.4-head.yml"
+    LINUX_BUILD_OPTION: ":kas/opt/linux-5.4-head.yaml"
     KERNEL_VERSION: "5.4"
     CACHE_KERNEL: ipipe-arm64
 
@@ -51,7 +51,7 @@ lava-test-5.4:qemu-arm64:
 build-5.4:hikey:
   extends: .build:hikey
   variables:
-    LINUX_BUILD_OPTION: ":opt-linux-5.4-head.yml"
+    LINUX_BUILD_OPTION: ":kas/opt/linux-5.4-head.yaml"
     KERNEL_VERSION: "5.4"
     CACHE_KERNEL: ipipe-arm64
 
@@ -64,7 +64,7 @@ lava-test-5.4:hikey:
 build-5.4:beagle-bone-black:
   extends: .build:beagle-bone-black
   variables:
-    LINUX_BUILD_OPTION: ":opt-linux-5.4-head.yml"
+    LINUX_BUILD_OPTION: ":kas/opt/linux-5.4-head.yaml"
     KERNEL_VERSION: "5.4"
     CACHE_KERNEL: ipipe-arm
 
@@ -77,7 +77,7 @@ lava-test-5.4:beagle-bone-black:
 build-5.4:x86-64-efi:
   extends: .build:x86-64-efi
   variables:
-    LINUX_BUILD_OPTION: ":opt-linux-5.4-head.yml"
+    LINUX_BUILD_OPTION: ":kas/opt/linux-5.4-head.yaml"
     KERNEL_VERSION: "5.4"
     CACHE_KERNEL: ipipe-x86
 
diff --git a/ci/kernel_6_1.yml b/ci/kernel_6_1.yml
index c32318d..5d9ca64 100644
--- a/ci/kernel_6_1.yml
+++ b/ci/kernel_6_1.yml
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2022-2023
+# Copyright (c) Siemens AG, 2022-2025
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -12,7 +12,7 @@
 build-6.1:qemu-amd64:
   extends: .build:qemu-amd64
   variables:
-    LINUX_BUILD_OPTION: ":opt-linux-6.1-head.yml"
+    LINUX_BUILD_OPTION: ":kas/opt/linux-6.1-head.yaml"
     KERNEL_VERSION: "6.1"
     CACHE_KERNEL: dovetail
 
@@ -25,7 +25,7 @@ lava-test-6.1:qemu-amd64:
 build-6.1:qemu-armhf:
   extends: .build:qemu-armhf
   variables:
-    LINUX_BUILD_OPTION: ":opt-linux-6.1-head.yml"
+    LINUX_BUILD_OPTION: ":kas/opt/linux-6.1-head.yaml"
     KERNEL_VERSION: "6.1"
     CACHE_KERNEL: dovetail
 
@@ -38,7 +38,7 @@ lava-test-6.1:qemu-armhf:
 build-6.1:qemu-arm64:
   extends: .build:qemu-arm64
   variables:
-    LINUX_BUILD_OPTION: ":opt-linux-6.1-head.yml"
+    LINUX_BUILD_OPTION: ":kas/opt/linux-6.1-head.yaml"
     KERNEL_VERSION: "6.1"
     CACHE_KERNEL: dovetail
 
@@ -51,7 +51,7 @@ lava-test-6.1:qemu-arm64:
 build-6.1:hikey:
   extends: .build:hikey
   variables:
-    LINUX_BUILD_OPTION: ":opt-linux-6.1-head.yml"
+    LINUX_BUILD_OPTION: ":kas/opt/linux-6.1-head.yaml"
     KERNEL_VERSION: "6.1"
     CACHE_KERNEL: dovetail
 
@@ -64,7 +64,7 @@ lava-test-6.1:hikey:
 build-6.1:beagle-bone-black:
   extends: .build:beagle-bone-black
   variables:
-    LINUX_BUILD_OPTION: ":opt-linux-6.1-head.yml"
+    LINUX_BUILD_OPTION: ":kas/opt/linux-6.1-head.yaml"
     KERNEL_VERSION: "6.1"
     CACHE_KERNEL: dovetail
 
@@ -77,7 +77,7 @@ lava-test-6.1:beagle-bone-black:
 build-6.1:x86-64-efi:
   extends: .build:x86-64-efi
   variables:
-    LINUX_BUILD_OPTION: ":opt-linux-6.1-head.yml"
+    LINUX_BUILD_OPTION: ":kas/opt/linux-6.1-head.yaml"
     KERNEL_VERSION: "6.1"
     CACHE_KERNEL: dovetail
 
diff --git a/ci/kernel_6_12.yml b/ci/kernel_6_12.yml
index c2ddf25..9048461 100644
--- a/ci/kernel_6_12.yml
+++ b/ci/kernel_6_12.yml
@@ -15,7 +15,7 @@ include:
 build-6.12:qemu-amd64:
   extends: .build:qemu-amd64
   variables:
-    LINUX_BUILD_OPTION: ":opt-linux-6.12-head.yml"
+    LINUX_BUILD_OPTION: ":kas/opt/linux-6.12-head.yaml"
     KERNEL_VERSION: "6.12"
     CACHE_KERNEL: dovetail
 
@@ -28,7 +28,7 @@ lava-test-6.12:qemu-amd64:
 build-6.12:qemu-armhf:
   extends: .build:qemu-armhf
   variables:
-    LINUX_BUILD_OPTION: ":opt-linux-6.12-head.yml"
+    LINUX_BUILD_OPTION: ":kas/opt/linux-6.12-head.yaml"
     KERNEL_VERSION: "6.12"
     CACHE_KERNEL: dovetail
 
@@ -41,7 +41,7 @@ lava-test-6.12:qemu-armhf:
 build-6.12:qemu-arm64:
   extends: .build:qemu-arm64
   variables:
-    LINUX_BUILD_OPTION: ":opt-linux-6.12-head.yml"
+    LINUX_BUILD_OPTION: ":kas/opt/linux-6.12-head.yaml"
     KERNEL_VERSION: "6.12"
     CACHE_KERNEL: dovetail
 
diff --git a/ci/kernel_6_12_physical.yml b/ci/kernel_6_12_physical.yml
index 2d9103d..86cd23c 100644
--- a/ci/kernel_6_12_physical.yml
+++ b/ci/kernel_6_12_physical.yml
@@ -12,7 +12,7 @@
 build-6.12:rpi4:
   extends: .build:rpi4
   variables:
-    LINUX_BUILD_OPTION: ":opt-linux-6.12-head.yml"
+    LINUX_BUILD_OPTION: ":kas/opt/linux-6.12-head.yaml"
     KERNEL_VERSION: "6.12"
     CACHE_KERNEL: dovetail
 
@@ -26,7 +26,7 @@ lava-test-6.12:rpi4:
 build-6.12:beagle-bone-black:
   extends: .build:beagle-bone-black
   variables:
-    LINUX_BUILD_OPTION: ":opt-linux-6.12-head.yml"
+    LINUX_BUILD_OPTION: ":kas/opt/linux-6.12-head.yaml"
     KERNEL_VERSION: "6.12"
     CACHE_KERNEL: dovetail
 
@@ -40,7 +40,7 @@ lava-test-6.12:beagle-bone-black:
 build-6.12:x86-64-efi:
   extends: .build:x86-64-efi
   variables:
-    LINUX_BUILD_OPTION: ":opt-linux-6.12-head.yml"
+    LINUX_BUILD_OPTION: ":kas/opt/linux-6.12-head.yaml"
     KERNEL_VERSION: "6.12"
     CACHE_KERNEL: dovetail
 
diff --git a/ci/xenomai_3_1_x.yml b/ci/xenomai_3_1_x.yml
index 76773ed..c5b8c70 100644
--- a/ci/xenomai_3_1_x.yml
+++ b/ci/xenomai_3_1_x.yml
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2020-2022
+# Copyright (c) Siemens AG, 2020-2025
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -14,5 +14,5 @@ include:
   - local: '/ci/kernel_4_19.yml'
 
 variables:
-  XENOMAI_BUILD_OPTION: ":opt-xenomai-3.1.x-head.yml:opt-debug.yml"
+  XENOMAI_BUILD_OPTION: ":kas/opt/xenomai-3.1.x-head.yaml:kas/opt/debug.yaml"
   XENOMAI_VERSION: "3.1.x"
diff --git a/ci/xenomai_3_2_x.yml b/ci/xenomai_3_2_x.yml
index 0ba0b17..97f754e 100644
--- a/ci/xenomai_3_2_x.yml
+++ b/ci/xenomai_3_2_x.yml
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2019 - 2023
+# Copyright (c) Siemens AG, 2019-2025
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -19,5 +19,5 @@ include:
   - local: '/ci/xenomai_3_2_x_compat.yml'
 
 variables:
-  XENOMAI_BUILD_OPTION: ":opt-xenomai-3.2.x-head.yml:opt-debug.yml"
+  XENOMAI_BUILD_OPTION: ":kas/opt/xenomai-3.2.x-head.yaml:kas/opt/debug.yaml"
   XENOMAI_VERSION: "3.2.x"
diff --git a/ci/xenomai_3_2_x_compat.yml b/ci/xenomai_3_2_x_compat.yml
index 5584f05..9465cb1 100644
--- a/ci/xenomai_3_2_x_compat.yml
+++ b/ci/xenomai_3_2_x_compat.yml
@@ -11,7 +11,7 @@
 
 .compat-vars:
   variables:
-    XENOMAI_BUILD_OPTION: ":opt-xenomai-3.2.x-head.yml:opt-debug.yml:opt-compat.yml"
+    XENOMAI_BUILD_OPTION: ":kas/opt/xenomai-3.2.x-head.yaml:kas/opt/debug.yaml:kas/opt/compat.yaml"
     XENOMAI_VERSION: "3_2_x-compat"
 
 include:
diff --git a/ci/xenomai_3_3_x.yml b/ci/xenomai_3_3_x.yml
index 3261be0..6e43add 100644
--- a/ci/xenomai_3_3_x.yml
+++ b/ci/xenomai_3_3_x.yml
@@ -18,6 +18,6 @@ include:
   - local: '/ci/xenomai_3_3_x_compat.yml'
 
 variables:
-  XENOMAI_BUILD_OPTION: ":opt-xenomai-3.3.x-head.yml:opt-debug.yml"
+  XENOMAI_BUILD_OPTION: ":kas/opt/xenomai-3.3.x-head.yaml:kas/opt/debug.yaml"
   XENOMAI_VERSION: "3.3.x"
   LATEST_KERNEL_VERSION: "6.12"
diff --git a/ci/xenomai_3_3_x_compat.yml b/ci/xenomai_3_3_x_compat.yml
index 504872d..3c55681 100644
--- a/ci/xenomai_3_3_x_compat.yml
+++ b/ci/xenomai_3_3_x_compat.yml
@@ -11,7 +11,7 @@
 
 .compat-vars:
   variables:
-    XENOMAI_BUILD_OPTION: ":opt-xenomai-3.3.x-head.yml:opt-debug.yml:opt-compat.yml"
+    XENOMAI_BUILD_OPTION: ":kas/opt/xenomai-3.3.x-head.yaml:kas/opt/debug.yaml:kas/opt/compat.yaml"
     XENOMAI_VERSION: "3_3_x-compat"
 
 include:
diff --git a/ci/xenomai_3_next.yml b/ci/xenomai_3_next.yml
index d05596f..9c984ba 100644
--- a/ci/xenomai_3_next.yml
+++ b/ci/xenomai_3_next.yml
@@ -18,6 +18,6 @@ include:
   - local: '/ci/xenomai_3_next_compat.yml'
 
 variables:
-  XENOMAI_BUILD_OPTION: ":opt-xenomai-next.yml:opt-debug.yml"
+  XENOMAI_BUILD_OPTION: ":kas/opt/xenomai-next.yaml:kas/opt/debug.yaml"
   XENOMAI_VERSION: "next"
   LATEST_KERNEL_VERSION: "6.12"
diff --git a/ci/xenomai_3_next_compat.yml b/ci/xenomai_3_next_compat.yml
index d40fbfc..ecd888d 100644
--- a/ci/xenomai_3_next_compat.yml
+++ b/ci/xenomai_3_next_compat.yml
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
-    XENOMAI_BUILD_OPTION: ":opt-xenomai-next.yml:opt-debug.yml:opt-compat.yml"
+    XENOMAI_BUILD_OPTION: ":kas/opt/xenomai-next.yaml:kas/opt/debug.yaml:kas/opt/compat.yaml"
     XENOMAI_VERSION: "next-compat"
 
 include:
diff --git a/ci/xenomai_3_next_long_term.yml b/ci/xenomai_3_next_long_term.yml
index 93c0e2f..e62fc71 100644
--- a/ci/xenomai_3_next_long_term.yml
+++ b/ci/xenomai_3_next_long_term.yml
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2024
+# Copyright (c) Siemens AG, 2024-2025
 #
 # Authors:
 #  Tobias Schaffner <tobias.schaffner@siemens.com>
@@ -14,7 +14,7 @@ include:
   - local: '/ci/kernel_6_12_physical.yml'
 
 variables:
-  XENOMAI_BUILD_OPTION: ":opt-xenomai-next.yml"
+  XENOMAI_BUILD_OPTION: ":kas/opt/xenomai-next.yaml"
   XENOMAI_VERSION: "next"
   LATEST_KERNEL_VERSION: "6.12"
   TEST_RUNTIME_SECONDS: 3600
diff --git a/ci/xenomai_4_next.yml b/ci/xenomai_4_next.yml
index 36ea986..78edc77 100644
--- a/ci/xenomai_4_next.yml
+++ b/ci/xenomai_4_next.yml
@@ -15,7 +15,7 @@ include:
   - local: '/ci/kernel_6_12.yml'
 
 variables:
-  XENOMAI_BUILD_OPTION: ":opt-libevl-next.yml:opt-debug.yml"
+  XENOMAI_BUILD_OPTION: ":kas/opt/libevl-next.yaml:kas/opt/debug.yaml"
   XENOMAI_VERSION: "next"
   LATEST_KERNEL_VERSION: "6.12"
   BUILD_IDENTIFIER: "evl-${XENOMAI_VERSION}_kernel-${KERNEL_VERSION}"
diff --git a/kas.yml b/kas.yaml
similarity index 100%
rename from kas.yml
rename to kas.yaml
diff --git a/board-beagle-bone-black.yml b/kas/board/beagle-bone-black.yaml
similarity index 100%
rename from board-beagle-bone-black.yml
rename to kas/board/beagle-bone-black.yaml
diff --git a/board-hikey.yml b/kas/board/hikey.yaml
similarity index 100%
rename from board-hikey.yml
rename to kas/board/hikey.yaml
diff --git a/board-qemu-amd64.yml b/kas/board/qemu-amd64.yaml
similarity index 100%
rename from board-qemu-amd64.yml
rename to kas/board/qemu-amd64.yaml
diff --git a/board-qemu-arm64.yml b/kas/board/qemu-arm64.yaml
similarity index 100%
rename from board-qemu-arm64.yml
rename to kas/board/qemu-arm64.yaml
diff --git a/board-qemu-armhf.yml b/kas/board/qemu-armhf.yaml
similarity index 100%
rename from board-qemu-armhf.yml
rename to kas/board/qemu-armhf.yaml
diff --git a/board-rpi4.yml b/kas/board/rpi4.yaml
similarity index 100%
rename from board-rpi4.yml
rename to kas/board/rpi4.yaml
diff --git a/board-x86-64-efi.yml b/kas/board/x86-64-efi.yaml
similarity index 100%
rename from board-x86-64-efi.yml
rename to kas/board/x86-64-efi.yaml
diff --git a/opt-ci.yml b/kas/opt/ci.yaml
similarity index 100%
rename from opt-ci.yml
rename to kas/opt/ci.yaml
diff --git a/opt-compat.yml b/kas/opt/compat.yaml
similarity index 100%
rename from opt-compat.yml
rename to kas/opt/compat.yaml
diff --git a/opt-debug.yml b/kas/opt/debug.yaml
similarity index 100%
rename from opt-debug.yml
rename to kas/opt/debug.yaml
diff --git a/opt-evl.yml b/kas/opt/evl.yaml
similarity index 100%
rename from opt-evl.yml
rename to kas/opt/evl.yaml
diff --git a/opt-libevl-latest-release.yml b/kas/opt/libevl-latest-release.yaml
similarity index 79%
rename from opt-libevl-latest-release.yml
rename to kas/opt/libevl-latest-release.yaml
index 7468b67..f0635a4 100644
--- a/opt-libevl-latest-release.yml
+++ b/kas/opt/libevl-latest-release.yaml
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2023-2024
+# Copyright (c) Siemens AG, 2023-2025
 #
 # Authors:
 #  Clara Kowalsky <clara.kowalsky@siemens.com>
@@ -12,7 +12,7 @@
 header:
   version: 14
   includes:
-    - opt-evl.yml
+    - kas/opt/evl.yaml
 
 local_conf_header:
   libevl-version: |
diff --git a/opt-libevl-next.yml b/kas/opt/libevl-next.yaml
similarity index 79%
rename from opt-libevl-next.yml
rename to kas/opt/libevl-next.yaml
index aa83d1f..b9c858e 100644
--- a/opt-libevl-next.yml
+++ b/kas/opt/libevl-next.yaml
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2023-2024
+# Copyright (c) Siemens AG, 2023-2025
 #
 # Authors:
 #  Clara Kowalsky <clara.kowalsky@siemens.com>
@@ -12,7 +12,7 @@
 header:
   version: 14
   includes:
-    - opt-evl.yml
+    - kas/opt/evl.yaml
 
 local_conf_header:
   libevl-version: |
diff --git a/opt-linux-4.19-head.yml b/kas/opt/linux-4.19-head.yaml
similarity index 100%
rename from opt-linux-4.19-head.yml
rename to kas/opt/linux-4.19-head.yaml
diff --git a/opt-linux-4.19.yml b/kas/opt/linux-4.19.yaml
similarity index 100%
rename from opt-linux-4.19.yml
rename to kas/opt/linux-4.19.yaml
diff --git a/opt-linux-5.10-head.yml b/kas/opt/linux-5.10-head.yaml
similarity index 100%
rename from opt-linux-5.10-head.yml
rename to kas/opt/linux-5.10-head.yaml
diff --git a/opt-linux-5.10.yml b/kas/opt/linux-5.10.yaml
similarity index 100%
rename from opt-linux-5.10.yml
rename to kas/opt/linux-5.10.yaml
diff --git a/opt-linux-5.15-head.yml b/kas/opt/linux-5.15-head.yaml
similarity index 100%
rename from opt-linux-5.15-head.yml
rename to kas/opt/linux-5.15-head.yaml
diff --git a/opt-linux-5.15.yml b/kas/opt/linux-5.15.yaml
similarity index 100%
rename from opt-linux-5.15.yml
rename to kas/opt/linux-5.15.yaml
diff --git a/opt-linux-5.4-head.yml b/kas/opt/linux-5.4-head.yaml
similarity index 100%
rename from opt-linux-5.4-head.yml
rename to kas/opt/linux-5.4-head.yaml
diff --git a/opt-linux-5.4.yml b/kas/opt/linux-5.4.yaml
similarity index 100%
rename from opt-linux-5.4.yml
rename to kas/opt/linux-5.4.yaml
diff --git a/opt-linux-6.1-head.yml b/kas/opt/linux-6.1-head.yaml
similarity index 100%
rename from opt-linux-6.1-head.yml
rename to kas/opt/linux-6.1-head.yaml
diff --git a/opt-linux-6.1.yml b/kas/opt/linux-6.1.yaml
similarity index 100%
rename from opt-linux-6.1.yml
rename to kas/opt/linux-6.1.yaml
diff --git a/opt-linux-6.12-head.yml b/kas/opt/linux-6.12-head.yaml
similarity index 100%
rename from opt-linux-6.12-head.yml
rename to kas/opt/linux-6.12-head.yaml
diff --git a/opt-linux-6.12.yml b/kas/opt/linux-6.12.yaml
similarity index 100%
rename from opt-linux-6.12.yml
rename to kas/opt/linux-6.12.yaml
diff --git a/opt-linux-head.yml b/kas/opt/linux-head.yaml
similarity index 100%
rename from opt-linux-head.yml
rename to kas/opt/linux-head.yaml
diff --git a/opt-xenomai-3.1.x-head.yml b/kas/opt/xenomai-3.1.x-head.yaml
similarity index 100%
rename from opt-xenomai-3.1.x-head.yml
rename to kas/opt/xenomai-3.1.x-head.yaml
diff --git a/opt-xenomai-3.1.x.yml b/kas/opt/xenomai-3.1.x.yaml
similarity index 100%
rename from opt-xenomai-3.1.x.yml
rename to kas/opt/xenomai-3.1.x.yaml
diff --git a/opt-xenomai-3.2.x-head.yml b/kas/opt/xenomai-3.2.x-head.yaml
similarity index 100%
rename from opt-xenomai-3.2.x-head.yml
rename to kas/opt/xenomai-3.2.x-head.yaml
diff --git a/opt-xenomai-3.2.x.yml b/kas/opt/xenomai-3.2.x.yaml
similarity index 100%
rename from opt-xenomai-3.2.x.yml
rename to kas/opt/xenomai-3.2.x.yaml
diff --git a/opt-xenomai-3.3.x-head.yml b/kas/opt/xenomai-3.3.x-head.yaml
similarity index 100%
rename from opt-xenomai-3.3.x-head.yml
rename to kas/opt/xenomai-3.3.x-head.yaml
diff --git a/opt-xenomai-3.3.x.yml b/kas/opt/xenomai-3.3.x.yaml
similarity index 100%
rename from opt-xenomai-3.3.x.yml
rename to kas/opt/xenomai-3.3.x.yaml
diff --git a/opt-xenomai-next.yml b/kas/opt/xenomai-next.yaml
similarity index 100%
rename from opt-xenomai-next.yml
rename to kas/opt/xenomai-next.yaml
-- 
2.51.0

