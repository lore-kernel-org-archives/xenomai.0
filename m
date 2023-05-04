Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55D51111
	for <xenomai@lists.linux.dev>; Thu,  4 May 2023 07:58:49 +0000 (UTC)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202305040758467582864fdfbc6a7156
        for <xenomai@lists.linux.dev>;
        Thu, 04 May 2023 09:58:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=EAgNu9mVgwuoMudZ60R8Ro+imD1taptQuYprCbH/FwY=;
 b=k4Oi+XPfPSLm1/WhWR4/A5766DW2iy2yuuLZGgnU7KwCpTSWZEsgOqdtw3WzeeD89aGfLY
 U7HpyGTorvZtaO5I17SQrCJ5PkgWSKtLB6QdHwi22jqof2PQohsurP1Qv/Z8YIW1vVnLcQz9
 5tz70ywbsGEUQ8R5UA+d6Zsg2Qq7o=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Thu, 04 May 2023 09:58:41 +0200
Subject: [PATCH xenomai-images v2 3/4] xenomai-demo: Switch base
 distribution to Debian bookworm
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230503-flo-debian-bookworm-update-v2-3-f859df1417e6@siemens.com>
References: <20230503-flo-debian-bookworm-update-v2-0-f859df1417e6@siemens.com>
In-Reply-To: <20230503-flo-debian-bookworm-update-v2-0-f859df1417e6@siemens.com>
To: jan.kiszka@siemens.com, xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Bookworm ships a glibc version (>= 2.34) that allows us to enable y2038
support within xenomai and the testsuite.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 conf/distro/xenomai-demo.conf | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/conf/distro/xenomai-demo.conf b/conf/distro/xenomai-demo.conf
index 10c37e1..c99669d 100644
--- a/conf/distro/xenomai-demo.conf
+++ b/conf/distro/xenomai-demo.conf
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2018-2021
+# Copyright (c) Siemens AG, 2018-2023
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -9,12 +9,12 @@
 # SPDX-License-Identifier: MIT
 #
 
-require conf/distro/debian-bullseye.conf
+require conf/distro/debian-bookworm.conf
 
 PREFERRED_VERSION_xenomai ?= "3.2%"
 include conf/distro/include/xenomai-version.inc
 
-HOST_DISTRO ?= "debian-bullseye"
+HOST_DISTRO ?= "debian-bookworm"
 
 KERNEL_NAME = "xenomai"
 

-- 
2.39.2

