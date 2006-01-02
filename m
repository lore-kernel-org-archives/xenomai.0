Message-ID: <43B92741.8030609@domain.hid>
Date: Mon, 02 Jan 2006 14:14:41 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB8F327E9EDE40A29C36A6AE7"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] in-kernel timer benchmark -v3
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB8F327E9EDE40A29C36A6AE7
Content-Type: multipart/mixed; boundary="------------040105030705060009040702"

This is a multi-part message in MIME format.
--------------040105030705060009040702
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Happy New Year everyone!

Hope you all survived the turn of the year without complications. ;)

I would like to start with a new patch round. The first one is a revised
and extended version of the earlier posted in-kernel timer benchmark
based on a RTDM device. Changes since the first version:

 * revised command line argument to set the test mode
 * display test mode during startup
 * display hint on missing benchmark device
 * support of trace freeze on latency above specified threshold
 * extended benchmark device to provide ipipe-tracing functions to
   userspace
 * further minor fixes

I think the patch should be ready to merge now. This would also be
helpful to provide a base on which Gilles can build his timer-scaling
tests. BTW, we still need some RTDM abstraction for timers, but this is
a different topic that will be addressed later.

Jan

--------------040105030705060009040702
Content-Type: text/plain;
 name="timerbench.patch-v3"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="timerbench.patch-v3"

Index: include/rtdm/rtbenchmark.h
===================================================================
--- include/rtdm/rtbenchmark.h	(Revision 0)
+++ include/rtdm/rtbenchmark.h	(Revision 0)
@@ -0,0 +1,131 @@
+/**
+ * @file
+ * Real-Time Driver Model for Xenomai, benchmark device profile header
+ *
+ * @note Copyright (C) 2005 Jan Kiszka <jan.kiszka@domain.hid>
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
+ *
+ * @ingroup rtbenchmark
+ */
+
+/*!
+ * @ingroup profiles
+ * @defgroup rtbenchmark Benchmark Devices
+ *
+ * This group of devices is intended to provide in-kernel benchmark results.
+ * Feel free to comment on this profile via the Xenomai mailing list
+ * (Xenomai-help@domain.hid) or directly to the author (jan.kiszka@domain.hid). @n
+ * @n
+ *
+ * @par Device Characteristics
+ * @ref rtdm_device.device_flags "Device Flags": @c RTDM_NAMED_DEVICE, @c RTDM_EXCLUSIVE @n
+ * @n
+ * @ref rtdm_device.device_name "Device Name": @c "rtbenchmark<N>", N >= 0 @n
+ * @n
+ * @ref rtdm_device.device_class "Device Class": @c RTDM_CLASS_BENCHMARK @n
+ * @n
+ *
+ * @par Supported Operations
+ * @b Open @n
+ * Environments: non-RT (RT optional)@n
+ * Specific return values: none @n
+ * @n
+ * @b Close @n
+ * Environments: non-RT (RT optional)@n
+ * Specific return values: none @n
+ * @n
+ * @b IOCTL @n
+ * Mandatory Environments: see @ref IOCTLs "below" @n
+ * Specific return values: see @ref IOCTLs "below" @n
+ *
+ * @{
+ */
+
+#ifndef _RTBENCHMARK_H
+#define _RTBENCHMARK_H
+
+#include <asm/types.h>
+#include <xenomai/rtdm/rtdm.h>
+
+#define RTBNCH_TIMER_TASK       0
+#define RTBNCH_TIMER_HANDLER    1
+
+typedef struct rtbnch_result {
+    long                    avg;
+    long                    min;
+    long                    max;
+    long                    overruns;
+    long                    test_loops;
+} rtbnch_result_t;
+
+typedef struct rtbnch_timerconfig {
+    int                     mode;
+    uint64_t                period;
+    int                     warmup_loops;
+    int                     histogram_size;
+    int                     histogram_bucketsize;
+    long                    freeze_threshold;
+} rtbnch_timerconfig_t;
+
+typedef struct rtbnch_interm_result {
+    struct rtbnch_result    last;
+    struct rtbnch_result    overall;
+} rtbnch_interm_result_t;
+
+typedef struct rtbnch_overall_result {
+    struct rtbnch_result    result;
+    long                    *histogram_avg;
+    long                    *histogram_min;
+    long                    *histogram_max;
+} rtbnch_overall_result_t;
+
+
+#define RTIOC_TYPE_BENCHMARK        RTDM_CLASS_BENCHMARK
+
+
+/*!
+ * @name Sub-Classes of RTDM_CLASS_BENCHMARK
+ * @{ */
+#define RTDM_SUBCLASS_TIMER         0
+/** @} */
+
+
+/*!
+ * @anchor IOCTLs @name IOCTLs
+ * Benchmark device IOCTLs
+ * @{ */
+
+#define RTBNCH_RTIOC_INTERM_RESULT      \
+    _IOWR(RTIOC_TYPE_BENCHMARK, 0x00, struct rtbnch_interm_result)
+
+#define RTBNCH_RTIOC_START_TMTEST       \
+    _IOW(RTIOC_TYPE_BENCHMARK, 0x10, struct rtbnch_timerconfig)
+
+#define RTBNCH_RTIOC_STOP_TMTEST        \
+    _IOWR(RTIOC_TYPE_BENCHMARK, 0x11, struct rtbnch_overall_result)
+
+#define RTBNCH_RTIOC_BEGIN_TRACE        \
+    _IOW(RTIOC_TYPE_BENCHMARK, 0x20, long)
+
+#define RTBNCH_RTIOC_END_TRACE          \
+    _IOW(RTIOC_TYPE_BENCHMARK, 0x21, long)
+
+#define RTBNCH_RTIOC_FREEZE_TRACE       \
+    _IOW(RTIOC_TYPE_BENCHMARK, 0x22, int)
+
+/** @} */
+
+#endif /* _RTBENCHMARK_H */
Index: include/rtdm/rtdm.h
===================================================================
--- include/rtdm/rtdm.h	(Revision 334)
+++ include/rtdm/rtdm.h	(Arbeitskopie)
@@ -68,6 +68,7 @@
 #define RTDM_CLASS_CAN              3
 #define RTDM_CLASS_NETWORK          4
 #define RTDM_CLASS_RTMAC            5
