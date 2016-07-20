From: "Haydon, Andrew" <ahaydon@moog.com>
Date: Wed, 20 Jul 2016 14:10:27 +0000
Message-ID: <7d0df99eb5c44c1fb444a3d5642001bc@lujp1svwi090222.corp.mooginc.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] [RFC] [PATCH] Add C_CAN/D_CAN driver
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

I have updated the C_CAN patch submitted by Stephen Battazzo:
http://xenomai.org/pipermail/xenomai/2015-July/034690.html

This update is for Xenomai 3.0.x and also updates the driver to the one
used in Linux v3.18.20. I've also backported a couple of bug fixes from
later kernel versions. I haven't ported the PCI support because I have no
way of testing this.
The RTDM port is largely the same as in Stephen's patch.

I'm not sure whether my use of "rtdm_task_busy_sleep" is correct. The
Linux driver uses udelay here.

At the moment I have only done very limited testing on this driver in
Xenomai, but it seems to work OK as far as I have tested it so far. I do
know that the Linux driver works well for me using the D_CAN interface on
the Cyclone V.

Regards,
Andy


From: Andrew Haydon <ahaydon@moog.com>
Date: Wed, 20 Jul 2016 12:12:41 +0100
Subject: [PATCH] Add C_CAN/D_CAN driver

based on Linux v3.18.20 driver with 32-bit write modification
required for Cyclone V SoC. PCI support is not implemented in this
version. RTDM port is based on the work done by Stephen Battazzo.

Tested on Altera Cyclone V SoC.
---
 kernel/drivers/can/Kconfig                      |    1 +
 kernel/drivers/can/Makefile                     |    2 +-
 kernel/drivers/can/README                       |    1 +
 kernel/drivers/can/c_can/Kconfig                |    8 +
 kernel/drivers/can/c_can/Makefile               |    7 +
 kernel/drivers/can/c_can/README                 |    5 +
 kernel/drivers/can/c_can/rtcan_c_can.c          | 1298 +++++++++++++++++++=
++++
 kernel/drivers/can/c_can/rtcan_c_can.h          |  227 ++++
 kernel/drivers/can/c_can/rtcan_c_can_platform.c |  394 +++++++
 9 files changed, 1942 insertions(+), 1 deletion(-)
 create mode 100644 kernel/drivers/can/c_can/Kconfig
 create mode 100644 kernel/drivers/can/c_can/Makefile
 create mode 100644 kernel/drivers/can/c_can/README
 create mode 100644 kernel/drivers/can/c_can/rtcan_c_can.c
 create mode 100644 kernel/drivers/can/c_can/rtcan_c_can.h
 create mode 100644 kernel/drivers/can/c_can/rtcan_c_can_platform.c

diff --git a/kernel/drivers/can/Kconfig b/kernel/drivers/can/Kconfig
index 33ca722..8ae967a 100644
--- a/kernel/drivers/can/Kconfig
+++ b/kernel/drivers/can/Kconfig
@@ -87,5 +87,6 @@ config XENO_DRIVERS_CAN_FLEXCAN

 source drivers/xenomai/can/mscan/Kconfig
 source drivers/xenomai/can/sja1000/Kconfig
+source drivers/xenomai/can/c_can/Kconfig

 endmenu
diff --git a/kernel/drivers/can/Makefile b/kernel/drivers/can/Makefile
index 36d125f..594ef51 100644
--- a/kernel/drivers/can/Makefile
+++ b/kernel/drivers/can/Makefile
@@ -1,7 +1,7 @@

 ccflags-y +=3D -Idrivers/xenomai/can

-obj-$(CONFIG_XENO_DRIVERS_CAN) +=3D xeno_can.o mscan/ sja1000/
+obj-$(CONFIG_XENO_DRIVERS_CAN) +=3D xeno_can.o mscan/ sja1000/ c_can/
 obj-$(CONFIG_XENO_DRIVERS_CAN_FLEXCAN) +=3D xeno_can_flexcan.o
 obj-$(CONFIG_XENO_DRIVERS_CAN_VIRT) +=3D xeno_can_virt.o

diff --git a/kernel/drivers/can/README b/kernel/drivers/can/README
index e345e8a..7891ad8 100644
--- a/kernel/drivers/can/README
+++ b/kernel/drivers/can/README
@@ -20,6 +20,7 @@ devices:
    SJA1000 PEAK parallel port Dongle
    SJA1000 IXXAT PCI card
    MSCAN for MPC5200 boards
+   C_CAN/D_CAN peripherals

 Utilities for RT-Socket-CAN are available in "src/utils/can".

