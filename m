From: Zqiang <qiang1.zhang@intel.com>
Subject: [linux-dovetail][PATCH 3/3] mfd: intel-ehl-gpio: Introduce MFD
 framework to PSE GPIO/TGPIO
Date: Tue, 17 May 2022 09:53:18 +0800
Message-Id: <20220517015318.697955-4-qiang1.zhang@intel.com>
In-Reply-To: <20220517015318.697955-1-qiang1.zhang@intel.com>
References: <20220517015318.697955-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: rpm@xenomai.org, jan.kiszka@siemens.com
Cc: hongzhan.chen@intel.com, xenomai@xenomai.org

From: Raymond Tan <raymond.tan@intel.com>

In Elkhart Lake, the PSE GPIO and TGPIO shares the PCI device,
albeit being accessed at different MMIO BAR offset. Thus, to properly
register device drivers and enable support of both functionalities,
we choose Linux MFD framework.

1) intel-ehl-gpio - probe base on the PCI device, and split the resources
2) ptp-intel-tgpio-plat - platform driver which will register support of
PSE TGPIO (20 pins max per device)

Note: BIOS configuration is required to properly assign the pin-mux.
Note: PSE TGPIO driver is based on Balbi Felipe's original driver.
Note: PSE GPIO driver is based on Pandith N's original driver.

Signed-off-by: N Pandith <pandith.n@intel.com>
Signed-off-by: Raymond Tan <raymond.tan@intel.com>
Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 drivers/mfd/Kconfig          |  12 ++
 drivers/mfd/Makefile         |   1 +
 drivers/mfd/intel-ehl-gpio.c | 248 +++++++++++++++++++++++++++++++++++
 3 files changed, 261 insertions(+)
 create mode 100644 drivers/mfd/intel-ehl-gpio.c

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index b8847ae04d93..c36b35100ead 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -2168,5 +2168,17 @@ config MFD_INTEL_M10_BMC
 	  additional drivers must be enabled in order to use the functionality
 	  of the device.
 
+config MFD_INTEL_EHL_PSE_GPIO
+	tristate "Intel Elkhart Lake PSE GPIO MFD"
+	depends on PCI
+	depends on X86
+	select MFD_CORE
+	help
+	  This MFD provides support for GPIO and TGPIO that exist only
+	  in a signle PCI device.
+
+	  IT splits the 2 IO devices to their
+	  respective drivers.
+
 endmenu
 endif
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 1780019d2474..5f7912391237 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -267,3 +267,4 @@ obj-$(CONFIG_MFD_KHADAS_MCU) 	+= khadas-mcu.o
 obj-$(CONFIG_SGI_MFD_IOC3)	+= ioc3.o
 obj-$(CONFIG_MFD_SIMPLE_MFD_I2C)	+= simple-mfd-i2c.o
 obj-$(CONFIG_MFD_INTEL_M10_BMC)   += intel-m10-bmc.o
