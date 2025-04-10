Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD0D28136F
	for <xenomai@lists.linux.dev>; Thu, 10 Apr 2025 14:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744294603; cv=none; b=pY+j4d3RTkPvice6SVLwJasJ5I/UXmP3X3NHQtPS3cWaBDRcjKumSzPQCNGaIsTDF0witrPDRWAusyAV0xCrBBBKMw8a+27Igyv45Pf1IzZBSEJqblioSGn4qlCyePJ3sgy1J7sAlX/kA95z0cnzG9fC2i7UXVP9oq4iUH4+AZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744294603; c=relaxed/simple;
	bh=yTHATNwTIOvHnMqaFxMRFgdbzCdcmKFK7hBpa6Zbs3c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C1R/IOgzyy79Y9k5iY4MtZ1nGVhgqK9X20xdf0Rukl6tPRl9g1e9fYp/QOPCWA5EFz5l/+sKW3VPTxH202nG/HIxQLVpFhgklLdBJDZyFzPmxXxUyA7ehnvGr7PyBQGkrcTTgXkkS+SnKfPVVXsgLDdbUtmtAqcEtEWTI7+G1+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=Z1/ye0xz; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="Z1/ye0xz"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2025041014163186037d3b5866f242a6
        for <xenomai@lists.linux.dev>;
        Thu, 10 Apr 2025 16:16:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=+I/Mw4tvrimLCONYxpuRt+R8OsQ504rLpnnEZFBx0qw=;
 b=Z1/ye0xz1kisroNrsRIn/qsGxkIbD80acDkvGebzFDkfwnBywAM56AX4o0QVNJa2VFgpI6
 Ob/x+wx0qL/AVfQcoI+w08xcA8sk1TImxS0OkthRWeLuJrmFIN4j+xamQVSBTVp6kjQkj/Zb
 vs897mSaorL3r67Ju4K3TqA+G9rA5kfIPJb3GTpRV8u7INvLvioX3g3FtWi5HwyS8L4OsjOG
 VVwvN2tJ3NGEyQwdUOZ56jMFA0cuEulQ11nR3n439BPLc5rMEdOjJ3Uhj+b85LsrpW+GzRPJ
 trHyKMX7eCY1aphx4JUEItVLOT3RbGluwnTSbTUcVBRdui6AghK8wmlA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH 1/7] Add stable 3.3 branch with kernel 6.12 as default
Date: Thu, 10 Apr 2025 16:16:24 +0200
Message-ID: <a6631e43663afc8511fa151c07daddeb1c740a3e.1744294590.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1744294590.git.jan.kiszka@siemens.com>
References: <cover.1744294590.git.jan.kiszka@siemens.com>
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

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 Kconfig                                        |  4 ++++
 conf/distro/include/xenomai-version.inc        | 12 +++++++++---
 opt-xenomai-3.3.x.yml                          | 18 ++++++++++++++++++
 .../xenomai/xenomai_stable-3.3.x.bb            |  1 +
 4 files changed, 32 insertions(+), 3 deletions(-)
 create mode 100644 opt-xenomai-3.3.x.yml
 create mode 120000 recipes-xenomai/xenomai/xenomai_stable-3.3.x.bb

diff --git a/Kconfig b/Kconfig
index 5aa06bd..f7ac3c8 100644
--- a/Kconfig
+++ b/Kconfig
@@ -82,6 +82,9 @@ choice
 config XENOMAI_LATEST
 	bool "Head of next branch"
 
+config XENOMAI_3_3_LATEST
+	bool "Head of stable/v3.3.x branch"
+
 config XENOMAI_3_3
 	bool "Latest 3.3.x release"
 
@@ -104,6 +107,7 @@ endchoice
 config KAS_INCLUDE_XENOMAI
 	string
 	default "opt-xenomai-next.yml" if XENOMAI_LATEST
+	default "opt-xenomai-3.3.x.yml" if XENOMAI_3_3_LATEST
 	default "opt-xenomai-3.2.x.yml" if XENOMAI_3_2_LATEST
 	default "opt-xenomai-3.1.x.yml" if XENOMAI_3_1_LATEST
 	default "opt-xenomai-3.0.x.yml" if XENOMAI_3_0_LATEST
diff --git a/conf/distro/include/xenomai-version.inc b/conf/distro/include/xenomai-version.inc
index e036c39..81c61ac 100644
--- a/conf/distro/include/xenomai-version.inc
+++ b/conf/distro/include/xenomai-version.inc
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2019-2024
+# Copyright (c) Siemens AG, 2019-2025
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -9,7 +9,7 @@
 # SPDX-License-Identifier: MIT
 #
 
-XENOMAI_DEFAULT_KERNEL_VERSION = "6.1%"
+XENOMAI_DEFAULT_KERNEL_VERSION = "6.12%"
 
 XENOMAI_3_0_VERSION_LIST = "3.0 3.0% 3.0.% 3.0.15 stable-3.0.x"
 XENOMAI_3_0_KERNEL_VERSION = "4.4%"
@@ -20,6 +20,9 @@ XENOMAI_3_1_KERNEL_VERSION = "5.4%"
 XENOMAI_3_2_VERSION_LIST = "3.2 3.2% 3.2.% 3.2.6 stable-3.2.x"
 XENOMAI_3_2_KERNEL_VERSION = "6.1%"
 
+XENOMAI_3_3_VERSION_LIST = "3.3 3.3% 3.3.% stable-3.2.x"
+XENOMAI_3_3_KERNEL_VERSION = "6.12%"
+
 # If PREFERRED_VERSION_xenomai contains any item from XENOMAI_3_0_VERSION_LIST use
 # XENOMAI_3_0_KERNEL_VERSION. Same for the other XENOMAI_*_VERSION_LIST.
 PREFERRED_VERSION_linux-xenomai-3 ?= \
@@ -29,6 +32,9 @@ PREFERRED_VERSION_linux-xenomai-3 ?= \
             '${XENOMAI_3_1_VERSION_LIST}', '${XENOMAI_3_1_KERNEL_VERSION}', \
             bb.utils.contains_any('PREFERRED_VERSION_xenomai', \
                 '${XENOMAI_3_2_VERSION_LIST}', '${XENOMAI_3_2_KERNEL_VERSION}', \
-                '${XENOMAI_DEFAULT_KERNEL_VERSION}', d), \
+                bb.utils.contains_any('PREFERRED_VERSION_xenomai', \
+                    '${XENOMAI_3_3_VERSION_LIST}', '${XENOMAI_3_3_KERNEL_VERSION}', \
+                    '${XENOMAI_DEFAULT_KERNEL_VERSION}', d), \
+                d), \
             d), \
         d)}"
diff --git a/opt-xenomai-3.3.x.yml b/opt-xenomai-3.3.x.yml
new file mode 100644
index 0000000..cd7b477
--- /dev/null
+++ b/opt-xenomai-3.3.x.yml
@@ -0,0 +1,18 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens, 2025
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+header:
+  version: 14
+
+local_conf_header:
+  xenomai-3-3-x: |
+    PREFERRED_VERSION_xenomai = "stable-3.3.x"
+    PREFERRED_VERSION_xenomai-compat = "stable-3.3.x"
diff --git a/recipes-xenomai/xenomai/xenomai_stable-3.3.x.bb b/recipes-xenomai/xenomai/xenomai_stable-3.3.x.bb
new file mode 120000
index 0000000..0914c52
--- /dev/null
+++ b/recipes-xenomai/xenomai/xenomai_stable-3.3.x.bb
@@ -0,0 +1 @@
+xenomai_stable-3.0.x.bb
\ No newline at end of file
-- 
2.43.0