diff --git a/kernel/drivers/can/c_can/Kconfig b/kernel/drivers/can/c_can/Kc=
onfig
new file mode 100644
index 0000000..a710b0e
--- /dev/null
+++ b/kernel/drivers/can/c_can/Kconfig
@@ -0,0 +1,8 @@
+config XENO_DRIVERS_CAN_CCAN
+depends on XENO_DRIVERS_CAN
+tristate "C-CAN/D_CAN driver"
+help
+
+This driver is for C_CAN or D_CAN based peripherals.
+
+
diff --git a/kernel/drivers/can/c_can/Makefile b/kernel/drivers/can/c_can/M=
akefile
new file mode 100644
index 0000000..92a0f81
--- /dev/null
+++ b/kernel/drivers/can/c_can/Makefile
@@ -0,0 +1,7 @@
+
+ccflags-y +=3D -Idrivers/xenomai/can -Idrivers/xenomai/can/c_can
+
+obj-$(CONFIG_XENO_DRIVERS_CAN_CCAN) +=3D xeno_can_c_can.o
+
+xeno_can_c_can-y :=3D rtcan_c_can.o rtcan_c_can_platform.o
+
diff --git a/kernel/drivers/can/c_can/README b/kernel/drivers/can/c_can/REA=
DME
new file mode 100644
index 0000000..6acb750
--- /dev/null
+++ b/kernel/drivers/can/c_can/README
@@ -0,0 +1,5 @@
+# xeno_d_can
+
+Driver for Bosch C_CAN and D_CAN peripherals ported to RTDM for use with X=
enomai.
+Based heavily on existing Linux (v3.18.20) driver for the same hardware. T=
ested on Altera Cycone V SoC.
+
diff --git a/kernel/drivers/can/c_can/rtcan_c_can.c b/kernel/drivers/can/c_=
can/rtcan_c_can.c
new file mode 100644
index 0000000..08e21fb
--- /dev/null
+++ b/kernel/drivers/can/c_can/rtcan_c_can.c
@@ -0,0 +1,1298 @@
+/*
+ * CAN bus driver for Bosch C_CAN and D_CAN controllers, ported to Xenomai=
 RTDM
+ *
+ * Andrew Haydon <ahaydon at moog.com>, Moog Inc
+ *
+ * based on original Xenomai port by:
+ *
+ * Stephen J. Battazzo <stephen.j.battazzo at nasa.gov>,
+ * MEI Services/NASA Ames Research Center
+ * Borrowed original driver from:
+ *
+ * Bhupesh Sharma <bhupesh.sharma at st.com>, ST Microelectronics
+ * Borrowed heavily from the C_CAN driver originally written by:
+ * Copyright (C) 2007
+ * - Sascha Hauer, Marc Kleine-Budde, Pengutronix <s.hauer at pengutronix.=
de>
+ * - Simon Kallweit, intefo AG <simon.kallweit at intefo.ch>
+ *
+ * TX and RX NAPI implementation has been removed and replaced with RT Soc=
ket CAN implementation.
+ * RT Socket CAN implementation inspired by Flexcan RTDM port by Wolfgang =
Grandegger <wg at denx.de>
+ *
+ * Bosch C_CAN controller is compliant to CAN protocol version 2.0 part A =
and B.
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
+#include <linux/pm_runtime.h>
+#include <linux/clk.h>
+#include <linux/platform_device.h>
+
+/* CAN device profile */
+#include <rtdm/can.h>
+#include "rtcan_dev.h"
+#include "rtcan_raw.h"
+#include "rtcan_internal.h"
+
+#include "rtcan_c_can.h"
+
+//borrowed this from linux/can/dev.h for now:
+#define CAN_MAX_DLC 8
+#define get_can_dlc(i)          (min_t(__u8, (i), CAN_MAX_DLC))
+
+/* Number of interface registers */
+#define IF_ENUM_REG_LEN11
+#define C_CAN_IFACE(reg, iface)(C_CAN_IF1_##reg + (iface) * IF_ENUM_REG_LE=
N)
+
+/* control extension register D_CAN specific */
+#define CONTROL_EX_PDRBIT(8)
+
+/* control register */
+#define CONTROL_TESTBIT(7)
+#define CONTROL_CCEBIT(6)
+#define CONTROL_DISABLE_ARBIT(5)
+#define CONTROL_ENABLE_AR(0 << 5)
+#define CONTROL_EIEBIT(3)
+#define CONTROL_SIEBIT(2)
+#define CONTROL_IEBIT(1)
+#define CONTROL_INITBIT(0)
+
+#define CONTROL_IRQMSK(CONTROL_EIE | CONTROL_IE | CONTROL_SIE)
+
+/* test register */
+#define TEST_RXBIT(7)
+#define TEST_TX1BIT(6)
+#define TEST_TX2BIT(5)
+#define TEST_LBACKBIT(4)
+#define TEST_SILENTBIT(3)
+#define TEST_BASICBIT(2)
+
+/* status register */
+#define STATUS_PDABIT(10)
+#define STATUS_BOFFBIT(7)
+#define STATUS_EWARNBIT(6)
+#define STATUS_EPASSBIT(5)
+#define STATUS_RXOKBIT(4)
+#define STATUS_TXOKBIT(3)
+
+/* error counter register */
+#define ERR_CNT_TEC_MASK0xff
+#define ERR_CNT_TEC_SHIFT0
+#define ERR_CNT_REC_SHIFT8
+#define ERR_CNT_REC_MASK(0x7f << ERR_CNT_REC_SHIFT)
+#define ERR_CNT_RP_SHIFT15
+#define ERR_CNT_RP_MASK(0x1 << ERR_CNT_RP_SHIFT)
+
+/* bit-timing register */
+#define BTR_BRP_MASK0x3f
+#define BTR_BRP_SHIFT0
+#define BTR_SJW_SHIFT6
+#define BTR_SJW_MASK(0x3 << BTR_SJW_SHIFT)
+#define BTR_TSEG1_SHIFT8
+#define BTR_TSEG1_MASK(0xf << BTR_TSEG1_SHIFT)
+#define BTR_TSEG2_SHIFT12
+#define BTR_TSEG2_MASK(0x7 << BTR_TSEG2_SHIFT)
+
+/* brp extension register */
+#define BRP_EXT_BRPE_MASK0x0f
+#define BRP_EXT_BRPE_SHIFT0
+
+/* IFx command request */
+#define IF_COMR_BUSYBIT(15)
+
+/* IFx command mask */
+#define IF_COMM_WRBIT(7)
+#define IF_COMM_MASKBIT(6)
+#define IF_COMM_ARBBIT(5)
+#define IF_COMM_CONTROLBIT(4)
+#define IF_COMM_CLR_INT_PNDBIT(3)
+#define IF_COMM_TXRQSTBIT(2)
+#define IF_COMM_CLR_NEWDATIF_COMM_TXRQST
+#define IF_COMM_DATAABIT(1)
+#define IF_COMM_DATABBIT(0)
+
+/* TX buffer setup */
+#define IF_COMM_TX(IF_COMM_ARB | IF_COMM_CONTROL | \
+ IF_COMM_TXRQST | \
+ IF_COMM_DATAA | IF_COMM_DATAB)
+
+/* For the low buffers we clear the interrupt bit, but keep newdat */
+#define IF_COMM_RCV_LOW(IF_COMM_MASK | IF_COMM_ARB | \
+ IF_COMM_CONTROL | IF_COMM_CLR_INT_PND | \
+ IF_COMM_DATAA | IF_COMM_DATAB)
+
+/* For the high buffers we clear the interrupt bit and newdat */
+#define IF_COMM_RCV_HIGH(IF_COMM_RCV_LOW | IF_COMM_CLR_NEWDAT)
+
+
+/* Receive setup of message objects */
+#define IF_COMM_RCV_SETUP(IF_COMM_MASK | IF_COMM_ARB | IF_COMM_CONTROL)
+
+/* Invalidation of message objects */
+#define IF_COMM_INVAL(IF_COMM_ARB | IF_COMM_CONTROL)
+
+/* IFx arbitration */
+#define IF_ARB_MSGVALBIT(31)
+#define IF_ARB_MSGXTDBIT(30)
+#define IF_ARB_TRANSMITBIT(29)
+
+/* IFx message control */
+#define IF_MCONT_NEWDATBIT(15)
+#define IF_MCONT_MSGLSTBIT(14)
+#define IF_MCONT_INTPNDBIT(13)
+#define IF_MCONT_UMASKBIT(12)
+#define IF_MCONT_TXIEBIT(11)
+#define IF_MCONT_RXIEBIT(10)
+#define IF_MCONT_RMTENBIT(9)
+#define IF_MCONT_TXRQSTBIT(8)
+#define IF_MCONT_EOBBIT(7)
+#define IF_MCONT_DLC_MASK0xf
+
+#define IF_MCONT_RCV(IF_MCONT_RXIE | IF_MCONT_UMASK)
+#define IF_MCONT_RCV_EOB(IF_MCONT_RCV | IF_MCONT_EOB)
+
+#define IF_MCONT_TX(IF_MCONT_TXIE | IF_MCONT_EOB)
+
+/*
+ * Use IF1 for RX and IF2 for TX
+ */
+#define IF_RX0
+#define IF_TX1
+
+/* status interrupt */
+#define CIR_STATUS_INTERRUPT0x8000
+#define CIR_INTERRUPT_ID0x00FF
+
+/* global interrupt masks */
+#define ENABLE_ALL_INTERRUPTS1
+#define DISABLE_ALL_INTERRUPTS0
+
+/* minimum timeout for checking BUSY status */
+#define MIN_TIMEOUT_VALUE6
+
+/* Wait for ~1 sec for INIT bit */
+#define INIT_WAIT_MS1000
+
+/* napi related */
+#define C_CAN_NAPI_WEIGHTC_CAN_MSG_OBJ_RX_NUM
+
+/* c_can lec values */
+enum c_can_lec_type {
+LEC_NO_ERROR =3D 0,
+LEC_STUFF_ERROR,
+LEC_FORM_ERROR,
+LEC_ACK_ERROR,
+LEC_BIT1_ERROR,
+LEC_BIT0_ERROR,
+LEC_CRC_ERROR,
+LEC_UNUSED,
+LEC_MASK =3D LEC_UNUSED,
+};
+
+/*
+ * c_can error types:
+ * Bus errors (BUS_OFF, ERROR_WARNING, ERROR_PASSIVE) are supported
+ */
+enum c_can_bus_error_types {
+C_CAN_NO_ERROR =3D 0,
+C_CAN_BUS_OFF,
+C_CAN_ERROR_WARNING,
+C_CAN_ERROR_PASSIVE,
+};
+
+struct can_bittiming_const c_can_bittiming_const =3D {
+.name =3D DRV_NAME,
+.tseg1_min =3D 2,/* Time segment 1 =3D prop_seg + phase_seg1 */
+.tseg1_max =3D 16,
+.tseg2_min =3D 1,/* Time segment 2 =3D phase_seg2 */
+.tseg2_max =3D 8,
+.sjw_max =3D 4,
+.brp_min =3D 1,
+.brp_max =3D 1024,/* 6-bit BRP field + 4-bit BRPE field*/
+.brp_inc =3D 1,
+};
+
+static inline void c_can_pm_runtime_enable(const struct c_can_priv *priv)
+{
+if (priv->device)
+pm_runtime_enable(priv->device);
+}
+
+static inline void c_can_pm_runtime_disable(const struct c_can_priv *priv)
+{
+if (priv->device)
+pm_runtime_disable(priv->device);
+}
+
+static inline void c_can_pm_runtime_get_sync(const struct c_can_priv *priv=
)
+{
+if (priv->device)
+pm_runtime_get_sync(priv->device);
+}
+
+static inline void c_can_pm_runtime_put_sync(const struct c_can_priv *priv=
)
+{
+if (priv->device)
+pm_runtime_put_sync(priv->device);
+}
+
+static inline void c_can_reset_ram(const struct c_can_priv *priv, bool ena=
ble)
+{
+if (priv->raminit)
+priv->raminit(priv, enable);
+}
+
+static void c_can_enable_all_interrupts(struct c_can_priv *priv,
+int enable)
+{
+unsigned int cntrl_save =3D priv->read_reg(priv,
+C_CAN_CTRL_REG);
+
+if (enable)
+cntrl_save |=3D (CONTROL_SIE | CONTROL_EIE | CONTROL_IE);
+else
+cntrl_save &=3D ~(CONTROL_EIE | CONTROL_IE | CONTROL_SIE);
+
+priv->write_reg(priv, C_CAN_CTRL_REG, cntrl_save);
+}
+
+static void c_can_obj_update(struct rtcan_device *dev, int iface, u32 cmd,=
 u32 obj)
+{
+struct c_can_priv *priv =3D rtcan_priv(dev);
+int cnt, reg =3D C_CAN_IFACE(COMREQ_REG, iface);
+
+priv->write_reg32(priv, reg, (cmd << 16) | obj);
+
+for (cnt =3D MIN_TIMEOUT_VALUE; cnt; cnt--) {
+if (!(priv->read_reg(priv, reg) & IF_COMR_BUSY))
+return;
+rtdm_task_busy_sleep(1000);
+}
+rtcandev_err(dev, "Updating object timed out\n");
+
+}
+
+static inline void c_can_object_get(struct rtcan_device *dev, int iface,
+    u32 obj, u32 cmd)
+{
+c_can_obj_update(dev, iface, cmd, obj);
+}
+
+static inline void c_can_object_put(struct rtcan_device *dev, int iface,
+    u32 obj, u32 cmd)
+{
+c_can_obj_update(dev, iface, cmd | IF_COMM_WR, obj);
+}
+
+/*
+ * Note: According to documentation clearing TXIE while MSGVAL is set
+ * is not allowed, but works nicely on C/DCAN. And that lowers the I/O
+ * load significantly.
+ */
+static void c_can_inval_tx_object(struct rtcan_device *dev, int iface, int=
 obj)
