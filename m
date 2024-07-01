Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD155F876
	for <xenomai@lists.linux.dev>; Mon,  1 Jul 2024 07:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719817704; cv=none; b=dLdMrrxe91rIIN2D7OrrNf2Bd4buGD6/VWLJGt5Xr+DvwOYTNnAz5zXS2o4tgbpbyICQgIod6U8sWg46rvNuikSyUlg45L9ODBMHG5p1H7QdLhX83ZDU0jQFIS0xUsnt6pwGZexH6iEqq+m2ADGLMcGwgEnZmCORlMWiJOs1YmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719817704; c=relaxed/simple;
	bh=Isr5Mg8gsPvDYn5p+lgNCwB9oeaGxnyx54gzfYjlncw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OVwi6G1DIK9dfKHlK/XVD2cjIDPRxireeZxGThpxoSGeTx61mpdHo8EF5R9AgTSl0sGYcLnL2WDsPygA06oP6DysKQ/5SJayOrFGkGdPvLHIm0xVY9xmligmOhkX1XIINe67BbLC8NIwNXKnH/0iHabMHb2JA+J6KKTBtMX/Ru8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=yi.jiang@siemens.com header.b=SBxh6TR+; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=yi.jiang@siemens.com header.b="SBxh6TR+"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20240701070812850f60d1c58ac0f07f
        for <xenomai@lists.linux.dev>;
        Mon, 01 Jul 2024 09:08:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=yi.jiang@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=wIK0EatQXgp3d1PY4IhGzsIRj5W9sWlPsqhdQNqpQes=;
 b=SBxh6TR+LeJp7SOBkEsMDKuKpDD8abxPaXBVzpWZOdL95QiK/zP4JV3T2AA1QYxIDqNSbf
 o9cXwb3xdUPZ4KQb/g25JkF6wiMgoueOhWaZcZTbuC8f14CoLTEXmlV6samwulrHYrMsaQRO
 +LOTzb4BxYG843MWKCm1OfjP9QLko=;
From: Yi Jiang <yi.jiang@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	florian.bezdeka@siemens.com,
	quirin.gylstorff@siemens.com,
	Yi Jiang <yi.jiang@siemens.com>
Subject: [PATCH v2 4/4] ci: use rpi4 instead of hikey for kernel 6.6 deployment
Date: Mon,  1 Jul 2024 09:08:07 +0200
Message-Id: <20240701070807.14465-5-yi.jiang@siemens.com>
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
 ci/kernel_6_6.yml | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/ci/kernel_6_6.yml b/ci/kernel_6_6.yml
index f13d28d..3d1e3ec 100644
--- a/ci/kernel_6_6.yml
+++ b/ci/kernel_6_6.yml
@@ -48,16 +48,16 @@ lava-test-6.6:qemu-arm64:
   variables:
     KERNEL_VERSION: "6.6"
 
-build-6.6:hikey:
-  extends: .build:hikey
+build-6.6:rpi4:
+  extends: .build:rpi4
   variables:
     LINUX_BUILD_OPTION: ":opt-linux-latest-6.6.yml"
     KERNEL_VERSION: "6.6"
     CACHE_KERNEL: dovetail
 
-lava-test-6.6:hikey:
-  needs: [ "build-6.6:hikey" ]
-  extends: .lava-test:hikey
+lava-test-6.6:rpi4:
+  needs: [ "build-6.6:rpi4" ]
+  extends: .lava-test:rpi4
   variables:
     KERNEL_VERSION: "6.6"
 
-- 
2.39.2

