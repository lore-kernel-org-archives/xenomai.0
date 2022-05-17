From: Zqiang <qiang1.zhang@intel.com>
Subject: [PATCH 3/4] ptp/pse-tgpio: introduce PSE Time-Aware GPIO driver for
 Intel Processors
Date: Tue, 17 May 2022 09:51:51 +0800
Message-Id: <20220517015152.697886-4-qiang1.zhang@intel.com>
In-Reply-To: <20220517015152.697886-1-qiang1.zhang@intel.com>
References: <20220517015152.697886-1-qiang1.zhang@intel.com>
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

The PSE GPIO and TGPIO shares the PCI device, albeit being accessed at
different MMIO BAR offset. Thus, to properly register device drivers and
enable support of both functionalities, it depends on intel-ehl-gpio driver
(CONFIG_MFD_INTEL_EHL_PSE_GPIO need to enable)to initialize hardware resources.
note: this driver only supports Intel Atom x6000 series processors.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/drivers/ptp/Kconfig     |  24 ++
 kernel/drivers/ptp/Makefile    |   3 +
 kernel/drivers/ptp/pse-tgpio.c | 568 +++++++++++++++++++++++++++++++++
 3 files changed, 595 insertions(+)
 create mode 100644 kernel/drivers/ptp/pse-tgpio.c

diff --git a/kernel/drivers/ptp/Kconfig b/kernel/drivers/ptp/Kconfig
index 12e1e4b..177a389 100644
--- a/kernel/drivers/ptp/Kconfig
+++ b/kernel/drivers/ptp/Kconfig
@@ -17,4 +17,28 @@ config XENO_DRIVERS_PTP_PMC_TGPIO
 	Intel Advanced Menu > PCH IO Configuration > Enabled Timed GPIO0 [Enable]
 	Intel Advanced Menu > PCH IO Configuration > Enabled Timed GPIO1 [Enable]
 
+config XENO_DRIVERS_PTP_PSE_TGPIO
+	tristate "Intel PSE Timed GPIO"
+	depends on XENO_DRIVERS_PTP
+	default n
+	help
+	This driver adds support for Intel PSE Timed-Aware GPIO (TGPIO)
+	note: BIOS configuration is required to properly assign the pin,
+	PSE TGPIO only for Intel Atom x6000 Series Processor.
+	To enable PSE Time-Aware GPIO, configure the following BIOS options:
+	Intel Advanced Menu > PCH IO Configuration > PSE configuration > Eclite
+	> Disable
+	Intel Advanced Menu > PCH IO Configuration > Security Configuration >
+	Force unlock on all GPIO pads > [Enabled]
+	Intel Advanced Menu > PCH IO Configuration > SerialIo Configuration >
+	SPI2 Controller > [Disabled]
+	Intel Advanced Menu > PCH IO Configuration > PSE configuration > SPI0 >
+	[Host owned with pin muxed]
+	Intel Advanced Menu > PCH IO Configuration > PSE configuration >
+	GPIO/TGPIO 0 > [Host owned with pin muxed]
+	Intel Advanced Menu > PCH IO Configuration > PSE configuration >
+	GPIO/TGPIO 0 MUX SELECTION > MID
+	Intel Advanced Menu > PCH IO Configuration > PSE configuration >
+	GPIO/TGPIO 0 Pin Selection > Check pins 28 and 27
+
 endmenu
diff --git a/kernel/drivers/ptp/Makefile b/kernel/drivers/ptp/Makefile
index aa1671c..3208427 100644
--- a/kernel/drivers/ptp/Makefile
+++ b/kernel/drivers/ptp/Makefile
@@ -3,3 +3,6 @@ xeno_ptp-y := ptp.o
 
 obj-$(CONFIG_XENO_DRIVERS_PTP_PMC_TGPIO) += xeno_pmc-tgpio.o
 xeno_pmc-tgpio-y := pmc-tgpio.o
