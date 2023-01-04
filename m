Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B501AD38
	for <xenomai@lists.linux.dev>; Wed,  4 Jan 2023 15:31:47 +0000 (UTC)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20230104152136667ec30fc8db5dc7f8
        for <xenomai@lists.linux.dev>;
        Wed, 04 Jan 2023 16:21:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=ucf/ZeEhUEqs0unItHTB7hGG65yqFkTvvWnd6xXWdAI=;
 b=RcUAyOK5F44k0vhieBZ+Vqgp1+VUxSnQyxrGWFpQC6lyzBeWAJ0x0wGWFouZQNNza3uCKm
 cMZ4rexzPlFxH5vU1sQIjsuiCOIK1ACWJG5MiEXSpgsK7Sv6lhB7dtz2fAJsjiGlY9Sek2qS
 8ICSEvYoQZyFwUd8YgW1wMhM4T2WA=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH 1/3] linux-xenomai: Refresh releases and simplify their maintenance
Date: Wed,  4 Jan 2023 16:21:33 +0100
Message-Id: <bf9579b91ea6cec5c2c449a0304a761fcf278fa4.1672845695.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1672845695.git.jan.kiszka@siemens.com>
References: <cover.1672845695.git.jan.kiszka@siemens.com>
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

PV can be derived from the release tags, so only the latter need to be
updated in the future. But make sure that SRCREV and PV remain
overwritable consistently.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-kernel/linux/linux-xenomai_4.19.bb | 13 ++++++-------
 recipes-kernel/linux/linux-xenomai_4.4.bb  | 10 +++++-----
 recipes-kernel/linux/linux-xenomai_5.10.bb |  7 ++++---
 recipes-kernel/linux/linux-xenomai_5.15.bb |  7 ++++---
 recipes-kernel/linux/linux-xenomai_5.4.bb  | 13 ++++++-------
 5 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/recipes-kernel/linux/linux-xenomai_4.19.bb b/recipes-kernel/linux/linux-xenomai_4.19.bb
index 5b12ce4..d02def6 100644
--- a/recipes-kernel/linux/linux-xenomai_4.19.bb
+++ b/recipes-kernel/linux/linux-xenomai_4.19.bb
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2019-2021
+# Copyright (c) Siemens AG, 2019-2023
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -12,15 +12,14 @@
 require recipes-kernel/linux/linux-xenomai.inc
 
 SRC_URI_append_amd64 = " git://github.com/xenomai-ci/ipipe-x86.git;protocol=https;nobranch=1"
-SRCREV_amd64 ?= "ipipe-core-4.19.207-cip58-x86-20"
-PV_amd64 ?= "4.19.207+"
+SRCREV_amd64 ?= "ipipe-core-4.19.266-cip86-x86-25"
 
 SRC_URI_append_arm64 = " git://github.com/xenomai-ci/ipipe-arm64.git;protocol=https;nobranch=1"
-SRCREV_arm64 ?= "ipipe-core-4.19.209-cip59-arm64-12"
-PV_arm64 ?= "4.19.209+"
+SRCREV_arm64 ?= "ipipe-core-4.19.229-cip67-arm64-13"
 
 SRC_URI_append_armhf = " git://github.com/xenomai-ci/ipipe-arm.git;protocol=https;nobranch=1"
-SRCREV_armhf ?= "ipipe-core-4.19.207-cip58-arm16"
-PV_armhf ?= "4.19.207+"
+SRCREV_armhf ?= "ipipe-core-4.19.229-cip67-arm-18"
+
+PV ?= "${@d.getVar('SRCREV').split('-')[2]}+"
 
 S = "${WORKDIR}/git"
diff --git a/recipes-kernel/linux/linux-xenomai_4.4.bb b/recipes-kernel/linux/linux-xenomai_4.4.bb
index a5cce7d..dc64a85 100644
--- a/recipes-kernel/linux/linux-xenomai_4.4.bb
+++ b/recipes-kernel/linux/linux-xenomai_4.4.bb
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2018-2021
+# Copyright (c) Siemens AG, 2018-2023
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -12,12 +12,12 @@
 require recipes-kernel/linux/linux-xenomai.inc
 
 SRC_URI_append_amd64 = " git://github.com/xenomai-ci/ipipe.git;protocol=https;nobranch=1"
