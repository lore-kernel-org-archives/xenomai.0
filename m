Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B04A3242BD
	for <xenomai@lists.linux.dev>; Wed, 27 May 2026 14:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779890876; cv=none; b=XP1e4ETcsk5dJuGjkOtjFBMmugsgZGWRgynLbH7mwdno3gIuSvZSJdeTdThmog0lOAbhAaehzZkbvJdz7sKEmDfBGI0oNtlDN6y8Ie5G3Vk1ejwQNZLgLp9ePiwrHeLWTBGvzO1H8JWUPv71FdeyJ9LUNXsnolnq0/k/A8jArF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779890876; c=relaxed/simple;
	bh=TI2m1nP1cfgfWB5WHpqRMliWVkprMyjA+qLuN+4wTrM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sBqZR+xk5iI04nl/NApwiDmKwLiVfcOumfXvk7FZhcBQkKFtZWUVyaROFt7HGctTi2ATM19g7RbEyQXEjHxUD7UAVYscCkHyy8an/6ogSheW7wQEweP4st/a8bGUXAhW9XFJKsM6Iu137qRqTdgyx1rc8eYtdEE+D9aD8obVlHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=I9+cDfgM; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="I9+cDfgM"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 2026052714074493baf3fde100020774
        for <xenomai@lists.linux.dev>;
        Wed, 27 May 2026 16:07:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=XNdwhlAzWaq1TCO8XdxBwC/2aBtLneBa2j4TGZm63po=;
 b=I9+cDfgMhW1lVPPWMoHCr5ALzMtyUEW773uu5Z+rhD/yKd2bHwPcg+/Q1riDMT5x4f8GsV
 xVuuw9uK0jyLCH57NimZS04lkUs8Gmw/dJ90mpcXiP53oVcX3HlptlEXwBgI9DqRiupiTGRV
 ODwd4Itce+0N2FAGSwt7qBaQzcbP7bH0ujMRR69F2w9z7tn8tD/ipPCbCKbvNK6BRTeE2M2T
 10KkBYxhnDaFEav52PuhSzCCzb4VnQ3LlchXhfQvPBA0xpBq65o5rP6Sygv4ycGZTi/+hCIU
 uWFyOqQoVTCHZdDThQvuzPMF7nMGoQ63IoHFDUOcOAM1V8ISIftsUPRA==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Wed, 27 May 2026 16:07:37 +0200
Subject: [PATCH 1/2] drivers/spi: Prepare for linux/of_gpio.h removal in
 Linux 7.1
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260527-wip-flo-7-1-preparations-v1-1-b65d1304bb6b@siemens.com>
References: <20260527-wip-flo-7-1-preparations-v1-0-b65d1304bb6b@siemens.com>
In-Reply-To: <20260527-wip-flo-7-1-preparations-v1-0-b65d1304bb6b@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

upstream commit
b6420bd5aa0c ("gpio: remove of_get_named_gpio() and <linux/of_gpio.h>")
removed the linux/of_gpio.h file. We now have to include linux/gpio.h
and linux/gpio/driver.h

This patch has to reach all Xenomai branches that should support
Dovetail 7.1 and newer.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/drivers/spi/spi-bcm2835.c        | 3 ++-
 kernel/drivers/spi/spi-omap2-mcspi-rt.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/drivers/spi/spi-bcm2835.c b/kernel/drivers/spi/spi-bcm2835.c
index 7c3568d582dd24ca7686f6438907d12e15401187..b9c3a19f0bd55c77430c68f6689dae3364be2304 100644
--- a/kernel/drivers/spi/spi-bcm2835.c
+++ b/kernel/drivers/spi/spi-bcm2835.c
@@ -25,13 +25,14 @@
 #include <linux/slab.h>
 #include <linux/err.h>
 #include <linux/dma-mapping.h>
+#include <linux/gpio.h>
+#include <linux/gpio/driver.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/clk.h>
 #include <linux/spi/spi.h>
 #include <linux/of_irq.h>
-#include <linux/of_gpio.h>
 #include "spi-master.h"
 
 #define RTDM_SUBCLASS_BCM2835  1
diff --git a/kernel/drivers/spi/spi-omap2-mcspi-rt.c b/kernel/drivers/spi/spi-omap2-mcspi-rt.c
index 88c5132b869f46c76efbf3e709bc7e7ed98d2862..fa56347b0d46623a854a0f668e587bfea888e8a9 100644
--- a/kernel/drivers/spi/spi-omap2-mcspi-rt.c
+++ b/kernel/drivers/spi/spi-omap2-mcspi-rt.c
@@ -23,13 +23,14 @@
 #include <linux/slab.h>
 #include <linux/err.h>
 #include <linux/dma-mapping.h>
+#include <linux/gpio.h>
+#include <linux/gpio/driver.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/clk.h>
 #include <linux/spi/spi.h>
 #include <linux/of_irq.h>
-#include <linux/of_gpio.h>
 #include <linux/of_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/gcd.h>

-- 
2.54.0