+#define RTDM_CLASS_BENCHMARK        6
 /*
 #define RTDM_CLASS_USB              ?
 #define RTDM_CLASS_FIREWIRE         ?
Index: src/testsuite/latency/latency.c
===================================================================
--- src/testsuite/latency/latency.c	(Revision 334)
+++ src/testsuite/latency/latency.c	(Arbeitskopie)
@@ -11,6 +11,7 @@
 #include <xenomai/native/task.h>
 #include <xenomai/native/timer.h>
 #include <xenomai/native/sem.h>
+#include <xenomai/rtdm/rtbenchmark.h>
 
 RT_TASK latency_task, display_task;
 
@@ -29,7 +30,16 @@
 int test_duration = 0;  /* sec of testing, via -T <sec>, 0 is inf */
 int data_lines = 21;    /* data lines per header line, -l <lines> to change */
 int quiet = 0;          /* suppress printing of RTH, RTD lines when -T given */
+int benchdev_no = 0;
+int benchdev = -1;
+long freeze_threshold = 0;
 
+#define USER_TASK       0
+#define KERNEL_TASK     1
+#define TIMER_HANDLER   2
+
+int test_mode = USER_TASK;
+
 time_t test_start, test_end;    /* report test duration */
 int test_loops = 0;             /* outer loop count */
 
@@ -60,14 +70,6 @@
     RTIME expected_tsc, period_tsc, start_ticks;
     RT_TIMER_INFO timer_info;
 
-    err = rt_timer_start(TM_ONESHOT);
-
-    if (err)
-        {
-        fprintf(stderr,"latency: cannot start timer, code %d\n",err);
-        return;
-        }
-
     err = rt_timer_inquire(&timer_info);
     
     if (err)
@@ -76,6 +78,9 @@
         return;
         }
 
+    if (freeze_threshold > 0)
+        freeze_threshold = rt_timer_ns2tsc(freeze_threshold*1000);
+
     nsamples = ONE_BILLION / period_ns;
     period_tsc = rt_timer_ns2tsc(period_ns);
     /* start time: one millisecond from now. */
@@ -117,6 +122,9 @@
             if (dt < minj) minj = dt;
             sumj += dt;
 
+            if ((freeze_threshold > 0) && (dt > freeze_threshold))
+                rt_dev_ioctl(benchdev, RTBNCH_RTIOC_FREEZE_TRACE, freeze_threshold);
+
             if (!(finished || warmup) && (do_histogram || do_stats))
                 add_histogram(histogram_avg, dt);
             }
@@ -156,14 +164,43 @@
     int err, n = 0;
     time_t start;
 
-    err = rt_sem_create(&display_sem,"dispsem",0,S_FIFO);
+    if (test_mode == USER_TASK) {
+        err = rt_sem_create(&display_sem,"dispsem",0,S_FIFO);
 
-    if (err)
-        {
-        fprintf(stderr,"latency: cannot create semaphore: %s\n",strerror(-err));
-        return;
-        }
+        if (err)
+            {
+            fprintf(stderr,"latency: cannot create semaphore: %s\n",strerror(-err));
+            return;
+            }
 
+        printf("== Test mode: periodic userspace task\n");
+
+    } else {
+        struct rtbnch_timerconfig   config;
+
+        if (test_mode == KERNEL_TASK)
+            config.mode = RTBNCH_TIMER_TASK;
+        else
+            config.mode = RTBNCH_TIMER_HANDLER;
+
+        config.period               = period_ns;
+        config.warmup_loops         = WARMUP_TIME;
+        config.histogram_size       = (do_histogram || do_stats) ? histogram_size : 0;
+        config.histogram_bucketsize = bucketsize;
+        config.freeze_threshold     = freeze_threshold;
+
+        err = rt_dev_ioctl(benchdev, RTBNCH_RTIOC_START_TMTEST, &config);
+
+        if (err)
+            {
+            fprintf(stderr,"latency: failed to start in-kernel timer benchmark, code %d\n",err);
+            return;
+            }
+
+        printf("== Test mode: in-kernel %s\n",
+               (test_mode == TIMER_HANDLER) ? "timer handler" : "periodic task");
+    }
+
     time(&start);
 
     if (quiet)
