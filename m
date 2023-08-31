Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C300E1AA78
	for <xenomai@lists.linux.dev>; Thu, 31 Aug 2023 20:37:53 +0000 (UTC)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 2023083120374662260d97c793c201c2
        for <xenomai@lists.linux.dev>;
        Thu, 31 Aug 2023 22:37:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=NX/gJdTlcCmc+/twm9+NiSOnBsOpwczqmX+5hX7fCyA=;
 b=jNC52eIgIf+5y4jxGO8uBtFbtqBGb5OOIsF+YD61GOrhwCMEi3f+Xl21YLrXQ/v9v0TgFb
 2fpF5oK4pSQmq+rzKXDXe8wqZJvNN3OxvBgkPomc14IORVNf533yZSFcEfh5VvS0IFm63rn9
 J7hjZlMALwDiVacE99h549e+7KLK8=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Thu, 31 Aug 2023 22:37:38 +0200
Subject: [PATCH stable/v3.2.x 12/19] drivers/spi: Switch to spi_controller
 API
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230828-florian-enable-stable-3-2-for-6-1-v1-12-0e08770820e8@siemens.com>
References: <20230828-florian-enable-stable-3-2-for-6-1-v1-0-0e08770820e8@siemens.com>
In-Reply-To: <20230828-florian-enable-stable-3-2-for-6-1-v1-0-0e08770820e8@siemens.com>
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

[ master commit 446e07bd3b8a2ae6a25403c8e3212c86779b5b70 ]

The kernel generalized spi_master to spi_controller and renamed several
services. Follow this to avoid breakage when the legacy wrappers are
eventually removed. Should come without functional changes.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/spi/spi-bcm2835.c        | 20 ++++++++++----------
 kernel/drivers/spi/spi-device.c         | 10 +++++-----
 kernel/drivers/spi/spi-master.c         | 24 ++++++++++++------------
 kernel/drivers/spi/spi-master.h         |  2 +-
 kernel/drivers/spi/spi-omap2-mcspi-rt.c | 20 ++++++++++----------
 kernel/drivers/spi/spi-sun6i.c          | 24 ++++++++++++------------
 6 files changed, 50 insertions(+), 50 deletions(-)

