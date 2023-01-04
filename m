Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C316BAD42
	for <xenomai@lists.linux.dev>; Wed,  4 Jan 2023 15:31:49 +0000 (UTC)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202301041521363420cd2c96de12b0c1
        for <xenomai@lists.linux.dev>;
        Wed, 04 Jan 2023 16:21:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=SoYPBipa5RtqEen25q7a6VhKf+tP5yrnIaoF84Fq43U=;
 b=in9b8UV8B/AcBiiAtTHk4ZHoCDJyMq1t3fDt1T+kEHhidtNuUHjRVulhY5NibbYrYnr7Re
 QMMofAi2gjj6niA95zdqSnepHFgHy2qXfJIHpt12f9dyBfPDUi+Nq9gI0Yp6RNPS7u4Rq2Yy
 YD0OG0ZiLRtTbZizEbKRQ4dZxE6PU=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH 2/3] xenomai: Update to latest releases
Date: Wed,  4 Jan 2023 16:21:34 +0100
Message-Id: <e83d519619c6a682cf29093f2eefa77fc47ed46e.1672845695.git.jan.kiszka@siemens.com>
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

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 conf/distro/include/xenomai-version.inc                   | 8 ++++----
 .../xenomai/{xenomai_3.0.12.bb => xenomai_3.0.13.bb}      | 0
 .../xenomai/{xenomai_3.1.2.bb => xenomai_3.1.3.bb}        | 0
 .../xenomai/{xenomai_3.2.1.bb => xenomai_3.2.2.bb}        | 0
 4 files changed, 4 insertions(+), 4 deletions(-)
 rename recipes-xenomai/xenomai/{xenomai_3.0.12.bb => xenomai_3.0.13.bb} (100%)
 rename recipes-xenomai/xenomai/{xenomai_3.1.2.bb => xenomai_3.1.3.bb} (100%)
 rename recipes-xenomai/xenomai/{xenomai_3.2.1.bb => xenomai_3.2.2.bb} (100%)

diff --git a/conf/distro/include/xenomai-version.inc b/conf/distro/include/xenomai-version.inc
index 7bd80ef..61e86f7 100644
--- a/conf/distro/include/xenomai-version.inc
+++ b/conf/distro/include/xenomai-version.inc
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2019-2022
+# Copyright (c) Siemens AG, 2019-2023
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -11,13 +11,13 @@
 
 XENOMAI_DEFAULT_KERNEL_VERSION = "5.15%"
 
-XENOMAI_3_0_VERSION_LIST = "3.0 3.0% 3.0.% 3.0.12 stable-3.0.x"
+XENOMAI_3_0_VERSION_LIST = "3.0 3.0% 3.0.% 3.0.13 stable-3.0.x"
 XENOMAI_3_0_KERNEL_VERSION = "4.4%"
 
-XENOMAI_3_1_VERSION_LIST = "3.1 3.1% 3.1.% 3.1.2 stable-3.1.x"
+XENOMAI_3_1_VERSION_LIST = "3.1 3.1% 3.1.% 3.1.3 stable-3.1.x"
 XENOMAI_3_1_KERNEL_VERSION = "5.4%"
 
-XENOMAI_3_2_VERSION_LIST = "3.2 3.2% 3.2.% 3.2.1 stable-3.2.x"
+XENOMAI_3_2_VERSION_LIST = "3.2 3.2% 3.2.% 3.2.2 stable-3.2.x"
 XENOMAI_3_2_KERNEL_VERSION = "5.10%"
 
 # If PREFERRED_VERSION_xenomai contains any item from XENOMAI_3_0_VERSION_LIST use
diff --git a/recipes-xenomai/xenomai/xenomai_3.0.12.bb b/recipes-xenomai/xenomai/xenomai_3.0.13.bb
similarity index 100%
rename from recipes-xenomai/xenomai/xenomai_3.0.12.bb
rename to recipes-xenomai/xenomai/xenomai_3.0.13.bb
diff --git a/recipes-xenomai/xenomai/xenomai_3.1.2.bb b/recipes-xenomai/xenomai/xenomai_3.1.3.bb
similarity index 100%
rename from recipes-xenomai/xenomai/xenomai_3.1.2.bb
rename to recipes-xenomai/xenomai/xenomai_3.1.3.bb
diff --git a/recipes-xenomai/xenomai/xenomai_3.2.1.bb b/recipes-xenomai/xenomai/xenomai_3.2.2.bb
similarity index 100%
rename from recipes-xenomai/xenomai/xenomai_3.2.1.bb
rename to recipes-xenomai/xenomai/xenomai_3.2.2.bb
-- 
2.35.3

