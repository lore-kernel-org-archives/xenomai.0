Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D4C1E5B60
	for <xenomai@lists.linux.dev>; Fri, 19 Dec 2025 16:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766163127; cv=none; b=UNDzXCc3qOGK44BzBMF9nEUxpDY+kMbGPDZqL6qZYc1E96lX8HsoBclW2MAaghcMlmYgZg6DaHWBYjFTFhw1HEt3P17kZKeS2oh16cA0QXnngniLBOjwb56O7sJtqdfya8Igln+R8tZq0ECCv/KhQHF3Weogi3oTRE/ExRJKg7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766163127; c=relaxed/simple;
	bh=GeFTVLpqCqpvb9GEN71Up7CL2iFSPTn4paBDpdxJ8Qo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hq+xwvYK+K8m0wg9G2uQ3V7gSc5FWv5kFhUhawrWIkermipdUQEs+FQNKGIrSXtKvo1DwoFsscgg67LoIcbPGNhSk/AAWLT2C6HsOar/gB/i+Uj3cUVAfRbdLjig35FIZK1455Vc6DtcKtLJ7f4IFCU9H5RcHL++aA9Se/n2ZUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=i6foOPJe; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="i6foOPJe"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20251219165155f84c24dd7000020733
        for <xenomai@lists.linux.dev>;
        Fri, 19 Dec 2025 17:51:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=n3e8CgjLJn1SORIKMd2QDzSY+jqC0ps3OMJFCsssIVg=;
 b=i6foOPJe2tjtY9TOWSj/4n4k+KOPPYZ1/OWh/bWcA+Djul3H+bkM5NIRTtiFX0fU1Zwyb9
 KHk4HQEIDP5GCYTwVAydO5bjFc06F/qdpjcsmFVQOGxsC5UPRI9se6jMQBz+pvNEHns4HxmV
 ZcZ8eHwDsgO5uLYyxG3ZuvKZv0reqerHE8ZHzjR4WRWejNO1ul/AxogY/o5Mbq6UjCEgdzNi
 aMDqkgxAQ/4UmV4OhMnpWbOpPnY8UJxdirMQEphpJbc3DiC2dCmfVFUAT4C706rWmKH7k4ij
 g+jsxXclu7w1CbIklsnpxNxoplJjrFlfvH6ATDCEfqazxbIJEffa2w3A==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH 1/5] Drop ipipe-5.4 kernel
Date: Fri, 19 Dec 2025 17:51:50 +0100
Message-ID: <f69fad2414de482da98f6c782cf6645c54938a6f.1766163114.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1766163114.git.jan.kiszka@siemens.com>
References: <cover.1766163114.git.jan.kiszka@siemens.com>
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

This one is now retired with Linux stable having stopped its maintenance
as well.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 Kconfig                                       | 10 ---
 ci/kernel_5_4.yml                             | 88 -------------------
 ci/xenomai_3_2_x.yml                          |  1 -
 conf/distro/include/xenomai-version.inc       |  2 +-
 kas/opt/linux-5.4-head.yaml                   | 18 ----
 kas/opt/linux-5.4.yaml                        | 17 ----
 recipes-kernel/linux/linux-xenomai-3_5.4.bb   | 23 -----
 .../linux/linux-xenomai-3_latest.bb           |  9 +-
 8 files changed, 4 insertions(+), 164 deletions(-)
 delete mode 100644 ci/kernel_5_4.yml
 delete mode 100644 kas/opt/linux-5.4-head.yaml
 delete mode 100644 kas/opt/linux-5.4.yaml
 delete mode 100644 recipes-kernel/linux/linux-xenomai-3_5.4.bb

diff --git a/Kconfig b/Kconfig
index a3e3885..56b1ebe 100644
--- a/Kconfig
+++ b/Kconfig
@@ -153,14 +153,6 @@ config KERNEL_5_10
 	bool "Latest 5.10 Dovetail release"
 	depends on XENOMAI_HEAD || XENOMAI_3_3_HEAD || XENOMAI_3_3 || XENOMAI_3_2_HEAD || XENOMAI_3_2
 
