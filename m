Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C86546AC
	for <xenomai@lists.linux.dev>; Mon,  4 Jul 2022 13:09:13 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (unknown [217.70.183.194])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 97707CA1BE
	for <xenomai@lists.linux.dev>; Mon,  4 Jul 2022 13:08:45 +0000 (UTC)
Received: from spool.mail.gandi.net (spool5.mail.gandi.net [217.70.178.214])
	by relay.mail.gandi.net (Postfix) with ESMTPS id B5EC34000A
	for <xenomai@lists.linux.dev>; Mon,  4 Jul 2022 13:08:37 +0000 (UTC)
X-Envelope-To: xenomai@xenomai.org
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 87A80D80091
	for <xenomai@xenomai.org>; Mon,  4 Jul 2022 13:08:37 +0000 (UTC)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20220704130837436b5a7e35386daa35
        for <xenomai@xenomai.org>;
        Mon, 04 Jul 2022 15:08:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=XRo/v7PYZoZW/E1kvHTRR1LoCKRHA9VMDJ4XrZYtK2A=;
 b=EuIDt0H3l0aiAIJsUcSc9vlQDRtZ8WUsJU31L6doq3RbbdmxjuVqd5fT4z5aTHVsbuQ9C2
 rz4X++7b28MKLo9fIO0xHU0HPWE0OLPfLpuEWQHGg6BFh7Qr/uHXboRUhHly14ex4KwCxZ9m
 393+fujQa5sk0tUwo6f5bbwV6/ANs=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@xenomai.org
Cc: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH 12/15] drivers/spi: Convert to GPIO descriptor API
Date: Mon,  4 Jul 2022 15:08:32 +0200
Message-Id: <cf16be3b09388439e0629c47313c6ac16b439bdc.1656940114.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1656940114.git.jan.kiszka@siemens.com>
References: <cover.1656940114.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
Received-SPF: pass (spool5: domain of rts-flowmailer.siemens.com designates 185.136.64.228 as permitted sender) client-ip=185.136.64.228; envelope-from=fm-294854-20220704130837436b5a7e35386daa35-rbkQE9@rts-flowmailer.siemens.com; helo=mta-64-228.siemens.flowmailer.net;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=fm1 header.b=EuIDt0H3;
	dmarc=pass (policy=none) header.from=siemens.com;
	spf=pass (spool.mail.gandi.net: domain of fm-294854-20220704130837436b5a7e35386daa35-rbkQE9@rts-flowmailer.siemens.com designates 185.136.64.228 as permitted sender) smtp.mailfrom=fm-294854-20220704130837436b5a7e35386daa35-rbkQE9@rts-flowmailer.siemens.com

From: Jan Kiszka <jan.kiszka@siemens.com>

The legacy one has been retired, and the new one was already available
with 5.10.

CC: Philippe Gerum <rpm@xenomai.org>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/spi/spi-bcm2835.c | 21 +++++++++++----------
 kernel/drivers/spi/spi-device.c  | 22 +++++-----------------
 kernel/drivers/spi/spi-device.h  |  1 -
 kernel/drivers/spi/spi-master.c  |  7 ++++---
 4 files changed, 20 insertions(+), 31 deletions(-)

diff --git a/kernel/drivers/spi/spi-bcm2835.c b/kernel/drivers/spi/spi-bcm2835.c
index 5299cad7a9..b1ee22bf82 100644
--- a/kernel/drivers/spi/spi-bcm2835.c
+++ b/kernel/drivers/spi/spi-bcm2835.c
@@ -281,7 +281,7 @@ static int do_transfer_irq(struct rtdm_spi_remote_slave *slave)
 	 * change the behaviour with gpio-cs this does not happen, so
 	 * it is implemented only for this case.
 	 */
-	if (gpio_is_valid(slave->cs_gpio)) {
+	if (slave->cs_gpiod) {
 		/* Set dummy CS, ->chip_select() was not called. */
 		cs |= BCM2835_SPI_CS_CS_10 | BCM2835_SPI_CS_CS_01;
 		/* Enable SPI block, before filling FIFO. */
@@ -457,11 +457,12 @@ static int find_cs_gpio(struct spi_device *spi)
 	u32 pingroup_index, pin, pin_index;
 	struct device_node *pins;
 	struct gpio_chip *chip;
+	int cs_gpio = -ENOENT;
 	int ret;
 
-	if (gpio_is_valid(spi->cs_gpio)) {
+	if (spi->cs_gpiod) {
 		dev_info(&spi->dev, "using GPIO%i for CS%d\n",
-			 spi->cs_gpio, spi->chip_select);
+			 desc_to_gpio(spi->cs_gpiod), spi->chip_select);
 		return 0;
 	}
 
@@ -477,7 +478,7 @@ static int find_cs_gpio(struct spi_device *spi)
 			     (pin == 8 || pin == 36 || pin == 46)) ||
 			    (spi->chip_select == 1 &&
 			     (pin == 7 || pin == 35))) {
-				spi->cs_gpio = pin;
+				cs_gpio = pin;
 				break;
 			}
 		}
@@ -485,24 +486,24 @@ static int find_cs_gpio(struct spi_device *spi)
 	}
 
 	/* If that failed, assume GPIOs 7-11 are used */
