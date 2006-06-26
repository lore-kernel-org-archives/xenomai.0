Message-Id: <20060626172117.725134000@domain.hid>
References: <20060626172116.019532000@domain.hid>
Date: Mon, 26 Jun 2006 19:21:17 +0200
From: jan.kiszka@domain.hid
Content-Disposition: inline; filename=xntrace-refactoring.patch
Subject: [Xenomai-core] [PATCH 1/6] Refactor tracer API
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

This patch encapsulates the I-pipe tracer facilities more cleanly according to the Xenomai layers. The changes are propagated to all current ipipe_trace_xxx users. Furthermore, the patch introduces a user-space inline API to invoke the tracer without the previous need to go through xeno_timerbench.

---
 include/asm-generic/hal.h         |   83 ++++++++++++++++++++++++++++++++
 include/asm-generic/syscall.h     |    1 
 include/asm-generic/system.h      |   19 ++++---
 include/asm-sim/system.h          |   13 ++++-
 include/asm-uvm/system.h          |   13 ++++-
 include/nucleus/assert.h          |    4 -
 include/nucleus/trace.h           |   98 ++++++++++++++++++++++++++++++++++++++
 include/nucleus/types.h           |    2 
 include/rtdm/rttesting.h          |   33 +-----------
 ksrc/arch/i386/hal.c              |   27 ++++------
 ksrc/drivers/testing/timerbench.c |   55 ---------------------
 ksrc/nucleus/shadow.c             |   48 ++++++++++++++++++
 src/testsuite/cyclic/cyclictest.c |   18 +-----
 src/testsuite/latency/latency.c   |    6 +-
 14 files changed, 289 insertions(+), 131 deletions(-)

Index: include/asm-generic/syscall.h
===================================================================
--- include/asm-generic/syscall.h.orig
+++ include/asm-generic/syscall.h
@@ -29,6 +29,7 @@
 #define __xn_sys_barrier    3	/* started = xnshadow_wait_barrier(&entry,&cookie) */
 #define __xn_sys_info       4	/* xnshadow_get_info(muxid,&info) */
 #define __xn_sys_arch       5	/* r = xnarch_local_syscall(args) */
+#define __xn_sys_trace      6	/* r = xntrace_xxx(...) */
 
 #define XENOMAI_LINUX_DOMAIN  0
 #define XENOMAI_XENO_DOMAIN   1
Index: include/rtdm/rttesting.h
===================================================================
--- include/rtdm/rttesting.h.orig
+++ include/rtdm/rttesting.h
@@ -1,6 +1,6 @@
 /**
  * @file
- * Real-Time Driver Model for Xenomai, benchmark device profile header
+ * Real-Time Driver Model for Xenomai, testing device profile header
  *
  * @note Copyright (C) 2005 Jan Kiszka <jan.kiszka@domain.hid>
  *
@@ -18,16 +18,16 @@
  * along with Xenomai; if not, write to the Free Software Foundation,
  * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  *
- * @ingroup rtbenchmark
+ * @ingroup rttesting
  */
 
 /*!
  * @ingroup profiles
- * @defgroup rtbenchmark Timer benchmark Device
+ * @defgroup rttesting Testing Device
  *
- * This group of devices is intended to provide in-kernel benchmark results.
+ * This group of devices is intended to provide in-kernel testing results.
  * Feel free to comment on this profile via the Xenomai mailing list
- * (Xenomai-help@domain.hid) or directly to the author (jan.kiszka@domain.hid). @n
+ * (xenomai@xenomai.org) or directly to the author (jan.kiszka@domain.hid). @n
  * @n
  *
  * @par Device Characteristics
@@ -91,11 +91,6 @@ typedef struct rtbnch_overall_result {
     long                    *histogram_max;
 } rtbnch_overall_result_t;
 
-typedef struct rtbnch_trace_special {
-    unsigned char           id;
-    long                    v;
-} rtbnch_trace_special_t;
-
 
 #define RTIOC_TYPE_BENCHMARK        RTDM_CLASS_TESTING
 
@@ -120,24 +115,6 @@ typedef struct rtbnch_trace_special {
 
 #define RTBNCH_RTIOC_STOP_TMTEST        \
     _IOWR(RTIOC_TYPE_BENCHMARK, 0x11, struct rtbnch_overall_result)
-
-#define RTBNCH_RTIOC_BEGIN_TRACE        \
-    _IOW(RTIOC_TYPE_BENCHMARK, 0x20, long)
-
-#define RTBNCH_RTIOC_END_TRACE          \
-    _IOW(RTIOC_TYPE_BENCHMARK, 0x21, long)
-
-#define RTBNCH_RTIOC_FREEZE_TRACE       \
-    _IOW(RTIOC_TYPE_BENCHMARK, 0x22, long)
-
-#define RTBNCH_RTIOC_REFREEZE_TRACE     \
-    _IOW(RTIOC_TYPE_BENCHMARK, 0x23, long)
-
-#define RTBNCH_RTIOC_SPECIAL_TRACE      \
-    _IOW(RTIOC_TYPE_BENCHMARK, 0x24, unsigned char)
-
-#define RTBNCH_RTIOC_SPECIAL_TRACE_EX   \
-    _IOW(RTIOC_TYPE_BENCHMARK, 0x25, struct rtbnch_trace_special)
 /** @} */
 
 
