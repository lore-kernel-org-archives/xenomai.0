Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988E722A4CB
	for <xenomai@lists.linux.dev>; Mon, 13 Jan 2025 12:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736772563; cv=none; b=VcCd56S4wtALr8jBNqGnEw1naFXou1A81NzPJ/33LbLf1tKDmqZ60tu4+ciS7qH80xai/q5OdmWRM/AwKFP8lj8r+vGwvZyHOas/DffJ3ThiQaxugkJpi2s3Xtdf7nKo8qVIcYQ/gHutI54sLqC7fynCNregqOuFBtDsMDU5NWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736772563; c=relaxed/simple;
	bh=JV2IVTupUjZlVT2f6bXbbP1HEvhYeOvUimvzpGsSz1A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mkz6RHOFqyErzXRUy7IWAkB3W6Qgs0eg6U4SZ28eEKx38wLAsMSSEEbF+a2K9DIvi/ieRG1XLjW5cTRCPBmOxZYpqJcJtdZuwVaA1MSA9GmX4lWk5By20G1rNyZgo4BXeNwyklQWrx4UydMS63PTLQqVsHd3NHGmCTIVS4jIdTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=a5yuH5mn; arc=none smtp.client-ip=185.136.65.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="a5yuH5mn"
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 20250113124913ddb690f5ada006b2c9
        for <xenomai@lists.linux.dev>;
        Mon, 13 Jan 2025 13:49:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=uCfobN70PItr8le1DIW5s2P1kjLf6ea4LnMxRgRmnFc=;
 b=a5yuH5mn86/X77oBV87KM06ofJjfZ/Ck3k2qYFQhL8XV4+g0bU16iKghjyJwRxw3hSZ/Sa
 GfKGnTnBW4Ua7UBe0exZnhoNa9uUCLAxkzKJqzxVyIekMjv6zkruUCmOHf7A8mDYy90b1Rrq
 rrfbBM54IJjw4DWxqOlV1Rf3uKQwRv8yaSl/rDjU/KLNLulGsJhYlAsFJ4Safl7I1EtxbnK/
 mo6+GVLjJA1gSesXZOfahV3jZhlW4ULwa8x3jabHz4kDCfOHhaNb1aCkdGsnVNMIByqd5Sif
 puVOUdu+WrGKyRR4TKb5POXraxZ/HcnsqqYA2hmjPby453q+ABO9pcvA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH 5/6] Add kernel 6.12 bits
Date: Mon, 13 Jan 2025 13:49:07 +0100
Message-ID: <31bcc65826c1bb93299e0bb77b7af7a38de902e5.1736772548.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1736772548.git.jan.kiszka@siemens.com>
References: <cover.1736772548.git.jan.kiszka@siemens.com>
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

Enable support for using this latest LTS kernel for Xenomai 3 and 4. We
intentionally not yet change any defaults, though.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 Kconfig                                       | 10 ++++++++++
 opt-linux-6.12.yml                            | 17 +++++++++++++++++
 opt-linux-latest-6.12.yml                     | 19 +++++++++++++++++++
 recipes-kernel/linux/linux-xenomai-3_6.12.bb  | 14 ++++++++++++++
 .../linux/linux-xenomai-3_latest.bb           |  3 +++
 recipes-kernel/linux/linux-xenomai-4_6.12.bb  | 14 ++++++++++++++
 .../linux/linux-xenomai-4_latest.bb           |  1 +
 7 files changed, 78 insertions(+)
 create mode 100644 opt-linux-6.12.yml
 create mode 100644 opt-linux-latest-6.12.yml
 create mode 100644 recipes-kernel/linux/linux-xenomai-3_6.12.bb
 create mode 100644 recipes-kernel/linux/linux-xenomai-4_6.12.bb

diff --git a/Kconfig b/Kconfig
index 26aa63e..5aa06bd 100644
--- a/Kconfig
+++ b/Kconfig
@@ -116,6 +116,14 @@ config KERNEL_LATEST
 	bool "Head of latest Dovetail branch"
 	depends on XENOMAI_LATEST
 
+config KERNEL_6_12_LATEST
+	bool "Head of 6.12 Dovetail branch"
+	depends on XENOMAI_LATEST || XENOMAI_3_3
+
+config KERNEL_6_12
+	bool "Latest 6.12 Dovetail release"
+	depends on XENOMAI_LATEST || XENOMAI_3_3
+
 config KERNEL_6_6_LATEST
 	bool "Head of 6.6 Dovetail branch"
 	depends on XENOMAI_LATEST || XENOMAI_3_3
@@ -177,6 +185,8 @@ endchoice
 config KAS_INCLUDE_KERNEL
 	string
 	default "opt-linux-latest.yml" if KERNEL_LATEST
+	default "opt-linux-latest-6.12.yml" if KERNEL_6_12_LATEST
+	default "opt-linux-6.12.yml" if KERNEL_6_12
 	default "opt-linux-latest-6.6.yml" if KERNEL_6_6_LATEST
 	default "opt-linux-6.6.yml" if KERNEL_6_6
 	default "opt-linux-latest-6.1.yml" if KERNEL_6_1_LATEST
