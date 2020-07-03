From: chensong <chensong@tj.kylinos.cn>
Subject: [PATCH 2/2] kernel/driver/testing: Driver of gpio loopback benchmark
Date: Fri,  3 Jul 2020 14:37:48 +0800
Message-Id: <1593758268-9284-1-git-send-email-chensong@tj.kylinos.cn>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: chensong <chensong@kylinos.cn>

From: chensong <chensong@kylinos.cn>

1, request 2 gpio ports, one is output, the other is interrupt
   connect them with a cable, once there is a signal in output,
   an interrupt will be raised
2, an interrupt handler
3, write_rt, read_rt for app to get timestamp
4, record timestamp in write_rt and interrupt handler respectively,
   it's the latency in kernel space(inner_loop)

Signed-off-by: chensong <chensong@kylinos.cn>
---
 kernel/drivers/testing/Kconfig     |   7 +
 kernel/drivers/testing/Makefile    |   3 +
 kernel/drivers/testing/gpiobench.c | 288 +++++++++++++++++++++++++++++++++++++
 3 files changed, 298 insertions(+)
 create mode 100644 kernel/drivers/testing/gpiobench.c

diff --git a/kernel/drivers/testing/Kconfig b/kernel/drivers/testing/Kconfig
index 88c043c..fd215ec 100644
--- a/kernel/drivers/testing/Kconfig
+++ b/kernel/drivers/testing/Kconfig
@@ -26,4 +26,11 @@ config XENO_DRIVERS_RTDMTEST
 	help
 	Kernel driver for performing RTDM unit tests.
 
+config XENO_DRIVERS_GPIOBENCH
+	tristate "GPIO benchmark driver"
+	default m
+	help
+	Kernel-based benchmark driver for gpio loopback latency evaluation.
+	See testsuite/gpiobench for a possible front-end.
+
 endmenu
diff --git a/kernel/drivers/testing/Makefile b/kernel/drivers/testing/Makefile
index 09b0763..fc05d9d 100644
--- a/kernel/drivers/testing/Makefile
+++ b/kernel/drivers/testing/Makefile
@@ -3,6 +3,7 @@ obj-$(CONFIG_XENO_DRIVERS_TIMERBENCH) += xeno_timerbench.o
 obj-$(CONFIG_XENO_DRIVERS_SWITCHTEST) += xeno_switchtest.o
 obj-$(CONFIG_XENO_DRIVERS_RTDMTEST)   += xeno_rtdmtest.o
 obj-$(CONFIG_XENO_DRIVERS_HEAPCHECK)   += xeno_heapcheck.o
+obj-$(CONFIG_XENO_DRIVERS_GPIOBENCH) += xeno_gpiobench.o
 
 xeno_timerbench-y := timerbench.o
 
@@ -11,3 +12,5 @@ xeno_switchtest-y := switchtest.o
 xeno_rtdmtest-y := rtdmtest.o
 
 xeno_heapcheck-y := heapcheck.o
