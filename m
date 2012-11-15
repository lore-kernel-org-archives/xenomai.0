From: stefan.roese@gmail.com
Date: Thu, 15 Nov 2012 15:19:03 +0100
Message-Id: <1352989143-32531-1-git-send-email-stefan.roese@gmail.com>
Subject: [Xenomai] [PATCH] mpc5200: Add RTDM LPBFIFO driver and demo RTDM
	FPGA device driver
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
for the MPC5200. It will be used for DMA support in an RTDM FPGA
device driver. This rt-fpga.c driver is a custom device driver,
but might be useful for other developers as well. Thats why I
included it here too.

The lpb-fifo driver is ported from the Linux kernel lpb-fifo
driver:

arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c

With all locking etc changed from Linux call to Xenomai/RTDM
calls.

Signed-off-by: Stefan Roese <sr@denx.de>
---
 ksrc/drivers/Config.in                        |   1 +
 ksrc/drivers/Kconfig                          |   1 +
 ksrc/drivers/Makefile                         |   6 +-
 ksrc/drivers/mpc5200_dma/Config.in            |  10 +
 ksrc/drivers/mpc5200_dma/Kconfig              |  10 +
 ksrc/drivers/mpc5200_dma/Makefile             |  31 ++
 ksrc/drivers/mpc5200_dma/rt-fpga.c            | 701 ++++++++++++++++++++++++++
 ksrc/drivers/mpc5200_dma/rt-fpga.h            |  35 ++
 ksrc/drivers/mpc5200_dma/rt_mpc52xx_lpbfifo.c | 569 +++++++++++++++++++++
 scripts/Modules.frag                          |   3 +-
 10 files changed, 1364 insertions(+), 3 deletions(-)
 create mode 100644 ksrc/drivers/mpc5200_dma/Config.in
 create mode 100644 ksrc/drivers/mpc5200_dma/Kconfig
 create mode 100644 ksrc/drivers/mpc5200_dma/Makefile
 create mode 100644 ksrc/drivers/mpc5200_dma/rt-fpga.c
 create mode 100644 ksrc/drivers/mpc5200_dma/rt-fpga.h
 create mode 100644 ksrc/drivers/mpc5200_dma/rt_mpc52xx_lpbfifo.c

diff --git a/ksrc/drivers/Config.in b/ksrc/drivers/Config.in
index 0e50c44..bab3107 100644
--- a/ksrc/drivers/Config.in
+++ b/ksrc/drivers/Config.in
@@ -12,5 +12,6 @@ comment 'Drivers'
 	source drivers/xenomai/can/Config.in
 	source drivers/xenomai/analogy/Config.in
 	source drivers/xenomai/ipc/Config.in
+	source drivers/xenomai/mpc5200_dma/Config.in
 endmenu
 fi
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
index 4968d87..e50ea1e 100644
--- a/ksrc/drivers/Makefile
+++ b/ksrc/drivers/Makefile
@@ -2,13 +2,13 @@ ifneq ($(VERSION).$(PATCHLEVEL),2.4)
 
 # Makefile frag for Linux v2.6 and v3.x
 
-obj-$(CONFIG_XENOMAI) += serial/ testing/ can/ analogy/ ipc/
+obj-$(CONFIG_XENOMAI) += serial/ testing/ can/ analogy/ ipc/ mpc5200_dma/
 
 else
 
 # Makefile frag for Linux v2.4
 
-mod-subdirs := serial testing can analogy ipc
+mod-subdirs := serial testing can analogy ipc mpc5200_dma
 
 subdir-$(CONFIG_XENO_DRIVERS_16550A) += serial
 
@@ -20,6 +20,8 @@ subdir-$(CONFIG_XENO_DRIVERS_CAN) += can
 subdir-$(CONFIG_XENO_DRIVERS_ANALOGY) += analogy
 subdir-$(CONFIG_XENO_DRIVERS_MPIPE) += ipc
 
+subdir-$(CONFIG_XENO_DRIVERS_MPC5200_DMA) += mpc5200_dma
+
 include $(TOPDIR)/Rules.make
 
 endif