+
+obj-$(CONFIG_XENO_DRIVERS_PTP_PSE_TGPIO) += xeno_pse-tgpio.o
+xeno_pse-tgpio-y := pse-tgpio.o
diff --git a/kernel/drivers/ptp/pse-tgpio.c b/kernel/drivers/ptp/pse-tgpio.c
new file mode 100644
index 0000000..c5604bc
--- /dev/null
+++ b/kernel/drivers/ptp/pse-tgpio.c
@@ -0,0 +1,568 @@
+/**
+ * I/O handling lifted from drivers/ptp/ptp-intel-tgpio-plat.c
+ * Intel Timed GPIO Controller Driver
+ *
+ * Copyright (C) 2018 Intel Corporation
+ * Author: Felipe Balbi <felipe.balbi@linux.intel.com>
+ *
+ * RTDM integration by:
+ * Copyright (C) 2022 Zqiang <qiang1.zhang@intel.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ */
+#include <linux/acpi.h>
+#include <linux/bitops.h>
+#include <linux/gpio.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/mfd/core.h>
+#include <linux/pm_runtime.h>
+#include "ptp.h"
+
+#define TGPIOCTL(n)		(((n) * 0x40) + 0x00)
+#define TGPIOCOMPV31_0(n)	(((n) * 0x40) + 0x04)
+#define TGPIOCOMPV63_32(n)	(((n) * 0x40) + 0x08)
+#define TGPIOPIV31_0(n)		(((n) * 0x40) + 0x0c)
+#define TGPIOPIV63_32(n)	(((n) * 0x40) + 0x10)
+#define TGPIOTCV31_0(n)		(((n) * 0x40) + 0x14)
+#define TGPIOTCV63_32(n)	(((n) * 0x40) + 0x18)
+#define TGPIOECCV31_0(n)	(((n) * 0x40) + 0x1c)
+#define TGPIOECCV63_32(n)	(((n) * 0x40) + 0x20)
+#define TGPIOEC31_0(n)		(((n) * 0x40) + 0x24)
+#define TGPIOEC63_32(n)		(((n) * 0x40) + 0x28)
+
+#define TGPIOINTRCTL		0x0500
+#define TGPIORIS		0x0504
+#define TGPIOMSC		0x0508
+#define TGPIOMIS		0x050c
+#define TGPIOICR		0x0510
+#define TGPIO_CLK_SEL		0x0514
+#define TGPIO_TS_SEL_0		0x0520
+#define TGPIO_TS_SEL_1		0x0524
+#define TMT_CLK_SEL		0x0528
+#define TGPIO_TSC_CTL		0x0530
+#define TGPIO_TSC_STATUS	0x0534
+#define TMTCTL_TSG		0x0600
+#define TMTR_TSG		0x0604
+#define TMTL_TSG		0x0608
+#define TMTH_TSG		0x060C
+#define TIMINCA_TSG		0x0610
+#define TIMADJ_TSG		0x0614
+#define LXTS_TMT_LOW_TSG	0x0618
+#define LXTS_TMT_HIGH_TSG	0x061C
+#define LXTS_ART_LOW_TSG	0x0620
+#define LXTS_ART_HIGH_TSG	0x0624
+#define RXTS_TMT_LOW_TSG	0x0628
+#define RXTS_TMT_HIGH_TSG	0x062C
+#define TMTCTL_GLOBAL		0x0640
+#define TMTR_GLOBAL		0x0644
+#define TMTL_GLOBAL		0x0648
+#define TMTH_GLOBAL		0x064C
+#define TIMINCA_GLOBAL		0x0650
+#define TIMADJ_GLOBAL		0x0654
+#define LXTS_TMT_LOW_GLOBAL	0x0658
+#define LXTS_TMT_HIGH_GLOBAL	0x065C
+#define LXTS_ART_LOW_GLOBAL	0x0660
+#define LXTS_ART_HIGH_GLOBAL	0x0664
+#define RXTS_TMT_LOW_GLOBAL	0x0668
+#define RXTS_TMT_HIGH_GLOBAL	0x066C
+#define TMTCTL_WORKING		0x0680
+#define TMTR_WORKING		0x0684
+#define TMTL_WORKING		0x0688
+#define TMTH_WORKING		0x068C
+#define TIMINCA_WORKING		0x0690
+#define TIMADJ_WORKING		0x0694
+#define LXTS_TMT_LOW_WORKING	0x0698
+#define LXTS_TMT_HIGH_WORKING	0x069C
+#define LXTS_ART_LOW_WORKING	0x06A0
+#define LXTS_ART_HIGH_WORKING	0x06A4
+#define RXTS_TMT_LOW_WORKING	0x06A8
+#define RXTS_TMT_HIGH_WORKING	0x06AC
+
+/* Control Register */
+#define TGPIOCTL_EN			BIT(0)
+#define TGPIOCTL_DIR			BIT(1)
+#define TGPIOCTL_EP			GENMASK(3, 2)
+#define TGPIOCTL_EP_RISING_EDGE		(0 << 2)
+#define TGPIOCTL_EP_FALLING_EDGE	(1 << 2)
+#define TGPIOCTL_EP_TOGGLE_EDGE		(2 << 2)
+#define TGPIOCTL_PM			BIT(4)
+#define TGPIOCTL_PWS			GENMASK(8, 5)
+#define TGPIOCTL_PWS_N(n)		(((n) & 0xf) << 5)
+#define TGPIOCTL_ICS			BIT(9)
+#define TGPIOCTL_TSCS			BIT(10)
+#define TGPIOCTL_OEC			BIT(12)
+#define TGPIOCTL_FIT			BIT(13)
+#define TGPIOCTL_IEC			GENMASK(15, 14)
+#define TGPIOCTL_IEC_EC			BIT(14)
+#define TGPIOCTL_ECC			BIT(16)
+#define TGPIOCTL_PSL			GENMASK(24, 17)
+#define TGPIOCTL_TS			GENMASK(29, 28)
+#define TGPIOCTL_TS_TMT0		(0 << 28)
+#define TGPIOCTL_TS_TMT1		(1 << 28)
+#define TGPIOCTL_TS_TMT2		(2 << 28)
+#define TGPIOCTL_TS_LART		(3 << 28)
+
+/* Timed GPIO Interrupt Status/Mask/Clear registers */
+#define TGPIOINT_TMT_NSEC_WRAP_GLOBAL	BIT(25)
+#define TGPIOINT_TMT_NSEC_WRAP_WORKING	BIT(24)
+#define TGPIOINT_TMT_NSEC_WRAP_TSG	BIT(23)
+#define TGPIOINT_TADJ_TMT_GLOBAL_CMPLT	BIT(22)
+#define TGPIOINT_TADJ_TMT_WORKING_CMPLT	BIT(21)
+#define TGPIOINT_TADJ_TMT_TSG_CMPLT	BIT(20)
+#define TGPIOINT_EVENT_INTERRUPT(n)	BIT((n))
+
+/* Tunable Monotonous Timer Control Register */
+#define TMTCTL_TMT_ENABLE		BIT(0)
+
+#define NSECS_PER_SEC			1000000000
+#define TGPIO_MAX_ADJ_TIME		999999900
+
+#define TGPIO_MAX_PIN			20
+
+#define TGPIO_D0I3C		1000
+#define TGPIO_CGSR		1004
+#define TGPIO_D0I3_CIP		BIT(0)
+#define TGPIO_D0I3_IR		BIT(1)
+#define TGPIO_D0I3_EN		BIT(2)
+#define TGPIO_D0I3_RR		BIT(3)
+#define TGPIO_CGSR_CG		BIT(16)
+
+struct intel_tgpio {
+	struct rt_ptp_clock_info	info;
+	struct rt_ptp_clock	*clock;
+
+	rtdm_lock_t		lock;
+	struct device		*dev;
+	void __iomem		*base;
+	u32			irq_status;
+	u32			irq_mask;
+	u32			saved_ctl_regs[TGPIO_MAX_PIN];
+	u64			saved_piv_regs[TGPIO_MAX_PIN];
+	rtdm_irq_t		handle;
+	bool			is_interrupt;
+};
+
+#define to_intel_tgpio(i)	(container_of((i), struct intel_tgpio, info))
+
+#define ts64_to_ptp_clock_time(x) ((struct rt_ptp_clock_time){.sec = (x).tv_sec, \
+				    .nsec = (x).tv_nsec})
+
+static inline u64 to_intel_tgpio_time(struct rt_ptp_clock_time *t)
+{
+	return t->sec * NSECS_PER_SEC + t->nsec;
+}
+
+static inline u64 intel_tgpio_readq(void __iomem *base, u32 offset)
+{
+	return lo_hi_readq(base + offset);
+}
+
+static inline void intel_tgpio_writeq(void __iomem *base, u32 offset, u64 v)
+{
+	return lo_hi_writeq(v, base + offset);
+}
+
+static inline u32 intel_tgpio_readl(void __iomem *base, u32 offset)
+{
+	return readl(base + offset);
+}
+
+static inline void intel_tgpio_writel(void __iomem *base, u32 offset, u32 value)
+{
+	writel(value, base + offset);
+}
+
+static void intel_tgpio_get_time(struct intel_tgpio *tgpio,
+			struct timespec64 *ts)
+{
+	(void) intel_tgpio_readl(tgpio->base, TMTR_TSG);
+	ts->tv_nsec = intel_tgpio_readl(tgpio->base, TMTL_TSG);
+	ts->tv_sec = intel_tgpio_readl(tgpio->base, TMTH_TSG);
+}
+
+#define TGPIO_PIN(n)					\
+	{						\
+		.name	= "pin" __stringify((n)),	\
+		.index	= (n),				\
+		.chan	= (n),				\
+		.func	= RT_PTP_PF_NONE,		\
+	}
+
+static struct rt_ptp_pin_desc intel_tgpio_pin_config[] = {
+	TGPIO_PIN(0),
+	TGPIO_PIN(1),
+	TGPIO_PIN(2),
+	TGPIO_PIN(3),
+	TGPIO_PIN(4),
+	TGPIO_PIN(5),
+	TGPIO_PIN(6),
+	TGPIO_PIN(7),
+	TGPIO_PIN(8),
+	TGPIO_PIN(9),
+	TGPIO_PIN(10),
+	TGPIO_PIN(11),
+	TGPIO_PIN(12),
+	TGPIO_PIN(13),
+	TGPIO_PIN(14),
+	TGPIO_PIN(15),
+	TGPIO_PIN(16),
+	TGPIO_PIN(17),
+	TGPIO_PIN(18),
+	TGPIO_PIN(19),
+};
+
+static int intel_tgpio_config_input(struct intel_tgpio *tgpio,
+		struct rt_ptp_extts_request *extts, int on)
+{
+	unsigned int		index = extts->index;
+	u32			offset;
+	u32			ctrl;
+
+	offset = TGPIOCTL(index);
+	ctrl = intel_tgpio_readl(tgpio->base, offset);
+	ctrl &= ~(TGPIOCTL_TS | TGPIOCTL_EP | TGPIOCTL_DIR |
+			TGPIOCTL_PWS | TGPIOCTL_IEC_EC | TGPIOCTL_ICS);
+
+	if (on) {
+		int rising_cap, falling_cap;
+
+		tgpio->irq_mask |= TGPIOINT_EVENT_INTERRUPT(index);
+		ctrl |= TGPIOCTL_DIR | TGPIOCTL_TS_TMT0;
+
+		/* To enable for Input Event Counter & Input Event Control */
+		/* TODO: temporarily using rsv0 to store the counter */
+		if ((extts->flags & RT_PTP_EVENT_COUNTER_MODE) && extts->rsv[0])
+		{
+			ctrl |= TGPIOCTL_IEC_EC;
+			ctrl |= TGPIOCTL_ICS;
+
+			intel_tgpio_writel(tgpio->base, TGPIOCOMPV31_0(index),
+						extts->rsv[0]);
+			intel_tgpio_writel(tgpio->base, TGPIOCOMPV63_32(index),
+						0);
+		}
+
+		/* To enable Event Polarity for inout mode, */
+		/* default to capture both rising & failling */
+		rising_cap = extts->flags & RT_PTP_RISING_EDGE;
+		falling_cap = extts->flags & RT_PTP_FALLING_EDGE;
+
+		if (rising_cap && !falling_cap)
+			ctrl |= TGPIOCTL_EP_RISING_EDGE;
+		else if (!rising_cap && falling_cap)
+			ctrl |= TGPIOCTL_EP_FALLING_EDGE;
+		else
+			ctrl |= TGPIOCTL_EP_TOGGLE_EDGE;
+
+		/* gotta program all other bits before EN bit is set */
+		intel_tgpio_writel(tgpio->base, offset, ctrl);
+
+		ctrl |= TGPIOCTL_EN;
+	} else {
+		ctrl &= ~TGPIOCTL_EN;
+		intel_tgpio_writel(tgpio->base, offset, ctrl);
+
+		intel_tgpio_writeq(tgpio->base, TGPIOCOMPV31_0(index), 0);
+		tgpio->irq_mask &= ~TGPIOINT_EVENT_INTERRUPT(index);
+		ctrl = 0x0;
+	}
+
+	/* For everytime we mask the interrupt, we need to */
+	/* flush the corresponding Raw Interrupt Status  */
+	intel_tgpio_writel(tgpio->base, TGPIOMSC, tgpio->irq_mask);
+	intel_tgpio_writel(tgpio->base, TGPIOICR, tgpio->irq_mask);
+	intel_tgpio_writel(tgpio->base, offset, ctrl);
+
+	return 0;
+}
+
+static int intel_tgpio_config_output(struct intel_tgpio *tgpio,
+		struct rt_ptp_perout_request *perout, int on)
+{
+	unsigned int		index = perout->index;
+	u32			offset;
+	u32			ctrl;
+
+	offset = TGPIOCTL(index);
+	ctrl = intel_tgpio_readl(tgpio->base, offset);
+	ctrl &= ~(TGPIOCTL_TS | TGPIOCTL_EP | TGPIOCTL_DIR |
+			TGPIOCTL_PWS | TGPIOCTL_IEC_EC | TGPIOCTL_ICS);
+
+	if (on || (perout->flags & RT_PTP_PEROUT_ONE_SHOT)) {
+		struct rt_ptp_clock_time *period = &perout->period;
+		struct rt_ptp_clock_time *start = &perout->start;
+
+		ctrl |= TGPIOCTL_TS_TMT0 | TGPIOCTL_ECC | TGPIOCTL_PWS_N(17);
+
+		if (perout->flags & RT_PTP_PEROUT_ONE_SHOT)
+			ctrl &= ~TGPIOCTL_PM;
+		else
+			ctrl |= TGPIOCTL_PM;
+
+		if (!(perout->flags & RT_PTP_PEROUT_FREQ_ADJ)) {
+			start->nsec = ((start->nsec) / 10) * 10;
+			intel_tgpio_writel(tgpio->base, TGPIOCOMPV31_0(index),
+						start->nsec);
+			intel_tgpio_writel(tgpio->base, TGPIOCOMPV63_32(index),
+						start->sec);
+		}
+		intel_tgpio_writeq(tgpio->base, TGPIOPIV31_0(index),
+				to_intel_tgpio_time(period));
+
+		/* gotta program all other bits before EN bit is set */
+		intel_tgpio_writel(tgpio->base, offset, ctrl);
+
+		ctrl |= TGPIOCTL_EN;
+	} else {
+		ctrl &= ~TGPIOCTL_EN;
+		intel_tgpio_writel(tgpio->base, offset, ctrl);
+
+		intel_tgpio_writeq(tgpio->base, TGPIOCOMPV31_0(index), 0);
+		intel_tgpio_writeq(tgpio->base, TGPIOPIV31_0(index), 0);
+		ctrl = 0x0;
+	}
+
+	intel_tgpio_writel(tgpio->base, offset, ctrl);
+
+	return 0;
+}
+
+static int intel_tgpio_enable(struct rt_ptp_clock_info *info,
+		struct rt_ptp_clock_request *req, int on)
+{
+	struct intel_tgpio	*tgpio = to_intel_tgpio(info);
+	rtdm_lockctx_t		flags;
+	int			ret = -EOPNOTSUPP;
+
+	switch (req->type) {
+		case RT_PTP_CLK_REQ_EXTTS:
+		{
+			rtdm_lock_get_irqsave(&tgpio->lock, flags);
+			ret = intel_tgpio_config_input(tgpio, &req->extts, on);
+			rtdm_lock_put_irqrestore(&tgpio->lock, flags);
+			break;
+		}
+		case RT_PTP_CLK_REQ_PEROUT:
+		{
+			rtdm_lock_get_irqsave(&tgpio->lock, flags);
+			ret = intel_tgpio_config_output(tgpio, &req->perout, on);
+			rtdm_lock_put_irqrestore(&tgpio->lock, flags);
+			break;
+		}
+		default:
+			break;
+	}
+
+	return ret;
+}
+
+static int intel_tgpio_get_time_fn(ktime_t *device_time,
+		struct system_counterval_t *system_counter, void *_tgpio)
+{
+	struct intel_tgpio	*tgpio = _tgpio;
+	struct timespec64	ts;
+	u64			cycles;
+
+	intel_tgpio_get_time(tgpio, &ts);
+	*device_time = timespec64_to_ktime(ts);
+	cycles = read_art();
+	*system_counter = convert_art_to_tsc(cycles);
+	return 0;
+}
+
+static int intel_tgpio_getcrosststamp(struct rt_ptp_clock_info *info,
+		struct system_device_crosststamp *cts)
+{
+	struct intel_tgpio	*tgpio = to_intel_tgpio(info);
+
+	return get_device_system_crosststamp(intel_tgpio_get_time_fn, tgpio,
+							NULL, cts);
+}
+
+static int intel_tgpio_counttstamp(struct rt_ptp_clock_info *info,
+				   struct rt_ptp_event_count_tstamp *count)
+{
+	struct intel_tgpio *tgpio = to_intel_tgpio(info);
+	rtdm_lockctx_t	flags;
+
+	rtdm_lock_get_irqsave(&tgpio->lock, flags);
+	/* Reading lower 32-bit word of Time Capture Value (TCV) loads */
+	/* the event time and event count capture */
+	count->device_time.nsec = intel_tgpio_readl(tgpio->base,
+						TGPIOTCV31_0(count->index));
+	count->event_count = intel_tgpio_readl(tgpio->base,
+						TGPIOECCV63_32(count->index));
+	count->event_count <<= 32;
+	count->event_count |= intel_tgpio_readl(tgpio->base,
+						TGPIOECCV31_0(count->index));
+	count->device_time.sec = intel_tgpio_readl(tgpio->base,
+						TGPIOTCV63_32(count->index));
+	rtdm_lock_put_irqrestore(&tgpio->lock, flags);
+	return 0;
+}
+
+static int intel_tgpio_verify(struct rt_ptp_clock_info *ptp, unsigned int pin,
+		enum rt_ptp_pin_function func, unsigned int chan)
+{
+	return 0;
+}
+
+static const struct rt_ptp_clock_info intel_tgpio_info = {
+	.owner		= THIS_MODULE,
+	.name		= "Intel PSE TGPIO",
+	.max_adj	= 50000000,
+	.n_pins		= 20,
+	.n_ext_ts	= 20,
+	.n_per_out	= 20,
+	.pin_config	= intel_tgpio_pin_config,
+	.enable		= intel_tgpio_enable,
+	.getcrosststamp	= intel_tgpio_getcrosststamp,
+	.counttstamp    = intel_tgpio_counttstamp,
+	.verify		= intel_tgpio_verify,
+};
+
+static void intel_tgpio_irq_fn(void *_tgpio)
+{
+	struct intel_tgpio	*tgpio = _tgpio;
+	unsigned long		irq_status;
+	unsigned long		pin;
+
+	rtdm_lock_get(&tgpio->lock);
+
+	irq_status = tgpio->irq_status;
+	for_each_set_bit(pin, &irq_status, BITS_PER_LONG) {
+		struct rt_ptp_event event;
+
+		event.type = RT_PTP_CLK_REQ_EXTTS;
+		event.index = pin;
+		event.timestamp = intel_tgpio_readq(tgpio->base,
+				TGPIOTCV31_0(pin));
+
+		rt_ptp_clock_event(tgpio->clock, &event);
+	}
+
+	/*
+	 * Clear RIS (Raw Interrupt Status) after we mask the MIS for any
+	 * pending interrupts in RIS through ICR register.
+	 */
+	intel_tgpio_writel(tgpio->base, TGPIOMSC, tgpio->irq_mask);
+	intel_tgpio_writel(tgpio->base, TGPIOICR, tgpio->irq_mask);
+	rtdm_lock_put(&tgpio->lock);
+}
+
+static int intel_tgpio_irq(rtdm_irq_t *handle)
+{
+	struct intel_tgpio	*tgpio = rtdm_irq_get_arg(handle,
+							struct intel_tgpio);
+	u32			intr;
+
+	intr = intel_tgpio_readl(tgpio->base, TGPIOMIS);
+	if (intr) {
+		tgpio->irq_status = intr;
+		intel_tgpio_writel(tgpio->base, TGPIOMSC, 0x00);
+		intel_tgpio_writel(tgpio->base, TGPIOICR, intr);
+		intel_tgpio_irq_fn(tgpio);
+
+	}
+	return RTDM_IRQ_HANDLED;
+}
+
+static void intel_tgpio_disable_all_pins(struct intel_tgpio *tgpio)
+{
+	int	i;
+
+	for (i = 0; i < 20; i++)
+		intel_tgpio_writel(tgpio->base, TGPIOCTL(i), 0);
+}
+
+static int intel_tgpio_probe(struct platform_device *pdev)
+{
+	struct intel_tgpio	*tgpio;
+	struct resource		*res;
+	int			ret;
+	int			irq;
+
+	tgpio = devm_kzalloc(&pdev->dev, sizeof(*tgpio), GFP_KERNEL);
+	if (!tgpio)
+		return -ENOMEM;
+
+	tgpio->dev = &pdev->dev;
+	tgpio->info = intel_tgpio_info;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENODEV;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return -ENODEV;
+
+	tgpio->base = devm_ioremap_resource(&pdev->dev, res);
+
+	/* make sure all pins are disabled */
+	intel_tgpio_disable_all_pins(tgpio);
+
+	/* mask all interrupt events */
+	intel_tgpio_writel(tgpio->base, TGPIOMIS, 0x00);
+
+	/* enable TMT0 */
+	intel_tgpio_writel(tgpio->base, TMTCTL_TSG, TMTCTL_TMT_ENABLE);
+
+	rtdm_lock_init(&tgpio->lock);
+
+	platform_set_drvdata(pdev, tgpio);
+
+	tgpio->clock = rt_ptp_clock_register(&tgpio->info, "pse-tgpio");
+	if (IS_ERR(tgpio->clock))
+		return PTR_ERR(tgpio->clock);
+
+	ret = rtdm_irq_request(&tgpio->handle, irq, intel_tgpio_irq,
+			IRQF_TRIGGER_RISING | IRQF_SHARED,
+			dev_name(&pdev->dev), tgpio);
+	if (ret)
+		goto err0;
+
+	tgpio->is_interrupt = true;
+	pm_runtime_get_sync(tgpio->dev->parent);
+	return 0;
+
+err0:
+	rt_ptp_clock_unregister(tgpio->clock);
+	return ret;
+}
+
+static int intel_tgpio_remove(struct platform_device *pdev)
+{
+	struct intel_tgpio *tgpio = platform_get_drvdata(pdev);
+
+	pm_runtime_put(tgpio->dev->parent);
+	if (tgpio->is_interrupt)
+		rtdm_irq_free(&tgpio->handle);
+	rt_ptp_clock_unregister(tgpio->clock);
+
+	return 0;
+}
+
+static struct platform_driver intel_tgpio_driver = {
+	.driver = {
+		.name	= "intel-ehl-tgpio",
+	},
+	.probe		= intel_tgpio_probe,
+	.remove		= intel_tgpio_remove,
+};
+
+module_platform_driver(intel_tgpio_driver);
-- 
2.25.1