Index: src/testsuite/latency/latency.c
===================================================================
--- src/testsuite/latency/latency.c.orig
+++ src/testsuite/latency/latency.c
@@ -12,6 +12,7 @@
 #include <native/timer.h>
 #include <native/sem.h>
 #include <rtdm/rttesting.h>
+#include <nucleus/trace.h>
 
 RT_TASK latency_task, display_task;
 
@@ -130,8 +131,7 @@ void latency (void *cookie)
 
             if (freeze_max && (dt > gmaxjitter) && !(finished || warmup))
                 {
-                rt_dev_ioctl(benchdev, RTBNCH_RTIOC_REFREEZE_TRACE,
-                             rt_timer_tsc2ns(dt));
+                xntrace_user_freeze(rt_timer_tsc2ns(dt), 0);
                 gmaxjitter = dt;
                 }
 
@@ -545,7 +545,7 @@ int main (int argc, char **argv)
 
     mlockall(MCL_CURRENT|MCL_FUTURE);
 
-    if ((test_mode != USER_TASK) || freeze_max)
+    if (test_mode != USER_TASK)
         {
         char devname[RTDM_MAX_DEVNAME_LEN];
 
Index: src/testsuite/cyclic/cyclictest.c
===================================================================
--- src/testsuite/cyclic/cyclictest.c.orig
+++ src/testsuite/cyclic/cyclictest.c
@@ -36,7 +36,7 @@
 #include <sys/mman.h>
 
 #if IPIPE_TRACE
-#include <rtdm/rttesting.h>
+#include <nucleus/trace.h>
 #endif
 
 /* Ugly, but .... */
@@ -93,11 +93,6 @@ struct thread_stat {
 static int test_shutdown;
 static int tracelimit = 100000;
 static struct timespec start;
-#if IPIPE_TRACE
-static int benchdev = -1;
-#else
-#define benchdev -1
-#endif
 
 static inline void tsnorm(struct timespec *ts)
 {
@@ -266,7 +261,7 @@ void *timerthread(void *param)
 			stat->max = diff;
 #if IPIPE_TRACE
 			if (stat->traced)
-				ioctl(benchdev, RTBNCH_RTIOC_REFREEZE_TRACE, diff);
+				xntrace_user_freeze(diff, 0);
 #endif
 		}
 
@@ -411,9 +406,6 @@ static void process_options (int argc, c
 
 static void sighand(int sig)
 {
-#if IPIPE_TRACE
-	close(benchdev);
-#endif
 	test_shutdown = 1;
 }
 
@@ -469,10 +461,6 @@ int main(int argc, char **argv)
 	if (!stat)
 		goto outpar;
 
-#if IPIPE_TRACE
-	benchdev = open("rtbenchmark0", O_RDWR);
-#endif
-
 	clock_gettime(clocksources[clocksel], &start);
 
 	for (i = 0; i < num_threads; i++) {
@@ -500,7 +488,7 @@ int main(int argc, char **argv)
 		pthread_attr_setstacksize(&thattr, 131072);
 		pthread_create(&stat[i].thread, &thattr, timerthread, &par[i]);
 		stat[i].threadstarted = 1;
-		stat[i].traced = (i == 0 && benchdev >= 0);
+		stat[i].traced = (i == 0 && IPIPE_TRACE > 0);
 	}
 	
 	while (!test_shutdown) {
Index: ksrc/drivers/testing/timerbench.c
===================================================================
--- ksrc/drivers/testing/timerbench.c.orig
+++ ksrc/drivers/testing/timerbench.c
@@ -232,55 +232,6 @@ int rt_tmbench_close(struct rtdm_dev_con
 }
 
 
-#ifdef CONFIG_IPIPE_TRACE
-int tracer_ioctl(int request, rtdm_user_info_t *user_info, void *arg)
-{
-    switch (request) {
-        case RTBNCH_RTIOC_BEGIN_TRACE:
-            ipipe_trace_begin((long)arg);
-            break;
-
-        case RTBNCH_RTIOC_END_TRACE:
-            ipipe_trace_end((long)arg);
-            break;
-
-        case RTBNCH_RTIOC_REFREEZE_TRACE:
-            ipipe_trace_frozen_reset();
-            /* fall through */
-
-        case RTBNCH_RTIOC_FREEZE_TRACE:
-            ipipe_trace_freeze((long)arg);
-            break;
-
-        case RTBNCH_RTIOC_SPECIAL_TRACE:
-            ipipe_trace_special((long)arg, 0);
-            break;
-
-        case RTBNCH_RTIOC_SPECIAL_TRACE_EX: {
-            struct rtbnch_trace_special special;
-
-            if (user_info) {
-                if (!rtdm_read_user_ok(user_info, arg,
-                                       sizeof(struct rtbnch_trace_special)) ||
-                    rtdm_copy_from_user(user_info, &special, arg,
-                                        sizeof(struct rtbnch_trace_special)))
-                    return 0;
-            } else
-                special = *(struct rtbnch_trace_special *)arg;
-            ipipe_trace_special(special.id, special.v);
-            break;
-        }
-
-        default:
-            return 0;
-    }
-    return 1;
-}
-#else /* !CONFIG_IPIPE_TRACE */
-#define tracer_ioctl(request, user_info, arg)   (0)
-#endif /* CONFIG_IPIPE_TRACE */
-
-
 int rt_tmbench_ioctl_nrt(struct rtdm_dev_context *context,
                          rtdm_user_info_t *user_info, int request, void *arg)
 {
@@ -288,9 +239,6 @@ int rt_tmbench_ioctl_nrt(struct rtdm_dev
     int                         ret = 0;
 
 
-    if (tracer_ioctl(request, user_info, arg))
-        return 0;
-
     ctx = (struct rt_tmbench_context *)context->dev_private;
 
     switch (request) {
@@ -475,9 +423,6 @@ int rt_tmbench_ioctl_rt(struct rtdm_dev_
     int                         ret = 0;
 
 
-    if (tracer_ioctl(request, user_info, arg))
-        return 0;
-
     ctx = (struct rt_tmbench_context *)context->dev_private;
 
     switch (request) {
Index: ksrc/nucleus/shadow.c
===================================================================
--- ksrc/nucleus/shadow.c.orig
+++ ksrc/nucleus/shadow.c
@@ -51,6 +51,7 @@
 #include <nucleus/ltt.h>
 #include <nucleus/jhash.h>
 #include <nucleus/ppd.h>
+#include <nucleus/trace.h>
 #include <asm/xenomai/features.h>
 
 int nkthrptd;
@@ -1262,6 +1263,50 @@ static int xnshadow_sys_barrier(struct t
 	return xnshadow_wait_barrier(regs);
 }
 
+static int xnshadow_sys_trace(struct task_struct *curr, struct pt_regs *regs)
+{
+	int err = -ENOSYS;
+
+	switch (__xn_reg_arg1(regs)) {
+	case __xntrace_op_max_begin:
+		err = xnarch_trace_max_begin(__xn_reg_arg2(regs));
+		break;
+
+	case __xntrace_op_max_end:
+		err = xnarch_trace_max_end(__xn_reg_arg2(regs));
+		break;
+
+	case __xntrace_op_max_reset:
+		err = xnarch_trace_max_reset();
+		break;
+
+	case __xntrace_op_user_start:
+		err = xnarch_trace_user_start();
+		break;
+
+	case __xntrace_op_user_stop:
+		err = xnarch_trace_user_stop(__xn_reg_arg2(regs));
+		break;
+
+	case __xntrace_op_user_freeze:
+		err = xnarch_trace_user_freeze(__xn_reg_arg2(regs),
+					       __xn_reg_arg3(regs));
+		break;
+
+	case __xntrace_op_special:
+		err = xnarch_trace_special(__xn_reg_arg2(regs) & 0xFF,
+					   __xn_reg_arg3(regs));
+		break;
+
+	case __xntrace_op_special_u64:
+		err = xnarch_trace_special_u64(__xn_reg_arg2(regs) & 0xFF,
+					(((u64)__xn_reg_arg3(regs)) << 32) |
+					__xn_reg_arg4(regs));
+		break;
+	}
+	return err;
+}
+
 static xnsysent_t xnshadow_systab[] = {
 	[__xn_sys_migrate] = {&xnshadow_sys_migrate, __xn_exec_current},
 	[__xn_sys_arch] = {&xnshadow_sys_arch, __xn_exec_any},
@@ -1269,6 +1314,7 @@ static xnsysent_t xnshadow_systab[] = {
 	[__xn_sys_info] = {&xnshadow_sys_info, __xn_exec_lostage},
 	[__xn_sys_completion] = {&xnshadow_sys_completion, __xn_exec_lostage},
 	[__xn_sys_barrier] = {&xnshadow_sys_barrier, __xn_exec_lostage},
+	[__xn_sys_trace] = {&xnshadow_sys_trace, __xn_exec_any},
 };
 
 static inline int substitute_linux_syscall(struct task_struct *curr,
@@ -1628,7 +1674,7 @@ static inline void do_schedule_event(str
 				      properly recover from a stopped state. */
 				   testbits(status, XNSTARTED)
 				   && testbits(status, XNPEND)) {
-				ipipe_trace_panic_freeze();
+				xnarch_trace_panic_freeze();
 				show_stack(xnthread_user_task(threadin), NULL);
 				xnpod_fatal
 				    ("blocked thread %s[%d] rescheduled?! (status=0x%lx, sig=%d, prev=%s[%d])",
Index: include/asm-generic/hal.h
===================================================================
--- include/asm-generic/hal.h.orig
+++ include/asm-generic/hal.h
@@ -589,6 +589,89 @@ struct proc_dir_entry *__rthal_add_proc_
 					      struct proc_dir_entry *parent);
 #endif /* CONFIG_PROC_FS */
 
+#ifdef CONFIG_IPIPE_TRACE
+#include <linux/ipipe_trace.h>
+
+static inline int rthal_trace_max_begin(unsigned long v)
+{
+	ipipe_trace_begin(v);
+	return 0;
+}
+
+static inline int rthal_trace_max_end(unsigned long v)
+{
+	ipipe_trace_end(v);
+	return 0;
+}
+
+static inline int rthal_trace_max_reset(void)
+{
+	ipipe_trace_max_reset();
+	return 0;
+}
+
+static inline int rthal_trace_user_start(void)
+{
+	return ipipe_trace_frozen_reset();
+}
+
+static inline int rthal_trace_user_stop(unsigned long v)
+{
+	ipipe_trace_freeze(v);
+	return 0;
+}
+
+static inline int rthal_trace_user_freeze(unsigned long v, int once)
+{
+	int err = 0;
+
+	if (!once)
+		err = ipipe_trace_frozen_reset();
+	ipipe_trace_freeze(v);
+	return err;
+}
+
+static inline int rthal_trace_special(unsigned char id, unsigned long v)
+{
+	ipipe_trace_special(id, v);
+	return 0;
+}
+
+static inline int rthal_trace_special_u64(unsigned char id,
+					  unsigned long long v)
+{
+	ipipe_trace_special(id, (unsigned long)(v >> 32));
+	ipipe_trace_special(id, (unsigned long)(v & 0xFFFFFFFF));
+	return 0;
+}
+
+static inline int rthal_trace_panic_freeze(void)
+{
+	ipipe_trace_panic_freeze();
+	return 0;
+}
+
+static inline int rthal_trace_panic_dump(void)
+{
+	ipipe_trace_panic_dump();
+	return 0;
+}
+
+#else /* !CONFIG_IPIPE_TRACE */
+
+#define rthal_trace_max_begin(v)		({-ENOSYS;})
+#define rthal_trace_max_end(v)			({-ENOSYS;})
+#define rthal_trace_max_reset(v)		({-ENOSYS;})
+#define rthal_trace_user_start()		({-ENOSYS;})
+#define rthal_trace_user_stop(v)		({-ENOSYS;})
+#define rthal_trace_user_freeze(v, once)	({-ENOSYS;})
+#define rthal_trace_special(id, v)		({-ENOSYS;})
+#define rthal_trace_special_u64(id, v)		({-ENOSYS;})
+#define rthal_trace_panic_freeze()		({-ENOSYS;})
+#define rthal_trace_panic_dump()		({-ENOSYS;})
+
+#endif /* CONFIG_IPIPE_TRACE */
+
 #ifdef __cplusplus
 }
 #endif /* __cplusplus */
Index: include/asm-generic/system.h
===================================================================
--- include/asm-generic/system.h.orig
+++ include/asm-generic/system.h
@@ -40,12 +40,17 @@
 #include <asm/xenomai/atomic.h>
 #include <nucleus/shadow.h>
 
-#ifdef CONFIG_IPIPE_TRACE
-#include <linux/ipipe_trace.h>
-#else /* !CONFIG_IPIPE_TRACE */
-#define ipipe_trace_panic_freeze()
-#define ipipe_trace_panic_dump()
-#endif /* CONFIG_IPIPE_TRACE */
+/* Tracer interface */
+#define xnarch_trace_max_begin(v)	rthal_trace_max_begin(v)
+#define xnarch_trace_max_end(v)		rthal_trace_max_end(v)
+#define xnarch_trace_max_reset()	rthal_trace_max_reset()
+#define xnarch_trace_user_start()	rthal_trace_user_start()
+#define xnarch_trace_user_stop(v)	rthal_trace_user_stop(v)
+#define xnarch_trace_user_freeze(v, once) rthal_trace_user_freeze(v, once)
+#define xnarch_trace_special(id, v)	rthal_trace_special(id, v)
+#define xnarch_trace_special_u64(id, v)	rthal_trace_special_u64(id, v)
+#define xnarch_trace_panic_freeze()	rthal_trace_panic_freeze()
+#define xnarch_trace_panic_dump()	rthal_trace_panic_dump()
 
 #define module_param_value(parm) (parm)
 
@@ -199,7 +204,7 @@ do { \
     rthal_emergency_console(); \
     xnarch_logerr("fatal: %s\n",emsg); \
     show_stack(NULL,NULL);			\
-    ipipe_trace_panic_dump();			\
+    xnarch_trace_panic_dump();			\
     for (;;) cpu_relax();			\
 } while(0)
 
Index: include/asm-sim/system.h
===================================================================
--- include/asm-sim/system.h.orig
+++ include/asm-sim/system.h
@@ -762,8 +762,17 @@ if (cond) \
 __mvm_breakable(mvm_post_graph)(&(obj)->__mvm_display_context,state); \
 while(0)
 
-/* Ipipe-tracer */
-#define ipipe_trace_panic_freeze()
+/* Tracer interface */
+#define xnarch_trace_max_begin(v)		({-ENOSYS;})
+#define xnarch_trace_max_end(v)			({-ENOSYS;})
+#define xnarch_trace_max_reset()		({-ENOSYS;})
+#define xnarch_trace_user_start()		({-ENOSYS;})
+#define xnarch_trace_user_stop(v)		({-ENOSYS;})
+#define xnarch_trace_user_freeze(v, once)	({-ENOSYS;})
+#define xnarch_trace_special(id, v)		({-ENOSYS;})
+#define xnarch_trace_special_u64(id, v)		({-ENOSYS;})
+#define xnarch_trace_panic_freeze()		({-ENOSYS;})
+#define xnarch_trace_panic_dump()		({-ENOSYS;})
 
 #ifndef PAGE_SIZE
 #define PAGE_SIZE sysconf(_SC_PAGESIZE)
Index: include/asm-uvm/system.h
===================================================================
--- include/asm-uvm/system.h.orig
+++ include/asm-uvm/system.h
@@ -784,7 +784,16 @@ static inline void xnarch_sysfree (void 
 #define xnarch_post_graph(obj,state)
 #define xnarch_post_graph_if(obj,state,cond)
 
-/* Ipipe-tracer */
-#define ipipe_trace_panic_freeze()
+/* Tracer interface */
+#define xnarch_trace_max_begin(v)		({-ENOSYS;})
+#define xnarch_trace_max_end(v)			({-ENOSYS;})
+#define xnarch_trace_max_reset()		({-ENOSYS;})
+#define xnarch_trace_user_start()		({-ENOSYS;})
+#define xnarch_trace_user_stop(v)		({-ENOSYS;})
+#define xnarch_trace_user_freeze(v, once)	({-ENOSYS;})
+#define xnarch_trace_special(id, v)		({-ENOSYS;})
+#define xnarch_trace_special_u64(id, v)		({-ENOSYS;})
+#define xnarch_trace_panic_freeze()		({-ENOSYS;})
+#define xnarch_trace_panic_dump()		({-ENOSYS;})
 
 #endif /* !_XENO_ASM_UVM_SYSTEM_H */
Index: include/nucleus/assert.h
===================================================================
--- include/nucleus/assert.h.orig
+++ include/nucleus/assert.h
@@ -24,9 +24,9 @@
 
 #define XENO_ASSERT(subsystem,cond,action)  do { \
     if (unlikely(CONFIG_XENO_OPT_DEBUG_##subsystem > 0 && !(cond))) { \
-        ipipe_trace_panic_freeze(); \
+        xnarch_trace_panic_freeze(); \
         xnlogerr("assertion failed at %s:%d (%s)\n", __FILE__, __LINE__, (#cond)); \
-        ipipe_trace_panic_dump(); \
+        xnarch_trace_panic_dump(); \
         action; \
     } \
 } while(0)
Index: include/nucleus/trace.h
===================================================================
--- /dev/null
+++ include/nucleus/trace.h
@@ -0,0 +1,98 @@
+/*
+ * Copyright (C) 2006 Jan Kiszka <jan.kiszka@domain.hid>.
+ *
+ * Xenomai is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published
+ * by the Free Software Foundation; either version 2 of the License,
+ * or (at your option) any later version.
+ *
+ * Xenomai is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with Xenomai; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
+ * 02111-1307, USA.
+ *
+ * User space interface to the I-pipe tracer.
+ */
+
+#ifndef _XENO_NUCLEUS_TRACE_H
+#define _XENO_NUCLEUS_TRACE_H
+
+#define __xntrace_op_max_begin		0
+#define __xntrace_op_max_end		1
+#define __xntrace_op_max_reset		2
+#define __xntrace_op_user_start		3
+#define __xntrace_op_user_stop		4
+#define __xntrace_op_user_freeze	5
+#define __xntrace_op_special		6
+#define __xntrace_op_special_u64	7
+
+#if defined(__KERNEL__) || defined(__XENO_SIM__)
+
+#include <asm/xenomai/system.h>
+
+#define xntrace_max_begin(v)		xnarch_trace_max_begin(v)
+#define xntrace_max_end(v)		xnarch_trace_max_end(v)
+#define xntrace_max_reset()		xnarch_trace_max_reset()
+#define xntrace_user_start()		xnarch_trace_user_start()
+#define xntrace_user_stop(v)		xnarch_trace_user_stop(v)
+#define xntrace_user_freeze(v, once)	xnarch_trace_user_freeze(v, once)
+#define xntrace_special(id, v)		xnarch_trace_special(id, v)
+#define xntrace_special_u64(id, v)	xnarch_trace_special_u64(id, v)
+#define xntrace_panic_freeze()		xnarch_trace_panic_freeze()
+#define xntrace_panic_dump()		xnarch_trace_panic_dump()
+
+#else /* !(defined(__KERNEL__) || defined(__XENO_SIM__)) */
+
+#include <asm/xenomai/syscall.h>
+
+static inline int xntrace_max_begin(unsigned long v)
+{
+	return XENOMAI_SYSCALL2(__xn_sys_trace, __xntrace_op_max_begin, v);
+}
+
+static inline int xntrace_max_end(unsigned long v)
+{
+	return XENOMAI_SYSCALL2(__xn_sys_trace, __xntrace_op_max_end, v);
+}
+
+static inline int xntrace_max_reset(void)
+{
+	return XENOMAI_SYSCALL1(__xn_sys_trace, __xntrace_op_max_reset);
+}
+
+static inline int xntrace_user_start(void)
+{
+	return XENOMAI_SYSCALL1(__xn_sys_trace, __xntrace_op_user_start);
+}
+
+static inline int xntrace_user_stop(unsigned long v)
+{
+	return XENOMAI_SYSCALL2(__xn_sys_trace, __xntrace_op_user_stop, v);
+}
+
+static inline int xntrace_user_freeze(unsigned long v, int once)
+{
+	return XENOMAI_SYSCALL3(__xn_sys_trace, __xntrace_op_user_freeze,
+				v, once);
+}
+
+static inline int xntrace_special(unsigned char id, unsigned long v)
+{
+	return XENOMAI_SYSCALL3(__xn_sys_trace, __xntrace_op_special, id, v);
+}
+
+static inline int xntrace_special_u64(unsigned char id, unsigned long long v)
+{
+	return XENOMAI_SYSCALL4(__xn_sys_trace, __xntrace_op_special_u64, id,
+				(unsigned long)(v >> 32),
+				(unsigned long)(v & 0xFFFFFFFF));
+}
+
+#endif /* defined(__KERNEL__) || defined(__XENO_SIM__) */
+
+#endif /* !_XENO_NUCLEUS_TRACE_H */
Index: include/nucleus/types.h
===================================================================
--- include/nucleus/types.h.orig
+++ include/nucleus/types.h
@@ -112,7 +112,7 @@ void __xeno_user_exit(void);
 #define xnpod_fatal(format,args...) \
 do { \
     const char *panic; \
-    ipipe_trace_panic_freeze(); \
+    xnarch_trace_panic_freeze(); \
     panic = xnpod_fatal_helper(format,##args); \
     xnarch_halt(panic); \
 } while (0)
Index: ksrc/arch/i386/hal.c
===================================================================
--- ksrc/arch/i386/hal.c.orig
+++ ksrc/arch/i386/hal.c
@@ -61,9 +61,6 @@
 #endif /* CONFIG_X86_LOCAL_APIC */
 #include <asm/xenomai/hal.h>
 #include <stdarg.h>
-#ifdef CONFIG_IPIPE_TRACE
-#include <linux/ipipe_trace.h>
-#endif /* CONFIG_IPIPE_TRACE */
 
 extern struct desc_struct idt_table[];
 
@@ -176,7 +173,7 @@ unsigned long rthal_timer_calibrate(void
 
 #ifdef CONFIG_IPIPE_TRACE_IRQSOFF
     /* reset the max trace, it contains the excessive calibration now */
-    ipipe_trace_max_reset();
+    rthal_trace_max_reset();
 #endif /* CONFIG_IPIPE_TRACE_IRQSOFF */
 
     return rthal_imuldiv(dt, 100000, RTHAL_CPU_FREQ);
@@ -211,16 +208,16 @@ void die_nmi(struct pt_regs *regs, const
 
 static void rthal_latency_above_max(struct pt_regs *regs)
 {
-#ifdef CONFIG_IPIPE_TRACE
-    ipipe_trace_freeze(rthal_maxlat_us);
-#else /* !CONFIG_IPIPE_TRACE */
-    char buf[128];
-    snprintf(buf,
-             sizeof(buf),
-             "NMI watchdog detected timer latency above %u us\n",
-             rthal_maxlat_us);
-    die_nmi(regs, buf);
-#endif /* CONFIG_IPIPE_TRACE */
+    /* Try to report via latency tracer first, then fall back to panic. */
+    if (rthal_trace_user_freeze(rthal_maxlat_us, 1) < 0) {
+        char buf[128];
+
+        snprintf(buf,
+                 sizeof(buf),
+                 "NMI watchdog detected timer latency above %u us\n",
+                 rthal_maxlat_us);
+        die_nmi(regs, buf);
+    }
 }
 
 #endif /* CONFIG_XENO_HW_NMI_DEBUG_LATENCY */
@@ -341,7 +338,7 @@ unsigned long rthal_timer_calibrate(void
 
 #ifdef CONFIG_IPIPE_TRACE_IRQSOFF
     /* reset the max trace, it contains the excessive calibration now */
-    ipipe_trace_max_reset();
+    rthal_trace_max_reset();
 #endif /* CONFIG_IPIPE_TRACE_IRQSOFF */
 
     return rthal_imuldiv(dt, 100000, RTHAL_CPU_FREQ);

--

