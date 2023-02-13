Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DF91FA8
	for <xenomai@lists.linux.dev>; Mon, 13 Feb 2023 07:11:28 +0000 (UTC)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2023021307011834c47ab2386ce5d67e
        for <xenomai@lists.linux.dev>;
        Mon, 13 Feb 2023 08:01:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=GO6GgFxobk0LSqgPAMZGtTjy0p33d2T3uc+zsy36Mg0=;
 b=SxbxZuImLA3aVTlyli2Znpp+K2kQTC0CmoSPgeEW3xQDmMKdWLssi82BD7QYWjN0iCGex1
 reEh+QDXhsftQWv5lHaC3dPv7EwVSV8tyze3zQedVpxu0XeJLVmgLUJmOoxmF/MbagZk1cMn
 WVn0uwXtvIqdt81FlKDZbLiBCp+Go=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH 1/7] linux-xenomai: Move S assignment into common include
Date: Mon, 13 Feb 2023 08:01:10 +0100
Message-Id: <c0e1f16401299727df5d58ab0c946817b521171e.1676271676.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1676271676.git.jan.kiszka@siemens.com>
References: <cover.1676271676.git.jan.kiszka@siemens.com>
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
 recipes-kernel/linux/linux-xenomai.inc       | 2 ++
 recipes-kernel/linux/linux-xenomai_4.19.bb   | 2 --
 recipes-kernel/linux/linux-xenomai_4.4.bb    | 2 --
 recipes-kernel/linux/linux-xenomai_5.10.bb   | 2 --
 recipes-kernel/linux/linux-xenomai_5.15.bb   | 2 --
 recipes-kernel/linux/linux-xenomai_5.4.bb    | 2 --
 recipes-kernel/linux/linux-xenomai_latest.bb | 2 --
 7 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/recipes-kernel/linux/linux-xenomai.inc b/recipes-kernel/linux/linux-xenomai.inc
index f0f809d..7d69519 100644
--- a/recipes-kernel/linux/linux-xenomai.inc
+++ b/recipes-kernel/linux/linux-xenomai.inc
@@ -21,6 +21,8 @@ SRC_URI += "${@'file://${KERNEL_DEFCONFIG}' if d.getVar('KERNEL_DEFCONFIG') == d
 SRC_URI += "${@'file://common_nodbg.cfg' if d.getVar('XENOMAI_DEBUG') == '0' else ''}"
 SRC_URI += "file://rules.tmpl"
 
+S = "${WORKDIR}/git"
+
 DEPENDS += "xenomai-kernel-source"
 KBUILD_DEPENDS += "xenomai-kernel-source:native"
 
diff --git a/recipes-kernel/linux/linux-xenomai_4.19.bb b/recipes-kernel/linux/linux-xenomai_4.19.bb
index d02def6..8194ea5 100644
--- a/recipes-kernel/linux/linux-xenomai_4.19.bb
+++ b/recipes-kernel/linux/linux-xenomai_4.19.bb
@@ -21,5 +21,3 @@ SRC_URI_append_armhf = " git://github.com/xenomai-ci/ipipe-arm.git;protocol=http
 SRCREV_armhf ?= "ipipe-core-4.19.229-cip67-arm-18"
 
 PV ?= "${@d.getVar('SRCREV').split('-')[2]}+"
-
-S = "${WORKDIR}/git"
diff --git a/recipes-kernel/linux/linux-xenomai_4.4.bb b/recipes-kernel/linux/linux-xenomai_4.4.bb
index dc64a85..bf00fdc 100644
--- a/recipes-kernel/linux/linux-xenomai_4.4.bb
+++ b/recipes-kernel/linux/linux-xenomai_4.4.bb
@@ -19,5 +19,3 @@ SRC_URI_append_armhf = " ${@ 'file://bbb_4.4.cfg' if d.getVar('MACHINE') == 'bea
 SRCREV_armhf ?= "ipipe-core-4.4.302-cip71-arm-20"
 
 PV ?= "${@d.getVar('SRCREV').split('-')[2]}+"
-
-S = "${WORKDIR}/git"
diff --git a/recipes-kernel/linux/linux-xenomai_5.10.bb b/recipes-kernel/linux/linux-xenomai_5.10.bb
index 4500864..1c98d29 100644
--- a/recipes-kernel/linux/linux-xenomai_5.10.bb
+++ b/recipes-kernel/linux/linux-xenomai_5.10.bb
@@ -15,5 +15,3 @@ SRC_URI += "git://source.denx.de/xenomai/linux-dovetail.git;protocol=https;nobra
 SRCREV ?= "v5.10.161-dovetail1"
 
 PV ?= "${@d.getVar('SRCREV').strip('-')[0].lstrip('v')}+"
-
-S = "${WORKDIR}/git"
diff --git a/recipes-kernel/linux/linux-xenomai_5.15.bb b/recipes-kernel/linux/linux-xenomai_5.15.bb
index 724c73b..168334c 100644
--- a/recipes-kernel/linux/linux-xenomai_5.15.bb
+++ b/recipes-kernel/linux/linux-xenomai_5.15.bb
@@ -15,5 +15,3 @@ SRC_URI += "git://source.denx.de/xenomai/linux-dovetail.git;protocol=https;nobra
 SRCREV ?= "v5.15.85-dovetail1"
 
 PV ?= "${@d.getVar('SRCREV').strip('-')[0].lstrip('v')}+"
-
-S = "${WORKDIR}/git"
diff --git a/recipes-kernel/linux/linux-xenomai_5.4.bb b/recipes-kernel/linux/linux-xenomai_5.4.bb
index 716d92d..104955f 100644
--- a/recipes-kernel/linux/linux-xenomai_5.4.bb
+++ b/recipes-kernel/linux/linux-xenomai_5.4.bb
@@ -21,5 +21,3 @@ SRC_URI_append_armhf = " git://github.com/xenomai-ci/ipipe-arm.git;protocol=http
 SRCREV_armhf ?= "ipipe-core-5.4.180-arm-5"
 
 PV ?= "${@d.getVar('SRCREV').split('-')[2]}+"
-
-S = "${WORKDIR}/git"
diff --git a/recipes-kernel/linux/linux-xenomai_latest.bb b/recipes-kernel/linux/linux-xenomai_latest.bb
index 9a8c6fd..6804391 100644
--- a/recipes-kernel/linux/linux-xenomai_latest.bb
+++ b/recipes-kernel/linux/linux-xenomai_latest.bb
@@ -72,5 +72,3 @@ SRC_URI += "${GIT_REPO};protocol=https;branch=${GIT_BRANCH}"
 SRCREV = "${AUTOREV}"
 
 SRC_URI_append_armhf = " ${@ 'file://bbb_4.4.cfg' if is_xeno_3_0(d) and d.getVar('MACHINE') == 'beagle-bone-black' else '' }"
-
-S = "${WORKDIR}/git"
-- 
2.35.3

