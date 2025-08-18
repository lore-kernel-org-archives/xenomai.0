Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE30320398
	for <xenomai@lists.linux.dev>; Mon, 18 Aug 2025 12:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755520016; cv=none; b=RoZDljUtzilcBNGn1zYcban6HUe/fgrFwyDamk+J24MxwFWQAU+jD+HDIm8G/l0eHA0CO8ngnEjQ/Jnfj//0t1J6qiDV0kSelYOcYGgSJOZde8DRRLf/jrvYs3PJ0/tVJFd12TSv2xaFbJQX+g5vPWSJDujqcbgjNQ+yTw1DefM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755520016; c=relaxed/simple;
	bh=yD/Cys+qqSVpnDF//IRO+6DChSvQVpSw1GPlSvUE4KU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MWZWRd6XRSzDZzH6N1FqeNqR0lZ95Fxnu1lykARj+i+oOYkVd5eyRhxEVM0lu9AplLeHcQzG+1LggCw8W1MO29UYz7UN2hmhTw8wqaArxHMSzl8pBnzw7k82calfXVEnGyNzvLPwE7tj/X+HOeqTQH0thsdveHlo/jzqzlNOMkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=cXvsn4ND; arc=none smtp.client-ip=185.136.65.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="cXvsn4ND"
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 20250818122645cbbd56f01872e24f4a
        for <xenomai@lists.linux.dev>;
        Mon, 18 Aug 2025 14:26:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=h6a98TEoapcLi1hLE3H7wD20ZO126eARfesgUTBXrFw=;
 b=cXvsn4NDICeVtCl5ElX0W/Ypl1hw8Ixu0e2JJBc1xjGGKeih3zlTApYC3x/mzQqnbH9XvM
 aw0BaVttMybvhMU9w0ErbYUVKRbcAyMbojUKdVaCXG//9SNzE+CUqrA5GLk0qwZWVobokNqI
 JDPY8NPl7dCS0U5+rrUacZiLAjAfHTqn1TGDI7lpQwaBs23ASo0VUA60X68h2RCV2bFIbtUC
 jenMvDzEh6sjj0TOa3p1nd8uoLFfKfD3xhSkLfdZ/Olr78xO1iDzQXvv3KiF7+dhKme+KTJX
 euEtB2EWxs/jt7bthOPj37doOd7aVzO4AUsnJbwJBEiV0m6kPT2Vi6/Q==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 18 Aug 2025 14:26:43 +0200
Subject: [PATCH 01/13] drivers/gpio: Add missing MODULE_DESCRIPTION()
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-wip-flo-add-missing-module-descriptions-v1-1-c57f195e3f93@siemens.com>
References: <20250812-wip-flo-add-missing-module-descriptions-v1-0-c57f195e3f93@siemens.com>
In-Reply-To: <20250812-wip-flo-add-missing-module-descriptions-v1-0-c57f195e3f93@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

There is a build warning triggered when MODULE_DESCRIPTION() is
missing. Seen on builds with Dovetail 6.16, but likely older versions
are also already triggering the warning.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/drivers/gpio/gpio-bcm2711.c    | 1 +
 kernel/drivers/gpio/gpio-bcm2835.c    | 2 +-
 kernel/drivers/gpio/gpio-cherryview.c | 1 +
 kernel/drivers/gpio/gpio-mxc.c        | 1 +
 kernel/drivers/gpio/gpio-omap.c       | 1 +
 kernel/drivers/gpio/gpio-sun8i-h3.c   | 1 +
 kernel/drivers/gpio/gpio-xilinx.c     | 2 +-
 kernel/drivers/gpio/gpio-zynq7000.c   | 2 +-
 8 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/drivers/gpio/gpio-bcm2711.c b/kernel/drivers/gpio/gpio-bcm2711.c
