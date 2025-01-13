Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBCF22A4DE
	for <xenomai@lists.linux.dev>; Mon, 13 Jan 2025 12:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736772563; cv=none; b=rUXDbVDJ4aJUq42fJhKE3vRLluWesQr7ltmcFoy3EfEX/8Fk51fZ9PNXxueYY6KUyCsVaexjElwgarPZoPOp86GO6kXI3Xm8mM3RXj4TkZMuE+FU8qCenpVlj8h7MEsMjNTbcqmjTTODzyb3PQQqEgXpAAGyI3hLCuCFU71wcag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736772563; c=relaxed/simple;
	bh=dwMto0qyUkR0V1ueQ8LoqZSYFP8RjYIbz04HQqJ2NyY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kfsf6FJIKLwB8tihjYiCbSjDbZvfCXtWafKSNEnoYPRKZJ7w+DZWwN82eqDRLicHyu4fCtnOkRVNIjfRUAQcnPhu2XLjYassNBIVVRxIRyZCWMJXPyU+AIlxdZzhwILb9r1CAu8bzVDsP8SnmiP/pIFeFl7U7GLA3zHi+9DIj4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=sSULTNqg; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="sSULTNqg"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20250113124912ed4e7e1873b7cfd81c
        for <xenomai@lists.linux.dev>;
        Mon, 13 Jan 2025 13:49:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=4b8dy+q0RX+UHBKmAGeM6j2oCOMGJ7x2BLCQA5UhiJs=;
 b=sSULTNqgsyWtRks2OXLuccfV7Vxp3HdjO1C1qsu+Np8dIdUY+23GXxv5bUJM/Fjn5WwCnJ
 o2lkYeRGhw13TxuGcrseT0TbfKHDWYaZOWtEe5lyHD1049c1t6p7H0wU5TbksTXmLeQO056g
 7XtmA9rZCuKZ9w/X2FmbaVkCovai1tAmMuymWrHGJbGTYAGJCnAKo0fRiN8IPz3O2kwTajFm
 Tb/g/LEhAA7B3NOdMXuHHxcwYcy+BGiblziaf30F1UdFR6g4646cBKsGEznSSXX/CVWmTqpv
 4OkZ45zSrpTKsM+pNkRdHyTH3hwX1fvXAgabBOL/U5MYi14NTZeFGp0w==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH 4/6] linux-xenomai: Update to latest releases
Date: Mon, 13 Jan 2025 13:49:06 +0100
Message-ID: <167230e9313c5620af404fd54a81dd665fcca67a.1736772548.git.jan.kiszka@siemens.com>
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

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-kernel/linux/linux-xenomai-3_4.19.bb | 6 +++---
 recipes-kernel/linux/linux-xenomai-3_4.4.bb  | 6 +++---
 recipes-kernel/linux/linux-xenomai-3_5.10.bb | 4 ++--
 recipes-kernel/linux/linux-xenomai-3_5.15.bb | 4 ++--
 recipes-kernel/linux/linux-xenomai-3_5.4.bb  | 6 +++---
 recipes-kernel/linux/linux-xenomai-3_6.6.bb  | 4 ++--
 recipes-kernel/linux/linux-xenomai-4_6.6.bb  | 4 ++--
 7 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/recipes-kernel/linux/linux-xenomai-3_4.19.bb b/recipes-kernel/linux/linux-xenomai-3_4.19.bb
index 298610f..a4b6dfb 100644
--- a/recipes-kernel/linux/linux-xenomai-3_4.19.bb
+++ b/recipes-kernel/linux/linux-xenomai-3_4.19.bb
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2019-2023
+# Copyright (c) Siemens AG, 2019-2025
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -12,12 +12,12 @@
 require recipes-kernel/linux/linux-xenomai-3.inc
 
 SRC_URI:append:amd64 = " git://github.com/xenomai-ci/ipipe-x86.git;protocol=https;nobranch=1"
-SRCREV:amd64 ?= "ipipe-core-4.19.317-cip111-x86-29"
+SRCREV:amd64 ?= "ipipe-core-4.19.322-cip113-x86-30"
 
 SRC_URI:append:arm64 = " git://github.com/xenomai-ci/ipipe-arm64.git;protocol=https;nobranch=1"
 SRCREV:arm64 ?= "ipipe-core-4.19.229-cip67-arm64-13"
 
 SRC_URI:append:armhf = " git://github.com/xenomai-ci/ipipe-arm.git;protocol=https;nobranch=1"
-SRCREV:armhf ?= "ipipe-core-4.19.229-cip67-arm-18"
+SRCREV:armhf ?= "ipipe-core-4.19.271-cip90-arm-19"
 
 PV ?= "${@d.getVar('SRCREV').split('-')[2]}+"
