Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E81F9C2
	for <xenomai@lists.linux.dev>; Fri,  1 Sep 2023 19:45:34 +0000 (UTC)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20230901194532402cb1ebd142230e7c
        for <xenomai@lists.linux.dev>;
        Fri, 01 Sep 2023 21:45:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=H+lgj4MF7k/ENvY3BpASSCSTw7ucTxjcLoYF1DPW3NY=;
 b=DkfuxSevKiXBtvdVT3TSL1+9uBJbrRt8oPgTj/VLuDYU/5q/GNnZ3e1NPZ/ETKMKIW/rUc
 ZEzyaaTfCoB6XUr+SduOu6SJvmZD6j5h4cy6X2g6SWjfXBdDcHEqCs4pxkzoJObduRFLkVFz
 wdi7A/6iBuVNhWg5tb3xZ+Y/xhs/0=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 01 Sep 2023 21:45:34 +0200
Subject: [PATCH stable/v3.2.x v2 11/17] drivers/spi: Convert to GPIO
 descriptor API
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230828-florian-enable-stable-3-2-for-6-1-v2-11-5189cfb05a62@siemens.com>
References: <20230828-florian-enable-stable-3-2-for-6-1-v2-0-5189cfb05a62@siemens.com>
In-Reply-To: <20230828-florian-enable-stable-3-2-for-6-1-v2-0-5189cfb05a62@siemens.com>
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

[ master commit 7913f523e4234167abaed315a806df54a3508183 ]

The legacy one has been retired, and the new one was already available
with 5.10.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
[Florian: Backporting]
Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/drivers/spi/spi-bcm2835.c | 43 +++++++++++++++++++++++++++--------
 kernel/drivers/spi/spi-device.c  | 49 ++++++++++++++++++++++++----------------
 kernel/drivers/spi/spi-device.h  |  1 -
 kernel/drivers/spi/spi-master.c  |  9 +++++---
 4 files changed, 69 insertions(+), 33 deletions(-)

diff --git a/kernel/drivers/spi/spi-bcm2835.c b/kernel/drivers/spi/spi-bcm2835.c
index 5299cad7a..f37976554 100644
--- a/kernel/drivers/spi/spi-bcm2835.c
+++ b/kernel/drivers/spi/spi-bcm2835.c
@@ -139,6 +139,28 @@ static inline void bcm2835_rd_fifo(struct spi_master_bcm2835 *spim)
 	}
 }
 
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(5,1,0)
+static inline bool xn_gpio_is_valid(struct spi_device *spi)
+{
+       return spi->cs_gpiod != NULL;
+}
+
+static inline int xn_get_gpio(struct spi_device *spi)
+{
+       return desc_to_gpio(spi->cs_gpiod);
+}
+#else
+static inline bool xn_gpio_is_valid(struct spi_device *spi)
+{
+       return gpio_is_valid(spi->cs_gpio);
+}
+
+static inline int xn_get_gpio(struct spi_device *spi)
+{
+       return spi->cs_gpio;
+}
+#endif
+
 static inline void bcm2835_wr_fifo(struct spi_master_bcm2835 *spim)
 {
 	u8 byte;
@@ -281,7 +303,7 @@ static int do_transfer_irq(struct rtdm_spi_remote_slave *slave)
 	 * change the behaviour with gpio-cs this does not happen, so
 	 * it is implemented only for this case.
 	 */
-	if (gpio_is_valid(slave->cs_gpio)) {
+	if (slave->cs_gpiod) {
 		/* Set dummy CS, ->chip_select() was not called. */
 		cs |= BCM2835_SPI_CS_CS_10 | BCM2835_SPI_CS_CS_01;
 		/* Enable SPI block, before filling FIFO. */
@@ -457,11 +479,12 @@ static int find_cs_gpio(struct spi_device *spi)
 	u32 pingroup_index, pin, pin_index;
 	struct device_node *pins;
 	struct gpio_chip *chip;
+	int cs_gpio = -ENOENT;
 	int ret;
 
-	if (gpio_is_valid(spi->cs_gpio)) {
+	if (xn_gpio_is_valid(spi)) {
 		dev_info(&spi->dev, "using GPIO%i for CS%d\n",
-			 spi->cs_gpio, spi->chip_select);
+			 xn_get_gpio(spi), spi->chip_select);
 		return 0;
 	}
 
@@ -477,7 +500,7 @@ static int find_cs_gpio(struct spi_device *spi)
 			     (pin == 8 || pin == 36 || pin == 46)) ||
 			    (spi->chip_select == 1 &&
 			     (pin == 7 || pin == 35))) {
-				spi->cs_gpio = pin;
+				cs_gpio = pin;
 				break;
 			}
 		}