diff --git a/kernel/drivers/spi/spi-bcm2835.c b/kernel/drivers/spi/spi-bcm2835.c
index b1ee22bf8..e8df8fe7e 100644
--- a/kernel/drivers/spi/spi-bcm2835.c
+++ b/kernel/drivers/spi/spi-bcm2835.c
@@ -111,7 +111,7 @@ to_master_bcm2835(struct rtdm_spi_remote_slave *slave)
 static inline struct device *
 master_to_kdev(struct rtdm_spi_master *master)
 {
-	return &master->kmaster->dev;
+	return &master->controller->dev;
 }
 
 static inline u32 bcm2835_rd(struct spi_master_bcm2835 *spim,
@@ -453,7 +453,7 @@ static int gpio_match_name(struct gpio_chip *chip, void *data)
 
 static int find_cs_gpio(struct spi_device *spi)
 {
-	struct spi_master *kmaster = spi->master;
+	struct spi_controller *ctlr = spi->controller;
 	u32 pingroup_index, pin, pin_index;
 	struct device_node *pins;
 	struct gpio_chip *chip;
@@ -469,7 +469,7 @@ static int find_cs_gpio(struct spi_device *spi)
 	/* Translate native CS to GPIO. */
 
 	for (pingroup_index = 0;
-	     (pins = of_parse_phandle(kmaster->dev.of_node,
+	     (pins = of_parse_phandle(ctlr->dev.of_node,
 		     "pinctrl-0", pingroup_index)) != 0; pingroup_index++) {
 		for (pin_index = 0;
 		     of_property_read_u32_index(pins, "brcm,pins",
@@ -579,7 +579,7 @@ static int bcm2835_spi_probe(struct platform_device *pdev)
 {
 	struct spi_master_bcm2835 *spim;
 	struct rtdm_spi_master *master;
-	struct spi_master *kmaster;
+	struct spi_controller *ctlr;
 	struct resource *r;
 	int ret, irq;
 
@@ -594,11 +594,11 @@ static int bcm2835_spi_probe(struct platform_device *pdev)
 	master->ops = &bcm2835_master_ops;
 	platform_set_drvdata(pdev, master);
 
-	kmaster = master->kmaster;
-	kmaster->mode_bits = BCM2835_SPI_MODE_BITS;
-	kmaster->bits_per_word_mask = SPI_BPW_MASK(8);
-	kmaster->num_chipselect = 2;
-	kmaster->dev.of_node = pdev->dev.of_node;
+	ctlr = master->controller;
+	ctlr->mode_bits = BCM2835_SPI_MODE_BITS;
+	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
+	ctlr->num_chipselect = 2;
+	ctlr->dev.of_node = pdev->dev.of_node;
 
 	spim = container_of(master, struct spi_master_bcm2835, master);
 	rtdm_event_init(&spim->transfer_done, 0);
@@ -652,7 +652,7 @@ static int bcm2835_spi_probe(struct platform_device *pdev)
 fail_unclk:
 	clk_disable_unprepare(spim->clk);
 fail:
-	spi_master_put(kmaster);
+	spi_controller_put(ctlr);
 
 	return ret;
 }
diff --git a/kernel/drivers/spi/spi-device.c b/kernel/drivers/spi/spi-device.c
index 6e975fc79..397af0f33 100644
--- a/kernel/drivers/spi/spi-device.c
+++ b/kernel/drivers/spi/spi-device.c
@@ -29,7 +29,7 @@ int rtdm_spi_add_remote_slave(struct rtdm_spi_remote_slave *slave,
 			      struct rtdm_spi_master *master,
 			      struct spi_device *spi)
 {
-	struct spi_master *kmaster = master->kmaster;
+	struct spi_controller *ctlr = master->controller;
 	struct rtdm_device *dev;
 	rtdm_lockctx_t c;
 	int ret;
@@ -44,8 +44,8 @@ int rtdm_spi_add_remote_slave(struct rtdm_spi_remote_slave *slave,
 	dev = &slave->dev;
 	dev->driver = &master->driver;
 	dev->label = kasprintf(GFP_KERNEL, "%s/slave%d.%%d",
-			       dev_name(&kmaster->dev),
-			       kmaster->bus_num);
+			       dev_name(&ctlr->dev),
+			       ctlr->bus_num);
 	if (dev->label == NULL)
 		return -ENOMEM;
 
@@ -53,8 +53,8 @@ int rtdm_spi_add_remote_slave(struct rtdm_spi_remote_slave *slave,
 		slave->cs_gpiod = spi->cs_gpiod;
 	else {
 		slave->cs_gpiod = NULL;
-		if (kmaster->cs_gpiods)
-			slave->cs_gpiod = kmaster->cs_gpiods[spi->chip_select];
+		if (ctlr->cs_gpiods)
+			slave->cs_gpiod = ctlr->cs_gpiods[spi->chip_select];
 	}
 	
 	mutex_init(&slave->ctl_lock);
diff --git a/kernel/drivers/spi/spi-master.c b/kernel/drivers/spi/spi-master.c
index 215b4bcc9..cffeaf087 100644
--- a/kernel/drivers/spi/spi-master.c
+++ b/kernel/drivers/spi/spi-master.c
@@ -349,16 +349,16 @@ struct rtdm_spi_master *
 __rtdm_spi_alloc_master(struct device *dev, size_t size, int off)
 {
 	struct rtdm_spi_master *master;
-	struct spi_master *kmaster;
+	struct spi_controller *ctlr;
 
-	kmaster = spi_alloc_master(dev, size);
-	if (kmaster == NULL)
+	ctlr = spi_alloc_master(dev, size);
+	if (ctlr == NULL)
 		return NULL;
 
-	master->use_gpio_descriptors = true;
-	master = (void *)(kmaster + 1) + off;
-	master->kmaster = kmaster;
-	spi_master_set_devdata(kmaster, master);
+	ctlr->use_gpio_descriptors = true;
+	master = (void *)(ctlr + 1) + off;
+	master->controller = ctlr;
+	spi_master_set_devdata(ctlr, master);
 
 	return master;
 }
@@ -367,7 +367,7 @@ EXPORT_SYMBOL_GPL(__rtdm_spi_alloc_master);
 int __rtdm_spi_setup_driver(struct rtdm_spi_master *master)
 {
 	master->classname = kstrdup(
-		dev_name(&master->kmaster->dev), GFP_KERNEL);
+		dev_name(&master->controller->dev), GFP_KERNEL);
 	master->devclass = class_create(THIS_MODULE,
 		master->classname);
 	if (IS_ERR(master->devclass)) {
@@ -416,20 +416,20 @@ static int spi_transfer_one_unimp(struct spi_master *master,
 
 int rtdm_spi_add_master(struct rtdm_spi_master *master)
 {
-	struct spi_master *kmaster = master->kmaster;
+	struct spi_controller *ctlr = master->controller;
 
 	/*
 	 * Prevent the transfer handler to be called from the regular
 	 * SPI stack, just in case.
 	 */
-	kmaster->transfer_one = spi_transfer_one_unimp;
+	ctlr->transfer_one = spi_transfer_one_unimp;
 	master->devclass = NULL;
 
 	/*
 	 * Add the core SPI driver, devices on the bus will be
 	 * enumerated, handed to spi_device_probe().
 	 */
-	return spi_register_master(kmaster);
+	return spi_register_controller(ctlr);
 }
 EXPORT_SYMBOL_GPL(rtdm_spi_add_master);
 
@@ -439,7 +439,7 @@ void rtdm_spi_remove_master(struct rtdm_spi_master *master)
 	char *classname = master->classname;
 	
 	rtdm_mutex_destroy(&master->bus_lock);
-	spi_unregister_master(master->kmaster);
+	spi_unregister_controller(master->controller);
 	rtdm_drv_set_sysclass(&master->driver, NULL);
 	class_destroy(class);
 	kfree(classname);
diff --git a/kernel/drivers/spi/spi-master.h b/kernel/drivers/spi/spi-master.h
index ecfea2f90..449a6cc60 100644
--- a/kernel/drivers/spi/spi-master.h
+++ b/kernel/drivers/spi/spi-master.h
@@ -53,7 +53,7 @@ struct rtdm_spi_master_ops {
 struct rtdm_spi_master {
 	int subclass;
 	const struct rtdm_spi_master_ops *ops;
-	struct spi_master *kmaster;
+	struct spi_controller *controller;
 	struct {	/* Internal */
 		struct rtdm_driver driver;
 		struct class *devclass;
diff --git a/kernel/drivers/spi/spi-omap2-mcspi-rt.c b/kernel/drivers/spi/spi-omap2-mcspi-rt.c
index 03678b991..7918f61e7 100644
--- a/kernel/drivers/spi/spi-omap2-mcspi-rt.c
+++ b/kernel/drivers/spi/spi-omap2-mcspi-rt.c
@@ -181,7 +181,7 @@ to_master_omap2_mcspi(struct rtdm_spi_remote_slave *slave)
 static inline struct device *
 master_to_kdev(struct rtdm_spi_master *master)
 {
-	return &master->kmaster->dev;
+	return &master->controller->dev;
 }
 
 static inline u32 mcspi_rd_reg(struct spi_master_omap2_mcspi *spim,
@@ -881,7 +881,7 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 {
 	struct spi_master_omap2_mcspi *spim;
 	struct rtdm_spi_master *master;
-	struct spi_master *kmaster;
+	struct spi_controller *ctlr;
 	struct resource *r;
 	int ret, irq;
 	u32 regs_offset = 0;
@@ -912,21 +912,21 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 	master->ops = &omap2_mcspi_master_ops;
 	platform_set_drvdata(pdev, master);
 
-	kmaster = master->kmaster;
+	ctlr = master->controller;
 	/* flags understood by this controller driver */
-	kmaster->mode_bits = OMAP2_MCSPI_SPI_MODE_BITS;
+	ctlr->mode_bits = OMAP2_MCSPI_SPI_MODE_BITS;
 	/* TODO: SPI_BPW_RANGE_MASK(4, 32); */
-	kmaster->bits_per_word_mask = SPI_BPW_MASK(8);
+	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
 	of_property_read_u32(pdev->dev.of_node, "ti,spi-num-cs", &num_cs);
-	kmaster->num_chipselect = num_cs;
+	ctlr->num_chipselect = num_cs;
 	if (of_get_property(pdev->dev.of_node,
 		"ti,pindir-d0-out-d1-in", NULL)) {
 		pin_dir = MCSPI_PINDIR_D0_OUT_D1_IN;
 	}
 
-	kmaster->max_speed_hz = OMAP2_MCSPI_MAX_FREQ;
-	kmaster->min_speed_hz = OMAP2_MCSPI_MAX_FREQ >> 15;
-	kmaster->dev.of_node = pdev->dev.of_node;
+	ctlr->max_speed_hz = OMAP2_MCSPI_MAX_FREQ;
+	ctlr->min_speed_hz = OMAP2_MCSPI_MAX_FREQ >> 15;
+	ctlr->dev.of_node = pdev->dev.of_node;
 
 	spim = container_of(master, struct spi_master_omap2_mcspi, master);
 	rtdm_event_init(&spim->transfer_done, 0);
@@ -987,7 +987,7 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 
 fail_unclk:
 fail:
-	spi_master_put(kmaster);
+	spi_controller_put(ctlr);
 
 	return ret;
 }
diff --git a/kernel/drivers/spi/spi-sun6i.c b/kernel/drivers/spi/spi-sun6i.c
index 36a2cd471..72a4abd0d 100644
--- a/kernel/drivers/spi/spi-sun6i.c
+++ b/kernel/drivers/spi/spi-sun6i.c
@@ -150,7 +150,7 @@ to_master_sun6i(struct rtdm_spi_remote_slave *slave)
 static inline struct device *
 master_to_kdev(struct rtdm_spi_master *master)
 {
-	return &master->kmaster->dev;
+	return &master->controller->dev;
 }
 
 static inline u32 sun6i_rd(struct spi_master_sun6i *spim,
@@ -509,7 +509,7 @@ static int sun6i_spi_probe(struct platform_device *pdev)
 {
 	struct rtdm_spi_master *master;
 	struct spi_master_sun6i *spim;
-	struct spi_master *kmaster;
+	struct spi_controller *ctlr;
 	struct resource *r;
 	int ret, irq;
 	u32 clk_rate;
@@ -525,13 +525,13 @@ static int sun6i_spi_probe(struct platform_device *pdev)
 	master->ops = &sun6i_master_ops;
 	platform_set_drvdata(pdev, master);
 
-	kmaster = master->kmaster;
-	kmaster->max_speed_hz = 100 * 1000 * 1000;
-	kmaster->min_speed_hz = 3 * 1000;
-	kmaster->mode_bits = SUN6I_SPI_MODE_BITS;
-	kmaster->bits_per_word_mask = SPI_BPW_MASK(8);
-	kmaster->num_chipselect = 4;
-	kmaster->dev.of_node = pdev->dev.of_node;
+	ctlr = master->controller;
+	ctlr->max_speed_hz = 100 * 1000 * 1000;
+	ctlr->min_speed_hz = 3 * 1000;
+	ctlr->mode_bits = SUN6I_SPI_MODE_BITS;
+	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
+	ctlr->num_chipselect = 4;
+	ctlr->dev.of_node = pdev->dev.of_node;
 
 	spim = container_of(master, struct spi_master_sun6i, master);
 	spim->setup = of_device_get_match_data(&pdev->dev);
@@ -572,8 +572,8 @@ static int sun6i_spi_probe(struct platform_device *pdev)
 	 * the fastest transfers properly.
 	 */
 	clk_rate = clk_get_rate(spim->mclk);
-	if (clk_rate < 2 * kmaster->max_speed_hz)
-		clk_set_rate(spim->mclk, 2 * kmaster->max_speed_hz);
+	if (clk_rate < 2 * ctlr->max_speed_hz)
+		clk_set_rate(spim->mclk, 2 * ctlr->max_speed_hz);
 
 	spim->clk_hz = clk_get_rate(spim->mclk);
 
@@ -624,7 +624,7 @@ fail_unclk:
 	clk_disable_unprepare(spim->mclk);
 	clk_disable_unprepare(spim->hclk);
 fail:
-	spi_master_put(kmaster);
+	spi_controller_put(ctlr);
 
 	return ret;
 }

-- 
2.39.2

