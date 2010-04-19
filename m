From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Mon, 19 Apr 2010 12:29:04 +0200
Message-Id: <be9c336507bc21463d908244756281102ba49b65.1271672940.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1271672940.git.jan.kiszka@domain.hid>
References: <cover.1271672940.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1271672940.git.jan.kiszka@domain.hid>
References: <cover.1271672940.git.jan.kiszka@domain.hid>
Subject: [Xenomai-core] [PATCH v4 24/25] RTDM: Add basic unit test
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This unit test for RTDM validates deferred device closing and driver
deregistration due to pending references. Further tests can be added in
the future.

CC: Philippe Gerum <rpm@xenomai.org>
Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 include/rtdm/rttesting.h        |    9 ++
 ksrc/drivers/testing/Config.in  |    2 +
 ksrc/drivers/testing/Kconfig    |    6 ++
 ksrc/drivers/testing/Makefile   |   12 +++-
 ksrc/drivers/testing/rtdmtest.c |  191 +++++++++++++++++++++++++++++++++++++++
 src/testsuite/unit/Makefile.am  |   17 ++++-
 src/testsuite/unit/rtdm.c       |  114 +++++++++++++++++++++++
 7 files changed, 349 insertions(+), 2 deletions(-)
 create mode 100644 ksrc/drivers/testing/rtdmtest.c
 create mode 100644 src/testsuite/unit/rtdm.c

diff --git a/include/rtdm/rttesting.h b/include/rtdm/rttesting.h
index a660139..e936630 100644
--- a/include/rtdm/rttesting.h
+++ b/include/rtdm/rttesting.h
@@ -141,6 +141,10 @@ struct rttst_swtest_error {
 	unsigned fp_val;
 };
 
+#define RTTST_RTDM_NORMAL_CLOSE		0
+#define RTTST_RTDM_DEFER_CLOSE_HANDLER	1
+#define RTTST_RTDM_DEFER_CLOSE_CONTEXT	2
+
 #define RTIOC_TYPE_TESTING		RTDM_CLASS_TESTING
 
 /*!
@@ -152,6 +156,8 @@ struct rttst_swtest_error {
 #define RTDM_SUBCLASS_IRQBENCH		1
 /** subclass name: "switchtest" */
 #define RTDM_SUBCLASS_SWITCHTEST	2
+/** subclase name: "rtdm" */
+#define RTDM_SUBCLASS_RTDMTEST		3
 /** @} */
 
 /*!
@@ -208,6 +214,9 @@ struct rttst_swtest_error {
 
 #define RTTST_RTIOC_SWTEST_SET_PAUSE \
 	_IOW(RTIOC_TYPE_TESTING, 0x38, unsigned long)
+
+#define RTTST_RTIOC_RTDM_DEFER_CLOSE \
+	_IOW(RTIOC_TYPE_TESTING, 0x40, unsigned long)
 /** @} */
 
 /** @} */
diff --git a/ksrc/drivers/testing/Config.in b/ksrc/drivers/testing/Config.in
index 215c38d..4f81cf9 100644
--- a/ksrc/drivers/testing/Config.in
+++ b/ksrc/drivers/testing/Config.in
@@ -17,4 +17,6 @@ dep_tristate 'Kernel-only latency measurement module' CONFIG_XENO_DRIVERS_KLATEN
 
 dep_tristate 'User-space real-time signals testing module' CONFIG_XENO_DRIVERS_SIGTEST m
 
+dep_tristate 'RTDM unit tests driver' CONFIG_XENO_DRIVERS_RTDMTEST $CONFIG_XENO_SKIN_RTDM m
+
 endmenu
diff --git a/ksrc/drivers/testing/Kconfig b/ksrc/drivers/testing/Kconfig
index 883ede1..28504dc 100644
--- a/ksrc/drivers/testing/Kconfig
+++ b/ksrc/drivers/testing/Kconfig
@@ -45,4 +45,10 @@ config XENO_DRIVERS_SIGTEST
 	help
 	Elementary skin for unit testing user-space real-time signals.
 
