Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048ED1AA78
	for <xenomai@lists.linux.dev>; Thu, 31 Aug 2023 20:37:56 +0000 (UTC)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202308312037492991bbc9f0582b1dbd
        for <xenomai@lists.linux.dev>;
        Thu, 31 Aug 2023 22:37:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=yVNAmwy8+xF7JPLIXEVol9Fh/1mT8dx4r85fASXwNdE=;
 b=nDitC5MlKfqvlyVvXIKvQWBxZ/YsAbNDBjmtwfTcqIgEqpU1tf92bW5SdnFPGp7PbGE4O9
 nWyRSnRetlXtsivvjKEa0SDFTVQFN/ikyPTR9SR/HD1BbDZe7koj3lOC946oX1ihsOe9bnVE
 4xu5YXD9dHi6k698eOd/Bh7GcKBHk=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Thu, 31 Aug 2023 22:37:45 +0200
Subject: [PATCH stable/v3.2.x 19/19] drivers/spi: Add support for kernels <
 5.1
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230828-florian-enable-stable-3-2-for-6-1-v1-19-0e08770820e8@siemens.com>
References: <20230828-florian-enable-stable-3-2-for-6-1-v1-0-0e08770820e8@siemens.com>
In-Reply-To: <20230828-florian-enable-stable-3-2-for-6-1-v1-0-0e08770820e8@siemens.com>
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Upstream commit 7913f523e423 ("drivers/spi: Convert to GPIO descriptor API")
was taken into the stable branch 1:1.

This patch adds support for kernels < 5.1 on top so that we do not have
to drop for 4.19 kernels for the Xenomai stable releases.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/drivers/spi/spi-bcm2835.c | 26 ++++++++++++++++++++++++--
 kernel/drivers/spi/spi-device.c  | 39 +++++++++++++++++++++++++++++++--------
 kernel/drivers/spi/spi-master.c  |  2 ++
 3 files changed, 57 insertions(+), 10 deletions(-)

diff --git a/kernel/drivers/spi/spi-bcm2835.c b/kernel/drivers/spi/spi-bcm2835.c
index e8df8fe7e..a3fb0c75e 100644
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
@@ -460,9 +482,9 @@ static int find_cs_gpio(struct spi_device *spi)
 	int cs_gpio = -ENOENT;
 	int ret;
 
-	if (spi->cs_gpiod) {
+	if (xn_gpio_is_valid(spi)) {
 		dev_info(&spi->dev, "using GPIO%i for CS%d\n",
-			 desc_to_gpio(spi->cs_gpiod), spi->chip_select);
+			 xn_get_gpio(spi), spi->chip_select);
 		return 0;
 	}
 
diff --git a/kernel/drivers/spi/spi-device.c b/kernel/drivers/spi/spi-device.c
index 6e368bd55..d984facaa 100644
--- a/kernel/drivers/spi/spi-device.c
+++ b/kernel/drivers/spi/spi-device.c
@@ -25,6 +25,35 @@
 #include <linux/spi/spi.h>
 #include "spi-master.h"
 
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(5, 1, 0)
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
@@ -49,14 +78,8 @@ int rtdm_spi_add_remote_slave(struct rtdm_spi_remote_slave *slave,
 	if (dev->label == NULL)
 		return -ENOMEM;
 
-	if (spi->cs_gpiod)
-		slave->cs_gpiod = spi->cs_gpiod;
-	else {
-		slave->cs_gpiod = NULL;
-		if (ctlr->cs_gpiods)
-			slave->cs_gpiod = ctlr->cs_gpiods[spi->chip_select];
-	}
-	
+	rtdm_spi_slave_init(ctlr, slave, spi);
+
 	mutex_init(&slave->ctl_lock);
 
 	dev->device_data = master;
diff --git a/kernel/drivers/spi/spi-master.c b/kernel/drivers/spi/spi-master.c
index cffeaf087..9bddb9e47 100644
--- a/kernel/drivers/spi/spi-master.c
+++ b/kernel/drivers/spi/spi-master.c
@@ -355,7 +355,9 @@ __rtdm_spi_alloc_master(struct device *dev, size_t size, int off)
 	if (ctlr == NULL)
 		return NULL;
 
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(5,1,0)
 	ctlr->use_gpio_descriptors = true;
+#endif
 	master = (void *)(ctlr + 1) + off;
 	master->controller = ctlr;
 	spi_master_set_devdata(ctlr, master);

-- 
2.39.2

