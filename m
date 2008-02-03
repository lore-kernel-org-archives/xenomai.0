From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="PltMr7To8A"
Content-Transfer-Encoding: 7bit
Message-ID: <18341.1895.173514.464390@domain.hid>
Date: Sun, 3 Feb 2008 01:14:31 +0100
In-Reply-To: <18341.1681.919618.418201@domain.hid>
References: <18341.1681.919618.418201@domain.hid>
Subject: Re: [Xenomai-core] [PATCH 3/3] kernel-space only latency test.
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


--PltMr7To8A
Content-Type: text/plain; charset=us-ascii
Content-Description: message body and .signature
Content-Transfer-Encoding: 7bit


This patch adds a kernel module and a user-space tool to measure the
kernel-space latency without running user-space real-time tasks. It is mostly
useful to do a fair comparison between Xenomai and RTAI on platforms without
LXRT support.

The kernel module uses the timerbench driver and write intermediate results to
an rt_pipe; The user-space tool reads the rt_pipe, formats the results and print
them.

Stats:
 configure.in                       |    1
 ksrc/drivers/testing/Config.in     |    2
 ksrc/drivers/testing/Kconfig       |    6 +
 ksrc/drivers/testing/Makefile      |   13 +-
 ksrc/drivers/testing/klat.c        |  156 ++++++++++++++++++++++++++
 src/testsuite/Makefile.am          |    2
 src/testsuite/klatency/Makefile.am |   25 ++++
 src/testsuite/klatency/klatency.c  |  217 +++++++++++++++++++++++++++++++++++++
 src/testsuite/klatency/runinfo.in  |    1
 9 files changed, 420 insertions(+), 3 deletions(-)

-- 


					    Gilles Chanteperdrix.

--PltMr7To8A
Content-Type: text/plain
Content-Disposition: inline;
	filename="xeno-klatency.diff"
Content-Transfer-Encoding: 7bit