+{
+struct c_can_priv *priv =3D rtcan_priv(dev);
+
+priv->write_reg(priv, C_CAN_IFACE(MSGCTRL_REG, iface), 0);
+c_can_object_put(dev, iface, obj, IF_COMM_INVAL);
+}
+
+static void c_can_inval_msg_object(struct rtcan_device *dev, int iface, in=
t obj)
+{
+struct c_can_priv *priv =3D rtcan_priv(dev);
+
+priv->write_reg(priv, C_CAN_IFACE(ARB1_REG, iface), 0);
+priv->write_reg(priv, C_CAN_IFACE(ARB2_REG, iface), 0);
+c_can_inval_tx_object(dev, iface, obj);
+}
+
+static void c_can_setup_tx_object(struct rtcan_device *dev, int iface,
+  struct can_frame *frame, int idx)
+{
+struct c_can_priv *priv =3D rtcan_priv(dev);
+u16 ctrl =3D IF_MCONT_TX | frame->can_dlc;
+bool rtr =3D frame->can_id & CAN_RTR_FLAG;
+u32 arb =3D IF_ARB_MSGVAL;
+int i;
+
+if (frame->can_id & CAN_EFF_FLAG) {
+arb |=3D frame->can_id & CAN_EFF_MASK;
+arb |=3D IF_ARB_MSGXTD;
+} else {
+arb |=3D (frame->can_id & CAN_SFF_MASK) << 18;
+}
+
+if (!rtr)
+arb |=3D IF_ARB_TRANSMIT;
+
+/*
+ * If we change the DIR bit, we need to invalidate the buffer
+ * first, i.e. clear the MSGVAL flag in the arbiter.
+ */
+if (rtr !=3D (bool)test_bit(idx, &priv->tx_dir)) {
+u32 obj =3D idx + C_CAN_MSG_OBJ_TX_FIRST;
+
+c_can_inval_msg_object(dev, iface, obj);
+change_bit(idx, &priv->tx_dir);
+}
+
+priv->write_reg32(priv, C_CAN_IFACE(ARB1_REG, iface), arb);
+
+priv->write_reg(priv, C_CAN_IFACE(MSGCTRL_REG, iface), ctrl);
+
+if (priv->type =3D=3D BOSCH_D_CAN) {
+u32 data =3D 0, dreg =3D C_CAN_IFACE(DATA1_REG, iface);
+
+for (i =3D 0; i < frame->can_dlc; i +=3D 4, dreg +=3D 2) {
+data =3D (u32)frame->data[i];
+data |=3D (u32)frame->data[i + 1] << 8;
+data |=3D (u32)frame->data[i + 2] << 16;
+data |=3D (u32)frame->data[i + 3] << 24;
+priv->write_reg32(priv, dreg, data);
+}
+} else {
+for (i =3D 0; i < frame->can_dlc; i +=3D 2) {
+priv->write_reg(priv,
+C_CAN_IFACE(DATA1_REG, iface) + i / 2,
+frame->data[i] |
+(frame->data[i + 1] << 8));
+}
+}
+}
+
+static inline void c_can_activate_all_lower_rx_msg_obj(struct rtcan_device=
 *dev,
+       int iface)
+{
+int i;
+
+for (i =3D C_CAN_MSG_OBJ_RX_FIRST; i <=3D C_CAN_MSG_RX_LOW_LAST; i++)
+c_can_object_get(dev, iface, i, IF_COMM_CLR_NEWDAT);
+}
+
+static int c_can_handle_lost_msg_obj(struct rtcan_device *dev,
+     int iface, int objno, u32 ctrl)
+{
+struct c_can_priv *priv =3D rtcan_priv(dev);
+struct rtcan_skb skb;
+struct rtcan_rb_frame *cf =3D &skb.rb_frame;
+
+ctrl &=3D ~(IF_MCONT_MSGLST | IF_MCONT_INTPND | IF_MCONT_NEWDAT);
+priv->write_reg(priv, C_CAN_IFACE(MSGCTRL_REG, iface), ctrl);
+c_can_object_put(dev, iface, objno, IF_COMM_CONTROL);
+
+cf->can_id |=3D CAN_ERR_CRTL;
+cf->data[1] =3D CAN_ERR_CRTL_RX_OVERFLOW;
+
+rtcan_rcv(dev, &skb);
+
+return 1;
+}
+
+static int c_can_read_msg_object(struct rtcan_device *dev, int iface, u32 =
ctrl, struct rtcan_skb *skb)
+{
+struct c_can_priv *priv =3D rtcan_priv(dev);
+struct rtcan_rb_frame *frame =3D &skb->rb_frame;
+u32 arb, data;
+
+frame->can_dlc =3D get_can_dlc(ctrl & 0x0F);
+skb->rb_frame_size =3D EMPTY_RB_FRAME_SIZE + CAN_ERR_DLC;
+
+arb =3D priv->read_reg32(priv, C_CAN_IFACE(ARB1_REG, iface));
+
+if (arb & IF_ARB_MSGXTD)
+frame->can_id =3D (arb & CAN_EFF_MASK) | CAN_EFF_FLAG;
+else
+frame->can_id =3D (arb >> 18) & CAN_SFF_MASK;
+
+if (arb & IF_ARB_TRANSMIT) {
+frame->can_id |=3D CAN_RTR_FLAG;
+} else {
+int i, dreg =3D C_CAN_IFACE(DATA1_REG, iface);
+
+if (priv->type =3D=3D BOSCH_D_CAN) {
+for (i =3D 0; i < frame->can_dlc; i +=3D 4, dreg +=3D 2) {
+data =3D priv->read_reg32(priv, dreg);
+frame->data[i] =3D data;
+frame->data[i + 1] =3D data >> 8;
+frame->data[i + 2] =3D data >> 16;
+frame->data[i + 3] =3D data >> 24;
+}
+} else {
+for (i =3D 0; i < frame->can_dlc; i +=3D 2, dreg++) {
+data =3D priv->read_reg(priv, dreg);
+frame->data[i] =3D data;
+frame->data[i + 1] =3D data >> 8;
+}
+}
+}
+
+return 0;
+}
+
+static void c_can_setup_receive_object(struct rtcan_device *dev, int iface=
,
+       u32 obj, u32 mask, u32 id, u32 mcont)
+{
+struct c_can_priv *priv =3D rtcan_priv(dev);
+
+mask |=3D BIT(29);
+priv->write_reg32(priv, C_CAN_IFACE(MASK1_REG, iface), mask);
+
+id |=3D IF_ARB_MSGVAL;
+priv->write_reg32(priv, C_CAN_IFACE(ARB1_REG, iface), id);
+
+priv->write_reg(priv, C_CAN_IFACE(MSGCTRL_REG, iface), mcont);
+c_can_object_put(dev, iface, obj, IF_COMM_RCV_SETUP);
+}
+
+int c_can_start_xmit(struct rtcan_device *dev, struct can_frame *cf)
+{
+struct c_can_priv *priv =3D rtcan_priv(dev);
+u32 idx, obj;
+
+/*
+ * This is not a FIFO. C/D_CAN sends out the buffers
+ * prioritized. The lowest buffer number wins.
+ */
+idx =3D fls(atomic_read(&priv->tx_active));
+obj =3D idx + C_CAN_MSG_OBJ_TX_FIRST;
+
+/*
+ * Store the message in the interface . We must do this before we enable
+ * transmit as we might race against do_tx().
+ */
+c_can_setup_tx_object(dev, IF_TX, cf, idx);
+
+/* Update the active bits */
+atomic_add((1 << idx), &priv->tx_active);
+/* Start transmission */
+c_can_object_put(dev, IF_TX, obj, IF_COMM_TX);
+
+return 0;
+}
+
+static int c_can_wait_for_ctrl_init(struct rtcan_device *dev,
+    struct c_can_priv *priv, u32 init)
+{
+int retry =3D 0;
+
+while (init !=3D (priv->read_reg(priv, C_CAN_CTRL_REG) & CONTROL_INIT)) {
+udelay(10);
+if (retry++ > 1000) {
+rtcandev_err(dev, "CCTRL: set CONTROL_INIT failed\n");
+return -EIO;
+}
+}
+return 0;
+}
+
+int c_can_set_bittiming(struct rtcan_device *dev)
+{
+unsigned int reg_btr, reg_brpe, ctrl_save;
+u8 brp, brpe, sjw, tseg1, tseg2;
+u32 ten_bit_brp;
+struct c_can_priv *priv =3D rtcan_priv(dev);
+struct can_bittime *bt =3D &priv->bit_time;
+int res;
+
+/* c_can provides a 6-bit brp and 4-bit brpe fields */
+ten_bit_brp =3D bt->std.brp - 1;
+brp =3D ten_bit_brp & BTR_BRP_MASK;
+brpe =3D ten_bit_brp >> 6;
+
+sjw =3D bt->std.sjw - 1;
+tseg1 =3D bt->std.prop_seg + bt->std.phase_seg1 - 1;
+tseg2 =3D bt->std.phase_seg2 - 1;
+reg_btr =3D brp | (sjw << BTR_SJW_SHIFT) | (tseg1 << BTR_TSEG1_SHIFT) |
+(tseg2 << BTR_TSEG2_SHIFT);
+reg_brpe =3D brpe & BRP_EXT_BRPE_MASK;
+
+rtcandev_info(dev,
+"setting BTR=3D%04x BRPE=3D%04x\n", reg_btr, reg_brpe);
+
+ctrl_save =3D priv->read_reg(priv, C_CAN_CTRL_REG);
+ctrl_save &=3D ~CONTROL_INIT;
+priv->write_reg(priv, C_CAN_CTRL_REG, CONTROL_CCE | CONTROL_INIT);
+res =3D c_can_wait_for_ctrl_init(dev, priv, CONTROL_INIT);
+if (res)
+return res;
+
+priv->write_reg(priv, C_CAN_BTR_REG, reg_btr);
+priv->write_reg(priv, C_CAN_BRPEXT_REG, reg_brpe);
+priv->write_reg(priv, C_CAN_CTRL_REG, ctrl_save);
+
+return c_can_wait_for_ctrl_init(dev, priv, 0);
+}
+
+/*
+ * Configure C_CAN message objects for Tx and Rx purposes:
+ * C_CAN provides a total of 32 message objects that can be configured
+ * either for Tx or Rx purposes. Here the first 16 message objects are use=
d as
+ * a reception FIFO. The end of reception FIFO is signified by the EoB bit
+ * being SET. The remaining 16 message objects are kept aside for Tx purpo=
ses.
+ * See user guide document for further details on configuring message
+ * objects.
+ */
+static void c_can_configure_msg_objects(struct rtcan_device *dev)
+{
+int i;
+
+/* first invalidate all message objects */
+for (i =3D C_CAN_MSG_OBJ_RX_FIRST; i <=3D C_CAN_NO_OF_OBJECTS; i++)
+c_can_inval_msg_object(dev, IF_RX, i);
+
+/* setup receive message objects */
+for (i =3D C_CAN_MSG_OBJ_RX_FIRST; i < C_CAN_MSG_OBJ_RX_LAST; i++)
+c_can_setup_receive_object(dev, IF_RX, i, 0, 0, IF_MCONT_RCV);
+
+c_can_setup_receive_object(dev, IF_RX, C_CAN_MSG_OBJ_RX_LAST, 0, 0,
+   IF_MCONT_RCV_EOB);
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
+struct c_can_priv *priv =3D rtcan_priv(dev);
+
+/* enable automatic retransmission */
+priv->write_reg(priv, C_CAN_CTRL_REG, CONTROL_ENABLE_AR);
+
+if ((dev->ctrl_mode & CAN_CTRLMODE_LISTENONLY) &&
+    (dev->ctrl_mode & CAN_CTRLMODE_LOOPBACK)) {
+/* loopback + silent mode : useful for hot self-test */
+priv->write_reg(priv, C_CAN_CTRL_REG, CONTROL_TEST);
+priv->write_reg(priv, C_CAN_TEST_REG, TEST_LBACK | TEST_SILENT);
+} else if (dev->ctrl_mode & CAN_CTRLMODE_LOOPBACK) {
+/* loopback mode : useful for self-test function */
+priv->write_reg(priv, C_CAN_CTRL_REG, CONTROL_TEST);
+priv->write_reg(priv, C_CAN_TEST_REG, TEST_LBACK);
+} else if (dev->ctrl_mode & CAN_CTRLMODE_LISTENONLY) {
+/* silent mode : bus-monitoring mode */
+priv->write_reg(priv, C_CAN_CTRL_REG, CONTROL_TEST);
+priv->write_reg(priv, C_CAN_TEST_REG, TEST_SILENT);
+}
+
+/* configure message objects */
+c_can_configure_msg_objects(dev);
+
+/* set a `lec` value so that we can check for updates later */
+priv->write_reg(priv, C_CAN_STS_REG, LEC_UNUSED);
+
+/* Clear all internal status */
+atomic_set(&priv->tx_active, 0);
+priv->rxmasked =3D 0;
+priv->tx_dir =3D 0;
+
+/* set bittiming params */
+return c_can_set_bittiming(dev);
+}
+
+int c_can_save_bit_time(struct rtcan_device *dev,
+struct can_bittime *bt,
+rtdm_lockctx_t *lock_ctx)
+{
+struct c_can_priv *priv =3D rtcan_priv(dev);
+
+memcpy(&priv->bit_time, bt, sizeof(*bt));
+
+return 0;
+}
+
+static int c_can_mode_start(struct rtcan_device *dev, rtdm_lockctx_t *lock=
_ctx)
+{
+struct c_can_priv *priv =3D rtcan_priv(dev);
+int err =3D 0;
+
+rtdm_lock_put_irqrestore(&dev->device_lock, *lock_ctx);
+
+switch (dev->state) {
+
+case CAN_STATE_ACTIVE:
+case CAN_STATE_BUS_WARNING:
+case CAN_STATE_BUS_PASSIVE:
+break;
+
+case CAN_STATE_STOPPED:
+/* Register IRQ handler and pass device structure as arg */
+
+err =3D rtdm_irq_request(&dev->irq_handle, priv->irq,
+       c_can_interrupt, 0, DRV_NAME,
+       (void *)dev);
+if (err) {
+ rtcandev_err(dev, "couldn't request irq %d\n",priv->irq);
+goto out;
+}
+
+c_can_pm_runtime_get_sync(priv);
+c_can_reset_ram(priv, true);
+
+/* start chip and queuing */
+err =3D c_can_chip_config(dev);
+if (err)
+goto out_irq_free;
+
+/* Setup the command for new messages */
+priv->comm_rcv_high =3D priv->type !=3D BOSCH_D_CAN ?
+IF_COMM_RCV_LOW : IF_COMM_RCV_HIGH;
+
+dev->state =3D CAN_STATE_ERROR_ACTIVE;
+
+/* reset tx helper pointers */
+priv->tx_next =3D priv->tx_echo =3D 0;
+
+/* enable status change, error and module interrupts */
+c_can_enable_all_interrupts(priv, ENABLE_ALL_INTERRUPTS);
+
+/* Set up sender "mutex" */
+rtdm_sem_init(&dev->tx_sem, C_CAN_MSG_OBJ_TX_NUM);
+
+break;
+
+case CAN_STATE_BUS_OFF:
+/* Set up sender "mutex" */
+rtdm_sem_init(&dev->tx_sem, C_CAN_MSG_OBJ_TX_NUM);
+/* start chip and queuing */
+c_can_pm_runtime_get_sync(priv);
+c_can_reset_ram(priv, true);
+err =3D c_can_chip_config(dev);
+if (err)
+goto out_put_sync;
+
+dev->state =3D CAN_STATE_ERROR_ACTIVE;
+/* reset tx helper pointers */
+priv->tx_next =3D priv->tx_echo =3D 0;
+/* enable status change, error and module interrupts */
+c_can_enable_all_interrupts(priv, ENABLE_ALL_INTERRUPTS);
+break;
+
+case CAN_STATE_SLEEPING:
+default:
+/* Never reached, but we don't want nasty compiler warnings ... */
+err =3D 0;
+break;
+}
+
+goto out;
+
+out_irq_free:
+rtdm_irq_free(&dev->irq_handle);
+out_put_sync:
+c_can_pm_runtime_put_sync(priv);
+out:
+rtdm_lock_get_irqsave(&dev->device_lock, *lock_ctx);
+
+return err;
+}
+
+static void c_can_mode_stop(struct rtcan_device *dev, rtdm_lockctx_t *lock=
_ctx)
+{
+struct c_can_priv *priv =3D rtcan_priv(dev);
+can_state_t state;
+
+state =3D dev->state;
+/* If controller is not operating anyway, go out */
+if (!CAN_STATE_OPERATING(state))
+return;
+
+/*
+ * Drop the device lock early, we should not need it and we
+ * may not hold it for calling the regular kernel
+ * infrastructure.
+ */
+rtdm_lock_put_irqrestore(&dev->device_lock, *lock_ctx);
+
+/* disable all interrupts */
+c_can_enable_all_interrupts(priv, DISABLE_ALL_INTERRUPTS);
+
+/* set the state as STOPPED */
+dev->state =3D CAN_STATE_STOPPED;
+
+/* Wake up waiting senders */
+rtdm_sem_destroy(&dev->tx_sem);
+
+rtdm_irq_free(&dev->irq_handle);
+c_can_pm_runtime_put_sync(priv);
+
+rtdm_lock_get_irqsave(&dev->device_lock, *lock_ctx);
+}
+
+
+int c_can_set_mode(struct rtcan_device *dev, can_mode_t mode, rtdm_lockctx=
_t *lock_ctx)
+{
+int err =3D 0;
+
+switch (mode) {
+
+case CAN_MODE_STOP:
+c_can_mode_stop(dev, lock_ctx);
+break;
+
+case CAN_MODE_START:
+err =3D c_can_mode_start(dev, lock_ctx);
+break;
+
+case CAN_MODE_SLEEP:
+default:
+err =3D -EOPNOTSUPP;
+break;
+}
+
+return err;
+}
+
+static void c_can_do_tx(struct rtcan_device *dev)
+{
+struct c_can_priv *priv =3D rtcan_priv(dev);
+u32 idx, obj, pend, clr;
+
+clr =3D pend =3D priv->read_reg(priv, C_CAN_INTPND2_REG);
+
+while ((idx =3D ffs(pend))) {
+idx--;
+pend &=3D ~(1 << idx);
+obj =3D idx + C_CAN_MSG_OBJ_TX_FIRST;
+c_can_inval_tx_object(dev, IF_RX, obj);
+}
+
+/* Clear the bits in the tx_active mask */
+atomic_sub(clr, &priv->tx_active);
+
+/* Wake up a sender */
+if (clr & (1 << (C_CAN_MSG_OBJ_TX_NUM - 1)))
+rtdm_sem_up(&dev->tx_sem);
+}
+
+/*
+ * If we have a gap in the pending bits, that means we either
+ * raced with the hardware or failed to readout all upper
+ * objects in the last run due to quota limit.
+ */
+static u32 c_can_adjust_pending(u32 pend)
+{
+u32 weight, lasts;
+
+if (pend =3D=3D RECEIVE_OBJECT_BITS)
+return pend;
+
+/*
+ * If the last set bit is larger than the number of pending
+ * bits we have a gap.
+ */
+weight =3D hweight32(pend);
+lasts =3D fls(pend);
+
+/* If the bits are linear, nothing to do */
+if (lasts =3D=3D weight)
+return pend;
+
+/*
+ * Find the first set bit after the gap. We walk backwards
+ * from the last set bit.
+ */
+for (lasts--; pend & (1 << (lasts - 1)); lasts--);
+
+return pend & ~((1 << lasts) - 1);
+}
+
+static inline void c_can_rx_object_get(struct rtcan_device *dev,
+       struct c_can_priv *priv, u32 obj)
+{
+c_can_object_get(dev, IF_RX, obj, priv->comm_rcv_high);
+}
+
+static inline void c_can_rx_finalize(struct rtcan_device *dev,
+     struct c_can_priv *priv, u32 obj)
+{
+if (priv->type !=3D BOSCH_D_CAN)
+c_can_object_get(dev, IF_RX, obj, IF_COMM_CLR_NEWDAT);
+}
+
+static void c_can_read_objects(struct rtcan_device *dev, struct c_can_priv=
 *priv,
+      u32 pend)
+{
+u32 ctrl, obj;
+struct rtcan_skb skb;
+
+while ((obj =3D ffs(pend))) {
+pend &=3D ~BIT(obj - 1);
+
+c_can_rx_object_get(dev, priv, obj);
+ctrl =3D priv->read_reg(priv, C_CAN_IFACE(MSGCTRL_REG, IF_RX));
+
+if (ctrl & IF_MCONT_MSGLST) {
+c_can_handle_lost_msg_obj(dev, IF_RX, obj, ctrl);
+continue;
+}
+
+/*
+ * This really should not happen, but this covers some
+ * odd HW behaviour. Do not remove that unless you
+ * want to brick your machine.
+ */
+if (!(ctrl & IF_MCONT_NEWDAT))
+continue;
+
+/* read the data from the message object */
+c_can_read_msg_object(dev, IF_RX, ctrl, &skb);
+
+c_can_rx_finalize(dev, priv, obj);
+
+rtcan_rcv(dev, &skb);
+}
+}
+
+static inline u32 c_can_get_pending(struct c_can_priv *priv)
+{
+u32 pend =3D priv->read_reg(priv, C_CAN_NEWDAT1_REG);
+
+return pend;
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
+static void c_can_do_rx_poll(struct rtcan_device *dev)
+{
+struct c_can_priv *priv =3D rtcan_priv(dev);
+u32 pend =3D 0, toread;
+u8i;
+
+/*
+ * It is faster to read only one 16bit register. This is only possible
+ * for a maximum number of 16 objects.
+ */
+BUILD_BUG_ON_MSG(C_CAN_MSG_OBJ_RX_LAST > 16,
+"Implementation does not support more message objects than 16");
+
+/* do this up to 2 times to handle gaps that could be caused by a race
+ * with h/w
+ */
+i =3D 2;
+while (i--) {
+if (!pend) {
+pend =3D c_can_get_pending(priv);
+if (!pend)
+return;
+/*
+ * If the pending field has a gap, handle the
+ * bits above the gap first.
+ */
+toread =3D c_can_adjust_pending(pend);
+} else {
+toread =3D pend;
+}
+/* Remove the bits from pend */
+pend &=3D ~toread;
+/* Read the objects */
+c_can_read_objects(dev, priv, toread);
+}
+}
+
+static int c_can_handle_state_change(struct rtcan_device *dev,
+enum c_can_bus_error_types error_type)
+{
+unsigned int reg_err_counter;
+u8 txerr;
+u8 rxerr;
+unsigned int rx_err_passive;
+struct c_can_priv *priv =3D rtcan_priv(dev);
+struct rtcan_skb skb;
+struct rtcan_rb_frame *cf =3D &skb.rb_frame;
+
+switch (error_type) {
+case C_CAN_ERROR_WARNING:
+/* error warning state */
+skb.rb_frame_size =3D EMPTY_RB_FRAME_SIZE + CAN_ERR_DLC;
+dev->state =3D CAN_STATE_ERROR_WARNING;
+break;
+case C_CAN_ERROR_PASSIVE:
+/* error passive state */
+skb.rb_frame_size =3D EMPTY_RB_FRAME_SIZE + CAN_ERR_DLC;
+dev->state =3D CAN_STATE_ERROR_PASSIVE;
+break;
+case C_CAN_BUS_OFF:
+/* bus-off state */
+skb.rb_frame_size =3D EMPTY_RB_FRAME_SIZE + CAN_ERR_DLC;
+break;
+default:
+break;
+}
+
+reg_err_counter =3D priv->read_reg(priv, C_CAN_ERR_CNT_REG);
+rxerr =3D (reg_err_counter & ERR_CNT_REC_MASK) >> ERR_CNT_REC_SHIFT;
+txerr =3D reg_err_counter & ERR_CNT_TEC_MASK;
+rx_err_passive =3D (reg_err_counter & ERR_CNT_RP_MASK) >>
+ERR_CNT_RP_SHIFT;
+
+switch (error_type) {
+case C_CAN_ERROR_WARNING:
+/* error warning state */
+cf->can_id |=3D CAN_ERR_CRTL;
+cf->data[1] =3D (txerr > rxerr) ?
+CAN_ERR_CRTL_TX_WARNING :
+CAN_ERR_CRTL_RX_WARNING;
+cf->data[6] =3D txerr;
+cf->data[7] =3D rxerr;
+
+break;
+case C_CAN_ERROR_PASSIVE:
+/* error passive state */
+cf->can_id |=3D CAN_ERR_CRTL;
+if (rx_err_passive)
+cf->data[1] |=3D CAN_ERR_CRTL_RX_PASSIVE;
+if (txerr > 127)
+cf->data[1] |=3D CAN_ERR_CRTL_TX_PASSIVE;
+
+cf->data[6] =3D txerr;
+cf->data[7] =3D rxerr;
+break;
+case C_CAN_BUS_OFF:
+/* bus-off state */
+cf->can_id |=3D CAN_ERR_BUSOFF;
+/* Wake up waiting senders */
+rtdm_sem_destroy(&dev->tx_sem);
+break;
+default:
+break;
+}
+
+rtcan_rcv(dev, &skb);
+
+return 1;
+}
+
+static int c_can_handle_bus_err(struct rtcan_device *dev,
+enum c_can_lec_type lec_type)
+{
+struct rtcan_skb skb;
+struct rtcan_rb_frame *cf =3D &skb.rb_frame;
+skb.rb_frame_size =3D EMPTY_RB_FRAME_SIZE + CAN_ERR_DLC;
+
+/*
+ * early exit if no lec update or no error.
+ * no lec update means that no CAN bus event has been detected
+ * since CPU wrote 0x7 value to status reg.
+ */
+if (lec_type =3D=3D LEC_UNUSED || lec_type =3D=3D LEC_NO_ERROR)
+return 0;
+
+/*
+ * check for 'last error code' which tells us the
+ * type of the last error to occur on the CAN bus
+ */
+cf->can_id |=3D CAN_ERR_PROT | CAN_ERR_BUSERROR;
+
+switch (lec_type) {
+case LEC_STUFF_ERROR:
+rtcandev_dbg(dev, "stuff error\n");
+cf->data[2] |=3D CAN_ERR_PROT_STUFF;
+break;
+case LEC_FORM_ERROR:
+rtcandev_dbg(dev, "form error\n");
+cf->data[2] |=3D CAN_ERR_PROT_FORM;
+break;
+case LEC_ACK_ERROR:
+rtcandev_dbg(dev, "ack error\n");
+cf->data[3] |=3D CAN_ERR_PROT_LOC_ACK;
+break;
+case LEC_BIT1_ERROR:
+rtcandev_dbg(dev, "bit1 error\n");
+cf->data[2] |=3D CAN_ERR_PROT_BIT1;
+break;
+case LEC_BIT0_ERROR:
+rtcandev_dbg(dev, "bit0 error\n");
+cf->data[2] |=3D CAN_ERR_PROT_BIT0;
+break;
+case LEC_CRC_ERROR:
+rtcandev_dbg(dev, "CRC error\n");
+cf->data[3] |=3D CAN_ERR_PROT_LOC_CRC_SEQ;
+break;
+default:
+break;
+}
+
+rtcan_rcv(dev, &skb);
+
+return 1;
+}
+
+int c_can_interrupt(rtdm_irq_t *irq_handle)
+{
+struct rtcan_device *dev =3D rtdm_irq_get_arg(irq_handle, void);
+struct c_can_priv *priv =3D rtcan_priv(dev);
+u16 irqstatus;
+int lec_type =3D 0;
+int recv_lock_free =3D 1;
+int ret =3D RTDM_IRQ_NONE;
+
+priv->irqstatus =3D priv->read_reg(priv, C_CAN_INT_REG);
+if (!priv->irqstatus) {
+return RTDM_IRQ_NONE;
+}
+
+c_can_enable_all_interrupts(priv, DISABLE_ALL_INTERRUPTS);
+rtdm_lock_get(&dev->device_lock);
+
+/* status events have the highest priority */
+if (priv->irqstatus =3D=3D CIR_STATUS_INTERRUPT) {
+priv->current_status =3D priv->read_reg(priv,
+C_CAN_STS_REG);
+
+/* handle Tx/Rx events */
+if (priv->current_status & STATUS_TXOK){
+priv->write_reg(priv, C_CAN_STS_REG,
+priv->current_status & ~STATUS_TXOK);
+}
+
+if (priv->current_status & STATUS_RXOK){
+priv->write_reg(priv, C_CAN_STS_REG,
+priv->current_status & ~STATUS_RXOK);
+}
+
+/* handle state changes */
+if ((priv->current_status & STATUS_EWARN) &&
+(!(priv->last_status & STATUS_EWARN))) {
+rtcandev_dbg(dev, "entered error warning state\n");
+c_can_handle_state_change(dev,C_CAN_ERROR_WARNING);
+if (recv_lock_free) {
+recv_lock_free =3D 0;
+rtdm_lock_get(&rtcan_recv_list_lock);
+rtdm_lock_get(&rtcan_socket_lock);
+}
+ret =3D RTDM_IRQ_HANDLED;
+}
+if ((priv->current_status & STATUS_EPASS) &&
+(!(priv->last_status & STATUS_EPASS))) {
+rtcandev_dbg(dev, "entered error passive state\n");
+c_can_handle_state_change(dev, C_CAN_ERROR_PASSIVE);
+if (recv_lock_free) {
+recv_lock_free =3D 0;
+rtdm_lock_get(&rtcan_recv_list_lock);
+rtdm_lock_get(&rtcan_socket_lock);
+}
+ret =3D RTDM_IRQ_HANDLED;
+}
+if ((priv->current_status & STATUS_BOFF) &&
+(!(priv->last_status & STATUS_BOFF))) {
+rtcandev_dbg(dev, "entered bus off state\n");
+c_can_handle_state_change(dev,C_CAN_BUS_OFF);
+if (recv_lock_free) {
+recv_lock_free =3D 0;
+rtdm_lock_get(&rtcan_recv_list_lock);
+rtdm_lock_get(&rtcan_socket_lock);
+}
+ret =3D RTDM_IRQ_HANDLED;
+}
+
+/* handle bus recovery events */
+if ((!(priv->current_status & STATUS_BOFF)) &&
+(priv->last_status & STATUS_BOFF)) {
+rtcandev_dbg(dev, "left bus off state\n");
+dev->state =3D CAN_STATE_ERROR_ACTIVE;
+ret =3D RTDM_IRQ_HANDLED;
+}
+if ((!(priv->current_status & STATUS_EPASS)) &&
+(priv->last_status & STATUS_EPASS)) {
+rtcandev_dbg(dev, "left error passive state\n");
+dev->state =3D CAN_STATE_ERROR_ACTIVE;
+ret =3D RTDM_IRQ_HANDLED;
+}
+
+priv->last_status =3D priv->current_status;
+
+/* handle lec errors on the bus */
+lec_type =3D (priv->current_status & LEC_UNUSED);
+if (lec_type) {
+c_can_handle_bus_err(dev, lec_type);
+
+if (recv_lock_free) {
+recv_lock_free =3D 0;
+rtdm_lock_get(&rtcan_recv_list_lock);
+rtdm_lock_get(&rtcan_socket_lock);
+}
+ret =3D RTDM_IRQ_HANDLED;
+}
+}
+
+irqstatus =3D priv->irqstatus & CIR_INTERRUPT_ID;
+if ((irqstatus >=3D C_CAN_MSG_OBJ_RX_FIRST) &&
+(irqstatus <=3D C_CAN_MSG_OBJ_RX_LAST)) {
+/* handle events corresponding to receive message objects */
+c_can_do_rx_poll(dev);
+
+if (recv_lock_free) {
+recv_lock_free =3D 0;
+rtdm_lock_get(&rtcan_recv_list_lock);
+rtdm_lock_get(&rtcan_socket_lock);
+}
+
+ret =3D RTDM_IRQ_HANDLED;
+
+}
+else if ((irqstatus >=3D C_CAN_MSG_OBJ_TX_FIRST) &&
+(irqstatus <=3D C_CAN_MSG_OBJ_TX_LAST)) {
+/* handle events corresponding to transmit message objects */
+c_can_do_tx(dev);
+
+if (rtcan_loopback_pending(dev)) {
+if (recv_lock_free) {
+recv_lock_free =3D 0;
+rtdm_lock_get(&rtcan_recv_list_lock);
+rtdm_lock_get(&rtcan_socket_lock);
+}
+rtcan_loopback(dev);
+}
+ret =3D RTDM_IRQ_HANDLED;
+}
+
+if (!recv_lock_free) {
+rtdm_lock_put(&rtcan_socket_lock);
+rtdm_lock_put(&rtcan_recv_list_lock);
+}
+rtdm_lock_put(&dev->device_lock);
+c_can_enable_all_interrupts(priv, ENABLE_ALL_INTERRUPTS);
+
+return ret;
+}
+
+struct rtcan_device *alloc_rtcan_c_can_dev(void)
+{
+struct rtcan_device *dev;
+struct c_can_priv *priv;
+
+dev =3D rtcan_dev_alloc(sizeof(struct c_can_priv), 0);
+if (!dev)
+return NULL;
+
+priv =3D rtcan_priv(dev);
+
+priv->dev =3D dev;
+return dev;
+}
+
+#ifdef CONFIG_PM
+int c_can_power_down(struct rtcan_device *dev)
+{
+u32 val;
+unsigned long time_out;
+struct c_can_priv *priv =3D rtcan_priv(dev);
+
+if (!(dev->flags & IFF_UP))
+return 0;
+
+WARN_ON(priv->type !=3D BOSCH_D_CAN);
+
+/* set PDR value so the device goes to power down mode */
+val =3D priv->read_reg(priv, C_CAN_CTRL_EX_REG);
+val |=3D CONTROL_EX_PDR;
+priv->write_reg(priv, C_CAN_CTRL_EX_REG, val);
+
+/* Wait for the PDA bit to get set */
+time_out =3D jiffies + msecs_to_jiffies(INIT_WAIT_MS);
+while (!(priv->read_reg(priv, C_CAN_STS_REG) & STATUS_PDA) &&
+time_after(time_out, jiffies))
+cpu_relax();
+
+if (time_after(jiffies, time_out))
+return -ETIMEDOUT;
+
+/* disable all interrupts */
+c_can_enable_all_interrupts(priv, DISABLE_ALL_INTERRUPTS);
+
+/* set the state as STOPPED */
+dev->state =3D CAN_STATE_STOPPED;
+
+c_can_reset_ram(priv, false);
+c_can_pm_runtime_put_sync(priv);
+
+return 0;
+}
+EXPORT_SYMBOL_GPL(c_can_power_down);
+
+int c_can_power_up(struct rtcan_device *dev)
+{
+u32 val;
+unsigned long time_out;
+struct c_can_priv *priv =3D rtcan_priv(dev);
+int ret;
+
+if (!(dev->flags & IFF_UP))
+return 0;
+
+WARN_ON(priv->type !=3D BOSCH_D_CAN);
+
+c_can_pm_runtime_get_sync(priv);
+c_can_reset_ram(priv, true);
+
+/* Clear PDR and INIT bits */
+val =3D priv->read_reg(priv, C_CAN_CTRL_EX_REG);
+val &=3D ~CONTROL_EX_PDR;
+priv->write_reg(priv, C_CAN_CTRL_EX_REG, val);
+val =3D priv->read_reg(priv, C_CAN_CTRL_REG);
+val &=3D ~CONTROL_INIT;
+priv->write_reg(priv, C_CAN_CTRL_REG, val);
+
+/* Wait for the PDA bit to get clear */
+time_out =3D jiffies + msecs_to_jiffies(INIT_WAIT_MS);
+while ((priv->read_reg(priv, C_CAN_STS_REG) & STATUS_PDA) &&
+time_after(time_out, jiffies))
+cpu_relax();
+
+if (time_after(jiffies, time_out))
+return -ETIMEDOUT;
+
+return ret;
+}
+EXPORT_SYMBOL_GPL(c_can_power_up);
+#endif
+
+int register_c_can_dev(struct rtcan_device *dev)
+{
+int err;
+struct c_can_priv *priv =3D rtcan_priv(dev);
+
+c_can_pm_runtime_enable(priv);
+
+err =3D rtcan_dev_register(dev);
+if (err)
+goto out_chip_disable;
+
+return 0;
+
+out_chip_disable:
+c_can_pm_runtime_disable(priv);
+
+return err;
+}
+
+void unregister_c_can_dev(struct rtcan_device *dev)
+{
+c_can_mode_stop(dev, NULL);
+rtcan_dev_unregister(dev);
+}
+
+
diff --git a/kernel/drivers/can/c_can/rtcan_c_can.h b/kernel/drivers/can/c_=
can/rtcan_c_can.h
new file mode 100644
index 0000000..e79b2e0
--- /dev/null
+++ b/kernel/drivers/can/c_can/rtcan_c_can.h
@@ -0,0 +1,227 @@
+/*
+ * CAN bus driver for Bosch C_CAN and D_CAN controllers, ported to Xenomai=
 RTDM
+ *
+ * Andrew Haydon <ahaydon at moog.com>, Moog Inc
+ *
+ * based on original Xenomai port by:
+ *
+ * Stephen J. Battazzo <stephen.j.battazzo at nasa.gov>,
+ * MEI Services/NASA Ames Research Center
+ * Borrowed original driver from:
+ *
+ * Bhupesh Sharma <bhupesh.sharma at st.com>, ST Microelectronics
+ * Borrowed heavily from the C_CAN driver originally written by:
+ * Copyright (C) 2007
+ * - Sascha Hauer, Marc Kleine-Budde, Pengutronix <s.hauer at pengutronix.=
de>
+ * - Simon Kallweit, intefo AG <simon.kallweit at intefo.ch>
+ *
+ * TX and RX NAPI implementation has been removed and replaced with RT Soc=
ket CAN implementation.
+ * RT Socket CAN implementation inspired by Flexcan RTDM port by Wolfgang =
Grandegger <wg at denx.de>
+ *
+ * Bosch C_CAN controller is compliant to CAN protocol version 2.0 part A =
and B.
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef RTCAN_C_CAN_H
+#define RTCAN_C_CAN_H
+
+/* message object split */
+#define C_CAN_NO_OF_OBJECTS32
+#define C_CAN_MSG_OBJ_RX_NUM16
+#define C_CAN_MSG_OBJ_TX_NUM16
+
+#define C_CAN_MSG_OBJ_RX_FIRST1
+#define C_CAN_MSG_OBJ_RX_LAST(C_CAN_MSG_OBJ_RX_FIRST + \
+C_CAN_MSG_OBJ_RX_NUM - 1)
+
+#define C_CAN_MSG_OBJ_TX_FIRST(C_CAN_MSG_OBJ_RX_LAST + 1)
+#define C_CAN_MSG_OBJ_TX_LAST(C_CAN_MSG_OBJ_TX_FIRST + \
+C_CAN_MSG_OBJ_TX_NUM - 1)
+
+#define C_CAN_MSG_OBJ_RX_SPLIT9
+#define C_CAN_MSG_RX_LOW_LAST(C_CAN_MSG_OBJ_RX_SPLIT - 1)
+#define RECEIVE_OBJECT_BITS0x0000ffff
+
+enum reg {
+C_CAN_CTRL_REG =3D 0,
+C_CAN_CTRL_EX_REG,
+C_CAN_STS_REG,
+C_CAN_ERR_CNT_REG,
+C_CAN_BTR_REG,
+C_CAN_INT_REG,
+C_CAN_TEST_REG,
+C_CAN_BRPEXT_REG,
+C_CAN_IF1_COMREQ_REG,
+C_CAN_IF1_COMMSK_REG,
+C_CAN_IF1_MASK1_REG,
+C_CAN_IF1_MASK2_REG,
+C_CAN_IF1_ARB1_REG,
+C_CAN_IF1_ARB2_REG,
+C_CAN_IF1_MSGCTRL_REG,
+C_CAN_IF1_DATA1_REG,
+C_CAN_IF1_DATA2_REG,
+C_CAN_IF1_DATA3_REG,
+C_CAN_IF1_DATA4_REG,
+C_CAN_IF2_COMREQ_REG,
+C_CAN_IF2_COMMSK_REG,
+C_CAN_IF2_MASK1_REG,
+C_CAN_IF2_MASK2_REG,
+C_CAN_IF2_ARB1_REG,
+C_CAN_IF2_ARB2_REG,
+C_CAN_IF2_MSGCTRL_REG,
+C_CAN_IF2_DATA1_REG,
+C_CAN_IF2_DATA2_REG,
+C_CAN_IF2_DATA3_REG,
+C_CAN_IF2_DATA4_REG,
+C_CAN_TXRQST1_REG,
+C_CAN_TXRQST2_REG,
+C_CAN_NEWDAT1_REG,
+C_CAN_NEWDAT2_REG,
+C_CAN_INTPND1_REG,
+C_CAN_INTPND2_REG,
+C_CAN_MSGVAL1_REG,
+C_CAN_MSGVAL2_REG,
+C_CAN_FUNCTION_REG,
+};
+
+static const u16 reg_map_c_can[] =3D {
+[C_CAN_CTRL_REG]=3D 0x00,
+[C_CAN_STS_REG]=3D 0x02,
+[C_CAN_ERR_CNT_REG]=3D 0x04,
+[C_CAN_BTR_REG]=3D 0x06,
+[C_CAN_INT_REG]=3D 0x08,
+[C_CAN_TEST_REG]=3D 0x0A,
+[C_CAN_BRPEXT_REG]=3D 0x0C,
+[C_CAN_IF1_COMREQ_REG]=3D 0x10,
+[C_CAN_IF1_COMMSK_REG]=3D 0x12,
+[C_CAN_IF1_MASK1_REG]=3D 0x14,
+[C_CAN_IF1_MASK2_REG]=3D 0x16,
+[C_CAN_IF1_ARB1_REG]=3D 0x18,
+[C_CAN_IF1_ARB2_REG]=3D 0x1A,
+[C_CAN_IF1_MSGCTRL_REG]=3D 0x1C,
+[C_CAN_IF1_DATA1_REG]=3D 0x1E,
+[C_CAN_IF1_DATA2_REG]=3D 0x20,
+[C_CAN_IF1_DATA3_REG]=3D 0x22,
+[C_CAN_IF1_DATA4_REG]=3D 0x24,
+[C_CAN_IF2_COMREQ_REG]=3D 0x40,
+[C_CAN_IF2_COMMSK_REG]=3D 0x42,
+[C_CAN_IF2_MASK1_REG]=3D 0x44,
+[C_CAN_IF2_MASK2_REG]=3D 0x46,
+[C_CAN_IF2_ARB1_REG]=3D 0x48,
+[C_CAN_IF2_ARB2_REG]=3D 0x4A,
+[C_CAN_IF2_MSGCTRL_REG]=3D 0x4C,
+[C_CAN_IF2_DATA1_REG]=3D 0x4E,
+[C_CAN_IF2_DATA2_REG]=3D 0x50,
+[C_CAN_IF2_DATA3_REG]=3D 0x52,
+[C_CAN_IF2_DATA4_REG]=3D 0x54,
+[C_CAN_TXRQST1_REG]=3D 0x80,
+[C_CAN_TXRQST2_REG]=3D 0x82,
+[C_CAN_NEWDAT1_REG]=3D 0x90,
+[C_CAN_NEWDAT2_REG]=3D 0x92,
+[C_CAN_INTPND1_REG]=3D 0xA0,
+[C_CAN_INTPND2_REG]=3D 0xA2,
+[C_CAN_MSGVAL1_REG]=3D 0xB0,
+[C_CAN_MSGVAL2_REG]=3D 0xB2,
+};
+
+static const u16 reg_map_d_can[] =3D {
+[C_CAN_CTRL_REG]=3D 0x00,
+[C_CAN_CTRL_EX_REG]=3D 0x02,
+[C_CAN_STS_REG]=3D 0x04,
+[C_CAN_ERR_CNT_REG]=3D 0x08,
+[C_CAN_BTR_REG]=3D 0x0C,
+[C_CAN_BRPEXT_REG]=3D 0x0E,
+[C_CAN_INT_REG]=3D 0x10,
+[C_CAN_TEST_REG]=3D 0x14,
+[C_CAN_FUNCTION_REG]=3D 0x18,
+[C_CAN_TXRQST1_REG]=3D 0x88,
+[C_CAN_TXRQST2_REG]=3D 0x8A,
+[C_CAN_NEWDAT1_REG]=3D 0x9C,
+[C_CAN_NEWDAT2_REG]=3D 0x9E,
+[C_CAN_INTPND1_REG]=3D 0xB0,
+[C_CAN_INTPND2_REG]=3D 0xB2,
+[C_CAN_MSGVAL1_REG]=3D 0xC4,
+[C_CAN_MSGVAL2_REG]=3D 0xC6,
+[C_CAN_IF1_COMREQ_REG]=3D 0x100,
+[C_CAN_IF1_COMMSK_REG]=3D 0x102,
+[C_CAN_IF1_MASK1_REG]=3D 0x104,
+[C_CAN_IF1_MASK2_REG]=3D 0x106,
+[C_CAN_IF1_ARB1_REG]=3D 0x108,
+[C_CAN_IF1_ARB2_REG]=3D 0x10A,
+[C_CAN_IF1_MSGCTRL_REG]=3D 0x10C,
+[C_CAN_IF1_DATA1_REG]=3D 0x110,
+[C_CAN_IF1_DATA2_REG]=3D 0x112,
+[C_CAN_IF1_DATA3_REG]=3D 0x114,
+[C_CAN_IF1_DATA4_REG]=3D 0x116,
+[C_CAN_IF2_COMREQ_REG]=3D 0x120,
+[C_CAN_IF2_COMMSK_REG]=3D 0x122,
+[C_CAN_IF2_MASK1_REG]=3D 0x124,
+[C_CAN_IF2_MASK2_REG]=3D 0x126,
+[C_CAN_IF2_ARB1_REG]=3D 0x128,
+[C_CAN_IF2_ARB2_REG]=3D 0x12A,
+[C_CAN_IF2_MSGCTRL_REG]=3D 0x12C,
+[C_CAN_IF2_DATA1_REG]=3D 0x130,
+[C_CAN_IF2_DATA2_REG]=3D 0x132,
+[C_CAN_IF2_DATA3_REG]=3D 0x134,
+[C_CAN_IF2_DATA4_REG]=3D 0x136,
+};
+
+enum c_can_dev_id {
+BOSCH_C_CAN_PLATFORM,
+BOSCH_C_CAN,
+BOSCH_D_CAN,
+};
+
+#define DEV_NAME"rtcan%d"
+#define DRV_NAME"c_can"
+
+/* c_can private data structure */
+struct c_can_priv {
+struct rtcan_device *dev;
+int irq;
+struct device *device;
+struct can_bittime bit_time;
+atomic_t tx_active;
+unsigned long tx_dir;
+int current_status;
+int last_status;
+u16 (*read_reg) (const struct c_can_priv *priv, enum reg index);
+void (*write_reg) (const struct c_can_priv *priv, enum reg index, u16 val)=
;
+u32 (*read_reg32) (const struct c_can_priv *priv, enum reg index);
+void (*write_reg32) (const struct c_can_priv *priv, enum reg index, u32 va=
l);
+void __iomem *base;
+const u16 *regs;
+unsigned int tx_next;
+unsigned int tx_echo;
+void *priv;/* for board-specific data */
+u16 irqstatus;
+enum c_can_dev_id type;
+u32 __iomem *raminit_ctrlreg;
+int instance;
+void (*raminit) (const struct c_can_priv *priv, bool enable);
+u32 comm_rcv_high;
+u32 rxmasked;
+u32 dlc[C_CAN_MSG_OBJ_TX_NUM];
+};
+
+struct rtcan_device *alloc_rtcan_c_can_dev(void);
+int register_c_can_dev(struct rtcan_device *dev);
+void unregister_c_can_dev(struct rtcan_device *dev);
+int c_can_interrupt(rtdm_irq_t *irq_handle);
+int c_can_start_xmit(struct rtcan_device *dev, struct can_frame *cf);
+int c_can_set_bittiming(struct rtcan_device *dev);
+int c_can_set_mode(struct rtcan_device *dev, can_mode_t mode, rtdm_lockctx=
_t *lock_ctx);
+int c_can_save_bit_time(struct rtcan_device *dev,
+struct can_bittime *bt,
+rtdm_lockctx_t *lock_ctx);
+extern struct can_bittiming_const c_can_bittiming_const;
+
+#ifdef CONFIG_PM
+int c_can_power_up(struct rtcan_device *dev);
+int c_can_power_down(struct rtcan_device *dev);
+#endif
+
+#endif /* C_CAN_H */
diff --git a/kernel/drivers/can/c_can/rtcan_c_can_platform.c b/kernel/drive=
rs/can/c_can/rtcan_c_can_platform.c
new file mode 100644
index 0000000..71f87b0
--- /dev/null
+++ b/kernel/drivers/can/c_can/rtcan_c_can_platform.c
@@ -0,0 +1,394 @@
+/*
+ * CAN bus driver for Bosch C_CAN and D_CAN controllers, ported to Xenomai=
 RTDM
+ *
+ * Andrew Haydon <ahaydon at moog.com>, Moog Inc
+ *
+ * based on original Xenomai port by:
+ *
+ * Stephen J. Battazzo <stephen.j.battazzo at nasa.gov>,
+ * MEI Services/NASA Ames Research Center
+ * Borrowed original driver from:
+ *
+ * Bhupesh Sharma <bhupesh.sharma at st.com>, ST Microelectronics
+ * Borrowed heavily from the C_CAN driver originally written by:
+ * Copyright (C) 2007
+ * - Sascha Hauer, Marc Kleine-Budde, Pengutronix <s.hauer at pengutronix.=
de>
+ * - Simon Kallweit, intefo AG <simon.kallweit at intefo.ch>
+ *
+ * TX and RX NAPI implementation has been removed and replaced with RT Soc=
ket CAN implementation.
+ * RT Socket CAN implementation inspired by Flexcan RTDM port by Wolfgang =
Grandegger <wg at denx.de>
+ *
+ * Bosch C_CAN controller is compliant to CAN protocol version 2.0 part A =
and B.
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
+
+#include <rtdm/can.h>
+#include "rtcan_internal.h"
+#include "rtcan_dev.h"
+
+#include "rtcan_c_can.h"
+
+static char *c_can_ctrl_name =3D "DCAN";
+
+#define CAN_RAMINIT_START_MASK(i)(0x001 << (i))
+#define CAN_RAMINIT_DONE_MASK(i)(0x100 << (i))
+#define CAN_RAMINIT_ALL_MASK(i)(0x101 << (i))
+#define DCAN_RAM_INIT_BIT(1 << 3)
+static DEFINE_SPINLOCK(raminit_lock);
+/*
+ * 16-bit c_can registers can be arranged differently in the memory
+ * architecture of different implementations. For example: 16-bit
+ * registers can be aligned to a 16-bit boundary or 32-bit boundary etc.
+ * Handle the same by providing a common read/write interface.
+ */
+static u16 c_can_plat_read_reg_aligned_to_16bit(const struct c_can_priv *p=
riv,
+enum reg index)
+{
+return readw(priv->base + priv->regs[index]);
+}
+
+static void c_can_plat_write_reg_aligned_to_16bit(const struct c_can_priv =
*priv,
+enum reg index, u16 val)
+{
+writew(val, priv->base + priv->regs[index]);
+}
+
+static u16 c_can_plat_read_reg_aligned_to_32bit(const struct c_can_priv *p=
riv,
+enum reg index)
+{
+return readw(priv->base + 2 * priv->regs[index]);
+}
+
+static void c_can_plat_write_reg_aligned_to_32bit(const struct c_can_priv =
*priv,
+enum reg index, u16 val)
+{
+writew(val, priv->base + 2 * priv->regs[index]);
+}
+
+static void c_can_hw_raminit_wait_ti(const struct c_can_priv *priv, u32 ma=
sk,
+  u32 val)
+{
+/* We look only at the bits of our instance. */
+val &=3D mask;
+while ((readl(priv->raminit_ctrlreg) & mask) !=3D val)
+udelay(1);
+}
+
+static void c_can_hw_raminit_ti(const struct c_can_priv *priv, bool enable=
)
+{
+u32 mask =3D CAN_RAMINIT_ALL_MASK(priv->instance);
+u32 ctrl;
+
+spin_lock(&raminit_lock);
+
+ctrl =3D readl(priv->raminit_ctrlreg);
+/* We clear the done and start bit first. The start bit is
+ * looking at the 0 -> transition, but is not self clearing;
+ * And we clear the init done bit as well.
+ */
+ctrl &=3D ~CAN_RAMINIT_START_MASK(priv->instance);
+ctrl |=3D CAN_RAMINIT_DONE_MASK(priv->instance);
+writel(ctrl, priv->raminit_ctrlreg);
+ctrl &=3D ~CAN_RAMINIT_DONE_MASK(priv->instance);
+c_can_hw_raminit_wait_ti(priv, mask, ctrl);
+
+if (enable) {
+/* Set start bit and wait for the done bit. */
+ctrl |=3D CAN_RAMINIT_START_MASK(priv->instance);
+writel(ctrl, priv->raminit_ctrlreg);
+ctrl |=3D CAN_RAMINIT_DONE_MASK(priv->instance);
+c_can_hw_raminit_wait_ti(priv, mask, ctrl);
+}
+spin_unlock(&raminit_lock);
+}
+
+static u32 c_can_plat_read_reg32(const struct c_can_priv *priv, enum reg i=
ndex)
+{
+u32 val;
+
+val =3D priv->read_reg(priv, index);
+val |=3D ((u32) priv->read_reg(priv, index + 1)) << 16;
+
+return val;
+}
+
+static void c_can_plat_write_reg32(const struct c_can_priv *priv, enum reg=
 index,
+u32 val)
+{
+priv->write_reg(priv, index + 1, val >> 16);
+priv->write_reg(priv, index, val);
+}
+
+static u32 d_can_plat_read_reg32(const struct c_can_priv *priv, enum reg i=
ndex)
+{
+return readl(priv->base + priv->regs[index]);
+}
+
+static void d_can_plat_write_reg32(const struct c_can_priv *priv, enum reg=
 index,
+u32 val)
+{
+writel(val, priv->base + priv->regs[index]);
+}
+
+static void c_can_hw_raminit_wait(const struct c_can_priv *priv, u32 mask)
+{
+while (priv->read_reg32(priv, C_CAN_FUNCTION_REG) & mask)
+udelay(1);
+}
+
+static void c_can_hw_raminit(const struct c_can_priv *priv, bool enable)
+{
+u32 ctrl;
+
+ctrl =3D priv->read_reg32(priv, C_CAN_FUNCTION_REG);
+ctrl &=3D ~DCAN_RAM_INIT_BIT;
+priv->write_reg32(priv, C_CAN_FUNCTION_REG, ctrl);
+c_can_hw_raminit_wait(priv, ctrl);
+
+if (enable) {
+ctrl |=3D DCAN_RAM_INIT_BIT;
+priv->write_reg32(priv, C_CAN_FUNCTION_REG, ctrl);
+c_can_hw_raminit_wait(priv, ctrl);
+}
+}
+
+static struct platform_device_id c_can_id_table[] =3D {
+[BOSCH_C_CAN_PLATFORM] =3D {
+.name =3D DRV_NAME,
+.driver_data =3D BOSCH_C_CAN,
+},
+[BOSCH_C_CAN] =3D {
+.name =3D "c_can",
+.driver_data =3D BOSCH_C_CAN,
+},
+[BOSCH_D_CAN] =3D {
+.name =3D "d_can",
+.driver_data =3D BOSCH_D_CAN,
+}, {
+}
+};
+MODULE_DEVICE_TABLE(platform, c_can_id_table);
+
+static const struct of_device_id c_can_of_table[] =3D {
+{ .compatible =3D "bosch,c_can", .data =3D &c_can_id_table[BOSCH_C_CAN] },
+{ .compatible =3D "bosch,d_can", .data =3D &c_can_id_table[BOSCH_D_CAN] },
+{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, c_can_of_table);
+
+static int c_can_plat_probe(struct platform_device *pdev)
+{
+int ret;
+void __iomem *addr;
+struct rtcan_device *dev;
+struct c_can_priv *priv;
+const struct of_device_id *match;
+const struct platform_device_id *id;
+struct resource *mem, *res;
+int irq;
+struct clk *clk;
+
+if (pdev->dev.of_node) {
+match =3D of_match_device(c_can_of_table, &pdev->dev);
+if (!match) {
+dev_err(&pdev->dev, "Failed to find matching dt id\n");
+ret =3D -EINVAL;
+goto exit;
+}
+id =3D match->data;
+} else {
+id =3D platform_get_device_id(pdev);
+}
+
+/* get the appropriate clk */
+clk =3D devm_clk_get(&pdev->dev, NULL);
+if (IS_ERR(clk)) {
+ret =3D PTR_ERR(clk);
+goto exit;
+}
+
+dev_info(&pdev->dev, "setting up step 1: platform_get_resource\n");
+
+/* get the platform data */
+irq =3D platform_get_irq(pdev, 0);
+if (irq <=3D 0) {
+ret =3D -ENODEV;
+goto exit;
+}
+
+mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+dev_info(&pdev->dev, "setting up step 2: ioremap. Start %x, size %d\n", me=
m->start, resource_size(mem));
+
+addr =3D devm_ioremap_resource(&pdev->dev, mem);
+if (IS_ERR(addr)) {
+ret =3D  PTR_ERR(addr);
+goto exit;
+}
+
+dev_info(&pdev->dev, "alloc dev...\n");
+
+/* allocate the c_can device */
+dev =3D alloc_rtcan_c_can_dev();
+if (!dev) {
+ret =3D -ENOMEM;
+goto exit;
+}
+
+priv =3D rtcan_priv(dev);
+switch (id->driver_data) {
+case BOSCH_C_CAN:
+priv->regs =3D reg_map_c_can;
+switch (mem->flags & IORESOURCE_MEM_TYPE_MASK) {
+case IORESOURCE_MEM_32BIT:
+priv->read_reg =3D c_can_plat_read_reg_aligned_to_32bit;
+priv->write_reg =3D c_can_plat_write_reg_aligned_to_32bit;
+priv->read_reg32 =3D c_can_plat_read_reg32;
+priv->write_reg32 =3D c_can_plat_write_reg32;
+break;
+case IORESOURCE_MEM_16BIT:
+default:
+priv->read_reg =3D c_can_plat_read_reg_aligned_to_16bit;
+priv->write_reg =3D c_can_plat_write_reg_aligned_to_16bit;
+priv->read_reg32 =3D c_can_plat_read_reg32;
+priv->write_reg32 =3D c_can_plat_write_reg32;
+break;
+}
+break;
+case BOSCH_D_CAN:
+priv->regs =3D reg_map_d_can;
+dev->ctrl_mode |=3D CAN_CTRLMODE_3_SAMPLES;
+priv->read_reg =3D c_can_plat_read_reg_aligned_to_16bit;
+priv->write_reg =3D c_can_plat_write_reg_aligned_to_16bit;
+priv->read_reg32 =3D d_can_plat_read_reg32;
+priv->write_reg32 =3D d_can_plat_write_reg32;
+
+if (pdev->dev.of_node)
+priv->instance =3D of_alias_get_id(pdev->dev.of_node, "d_can");
+else
+priv->instance =3D pdev->id;
+
+res =3D platform_get_resource(pdev, IORESOURCE_MEM, 1);
+/* Not all D_CAN modules have a separate register for the D_CAN
+ * RAM initialization. Use default RAM init bit in D_CAN module
+ * if not specified in DT.
+ */
+if (!res) {
+priv->raminit =3D c_can_hw_raminit;
+break;
+}
+
+dev_info(&pdev->dev, "devm request and ioremap..\n");
+
+priv->raminit_ctrlreg =3D devm_ioremap(&pdev->dev, res->start,
+     resource_size(res));
+if (!priv->raminit_ctrlreg || priv->instance < 0)
+dev_info(&pdev->dev, "control memory is not used for raminit\n");
+else
+priv->raminit =3D c_can_hw_raminit_ti;
+break;
+default:
+ret =3D -EINVAL;
+goto exit_free_device;
+}
+
+priv->irq =3D irq;
+priv->base =3D addr;
+priv->device =3D &pdev->dev;
+//priv->can.clock.freq =3D clk_get_rate(clk);
+priv->priv =3D clk;
+priv->type =3D id->driver_data;
+
+platform_set_drvdata(pdev, dev);
+
+dev->ctrl_name =3D c_can_ctrl_name;
+dev->board_name =3D c_can_ctrl_name;
+dev->base_addr =3D (unsigned long)addr;
+dev->can_sys_clock =3D clk_get_rate(clk);
+dev->hard_start_xmit =3D c_can_start_xmit;
+dev->do_set_mode =3D c_can_set_mode;
+dev->do_set_bit_time =3D c_can_save_bit_time;
+dev->bittiming_const =3D &c_can_bittiming_const;
+dev->state =3D CAN_STATE_STOPPED;
+
+/* Give device an interface name */
+strncpy(dev->name, DEV_NAME, IFNAMSIZ);
+
+ret =3D register_c_can_dev(dev);
+if (ret) {
+dev_err(&pdev->dev, "registering %s failed (err=3D%d)\n",
+DRV_NAME, ret);
+goto exit_free_device;
+}
+
+dev_info(&pdev->dev, "%s device registered (regs=3D%p, irq=3D%d)\n",
+ DRV_NAME, priv->base, priv->irq);
+return 0;
+
+exit_free_device:
+platform_set_drvdata(pdev, NULL);
+exit:
+dev_err(&pdev->dev, "probe failed\n");
+
+return ret;
+}
+
+static int c_can_plat_remove(struct platform_device *pdev)
+{
+struct rtcan_device *dev =3D platform_get_drvdata(pdev);
+struct c_can_priv *priv =3D rtcan_priv(dev);
+struct resource *mem;
+
+unregister_c_can_dev(dev);
+platform_set_drvdata(pdev, NULL);
+
+iounmap(priv->base);
+
+mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
+release_mem_region(mem->start, resource_size(mem));
+
+clk_put(priv->priv);
+
+rtcan_dev_free(dev);
+
+return 0;
+}
+
+#define c_can_suspend NULL
+#define c_can_resume NULL
+
+static struct platform_driver c_can_plat_driver =3D {
+.driver =3D {
+.name =3D DRV_NAME,
+.owner =3D THIS_MODULE,
+.of_match_table =3D c_can_of_table,
+},
+.probe =3D c_can_plat_probe,
+.remove =3D c_can_plat_remove,
+.suspend =3D c_can_suspend,
+.resume =3D c_can_resume,
+.id_table =3D c_can_id_table,
+};
+
+module_platform_driver(c_can_plat_driver);
+
+MODULE_AUTHOR("Andrew Haydon <ahaydon@moog.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Platform CAN bus driver for Bosch C_CAN controller");
--
1.9.1

Confidentiality Notice: This electronic mail transmission is intended for t=
he use of the individual or entity to which it is addressed and may contain=
 confidential and/or proprietary information belonging to the sender. If yo=
u are not the intended recipient, you are hereby notified that any disclosu=
re, use, copying, distribution, or the taking of any action in reliance on =
the contents of this information is strictly prohibited. If you have receiv=
ed this transmission in error, please notify the sender immediately by e-ma=
il and delete the original message. Thank you for your cooperation.

