From: stefan.roese@gmail.com
Date: Fri, 23 Nov 2012 14:50:08 +0100
Message-Id: <1353678609-9730-3-git-send-email-stefan.roese@gmail.com>
In-Reply-To: <1353678609-9730-1-git-send-email-stefan.roese@gmail.com>
References: <1353678609-9730-1-git-send-email-stefan.roese@gmail.com>
Subject: [Xenomai] [PATCH v3 2/3] mpc5200: Add RTDM LPBFIFO driver
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Stefan Roese <sr@denx.de>

From: Stefan Roese <sr@denx.de>

This patch adds support for the RTDM LPB (LocalPlusBus) FIFO driver
for the MPC5200. It will be used for DMA support in an custom RTDM
FPGA device driver.

The RT lpb-fifo driver is ported from the Linux kernel lpb-fifo
driver:

    arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c

With all locking etc changed from Linux call to Xenomai/RTDM
calls.

Signed-off-by: Stefan Roese <sr@denx.de>
---
 include/rtdm/rt_mpc52xx_lpbfifo.h             |  13 +
 ksrc/drivers/Kconfig                          |   1 +
 ksrc/drivers/Makefile                         |   2 +-
 ksrc/drivers/mpc5200_dma/Kconfig              |  14 +
 ksrc/drivers/mpc5200_dma/Makefile             |   7 +
 ksrc/drivers/mpc5200_dma/rt_mpc52xx_lpbfifo.c | 569 ++++++++++++++++++++++++++
 scripts/Modules.frag                          |   2 +-
 7 files changed, 606 insertions(+), 2 deletions(-)
 create mode 100644 include/rtdm/rt_mpc52xx_lpbfifo.h
 create mode 100644 ksrc/drivers/mpc5200_dma/Kconfig
 create mode 100644 ksrc/drivers/mpc5200_dma/Makefile
 create mode 100644 ksrc/drivers/mpc5200_dma/rt_mpc52xx_lpbfifo.c

diff --git a/include/rtdm/rt_mpc52xx_lpbfifo.h b/include/rtdm/rt_mpc52xx_lpbfifo.h
new file mode 100644
index 0000000..fc441c3
--- /dev/null
+++ b/include/rtdm/rt_mpc52xx_lpbfifo.h
@@ -0,0 +1,13 @@
+/*
+ *  RTDM mpc5200 lpbfifo driver
+ *
+ *  Copyright (C) 2012 Stefan Roese <sr@denx.de>
+ */
+
+#ifndef _RT_MPC5200_LPBFIFO_H
+#define _RT_MPC5200_LPBFIFO_H
+
+/* Interface to rt_mpc5200_lpbfifo driver */
+int rt_mpc52xx_lpbfifo_submit(struct mpc52xx_lpbfifo_request *req);
+
+#endif
diff --git a/ksrc/drivers/Kconfig b/ksrc/drivers/Kconfig
index 2a9bd8c..9ecc710 100644
--- a/ksrc/drivers/Kconfig
+++ b/ksrc/drivers/Kconfig
@@ -7,5 +7,6 @@ source "drivers/xenomai/testing/Kconfig"
 source "drivers/xenomai/can/Kconfig"
 source "drivers/xenomai/analogy/Kconfig"
 source "drivers/xenomai/ipc/Kconfig"
+source "drivers/xenomai/mpc5200_dma/Kconfig"
 
 endmenu
diff --git a/ksrc/drivers/Makefile b/ksrc/drivers/Makefile
index 4968d87..07739e9 100644
--- a/ksrc/drivers/Makefile
+++ b/ksrc/drivers/Makefile
@@ -2,7 +2,7 @@ ifneq ($(VERSION).$(PATCHLEVEL),2.4)
 
 # Makefile frag for Linux v2.6 and v3.x
 
