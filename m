Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EC732573F
	for <xenomai@lists.linux.dev>; Sun, 14 Jun 2026 09:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781428667; cv=none; b=dFjkRtCQezvAgQ0iFLmZtiblx3hk3raTG5bQYenbnO42MS9AyYij8AIxW1J7qSd7EfiE0N1IL0Ec0D/+tUq+1ciCKw7yEhtr4RBhSpawIKUfdm2VDoi7sph0nlom9tfIYIrKqbawX60yaQZGwWakkPN/CVMXqxLx/ID504SpE6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781428667; c=relaxed/simple;
	bh=+PImMXBQ5xqYmqP37/FJ+KC9isQsmPClPR4YJh3sQQw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KVOvhuo4g4B21uYeOB1doxRnm8X+kIsYLrywKgD14u/604d8j5PHAGaRB1kSVSJoKAqkUY7zRohlAWcXyL9cCSGnHn4PT0/RbsovOuyJg4xZqoqz21nCYFFyqE6N0jNmbyHcjGCj7zI2eDvKPzzjQVY5euYFetBAGbpeIchfjLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=qKkjChxv; arc=none smtp.client-ip=185.136.65.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="qKkjChxv"
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 202606140917351a3989ee12000207ba
        for <xenomai@lists.linux.dev>;
        Sun, 14 Jun 2026 11:17:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=kxqyYihKzzuVZqpxmK8BDtxZJ0sVgq/amDobKhP8HB0=;
 b=qKkjChxvrAA8H9k+rdmO3Z2Srb2DglGnOoySPEIpERbECJWZhjRxPajssMDX2EfKOOge9r
 5K6pWVrTWONEAZRc4XTt27HoLDt4QuI4dPca3RshdiPW6+n78+3/BLvdNhePoEvNRHGuB8Om
 u6cR4DXs1mbZIdMxwoXhTT3bg3L4Vp7/dFVNK0uYO9kHpg7pSM8JqOaT0tXWjeo+82g03U1i
 hEEwPzGz5e3GOZVJXn8VHTfSad6R6cbphkWeKohaJ6tu5aDcPwTarJG9bcVEU1vwB3fK6Jl7
 gLNPLxC2VXEypwJMftpnrOjdGZ0xaFYZVD05LxL8NqIx+EB3dMYzqWAA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH 5/6] linux-xenomai: Renovate xenomai-4 kernel versions
Date: Sun, 14 Jun 2026 11:17:33 +0200
Message-ID: <36308aaa5fd8683e6a6ce0100cff648b2149fc74.1781428654.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1781428654.git.jan.kiszka@siemens.com>
References: <cover.1781428654.git.jan.kiszka@siemens.com>
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

6.1.y-cip-evl is now EOL, drop it. Bump the rest to latest releases.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 Kconfig                                        | 10 ----------
 recipes-kernel/linux/linux-xenomai-4_6.1.bb    | 14 --------------
 recipes-kernel/linux/linux-xenomai-4_6.12.bb   |  2 +-
 recipes-kernel/linux/linux-xenomai-4_6.18.bb   |  2 +-
 recipes-kernel/linux/linux-xenomai-4_latest.bb |  5 ++---
 5 files changed, 4 insertions(+), 29 deletions(-)
 delete mode 100644 recipes-kernel/linux/linux-xenomai-4_6.1.bb

diff --git a/Kconfig b/Kconfig
index dc79700..091a299 100644
--- a/Kconfig
+++ b/Kconfig
@@ -228,14 +228,6 @@ config EVL_KERNEL_6_12
 	bool "Latest 6.12 EVL release"
 	depends on !ARCH_RISCV64
 
-config EVL_KERNEL_6_1_HEAD
-	bool "Head of 6.1 EVL branch"
-	depends on !ARCH_RISCV64
-
-config EVL_KERNEL_6_1
-	bool "Latest 6.1 EVL release"
-	depends on !ARCH_RISCV64
-
 endchoice
 
 config KAS_INCLUDE_EVL_KERNEL
