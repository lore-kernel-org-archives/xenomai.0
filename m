Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDD621ADB9
	for <xenomai@lists.linux.dev>; Mon, 13 Jan 2025 12:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736772563; cv=none; b=rcujtcDiQYo1UAhAjWmqfK/c+3zThi6Ry1v/RSH3/P7O2cn9//QENtyVVS3RSViM3hmpk2XQ5819v4NT6VHiNu65/2Dc1fM718lSFVGnTkSAeC2X2bWWF5mBGPD5zeVXO1t+V+khIYOofCaP22JKahACmAXC4Bwu1U58eR5ZyrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736772563; c=relaxed/simple;
	bh=nDnlSTDKIvZil0zQIjf2hOZ0R8sKH075mU3o4IXhzLw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ebKit/8xwZ/CynAVP6pVWrIhT+cK4GgUkvSt38/v6wsT7IqHgqCl9oMmcu3sqS5LyOOwixMHPe2hDazqFNWAVqU3NfZMQtptAlHQRJzhItlsHCkS7rAK23bfdceHt9ngSrQbbWL1ooHIKaca6BtFZebvAidyK1Aw4fkp0cSq/gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=K3cbKQX+; arc=none smtp.client-ip=185.136.65.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="K3cbKQX+"
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 20250113124912ef786e50d4f37473af
        for <xenomai@lists.linux.dev>;
        Mon, 13 Jan 2025 13:49:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=LaD0/wV6jmaZG7Hhxro5KevGdq2KwjJ3YEccfKcwgL8=;
 b=K3cbKQX+6XP/nrdwIMGcZXCf2IWw+DidlLod77XBkSnC7Z4XMLjJnSDlSXb4rcX57GEMKo
 dCIIhRWD/UgzoT3czBOcJsL9r92HkfjUWt/XfIEEBwyOi++vWWhiX8uHR39w6XGfJscWNvUd
 MicOki1MIOvUJjgTBSx1aenbYzDV+EWkYGStR6BU34pkKv3OmcY2WJUhck0vA/qlHuVGwtOv
 uOtkWXpjdNkqtJ7luKSUXS+EtICHlokQTgxVwQ4L2yKsJB8MKLtTjcffXq9ymce+mjbb78EC
 OXXIOUC8/TQsuXhGpbMQI0uLzsXD5BJwvopS9bkjI02vA7T8LuQ/SoWA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH 3/6] linux-xenomai: Switch to v6.1.y-cip branches
Date: Mon, 13 Jan 2025 13:49:05 +0100
Message-ID: <45339d08d32db73d393cc84477910da749e7990d.1736772548.git.jan.kiszka@siemens.com>
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

Maintenance of dovetail and evl for kernel v6.1 moved on from LTS-based
to CIP-based.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-kernel/linux/linux-xenomai-3_6.1.bb    | 4 ++--
 recipes-kernel/linux/linux-xenomai-3_latest.bb | 8 ++++----
 recipes-kernel/linux/linux-xenomai-4_6.1.bb    | 4 ++--
 recipes-kernel/linux/linux-xenomai-4_latest.bb | 4 ++--
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/recipes-kernel/linux/linux-xenomai-3_6.1.bb b/recipes-kernel/linux/linux-xenomai-3_6.1.bb
index 1b41692..f052b20 100644
--- a/recipes-kernel/linux/linux-xenomai-3_6.1.bb
+++ b/recipes-kernel/linux/linux-xenomai-3_6.1.bb
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2021-2023
+# Copyright (c) Siemens AG, 2021-2025
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -11,4 +11,4 @@
 
 require recipes-kernel/linux/linux-xenomai-3-dovetail.inc
 
