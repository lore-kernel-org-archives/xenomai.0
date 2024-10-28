Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEE31DD53E
	for <xenomai@lists.linux.dev>; Mon, 28 Oct 2024 13:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730123092; cv=none; b=mWnDssKOo/SMgvN0USv5CguiilnRI79MalTFYeUE0IR6n41HIh5yTytXINne2IF9pGflLK8JKHtcm+3rrwNVoSoeuizjOnjTwi6eThiaJc+UHzcU85SIKsYI3qX9PK7SbgvHhgPuL92uOjq60JONIv/eSfxU++QjIXYQy1Q/0pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730123092; c=relaxed/simple;
	bh=Xsl1nKRpHkiTpdOr/t2JflQzftaNLDP0wpuxxZPNKi8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iNHtsulU6QprY3NW23sQn/PqDZ6+ijniOnAk5Qm92PRhI/EXe+WyKtgKQtxQio75qQrlRR/kCPykZOfN5yxGV3QfV/SdnNfdf5DrqYjABBJ6i+6QY/kMxfyn0629ITTuCduJfGoUvDHwC3vc5VJH8K9tV38LDyf6cV3N5Bw9oRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=Zx3re4ka; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="Zx3re4ka"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20241028134446bfaaefc17766aeab0b
        for <xenomai@lists.linux.dev>;
        Mon, 28 Oct 2024 14:44:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=wDYdobcxHhcI8RKus2ZTft3ZCL4eaom5E6DjsTydBMQ=;
 b=Zx3re4kaUPpalFcsgwjoFxKu0h8Sus2zngHiefM2q7tDoqcuqwZDgbHILkZh+xtvTN8hkh
 ztcpM7Pkg2716RIlVB+zp6YRxz9V1ddj8lOOodm6bgFsvwRcHyddzf4Ysog3uzkLSVM3g+gx
 eg0wwY0F7bGNt3cfTHfkbUHkncbIenw9d0f44yxfl0JPHQFlM0IXRQ6HPBlFkdyrwyonHjoO
 H99M37s4cVWR3+X2phDghAlAwRt05/xaCzjEv9FTvGPIt1MF3nsA7g6+S4sdNIuHS2tWEy4O
 Hk2fItLq9NBZh3Y86JeT76NgvIg018hrsGLdRDaloT/0AFktBHg8YANA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH 6/6] Add Xenomai 3.3 support
Date: Mon, 28 Oct 2024 14:44:44 +0100
Message-ID: <d57ca880bf1f5abc5b92b8033fa3109eaadb7176.1730123084.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1730123084.git.jan.kiszka@siemens.com>
References: <cover.1730123084.git.jan.kiszka@siemens.com>
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

Add the latest major version, also as new default. It does not come with
an own stable branch yet, thus focus on the release for now.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 Kconfig                                | 25 ++++++++++++++-----------
 conf/distro/xenomai-demo.conf          |  4 ++--
 recipes-xenomai/xenomai/xenomai_3.3.bb | 17 +++++++++++++++++
 3 files changed, 33 insertions(+), 13 deletions(-)
 create mode 100644 recipes-xenomai/xenomai/xenomai_3.3.bb

diff --git a/Kconfig b/Kconfig
index 13699bf..2336e66 100644
--- a/Kconfig
+++ b/Kconfig
@@ -77,11 +77,14 @@ if XENOMAI3
 
 choice
 	prompt "Xenomai 3 subversion"
-	default XENOMAI_3_2
+	default XENOMAI_3_3
 
 config XENOMAI_LATEST
 	bool "Head of next branch"
 
+config XENOMAI_3_3
+	bool "Latest 3.3.x release"
+
 config XENOMAI_3_2_LATEST
 	bool "Head of stable/v3.2.x branch"
 
@@ -107,7 +110,7 @@ config KAS_INCLUDE_XENOMAI
 
 choice
 	prompt "Kernel version"
-	default KERNEL_6_1
+	default KERNEL_6_6
 
 config KERNEL_LATEST
 	bool "Head of latest Dovetail branch"
@@ -115,35 +118,35 @@ config KERNEL_LATEST
 
 config KERNEL_6_6_LATEST
 	bool "Head of 6.6 Dovetail branch"
