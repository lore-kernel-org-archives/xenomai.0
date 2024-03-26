Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BAC1272BB
	for <xenomai@lists.linux.dev>; Tue, 26 Mar 2024 06:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711434683; cv=none; b=ILto8RSI+6sPaR3ADTqnXrpRMGJfN2EyzhnSWpwYVW8PmA4PhGsoJpMiJP2FiQEwXpN9V/xxkgaaAl1OSsODaU1Vggr1m5KYkIzN8m1XTm/Duuzcoi7Tfb+bRyjLI8ivcrbJXP+oJU60wiUfGgWa3mfdAFj11rrQLJm3cjHQRPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711434683; c=relaxed/simple;
	bh=VKg/4qB0cVuwXayd3HnTxRRf/P5RxW6/tkQ8ZSPZdjc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pj3YkKiQCfgeUOCDE6Mhp9Q+KNU2nOBP1XUSxxmiVGyS323XmDZVdip2QPn+U/68k7Gtdimrop35KISlIIwOQj/1kHEUahRcBBynKqY/no86pkV3yiXmZQz4dGmj8kzy2Uc4/rh3cxLl9hH2lqCgaH3Go2yxpR3TcVSTB1CSDyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=Y9kUHRQQ; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="Y9kUHRQQ"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20240326063112f0f75a2f91c5fb55db
        for <xenomai@lists.linux.dev>;
        Tue, 26 Mar 2024 07:31:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=fdOwCwNALESpHchx4A0Ln1AZAzdA7PXiMnSlPy0mFmg=;
 b=Y9kUHRQQzIzdGsura2iFrQ6dORYcB0/5R7m7b4GmRvchNDqYjseJ3TORbD/0Uy3aIV1goy
 iLJR0iVnl7vBmpr76AB6nBL012+XuU6XsM3QR5i67tGugeZh70qeX2HmEVQsKU1jtVWF3zLR
 +adIz5Zc43BITzeeiSbIpOtzf40nU=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [PATCH 24/25] drivers/spi: Use spi_get_chipselect/gpiod
Date: Tue, 26 Mar 2024 07:31:03 +0100
Message-Id: <89b36c5b3e2460d1145dc8b5950a0eb1747152c1.1711434664.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1711434664.git.jan.kiszka@siemens.com>
References: <cover.1711434664.git.jan.kiszka@siemens.com>
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

This is required since kernel 6.8.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../include/asm-generic/xenomai/wrappers.h      |  5 +++++
 kernel/drivers/spi/spi-bcm2835.c                | 17 +++++++++--------
 kernel/drivers/spi/spi-device.c                 | 14 +++++++-------
 kernel/drivers/spi/spi-omap2-mcspi-rt.c         | 13 +++++++------
 4 files changed, 28 insertions(+), 21 deletions(-)

diff --git a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
index abf58c589c..9316c35d8b 100644
--- a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
+++ b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
@@ -65,6 +65,11 @@
 #define pde_data(i)	PDE_DATA(i)
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(6,3,0)
+#define spi_get_chipselect(spi, idx)	((spi)->chip_select)
+#define spi_get_csgpiod(spi, idx)	((spi)->cs_gpiod)
+#endif
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(6,8,0)
 #define MAX_PAGE_ORDER	MAX_ORDER
 #endif
diff --git a/kernel/drivers/spi/spi-bcm2835.c b/kernel/drivers/spi/spi-bcm2835.c
index 2d50b86080..fabfd4a59c 100644
--- a/kernel/drivers/spi/spi-bcm2835.c
+++ b/kernel/drivers/spi/spi-bcm2835.c
@@ -462,9 +462,10 @@ static int find_cs_gpio(struct spi_device *spi)
 	int cs_gpio = -ENOENT;
 	int ret;
 
-	if (spi->cs_gpiod) {
+	if (spi_get_csgpiod(spi, 0)) {
 		dev_info(&spi->dev, "using GPIO%i for CS%d\n",
-			 desc_to_gpio(spi->cs_gpiod), spi->chip_select);
+			 desc_to_gpio(spi_get_csgpiod(spi, 0)),
+				      spi_get_chipselect(spi, 0));
 		return 0;
 	}
 