Index: configure
===================================================================
Index: Makefile.in
===================================================================
Index: include/uitron/Makefile.in
===================================================================
Index: include/asm-ia64/bits/Makefile.in
===================================================================
Index: include/asm-ia64/Makefile.in
===================================================================
Index: include/Makefile.in
===================================================================
Index: include/vxworks/Makefile.in
===================================================================
Index: include/native/Makefile.in
===================================================================
Index: include/asm-blackfin/bits/Makefile.in
===================================================================
Index: include/asm-blackfin/Makefile.in
===================================================================
Index: include/asm-generic/bits/Makefile.in
===================================================================
Index: include/asm-generic/Makefile.in
===================================================================
Index: include/asm-arm/bits/Makefile.in
===================================================================
Index: include/asm-arm/Makefile.in
===================================================================
Index: include/asm-powerpc/bits/Makefile.in
===================================================================
Index: include/asm-powerpc/Makefile.in
===================================================================
Index: include/rtai/Makefile.in
===================================================================
Index: include/psos+/Makefile.in
===================================================================
Index: include/posix/syscall.h
===================================================================
Index: include/posix/Makefile.in
===================================================================
Index: include/posix/sys/Makefile.in
===================================================================
Index: include/posix/sys/select.h
===================================================================
Index: include/vrtx/Makefile.in
===================================================================
Index: include/asm-x86/Makefile.in
===================================================================
Index: include/asm-x86/bits/Makefile.in
===================================================================
Index: include/rtdm/Makefile.in
===================================================================
Index: include/rtdm/rtdm_driver.h
===================================================================
Index: include/rtdm/rtdm.h
===================================================================
Index: include/asm-sim/bits/Makefile.in
===================================================================
Index: include/asm-sim/Makefile.in
===================================================================
Index: include/nucleus/Makefile.in
===================================================================
Index: include/nucleus/select.h
===================================================================
Index: configure.in
===================================================================
--- configure.in	(revision 3452)
+++ configure.in	(working copy)
@@ -766,6 +766,7 @@ AC_CONFIG_FILES([ \
        	src/testsuite/switchtest/Makefile \
 	src/testsuite/irqbench/Makefile \
 	src/testsuite/clocktest/Makefile \
+       	src/testsuite/klatency/Makefile \
 	src/utils/Makefile \
 	src/utils/can/Makefile \
        	include/Makefile \
Index: src/utils/can/Makefile.in
===================================================================
Index: src/utils/Makefile.in
===================================================================
Index: src/Makefile.in
===================================================================
Index: src/include/Makefile.in
===================================================================
Index: src/rtdk/Makefile.in
===================================================================
Index: src/skins/psos+/Makefile.in
===================================================================
Index: src/skins/rtai/Makefile.in
===================================================================
Index: src/skins/uitron/Makefile.in
===================================================================
Index: src/skins/posix/Makefile.in
===================================================================
Index: src/skins/posix/wrappers.c
===================================================================
Index: src/skins/posix/select.c
===================================================================
Index: src/skins/posix/posix.wrappers
===================================================================
Index: src/skins/posix/Makefile.am
===================================================================
Index: src/skins/Makefile.in
===================================================================
Index: src/skins/vrtx/Makefile.in
===================================================================
Index: src/skins/vxworks/Makefile.in
===================================================================
Index: src/skins/rtdm/Makefile.in
===================================================================
Index: src/testsuite/latency/Makefile.in
===================================================================
Index: src/testsuite/switchbench/Makefile.in
===================================================================
Index: src/testsuite/switchtest/Makefile.in
===================================================================
Index: src/testsuite/Makefile.in
===================================================================
Index: src/testsuite/cyclic/Makefile.in
===================================================================
Index: src/testsuite/Makefile.am
===================================================================
--- src/testsuite/Makefile.am	(revision 3452)
+++ src/testsuite/Makefile.am	(working copy)
@@ -1 +1 @@
-SUBDIRS = latency switchbench cyclic switchtest irqbench clocktest
+SUBDIRS = latency switchbench cyclic switchtest irqbench clocktest klatency
Index: src/testsuite/klatency/Makefile.in
===================================================================
Index: src/testsuite/klatency/runinfo.in
===================================================================
--- src/testsuite/klatency/runinfo.in	(revision 0)
+++ src/testsuite/klatency/runinfo.in	(revision 0)
@@ -0,0 +1 @@
+latency:native+rtdm+timerbench+klat:!@exec_prefix@domain.hid
Index: src/testsuite/klatency/Makefile.am
===================================================================
--- src/testsuite/klatency/Makefile.am	(revision 0)
+++ src/testsuite/klatency/Makefile.am	(revision 0)
@@ -0,0 +1,25 @@
+testdir = $(exec_prefix)/share/xenomai/testsuite/klatency
+
+bin_PROGRAMS = klatency
+
+klatency_SOURCES = klatency.c
+
+klatency_CPPFLAGS = \
+	@XENO_USER_CFLAGS@ \
+	-I$(top_srcdir)/include
+
+klatency_LDFLAGS = @XENO_USER_LDFLAGS@
+
+install-data-local:
+	$(mkinstalldirs) $(DESTDIR)$(testdir)
+	@sed -e's,@exec_prefix\@,$(exec_prefix),g' $(srcdir)/runinfo.in > $(DESTDIR)$(testdir)/.runinfo
+	@echo "\$${DESTDIR}$(exec_prefix)/bin/xeno-load \`dirname \$$0\` \$$*" > $(DESTDIR)$(testdir)/run
+	@chmod +x $(DESTDIR)$(testdir)/run
+
+uninstall-local:
+	$(RM) $(DESTDIR)$(testdir)/.runinfo $(DESTDIR)$(testdir)/run
+
+run: all
+	@$(top_srcdir)/scripts/xeno-load --verbose
+
+EXTRA_DIST = runinfo.in
Index: src/testsuite/klatency/klatency.c
===================================================================
--- src/testsuite/klatency/klatency.c	(revision 0)
+++ src/testsuite/klatency/klatency.c	(revision 0)
@@ -0,0 +1,217 @@
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <string.h>
+#include <signal.h>
+#include <getopt.h>
+#include <time.h>
+#include <errno.h>
+#include <rtdm/rttesting.h>
+
+long long period_ns = 0;
+int test_duration = 0;		/* sec of testing, via -T <sec>, 0 is inf */
+int data_lines = 21;		/* data lines per header line, -l <lines> to change */
+int quiet = 0;			/* suppress printing of RTH, RTD lines when -T given */
+int benchdev_no = -1;
+int benchdev = -1;
+int freeze_max;
+int priority;
+
+#define USER_TASK       0
+#define KERNEL_TASK     1
+#define TIMER_HANDLER   2
+
+int test_mode = USER_TASK;
+const char *test_mode_names[] = {
+	"periodic user-mode task",
+	"in-kernel periodic task",
+	"in-kernel timer handler"
+};
+
+time_t test_start, test_end;	/* report test duration */
+int test_loops = 0;		/* outer loop count */
+
+int finished = 0;
+
+void display(void)
+{
+	struct rttst_interm_bench_res result;
+	int err, n = 0, got_results = 0;
+	time_t start, actual_duration;
+
+	time(&start);
+
+	printf("warming up...\n");
+
+	if (quiet)
+		fprintf(stderr, "running quietly for %d seconds\n",
+			test_duration);
+
+	while (!finished) {
+		long minj, gminj, maxj, gmaxj, avgj, goverrun;
+
+		err = read(benchdev, &result, sizeof(result));
+		if (err <= 0) {
+			fprintf(stderr, "read: %d, errno: %d\n", err, errno);
+			break;
+		}
+
+		got_results = 1;
+		minj = result.last.min;
+		gminj = result.overall.min;
+		avgj = result.last.avg;
+		maxj = result.last.max;
+		gmaxj = result.overall.max;
+		goverrun = result.overall.overruns;
+
+		if (!quiet) {
+			if (data_lines && (n++ % data_lines) == 0) {
+				time_t now, dt;
+				time(&now);
+				dt = now - start;
+				printf
+					("RTT|  %.2ld:%.2ld:%.2ld  (%s, %Ld us period, "
+					 "priority %d)\n", dt / 3600,
+					 (dt / 60) % 60, dt % 60,
+					 test_mode_names[test_mode],
+					 period_ns / 1000, priority);
+				printf("RTH|%12s|%12s|%12s|%8s|%12s|%12s\n",
+				       "-----lat min", "-----lat avg",
+				       "-----lat max", "-overrun",
+				       "----lat best", "---lat worst");
+			}
+
+			printf("RTD|%12.3f|%12.3f|%12.3f|%8ld|%12.3f|%12.3f\n",
+			       (double)minj / 1000,
+			       (double)avgj / 1000,
+			       (double)maxj / 1000,
+			       goverrun,
+			       (double)gminj / 1000, (double)gmaxj / 1000);
+		}
+	}
+
+	time(&test_end);
+	actual_duration = test_end - test_start;
+	if (!test_duration)
+		test_duration = actual_duration;
+
+	if (got_results) {
+		long gminj, gmaxj, gavgj, goverrun;
+
+		gminj = result.overall.min;
+		gmaxj = result.overall.max;
+		goverrun = result.overall.overruns;
+		gavgj = result.overall.avg
+			/ ((result.overall.test_loops) > 1 ?
+			   result.overall.test_loops : 2) - 1;
+
+		printf("---|------------|------------|------------|--------|-------------------------\n"
+		       "RTS|%12.3f|%12.3f|%12.3f|%8ld|    %.2ld:%.2ld:%.2ld/%.2d:%.2d:%.2d\n",
+		       (double)gminj / 1000, (double)gavgj / 1000, (double)gmaxj / 1000,
+		       goverrun, actual_duration / 3600, (actual_duration / 60) % 60,
+		       actual_duration % 60, test_duration / 3600,
+		       (test_duration / 60) % 60, test_duration % 60);
+
+	}
+
+	if (benchdev >= 0)
+		close(benchdev);
+}
+
+void sighand(int sig __attribute__ ((unused)))
+{
+	finished = 1;
+}
+
+int main(int argc, char **argv)
+{
+	struct rttst_tmbench_config config;
+	int c;
+
+	while ((c = getopt(argc, argv, "l:T:qP:")) != EOF)
+		switch (c) {
+		case 'l':
+
+			data_lines = atoi(optarg);
+			break;
+
+		case 'T':
+
+			test_duration = atoi(optarg);
+			alarm(test_duration);
+			break;
+
+		case 'q':
+
+			quiet = 1;
+			break;
+
+		case 'P':
+
+			benchdev_no = atoi(optarg);
+			break;
+
+		default:
+
+			fprintf(stderr, "usage: latency [options]\n"
+				"  [-l <data-lines per header>] # default=21, 0 to supress headers\n"
+				"  [-T <test_duration_seconds>] # default=0, so ^C to end\n"
+				"  [-q]                         # supresses RTD, RTH lines if -T is used\n"
+				"  [-P <rt_pipe_no>]            # number of testing pipe, default=auto\n");
+			exit(2);
+		}
+
+	if (!test_duration && quiet) {
+		fprintf(stderr,
+			"latency: -q only works if -T has been given.\n");
+		quiet = 0;
+	}
+
+	time(&test_start);
+
+	signal(SIGINT, sighand);
+	signal(SIGTERM, sighand);
+	signal(SIGHUP, sighand);
+	signal(SIGALRM, sighand);
+
+	setlinebuf(stdout);
+
+	if (benchdev_no == -1) {
+		benchdev = open("/proc/xenomai/registry/native/pipes/klat_pipe",
+				O_RDONLY);
+		if (benchdev == -1) {
+			perror("open(/proc/xenomai/registry/native/pipes/klat_pipe)");
+			fprintf(stderr,
+				"modprobe klat_mod or try the -P option?\n");
+			exit(EXIT_FAILURE);
+		}
+	} else {
+		char devname[64];
+		snprintf(devname, sizeof(devname), "/dev/rtp%d", benchdev_no);
+		benchdev = open(devname, O_RDONLY);
+		if (benchdev == -1) {
+			fprintf(stderr, "open(%s): %s\n",
+				devname, strerror(errno));
+			exit(EXIT_FAILURE);
+		}
+	}
+
+	if (read(benchdev, &config, sizeof(config)) == -1) {
+		perror("read");
+		exit(EXIT_FAILURE);
+	}
+
+	test_mode = config.mode;
+	priority = config.priority;
+	period_ns = config.period;
+	freeze_max = config.freeze_max;
+
+	printf("== Sampling period: %Ld us\n"
+	       "== Test mode: %s\n"
+	       "== All results in microseconds\n",
+	       period_ns / 1000, test_mode_names[test_mode]);
+
+	display();
+
+	return 0;
+}
Index: src/testsuite/irqbench/Makefile.in
===================================================================
Index: src/testsuite/clocktest/Makefile.in
===================================================================
Index: scripts/Makefile.in
===================================================================
Index: ksrc/skins/posix/syscall.c
===================================================================
Index: ksrc/skins/posix/mq.c
===================================================================
Index: ksrc/skins/posix/thread.c
===================================================================
Index: ksrc/skins/posix/thread.h
===================================================================
Index: ksrc/skins/posix/internal.h
===================================================================
Index: ksrc/skins/rtdm/device.c
===================================================================
Index: ksrc/skins/rtdm/drvlib.c
===================================================================
Index: ksrc/skins/rtdm/core.c
===================================================================
Index: ksrc/drivers/testing/Kconfig
===================================================================
--- ksrc/drivers/testing/Kconfig	(revision 3452)
+++ ksrc/drivers/testing/Kconfig	(working copy)
@@ -22,4 +22,10 @@ config XENO_DRIVERS_SWITCHTEST
 	Kernel-based driver for unit testing context switches and
 	FPU switches.
 
+config XENO_DRIVERS_KLATENCY
+	depends on XENO_DRIVERS_TIMERBENCH
+	tristate "Kernel-only latency measurement module"
+	help
+	Kernel module for kernel-only latency measurement.
+
 endmenu
Index: ksrc/drivers/testing/Config.in
===================================================================
--- ksrc/drivers/testing/Config.in	(revision 3452)
+++ ksrc/drivers/testing/Config.in	(working copy)
@@ -11,4 +11,6 @@ dep_tristate 'IRQ benchmark driver' CONF
 
 dep_tristate 'Context switches test driver' CONFIG_XENO_DRIVERS_SWITCHTEST $CONFIG_XENO_SKIN_RTDM
 
+dep_tristate 'Kernel-only latency measurement module' CONFIG_XENO_DRIVERS_KLATENCY $XENO_DRIVERS_TIMERBENCH
+
 endmenu
Index: ksrc/drivers/testing/klat.c
===================================================================
--- ksrc/drivers/testing/klat.c	(revision 0)
+++ ksrc/drivers/testing/klat.c	(revision 0)
@@ -0,0 +1,156 @@
+/*
+ * Copyright (C) 2008 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>.
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
+#include <native/pipe.h>
+#include <native/task.h>
+#include <rtdm/rttesting.h>
+
+#define DEV_NR_MAX 256
+
+static int pipe = P_MINOR_AUTO;
+module_param(pipe, int, 0400);
+MODULE_PARM_DESC(pipe, "Index of the RT-pipe used for first connection"
+		 " (-1, the default, means automatic minor allocation)");
+
+static int mode = 1;
+module_param(mode, int, 0400);
+MODULE_PARM_DESC(mode, "Test mode, (1 for kernel task, 2 for timer handler)");
+
+static int priority = 99;
+module_param(priority, int, 0400);
+MODULE_PARM_DESC(priority, "Kernel task priority");
+
+static unsigned period = 100;
+module_param(period, uint, 0400);
+MODULE_PARM_DESC(period, "Sampling period, in microseconds");
+
+static int freeze_max = 0;
+module_param(freeze_max, int, 0400);
+MODULE_PARM_DESC(freeze_max, "Freeze trace for each new max latency");
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("gilles.chanteperdrix@xenomai.org");
+
+static RT_TASK klat_srvr;
+static RT_PIPE klat_pipe;
+static int fd;
+
+static void klat_server(void *cookie)
+{
+	struct rttst_interm_bench_res res;
+	int err;
+
+	for (;;) {
+		err = rt_dev_ioctl(fd, RTTST_RTIOC_INTERM_BENCH_RES, &res);
+		if (err) {
+			if (err != -EIDRM)
+				printk("rt_dev_ioctl(RTTST_RTIOC_INTERM_BENCH_RES): %d",
+				       err);
+			return;
+		}
+
+		/* Do not check rt_pipe_write return value, the pipe may well be
+		   full. */
+		rt_pipe_write(&klat_pipe, &res, sizeof(res), P_NORMAL);
+	}
+}
+
+static int __init klat_mod_init(void)
+{
+	char devname[RTDM_MAX_DEVNAME_LEN + 1];
+	struct rttst_tmbench_config config;
+	unsigned dev_nr;
+	int err;
+
+	err = rt_pipe_create(&klat_pipe, "klat_pipe", pipe, 4096);
+	if (err) {
+		printk("rt_pipe_create(klat_pipe): %d\n", err);
+		return err;
+	}
+
+	err = rt_task_create(&klat_srvr, "klat_srvr", 0, 0, 0);
+	if (err) {
+		printk("rt_task_create(klat_srvr): %d\n", err);
+		goto err_close_pipe;
+	}
+
+	config.mode = mode;
+	config.priority = priority;
+	config.period = period * 1000;
+	config.warmup_loops = 1;
+	config.histogram_size = 0;
+	config.freeze_max = freeze_max;
+
+	for (dev_nr = 0; dev_nr < DEV_NR_MAX; dev_nr++) {
+		snprintf(devname, sizeof(devname), "rttest%d", dev_nr);
+		fd = rt_dev_open(devname, O_RDONLY);
+		if (fd < 0)
+			continue;
+
+		err = rt_dev_ioctl(fd, RTTST_RTIOC_TMBENCH_START, &config);
+		if (err == -ENOTTY) {
+			rt_dev_close(fd);
+			continue;
+		}
+
+		if (err < 0) {
+			printk("rt_dev_ioctl(RTTST_RTIOC_TMBENCH_START): %d\n",
+			       err);
+			goto err_close_dev;
+		}
+
+		break;
+	}
+	if (fd < 0) {
+		printk("rt_dev_open: could not find rttest device\n"
+		       "(modprobe timerbench?)");
+		return fd;
+	}
+
+	err = rt_pipe_write(&klat_pipe, &config, sizeof(config), P_NORMAL);
+	if (err < 0) {
+		printk("rt_pipe_write: %d\n", err);
+		goto err_close_dev;
+	}
+
+	err = rt_task_start(&klat_srvr, &klat_server, NULL);
+	if (err) {
+		printk("rt_task_start: %d\n", err);
+		goto err_close_dev;
+	}
+	
+	return 0;
+
+  err_close_dev:
+	rt_dev_close(fd);
+	rt_task_delete(&klat_srvr);
+  err_close_pipe:
+	rt_pipe_delete(&klat_pipe);
+	return err;
+}
+
+
+static void klat_mod_exit(void)
+{
+	rt_dev_close(fd);
+	rt_task_delete(&klat_srvr);
+	rt_pipe_delete(&klat_pipe);
+}
+
+module_init(klat_mod_init);
+module_exit(klat_mod_exit);
Index: ksrc/drivers/testing/Makefile
===================================================================
--- ksrc/drivers/testing/Makefile	(revision 3452)
+++ ksrc/drivers/testing/Makefile	(working copy)
@@ -7,6 +7,7 @@ EXTRA_CFLAGS += -D__IN_XENOMAI__ -Iinclu
 obj-$(CONFIG_XENO_DRIVERS_TIMERBENCH) += xeno_timerbench.o
 obj-$(CONFIG_XENO_DRIVERS_IRQBENCH)   += xeno_irqbench.o
 obj-$(CONFIG_XENO_DRIVERS_SWITCHTEST) += xeno_switchtest.o
