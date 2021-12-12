From: Dario Binacchi <dariobin@libero.it>
Subject: [PATCH v4 8/8] drivers/can: add support for Bosch C_CAN controller
Date: Sun, 12 Dec 2021 12:56:11 +0100
Message-Id: <20211212115611.3036-7-dariobin@libero.it>
In-Reply-To: <20211212115611.3036-1-dariobin@libero.it>
References: <20211212115611.3036-1-dariobin@libero.it>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Michael Trimarchi <michael@amarulasolutions.com>, Wolfgang Grandegger <wg@grandegger.com>, Philippe Gerum <rpm@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>, "Stephen J . Battazzo" <stephen.j.battazzo@nasa.gov>, Dario Binacchi <dariobin@libero.it>, Gianluca Falavigna <gianluca.falavigna@inwind.it>

Bosch C_CAN controller is a full-CAN implementation which is compliant
to CAN protocol version 2.0 part A and B.

Starting from the RTDM porting [1] by Stephen Battazzo, Michael applied
some fixes for proper driver operation. Then I ported the commits from
Linux kernel version 5.12 and finally I added support for 64 message
objects [2] and improved the FIFO management [2] to get the best
possible RX/TX throughput. Features [2] and [3] led to the creation of
patches applied to the Linux kernel too.

The patch was tested on a custom board mounting an AM335x SOC.

PCI support has not been developed.

[1] http://xenomai.org/pipermail/xenomai/2015-July/034690.html
[2] 132f2d45fb23 ("can: c_can: add support to 64 message objects")
[3] 387da6bc7a82 ("can: c_can: cache frames to operate as a true FIFO")

Signed-off-by: Stephen J. Battazzo <stephen.j.battazzo@nasa.gov>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dariobin@libero.it>
Signed-off-by: Gianluca Falavigna <gianluca.falavigna@inwind.it>
Tested-by: Gianluca Falavigna <gianluca.falavigna@inwind.it>

---

(no changes since v3)

Changes in v3:
- Add virtual CAN testsuite

Changes in v2:
- Drop 'default n' Kconfig
- Enable the driver for Xenomai CI builds
- Drop commented code
- Drop power managemet (pm) code

 .gitlab-ci.yml                                |    2 +
 kernel/drivers/can/Kconfig                    |    1 +
 kernel/drivers/can/Makefile                   |    2 +-
 kernel/drivers/can/README                     |    1 +
 kernel/drivers/can/c_can/Kconfig              |   15 +
 kernel/drivers/can/c_can/Makefile             |    8 +
 kernel/drivers/can/c_can/rtcan_c_can.c        | 1298 +++++++++++++++++
 kernel/drivers/can/c_can/rtcan_c_can.h        |  255 ++++
 .../drivers/can/c_can/rtcan_c_can_ethtool.c   |   47 +
 .../drivers/can/c_can/rtcan_c_can_platform.c  |  461 ++++++
 10 files changed, 2089 insertions(+), 1 deletion(-)
 create mode 100644 kernel/drivers/can/c_can/Kconfig
 create mode 100644 kernel/drivers/can/c_can/Makefile
 create mode 100644 kernel/drivers/can/c_can/rtcan_c_can.c
 create mode 100644 kernel/drivers/can/c_can/rtcan_c_can.h
 create mode 100644 kernel/drivers/can/c_can/rtcan_c_can_ethtool.c
 create mode 100644 kernel/drivers/can/c_can/rtcan_c_can_platform.c

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 602a7682a..b54baf25b 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -118,6 +118,8 @@ variables:
     - ./scripts/config -e XENO_DRIVERS_CAN_SJA1000_ESD_PCI
     - ./scripts/config -e XENO_DRIVERS_CAN_SJA1000_PEAK_DNG
     - ./scripts/config -e XENO_DRIVERS_CAN_PEAK_CANFD
+    - ./scripts/config -e XENO_DRIVERS_CAN_C_CAN
+    - ./scripts/config -e XENO_DRIVERS_CAN_C_CAN_PLATFORM
     - ./scripts/config -m XENO_DRIVERS_NET
     - ./scripts/config -e XENO_DRIVERS_RTNET_CHECKED
     - ./scripts/config -e XENO_DRIVERS_NET_ETH_P_ALL
diff --git a/kernel/drivers/can/Kconfig b/kernel/drivers/can/Kconfig
index 1c055494d..c9ff36d94 100644
--- a/kernel/drivers/can/Kconfig
+++ b/kernel/drivers/can/Kconfig
@@ -85,6 +85,7 @@ config XENO_DRIVERS_CAN_FLEXCAN
 
 	Say Y here if you want to support for Freescale FlexCAN.
 
+source "drivers/xenomai/can/c_can/Kconfig"
 source "drivers/xenomai/can/mscan/Kconfig"
 source "drivers/xenomai/can/peak_canfd/Kconfig"
 source "drivers/xenomai/can/sja1000/Kconfig"
diff --git a/kernel/drivers/can/Makefile b/kernel/drivers/can/Makefile
index 65761a010..87bd0d070 100644
--- a/kernel/drivers/can/Makefile
+++ b/kernel/drivers/can/Makefile
@@ -1,7 +1,7 @@
 
 ccflags-y += -I$(srctree)/drivers/xenomai/can
 
-obj-$(CONFIG_XENO_DRIVERS_CAN) += xeno_can.o mscan/ sja1000/ peak_canfd/
+obj-$(CONFIG_XENO_DRIVERS_CAN) += xeno_can.o mscan/ sja1000/ peak_canfd/ c_can/
 obj-$(CONFIG_XENO_DRIVERS_CAN_FLEXCAN) += xeno_can_flexcan.o
 obj-$(CONFIG_XENO_DRIVERS_CAN_VIRT) += xeno_can_virt.o
 
diff --git a/kernel/drivers/can/README b/kernel/drivers/can/README
index cb0ef37ae..44aff9b1c 100644
--- a/kernel/drivers/can/README
+++ b/kernel/drivers/can/README
@@ -20,6 +20,7 @@ devices:
    SJA1000 PEAK parallel port Dongle
    SJA1000 IXXAT PCI card
    MSCAN for MPC5200 boards
+   C_CAN/D_CAN for AM335x/AM437x Sitara processors and DRA7 SOC
 
 Utilities for RT-Socket-CAN are available in "src/utils/can".
 
