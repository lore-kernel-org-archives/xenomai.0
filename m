From: stefan.roese@gmail.com
Date: Fri, 23 Nov 2012 14:50:09 +0100
Message-Id: <1353678609-9730-4-git-send-email-stefan.roese@gmail.com>
In-Reply-To: <1353678609-9730-1-git-send-email-stefan.roese@gmail.com>
References: <1353678609-9730-1-git-send-email-stefan.roese@gmail.com>
Subject: [Xenomai] [PATCH v3 3/3] mpc5200: Add demo RTDM FPGA DMA based
	device driver
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

This patch adds support for an custom RTDM FPGA DMA based driver driver.
This is a driver to demonstrate the usage of the RTDM DMA infrastructure on
the MPC5200. It uses the RTDM lpbfifo driver to communicate with the
BestComm DMA controller.

As mentioned above, its a special custom driver. But it might be useful for
other developers as well. Thats why I included it here too.

Signed-off-by: Stefan Roese <sr@denx.de>

---
 include/rtdm/rt-fpga.h             |  46 +++
 ksrc/drivers/mpc5200_dma/Kconfig   |  39 ++
 ksrc/drivers/mpc5200_dma/Makefile  |   2 +
 ksrc/drivers/mpc5200_dma/rt-fpga.c | 711 +++++++++++++++++++++++++++++++++++++
 scripts/Modules.frag               |   1 +
 5 files changed, 799 insertions(+)
 create mode 100644 include/rtdm/rt-fpga.h
 create mode 100644 ksrc/drivers/mpc5200_dma/rt-fpga.c

diff --git a/include/rtdm/rt-fpga.h b/include/rtdm/rt-fpga.h
new file mode 100644
index 0000000..f819a19
--- /dev/null
+++ b/include/rtdm/rt-fpga.h
@@ -0,0 +1,46 @@
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
+#define RTIOC_TYPE_CUSTOM		RTDM_CLASS_CUSTOM
+#define FPGA_CONFIG	\
+	_IOW(RTIOC_TYPE_CUSTOM, 0x00, struct fpga_config)
+#define FPGA_READ_WORD	\
+	_IOR(RTIOC_TYPE_CUSTOM, 0x01, struct fpga_rw_word)
+#define FPGA_WRITE_WORD	\
+	_IOW(RTIOC_TYPE_CUSTOM, 0x02, struct fpga_rw_word)
+#define FPGA_SET_TIMEOUT	\
+	_IOW(RTIOC_TYPE_CUSTOM, 0x03, struct fpga_set_timeout)
+#define FPGA_GET_CYCLES_MISSED	\
+	_IOR(RTIOC_TYPE_CUSTOM, 0x04, struct fpga_get_cycles_missed)
+
+/* Structs for ioctls */
+struct fpga_config {
+	unsigned int offset;
+	unsigned int count;
+	unsigned int write_offset;
+	unsigned int write_count;
+};
+
+struct fpga_rw_word {
+	unsigned int offset;
+	unsigned short value;
+};
+
+struct fpga_set_timeout {
+	unsigned int timeout;
+};
+
+struct fpga_get_cycles_missed {
+	int cycles_missed;
+};
+
+#endif
diff --git a/ksrc/drivers/mpc5200_dma/Kconfig b/ksrc/drivers/mpc5200_dma/Kconfig
index 9d5ecb9..5cf8018 100644
--- a/ksrc/drivers/mpc5200_dma/Kconfig
+++ b/ksrc/drivers/mpc5200_dma/Kconfig
@@ -11,4 +11,43 @@ config XENO_DRIVERS_MPC5200_LPBFIFO
 	based RTDM device drivers using the BestComm DMA controller
 	on the MPC5200.
 
