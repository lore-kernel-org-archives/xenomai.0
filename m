Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5040A48CCC
	for <xenomai@lists.linux.dev>; Fri, 24 May 2024 15:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716563028; cv=none; b=so1s7txdUXLiMh8OBTDFiz2ATrY0LAhZhQcK76jKASQkNKHb+ETIu+MlwYTBPFJeqC9OleVH4clFmWk0Wut8LnTCUYr5JHePwEchqM2MAt4OgbnPoQrh5FcIedM3itNCzFaqQ92G4nVP0fB6qoCgSxP7fEI/3kvtaNE6SGGUCLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716563028; c=relaxed/simple;
	bh=y+h4xdzzEkGRobMnuyec32+GX8mty74EfPEo4gMYX60=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iby7I9ZH0sgSoFyGMIphcLCr1y8kWL7SehFcgoysaWspJlmYHo8WU6wToIZQG8gUBP93pPSwP8A12lotlAWEqd8fj6+t7iwhFhGTn4lHfsTOXtOtdaH0dI6wesLLStYhGsQRbn6yjDyAV58dX5jyJIotwZNB4tcvJmo5AA4lSeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=yi.jiang@siemens.com header.b=Sf0g6kbA; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=yi.jiang@siemens.com header.b="Sf0g6kbA"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20240524150340ede122621c5962b7ed
        for <xenomai@lists.linux.dev>;
        Fri, 24 May 2024 17:03:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=yi.jiang@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=wVmDazAe5s1pVVCGbobRhVTVJFbufJagRmWEWuuqUA0=;
 b=Sf0g6kbATyGcTSINwUbHJMmTGpmZv6e2K9k9rMfa4XjqROsd6fys5Gy6xxsqyK6uxS0MyQ
 l+FRIO+MNDOL7B7YMF2XFwzYX5aB4+bpOaL1W8TV+gAQ1Dt+H9GawHVb+gkhq8/GFRRBsM6m
 CNEtSilgRqpMTHChnuqoBvOWW2Kbc=;
From: Yi Jiang <yi.jiang@siemens.com>
To: xenomai@lists.linux.dev
Cc: florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Yi Jiang <yi.jiang@siemens.com>
Subject: [PATCH v3 3/3] rpi4: add building options for rpi4; remove build options of old kernel and Xenomai versions in kas menu for rpi4.
Date: Fri, 24 May 2024 17:03:35 +0200
Message-Id: <20240524150335.23090-4-yi.jiang@siemens.com>
In-Reply-To: <20240524150335.23090-1-yi.jiang@siemens.com>
References: <20240524150335.23090-1-yi.jiang@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1325609:519-21489:flowmailer

For RPi4, the following building option of kernel version is not supported any more. Therefore, it is removed from kas menu.

 - Xenomai 3, Head of stable/v3.1.x branch.

For RPi4, the following building options of Xenomai versions are not supported any more. Therefore, they are removed from kas menu.

 - Xenomai 3, Latest 4.19-cip I-pipe release;
 - Xenomai 3, Head of 4.19-cip I-pipe branch;
 - Xenomai 3, Latest 5.4 I-pipe release;
 - Xenomai 3, Head of 5.4 I-pipe branch.

Signed-off-by: Yi Jiang <yi.jiang@siemens.com>
---
 Kconfig | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/Kconfig b/Kconfig
index 669ea65..13699bf 100644
--- a/Kconfig
+++ b/Kconfig
@@ -45,6 +45,10 @@ config TARGET_HIKEY
 	bool "LeMaker HiKey"
 	select ARCH_ARM64
 
+config TARGET_RPI4
+	bool "Raspberry Pi 4"
+	select ARCH_ARM64
+
 endchoice
 
 config KAS_INCLUDE_TARGET
@@ -55,6 +59,7 @@ config KAS_INCLUDE_TARGET
 	default "board-beagle-bone-black.yml" if TARGET_BBB
 	default "board-qemu-arm64.yml" if TARGET_QEMU_ARM64
 	default "board-hikey.yml" if TARGET_HIKEY
+	default "board-rpi4.yml" if TARGET_RPI4
 
 choice
 	prompt "Xenomai version"
@@ -85,6 +90,7 @@ config XENOMAI_3_2
 
 config XENOMAI_3_1_LATEST
 	bool "Head of stable/v3.1.x branch"
+	depends on !TARGET_RPI4
 
 config XENOMAI_3_0_LATEST
 	bool "Head of stable/v3.0.x branch"
@@ -141,19 +147,19 @@ config KERNEL_5_10
 
 config KERNEL_5_4_LATEST
 	bool "Head of 5.4 I-pipe branch"
-	depends on XENOMAI_3_2_LATEST || XENOMAI_3_2 || XENOMAI_3_1_LATEST || XENOMAI_3_1
+	depends on !TARGET_RPI4 && (XENOMAI_3_2_LATEST || XENOMAI_3_2 || XENOMAI_3_1_LATEST || XENOMAI_3_1)
 
 config KERNEL_5_4
 	bool "Latest 5.4 I-pipe release"
-	depends on XENOMAI_3_2_LATEST || XENOMAI_3_2 || XENOMAI_3_1_LATEST || XENOMAI_3_1
+	depends on !TARGET_RPI4 && (XENOMAI_3_2_LATEST || XENOMAI_3_2 || XENOMAI_3_1_LATEST || XENOMAI_3_1)
 
 config KERNEL_4_19_LATEST
 	bool "Head of 4.19-cip I-pipe branch"
-	depends on XENOMAI_3_2_LATEST || XENOMAI_3_2 || XENOMAI_3_1_LATEST || XENOMAI_3_1
+	depends on !TARGET_RPI4 && (XENOMAI_3_2_LATEST || XENOMAI_3_2 || XENOMAI_3_1_LATEST || XENOMAI_3_1)
 
 config KERNEL_4_19
 	bool "Latest 4.19-cip I-pipe release"
-	depends on XENOMAI_3_2_LATEST || XENOMAI_3_2 || XENOMAI_3_1_LATEST || XENOMAI_3_1
+	depends on !TARGET_RPI4 && (XENOMAI_3_2_LATEST || XENOMAI_3_2 || XENOMAI_3_1_LATEST || XENOMAI_3_1)
 
 config KERNEL_4_4_LATEST
 	bool "Head of 4.4-cip I-pipe branch"
-- 
2.39.2