@@ -476,9 +477,9 @@ static int find_cs_gpio(struct spi_device *spi)
 		for (pin_index = 0;
 		     of_property_read_u32_index(pins, "brcm,pins",
 				pin_index, &pin) == 0; pin_index++) {
-			if ((spi->chip_select == 0 &&
+			if ((spi_get_chipselect(spi, 0) == 0 &&
 			     (pin == 8 || pin == 36 || pin == 46)) ||
-			    (spi->chip_select == 1 &&
+			    (spi_get_chipselect(spi, 0) == 1 &&
 			     (pin == 7 || pin == 35))) {
 				cs_gpio = pin;
 				break;
@@ -503,19 +504,19 @@ static int find_cs_gpio(struct spi_device *spi)
 			return 0;
 #endif
 
-		cs_gpio = chip->base + 8 - spi->chip_select;
+		cs_gpio = chip->base + 8 - spi_get_chipselect(spi, 0);
 	}
 
 	dev_info(&spi->dev,
 		 "setting up native-CS%i as GPIO %i\n",
-		 spi->chip_select, cs_gpio);
+		 spi_get_chipselect(spi, 0), cs_gpio);
 
 	ret = gpio_direction_output(cs_gpio,
 			    (spi->mode & SPI_CS_HIGH) ? 0 : 1);
 	if (ret) {
 		dev_err(&spi->dev,
 			"could not set CS%i gpio %i as output: %i",
-			spi->chip_select, cs_gpio, ret);
+			spi_get_chipselect(spi, 0), cs_gpio, ret);
 		return ret;
 	}
 
@@ -534,7 +535,7 @@ bcm2835_attach_slave(struct rtdm_spi_master *master, struct spi_device *spi)
 	struct spi_slave_bcm2835 *bcm;
 	int ret;
 
-	if (spi->chip_select > 1) {
+	if (spi_get_chipselect(spi, 0) > 1) {
 		/*
 		 * Error in the case of native CS requested with CS >
 		 * 1 officially there is a CS2, but it is not
diff --git a/kernel/drivers/spi/spi-device.c b/kernel/drivers/spi/spi-device.c
index 6e368bd555..265f98f1b5 100644
--- a/kernel/drivers/spi/spi-device.c
+++ b/kernel/drivers/spi/spi-device.c
@@ -35,12 +35,12 @@ int rtdm_spi_add_remote_slave(struct rtdm_spi_remote_slave *slave,
 	int ret;
 
 	memset(slave, 0, sizeof(*slave));
-	slave->chip_select = spi->chip_select;
+	slave->chip_select = spi_get_chipselect(spi, 0);
 	slave->config.bits_per_word = spi->bits_per_word;
 	slave->config.speed_hz = spi->max_speed_hz;
 	slave->config.mode = spi->mode;
 	slave->master = master;
-	
+
 	dev = &slave->dev;
 	dev->driver = &master->driver;
 	dev->label = kasprintf(GFP_KERNEL, "%s/slave%d.%%d",
@@ -49,14 +49,14 @@ int rtdm_spi_add_remote_slave(struct rtdm_spi_remote_slave *slave,
 	if (dev->label == NULL)
 		return -ENOMEM;
 
-	if (spi->cs_gpiod)
-		slave->cs_gpiod = spi->cs_gpiod;
-	else {
+	if (spi_get_csgpiod(spi, 0)) {
+		slave->cs_gpiod = spi_get_csgpiod(spi, 0);
+	} else {
 		slave->cs_gpiod = NULL;
 		if (ctlr->cs_gpiods)
-			slave->cs_gpiod = ctlr->cs_gpiods[spi->chip_select];
+			slave->cs_gpiod = ctlr->cs_gpiods[slave->chip_select];
 	}
-	
+
 	mutex_init(&slave->ctl_lock);
 
 	dev->device_data = master;
diff --git a/kernel/drivers/spi/spi-omap2-mcspi-rt.c b/kernel/drivers/spi/spi-omap2-mcspi-rt.c
index 7918f61e7d..976d28dc5d 100644
--- a/kernel/drivers/spi/spi-omap2-mcspi-rt.c
+++ b/kernel/drivers/spi/spi-omap2-mcspi-rt.c
@@ -804,7 +804,8 @@ omap2_mcspi_attach_slave(struct rtdm_spi_master *master, struct spi_device *spi)
 	struct spi_slave_omap2_mcspi *mapped_data;
 	int ret;
 
-	if ((spi->chip_select >= OMAP2_MCSPI_CS_N) || (OMAP2_MCSPI_CS_N > 2)) {
+	if (spi_get_chipselect(spi, 0) >= OMAP2_MCSPI_CS_N ||
+	    OMAP2_MCSPI_CS_N > 2) {
 		/* Error in the case of native CS requested with CS > 1 */
 		dev_err(&spi->dev, "%s: only two native CS per spi module are supported\n",
 			__func__);
@@ -823,11 +824,11 @@ omap2_mcspi_attach_slave(struct rtdm_spi_master *master, struct spi_device *spi)
 	}
 
 	spim = container_of(master, struct spi_master_omap2_mcspi, master);
-	spim->cs[spi->chip_select].chosen = 0;
-	spim->cs[spi->chip_select].regs = spim->regs +
-		spi->chip_select * OMAP2_MCSPI_CHANNELBANK_SIZE;
-	spim->cs[spi->chip_select].phys = spim->phys +
-		spi->chip_select * OMAP2_MCSPI_CHANNELBANK_SIZE;
+	spim->cs[spi_get_chipselect(spi, 0)].chosen = 0;
+	spim->cs[spi_get_chipselect(spi, 0)].regs = spim->regs +
+		spi_get_chipselect(spi, 0) * OMAP2_MCSPI_CHANNELBANK_SIZE;
+	spim->cs[spi_get_chipselect(spi, 0)].phys = spim->phys +
+		spi_get_chipselect(spi, 0) * OMAP2_MCSPI_CHANNELBANK_SIZE;
 
 	return &mapped_data->slave;
 }
-- 
2.35.3