+obj-$(CONFIG_MFD_INTEL_EHL_PSE_GPIO)    += intel-ehl-gpio.o
diff --git a/drivers/mfd/intel-ehl-gpio.c b/drivers/mfd/intel-ehl-gpio.c
new file mode 100644
index 000000000000..9db5601ab39c
--- /dev/null
+++ b/drivers/mfd/intel-ehl-gpio.c
@@ -0,0 +1,248 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Intel Multi-Functional Driver driver for Elkhart Lake
+ * Programmable Service Engine (PSE) GPIO & TGPIO Functions
+ *
+ * Copyright(c) 2020 Intel Corporation.
+ *
+ * Intel Elkhart Lake PSE has 2 PCI devices which exposes 2 different
+ * functions of GPIO and Timed-GPIO based on the BIOS configurations
+ * and exposes the programmability through different offset from the
+ * MMIO BAR of the PCI device.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/device.h>
+#include <linux/mfd/core.h>
+#include <linux/pm_runtime.h>
+
+#define PSE_GPIO_OFFSET		0x0000
+#define PSE_TGPIO_OFFSET	0x1000
+#define PSE_PRIV_OFFSET		0x2000
+#define PSE_GPIO_SIZE		0x134
+#define PSE_TGPIO_SIZE		0x6B0
+#define PSE_PRIV_SIZE		0x8
+
+#define PSE_GPIO_D0I3C		1000
+#define PSE_GPIO_CGSR		1004
+#define PSE_GPIO_D0I3_CIP	BIT(0)
+#define PSE_GPIO_D0I3_IR	BIT(1)
+#define PSE_GPIO_D0I3_EN	BIT(2)
+#define PSE_GPIO_D0I3_RR	BIT(3)
+#define PSE_GPIO_CGSR_CG	BIT(16)
+
+static struct resource intel_ehl_pse_gpio_resources[] = {
+	DEFINE_RES_MEM(PSE_GPIO_OFFSET, PSE_GPIO_SIZE),
+	DEFINE_RES_IRQ(0),
+};
+
+static struct resource intel_ehl_pse_tgpio_resources[] = {
+	DEFINE_RES_MEM(PSE_TGPIO_OFFSET, PSE_TGPIO_SIZE),
+	DEFINE_RES_IRQ(1),
+};
+
+struct intel_ehl_pse_gpio_data {
+	struct resource *mem;
+	int irq;
+	struct device *dev;
+	void __iomem *priv;
+};
+
+struct intel_ehl_pse_gpio_priv {
+	const struct intel_ehl_pse_gpio_data *info; // array for gpio & tgpio
+
+	struct mfd_cell *cell; // array for gpio & tgpio
+};
+
+static struct mfd_cell intel_ehl_pse_gpio_mfd_devs[] = {
+	{
+		.name = "gpio-ehl-pse",
+		.num_resources = ARRAY_SIZE(intel_ehl_pse_gpio_resources),
+		.resources = intel_ehl_pse_gpio_resources,
+		.ignore_resource_conflicts = true,
+	},
+	{
+		.name = "intel-ehl-tgpio",
+		.num_resources = ARRAY_SIZE(intel_ehl_pse_tgpio_resources),
+		.resources = intel_ehl_pse_tgpio_resources,
+		.ignore_resource_conflicts = true,
+	},
+};
+
+
+static int intel_ehl_pse_gpio_mfd_probe(struct pci_dev *pci,
+					const struct pci_device_id *id)
+{
+	int ret;
+	struct intel_ehl_pse_gpio_data *pdata;
+
+	pdata = devm_kzalloc(&pci->dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return -ENOMEM;
+
+	ret = pcim_enable_device(pci);
+	if (ret)
+		return ret;
+
+	pci_set_master(pci);
+
+	ret = pci_alloc_irq_vectors(pci, 2, 2, PCI_IRQ_ALL_TYPES);
+	if (ret < 0)
+		return ret;
+
+	pdata->irq = pci_irq_vector(pci, 0);
+	pdata->mem = &pci->resource[0];
+
+	pdata->priv = devm_ioremap(&pci->dev, pdata->mem->start +
+			PSE_PRIV_OFFSET, PSE_PRIV_SIZE);
+	if (!pdata->priv)
+		return -ENOMEM;
+
+	pci_set_drvdata(pci, pdata);
+
+	ret = mfd_add_devices(&pci->dev, PLATFORM_DEVID_AUTO,
+			intel_ehl_pse_gpio_mfd_devs,
+			ARRAY_SIZE(intel_ehl_pse_gpio_mfd_devs),
+			pdata->mem, pdata->irq, NULL);
+
+	pm_runtime_set_autosuspend_delay(&pci->dev, 1000);
+	pm_runtime_use_autosuspend(&pci->dev);
+	pm_runtime_put_autosuspend(&pci->dev);
+	pm_runtime_allow(&pci->dev);
+
+	return 0;
+}
+
+static void intel_ehl_pse_gpio_mfd_remove(struct pci_dev *pci)
+{
+	pm_runtime_forbid(&pci->dev);
+	pm_runtime_get_noresume(&pci->dev);
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int intel_ehl_pse_gpio_mfd_suspend(struct device *dev)
+{
+	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
+	struct intel_ehl_pse_gpio_data	*pdata = pci_get_drvdata(pdev);
+	u32 d0i3c_reg, cgsr_reg = 0;
+
+	d0i3c_reg = readl(pdata->priv + PSE_GPIO_D0I3C);
+	cgsr_reg = readl(pdata->priv + PSE_GPIO_CGSR);
+
+	/* enable D0i3 BIT(2) & disable interrupt BIT(1)*/
+	d0i3c_reg |= PSE_GPIO_D0I3_EN;
+	d0i3c_reg &= ~PSE_GPIO_D0I3_IR;
+
+	/* enable clock gating BIT(16)*/
+	cgsr_reg |= PSE_GPIO_CGSR_CG;
+
+	writel(d0i3c_reg, pdata->priv + PSE_GPIO_D0I3C);
+	writel(cgsr_reg, pdata->priv + PSE_GPIO_CGSR);
+
+	return 0;
+}
+
+static int intel_ehl_pse_gpio_mfd_resume(struct device *dev)
+{
+	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
+	struct intel_ehl_pse_gpio_data	*pdata = pci_get_drvdata(pdev);
+	struct timespec64 *ts;
+	u32 d0i3c_reg, cgsr_reg = 0;
+
+	ts = devm_kzalloc(dev, sizeof(*ts), GFP_KERNEL);
+
+	d0i3c_reg = readl(pdata->priv + PSE_GPIO_D0I3C);
+	cgsr_reg = readl(pdata->priv + PSE_GPIO_CGSR);
+
+	/* disable D0i3 BIT(2) & disable interrupt BIT(1)*/
+	d0i3c_reg &= ~(PSE_GPIO_D0I3_IR | PSE_GPIO_D0I3_EN);
+
+	/* disable clock gating BIT(16)*/
+	cgsr_reg &= ~PSE_GPIO_CGSR_CG;
+
+	writel(d0i3c_reg, pdata->priv + PSE_GPIO_D0I3C);
+	writel(cgsr_reg, pdata->priv + PSE_GPIO_CGSR);
+
+	return 0;
+}
+#endif
+
+#ifdef CONFIG_PM
+static int intel_ehl_pse_gpio_mfd_runtime_suspend(struct device *dev)
+{
+	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
+	struct intel_ehl_pse_gpio_data	*pdata = pci_get_drvdata(pdev);
+	u32 d0i3c_reg, cgsr_reg = 0;
+
+	d0i3c_reg = readl(pdata->priv + PSE_GPIO_D0I3C);
+	cgsr_reg = readl(pdata->priv + PSE_GPIO_CGSR);
+
+	/* enable D0i3 BIT(2) & disable interrupt BIT(1)*/
+	d0i3c_reg |= PSE_GPIO_D0I3_EN;
+	d0i3c_reg &= ~PSE_GPIO_D0I3_IR;
+
+	/* enable clock gating BIT(16)*/
+	cgsr_reg |= PSE_GPIO_CGSR_CG;
+
+	writel(d0i3c_reg, pdata->priv + PSE_GPIO_D0I3C);
+	writel(cgsr_reg, pdata->priv + PSE_GPIO_CGSR);
+
+	return 0;
+}
+
+static int intel_ehl_pse_gpio_mfd_runtime_resume(struct device *dev)
+{
+	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
+	struct intel_ehl_pse_gpio_data	*pdata = pci_get_drvdata(pdev);
+	struct timespec64 *ts;
+	u32 d0i3c_reg, cgsr_reg = 0;
+
+	ts = devm_kzalloc(dev, sizeof(*ts), GFP_KERNEL);
+
+	d0i3c_reg = readl(pdata->priv + PSE_GPIO_D0I3C);
+	cgsr_reg = readl(pdata->priv + PSE_GPIO_CGSR);
+
+	/* disable D0i3 BIT(2) & disable interrupt BIT(1)*/
+	d0i3c_reg &= ~(PSE_GPIO_D0I3_IR | PSE_GPIO_D0I3_EN);
+
+	/* disable clock gating BIT(16)*/
+	cgsr_reg &= ~PSE_GPIO_CGSR_CG;
+
+	writel(d0i3c_reg, pdata->priv + PSE_GPIO_D0I3C);
+	writel(cgsr_reg, pdata->priv + PSE_GPIO_CGSR);
+
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops intel_ehl_pse_gpio_mfd_pm_ops = {
+	SET_RUNTIME_PM_OPS(intel_ehl_pse_gpio_mfd_runtime_suspend,
+			intel_ehl_pse_gpio_mfd_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(intel_ehl_pse_gpio_mfd_suspend,
+			intel_ehl_pse_gpio_mfd_resume)
+};
+
+static const struct pci_device_id intel_ehl_pse_gpio_mfd_ids[] = {
+	{ PCI_VDEVICE(INTEL, 0x4b88), },
+	{ PCI_VDEVICE(INTEL, 0x4b89), },
+	{ },
+};
+MODULE_DEVICE_TABLE(pci, intel_ehl_pse_gpio_mfd_ids);
+
+static struct pci_driver intel_ehl_pse_gpio_mfd_driver = {
+	.name		= "intel_ehl_pse_gpio_mfd",
+	.id_table	= intel_ehl_pse_gpio_mfd_ids,
+	.probe		= intel_ehl_pse_gpio_mfd_probe,
+	.remove		= intel_ehl_pse_gpio_mfd_remove,
+	.driver = {
+		.pm = &intel_ehl_pse_gpio_mfd_pm_ops,
+	},
+};
+
+module_pci_driver(intel_ehl_pse_gpio_mfd_driver);
+
+MODULE_AUTHOR("Raymond Tan <raymond.tan@intel.com>");
+MODULE_DESCRIPTION("Intel MFD Driver for Elkhart Lake PSE TGPIO/GPIO");
+MODULE_LICENSE("GPL v2");
-- 
2.25.1