+obj-$(CONFIG_XENO_DRIVERS_KLATENCY)   += xeno_klat.o
 
 xeno_timerbench-y := timerbench.o
 
@@ -14,6 +15,8 @@ xeno_irqbench-y := irqbench.o
 
 xeno_switchtest-y := switchtest.o
 
+xeno_klat-y := klat.o
+
 EXTRA_CFLAGS += -D__IN_XENOMAI__ -Iinclude/xenomai
 
 else
@@ -25,14 +28,17 @@ O_TARGET := built-in.o
 obj-$(CONFIG_XENO_DRIVERS_TIMERBENCH) += xeno_timerbench.o
 obj-$(CONFIG_XENO_DRIVERS_IRQBENCH)   += xeno_irqbench.o
 obj-$(CONFIG_XENO_DRIVERS_SWITCHTEST) += xeno_switchtest.o
-
+obj-$(CONFIG_XENO_DRIVERS_KLATENCY)   += xeno_klat.o
 xeno_timerbench-objs := timerbench.o
 
 xeno_irqbench-objs := irqbench.o
 
 xeno_switchtest-objs := switchtest.o
 
-export-objs := $(xeno_timerbench-objs) $(xeno_irqbench-objs) $(xeno_switchtest-objs)
+xeno_klat-objs := klat.o
+
+export-objs := $(xeno_timerbench-objs) $(xeno_irqbench-objs) \
+	$(xeno_switchtest-objs) $(xeno_klat-objs)
 
 EXTRA_CFLAGS += -D__IN_XENOMAI__ -I$(TOPDIR)/include/xenomai -I$(TOPDIR)/include/xenomai/compat
 