diff --git a/kernel/drivers/can/c_can/Kconfig b/kernel/drivers/can/c_can/Kconfig
new file mode 100644
index 000000000..6d9b37921
--- /dev/null
+++ b/kernel/drivers/can/c_can/Kconfig
@@ -0,0 +1,15 @@
+config XENO_DRIVERS_CAN_C_CAN
+	depends on XENO_DRIVERS_CAN && OF
+	tristate "Bosch C-CAN based chips"
+
+config XENO_DRIVERS_CAN_C_CAN_PLATFORM
+	depends on XENO_DRIVERS_CAN_C_CAN
+	tristate "Generic Platform Bus based controller"
+	help
+
+	This driver adds support for the C_CAN/D_CAN chips connected
+	to the "platform bus" (Linux abstraction for directly to the
+	processor attached devices) which can be found on various
+	boards from ST Microelectronics (http://www.st.com) like the
+	SPEAr1310 and SPEAr320 evaluation boards & TI (www.ti.com)
+	boards like am335x, dm814x, dm813x and dm811x.
diff --git a/kernel/drivers/can/c_can/Makefile b/kernel/drivers/can/c_can/Makefile
new file mode 100644
index 000000000..888e51a10
--- /dev/null
+++ b/kernel/drivers/can/c_can/Makefile
@@ -0,0 +1,8 @@
+
+ccflags-y += -Idrivers/xenomai/can -Idrivers/xenomai/can/c_can
+
+obj-$(CONFIG_XENO_DRIVERS_CAN_C_CAN) += xeno_can_c_can.o
+obj-$(CONFIG_XENO_DRIVERS_CAN_C_CAN_PLATFORM) += xeno_can_c_can_platform.o
+
+xeno_can_c_can-y := rtcan_c_can.o rtcan_c_can_ethtool.o
+xeno_can_c_can_platform-y := rtcan_c_can_platform.o
diff --git a/kernel/drivers/can/c_can/rtcan_c_can.c b/kernel/drivers/can/c_can/rtcan_c_can.c
new file mode 100644
index 000000000..0f7bc3e53
--- /dev/null
+++ b/kernel/drivers/can/c_can/rtcan_c_can.c
@@ -0,0 +1,1298 @@
+/*
+ * CAN bus driver for Bosch C_CAN controller, ported to Xenomai RTDM
+ *
+ * Copyright 2021, Dario Binacchi <dariobin@libero.it>
+ *
+ * Stephen J. Battazzo <stephen.j.battazzo@nasa.gov>,
+ * MEI Services/NASA Ames Research Center
+ *
+ * Borrowed original driver from:
+ *
+ * Bhupesh Sharma <bhupesh.sharma@st.com>, ST Microelectronics
+ * Borrowed heavily from the C_CAN driver originally written by:
+ * Copyright (C) 2007
+ * - Sascha Hauer, Marc Kleine-Budde, Pengutronix <s.hauer@pengutronix.de>
+ * - Simon Kallweit, intefo AG <simon.kallweit@intefo.ch>
+ *
+ * TX and RX NAPI implementation has been removed and replaced with RT Socket CAN implementation.
+ * RT Socket CAN implementation inspired by Flexcan RTDM port by Wolfgang Grandegger <wg@denx.de>
+ *
+ * Bosch C_CAN controller is compliant to CAN protocol version 2.0 part A and B.
+ * Bosch C_CAN user manual can be obtained from:
+ * http://www.semiconductors.bosch.de/media/en/pdf/ipmodules_1/c_can/
+ * users_manual_c_can.pdf
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+#include <linux/if_arp.h>
+#include <linux/if_ether.h>
+#include <linux/list.h>
+#include <linux/io.h>
+#include <linux/pm_runtime.h>
+#include <linux/pinctrl/consumer.h>
+#ifdef CONFIG_OF
+#include <linux/of.h>
+#include <linux/of_device.h>
+#endif
+#include <linux/clk.h>
+#include <linux/platform_device.h>
+#include <linux/pinctrl/consumer.h>
+
+#include <rtdm/driver.h>
+
+/* CAN device profile */
+#include <rtdm/can.h>
+
+#include "rtcan_dev.h"
+#include "rtcan_raw.h"
+#include "rtcan_internal.h"
+
+#include "rtcan_c_can.h"
+
+//borrowed this from linux/can/dev.h for now:
+#define CAN_MAX_DLEN 8
+/*
+ * can_cc_dlc2len(value) - convert a given data length code (dlc) of a
+ * Classical CAN frame into a valid data length of max. 8 bytes.
+ *
+ * To be used in the CAN netdriver receive path to ensure conformance with
+ * ISO 11898-1 Chapter 8.4.2.3 (DLC field)
+ */
+#define can_cc_dlc2len(dlc)	(min_t(u8, (dlc), CAN_MAX_DLEN))
+
+/* Number of interface registers */
+#define IF_ENUM_REG_LEN		11
+#define C_CAN_IFACE(reg, iface)	(C_CAN_IF1_##reg + (iface) * IF_ENUM_REG_LEN)
+
+/* control extension register D_CAN specific */
+#define CONTROL_EX_PDR		BIT(8)
+
+/* control register */
+#define CONTROL_SWR		BIT(15)
+#define CONTROL_TEST		BIT(7)
+#define CONTROL_CCE		BIT(6)
+#define CONTROL_DISABLE_AR	BIT(5)
+#define CONTROL_ENABLE_AR	(0 << 5)
+#define CONTROL_EIE		BIT(3)
+#define CONTROL_SIE		BIT(2)
+#define CONTROL_IE		BIT(1)
+#define CONTROL_INIT		BIT(0)
+
+#define CONTROL_IRQMSK		(CONTROL_EIE | CONTROL_IE | CONTROL_SIE)
+
+/* test register */
+#define TEST_RX			BIT(7)
+#define TEST_TX1		BIT(6)
+#define TEST_TX2		BIT(5)
+#define TEST_LBACK		BIT(4)
+#define TEST_SILENT		BIT(3)
+#define TEST_BASIC		BIT(2)
+
+/* status register */
+#define STATUS_PDA		BIT(10)
+#define STATUS_BOFF		BIT(7)
+#define STATUS_EWARN		BIT(6)
+#define STATUS_EPASS		BIT(5)
+#define STATUS_RXOK		BIT(4)
+#define STATUS_TXOK		BIT(3)
+
+/* error counter register */
+#define ERR_CNT_TEC_MASK	0xff
+#define ERR_CNT_TEC_SHIFT	0
+#define ERR_CNT_REC_SHIFT	8
+#define ERR_CNT_REC_MASK	(0x7f << ERR_CNT_REC_SHIFT)
+#define ERR_CNT_RP_SHIFT	15
+#define ERR_CNT_RP_MASK		(0x1 << ERR_CNT_RP_SHIFT)
+
+/* bit-timing register */
+#define BTR_BRP_MASK		0x3f
+#define BTR_BRP_SHIFT		0
+#define BTR_SJW_SHIFT		6
+#define BTR_SJW_MASK		(0x3 << BTR_SJW_SHIFT)
+#define BTR_TSEG1_SHIFT		8
+#define BTR_TSEG1_MASK		(0xf << BTR_TSEG1_SHIFT)
+#define BTR_TSEG2_SHIFT		12
+#define BTR_TSEG2_MASK		(0x7 << BTR_TSEG2_SHIFT)
+
+/* interrupt register */
+#define INT_STS_PENDING		0x8000
+
+/* brp extension register */
+#define BRP_EXT_BRPE_MASK	0x0f
+#define BRP_EXT_BRPE_SHIFT	0
+
+/* IFx command request */
+#define IF_COMR_BUSY		BIT(15)
+
+/* IFx command mask */
+#define IF_COMM_WR		BIT(7)
+#define IF_COMM_MASK		BIT(6)
+#define IF_COMM_ARB		BIT(5)
+#define IF_COMM_CONTROL		BIT(4)
+#define IF_COMM_CLR_INT_PND	BIT(3)
+#define IF_COMM_TXRQST		BIT(2)
+#define IF_COMM_CLR_NEWDAT	IF_COMM_TXRQST
+#define IF_COMM_DATAA		BIT(1)
+#define IF_COMM_DATAB		BIT(0)
+
+/* TX buffer setup */
+#define IF_COMM_TX		(IF_COMM_ARB | IF_COMM_CONTROL | \
+				 IF_COMM_TXRQST |		 \
+				 IF_COMM_DATAA | IF_COMM_DATAB)
+
+#define IF_COMM_TX_FRAME	(IF_COMM_ARB | IF_COMM_CONTROL | \
+				 IF_COMM_DATAA | IF_COMM_DATAB)
+
+/* For the low buffers we clear the interrupt bit, but keep newdat */
+#define IF_COMM_RCV_LOW		(IF_COMM_MASK | IF_COMM_ARB | \
+				 IF_COMM_CONTROL | IF_COMM_CLR_INT_PND | \
+				 IF_COMM_DATAA | IF_COMM_DATAB)
+
+/* For the high buffers we clear the interrupt bit and newdat */
+#define IF_COMM_RCV_HIGH	(IF_COMM_RCV_LOW | IF_COMM_CLR_NEWDAT)
+
+/* Receive setup of message objects */
+#define IF_COMM_RCV_SETUP	(IF_COMM_MASK | IF_COMM_ARB | IF_COMM_CONTROL)
+
+/* Invalidation of message objects */
+#define IF_COMM_INVAL		(IF_COMM_ARB | IF_COMM_CONTROL)
+
+/* IFx arbitration */
+#define IF_ARB_MSGVAL		BIT(31)
+#define IF_ARB_MSGXTD		BIT(30)
+#define IF_ARB_TRANSMIT		BIT(29)
+
+/* IFx message control */
+#define IF_MCONT_NEWDAT		BIT(15)
+#define IF_MCONT_MSGLST		BIT(14)
+#define IF_MCONT_INTPND		BIT(13)
+#define IF_MCONT_UMASK		BIT(12)
+#define IF_MCONT_TXIE		BIT(11)
+#define IF_MCONT_RXIE		BIT(10)
+#define IF_MCONT_RMTEN		BIT(9)
+#define IF_MCONT_TXRQST		BIT(8)
+#define IF_MCONT_EOB		BIT(7)
+#define IF_MCONT_DLC_MASK	0xf
+
+#define IF_MCONT_RCV		(IF_MCONT_RXIE | IF_MCONT_UMASK)
+#define IF_MCONT_RCV_EOB	(IF_MCONT_RCV | IF_MCONT_EOB)
+
+#define IF_MCONT_TX		(IF_MCONT_TXIE | IF_MCONT_EOB)
+
+/*
+ * Use IF1 for RX and IF2 for TX
+ */
+#define IF_RX			0
+#define IF_TX			1
+
+/* minimum timeout for checking BUSY status */
+#define MIN_TIMEOUT_VALUE	6
+
+/* Wait for ~1 sec for INIT bit */
+#define INIT_WAIT_MS		1000
+
+/* c_can lec values */
+enum c_can_lec_type {
+	LEC_NO_ERROR = 0,
+	LEC_STUFF_ERROR,
+	LEC_FORM_ERROR,
+	LEC_ACK_ERROR,
+	LEC_BIT1_ERROR,
+	LEC_BIT0_ERROR,
+	LEC_CRC_ERROR,
+	LEC_UNUSED,
+	LEC_MASK = LEC_UNUSED,
+};
+
+static const struct can_bittiming_const c_can_bittiming_const = {
+	.name = DRV_NAME,
+	.tseg1_min = 2,		/* Time segment 1 = prop_seg + phase_seg1 */
+	.tseg1_max = 16,
+	.tseg2_min = 1,		/* Time segment 2 = phase_seg2 */
+	.tseg2_max = 8,
+	.sjw_max = 4,
+	.brp_min = 1,
+	.brp_max = 1024,	/* 6-bit BRP field + 4-bit BRPE field */
+	.brp_inc = 1,
+};
+
+static inline void c_can_pm_runtime_enable(const struct c_can_priv *priv)
+{
+	if (priv->device)
+		pm_runtime_enable(priv->device);
+}
+
+static inline void c_can_pm_runtime_disable(const struct c_can_priv *priv)
+{
+	if (priv->device)
+		pm_runtime_disable(priv->device);
+}
+
+static inline void c_can_pm_runtime_get_sync(const struct c_can_priv *priv)
+{
+	if (priv->device)
+		pm_runtime_get_sync(priv->device);
+}
+
+static inline void c_can_pm_runtime_put_sync(const struct c_can_priv *priv)
+{
+	if (priv->device)
+		pm_runtime_put_sync(priv->device);
+}
+
+static inline void c_can_reset_ram(const struct c_can_priv *priv, bool enable)
+{
+	if (priv->raminit)
+		priv->raminit(priv, enable);
+}
+
+static void c_can_irq_control(struct c_can_priv *priv, bool enable)
+{
+	u32 ctrl = priv->read_reg(priv, C_CAN_CTRL_REG) & ~CONTROL_IRQMSK;
+
+	if (enable)
+		ctrl |= CONTROL_IRQMSK;
+
+	priv->write_reg(priv, C_CAN_CTRL_REG, ctrl);
+}
+
+static void c_can_obj_update(struct rtcan_device *dev, int iface, u32 cmd,
+			     u32 obj)
+{
+	struct c_can_priv *priv = rtcan_priv(dev);
+	int cnt, reg = C_CAN_IFACE(COMREQ_REG, iface);
+
+	priv->write_reg32(priv, reg, (cmd << 16) | obj);
+
+	for (cnt = MIN_TIMEOUT_VALUE; cnt; cnt--) {
+		if (!(priv->read_reg(priv, reg) & IF_COMR_BUSY))
+			return;
+		udelay(1);
+	}
+	rtcandev_err(dev, "Updating object timed out\n");
+
+}
+
+static inline void c_can_object_get(struct rtcan_device *dev, int iface,
+				    u32 obj, u32 cmd)
+{
+	c_can_obj_update(dev, iface, cmd, obj);
+}
+
+static inline void c_can_object_put(struct rtcan_device *dev, int iface,
+				    u32 obj, u32 cmd)
+{
+	c_can_obj_update(dev, iface, cmd | IF_COMM_WR, obj);
+}
+
+/*
+ * Note: According to documentation clearing TXIE while MSGVAL is set
+ * is not allowed, but works nicely on C/DCAN. And that lowers the I/O
+ * load significantly.
+ */
+static void c_can_inval_tx_object(struct rtcan_device *dev, int iface, int obj)
+{
+	struct c_can_priv *priv = rtcan_priv(dev);
+
+	priv->write_reg(priv, C_CAN_IFACE(MSGCTRL_REG, iface), 0);
+	c_can_object_put(dev, iface, obj, IF_COMM_INVAL);
+}
+
+static void c_can_inval_msg_object(struct rtcan_device *dev, int iface, int obj)
+{
+	struct c_can_priv *priv = rtcan_priv(dev);
+
+	priv->write_reg32(priv, C_CAN_IFACE(ARB1_REG, iface), 0);
+	c_can_inval_tx_object(dev, iface, obj);
+}
+
+static void c_can_setup_tx_object(struct rtcan_device *dev, int iface,
+				  struct can_frame *frame, int idx)
+{
+	struct c_can_priv *priv = rtcan_priv(dev);
+	u16 ctrl = IF_MCONT_TX | frame->len;
+	bool rtr = frame->can_id & CAN_RTR_FLAG;
+	u32 arb = IF_ARB_MSGVAL;
+	int i;
+
+	if (frame->can_id & CAN_EFF_FLAG) {
+		arb |= frame->can_id & CAN_EFF_MASK;
+		arb |= IF_ARB_MSGXTD;
+	} else {
+		arb |= (frame->can_id & CAN_SFF_MASK) << 18;
+	}
+
+	if (!rtr)
+		arb |= IF_ARB_TRANSMIT;
+
+	/*
+	 * If we change the DIR bit, we need to invalidate the buffer
+	 * first, i.e. clear the MSGVAL flag in the arbiter.
+	 */
+	if (rtr != (bool)test_bit(idx, &priv->tx_dir)) {
+		u32 obj = idx + priv->msg_obj_tx_first;
+
+		c_can_inval_msg_object(dev, iface, obj);
+		change_bit(idx, &priv->tx_dir);
+	}
+
+	priv->write_reg32(priv, C_CAN_IFACE(ARB1_REG, iface), arb);
+
+	priv->write_reg(priv, C_CAN_IFACE(MSGCTRL_REG, iface), ctrl);
+
+	if (priv->type == BOSCH_D_CAN) {
+		u32 data = 0, dreg = C_CAN_IFACE(DATA1_REG, iface);
+
+		for (i = 0; i < frame->len; i += 4, dreg += 2) {
+			data = (u32) frame->data[i];
+			data |= (u32) frame->data[i + 1] << 8;
+			data |= (u32) frame->data[i + 2] << 16;
+			data |= (u32) frame->data[i + 3] << 24;
+			priv->write_reg32(priv, dreg, data);
+		}
+	} else {
+
+		for (i = 0; i < frame->len; i += 2) {
+			priv->write_reg(priv,
+					C_CAN_IFACE(DATA1_REG, iface) + i / 2,
+					frame->data[i] |
+					(frame->data[i + 1] << 8));
+		}
+	}
+}
+
+static int c_can_handle_lost_msg_obj(struct rtcan_device *dev, int iface,
+				     int objno, u32 ctrl, struct rtcan_skb *skb)
+{
+	struct c_can_priv *priv = rtcan_priv(dev);
+	struct rtcan_rb_frame *cf = &skb->rb_frame;
+
+	rtcandev_err(dev, "msg lost in buffer %d\n", objno);
+
+	ctrl &= ~(IF_MCONT_MSGLST | IF_MCONT_INTPND | IF_MCONT_NEWDAT);
+	priv->write_reg(priv, C_CAN_IFACE(MSGCTRL_REG, iface), ctrl);
+	c_can_object_put(dev, iface, objno, IF_COMM_CONTROL);
+
+	cf->can_id |= CAN_ERR_CRTL;
+	cf->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
+	return 1;
+}
+
+static int c_can_read_msg_object(struct rtcan_device *dev, int iface, u32 ctrl,
+				 struct rtcan_skb *skb)
+{
+	struct c_can_priv *priv = rtcan_priv(dev);
+	struct rtcan_rb_frame *frame = &skb->rb_frame;
+	u32 arb, data;
+
+	frame->len = can_cc_dlc2len(ctrl & 0x0F);
+	frame->can_ifindex = dev->ifindex;
+
+	arb = priv->read_reg32(priv, C_CAN_IFACE(ARB1_REG, iface));
+
+	if (arb & IF_ARB_MSGXTD)
+		frame->can_id = (arb & CAN_EFF_MASK) | CAN_EFF_FLAG;
+	else
+		frame->can_id = (arb >> 18) & CAN_SFF_MASK;
+
+	if (arb & IF_ARB_TRANSMIT) {
+		frame->can_id |= CAN_RTR_FLAG;
+		skb->rb_frame_size = EMPTY_RB_FRAME_SIZE;
+	} else {
+		int i, dreg = C_CAN_IFACE(DATA1_REG, iface);
+
+		if (priv->type == BOSCH_D_CAN) {
+			for (i = 0; i < frame->len; i += 4, dreg += 2) {
+				data = priv->read_reg32(priv, dreg);
+				frame->data[i] = data;
+				frame->data[i + 1] = data >> 8;
+				frame->data[i + 2] = data >> 16;
+				frame->data[i + 3] = data >> 24;
+			}
+		} else {
+
+			for (i = 0; i < frame->len; i += 2, dreg++) {
+				data = priv->read_reg(priv, dreg);
+				frame->data[i] = data;
+				frame->data[i + 1] = data >> 8;
+			}
+		}
+
+		skb->rb_frame_size = EMPTY_RB_FRAME_SIZE + frame->len;
+	}
+
+	return 0;
+}
+
+static void c_can_setup_receive_object(struct rtcan_device *dev, int iface,
+				       u32 obj, u32 mask, u32 id, u32 mcont)
+{
+	struct c_can_priv *priv = rtcan_priv(dev);
+
+	mask |= BIT(29);
+	priv->write_reg32(priv, C_CAN_IFACE(MASK1_REG, iface), mask);
+
+	id |= IF_ARB_MSGVAL;
+	priv->write_reg32(priv, C_CAN_IFACE(ARB1_REG, iface), id);
+
+	priv->write_reg(priv, C_CAN_IFACE(MSGCTRL_REG, iface), mcont);
+	c_can_object_put(dev, iface, obj, IF_COMM_RCV_SETUP);
+}
+
+static int c_can_start_xmit(struct rtcan_device *dev, struct can_frame *cf)
+{
+	struct c_can_priv *priv = rtcan_priv(dev);
+	u32 idx, obj, tx_active, tx_cached;
+	rtdm_lockctx_t lock_ctx;
+
+	rtdm_lock_get_irqsave(&priv->tx_cached_lock, lock_ctx);
+
+	tx_active = atomic_read(&priv->tx_active);
+	tx_cached = atomic_read(&priv->tx_cached);
+	idx = fls(tx_active);
+	if (idx > priv->msg_obj_tx_num - 1) {
+		idx = fls(tx_cached);
+		if (idx > priv->msg_obj_tx_num - 1) {
+			rtdm_lock_put_irqrestore(&priv->tx_cached_lock,
+						 lock_ctx);
+			rtcandev_err(dev, "FIFO full\n");
+			return -EIO;
+		}
+
+		obj = idx + priv->msg_obj_tx_first;
+		/* prepare message object for transmission */
+		c_can_setup_tx_object(dev, IF_TX, cf, idx);
+		c_can_object_put(dev, IF_TX, obj, IF_COMM_TX_FRAME);
+		priv->dlc[idx] = cf->len;
+		atomic_add((1 << idx), &priv->tx_cached);
+		rtdm_lock_put_irqrestore(&priv->tx_cached_lock, lock_ctx);
+		return 0;
+	}
+
+	rtdm_lock_put_irqrestore(&priv->tx_cached_lock, lock_ctx);
+
+	obj = idx + priv->msg_obj_tx_first;
+
+	/* prepare message object for transmission */
+	c_can_setup_tx_object(dev, IF_TX, cf, idx);
+	priv->dlc[idx] = cf->len;
+
+	/* Update the active bits */
+	atomic_add((1 << idx), &priv->tx_active);
+	/* Start transmission */
+	c_can_object_put(dev, IF_TX, obj, IF_COMM_TX);
+	return 0;
+}
+
+static int c_can_wait_for_ctrl_init(struct rtcan_device *dev,
+				    struct c_can_priv *priv, u32 init)
+{
+	int retry = 0;
+
+	while (init != (priv->read_reg(priv, C_CAN_CTRL_REG) & CONTROL_INIT)) {
+		udelay(10);
+		if (retry++ > 1000) {
+			rtcandev_err(dev, "CCTRL: set CONTROL_INIT failed\n");
+			return -EIO;
+		}
+	}
+	return 0;
+}
+
+static int c_can_set_bittiming(struct rtcan_device *dev)
+{
+	unsigned int reg_btr, reg_brpe, ctrl_save;
+	u8 brp, brpe, sjw, tseg1, tseg2;
+	u32 ten_bit_brp;
+	struct c_can_priv *priv = rtcan_priv(dev);
+	struct can_bittime *bt = &priv->bit_time;
+	int res;
+
+	/* c_can provides a 6-bit brp and 4-bit brpe fields */
+	ten_bit_brp = bt->std.brp - 1;
+	brp = ten_bit_brp & BTR_BRP_MASK;
+	brpe = ten_bit_brp >> 6;
+
+	sjw = bt->std.sjw - 1;
+	tseg1 = bt->std.prop_seg + bt->std.phase_seg1 - 1;
+	tseg2 = bt->std.phase_seg2 - 1;
+	reg_btr = brp | (sjw << BTR_SJW_SHIFT) | (tseg1 << BTR_TSEG1_SHIFT) |
+	    (tseg2 << BTR_TSEG2_SHIFT);
+	reg_brpe = brpe & BRP_EXT_BRPE_MASK;
+
+	rtcandev_info(dev, "setting BTR=%04x BRPE=%04x\n", reg_btr, reg_brpe);
+
+	ctrl_save = priv->read_reg(priv, C_CAN_CTRL_REG);
+	ctrl_save &= ~CONTROL_INIT;
+	priv->write_reg(priv, C_CAN_CTRL_REG, CONTROL_CCE | CONTROL_INIT);
+	res = c_can_wait_for_ctrl_init(dev, priv, CONTROL_INIT);
+	if (res)
+		return res;
+
+	priv->write_reg(priv, C_CAN_BTR_REG, reg_btr);
+	priv->write_reg(priv, C_CAN_BRPEXT_REG, reg_brpe);
+	priv->write_reg(priv, C_CAN_CTRL_REG, ctrl_save);
+
+	return c_can_wait_for_ctrl_init(dev, priv, 0);
+}
+
+/*
+ * Configure C_CAN message objects for Tx and Rx purposes:
+ * C_CAN provides a total of 32 message objects that can be configured
+ * either for Tx or Rx purposes. Here the first 16 message objects are used as
+ * a reception FIFO. The end of reception FIFO is signified by the EoB bit
+ * being SET. The remaining 16 message objects are kept aside for Tx purposes.
+ * See user guide document for further details on configuring message
+ * objects.
+ */
+static void c_can_configure_msg_objects(struct rtcan_device *dev)
+{
+	struct c_can_priv *priv = rtcan_priv(dev);
+	int i;
+
+	/* first invalidate all message objects */
+	for (i = priv->msg_obj_rx_first; i <= priv->msg_obj_num; i++)
+		c_can_inval_msg_object(dev, IF_RX, i);
+
+	/* setup receive message objects */
+	for (i = priv->msg_obj_rx_first; i < priv->msg_obj_rx_last; i++)
+		c_can_setup_receive_object(dev, IF_RX, i, 0, 0, IF_MCONT_RCV);
+
+	c_can_setup_receive_object(dev, IF_RX, priv->msg_obj_rx_last, 0, 0,
+				   IF_MCONT_RCV_EOB);
+}
+
+static int c_can_software_reset(struct rtcan_device *dev)
+{
+	struct c_can_priv *priv = rtcan_priv(dev);
+	int retry = 0;
+
+	if (priv->type != BOSCH_D_CAN)
+		return 0;
+
+	priv->write_reg(priv, C_CAN_CTRL_REG, CONTROL_SWR | CONTROL_INIT);
+	while (priv->read_reg(priv, C_CAN_CTRL_REG) & CONTROL_SWR) {
+		msleep(20);
+		if (retry++ > 100) {
+			rtcandev_err(dev, "CCTRL: software reset failed\n");
+			return -EIO;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * Configure C_CAN chip:
+ * - enable/disable auto-retransmission
+ * - set operating mode
+ * - configure message objects
+ */
+static int c_can_chip_config(struct rtcan_device *dev)
+{
+	struct c_can_priv *priv = rtcan_priv(dev);
+	int err;
+
+	err = c_can_software_reset(dev);
+	if (err)
+		return err;
+
+	/* enable automatic retransmission */
+	priv->write_reg(priv, C_CAN_CTRL_REG, CONTROL_ENABLE_AR);
+
+	if ((dev->ctrl_mode & CAN_CTRLMODE_LISTENONLY) &&
+	    (dev->ctrl_mode & CAN_CTRLMODE_LOOPBACK)) {
+		/* loopback + silent mode : useful for hot self-test */
+		priv->write_reg(priv, C_CAN_CTRL_REG, CONTROL_TEST);
+		priv->write_reg(priv, C_CAN_TEST_REG, TEST_LBACK | TEST_SILENT);
+	} else if (dev->ctrl_mode & CAN_CTRLMODE_LOOPBACK) {
+		/* loopback mode : useful for self-test function */
+		priv->write_reg(priv, C_CAN_CTRL_REG, CONTROL_TEST);
+		priv->write_reg(priv, C_CAN_TEST_REG, TEST_LBACK);
+	} else if (dev->ctrl_mode & CAN_CTRLMODE_LISTENONLY) {
+		/* silent mode : bus-monitoring mode */
+		priv->write_reg(priv, C_CAN_CTRL_REG, CONTROL_TEST);
+		priv->write_reg(priv, C_CAN_TEST_REG, TEST_SILENT);
+	}
+
+	/* configure message objects */
+	c_can_configure_msg_objects(dev);
+
+	/* set a `lec` value so that we can check for updates later */
+	priv->write_reg(priv, C_CAN_STS_REG, LEC_UNUSED);
+
+	/* Clear all internal status */
+	atomic_set(&priv->tx_active, 0);
+	atomic_set(&priv->tx_cached, 0);
+	priv->rxmasked = 0;
+	priv->tx_dir = 0;
+
+	/* set bittiming params */
+	return c_can_set_bittiming(dev);
+}
+
+static int c_can_save_bit_time(struct rtcan_device *dev, struct can_bittime *bt,
+			       rtdm_lockctx_t *lock_ctx)
+{
+	struct c_can_priv *priv = rtcan_priv(dev);
+
+	memcpy(&priv->bit_time, bt, sizeof(*bt));
+
+	return 0;
+}
+
+#ifdef CONFIG_XENO_DRIVERS_CAN_BUS_ERR
+static void c_can_enable_bus_err(struct rtcan_device *dev)
+{
+	struct c_can_priv *priv = rtcan_priv(dev);
+
+	if (priv->bus_err_on < 2) {
+		priv->write_reg(priv, C_CAN_STS_REG, LEC_UNUSED);
+		priv->bus_err_on = 2;
+	}
+}
+#endif
+
+static void c_can_do_tx(struct rtcan_device *dev)
+{
+	struct c_can_priv *priv = rtcan_priv(dev);
+	u32 idx, obj, pend, clr;
+
+	if (priv->msg_obj_tx_last > 32)
+		pend = priv->read_reg32(priv, C_CAN_INTPND3_REG);
+	else
+		pend = priv->read_reg(priv, C_CAN_INTPND2_REG);
+
+	clr = pend;
+
+	while ((idx = ffs(pend))) {
+		idx--;
+		pend &= ~(1 << idx);
+		obj = idx + priv->msg_obj_tx_first;
+		c_can_inval_tx_object(dev, IF_RX, obj);
+		rtdm_sem_up(&dev->tx_sem);
+		dev->tx_count++;
+	}
+
+	/* Clear the bits in the tx_active mask */
+	atomic_sub(clr, &priv->tx_active);
+
+	pend = atomic_read(&priv->tx_cached);
+	if (pend && atomic_read(&priv->tx_active) == 0) {
+		clr = pend;
+		while ((idx = ffs(pend))) {
+			idx--;
+			pend &= ~(1 << idx);
+
+			obj = idx + priv->msg_obj_tx_first;
+			c_can_object_put(dev, IF_RX, obj, IF_COMM_TXRQST);
+		}
+
+		atomic_sub(clr, &priv->tx_cached);
+		atomic_add(clr, &priv->tx_active);
+	}
+}
+
+/*
+ * If we have a gap in the pending bits, that means we either
+ * raced with the hardware or failed to readout all upper
+ * objects in the last run due to quota limit.
+ */
+static u32 c_can_adjust_pending(u32 pend, u32 rx_mask)
+{
+	u32 weight, lasts;
+
+	if (pend == rx_mask)
+		return pend;
+
+	/*
+	 * If the last set bit is larger than the number of pending
+	 * bits we have a gap.
+	 */
+	weight = hweight32(pend);
+	lasts = fls(pend);
+
+	/* If the bits are linear, nothing to do */
+	if (lasts == weight)
+		return pend;
+
+	/*
+	 * Find the first set bit after the gap. We walk backwards
+	 * from the last set bit.
+	 */
+	for (lasts--; pend & (1 << (lasts - 1)); lasts--)
+		;
+
+	return pend & ~((1 << lasts) - 1);
+}
+
+static inline void c_can_rx_object_get(struct rtcan_device *dev,
+				       struct c_can_priv *priv, u32 obj)
+{
+	c_can_object_get(dev, IF_RX, obj, priv->comm_rcv_high);
+}
+
+static inline void c_can_rx_finalize(struct rtcan_device *dev,
+				     struct c_can_priv *priv, u32 obj)
+{
+	if (priv->type != BOSCH_D_CAN)
+		c_can_object_get(dev, IF_RX, obj, IF_COMM_CLR_NEWDAT);
+}
+
+static int c_can_read_objects(struct rtcan_device *dev, struct c_can_priv *priv,
+			      u32 pend, int quota)
+{
+	struct rtcan_skb skb;
+	u32 pkts = 0, ctrl, obj;
+
+	while ((obj = ffs(pend)) && quota > 0) {
+		pend &= ~BIT(obj - 1);
+
+		c_can_rx_object_get(dev, priv, obj);
+		ctrl = priv->read_reg(priv, C_CAN_IFACE(MSGCTRL_REG, IF_RX));
+
+		if (ctrl & IF_MCONT_MSGLST) {
+			int n = c_can_handle_lost_msg_obj(dev, IF_RX, obj, ctrl,
+							  &skb);
+
+			pkts += n;
+			quota -= n;
+			continue;
+		}
+
+		/*
+		 * This really should not happen, but this covers some
+		 * odd HW behaviour. Do not remove that unless you
+		 * want to brick your machine.
+		 */
+		if (!(ctrl & IF_MCONT_NEWDAT))
+			continue;
+
+		/* read the data from the message object */
+		c_can_read_msg_object(dev, IF_RX, ctrl, &skb);
+
+		c_can_rx_finalize(dev, priv, obj);
+
+		rtcan_rcv(dev, &skb);
+		quota--;
+		pkts++;
+	}
+
+	return pkts;
+}
+
+static inline u32 c_can_get_pending(struct c_can_priv *priv)
+{
+	u32 pend = priv->read_reg32(priv, C_CAN_NEWDAT1_REG);
+
+	return pend;
+}
+
+/*
+ * theory of operation:
+ *
+ * c_can core saves a received CAN message into the first free message
+ * object it finds free (starting with the lowest). Bits NEWDAT and
+ * INTPND are set for this message object indicating that a new message
+ * has arrived. To work-around this issue, we keep two groups of message
+ * objects whose partitioning is defined by C_CAN_MSG_OBJ_RX_SPLIT.
+ *
+ * We clear the newdat bit right away.
+ *
+ * This can result in packet reordering when the readout is slow.
+ */
+static int c_can_do_rx_poll(struct rtcan_device *dev, int quota)
+{
+	struct c_can_priv *priv = rtcan_priv(dev);
+	u32 pkts = 0, pend = 0, toread, n;
+
+	BUG_ON(priv->msg_obj_rx_last > 32);
+
+	while (quota > 0) {
+
+		if (!pend) {
+			pend = c_can_get_pending(priv);
+			if (!pend)
+				break;
+			/*
+			 * If the pending field has a gap, handle the
+			 * bits above the gap first.
+			 */
+			toread = c_can_adjust_pending(pend,
+						      priv->msg_obj_rx_mask);
+		} else {
+			toread = pend;
+		}
+		/* Remove the bits from pend */
+		pend &= ~toread;
+		/* Read the objects */
+		n = c_can_read_objects(dev, priv, toread, quota);
+		pkts += n;
+		quota -= n;
+	}
+	return pkts;
+}
+
+static int c_can_handle_state_change(struct rtcan_device *dev,
+				     enum CAN_STATE error_type)
+{
+	unsigned int reg_err_counter;
+	u8 txerr;
+	u8 rxerr;
+	unsigned int rx_err_passive;
+	struct c_can_priv *priv = rtcan_priv(dev);
+	struct rtcan_skb skb;
+	struct rtcan_rb_frame *cf = &skb.rb_frame;
+
+	/* propagate the error condition to the CAN stack */
+	reg_err_counter = priv->read_reg(priv, C_CAN_ERR_CNT_REG);
+	rxerr = (reg_err_counter & ERR_CNT_REC_MASK) >> ERR_CNT_REC_SHIFT;
+	txerr = reg_err_counter & ERR_CNT_TEC_MASK;
+	rx_err_passive = (reg_err_counter & ERR_CNT_RP_MASK) >>
+	    ERR_CNT_RP_SHIFT;
+
+	skb.rb_frame_size = EMPTY_RB_FRAME_SIZE + CAN_ERR_DLC;
+	cf->can_id = CAN_ERR_FLAG;
+	cf->len = CAN_ERR_DLC;
+	memset(&cf->data[0], 0, cf->len);
+
+	switch (error_type) {
+	case CAN_STATE_ERROR_ACTIVE:
+		/* RX/TX error count < 96 */
+		dev->state = CAN_STATE_ERROR_ACTIVE;
+		cf->can_id |= CAN_ERR_CRTL;
+		cf->data[1] = CAN_ERR_CRTL_ACTIVE;
+		cf->data[6] = txerr;
+		cf->data[7] = rxerr;
+		break;
+	case CAN_STATE_ERROR_WARNING:
+		/* error warning state */
+		dev->state = CAN_STATE_ERROR_WARNING;
+		cf->can_id |= CAN_ERR_CRTL;
+		cf->data[1] = (txerr > rxerr) ?
+		    CAN_ERR_CRTL_TX_WARNING : CAN_ERR_CRTL_RX_WARNING;
+		cf->data[6] = txerr;
+		cf->data[7] = rxerr;
+
+		break;
+	case CAN_STATE_ERROR_PASSIVE:
+		/* error passive state */
+		dev->state = CAN_STATE_ERROR_PASSIVE;
+		cf->can_id |= CAN_ERR_CRTL;
+		if (rx_err_passive)
+			cf->data[1] |= CAN_ERR_CRTL_RX_PASSIVE;
+		if (txerr > 127)
+			cf->data[1] |= CAN_ERR_CRTL_TX_PASSIVE;
+
+		cf->data[6] = txerr;
+		cf->data[7] = rxerr;
+		break;
+	case CAN_STATE_BUS_OFF:
+		/* bus-off state */
+		dev->state = CAN_STATE_BUS_OFF;
+		cf->can_id |= CAN_ERR_BUSOFF;
+		/* Wake up waiting senders */
+		rtdm_sem_destroy(&dev->tx_sem);
+		break;
+	default:
+		break;
+	}
+
+	/* Store the interface index */
+	cf->can_ifindex = dev->ifindex;
+	rtcan_rcv(dev, &skb);
+
+	return 1;
+}
+
+static int c_can_handle_bus_err(struct rtcan_device *dev,
+				enum c_can_lec_type lec_type)
+{
+	struct c_can_priv *priv = rtcan_priv(dev);
+	struct rtcan_skb skb;
+	struct rtcan_rb_frame *cf = &skb.rb_frame;
+	skb.rb_frame_size = EMPTY_RB_FRAME_SIZE + CAN_ERR_DLC;
+
+	/*
+	 * early exit if no lec update or no error.
+	 * no lec update means that no CAN bus event has been detected
+	 * since CPU wrote 0x7 value to status reg.
+	 */
+	if (lec_type == LEC_UNUSED || lec_type == LEC_NO_ERROR)
+		return 0;
+
+	if (priv->bus_err_on < 2)
+		return 0;
+
+	priv->bus_err_on--;
+	/*
+	 * check for 'last error code' which tells us the
+	 * type of the last error to occur on the CAN bus
+	 */
+
+	/* common for all type of bus errors */
+
+	cf->can_id = CAN_ERR_PROT | CAN_ERR_BUSERROR;
+	cf->len = CAN_ERR_DLC;
+	memset(&cf->data[0], 0, cf->len);
+
+	switch (lec_type) {
+	case LEC_STUFF_ERROR:
+		rtcandev_dbg(dev, "stuff error\n");
+		cf->data[2] |= CAN_ERR_PROT_STUFF;
+		break;
+	case LEC_FORM_ERROR:
+		rtcandev_dbg(dev, "form error\n");
+		cf->data[2] |= CAN_ERR_PROT_FORM;
+		break;
+	case LEC_ACK_ERROR:
+		rtcandev_dbg(dev, "ack error\n");
+		cf->data[3] |= CAN_ERR_PROT_LOC_ACK;
+		break;
+	case LEC_BIT1_ERROR:
+		rtcandev_dbg(dev, "bit1 error\n");
+		cf->data[2] |= CAN_ERR_PROT_BIT1;
+		break;
+	case LEC_BIT0_ERROR:
+		rtcandev_dbg(dev, "bit0 error\n");
+		cf->data[2] |= CAN_ERR_PROT_BIT0;
+		break;
+	case LEC_CRC_ERROR:
+		rtcandev_dbg(dev, "CRC error\n");
+		cf->data[3] |= CAN_ERR_PROT_LOC_CRC_SEQ;
+		break;
+	default:
+		break;
+	}
+
+	cf->can_ifindex = dev->ifindex;
+	rtcan_rcv(dev, &skb);
+
+	return 1;
+}
+
+static int c_can_interrupt(rtdm_irq_t *irq_handle)
+{
+	struct rtcan_device *dev = rtdm_irq_get_arg(irq_handle, void);
+	struct c_can_priv *priv = rtcan_priv(dev);
+	u16 reg_int, curr, last = priv->last_status;
+
+	reg_int = priv->read_reg(priv, C_CAN_INT_REG);
+	if (!reg_int)
+		return RTDM_IRQ_NONE;
+
+	c_can_irq_control(priv, false);
+
+	rtdm_lock_get(&dev->device_lock);
+	rtdm_lock_get(&rtcan_recv_list_lock);
+	rtdm_lock_get(&rtcan_socket_lock);
+
+	/* Only read the status register if a status interrupt was pending */
+	if (reg_int & INT_STS_PENDING) {
+		priv->last_status = curr = priv->read_reg(priv, C_CAN_STS_REG);
+		/* Ack status on C_CAN. D_CAN is self clearing */
+		if (priv->type != BOSCH_D_CAN)
+			priv->write_reg(priv, C_CAN_STS_REG, LEC_UNUSED);
+	} else {
+		/* no change detected ... */
+		curr = last;
+	}
+
+	/* handle state changes */
+	if ((curr & STATUS_EWARN) && (!(last & STATUS_EWARN))) {
+		rtcandev_dbg(dev, "entered error warning state\n");
+		c_can_handle_state_change(dev, CAN_STATE_ERROR_WARNING);
+
+	}
+
+	if ((curr & STATUS_EPASS) && (!(last & STATUS_EPASS))) {
+		rtcandev_dbg(dev, "entered error passive state\n");
+		c_can_handle_state_change(dev, CAN_STATE_ERROR_PASSIVE);
+	}
+
+	if ((curr & STATUS_BOFF) && (!(last & STATUS_BOFF))) {
+		rtcandev_dbg(dev, "entered bus off state\n");
+		c_can_handle_state_change(dev, CAN_STATE_BUS_OFF);
+		goto end;
+	}
+
+	/* handle bus recovery events */
+	if ((!(curr & STATUS_BOFF)) && (last & STATUS_BOFF)) {
+		rtcandev_dbg(dev, "left bus off state\n");
+		c_can_handle_state_change(dev, CAN_STATE_ERROR_PASSIVE);
+	}
+
+	if ((!(curr & STATUS_EPASS)) && (last & STATUS_EPASS)) {
+		rtcandev_dbg(dev, "left error passive state\n");
+		c_can_handle_state_change(dev, CAN_STATE_ERROR_WARNING);
+	}
+
+	if ((!(curr & STATUS_EWARN)) && (last & STATUS_EWARN)) {
+		rtcandev_dbg(dev, "left error warning state\n");
+		c_can_handle_state_change(dev, CAN_STATE_ERROR_ACTIVE);
+	}
+
+	/* handle lec errors on the bus */
+	c_can_handle_bus_err(dev, curr & LEC_MASK);
+
+	/* Handle Tx/Rx events. We do this unconditionally */
+	c_can_do_rx_poll(dev, priv->msg_obj_rx_num);
+	c_can_do_tx(dev);
+
+	if (curr >= priv->msg_obj_rx_first && curr <= priv->msg_obj_rx_last &&
+	    rtcan_loopback_pending(dev))
+		rtcan_loopback(dev);
+
+end:
+	rtdm_lock_put(&rtcan_socket_lock);
+	rtdm_lock_put(&rtcan_recv_list_lock);
+	rtdm_lock_put(&dev->device_lock);
+
+	/* enable all IRQs if we are not in bus off state */
+	if (dev->state != CAN_STATE_BUS_OFF)
+		c_can_irq_control(priv, true);
+
+	return RTDM_IRQ_HANDLED;
+}
+
+static int c_can_mode_start(struct rtcan_device *dev, rtdm_lockctx_t *lock_ctx)
+{
+	struct c_can_priv *priv = rtcan_priv(dev);
+	struct pinctrl *p;
+	int err;
+
+	switch (dev->state) {
+
+	case CAN_STATE_ACTIVE:
+	case CAN_STATE_BUS_WARNING:
+	case CAN_STATE_BUS_PASSIVE:
+		//rtcandev_info(dev, "Mode start: state active, bus warning, or passive\n");
+		break;
+
+	case CAN_STATE_STOPPED:
+		/* Register IRQ handler and pass device structure as arg */
+		err = rtdm_irq_request(&dev->irq_handle, priv->irq,
+				       c_can_interrupt, 0, DRV_NAME,
+				       (void *)dev);
+		if (err) {
+			rtcandev_err(dev, "couldn't request irq %d\n",
+				     priv->irq);
+			goto out;
+		}
+
+		c_can_pm_runtime_get_sync(priv);
+		c_can_reset_ram(priv, true);
+
+		/* start chip and queuing */
+		err = c_can_chip_config(dev);
+		if (err)
+			goto out;
+
+		/* Setup the command for new messages */
+		priv->comm_rcv_high = priv->type != BOSCH_D_CAN ?
+		    IF_COMM_RCV_LOW : IF_COMM_RCV_HIGH;
+
+		dev->state = CAN_STATE_ERROR_ACTIVE;
+
+		/* enable status change, error and module interrupts */
+		c_can_irq_control(priv, true);
+
+		/* Set up sender "mutex" */
+		rtdm_sem_init(&dev->tx_sem, priv->msg_obj_tx_num);
+
+		break;
+
+	case CAN_STATE_BUS_OFF:
+		/* Set up sender "mutex" */
+		rtdm_sem_init(&dev->tx_sem, priv->msg_obj_tx_num);
+		/* start chip and queuing */
+		c_can_pm_runtime_get_sync(priv);
+		c_can_reset_ram(priv, true);
+		err = c_can_chip_config(dev);
+		if (err)
+			goto out;
+
+		dev->state = CAN_STATE_ERROR_ACTIVE;
+		/* enable status change, error and module interrupts */
+		c_can_irq_control(priv, true);
+		break;
+
+	case CAN_STATE_SLEEPING:
+		//rtcandev_info(dev, "Mode start: state sleeping\n");
+	default:
+		/* Never reached, but we don't want nasty compiler warnings ... */
+		break;
+	}
+
+	return 0;
+out:
+	/* Attempt to use "active" if available else use "default" */
+	p = pinctrl_get_select(priv->device, "active");
+	if (!IS_ERR(p))
+		pinctrl_put(p);
+	else
+		pinctrl_pm_select_default_state(priv->device);
+
+	c_can_pm_runtime_put_sync(priv);
+	return err;
+}
+
+static void c_can_mode_stop(struct rtcan_device *dev, rtdm_lockctx_t *lock_ctx)
+{
+	struct c_can_priv *priv = rtcan_priv(dev);
+	can_state_t state;
+
+	state = dev->state;
+	/* If controller is not operating anyway, go out */
+	if (!CAN_STATE_OPERATING(state))
+		return;
+	/* put ctrl to init on stop to end ongoing transmission */
+	priv->write_reg(priv, C_CAN_CTRL_REG, CONTROL_INIT);
+
+	//rtcandev_info(dev, "Mode stop.\n");
+	/* disable all interrupts */
+	c_can_irq_control(priv, false);
+
+	/* deactivate pins */
+	pinctrl_pm_select_sleep_state(priv->device->parent);
+
+	/* set the state as STOPPED */
+	dev->state = CAN_STATE_STOPPED;
+
+	/* Wake up waiting senders */
+	rtdm_sem_destroy(&dev->tx_sem);
+
+	rtdm_irq_free(&dev->irq_handle);
+	c_can_pm_runtime_put_sync(priv);
+}
+
+static int c_can_set_mode(struct rtcan_device *dev, can_mode_t mode,
+			  rtdm_lockctx_t *lock_ctx)
+{
+	int err = 0;
+	//rtcandev_info(dev, "Set mode.\n");
+
+	switch (mode) {
+
+	case CAN_MODE_STOP:
+		//rtcandev_info(dev, "Set mode: stop\n");
+		c_can_mode_stop(dev, lock_ctx);
+		break;
+
+	case CAN_MODE_START:
+		//rtcandev_info(dev, "Set mode: start\n");
+		err = c_can_mode_start(dev, lock_ctx);
+		break;
+
+	case CAN_MODE_SLEEP:
+	default:
+		err = -EOPNOTSUPP;
+		break;
+	}
+
+	return err;
+}
+
+struct rtcan_device *rtcan_c_can_dev_alloc(int msg_obj_num)
+{
+	struct rtcan_device *dev;
+	struct c_can_priv *priv;
+
+	dev = rtcan_dev_alloc(sizeof(struct c_can_priv), 0);
+	if (!dev)
+		return NULL;
+
+	priv = rtcan_priv(dev);
+
+	priv->dev = dev;
+	priv->bus_err_on = 1;
+	dev->hard_start_xmit = c_can_start_xmit;
+	dev->do_set_mode = c_can_set_mode;
+	dev->do_set_bit_time = c_can_save_bit_time;
+	dev->bittiming_const = &c_can_bittiming_const;
+#ifdef CONFIG_XENO_DRIVERS_CAN_BUS_ERR
+	dev->do_enable_bus_err = c_can_enable_bus_err;
+#endif
+	rtcan_c_can_set_ethtool_ops(dev);
+
+	rtdm_lock_init(&priv->tx_cached_lock);
+	priv->msg_obj_num = msg_obj_num;
+	priv->msg_obj_rx_num = msg_obj_num / 2;
+	priv->msg_obj_rx_first = 1;
+	priv->msg_obj_rx_last =
+	    priv->msg_obj_rx_first + priv->msg_obj_rx_num - 1;
+	priv->msg_obj_rx_low_last =
+	    (priv->msg_obj_rx_first + priv->msg_obj_rx_last) / 2;
+	priv->msg_obj_rx_mask = ((u64) 1 << priv->msg_obj_rx_num) - 1;
+
+	priv->msg_obj_tx_num = msg_obj_num - priv->msg_obj_rx_num;
+	priv->msg_obj_tx_first = priv->msg_obj_rx_last + 1;
+	priv->msg_obj_tx_last =
+	    priv->msg_obj_tx_first + priv->msg_obj_tx_num - 1;
+	priv->msg_obj_tx_next_mask = priv->msg_obj_tx_num - 1;
+
+	priv->dlc = kcalloc(priv->msg_obj_tx_num, sizeof(*priv->dlc),
+			    GFP_KERNEL);
+	if (!priv->dlc) {
+		rtcan_dev_free(dev);
+		return NULL;
+	}
+
+	return dev;
+}
+EXPORT_SYMBOL_GPL(rtcan_c_can_dev_alloc);
+
+void rtcan_c_can_dev_free(struct rtcan_device *dev)
+{
+	struct c_can_priv *priv = rtcan_priv(dev);
+
+	kfree(priv->dlc);
+	rtcan_dev_free(dev);
+}
+EXPORT_SYMBOL_GPL(rtcan_c_can_dev_free);
+
+int rtcan_c_can_register(struct rtcan_device *dev)
+{
+	int err;
+	struct c_can_priv *priv = rtcan_priv(dev);
+
+	/* Deactivate pins to prevent DRA7 DCAN IP from being
+	 * stuck in transition when module is disabled.
+	 * Pins are activated in c_can_start() and deactivated
+	 * in c_can_stop()
+	 */
+	pinctrl_pm_select_sleep_state(priv->device->parent);
+
+	c_can_pm_runtime_enable(priv);
+
+	err = rtcan_dev_register(dev);
+	if (err)
+		goto out_chip_disable;
+
+	return 0;
+
+out_chip_disable:
+	c_can_pm_runtime_disable(priv);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(rtcan_c_can_register);
+
+void rtcan_c_can_unregister(struct rtcan_device *dev)
+{
+	c_can_mode_stop(dev, NULL);
+	rtcan_dev_unregister(dev);
+}
+EXPORT_SYMBOL_GPL(rtcan_c_can_unregister);
+
+MODULE_AUTHOR("Stephen J. Battazzo <stephen.j.battazzo@nasa.gov>");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("RT-Socket-CAN driver for Bosch C_CAN");
+MODULE_SUPPORTED_DEVICE("Boch C_CAN CAN controller");
diff --git a/kernel/drivers/can/c_can/rtcan_c_can.h b/kernel/drivers/can/c_can/rtcan_c_can.h
new file mode 100644
index 000000000..2edbb13ea
--- /dev/null
+++ b/kernel/drivers/can/c_can/rtcan_c_can.h
@@ -0,0 +1,255 @@
+/*
+ * CAN bus driver for Bosch C_CAN controller, ported to Xenomai RTDM
+ *
+ * Copyright 2021, Dario Binacchi <dariobin@libero.it>
+ *
+ * Copyright (C) 2010 ST Microelectronics
+ * Bhupesh Sharma <bhupesh.sharma@st.com>
+ *
+ * Stephen J. Battazzo <stephen.j.battazzo@nasa.gov>,
+ * MEI Services/NASA Ames Research Center
+ *
+ * Borrowed original driver from:
+ *
+ * Bhupesh Sharma <bhupesh.sharma@st.com>, ST Microelectronics
+ * Borrowed heavily from the C_CAN driver originally written by:
+ * Copyright (C) 2007
+ * - Sascha Hauer, Marc Kleine-Budde, Pengutronix <s.hauer@pengutronix.de>
+ * - Simon Kallweit, intefo AG <simon.kallweit@intefo.ch>
+ *
+ * TX and RX NAPI implementation has been removed and replaced with RT Socket CAN implementation.
+ * RT Socket CAN implementation inspired by Flexcan RTDM port by Wolfgang Grandegger <wg@denx.de>
+ *
+ * Bosch C_CAN controller is compliant to CAN protocol version 2.0 part A and B.
+ * Bosch C_CAN user manual can be obtained from:
+ * http://www.semiconductors.bosch.de/media/en/pdf/ipmodules_1/c_can/
+ * users_manual_c_can.pdf
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef RTCAN_C_CAN_H
+#define RTCAN_C_CAN_H
+
+enum reg {
+	C_CAN_CTRL_REG = 0,
+	C_CAN_CTRL_EX_REG,
+	C_CAN_STS_REG,
+	C_CAN_ERR_CNT_REG,
+	C_CAN_BTR_REG,
+	C_CAN_INT_REG,
+	C_CAN_TEST_REG,
+	C_CAN_BRPEXT_REG,
+	C_CAN_IF1_COMREQ_REG,
+	C_CAN_IF1_COMMSK_REG,
+	C_CAN_IF1_MASK1_REG,
+	C_CAN_IF1_MASK2_REG,
+	C_CAN_IF1_ARB1_REG,
+	C_CAN_IF1_ARB2_REG,
+	C_CAN_IF1_MSGCTRL_REG,
+	C_CAN_IF1_DATA1_REG,
+	C_CAN_IF1_DATA2_REG,
+	C_CAN_IF1_DATA3_REG,
+	C_CAN_IF1_DATA4_REG,
+	C_CAN_IF2_COMREQ_REG,
+	C_CAN_IF2_COMMSK_REG,
+	C_CAN_IF2_MASK1_REG,
+	C_CAN_IF2_MASK2_REG,
+	C_CAN_IF2_ARB1_REG,
+	C_CAN_IF2_ARB2_REG,
+	C_CAN_IF2_MSGCTRL_REG,
+	C_CAN_IF2_DATA1_REG,
+	C_CAN_IF2_DATA2_REG,
+	C_CAN_IF2_DATA3_REG,
+	C_CAN_IF2_DATA4_REG,
+	C_CAN_TXRQST1_REG,
+	C_CAN_TXRQST2_REG,
+	C_CAN_TXRQST3_REG,
+	C_CAN_TXRQST4_REG,
+	C_CAN_NEWDAT1_REG,
+	C_CAN_NEWDAT2_REG,
+	C_CAN_INTPND1_REG,
+	C_CAN_INTPND2_REG,
+	C_CAN_INTPND3_REG,
+	C_CAN_MSGVAL1_REG,
+	C_CAN_MSGVAL2_REG,
+	C_CAN_FUNCTION_REG,
+};
+
+static const u16 reg_map_c_can[] = {
+	[C_CAN_CTRL_REG] = 0x00,
+	[C_CAN_STS_REG] = 0x02,
+	[C_CAN_ERR_CNT_REG] = 0x04,
+	[C_CAN_BTR_REG] = 0x06,
+	[C_CAN_INT_REG] = 0x08,
+	[C_CAN_TEST_REG] = 0x0A,
+	[C_CAN_BRPEXT_REG] = 0x0C,
+	[C_CAN_IF1_COMREQ_REG] = 0x10,
+	[C_CAN_IF1_COMMSK_REG] = 0x12,
+	[C_CAN_IF1_MASK1_REG] = 0x14,
+	[C_CAN_IF1_MASK2_REG] = 0x16,
+	[C_CAN_IF1_ARB1_REG] = 0x18,
+	[C_CAN_IF1_ARB2_REG] = 0x1A,
+	[C_CAN_IF1_MSGCTRL_REG] = 0x1C,
+	[C_CAN_IF1_DATA1_REG] = 0x1E,
+	[C_CAN_IF1_DATA2_REG] = 0x20,
+	[C_CAN_IF1_DATA3_REG] = 0x22,
+	[C_CAN_IF1_DATA4_REG] = 0x24,
+	[C_CAN_IF2_COMREQ_REG] = 0x40,
+	[C_CAN_IF2_COMMSK_REG] = 0x42,
+	[C_CAN_IF2_MASK1_REG] = 0x44,
+	[C_CAN_IF2_MASK2_REG] = 0x46,
+	[C_CAN_IF2_ARB1_REG] = 0x48,
+	[C_CAN_IF2_ARB2_REG] = 0x4A,
+	[C_CAN_IF2_MSGCTRL_REG] = 0x4C,
+	[C_CAN_IF2_DATA1_REG] = 0x4E,
+	[C_CAN_IF2_DATA2_REG] = 0x50,
+	[C_CAN_IF2_DATA3_REG] = 0x52,
+	[C_CAN_IF2_DATA4_REG] = 0x54,
+	[C_CAN_TXRQST1_REG] = 0x80,
+	[C_CAN_TXRQST2_REG] = 0x82,
+	[C_CAN_NEWDAT1_REG] = 0x90,
+	[C_CAN_NEWDAT2_REG] = 0x92,
+	[C_CAN_INTPND1_REG] = 0xA0,
+	[C_CAN_INTPND2_REG] = 0xA2,
+	[C_CAN_MSGVAL1_REG] = 0xB0,
+	[C_CAN_MSGVAL2_REG] = 0xB2,
+};
+
+static const u16 reg_map_d_can[] = {
+	[C_CAN_CTRL_REG] = 0x00,
+	[C_CAN_CTRL_EX_REG] = 0x02,
+	[C_CAN_STS_REG] = 0x04,
+	[C_CAN_ERR_CNT_REG] = 0x08,
+	[C_CAN_BTR_REG] = 0x0C,
+	[C_CAN_BRPEXT_REG] = 0x0E,
+	[C_CAN_INT_REG] = 0x10,
+	[C_CAN_TEST_REG] = 0x14,
+	[C_CAN_FUNCTION_REG] = 0x18,
+	[C_CAN_TXRQST1_REG] = 0x88,
+	[C_CAN_TXRQST2_REG] = 0x8A,
+	[C_CAN_TXRQST3_REG] = 0x8C,
+	[C_CAN_TXRQST4_REG] = 0x8E,
+	[C_CAN_NEWDAT1_REG] = 0x9C,
+	[C_CAN_NEWDAT2_REG] = 0x9E,
+	[C_CAN_INTPND1_REG] = 0xB0,
+	[C_CAN_INTPND2_REG] = 0xB2,
+	[C_CAN_INTPND3_REG] = 0xB4,
+	[C_CAN_MSGVAL1_REG] = 0xC4,
+	[C_CAN_MSGVAL2_REG] = 0xC6,
+	[C_CAN_IF1_COMREQ_REG] = 0x100,
+	[C_CAN_IF1_COMMSK_REG] = 0x102,
+	[C_CAN_IF1_MASK1_REG] = 0x104,
+	[C_CAN_IF1_MASK2_REG] = 0x106,
+	[C_CAN_IF1_ARB1_REG] = 0x108,
+	[C_CAN_IF1_ARB2_REG] = 0x10A,
+	[C_CAN_IF1_MSGCTRL_REG] = 0x10C,
+	[C_CAN_IF1_DATA1_REG] = 0x110,
+	[C_CAN_IF1_DATA2_REG] = 0x112,
+	[C_CAN_IF1_DATA3_REG] = 0x114,
+	[C_CAN_IF1_DATA4_REG] = 0x116,
+	[C_CAN_IF2_COMREQ_REG] = 0x120,
+	[C_CAN_IF2_COMMSK_REG] = 0x122,
+	[C_CAN_IF2_MASK1_REG] = 0x124,
+	[C_CAN_IF2_MASK2_REG] = 0x126,
+	[C_CAN_IF2_ARB1_REG] = 0x128,
+	[C_CAN_IF2_ARB2_REG] = 0x12A,
+	[C_CAN_IF2_MSGCTRL_REG] = 0x12C,
+	[C_CAN_IF2_DATA1_REG] = 0x130,
+	[C_CAN_IF2_DATA2_REG] = 0x132,
+	[C_CAN_IF2_DATA3_REG] = 0x134,
+	[C_CAN_IF2_DATA4_REG] = 0x136,
+};
+
+enum c_can_dev_id {
+	BOSCH_C_CAN_PLATFORM,
+	BOSCH_C_CAN,
+	BOSCH_D_CAN,
+};
+
+struct raminit_bits {
+	u8 start;
+	u8 done;
+};
+
+struct c_can_driver_data {
+	enum c_can_dev_id id;
+
+	int msg_obj_num;
+
+	/* RAMINIT register description. Optional. */
+	const struct raminit_bits *raminit_bits;	/* Array of START/DONE bit positions */
+	u8 raminit_num;		/* Number of CAN instances on the SoC */
+	bool raminit_pulse;	/* If set, sets and clears START bit (pulse) */
+};
+
+/* Out of band RAMINIT register access via syscon regmap */
+struct c_can_raminit {
+	struct regmap *syscon;	/* for raminit ctrl. reg. access */
+	unsigned int reg;	/* register index within syscon */
+	struct raminit_bits bits;
+	bool needs_pulse;
+};
+
+#define DEV_NAME	"rtcan%d"
+#define DRV_NAME	"c_can"
+
+/* c_can private data structure */
+struct c_can_priv {
+	struct rtcan_device *dev;
+
+	int irq;
+
+	struct device *device;
+
+	struct can_bittime bit_time;
+	char bus_err_on;
+	int tx_object;
+	int current_status;
+	int last_status;
+	u16 (*read_reg)(const struct c_can_priv *priv, enum reg index);
+	void (*write_reg)(const struct c_can_priv *priv, enum reg index,
+			  u16 val);
+	u32 (*read_reg32)(const struct c_can_priv *priv, enum reg index);
+	void (*write_reg32)(const struct c_can_priv *priv, enum reg index,
+			    u32 val);
+	void __iomem *base;
+	const u16 *regs;
+	unsigned long irq_flags;	/* for request_irq() */
+	atomic_t tx_active;
+	atomic_t tx_cached;
+	rtdm_lock_t tx_cached_lock;
+	unsigned long tx_dir;
+	void *priv;		/* for board-specific data */
+	u16 irqstatus;
+	enum c_can_dev_id type;
+	int msg_obj_num;
+	int msg_obj_rx_num;
+	int msg_obj_tx_num;
+	int msg_obj_rx_first;
+	int msg_obj_rx_last;
+	int msg_obj_rx_low_last;
+	u32 msg_obj_rx_mask;
+	u32 rxmasked;
+	int msg_obj_tx_first;
+	int msg_obj_tx_last;
+	int msg_obj_tx_next_mask;
+	u32 comm_rcv_high;
+	u32 *dlc;
+	struct c_can_raminit raminit_sys;	/* RAMINIT via syscon regmap */
+	u32 __iomem *raminit_ctrlreg;
+	unsigned int instance;
+	void (*raminit)(const struct c_can_priv *priv, bool enable);
+};
+
+struct rtcan_device *rtcan_c_can_dev_alloc(int msg_obj_num);
+void rtcan_c_can_dev_free(struct rtcan_device *dev);
+
+int rtcan_c_can_register(struct rtcan_device *dev);
+void rtcan_c_can_unregister(struct rtcan_device *dev);
+
+void rtcan_c_can_set_ethtool_ops(struct rtcan_device *dev);
+
+#endif
diff --git a/kernel/drivers/can/c_can/rtcan_c_can_ethtool.c b/kernel/drivers/can/c_can/rtcan_c_can_ethtool.c
new file mode 100644
index 000000000..7945ce4d8
--- /dev/null
+++ b/kernel/drivers/can/c_can/rtcan_c_can_ethtool.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2021, Dario Binacchi <dariobin@libero.it>
+ */
+
+#include <linux/platform_device.h>
+
+/* CAN device profile */
+#include <rtdm/can.h>
+
+#include "rtcan_dev.h"
+#include "rtcan_raw.h"
+#include "rtcan_internal.h"
+#include "rtcan_ethtool.h"
+#include "rtcan_c_can.h"
+
+static void rtcan_c_can_get_drvinfo(struct rtcan_device *dev,
+				    struct ethtool_drvinfo *info)
+{
+	struct c_can_priv *priv = rtcan_priv(dev);
+	struct platform_device *pdev = to_platform_device(priv->device);
+
+	strlcpy(info->driver, "c_can", sizeof(info->driver));
+	strlcpy(info->version, "1.0", sizeof(info->version));
+	strlcpy(info->bus_info, pdev->name, sizeof(info->bus_info));
+}
+
+static void rtcan_c_can_get_ringparam(struct rtcan_device *dev,
+				      struct ethtool_ringparam *ring)
+{
+	struct c_can_priv *priv = rtcan_priv(dev);
+
+	ring->rx_max_pending = priv->msg_obj_num;
+	ring->tx_max_pending = priv->msg_obj_num;
+	ring->rx_pending = priv->msg_obj_rx_num;
+	ring->tx_pending = priv->msg_obj_tx_num;
+}
+
+static const struct rtcan_ethtool_ops rtcan_c_can_ethtool_ops = {
+	.get_drvinfo = rtcan_c_can_get_drvinfo,
+	.get_ringparam = rtcan_c_can_get_ringparam,
+};
+
+void rtcan_c_can_set_ethtool_ops(struct rtcan_device *dev)
+{
+	dev->ethtool_ops = &rtcan_c_can_ethtool_ops;
+}
diff --git a/kernel/drivers/can/c_can/rtcan_c_can_platform.c b/kernel/drivers/can/c_can/rtcan_c_can_platform.c
new file mode 100644
index 000000000..0d29d9877
--- /dev/null
+++ b/kernel/drivers/can/c_can/rtcan_c_can_platform.c
@@ -0,0 +1,461 @@
+/*
+ * CAN bus driver for Bosch C_CAN controller, ported to Xenomai RTDM
+ *
+ * Copyright 2021, Dario Binacchi <dariobin@libero.it>
+ *
+ * Stephen J. Battazzo <stephen.j.battazzo@nasa.gov>,
+ * MEI Services/NASA Ames Research Center
+ *
+ * Borrowed original driver from:
+ *
+ * Bhupesh Sharma <bhupesh.sharma@st.com>, ST Microelectronics
+ * Borrowed heavily from the C_CAN driver originally written by:
+ * Copyright (C) 2007
+ * - Sascha Hauer, Marc Kleine-Budde, Pengutronix <s.hauer@pengutronix.de>
+ * - Simon Kallweit, intefo AG <simon.kallweit@intefo.ch>
+ *
+ * TX and RX NAPI implementation has been removed and replaced with RT Socket CAN implementation.
+ * RT Socket CAN implementation inspired by Flexcan RTDM port by Wolfgang Grandegger <wg@denx.de>
+ *
+ * Bosch C_CAN controller is compliant to CAN protocol version 2.0 part A and B.
+ * Bosch C_CAN user manual can be obtained from:
+ * http://www.semiconductors.bosch.de/media/en/pdf/ipmodules_1/c_can/
+ * users_manual_c_can.pdf
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+#include <linux/netdevice.h>
+#include <linux/if_arp.h>
+#include <linux/if_ether.h>
+#include <linux/list.h>
+#include <linux/io.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
+#include <linux/device.h>
+
+#include <rtdm/driver.h>
+
+/* CAN device profile */
+#include <rtdm/can.h>
+
+#include "rtcan_internal.h"
+#include "rtcan_dev.h"
+
+#include "rtcan_c_can.h"
+
+static char *board_name = "platform-c_can";
+
+#define DCAN_RAM_INIT_BIT		(1 << 3)
+static DEFINE_SPINLOCK(raminit_lock);
+/*
+ * 16-bit c_can registers can be arranged differently in the memory
+ * architecture of different implementations. For example: 16-bit
+ * registers can be aligned to a 16-bit boundary or 32-bit boundary etc.
+ * Handle the same by providing a common read/write interface.
+ */
+static u16 c_can_plat_read_reg_aligned_to_16bit(const struct c_can_priv *priv,
+						enum reg index)
+{
+	return readw(priv->base + priv->regs[index]);
+}
+
+static void c_can_plat_write_reg_aligned_to_16bit(const struct c_can_priv *priv,
+						  enum reg index, u16 val)
+{
+	writew(val, priv->base + priv->regs[index]);
+}
+
+static u16 c_can_plat_read_reg_aligned_to_32bit(const struct c_can_priv *priv,
+						enum reg index)
+{
+	return readw(priv->base + 2 * priv->regs[index]);
+}
+
+static void c_can_plat_write_reg_aligned_to_32bit(const struct c_can_priv *priv,
+						  enum reg index, u16 val)
+{
+	writew(val, priv->base + 2 * priv->regs[index]);
+}
+
+static void c_can_hw_raminit_wait_syscon(const struct c_can_priv *priv,
+					 u32 mask, u32 val)
+{
+	const struct c_can_raminit *raminit = &priv->raminit_sys;
+	int timeout = 0;
+	u32 ctrl = 0;
+
+	/* We look only at the bits of our instance. */
+	val &= mask;
+	do {
+		udelay(1);
+		timeout++;
+
+		regmap_read(raminit->syscon, raminit->reg, &ctrl);
+		if (timeout == 1000) {
+			dev_err(priv->device, "%s: time out\n", __func__);
+			break;
+		}
+	} while ((ctrl & mask) != val);
+}
+
+static void c_can_hw_raminit_syscon(const struct c_can_priv *priv, bool enable)
+{
+	const struct c_can_raminit *raminit = &priv->raminit_sys;
+	u32 ctrl = 0;
+	u32 mask;
+
+	spin_lock(&raminit_lock);
+
+	mask = 1 << raminit->bits.start | 1 << raminit->bits.done;
+	regmap_read(raminit->syscon, raminit->reg, &ctrl);
+
+	/* We clear the start bit first. The start bit is
+	 * looking at the 0 -> transition, but is not self clearing;
+	 * NOTE: DONE must be written with 1 to clear it.
+	 * We can't clear the DONE bit here using regmap_update_bits()
+	 * as it will bypass the write if initial condition is START:0 DONE:1
+	 * e.g. on DRA7 which needs START pulse.
+	 */
+	ctrl &= ~mask;		/* START = 0, DONE = 0 */
+	regmap_update_bits(raminit->syscon, raminit->reg, mask, ctrl);
+
+	/* check if START bit is 0. Ignore DONE bit for now
+	 * as it can be either 0 or 1.
+	 */
+	c_can_hw_raminit_wait_syscon(priv, 1 << raminit->bits.start, ctrl);
+
+	if (enable) {
+		/* Clear DONE bit & set START bit. */
+		ctrl |= 1 << raminit->bits.start;
+		/* DONE must be written with 1 to clear it */
+		ctrl |= 1 << raminit->bits.done;
+		regmap_update_bits(raminit->syscon, raminit->reg, mask, ctrl);
+		/* prevent further clearing of DONE bit */
+		ctrl &= ~(1 << raminit->bits.done);
+		/* clear START bit if start pulse is needed */
+		if (raminit->needs_pulse) {
+			ctrl &= ~(1 << raminit->bits.start);
+			regmap_update_bits(raminit->syscon, raminit->reg,
+					   mask, ctrl);
+		}
+
+		ctrl |= 1 << raminit->bits.done;
+		c_can_hw_raminit_wait_syscon(priv, mask, ctrl);
+	}
+	spin_unlock(&raminit_lock);
+}
+
+static u32 c_can_plat_read_reg32(const struct c_can_priv *priv, enum reg index)
+{
+	u32 val;
+
+	val = priv->read_reg(priv, index);
+	val |= ((u32) priv->read_reg(priv, index + 1)) << 16;
+
+	return val;
+}
+
+static void c_can_plat_write_reg32(const struct c_can_priv *priv,
+				   enum reg index, u32 val)
+{
+	priv->write_reg(priv, index + 1, val >> 16);
+	priv->write_reg(priv, index, val);
+}
+
+static u32 d_can_plat_read_reg32(const struct c_can_priv *priv, enum reg index)
+{
+	return readl(priv->base + priv->regs[index]);
+}
+
+static void d_can_plat_write_reg32(const struct c_can_priv *priv,
+				   enum reg index, u32 val)
+{
+	writel(val, priv->base + priv->regs[index]);
+}
+
+static void c_can_hw_raminit_wait(const struct c_can_priv *priv, u32 mask)
+{
+	while (priv->read_reg32(priv, C_CAN_FUNCTION_REG) & mask)
+		udelay(1);
+}
+
+static void c_can_hw_raminit(const struct c_can_priv *priv, bool enable)
+{
+	u32 ctrl;
+
+	ctrl = priv->read_reg32(priv, C_CAN_FUNCTION_REG);
+	ctrl &= ~DCAN_RAM_INIT_BIT;
+	priv->write_reg32(priv, C_CAN_FUNCTION_REG, ctrl);
+	c_can_hw_raminit_wait(priv, ctrl);
+
+	if (enable) {
+		ctrl |= DCAN_RAM_INIT_BIT;
+		priv->write_reg32(priv, C_CAN_FUNCTION_REG, ctrl);
+		c_can_hw_raminit_wait(priv, ctrl);
+	}
+}
+
+static const struct c_can_driver_data c_can_drvdata = {
+	.id = BOSCH_C_CAN,
+	.msg_obj_num = 32,
+};
+
+static const struct c_can_driver_data d_can_drvdata = {
+	.id = BOSCH_D_CAN,
+	.msg_obj_num = 32,
+};
+
+static const struct raminit_bits dra7_raminit_bits[] = {
+	[0] = {.start = 3, .done = 1, },
+	[1] = {.start = 5, .done = 2, },
+};
+
+static const struct c_can_driver_data dra7_dcan_drvdata = {
+	.id = BOSCH_D_CAN,
+	.msg_obj_num = 64,
+	.raminit_num = ARRAY_SIZE(dra7_raminit_bits),
+	.raminit_bits = dra7_raminit_bits,
+	.raminit_pulse = true,
+};
+
+static const struct raminit_bits am3352_raminit_bits[] = {
+	[0] = {.start = 0, .done = 8, },
+	[1] = {.start = 1, .done = 9, },
+};
+
+static const struct c_can_driver_data am3352_dcan_drvdata = {
+	.id = BOSCH_D_CAN,
+	.msg_obj_num = 64,
+	.raminit_num = ARRAY_SIZE(am3352_raminit_bits),
+	.raminit_bits = am3352_raminit_bits,
+};
+
+static const struct platform_device_id c_can_id_table[] = {
+	{
+	 .name = DRV_NAME,
+	 .driver_data = (kernel_ulong_t) &c_can_drvdata,
+	 },
+	{
+	 .name = "c_can",
+	 .driver_data = (kernel_ulong_t) &c_can_drvdata,
+	 },
+	{
+	 .name = "d_can",
+	 .driver_data = (kernel_ulong_t) &d_can_drvdata,
+	 },
+	{ /* sentinel */ },
+};
+
+MODULE_DEVICE_TABLE(platform, c_can_id_table);
+
+static const struct of_device_id c_can_of_table[] = {
+	{.compatible = "bosch,c_can", .data = &c_can_drvdata},
+	{.compatible = "bosch,d_can", .data = &d_can_drvdata},
+	{.compatible = "ti,dra7-d_can", .data = &dra7_dcan_drvdata},
+	{.compatible = "ti,am3352-d_can", .data = &am3352_dcan_drvdata},
+	{.compatible = "ti,am4372-d_can", .data = &am3352_dcan_drvdata},
+	{ /* sentinel */ },
+};
+
+MODULE_DEVICE_TABLE(of, c_can_of_table);
+
+static int c_can_plat_probe(struct platform_device *pdev)
+{
+	int ret;
+	void __iomem *addr;
+	struct rtcan_device *dev;
+	struct c_can_priv *priv;
+	const struct of_device_id *match;
+	struct resource *mem;
+	int irq;
+	struct clk *clk;
+	const struct c_can_driver_data *drvdata;
+	struct device_node *np = pdev->dev.of_node;
+
+	match = of_match_device(c_can_of_table, &pdev->dev);
+	if (match) {
+		drvdata = match->data;
+	} else if (pdev->id_entry->driver_data) {
+		drvdata = (struct c_can_driver_data *)
+		    platform_get_device_id(pdev)->driver_data;
+	} else {
+		return -ENODEV;
+	}
+
+	/* get the appropriate clk */
+	clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(clk)) {
+		ret = PTR_ERR(clk);
+		goto exit;
+	}
+
+	/* get the platform data */
+	irq = platform_get_irq(pdev, 0);
+	if (irq <= 0) {
+		ret = -ENODEV;
+		goto exit;
+	}
+
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	addr = devm_ioremap_resource(&pdev->dev, mem);
+	if (IS_ERR(addr)) {
+		ret = PTR_ERR(addr);
+		goto exit;
+	}
+
+	/* allocate the c_can device */
+	dev = rtcan_c_can_dev_alloc(drvdata->msg_obj_num);
+	if (!dev) {
+		ret = -ENOMEM;
+		goto exit;
+	}
+
+	priv = rtcan_priv(dev);
+	switch (drvdata->id) {
+	case BOSCH_C_CAN:
+		priv->regs = reg_map_c_can;
+		switch (mem->flags & IORESOURCE_MEM_TYPE_MASK) {
+		case IORESOURCE_MEM_32BIT:
+			priv->read_reg = c_can_plat_read_reg_aligned_to_32bit;
+			priv->write_reg = c_can_plat_write_reg_aligned_to_32bit;
+			priv->read_reg32 = c_can_plat_read_reg32;
+			priv->write_reg32 = c_can_plat_write_reg32;
+			break;
+		case IORESOURCE_MEM_16BIT:
+		default:
+			priv->read_reg = c_can_plat_read_reg_aligned_to_16bit;
+			priv->write_reg = c_can_plat_write_reg_aligned_to_16bit;
+			priv->read_reg32 = c_can_plat_read_reg32;
+			priv->write_reg32 = c_can_plat_write_reg32;
+			break;
+		}
+		break;
+	case BOSCH_D_CAN:
+		priv->regs = reg_map_d_can;
+		priv->read_reg = c_can_plat_read_reg_aligned_to_16bit;
+		priv->write_reg = c_can_plat_write_reg_aligned_to_16bit;
+		priv->read_reg32 = d_can_plat_read_reg32;
+		priv->write_reg32 = d_can_plat_write_reg32;
+
+		/* Check if we need custom RAMINIT via syscon. Mostly for TI
+		 * platforms. Only supported with DT boot.
+		 */
+		if (np && of_property_read_bool(np, "syscon-raminit")) {
+			u32 id;
+			struct c_can_raminit *raminit = &priv->raminit_sys;
+
+			ret = -EINVAL;
+			raminit->syscon = syscon_regmap_lookup_by_phandle(np,
+									  "syscon-raminit");
+			if (IS_ERR(raminit->syscon)) {
+				/* can fail with -EPROBE_DEFER */
+				ret = PTR_ERR(raminit->syscon);
+				goto exit_free_device;
+			}
+
+			if (of_property_read_u32_index(np, "syscon-raminit", 1,
+						       &raminit->reg)) {
+				dev_err(&pdev->dev,
+					"couldn't get the RAMINIT reg. offset!\n");
+				goto exit_free_device;
+			}
+
+			if (of_property_read_u32_index(np, "syscon-raminit", 2,
+						       &id)) {
+				dev_err(&pdev->dev,
+					"couldn't get the CAN instance ID\n");
+				goto exit_free_device;
+			}
+
+			if (id >= drvdata->raminit_num) {
+				dev_err(&pdev->dev,
+					"Invalid CAN instance ID\n");
+				goto exit_free_device;
+			}
+
+			raminit->bits = drvdata->raminit_bits[id];
+			raminit->needs_pulse = drvdata->raminit_pulse;
+
+			priv->raminit = c_can_hw_raminit_syscon;
+		} else {
+			priv->raminit = c_can_hw_raminit;
+		}
+		break;
+	default:
+		ret = -EINVAL;
+		goto exit_free_device;
+	}
+
+	priv->irq = irq;
+	priv->base = addr;
+	priv->device = &pdev->dev;
+	priv->priv = clk;
+	priv->type = drvdata->id;
+	platform_set_drvdata(pdev, dev);
+
+	dev->ctrl_name = drvdata->id == BOSCH_C_CAN ? "C_CAN" : "D_CAN";
+	dev->board_name = board_name;
+	dev->base_addr = (unsigned long)addr;
+	dev->can_sys_clock = clk_get_rate(clk);
+	dev->state = CAN_STATE_STOPPED;
+
+	/* Give device an interface name */
+	strncpy(dev->name, DEV_NAME, IFNAMSIZ);
+
+	ret = rtcan_c_can_register(dev);
+	if (ret) {
+		dev_err(&pdev->dev, "registering %s failed (err=%d)\n",
+			DRV_NAME, ret);
+		goto exit_free_device;
+	}
+
+	dev_info(&pdev->dev, "%s device registered (regs=%p, irq=%d)\n",
+		 DRV_NAME, priv->base, priv->irq);
+	return 0;
+
+exit_free_device:
+	rtcan_c_can_dev_free(dev);
+exit:
+	dev_err(&pdev->dev, "probe failed\n");
+
+	return ret;
+}
+
+static int c_can_plat_remove(struct platform_device *pdev)
+{
+	struct rtcan_device *dev = platform_get_drvdata(pdev);
+
+	rtcan_c_can_unregister(dev);
+	rtcan_c_can_dev_free(dev);
+	return 0;
+}
+
+static struct platform_driver c_can_plat_driver = {
+	.driver = {
+		   .name = DRV_NAME,
+		   .owner = THIS_MODULE,
+#ifdef CONFIG_OF
+		   .of_match_table = of_match_ptr(c_can_of_table),
+#endif
+		   },
+	.id_table = c_can_id_table,
+	.probe = c_can_plat_probe,
+	.remove = c_can_plat_remove,
+};
+
+module_platform_driver(c_can_plat_driver);
+
+MODULE_AUTHOR("Stephen J. Battazzo <stephen.j.battazzo@nasa.gov>");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("CAN bus RTDM driver for Bosch C_CAN controller");
-- 
2.17.1


