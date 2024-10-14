Received: from out28-171.mail.aliyun.com (out28-171.mail.aliyun.com [115.124.28.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073DBD2FA
	for <xenomai@lists.linux.dev>; Mon, 14 Oct 2024 01:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728871024; cv=none; b=Uj93qvqrq5RYGUS5+xB5MlcibVBqy7fMwJpLTYNrOFJ7aOH/9rdj12w23Wiod3WxqVJlubqx2Pboy0zSJNSYBzBzSNcDc65PW3ZLIFQ00TXkAtzCQUQEh/NIyI7cHLdkN5TQjIpwIm7mjshhl8QtegqKLiXmkBkvRNeRb3eZeYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728871024; c=relaxed/simple;
	bh=fxN71CkZpSJ9RI6zJq9Rh2WeozEyJvHF7xwPchxQOKg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HdligJCkghd7UCL1mE9QiZBExiU5u2OWlsm0qyFKEnG0RF6q2QF7VmktI9NShu+1IVWlSa1k4C+rLRqhM31WAiXOnTuWRrMl89l7XeUri+jp+Ot625n/lAq9csqQUtWhFWKOVTFwVrlYK4d86j2zI7UPWeVE9XzhxU0B/qDk7E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sinsegye.com.cn; spf=none smtp.mailfrom=sinsegye.com.cn; arc=none smtp.client-ip=115.124.28.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sinsegye.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sinsegye.com.cn
Received: from sinsegye..(mailfrom:liuyang@sinsegye.com.cn fp:SMTPD_---.ZhEP689_1728871010 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 14 Oct 2024 09:56:51 +0800
From: liuyang <liuyang@sinsegye.com.cn>
To: xenomai@lists.linux.dev
Cc: liuyang <liuyang@sinsegye.com.cn>
Subject: [PATCH] add f81601 support
Date: Mon, 14 Oct 2024 09:56:48 +0800
Message-Id: <20241014015648.883157-1-liuyang@sinsegye.com.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: liuyang <liuyang@sinsegye.com.cn>
---
 .gitlab-ci.yml                                |   1 +
 kernel/drivers/can/sja1000/Kconfig            |  11 +
 kernel/drivers/can/sja1000/Makefile           |   2 +
 kernel/drivers/can/sja1000/rtcan_f81601_pci.c | 226 ++++++++++++++++++
 4 files changed, 240 insertions(+)
 create mode 100644 kernel/drivers/can/sja1000/rtcan_f81601_pci.c

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index ad6f37d1c..892c20b9c 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -113,6 +113,7 @@ variables:
     - ./scripts/config -e XENO_DRIVERS_CAN_SJA1000_EMS_PCI
     - ./scripts/config -e XENO_DRIVERS_CAN_SJA1000_ESD_PCI
     - ./scripts/config -e XENO_DRIVERS_CAN_SJA1000_PEAK_DNG
+    - ./scripts/config -e XENO_DRIVERS_CAN_SJA1000_F81601
     - ./scripts/config -e XENO_DRIVERS_CAN_PEAK_CANFD
     - ./scripts/config -e XENO_DRIVERS_CAN_C_CAN
     - ./scripts/config -e XENO_DRIVERS_CAN_C_CAN_PLATFORM
diff --git a/kernel/drivers/can/sja1000/Kconfig b/kernel/drivers/can/sja1000/Kconfig
index 9fab4a475..043f7aac1 100644
--- a/kernel/drivers/can/sja1000/Kconfig
+++ b/kernel/drivers/can/sja1000/Kconfig
@@ -98,3 +98,14 @@ config XENO_DRIVERS_CAN_SJA1000_PEAK_DNG
 	to disable parallel port support in the kernel (CONFIG_PARPORT) for
 	proper operation. The interface type (sp or epp), I/O port and
 	interrupt number should be defined via module parameters.
+
+config XENO_DRIVERS_CAN_SJA1000_F81601
+    depends on XENO_DRIVERS_CAN_SJA1000 && PCI
+    tristate "Fintek F81601 PCIE to 2 CAN Controller"
+    help
+      This driver adds support for Fintek F81601 PCIE to 2 CAN
+      Controller. It had internal 24MHz clock source, but it can
+      be changed by manufacturer. Use modinfo to get usage for
+      parameters. Visit http://www.fintek.com.tw to get more
+      information.
+
diff --git a/kernel/drivers/can/sja1000/Makefile b/kernel/drivers/can/sja1000/Makefile
index ff6715513..2d344c37b 100644
--- a/kernel/drivers/can/sja1000/Makefile
+++ b/kernel/drivers/can/sja1000/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_XENO_DRIVERS_CAN_SJA1000_EMS_PCI) += xeno_can_ems_pci.o
 obj-$(CONFIG_XENO_DRIVERS_CAN_SJA1000_ESD_PCI) += xeno_can_esd_pci.o
 obj-$(CONFIG_XENO_DRIVERS_CAN_SJA1000_ISA) += xeno_can_isa.o
 obj-$(CONFIG_XENO_DRIVERS_CAN_SJA1000_MEM) += xeno_can_mem.o
+obj-$(CONFIG_XENO_DRIVERS_CAN_SJA1000_F81601) += xeno_can_f81601.o
 
 xeno_can_sja1000-y := rtcan_sja1000.o
 xeno_can_sja1000-$(CONFIG_FS_PROCFS) += rtcan_sja1000_proc.o
@@ -22,3 +23,4 @@ xeno_can_ems_pci-y := rtcan_ems_pci.o
 xeno_can_esd_pci-y := rtcan_esd_pci.o
 xeno_can_isa-y := rtcan_isa.o
 xeno_can_mem-y := rtcan_mem.o
+xeno_can_f81601-y := rtcan_f81601_pci.o
diff --git a/kernel/drivers/can/sja1000/rtcan_f81601_pci.c b/kernel/drivers/can/sja1000/rtcan_f81601_pci.c
new file mode 100644
index 000000000..0e577ce5f
--- /dev/null
+++ b/kernel/drivers/can/sja1000/rtcan_f81601_pci.c
@@ -0,0 +1,226 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Fintek F81601 PCIE to 2 CAN controller driver, ported to Xenomai RTDM
+ * only use CAN controller 0
+ * Copyright (C) 2024 Liu Yang <liuyang@sinsegye.com.cn>
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/pci.h>
+#include <linux/io.h>
+
+#include <rtdm/driver.h>
+
+/* CAN device profile */
+#include <rtdm/can.h>
+#include <rtcan_dev.h>
+#include <rtcan_raw.h>
+#include <rtcan_internal.h>
+#include <rtcan_sja1000.h>
+#include <rtcan_sja1000_regs.h>
+
+static char *f81601_pci_board_name = "F81601-PCI";
+#define RTCAN_DRV_NAME "rt_sja1000_f81601_pci"
+#define RTCAN_DEV_NAME "rtcan%d"
+
+#define F81601_PCI_MAX_CHAN		1
+
+#define F81601_DECODE_REG		0x209
+#define F81601_IO_MODE			BIT(7)
+#define F81601_MEM_MODE			BIT(6)
+#define F81601_CFG_MODE			BIT(5)
+#define F81601_CAN2_INTERNAL_CLK	BIT(3)
+#define F81601_CAN1_INTERNAL_CLK	BIT(2)
+#define F81601_CAN2_EN			BIT(1)
+#define F81601_CAN1_EN			BIT(0)
+
+#define F81601_TRAP_REG			0x20a
+#define F81601_CAN2_HAS_EN		BIT(4)
+
+struct f81601_pci_card {
+	void __iomem *addr;
+	struct pci_dev *dev;
+	struct rtcan_device *rtcan_dev[F81601_PCI_MAX_CHAN];
+};
+
+static const struct pci_device_id f81601_pci_tbl[] = {
+	{ PCI_DEVICE(0x1c29, 0x1703) },
+	{ /* sentinel */ },
+};
+
+MODULE_DEVICE_TABLE(pci, f81601_pci_tbl);
+
+static bool internal_clk = true;
+module_param(internal_clk, bool, 0444);
+MODULE_PARM_DESC(internal_clk, "Use internal clock, default true (24MHz)");
+
+static unsigned int external_clk;
+module_param(external_clk, uint, 0444);
+MODULE_PARM_DESC(external_clk, "External clock when internal_clk disabled");
+
+static u8 f81601_pci_read_reg(struct rtcan_device *dev, int port)
+{
+	return readb((void * __iomem)dev->base_addr + port);
+}
+
+static void f81601_pci_write_reg(struct rtcan_device *dev, int port,
+				 u8 val)
+{
+	writeb(val, (void * __iomem)dev->base_addr + port);
+	readb((void * __iomem)dev->base_addr);
+}
+
+static void f81601_pci_remove(struct pci_dev *pdev)
+{
+	struct f81601_pci_card *card = pci_get_drvdata(pdev);
+	struct rtcan_device *dev;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(card->rtcan_dev); i++) {
+		dev = card->rtcan_dev[i];
+		if (!dev)
+			continue;
+
+		dev_info(&pdev->dev, "%s: Removing %s\n", __func__, dev->name);
+
+		rtcan_sja1000_unregister(dev);
+		if (card->addr)
+			pci_iounmap(pdev, card->addr);
+		rtcan_dev_free(dev);
+	}
+
+	kfree(card);
+}
+
+/* Probe F81601 based device for the SJA1000 chips and register each
+ * available CAN channel to SJA1000 Socket-CAN subsystem.
+ */
+static int f81601_pci_probe(struct pci_dev *pdev,
+			    const struct pci_device_id *ent)
+{
+	struct rtcan_sja1000 *chip;
+	struct f81601_pci_card *card;
+	struct rtcan_device *dev;
+
+	int err, i, count;
+	u8 tmp;
+
+	if (!rtdm_available())
+		return -ENODEV;
+
+	/* Enabling PCI device */
+	if (pci_enable_device(pdev) < 0) {
+		dev_err(&pdev->dev, "Enabling PCI device failed\n");
+		return -ENODEV;
+	}
+
+	/* Allocating card structures to hold addresses, ... */
+	card = kzalloc(sizeof(*card), GFP_KERNEL);
+	if (card == NULL) {
+		pci_disable_device(pdev);
+		return -ENOMEM;
+	}
+
+	card->dev = pdev;
+
+	pci_set_drvdata(pdev, card);
+
+	tmp = F81601_IO_MODE | F81601_MEM_MODE | F81601_CFG_MODE |
+		F81601_CAN2_EN | F81601_CAN1_EN;
+
+	if (internal_clk) {
+		tmp |= F81601_CAN2_INTERNAL_CLK | F81601_CAN1_INTERNAL_CLK;
+
+		dev_info(&pdev->dev,
+			 "F81601 running with internal clock: 24Mhz\n");
+	} else {
+		dev_info(&pdev->dev,
+			 "F81601 running with external clock: %dMhz\n",
+			 external_clk / 1000000);
+	}
+
+	pci_write_config_byte(pdev, F81601_DECODE_REG, tmp);
+
+	card->addr = pci_iomap(pdev, 0, pci_resource_len(pdev, 0));
+
+	if (!card->addr) {
+		err = -ENOMEM;
+		dev_err(&pdev->dev, "%s: Failed to remap BAR\n", __func__);
+		goto failure_cleanup;
+	}
+
+	/* read CAN2_HW_EN strap pin to detect how many CANBUS do we have */
+	count = ARRAY_SIZE(card->rtcan_dev);
+	pci_read_config_byte(pdev, F81601_TRAP_REG, &tmp);
+	if (!(tmp & F81601_CAN2_HAS_EN))
+		count = 1;
+
+	for (i = 0; i < count; i++) {
+		dev = rtcan_dev_alloc(sizeof(struct rtcan_sja1000), 0);
+		if (!dev) {
+			err = -ENOMEM;
+			goto failure_cleanup;
+		}
+
+	/* set rtcan_device struct */
+	dev->base_addr  = (unsigned long)card->addr + 0x80 * i;
+	dev->board_name = f81601_pci_board_name;
+	strncpy(dev->name, RTCAN_DEV_NAME, IFNAMSIZ);
+
+	if (internal_clk)
+		dev->can_sys_clock = 24000000 / 2;
+	else
+		dev->can_sys_clock = external_clk / 2;
+
+	/* get rtcan_sja1000 struct */
+	card->rtcan_dev[i] = dev;
+	chip = card->rtcan_dev[i]->priv;
+
+	/* set rtcan_sja1000 struct */
+	chip->irq_flags = RTDM_IRQTYPE_SHARED;
+	chip->irq_num   = pdev->irq;
+	chip->read_reg  = f81601_pci_read_reg;
+	chip->write_reg = f81601_pci_write_reg;
+	chip->ocr = SJA_OCR_TX0_PUSHPULL | SJA_OCR_TX1_PUSHPULL | SJA_OCR_MODE_NORMAL;
+	/* Clock divider register */
+	chip->cdr = SJA_CDR_CBP;
+
+	/* Register SJA1000 device */
+	err = rtcan_sja1000_register(dev);
+	if (err) {
+		dev_err(&pdev->dev,
+			"%s: Registering device failed: %x\n", __func__,
+			err);
+		goto failure_cleanup;
+	}
+
+	dev_info(&pdev->dev, "Channel #%d at 0x%p, irq %d registered as %s\n", i,
+		(void * __iomem)dev->base_addr, chip->irq_num, dev->name);
+	}
+
+	/* force into reset mode */
+	chip->write_reg(dev, SJA_MOD, SJA_MOD_RM);
+
+	return 0;
+
+ failure_cleanup:
+	dev_err(&pdev->dev, "%s: failed: %d. Cleaning Up.\n", __func__, err);
+	f81601_pci_remove(pdev);
+
+	return err;
+}
+
+static struct pci_driver f81601_pci_driver = {
+	.name =	RTCAN_DRV_NAME,
+	.id_table = f81601_pci_tbl,
+	.probe = f81601_pci_probe,
+	.remove = f81601_pci_remove,
+};
+
+MODULE_DESCRIPTION("Fintek F81601 PCIE to 2 CANBUS adaptor driver");
+MODULE_AUTHOR("Liu Yang <liuyang@sinsegye.com.cn>");
+MODULE_LICENSE("GPL v2");
+
+module_pci_driver(f81601_pci_driver);
+
-- 
2.34.1

