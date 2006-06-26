Message-Id: <20060626172120.322015000@domain.hid>
References: <20060626172116.019532000@domain.hid>
Date: Mon, 26 Jun 2006 19:21:22 +0200
From: jan.kiszka@domain.hid
Content-Disposition: inline; filename=irqbench.patch
Subject: [Xenomai-core] [PATCH 6/6] Introduce IRQ latency benchmark
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

This patch introduces another rttesting driver, xeno_irqbench, for measuring external IRQ latencies. The irqbench device is controlled by a user-mode tool irqloop. A second tool for plain Linux, irqbench, is provided to trigger the event over serial or parallel cross-link (the latter is incomplete yet) and measure the reaction latency.

---
 configure.in                       |    1 
 include/rtdm/rttesting.h           |   38 ++
 ksrc/drivers/Makefile              |    2 
 ksrc/drivers/testing/Kconfig       |   21 +
 ksrc/drivers/testing/Makefile      |   13 -
 ksrc/drivers/testing/irqbench.c    |  472 +++++++++++++++++++++++++++++++++++++
 src/testsuite/Makefile.am          |    2 
 src/testsuite/irqbench/Makefile.am |   47 +++
 src/testsuite/irqbench/irqbench.c  |  301 +++++++++++++++++++++++
 src/testsuite/irqbench/irqloop.c   |  169 +++++++++++++
 src/testsuite/irqbench/runinfo     |    1 
 11 files changed, 1056 insertions(+), 11 deletions(-)

Index: xenomai/include/rtdm/rttesting.h
===================================================================
--- xenomai.orig/include/rtdm/rttesting.h
+++ xenomai/include/rtdm/rttesting.h
@@ -94,6 +94,28 @@ typedef struct rttst_tmbench_config {
 } rttst_tmbench_config_t;
 
 
+#define RTTST_IRQBENCH_USER_TASK    0
+#define RTTST_IRQBENCH_KERNEL_TASK  1
+#define RTTST_IRQBENCH_HANDLER      2
+
+#define RTTST_IRQBENCH_SERPORT      0
+#define RTTST_IRQBENCH_PARPORT      1
+
+struct rttst_irqbench_config {
+    int                     mode;
+    int                     priority;
+    int                     calibration_loops;
+    unsigned int            port_type;
+    unsigned long           port_ioaddr;
+    unsigned int            port_irq;
+} rttst_irqbench_config_t;
+
+struct rttst_irqbench_stats {
+    unsigned long long      irqs_received;
+    unsigned long long      irqs_acknowledged;
+} rttst_irqbench_stats_t;
+
+
 #define RTTST_SWTEST_FPU            0x1
 #define RTTST_SWTEST_USE_FPU        0x2 /* Only for kernel-space tasks. */
 