-SRCREV ?= "v6.1.11-dovetail1"
+SRCREV ?= "v6.1.121-cip34-dovetail1"
diff --git a/recipes-kernel/linux/linux-xenomai-3_latest.bb b/recipes-kernel/linux/linux-xenomai-3_latest.bb
index ab13897..ff1708b 100644
--- a/recipes-kernel/linux/linux-xenomai-3_latest.bb
+++ b/recipes-kernel/linux/linux-xenomai-3_latest.bb
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2019-2023
+# Copyright (c) Siemens AG, 2019-2025
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -46,7 +46,7 @@ GIT_BRANCH = "${@ \
     else 'ipipe-x86-5.4.y' if is_kernel(d, '5.4') \
     else 'v5.10.y-cip-dovetail-rebase' if is_kernel(d, '5.10') \
     else 'v5.15.y-dovetail-rebase' if is_kernel(d, '5.15') \
-    else 'v6.1.y-dovetail-rebase' if is_kernel(d, '6.1') \
+    else 'v6.1.y-cip-dovetail-rebase' if is_kernel(d, '6.1') \
     else 'v6.6.y-dovetail-rebase' if is_kernel(d, '6.6') \
     else d.getVar('LATEST_KERNEL_BRANCH') }"
 
@@ -60,7 +60,7 @@ GIT_BRANCH:armhf = "${@ \
     else 'ipipe/5.4.y' if is_kernel(d, '5.4') \
     else 'v5.10.y-cip-dovetail-rebase' if is_kernel(d, '5.10') \
     else 'v5.15.y-dovetail-rebase' if is_kernel(d, '5.15') \
-    else 'v6.1.y-dovetail-rebase' if is_kernel(d, '6.1') \
+    else 'v6.1.y-cip-dovetail-rebase' if is_kernel(d, '6.1') \
     else 'v6.6.y-dovetail-rebase' if is_kernel(d, '6.6') \
     else d.getVar('LATEST_KERNEL_BRANCH') }"
 
@@ -72,7 +72,7 @@ GIT_BRANCH:arm64 = "${@ \
     else 'ipipe/5.4.y' if is_kernel(d, '5.4') \
     else 'v5.10.y-cip-dovetail-rebase' if is_kernel(d, '5.10') \
     else 'v5.15.y-dovetail-rebase' if is_kernel(d, '5.15') \
-    else 'v6.1.y-dovetail-rebase' if is_kernel(d, '6.1') \
+    else 'v6.1.y-cip-dovetail-rebase' if is_kernel(d, '6.1') \
     else 'v6.6.y-dovetail-rebase' if is_kernel(d, '6.6') \
     else d.getVar('LATEST_KERNEL_BRANCH') }"
 
diff --git a/recipes-kernel/linux/linux-xenomai-4_6.1.bb b/recipes-kernel/linux/linux-xenomai-4_6.1.bb
index a037e4c..32e2131 100644
--- a/recipes-kernel/linux/linux-xenomai-4_6.1.bb
+++ b/recipes-kernel/linux/linux-xenomai-4_6.1.bb
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2023-2024
+# Copyright (c) Siemens AG, 2023-2025
 #
 # Authors:
 #  Clara Kowalsky <clara.kowalsky@siemens.com>
@@ -11,4 +11,4 @@
 
 require recipes-kernel/linux/linux-xenomai-4-evl.inc
 
-SRCREV ?= "v6.1.61-evl2-rebase"
+SRCREV ?= "v6.1.121-cip34-evl1-rebase"
diff --git a/recipes-kernel/linux/linux-xenomai-4_latest.bb b/recipes-kernel/linux/linux-xenomai-4_latest.bb
index c4a254f..307c550 100644
--- a/recipes-kernel/linux/linux-xenomai-4_latest.bb
+++ b/recipes-kernel/linux/linux-xenomai-4_latest.bb
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2024
+# Copyright (c) Siemens AG, 2024-2025
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -31,7 +31,7 @@ python () {
 }
 
 GIT_BRANCH = "${@ \
-    'v6.1.y-evl-rebase' if is_kernel(d, '6.1') \
+    'v6.1.y-cip-evl-rebase' if is_kernel(d, '6.1') \
     else 'v6.6.y-evl-rebase' if is_kernel(d, '6.6') \
     else d.getVar('LATEST_KERNEL_BRANCH') }"
 
-- 
2.43.0

