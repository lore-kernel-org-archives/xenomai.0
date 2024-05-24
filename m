Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047F642078
	for <xenomai@lists.linux.dev>; Fri, 24 May 2024 11:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716549197; cv=none; b=G9hOlRz+J37usvVOzNyvRiVeszxHm2hA8/kotc1XrAJUBRTAiSvCCMg2Ec3/SSHgzMN98KaN8J+7xZPHT4i07jqXm3LoPBVAucwEPK+bekzJEojXOGzkOobjUyYBHB+3XrTaUBwhJAvQHP7/dR+Ozh7b2lKv1xjookFZdhbXJn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716549197; c=relaxed/simple;
	bh=y+h4xdzzEkGRobMnuyec32+GX8mty74EfPEo4gMYX60=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=krl3QWAryokvLhyxnSVR5prMLWE5a3OvgJKKxYWTpZ1wuBVPxFeIaeJdL8bgXzKgkdgKbI3+HJCGq3twJsob34wEq2n6Lvcu/k5RavpuTI99m7ARxItr/0O44TktnmNP0LsPsAqK0jZziAIKE/Bh+RP8ZncfBFcfkA3te0+XkxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=yi.jiang@siemens.com header.b=Xtd1haIe; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=yi.jiang@siemens.com header.b="Xtd1haIe"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202405241103008e9bad942a6ea488e1
        for <xenomai@lists.linux.dev>;
        Fri, 24 May 2024 13:03:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=yi.jiang@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=wVmDazAe5s1pVVCGbobRhVTVJFbufJagRmWEWuuqUA0=;
 b=Xtd1haIevxL4+IjmfluNTguGDMGV9pbd70M4+Ir8NVYENlqWFUcT7zslcb6JdVz3Yq56En
 0IQO6kpGHUZ4egDguqLzMk8HiuzkafpluyDvEAfmwZfzVNLo6OQWbltCdmtjsv1NRsd2vEgB
 GXhhHW9ZFodMYM5xGPCwoAevUlTws=;
From: Yi Jiang <yi.jiang@siemens.com>
To: xenomai@lists.linux.dev
Cc: florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Yi Jiang <yi.jiang@siemens.com>
Subject: [PATCH v2 3/3] rpi4: add building options for rpi4; remove build options of old kernel and Xenomai versions in kas menu for rpi4.
Date: Fri, 24 May 2024 13:02:54 +0200
Message-Id: <20240524110254.37483-4-yi.jiang@siemens.com>
In-Reply-To: <20240524110254.37483-1-yi.jiang@siemens.com>
References: <20240524110254.37483-1-yi.jiang@siemens.com>
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

