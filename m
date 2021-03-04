From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH] RT-socket-CAN: Add support of PEAK PCAN-PCIe FD cards family
Date: Thu,  4 Mar 2021 14:45:40 +0100
Message-Id: <20210304134540.5246-1-s.grosjean@peak-system.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai mailing list <xenomai@xenomai.org>
Cc: Wolfgang Grandegger <wg@grandegger.com>, Jan Kiszka <kiszka@rts.uni-hannover.de>, Sebastian Smolorz <sebastian.smolorz@stud.uni-hannover.de>, Andy Tannenbaum <trb@bioniklabs.com>, Stephane Grosjean <s.grosjean@peak-system.com>

This patch includes the driver that supports the CANFD interfaces of
the PCAN-PCIe FD family. This driver is largely inspired by the peak_pciefd
driver included in the kernel since version 4.12. Except for the
differences related to the RTDM model, this driver differs from the
socket-CAN driver by the following points:

. CAN 2.0 a/b support only (CAN-FD not available in rt-socket-can)
. all interrupts are required (or released) when loading (or unloading)
  the module, not when activating (or deactivating) the CAN interface as in
  the socket-CAN model. Only hardware interruptions are enabled (or
  disabled) when the rtcan interface is set up (or down).
. This way of operating allows the usage of the MSI mode: if CONFIG_PCI_MSI
  is defined while CONFIG_XENO_OPT_SHIRQ is not, then the driver activates
  the MSI mode by default. The legacy INTA mode is used otherwise. In case
  CONFIG_PCI_MSI is defined, the parameter module "usemsi" allows to change
  this default behaviour: usemsi=0 selects INTA mode while usemsi=1 selects
  MSI mode.
. the Tx flow is managed more easily (no echo management in rt-socket-can)

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
Tested-by: Andy Tannenbaum <trb@bioniklabs.com>
---
 kernel/drivers/can/Kconfig                    |    1 +
 kernel/drivers/can/Makefile                   |    2 +-
 kernel/drivers/can/peak_canfd/Kconfig         |    7 +
 kernel/drivers/can/peak_canfd/Makefile        |    6 +
 .../drivers/can/peak_canfd/rtcan_peak_canfd.c |  632 ++++++++++
 .../can/peak_canfd/rtcan_peak_canfd_user.h    |   51 +
 .../can/peak_canfd/rtcan_peak_pciefd.c        | 1069 +++++++++++++++++
 7 files changed, 1767 insertions(+), 1 deletion(-)
 create mode 100644 kernel/drivers/can/peak_canfd/Kconfig
 create mode 100644 kernel/drivers/can/peak_canfd/Makefile
 create mode 100644 kernel/drivers/can/peak_canfd/rtcan_peak_canfd.c
 create mode 100644 kernel/drivers/can/peak_canfd/rtcan_peak_canfd_user.h
 create mode 100644 kernel/drivers/can/peak_canfd/rtcan_peak_pciefd.c

diff --git a/kernel/drivers/can/Kconfig b/kernel/drivers/can/Kconfig
index 0bbfcc9d1..1c055494d 100644
--- a/kernel/drivers/can/Kconfig
+++ b/kernel/drivers/can/Kconfig
@@ -86,6 +86,7 @@ config XENO_DRIVERS_CAN_FLEXCAN
 	Say Y here if you want to support for Freescale FlexCAN.
 
 source "drivers/xenomai/can/mscan/Kconfig"
+source "drivers/xenomai/can/peak_canfd/Kconfig"
 source "drivers/xenomai/can/sja1000/Kconfig"
 
 endmenu
diff --git a/kernel/drivers/can/Makefile b/kernel/drivers/can/Makefile
index 1c071b214..f78f6afdf 100644
--- a/kernel/drivers/can/Makefile
+++ b/kernel/drivers/can/Makefile
@@ -1,7 +1,7 @@
 
 ccflags-y += -I$(srctree)/drivers/xenomai/can
 
-obj-$(CONFIG_XENO_DRIVERS_CAN) += xeno_can.o mscan/ sja1000/
+obj-$(CONFIG_XENO_DRIVERS_CAN) += xeno_can.o mscan/ sja1000/ peak_canfd/
 obj-$(CONFIG_XENO_DRIVERS_CAN_FLEXCAN) += xeno_can_flexcan.o
 obj-$(CONFIG_XENO_DRIVERS_CAN_VIRT) += xeno_can_virt.o
 
