Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F1163DC
	for <xenomai@lists.linux.dev>; Wed,  3 May 2023 12:10:16 +0000 (UTC)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202305031210094c95a97c0e292d9e8a
        for <xenomai@lists.linux.dev>;
        Wed, 03 May 2023 14:10:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=EAgNu9mVgwuoMudZ60R8Ro+imD1taptQuYprCbH/FwY=;
 b=JgOVWSUFJxVJ0TBTk/AAQfuYi5v7HaVaYJb6Vi+O6FVN7TCjZ2Z7hR+8Hvo8QbKfpMqGqx
 8G+XsI5mPwrFxpHYXid9oCliOPb0soAHI0zYH+uBHVYAD1K4XqISZDM0EtQxryYuMUJpmEm0
 3n/bWaq6gMObX7ghw+wjzBvRehpqU=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Wed, 03 May 2023 14:10:03 +0200
Subject: [PATCH xenomai-images 2/4] xenomai-demo: Switch base distribution
 to Debian bookworm
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230503-flo-debian-bookworm-update-v1-2-6a4aa9e4d95f@siemens.com>
References: <20230503-flo-debian-bookworm-update-v1-0-6a4aa9e4d95f@siemens.com>
In-Reply-To: <20230503-flo-debian-bookworm-update-v1-0-6a4aa9e4d95f@siemens.com>
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

