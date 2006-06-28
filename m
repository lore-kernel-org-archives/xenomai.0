Message-ID: <44A2DB18.9080309@domain.hid>
Date: Wed, 28 Jun 2006 21:40:08 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080909070609030006030506"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] pid and current-domain tracing
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>, adeos-main@gna.org

This is a multi-part message in MIME format.
--------------080909070609030006030506
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

here are three patches, two enhancing the ipipe tracer, the third
propagating the new features to Xenomai.

The tracer gains support for recording a Linux pid + a priority value.
The priority can be set to an arbitrary value (12 bit, signed), but will
typically be related to the pid. When the tracer's verbose mode is
active, it tries to resolve the pid to a task_struct and prints the
first chars of the command line followed by the priority in the related
lines.

This feature is applied to Xenomai for tracing RT-task switches and
wakeups. Kind of poor man's LTT, but with the advantage of per-function
tracing. I already used this while trying to understand my
prio-inversion issue.

Finally, the tracer is enhanced by a facility to track the currently
active ipipe domain. The field for displaying domain stall flags is
reused for this.

Some example from my Pentium-133 box:

> I-pipe frozen back-tracing service on 2.6.16.16/ipipe-1.3-05
> ------------------------------------------------------------
> Freeze: 6070092534285 cycles, Trace Points: 1000 (+10)
> 
>  +----- Hard IRQs ('|': locked)
>  |+---- <unused>
>  ||+--- <unused>
>  |||+-- Xenomai
>  ||||+- Linux ('*': domain stalled, '+': current, '#': current+stalled)
>  |||||                        +---------- Delay flag ('+': > 1 us, '!': > 10 us)
>  |||||                        |        +- NMI noise ('N')
>  |||||                        |        |
>       Type    User Val.   Time    Delay  Function (Parent)
> :    +func               -3221+   2.105  n_tty_set_room+0x8 (n_tty_receive_buf+0xe4b)
> :    +func               -3219+   2.060  kill_fasync+0x9 (n_tty_receive_buf+0xe78)
> :    +func               -3217+   1.458  __wake_up+0xe (n_tty_receive_buf+0xe97)
> :    +func               -3216+   2.421  __ipipe_test_and_stall_root+0x8 (__wake_up+0x1a)
> :    #func               -3213+   2.135  __wake_up_common+0xe (__wake_up+0x50)
> :    #func               -3211+   6.090  default_wake_function+0x8 (__wake_up_common+0x33)
> :|   #func               -3205+   2.676  __ipipe_handle_irq+0xe (common_interrupt+0x18)
> :|   #func               -3203+   2.360  __ipipe_ack_common_irq+0xa (__ipipe_handle_irq+0x80)
> :|   #func               -3200+   3.428  ipipe_test_and_stall_pipeline_from+0x8 (__ipipe_ack_common_irq+0x16)
> :|   #func               -3197+   4.511  mask_and_ack_8259A+0xb (__ipipe_ack_common_irq+0x3f)
> :|   #func               -3192+   2.571  __ipipe_dispatch_wired+0xe (__ipipe_handle_irq+0x8a)
> :|  #*func               -3190+   2.766  xnintr_irq_handler+0xb (__ipipe_dispatch_wired+0x7d)
> :|  #*func               -3187+   4.902  rt_irqbench_task_irq+0xa [xeno_irqbench] (xnintr_irq_handler+0x24)
> :|  #*func               -3182+   3.451  rtdm_event_signal+0x9 (rt_irqbench_task_irq+0x46 [xeno_irqbench])
> :|  #*func               -3179+   3.796  xnsynch_flush+0xe (rtdm_event_signal+0x2d)
> :|  #*func               -3175+   3.263  xnpod_resume_thread+0xe (xnsynch_flush+0x76)
> :|  #*[  922] irqloop 99 -3171+   4.375  xnpod_resume_thread+0x48 (xnsynch_flush+0x76)
> :|  #*func               -3167+   2.992  xnpod_schedule+0xe (rtdm_event_signal+0x36)
> :|  #*func               -3164+   2.511  rthal_irq_end+0x8 (xnintr_irq_handler+0x41)
> :|  #*func               -3162+   3.969  enable_8259A_irq+0x9 (rthal_irq_end+0x2e)
> :|  #*func               -3158+   2.511  xnpod_schedule+0xe (xnintr_irq_handler+0x5f)
> :|  #*[    0] swapper  0 -3155+   8.669  xnpod_schedule+0x82 (xnintr_irq_handler+0x5f)
> :|  #*func               -3146+   7.766  __switch_to+0xe (xnpod_schedule+0x5e8)
> :|  #*[  922] irqloop 99 -3139+   6.992  xnpod_schedule+0x6bc (xnpod_suspend_thread+0xed)
> :|  #*func               -3132!  18.015  __ipipe_restore_pipeline_head+0x8 (rtdm_event_timedwait+0xea)
> :   +*func               -3114+   2.774  __ipipe_syscall_root+0x9 (system_call+0x20)
> :   +*func               -3111+   2.323  __ipipe_dispatch_event+0xe (__ipipe_syscall_root+0x55)
> :   +*func               -3109+   4.676  hisyscall_event+0xe (__ipipe_dispatch_event+0x5e)
> :   +*func               -3104+   2.135  sys_rtdm_ioctl+0x8 (hisyscall_event+0x140)
> :   +*func               -3102+   2.157  _rtdm_ioctl+0xe (sys_rtdm_ioctl+0x16)
> :   +*func               -3100+   2.052  rtdm_context_get+0x9 (_rtdm_ioctl+0x1f)