@@ -245,8 +237,6 @@ config KAS_INCLUDE_EVL_KERNEL
 	default "kas/opt/linux-6.18.yaml" if EVL_KERNEL_6_18
 	default "kas/opt/linux-6.12-head.yaml" if EVL_KERNEL_6_12_HEAD
 	default "kas/opt/linux-6.12.yaml" if EVL_KERNEL_6_12
-	default "kas/opt/linux-6.1-head.yaml" if EVL_KERNEL_6_1_HEAD
-	default "kas/opt/linux-6.1.yaml" if EVL_KERNEL_6_1
 
 choice
 	prompt "libevl version"
diff --git a/recipes-kernel/linux/linux-xenomai-4_6.1.bb b/recipes-kernel/linux/linux-xenomai-4_6.1.bb
deleted file mode 100644
index 2efe538..0000000
--- a/recipes-kernel/linux/linux-xenomai-4_6.1.bb
+++ /dev/null
@@ -1,14 +0,0 @@
-#
-# Xenomai Real-Time System
-#
-# Copyright (c) Siemens AG, 2023-2026
-#
-# Authors:
-#  Clara Kowalsky <clara.kowalsky@siemens.com>
-#
-# SPDX-License-Identifier: MIT
-#
-
-require recipes-kernel/linux/linux-xenomai-4-evl.inc
-
-SRCREV ?= "v6.1.162-cip51-evl2-rebase"
diff --git a/recipes-kernel/linux/linux-xenomai-4_6.12.bb b/recipes-kernel/linux/linux-xenomai-4_6.12.bb
index 7281917..249b485 100644
--- a/recipes-kernel/linux/linux-xenomai-4_6.12.bb
+++ b/recipes-kernel/linux/linux-xenomai-4_6.12.bb
@@ -11,4 +11,4 @@
 
 require recipes-kernel/linux/linux-xenomai-4-evl.inc
 
-SRCREV ?= "v6.12.69-cip17-evl1-rebase"
+SRCREV ?= "v6.12.85-cip22-evl4-rebase"
diff --git a/recipes-kernel/linux/linux-xenomai-4_6.18.bb b/recipes-kernel/linux/linux-xenomai-4_6.18.bb
index a1ddad5..10fe5f9 100644
--- a/recipes-kernel/linux/linux-xenomai-4_6.18.bb
+++ b/recipes-kernel/linux/linux-xenomai-4_6.18.bb
@@ -11,4 +11,4 @@
 
 require recipes-kernel/linux/linux-xenomai-4-evl.inc
 
-SRCREV ?= "v6.18.7-evl2-rebase"
+SRCREV ?= "v6.18.22-evl5-rebase"
diff --git a/recipes-kernel/linux/linux-xenomai-4_latest.bb b/recipes-kernel/linux/linux-xenomai-4_latest.bb
index 9d479cd..a542e80 100644
--- a/recipes-kernel/linux/linux-xenomai-4_latest.bb
+++ b/recipes-kernel/linux/linux-xenomai-4_latest.bb
@@ -27,12 +27,11 @@ python () {
         (ret, out) = subprocess.getstatusoutput(cmd)
         d.setVar('LATEST_KERNEL_BRANCH', out)
     else:
-        d.setVar('LATEST_KERNEL_BRANCH', 'v6.12.y-evl-rebase')
+        d.setVar('LATEST_KERNEL_BRANCH', 'v6.18.y-evl-rebase')
 }
 
 GIT_BRANCH = "${@ \
-    'v6.1.y-cip-evl-rebase' if is_kernel(d, '6.1') \
-    else 'v6.12.y-cip-evl-rebase' if is_kernel(d, '6.12') \
+    'v6.12.y-cip-evl-rebase' if is_kernel(d, '6.12') \
     else 'v6.18.y-evl-rebase' if is_kernel(d, '6.18') \
     else d.getVar('LATEST_KERNEL_BRANCH') }"
 GIT_BRANCH:riscv64 = "wip/evl-riscv"
-- 
2.47.3