+config XENO_DRIVERS_RTDMTEST
+	depends on XENO_SKIN_RTDM && m
+	tristate "RTDM unit tests driver"
+	help
+	Kernel driver for performing RTDM unit tests.
+
 endmenu
diff --git a/ksrc/drivers/testing/Makefile b/ksrc/drivers/testing/Makefile
index 7878cd5..17a6cf1 100644
--- a/ksrc/drivers/testing/Makefile
+++ b/ksrc/drivers/testing/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_XENO_DRIVERS_IRQBENCH)   += xeno_irqbench.o
 obj-$(CONFIG_XENO_DRIVERS_SWITCHTEST) += xeno_switchtest.o
 obj-$(CONFIG_XENO_DRIVERS_KLATENCY)   += xeno_klat.o
 obj-$(CONFIG_XENO_DRIVERS_SIGTEST)    += xeno_sigtest.o
+obj-$(CONFIG_XENO_DRIVERS_RTDMTEST)   += xeno_rtdmtest.o
 
 xeno_timerbench-y := timerbench.o
 
@@ -20,6 +21,8 @@ xeno_klat-y := klat.o
 
 xeno_sigtest-y := sigtest_module.o
 
+xeno_rtdmtest-y := rtdmtest.o
+
 EXTRA_CFLAGS += -D__IN_XENOMAI__ -Iinclude/xenomai
 
 else
@@ -33,6 +36,7 @@ obj-$(CONFIG_XENO_DRIVERS_IRQBENCH)   += xeno_irqbench.o
 obj-$(CONFIG_XENO_DRIVERS_SWITCHTEST) += xeno_switchtest.o
 obj-$(CONFIG_XENO_DRIVERS_KLATENCY)   += xeno_klat.o
 obj-$(CONFIG_XENO_DRIVERS_SIGTEST)    += xeno_sigtest.o
+obj-$(CONFIG_XENO_DRIVERS_RTDMTEST)   += xeno_rtdmtest.o
 
 xeno_timerbench-objs := timerbench.o
 
@@ -44,8 +48,11 @@ xeno_klat-objs := klat.o
 
 xeno_sigtest-objs := sigtest_module.o
 
+xeno_rtdmtest-objs := rtdmtest.o
+
 export-objs := $(xeno_timerbench-objs) $(xeno_irqbench-objs) \
-	$(xeno_switchtest-objs) $(xeno_klat-objs) $(xeno_sigtest-objs)
+	$(xeno_switchtest-objs) $(xeno_klat-objs) $(xeno_sigtest-objs) \
+	$(xeno_rtdmtest-objs)
 
 EXTRA_CFLAGS += -D__IN_XENOMAI__ -I$(TOPDIR)/include/xenomai -I$(TOPDIR)/include/xenomai/compat
 
@@ -66,4 +73,7 @@ xeno_klat.o: $(xeno_klat-objs)
 xeno_sigtest.o: $(xeno_sigtest-objs)
 	$(LD) -r -o $@ $(xeno_sigtest-objs)
 
+xeno_rtdmtest.o: $(xeno_rtdmtest-objs)
+	$(LD) -r -o $@ $(xeno_rtdmtest-objs)
+
 endif