-config KERNEL_5_4_HEAD
-	bool "Head of 5.4 I-pipe branch"
-	depends on !TARGET_RPI4 && (XENOMAI_3_2_HEAD || XENOMAI_3_2 || XENOMAI_3_1_HEAD || XENOMAI_3_1)
-
-config KERNEL_5_4
-	bool "Latest 5.4 I-pipe release"
-	depends on !TARGET_RPI4 && (XENOMAI_3_2_HEAD || XENOMAI_3_2 || XENOMAI_3_1_HEAD || XENOMAI_3_1)
-
 config KERNEL_4_19_HEAD
 	bool "Head of 4.19-cip I-pipe branch"
 	depends on !TARGET_RPI4 && (XENOMAI_3_2_HEAD || XENOMAI_3_2 || XENOMAI_3_1_HEAD || XENOMAI_3_1)
@@ -182,8 +174,6 @@ config KAS_INCLUDE_KERNEL
 	default "kas/opt/linux-5.15.yaml" if KERNEL_5_15
 	default "kas/opt/linux-5.10-head.yaml" if KERNEL_5_10_HEAD
 	default "kas/opt/linux-5.10.yaml" if KERNEL_5_10
-	default "kas/opt/linux-5.4-head.yaml" if KERNEL_5_4_HEAD
-	default "kas/opt/linux-5.4.yaml" if KERNEL_5_4
 	default "kas/opt/linux-4.19-head.yaml" if KERNEL_4_19_HEAD
 	default "kas/opt/linux-4.19.yaml" if KERNEL_4_19
 
diff --git a/ci/kernel_5_4.yml b/ci/kernel_5_4.yml
deleted file mode 100644
index 5f63aea..0000000
--- a/ci/kernel_5_4.yml
+++ /dev/null
@@ -1,88 +0,0 @@
-#
-# Xenomai Real-Time System
-#
-# Copyright (c) Siemens AG, 2019-2025
-#
-# Authors:
-#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
-#
-# SPDX-License-Identifier: MIT
-#
-
-build-5.4:qemu-amd64:
-  extends: .build:qemu-amd64
-  variables:
-    LINUX_BUILD_OPTION: ":kas/opt/linux-5.4-head.yaml"
-    KERNEL_VERSION: "5.4"
-    CACHE_KERNEL: ipipe-x86
-
-lava-test-5.4:qemu-amd64:
-  needs: [ "build-5.4:qemu-amd64" ]
-  extends: .lava-test:qemu-amd64
-  variables:
-    KERNEL_VERSION: "5.4"
-
-build-5.4:qemu-armhf:
-  extends: .build:qemu-armhf
-  variables:
-    LINUX_BUILD_OPTION: ":kas/opt/linux-5.4-head.yaml"
-    KERNEL_VERSION: "5.4"
-    CACHE_KERNEL: ipipe-arm
-
-lava-test-5.4:qemu-armhf:
-  needs: [ "build-5.4:qemu-armhf" ]
-  extends: .lava-test:qemu-armhf
-  variables:
-    KERNEL_VERSION: "5.4"
-
-build-5.4:qemu-arm64:
-  extends: .build:qemu-arm64
-  variables:
-    LINUX_BUILD_OPTION: ":kas/opt/linux-5.4-head.yaml"
-    KERNEL_VERSION: "5.4"
-    CACHE_KERNEL: ipipe-arm64
-
-lava-test-5.4:qemu-arm64:
-  needs: [ "build-5.4:qemu-arm64" ]
-  extends: .lava-test:qemu-arm64
-  variables:
-    KERNEL_VERSION: "5.4"
-
-build-5.4:hikey:
-  extends: .build:hikey
-  variables:
-    LINUX_BUILD_OPTION: ":kas/opt/linux-5.4-head.yaml"
-    KERNEL_VERSION: "5.4"
-    CACHE_KERNEL: ipipe-arm64
-
-lava-test-5.4:hikey:
-  needs: [ "build-5.4:hikey" ]
-  extends: .lava-test:hikey
-  variables:
-    KERNEL_VERSION: "5.4"
-
-build-5.4:beagle-bone-black:
-  extends: .build:beagle-bone-black
-  variables:
-    LINUX_BUILD_OPTION: ":kas/opt/linux-5.4-head.yaml"
-    KERNEL_VERSION: "5.4"
-    CACHE_KERNEL: ipipe-arm
-
-lava-test-5.4:beagle-bone-black:
-  needs: [ "build-5.4:beagle-bone-black" ]
-  extends: .lava-test:beagle-bone-black
-  variables:
-    KERNEL_VERSION: "5.4"
-
-build-5.4:x86-64-efi:
-  extends: .build:x86-64-efi
-  variables:
-    LINUX_BUILD_OPTION: ":kas/opt/linux-5.4-head.yaml"
-    KERNEL_VERSION: "5.4"
-    CACHE_KERNEL: ipipe-x86
-
-lava-test-5.4:x86-64-efi:
-  needs: [ "build-5.4:x86-64-efi" ]
-  extends: .lava-test:x86-64-efi
-  variables:
-    KERNEL_VERSION: "5.4"
diff --git a/ci/xenomai_3_2_x.yml b/ci/xenomai_3_2_x.yml
index 97f754e..4e8ab0d 100644
--- a/ci/xenomai_3_2_x.yml
+++ b/ci/xenomai_3_2_x.yml
@@ -12,7 +12,6 @@
 include:
   - local: '/ci/gitlab-ci-base.yml'
   - local: '/ci/kernel_4_19.yml'