@@ -47,4 +53,7 @@ xeno_irqbench.o: $(xeno_irqbench-objs)
 xeno_switchtest.o: $(xeno_switchtest-objs)
 	$(LD) -r -o $@ $(xeno_switchtest-objs)
 
+xeno_klat.o: $(xeno_klat-objs)
+	$(LD) -r -o $@ $(xeno_klat-objs)
+
 endif
Index: ksrc/nucleus/select.c
===================================================================
Index: ksrc/nucleus/Makefile
===================================================================
Index: config/Makefile.in
===================================================================
Index: doc/txt/Makefile.in
===================================================================
Index: doc/docbook/xenomai/Makefile.in
===================================================================
Index: doc/docbook/Makefile.in
===================================================================
Index: doc/docbook/custom-stylesheets/Makefile.in
===================================================================
Index: doc/docbook/custom-stylesheets/xsl/Makefile.in
===================================================================
Index: doc/docbook/custom-stylesheets/xsl/fo/Makefile.in
===================================================================
Index: doc/docbook/custom-stylesheets/xsl/html/Makefile.in
===================================================================
Index: doc/docbook/custom-stylesheets/xsl/common/Makefile.in
===================================================================
Index: doc/Makefile.in
===================================================================
Index: doc/man/Makefile.in
===================================================================
Index: doc/doxygen/Makefile.in
===================================================================
Index: aclocal.m4
===================================================================

--PltMr7To8A--