diff --git a/recipes-kernel/linux/linux-xenomai-3_4.4.bb b/recipes-kernel/linux/linux-xenomai-3_4.4.bb
index e7a7e60..678f7f6 100644
--- a/recipes-kernel/linux/linux-xenomai-3_4.4.bb
+++ b/recipes-kernel/linux/linux-xenomai-3_4.4.bb
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2018-2023
+# Copyright (c) Siemens AG, 2018-2025
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -12,10 +12,10 @@
 require recipes-kernel/linux/linux-xenomai-3.inc
 
 SRC_URI:append:amd64 = " git://github.com/xenomai-ci/ipipe.git;protocol=https;nobranch=1"
-SRCREV:amd64 ?= "ipipe-core-4.4.302-cip79-x86-39"
+SRCREV:amd64 ?= "ipipe-core-4.4.302-cip91-x86-40"
 
 SRC_URI:append:armhf = " git://github.com/xenomai-ci/ipipe.git;protocol=https;nobranch=1"
 SRC_URI:append:armhf = " ${@ 'file://bbb_4.4.cfg' if d.getVar('MACHINE') == 'beagle-bone-black' else '' }"
-SRCREV:armhf ?= "ipipe-core-4.4.302-cip79-arm-24"
+SRCREV:armhf ?= "ipipe-core-4.4.302-cip91-arm-25"
 
 PV ?= "${@d.getVar('SRCREV').split('-')[2]}+"
diff --git a/recipes-kernel/linux/linux-xenomai-3_5.10.bb b/recipes-kernel/linux/linux-xenomai-3_5.10.bb
index 9b01708..088d0d8 100644
--- a/recipes-kernel/linux/linux-xenomai-3_5.10.bb
+++ b/recipes-kernel/linux/linux-xenomai-3_5.10.bb
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
 
-SRCREV ?= "v5.10.161-dovetail1"
+SRCREV ?= "v5.10.229-cip54-dovetail1"
diff --git a/recipes-kernel/linux/linux-xenomai-3_5.15.bb b/recipes-kernel/linux/linux-xenomai-3_5.15.bb
index 9c5ba27..286c64e 100644
--- a/recipes-kernel/linux/linux-xenomai-3_5.15.bb
+++ b/recipes-kernel/linux/linux-xenomai-3_5.15.bb
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
 
-SRCREV ?= "v5.15.85-dovetail1"
+SRCREV ?= "v5.15.173-dovetail1"
diff --git a/recipes-kernel/linux/linux-xenomai-3_5.4.bb b/recipes-kernel/linux/linux-xenomai-3_5.4.bb
index 5dced1d..71e0066 100644
--- a/recipes-kernel/linux/linux-xenomai-3_5.4.bb
+++ b/recipes-kernel/linux/linux-xenomai-3_5.4.bb
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2021-2023
+# Copyright (c) Siemens AG, 2021-2025
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -12,12 +12,12 @@
 require recipes-kernel/linux/linux-xenomai-3.inc
 
 SRC_URI:append:amd64 = " git://github.com/xenomai-ci/ipipe-x86.git;protocol=https;nobranch=1"
-SRCREV:amd64 ?= "ipipe-core-5.4.281-x86-16"
+SRCREV:amd64 ?= "ipipe-core-5.4.284-x86-17"
 
 SRC_URI:append:arm64 = " git://github.com/xenomai-ci/ipipe-arm64.git;protocol=https;nobranch=1"
 SRCREV:arm64 ?= "ipipe-core-5.4.180-arm64-5"
 
 SRC_URI:append:armhf = " git://github.com/xenomai-ci/ipipe-arm.git;protocol=https;nobranch=1"
-SRCREV:armhf ?= "ipipe-core-5.4.180-arm-5"
+SRCREV:armhf ?= "ipipe-core-5.4.231-arm-6"
 
 PV ?= "${@d.getVar('SRCREV').split('-')[2]}+"
diff --git a/recipes-kernel/linux/linux-xenomai-3_6.6.bb b/recipes-kernel/linux/linux-xenomai-3_6.6.bb
index b20eb19..cc765e1 100644
--- a/recipes-kernel/linux/linux-xenomai-3_6.6.bb
+++ b/recipes-kernel/linux/linux-xenomai-3_6.6.bb
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2024
+# Copyright (c) Siemens AG, 2024-2025
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -11,4 +11,4 @@
 
 require recipes-kernel/linux/linux-xenomai-3-dovetail.inc
 
-SRCREV ?= "v6.6-dovetail1"
+SRCREV ?= "v6.6.69-dovetail1"
diff --git a/recipes-kernel/linux/linux-xenomai-4_6.6.bb b/recipes-kernel/linux/linux-xenomai-4_6.6.bb
index f499bd0..730b0da 100644
--- a/recipes-kernel/linux/linux-xenomai-4_6.6.bb
+++ b/recipes-kernel/linux/linux-xenomai-4_6.6.bb
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
 
-SRCREV ?= "v6.6-evl2-rebase"
+SRCREV ?= "v6.6.69-evl1-rebase"
-- 
2.43.0