diff --git a/ksrc/drivers/testing/rtdmtest.c b/ksrc/drivers/testing/rtdmtest.c
new file mode 100644
index 0000000..12540de
--- /dev/null
+++ b/ksrc/drivers/testing/rtdmtest.c
@@ -0,0 +1,191 @@
+/*
+ * Copyright (C) 2010 Jan Kiszka <jan.kiszka@domain.hid>.
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
+
+#include <rtdm/rtdm_driver.h>
+#include <rtdm/rttesting.h>
+
+static unsigned int start_index;
+
+module_param(start_index, uint, 0400);
+MODULE_PARM_DESC(start_index, "First device instance number to be used");
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("jan.kiszka@domain.hid");
+
+struct rtdm_test_context {
+	rtdm_timer_t close_timer;
+	unsigned long close_counter;
+	unsigned long close_deferral;
+};
+
+static void close_timer_proc(rtdm_timer_t *timer)
+{
+	struct rtdm_test_context *ctx =
+		container_of(timer, struct rtdm_test_context, close_timer);
+
+	if (ctx->close_counter != 1)
+		printk(KERN_ERR
+		       "rtdmtest: %s: close_counter is %lu, should be 1!\n",
+		       __FUNCTION__, ctx->close_counter);
+
+	rtdm_context_unlock(rtdm_private_to_context(ctx));
+}
+
+static int rtdm_test_open(struct rtdm_dev_context *context,
+			  rtdm_user_info_t *user_info, int oflags)
+{
+	struct rtdm_test_context *ctx =
+		(struct rtdm_test_context *)context->dev_private;
+
+	rtdm_timer_init(&ctx->close_timer, close_timer_proc,
+			"rtdm close test");
+	ctx->close_counter = 0;
+	ctx->close_deferral = RTTST_RTDM_NORMAL_CLOSE;
+
+	return 0;
+}
+
+static int rtdm_test_close(struct rtdm_dev_context *context,
+			   rtdm_user_info_t *user_info)
+{
+	struct rtdm_test_context *ctx =
+		(struct rtdm_test_context *)context->dev_private;
+
+	ctx->close_counter++;
+
+	switch (ctx->close_deferral) {
+	case RTTST_RTDM_DEFER_CLOSE_HANDLER:
+		if (ctx->close_counter <= 3)
+			return -EAGAIN;
+		if (ctx->close_counter > 4) {
+			printk(KERN_ERR
+			       "rtdmtest: %s: close_counter is %lu, "
+			       "should be 2!\n",
+			       __FUNCTION__, ctx->close_counter);
+			return 0;
+		}
+		break;
+
+	case RTTST_RTDM_DEFER_CLOSE_CONTEXT:
+		if (ctx->close_counter == 1) {
+			rtdm_context_lock(context);
+			rtdm_timer_start(&ctx->close_timer, 300000000ULL, 0,
+					 RTDM_TIMERMODE_RELATIVE);
+			return 0;
+		}
+		if (ctx->close_counter > 2) {
+			printk(KERN_ERR
+			       "rtdmtest: %s: close_counter is %lu, "
+			       "should be 2!\n",
+			       __FUNCTION__, ctx->close_counter);
+			return 0;
+		}
+		break;
+	}
+
+	rtdm_timer_destroy(&ctx->close_timer);
+
+	return 0;
+}
+
+static int rtdm_test_ioctl(struct rtdm_dev_context *context,
+			   rtdm_user_info_t *user_info,
+			   unsigned int request, void __user *arg)
+{
+	struct rtdm_test_context *ctx =
+		(struct rtdm_test_context *)context->dev_private;
+	int err = 0;
+
+	switch (request) {
+	case RTTST_RTIOC_RTDM_DEFER_CLOSE:
+		ctx->close_deferral = (unsigned long)arg;
+		break;
+
+	default:
+		err = -ENOTTY;
+	}
+
+	return err;
+}
+
+static struct rtdm_device device[2] = { [0 ... 1] = {
+	.struct_version		= RTDM_DEVICE_STRUCT_VER,
+
+	.device_flags		= RTDM_NAMED_DEVICE | RTDM_EXCLUSIVE,
+	.context_size		= sizeof(struct rtdm_test_context),
+	.device_name		= "",
+
+	.open_nrt		= rtdm_test_open,
+
+	.ops = {
+		.close_nrt	= rtdm_test_close,
+
+		.ioctl_rt	= rtdm_test_ioctl,
+		.ioctl_nrt	= rtdm_test_ioctl,
+	},
+
+	.device_class		= RTDM_CLASS_TESTING,
+	.device_sub_class	= RTDM_SUBCLASS_RTDMTEST,
+	.profile_version	= RTTST_PROFILE_VER,
+	.driver_name		= "xeno_rtdmtest",
+	.driver_version		= RTDM_DRIVER_VER(0, 1, 0),
+	.peripheral_name	= "RTDM unit test",
+	.provider_name		= "Jan Kiszka",
+} };
+
+static int __init __rtdm_test_init(void)
+{
+	int dev = 0;
+	int err;
+
+	while (1) {
+		device[dev].proc_name = device[dev].device_name;
+
+		snprintf(device[dev].device_name, RTDM_MAX_DEVNAME_LEN,
+			 "rttest-rtdm%d",
+			 start_index);
+		err = rtdm_dev_register(&device[dev]);
+
+		start_index++;
+
+		if (!err) {
+			if (++dev >= ARRAY_SIZE(device))
+				break;
+		} else if (err != -EEXIST) {
+			while (dev > 0) {
+				dev--;
+				rtdm_dev_unregister(&device[dev], 1000);
+			}
+			return err;
+		}
+	}
+	return 0;
+}
+
+static void __exit __rtdm_test_exit(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(device); i++)
+		rtdm_dev_unregister(&device[i], 1000);
+}
+
+module_init(__rtdm_test_init);
+module_exit(__rtdm_test_exit);
diff --git a/src/testsuite/unit/Makefile.am b/src/testsuite/unit/Makefile.am
index 8966883..f37ec33 100644
--- a/src/testsuite/unit/Makefile.am
+++ b/src/testsuite/unit/Makefile.am
@@ -10,7 +10,8 @@ test_PROGRAMS = \
 	mutex-torture-native \
 	cond-torture-posix \
 	cond-torture-native \
-	check-vdso
+	check-vdso \
+	rtdm
 
 arith_SOURCES = arith.c arith-noinline.c arith-noinline.h
 
@@ -105,6 +106,20 @@ check_vdso_LDADD = \
 	../../skins/common/libxenomai.la \
 	-lpthread -lm
 
+rtdm_SOURCES = rtdm.c
+
+rtdm_CPPFLAGS = \
+	-I$(top_srcdir)/include/posix @XENO_USER_CFLAGS@ -g -DXENO_POSIX \
+	-I$(top_srcdir)/include
+
+rtdm_LDFLAGS = $(XENO_POSIX_WRAPPERS) @XENO_USER_LDFLAGS@
+
+rtdm_LDADD = \
+	../../skins/posix/libpthread_rt.la \
+	../../skins/native/libnative.la \
+	../../skins/common/libxenomai.la \
+	-lpthread -lrt -lm
+
 install-data-local:
 	$(mkinstalldirs) $(DESTDIR)$(rundir)
 	@sed -e's,@exec_prefix\@,$(exec_prefix),g' $(srcdir)/runinfo.in > $(DESTDIR)$(rundir)/.runinfo
diff --git a/src/testsuite/unit/rtdm.c b/src/testsuite/unit/rtdm.c
new file mode 100644
index 0000000..e472c9b
--- /dev/null
+++ b/src/testsuite/unit/rtdm.c
@@ -0,0 +1,114 @@
+/*
+ * Functional testing of RTDM services.
+ *
+ * Copyright (C) 2010 Jan Kiszka <jan.kiszka@domain.hid>.
+ *
+ * Released under the terms of GPLv2.
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <unistd.h>
+#include <native/timer.h>
+#include <rtdm/rttesting.h>
+
+#define NS_PER_MS (1000000)
+
+static void check_inner(const char *fn, int line, const char *msg,
+			int status, int expected)
+{
+	if (status == expected)
+		return;
+
+	fprintf(stderr, "FAILED %s:%d: %s returned %d instead of %d - %s\n",
+		fn, line, msg, status, expected, strerror(-status));
+	exit(EXIT_FAILURE);
+}
+
+#define check(msg, status, expected) ({					\
+	int __status = status;						\
+	check_inner(__FUNCTION__, __LINE__, msg,			\
+		    __status < 0 ? -errno : __status, expected);	\
+	__status;							\
+})
+
+#define check_no_error(msg, status) ({					\
+	int __status = status;						\
+	check_inner(__FUNCTION__, __LINE__, msg,			\
+		    __status < 0 ? -errno : 0, 0);			\
+	__status;							\
+})
+
+static void check_sleep_inner(const char *fn, int line,
+			      const char *msg, unsigned long long start)
+{
+	unsigned long long diff = rt_timer_tsc2ns(rt_timer_tsc() - start);
+
+	if (diff < 300 * NS_PER_MS) {
+		fprintf(stderr, "FAILED %s:%d: %s waited only %Ld.%06u ms\n",
+			fn, line, msg, diff / 1000000,
+			(unsigned)(diff % 1000000));
+		exit(EXIT_FAILURE);
+	}
+}
+#define check_sleep(msg, start) \
+	check_sleep_inner(__FUNCTION__, __LINE__, msg, start)
+
+static const char *devname = "/dev/rttest-rtdm0";
+static const char *devname2 = "/dev/rttest-rtdm1";
+
+int main(int argc, const char *argv[])
+{
+	unsigned long long start;
+	int dev, dev2;
+
+	printf("Setup\n");
+	check("modprobe", system("modprobe xeno_rtdmtest"), 0);
+	dev = check_no_error("open", open(devname, O_RDWR));
+
+	printf("Exclusive open\n");
+	check("open", open(devname, O_RDWR), -EBUSY);
+
+	printf("Successive open\n");
+	dev2 = check("open", open(devname2, O_RDWR), dev + 1);
+	check("close", close(dev2), 0);
+
+	printf("Defer close by driver handler\n");
+	check("ioctl", ioctl(dev, RTTST_RTIOC_RTDM_DEFER_CLOSE,
+			     RTTST_RTDM_DEFER_CLOSE_HANDLER), 0);
+	start = rt_timer_tsc();
+	check("close", close(dev), 0);
+	check("open", open(devname, O_RDWR), -EBUSY);
+	dev2 = check("open", open(devname2, O_RDWR), dev);
+	check("close", close(dev2), 0);
+	usleep(300000);
+	dev = check("open", open(devname, O_RDWR), dev);
+
+	printf("Defer close by pending reference\n");
+	check("ioctl", ioctl(dev, RTTST_RTIOC_RTDM_DEFER_CLOSE,
+			     RTTST_RTDM_DEFER_CLOSE_CONTEXT), 0);
+	start = rt_timer_tsc();
+	check("close", close(dev), 0);
+	check("open", open(devname, O_RDWR), -EBUSY);
+	dev2 = check("open", open(devname2, O_RDWR), dev);
+	check("close", close(dev2), 0);
+	usleep(300000);
+	dev = check("open", open(devname, O_RDWR), dev);
+
+	printf("Normal close\n");
+	check("ioctl", ioctl(dev, RTTST_RTIOC_RTDM_DEFER_CLOSE,
+			     RTTST_RTDM_NORMAL_CLOSE), 0);
+	check("close", close(dev), 0);
+	dev = check("open", open(devname, O_RDWR), dev);
+
+	printf("Deferred module unload\n");
+	check("ioctl", ioctl(dev, RTTST_RTIOC_RTDM_DEFER_CLOSE,
+			     RTTST_RTDM_DEFER_CLOSE_CONTEXT), 0);
+	start = rt_timer_tsc();
+	check("close", close(dev), 0);
+	check("rmmod", system("rmmod xeno_rtdmtest"), 0);
+	check_sleep("rmmod", start);
+
+	return 0;
+}
-- 
1.6.0.2


