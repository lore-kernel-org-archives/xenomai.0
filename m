Message-Id: <20060626172119.347898000@domain.hid>
References: <20060626172116.019532000@domain.hid>
Date: Mon, 26 Jun 2006 19:21:20 +0200
From: jan.kiszka@domain.hid
Content-Disposition: inline; filename=latency-add-prio-switch.patch
Subject: [Xenomai-core] [PATCH 4/6] Add prio switch to latency test
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

Introduces -P <priority> switch to the latency test and extends xeno_timerbench to respect this for the kernel-based timer task as well. The patch also allows now to run multiple latency tests (both in-kernel and user-space) in parallel.

---
 include/rtdm/rttesting.h          |    1 +
 ksrc/drivers/testing/timerbench.c |    4 ++--
 src/testsuite/latency/latency.c   |   20 ++++++++++++++++----
 3 files changed, 19 insertions(+), 6 deletions(-)

Index: xenomai/include/rtdm/rttesting.h
===================================================================
--- xenomai.orig/include/rtdm/rttesting.h
+++ xenomai/include/rtdm/rttesting.h
@@ -86,6 +86,7 @@ typedef struct rttst_overall_bench_res {
 typedef struct rttst_tmbench_config {
     int                     mode;
     uint64_t                period;
+    int                     priority;
     int                     warmup_loops;
     int                     histogram_size;
     int                     histogram_bucketsize;
Index: xenomai/ksrc/drivers/testing/timerbench.c
===================================================================
--- xenomai.orig/ksrc/drivers/testing/timerbench.c
+++ xenomai/ksrc/drivers/testing/timerbench.c
@@ -305,7 +305,7 @@ int rt_tmbench_ioctl_nrt(struct rtdm_dev
                     ctx->mode = RTTST_TMBENCH_TASK;
                     ret = rtdm_task_init(&ctx->timer_task, "timerbench",
                                          timer_task_proc, ctx,
-                                         RTDM_TASK_HIGHEST_PRIORITY, 0);
+                                         config->priority, 0);
                 }
             } else {
                 /* FIXME: convert to RTDM timers */
@@ -465,7 +465,7 @@ int rt_tmbench_ioctl_rt(struct rtdm_dev_
 static struct rtdm_device device = {
     struct_version:     RTDM_DEVICE_STRUCT_VER,
 
-    device_flags:       RTDM_NAMED_DEVICE | RTDM_EXCLUSIVE,
+    device_flags:       RTDM_NAMED_DEVICE,
     context_size:       sizeof(struct rt_tmbench_context),
     device_name:        "",
 
Index: xenomai/src/testsuite/latency/latency.c
===================================================================
--- xenomai.orig/src/testsuite/latency/latency.c
+++ xenomai/src/testsuite/latency/latency.c
@@ -34,6 +34,7 @@ int quiet = 0;          /* suppress prin
 int benchdev_no = 0;
 int benchdev = -1;
 int freeze_max = 0;
+int priority = T_HIPRIO;
 
 #define USER_TASK       0
 #define KERNEL_TASK     1
@@ -194,6 +195,7 @@ void display (void *cookie)
             config.mode = RTTST_TMBENCH_HANDLER;
 
         config.period               = period_ns;
+        config.priority             = priority;
         config.warmup_loops         = WARMUP_TIME;
         config.histogram_size       = (do_histogram || do_stats) ? histogram_size : 0;
         config.histogram_bucketsize = bucketsize;
@@ -425,7 +427,7 @@ int main (int argc, char **argv)
     char task_name[16];
     int cpu = 0;
 
-    while ((c = getopt(argc,argv,"hp:l:T:qH:B:sD:t:fc:")) != EOF)
+    while ((c = getopt(argc,argv,"hp:l:T:qH:B:sD:t:fc:P:")) != EOF)
         switch (c)
             {
             case 'h':
@@ -488,6 +490,10 @@ int main (int argc, char **argv)
                 cpu = T_CPU(atoi(optarg));
                 break;
 
+            case 'P':
+                priority = atoi(optarg);
+                break;
+
             default:
 
                 fprintf(stderr, "usage: latency [options]\n"
@@ -502,7 +508,8 @@ int main (int argc, char **argv)
                         "  [-D <testing_device_no>]     # number of testing device, default=0\n"
                         "  [-t <test_mode>]             # 0=user task (default), 1=kernel task, 2=timer IRQ\n"
                         "  [-f]                         # freeze trace for each new max latency\n"
-                        "  [-c <cpu>]                   # pin measuring task down to given CPU\n");
+                        "  [-c <cpu>]                   # pin measuring task down to given CPU\n"
+                        "  [-P <priority>]              # task priority (test mode 0 and 1 only)\n");
                 exit(2);
             }
 
@@ -530,6 +537,11 @@ int main (int argc, char **argv)
     if (period_ns == 0)
         period_ns = 100000LL; /* ns */
 
+    if (priority <= T_LOPRIO)
+        priority = T_LOPRIO + 1;
+    else if (priority > T_HIPRIO)
+        priority = T_HIPRIO;
+
     signal(SIGINT, cleanup_upon_sig);
     signal(SIGTERM, cleanup_upon_sig);
     signal(SIGHUP, cleanup_upon_sig);
@@ -563,7 +575,7 @@ int main (int argc, char **argv)
     rt_timer_set_mode(TM_ONESHOT); /* Force aperiodic timing. */
 
     snprintf(task_name, sizeof(task_name), "display-%d", getpid());
-    err = rt_task_create(&display_task,task_name,0,98,T_FPU);
+    err = rt_task_create(&display_task,task_name,0,0,T_FPU);
 
     if (err)
         {
@@ -581,7 +593,7 @@ int main (int argc, char **argv)
 
     if (test_mode == USER_TASK) {
         snprintf(task_name, sizeof(task_name), "sampling-%d", getpid());
-        err = rt_task_create(&latency_task,task_name,0,99,T_FPU|cpu);
+        err = rt_task_create(&latency_task,task_name,0,priority,T_FPU|cpu);
 
         if (err)
             {

--

