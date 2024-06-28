Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42511411EE
	for <xenomai@lists.linux.dev>; Fri, 28 Jun 2024 12:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719577294; cv=none; b=KfH0n0IGn/M+tGtAoFuQs/saeHvI4qmXKBItYQ18re5aHJkxR0qf9NXwSnAOuF3dkkDpI0z4AGJSKEGmapsGiznR25TbkzLWFt8aofTUsrKcx5u8cXlGN+ukLiosrEcKI07q3FuV9Z4MGWlo3RMMlQzRToYTryctGxVwLeDANA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719577294; c=relaxed/simple;
	bh=BD8TFi3gJLdLADGtR3bskxwOSZg8nChV6LpA1r3bOfs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A+JqNHqHbGyyWAVKjCSlTHnNKvwqcCzOvKC82mlIUuCQn5vfmscUJvIb7wbB4xtYVxm6bwmQknaPLX3Gy0Yi5C8STEmKjlIUHVx5WFGBxLbfmSLIdhP7cWtdNxSx/Bc1OD1Si48AqqYI+Fk8Z5uJYBWKnIDN63hlAeV3OEeNAXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=yi.jiang@siemens.com header.b=wKBugM7n; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=yi.jiang@siemens.com header.b="wKBugM7n"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20240628122122a4b88af9c694c6e576
        for <xenomai@lists.linux.dev>;
        Fri, 28 Jun 2024 14:21:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=yi.jiang@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=oKHk5FG0Co8V00ToOqhCgi+kRRFAS27xqjZpA+Q/Bf8=;
 b=wKBugM7nrm5eTFFAHVakz/nIPruP2LYZZjTvtc8J0638EbPi5aivxbk1bDXhUauzjHdXVm
 MvhL1KE1UfZBVvsDaledpq1QHVKhpFVB/dbYmDdxMSdOdox/F0RIod52qU8Jam8tBvqlxIeg
 WK94KIRZ0ZIwZV8SADZtz7vWQcNh8=;
From: Yi Jiang <yi.jiang@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	florian.bezdeka@siemens.com,
	quirin.gylstorff@siemens.com,
	Yi Jiang <yi.jiang@siemens.com>
Subject: [PATCH 3/4] ci: add kernel support for rpi4
Date: Fri, 28 Jun 2024 14:21:16 +0200
Message-Id: <20240628122117.19059-4-yi.jiang@siemens.com>
In-Reply-To: <20240628122117.19059-1-yi.jiang@siemens.com>
References: <20240628122117.19059-1-yi.jiang@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1325609:519-21489:flowmailer

Signed-off-by: Yi Jiang <yi.jiang@siemens.com>
---
 ci/kernel_5_10.yml | 15 ++++++++++++++-
 ci/kernel_5_15.yml | 15 ++++++++++++++-
 ci/kernel_6_1.yml  | 15 ++++++++++++++-
 ci/kernel_6_6.yml  | 13 +++++++++++++
 4 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/ci/kernel_5_10.yml b/ci/kernel_5_10.yml
index 44cd6d6..36c2e06 100644
--- a/ci/kernel_5_10.yml
+++ b/ci/kernel_5_10.yml
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2019 - 2022
+# Copyright (c) Siemens AG, 2019 - 2024
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -61,6 +61,19 @@ lava-test-5.10:hikey:
   variables:
     KERNEL_VERSION: "5.10"
 
+build-5.10:rpi4:
+  extends: .build:rpi4
+  variables:
+    LINUX_BUILD_OPTION: ":opt-linux-latest-5.10.yml"
+    KERNEL_VERSION: "5.10"
+    CACHE_KERNEL: dovetail
+
+lava-test-5.10:rpi4:
+  needs: [ "build-5.10:rpi4" ]
+  extends: .lava-test:rpi4
+  variables:
+    KERNEL_VERSION: "5.10"
+
 build-5.10:beagle-bone-black:
   extends: .build:beagle-bone-black
   variables:
diff --git a/ci/kernel_5_15.yml b/ci/kernel_5_15.yml
index 52710fd..e17275a 100644
--- a/ci/kernel_5_15.yml
+++ b/ci/kernel_5_15.yml
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2022
+# Copyright (c) Siemens AG, 2022 - 2024
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -61,6 +61,19 @@ lava-test-5.15:hikey:
   variables:
     KERNEL_VERSION: "5.15"
 
+build-5.15:rpi4:
+  extends: .build:rpi4
+  variables:
+    LINUX_BUILD_OPTION: ":opt-linux-latest-5.15.yml"
+    KERNEL_VERSION: "5.15"
+    CACHE_KERNEL: dovetail
+
+lava-test-5.15:rpi4:
+  needs: [ "build-5.15:rpi4" ]
+  extends: .lava-test:rpi4
+  variables:
+    KERNEL_VERSION: "5.15"
+
 build-5.15:beagle-bone-black:
   extends: .build:beagle-bone-black
   variables:
diff --git a/ci/kernel_6_1.yml b/ci/kernel_6_1.yml
index 1c6a6d7..cd7906d 100644
--- a/ci/kernel_6_1.yml
+++ b/ci/kernel_6_1.yml
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2022-2023
+# Copyright (c) Siemens AG, 2022-2024
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -61,6 +61,19 @@ lava-test-6.1:hikey:
   variables:
     KERNEL_VERSION: "6.1"
 
+build-6.1:rpi4:
+  extends: .build:rpi4
+  variables:
+    LINUX_BUILD_OPTION: ":opt-linux-latest-6.1.yml"
+    KERNEL_VERSION: "6.1"
+    CACHE_KERNEL: dovetail
+
+lava-test-6.1:rpi4:
+  needs: [ "build-6.1:rpi4" ]
+  extends: .lava-test:rpi4
+  variables:
+    KERNEL_VERSION: "6.1"
+
 build-6.1:beagle-bone-black:
   extends: .build:beagle-bone-black
   variables:
diff --git a/ci/kernel_6_6.yml b/ci/kernel_6_6.yml
index f13d28d..d840d26 100644
--- a/ci/kernel_6_6.yml
+++ b/ci/kernel_6_6.yml
@@ -61,6 +61,19 @@ lava-test-6.6:hikey:
   variables:
     KERNEL_VERSION: "6.6"
 
+build-6.6:rpi4:
+  extends: .build:rpi4
+  variables:
+    LINUX_BUILD_OPTION: ":opt-linux-latest-6.6.yml"
+    KERNEL_VERSION: "6.6"
+    CACHE_KERNEL: dovetail
+
+lava-test-6.6:rpi4:
+  needs: [ "build-6.6:rpi4" ]
+  extends: .lava-test:rpi4
+  variables:
+    KERNEL_VERSION: "6.6"
+
 build-6.6:beagle-bone-black:
   extends: .build:beagle-bone-black
   variables:
-- 
2.39.2