diff --git a/ksrc/drivers/mpc5200_dma/Config.in b/ksrc/drivers/mpc5200_dma/Config.in
new file mode 100644
index 0000000..367c4c6
--- /dev/null
+++ b/ksrc/drivers/mpc5200_dma/Config.in
@@ -0,0 +1,10 @@
+#
+# Xenomai configuration for Linux v2.4
+#
+
+mainmenu_option next_comment
+comment 'MPC5200 DMA drivers'
+
+dep_tristate 'MPC5200 DMA FPGA driver' CONFIG_XENO_DRIVERS_MPC5200_DMA $CONFIG_XENO_SKIN_RTDM
+
+endmenu
diff --git a/ksrc/drivers/mpc5200_dma/Kconfig b/ksrc/drivers/mpc5200_dma/Kconfig
new file mode 100644
index 0000000..bf977de
--- /dev/null
+++ b/ksrc/drivers/mpc5200_dma/Kconfig
@@ -0,0 +1,10 @@
+menu "MPC5200 DMA drivers"
+
+config XENO_DRIVERS_MPC5200_DMA
+	depends on XENO_SKIN_RTDM && PPC_MPC52xx && PPC_MPC5200_LPBFIFO
+	tristate "MPC5200 DMA based driver to receive data from an FPGA"
+	help
+	This is a driver to demonstrate the usage of the RTDM DMA
+	infrastructure on the MPC5200.
+
+endmenu
diff --git a/ksrc/drivers/mpc5200_dma/Makefile b/ksrc/drivers/mpc5200_dma/Makefile
new file mode 100644
index 0000000..151dc79
--- /dev/null
+++ b/ksrc/drivers/mpc5200_dma/Makefile
@@ -0,0 +1,31 @@
+ifneq ($(VERSION).$(PATCHLEVEL),2.4)
+
+# Makefile frag for Linux v2.6 and v3.x
+
+EXTRA_CFLAGS += -D__IN_XENOMAI__ -Iinclude/xenomai
+
+obj-$(CONFIG_XENO_DRIVERS_MPC5200_DMA) += xeno_rt-fpga.o xeno_rt_mpc52xx_lpbfifo.o
+
+xeno_rt-fpga-y := rt-fpga.o
+xeno_rt_mpc52xx_lpbfifo-y := rt_mpc52xx_lpbfifo.o
+
+else
+
+# Makefile frag for Linux v2.4
+
+O_TARGET := built-in.o
+
+obj-$(CONFIG_XENO_DRIVERS_MPC5200_DMA) += xeno_rt-fpga.o xeno_rt_mpc52xx_lpbfifo.o
+
+xeno_mpc5200_dma-objs := rt-fpga.o rt_mpc52xx_lpbfifo.o
+
+export-objs := $(xeno_mpc5200_dma-objs)
+
+EXTRA_CFLAGS += -D__IN_XENOMAI__ -I$(TOPDIR)/include/xenomai -I$(TOPDIR)/include/xenomai/compat
+
+include $(TOPDIR)/Rules.make
+
+xeno_mpc5200_dma.o: $(xeno_mpc5200_dma-objs)
+	$(LD) -r -o $@ $(xeno_mpc5200_dma-objs)
+
+endif
diff --git a/ksrc/drivers/mpc5200_dma/rt-fpga.c b/ksrc/drivers/mpc5200_dma/rt-fpga.c
new file mode 100644
index 0000000..eaed49d
--- /dev/null
+++ b/ksrc/drivers/mpc5200_dma/rt-fpga.c
@@ -0,0 +1,701 @@
+/*
+ *  Xenomai RTDM device driver for A3M071 FPGA with interrupt support
+ *
+ *  Copyright (C) 2012 Stefan Roese <sr@denx.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/types.h>
+#include <linux/uaccess.h>
+#include <linux/dma-mapping.h>
+#include <asm/mpc52xx.h>
+
+/* Xenomai headers */
+#include <native/timer.h>
+#include <rtdm/rtdm_driver.h>
+
+#include "rt-fpga.h"
+
+extern int rt_mpc52xx_lpbfifo_submit(struct mpc52xx_lpbfifo_request *req);
+extern void rt_mpc52xx_lpbfifo_abort(struct mpc52xx_lpbfifo_request *req);
+
+/*
+ * Some switches for testing and/or evaluation. Should be removed
+ * from the final device driver version.
+ */
+
+/*
+ * NO_DMA:
+ *
+ * Define to enable memcpy() for blockdata transfer instead of DMA
+ * support. This is available only for test purposes. Should be disabled
+ * or even removed in the final driver version.
+ */
+#if 0
+#define NO_DMA
+#endif
+
+/*
+ * PRINT_READ_TIME:
+ *
+ * Print min and max times consumed by the blockdata transfer, either
+ * per DMA or per memcpy. Should be disbaled or even removed in the
+ * final driver version.
+ */
+#if 1
+#define PRINT_READ_TIME
+#endif
+
+/*
+ * DEBUG:
+ *
+ * Define to print debug informations. Should be disabled in the
+ * final driver of course.
+ */
+#if 0
+#define DEBUG
+#endif
+
+#ifdef DEBUG
+#define dbg(format, arg...)						\
+	printk("%s (%d): " format, __func__, __LINE__, ##arg)
+#else
+#define dbg(format, arg...)						\
+do {									\
+	if (0)								\
+		printk("%s (%d): " format, __func__, __LINE__, ##arg);	\
+} while (0)
+#endif
+
+
+#define DRIVER_NAME		"rt_fpga"
+#define DRIVER_VERSION		"1.0"
+
+#define BLOCKDATA_MAX_SIZE	(16 << 10)
+
+#define DMA_TIMEOUT_NS	(100 * 1000 * 1000)	/* 100ms timeout for DMA */
+
+/*
+ * Nothing used from the "master" address space right now in this
+ * driver
+ */
+struct fpga_master {
+};
+
+/*
+ * Only define the interrupt related variables here. They are
+ * needed for the ISR. All other offsets/variables are only
+ * used by the userspace application.
+ */
+struct fpga_slave {
+	u8 dummy[0x400];
+	u16 irq_enable;
+	u16 align0;
+	u16 irq_pending;
+	u16 align1;
+	u16 irq_ack;
+	u16 align2;
+};
+
+struct fpga_info {
+	struct fpga_master *fpga_master;
+	struct fpga_slave *fpga_slave;
+	u8 *blockdata_read_buffer;
+	phys_addr_t blockdata_read_buffer_phys;
+	u8 *blockdata_write_buffer;
+	u32 blockdata_read_offset;
+	u32 blockdata_read_count;
+	u32 blockdata_write_offset;
+	u32 blockdata_write_count;
+	u32 timeout;
+	int irq;
+	int chip_select;
+};
+
+struct fpga_ctx {
+	rtdm_lock_t lock;		/* lock to protect context struct */
+	rtdm_event_t read_event;	/* raised to unblock reader */
+	rtdm_event_t read_event_dma;
+	rtdm_task_t irq_task;
+	rtdm_event_t irq_event;
+	struct fpga_info *info;
+	rtdm_irq_t rtdm_irq;
+	u32 irq_status;
+	u32 blockdata_ready;
+	int cycles_missed;
+	int reading;
+
+	/* for sclpc fifo bestcomm */
+	struct mpc52xx_lpbfifo_request req;
+	int dmareq_queued;
+	int dma_running;
+};
+
+static void fpga_dma_done_callback(struct mpc52xx_lpbfifo_request *req)
+{
+	struct fpga_ctx *fpga_ctx = req->priv;
+
+	rtdm_event_signal(&fpga_ctx->read_event_dma);
+}
+
+#ifdef PRINT_READ_TIME
+static int time_min, time_max;
+#endif
+
+static void fpga_irq_task(void *arg)
+{
+	struct fpga_ctx *fpga_ctx = arg;
+	int ret;
+#ifdef PRINT_READ_TIME
+	RTIME old_time;
+	int dt;
+#endif
+
+	while (1) {
+		ret = rtdm_event_wait(&fpga_ctx->irq_event);
+		if (ret < 0) {
+			printk("Error: irq_task waiting on event returned %d\n",
+			       ret);
+		}
+
+		/*
+		 * Task continues - this means that the FPGA interrupt
+		 * has been received and new data is ready in the FPGA
+		 * for transfer from FPGA to MPC5200 RAM.
+		 */
+
+#ifdef PRINT_READ_TIME
+		old_time = rt_timer_tsc();
+#endif
+
+#ifdef NO_DMA
+		/*
+		 * Read blockdata into buffer via memcpy
+		 */
+		memcpy(fpga_ctx->info->blockdata_read_buffer,
+		       (void *)fpga_ctx->info->fpga_slave +
+		       fpga_ctx->info->blockdata_read_offset,
+		       fpga_ctx->info->blockdata_read_count);
+#else
+		/*
+		 * Submit the DMA request the the LPB-FIFO RT driver. This
+		 * will use the DMA based read (MPC5200 BestComm) to free
+		 * the CPU from this time-consuming local bus accesses.
+		 * The DMA parameters (request struct) is already filled in
+		 * the FPGA_CONFIG ioctl.
+		 */
+		ret = rt_mpc52xx_lpbfifo_submit(&fpga_ctx->req);
+		if (ret < 0) {
+			printk("Error: rt_mpc52xx_lpbfifo_submit returned %d\n", ret);
+			return;
+		}
+
+		/*
+		 * Wait for DMA to complete here
+		 */
+		ret = rtdm_event_timedwait(&fpga_ctx->read_event_dma,
+					   DMA_TIMEOUT_NS, NULL);
+		if (ret) {
+			printk("Error: DMA timed out (ret=%d)!\n", ret);
+			return;
+		}
+#endif
+
+#ifdef PRINT_READ_TIME
+		dt = rt_timer_tsc() - old_time;
+		if (dt < time_min)
+			time_min = dt;
+		if (dt > time_max)
+			time_max = dt;
+#endif
+
+		/*
+		 * Mark data as ready in buffer
+		 */
+		fpga_ctx->blockdata_ready = 1;
+
+		/*
+		 * Send signal to read function - unblock potential reading
+		 * process
+		 */
+		rtdm_event_signal(&fpga_ctx->read_event);
+	}
+}
+
+static int fpga_irq_handler(rtdm_irq_t *irq_context)
+{
+	struct fpga_ctx *fpga_ctx;
+	u32 irq_status;
+
+	fpga_ctx = rtdm_irq_get_arg(irq_context, struct fpga_ctx);
+
+	rtdm_lock_get(&fpga_ctx->lock);
+
+	irq_status = __raw_readw(&fpga_ctx->info->fpga_slave->irq_pending);
+	dbg("irq_status=%08x\n", irq_status);
+	__raw_writew(irq_status, &fpga_ctx->info->fpga_slave->irq_ack);
+
+	/*
+	 * Check if blockdata has already been read be application
+	 */
+	if (fpga_ctx->blockdata_ready)
+		fpga_ctx->cycles_missed++;
+
+	/* Let the irq-task continue with the real data transfer */
+	rtdm_event_signal(&fpga_ctx->irq_event);
+
+	rtdm_lock_put(&fpga_ctx->lock);
+
+	return RTDM_IRQ_HANDLED;
+}
+
+static void fpga_cleanup_ctx(struct fpga_ctx *fpga_ctx)
+{
+	rtdm_task_destroy(&fpga_ctx->irq_task);
+	rtdm_event_destroy(&fpga_ctx->read_event);
+	rtdm_event_destroy(&fpga_ctx->read_event_dma);
+	rtdm_event_destroy(&fpga_ctx->irq_event);
+}
+
+static int fpga_open(struct rtdm_dev_context *context,
+		     rtdm_user_info_t *user_info, int oflags)
+{
+	struct fpga_ctx *fpga_ctx;
+	int ret = 0;
+
+	fpga_ctx = (struct fpga_ctx *)context->dev_private;
+	fpga_ctx->info = (struct fpga_info *)context->device->device_data;
+
+	rtdm_lock_init(&fpga_ctx->lock);
+	rtdm_event_init(&fpga_ctx->read_event, 0);
+	rtdm_event_init(&fpga_ctx->read_event_dma, 0);
+	rtdm_event_init(&fpga_ctx->irq_event, 0);
+	fpga_ctx->cycles_missed = 0;
+	fpga_ctx->blockdata_ready = 0;
+	fpga_ctx->reading = 0;
+
+#ifdef PRINT_READ_TIME
+	time_min = 1000000;
+	time_max = 0;
+#endif
+
+	ret = rtdm_task_init(&fpga_ctx->irq_task, "fpga_irq_task",
+			     fpga_irq_task, fpga_ctx,
+			     RTDM_TASK_HIGHEST_PRIORITY, 0);
+	if (ret) {
+		fpga_cleanup_ctx(fpga_ctx);
+		return ret;
+	}
+
+	ret = rtdm_irq_request(&fpga_ctx->rtdm_irq, fpga_ctx->info->irq,
+			       fpga_irq_handler, 0, DRIVER_NAME, fpga_ctx);
+	if (ret)
+		fpga_cleanup_ctx(fpga_ctx);
+
+	return ret;
+}
+
+static int fpga_close(struct rtdm_dev_context *context,
+		      rtdm_user_info_t *user_info)
+{
+	struct fpga_ctx *fpga_ctx;
+
+	fpga_ctx = (struct fpga_ctx *)context->dev_private;
+
+#ifdef PRINT_READ_TIME
+	printk("read_time_min=%lld read_time_max=%lld [ns]\n",
+	       rt_timer_tsc2ns(time_min), rt_timer_tsc2ns(time_max));
+#endif
+
+	rtdm_irq_free(&fpga_ctx->rtdm_irq);
+	fpga_cleanup_ctx(fpga_ctx);
+
+	return 0;
+}
+
+static int fpga_ioctl(struct rtdm_dev_context *context,
+		      rtdm_user_info_t *user_info,
+		      unsigned int request, void *arg)
+{
+	struct fpga_ctx *fpga_ctx;
+	struct fpga_rw_data fpga_data_buf;
+	struct fpga_rw_data *fpga_data;
+	int struct_size = sizeof(struct fpga_rw_data);
+	int err = 0;
+
+	fpga_ctx = (struct fpga_ctx *)context->dev_private;
+	fpga_data = (struct fpga_rw_data *)arg;
+
+	switch (request) {
+	case FPGA_READ_WORD:
+		/*
+		 * Read one 16bit word from FPGA
+		 */
+		if (user_info) {
+			err = rtdm_safe_copy_from_user(user_info,
+						       &fpga_data_buf,
+						       arg, struct_size);
+			if (err)
+				return err;
+
+			fpga_data = &fpga_data_buf;
+		}
+		fpga_data->value = __raw_readw((void *)fpga_ctx->info->fpga_slave +
+					       fpga_data->offset);
+
+		if (user_info)
+			err = rtdm_safe_copy_to_user(user_info, arg,
+						     &fpga_data_buf,
+						     struct_size);
+		else
+			((struct fpga_rw_data *)arg)->value = fpga_data->value;
+
+		break;
+
+	case FPGA_WRITE_WORD:
+		/*
+		 * Write one 16bit word to FPGA
+		 */
+		if (user_info) {
+			err = rtdm_safe_copy_from_user(user_info,
+						       &fpga_data_buf,
+						       arg, struct_size);
+			if (err)
+				return err;
+
+			fpga_data = &fpga_data_buf;
+		}
+		__raw_writew(fpga_data->value,
+			     (void *)fpga_ctx->info->fpga_slave +
+			     fpga_data->offset);
+
+		break;
+
+	case FPGA_CONFIG:
+		if (user_info) {
+			err = rtdm_safe_copy_from_user(user_info,
+						       &fpga_data_buf,
+						       arg, struct_size);
+			if (err)
+				return err;
+
+			fpga_data = &fpga_data_buf;
+		}
+
+		fpga_ctx->info->blockdata_read_offset = fpga_data->offset;
+		fpga_ctx->info->blockdata_read_count = fpga_data->count;
+		fpga_ctx->info->blockdata_write_offset = fpga_data->write_offset;
+		fpga_ctx->info->blockdata_write_count = fpga_data->write_count;
+
+		/*
+		 * Setup request for upcoming DMA transfer
+		 */
+		fpga_ctx->req.cs = fpga_ctx->info->chip_select;
+		fpga_ctx->req.offset = fpga_ctx->info->blockdata_read_offset;
+		fpga_ctx->req.data = fpga_ctx->info->blockdata_read_buffer;
+		fpga_ctx->req.data_phys = fpga_ctx->info->blockdata_read_buffer_phys;
+		fpga_ctx->req.size = fpga_ctx->info->blockdata_read_count;
+		fpga_ctx->req.pos = 0;
+		fpga_ctx->req.flags = MPC52XX_LPBFIFO_FLAG_READ;
+		fpga_ctx->req.callback = fpga_dma_done_callback;
+		fpga_ctx->req.priv = fpga_ctx;
+
+		break;
+
+	case FPGA_SET_TIMEOUT:
+		if (fpga_ctx->reading)
+			return -EBUSY;
+
+		if (user_info) {
+			err = rtdm_safe_copy_from_user(user_info,
+						       &fpga_data_buf,
+						       arg, struct_size);
+			if (err)
+				return err;
+
+			fpga_data = &fpga_data_buf;
+		}
+
+		/*
+		 * FPGA_SET_TIMEOUT is used to start the blockdata
+		 * read operation. Upon this call we mark the reading
+		 * in process, so that other processes will return
+		 * with -EBUSY.
+		 */
+		fpga_ctx->info->timeout =
+			(nanosecs_rel_t)fpga_data->timeout * 1000;
+		fpga_ctx->reading = 1;
+		break;
+
+	case FPGA_GET_CYCLES_MISSED:
+		if (user_info) {
+			fpga_data_buf.cycles_missed = fpga_ctx->cycles_missed;
+			err = rtdm_safe_copy_to_user(user_info, arg,
+						     &fpga_data_buf,
+						     struct_size);
+		} else
+			((struct fpga_rw_data *)arg)->cycles_missed =
+				fpga_ctx->cycles_missed;
+
+		/*
+		 * Reset cycles_missed and reading in process flags
+		 */
+		fpga_ctx->cycles_missed = 0;
+		fpga_ctx->reading = 0;
+		break;
+	}
+
+	return 0;
+}
+
+static ssize_t fpga_read(struct rtdm_dev_context *context,
+			 rtdm_user_info_t *user_info, void *buf, size_t nbyte)
+{
+	rtdm_lockctx_t lock_ctx;
+	struct fpga_ctx *fpga_ctx;
+	ssize_t ret;
+	int count;
+
+	if (nbyte == 0)
+		return 0;
+
+	if (user_info && !rtdm_rw_user_ok(user_info, buf, nbyte))
+		return -EFAULT;
+
+	fpga_ctx = (struct fpga_ctx *)context->dev_private;
+
+	/*
+	 * Block until the blockdata is completely read into
+	 * the buffer (done in interrupt)
+	 */
+	ret = rtdm_event_timedwait(&fpga_ctx->read_event,
+				   fpga_ctx->info->timeout, NULL);
+
+	/*
+	 * Mark blockdata as read
+	 */
+	fpga_ctx->blockdata_ready = 0;
+
+	if (ret)
+		return ret;
+
+	rtdm_lock_get_irqsave(&fpga_ctx->lock, lock_ctx);
+
+	/*
+	 * Transfer data to user
+	 */
+	count = min(nbyte, fpga_ctx->info->blockdata_read_count);
+	if (user_info) {
+		if (rtdm_copy_to_user(user_info, buf,
+				      fpga_ctx->info->blockdata_read_buffer,
+				      count) != 0) {
+			return -EFAULT;
+		}
+	} else
+		memcpy(buf, fpga_ctx->info->blockdata_read_buffer, count);
+
+	rtdm_lock_put_irqrestore(&fpga_ctx->lock, lock_ctx);
+
+	return count;
+}
+
+static ssize_t fpga_write(struct rtdm_dev_context *context,
+			  rtdm_user_info_t  *user_info,
+			  const void *buf, size_t nbyte)
+{
+	rtdm_lockctx_t lock_ctx;
+	struct fpga_ctx *fpga_ctx;
+	int count;
+
+	if (nbyte == 0)
+		return 0;
+
+	if (user_info && !rtdm_read_user_ok(user_info, buf, nbyte))
+		return -EFAULT;
+
+	fpga_ctx = (struct fpga_ctx *)context->dev_private;
+
+	rtdm_lock_get_irqsave(&fpga_ctx->lock, lock_ctx);
+
+	/*
+	 * Copy blockdata from userspace
+	 */
+	if (user_info) {
+		if (rtdm_copy_from_user(user_info,
+					fpga_ctx->info->blockdata_write_buffer,
+					buf, nbyte) != 0) {
+			rtdm_lock_put_irqrestore(&fpga_ctx->lock, lock_ctx);
+			return -EFAULT;
+		}
+	} else {
+		memcpy(fpga_ctx->info->blockdata_write_buffer, buf, nbyte);
+	}
+
+	/*
+	 * Transfer data to FPGA
+	 */
+	count = min(nbyte, fpga_ctx->info->blockdata_write_count);
+	memcpy((void *)fpga_ctx->info->fpga_slave +
+	       fpga_ctx->info->blockdata_write_offset,
+	       fpga_ctx->info->blockdata_write_buffer, count);
+
+	rtdm_lock_put_irqrestore(&fpga_ctx->lock, lock_ctx);
+
+	return count;
+}
+
+static const struct rtdm_device __devinitdata device_tmpl = {
+	.struct_version		= RTDM_DEVICE_STRUCT_VER,
+
+	.device_flags		= RTDM_NAMED_DEVICE | RTDM_EXCLUSIVE,
+	.context_size		= sizeof(struct fpga_ctx),
+	.device_name		= "",
+
+	.open_nrt		= fpga_open,
+
+	.ops = {
+		.close_nrt	= fpga_close,
+
+		.ioctl_rt	= fpga_ioctl,
+		.ioctl_nrt	= fpga_ioctl,
+
+		.read_rt	= fpga_read,
+
+		.write_rt	= fpga_write,
+	},
+
+	.device_class		= RTDM_CLASS_TESTING,
+	.driver_name		= "a3m071-fpga",
+	.driver_version		= RTDM_DRIVER_VER(1, 0, 0),
+	.peripheral_name	= "A3M071 FPGA",
+	.provider_name		= "Stefan Roese",
+};
+
+static int __devinit fpga_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
+	struct fpga_info *fpga_info;
+	struct rtdm_device *rtdm_dev;
+	const unsigned int *prop;
+	u32 val;
+	int ret = 0;
+
+	fpga_info = devm_kzalloc(dev, sizeof(struct fpga_info), GFP_KERNEL);
+
+	fpga_info->fpga_slave = of_iomap(np, 0);
+	if (!fpga_info->fpga_slave) {
+		dev_err(dev, "ioremap failed\n");
+		return -ENOMEM;
+	}
+
+	fpga_info->fpga_master = of_iomap(np, 1);
+	if (!fpga_info->fpga_master) {
+		dev_err(dev, "ioremap failed\n");
+		return -ENOMEM;
+	}
+
+	fpga_info->irq = platform_get_irq(pdev, 0);
+	if (fpga_info->irq < 0) {
+		dev_err(dev, "invalid FPGA irq\n");
+		return -ENODEV;
+	}
+
+	fpga_info->blockdata_read_buffer =
+		dmam_alloc_coherent(dev, BLOCKDATA_MAX_SIZE,
+				    &fpga_info->blockdata_read_buffer_phys,
+				    GFP_KERNEL);
+	if (!fpga_info->blockdata_read_buffer) {
+		dev_err(dev, "Could allocate blockdata read buffer\n");
+		return -ENOMEM;
+	}
+
+	fpga_info->blockdata_write_buffer = devm_kzalloc(dev, BLOCKDATA_MAX_SIZE,
+							 GFP_KERNEL);
+	if (!fpga_info->blockdata_write_buffer) {
+		dev_err(dev, "Could allocate blockdata write buffer\n");
+		return -ENOMEM;
+	}
+
+	rtdm_dev = devm_kzalloc(dev, sizeof(struct rtdm_device), GFP_KERNEL);
+	if (!rtdm_dev) {
+		dev_err(dev, "Could allocate device context\n");
+		return -ENOMEM;
+	}
+
+	/* find CS # */
+	prop = of_get_property(np, "reg", &val);
+	if (!prop || !*prop || *prop > 7) {
+		dev_err(&pdev->dev, "invalid reg property\n");
+		return -EINVAL;
+	}
+	fpga_info->chip_select = *prop;
+
+	memcpy(rtdm_dev, &device_tmpl, sizeof(struct rtdm_device));
+	snprintf(rtdm_dev->device_name, RTDM_MAX_DEVNAME_LEN, "fpga-a3m071");
+	rtdm_dev->proc_name = rtdm_dev->device_name;
+	rtdm_dev->device_data = fpga_info;
+
+	ret = rtdm_dev_register(rtdm_dev);
+	if (ret)
+		return ret;
+
+	dev_set_drvdata(dev, rtdm_dev);
+
+	dev_info(dev, "%s driver registration successful\n", DRIVER_NAME);
+
+	return 0;
+}
+
+static int fpga_remove(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct rtdm_device *rtdm_dev = dev_get_drvdata(dev);
+	struct fpga_info *fpga_info = rtdm_dev->device_data;
+
+        iounmap(fpga_info->fpga_master);
+        iounmap(fpga_info->fpga_slave);
+
+	rtdm_dev_unregister(rtdm_dev, 1000);
+
+	dev_info(dev, "%s driver unregistered\n", DRIVER_NAME);
+
+	return 0;
+}
+
+static const struct of_device_id fpga_id_table[] = {
+	{ .compatible = "anonymous,a3m071-fpga" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, fpga_id_table);
+
+static struct platform_driver fpga_driver = {
+	.probe = fpga_probe,
+	.remove = fpga_remove,
+	.driver = {
+		.owner = THIS_MODULE,
+		.name = DRIVER_NAME,
+		.of_match_table = of_match_ptr(fpga_id_table),
+	},
+};
+
+module_platform_driver(fpga_driver);
+
+MODULE_AUTHOR("Stefan Roese <sr@denx.de>");
+MODULE_DESCRIPTION("Xenomai A3M071 FPGA device driver");
+MODULE_LICENSE("GPL");
diff --git a/ksrc/drivers/mpc5200_dma/rt-fpga.h b/ksrc/drivers/mpc5200_dma/rt-fpga.h
new file mode 100644
index 0000000..f25cf2e
--- /dev/null
+++ b/ksrc/drivers/mpc5200_dma/rt-fpga.h
@@ -0,0 +1,35 @@
+/*
+ *  Xenomai RTDM device driver for A3M071 FPGA with interrupt support
+ *
+ *  Copyright (C) 2012 Stefan Roese <sr@denx.de>
+ */
+
+#ifndef _RT_FPGA_H
+#define _RT_FPGA_H
+
+/*
+ * IOCTL's for this FPGA driver
+ */
+#define RTIOC_TYPE_TESTING		RTDM_CLASS_TESTING
+#define FPGA_CONFIG	\
+	_IOW(RTIOC_TYPE_TESTING, 0x00, struct fpga_rw_data)
+#define FPGA_READ_WORD	\
+	_IOR(RTIOC_TYPE_TESTING, 0x01, struct fpga_rw_data)
+#define FPGA_WRITE_WORD	\
+	_IOW(RTIOC_TYPE_TESTING, 0x02, struct fpga_rw_data)
+#define FPGA_SET_TIMEOUT	\
+	_IOW(RTIOC_TYPE_TESTING, 0x03, struct fpga_rw_data)
+#define FPGA_GET_CYCLES_MISSED	\
+	_IOR(RTIOC_TYPE_TESTING, 0x04, struct fpga_rw_data)
+
+struct fpga_rw_data {
+	unsigned int offset;
+	unsigned short value;
+	unsigned int count;
+	unsigned int write_offset;
+	unsigned int write_count;
+	unsigned int timeout;
+	int cycles_missed;
+};
+
+#endif
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
index d5e2ca4..24ad34a 100644
--- a/scripts/Modules.frag
+++ b/scripts/Modules.frag
@@ -21,4 +21,5 @@ DRIVERS-$(CONFIG_XENO_DRIVERS_CAN_SJA1000_PEAK_PCI) += drivers/xenomai/can/sja10
 DRIVERS-$(CONFIG_XENO_DRIVERS_CAN_SJA1000_PEAK_DNG) += drivers/xenomai/can/sja1000/xeno_can_peak_dng.o
 DRIVERS-$(CONFIG_XENO_DRIVERS_CAN_SJA1000_IXXAT_PCI) += drivers/xenomai/can/sja1000/xeno_can_ixxat_pci.o
 DRIVERS-$(CONFIG_XENO_DRIVERS_CAN_SJA1000_EMS_PCI) += drivers/xenomai/can/sja1000/xeno_can_ems_pci.o
-
+DRIVERS-$(CONFIG_XENO_DRIVERS_MPC5200_DMA) += drivers/xenomai/mpc5200_dma/rt-fpga.o
+DRIVERS-$(CONFIG_XENO_DRIVERS_MPC5200_DMA) += drivers/xenomai/mpc5200_dma/rt_mpc52xx_lpbfifo.o
-- 
1.8.0