diff --git a/kernel/drivers/can/peak_canfd/Kconfig b/kernel/drivers/can/peak_canfd/Kconfig
new file mode 100644
index 000000000..8537d73b4
--- /dev/null
+++ b/kernel/drivers/can/peak_canfd/Kconfig
@@ -0,0 +1,7 @@
+config XENO_DRIVERS_CAN_PEAK_CANFD
+	depends on XENO_DRIVERS_CAN && PCI
+	tristate "PEAK driver for PCAN-PCIe FD family"
+	default n
+	help
+
+	This driver supports the PCAN-PCIe FD boards family from PEAK-System.
diff --git a/kernel/drivers/can/peak_canfd/Makefile b/kernel/drivers/can/peak_canfd/Makefile
new file mode 100644
index 000000000..22670a9c4
--- /dev/null
+++ b/kernel/drivers/can/peak_canfd/Makefile
@@ -0,0 +1,6 @@
+#
+# Makefile for the PEAK-System CAN-FD IP module drivers
+#
+ccflags-y += -Idrivers/xenomai/can
+obj-$(CONFIG_XENO_DRIVERS_CAN_PEAK_CANFD) += xeno_can_peak_pciefd.o
+xeno_can_peak_pciefd-y := rtcan_peak_pciefd.o rtcan_peak_canfd.o
diff --git a/kernel/drivers/can/peak_canfd/rtcan_peak_canfd.c b/kernel/drivers/can/peak_canfd/rtcan_peak_canfd.c
new file mode 100644
index 000000000..bd20a5db6
--- /dev/null
+++ b/kernel/drivers/can/peak_canfd/rtcan_peak_canfd.c
@@ -0,0 +1,632 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * CANFD firmware interface.
+ *
+ * Copyright (C) 2001-2021 PEAK System-Technik GmbH
+ * Copyright (C) 2019-2021 Stephane Grosjean <s.grosjean@peak-system.com>
+ */
+#include "rtcan_dev.h"
+#include "rtcan_raw.h"
+#include "rtcan_peak_canfd_user.h"
+
+#define DRV_NAME               "xeno_peak_canfd"
+
+#define RTCAN_DEV_NAME          "rtcan%d"
+#define RTCAN_CTRLR_NAME       "peak_canfd"
+
+#ifndef CONFIG_XENO_DRIVERS_CAN_CALC_BITTIME_OLD
+/* bittiming ranges of the PEAK-System PC CAN-FD interfaces */
+static const struct can_bittiming_const peak_canfd_nominal_const = {
+	.name = RTCAN_CTRLR_NAME,
+	.tseg1_min = 1,
+	.tseg1_max = (1 << PUCAN_TSLOW_TSGEG1_BITS),
+	.tseg2_min = 1,
+	.tseg2_max = (1 << PUCAN_TSLOW_TSGEG2_BITS),
+	.sjw_max = (1 << PUCAN_TSLOW_SJW_BITS),
+	.brp_min = 1,
+	.brp_max = (1 << PUCAN_TSLOW_BRP_BITS),
+	.brp_inc = 1,
+};
+#endif
+
+/* initialize the command area */
+static struct peak_canfd_priv *pucan_init_cmd(struct peak_canfd_priv *priv)
+{
+	priv->cmd_len = 0;
+	return priv;
+}
+
+/* add command 'cmd_op' to the command area */
+static void *pucan_add_cmd(struct peak_canfd_priv *priv, int cmd_op)
+{
+	struct pucan_command *cmd;
+
+	if (priv->cmd_len + sizeof(*cmd) > priv->cmd_maxlen)
+		return NULL;
+
+	cmd = priv->cmd_buffer + priv->cmd_len;
+
+	/* reset all unused bit to default */
+	memset(cmd, 0, sizeof(*cmd));
+
+	cmd->opcode_channel = pucan_cmd_opcode_channel(priv->index, cmd_op);
+	priv->cmd_len += sizeof(*cmd);
+
+	return cmd;
+}
+
+/* send the command(s) to the IP core through the host-device interface */
+static int pucan_write_cmd(struct peak_canfd_priv *priv)
+{
+	int err;
+
+	/* prepare environment before writing the command */
+	if (priv->pre_cmd) {
+		err = priv->pre_cmd(priv);
+		if (err)
+			return err;
+	}
+
+	err = priv->write_cmd(priv);
+	if (err)
+		return err;
+
+	/* update environment after writing the command */
+	if (priv->post_cmd)
+		err = priv->post_cmd(priv);
+
+	return err;
+}
+
+/* set the device in RESET mode */
+static int pucan_set_reset_mode(struct peak_canfd_priv *priv)
+{
+	int err;
+
+	pucan_add_cmd(pucan_init_cmd(priv), PUCAN_CMD_RESET_MODE);
+	err = pucan_write_cmd(priv);
+	if (!err)
+		priv->rdev->state = CAN_STATE_STOPPED;
+
+	return err;
+}
+
+/* set the device in NORMAL mode */
+static int pucan_set_normal_mode(struct peak_canfd_priv *priv)
+{
+	int err;
+
+	pucan_add_cmd(pucan_init_cmd(priv), PUCAN_CMD_NORMAL_MODE);
+	err = pucan_write_cmd(priv);
+	if (!err)
+		priv->rdev->state = CAN_STATE_ERROR_ACTIVE;
+
+	return err;
+}
+
+/* set the device in LISTEN_ONLY mode */
+static int pucan_set_listen_only_mode(struct peak_canfd_priv *priv)
+{
+	int err;
+
+	pucan_add_cmd(pucan_init_cmd(priv), PUCAN_CMD_LISTEN_ONLY_MODE);
+	err = pucan_write_cmd(priv);
+	if (!err)
+		priv->rdev->state = CAN_STATE_ERROR_ACTIVE;
+
+	return err;
+}
+
+/* set acceptance filters */
+static int pucan_set_std_filter(struct peak_canfd_priv *priv, u8 row, u32 mask)
+{
+	struct pucan_std_filter *cmd;
+
+	cmd = pucan_add_cmd(pucan_init_cmd(priv), PUCAN_CMD_SET_STD_FILTER);
+
+	/* All the 11-bit CAN ID values are represented by one bit in a
+	 * 64 rows array of 32 columns: the upper 6 bit of the CAN ID select
+	 * the row while the lowest 5 bit select the column in that row.
+	 *
+	 * bit  filter
+	 * 1    passed
+	 * 0    discarded
+	 */
+
+	/* select the row */
+	cmd->idx = row;
+
+	/* set/unset bits in the row */
+	cmd->mask = cpu_to_le32(mask);
+
+	return pucan_write_cmd(priv);
+}
+
+/* request the device to stop transmission */
+static int pucan_tx_abort(struct peak_canfd_priv *priv, u16 flags)
+{
+	struct pucan_tx_abort *cmd;
+
+	cmd = pucan_add_cmd(pucan_init_cmd(priv), PUCAN_CMD_TX_ABORT);
+
+	cmd->flags = cpu_to_le16(flags);
+
+	return pucan_write_cmd(priv);
+}
+
+/* request the device to clear rx/tx error counters */
+static int pucan_clr_err_counters(struct peak_canfd_priv *priv)
+{
+	struct pucan_wr_err_cnt *cmd;
+
+	cmd = pucan_add_cmd(pucan_init_cmd(priv), PUCAN_CMD_WR_ERR_CNT);
+
+	cmd->sel_mask = cpu_to_le16(PUCAN_WRERRCNT_TE | PUCAN_WRERRCNT_RE);
+
+	/* write the counters new value */
+	cmd->tx_counter = 0;
+	cmd->rx_counter = 0;
+
+	return pucan_write_cmd(priv);
+}
+
+/* set options to the device */
+static int pucan_set_options(struct peak_canfd_priv *priv, u16 opt_mask)
+{
+	struct pucan_options *cmd;
+
+	cmd = pucan_add_cmd(pucan_init_cmd(priv), PUCAN_CMD_SET_EN_OPTION);
+
+	cmd->options = cpu_to_le16(opt_mask);
+
+	return pucan_write_cmd(priv);
+}
+
+/* request the device to notify the driver when Tx path is ready */
+static int pucan_setup_rx_barrier(struct peak_canfd_priv *priv)
+{
+	pucan_add_cmd(pucan_init_cmd(priv), PUCAN_CMD_RX_BARRIER);
+
+	return pucan_write_cmd(priv);
+}
+
+/* handle the reception of one CAN frame */
+static int pucan_handle_can_rx(struct peak_canfd_priv *priv,
+			       struct pucan_rx_msg *msg)
+{
+	struct rtcan_skb skb = { .rb_frame_size = EMPTY_RB_FRAME_SIZE, };
+	struct rtcan_rb_frame *cf = &skb.rb_frame;
+	struct rtcan_device *rdev = priv->rdev;
+	const u16 rx_msg_flags = le16_to_cpu(msg->flags);
+
+	if (rx_msg_flags & PUCAN_MSG_EXT_DATA_LEN) {
+		/* CAN-FD frames are silently discarded */
+		return 0;
+	}
+
+	cf->can_id = le32_to_cpu(msg->can_id);
+	cf->can_dlc = get_can_dlc(pucan_msg_get_dlc(msg));
+
+	if (rx_msg_flags & PUCAN_MSG_EXT_ID)
+		cf->can_id |= CAN_EFF_FLAG;
+
+	if (rx_msg_flags & PUCAN_MSG_RTR)
+		cf->can_id |= CAN_RTR_FLAG;
+	else {
+		memcpy(cf->data, msg->d, cf->can_dlc);
+		skb.rb_frame_size += cf->can_dlc;
+	}
+
+	cf->can_ifindex = rdev->ifindex;
+
+	/* Pass received frame out to the sockets */
+	rtcan_rcv(rdev, &skb);
+
+	return 0;
+}
+
+/* handle rx/tx error counters notification */
+static int pucan_handle_error(struct peak_canfd_priv *priv,
+			      struct pucan_error_msg *msg)
+{
+	priv->bec.txerr = msg->tx_err_cnt;
+	priv->bec.rxerr = msg->rx_err_cnt;
+
+	return 0;
+}
+
+/* handle status notification */
+static int pucan_handle_status(struct peak_canfd_priv *priv,
+			       struct pucan_status_msg *msg)
+{
+	struct rtcan_skb skb = { .rb_frame_size = EMPTY_RB_FRAME_SIZE, };
+	struct rtcan_rb_frame *cf = &skb.rb_frame;
+	struct rtcan_device *rdev = priv->rdev;
+
+	/* this STATUS is the CNF of the RX_BARRIER: Tx path can be setup */
+	if (pucan_status_is_rx_barrier(msg)) {
+		if (priv->enable_tx_path) {
+			int err = priv->enable_tx_path(priv);
+
+			if (err)
+				return err;
+		}
+
+		/* unlock senders */
+		rtdm_sem_up(&rdev->tx_sem);
+		return 0;
+	}
+
+	/* otherwise, it's a BUS status */
+	cf->can_id = CAN_ERR_FLAG;
+	cf->can_dlc = CAN_ERR_DLC;
+
+	/* test state error bits according to their priority */
+	if (pucan_status_is_busoff(msg)) {
+		rtdm_printk(DRV_NAME " CAN%u: Bus-off entry status\n",
+			    priv->index+1);
+		rdev->state = CAN_STATE_BUS_OFF;
+		cf->can_id |= CAN_ERR_BUSOFF;
+
+		/* wakeup waiting senders */
+		rtdm_sem_destroy(&rdev->tx_sem);
+
+	} else if (pucan_status_is_passive(msg)) {
+		rtdm_printk(DRV_NAME " CAN%u: Error passive status\n",
+			    priv->index+1);
+		rdev->state = CAN_STATE_ERROR_PASSIVE;
+		cf->can_id |= CAN_ERR_CRTL;
+		cf->data[1] = (priv->bec.txerr > priv->bec.rxerr) ?
+					CAN_ERR_CRTL_TX_PASSIVE :
+					CAN_ERR_CRTL_RX_PASSIVE;
+		cf->data[6] = priv->bec.txerr;
+		cf->data[7] = priv->bec.rxerr;
+
+	} else if (pucan_status_is_warning(msg)) {
+		rtdm_printk(DRV_NAME " CAN%u: Error warning status\n",
+			    priv->index+1);
+		rdev->state = CAN_STATE_ERROR_WARNING;
+
+		cf->can_id |= CAN_ERR_CRTL;
+		cf->data[1] = (priv->bec.txerr > priv->bec.rxerr) ?
+					CAN_ERR_CRTL_TX_WARNING :
+					CAN_ERR_CRTL_RX_WARNING;
+		cf->data[6] = priv->bec.txerr;
+		cf->data[7] = priv->bec.rxerr;
+
+	} else if (rdev->state != CAN_STATE_ERROR_ACTIVE) {
+		/* back to ERROR_ACTIVE */
+		rtdm_printk(DRV_NAME " CAN%u: Error active status\n",
+			    priv->index+1);
+		rdev->state = CAN_STATE_ERROR_ACTIVE;
+	}
+
+	skb.rb_frame_size += cf->can_dlc;
+	cf->can_ifindex = rdev->ifindex;
+
+	/* Pass received frame out to the sockets */
+	rtcan_rcv(rdev, &skb);
+
+	return 0;
+}
+
+/* handle IP core Rx overflow notification */
+static int pucan_handle_cache_critical(struct peak_canfd_priv *priv)
+{
+	struct rtcan_skb skb = { .rb_frame_size = EMPTY_RB_FRAME_SIZE, };
+	struct rtcan_rb_frame *cf = &skb.rb_frame;
+	struct rtcan_device *rdev = priv->rdev;
+
+	cf->can_id = CAN_ERR_FLAG | CAN_ERR_CRTL;
+	cf->can_dlc = CAN_ERR_DLC;
+
+	cf->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
+
+	cf->data[6] = priv->bec.txerr;
+	cf->data[7] = priv->bec.rxerr;
+
+	skb.rb_frame_size += cf->can_dlc;
+	cf->can_ifindex = rdev->ifindex;
+
+	/* Pass received frame out to the sockets */
+	rtcan_rcv(rdev, &skb);
+
+	return 0;
+}
+
+/* handle a single uCAN message */
+int peak_canfd_handle_msg(struct peak_canfd_priv *priv,
+			  struct pucan_rx_msg *msg)
+{
+	u16 msg_type = le16_to_cpu(msg->type);
+	int msg_size = le16_to_cpu(msg->size);
+	int err;
+
+	if (!msg_size || !msg_type) {
+		/* null packet found: end of list */
+		goto exit;
+	}
+
+	switch (msg_type) {
+	case PUCAN_MSG_CAN_RX:
+		err = pucan_handle_can_rx(priv, (struct pucan_rx_msg *)msg);
+		break;
+	case PUCAN_MSG_ERROR:
+		err = pucan_handle_error(priv, (struct pucan_error_msg *)msg);
+		break;
+	case PUCAN_MSG_STATUS:
+		err = pucan_handle_status(priv,
+					 (struct pucan_status_msg *)msg);
+		break;
+	case PUCAN_MSG_CACHE_CRITICAL:
+		err = pucan_handle_cache_critical(priv);
+		break;
+	default:
+		err = 0;
+	}
+
+	if (err < 0)
+		return err;
+
+exit:
+	return msg_size;
+}
+
+/* handle a list of rx_count messages from rx_msg memory address */
+int peak_canfd_handle_msgs_list(struct peak_canfd_priv *priv,
+				struct pucan_rx_msg *msg_list, int msg_count)
+{
+	void *msg_ptr = msg_list;
+	int i, msg_size = 0;
+
+	for (i = 0; i < msg_count; i++) {
+		msg_size = peak_canfd_handle_msg(priv, msg_ptr);
+
+		/* a null packet can be found at the end of a list */
+		if (msg_size <= 0)
+			break;
+
+		msg_ptr += ALIGN(msg_size, 4);
+	}
+
+	if (msg_size < 0)
+		return msg_size;
+
+	return i;
+}
+
+/* start the device (set the IP core in NORMAL or LISTEN-ONLY mode) */
+static int peak_canfd_start(struct rtcan_device *rdev,
+			    rtdm_lockctx_t *lock_ctx)
+{
+	struct peak_canfd_priv *priv = rdev->priv;
+	int i, err = 0;
+
+	switch (rdev->state) {
+	case CAN_STATE_BUS_OFF:
+	case CAN_STATE_STOPPED:
+		err = pucan_set_reset_mode(priv);
+		if (err)
+			break;
+
+		/* set ineeded option: get rx/tx error counters */
+		err = pucan_set_options(priv, PUCAN_OPTION_ERROR);
+		if (err)
+			break;
+
+		/* accept all standard CAN ID */
+		for (i = 0; i <= PUCAN_FLTSTD_ROW_IDX_MAX; i++)
+			pucan_set_std_filter(priv, i, 0xffffffff);
+
+		/* clear device rx/tx error counters */
+		err = pucan_clr_err_counters(priv);
+		if (err)
+			break;
+
+		/* set resquested mode */
+		if (priv->rdev->ctrl_mode & CAN_CTRLMODE_LISTENONLY)
+			err = pucan_set_listen_only_mode(priv);
+		else
+			err = pucan_set_normal_mode(priv);
+
+		rtdm_sem_init(&rdev->tx_sem, 1);
+
+		/* receiving the RB status says when Tx path is ready */
+		err = pucan_setup_rx_barrier(priv);
+		break;
+
+	default:
+		break;
+	}
+
+	return err;
+}
+
+/* stop the device (set the IP core in RESET mode) */
+static int peak_canfd_stop(struct rtcan_device *rdev,
+			   rtdm_lockctx_t *lock_ctx)
+{
+	struct peak_canfd_priv *priv = rdev->priv;
+	int err = 0;
+
+	switch (rdev->state) {
+	case CAN_STATE_BUS_OFF:
+	case CAN_STATE_STOPPED:
+		break;
+
+	default:
+		/* go back to RESET mode */
+		err = pucan_set_reset_mode(priv);
+		if (err) {
+			rtdm_printk(DRV_NAME " CAN%u: reset failed\n",
+				    priv->index+1);
+			break;
+		}
+
+		/* abort last Tx (MUST be done in RESET mode only!) */
+		pucan_tx_abort(priv, PUCAN_TX_ABORT_FLUSH);
+
+		rtdm_sem_destroy(&rdev->tx_sem);
+		break;
+	}
+
+	return err;
+}
+
+/* RT-Socket-CAN driver interface */
+static int peak_canfd_set_mode(struct rtcan_device *rdev, can_mode_t mode,
+			       rtdm_lockctx_t *lock_ctx)
+{
+	int err = 0;
+
+	switch (mode) {
+	case CAN_MODE_STOP:
+		err = peak_canfd_stop(rdev, lock_ctx);
+		break;
+	case CAN_MODE_START:
+		err = peak_canfd_start(rdev, lock_ctx);
+		break;
+	case CAN_MODE_SLEEP:
+		/* Controller must operate, otherwise go out */
+		if (!CAN_STATE_OPERATING(rdev->state)) {
+			err = -ENETDOWN;
+			break;
+		}
+		if (rdev->state == CAN_STATE_SLEEPING)
+			break;
+
+		/* fallthrough */
+	default:
+		err = -EOPNOTSUPP;
+		break;
+	}
+
+	return err;
+}
+
+static int peak_canfd_set_bittiming(struct rtcan_device *rdev,
+				    struct can_bittime *pbt,
+				    rtdm_lockctx_t *lock_ctx)
+{
+	struct peak_canfd_priv *priv = rdev->priv;
+	struct pucan_timing_slow *cmd;
+
+	/* can't support BTR0BTR1 mode with clock greater than 8 MHz */
+	if (pbt->type != CAN_BITTIME_STD) {
+		rtdm_printk(DRV_NAME
+			    " CAN%u: unsupported bittiming mode %u\n",
+			    priv->index+1, pbt->type);
+		return -EINVAL;
+	}
+
+	cmd = pucan_add_cmd(pucan_init_cmd(priv), PUCAN_CMD_TIMING_SLOW);
+
+	cmd->sjw_t = PUCAN_TSLOW_SJW_T(pbt->std.sjw - 1,
+				       priv->rdev->ctrl_mode &
+						CAN_CTRLMODE_3_SAMPLES);
+
+	cmd->tseg1 = PUCAN_TSLOW_TSEG1(pbt->std.prop_seg +
+				       pbt->std.phase_seg1 - 1);
+	cmd->tseg2 = PUCAN_TSLOW_TSEG2(pbt->std.phase_seg2 - 1);
+	cmd->brp = cpu_to_le16(PUCAN_TSLOW_BRP(pbt->std.brp - 1));
+
+	cmd->ewl = 96;	/* default */
+
+	rtdm_printk(DRV_NAME ": nominal: brp=%u tseg1=%u tseg2=%u sjw=%u\n",
+		   le16_to_cpu(cmd->brp), cmd->tseg1, cmd->tseg2, cmd->sjw_t);
+
+	return pucan_write_cmd(priv);
+}
+
+/* hard transmit callback: write the CAN frame to the device */
+static netdev_tx_t peak_canfd_start_xmit(struct rtcan_device *rdev,
+					 can_frame_t *cf)
+{
+	struct peak_canfd_priv *priv = rdev->priv;
+	struct pucan_tx_msg *msg;
+	u16 msg_size, msg_flags;
+	int room_left;
+	const u8 dlc = (cf->can_dlc > CAN_MAX_DLC) ? CAN_MAX_DLC : cf->can_dlc;
+
+	msg_size = ALIGN(sizeof(*msg) + dlc, 4);
+	msg = priv->alloc_tx_msg(priv, msg_size, &room_left);
+
+	/* should never happen except under bus-off condition and
+	 * (auto-)restart mechanism
+	 */
+	if (!msg) {
+		rtdm_printk(DRV_NAME
+			    " CAN%u: skb lost (No room left in tx buffer)\n",
+			    priv->index+1);
+		return 0;
+	}
+
+	msg->size = cpu_to_le16(msg_size);
+	msg->type = cpu_to_le16(PUCAN_MSG_CAN_TX);
+	msg_flags = 0;
+	if (cf->can_id & CAN_EFF_FLAG) {
+		msg_flags |= PUCAN_MSG_EXT_ID;
+		msg->can_id = cpu_to_le32(cf->can_id & CAN_EFF_MASK);
+	} else {
+		msg->can_id = cpu_to_le32(cf->can_id & CAN_SFF_MASK);
+	}
+
+	if (cf->can_id & CAN_RTR_FLAG)
+		msg_flags |= PUCAN_MSG_RTR;
+
+	/* set driver specific bit to differentiate with application
+	 * loopback
+	 */
+	if (rdev->ctrl_mode & CAN_CTRLMODE_LOOPBACK)
+		msg_flags |= PUCAN_MSG_LOOPED_BACK;
+
+	msg->flags = cpu_to_le16(msg_flags);
+	msg->channel_dlc = PUCAN_MSG_CHANNEL_DLC(priv->index, dlc);
+	memcpy(msg->d, cf->data, dlc);
+
+	/* write the skb on the interface */
+	priv->write_tx_msg(priv, msg);
+
+	/* control senders flow */
+	if (room_left > (sizeof(*msg) + CAN_MAX_DLC))
+		rtdm_sem_up(&rdev->tx_sem);
+
+	return 0;
+}
+
+/* allocate a rtcan device for channel #index, with enough space to store
+ * private information.
+ */
+struct rtcan_device *alloc_peak_canfd_dev(int sizeof_priv, int index)
+{
+	struct rtcan_device *rdev;
+	struct peak_canfd_priv *priv;
+
+	/* allocate the candev object */
+	rdev = rtcan_dev_alloc(sizeof_priv, 0);
+	if (!rdev)
+		return NULL;
+
+	/* RTCAN part initialization */
+	strncpy(rdev->name, RTCAN_DEV_NAME, IFNAMSIZ);
+	rdev->ctrl_name = RTCAN_CTRLR_NAME;
+	rdev->can_sys_clock = 80*1000*1000;	/* default */
+	rdev->state = CAN_STATE_STOPPED;
+	rdev->hard_start_xmit = peak_canfd_start_xmit;
+	rdev->do_set_mode = peak_canfd_set_mode;
+	rdev->do_set_bit_time = peak_canfd_set_bittiming;
+#ifndef CONFIG_XENO_DRIVERS_CAN_CALC_BITTIME_OLD
+	rdev->bittiming_const = &peak_canfd_nominal_const;
+#endif
+
+	priv = rdev->priv;
+
+	/* private part initialization */
+	priv->rdev = rdev;
+	priv->index = index;
+	priv->cmd_len = 0;
+	priv->bec.txerr = 0;
+	priv->bec.rxerr = 0;
+
+	return rdev;
+}
diff --git a/kernel/drivers/can/peak_canfd/rtcan_peak_canfd_user.h b/kernel/drivers/can/peak_canfd/rtcan_peak_canfd_user.h
new file mode 100644
index 000000000..1a70053e8
--- /dev/null
+++ b/kernel/drivers/can/peak_canfd/rtcan_peak_canfd_user.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * CAN driver for PEAK System micro-CAN based adapters.
+ *
+ * Copyright (C) 2001-2021 PEAK System-Technik GmbH
+ * Copyright (C) 2019-2021 Stephane Grosjean <s.grosjean@peak-system.com>
+ */
+#ifndef PEAK_CANFD_USER_H
+#define PEAK_CANFD_USER_H
+
+#include <linux/can/dev/peak_canfd.h>
+
+#define CAN_MAX_DLC            8
+#define get_can_dlc(i)         (min_t(__u8, (i), CAN_MAX_DLC))
+
+struct peak_berr_counter {
+	__u16 txerr;
+	__u16 rxerr;
+};
+
+/* data structure private to each uCAN interface */
+struct peak_canfd_priv {
+	struct rtcan_device *rdev;      /* RTCAN device */
+	int index;                      /* channel index */
+
+	struct peak_berr_counter bec;
+
+	int cmd_len;
+	void *cmd_buffer;
+	int cmd_maxlen;
+
+	int (*pre_cmd)(struct peak_canfd_priv *priv);
+	int (*write_cmd)(struct peak_canfd_priv *priv);
+	int (*post_cmd)(struct peak_canfd_priv *priv);
+
+	int (*enable_tx_path)(struct peak_canfd_priv *priv);
+	void *(*alloc_tx_msg)(struct peak_canfd_priv *priv, u16 msg_size,
+			      int *room_left);
+	int (*write_tx_msg)(struct peak_canfd_priv *priv,
+			    struct pucan_tx_msg *msg);
+};
+
+struct rtcan_device *alloc_peak_canfd_dev(int sizeof_priv, int index);
+void rtcan_peak_pciefd_remove_proc(struct rtcan_device *rdev);
+int rtcan_peak_pciefd_create_proc(struct rtcan_device *rdev);
+
+int peak_canfd_handle_msg(struct peak_canfd_priv *priv,
+			  struct pucan_rx_msg *msg);
+int peak_canfd_handle_msgs_list(struct peak_canfd_priv *priv,
+				struct pucan_rx_msg *rx_msg, int rx_count);
+#endif
diff --git a/kernel/drivers/can/peak_canfd/rtcan_peak_pciefd.c b/kernel/drivers/can/peak_canfd/rtcan_peak_pciefd.c
new file mode 100644
index 000000000..a40b0cd58
--- /dev/null
+++ b/kernel/drivers/can/peak_canfd/rtcan_peak_pciefd.c
@@ -0,0 +1,1069 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * CAN driver PCI interface.
+ *
+ * Copyright (C) 2001-2021 PEAK System-Technik GmbH
+ * Copyright (C) 2019-2021 Stephane Grosjean <s.grosjean@peak-system.com>
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+#include <linux/pci.h>
+#include <linux/io.h>
+
+#include <rtdm/driver.h>
+
+#include <rtdm/can.h>
+
+#include "rtcan_dev.h"
+#include "rtcan_raw.h"
+#include "rtcan_peak_canfd_user.h"
+
+#ifdef CONFIG_PCI_MSI
+#define PCIEFD_USES_MSI
+#endif
+
+#ifndef struct_size
+#define struct_size(p, member, n)      ((n)*sizeof(*(p)->member) + \
+					sizeof(*(p)))
+#endif
+
+#define DRV_NAME                       "xeno_peak_pciefd"
+
+static char *pciefd_board_name = "PEAK-PCIe FD";
+
+MODULE_AUTHOR("Stephane Grosjean <s.grosjean@peak-system.com>");
+MODULE_DESCRIPTION("RTCAN driver for PEAK PCAN PCIe/M.2 FD family cards");
+MODULE_SUPPORTED_DEVICE("PEAK PCAN PCIe/M.2 FD CAN controllers");
+MODULE_LICENSE("GPL v2");
+
+#define PEAK_PCI_VENDOR_ID	0x001c  /* The PCI device and vendor IDs */
+#define PEAK_PCIEFD_ID		0x0013  /* for PCIe slot cards */
+#define PCAN_CPCIEFD_ID		0x0014  /* for Compact-PCI Serial slot cards */
+#define PCAN_PCIE104FD_ID	0x0017  /* for PCIe-104 Express slot cards */
+#define PCAN_MINIPCIEFD_ID	0x0018 /* for mini-PCIe slot cards */
+#define PCAN_PCIEFD_OEM_ID	0x0019 /* for PCIe slot OEM cards */
+#define PCAN_M2_ID		0x001a  /* for M2 slot cards */
+
+/* supported device ids. */
+static const struct pci_device_id peak_pciefd_tbl[] = {
+	{PEAK_PCI_VENDOR_ID, PEAK_PCIEFD_ID, PCI_ANY_ID, PCI_ANY_ID,},
+	{PEAK_PCI_VENDOR_ID, PCAN_CPCIEFD_ID, PCI_ANY_ID, PCI_ANY_ID,},
+	{PEAK_PCI_VENDOR_ID, PCAN_PCIE104FD_ID, PCI_ANY_ID, PCI_ANY_ID,},
+	{PEAK_PCI_VENDOR_ID, PCAN_MINIPCIEFD_ID, PCI_ANY_ID, PCI_ANY_ID,},
+	{PEAK_PCI_VENDOR_ID, PCAN_PCIEFD_OEM_ID, PCI_ANY_ID, PCI_ANY_ID,},
+	{PEAK_PCI_VENDOR_ID, PCAN_M2_ID, PCI_ANY_ID, PCI_ANY_ID,},
+	{0,}
+};
+
+MODULE_DEVICE_TABLE(pci, peak_pciefd_tbl);
+
+/* PEAK PCIe board access description */
+#define PCIEFD_BAR0_SIZE		(64 * 1024)
+#define PCIEFD_RX_DMA_SIZE		(4 * 1024)
+#define PCIEFD_TX_DMA_SIZE		(4 * 1024)
+
+#define PCIEFD_TX_PAGE_SIZE		(2 * 1024)
+
+/* System Control Registers */
+#define PCIEFD_REG_SYS_CTL_SET		0x0000	/* set bits */
+#define PCIEFD_REG_SYS_CTL_CLR		0x0004	/* clear bits */
+
+/* Version info registers */
+#define PCIEFD_REG_SYS_VER1		0x0040	/* version reg #1 */
+#define PCIEFD_REG_SYS_VER2		0x0044	/* version reg #2 */
+
+#define PCIEFD_FW_VERSION(x, y, z)	(((u32)(x) << 24) | \
+					 ((u32)(y) << 16) | \
+					 ((u32)(z) << 8))
+
+/* System Control Registers Bits */
+#define PCIEFD_SYS_CTL_TS_RST		0x00000001	/* timestamp clock */
+#define PCIEFD_SYS_CTL_CLK_EN		0x00000002	/* system clock */
+
+/* CAN-FD channel addresses */
+#define PCIEFD_CANX_OFF(c)		(((c) + 1) * 0x1000)
+
+#define PCIEFD_ECHO_SKB_MAX		PCANFD_ECHO_SKB_DEF
+
+/* CAN-FD channel registers */
+#define PCIEFD_REG_CAN_MISC		0x0000	/* Misc. control */
+#define PCIEFD_REG_CAN_CLK_SEL		0x0008	/* Clock selector */
+#define PCIEFD_REG_CAN_CMD_PORT_L	0x0010	/* 64-bits command port */
+#define PCIEFD_REG_CAN_CMD_PORT_H	0x0014
+#define PCIEFD_REG_CAN_TX_REQ_ACC	0x0020	/* Tx request accumulator */
+#define PCIEFD_REG_CAN_TX_CTL_SET	0x0030	/* Tx control set register */
+#define PCIEFD_REG_CAN_TX_CTL_CLR	0x0038	/* Tx control clear register */
+#define PCIEFD_REG_CAN_TX_DMA_ADDR_L	0x0040	/* 64-bits addr for Tx DMA */
+#define PCIEFD_REG_CAN_TX_DMA_ADDR_H	0x0044
+#define PCIEFD_REG_CAN_RX_CTL_SET	0x0050	/* Rx control set register */
+#define PCIEFD_REG_CAN_RX_CTL_CLR	0x0058	/* Rx control clear register */
+#define PCIEFD_REG_CAN_RX_CTL_WRT	0x0060	/* Rx control write register */
+#define PCIEFD_REG_CAN_RX_CTL_ACK	0x0068	/* Rx control ACK register */
+#define PCIEFD_REG_CAN_RX_DMA_ADDR_L	0x0070	/* 64-bits addr for Rx DMA */
+#define PCIEFD_REG_CAN_RX_DMA_ADDR_H	0x0074
+
+/* CAN-FD channel misc register bits */
+#define CANFD_MISC_TS_RST		0x00000001	/* timestamp cnt rst */
+
+/* CAN-FD channel Clock SELector Source & DIVider */
+#define CANFD_CLK_SEL_DIV_MASK		0x00000007
+#define CANFD_CLK_SEL_DIV_60MHZ		0x00000000	/* SRC=240MHz only */
+#define CANFD_CLK_SEL_DIV_40MHZ		0x00000001	/* SRC=240MHz only */
+#define CANFD_CLK_SEL_DIV_30MHZ		0x00000002	/* SRC=240MHz only */
+#define CANFD_CLK_SEL_DIV_24MHZ		0x00000003	/* SRC=240MHz only */
+#define CANFD_CLK_SEL_DIV_20MHZ		0x00000004	/* SRC=240MHz only */
+
+#define CANFD_CLK_SEL_SRC_MASK		0x00000008	/* 0=80MHz, 1=240MHz */
+#define CANFD_CLK_SEL_SRC_240MHZ	0x00000008
+#define CANFD_CLK_SEL_SRC_80MHZ		(~CANFD_CLK_SEL_SRC_240MHZ & \
+					 CANFD_CLK_SEL_SRC_MASK)
+
+#define CANFD_CLK_SEL_20MHZ		(CANFD_CLK_SEL_SRC_240MHZ |\
+					 CANFD_CLK_SEL_DIV_20MHZ)
+#define CANFD_CLK_SEL_24MHZ		(CANFD_CLK_SEL_SRC_240MHZ |\
+					 CANFD_CLK_SEL_DIV_24MHZ)
+#define CANFD_CLK_SEL_30MHZ		(CANFD_CLK_SEL_SRC_240MHZ |\
+					 CANFD_CLK_SEL_DIV_30MHZ)
+#define CANFD_CLK_SEL_40MHZ		(CANFD_CLK_SEL_SRC_240MHZ |\
+					 CANFD_CLK_SEL_DIV_40MHZ)
+#define CANFD_CLK_SEL_60MHZ		(CANFD_CLK_SEL_SRC_240MHZ |\
+					 CANFD_CLK_SEL_DIV_60MHZ)
+#define CANFD_CLK_SEL_80MHZ		(CANFD_CLK_SEL_SRC_80MHZ)
+
+/* CAN-FD channel Rx/Tx control register bits */
+#define CANFD_CTL_UNC_BIT		0x00010000	/* Uncached DMA mem */
+#define CANFD_CTL_RST_BIT		0x00020000	/* reset DMA action */
+#define CANFD_CTL_IEN_BIT		0x00040000	/* IRQ enable */
+
+/* Rx IRQ Count and Time Limits */
+#define CANFD_CTL_IRQ_CL_DEF	16	/* Rx msg max nb per IRQ in Rx DMA */
+#define CANFD_CTL_IRQ_TL_DEF	5	/* Time before IRQ if < CL (x100 µs) */
+
+#define CANFD_OPTIONS_SET	(CANFD_OPTION_ERROR | CANFD_OPTION_BUSLOAD)
+
+/* Tx anticipation window (link logical address should be aligned on 2K
+ * boundary)
+ */
+#define PCIEFD_TX_PAGE_COUNT	(PCIEFD_TX_DMA_SIZE / PCIEFD_TX_PAGE_SIZE)
+
+#define CANFD_MSG_LNK_TX	0x1001	/* Tx msgs link */
+
+/* 32-bit IRQ status fields, heading Rx DMA area */
+static inline int pciefd_irq_tag(u32 irq_status)
+{
+	return irq_status & 0x0000000f;
+}
+
+static inline int pciefd_irq_rx_cnt(u32 irq_status)
+{
+	return (irq_status & 0x000007f0) >> 4;
+}
+
+static inline int pciefd_irq_is_lnk(u32 irq_status)
+{
+	return irq_status & 0x00010000;
+}
+
+/* Rx record */
+struct pciefd_rx_dma {
+	__le32 irq_status;
+	__le32 sys_time_low;
+	__le32 sys_time_high;
+	struct pucan_rx_msg msg[0];
+} __packed __aligned(4);
+
+/* Tx Link record */
+struct pciefd_tx_link {
+	__le16 size;
+	__le16 type;
+	__le32 laddr_lo;
+	__le32 laddr_hi;
+} __packed __aligned(4);
+
+/* Tx page descriptor */
+struct pciefd_page {
+	void *vbase;			/* page virtual address */
+	dma_addr_t lbase;		/* page logical address */
+	u32 offset;
+	u32 size;
+};
+
+/* CAN channel object */
+struct pciefd_board;
+struct pciefd_can {
+	struct peak_canfd_priv ucan;	/* must be the first member */
+	void __iomem *reg_base;		/* channel config base addr */
+	struct pciefd_board *board;	/* reverse link */
+
+	struct pucan_command pucan_cmd;	/* command buffer */
+
+	dma_addr_t rx_dma_laddr;	/* DMA virtual and logical addr */
+	void *rx_dma_vaddr;		/* for Rx and Tx areas */
+	dma_addr_t tx_dma_laddr;
+	void *tx_dma_vaddr;
+
+	struct pciefd_page tx_pages[PCIEFD_TX_PAGE_COUNT];
+	u16 tx_pages_free;		/* free Tx pages counter */
+	u16 tx_page_index;		/* current page used for Tx */
+	rtdm_lock_t tx_lock;
+	u32 irq_status;
+	u32 irq_tag;			/* next irq tag */
+	int irq;
+
+	u32 flags;
+};
+
+/* PEAK-PCIe FD board object */
+struct pciefd_board {
+	void __iomem *reg_base;
+	struct pci_dev *pci_dev;
+	int can_count;
+	int irq_flags;			/* IRQF_SHARED or 0 */
+	rtdm_lock_t cmd_lock;		/* 64-bits cmds must be atomic */
+	struct pciefd_can *can[0];	/* array of network devices */
+};
+
+#define CANFD_CTL_IRQ_CL_MIN	1
+#define CANFD_CTL_IRQ_CL_MAX	127	/* 7-bit field */
+
+#define CANFD_CTL_IRQ_TL_MIN	1
+#define CANFD_CTL_IRQ_TL_MAX	15	/* 4-bit field */
+
+static uint irqcl = CANFD_CTL_IRQ_CL_DEF;
+module_param(irqcl, uint, 0644);
+MODULE_PARM_DESC(irqcl,
+" PCIe FD IRQ Count Limit (default=" __stringify(CANFD_CTL_IRQ_CL_DEF) ")");
+
+static uint irqtl = CANFD_CTL_IRQ_TL_DEF;
+module_param(irqtl, uint, 0644);
+MODULE_PARM_DESC(irqtl,
+" PCIe FD IRQ Time Limit (default=" __stringify(CANFD_CTL_IRQ_TL_DEF) ")");
+
+#ifdef PCIEFD_USES_MSI
+
+#ifdef CONFIG_XENO_OPT_SHIRQ
+/* default behaviour: run as mainline driver in INTx mode */
+#define PCIEFD_USEMSI_DEFAULT	0
+#else
+/* default behaviour: run in MSI mode (one IRQ per channel) */
+#define PCIEFD_USEMSI_DEFAULT	1
+#endif
+
+static uint usemsi = PCIEFD_USEMSI_DEFAULT;
+module_param(usemsi, uint, 0644);
+MODULE_PARM_DESC(usemsi,
+" 0=INTA; 1=MSI (def=" __stringify(PCIEFD_USEMSI_DEFAULT) ")");
+#endif
+
+#ifdef CONFIG_XENO_DRIVERS_CAN_DEBUG
+#include "rtcan_internal.h"
+
+static int rtcan_peak_pciefd_proc_regs(struct seq_file *p, void *data)
+{
+	struct rtcan_device *rdev = (struct rtcan_device *)data;
+	struct pciefd_can *priv = rdev->priv;
+	u16 i;
+
+	seq_printf(p, "CANFD registers at %p\n", priv->reg_base);
+
+	for (i = 0; i < 0x80; i += 8) {
+		u32 l = readl(priv->reg_base + i);
+		u32 h = readl(priv->reg_base + i + 4);
+
+		seq_printf(p, "%04x: %08x-%08x\n", i, l, h);
+	}
+
+	return 0;
+}
+
+static int rtcan_peak_pciefd_proc_regs_open(struct inode *inode,
+					    struct file *file)
+{
+	return single_open(file, rtcan_peak_pciefd_proc_regs, PDE_DATA(inode));
+}
+
+static const struct file_operations rtcan_peak_pciefd_proc_regs_ops = {
+	.open = rtcan_peak_pciefd_proc_regs_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
+int rtcan_peak_pciefd_create_proc(struct rtcan_device *rdev)
+{
+	if (!rdev->proc_root)
+		return -EINVAL;
+
+	proc_create_data("registers", S_IFREG | 0644,
+			 rdev->proc_root,
+			 &rtcan_peak_pciefd_proc_regs_ops, rdev);
+	return 0;
+}
+
+void rtcan_peak_pciefd_remove_proc(struct rtcan_device *rdev)
+{
+	if (!rdev->proc_root)
+		return;
+
+	remove_proc_entry("registers", rdev->proc_root);
+}
+
+#else /* !CONFIG_XENO_DRIVERS_CAN_DEBUG */
+
+void rtcan_peak_pciefd_remove_proc(struct rtcan_device *dev)
+{
+}
+
+int rtcan_peak_pciefd_create_proc(struct rtcan_device *dev)
+{
+	return 0;
+}
+#endif /* CONFIG_XENO_DRIVERS_CAN_DEBUG */
+
+/* read a 32 bit value from a SYS block register */
+static inline u32 pciefd_sys_readreg(const struct pciefd_board *priv, u16 reg)
+{
+	return readl(priv->reg_base + reg);
+}
+
+/* write a 32 bit value into a SYS block register */
+static inline void pciefd_sys_writereg(const struct pciefd_board *priv,
+				       u32 val, u16 reg)
+{
+	writel(val, priv->reg_base + reg);
+}
+
+/* read a 32 bits value from CAN-FD block register */
+static inline u32 pciefd_can_readreg(const struct pciefd_can *priv, u16 reg)
+{
+	return readl(priv->reg_base + reg);
+}
+
+/* write a 32 bits value into a CAN-FD block register */
+static inline void pciefd_can_writereg(const struct pciefd_can *priv,
+				       u32 val, u16 reg)
+{
+	writel(val, priv->reg_base + reg);
+}
+
+/* give a channel logical Rx DMA address to the board */
+static void pciefd_can_setup_rx_dma(struct pciefd_can *priv)
+{
+#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
+	const u32 dma_addr_h = (u32)(priv->rx_dma_laddr >> 32);
+#else
+	const u32 dma_addr_h = 0;
+#endif
+
+	/* (DMA must be reset for Rx) */
+	pciefd_can_writereg(priv, CANFD_CTL_RST_BIT,
+			    PCIEFD_REG_CAN_RX_CTL_SET);
+
+	/* write the logical address of the Rx DMA area for this channel */
+	pciefd_can_writereg(priv, (u32)priv->rx_dma_laddr,
+			    PCIEFD_REG_CAN_RX_DMA_ADDR_L);
+	pciefd_can_writereg(priv, dma_addr_h, PCIEFD_REG_CAN_RX_DMA_ADDR_H);
+
+	/* also indicates that Rx DMA is cacheable */
+	pciefd_can_writereg(priv, CANFD_CTL_UNC_BIT,
+			    PCIEFD_REG_CAN_RX_CTL_CLR);
+}
+
+/* clear channel logical Rx DMA address from the board */
+static void pciefd_can_clear_rx_dma(struct pciefd_can *priv)
+{
+	/* DMA must be reset for Rx */
+	pciefd_can_writereg(priv, CANFD_CTL_RST_BIT,
+			    PCIEFD_REG_CAN_RX_CTL_SET);
+
+	/* clear the logical address of the Rx DMA area for this channel */
+	pciefd_can_writereg(priv, 0, PCIEFD_REG_CAN_RX_DMA_ADDR_L);
+	pciefd_can_writereg(priv, 0, PCIEFD_REG_CAN_RX_DMA_ADDR_H);
+}
+
+/* give a channel logical Tx DMA address to the board */
+static void pciefd_can_setup_tx_dma(struct pciefd_can *priv)
+{
+#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
+	const u32 dma_addr_h = (u32)(priv->tx_dma_laddr >> 32);
+#else
+	const u32 dma_addr_h = 0;
+#endif
+
+	/* (DMA must be reset for Tx) */
+	pciefd_can_writereg(priv, CANFD_CTL_RST_BIT,
+			    PCIEFD_REG_CAN_TX_CTL_SET);
+
+	/* write the logical address of the Tx DMA area for this channel */
+	pciefd_can_writereg(priv, (u32)priv->tx_dma_laddr,
+			    PCIEFD_REG_CAN_TX_DMA_ADDR_L);
+	pciefd_can_writereg(priv, dma_addr_h, PCIEFD_REG_CAN_TX_DMA_ADDR_H);
+
+	/* also indicates that Tx DMA is cacheable */
+	pciefd_can_writereg(priv, CANFD_CTL_UNC_BIT,
+			    PCIEFD_REG_CAN_TX_CTL_CLR);
+}
+
+/* clear channel logical Tx DMA address from the board */
+static void pciefd_can_clear_tx_dma(struct pciefd_can *priv)
+{
+	/* DMA must be reset for Tx */
+	pciefd_can_writereg(priv, CANFD_CTL_RST_BIT,
+			    PCIEFD_REG_CAN_TX_CTL_SET);
+
+	/* clear the logical address of the Tx DMA area for this channel */
+	pciefd_can_writereg(priv, 0, PCIEFD_REG_CAN_TX_DMA_ADDR_L);
+	pciefd_can_writereg(priv, 0, PCIEFD_REG_CAN_TX_DMA_ADDR_H);
+}
+
+/* acknowledge interrupt to the device */
+static void pciefd_can_ack_rx_dma(struct pciefd_can *priv)
+{
+	/* read value of current IRQ tag and inc it for next one */
+	priv->irq_tag = le32_to_cpu(*(__le32 *)priv->rx_dma_vaddr);
+	priv->irq_tag++;
+	priv->irq_tag &= 0xf;
+
+	/* write the next IRQ tag for this CAN */
+	pciefd_can_writereg(priv, priv->irq_tag, PCIEFD_REG_CAN_RX_CTL_ACK);
+}
+
+/* IRQ handler */
+static int pciefd_irq_handler(rtdm_irq_t *irq_handle)
+{
+	struct pciefd_can *priv = rtdm_irq_get_arg(irq_handle, void);
+	struct pciefd_rx_dma *rx_dma = priv->rx_dma_vaddr;
+
+	/* INTA mode only, dummy read to sync with PCIe transaction */
+	if (!pci_dev_msi_enabled(priv->board->pci_dev))
+		(void)pciefd_sys_readreg(priv->board, PCIEFD_REG_SYS_VER1);
+
+	/* read IRQ status from the first 32-bit of the Rx DMA area */
+	priv->irq_status = le32_to_cpu(rx_dma->irq_status);
+
+	/* check if this (shared) IRQ is for this CAN */
+	if (pciefd_irq_tag(priv->irq_status) != priv->irq_tag)
+		return RTDM_IRQ_NONE;
+
+	/* handle rx messages (if any) */
+	peak_canfd_handle_msgs_list(&priv->ucan,
+				    rx_dma->msg,
+				    pciefd_irq_rx_cnt(priv->irq_status));
+
+	/* handle tx link interrupt (if any) */
+	if (pciefd_irq_is_lnk(priv->irq_status)) {
+		rtdm_lock_get(&priv->tx_lock);
+		priv->tx_pages_free++;
+		rtdm_lock_put(&priv->tx_lock);
+
+		/* Wake up a sender */
+		rtdm_sem_up(&priv->ucan.rdev->tx_sem);
+	}
+
+	/* re-enable Rx DMA transfer for this CAN */
+	pciefd_can_ack_rx_dma(priv);
+
+	return RTDM_IRQ_HANDLED;
+}
+
+/* initialize structures used for sending CAN frames */
+static int pciefd_enable_tx_path(struct peak_canfd_priv *ucan)
+{
+	struct pciefd_can *priv = (struct pciefd_can *)ucan;
+	int i;
+
+	/* initialize the Tx pages descriptors */
+	priv->tx_pages_free = PCIEFD_TX_PAGE_COUNT - 1;
+	priv->tx_page_index = 0;
+
+	priv->tx_pages[0].vbase = priv->tx_dma_vaddr;
+	priv->tx_pages[0].lbase = priv->tx_dma_laddr;
+
+	for (i = 0; i < PCIEFD_TX_PAGE_COUNT; i++) {
+		priv->tx_pages[i].offset = 0;
+		priv->tx_pages[i].size = PCIEFD_TX_PAGE_SIZE -
+					 sizeof(struct pciefd_tx_link);
+		if (i) {
+			priv->tx_pages[i].vbase =
+					  priv->tx_pages[i - 1].vbase +
+					  PCIEFD_TX_PAGE_SIZE;
+			priv->tx_pages[i].lbase =
+					  priv->tx_pages[i - 1].lbase +
+					  PCIEFD_TX_PAGE_SIZE;
+		}
+	}
+
+	/* setup Tx DMA addresses into IP core */
+	pciefd_can_setup_tx_dma(priv);
+
+	/* start (TX_RST=0) Tx Path */
+	pciefd_can_writereg(priv, CANFD_CTL_RST_BIT,
+			    PCIEFD_REG_CAN_TX_CTL_CLR);
+
+	return 0;
+}
+
+/* board specific command pre-processing */
+static int pciefd_pre_cmd(struct peak_canfd_priv *ucan)
+{
+	struct pciefd_can *priv = (struct pciefd_can *)ucan;
+	u16 cmd = pucan_cmd_get_opcode(&priv->pucan_cmd);
+
+	/* pre-process command */
+	switch (cmd) {
+	case PUCAN_CMD_NORMAL_MODE:
+	case PUCAN_CMD_LISTEN_ONLY_MODE:
+
+		if (ucan->rdev->state == CAN_STATE_BUS_OFF)
+			break;
+
+		/* setup Rx DMA address */
+		pciefd_can_setup_rx_dma(priv);
+
+		/* setup max count of msgs per IRQ */
+		pciefd_can_writereg(priv, (irqtl << 8) | irqcl,
+				    PCIEFD_REG_CAN_RX_CTL_WRT);
+
+		/* clear DMA RST for Rx (Rx start) */
+		pciefd_can_writereg(priv, CANFD_CTL_RST_BIT,
+				    PCIEFD_REG_CAN_RX_CTL_CLR);
+
+		/* reset timestamps */
+		pciefd_can_writereg(priv, !CANFD_MISC_TS_RST,
+				    PCIEFD_REG_CAN_MISC);
+
+		/* do an initial ACK */
+		pciefd_can_ack_rx_dma(priv);
+
+		/* enable IRQ for this CAN after having set next irq_tag */
+		pciefd_can_writereg(priv, CANFD_CTL_IEN_BIT,
+				    PCIEFD_REG_CAN_RX_CTL_SET);
+
+		/* Tx path will be setup as soon as RX_BARRIER is received */
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+/* write a command */
+static int pciefd_write_cmd(struct peak_canfd_priv *ucan)
+{
+	struct pciefd_can *priv = (struct pciefd_can *)ucan;
+	unsigned long flags;
+
+	/* 64-bit command must be atomic */
+	rtdm_lock_get_irqsave(&priv->board->cmd_lock, flags);
+
+	pciefd_can_writereg(priv, *(u32 *)ucan->cmd_buffer,
+			    PCIEFD_REG_CAN_CMD_PORT_L);
+	pciefd_can_writereg(priv, *(u32 *)(ucan->cmd_buffer + 4),
+			    PCIEFD_REG_CAN_CMD_PORT_H);
+
+	rtdm_lock_put_irqrestore(&priv->board->cmd_lock, flags);
+
+	return 0;
+}
+
+/* board specific command post-processing */
+static int pciefd_post_cmd(struct peak_canfd_priv *ucan)
+{
+	struct pciefd_can *priv = (struct pciefd_can *)ucan;
+	u16 cmd = pucan_cmd_get_opcode(&priv->pucan_cmd);
+
+	switch (cmd) {
+	case PUCAN_CMD_RESET_MODE:
+
+		if (ucan->rdev->state == CAN_STATE_STOPPED)
+			break;
+
+		/* controller now in reset mode: disable IRQ for this CAN */
+		pciefd_can_writereg(priv, CANFD_CTL_IEN_BIT,
+				    PCIEFD_REG_CAN_RX_CTL_CLR);
+
+		/* stop and reset DMA addresses in Tx/Rx engines */
+		pciefd_can_clear_tx_dma(priv);
+		pciefd_can_clear_rx_dma(priv);
+
+		/* wait for above commands to complete (read cycle) */
+		(void)pciefd_sys_readreg(priv->board, PCIEFD_REG_SYS_VER1);
+
+		ucan->rdev->state = CAN_STATE_STOPPED;
+
+		break;
+	}
+
+	return 0;
+}
+
+/* allocate enough room into the Tx dma area to store a CAN message */
+static void *pciefd_alloc_tx_msg(struct peak_canfd_priv *ucan, u16 msg_size,
+				 int *room_left)
+{
+	struct pciefd_can *priv = (struct pciefd_can *)ucan;
+	struct pciefd_page *page = priv->tx_pages + priv->tx_page_index;
+	unsigned long flags;
+	void *msg;
+
+	rtdm_lock_get_irqsave(&priv->tx_lock, flags);
+
+	if (page->offset + msg_size > page->size) {
+		struct pciefd_tx_link *lk;
+
+		/* not enough space in this page: try another one */
+		if (!priv->tx_pages_free) {
+			rtdm_lock_put_irqrestore(&priv->tx_lock, flags);
+			/* Tx overflow */
+			return NULL;
+		}
+
+		priv->tx_pages_free--;
+
+		/* keep address of the very last free slot of current page */
+		lk = page->vbase + page->offset;
+
+		/* next, move on a new free page */
+		priv->tx_page_index = (priv->tx_page_index + 1) %
+				      PCIEFD_TX_PAGE_COUNT;
+		page = priv->tx_pages + priv->tx_page_index;
+
+		/* put link record to this new page at the end of prev one */
+		lk->size = cpu_to_le16(sizeof(*lk));
+		lk->type = cpu_to_le16(CANFD_MSG_LNK_TX);
+		lk->laddr_lo = cpu_to_le32(page->lbase);
+
+#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
+		lk->laddr_hi = cpu_to_le32(page->lbase >> 32);
+#else
+		lk->laddr_hi = 0;
+#endif
+		/* next msgs will be put from the begininng of this new page */
+		page->offset = 0;
+	}
+
+	*room_left = priv->tx_pages_free * page->size;
+
+	rtdm_lock_put_irqrestore(&priv->tx_lock, flags);
+
+	msg = page->vbase + page->offset;
+
+	/* give back room left in the tx ring */
+	*room_left += page->size - (page->offset + msg_size);
+
+	return msg;
+}
+
+/* tell the IP core tha a frame has been written into the Tx DMA area */
+static int pciefd_write_tx_msg(struct peak_canfd_priv *ucan,
+			       struct pucan_tx_msg *msg)
+{
+	struct pciefd_can *priv = (struct pciefd_can *)ucan;
+	struct pciefd_page *page = priv->tx_pages + priv->tx_page_index;
+
+	/* this slot is now reserved for writing the frame */
+	page->offset += le16_to_cpu(msg->size);
+
+	/* tell the board a frame has been written in Tx DMA area */
+	pciefd_can_writereg(priv, 1, PCIEFD_REG_CAN_TX_REQ_ACC);
+
+	return 0;
+}
+
+/* probe for CAN channel number #pciefd_board->can_count */
+static int pciefd_can_probe(struct pciefd_board *pciefd)
+{
+	struct rtcan_device *rdev;
+	struct pciefd_can *priv;
+	u32 clk;
+	int err;
+
+	/* allocate the RTCAN object */
+	rdev = alloc_peak_canfd_dev(sizeof(*priv), pciefd->can_count);
+	if (!rdev) {
+		dev_err(&pciefd->pci_dev->dev,
+			"failed to alloc RTCAN device object\n");
+		goto failure;
+	}
+
+	/* fill-in board specific parts */
+	rdev->board_name = pciefd_board_name;
+
+	/* fill-in rtcan private object */
+	priv = rdev->priv;
+
+	/* setup PCIe-FD own callbacks */
+	priv->ucan.pre_cmd = pciefd_pre_cmd;
+	priv->ucan.write_cmd = pciefd_write_cmd;
+	priv->ucan.post_cmd = pciefd_post_cmd;
+	priv->ucan.enable_tx_path = pciefd_enable_tx_path;
+	priv->ucan.alloc_tx_msg = pciefd_alloc_tx_msg;
+	priv->ucan.write_tx_msg = pciefd_write_tx_msg;
+
+	/* setup PCIe-FD own command buffer */
+	priv->ucan.cmd_buffer = &priv->pucan_cmd;
+	priv->ucan.cmd_maxlen = sizeof(priv->pucan_cmd);
+
+	priv->board = pciefd;
+
+	/* CAN config regs block address */
+	priv->reg_base = pciefd->reg_base + PCIEFD_CANX_OFF(priv->ucan.index);
+	rdev->base_addr = (unsigned long)priv->reg_base;
+
+	/* allocate non-cacheable DMA'able 4KB memory area for Rx */
+	priv->rx_dma_vaddr = dmam_alloc_coherent(&pciefd->pci_dev->dev,
+						 PCIEFD_RX_DMA_SIZE,
+						 &priv->rx_dma_laddr,
+						 GFP_KERNEL);
+	if (!priv->rx_dma_vaddr) {
+		dev_err(&pciefd->pci_dev->dev,
+			"Rx dmam_alloc_coherent(%u) failure\n",
+			PCIEFD_RX_DMA_SIZE);
+		goto err_free_rtdev;
+	}
+
+	/* allocate non-cacheable DMA'able 4KB memory area for Tx */
+	priv->tx_dma_vaddr = dmam_alloc_coherent(&pciefd->pci_dev->dev,
+						 PCIEFD_TX_DMA_SIZE,
+						 &priv->tx_dma_laddr,
+						 GFP_KERNEL);
+	if (!priv->tx_dma_vaddr) {
+		dev_err(&pciefd->pci_dev->dev,
+			"Tx dmam_alloc_coherent(%u) failure\n",
+			PCIEFD_TX_DMA_SIZE);
+		goto err_free_rtdev;
+	}
+
+	/* CAN clock in RST mode */
+	pciefd_can_writereg(priv, CANFD_MISC_TS_RST, PCIEFD_REG_CAN_MISC);
+
+	/* read current clock value */
+	clk = pciefd_can_readreg(priv, PCIEFD_REG_CAN_CLK_SEL);
+	switch (clk) {
+	case CANFD_CLK_SEL_20MHZ:
+		priv->ucan.rdev->can_sys_clock = 20 * 1000 * 1000;
+		break;
+	case CANFD_CLK_SEL_24MHZ:
+		priv->ucan.rdev->can_sys_clock = 24 * 1000 * 1000;
+		break;
+	case CANFD_CLK_SEL_30MHZ:
+		priv->ucan.rdev->can_sys_clock = 30 * 1000 * 1000;
+		break;
+	case CANFD_CLK_SEL_40MHZ:
+		priv->ucan.rdev->can_sys_clock = 40 * 1000 * 1000;
+		break;
+	case CANFD_CLK_SEL_60MHZ:
+		priv->ucan.rdev->can_sys_clock = 60 * 1000 * 1000;
+		break;
+	default:
+		pciefd_can_writereg(priv, CANFD_CLK_SEL_80MHZ,
+				    PCIEFD_REG_CAN_CLK_SEL);
+
+		/* fallthrough */
+	case CANFD_CLK_SEL_80MHZ:
+		priv->ucan.rdev->can_sys_clock = 80 * 1000 * 1000;
+		break;
+	}
+
+#ifdef PCIEFD_USES_MSI
+	priv->irq = (pciefd->irq_flags & IRQF_SHARED) ?
+		    pciefd->pci_dev->irq :
+		    pci_irq_vector(pciefd->pci_dev, priv->ucan.index);
+#else
+	priv->irq = pciefd->pci_dev->irq;
+#endif
+
+	/* setup irq handler */
+	err = rtdm_irq_request(&rdev->irq_handle,
+			       priv->irq,
+			       pciefd_irq_handler,
+			       pciefd->irq_flags,
+			       DRV_NAME,
+			       priv);
+	if (err) {
+		dev_err(&pciefd->pci_dev->dev,
+			"rtdm_irq_request(IRQ%u) failure err %d\n",
+			priv->irq, err);
+		goto err_free_rtdev;
+	}
+
+	err = rtcan_dev_register(rdev);
+	if (err) {
+		dev_err(&pciefd->pci_dev->dev,
+			"couldn't register RTCAN device: %d\n", err);
+		goto err_free_irq;
+	}
+
+	rtdm_lock_init(&priv->tx_lock);
+
+	/* save the object address in the board structure */
+	pciefd->can[pciefd->can_count] = priv;
+
+	rtcan_peak_pciefd_create_proc(rdev);
+
+	dev_info(&pciefd->pci_dev->dev, "%s at reg_base=0x%p irq=%d\n",
+		 rdev->name, priv->reg_base, priv->irq);
+
+	return 0;
+
+err_free_irq:
+	rtdm_irq_free(&rdev->irq_handle);
+
+err_free_rtdev:
+	rtcan_dev_free(rdev);
+
+failure:
+	return -ENOMEM;
+}
+
+/* wakeup all RT tasks that are blocked on read */
+static void pciefd_can_unlock_recv_tasks(struct rtcan_device *rdev)
+{
+	struct rtcan_recv *recv_listener = rdev->recv_list;
+
+	while (recv_listener) {
+		struct rtcan_socket *sock = recv_listener->sock;
+
+		/* wakeup any rx task */
+		rtdm_sem_destroy(&sock->recv_sem);
+
+		recv_listener = recv_listener->next;
+	}
+}
+
+/* remove a CAN-FD channel by releasing all of its resources */
+static void pciefd_can_remove(struct pciefd_can *priv)
+{
+	struct rtcan_device *rdev = priv->ucan.rdev;
+
+	/* unlock any tasks that wait for read on a socket bound to this CAN */
+	pciefd_can_unlock_recv_tasks(rdev);
+
+	/* in case the driver is removed when the interface is UP
+	 * (device MUST be closed before being unregistered)
+	 */
+	rdev->do_set_mode(rdev, CAN_MODE_STOP, NULL);
+
+	rtcan_peak_pciefd_remove_proc(rdev);
+	rtcan_dev_unregister(rdev);
+	rtdm_irq_disable(&rdev->irq_handle);
+	rtdm_irq_free(&rdev->irq_handle);
+	rtcan_dev_free(rdev);
+}
+
+/* remove all CAN-FD channels by releasing their own resources */
+static void pciefd_can_remove_all(struct pciefd_board *pciefd)
+{
+	while (pciefd->can_count > 0)
+		pciefd_can_remove(pciefd->can[--pciefd->can_count]);
+}
+
+/* probe for the entire device */
+static int peak_pciefd_probe(struct pci_dev *pdev,
+			     const struct pci_device_id *ent)
+{
+	struct pciefd_board *pciefd;
+	int err, can_count;
+	u16 sub_sys_id;
+	u8 hw_ver_major;
+	u8 hw_ver_minor;
+	u8 hw_ver_sub;
+	u32 v2;
+
+	err = pci_enable_device(pdev);
+	if (err)
+		return err;
+
+	err = pci_request_regions(pdev, DRV_NAME);
+	if (err)
+		goto err_disable_pci;
+
+	/* the number of channels depends on sub-system id */
+	err = pci_read_config_word(pdev, PCI_SUBSYSTEM_ID, &sub_sys_id);
+	if (err)
+		goto err_release_regions;
+
+	dev_dbg(&pdev->dev, "probing device %04x:%04x:%04x\n",
+		pdev->vendor, pdev->device, sub_sys_id);
+
+	if (sub_sys_id >= 0x0012)
+		can_count = 4;
+	else if (sub_sys_id >= 0x0010)
+		can_count = 3;
+	else if (sub_sys_id >= 0x0004)
+		can_count = 2;
+	else
+		can_count = 1;
+
+	/* allocate board structure object */
+	pciefd = devm_kzalloc(&pdev->dev, struct_size(pciefd, can, can_count),
+			      GFP_KERNEL);
+	if (!pciefd) {
+		err = -ENOMEM;
+		goto err_release_regions;
+	}
+
+	/* initialize the board structure */
+	pciefd->pci_dev = pdev;
+	rtdm_lock_init(&pciefd->cmd_lock);
+
+	/* save the PCI BAR0 virtual address for further system regs access */
+	pciefd->reg_base = pci_iomap(pdev, 0, PCIEFD_BAR0_SIZE);
+	if (!pciefd->reg_base) {
+		dev_err(&pdev->dev, "failed to map PCI resource #0\n");
+		err = -ENOMEM;
+		goto err_release_regions;
+	}
+
+	/* read the firmware version number */
+	v2 = pciefd_sys_readreg(pciefd, PCIEFD_REG_SYS_VER2);
+
+	hw_ver_major = (v2 & 0x0000f000) >> 12;
+	hw_ver_minor = (v2 & 0x00000f00) >> 8;
+	hw_ver_sub = (v2 & 0x000000f0) >> 4;
+
+	dev_info(&pdev->dev,
+		 "%ux CAN-FD PCAN-PCIe FPGA v%u.%u.%u:\n", can_count,
+		 hw_ver_major, hw_ver_minor, hw_ver_sub);
+
+#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
+	/* DMA logic doesn't handle mix of 32-bit and 64-bit logical addresses
+	 * in fw <= 3.2.x
+	 */
+	if (PCIEFD_FW_VERSION(hw_ver_major, hw_ver_minor, hw_ver_sub) <
+		PCIEFD_FW_VERSION(3, 3, 0)) {
+		err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
+		if (err)
+			dev_warn(&pdev->dev,
+				"warning: can't set DMA mask %llxh (err %d)\n",
+				DMA_BIT_MASK(32), err);
+	}
+#endif
+
+	/* default interrupt mode is: shared INTx */
+	pciefd->irq_flags = IRQF_SHARED;
+
+#ifdef PCIEFD_USES_MSI
+	if (usemsi) {
+		err = pci_msi_vec_count(pdev);
+		if (err > 0) {
+			int msi_maxvec = err;
+
+			err = pci_alloc_irq_vectors_affinity(pdev, can_count,
+							     msi_maxvec,
+							     PCI_IRQ_MSI,
+							     NULL);
+			dev_info(&pdev->dev,
+				 "MSI[%u..%u] enabling status: %d\n",
+				 can_count, msi_maxvec, err);
+
+			/* if didn't get the requested count of MSI, fall back
+			 * to INTx
+			 */
+			if (err >= can_count)
+				pciefd->irq_flags &= ~IRQF_SHARED;
+			else if (err >= 0)
+				pci_free_irq_vectors(pdev);
+		}
+	}
+#endif
+
+	/* stop system clock */
+	pciefd_sys_writereg(pciefd, PCIEFD_SYS_CTL_CLK_EN,
+			    PCIEFD_REG_SYS_CTL_CLR);
+
+	pci_set_master(pdev);
+
+	/* create now the corresponding channels objects */
+	while (pciefd->can_count < can_count) {
+		err = pciefd_can_probe(pciefd);
+		if (err)
+			goto err_free_canfd;
+
+		pciefd->can_count++;
+	}
+
+	/* set system timestamps counter in RST mode */
+	pciefd_sys_writereg(pciefd, PCIEFD_SYS_CTL_TS_RST,
+			    PCIEFD_REG_SYS_CTL_SET);
+
+	/* wait a bit (read cycle) */
+	(void)pciefd_sys_readreg(pciefd, PCIEFD_REG_SYS_VER1);
+
+	/* free all clocks */
+	pciefd_sys_writereg(pciefd, PCIEFD_SYS_CTL_TS_RST,
+			    PCIEFD_REG_SYS_CTL_CLR);
+
+	/* start system clock */
+	pciefd_sys_writereg(pciefd, PCIEFD_SYS_CTL_CLK_EN,
+			    PCIEFD_REG_SYS_CTL_SET);
+
+	/* remember the board structure address in the device user data */
+	pci_set_drvdata(pdev, pciefd);
+
+	return 0;
+
+err_free_canfd:
+	pciefd_can_remove_all(pciefd);
+
+#ifdef PCIEFD_USES_MSI
+	pci_free_irq_vectors(pdev);
+#endif
+	pci_iounmap(pdev, pciefd->reg_base);
+
+err_release_regions:
+	pci_release_regions(pdev);
+
+err_disable_pci:
+	pci_disable_device(pdev);
+
+	/* pci_xxx_config_word() return positive PCIBIOS_xxx error codes while
+	 * the probe() function must return a negative errno in case of failure
+	 * (err is unchanged if negative)
+	 */
+	return pcibios_err_to_errno(err);
+}
+
+/* free the board structure object, as well as its resources: */
+static void peak_pciefd_remove(struct pci_dev *pdev)
+{
+	struct pciefd_board *pciefd = pci_get_drvdata(pdev);
+
+	/* release CAN-FD channels resources */
+	pciefd_can_remove_all(pciefd);
+
+#ifdef PCIEFD_USES_MSI
+	pci_free_irq_vectors(pdev);
+#endif
+	pci_iounmap(pdev, pciefd->reg_base);
+
+	pci_release_regions(pdev);
+	pci_disable_device(pdev);
+}
+
+static struct pci_driver rtcan_peak_pciefd_driver = {
+	.name = DRV_NAME,
+	.id_table = peak_pciefd_tbl,
+	.probe = peak_pciefd_probe,
+	.remove = peak_pciefd_remove,
+};
+
+static int __init rtcan_peak_pciefd_init(void)
+{
+	if (!realtime_core_enabled())
+		return 0;
+
+	return pci_register_driver(&rtcan_peak_pciefd_driver);
+}
+
+static void __exit rtcan_peak_pciefd_exit(void)
+{
+	if (realtime_core_enabled())
+		pci_unregister_driver(&rtcan_peak_pciefd_driver);
+}
+
+module_init(rtcan_peak_pciefd_init);
+module_exit(rtcan_peak_pciefd_exit);
-- 
2.25.1


