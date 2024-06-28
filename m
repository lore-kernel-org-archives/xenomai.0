Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C721E898
	for <xenomai@lists.linux.dev>; Fri, 28 Jun 2024 12:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719577295; cv=none; b=Q1lBRaAQT5pAU6tsU/KgTG9sKcD0pPfLJcq9iFYltY+HwJeIpPShrNzE8UNuVR1KK13UIiGBYrtxMcZLY6fayVIf9dTkbB2/ANAiazgpTbbEX1lAqubPtq1MlZOhVFZXxwNTnexpQoTfHA9PUhMJvRSQ96HcANXRBQXXGRsNkf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719577295; c=relaxed/simple;
	bh=X+uJfntHkQkCmqn89mNg1MerO8PIA84xP5iOQZtfYsU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kcOsf/hUpB4xNF/xiatMXS3XFxJuFmWQxAxtdoKyVw4wndH2EzNF4hrIoFEL5JZxPpenIMambOE6rFWVdIBWDrXSh2LCMpUzHUqsZxqVYnaBQct9utJT0DIBrCprnZZmJ3qsdm6rHC8nvU3ic8SdPg15mcXPQZHcISK+mZpGFIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=yi.jiang@siemens.com header.b=HTYjGXpx; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=yi.jiang@siemens.com header.b="HTYjGXpx"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20240628122121777537c0886f6adc14
        for <xenomai@lists.linux.dev>;
        Fri, 28 Jun 2024 14:21:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=yi.jiang@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=+lKLyShTQNNLv/yDyQhXfgQ8ICT5kPFjfeNHpSZJZFc=;
 b=HTYjGXpxz1lP5exFIl2g4pmhbYu4Ie30jGtQ1NtiYKv3v5EYjyQIfIwOqxYRh+LiVFiWlg
 KoQefTcPvUYkHJOVRxI2WLfboEdcWH0ybhnw1V5ErCZrJiCBZFXyu6gTy/nsot9mjQtG8Q5t
 9Hio+L1LS7dPP2b/7lDD3229HrilM=;
From: Yi Jiang <yi.jiang@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	florian.bezdeka@siemens.com,
	quirin.gylstorff@siemens.com,
	Yi Jiang <yi.jiang@siemens.com>
Subject: [PATCH 2/4] ci: add gitlab-ci-base configurations for rpi4
Date: Fri, 28 Jun 2024 14:21:15 +0200
Message-Id: <20240628122117.19059-3-yi.jiang@siemens.com>
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
 ci/gitlab-ci-base.yml | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
index c7a1571..1157fa6 100644
--- a/ci/gitlab-ci-base.yml
+++ b/ci/gitlab-ci-base.yml
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2019 - 2023
+# Copyright (c) Siemens AG, 2019 - 2024
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -125,6 +125,18 @@ default:
   variables:
     TARGET: hikey
 
+.build:rpi4:
+  extends: .build
+  variables:
+    TARGET: rpi4
+    CACHE_ARCH: arm64
+
+.lava-test:rpi4:
+  extends: .test
+  resource_group: board-rpi4
+  variables:
+    TARGET: rpi4
+
 .build:beagle-bone-black:
   extends: .build
   variables:
-- 
2.39.2