-obj-$(CONFIG_XENOMAI) += serial/ testing/ can/ analogy/ ipc/
+obj-$(CONFIG_XENOMAI) += serial/ testing/ can/ analogy/ ipc/ mpc5200_dma/
 
 else
 
diff --git a/ksrc/drivers/mpc5200_dma/Kconfig b/ksrc/drivers/mpc5200_dma/Kconfig
new file mode 100644
index 0000000..9d5ecb9
--- /dev/null
+++ b/ksrc/drivers/mpc5200_dma/Kconfig
@@ -0,0 +1,14 @@
+menu "MPC5200 DMA drivers"
+
+config XENO_DRIVERS_MPC5200_LPBFIFO
+        tristate "RTDM MPC5200 LocalPlus bus FIFO driver"
+        depends on XENO_SKIN_RTDM && PPC_MPC52xx
+        select PPC_BESTCOMM_GEN_BD
+	select PPC_MPC5200_LPBFIFO
+	help
+
+	This RTDM driver implements the LPB-FIFO infrastructure for DMA
+	based RTDM device drivers using the BestComm DMA controller
+	on the MPC5200.
+
+endmenu
diff --git a/ksrc/drivers/mpc5200_dma/Makefile b/ksrc/drivers/mpc5200_dma/Makefile
new file mode 100644
index 0000000..00d914d
--- /dev/null
+++ b/ksrc/drivers/mpc5200_dma/Makefile
@@ -0,0 +1,7 @@
+# Makefile frag for Linux v2.6 and v3.x
+
+EXTRA_CFLAGS += -D__IN_XENOMAI__ -Iinclude/xenomai
+
+obj-$(CONFIG_XENO_DRIVERS_MPC5200_LPBFIFO) += xeno_rt_mpc52xx_lpbfifo.o
+
+xeno_rt_mpc52xx_lpbfifo-y := rt_mpc52xx_lpbfifo.o
diff --git a/ksrc/drivers/mpc5200_dma/rt_mpc52xx_lpbfifo.c b/ksrc/drivers/mpc5200_dma/rt_mpc52xx_lpbfifo.c
new file mode 100644
index 0000000..8305f43
--- /dev/null
+++ b/ksrc/drivers/mpc5200_dma/rt_mpc52xx_lpbfifo.c
@@ -0,0 +1,569 @@
+/*
+ * LocalPlus Bus FIFO driver for the Freescale MPC52xx.
+ *
+ * Copyright (C) 2009 Secret Lab Technologies Ltd.
+ *
+ * Ported to Xenomai (RTDM): Stefan Roese <sr@denx.de>
+ *
+ * This file is released under the GPLv2
+ */
+
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/module.h>
+#include <asm/io.h>
+#include <asm/prom.h>
+#include <asm/mpc52xx.h>
+#include <asm/time.h>
+
+#include <sysdev/bestcomm/bestcomm.h>
+#include <sysdev/bestcomm/bestcomm_priv.h>
+#include <sysdev/bestcomm/gen_bd.h>
+
+/* Xenomai headers */
+#include <rtdm/rtdm_driver.h>
+
+MODULE_AUTHOR("Grant Likely <grant.likely@secretlab.ca>");
+MODULE_DESCRIPTION("RT MPC5200 LocalPlus FIFO device driver");
+MODULE_LICENSE("GPL");
+
+#define LPBFIFO_REG_PACKET_SIZE		(0x00)
+#define LPBFIFO_REG_START_ADDRESS	(0x04)
+#define LPBFIFO_REG_CONTROL		(0x08)
+#define LPBFIFO_REG_ENABLE		(0x0C)
+#define LPBFIFO_REG_BYTES_DONE_STATUS	(0x14)
+#define LPBFIFO_REG_FIFO_DATA		(0x40)
+#define LPBFIFO_REG_FIFO_STATUS		(0x44)
+#define LPBFIFO_REG_FIFO_CONTROL	(0x48)
+#define LPBFIFO_REG_FIFO_ALARM		(0x4C)
+
+struct mpc52xx_lpbfifo {
+	struct device *dev;
+	phys_addr_t regs_phys;
+	void __iomem *regs;
+	int irq;
+	rtdm_lock_t lock;
+
+	struct bcom_task *bcom_tx_task;
+	struct bcom_task *bcom_rx_task;
+	struct bcom_task *bcom_cur_task;
+
+	/* Current state data */
+	struct mpc52xx_lpbfifo_request *req;
+	int dma_irqs_enabled;
+
+	rtdm_irq_t rtdm_irq_bcom_rx;
+	rtdm_irq_t rtdm_irq_bcom_tx;
+	rtdm_irq_t rtdm_irq_lpbfifo;
+};
+
+/* The MPC5200 has only one fifo, so only need one instance structure */
+static struct mpc52xx_lpbfifo lpbfifo;
+
+/**
+ * mpc52xx_lpbfifo_kick - Trigger the next block of data to be transferred
+ */
+static void mpc52xx_lpbfifo_kick(struct mpc52xx_lpbfifo_request *req)
+{
+	size_t transfer_size = req->size - req->pos;
+	struct bcom_bd *bd;
+	void __iomem *reg;
+	u32 *data;
+	int i;
+	int bit_fields;
+	int dma = !(req->flags & MPC52XX_LPBFIFO_FLAG_NO_DMA);
+	int write = req->flags & MPC52XX_LPBFIFO_FLAG_WRITE;
+	int poll_dma = req->flags & MPC52XX_LPBFIFO_FLAG_POLL_DMA;
+
+	/* Set and clear the reset bits; is good practice in User Manual */
+	out_be32(lpbfifo.regs + LPBFIFO_REG_ENABLE, 0x01010000);
+
+	/* set master enable bit */
+	out_be32(lpbfifo.regs + LPBFIFO_REG_ENABLE, 0x00000001);
+	if (!dma) {
+		/* While the FIFO can be setup for transfer sizes as large as
+		 * 16M-1, the FIFO itself is only 512 bytes deep and it does
+		 * not generate interrupts for FIFO full events (only transfer
+		 * complete will raise an IRQ).  Therefore when not using
+		 * Bestcomm to drive the FIFO it needs to either be polled, or
+		 * transfers need to constrained to the size of the fifo.
+		 *
+		 * This driver restricts the size of the transfer
+		 */
+		if (transfer_size > 512)
+			transfer_size = 512;
+
+		/* Load the FIFO with data */
+		if (write) {
+			reg = lpbfifo.regs + LPBFIFO_REG_FIFO_DATA;
+			data = req->data + req->pos;
+			for (i = 0; i < transfer_size; i += 4)
+				out_be32(reg, *data++);
+		}
+
+		/* Unmask both error and completion irqs */
+		out_be32(lpbfifo.regs + LPBFIFO_REG_ENABLE, 0x00000301);
+	} else {
+		/* Choose the correct direction
+		 *
+		 * Configure the watermarks so DMA will always complete correctly.
+		 * It may be worth experimenting with the ALARM value to see if
+		 * there is a performance impacit.  However, if it is wrong there
+		 * is a risk of DMA not transferring the last chunk of data
+		 */
+		if (write) {
+			out_be32(lpbfifo.regs + LPBFIFO_REG_FIFO_ALARM, 0x1e4);
+			out_8(lpbfifo.regs + LPBFIFO_REG_FIFO_CONTROL, 7);
+			lpbfifo.bcom_cur_task = lpbfifo.bcom_tx_task;
+		} else {
+			out_be32(lpbfifo.regs + LPBFIFO_REG_FIFO_ALARM, 0x1ff);
+			out_8(lpbfifo.regs + LPBFIFO_REG_FIFO_CONTROL, 0);
+			lpbfifo.bcom_cur_task = lpbfifo.bcom_rx_task;
+
+			if (poll_dma) {
+				if (lpbfifo.dma_irqs_enabled) {
+					disable_irq(bcom_get_task_irq(lpbfifo.bcom_rx_task));
+					lpbfifo.dma_irqs_enabled = 0;
+				}
+			} else {
+				if (!lpbfifo.dma_irqs_enabled) {
+					enable_irq(bcom_get_task_irq(lpbfifo.bcom_rx_task));
+					lpbfifo.dma_irqs_enabled = 1;
+				}
+			}
+		}
+
+		bd = bcom_prepare_next_buffer(lpbfifo.bcom_cur_task);
+		bd->status = transfer_size;
+		if (!write) {
+			/*
+			 * In the DMA read case, the DMA doesn't complete,
+			 * possibly due to incorrect watermarks in the ALARM
+			 * and CONTROL regs. For now instead of trying to
+			 * determine the right watermarks that will make this
+			 * work, just increase the number of bytes the FIFO is
+			 * expecting.
+			 *
+			 * When submitting another operation, the FIFO will get
+			 * reset, so the condition of the FIFO waiting for a
+			 * non-existent 4 bytes will get cleared.
+			 */
+			transfer_size += 4; /* BLECH! */
+		}
+		bd->data[0] = req->data_phys + req->pos;
+		bcom_submit_next_buffer(lpbfifo.bcom_cur_task, NULL);
+
+		/* error irq & master enabled bit */
+		bit_fields = 0x00000201;
+
+		/* Unmask irqs */
+		if (write && (!poll_dma))
+			bit_fields |= 0x00000100; /* completion irq too */
+		out_be32(lpbfifo.regs + LPBFIFO_REG_ENABLE, bit_fields);
+	}
+
+	/* Set transfer size, width, chip select and READ mode */
+	out_be32(lpbfifo.regs + LPBFIFO_REG_START_ADDRESS,
+		 req->offset + req->pos);
+	out_be32(lpbfifo.regs + LPBFIFO_REG_PACKET_SIZE, transfer_size);
+
+	bit_fields = req->cs << 24 | 0x000008;
+	if (!write)
+		bit_fields |= 0x010000; /* read mode */
+	out_be32(lpbfifo.regs + LPBFIFO_REG_CONTROL, bit_fields);
+
+	/* Kick it off */
+	out_8(lpbfifo.regs + LPBFIFO_REG_PACKET_SIZE, 0x01);
+	if (dma)
+		bcom_enable(lpbfifo.bcom_cur_task);
+}
+
+/**
+ * mpc52xx_lpbfifo_irq - IRQ handler for LPB FIFO
+ *
+ * On transmit, the dma completion irq triggers before the fifo completion
+ * triggers.  Handle the dma completion here instead of the LPB FIFO Bestcomm
+ * task completion irq because everything is not really done until the LPB FIFO
+ * completion irq triggers.
+ *
+ * In other words:
+ * For DMA, on receive, the "Fat Lady" is the bestcom completion irq. on
+ * transmit, the fifo completion irq is the "Fat Lady". The opera (or in this
+ * case the DMA/FIFO operation) is not finished until the "Fat Lady" sings.
+ *
+ * Reasons for entering this routine:
+ * 1) PIO mode rx and tx completion irq
+ * 2) DMA interrupt mode tx completion irq
+ * 3) DMA polled mode tx
+ *
+ * Exit conditions:
+ * 1) Transfer aborted
+ * 2) FIFO complete without DMA; more data to do
+ * 3) FIFO complete without DMA; all data transferred
+ * 4) FIFO complete using DMA
+ *
+ * Condition 1 can occur regardless of whether or not DMA is used.
+ * It requires executing the callback to report the error and exiting
+ * immediately.
+ *
+ * Condition 2 requires programming the FIFO with the next block of data
+ *
+ * Condition 3 requires executing the callback to report completion
+ *
+ * Condition 4 means the same as 3, except that we also retrieve the bcom
+ * buffer so DMA doesn't get clogged up.
+ *
+ * To make things trickier, the spinlock must be dropped before
+ * executing the callback, otherwise we could end up with a deadlock
+ * or nested spinlock condition.  The out path is non-trivial, so
+ * extra fiddling is done to make sure all paths lead to the same
+ * outbound code.
+ */
+static int mpc52xx_lpbfifo_irq(rtdm_irq_t *irq_context)
+{
+	struct mpc52xx_lpbfifo_request *req;
+	u32 status = in_8(lpbfifo.regs + LPBFIFO_REG_BYTES_DONE_STATUS);
+	void __iomem *reg;
+	u32 *data;
+	int count, i;
+	int do_callback = 0;
+	u32 ts;
+	int dma, write, poll_dma;
+	rtdm_lockctx_t lock_ctx;
+
+	rtdm_lock_get_irqsave(&lpbfifo.lock, lock_ctx);
+	ts = get_tbl();
+
+	req = lpbfifo.req;
+	if (!req) {
+		rtdm_lock_put_irqrestore(&lpbfifo.lock, lock_ctx);
+		pr_err("bogus LPBFIFO IRQ\n");
+		return RTDM_IRQ_HANDLED;
+	}
+
+	dma = !(req->flags & MPC52XX_LPBFIFO_FLAG_NO_DMA);
+	write = req->flags & MPC52XX_LPBFIFO_FLAG_WRITE;
+	poll_dma = req->flags & MPC52XX_LPBFIFO_FLAG_POLL_DMA;
+
+	if (dma && !write) {
+		rtdm_lock_put_irqrestore(&lpbfifo.lock, lock_ctx);
+		pr_err("bogus LPBFIFO IRQ (dma and not writting)\n");
+		return RTDM_IRQ_HANDLED;
+	}
+
+	if ((status & 0x01) == 0) {
+		goto out;
+	}
+
+	/* check abort bit */
+	if (status & 0x10) {
+		out_be32(lpbfifo.regs + LPBFIFO_REG_ENABLE, 0x01010000);
+		do_callback = 1;
+		goto out;
+	}
+
+	/* Read result from hardware */
+	count = in_be32(lpbfifo.regs + LPBFIFO_REG_BYTES_DONE_STATUS);
+	count &= 0x00ffffff;
+
+	if (!dma && !write) {
+		/* copy the data out of the FIFO */
+		reg = lpbfifo.regs + LPBFIFO_REG_FIFO_DATA;
+		data = req->data + req->pos;
+		for (i = 0; i < count; i += 4)
+			*data++ = in_be32(reg);
+	}
+
+	/* Update transfer position and count */
+	req->pos += count;
+
+	/* Decide what to do next */
+	if (req->size - req->pos)
+		mpc52xx_lpbfifo_kick(req); /* more work to do */
+	else
+		do_callback = 1;
+
+ out:
+	/* Clear the IRQ */
+	out_8(lpbfifo.regs + LPBFIFO_REG_BYTES_DONE_STATUS, 0x01);
+
+	if (dma && (status & 0x11)) {
+		/*
+		 * Count the DMA as complete only when the FIFO completion
+		 * status or abort bits are set.
+		 *
+		 * (status & 0x01) should always be the case except sometimes
+		 * when using polled DMA.
+		 *
+		 * (status & 0x10) {transfer aborted}: This case needs more
+		 * testing.
+		 */
+		bcom_retrieve_buffer(lpbfifo.bcom_cur_task, &status, NULL);
+	}
+	req->last_byte = ((u8 *)req->data)[req->size - 1];
+
+	/* When the do_callback flag is set; it means the transfer is finished
+	 * so set the FIFO as idle */
+	if (do_callback)
+		lpbfifo.req = NULL;
+
+	if (irq_context != NULL) /* don't increment on polled case */
+		req->irq_count++;
+
+	req->irq_ticks += get_tbl() - ts;
+	rtdm_lock_put_irqrestore(&lpbfifo.lock, lock_ctx);
+
+	/* Spinlock is released; it is now safe to call the callback */
+	if (do_callback && req->callback)
+		req->callback(req);
+
+	return RTDM_IRQ_HANDLED;
+}
+
+/**
+ * mpc52xx_lpbfifo_bcom_irq - IRQ handler for LPB FIFO Bestcomm task
+ *
+ * Only used when receiving data.
+ */
+static int mpc52xx_lpbfifo_bcom_irq(rtdm_irq_t *irq_context)
+{
+	struct mpc52xx_lpbfifo_request *req;
+	u32 status;
+	u32 ts;
+	rtdm_lockctx_t lock_ctx;
+
+	rtdm_lock_get_irqsave(&lpbfifo.lock, lock_ctx);
+	ts = get_tbl();
+
+	req = lpbfifo.req;
+	if (!req || (req->flags & MPC52XX_LPBFIFO_FLAG_NO_DMA)) {
+		rtdm_lock_put_irqrestore(&lpbfifo.lock, lock_ctx);
+		return RTDM_IRQ_HANDLED;
+	}
+
+	if (irq_context != NULL) /* don't increment on polled case */
+		req->irq_count++;
+
+	if (!bcom_buffer_done(lpbfifo.bcom_cur_task)) {
+		rtdm_lock_put_irqrestore(&lpbfifo.lock, lock_ctx);
+
+		req->buffer_not_done_cnt++;
+		if ((req->buffer_not_done_cnt % 1000) == 0)
+			pr_err("transfer stalled\n");
+
+		return RTDM_IRQ_HANDLED;
+	}
+
+	bcom_retrieve_buffer(lpbfifo.bcom_cur_task, &status, NULL);
+
+	req->last_byte = ((u8 *)req->data)[req->size - 1];
+
+	req->pos = status & 0x00ffffff;
+
+	/* Mark the FIFO as idle */
+	lpbfifo.req = NULL;
+
+	/* Release the lock before calling out to the callback. */
+	req->irq_ticks += get_tbl() - ts;
+	rtdm_lock_put_irqrestore(&lpbfifo.lock, lock_ctx);
+
+	if (req->callback)
+		req->callback(req);
+
+	return RTDM_IRQ_HANDLED;
+}
+
+/**
+ * rt_mpc52xx_lpbfifo_bcom_poll - Poll for DMA completion
+ */
+void rt_mpc52xx_lpbfifo_poll(void)
+{
+	struct mpc52xx_lpbfifo_request *req = lpbfifo.req;
+	int dma = !(req->flags & MPC52XX_LPBFIFO_FLAG_NO_DMA);
+	int write = req->flags & MPC52XX_LPBFIFO_FLAG_WRITE;
+
+	/*
+	 * For more information, see comments on the "Fat Lady"
+	 */
+	if (dma && write)
+		mpc52xx_lpbfifo_irq(NULL);
+	else
+		mpc52xx_lpbfifo_bcom_irq(NULL);
+}
+EXPORT_SYMBOL(rt_mpc52xx_lpbfifo_poll);
+
+/**
+ * rt_mpc52xx_lpbfifo_submit - Submit an LPB FIFO transfer request.
+ * @req: Pointer to request structure
+ */
+int rt_mpc52xx_lpbfifo_submit(struct mpc52xx_lpbfifo_request *req)
+{
+	rtdm_lockctx_t lock_ctx;
+
+	if (!lpbfifo.regs)
+		return -ENODEV;
+
+	rtdm_lock_get_irqsave(&lpbfifo.lock, lock_ctx);
+
+	/* If the req pointer is already set, then a transfer is in progress */
+	if (lpbfifo.req) {
+		rtdm_lock_put_irqrestore(&lpbfifo.lock, lock_ctx);
+		return -EBUSY;
+	}
+
+	/* Setup the transfer */
+	lpbfifo.req = req;
+	req->irq_count = 0;
+	req->irq_ticks = 0;
+	req->buffer_not_done_cnt = 0;
+	req->pos = 0;
+
+	mpc52xx_lpbfifo_kick(req);
+	rtdm_lock_put_irqrestore(&lpbfifo.lock, lock_ctx);
+	return 0;
+}
+EXPORT_SYMBOL(rt_mpc52xx_lpbfifo_submit);
+
+void rt_mpc52xx_lpbfifo_abort(struct mpc52xx_lpbfifo_request *req)
+{
+	rtdm_lockctx_t lock_ctx;
+
+	rtdm_lock_get_irqsave(&lpbfifo.lock, lock_ctx);
+	if (lpbfifo.req == req) {
+		/* Put it into reset and clear the state */
+		bcom_gen_bd_rx_reset(lpbfifo.bcom_rx_task);
+		bcom_gen_bd_tx_reset(lpbfifo.bcom_tx_task);
+		out_be32(lpbfifo.regs + LPBFIFO_REG_ENABLE, 0x01010000);
+		lpbfifo.req = NULL;
+	}
+	rtdm_lock_put_irqrestore(&lpbfifo.lock, lock_ctx);
+}
+EXPORT_SYMBOL(rt_mpc52xx_lpbfifo_abort);
+
+static int __devinit mpc52xx_lpbfifo_probe(struct platform_device *op)
+{
+	struct resource res;
+	int rc = -ENOMEM;
+
+	if (lpbfifo.dev != NULL)
+		return -ENOSPC;
+
+	lpbfifo.irq = irq_of_parse_and_map(op->dev.of_node, 0);
+	if (!lpbfifo.irq)
+		return -ENODEV;
+
+	if (of_address_to_resource(op->dev.of_node, 0, &res))
+		return -ENODEV;
+	lpbfifo.regs_phys = res.start;
+	lpbfifo.regs = of_iomap(op->dev.of_node, 0);
+	if (!lpbfifo.regs)
+		return -ENOMEM;
+
+	rtdm_lock_init(&lpbfifo.lock);
+
+	/* Put FIFO into reset */
+	out_be32(lpbfifo.regs + LPBFIFO_REG_ENABLE, 0x01010000);
+
+	/* Register the interrupt handler */
+	rc = rtdm_irq_request(&lpbfifo.rtdm_irq_lpbfifo, lpbfifo.irq,
+			      mpc52xx_lpbfifo_irq, 0,
+			      "mpc52xx-lpbfifo", &lpbfifo);
+	if (rc)
+		goto err_irq;
+
+	/* Request the Bestcomm receive (fifo --> memory) task and IRQ */
+	lpbfifo.bcom_rx_task =
+		bcom_gen_bd_rx_init(2, res.start + LPBFIFO_REG_FIFO_DATA,
+				    BCOM_INITIATOR_SCLPC, BCOM_IPR_SCLPC,
+				    16*1024*1024);
+	if (!lpbfifo.bcom_rx_task)
+		goto err_bcom_rx;
+
+	rc = rtdm_irq_request(&lpbfifo.rtdm_irq_bcom_rx,
+			      bcom_get_task_irq(lpbfifo.bcom_rx_task),
+			      mpc52xx_lpbfifo_bcom_irq, 0,
+			      "mpc52xx-lpbfifo-rx", &lpbfifo);
+	if (rc)
+		goto err_bcom_rx_irq;
+
+	lpbfifo.dma_irqs_enabled = 1;
+
+	/* Request the Bestcomm transmit (memory --> fifo) task and IRQ */
+	lpbfifo.bcom_tx_task =
+		bcom_gen_bd_tx_init(2, res.start + LPBFIFO_REG_FIFO_DATA,
+				    BCOM_INITIATOR_SCLPC, BCOM_IPR_SCLPC);
+	if (!lpbfifo.bcom_tx_task)
+		goto err_bcom_tx;
+
+	lpbfifo.dev = &op->dev;
+	return 0;
+
+ err_bcom_tx:
+	rtdm_irq_free(&lpbfifo.rtdm_irq_bcom_rx);
+ err_bcom_rx_irq:
+	bcom_gen_bd_rx_release(lpbfifo.bcom_rx_task);
+ err_bcom_rx:
+ err_irq:
+	iounmap(lpbfifo.regs);
+	lpbfifo.regs = NULL;
+
+	dev_err(&op->dev, "mpc52xx_lpbfifo_probe() failed\n");
+	return -ENODEV;
+}
+
+
+static int __devexit mpc52xx_lpbfifo_remove(struct platform_device *op)
+{
+	if (lpbfifo.dev != &op->dev)
+		return 0;
+
+	/* Put FIFO in reset */
+	out_be32(lpbfifo.regs + LPBFIFO_REG_ENABLE, 0x01010000);
+
+	/* Release the bestcomm transmit task */
+	rtdm_irq_free(&lpbfifo.rtdm_irq_bcom_tx);
+	bcom_gen_bd_tx_release(lpbfifo.bcom_tx_task);
+
+	/* Release the bestcomm receive task */
+	rtdm_irq_free(&lpbfifo.rtdm_irq_bcom_rx);
+	bcom_gen_bd_rx_release(lpbfifo.bcom_rx_task);
+
+	rtdm_irq_free(&lpbfifo.rtdm_irq_lpbfifo);
+	iounmap(lpbfifo.regs);
+	lpbfifo.regs = NULL;
+	lpbfifo.dev = NULL;
+
+	return 0;
+}
+
+static struct of_device_id mpc52xx_lpbfifo_match[] __devinitconst = {
+	{ .compatible = "fsl,rt-mpc5200-lpbfifo", },
+	{},
+};
+
+static struct platform_driver mpc52xx_lpbfifo_driver = {
+	.driver = {
+		.name = "rt-mpc52xx-lpbfifo",
+		.owner = THIS_MODULE,
+		.of_match_table = mpc52xx_lpbfifo_match,
+	},
+	.probe = mpc52xx_lpbfifo_probe,
+	.remove = __devexit_p(mpc52xx_lpbfifo_remove),
+};
+
+/***********************************************************************
+ * Module init/exit
+ */
+static int __init mpc52xx_lpbfifo_init(void)
+{
+	return platform_driver_register(&mpc52xx_lpbfifo_driver);
+}
+module_init(mpc52xx_lpbfifo_init);
+
+static void __exit mpc52xx_lpbfifo_exit(void)
+{
+	platform_driver_unregister(&mpc52xx_lpbfifo_driver);
+}
+module_exit(mpc52xx_lpbfifo_exit);
diff --git a/scripts/Modules.frag b/scripts/Modules.frag
index d5e2ca4..fa52b7f 100644
--- a/scripts/Modules.frag
+++ b/scripts/Modules.frag
@@ -21,4 +21,4 @@ DRIVERS-$(CONFIG_XENO_DRIVERS_CAN_SJA1000_PEAK_PCI) += drivers/xenomai/can/sja10
 DRIVERS-$(CONFIG_XENO_DRIVERS_CAN_SJA1000_PEAK_DNG) += drivers/xenomai/can/sja1000/xeno_can_peak_dng.o
 DRIVERS-$(CONFIG_XENO_DRIVERS_CAN_SJA1000_IXXAT_PCI) += drivers/xenomai/can/sja1000/xeno_can_ixxat_pci.o
 DRIVERS-$(CONFIG_XENO_DRIVERS_CAN_SJA1000_EMS_PCI) += drivers/xenomai/can/sja1000/xeno_can_ems_pci.o
-
+DRIVERS-$(CONFIG_XENO_DRIVERS_MPC5200_LPBFIFO) += drivers/xenomai/mpc5200_dma/rt_mpc52xx_lpbfifo.o
-- 
1.8.0