+
+xeno_gpiobench-y := gpiobench.o
diff --git a/kernel/drivers/testing/gpiobench.c b/kernel/drivers/testing/gpiobench.c
new file mode 100644
index 0000000..af86565
--- /dev/null
+++ b/kernel/drivers/testing/gpiobench.c
@@ -0,0 +1,288 @@
+/*
+ * Copyright (C) 2020 chensong <chensong@tj.kylinos.cn>.
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/proc_fs.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/device.h>
+#include <linux/gpio.h>
+#include <linux/irq.h>
+#include <linux/slab.h>
+#include <linux/err.h>
+#include <rtdm/driver.h>
+#include <linux/delay.h>
+
+#include <linux/compiler.h>
+#include <linux/device.h>
+#include <linux/fs.h>
+#include <linux/uaccess.h>
+
+#include <linux/ipipe_trace.h>
+#include <cobalt/kernel/arith.h>
+#include <rtdm/testing.h>
+#include <rtdm/driver.h>
+#include <rtdm/compat.h>
+#include <rtdm/gpio.h>
+
+#define DEFAULT_GPIO_OUT 20
+#define DEFAULT_GPIO_IN  21
+
+MODULE_DESCRIPTION("GPIO loopback latency test helper");
+MODULE_AUTHOR("chensong <chensong@tj.kylinos.cn>");
+MODULE_VERSION("0.1.1");
+MODULE_LICENSE("GPL");
+
+struct rt_timing_info {
+	unsigned long long time_gpio_output;
+	unsigned long long time_gpio_irq;
+};
+
+struct rt_gpiobench_context {
+	int irq;
+	rtdm_irq_t irq_handle;		/* device IRQ handle */
+	rtdm_event_t in_event;		/* raised to unblock reader */
+	rtdm_lock_t lock;		/* lock to protect context struct */
+
+	int gpio_out;
+	int gpio_in;
+
+	struct rt_timing_info result;
+
+	int magic;
+};
+
+static int  gpio_pin_interrupt(rtdm_irq_t *irq_context)
+{
+	struct rt_gpiobench_context *ctx;
+
+	ctx = rtdm_irq_get_arg(irq_context, struct rt_gpiobench_context);
+
+	rtdm_lock_get(&ctx->lock);
+	ctx->result.time_gpio_irq = rtdm_clock_read_monotonic();
+	rtdm_lock_put(&ctx->lock);
+
+	rtdm_event_signal(&ctx->in_event);
+	return RTDM_IRQ_HANDLED;
+}
+
+static int rt_gpio_init(struct rt_gpiobench_context *ctx)
+{
+	int ret, irq_trigger;
+
+	/*set up gpio in*/
+	ctx->gpio_in = DEFAULT_GPIO_IN;
+	ret = gpio_request(ctx->gpio_in, "gpiobench_irq");
+	if (ret) {
+		printk(XENO_ERR "cannot request GPIO %d as input\n",
+					ctx->gpio_in);
+		goto gpioin_failed;
+	}
+
+	/*set up irq*/
+	ctx->irq = gpio_to_irq(ctx->gpio_in);
+	irq_trigger = IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING;
+	irq_set_irq_type(ctx->irq, irq_trigger);
+	ret = rtdm_irq_request(&ctx->irq_handle, ctx->irq,
+				gpio_pin_interrupt, 0, "gpiobench_irq", ctx);
+	if (ret) {
+		printk(XENO_ERR "cannot request GPIO%d interrupt\n",
+					ctx->gpio_in);
+		goto irq_failed;
+	}
+
+	/*set up gpio out*/
+	ctx->gpio_out = DEFAULT_GPIO_OUT;
+	ret = gpio_request(ctx->gpio_out, "gpiobench_out");
+	if (ret) {
+		printk(XENO_ERR "cannot request GPIO%d\n", ctx->gpio_out);
+		goto gpioout_fail;
+	}
+
+	ret = gpio_direction_output(ctx->gpio_out, 0);
+	if (ret) {
+		printk(XENO_ERR "cannot set GPIO%d as output\n", ctx->gpio_out);
+		goto direction_failed;
+	}
+
+	gpio_export(ctx->gpio_out, true);
+
+	return 0;
+
+direction_failed:
+	gpio_free(ctx->gpio_out);
+gpioout_fail:
+	rtdm_irq_free(&ctx->irq_handle);
+irq_failed:
+	gpio_free(ctx->gpio_in);
+gpioin_failed:
+	return -ENODEV;
+}
+
+static int rt_gpiobench_open(struct rtdm_fd *fd, int oflags)
+{
+	struct rt_gpiobench_context *ctx = rtdm_fd_to_private(fd);
+
+	if (rt_gpio_init(ctx)) {
+		printk(XENO_ERR "GPIO init failed\n");
+		return -ENODEV;
+	}
+	rtdm_lock_init(&ctx->lock);
+	rtdm_event_init(&ctx->in_event, 0);
+	return 0;
+
+}
+
+static void rt_gpio_cleanup(struct rt_gpiobench_context *ctx)
+{
+	gpio_free(ctx->gpio_out);
+	gpio_free(ctx->gpio_in);
+	rtdm_irq_free(&ctx->irq_handle);
+}
+
+static void rt_gpiobench_close(struct rtdm_fd *fd)
+{
+	struct rt_gpiobench_context *ctx = rtdm_fd_to_private(fd);
+
+	rtdm_event_destroy(&ctx->in_event);
+	rt_gpio_cleanup(ctx);
+}
+
+static ssize_t rt_gpiobench_read(struct rtdm_fd *fd,
+			   void __user *buf, size_t len)
+{
+	int ret = 0;
+	struct rt_timing_info ti;
+	struct rt_gpiobench_context *ctx = rtdm_fd_to_private(fd);
+	rtdm_lockctx_t lock_ctx;
+	int count = len < sizeof(struct rt_gpiobench_context) ?
+		len : sizeof(struct rt_gpiobench_context);
+
+	rtdm_event_wait(&ctx->in_event);
+
+	rtdm_lock_get_irqsave(&ctx->lock, lock_ctx);
+	ti.time_gpio_output = ctx->result.time_gpio_output;
+	ti.time_gpio_irq    = ctx->result.time_gpio_irq;
+	rtdm_lock_put_irqrestore(&ctx->lock, lock_ctx);
+
+	if (rtdm_fd_is_user(fd)) {
+		if (rtdm_safe_copy_to_user(fd, buf, &ti, count) != 0)
+			ret = -EFAULT;
+		else
+			ret = count;
+	} else {
+		memcpy(buf, &ti, count);
+		ret = count;
+	}
+
+	return ret;
+}
+
+static ssize_t rt_gpiobench_write(struct rtdm_fd *fd,
+			    const void __user *buf, size_t len)
+{
+	int ret = 0;
+	int gpio_val = 0;
+	struct rt_gpiobench_context *ctx = rtdm_fd_to_private(fd);
+	rtdm_lockctx_t lock_ctx;
+	int count = len < sizeof(int) ? len : sizeof(int);
+
+	if (rtdm_fd_is_user(fd)) {
+		if (rtdm_safe_copy_from_user(fd, &gpio_val, buf, count) != 0)
+			ret = -EFAULT;
+		else
+			ret = count;
+	} else {
+		memcpy(&gpio_val, buf, count);
+		ret = count;
+	}
+
+	gpio_val = (gpio_val == 0 ? 0 : 1);
+
+	rtdm_lock_get_irqsave(&ctx->lock, lock_ctx);
+	ctx->result.time_gpio_output = rtdm_clock_read_monotonic();
+	rtdm_lock_put_irqrestore(&ctx->lock, lock_ctx);
+
+	gpio_set_value(ctx->gpio_out, gpio_val);
+
+	return 0;
+}
+
+static int nrt_gpiobench_ioctl(struct rtdm_fd *fd,
+			      unsigned int request, void *arg)
+{
+	int ret = 0, val;
+	struct rt_gpiobench_context *ctx = rtdm_fd_to_private(fd);
+
+	switch (request) {
+	case GPIO_RTIOC_DIR_OUT:
+		ret = rtdm_safe_copy_from_user(fd, &val, arg, sizeof(val));
+		if (ret)
+			return ret;
+		ctx->gpio_out = val;
+		break;
+
+	case GPIO_RTIOC_IRQEN:
+		ret = rtdm_safe_copy_from_user(fd, &val, arg, sizeof(val));
+		if (ret)
+			return ret;
+		ctx->gpio_in = val;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static struct rtdm_driver gpiobench_driver = {
+	.profile_info		= RTDM_PROFILE_INFO(gpio_benchmark,
+						    RTDM_CLASS_TESTING,
+						    RTDM_SUBCLASS_TIMERBENCH,
+						    RTTST_PROFILE_VER),
+	.device_flags		= RTDM_NAMED_DEVICE,
+	.device_count		= 1,
+	.context_size		= sizeof(struct rt_gpiobench_context),
+	.ops = {
+		.open		= rt_gpiobench_open,
+		.close		= rt_gpiobench_close,
+		.read_rt	= rt_gpiobench_read,
+		.write_rt   = rt_gpiobench_write,
+		.ioctl_nrt	= nrt_gpiobench_ioctl,
+	},
+};
+
+static struct rtdm_device device = {
+	.driver = &gpiobench_driver,
+	.label = "gpiobench",
+};
+static int __init __gpiobench_init(void)
+{
+	if (!realtime_core_enabled())
+		return 0;
+
+	return rtdm_dev_register(&device);
+}
+
+static void __exit __gpiobench_exit(void)
+{
+	if (!realtime_core_enabled())
+		return;
+
+	rtdm_dev_unregister(&device);
+}
+
+module_init(__gpiobench_init);
+module_exit(__gpiobench_exit);
+
-- 
2.7.4