-	if (!gpio_is_valid(spi->cs_gpio) ) {
+	if (!gpio_is_valid(cs_gpio)) {
 		chip = gpiochip_find("pinctrl-bcm2835", gpio_match_name);
 		if (chip == NULL)
 			return 0;
 
-		spi->cs_gpio = chip->base + 8 - spi->chip_select;
+		cs_gpio = chip->base + 8 - spi->chip_select;
 	}
 
 	dev_info(&spi->dev,
 		 "setting up native-CS%i as GPIO %i\n",
-		 spi->chip_select, spi->cs_gpio);
+		 spi->chip_select, cs_gpio);
 
-	ret = gpio_direction_output(spi->cs_gpio,
+	ret = gpio_direction_output(cs_gpio,
 			    (spi->mode & SPI_CS_HIGH) ? 0 : 1);
 	if (ret) {
 		dev_err(&spi->dev,
 			"could not set CS%i gpio %i as output: %i",
-			spi->chip_select, spi->cs_gpio, ret);
+			spi->chip_select, cs_gpio, ret);
 		return ret;
 	}
 
@@ -510,7 +511,7 @@ static int find_cs_gpio(struct spi_device *spi)
 	 * Force value on GPIO in case the pin controller does not
 	 * handle that properly when switching to output mode.
 	 */
-	gpio_set_value(spi->cs_gpio, (spi->mode & SPI_CS_HIGH) ? 0 : 1);
+	gpio_set_value(cs_gpio, (spi->mode & SPI_CS_HIGH) ? 0 : 1);
 
 	return 0;
 }
diff --git a/kernel/drivers/spi/spi-device.c b/kernel/drivers/spi/spi-device.c
index 71f30a6ef4..6e975fc798 100644
--- a/kernel/drivers/spi/spi-device.c
+++ b/kernel/drivers/spi/spi-device.c
@@ -49,21 +49,12 @@ int rtdm_spi_add_remote_slave(struct rtdm_spi_remote_slave *slave,
 	if (dev->label == NULL)
 		return -ENOMEM;
 
-	if (gpio_is_valid(spi->cs_gpio))
-		slave->cs_gpio = spi->cs_gpio;
+	if (spi->cs_gpiod)
+		slave->cs_gpiod = spi->cs_gpiod;
 	else {
-		slave->cs_gpio = -ENOENT;
-		if (kmaster->cs_gpios)
-			slave->cs_gpio = kmaster->cs_gpios[spi->chip_select];
-	}
-
-	if (gpio_is_valid(slave->cs_gpio)) {
-		ret = gpio_request(slave->cs_gpio, dev->label);
-		if (ret)
-			goto fail;
-		slave->cs_gpiod = gpio_to_desc(slave->cs_gpio);
-		if (slave->cs_gpiod == NULL)
-			goto fail;
+		slave->cs_gpiod = NULL;
+		if (kmaster->cs_gpiods)
+			slave->cs_gpiod = kmaster->cs_gpiods[spi->chip_select];
 	}
 	
 	mutex_init(&slave->ctl_lock);
@@ -90,9 +81,6 @@ void rtdm_spi_remove_remote_slave(struct rtdm_spi_remote_slave *slave)
 	struct rtdm_spi_master *master = slave->master;
 	struct rtdm_device *dev;
 	rtdm_lockctx_t c;
-	
-	if (gpio_is_valid(slave->cs_gpio))
-		gpio_free(slave->cs_gpio);
 
 	mutex_destroy(&slave->ctl_lock);
 	rtdm_lock_get_irqsave(&master->lock, c);
diff --git a/kernel/drivers/spi/spi-device.h b/kernel/drivers/spi/spi-device.h
index ee43c38e38..305dec3414 100644
--- a/kernel/drivers/spi/spi-device.h
+++ b/kernel/drivers/spi/spi-device.h
@@ -29,7 +29,6 @@ struct rtdm_spi_master;
 
 struct rtdm_spi_remote_slave {
 	u8 chip_select;
-	int cs_gpio;
 	struct gpio_desc *cs_gpiod;
 	struct rtdm_device dev;
 	struct list_head next;
diff --git a/kernel/drivers/spi/spi-master.c b/kernel/drivers/spi/spi-master.c
index 0fad328ef7..215b4bcc94 100644
--- a/kernel/drivers/spi/spi-master.c
+++ b/kernel/drivers/spi/spi-master.c
@@ -112,7 +112,7 @@ static int do_chip_select(struct rtdm_spi_remote_slave *slave)
 	rtdm_lock_get_irqsave(&master->lock, c);
 	
 	if (master->cs != slave) {
-		if (gpio_is_valid(slave->cs_gpio)) {
+		if (slave->cs_gpiod) {
 			state = !!(slave->config.mode & SPI_CS_HIGH);
 			gpiod_set_raw_value(slave->cs_gpiod, state);
 		} else
@@ -133,7 +133,7 @@ static void do_chip_deselect(struct rtdm_spi_remote_slave *slave)
 
 	rtdm_lock_get_irqsave(&master->lock, c);
 
-	if (gpio_is_valid(slave->cs_gpio)) {
+	if (slave->cs_gpiod) {
 		state = !(slave->config.mode & SPI_CS_HIGH);
 		gpiod_set_raw_value(slave->cs_gpiod, state);
 	} else
@@ -354,7 +354,8 @@ __rtdm_spi_alloc_master(struct device *dev, size_t size, int off)
 	kmaster = spi_alloc_master(dev, size);
 	if (kmaster == NULL)
 		return NULL;
-	
+
+	master->use_gpio_descriptors = true;
 	master = (void *)(kmaster + 1) + off;
 	master->kmaster = kmaster;
 	spi_master_set_devdata(kmaster, master);
-- 
2.35.3

