Message-Id: <20060626172118.844776000@domain.hid>
References: <20060626172116.019532000@domain.hid>
Date: Mon, 26 Jun 2006 19:21:19 +0200
From: jan.kiszka@domain.hid
Content-Disposition: inline; filename=rttesting-refactoring.patch
Subject: [Xenomai-core] [PATCH 3/6] Refactor rttesting device interface
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

Refactors the RTDM rttesting header to apply more regular naming and propagates the changes through all users. The patch also extends the testing devices to automatically acquire a free rttestX device name if the first one is busy.

---
 include/rtdm/rttesting.h          |  129 ++++++++++++++++++--------------------
 ksrc/drivers/testing/switchtest.c |   97 +++++++++++++++-------------
 ksrc/drivers/testing/timerbench.c |  111 +++++++++++++++++---------------
 src/testsuite/latency/latency.c   |   26 +++----
 src/testsuite/switchtest/switch.c |   69 ++++++++++----------
 5 files changed, 223 insertions(+), 209 deletions(-)

Index: xenomai/include/rtdm/rttesting.h
===================================================================
--- xenomai.orig/include/rtdm/rttesting.h
+++ xenomai/include/rtdm/rttesting.h
@@ -31,9 +31,9 @@
  * @n
  *
  * @par Device Characteristics
- * @ref rtdm_device.device_flags "Device Flags": @c RTDM_NAMED_DEVICE, @c RTDM_EXCLUSIVE @n
+ * @ref rtdm_device.device_flags "Device Flags": @c RTDM_NAMED_DEVICE @n
  * @n
- * @ref rtdm_device.device_name "Device Name": @c "rtbenchmark<N>", N >= 0 @n
+ * @ref rtdm_device.device_name "Device Name": @c "rttest<N>", N >= 0 @n
  * @n
  * @ref rtdm_device.device_class "Device Class": @c RTDM_CLASS_TESTING @n
  * @n
@@ -48,8 +48,8 @@
  * Specific return values: none @n
  * @n
  * @b IOCTL @n