Jan

--------------080909070609030006030506
Content-Type: text/x-patch;
 name="ipipe-trace-pid.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ipipe-trace-pid.patch"

---
 include/linux/ipipe_trace.h |    3 -
 kernel/ipipe/tracer.c       |  129 ++++++++++++++++++++++++++++++++++----------
 2 files changed, 102 insertions(+), 30 deletions(-)

Index: linux-2.6.16.16/include/linux/ipipe_trace.h
===================================================================
--- linux-2.6.16.16.orig/include/linux/ipipe_trace.h
+++ linux-2.6.16.16/include/linux/ipipe_trace.h
@@ -2,7 +2,7 @@
  * include/linux/ipipe_trace.h
  *
  * Copyright (C) 2005 Luotao Fu.
- *               2005 Jan Kiszka.
+ *               2005, 2006 Jan Kiszka.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -27,6 +27,7 @@ void ipipe_trace_begin(unsigned long v);
 void ipipe_trace_end(unsigned long v);
 void ipipe_trace_freeze(unsigned long v);
 void ipipe_trace_special(unsigned char special_id, unsigned long v);
+void ipipe_trace_pid(pid_t pid, short prio);
 
 int ipipe_trace_max_reset(void);
 int ipipe_trace_frozen_reset(void);
Index: linux-2.6.16.16/kernel/ipipe/tracer.c
===================================================================
--- linux-2.6.16.16.orig/kernel/ipipe/tracer.c
+++ linux-2.6.16.16/kernel/ipipe/tracer.c
@@ -79,13 +79,17 @@ struct ipipe_trace_path{
 
 enum ipipe_trace_type
 {
-	IPIPE_TRACE_FN = 0,
+	IPIPE_TRACE_FUNC = 0,
 	IPIPE_TRACE_BEGIN,
 	IPIPE_TRACE_END,
 	IPIPE_TRACE_FREEZE,
 	IPIPE_TRACE_SPECIAL,
+	IPIPE_TRACE_PID,
 };
 
+#define IPIPE_TYPE_MASK             0x0007
+#define IPIPE_TYPE_BITS             3
+
 
 #ifdef CONFIG_IPIPE_TRACE_VMALLOC
 #define IPIPE_DEFAULT_TRACE_STATE   0
@@ -471,11 +475,22 @@ void notrace ipipe_trace_special(unsigne
 {
 	if (!ipipe_trace_enable)
 		return;
-	__ipipe_trace(IPIPE_TRACE_SPECIAL + id, __BUILTIN_RETURN_ADDRESS0,
+	__ipipe_trace(IPIPE_TRACE_SPECIAL | (id << IPIPE_TYPE_BITS),
+	              __BUILTIN_RETURN_ADDRESS0,
 	              __BUILTIN_RETURN_ADDRESS1, v);
 }
 EXPORT_SYMBOL(ipipe_trace_special);
 
+void notrace ipipe_trace_pid(pid_t pid, short prio)
+{
+	if (!ipipe_trace_enable)
+		return;
+	__ipipe_trace(IPIPE_TRACE_PID | (prio << IPIPE_TYPE_BITS),
+	              __BUILTIN_RETURN_ADDRESS0,
+	              __BUILTIN_RETURN_ADDRESS1, pid);
+}
+EXPORT_SYMBOL(ipipe_trace_pid);
+
 int ipipe_trace_max_reset(void)
 {
 	int cpu_id;
@@ -550,10 +565,43 @@ void ipipe_trace_panic_freeze(void)
 }
 EXPORT_SYMBOL(ipipe_trace_panic_freeze);
 
+static void
+__ipipe_get_task_info(char *task_info, struct ipipe_trace_point *point,
+                      int trylock)
+{
+	struct task_struct *task = NULL;
+	char buf[8];
+	int i;
+	int locked = 1;
+
+	if (trylock && !read_trylock(&tasklist_lock))
+		locked = 0;
+	else
+		read_lock(&tasklist_lock);
+
+	if (locked)
+		task = find_task_by_pid((pid_t)point->v);
+
+	if (task)
+		strncpy(task_info, task->comm, 11);
+	else
+		strcpy(task_info, "-<?>-");
+
+	if (locked)
+		read_unlock(&tasklist_lock);
+
+	for (i = strlen(task_info); i < 11; i++)
+		task_info[i] = ' ';
+
+	sprintf(buf, " %d ", point->type >> IPIPE_TYPE_BITS);
+	strcpy(task_info + (11 - strlen(buf)), buf);
+}
+
 void ipipe_trace_panic_dump(void)
 {
 	int cnt = back_trace;
 	int start, pos;
+	char task_info[11];
 
 	printk("I-pipe tracer log (%d points):\n", cnt);
 
@@ -570,10 +618,20 @@ void ipipe_trace_panic_dump(void)
 			__ipipe_trace_point_type(buf, point);
 			printk(buf);
 
-			if (point->type != IPIPE_TRACE_FN)
-				printk("0x%08lx ", point->v);
-			else
-				printk("           ");
+			switch (point->type & IPIPE_TYPE_MASK) {
+				case IPIPE_TRACE_FUNC:
+					printk("           ");
+					break;
+
+				case IPIPE_TRACE_PID:
+					__ipipe_get_task_info(task_info,
+					                      point, 1);
+					printk(task_info);
+					break;
+
+				default:
+					printk("0x%08lx ", point->v);
+			}
 
 			time = __ipipe_signed_tsc2us(point->timestamp -
 				panic_path->point[start].timestamp);
@@ -618,26 +676,31 @@ static long __ipipe_signed_tsc2us(long l
 static void
 __ipipe_trace_point_type(char *buf, struct ipipe_trace_point *point)
 {
-	switch (point->type) {
-		case IPIPE_TRACE_FN:
-			strcpy(buf, "fn     ");
+	switch (point->type & IPIPE_TYPE_MASK) {
+		case IPIPE_TRACE_FUNC:
+			strcpy(buf, "func    ");
 			break;
 
 		case IPIPE_TRACE_BEGIN:
-			strcpy(buf, "begin  ");
+			strcpy(buf, "begin   ");
 			break;
 
 		case IPIPE_TRACE_END:
-			strcpy(buf, "end    ");
+			strcpy(buf, "end     ");
 			break;
 
 		case IPIPE_TRACE_FREEZE:
-			strcpy(buf, "freeze ");
+			strcpy(buf, "freeze  ");
+			break;
+
+		case IPIPE_TRACE_SPECIAL:
+			sprintf(buf, "(0x%02x)  ",
+				point->type >> IPIPE_TYPE_BITS);
 			break;
 
-		default: /* IPIPE_TRACE_SPECIAL */
-			sprintf(buf, "(0x%02x) ",
-			        point->type - IPIPE_TRACE_SPECIAL);
+		case IPIPE_TRACE_PID:
+			sprintf(buf, "[%5d] ", (pid_t)point->v);
+			break;
 	}
 }
 
@@ -765,23 +828,23 @@ static void __ipipe_print_headline(struc
 		           " ||+--- %s\n"
 		           " |||+-- %s\n"
 		           " ||||+- %s%s\n"
-		           " |||||                       +---------- "
+		           " |||||                        +---------- "
 		               "Delay flag ('+': > %d us, '!': > %d us)\n"
-		           " |||||                       |        +- "
+		           " |||||                        |        +- "
 		               "NMI noise ('N')\n"
-		           " |||||                       |        |\n"
-		           "      Type   User Val.   Time    Delay  Function "
+		           " |||||                        |        |\n"
+		           "      Type    User Val.   Time    Delay  Function "
 		               "(Parent)\n",
 		           name[3], name[2], name[1], name[0],
 		           name[0] ? " ('*': domain stalled)" : "",
 		           IPIPE_DELAY_NOTE/1000, IPIPE_DELAY_WARN/1000);
 	} else
 		seq_printf(m,
-		           " +-------------- Hard IRQs ('|': locked)\n"
-		           " |            +- Delay flag "
+		           " +--------------- Hard IRQs ('|': locked)\n"
+		           " |             +- Delay flag "
 		               "('+': > %d us, '!': > %d us)\n"
-		           " |            |\n"
-		           "  Type    Time   Function (Parent)\n",
+		           " |             |\n"
+		           "  Type     Time   Function (Parent)\n",
 		           IPIPE_DELAY_NOTE/1000, IPIPE_DELAY_WARN/1000);
 }
 
@@ -888,12 +951,20 @@ static int __ipipe_prtrace_show(struct s
 	__ipipe_print_pathmark(m, point);
 	__ipipe_trace_point_type(buf, point);
 	seq_puts(m, buf);
-	if (verbose_trace) {
-		if (point->type != IPIPE_TRACE_FN)
-			seq_printf(m, "0x%08lx ", point->v);
-		else
-			seq_puts(m, "           ");
-	}
+	if (verbose_trace)
+		switch (point->type & IPIPE_TYPE_MASK) {
+			case IPIPE_TRACE_FUNC:
+				seq_puts(m, "           ");
+				break;
+
+			case IPIPE_TRACE_PID:
+				__ipipe_get_task_info(buf, point, 0);
+				seq_puts(m, buf);
+				break;
+
+			default:
+				seq_printf(m, "0x%08lx ", point->v);
+		}
 
 	time = __ipipe_signed_tsc2us(point->timestamp -
 		print_path->point[print_path->begin].timestamp);

--------------080909070609030006030506
Content-Type: text/x-patch;
 name="xntrace_pid.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xntrace_pid.patch"

---
 include/asm-generic/hal.h    |    7 +++++++
 include/asm-generic/system.h |    1 +
 include/asm-sim/system.h     |    1 +
 include/asm-uvm/system.h     |    1 +
 include/nucleus/trace.h      |    1 +
 ksrc/nucleus/pod.c           |   24 ++++++++++++++++++++++++
 ksrc/nucleus/shadow.c        |    9 +++++++--
 7 files changed, 42 insertions(+), 2 deletions(-)

Index: xenomai/include/asm-generic/hal.h
===================================================================
--- xenomai.orig/include/asm-generic/hal.h
+++ xenomai/include/asm-generic/hal.h
@@ -645,6 +645,12 @@ static inline int rthal_trace_special_u6
 	return 0;
 }
 
+static inline int rthal_trace_pid(pid_t pid, short prio)
+{
+	ipipe_trace_pid(pid, prio);
+	return 0;
+}
+
 static inline int rthal_trace_panic_freeze(void)
 {
 	ipipe_trace_panic_freeze();
@@ -667,6 +673,7 @@ static inline int rthal_trace_panic_dump
 #define rthal_trace_user_freeze(v, once)	({-ENOSYS;})
 #define rthal_trace_special(id, v)		({-ENOSYS;})
 #define rthal_trace_special_u64(id, v)		({-ENOSYS;})
+#define rthal_trace_pid(pid, prio)		({-ENOSYS;})
 #define rthal_trace_panic_freeze()		({-ENOSYS;})
 #define rthal_trace_panic_dump()		({-ENOSYS;})
 
Index: xenomai/include/asm-generic/system.h
===================================================================
--- xenomai.orig/include/asm-generic/system.h
+++ xenomai/include/asm-generic/system.h
@@ -50,6 +50,7 @@
 #define xnarch_trace_user_freeze(v, once) rthal_trace_user_freeze(v, once)
 #define xnarch_trace_special(id, v)	rthal_trace_special(id, v)
 #define xnarch_trace_special_u64(id, v)	rthal_trace_special_u64(id, v)
+#define xnarch_trace_pid(pid, prio)	rthal_trace_pid(pid, prio)
 #define xnarch_trace_panic_freeze()	rthal_trace_panic_freeze()
 #define xnarch_trace_panic_dump()	rthal_trace_panic_dump()
 
Index: xenomai/include/asm-sim/system.h
===================================================================
--- xenomai.orig/include/asm-sim/system.h
+++ xenomai/include/asm-sim/system.h
@@ -772,6 +772,7 @@ while(0)
 #define xnarch_trace_user_freeze(v, once)	({-ENOSYS;})
 #define xnarch_trace_special(id, v)		({-ENOSYS;})
 #define xnarch_trace_special_u64(id, v)		({-ENOSYS;})
+#define xnarch_trace_pid(pid, prio)		({-ENOSYS;})
 #define xnarch_trace_panic_freeze()		({-ENOSYS;})
 #define xnarch_trace_panic_dump()		({-ENOSYS;})
 
Index: xenomai/include/asm-uvm/system.h
===================================================================
--- xenomai.orig/include/asm-uvm/system.h
+++ xenomai/include/asm-uvm/system.h
@@ -794,6 +794,7 @@ static inline void xnarch_sysfree (void 
 #define xnarch_trace_user_freeze(v, once)	({-ENOSYS;})
 #define xnarch_trace_special(id, v)		({-ENOSYS;})
 #define xnarch_trace_special_u64(id, v)		({-ENOSYS;})
+#define xnarch_trace_pid(pid, prio)		({-ENOSYS;})
 #define xnarch_trace_panic_freeze()		({-ENOSYS;})
 #define xnarch_trace_panic_dump()		({-ENOSYS;})
 
Index: xenomai/ksrc/nucleus/pod.c
===================================================================
--- xenomai.orig/ksrc/nucleus/pod.c
+++ xenomai/ksrc/nucleus/pod.c
@@ -673,6 +673,10 @@ static inline void xnpod_switch_zombie(x
 				   xnthread_archtcb(threadin));
 
 #if defined(__KERNEL__) && defined(CONFIG_XENO_OPT_PERVASIVE)
+	xnarch_trace_pid(xnthread_user_task(threadin) ?
+			 xnarch_user_pid(xnthread_archtcb(threadin)) : -1,
+			 xnthread_current_priority(threadin));
+
 	if (shadow)
 		/* Reap the user-space mate of a deleted real-time shadow.
 		   The Linux task has resumed into the Linux domain at the
@@ -1534,6 +1538,9 @@ void xnpod_resume_thread(xnthread_t *thr
 	xnlock_get_irqsave(&nklock, s);
 
 	xnltt_log_event(xeno_ev_thresume, thread->name, mask);
+	xnarch_trace_pid(xnthread_user_task(thread) ?
+			 xnarch_user_pid(xnthread_archtcb(thread)) : -1,
+			 xnthread_current_priority(thread));
 
 	sched = thread->sched;
 
@@ -2114,6 +2121,8 @@ void xnpod_welcome_thread(xnthread_t *th
 
 	xnltt_log_event(xeno_ev_thrboot, thread->name);
 
+	xnarch_trace_pid(-1, xnthread_current_priority(thread));
+
 	if (xnthread_signaled_p(thread))
 		xnpod_dispatch_signals();
 
@@ -2315,6 +2324,10 @@ void xnpod_schedule(void)
 	sched = xnpod_current_sched();
 	runthread = sched->runthread;
 
+	xnarch_trace_pid(xnthread_user_task(runthread) ?
+			 xnarch_user_pid(xnthread_archtcb(runthread)) : -1,
+			 xnthread_current_priority(runthread));
+
 #if defined(CONFIG_SMP) || defined(CONFIG_XENO_OPT_DEBUG)
 	need_resched = xnsched_tst_resched(sched);
 #endif
@@ -2426,6 +2439,10 @@ void xnpod_schedule(void)
 	 * relaxed/hardened transitions. */
 	runthread = sched->runthread;
 
+	xnarch_trace_pid(xnthread_user_task(runthread) ?
+			 xnarch_user_pid(xnthread_archtcb(runthread)) : -1,
+			 xnthread_current_priority(runthread));
+
 #if defined(__KERNEL__) && defined(CONFIG_XENO_OPT_PERVASIVE)
 	/* Test whether we are relaxing a thread. In such a case, we are here the
 	   epilogue of Linux' schedule, and should skip xnpod_schedule epilogue. */
@@ -2498,6 +2515,9 @@ void xnpod_schedule_runnable(xnthread_t 
 	xnthread_t *runthread = sched->runthread, *threadin;
 
 	xnltt_log_event(xeno_ev_fastsched);
+	xnarch_trace_pid(xnthread_user_task(runthread) ?
+			 xnarch_user_pid(xnthread_archtcb(runthread)) : -1,
+			 xnthread_current_priority(runthread));
 
 	if (thread != runthread) {
 		sched_removepq(&sched->readyq, &thread->rlink);
@@ -2582,6 +2602,10 @@ void xnpod_schedule_runnable(xnthread_t 
 	xnarch_switch_to(xnthread_archtcb(runthread),
 			 xnthread_archtcb(threadin));
 
+	xnarch_trace_pid(xnthread_user_task(runthread) ?
+			 xnarch_user_pid(xnthread_archtcb(runthread)) : -1,
+			 xnthread_current_priority(runthread));
+
 #ifdef CONFIG_SMP
 	/* If runthread migrated while suspended, sched is no longer correct. */
 	sched = xnpod_current_sched();
Index: xenomai/include/nucleus/trace.h
===================================================================
--- xenomai.orig/include/nucleus/trace.h
+++ xenomai/include/nucleus/trace.h
@@ -43,6 +43,7 @@
 #define xntrace_user_freeze(v, once)	xnarch_trace_user_freeze(v, once)
 #define xntrace_special(id, v)		xnarch_trace_special(id, v)
 #define xntrace_special_u64(id, v)	xnarch_trace_special_u64(id, v)
+#define xntrace_pid(pid, prio)		xnarch_trace_pid(pid, prio)
 #define xntrace_panic_freeze()		xnarch_trace_panic_freeze()
 #define xntrace_panic_dump()		xnarch_trace_panic_dump()
 
Index: xenomai/ksrc/nucleus/shadow.c
===================================================================
--- xenomai.orig/ksrc/nucleus/shadow.c
+++ xenomai/ksrc/nucleus/shadow.c
@@ -794,7 +794,7 @@ int xnshadow_map(xnthread_t *thread, xnc
 {
 	xnarch_cpumask_t affinity;
 	unsigned muxid, magic;
-	int mode, prio;
+	int mode, prio, err;
 
 	/* Increment the interface reference count. */
 	magic = xnthread_get_magic(thread);
@@ -849,7 +849,12 @@ int xnshadow_map(xnthread_t *thread, xnc
 	mode = thread->rrperiod != XN_INFINITE ? XNRRB : 0;
 	xnpod_start_thread(thread, mode, 0, affinity, NULL, NULL);
 
-	return xnshadow_harden();
+	err = xnshadow_harden();
+
+	xnarch_trace_pid(xnarch_user_pid(xnthread_archtcb(thread)),
+			 xnthread_current_priority(thread));
+
+	return err;
 }
 
 void xnshadow_unmap(xnthread_t *thread)

--------------080909070609030006030506
Content-Type: text/x-patch;
 name="ipipe-trace-curdom.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ipipe-trace-curdom.patch"

---
 kernel/ipipe/tracer.c |   34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

Index: linux-2.6.16.16/kernel/ipipe/tracer.c
===================================================================
--- linux-2.6.16.16.orig/kernel/ipipe/tracer.c
+++ linux-2.6.16.16/kernel/ipipe/tracer.c
@@ -52,7 +52,15 @@
 
 #define IPIPE_TFLG_HWIRQ_OFF        0x0100
 #define IPIPE_TFLG_FREEZING         0x0200
+#define IPIPE_TFLG_CURRDOM_SHIFT    10   /* bits 10..11: current domain */
+#define IPIPE_TFLG_CURRDOM_MASK     0x0C00
 #define IPIPE_TFLG_DOMSTATE_SHIFT   12   /* bits 12..15: domain stalled? */
+#define IPIPE_TFLG_DOMSTATE_BITS    3
+
+#define IPIPE_TFLG_DOMAIN_STALLED(point, n) \
+	(point->flags & (1 << (n + IPIPE_TFLG_DOMSTATE_SHIFT)))
+#define IPIPE_TFLG_CURRENT_DOMAIN(point) \
+	((point->flags & IPIPE_TFLG_CURRDOM_MASK) >> IPIPE_TFLG_CURRDOM_SHIFT)
 
 
 struct ipipe_trace_point{
@@ -137,17 +145,20 @@ static void __ipipe_print_symname(struct
 static notrace void
 __ipipe_store_domain_states(struct ipipe_trace_point *point, int cpu_id)
 {
-	int i = IPIPE_TFLG_DOMSTATE_SHIFT;
 	struct list_head *pos;
+	int i = 0;
 
 	list_for_each_prev(pos, &__ipipe_pipeline) {
 		struct ipipe_domain *ipd =
 			list_entry(pos, struct ipipe_domain, p_link);
 
 		if (test_bit(IPIPE_STALL_FLAG, &ipd->cpudata[cpu_id].status))
-			point->flags |= (1 << i);
+			point->flags |= 1 << (i + IPIPE_TFLG_DOMSTATE_SHIFT);
+
+		if (ipd == ipipe_percpu_domain[cpu_id])
+			point->flags |= i << IPIPE_TFLG_CURRDOM_SHIFT;
 
-		if (++i > IPIPE_TFLG_DOMSTATE_SHIFT+3)
+		if (++i > IPIPE_TFLG_DOMSTATE_BITS)
 			break;
 	}
 }
@@ -720,11 +731,15 @@ __ipipe_print_pathmark(struct seq_file *
 	seq_printf(m, "%c%c", mark,
 	           (point->flags & IPIPE_TFLG_HWIRQ_OFF) ? '|' : ' ');
 
-	if (verbose_trace)
-		for (i = IPIPE_TFLG_DOMSTATE_SHIFT + 3;
-		     i >= IPIPE_TFLG_DOMSTATE_SHIFT; i--)
-			seq_printf(m, "%c",
-			           (point->flags & (1 << i)) ? '*' : ' ');
+	if (!verbose_trace)
+		return;
+
+	for (i = IPIPE_TFLG_DOMSTATE_BITS; i >= 0; i--)
+		seq_printf(m, "%c",
+			(IPIPE_TFLG_CURRENT_DOMAIN(point) == i) ?
+			    (IPIPE_TFLG_DOMAIN_STALLED(point, i) ?
+				'#' : '+') :
+			(IPIPE_TFLG_DOMAIN_STALLED(point, i) ? '*' : ' '));
 }
 
 static void
@@ -836,7 +851,8 @@ static void __ipipe_print_headline(struc
 		           "      Type    User Val.   Time    Delay  Function "
 		               "(Parent)\n",
 		           name[3], name[2], name[1], name[0],
-		           name[0] ? " ('*': domain stalled)" : "",
+		           name[0] ? " ('*': domain stalled, '+': current, "
+		               "'#': current+stalled)" : "",
 		           IPIPE_DELAY_NOTE/1000, IPIPE_DELAY_WARN/1000);
 	} else
 		seq_printf(m,

--------------080909070609030006030506--