index 13ee105f1..985a87115 100644
--- a/kernel/drivers/gpio/gpio-bcm2711.c
+++ b/kernel/drivers/gpio/gpio-bcm2711.c
@@ -24,3 +24,4 @@ static void __exit bcm2711_gpio_exit(void)
 module_exit(bcm2711_gpio_exit);
 
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("RTDM gpio driver for the Broadcom 2711 SoC");
diff --git a/kernel/drivers/gpio/gpio-bcm2835.c b/kernel/drivers/gpio/gpio-bcm2835.c
index c379e6c9d..1136a22c4 100644
--- a/kernel/drivers/gpio/gpio-bcm2835.c
+++ b/kernel/drivers/gpio/gpio-bcm2835.c
@@ -34,4 +34,4 @@ static void __exit bcm2835_gpio_exit(void)
 module_exit(bcm2835_gpio_exit);
 
 MODULE_LICENSE("GPL");
-
+MODULE_DESCRIPTION("RTDM gpio driver for the Broadcom 2835 SoC");
diff --git a/kernel/drivers/gpio/gpio-cherryview.c b/kernel/drivers/gpio/gpio-cherryview.c
index 1234a3e12..3d59f0321 100644
--- a/kernel/drivers/gpio/gpio-cherryview.c
+++ b/kernel/drivers/gpio/gpio-cherryview.c
@@ -40,3 +40,4 @@ static void __exit cherryview_gpio_exit(void)
 module_exit(cherryview_gpio_exit);
 
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("RTDM gpio driver for Intel Cherryview pinctrl");
diff --git a/kernel/drivers/gpio/gpio-mxc.c b/kernel/drivers/gpio/gpio-mxc.c
index ccc41dabc..880624cb5 100644
--- a/kernel/drivers/gpio/gpio-mxc.c
+++ b/kernel/drivers/gpio/gpio-mxc.c
@@ -40,3 +40,4 @@ static void __exit mxc_gpio_exit(void)
 module_exit(mxc_gpio_exit);
 
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("RTDM gpio driver for the i.MX 6Quad and 7Dual SoCs");
diff --git a/kernel/drivers/gpio/gpio-omap.c b/kernel/drivers/gpio/gpio-omap.c
index ea213a33f..c3ab8e454 100644
--- a/kernel/drivers/gpio/gpio-omap.c
+++ b/kernel/drivers/gpio/gpio-omap.c
@@ -41,3 +41,4 @@ static void __exit omap_gpio_exit(void)
 module_exit(omap_gpio_exit);
 
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("RTDM gpio driver for the OMAP family of SOCs");
diff --git a/kernel/drivers/gpio/gpio-sun8i-h3.c b/kernel/drivers/gpio/gpio-sun8i-h3.c
index 55059efe6..09b93f21b 100644
--- a/kernel/drivers/gpio/gpio-sun8i-h3.c
+++ b/kernel/drivers/gpio/gpio-sun8i-h3.c
@@ -41,3 +41,4 @@ static void __exit h3_gpio_exit(void)
 module_exit(h3_gpio_exit);
 
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("RTDM gpio driver for Allwinner's H3 SoC");
diff --git a/kernel/drivers/gpio/gpio-xilinx.c b/kernel/drivers/gpio/gpio-xilinx.c
index e9ae3b171..c8ed17fdb 100644
--- a/kernel/drivers/gpio/gpio-xilinx.c
+++ b/kernel/drivers/gpio/gpio-xilinx.c
@@ -37,4 +37,4 @@ static void __exit xilinx_gpio_exit(void)
 module_exit(xilinx_gpio_exit);
 
 MODULE_LICENSE("GPL");
-
+MODULE_DESCRIPTION("RTDM gpio driver for Xilinx SoCs");
diff --git a/kernel/drivers/gpio/gpio-zynq7000.c b/kernel/drivers/gpio/gpio-zynq7000.c
index 9997a74c0..931f6ee4f 100644
--- a/kernel/drivers/gpio/gpio-zynq7000.c
+++ b/kernel/drivers/gpio/gpio-zynq7000.c
@@ -37,4 +37,4 @@ static void __exit zynq7000_gpio_exit(void)
 module_exit(zynq7000_gpio_exit);
 
 MODULE_LICENSE("GPL");
-
+MODULE_DESCRIPTION("RTDM gpio driver for the Zynq 7000 SoC");

-- 
2.39.5