- * Mandatory Environments: see @ref TIMER_IOCTLs "below" @n
- * Specific return values: see @ref TIMER_IOCTLs "below" @n
+ * Mandatory Environments: see @ref IOCTLs below @n
+ * Specific return values: see @ref IOCTLs below @n
  *
  * @{
  */
@@ -59,105 +59,100 @@
 
 #include <rtdm/rtdm.h>
 
-#define RTBNCH_TIMER_TASK       0
-#define RTBNCH_TIMER_HANDLER    1
-
-typedef struct rtbnch_result {
+typedef struct rttst_bench_res {
     long long               avg;
     long                    min;
     long                    max;
     long                    overruns;
     long                    test_loops;
-} rtbnch_result_t;
+} rttst_bench_res_t;
+
+typedef struct rttst_interm_bench_res {
+    struct rttst_bench_res  last;
+    struct rttst_bench_res  overall;
+} rttst_interm_bench_res_t;
+
+typedef struct rttst_overall_bench_res {
+    struct rttst_bench_res  result;
+    long                    *histogram_avg;
+    long                    *histogram_min;
+    long                    *histogram_max;
+} rttst_overall_bench_res_t;
+
+
+#define RTTST_TMBENCH_TASK       0
+#define RTTST_TMBENCH_HANDLER    1
 
-typedef struct rtbnch_timerconfig {
+typedef struct rttst_tmbench_config {
     int                     mode;
     uint64_t                period;
     int                     warmup_loops;
     int                     histogram_size;
     int                     histogram_bucketsize;
     int                     freeze_max;
-} rtbnch_timerconfig_t;
+} rttst_tmbench_config_t;
 
-typedef struct rtbnch_interm_result {
-    struct rtbnch_result    last;
-    struct rtbnch_result    overall;
-} rtbnch_interm_result_t;
 
-typedef struct rtbnch_overall_result {
-    struct rtbnch_result    result;
-    long                    *histogram_avg;
-    long                    *histogram_min;
-    long                    *histogram_max;
-} rtbnch_overall_result_t;
+#define RTTST_SWTEST_FPU            0x1
+#define RTTST_SWTEST_USE_FPU        0x2 /* Only for kernel-space tasks. */
+
+struct rttst_swtest_task {
+    unsigned index;
+    unsigned flags;
+};
+
+struct rttst_swtest_dir {
+    unsigned from;
+    unsigned to;
+};
 
 
-#define RTIOC_TYPE_BENCHMARK        RTDM_CLASS_TESTING
+#define RTIOC_TYPE_TESTING          RTDM_CLASS_TESTING
 
 /*!
  * @name Sub-Classes of RTDM_CLASS_TESTING
  * @{ */
-#define RTDM_SUBCLASS_TIMER         0
-
-#define RTDM_SUBCLASS_SWITCH        1
+#define RTDM_SUBCLASS_TIMERBENCH    0
+#define RTDM_SUBCLASS_IRQBENCH      1
+#define RTDM_SUBCLASS_SWITCHTEST    2
 /** @} */
 
 
 /*!
- * @anchor TIMER_IOCTLs @name TIMER_IOCTLs
- * Timer benchmark device IOCTLs
+ * @anchor IOCTLs @name IOCTLs
+ * Testing device IOCTLs
  * @{ */
-#define RTBNCH_RTIOC_INTERM_RESULT      \
-    _IOWR(RTIOC_TYPE_BENCHMARK, 0x00, struct rtbnch_interm_result)
-
-#define RTBNCH_RTIOC_START_TMTEST       \
-    _IOW(RTIOC_TYPE_BENCHMARK, 0x10, struct rtbnch_timerconfig)
-
-#define RTBNCH_RTIOC_STOP_TMTEST        \
-    _IOWR(RTIOC_TYPE_BENCHMARK, 0x11, struct rtbnch_overall_result)
-/** @} */
-
+#define RTTST_RTIOC_INTERM_BENCH_RES \
+    _IOWR(RTIOC_TYPE_TESTING, 0x00, struct rttst_interm_bench_res)
 
-#define RTIOC_TYPE_SWITCH           RTDM_CLASS_TESTING
 
-#define RTSWITCH_FPU     0x1
-#define RTSWITCH_USE_FPU 0x2 /* Only for kernel-space tasks. */
+#define RTTST_RTIOC_TMBENCH_START \
+    _IOW(RTIOC_TYPE_TESTING, 0x10, struct rttst_tmbench_config)
 
+#define RTTST_RTIOC_TMBENCH_STOP \
+    _IOWR(RTIOC_TYPE_TESTING, 0x11, struct rttst_overall_bench_res)
 
-struct rtswitch_task {
-    unsigned index;
-    unsigned flags;
-};
-
-struct rtswitch {
-    unsigned from;
-    unsigned to;
-};
 
-/**
- * @anchor SWITCH_IOCTLs @name @SWITCH_IOCTLs
- * Context-switch testing device IOCTLs
- * @{ */
-#define RTSWITCH_RTIOC_TASKS_COUNT                   \
-    _IOW(RTIOC_TYPE_SWITCH, 0x30, unsigned long)
+#define RTTST_RTIOC_SWTEST_SET_TASKS_COUNT \
+    _IOW(RTIOC_TYPE_TESTING, 0x30, unsigned long)
 
-#define RTSWITCH_RTIOC_SET_CPU \
-    _IOW(RTIOC_TYPE_SWITCH, 0x31, unsigned long)
+#define RTTST_RTIOC_SWTEST_SET_CPU \
+    _IOW(RTIOC_TYPE_TESTING, 0x31, unsigned long)
 
-#define RTSWITCH_RTIOC_REGISTER_UTASK \
-    _IOW(RTIOC_TYPE_SWITCH, 0x32, struct rtswitch_task)
+#define RTTST_RTIOC_SWTEST_REGISTER_UTASK \
+    _IOW(RTIOC_TYPE_TESTING, 0x32, struct rttst_swtest_task)
 
-#define RTSWITCH_RTIOC_CREATE_KTASK \
-    _IOWR(RTIOC_TYPE_SWITCH, 0x33, struct rtswitch_task)
+#define RTTST_RTIOC_SWTEST_CREATE_KTASK \
+    _IOWR(RTIOC_TYPE_TESTING, 0x33, struct rttst_swtest_task)
 
-#define RTSWITCH_RTIOC_PEND \
-    _IOR(RTIOC_TYPE_SWITCH, 0x34, struct rtswitch_task)
+#define RTTST_RTIOC_SWTEST_PEND \
+    _IOR(RTIOC_TYPE_TESTING, 0x34, struct rttst_swtest_task)
 
-#define RTSWITCH_RTIOC_SWITCH_TO \
-    _IOR(RTIOC_TYPE_SWITCH, 0x35, struct rtswitch)
+#define RTTST_RTIOC_SWTEST_SWITCH_TO \
+    _IOR(RTIOC_TYPE_TESTING, 0x35, struct rttst_swtest_dir)
 
-#define RTSWITCH_RTIOC_GET_SWITCHES_COUNT \
-    _IOR(RTIOC_TYPE_SWITCH, 0x36, unsigned long)
+#define RTTST_RTIOC_SWTEST_GET_SWITCHES_COUNT \
+    _IOR(RTIOC_TYPE_TESTING, 0x36, unsigned long)
 /** @} */
 
 /** @} */
Index: xenomai/ksrc/drivers/testing/switchtest.c
===================================================================
--- xenomai.orig/ksrc/drivers/testing/switchtest.c
+++ xenomai/ksrc/drivers/testing/switchtest.c
@@ -10,7 +10,7 @@
 #define RTSWITCH_KERNEL  0x8
 
 typedef struct {
-	struct rtswitch_task base;
+	struct rttst_swtest_task base;
 	xnsynch_t rt_synch;
 	struct semaphore nrt_synch;
 	xnthread_t ktask;          /* For kernel-space real-time tasks. */
@@ -25,6 +25,11 @@ typedef struct rtswitch_context {
 	unsigned switches_count;
 } rtswitch_context_t;
 
+static unsigned int start_index;
+
+module_param(start_index, uint, 0400);
+MODULE_PARM_DESC(start_index, "First device instance number to be used");
+
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Gilles.Chanteperdrix@domain.hid");
 
@@ -163,9 +168,9 @@ static int rtswitch_set_tasks_count(rtsw
 
 	if (!tasks)
 		return -ENOMEM;
-    
+
 	down(&ctx->lock);
-    
+
 	if (ctx->tasks)
 		kfree(ctx->tasks);
 
@@ -179,7 +184,7 @@ static int rtswitch_set_tasks_count(rtsw
 }
 
 static int rtswitch_register_task(rtswitch_context_t *ctx,
-                                  struct rtswitch_task *arg)
+                                  struct rttst_swtest_task *arg)
 {
 	rtswitch_task_t *t;
 
@@ -226,10 +231,10 @@ static void rtswitch_ktask(void *cookie)
 		if (to == task->base.index)
 			++to;
 
-		if (task->base.flags & RTSWITCH_USE_FPU)
+		if (task->base.flags & RTTST_SWTEST_USE_FPU)
 			fp_regs_set(task->base.index + i * 1000);
 		rtswitch_to_rt(ctx, task->base.index, to);
-		if (task->base.flags & RTSWITCH_USE_FPU)
+		if (task->base.flags & RTTST_SWTEST_USE_FPU)
 			if (fp_regs_check(task->base.index + i * 1000))
 				xnpod_suspend_self();
 
@@ -239,7 +244,7 @@ static void rtswitch_ktask(void *cookie)
 }
 
 static int rtswitch_create_ktask(rtswitch_context_t *ctx,
-                                 struct rtswitch_task *ptask)
+                                 struct rttst_swtest_task *ptask)
 {
 	rtswitch_task_t *task;
 	xnflags_t init_flags;
@@ -260,14 +265,14 @@ static int rtswitch_create_ktask(rtswitc
 	arg.ctx = ctx;
 	arg.task = task;
 
-	init_flags = (ptask->flags & RTSWITCH_FPU) ? XNFPU : 0;
+	init_flags = (ptask->flags & RTTST_SWTEST_FPU) ? XNFPU : 0;
 
 	/* Migrate the calling thread to the same CPU as the created task, in
 	   order to be sure that the created task is suspended when this function
 	   returns. This also allow us to use the stack to pass the parameters to
 	   the created task. */
 	set_cpus_allowed(current, cpumask_of_cpu(ctx->cpu));
-    
+
 	err = xnpod_init_thread(&task->ktask, name, 1, init_flags, 0);
 
 	if (!err)
@@ -331,25 +336,25 @@ static int rtswitch_ioctl_nrt(struct rtd
                               void *arg)
 {
 	rtswitch_context_t *ctx = (rtswitch_context_t *) context->dev_private;
-	struct rtswitch_task task;
-	struct rtswitch fromto;
+	struct rttst_swtest_task task;
+	struct rttst_swtest_dir fromto;
 	unsigned long count;
 	int err;
 
 	switch (request)
 		{
-		case RTSWITCH_RTIOC_TASKS_COUNT:
+		case RTTST_RTIOC_SWTEST_SET_TASKS_COUNT:
 			return rtswitch_set_tasks_count(ctx,
 							(unsigned long) arg);
 
-		case RTSWITCH_RTIOC_SET_CPU:
+		case RTTST_RTIOC_SWTEST_SET_CPU:
 			if ((unsigned long) arg > xnarch_num_online_cpus() - 1)
 				return -EINVAL;
 
 			ctx->cpu = (unsigned long) arg;
 			return 0;
 
-		case RTSWITCH_RTIOC_REGISTER_UTASK:
+		case RTTST_RTIOC_SWTEST_REGISTER_UTASK:
 			if (!rtdm_rw_user_ok(user_info, arg, sizeof(task)))
 				return -EFAULT;
 
@@ -365,7 +370,7 @@ static int rtswitch_ioctl_nrt(struct rtd
 
 			return err;
 
-		case RTSWITCH_RTIOC_CREATE_KTASK:
+		case RTTST_RTIOC_SWTEST_CREATE_KTASK:
 			if (!rtdm_rw_user_ok(user_info, arg, sizeof(task)))
 				return -EFAULT;
 
@@ -381,15 +386,15 @@ static int rtswitch_ioctl_nrt(struct rtd
 
 			return err;
 
-		case RTSWITCH_RTIOC_PEND:
+		case RTTST_RTIOC_SWTEST_PEND:
 			if (!rtdm_read_user_ok(user_info, arg, sizeof(task)))
 				return -EFAULT;
 
 			rtdm_copy_from_user(user_info, &task, arg, sizeof(task));
-            
+
 			return rtswitch_pend_nrt(ctx, task.index);
 
-		case RTSWITCH_RTIOC_SWITCH_TO:
+		case RTTST_RTIOC_SWTEST_SWITCH_TO:
 			if (!rtdm_read_user_ok(user_info, arg, sizeof(fromto)))
 				return -EFAULT;
 
@@ -402,7 +407,7 @@ static int rtswitch_ioctl_nrt(struct rtd
 
 			return 0;
 
-		case RTSWITCH_RTIOC_GET_SWITCHES_COUNT:
+		case RTTST_RTIOC_SWTEST_GET_SWITCHES_COUNT:
 			if (!rtdm_rw_user_ok(user_info, arg, sizeof(count)))
 				return -EFAULT;
 
@@ -411,7 +416,7 @@ static int rtswitch_ioctl_nrt(struct rtd
 			rtdm_copy_to_user(user_info, arg, &count, sizeof(count));
 
 			return 0;
-            
+
 		default:
 			return -ENOTTY;
 		}
@@ -423,25 +428,25 @@ static int rtswitch_ioctl_rt(struct rtdm
                              void *arg)
 {
 	rtswitch_context_t *ctx = (rtswitch_context_t *) context->dev_private;
-	struct rtswitch_task task;
-	struct rtswitch fromto;
+	struct rttst_swtest_task task;
+	struct rttst_swtest_dir fromto;
 
-	switch (request) 
+	switch (request)
 		{
-		case RTSWITCH_RTIOC_REGISTER_UTASK:
-		case RTSWITCH_RTIOC_CREATE_KTASK:
-		case RTSWITCH_RTIOC_GET_SWITCHES_COUNT:
+		case RTTST_RTIOC_SWTEST_REGISTER_UTASK:
+		case RTTST_RTIOC_SWTEST_CREATE_KTASK:
+		case RTTST_RTIOC_SWTEST_GET_SWITCHES_COUNT:
 			return -ENOSYS;
 
-		case RTSWITCH_RTIOC_PEND:
+		case RTTST_RTIOC_SWTEST_PEND:
 			if (!rtdm_read_user_ok(user_info, arg, sizeof(task)))
 				return -EFAULT;
 
 			rtdm_copy_from_user(user_info, &task, arg, sizeof(task));
-            
+
 			return rtswitch_pend_rt(ctx, task.index);
 
-		case RTSWITCH_RTIOC_SWITCH_TO:
+		case RTTST_RTIOC_SWTEST_SWITCH_TO:
 			if (!rtdm_read_user_ok(user_info, arg, sizeof(fromto)))
 				return -EFAULT;
 
@@ -464,7 +469,7 @@ static struct rtdm_device device = {
 
 	device_flags: RTDM_NAMED_DEVICE,
 	context_size: sizeof(rtswitch_context_t),
-	device_name:  "rtswitch",
+	device_name:  "",
 
 	open_rt: NULL,
 	open_nrt: rtswitch_open,
@@ -490,10 +495,10 @@ static struct rtdm_device device = {
 	},
 
 	device_class: RTDM_CLASS_TESTING,
-	device_sub_class: RTDM_SUBCLASS_SWITCH,
-	driver_name: "xeno_switchbench",
-	driver_version: RTDM_DRIVER_VER(0, 1, 0),
-	peripheral_name: "Context switch benchmark",
+	device_sub_class: RTDM_SUBCLASS_SWITCHTEST,
+	driver_name: "xeno_switchtest",
+	driver_version: RTDM_DRIVER_VER(0, 1, 1),
+	peripheral_name: "Context Switch Test",
 	provider_name: "Gilles Chanteperdrix",
 	proc_name: device.device_name,
 };
@@ -503,7 +508,7 @@ void rtswitch_utask_waker(rtdm_nrtsig_t 
 	up(&rtswitch_utask[xnarch_current_cpu()]->nrt_synch);
 }
 
-int __init __switchbench_init(void)
+int __init __switchtest_init(void)
 {
 	int err;
 
@@ -511,17 +516,23 @@ int __init __switchbench_init(void)
 
 	if (err)
 		return err;
-    
-	return rtdm_dev_register(&device);
+
+	do {
+		snprintf(device.device_name, RTDM_MAX_DEVNAME_LEN, "rttest%d",
+			 start_index);
+		err = rtdm_dev_register(&device);
+
+		start_index++;
+	} while (err == -EEXIST);
+
+	return err;
 }
 
-void __switchbench_exit(void)
+void __switchtest_exit(void)
 {
-	if(rtdm_dev_unregister(&device, 0))
-		printk("Warning: could not unregister driver %s\n",
-		       device.device_name);
+	rtdm_dev_unregister(&device, 1000);
 	rtdm_nrtsig_destroy(&rtswitch_wake_utask);
 }
 
-module_init(__switchbench_init);
-module_exit(__switchbench_exit);
+module_init(__switchtest_init);
+module_exit(__switchtest_exit);
Index: xenomai/ksrc/drivers/testing/timerbench.c
===================================================================
--- xenomai.orig/ksrc/drivers/testing/timerbench.c
+++ xenomai/ksrc/drivers/testing/timerbench.c
@@ -26,29 +26,29 @@
 #include <rtdm/rtdm_driver.h>
 
 struct rt_tmbench_context {
-    int                         mode;
-    unsigned long               period;
-    int                         freeze_max;
-    int                         warmup_loops;
-    int                         samples_per_sec;
-    long                        *histogram_min;
-    long                        *histogram_max;
-    long                        *histogram_avg;
-    int                         histogram_size;
-    int                         bucketsize;
-
-    rtdm_task_t                 timer_task;
-
-    xntimer_t                   timer;
-    int                         warmup;
-    uint64_t                    start_time;
-    uint64_t                    date;
-    struct rtbnch_result        curr;
+    int                             mode;
+    unsigned long                   period;
+    int                             freeze_max;
+    int                             warmup_loops;
+    int                             samples_per_sec;
+    long                            *histogram_min;
+    long                            *histogram_max;
+    long                            *histogram_avg;
+    int                             histogram_size;
+    int                             bucketsize;
+
+    rtdm_task_t                     timer_task;
+
+    xntimer_t                       timer;
+    int                             warmup;
+    uint64_t                        start_time;
+    uint64_t                        date;
+    struct rttst_bench_res          curr;
 
-    rtdm_event_t                result_event;
-    struct rtbnch_interm_result result;
+    rtdm_event_t                    result_event;
+    struct rttst_interm_bench_res   result;
 
-    struct semaphore            nrt_mutex;
+    struct semaphore                nrt_mutex;
 };
 
 static unsigned int start_index;
@@ -211,7 +211,7 @@ int rt_tmbench_close(struct rtdm_dev_con
     down(&ctx->nrt_mutex);
 
     if (ctx->mode >= 0) {
-        if (ctx->mode == RTBNCH_TIMER_TASK)
+        if (ctx->mode == RTTST_TMBENCH_TASK)
             rtdm_task_destroy(&ctx->timer_task);
         else
             /* FIXME: convert to RTDM timers */
@@ -242,17 +242,17 @@ int rt_tmbench_ioctl_nrt(struct rtdm_dev
     ctx = (struct rt_tmbench_context *)context->dev_private;
 
     switch (request) {
-        case RTBNCH_RTIOC_START_TMTEST: {
-            struct rtbnch_timerconfig   config_buf;
-            struct rtbnch_timerconfig   *config;
+        case RTTST_RTIOC_TMBENCH_START: {
+            struct rttst_tmbench_config config_buf;
+            struct rttst_tmbench_config *config;
 
 
-            config = (struct rtbnch_timerconfig *)arg;
+            config = (struct rttst_tmbench_config *)arg;
             if (user_info) {
                 if (!rtdm_read_user_ok(user_info, arg,
-                                       sizeof(struct rtbnch_timerconfig)) ||
+                                       sizeof(struct rttst_tmbench_config)) ||
                     rtdm_copy_from_user(user_info, &config_buf, arg,
-                                        sizeof(struct rtbnch_timerconfig)))
+                                        sizeof(struct rttst_tmbench_config)))
                     return -EFAULT;
 
                 config = &config_buf;
@@ -300,9 +300,9 @@ int rt_tmbench_ioctl_nrt(struct rtdm_dev
 
             rtdm_event_init(&ctx->result_event, 0);
 
-            if (config->mode == RTBNCH_TIMER_TASK) {
+            if (config->mode == RTTST_TMBENCH_TASK) {
                 if (!test_bit(RTDM_CLOSING, &context->context_flags)) {
-                    ctx->mode = RTBNCH_TIMER_TASK;
+                    ctx->mode = RTTST_TMBENCH_TASK;
                     ret = rtdm_task_init(&ctx->timer_task, "timerbench",
                                          timer_task_proc, ctx,
                                          RTDM_TASK_HIGHEST_PRIORITY, 0);
@@ -314,7 +314,7 @@ int rt_tmbench_ioctl_nrt(struct rtdm_dev
                 ctx->curr.test_loops = 0;
 
                 if (!test_bit(RTDM_CLOSING, &context->context_flags)) {
-                    ctx->mode = RTBNCH_TIMER_HANDLER;
+                    ctx->mode = RTTST_TMBENCH_HANDLER;
                     RTDM_EXECUTE_ATOMICALLY(
                         /* start time: one millisecond from now. */
                         ctx->start_time = rtdm_clock_read() + 1000000;
@@ -333,11 +333,11 @@ int rt_tmbench_ioctl_nrt(struct rtdm_dev
             break;
         }
 
-        case RTBNCH_RTIOC_STOP_TMTEST: {
-            struct rtbnch_overall_result *usr_res;
+        case RTTST_RTIOC_TMBENCH_STOP: {
+            struct rttst_overall_bench_res *usr_res;
 
 
-            usr_res = (struct rtbnch_overall_result *)arg;
+            usr_res = (struct rttst_overall_bench_res *)arg;
 
             down(&ctx->nrt_mutex);
 
@@ -346,7 +346,7 @@ int rt_tmbench_ioctl_nrt(struct rtdm_dev
                 return -EINVAL;
             }
 
-            if (ctx->mode == RTBNCH_TIMER_TASK)
+            if (ctx->mode == RTTST_TMBENCH_TASK)
                 rtdm_task_destroy(&ctx->timer_task);
             else
                 /* FIXME: convert to RTDM timers */
@@ -363,14 +363,14 @@ int rt_tmbench_ioctl_nrt(struct rtdm_dev
 
             if (user_info) {
                 if (!rtdm_rw_user_ok(user_info, usr_res,
-                                     sizeof(struct rtbnch_overall_result)) ||
+                                    sizeof(struct rttst_overall_bench_res)) ||
                     rtdm_copy_to_user(user_info, &usr_res->result,
                                       &ctx->result.overall,
-                                      sizeof(struct rtbnch_result)))
+                                      sizeof(struct rttst_bench_res)))
                     ret = -EFAULT;
             } else {
                 memcpy(&usr_res->result, &ctx->result.overall,
-                       sizeof(struct rtbnch_result));
+                       sizeof(struct rttst_bench_res));
             }
 
             if (ctx->histogram_size) {
@@ -404,7 +404,7 @@ int rt_tmbench_ioctl_nrt(struct rtdm_dev
             break;
         }
 
-        case RTBNCH_RTIOC_INTERM_RESULT:
+        case RTTST_RTIOC_INTERM_BENCH_RES:
             ret = -ENOSYS;
             break;
 
@@ -426,11 +426,11 @@ int rt_tmbench_ioctl_rt(struct rtdm_dev_
     ctx = (struct rt_tmbench_context *)context->dev_private;
 
     switch (request) {
-        case RTBNCH_RTIOC_INTERM_RESULT: {
-            struct rtbnch_interm_result *usr_res;
+        case RTTST_RTIOC_INTERM_BENCH_RES: {
+            struct rttst_interm_bench_res *usr_res;
 
 
-            usr_res = (struct rtbnch_interm_result *)arg;
+            usr_res = (struct rttst_interm_bench_res *)arg;
 
             ret = rtdm_event_wait(&ctx->result_event);
             if (ret < 0)
@@ -438,19 +438,19 @@ int rt_tmbench_ioctl_rt(struct rtdm_dev_
 
             if (user_info) {
                 if (!rtdm_rw_user_ok(user_info, usr_res,
-                                     sizeof(struct rtbnch_interm_result)) ||
+                                     sizeof(struct rttst_interm_bench_res)) ||
                     rtdm_copy_to_user(user_info, usr_res, &ctx->result,
-                                      sizeof(struct rtbnch_interm_result)))
+                                      sizeof(struct rttst_interm_bench_res)))
                     ret = -EFAULT;
             } else
                 memcpy(usr_res, &ctx->result,
-                       sizeof(struct rtbnch_interm_result));
+                       sizeof(struct rttst_interm_bench_res));
 
             break;
         }
 
-        case RTBNCH_RTIOC_START_TMTEST:
-        case RTBNCH_RTIOC_STOP_TMTEST:
+        case RTTST_RTIOC_TMBENCH_START:
+        case RTTST_RTIOC_TMBENCH_STOP:
             ret = -ENOSYS;
             break;
 
@@ -493,9 +493,9 @@ static struct rtdm_device device = {
     },
 
     device_class:       RTDM_CLASS_TESTING,
-    device_sub_class:   RTDM_SUBCLASS_TIMER,
+    device_sub_class:   RTDM_SUBCLASS_TIMERBENCH,
     driver_name:        "xeno_timerbench",
-    driver_version:     RTDM_DRIVER_VER(0, 1, 0),
+    driver_version:     RTDM_DRIVER_VER(0, 2, 0),
     peripheral_name:    "Timer Latency Benchmark",
     provider_name:      "Jan Kiszka",
     proc_name:          device.device_name,
@@ -503,10 +503,17 @@ static struct rtdm_device device = {
 
 int __init __timerbench_init(void)
 {
-    snprintf(device.device_name, RTDM_MAX_DEVNAME_LEN, "rtbenchmark%d",
-             start_index);
+    int ret;
 
-    return rtdm_dev_register(&device);
+    do {
+        snprintf(device.device_name, RTDM_MAX_DEVNAME_LEN, "rttest%d",
+                 start_index);
+        ret = rtdm_dev_register(&device);
+
+        start_index++;
+    } while (ret == -EEXIST);
+
+    return ret;
 }
 
 
Index: xenomai/src/testsuite/latency/latency.c
===================================================================
--- xenomai.orig/src/testsuite/latency/latency.c
+++ xenomai/src/testsuite/latency/latency.c
@@ -77,7 +77,7 @@ void latency (void *cookie)
     RT_TIMER_INFO timer_info;
 
     err = rt_timer_inquire(&timer_info);
-    
+
     if (err)
         {
         fprintf(stderr,"latency: rt_timer_inquire, code %d\n",err);
@@ -107,7 +107,7 @@ void latency (void *cookie)
 
         for (count = sumj = 0; count < nsamples; count++)
             {
-	    unsigned long ov;
+            unsigned long ov;
 
             expected_tsc += period_tsc;
             err = rt_task_wait_period(&ov);
@@ -186,12 +186,12 @@ void display (void *cookie)
             }
 
     } else {
-        struct rtbnch_timerconfig   config;
+        struct rttst_tmbench_config config;
 
         if (test_mode == KERNEL_TASK)
-            config.mode = RTBNCH_TIMER_TASK;
+            config.mode = RTTST_TMBENCH_TASK;
         else
-            config.mode = RTBNCH_TIMER_HANDLER;
+            config.mode = RTTST_TMBENCH_HANDLER;
 
         config.period               = period_ns;
         config.warmup_loops         = WARMUP_TIME;
@@ -199,7 +199,7 @@ void display (void *cookie)
         config.histogram_bucketsize = bucketsize;
         config.freeze_max           = freeze_max;
 
-        err = rt_dev_ioctl(benchdev, RTBNCH_RTIOC_START_TMTEST, &config);
+        err = rt_dev_ioctl(benchdev, RTTST_RTIOC_TMBENCH_START, &config);
 
         if (err)
             {
@@ -239,14 +239,14 @@ void display (void *cookie)
             gmaxj = rt_timer_tsc2ns(gmaxjitter);
 
         } else {
-            struct rtbnch_interm_result result;
+            struct rttst_interm_bench_res result;
 
-            err = rt_dev_ioctl(benchdev, RTBNCH_RTIOC_INTERM_RESULT, &result);
+            err = rt_dev_ioctl(benchdev, RTTST_RTIOC_INTERM_BENCH_RES, &result);
 
             if (err)
                 {
                 if (err != -EIDRM)
-                    fprintf(stderr,"latency: failed to call RTBNCH_RTIOC_INTERM_RESULT, code %d\n",err);
+                    fprintf(stderr,"latency: failed to call RTTST_RTIOC_INTERM_BENCH_RES, code %d\n",err);
 
                 return;
                 }
@@ -375,13 +375,13 @@ void cleanup_upon_sig(int sig __attribut
         gmaxj = rt_timer_tsc2ns(gmaxjitter);
         gavgj = rt_timer_tsc2ns(gavgjitter);
     } else {
-        struct rtbnch_overall_result overall;
+        struct rttst_overall_bench_res overall;
 
         overall.histogram_min = histogram_min;
         overall.histogram_max = histogram_max;
         overall.histogram_avg = histogram_avg;
 
-        rt_dev_ioctl(benchdev, RTBNCH_RTIOC_STOP_TMTEST, &overall);
+        rt_dev_ioctl(benchdev, RTTST_RTIOC_TMBENCH_STOP, &overall);
 
         gminj    = overall.result.min;
         gmaxj    = overall.result.max;
@@ -499,7 +499,7 @@ int main (int argc, char **argv)
                         "  [-l <data-lines per header>] # default=21, 0 to supress headers\n"
                         "  [-T <test_duration_seconds>] # default=0, so ^C to end\n"
                         "  [-q]                         # supresses RTD, RTH lines if -T is used\n"
-                        "  [-D <benchmark_device_no>]   # number of benchmark device, default=0\n"
+                        "  [-D <testing_device_no>]     # number of testing device, default=0\n"
                         "  [-t <test_mode>]             # 0=user task (default), 1=kernel task, 2=timer IRQ\n"
                         "  [-f]                         # freeze trace for each new max latency\n"
                         "  [-c <cpu>]                   # pin measuring task down to given CPU\n");
@@ -549,7 +549,7 @@ int main (int argc, char **argv)
         {
         char devname[RTDM_MAX_DEVNAME_LEN];
 
-        snprintf(devname, RTDM_MAX_DEVNAME_LEN, "rtbenchmark%d", benchdev_no);
+        snprintf(devname, RTDM_MAX_DEVNAME_LEN, "rttest%d", benchdev_no);
         benchdev = rt_dev_open(devname, O_RDWR);
 
         if (benchdev < 0)
Index: xenomai/src/testsuite/switchtest/switch.c
===================================================================
--- xenomai.orig/src/testsuite/switchtest/switch.c
+++ xenomai/src/testsuite/switchtest/switch.c
@@ -35,7 +35,7 @@ struct task_params {
 	unsigned fp;
 	pthread_t thread;
 	struct cpu_tasks *cpu;
-	struct rtswitch_task swt;
+	struct rttst_swtest_task swt;
 };
 
 struct cpu_tasks {
@@ -83,7 +83,7 @@ static void *sleeper(void *cookie)
 	unsigned tasks_count = param->cpu->tasks_count;
 	struct timespec ts, last;
 	int fd = param->cpu->fd;
-	struct rtswitch rtsw;
+	struct rttst_swtest_dir rtsw;
 	cpu_set_t cpu_set;
 	unsigned i = 0;
 
@@ -121,13 +121,13 @@ static void *sleeper(void *cookie)
 			last = now;
 
 			if (ioctl(fd,
-				  RTSWITCH_RTIOC_GET_SWITCHES_COUNT,
+				  RTTST_RTIOC_SWTEST_GET_SWITCHES_COUNT,
 				  &switches_count)) {
-				perror("sleeper: ioctl(RTSWITCH_RTIOC_GET_"
-				       "SWITCHES_COUNT)");
+				perror("sleeper: ioctl(RTTST_RTIOC_SWTEST_"
+				       "GET_SWITCHES_COUNT)");
 				exit(EXIT_FAILURE);
 			}
-	    
+
 			printf("cpu %u: %lu\n",
 			       param->cpu->index,
 			       switches_count);
@@ -144,7 +144,7 @@ static void *sleeper(void *cookie)
 			++rtsw.to;
 
 		fp_regs_set(rtsw.from + i * 1000);
-		if (ioctl(fd, RTSWITCH_RTIOC_SWITCH_TO, &rtsw))
+		if (ioctl(fd, RTTST_RTIOC_SWTEST_SWITCH_TO, &rtsw))
 			break;
 		if (fp_regs_check(rtsw.from + i * 1000))
 			pthread_kill(pthread_self(), SIGSTOP);
@@ -161,7 +161,7 @@ static void *rtup(void *cookie)
 	struct task_params *param = (struct task_params *) cookie;
 	unsigned tasks_count = param->cpu->tasks_count;
 	int err, fd = param->cpu->fd;
-	struct rtswitch rtsw;
+	struct rttst_swtest_dir rtsw;
 	cpu_set_t cpu_set;
 	unsigned i = 0;
 
@@ -186,7 +186,7 @@ static void *rtup(void *cookie)
 		exit(EXIT_FAILURE);
 	}    
 
-	if (ioctl(fd, RTSWITCH_RTIOC_PEND, &param->swt))
+	if (ioctl(fd, RTTST_RTIOC_SWTEST_PEND, &param->swt))
 		return NULL;
 
 	for (;;) {
@@ -199,7 +199,7 @@ static void *rtup(void *cookie)
 
 		if (param->fp & UFPP)
 			fp_regs_set(rtsw.from + i * 1000);
-		if (ioctl(fd, RTSWITCH_RTIOC_SWITCH_TO, &rtsw))
+		if (ioctl(fd, RTTST_RTIOC_SWTEST_SWITCH_TO, &rtsw))
 			break;
 		if (param->fp & UFPP)
 			if (fp_regs_check(rtsw.from + i * 1000))
@@ -217,7 +217,7 @@ static void *rtus(void *cookie)
 	struct task_params *param = (struct task_params *) cookie;
 	unsigned tasks_count = param->cpu->tasks_count;
 	int err, fd = param->cpu->fd;
-	struct rtswitch rtsw;
+	struct rttst_swtest_dir rtsw;
 	cpu_set_t cpu_set;
 	unsigned i = 0;
 
@@ -242,7 +242,7 @@ static void *rtus(void *cookie)
 		exit(EXIT_FAILURE);
 	}
 
-	if (ioctl(fd, RTSWITCH_RTIOC_PEND, &param->swt))
+	if (ioctl(fd, RTTST_RTIOC_SWTEST_PEND, &param->swt))
 		return NULL;
 
 	for (;;) {
@@ -255,7 +255,7 @@ static void *rtus(void *cookie)
 
 		if (param->fp & UFPS)
 			fp_regs_set(rtsw.from + i * 1000);
-		if (ioctl(fd, RTSWITCH_RTIOC_SWITCH_TO, &rtsw))
+		if (ioctl(fd, RTTST_RTIOC_SWTEST_SWITCH_TO, &rtsw))
 			break;
 		if (param->fp & UFPS)
 			if (fp_regs_check(rtsw.from + i * 1000))
@@ -273,7 +273,7 @@ static void *rtuo(void *cookie)
 	struct task_params *param = (struct task_params *) cookie;
 	unsigned mode, tasks_count = param->cpu->tasks_count;
 	int err, fd = param->cpu->fd;
-	struct rtswitch rtsw;
+	struct rttst_swtest_dir rtsw;
 	cpu_set_t cpu_set;
 	unsigned i = 0;
 
@@ -296,8 +296,8 @@ static void *rtuo(void *cookie)
 			"rtup: pthread_set_mode_np: %s\n",
 			strerror(err));
 		exit(EXIT_FAILURE);
-	}    
-	if (ioctl(fd, RTSWITCH_RTIOC_PEND, &param->swt))
+	}
+	if (ioctl(fd, RTTST_RTIOC_SWTEST_PEND, &param->swt))
 		return NULL;
 
 	mode = PTHREAD_PRIMARY;
@@ -311,7 +311,7 @@ static void *rtuo(void *cookie)
 
 		if ((mode && param->fp & UFPP) || (!mode && param->fp & UFPS))
 			fp_regs_set(rtsw.from + i * 1000);
-		if (ioctl(fd, RTSWITCH_RTIOC_SWITCH_TO, &rtsw))
+		if (ioctl(fd, RTTST_RTIOC_SWTEST_SWITCH_TO, &rtsw))
 			break;
 		if ((mode && param->fp & UFPP) || (!mode && param->fp & UFPS))
 			if (fp_regs_check(rtsw.from + i * 1000))
@@ -341,7 +341,7 @@ static int parse_arg(struct task_params 
 		const char *text;
 		unsigned flag;
 	};
-    
+
 	static struct t2f type2flags [] = {
 		{ "rtk",  RTK  },
 		{ "rtup", RTUP },
@@ -380,14 +380,14 @@ static int parse_arg(struct task_params 
 
 	if (isdigit(*text))
 		goto cpu_nr;
-    
+
 	for(i = 0; i < sizeof(fp2flags)/sizeof(struct t2f); i++) {
 		size_t len = strlen(fp2flags[i].text);
 	
 		if(!strncmp(text, fp2flags[i].text, len)) {
 			param->fp |= fp2flags[i].flag;
 			text += len;
-	    
+
 			goto fpflags;
 		}
 	}
@@ -688,22 +688,23 @@ int main(int argc, const char *argv[])
 	for (i = 0; i < nr_cpus; i ++) {
 		struct cpu_tasks *cpu = &cpus[i];
 
-		cpu->fd = open("rtswitch", O_RDWR);
+		/* FIXME: grab number from -D option when provided */
+		cpu->fd = open("rttest0", O_RDWR);
 
 		if (cpu->fd == -1) {
-			perror("open(\"rtswitch\")");
+			perror("open(\"rttest0\")");
 			goto failure;
 		}
 
 		if (ioctl(cpu->fd,
-			  RTSWITCH_RTIOC_TASKS_COUNT,
+			  RTTST_RTIOC_SWTEST_SET_TASKS_COUNT,
 			  cpu->tasks_count)) {
-			perror("ioctl(RTSWITCH_RTIOC_TASKS_COUNT)");
+			perror("ioctl(RTTST_RTIOC_SWTEST_SET_TASKS_COUNT)");
 			goto failure;
 		}
 
-		if (ioctl(cpu->fd, RTSWITCH_RTIOC_SET_CPU, i)) {
-			perror("ioctl(RTSWITCH_RTIOC_SET_CPU)");
+		if (ioctl(cpu->fd, RTTST_RTIOC_SWTEST_SET_CPU, i)) {
+			perror("ioctl(RTTST_RTIOC_SWTEST_SET_CPU)");
 			goto failure;
 		}
 
@@ -717,17 +718,17 @@ int main(int argc, const char *argv[])
 			switch(param->type) {
 			case RTK:
 				param->swt.flags = (param->fp & AFP
-						    ? RTSWITCH_FPU
+						    ? RTTST_SWTEST_FPU
 						    : 0)
 					| (param->fp & UFPP
-					   ? RTSWITCH_USE_FPU
+					   ? RTTST_SWTEST_USE_FPU
 					   : 0);
 
 				if (ioctl(cpu->fd,
-					  RTSWITCH_RTIOC_CREATE_KTASK,
+					  RTTST_RTIOC_SWTEST_CREATE_KTASK,
 					  &param->swt)) {
-					perror("ioctl(RTSWITCH_RTIOC_CREATE_"
-					       "KTASK)");
+					perror("ioctl(RTTST_RTIOC_SWTEST_"
+					       "CREATE_KTASK)");
 					goto failure;
 				}
 				break;
@@ -754,10 +755,10 @@ int main(int argc, const char *argv[])
 				param->swt.flags = 0;
 
 				if (ioctl(cpu->fd,
-					  RTSWITCH_RTIOC_REGISTER_UTASK,
+					  RTTST_RTIOC_SWTEST_REGISTER_UTASK,
 					  &param->swt)) {
-					perror("ioctl(RTSWITCH_RTIOC_REGISTER_"
-					       "UTASK)");
+					perror("ioctl(RTTST_RTIOC_SWTEST_"
+					       "REGISTER_UTASK)");
 					goto failure;
 				}
 				break;

--