@@ -485,24 +508,24 @@ static int find_cs_gpio(struct spi_device *spi)
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
 
@@ -510,7 +533,7 @@ static int find_cs_gpio(struct spi_device *spi)
 	 * Force value on GPIO in case the pin controller does not
 	 * handle that properly when switching to output mode.
 	 */
-	gpio_set_value(spi->cs_gpio, (spi->mode & SPI_CS_HIGH) ? 0 : 1);
+	gpio_set_value(cs_gpio, (spi->mode & SPI_CS_HIGH) ? 0 : 1);
 
 	return 0;
 }
diff --git a/kernel/drivers/spi/spi-device.c b/kernel/drivers/spi/spi-device.c
index 71f30a6ef..a8bd6bb66 100644
--- a/kernel/drivers/spi/spi-device.c
+++ b/kernel/drivers/spi/spi-device.c
@@ -25,6 +25,35 @@
 #include <linux/spi/spi.h>
 #include "spi-master.h"
 
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(5,1,0)
+static inline void rtdm_spi_slave_init(struct spi_controller *ctrl,
+				       struct rtdm_spi_remote_slave *slave,
+				       struct spi_device *spi)
+{
+	if (spi->cs_gpiod)
+		slave->cs_gpiod = spi->cs_gpiod;
+	else {
+		slave->cs_gpiod = NULL;
+		if (ctrl->cs_gpiods)
+			slave->cs_gpiod = ctrl->cs_gpiods[spi->chip_select];
+	}
+}
+#else
+static inline void rtdm_spi_slave_init(struct spi_controller *ctrl,
+				       struct rtdm_spi_remote_slave *slave,
+				       struct spi_device *spi)
+{
+	if (gpio_is_valid(spi->cs_gpio))
+		slave->cs_gpiod = gpio_to_desc(spi->cs_gpio);
+	else {
+		slave->cs_gpiod = NULL;
+		if (ctrl->cs_gpios)
+			slave->cs_gpiod =
+				gpio_to_desc(ctrl->cs_gpios[spi->chip_select]);
+	}
+}
+#endif
+
 int rtdm_spi_add_remote_slave(struct rtdm_spi_remote_slave *slave,
 			      struct rtdm_spi_master *master,
 			      struct spi_device *spi)
@@ -49,23 +78,8 @@ int rtdm_spi_add_remote_slave(struct rtdm_spi_remote_slave *slave,
 	if (dev->label == NULL)
 		return -ENOMEM;
 
-	if (gpio_is_valid(spi->cs_gpio))
-		slave->cs_gpio = spi->cs_gpio;
-	else {
-		slave->cs_gpio = -ENOENT;
-		if (kmaster->cs_gpios)
-			slave->cs_gpio = kmaster->cs_gpios[spi->chip_select];
-	}
+	rtdm_spi_slave_init(kmaster, slave, spi);
 
-	if (gpio_is_valid(slave->cs_gpio)) {
-		ret = gpio_request(slave->cs_gpio, dev->label);
-		if (ret)
-			goto fail;
-		slave->cs_gpiod = gpio_to_desc(slave->cs_gpio);
-		if (slave->cs_gpiod == NULL)
-			goto fail;
-	}
-	
 	mutex_init(&slave->ctl_lock);
 
 	dev->device_data = master;
@@ -90,9 +104,6 @@ void rtdm_spi_remove_remote_slave(struct rtdm_spi_remote_slave *slave)
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
index 0fad328ef..c9756b576 100644
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
@@ -354,7 +354,10 @@ __rtdm_spi_alloc_master(struct device *dev, size_t size, int off)
 	kmaster = spi_alloc_master(dev, size);
 	if (kmaster == NULL)
 		return NULL;
-	
+
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(5,1,0)
+	master->use_gpio_descriptors = true;
+#endif
 	master = (void *)(kmaster + 1) + off;
 	master->kmaster = kmaster;
 	spi_master_set_devdata(kmaster, master);

-- 
2.39.2

