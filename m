Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3124D1FA8
	for <xenomai@lists.linux.dev>; Mon, 13 Feb 2023 07:41:36 +0000 (UTC)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20230213070118a28d069897cf90b68d
        for <xenomai@lists.linux.dev>;
        Mon, 13 Feb 2023 08:01:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=lyT5hQRCeMn/VQpr67dFU5yBclhmOhpxjwA2jDj1Fz0=;
 b=WGREfVWWJ+Ps3ppNflHQ5INyOhS2xwc8oT4uAPMLTEdz67ck4xFr6ANdXvmfp8oZhZJLyM
 MOOQjeoBxdWt+28oo/pJmPBWnkHzb2aico+te02KbyaqEQH/ZBmdQiv5aWd3UUdKL4Yj6PKf
 dgM+WsR5Ddmgz6EPOu8jKmCN7FWaE=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH 2/7] linux-xenomai: Factor out linux-xenomai-dovetail.inc
Date: Mon, 13 Feb 2023 08:01:11 +0100
Message-Id: <1229a794aab2012c8d13335d006c11f9764e1fc1.1676271676.git.jan.kiszka@siemens.com>
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

Two lines to share per kernel, and there is another kernel upcoming.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../{linux-xenomai_5.15.bb => linux-xenomai-dovetail.inc}    | 1 -
 recipes-kernel/linux/linux-xenomai_5.10.bb                   | 5 +----
 recipes-kernel/linux/linux-xenomai_5.15.bb                   | 5 +----
 3 files changed, 2 insertions(+), 9 deletions(-)
 copy recipes-kernel/linux/{linux-xenomai_5.15.bb => linux-xenomai-dovetail.inc} (91%)

diff --git a/recipes-kernel/linux/linux-xenomai_5.15.bb b/recipes-kernel/linux/linux-xenomai-dovetail.inc
similarity index 91%
copy from recipes-kernel/linux/linux-xenomai_5.15.bb
copy to recipes-kernel/linux/linux-xenomai-dovetail.inc
index 168334c..05d775e 100644
--- a/recipes-kernel/linux/linux-xenomai_5.15.bb
+++ b/recipes-kernel/linux/linux-xenomai-dovetail.inc
@@ -12,6 +12,5 @@
 require recipes-kernel/linux/linux-xenomai.inc
 
 SRC_URI += "git://source.denx.de/xenomai/linux-dovetail.git;protocol=https;nobranch=1"
-SRCREV ?= "v5.15.85-dovetail1"
 
 PV ?= "${@d.getVar('SRCREV').strip('-')[0].lstrip('v')}+"
diff --git a/recipes-kernel/linux/linux-xenomai_5.10.bb b/recipes-kernel/linux/linux-xenomai_5.10.bb
index 1c98d29..986060d 100644
--- a/recipes-kernel/linux/linux-xenomai_5.10.bb
+++ b/recipes-kernel/linux/linux-xenomai_5.10.bb
@@ -9,9 +9,6 @@
 # SPDX-License-Identifier: MIT
 #
 
-require recipes-kernel/linux/linux-xenomai.inc
+require recipes-kernel/linux/linux-xenomai-dovetail.inc
 
-SRC_URI += "git://source.denx.de/xenomai/linux-dovetail.git;protocol=https;nobranch=1"
 SRCREV ?= "v5.10.161-dovetail1"
-
-PV ?= "${@d.getVar('SRCREV').strip('-')[0].lstrip('v')}+"
diff --git a/recipes-kernel/linux/linux-xenomai_5.15.bb b/recipes-kernel/linux/linux-xenomai_5.15.bb
index 168334c..63865eb 100644
--- a/recipes-kernel/linux/linux-xenomai_5.15.bb
+++ b/recipes-kernel/linux/linux-xenomai_5.15.bb
@@ -9,9 +9,6 @@
 # SPDX-License-Identifier: MIT
 #
 
-require recipes-kernel/linux/linux-xenomai.inc
+require recipes-kernel/linux/linux-xenomai-dovetail.inc
 
-SRC_URI += "git://source.denx.de/xenomai/linux-dovetail.git;protocol=https;nobranch=1"
 SRCREV ?= "v5.15.85-dovetail1"
-
-PV ?= "${@d.getVar('SRCREV').strip('-')[0].lstrip('v')}+"
-- 
2.35.3

