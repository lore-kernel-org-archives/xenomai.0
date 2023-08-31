Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D6E1AA77
	for <xenomai@lists.linux.dev>; Thu, 31 Aug 2023 20:37:53 +0000 (UTC)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20230831203745ce9138b9eb3f84064d
        for <xenomai@lists.linux.dev>;
        Thu, 31 Aug 2023 22:37:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=9nRoq+MdZDbDY7QS6AqZHiSoyAV5KI8vA8BnP45w3Uc=;
 b=OJJ8YVyXUd9ltk9yvI3Cl4F8LfK/4IThnpgrErA/6VulWlb56KBgdzcwveSz5Ph8FGrFVZ
 6d32eKFYEXWXz0XnUsMY4xHnPtbgii9r4EyqEg4LQaitp1kzn1vpTZcfSx/Hs8P32YCw8g1P
 eEcT9oxjuFyi637zDkF7JZjurykXQ=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Thu, 31 Aug 2023 22:37:37 +0200
Subject: [PATCH stable/v3.2.x 11/19] drivers/spi: Convert to GPIO
 descriptor API
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230828-florian-enable-stable-3-2-for-6-1-v1-11-0e08770820e8@siemens.com>
References: <20230828-florian-enable-stable-3-2-for-6-1-v1-0-0e08770820e8@siemens.com>
In-Reply-To: <20230828-florian-enable-stable-3-2-for-6-1-v1-0-0e08770820e8@siemens.com>
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

[ master commit 7913f523e4234167abaed315a806df54a3508183 ]

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
index 5299cad7a..b1ee22bf8 100644
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
index 71f30a6ef..6e975fc79 100644
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
index ee43c38e3..305dec341 100644
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
index 0fad328ef..215b4bcc9 100644
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
2.39.2