@@ -134,6 +156,22 @@ struct rttst_swtest_dir {
     _IOWR(RTIOC_TYPE_TESTING, 0x11, struct rttst_overall_bench_res)
 
 
+#define RTTST_RTIOC_IRQBENCH_START \
+    _IOW(RTIOC_TYPE_TESTING, 0x20, struct rttst_irqbench_config)
+
+#define RTTST_RTIOC_IRQBENCH_STOP \
+    _IO(RTIOC_TYPE_TESTING, 0x21)
+
+#define RTTST_RTIOC_IRQBENCH_GET_STATS \
+    _IOR(RTIOC_TYPE_TESTING, 0x22, struct rttst_irqbench_stats)
+
+#define RTTST_RTIOC_IRQBENCH_WAIT_IRQ \
+    _IO(RTIOC_TYPE_TESTING, 0x23)
+
+#define RTTST_RTIOC_IRQBENCH_REPLY_IRQ \
+    _IO(RTIOC_TYPE_TESTING, 0x24)
+
+
 #define RTTST_RTIOC_SWTEST_SET_TASKS_COUNT \
     _IOW(RTIOC_TYPE_TESTING, 0x30, unsigned long)
 
Index: xenomai/configure.in
===================================================================
--- xenomai.orig/configure.in
+++ xenomai/configure.in
@@ -602,6 +602,7 @@ AC_CONFIG_FILES([ \
        	src/testsuite/switchbench/Makefile \
        	src/testsuite/cyclic/Makefile \
        	src/testsuite/switchtest/Makefile \
+	src/testsuite/irqbench/Makefile \
        	include/Makefile \
        	include/asm-generic/Makefile \
        	include/asm-blackfin/Makefile \
Index: xenomai/ksrc/drivers/Makefile
===================================================================
--- xenomai.orig/ksrc/drivers/Makefile
+++ xenomai/ksrc/drivers/Makefile
@@ -11,7 +11,7 @@ else
 subdir-$(CONFIG_XENO_DRIVERS_16550A) += 16550A
 
 subdir-$(CONFIG_XENO_DRIVERS_TIMERBENCH) += testing
-
+subdir-$(CONFIG_XENO_DRIVERS_IRQBENCH)   += testing
 subdir-$(CONFIG_XENO_DRIVERS_SWITCHTEST) += testing
 
 include $(TOPDIR)/Rules.make
Index: xenomai/ksrc/drivers/testing/Kconfig
===================================================================
--- xenomai.orig/ksrc/drivers/testing/Kconfig
+++ xenomai/ksrc/drivers/testing/Kconfig
@@ -6,10 +6,19 @@ config XENO_DRIVERS_TIMERBENCH
 	Kernel-based benchmark driver for timer latency evaluation.
 	See testsuite/latency for a possible front-end.
 
+config XENO_DRIVERS_IRQBENCH
+	depends on XENO_SKIN_RTDM
+	tristate "IRQ benchmark driver"
+	default n
+	help
+	Loopback driver for IRQ latency evaluation over serial or parallel
+	port links. Additionally requires user-space helper and a logging tool
+	(see testsuite/irqbench).
+
 config XENO_DRIVERS_SWITCHTEST
-        depends on XENO_SKIN_RTDM
-        tristate "Context switch unit testing driver"
-        default n
-        help
-        Kernel-based driver for unit testing context switches and 
-        FPU switches.
+	depends on XENO_SKIN_RTDM
+	tristate "Context switch unit testing driver"
+	default n
+	help
+	Kernel-based driver for unit testing context switches and
+	FPU switches.
Index: xenomai/ksrc/drivers/testing/Makefile
===================================================================
--- xenomai.orig/ksrc/drivers/testing/Makefile
+++ xenomai/ksrc/drivers/testing/Makefile
@@ -5,11 +5,13 @@ ifeq ($(PATCHLEVEL),6)
 EXTRA_CFLAGS += -Iinclude/xenomai
 
 obj-$(CONFIG_XENO_DRIVERS_TIMERBENCH) += xeno_timerbench.o
-
+obj-$(CONFIG_XENO_DRIVERS_IRQBENCH)   += xeno_irqbench.o
 obj-$(CONFIG_XENO_DRIVERS_SWITCHTEST) += xeno_switchtest.o
 
 xeno_timerbench-y := timerbench.o
 
+xeno_irqbench-y := irqbench.o
+
 xeno_switchtest-y := switchtest.o
 
 EXTRA_CFLAGS += -Iinclude/xenomai
@@ -21,14 +23,16 @@ else
 O_TARGET := built-in.o
 
 obj-$(CONFIG_XENO_DRIVERS_TIMERBENCH) += xeno_timerbench.o
-
+obj-$(CONFIG_XENO_DRIVERS_IRQBENCH)   += xeno_irqbench.o
 obj-$(CONFIG_XENO_DRIVERS_SWITCHTEST) += xeno_switchtest.o
 
 xeno_timerbench-objs := timerbench.o
 
+xeno_irqbench-objs := irqbench.o
+
 xeno_switchtest-objs := switchtest.o
 
-export-objs := $(xeno_timerbench-objs) $(xeno_switchtest-objs)
+export-objs := $(xeno_timerbench-objs) $(xeno_irqbench-objs) $(xeno_switchtest-objs)
 
 EXTRA_CFLAGS += -I$(TOPDIR)/include/xenomai -I$(TOPDIR)/include/xenomai/compat
 
@@ -37,6 +41,9 @@ include $(TOPDIR)/Rules.make
 xeno_timerbench.o: $(xeno_timerbench-objs)
 	$(LD) -r -o $@ $(xeno_timerbench-objs)
 
+xeno_irqbench.o: $(xeno_irqbench-objs)
+	$(LD) -r -o $@ $(xeno_irqbench-objs)
+
 xeno_switchtest.o: $(xeno_switchtest-objs)
 	$(LD) -r -o $@ $(xeno_switchtest-objs)
 
Index: xenomai/ksrc/drivers/testing/irqbench.c
===================================================================
--- /dev/null
+++ xenomai/ksrc/drivers/testing/irqbench.c
@@ -0,0 +1,472 @@
+/*
+ * Copyright (C) 2006 Jan Kiszka <jan.kiszka@domain.hid>.
+ *
+ * Xenomai is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * Xenomai is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with Xenomai; if not, write to the Free Software Foundation,
+ * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ */
+
+#include <linux/module.h>
+#include <asm/semaphore.h>
+
+#include <rtdm/rttesting.h>
+#include <rtdm/rtdm_driver.h>
+#include <nucleus/trace.h>
+
+/* --- Serial port --- */
+
+#define MSR_DCTS                0x01
+#define MSR_DDSR                0x02
+#define MSR_DDCD                0x08
+
+#define MCR_RTS                 0x02
+#define MCR_OUT2                0x08
+
+#define IER_MODEM               0x08
+
+#define RHR(ctx) (ctx->port_ioaddr + 0) /* Receive Holding Buffer */
+#define IER(ctx) (ctx->port_ioaddr + 1) /* Interrupt Enable Register */
+#define IIR(ctx) (ctx->port_ioaddr + 2) /* Interrupt Id Register */
+#define LCR(ctx) (ctx->port_ioaddr + 3) /* Line Control Register */
+#define MCR(ctx) (ctx->port_ioaddr + 4) /* Modem Control Register */
+#define LSR(ctx) (ctx->port_ioaddr + 5) /* Line Status Register */
+#define MSR(ctx) (ctx->port_ioaddr + 6) /* Modem Status Register */
+
+/* --- Parallel port --- */
+
+#define CTRL_INIT               0x04
+
+#define STAT_STROBE             0x10
+
+#define DATA(ctx) (ctx->port_ioaddr + 0) /* Data register */
+#define STAT(ctx) (ctx->port_ioaddr + 1) /* Status register */
+#define CTRL(ctx) (ctx->port_ioaddr + 2) /* Control register */
+
+struct rt_irqbench_context {
+    int                         mode;
+    int                         port_type;
+    unsigned long               port_ioaddr;
+    unsigned int                toggle;
+    struct rttst_irqbench_stats stats;
+    rtdm_irq_t                  irq_handle;
+    rtdm_event_t                irq_event;
+    rtdm_task_t                 irq_task;
+    struct semaphore            nrt_mutex;
+};
+
+static unsigned int start_index;
+
+module_param(start_index, uint, 0400);
+MODULE_PARM_DESC(start_index, "First device instance number to be used");
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("jan.kiszka@domain.hid");
+
+
+static inline int rt_irqbench_check_irq(struct rt_irqbench_context *ctx)
+{
+    int status;
+
+
+    switch (ctx->port_type) {
+        case RTTST_IRQBENCH_SERPORT:
+            status = inb(MSR(ctx));
+            if (status & (MSR_DDSR | MSR_DDCD))
+                xntrace_user_freeze(0, 0);
+            if (!(status & MSR_DCTS))
+                return 0;
+            break;
+
+        case RTTST_IRQBENCH_PARPORT:
+            // todo
+            break;
+    }
+    ctx->stats.irqs_received++;
+    return 1;
+}
+
+
+static inline void rt_irqbench_hwreply(struct rt_irqbench_context *ctx)
+{
+    switch (ctx->port_type) {
+        case RTTST_IRQBENCH_SERPORT:
+            /* toggle RTS */
+            ctx->toggle ^= MCR_RTS;
+            outb(ctx->toggle, MCR(ctx));
+            break;
+
+        case RTTST_IRQBENCH_PARPORT:
+            ctx->toggle ^= 0xFF;
+            outb(ctx->toggle, DATA(ctx));
+            break;
+    }
+    xntrace_special(0xBE, 0);
+    ctx->stats.irqs_acknowledged++;
+}
+
+
+static void rt_irqbench_task(void *arg)
+{
+    struct rt_irqbench_context *ctx = (struct rt_irqbench_context *)arg;
+
+
+    while (1) {
+        if (rtdm_event_wait(&ctx->irq_event) < 0)
+            return;
+        rt_irqbench_hwreply(ctx);
+    }
+}
+
+
+static int rt_irqbench_task_irq(rtdm_irq_t *irq_handle)
+{
+    struct rt_irqbench_context *ctx;
+
+
+    ctx = rtdm_irq_get_arg(irq_handle, struct rt_irqbench_context);
+
+    if (rt_irqbench_check_irq(ctx))
+        rtdm_event_signal(&ctx->irq_event);
+
+    return RTDM_IRQ_HANDLED;
+}
+
+
+static int rt_irqbench_direct_irq(rtdm_irq_t *irq_handle)
+{
+    struct rt_irqbench_context *ctx;
+
+
+    ctx = rtdm_irq_get_arg(irq_handle, struct rt_irqbench_context);
+
+    if (rt_irqbench_check_irq(ctx))
+        rt_irqbench_hwreply(ctx);
+
+    return RTDM_IRQ_HANDLED;
+}
+
+
+static int rt_irqbench_stop(struct rt_irqbench_context *ctx)
+{
+    if (ctx->mode < 0)
+        return -EINVAL;
+
+    /* Disable hardware */
+    switch (ctx->port_type) {
+        case RTTST_IRQBENCH_SERPORT:
+            outb(0, IER(ctx));
+            break;
+
+        case RTTST_IRQBENCH_PARPORT:
+            outb(0, CTRL(ctx));
+            break;
+    }
+
+    rtdm_irq_free(&ctx->irq_handle);
+
+    if (ctx->mode == RTTST_IRQBENCH_KERNEL_TASK)
+        rtdm_task_destroy(&ctx->irq_task);
+
+    ctx->mode = -1;
+
+    return 0;
+}
+
+
+static int rt_irqbench_open(struct rtdm_dev_context *context,
+                            rtdm_user_info_t *user_info, int oflags)
+{
+    struct rt_irqbench_context  *ctx;
+
+
+    ctx = (struct rt_irqbench_context *)context->dev_private;
+
+    ctx->mode = -1;
+    rtdm_event_init(&ctx->irq_event, 0);
+    init_MUTEX(&ctx->nrt_mutex);
+
+    return 0;
+}
+
+
+static int rt_irqbench_close(struct rtdm_dev_context *context,
+                             rtdm_user_info_t *user_info)
+{
+    struct rt_irqbench_context  *ctx;
+
+
+    ctx = (struct rt_irqbench_context *)context->dev_private;
+
+    down(&ctx->nrt_mutex);
+    rt_irqbench_stop(ctx);
+    rtdm_event_destroy(&ctx->irq_event);
+    up(&ctx->nrt_mutex);
+
+    return 0;
+}
+
+
+static int rt_irqbench_ioctl_nrt(struct rtdm_dev_context *context,
+                                 rtdm_user_info_t *user_info, int request,
+                                 void *arg)
+{
+    struct rt_irqbench_context  *ctx;
+    int                         ret = 0;
+
+
+    ctx = (struct rt_irqbench_context *)context->dev_private;
+
+    switch (request) {
+        case RTTST_RTIOC_IRQBENCH_START: {
+            struct rttst_irqbench_config config_buf;
+            struct rttst_irqbench_config *config;
+
+            config = (struct rttst_irqbench_config *)arg;
+            if (user_info) {
+                if (!rtdm_read_user_ok(user_info, arg,
+                                    sizeof(struct rttst_irqbench_config)) ||
+                    rtdm_copy_from_user(user_info, &config_buf, arg,
+                                        sizeof(struct rttst_irqbench_config)))
+                    return -EFAULT;
+
+                config = &config_buf;
+            }
+
+            if (config->port_type > RTTST_IRQBENCH_PARPORT)
+                return -EINVAL;
+
+            down(&ctx->nrt_mutex);
+
+            if (test_bit(RTDM_CLOSING, &context->context_flags))
+                goto unlock_start_out;
+
+            switch (config->mode) {
+                case RTTST_IRQBENCH_USER_TASK:
+                    ret = rtdm_irq_request(&ctx->irq_handle, config->port_irq,
+                                           rt_irqbench_task_irq, 0,
+                                           "irqbench", ctx);
+                    break;
+
+                case RTTST_IRQBENCH_KERNEL_TASK:
+                    ret = rtdm_irq_request(&ctx->irq_handle, config->port_irq,
+                                           rt_irqbench_task_irq, 0,
+                                           "irqbench", ctx);
+                    if (ret < 0)
+                        goto unlock_start_out;
+
+                    ret = rtdm_task_init(&ctx->irq_task, "irqbench",
+                                         rt_irqbench_task, ctx,
+                                         config->priority, 0);
+                    if (ret < 0)
+                        rtdm_irq_free(&ctx->irq_handle);
+                    break;
+
+                case RTTST_IRQBENCH_HANDLER:
+                    ret = rtdm_irq_request(&ctx->irq_handle, config->port_irq,
+                                           rt_irqbench_direct_irq, 0,
+                                           "irqbench", ctx);
+                    break;
+
+                default:
+                    ret = -EINVAL;
+                    break;
+            }
+            if (ret < 0)
+                goto unlock_start_out;
+
+            rtdm_irq_enable(&ctx->irq_handle);
+
+            ctx->mode = config->mode;
+
+            memset(&ctx->stats, 0, sizeof(ctx->stats));
+
+            ctx->port_type   = config->port_type;
+            ctx->port_ioaddr = config->port_ioaddr;
+
+            /* Initialise hardware */
+            switch (ctx->port_type) {
+                case RTTST_IRQBENCH_SERPORT:
+                    ctx->toggle = MCR_OUT2;
+
+                    /* Reset DLAB, reset RTS, enable OUT2 */
+                    outb(0, LCR(ctx));
+                    outb(MCR_OUT2, MCR(ctx));
+
+                    /* Mask all UART interrupts and clear pending ones. */
+                    outb(0, IER(ctx));
+                    inb(IIR(ctx));
+                    inb(LSR(ctx));
+                    inb(RHR(ctx));
+                    inb(MSR(ctx));
+                    break;
+
+                case RTTST_IRQBENCH_PARPORT:
+                    ctx->toggle = 0xAA;
+                    outb(0xAA, DATA(ctx));
+                    outb(CTRL_INIT, CTRL(ctx));
+                    break;
+            }
+
+            // calibration
+
+            /* Arm IRQ */
+            switch (ctx->port_type) {
+                case RTTST_IRQBENCH_SERPORT:
+                    outb(IER_MODEM, IER(ctx));
+                    break;
+
+                case RTTST_IRQBENCH_PARPORT:
+                    outb(STAT_STROBE, CTRL(ctx));
+                    break;
+            }
+
+          unlock_start_out:
+            up(&ctx->nrt_mutex);
+            break;
+        }
+
+        case RTTST_RTIOC_IRQBENCH_STOP:
+            down(&ctx->nrt_mutex);
+            ret = rt_irqbench_stop(ctx);
+            up(&ctx->nrt_mutex);
+            break;
+
+        case RTTST_RTIOC_IRQBENCH_GET_STATS: {
+            struct rttst_irqbench_stats *usr_stats;
+
+            usr_stats = (struct rttst_irqbench_stats *)arg;
+
+            if (user_info) {
+                if (!rtdm_rw_user_ok(user_info, usr_stats,
+                                     sizeof(struct rttst_irqbench_stats)) ||
+                    rtdm_copy_to_user(user_info, usr_stats,
+                                      &ctx->stats,
+                                      sizeof(struct rttst_irqbench_stats)))
+                    ret = -EFAULT;
+            } else
+                *usr_stats = ctx->stats;
+            break;
+        }
+
+        case RTTST_RTIOC_IRQBENCH_WAIT_IRQ:
+            ret = -ENOSYS;
+            break;
+
+        case RTTST_RTIOC_IRQBENCH_REPLY_IRQ:
+            rt_irqbench_hwreply(ctx);
+            break;
+
+        default:
+            ret = -ENOTTY;
+    }
+
+    return ret;
+}
+
+
+static int rt_irqbench_ioctl_rt(struct rtdm_dev_context *context,
+                                rtdm_user_info_t *user_info, int request,
+                                void *arg)
+{
+    struct rt_irqbench_context  *ctx;
+    int                         ret = 0;
+
+
+    ctx = (struct rt_irqbench_context *)context->dev_private;
+
+    switch (request) {
+        case RTTST_RTIOC_IRQBENCH_WAIT_IRQ:
+            ret = rtdm_event_wait(&ctx->irq_event);
+            break;
+
+        case RTTST_RTIOC_IRQBENCH_REPLY_IRQ:
+            rt_irqbench_hwreply(ctx);
+            break;
+
+        case RTTST_RTIOC_IRQBENCH_START:
+        case RTTST_RTIOC_IRQBENCH_STOP:
+        case RTTST_RTIOC_IRQBENCH_GET_STATS:
+            ret = -ENOSYS;
+            break;
+
+        default:
+            ret = -ENOTTY;
+    }
+
+    return ret;
+}
+
+
+static struct rtdm_device device = {
+    struct_version:     RTDM_DEVICE_STRUCT_VER,
+
+    device_flags:       RTDM_NAMED_DEVICE,
+    context_size:       sizeof(struct rt_irqbench_context),
+    device_name:        "",
+
+    open_rt:            NULL,
+    open_nrt:           rt_irqbench_open,
+
+    ops: {
+        close_rt:       NULL,
+        close_nrt:      rt_irqbench_close,
+
+        ioctl_rt:       rt_irqbench_ioctl_rt,
+        ioctl_nrt:      rt_irqbench_ioctl_nrt,
+
+        read_rt:        NULL,
+        read_nrt:       NULL,
+
+        write_rt:       NULL,
+        write_nrt:      NULL,
+
+        recvmsg_rt:     NULL,
+        recvmsg_nrt:    NULL,
+
+        sendmsg_rt:     NULL,
+        sendmsg_nrt:    NULL,
+    },
+
+    device_class:       RTDM_CLASS_TESTING,
+    device_sub_class:   RTDM_SUBCLASS_IRQBENCH,
+    driver_name:        "xeno_irqbench",
+    driver_version:     RTDM_DRIVER_VER(0, 1, 0),
+    peripheral_name:    "IRQ Latency Benchmark",
+    provider_name:      "Jan Kiszka",
+    proc_name:          device.device_name,
+};
+
+int __init __timerbench_init(void)
+{
+    int ret;
+
+    do {
+        snprintf(device.device_name, RTDM_MAX_DEVNAME_LEN, "rttest%d",
+                 start_index);
+        ret = rtdm_dev_register(&device);
+
+        start_index++;
+    } while (ret == -EEXIST);
+
+    return ret;
+}
+
+
+void __exit __timerbench_exit(void)
+{
+    rtdm_dev_unregister(&device, 1000);
+}
+
+
+module_init(__timerbench_init);
+module_exit(__timerbench_exit);
Index: xenomai/src/testsuite/Makefile.am
===================================================================
--- xenomai.orig/src/testsuite/Makefile.am
+++ xenomai/src/testsuite/Makefile.am
@@ -1 +1 @@
-SUBDIRS = latency switchbench cyclic switchtest
+SUBDIRS = latency switchbench cyclic switchtest irqbench
Index: xenomai/src/testsuite/irqbench/Makefile.am
===================================================================
--- /dev/null
+++ xenomai/src/testsuite/irqbench/Makefile.am
@@ -0,0 +1,47 @@
+testdir = $(prefix)/testsuite/irqbench
+
+test_PROGRAMS = irqloop
+
+ifeq ($(XENO_TARGET_ARCH),i386)
+test_PROGRAMS += irqbench
+endif
+
+
+irqloop_SOURCES = irqloop.c
+
+irqloop_CPPFLAGS = \
+	-I$(top_srcdir)/include/posix \
+	$(XENO_USER_CFLAGS) \
+	-I$(top_srcdir)/include
+
+irqloop_LDFLAGS = \
+	$(XENO_POSIX_WRAPPERS) \
+	$(XENO_USER_LDFLAGS)
+
+irqloop_LDADD = \
+	-lpthread \
+	../../skins/posix/.libs/libpthread_rt.a
+
+
+irqbench_SOURCES = irqbench.c
+
+irqbench_CPPFLAGS = \
+	$(XENO_USER_CFLAGS) \
+	-I$(top_srcdir)/include
+
+irqbench_LDFLAGS = $(XENO_USER_LDFLAGS)
+
+
+install-data-local:
+	$(mkinstalldirs) $(DESTDIR)$(testdir)
+	$(INSTALL_DATA) $(srcdir)/runinfo $(DESTDIR)$(testdir)/.runinfo
+	@echo "\$${DESTDIR}$(prefix)/bin/xeno-load \$$*" > $(DESTDIR)$(testdir)/run
+	@chmod +x $(DESTDIR)$(testdir)/run
+
+uninstall-local:
+	$(RM) $(DESTDIR)$(testdir)/.runinfo $(DESTDIR)$(testdir)/run
+
+run: all
+	@$(top_srcdir)/scripts/xeno-load --verbose
+
+EXTRA_DIST = runinfo
Index: xenomai/src/testsuite/irqbench/irqbench.c
===================================================================
--- /dev/null
+++ xenomai/src/testsuite/irqbench/irqbench.c
@@ -0,0 +1,301 @@
+/*
+ * Copyright (C) 2006 Jan Kiszka <jan.kiszka@domain.hid>.
+ *
+ * Xenomai is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * Xenomai is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with Xenomai; if not, write to the Free Software Foundation,
+ * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ */
+
+#include <limits.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <signal.h>
+#include <unistd.h>
+#include <sys/io.h>
+#include <sys/mman.h>
+
+
+#define SERPORT                 0
+#define PARPORT                 1
+
+/* --- Serial port --- */
+
+#define MCR_DTR                 0x01
+#define MCR_RTS                 0x02
+#define MCR_OUT2                0x08
+
+#define MSR_DELTA               0x0F
+
+#define LCR(base) (base + 3) /* Line Control Register */
+#define MCR(base) (base + 4) /* Modem Control Register */
+#define LSR(base) (base + 5) /* Line Status Register */
+#define MSR(base) (base + 6) /* Modem Status Register */
+
+/* --- Parallel port --- */
+
+#define CTRL_INIT               0x04
+
+#define STAT_STROBE             0x10
+
+#define DATA(base) (base + 0) /* Data register */
+#define STAT(base) (base + 1) /* Status register */
+#define CTRL(base) (base + 2) /* Control register */
+
+double tsc2ns_scale;
+long long min_lat = LLONG_MAX;
+long long max_lat = LLONG_MIN;
+long long avg_lat = 0;
+long outer_loops = 0;
+int warmup = 1;
+
+static inline long long rdtsc(void)
+{
+    unsigned long long tsc;
+
+    __asm__ __volatile__("rdtsc" : "=A" (tsc));
+    return tsc;
+}
+
+
+static long tsc2ns(long long tsc)
+{
+    if ((tsc > LONG_MAX) || (tsc < LONG_MIN)) {
+        fprintf(stderr, "irqbench: overflow (%lld ns)!\n",
+                (long long)(tsc2ns_scale * (double)tsc));
+        exit(2);
+    }
+    return (long)(tsc2ns_scale * (double)tsc);
+}
+
+
+static inline long long ns2tsc(long long ns)
+{
+    return (long long)(((double)ns) / tsc2ns_scale);
+}
+
+
+void calibrate_tsc(void)
+{
+    FILE *proc;
+    char *lineptr = NULL;
+    size_t len;
+    double cpu_mhz;
+
+    proc = fopen("/proc/cpuinfo", "r");
+    if (proc == NULL) {
+        perror("irqbench: Unable to open /proc/cpuinfo");
+        exit(1);
+    }
+
+    while (getline(&lineptr, &len, proc) != -1)
+        if (strncmp(lineptr, "cpu MHz", 7) == 0) {
+            sscanf(strchr(lineptr, ':') + 1, "%lf", &cpu_mhz);
+            break;
+        }
+
+    if (lineptr)
+        free(lineptr);
+    fclose(proc);
+
+    printf("CPU frequency: %.3lf MHz\n", cpu_mhz);
+
+    tsc2ns_scale = 1000.0 / cpu_mhz;
+}
+
+
+void sighand(int signal)
+{
+    if (!warmup) {
+        avg_lat /= outer_loops;
+        printf("---\n%.3f / %.3f / %.3f us\n",
+               ((double)min_lat) / 1000.0, ((double)avg_lat) / 1000.0,
+               ((double)max_lat) / 1000.0);
+    }
+    exit(0);
+}
+
+
+int main(int argc, char *argv[])
+{
+    int             port_type   = SERPORT;
+    unsigned long   port_ioaddr = 0x3F8;
+    long long       period = 100000;
+    long long       timeout;
+    long long       start, delay;
+    unsigned int    toggle;
+    int             trigger_trace = 0;
+    int             c;
+
+
+    signal(SIGINT, sighand);
+    signal(SIGTERM, sighand);
+    signal(SIGHUP, sighand);
+    signal(SIGALRM, sighand);
+
+    calibrate_tsc();
+
+    while ((c = getopt(argc,argv,"p:T:o:a:f")) != EOF)
+        switch (c) {
+            case 'p':
+                period = atoi(optarg) * 1000;
+                break;
+
+            case 'T':
+                alarm(atoi(optarg));
+                break;
+
+            case 'o':
+                port_type = atoi(optarg);
+                break;
+
+            case 'a':
+                port_ioaddr = strtol(optarg, NULL,
+                    (strncmp(optarg, "0x", 2) == 0) ? 16 : 10);
+                break;
+
+            case 'f':
+                trigger_trace = 1;
+                break;
+
+            default:
+                fprintf(stderr, "usage: irqbench [options]\n"
+                        "  [-p <period_us>]             # signal period, default=100 us\n"
+                        "  [-T <test_duration_seconds>] # default=0, so ^C to end\n"
+                        "  [-o <port_type>]             # 0=serial (default), 1=parallel\n"
+                        "  [-a <port_io_address>]       # default=0x3f8\n"
+                        "  [-f]                         # freeze trace for each new max latency\n");
+                exit(2);
+        }
+
+    if (iopl(3) < 0) {
+        fprintf(stderr, "irqbench: superuser permissions required\n");
+        exit(1);
+    }
+    mlockall(MCL_CURRENT | MCL_FUTURE);
+
+    switch (port_type) {
+        case SERPORT:
+            toggle = MCR_OUT2;
+            inb(MSR(port_ioaddr));
+            break;
+
+        case PARPORT:
+            toggle = 0xAA;
+            outb(0xAA, DATA(port_ioaddr));
+            outb(CTRL_INIT, CTRL(port_ioaddr));
+            break;
+
+        default:
+            fprintf(stderr, "irqbench: invalid port type\n");
+            exit(1);
+    }
+
+    period = ns2tsc(period);
+
+    printf("Port type:     %s\n"
+           "Port address:  0x%lx\n\n",
+           (port_type == SERPORT) ? "serial" : "parallel", port_ioaddr);
+
+    printf("Waiting on target...\n");
+
+    while (1)
+        if (port_type ==  SERPORT) {
+            toggle ^= MCR_RTS;
+            outb(toggle, MCR(port_ioaddr));
+            usleep(100000);
+            if ((inb(MSR(port_ioaddr)) & MSR_DELTA) != 0)
+                break;
+        } else {
+            int status = inb(STAT(port_ioaddr));
+
+            toggle ^= 0xFF;
+            outb(toggle, DATA(port_ioaddr));
+            if (inb(STAT(port_ioaddr)) != status)
+                break;
+        }
+
+    printf("Warming up...\n");
+
+    while (1) {
+        long long loop_timeout = rdtsc() + ns2tsc(1000000000LL);
+        long loop_avg = 0;
+        int inner_loops;
+
+        for (inner_loops = 0; rdtsc() < loop_timeout; inner_loops++) {
+            long lat;
+
+            __asm__ __volatile__("cli");
+
+            if (port_type ==  SERPORT) {
+                start = rdtsc();
+
+                toggle ^= MCR_RTS;
+                outb(toggle, MCR(port_ioaddr));
+
+                timeout = start + period * 100;
+                while (((inb(MSR(port_ioaddr)) & MSR_DELTA) == 0) &&
+                       (rdtsc() < timeout));
+
+                delay = rdtsc() - start;
+            } else {
+                int status = inb(STAT(port_ioaddr));
+
+                start = rdtsc();
+
+                toggle ^= 0xFF;
+                outb(toggle, DATA(port_ioaddr));
+
+                timeout = start + period * 100;
+                while ((inb(STAT(port_ioaddr)) == status) &&
+                       (rdtsc() < timeout));
+
+                delay = rdtsc() - start;
+            }
+
+            if (!warmup) {
+                lat = tsc2ns(delay);
+
+                loop_avg += lat;
+                if (lat < min_lat)
+                    min_lat = lat;
+                if (lat > max_lat) {
+                    max_lat = lat;
+                    if (trigger_trace) {
+                        if (port_type == SERPORT) {
+                            toggle ^= MCR_DTR;
+                            outb(toggle, MCR(port_ioaddr));
+                        } else {
+                            // todo
+                        }
+                    }
+                }
+            }
+
+            __asm__ __volatile__("sti");
+
+            while (rdtsc() < start + period);
+        }
+        if (!warmup) {
+            loop_avg /= inner_loops;
+
+            printf("%.3f / %.3f / %.3f us\n",
+                ((double)min_lat) / 1000.0, ((double)loop_avg) / 1000.0,
+                ((double)max_lat) / 1000.0);
+
+            avg_lat += loop_avg;
+            outer_loops++;
+        } else
+            warmup = 0;
+    }
+}
Index: xenomai/src/testsuite/irqbench/irqloop.c
===================================================================
--- /dev/null
+++ xenomai/src/testsuite/irqbench/irqloop.c
@@ -0,0 +1,169 @@
+/*
+ * Copyright (C) 2006 Jan Kiszka <jan.kiszka@domain.hid>.
+ *
+ * Xenomai is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * Xenomai is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with Xenomai; if not, write to the Free Software Foundation,
+ * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <pthread.h>
+#include <unistd.h>
+#include <sys/mman.h>
+#include <rtdm/rttesting.h>
+
+static int benchdev;
+static int terminate;
+
+void *irq_thread(void *arg)
+{
+    while (1) {
+        if (ioctl(benchdev, RTTST_RTIOC_IRQBENCH_WAIT_IRQ) ||
+            ioctl(benchdev, RTTST_RTIOC_IRQBENCH_REPLY_IRQ))
+            return NULL;
+    }
+}
+
+
+void sighand(int sig)
+{
+    terminate = 1;
+}
+
+
+int main(int argc, char *argv[])
+{
+    const char *mode_name[] =
+        { "user-space task", "kernel-space task", "IRQ handler" };
+    const char *port_type_name[] = { "serial", "parallel" };
+    char devname[RTDM_MAX_DEVNAME_LEN];
+    int benchdev_no = 0;
+    struct rttst_irqbench_config config = {
+        mode:               RTTST_IRQBENCH_USER_TASK,
+        priority:           sched_get_priority_max(SCHED_FIFO),
+        calibration_loops:  0,
+        port_type:          RTTST_IRQBENCH_SERPORT,
+        port_ioaddr:        0x3f8,
+        port_irq:           4
+    };
+    struct rttst_irqbench_stats stats;
+    unsigned long long last_received = 0;
+    pthread_t thr;
+    int c;
+
+
+    while ((c = getopt(argc,argv,"D:t:P:o:a:i:")) != EOF)
+        switch (c) {
+            case 'D':
+                benchdev_no = atoi(optarg);
+                break;
+
+            case 't':
+                config.mode = atoi(optarg);
+                break;
+
+            case 'P':
+                config.priority = atoi(optarg);
+                break;
+
+            case 'o':
+                config.port_type = atoi(optarg);
+                break;
+
+            case 'a':
+                config.port_ioaddr = strtol(optarg, NULL,
+                    (strncmp(optarg, "0x", 2) == 0) ? 16 : 10);
+                break;
+
+            case 'i':
+                config.port_irq = atoi(optarg);
+                break;
+
+            default:
+                fprintf(stderr, "usage: irqloop [options]\n"
+                        "  [-D <testing_device_no>] # number of testing device, default=0\n"
+                        "  [-t <test_mode>]         # 0=user task (default), 1=kernel task, 2=IRQ\n"
+                        "  [-P <priority>]          # task priority (test mode 0 and 1 only)\n"
+                        "  [-o <port_type>]         # 0=serial (default), 1=parallel\n"
+                        "  [-a <port_io_address>]   # default=0x3f8\n"
+                        "  [-i <port_irq>]          # default=4\n");
+                exit(2);
+        }
+
+    signal(SIGINT, sighand);
+    signal(SIGTERM, sighand);
+    signal(SIGHUP, sighand);
+
+    mlockall(MCL_CURRENT|MCL_FUTURE);
+
+    snprintf(devname, RTDM_MAX_DEVNAME_LEN, "/dev/rttest%d", benchdev_no);
+    benchdev = open(devname, O_RDWR);
+    if (benchdev < 0) {
+        perror("irqloop: failed to open benchmark device");
+        fprintf(stderr, "(modprobe xeno_irqbench?)\n");
+        return 1;
+    }
+
+    if (config.mode == RTTST_IRQBENCH_USER_TASK) {
+        pthread_attr_t attr;
+        struct sched_param param;
+
+        pthread_attr_init(&attr);
+        pthread_attr_setinheritsched(&attr, PTHREAD_EXPLICIT_SCHED);
+        pthread_attr_setschedpolicy(&attr, SCHED_FIFO);
+        param.sched_priority = config.priority;
+        pthread_attr_setschedparam(&attr, &param);
+        pthread_attr_setstacksize(&attr, PTHREAD_STACK_MIN);
+
+        pthread_create(&thr, &attr, irq_thread, NULL);
+    }
+
+    if (ioctl(benchdev, RTTST_RTIOC_IRQBENCH_START, &config)) {
+        perror("irqloop: error starting test");
+        goto cleanup;
+    }
+
+    printf("Test mode:    %s\n"
+           "Port type:    %s\n"
+           "Port address: 0x%lx\n"
+           "Port IRQ:     %d\n\n\n\n",
+           mode_name[config.mode], port_type_name[config.port_type],
+           config.port_ioaddr, config.port_irq);
+
+    while (!terminate) {
+        if (ioctl(benchdev, RTTST_RTIOC_IRQBENCH_GET_STATS, &stats) < 0) {
+            perror("irqloop: error reading stats");
+            break;
+        }
+
+        if ((last_received > 0) && (stats.irqs_received == last_received))
+            break; /* timed out */
+        last_received = stats.irqs_received;
+
+        printf("\033[2AReceived IRQs:     %lld\nAcknowledged IRQs: %lld\n",
+                stats.irqs_received, stats.irqs_acknowledged);
+        usleep(250000);
+    }
+
+    ioctl(benchdev, RTTST_RTIOC_IRQBENCH_STOP);
+
+  cleanup:
+    close(benchdev);
+    if (config.mode == RTTST_IRQBENCH_USER_TASK) {
+        pthread_cancel(thr);
+        pthread_join(thr, NULL);
+    }
+
+    return 0;
+}
Index: xenomai/src/testsuite/irqbench/runinfo
===================================================================
--- /dev/null
+++ xenomai/src/testsuite/irqbench/runinfo
@@ -0,0 +1 @@
+irqloop:posix+rtdm+irqbench:!./irqloop;popall:control_c

--