-  - local: '/ci/kernel_5_4.yml'
   - local: '/ci/kernel_5_10.yml'
   - local: '/ci/kernel_5_15.yml'
   - local: '/ci/kernel_6_1.yml'
diff --git a/conf/distro/include/xenomai-version.inc b/conf/distro/include/xenomai-version.inc
index c64101e..6053e4e 100644
--- a/conf/distro/include/xenomai-version.inc
+++ b/conf/distro/include/xenomai-version.inc
@@ -12,7 +12,7 @@
 XENOMAI_DEFAULT_KERNEL_VERSION = "6.12%"
 
 XENOMAI_3_1_VERSION_LIST = "3.1 3.1% 3.1.% 3.1.5 stable-3.1.x"
-XENOMAI_3_1_KERNEL_VERSION = "5.4%"
+XENOMAI_3_1_KERNEL_VERSION = "4.19%"
 
 XENOMAI_3_2_VERSION_LIST = "3.2 3.2% 3.2.% 3.2.6 stable-3.2.x"
 XENOMAI_3_2_KERNEL_VERSION = "6.1%"
diff --git a/kas/opt/linux-5.4-head.yaml b/kas/opt/linux-5.4-head.yaml
deleted file mode 100644
index e1a20e1..0000000
--- a/kas/opt/linux-5.4-head.yaml
+++ /dev/null
@@ -1,18 +0,0 @@
-#
-# Xenomai Real-Time System
-#
-# Copyright (c) Siemens AG, 2019
-#
-# Authors:
-#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
-#
-# SPDX-License-Identifier: MIT
-#
-
-header:
-  version: 14
-
-local_conf_header:
-  linux-xenomai-version: |
-    PREFERRED_VERSION_linux-xenomai-3 = "9999-%"
-    LATEST_GIT_BRANCH = "5.4"
diff --git a/kas/opt/linux-5.4.yaml b/kas/opt/linux-5.4.yaml
deleted file mode 100644
index 4e0ee0a..0000000
--- a/kas/opt/linux-5.4.yaml
+++ /dev/null
@@ -1,17 +0,0 @@
-#
-# Xenomai Real-Time System
-#
-# Copyright (c) Siemens AG, 2021
-#
-# Authors:
-#  Jan Kiszka <jan.kiszka@siemens.com>
-#
-# SPDX-License-Identifier: MIT
-#
-
-header:
-  version: 14
-
-local_conf_header:
-  linux-xenomai-version: |
-    PREFERRED_VERSION_linux-xenomai-3 = "5.4%"
diff --git a/recipes-kernel/linux/linux-xenomai-3_5.4.bb b/recipes-kernel/linux/linux-xenomai-3_5.4.bb
deleted file mode 100644
index 7a4738d..0000000
--- a/recipes-kernel/linux/linux-xenomai-3_5.4.bb
+++ /dev/null
@@ -1,23 +0,0 @@
-#
-# Xenomai Real-Time System
-#
-# Copyright (c) Siemens AG, 2021-2025
-#
-# Authors:
-#  Jan Kiszka <jan.kiszka@siemens.com>
-#
-# SPDX-License-Identifier: MIT
-#
-
-require recipes-kernel/linux/linux-xenomai-3.inc
-
-SRC_URI:append:amd64 = " git://gitlab.com/Xenomai/legacy/ipipe-x86.git;protocol=https;nobranch=1"
-SRCREV:amd64 ?= "ipipe-core-5.4.299-x86-18"
-
-SRC_URI:append:arm64 = " git://gitlab.com/Xenomai/legacy/ipipe-arm64.git;protocol=https;nobranch=1"
-SRCREV:arm64 ?= "ipipe-core-5.4.180-arm64-5"
-
-SRC_URI:append:armhf = " git://gitlab.com/Xenomai/legacy/ipipe-arm.git;protocol=https;nobranch=1"
-SRCREV:armhf ?= "ipipe-core-5.4.231-arm-6"
-
-PV ?= "${@d.getVar('SRCREV').split('-')[2]}+"
diff --git a/recipes-kernel/linux/linux-xenomai-3_latest.bb b/recipes-kernel/linux/linux-xenomai-3_latest.bb
index 7939583..9c348fe 100644
--- a/recipes-kernel/linux/linux-xenomai-3_latest.bb
+++ b/recipes-kernel/linux/linux-xenomai-3_latest.bb
@@ -33,11 +33,10 @@ python () {
 
 # default: amd64 or i386
 GIT_REPO = "${@ \
-    'git://gitlab.com/Xenomai/legacy/ipipe-x86.git' if is_kernel(d, '4.19') or is_kernel(d, '5.4') \
+    'git://gitlab.com/Xenomai/legacy/ipipe-x86.git' if is_kernel(d, '4.19') \
     else 'git://gitlab.com/xenomai/linux-dovetail.git' }"
 GIT_BRANCH = "${@ \
     'ipipe-x86-4.19.y-cip' if is_kernel(d, '4.19') \
-    else 'ipipe-x86-5.4.y' if is_kernel(d, '5.4') \
     else 'v5.10.y-cip-dovetail-rebase' if is_kernel(d, '5.10') \
     else 'v5.15.y-dovetail-rebase' if is_kernel(d, '5.15') \
     else 'v6.1.y-cip-dovetail-rebase' if is_kernel(d, '6.1') \
@@ -45,11 +44,10 @@ GIT_BRANCH = "${@ \
     else d.getVar('LATEST_KERNEL_BRANCH') }"
 
 GIT_REPO:armhf = "${@ \
-    'git://gitlab.com/Xenomai/legacy/ipipe-arm.git' if is_kernel(d, '4.19') or is_kernel(d, '5.4') \
+    'git://gitlab.com/Xenomai/legacy/ipipe-arm.git' if is_kernel(d, '4.19') \
     else 'git://gitlab.com/xenomai/linux-dovetail.git' }"
 GIT_BRANCH:armhf = "${@ \
     'ipipe/4.19.y-cip' if is_kernel(d, '4.19') \
-    else 'ipipe/5.4.y' if is_kernel(d, '5.4') \
     else 'v5.10.y-cip-dovetail-rebase' if is_kernel(d, '5.10') \
     else 'v5.15.y-dovetail-rebase' if is_kernel(d, '5.15') \
     else 'v6.1.y-cip-dovetail-rebase' if is_kernel(d, '6.1') \
@@ -57,11 +55,10 @@ GIT_BRANCH:armhf = "${@ \
     else d.getVar('LATEST_KERNEL_BRANCH') }"
 
 GIT_REPO:arm64 = "${@ \
-    'git://gitlab.com/Xenomai/legacy/ipipe-arm64.git' if is_kernel(d, '4.19') or is_kernel(d, '5.4') \
+    'git://gitlab.com/Xenomai/legacy/ipipe-arm64.git' if is_kernel(d, '4.19') \
     else 'git://gitlab.com/xenomai/linux-dovetail.git' }"
 GIT_BRANCH:arm64 = "${@ \
     'ipipe/4.19.y-cip' if is_kernel(d, '4.19') \
-    else 'ipipe/5.4.y' if is_kernel(d, '5.4') \
     else 'v5.10.y-cip-dovetail-rebase' if is_kernel(d, '5.10') \
     else 'v5.15.y-dovetail-rebase' if is_kernel(d, '5.15') \
     else 'v6.1.y-cip-dovetail-rebase' if is_kernel(d, '6.1') \
-- 
2.51.0