@@ -172,23 +209,46 @@
     for (;;)
         {
         long minj, gminj, maxj, gmaxj, avgj;
-        err = rt_sem_p(&display_sem,TM_INFINITE);
 
-        if (err)
-            {
-            if (err != -EIDRM)
-                fprintf(stderr,"latency: failed to pend on semaphore, code %d\n",err);
+        if (test_mode == USER_TASK) {
+            err = rt_sem_p(&display_sem,TM_INFINITE);
 
-            rt_task_delete(NULL);
-            }
+            if (err)
+                {
+                if (err != -EIDRM)
+                    fprintf(stderr,"latency: failed to pend on semaphore, code %d\n",err);
 
-        /* convert jitters to nanoseconds. */
-        minj = rt_timer_tsc2ns(minjitter);
-        gminj = rt_timer_tsc2ns(gminjitter);
-        avgj = rt_timer_tsc2ns(avgjitter);
-        maxj = rt_timer_tsc2ns(maxjitter);
-        gmaxj = rt_timer_tsc2ns(gmaxjitter);
+                return;
+                }
 
+            /* convert jitters to nanoseconds. */
+            minj = rt_timer_tsc2ns(minjitter);
+            gminj = rt_timer_tsc2ns(gminjitter);
+            avgj = rt_timer_tsc2ns(avgjitter);
+            maxj = rt_timer_tsc2ns(maxjitter);
+            gmaxj = rt_timer_tsc2ns(gmaxjitter);
+
+        } else {
+            struct rtbnch_interm_result result;
+
+            err = rt_dev_ioctl(benchdev, RTBNCH_RTIOC_INTERM_RESULT, &result);
+
+            if (err)
+                {
+                if (err != -EIDRM)
+                    fprintf(stderr,"latency: failed to call RTBNCH_RTIOC_INTERM_RESULT, code %d\n",err);
+
+                return;
+                }
+
+            minj = result.last.min;
+            gminj = result.overall.min;
+            avgj = result.last.avg;
+            maxj = result.last.max;
+            gmaxj = result.overall.max;
+            goverrun = result.overall.overruns;
+        }
+
         if (!quiet)
             {
             if (data_lines && (n++ % data_lines)==0)
@@ -295,20 +355,40 @@
 
     finished = 1;
     rt_timer_stop();
-    rt_sem_delete(&display_sem);
 
+    if (test_mode == USER_TASK) {
+        rt_sem_delete(&display_sem);
+
+        gavgjitter /= (test_loops > 1 ? test_loops : 2)-1;
+
+        gminj = rt_timer_tsc2ns(gminjitter);
+        gmaxj = rt_timer_tsc2ns(gmaxjitter);
+        gavgj = rt_timer_tsc2ns(gavgjitter);
+    } else {
+        struct rtbnch_overall_result overall;
+
+        overall.histogram_min = histogram_min;
+        overall.histogram_max = histogram_max;
+        overall.histogram_avg = histogram_avg;
+
+        rt_dev_ioctl(benchdev, RTBNCH_RTIOC_STOP_TMTEST, &overall);
+
+        gminj    = overall.result.min;
+        gmaxj    = overall.result.max;
+        gavgj    = overall.result.avg;
+        goverrun = overall.result.overruns;
+    }
+
+    if (benchdev >= 0)
+        rt_dev_close(benchdev);
+
     if (do_histogram || do_stats)
         dump_hist_stats();
 
     time(&test_end);
     actual_duration = test_end - test_start - WARMUP_TIME;
     if (!test_duration) test_duration = actual_duration;
-    gavgjitter /= (test_loops > 1 ? test_loops : 2)-1;
 
-    gminj = rt_timer_tsc2ns(gminjitter);
-    gmaxj = rt_timer_tsc2ns(gmaxjitter);
-    gavgj = rt_timer_tsc2ns(gavgjitter);
-
     printf("---|------------|------------|------------|--------|-------------------------\n"
            "RTS|%12ld|%12ld|%12ld|%8ld|    %.2ld:%.2ld:%.2ld/%.2d:%.2d:%.2d\n",
            gminj,
@@ -333,7 +413,7 @@
 {
     int c, err;
 
-    while ((c = getopt(argc,argv,"hp:l:T:qH:B:s")) != EOF)
+    while ((c = getopt(argc,argv,"hp:l:T:qH:B:sD:t:f:")) != EOF)
         switch (c)
             {
             case 'h':
@@ -377,6 +457,21 @@
                 quiet = 1;
                 break;
 
+            case 'D':
+
+                benchdev_no = atoi(optarg);
+                break;
+
+            case 't':
+
+                test_mode = atoi(optarg);
+                break;
+
+            case 'f':
+
+                freeze_threshold = atoi(optarg);
+                break;
+
             default:
 
                 fprintf(stderr, "usage: latency [options]\n"
@@ -387,7 +482,10 @@
                         "  [-p <period_us>]             # sampling period\n"
                         "  [-l <data-lines per header>] # default=21, 0 to supress headers\n"
                         "  [-T <test_duration_seconds>] # default=0, so ^C to end\n"
-                        "  [-q]                         # supresses RTD, RTH lines if -T is used\n");
+                        "  [-q]                         # supresses RTD, RTH lines if -T is used\n"
+                        "  [-D <benchmark_device_no>]   # number of benchmark device, default=0\n"
+                        "  [-t <test_mode>]             # 0=user task (default), 1=kernel task, 2=timer IRQ\n"
+                        "  [-f <threshold_us>]          # freeze trace on latency exceeding threshold\n");
                 exit(2);
             }
 
@@ -397,6 +495,12 @@
         quiet = 0;
         }
 
+    if ((test_mode < USER_TASK) || (test_mode > TIMER_HANDLER))
+        {
+        fprintf(stderr, "latency: invalid test mode.\n");
+        exit(2);
+        }
+
     time(&test_start);
 
     histogram_avg = calloc(histogram_size, sizeof(long));
@@ -420,38 +524,63 @@
 
     mlockall(MCL_CURRENT|MCL_FUTURE);
 
-    err = rt_task_create(&display_task,"display",0,98,0);
+    err = rt_timer_start(TM_ONESHOT);
 
     if (err)
         {
-        fprintf(stderr,"latency: failed to create display task, code %d\n",err);
+        fprintf(stderr,"latency: cannot start timer, code %d\n",err);
         return 0;
         }
 
-    err = rt_task_start(&display_task,&display,NULL);
+    if ((test_mode != USER_TASK) || (freeze_threshold > 0))
+        {
+        char devname[RTDM_MAX_DEVNAME_LEN];
 
-    if (err)
-        {
-        fprintf(stderr,"latency: failed to start display task, code %d\n",err);
-        return 0;
+        snprintf(devname, RTDM_MAX_DEVNAME_LEN, "rtbenchmark%d", benchdev_no);
+        benchdev = rt_dev_open(devname, O_RDWR);
+
+        if (benchdev < 0)
+            {
+            fprintf(stderr,"latency: failed to open benchmark device, code %d\n"
+                    "(modprobe xeno_timerbench?)\n",benchdev);
+            return 0;
+            }
         }
 
-    err = rt_task_create(&latency_task,"sampling",0,99,T_FPU);
+    err = rt_task_create(&display_task,"display",0,98,0);
 
     if (err)
         {
-        fprintf(stderr,"latency: failed to create latency task, code %d\n",err);
+        fprintf(stderr,"latency: failed to create display task, code %d\n",err);
         return 0;
         }
 
-    err = rt_task_start(&latency_task,&latency,NULL);
+    err = rt_task_start(&display_task,&display,NULL);
 
     if (err)
         {
-        fprintf(stderr,"latency: failed to start latency task, code %d\n",err);
+        fprintf(stderr,"latency: failed to start display task, code %d\n",err);
         return 0;
         }
 
+    if (test_mode == USER_TASK) {
+        err = rt_task_create(&latency_task,"sampling",0,99,T_FPU);
+
+        if (err)
+            {
+            fprintf(stderr,"latency: failed to create latency task, code %d\n",err);
+            return 0;
+            }
+
+        err = rt_task_start(&latency_task,&latency,NULL);
+
+        if (err)
+            {
+            fprintf(stderr,"latency: failed to start latency task, code %d\n",err);
+            return 0;
+            }
+    }
+
     pause();
 
     return 0;
Index: src/testsuite/latency/runinfo
===================================================================
--- src/testsuite/latency/runinfo	(Revision 334)
+++ src/testsuite/latency/runinfo	(Arbeitskopie)
@@ -1 +1 @@
-latency:native:!./latency;popall:control_c
+latency:native+rtdm+timerbench:!./latency;popall:control_c
Index: src/testsuite/latency/Makefile.am
===================================================================
--- src/testsuite/latency/Makefile.am	(Revision 334)
+++ src/testsuite/latency/Makefile.am	(Arbeitskopie)
@@ -10,6 +10,7 @@
 
 latency_LDADD = \
 	../../skins/native/libnative.la \
+	../../skins/rtdm/librtdm.la \
 	-lpthread -lm
 
 install-data-local:
Index: ksrc/drivers/Kconfig
===================================================================
--- ksrc/drivers/Kconfig	(Revision 334)
+++ ksrc/drivers/Kconfig	(Arbeitskopie)
@@ -1 +1,2 @@
 source "drivers/xenomai/16550A/Kconfig"
+source "drivers/xenomai/benchmark/Kconfig"
Index: ksrc/drivers/Config.in
===================================================================
--- ksrc/drivers/Config.in	(Revision 334)
+++ ksrc/drivers/Config.in	(Arbeitskopie)
@@ -8,5 +8,6 @@
 mainmenu_option next_comment
 comment 'Real-time drivers'
 	source drivers/xenomai/16550A/Config.in
+	source drivers/xenomai/benchmark/Config.in
 endmenu
 fi
Index: ksrc/drivers/benchmark/Kconfig
===================================================================
--- ksrc/drivers/benchmark/Kconfig	(Revision 0)
+++ ksrc/drivers/benchmark/Kconfig	(Revision 0)
@@ -0,0 +1,7 @@
+config XENO_DRIVERS_TIMERBENCH
+	depends on XENO_SKIN_RTDM
+	tristate "Timer benchmark driver"
+	default n
+	help
+	Kernel-based benchmark driver for timer latency evaluation.
+	See testsuite/latency for a possible front-end.
Index: ksrc/drivers/benchmark/timerbench.c
===================================================================
--- ksrc/drivers/benchmark/timerbench.c	(Revision 0)
+++ ksrc/drivers/benchmark/timerbench.c	(Revision 0)
@@ -0,0 +1,538 @@
+/*
+ * Copyright (C) 2005 Jan Kiszka <jan.kiszka@domain.hid>.
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
+#include <linux/ipipe_trace.h>
+
+#include <xenomai/rtdm/rtbenchmark.h>
+#include <xenomai/rtdm/rtdm_driver.h>
+
+struct rt_tmbench_context {
+    int                         mode;
+    unsigned long               period;
+    unsigned long               freeze_threshold;
+    int                         warmup_loops;
+    int                         samples_per_sec;
+    long                        *histogram_min;
+    long                        *histogram_max;
+    long                        *histogram_avg;
+    int                         histogram_size;
+    int                         bucketsize;
+
+    rtdm_task_t                 timer_task;
+
+    xntimer_t                   timer;
+    int                         warmup;
+    uint64_t                    start_time;
+    uint64_t                    date;
+    struct rtbnch_result        curr;
+
+    rtdm_event_t                result_event;
+    struct rtbnch_interm_result result;
+
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
+static inline void add_histogram(struct rt_tmbench_context *ctx,
+                                 long *histogram, long addval)
+{
+    /* bucketsize steps */
+    long inabs = (addval >= 0 ? addval : -addval) / ctx->bucketsize;
+    histogram[inabs < ctx->histogram_size ? inabs : ctx->histogram_size-1]++;
+}
+
+
+void eval_inner_loop(struct rt_tmbench_context *ctx, long dt)
+{
+    if (ctx->date <= ctx->start_time)
+        ctx->curr.overruns++;
+
+    if (dt > ctx->curr.max)
+        ctx->curr.max = dt;
+    if (dt < ctx->curr.min)
+        ctx->curr.min = dt;
+    ctx->curr.avg += dt;
+
+#ifdef CONFIG_IPIPE_TRACE
+    if ((ctx->freeze_threshold > 0) && (dt > ctx->freeze_threshold))
+        ipipe_trace_freeze(ctx->freeze_threshold);
+#endif /* CONFIG_IPIPE_TRACE */
+
+    ctx->date += ctx->period;
+
+    if (!ctx->warmup && ctx->histogram_size)
+        add_histogram(ctx, ctx->histogram_avg, dt);
+}
+
+
+void eval_outer_loop(struct rt_tmbench_context *ctx)
+{
+    if (!ctx->warmup) {
+        if (ctx->histogram_size) {
+            add_histogram(ctx, ctx->histogram_max, ctx->curr.max);
+            add_histogram(ctx, ctx->histogram_min, ctx->curr.min);
+        }
+
+        ctx->result.last.min = ctx->curr.min;
+        if (ctx->curr.min < ctx->result.overall.min)
+            ctx->result.overall.min = ctx->curr.min;
+
+        ctx->result.last.max = ctx->curr.max;
+        if (ctx->curr.max > ctx->result.overall.max)
+            ctx->result.overall.max = ctx->curr.max;
+
+        ctx->result.last.avg = ctx->curr.avg / ctx->samples_per_sec;
+        ctx->result.overall.avg      += ctx->result.last.avg;
+        ctx->result.overall.overruns += ctx->curr.overruns;
+        rtdm_event_pulse(&ctx->result_event);
+    }
+
+    if (ctx->warmup &&
+        (ctx->result.overall.test_loops == ctx->warmup_loops)) {
+        ctx->result.overall.test_loops = 0;
+        ctx->warmup = 0;
+    }
+
+    ctx->curr.min        = 10000000;
+    ctx->curr.max        = -10000000;
+    ctx->curr.avg        = 0;
+    ctx->curr.overruns   = 0;
+
+    ctx->result.overall.test_loops++;
+}
+
+
+void timer_task_proc(void *arg)
+{
+    struct rt_tmbench_context   *ctx = (struct rt_tmbench_context *)arg;
+    int                         count;
+
+
+    /* start time: one millisecond from now. */
+    ctx->date = rtdm_clock_read() + 1000000;
+
+    while (1) {
+        int err;
+
+
+        for (count = 0; count < ctx->samples_per_sec; count++) {
+            RTDM_EXECUTE_ATOMICALLY(
+                ctx->start_time = rtdm_clock_read();
+                err = rtdm_task_sleep_until(ctx->date);
+            );
+
+            if (err)
+                return;
+
+            eval_inner_loop(ctx, (long)(rtdm_clock_read() - ctx->date));
+        }
+        eval_outer_loop(ctx);
+    }
+}
+
+
+void timer_proc(void *arg)
+{
+    struct rt_tmbench_context   *ctx = (struct rt_tmbench_context *)arg;
+
+
+    eval_inner_loop(ctx, (long)(rtdm_clock_read() - ctx->date));
+
+    ctx->start_time = rtdm_clock_read();
+    /* FIXME: convert to RTDM timers */
+    xntimer_start(&ctx->timer, xnpod_ns2ticks(ctx->date-ctx->start_time),
+                  XN_INFINITE);
+
+    if (++ctx->curr.test_loops < ctx->samples_per_sec)
+        return;
+
+    ctx->curr.test_loops = 0;
+    eval_outer_loop(ctx);
+}
+
+
+int rt_tmbench_open(struct rtdm_dev_context *context,
+                    rtdm_user_info_t *user_info, int oflags)
+{
+    struct rt_tmbench_context   *ctx;
+
+
+    ctx = (struct rt_tmbench_context *)context->dev_private;
+
+    ctx->mode = -1;
+    init_MUTEX(&ctx->nrt_mutex);
+
+    return 0;
+}
+
+
+int rt_tmbench_close(struct rtdm_dev_context *context,
+                     rtdm_user_info_t *user_info)
+{
+    struct rt_tmbench_context   *ctx;
+
+
+    ctx = (struct rt_tmbench_context *)context->dev_private;
+
+    down(&ctx->nrt_mutex);
+
+    if (ctx->mode >= 0) {
+        if (ctx->mode == RTBNCH_TIMER_TASK)
+            rtdm_task_destroy(&ctx->timer_task);
+        else
+            /* FIXME: convert to RTDM timers */
+            xntimer_destroy(&ctx->timer);
+
+        rtdm_event_destroy(&ctx->result_event);
+
+        if (ctx->histogram_size)
+            kfree(ctx->histogram_min);
+
+        ctx->mode           = -1;
+        ctx->histogram_size = 0;
+    }
+
+    up(&ctx->nrt_mutex);
+
+    return 0;
+}
+
+
+#ifdef CONFIG_IPIPE_TRACE
+int tracer_ioctl(int request, long v)
+{
+    switch (request) {
+        case RTBNCH_RTIOC_BEGIN_TRACE:
+            ipipe_trace_begin(v);
+            break;
+
+        case RTBNCH_RTIOC_END_TRACE:
+            ipipe_trace_end(v);
+            break;
+
+        case RTBNCH_RTIOC_FREEZE_TRACE:
+            ipipe_trace_freeze(v);
+            break;
+
+        default:
+            return 0;
+    }
+    return 1;
+}
+#else /* !CONFIG_IPIPE_TRACE */
+#define tracer_ioctl(request, v)    (0)
+#endif /* CONFIG_IPIPE_TRACE */
+
+
+int rt_tmbench_ioctl_nrt(struct rtdm_dev_context *context,
+                         rtdm_user_info_t *user_info, int request, void *arg)
+{
+    struct rt_tmbench_context   *ctx;
+    int                         ret = 0;
+
+
+    if (tracer_ioctl(request, (long)arg))
+        return 0;
+
+    ctx = (struct rt_tmbench_context *)context->dev_private;
+
+    switch (request) {
+        case RTBNCH_RTIOC_START_TMTEST: {
+            struct rtbnch_timerconfig   config_buf;
+            struct rtbnch_timerconfig   *config;
+
+
+            config = (struct rtbnch_timerconfig *)arg;
+            if (user_info) {
+                if (!rtdm_read_user_ok(user_info, arg,
+                                       sizeof(struct rtbnch_timerconfig)) ||
+                    rtdm_copy_from_user(user_info, &config_buf, arg,
+                                        sizeof(struct rtbnch_timerconfig)))
+                    return -EFAULT;
+
+                config = &config_buf;
+            }
+
+            down(&ctx->nrt_mutex);
+
+            ctx->period           = config->period;
+            ctx->warmup_loops     = config->warmup_loops;
+            ctx->samples_per_sec  = 1000000000 / ctx->period;
+            ctx->histogram_size   = config->histogram_size;
+            ctx->freeze_threshold = config->freeze_threshold;
+
+            if (ctx->histogram_size > 0) {
+                ctx->histogram_min =
+                    kmalloc(3 * ctx->histogram_size * sizeof(long),
+                            GFP_KERNEL);
+                ctx->histogram_max =
+                    ctx->histogram_min + config->histogram_size;
+                ctx->histogram_avg =
+                    ctx->histogram_max + config->histogram_size;
+
+                if (!ctx->histogram_min) {
+                    up(&ctx->nrt_mutex);
+                    return -ENOMEM;
+                }
+
+                memset(ctx->histogram_min, 0,
+                       3 * ctx->histogram_size * sizeof(long));
+                ctx->bucketsize = config->histogram_bucketsize;
+            }
+
+            ctx->result.overall.min        = 10000000;
+            ctx->result.overall.max        = -10000000;
+            ctx->result.overall.avg        = 0;
+            ctx->result.overall.test_loops = 1;
+            ctx->result.overall.overruns   = 0;
+
+            ctx->warmup = 1;
+
+            ctx->curr.min        = 10000000;
+            ctx->curr.max        = -10000000;
+            ctx->curr.avg        = 0;
+            ctx->curr.overruns   = 0;
+
+            rtdm_event_init(&ctx->result_event, 0);
+
+            if (config->mode == RTBNCH_TIMER_TASK) {
+                if (!test_bit(RTDM_CLOSING, &context->context_flags)) {
+                    ctx->mode = RTBNCH_TIMER_TASK;
+                    ret = rtdm_task_init(&ctx->timer_task, "timerbench",
+                                         timer_task_proc, ctx,
+                                         RTDM_TASK_HIGHEST_PRIORITY, 0);
+                }
+            } else {
+                /* FIXME: convert to RTDM timers */
+                xntimer_init(&ctx->timer, timer_proc, ctx);
+
+                ctx->curr.test_loops = 0;
+
+                if (!test_bit(RTDM_CLOSING, &context->context_flags)) {
+                    ctx->mode = RTBNCH_TIMER_HANDLER;
+                    RTDM_EXECUTE_ATOMICALLY(
+                        /* start time: one millisecond from now. */
+                        ctx->start_time = rtdm_clock_read() + 1000000;
+                        ctx->date       = ctx->start_time + ctx->period;
+
+                        /* FIXME: convert to RTDM timers */
+                        xntimer_start(&ctx->timer,
+                                xnpod_ns2ticks(ctx->date-rtdm_clock_read()),
+                                XN_INFINITE);
+                    );
+                }
+            }
+
+            up(&ctx->nrt_mutex);
+
+            break;
+        }
+
+        case RTBNCH_RTIOC_STOP_TMTEST: {
+            struct rtbnch_overall_result *usr_res;
+
+
+            usr_res = (struct rtbnch_overall_result *)arg;
+
+            down(&ctx->nrt_mutex);
+
+            if (ctx->mode < 0) {
+                up(&ctx->nrt_mutex);
+                return -EINVAL;
+            }
+
+            if (ctx->mode == RTBNCH_TIMER_TASK)
+                rtdm_task_destroy(&ctx->timer_task);
+            else
+                /* FIXME: convert to RTDM timers */
+                xntimer_destroy(&ctx->timer);
+
+            rtdm_event_destroy(&ctx->result_event);
+
+            ctx->mode = -1;
+
+            ctx->result.overall.avg /=
+                    ((ctx->result.overall.test_loops) > 1 ?
+                     ctx->result.overall.test_loops : 2) - 1;
+
+            if (user_info) {
+                if (!rtdm_rw_user_ok(user_info, usr_res,
+                                     sizeof(struct rtbnch_overall_result)) ||
+                    rtdm_copy_to_user(user_info, &usr_res->result,
+                                      &ctx->result.overall,
+                                      sizeof(struct rtbnch_result)))
+                    ret = -EFAULT;
+            } else {
+                memcpy(&usr_res->result, &ctx->result.overall,
+                       sizeof(struct rtbnch_result));
+            }
+
+            if (ctx->histogram_size) {
+                int size = ctx->histogram_size * sizeof(long);
+
+                if (user_info) {
+                    if (!rtdm_rw_user_ok(user_info, usr_res->histogram_min,
+                                         size) ||
+                        rtdm_copy_to_user(user_info, usr_res->histogram_min,
+                                          ctx->histogram_min, size) ||
+                        !rtdm_rw_user_ok(user_info, usr_res->histogram_max,
+                                         size) ||
+                        rtdm_copy_to_user(user_info, usr_res->histogram_max,
+                                          ctx->histogram_max, size) ||
+                        !rtdm_rw_user_ok(user_info, usr_res->histogram_avg,
+                                         size) ||
+                        rtdm_copy_to_user(user_info, usr_res->histogram_avg,
+                                          ctx->histogram_avg, size))
+                        ret = -EFAULT;
+                } else {
+                    memcpy(usr_res->histogram_min, ctx->histogram_min, size);
+                    memcpy(usr_res->histogram_max, ctx->histogram_max, size);
+                    memcpy(usr_res->histogram_avg, ctx->histogram_avg, size);
+                }
+
+                kfree(ctx->histogram_min);
+            }
+
+            up(&ctx->nrt_mutex);
+
+            break;
+        }
+
+        case RTBNCH_RTIOC_INTERM_RESULT:
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
+int rt_tmbench_ioctl_rt(struct rtdm_dev_context *context,
+                        rtdm_user_info_t *user_info, int request, void *arg)
+{
+    struct rt_tmbench_context   *ctx;
+    int                         ret = 0;
+
+
+    if (tracer_ioctl(request, (long)arg))
+        return 0;
+
+    ctx = (struct rt_tmbench_context *)context->dev_private;
+
+    switch (request) {
+        case RTBNCH_RTIOC_INTERM_RESULT: {
+            struct rtbnch_interm_result *usr_res;
+
+
+            usr_res = (struct rtbnch_interm_result *)arg;
+
+            ret = rtdm_event_wait(&ctx->result_event);
+            if (ret < 0)
+                return ret;
+
+            if (user_info) {
+                if (!rtdm_rw_user_ok(user_info, usr_res,
+                                     sizeof(struct rtbnch_interm_result)) ||
+                    rtdm_copy_to_user(user_info, usr_res, &ctx->result,
+                                      sizeof(struct rtbnch_interm_result)))
+                    ret = -EFAULT;
+            } else
+                memcpy(usr_res, &ctx->result,
+                       sizeof(struct rtbnch_interm_result));
+
+            break;
+        }
+
+        case RTBNCH_RTIOC_START_TMTEST:
+        case RTBNCH_RTIOC_STOP_TMTEST:
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
+    device_flags:       RTDM_NAMED_DEVICE | RTDM_EXCLUSIVE,
+    context_size:       sizeof(struct rt_tmbench_context),
+    device_name:        "",
+
+    open_rt:            NULL,
+    open_nrt:           rt_tmbench_open,
+
+    ops: {
+        close_rt:       NULL,
+        close_nrt:      rt_tmbench_close,
+
+        ioctl_rt:       rt_tmbench_ioctl_rt,
+        ioctl_nrt:      rt_tmbench_ioctl_nrt,
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
+    device_class:       RTDM_CLASS_BENCHMARK,
+    device_sub_class:   RTDM_SUBCLASS_TIMER,
+    driver_name:        "xeno_timerbench",
+    driver_version:     RTDM_DRIVER_VER(0, 1, 0),
+    peripheral_name:    "Timer Latency Benchmark",
+    provider_name:      "Jan Kiszka",
+    proc_name:          device.device_name,
+};
+
+int __init init_module(void)
+{
+    snprintf(device.device_name, RTDM_MAX_DEVNAME_LEN, "rtbenchmark%d",
+             start_index);
+
+    return rtdm_dev_register(&device);
+}
+
+
+void cleanup_module(void)
+{
+    rtdm_dev_unregister(&device, 1000);
+}
Index: ksrc/drivers/benchmark/Config.in
===================================================================
--- ksrc/drivers/benchmark/Config.in	(Revision 0)
+++ ksrc/drivers/benchmark/Config.in	(Revision 0)
@@ -0,0 +1,5 @@
+#
+# Xenomai configuration for Linux v2.4
+#
+
+dep_tristate 'Timer benchmark driver' CONFIG_XENO_DRIVERS_TIMERBENCH $CONFIG_XENO_SKIN_RTDM
Index: ksrc/drivers/benchmark/Makefile
===================================================================
--- ksrc/drivers/benchmark/Makefile	(Revision 0)
+++ ksrc/drivers/benchmark/Makefile	(Revision 0)
@@ -0,0 +1,30 @@
+ifeq ($(PATCHLEVEL),6)
+
+# Makefile frag for Linux v2.6
+
+obj-$(CONFIG_XENO_DRIVERS_TIMERBENCH) += xeno_timerbench.o
+
+xeno_timerbench-y := timerbench.o
+
+else
+
+# Makefile frag for Linux v2.4
+
+O_TARGET := built-in.o
+
+obj-$(CONFIG_XENO_DRIVERS_TIMERBENCH) := xeno_timerbench.o
+
+list-multi := xeno_timerbench.o
+
+xeno_timerbench-objs := timerbench.o
+
+export-objs := $(xeno_timerbench-objs)
+
+EXTRA_CFLAGS += -I$(TOPDIR)/include/xenomai/compat
+
+include $(TOPDIR)/Rules.make
+
+xeno_timerbench.o: $(xeno_timerbench-objs)
+	$(LD) -r -o $@ $(xeno_timerbench-objs)
+
+endif
Index: ksrc/drivers/Makefile
===================================================================
--- ksrc/drivers/Makefile	(Revision 334)
+++ ksrc/drivers/Makefile	(Arbeitskopie)
@@ -2,7 +2,7 @@
 
 # Makefile frag for Linux v2.6
 
-obj-$(CONFIG_XENOMAI) += 16550A/
+obj-$(CONFIG_XENOMAI) += 16550A/ benchmark/
 
 else
 
@@ -10,6 +10,8 @@
 
 subdir-$(CONFIG_XENO_DRIVERS_16550A) += 16550A
 
+subdir-$(CONFIG_XENO_DRIVERS_TIMERBENCH) += benchmark
+
 include $(TOPDIR)/Rules.make
 
 endif

--------------040105030705060009040702--

--------------enigB8F327E9EDE40A29C36A6AE7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDuSdFniDOoMHTA+kRAqKIAJ4xw/dVQuh1UCzvdjz1LNFZygITdQCfWF18
BntAk3fVp9DZxz8BOIhbIIU=
=++xk
-----END PGP SIGNATURE-----

--------------enigB8F327E9EDE40A29C36A6AE7--

