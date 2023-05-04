Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E138FC14
	for <xenomai@lists.linux.dev>; Thu,  4 May 2023 07:58:53 +0000 (UTC)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20230504075845de6e90d887439e0b54
        for <xenomai@lists.linux.dev>;
        Thu, 04 May 2023 09:58:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=rX5HjNlCqdVJi1CmbXGm0S6u8O+L3BOtLEMNzG0nLaY=;
 b=XVSjoFh8WpYQvjAVFfmX3R7740XFRrbsLzy3oC9MMkJxaMRjSbEa7oHMDJPaB9JY8L2x6/
 D+EKvRhvLR5TXAhxtDEf5tVo9pPH3Akm6anJl4+SQr5uE8JVFOIgAKlIvSFCLs99Nt3yMWmV
 1MFCGUu1LPKtsdcnJ3pXr9sD3XFWw=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Thu, 04 May 2023 09:58:39 +0200
Subject: [PATCH xenomai-images v2 1/4] ci: Update kas to 3.2.3
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230503-flo-debian-bookworm-update-v2-1-f859df1417e6@siemens.com>
References: <20230503-flo-debian-bookworm-update-v2-0-f859df1417e6@siemens.com>
In-Reply-To: <20230503-flo-debian-bookworm-update-v2-0-f859df1417e6@siemens.com>
To: jan.kiszka@siemens.com, xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 README.md             | 2 +-
 ci/gitlab-ci-base.yml | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/README.md b/README.md
index 392865a..638768b 100644
--- a/README.md
+++ b/README.md
@@ -13,7 +13,7 @@ from scratch.
 
 Install `kas-container` from the [kas project](https://github.com/siemens/kas):
 
-    wget https://raw.githubusercontent.com/siemens/kas/3.1/kas-container -P ~/bin/
+    wget https://raw.githubusercontent.com/siemens/kas/3.2.3/kas-container -P ~/bin/
     chmod a+x ~/bin/kas-container
 
 Furthermore, install docker and make sure you have required permissions to
diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
index b7dd4dc..2dbb82d 100644
--- a/ci/gitlab-ci-base.yml
+++ b/ci/gitlab-ci-base.yml
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2019 - 2022
+# Copyright (c) Siemens AG, 2019 - 2023
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -23,7 +23,7 @@ variables:
   BUILD_IDENTIFIER: "xenomai-${XENOMAI_VERSION}_kernel-${KERNEL_VERSION}"
 
 default:
-  image: ghcr.io/siemens/kas/kas-isar:3.1
+  image: ghcr.io/siemens/kas/kas-isar:3.2.3
 
 .common-config:
   before_script:

-- 
2.39.2