-SRCREV_amd64 ?= "ipipe-core-4.4.285-cip63-x86-30"
-PV_amd64 = "4.4.285+"
+SRCREV_amd64 ?= "ipipe-core-4.4.302-cip71-x86-35"
 
 SRC_URI_append_armhf = " git://github.com/xenomai-ci/ipipe.git;protocol=https;nobranch=1"
 SRC_URI_append_armhf = " ${@ 'file://bbb_4.4.cfg' if d.getVar('MACHINE') == 'beagle-bone-black' else '' }"
-SRCREV_armhf ?= "ipipe-core-4.4.285-cip63-arm-15"
-PV_armhf = "4.4.285+"
+SRCREV_armhf ?= "ipipe-core-4.4.302-cip71-arm-20"
+
+PV ?= "${@d.getVar('SRCREV').split('-')[2]}+"
 
 S = "${WORKDIR}/git"
diff --git a/recipes-kernel/linux/linux-xenomai_5.10.bb b/recipes-kernel/linux/linux-xenomai_5.10.bb
index 0e8b414..4500864 100644
--- a/recipes-kernel/linux/linux-xenomai_5.10.bb
+++ b/recipes-kernel/linux/linux-xenomai_5.10.bb
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2021
+# Copyright (c) Siemens AG, 2021-2023
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -12,7 +12,8 @@
 require recipes-kernel/linux/linux-xenomai.inc
 
 SRC_URI += "git://source.denx.de/xenomai/linux-dovetail.git;protocol=https;nobranch=1"
-SRCREV = "v5.10.76-dovetail3"
-PV = "5.10.76+"
+SRCREV ?= "v5.10.161-dovetail1"
+
+PV ?= "${@d.getVar('SRCREV').strip('-')[0].lstrip('v')}+"
 
 S = "${WORKDIR}/git"
diff --git a/recipes-kernel/linux/linux-xenomai_5.15.bb b/recipes-kernel/linux/linux-xenomai_5.15.bb
index fcfc4b4..724c73b 100644
--- a/recipes-kernel/linux/linux-xenomai_5.15.bb
+++ b/recipes-kernel/linux/linux-xenomai_5.15.bb
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2021
+# Copyright (c) Siemens AG, 2021-2023
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -12,7 +12,8 @@
 require recipes-kernel/linux/linux-xenomai.inc
 
 SRC_URI += "git://source.denx.de/xenomai/linux-dovetail.git;protocol=https;nobranch=1"
-SRCREV = "v5.15.57-dovetail1"
-PV = "5.15.57+"
+SRCREV ?= "v5.15.85-dovetail1"
+
+PV ?= "${@d.getVar('SRCREV').strip('-')[0].lstrip('v')}+"
 
 S = "${WORKDIR}/git"
diff --git a/recipes-kernel/linux/linux-xenomai_5.4.bb b/recipes-kernel/linux/linux-xenomai_5.4.bb
index f19dcd6..716d92d 100644
--- a/recipes-kernel/linux/linux-xenomai_5.4.bb
+++ b/recipes-kernel/linux/linux-xenomai_5.4.bb
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2021
+# Copyright (c) Siemens AG, 2021-2023
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -12,15 +12,14 @@
 require recipes-kernel/linux/linux-xenomai.inc
 
 SRC_URI_append_amd64 = " git://github.com/xenomai-ci/ipipe-x86.git;protocol=https;nobranch=1"
-SRCREV_amd64 ?= "ipipe-core-5.4.151-x86-7"
-PV_amd64 ?= "5.4.151+"
+SRCREV_amd64 ?= "ipipe-core-5.4.228-x86-12"
 
 SRC_URI_append_arm64 = " git://github.com/xenomai-ci/ipipe-arm64.git;protocol=https;nobranch=1"
-SRCREV_arm64 ?= "ipipe-core-5.4.152-arm64-3"
-PV_arm64 ?= "5.4.152+"
+SRCREV_arm64 ?= "ipipe-core-5.4.180-arm64-5"
 
 SRC_URI_append_armhf = " git://github.com/xenomai-ci/ipipe-arm.git;protocol=https;nobranch=1"
-SRCREV_armhf ?= "ipipe-core-5.4.151-arm-4"
-PV_armhf ?= "5.4.151+"
+SRCREV_armhf ?= "ipipe-core-5.4.180-arm-5"
+
+PV ?= "${@d.getVar('SRCREV').split('-')[2]}+"
 
 S = "${WORKDIR}/git"
-- 
2.35.3

