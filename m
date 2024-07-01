Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5B859160
	for <xenomai@lists.linux.dev>; Mon,  1 Jul 2024 07:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719817704; cv=none; b=E2kc79f6zxZK/zHdh1yoiOXtWz/GtiO+XaFikzG/1fgDykIT26ZwCktKQIHEpf1Vht3RE2FkmZI8VYu5SA1ZAffRhAsA4S541kewRimPypvn6icIOvcj1GWZhHH1Z0MXTsy/HP63TYklQo00f2FqrUFf1uV1R4byPUPx7EhnUMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719817704; c=relaxed/simple;
	bh=X+uJfntHkQkCmqn89mNg1MerO8PIA84xP5iOQZtfYsU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NnlEaOIpu3LKpm3cqYWGgqw1sbE5UIJ7OPnbi8Xakv6eANwxJ+K5a6jyd1L8qq24SCdmOuHIi5HvHaDm29xAOHi/TjL4QDaaB3dB8xBVkV9rjarmQlwdBbv39uGWO1QTrCFkodkS/JYSQwuw6ieJC24f8gT27YvgZNKjItBwXrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=yi.jiang@siemens.com header.b=Sgy0sklj; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=yi.jiang@siemens.com header.b="Sgy0sklj"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20240701070811add4e8d8c0b8c28290
        for <xenomai@lists.linux.dev>;
        Mon, 01 Jul 2024 09:08:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=yi.jiang@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=+lKLyShTQNNLv/yDyQhXfgQ8ICT5kPFjfeNHpSZJZFc=;
 b=Sgy0skljOxDoARPCyFmubpdkjeiJUc2tuxF0iOWa+cxAuDv32e11D6Jlck7HLzvbMhMT0f
 UJdyuJZVgJ9evqbiUkyj/u0dzC/Hql9LjbFVB+GCuCPFoHCgyRjwOFktoQcRnunEpkg5jTtW
 i8/5+SbM4f+fsfTQKaY8WCffKxSpQ=;
From: Yi Jiang <yi.jiang@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	florian.bezdeka@siemens.com,
	quirin.gylstorff@siemens.com,
	Yi Jiang <yi.jiang@siemens.com>
Subject: [PATCH v2 2/4] ci: add gitlab-ci-base configurations for rpi4
Date: Mon,  1 Jul 2024 09:08:05 +0200
Message-Id: <20240701070807.14465-3-yi.jiang@siemens.com>
In-Reply-To: <20240701070807.14465-1-yi.jiang@siemens.com>
References: <20240701070807.14465-1-yi.jiang@siemens.com>
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