-	depends on XENOMAI_LATEST
+	depends on XENOMAI_LATEST || XENOMAI_3_3
 
 config KERNEL_6_6
 	bool "Latest 6.6 Dovetail release"
-	depends on XENOMAI_LATEST
+	depends on XENOMAI_LATEST || XENOMAI_3_3
 
 config KERNEL_6_1_LATEST
 	bool "Head of 6.1 Dovetail branch"
-	depends on XENOMAI_LATEST || XENOMAI_3_2_LATEST || XENOMAI_3_2
+	depends on XENOMAI_LATEST || XENOMAI_3_3 || XENOMAI_3_2_LATEST || XENOMAI_3_2
 
 config KERNEL_6_1
 	bool "Latest 6.1 Dovetail release"
-	depends on XENOMAI_LATEST || XENOMAI_3_2_LATEST || XENOMAI_3_2
+	depends on XENOMAI_LATEST || XENOMAI_3_3 || XENOMAI_3_2_LATEST || XENOMAI_3_2
 
 config KERNEL_5_15_LATEST
 	bool "Head of 5.15 Dovetail branch"
-	depends on XENOMAI_LATEST || XENOMAI_3_2_LATEST || XENOMAI_3_2
+	depends on XENOMAI_LATEST || XENOMAI_3_3 || XENOMAI_3_2_LATEST || XENOMAI_3_2
 
 config KERNEL_5_15
 	bool "Latest 5.15 Dovetail release"
-	depends on XENOMAI_LATEST || XENOMAI_3_2_LATEST || XENOMAI_3_2
+	depends on XENOMAI_LATEST || XENOMAI_3_3 || XENOMAI_3_2_LATEST || XENOMAI_3_2
 
 config KERNEL_5_10_LATEST
 	bool "Head of 5.10 Dovetail branch"
-	depends on XENOMAI_LATEST || XENOMAI_3_2_LATEST || XENOMAI_3_2
+	depends on XENOMAI_LATEST || XENOMAI_3_3 || XENOMAI_3_2_LATEST || XENOMAI_3_2
 
 config KERNEL_5_10
 	bool "Latest 5.10 Dovetail release"
-	depends on XENOMAI_LATEST || XENOMAI_3_2_LATEST || XENOMAI_3_2
+	depends on XENOMAI_LATEST || XENOMAI_3_3 || XENOMAI_3_2_LATEST || XENOMAI_3_2
 
 config KERNEL_5_4_LATEST
 	bool "Head of 5.4 I-pipe branch"
@@ -208,7 +211,7 @@ config KAS_INCLUDE_DEBUG
 
 config COMPAT
 	bool "Build 32 bit Xenomai userspace"
-	depends on XENOMAI_LATEST && ARCH_X86
+	depends on (XENOMAI_LATEST || XENOMAI_3_3) && ARCH_X86
 
 config KAS_INCLUDE_COMPAT
 	string
diff --git a/conf/distro/xenomai-demo.conf b/conf/distro/xenomai-demo.conf
index 222e077..d1b24b7 100644
--- a/conf/distro/xenomai-demo.conf
+++ b/conf/distro/xenomai-demo.conf
@@ -15,8 +15,8 @@ XENOMAI_MAJOR_VERSION ?= "3"
 
 OVERRIDES .= ":xenomai${XENOMAI_MAJOR_VERSION}"
 
-PREFERRED_VERSION_xenomai ?= "3.2%"
-PREFERRED_VERSION_xenomai-compat ?= "3.2%"
+PREFERRED_VERSION_xenomai ?= "3.3%"
+PREFERRED_VERSION_xenomai-compat ?= "3.3%"
 include conf/distro/include/xenomai-version.inc
 
 PREFERRED_VERSION_libevl ?= "4%"
diff --git a/recipes-xenomai/xenomai/xenomai_3.3.bb b/recipes-xenomai/xenomai/xenomai_3.3.bb
new file mode 100644
index 0000000..c2babdb
--- /dev/null
+++ b/recipes-xenomai/xenomai/xenomai_3.3.bb
@@ -0,0 +1,17 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2024
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+require xenomai.inc
+
+# Note: When updating PV, also update conf/distro/include/xenomai-version.inc!
+
+SRC_URI = " \
+    git://github.com/xenomai-ci/xenomai.git;protocol=https;branch=master;tag=v${PV}"
-- 
2.43.0