diff --git a/opt-linux-6.12.yml b/opt-linux-6.12.yml
new file mode 100644
index 0000000..8132364
--- /dev/null
+++ b/opt-linux-6.12.yml
@@ -0,0 +1,17 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2025
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
+  linux-xenomai-version: |
+    PREFERRED_VERSION_linux-xenomai-3 = "6.12%"
diff --git a/opt-linux-latest-6.12.yml b/opt-linux-latest-6.12.yml
new file mode 100644
index 0000000..27d4845
--- /dev/null
+++ b/opt-linux-latest-6.12.yml
@@ -0,0 +1,19 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2025
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
+  linux-xenomai-version: |
+    PREFERRED_VERSION_linux-xenomai-3 = "9999-%"
+    PREFERRED_VERSION_linux-xenomai-4 = "9999-%"
+    LATEST_GIT_BRANCH = "6.12"
diff --git a/recipes-kernel/linux/linux-xenomai-3_6.12.bb b/recipes-kernel/linux/linux-xenomai-3_6.12.bb
new file mode 100644
index 0000000..62fbe67
--- /dev/null
+++ b/recipes-kernel/linux/linux-xenomai-3_6.12.bb
@@ -0,0 +1,14 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2025
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+require recipes-kernel/linux/linux-xenomai-3-dovetail.inc
+
+SRCREV ?= "v6.12.8-dovetail1"
diff --git a/recipes-kernel/linux/linux-xenomai-3_latest.bb b/recipes-kernel/linux/linux-xenomai-3_latest.bb
index ff1708b..0aeeaa2 100644
--- a/recipes-kernel/linux/linux-xenomai-3_latest.bb
+++ b/recipes-kernel/linux/linux-xenomai-3_latest.bb
@@ -48,6 +48,7 @@ GIT_BRANCH = "${@ \
     else 'v5.15.y-dovetail-rebase' if is_kernel(d, '5.15') \
     else 'v6.1.y-cip-dovetail-rebase' if is_kernel(d, '6.1') \
     else 'v6.6.y-dovetail-rebase' if is_kernel(d, '6.6') \
+    else 'v6.12.y-dovetail-rebase' if is_kernel(d, '6.12') \
     else d.getVar('LATEST_KERNEL_BRANCH') }"
 
 GIT_REPO:armhf = "${@ \
@@ -62,6 +63,7 @@ GIT_BRANCH:armhf = "${@ \
     else 'v5.15.y-dovetail-rebase' if is_kernel(d, '5.15') \
     else 'v6.1.y-cip-dovetail-rebase' if is_kernel(d, '6.1') \
     else 'v6.6.y-dovetail-rebase' if is_kernel(d, '6.6') \
+    else 'v6.12.y-dovetail-rebase' if is_kernel(d, '6.12') \
     else d.getVar('LATEST_KERNEL_BRANCH') }"
 
 GIT_REPO:arm64 = "${@ \
@@ -74,6 +76,7 @@ GIT_BRANCH:arm64 = "${@ \
     else 'v5.15.y-dovetail-rebase' if is_kernel(d, '5.15') \
     else 'v6.1.y-cip-dovetail-rebase' if is_kernel(d, '6.1') \
     else 'v6.6.y-dovetail-rebase' if is_kernel(d, '6.6') \
+    else 'v6.12.y-dovetail-rebase' if is_kernel(d, '6.12') \
     else d.getVar('LATEST_KERNEL_BRANCH') }"
 
 SRC_URI += "${GIT_REPO};protocol=https;branch=${GIT_BRANCH}"
diff --git a/recipes-kernel/linux/linux-xenomai-4_6.12.bb b/recipes-kernel/linux/linux-xenomai-4_6.12.bb
new file mode 100644
index 0000000..75fa7ee
--- /dev/null
+++ b/recipes-kernel/linux/linux-xenomai-4_6.12.bb
@@ -0,0 +1,14 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2025
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+require recipes-kernel/linux/linux-xenomai-4-evl.inc
+
+SRCREV ?= "v6.12.8-evl1-rebase"
diff --git a/recipes-kernel/linux/linux-xenomai-4_latest.bb b/recipes-kernel/linux/linux-xenomai-4_latest.bb
index 307c550..689c50e 100644
--- a/recipes-kernel/linux/linux-xenomai-4_latest.bb
+++ b/recipes-kernel/linux/linux-xenomai-4_latest.bb
@@ -33,6 +33,7 @@ python () {
 GIT_BRANCH = "${@ \
     'v6.1.y-cip-evl-rebase' if is_kernel(d, '6.1') \
     else 'v6.6.y-evl-rebase' if is_kernel(d, '6.6') \
+    else 'v6.12.y-evl-rebase' if is_kernel(d, '6.12') \
     else d.getVar('LATEST_KERNEL_BRANCH') }"
 
 SRC_URI += "git://source.denx.de/Xenomai/xenomai4/linux-evl.git;protocol=https;branch=${GIT_BRANCH}"
-- 
2.43.0