+config XENO_DRIVERS_MPC5200_DMA
+	depends on XENO_DRIVERS_MPC5200_LPBFIFO
+	tristate "MPC5200 DMA based driver to receive data from an FPGA"
+	help
+
+	This is a driver to demonstrate the usage of the RTDM DMA
+	infrastructure on the MPC5200.
+
+config XENO_DRIVERS_MPC5200_DMA_DEBUG
+	depends on XENO_DRIVERS_MPC5200_DMA
+	bool "Enable debug output"
+	default n
+	help
+
+	This option activates debugging checks and enhanced output for the
+	RTDM FPGA DMA driver. It is a recommended option for getting started
+	and analysing potential problems. For production purposes, it should
+	be switched off (for the sake of latency).
+
+config XENO_DRIVERS_MPC5200_DMA_NO_DMA
+	depends on XENO_DRIVERS_MPC5200_DMA
+	bool "Enable non-DMA version of this FPGA driver"
+	default n
+	help
+
+	Define to enable memcpy() for blockdata transfer instead of DMA
+	support. This is available only for test purposes. Should be disabled
+	in the final/release driver version.
+
+config XENO_DRIVERS_MPC5200_DMA_PRINT_READ_TIME
+	depends on XENO_DRIVERS_MPC5200_DMA
+	bool "Enable read time debug output of this FPGA driver"
+	default n
+	help
+
+	Print min and max times consumed by the blockdata transfer, either
+	per DMA or per memcpy. Should be disabled in the final/release driver
+	version.
+
 endmenu
diff --git a/ksrc/drivers/mpc5200_dma/Makefile b/ksrc/drivers/mpc5200_dma/Makefile
index 00d914d..6c075ae 100644
--- a/ksrc/drivers/mpc5200_dma/Makefile
+++ b/ksrc/drivers/mpc5200_dma/Makefile
@@ -3,5 +3,7 @@
 EXTRA_CFLAGS += -D__IN_XENOMAI__ -Iinclude/xenomai
 
 obj-$(CONFIG_XENO_DRIVERS_MPC5200_LPBFIFO) += xeno_rt_mpc52xx_lpbfifo.o
+obj-$(CONFIG_XENO_DRIVERS_MPC5200_DMA) += xeno_rt-fpga.o
 
 xeno_rt_mpc52xx_lpbfifo-y := rt_mpc52xx_lpbfifo.o
+xeno_rt-fpga-y := rt-fpga.o
diff --git a/ksrc/drivers/mpc5200_dma/rt-fpga.c b/ksrc/drivers/mpc5200_dma/rt-fpga.c
new file mode 100644
index 0000000..d5a9e09
--- /dev/null
+++ b/ksrc/drivers/mpc5200_dma/rt-fpga.c
@@ -0,0 +1,711 @@
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
+#include <rtdm/rt_mpc52xx_lpbfifo.h>
+#include <rtdm/rt-fpga.h>
+
+/*
+ * Some switches for testing and/or evaluation. Should be disabled
+ * in the release version of this device driver.
+ */
+
+/*
+ * CONFIG_XENO_DRIVERS_MPC5200_DMA_NO_DMA:
+ *
+ * Define to enable memcpy() for blockdata transfer instead of DMA
+ * support. This is available only for test purposes. Should be disabled
+ * in the final/release driver version.
+ */
+
+/*
+ * CONFIG_XENO_DRIVERS_MPC5200_DMA_PRINT_READ_TIME:
+ *
+ * Print min and max times consumed by the blockdata transfer, either
+ * per DMA or per memcpy. Should be disabled in the final/release driver
+ * version.
+ */
+
+/*
+ * CONFIG_XENO_DRIVERS_MPC5200_DMA_DEBUG:
+ *
+ * Define to print debug informations. Should be disabled in the
+ * final driver of course.
+ */
+
+#ifdef CONFIG_XENO_DRIVERS_MPC5200_DMA_DEBUG
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
+#ifdef CONFIG_XENO_DRIVERS_MPC5200_DMA_PRINT_READ_TIME
+static int time_min, time_max;
+#endif
+
+static void fpga_irq_task(void *arg)
+{
+	struct fpga_ctx *fpga_ctx = arg;
+	int ret;
+#ifdef CONFIG_XENO_DRIVERS_MPC5200_DMA_PRINT_READ_TIME
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
+#ifdef CONFIG_XENO_DRIVERS_MPC5200_DMA_PRINT_READ_TIME
+		old_time = rt_timer_tsc();
+#endif
+
+#ifdef CONFIG_XENO_DRIVERS_MPC5200_DMA_NO_DMA
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
+#ifdef CONFIG_XENO_DRIVERS_MPC5200_DMA_PRINT_READ_TIME
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
+	 * Check if blockdata has already been read by the application.
+	 * If not, increment the cycles_missed counter to notify this
+	 * "overrun" to the application.
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
+#ifdef CONFIG_XENO_DRIVERS_MPC5200_DMA_PRINT_READ_TIME
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
+#ifdef CONFIG_XENO_DRIVERS_MPC5200_DMA_PRINT_READ_TIME
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
+	struct fpga_ctx *fpga_ctx = (struct fpga_ctx *)context->dev_private;
+	int err = 0;
+
+	switch (request) {
+	case FPGA_READ_WORD: {
+		struct fpga_rw_word fpga_data_buf;
+		struct fpga_rw_word *fpga_data = (struct fpga_rw_word *)arg;
+		int struct_size = sizeof(struct fpga_rw_word);
+
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
+		fpga_data->value = __raw_readw(
+			(void *)fpga_ctx->info->fpga_slave + fpga_data->offset);
+
+		if (user_info)
+			err = rtdm_safe_copy_to_user(user_info, arg,
+						     &fpga_data_buf,
+						     struct_size);
+		else
+			((struct fpga_rw_word *)arg)->value = fpga_data->value;
+
+		break;
+	}
+
+	case FPGA_WRITE_WORD: {
+		struct fpga_rw_word fpga_data_buf;
+		struct fpga_rw_word *fpga_data = (struct fpga_rw_word *)arg;
+		int struct_size = sizeof(struct fpga_rw_word);
+
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
+	}
+
+	case FPGA_CONFIG: {
+		struct fpga_config fpga_data_buf;
+		struct fpga_config *fpga_data = (struct fpga_config *)arg;
+		int struct_size = sizeof(struct fpga_config);
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
+	}
+
+	case FPGA_SET_TIMEOUT: {
+		struct fpga_set_timeout fpga_data_buf;
+		struct fpga_set_timeout *fpga_data =
+			(struct fpga_set_timeout *)arg;
+		int struct_size = sizeof(struct fpga_set_timeout);
+
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
+	}
+
+	case FPGA_GET_CYCLES_MISSED: {
+		struct fpga_get_cycles_missed fpga_data_buf;
+		int struct_size = sizeof(struct fpga_get_cycles_missed);
+
+		if (user_info) {
+			fpga_data_buf.cycles_missed = fpga_ctx->cycles_missed;
+			err = rtdm_safe_copy_to_user(user_info, arg,
+						     &fpga_data_buf,
+						     struct_size);
+		} else
+			((struct fpga_get_cycles_missed *)arg)->cycles_missed =
+				fpga_ctx->cycles_missed;
+
+		/*
+		 * Reset cycles_missed and reading in process flags
+		 */
+		fpga_ctx->cycles_missed = 0;
+		fpga_ctx->reading = 0;
+		break;
+	}
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
+	{ .compatible = "anonymous,a4m2k-fpga" },
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
diff --git a/scripts/Modules.frag b/scripts/Modules.frag
index fa52b7f..74e70fd 100644
--- a/scripts/Modules.frag
+++ b/scripts/Modules.frag
@@ -22,3 +22,4 @@ DRIVERS-$(CONFIG_XENO_DRIVERS_CAN_SJA1000_PEAK_DNG) += drivers/xenomai/can/sja10
 DRIVERS-$(CONFIG_XENO_DRIVERS_CAN_SJA1000_IXXAT_PCI) += drivers/xenomai/can/sja1000/xeno_can_ixxat_pci.o
 DRIVERS-$(CONFIG_XENO_DRIVERS_CAN_SJA1000_EMS_PCI) += drivers/xenomai/can/sja1000/xeno_can_ems_pci.o
 DRIVERS-$(CONFIG_XENO_DRIVERS_MPC5200_LPBFIFO) += drivers/xenomai/mpc5200_dma/rt_mpc52xx_lpbfifo.o
+DRIVERS-$(CONFIG_XENO_DRIVERS_MPC5200_DMA) += drivers/xenomai/mpc5200_dma/rt-fpga.o
-- 
1.8.0


