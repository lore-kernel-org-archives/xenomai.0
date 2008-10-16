Resent-To: xenomai-core <xenomai@xenomai.org>
Resent-Message-Id: <48F756EB.2030801@domain.hid>
Message-Id: <20081016145758.306372425@domain.hid>
Date: Thu, 16 Oct 2008 16:57:59 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
References: <20081016145757.935266172@domain.hid>
Content-Disposition: inline; filename=add-pthread_inquire_np.patch
Subject: [Xenomai-core] [PATCH 2/2] Add pthread_inquire_np service
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
Cc: Jan Kiszka <jan.kiszka@domain.hid>

Almost identically to what rt_task_inquire provides for the native skin,
this introduces the pthread_inquire_np extension to the POSIX API. Only
supported thread status values are reported back, PTHREAD_PRIMARY
included.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 include/posix/pthread.h    |   53 ++++++++++++++++++++++++++++++++++++++----
 include/posix/syscall.h    |    1 
 ksrc/skins/posix/syscall.c |   23 ++++++++++++++++++
 ksrc/skins/posix/thread.c  |   56 +++++++++++++++++++++++++++++++++++++++++++++
 src/skins/posix/thread.c   |    7 +++++
 5 files changed, 135 insertions(+), 5 deletions(-)

Index: b/include/posix/pthread.h
===================================================================
--- a/include/posix/pthread.h
+++ b/include/posix/pthread.h
@@ -135,6 +135,7 @@ typedef struct
 #include_next <pthread.h>
 #include <nucleus/thread.h>
 #include <nucleus/intr.h>
+#include <nucleus/types.h>
 
 struct timespec;
 
@@ -144,11 +145,31 @@ struct timespec;
 #define PTHREAD_PRIO_INHERIT 1
 #define PTHREAD_PRIO_PROTECT 2
 
-#define PTHREAD_SHIELD     XNSHIELD
-#define PTHREAD_WARNSW     XNTRAPSW
-#define PTHREAD_LOCK_SCHED XNLOCK
-#define PTHREAD_RPIOFF     XNRPIOFF
-#define PTHREAD_PRIMARY    XNTHREAD_STATE_SPARE1
+/**
+ * @ingroup posix
+ * @defgroup thread_task_status Thread Status
+ * @brief Defines used to specify thread state and/or mode
+ * @{
+ */
+
+#define PTHREAD_SUSP       XNSUSP	/**< Suspended. */
+#define PTHREAD_BLOCKED    XNPEND	/**< Sleep-wait for a resource. */
+#define PTHREAD_DELAYED    XNDELAY	/**< Delayed. */
+#define PTHREAD_READY      XNREADY	/**< Linked to the ready queue. */
+#define PTHREAD_DORMANT    XNDORMANT	/**< Not started yet or killed. */
+#define PTHREAD_STARTED    XNSTARTED	/**< Thread has been started. */
+#define PTHREAD_HELD       XNHELD	/**< Held thread from suspended partition. */
+#define PTHREAD_BOOST      XNBOOST	/**< Undergoes a PIP boost. */
+#define PTHREAD_DEBUG      XNDEBUG	/**< Hit a debugger breakpoint (user space only). */
+#define PTHREAD_LOCK_SCHED XNLOCK	/**< Holds the scheduler lock (i.e. not preemptible). */
+#define PTHREAD_RRB        XNRRB	/**< Undergoes a round-robin scheduling. */
+#define PTHREAD_NOSIG      XNASDI	/**< ASR are disabled. */
+#define PTHREAD_SHIELD     XNSHIELD	/**< IRQ shield is enabled (user space only). */
+#define PTHREAD_WARNSW     XNTRAPSW	/**< Trap execution mode switches. */
+#define PTHREAD_RPIOFF     XNRPIOFF	/**< Stop priority coupling (user space only). */
+#define PTHREAD_USERSPACE  XNSHADOW	/**< User space task. */
+#define PTHREAD_PRIMARY    XNTHREAD_STATE_SPARE1 /**< Running under Xenomai control (primary mode). */
+/*! @} */ /* Ends doxygen-group thread_task_status */
 
 #define PTHREAD_INOAUTOENA  XN_ISR_NOENABLE
 #define PTHREAD_IPROPAGATE  XN_ISR_PROPAGATE
@@ -183,6 +204,24 @@ struct pse51_interrupt;
 
 typedef struct pse51_interrupt *pthread_intr_t;
 
+/**
+ * Structure containing thread information useful to users.
+ *
+ *  @see pthread_inquire_np()
+ */
+typedef struct {
+
+	int bprio; /**< Base priority. */
+	int cprio; /**< Current priority. May change through Priority Inheritance.*/
+	unsigned status; /**< Thread status. @see thread_state_flags */
+	struct timespec relpoint; /**< Time of next release.*/
+	char name[XNOBJECT_NAME_LEN];  /**< Symbolic name assigned at creation. */
+	struct timespec exectime; /**< Execution time in primary mode. */
+	int modeswitches; /**< Number of primary->secondary mode switches. */
+	int ctxswitches; /**< Number of context switches. */
+	int pagefaults; /**< Number of triggered page faults. */
+} pthread_info_t;
+
 #if defined(__KERNEL__) || defined(__XENO_SIM__)
 typedef struct pse51_mutexattr pthread_mutexattr_t;
 
@@ -385,6 +424,8 @@ int pthread_set_mode_np(int clrmask,
 int pthread_set_name_np(pthread_t thread,
 			const char *name);
 
+int pthread_inquire_np(pthread_t thread, pthread_info_t *info);
+
 int pthread_intr_attach_np(pthread_intr_t *intr,
 			   unsigned irq,
 			   xnisr_t isr,
@@ -429,6 +470,8 @@ int pthread_set_mode_np(int clrmask,
 int pthread_set_name_np(pthread_t thread,
 			const char *name);
 
+int pthread_inquire_np(pthread_t thread, pthread_info_t *info);
+
 int pthread_intr_attach_np(pthread_intr_t *intr,
 			   unsigned irq,
 			   int mode);
Index: b/include/posix/syscall.h
===================================================================
--- a/include/posix/syscall.h
+++ b/include/posix/syscall.h
@@ -102,6 +102,7 @@
 #define __pse51_thread_getschedparam  75
 #define __pse51_thread_kill           76
 #define __pse51_select                77
+#define __pse51_thread_inquire        78
 
 #ifdef __KERNEL__
 
Index: b/ksrc/skins/posix/syscall.c
===================================================================
--- a/ksrc/skins/posix/syscall.c
+++ b/ksrc/skins/posix/syscall.c
@@ -370,6 +370,28 @@ static int __pthread_set_name_np(struct
 	return -pthread_set_name_np(k_tid, name);
 }
 
+static int __pthread_inquire_np(struct pt_regs *regs)
+{
+	struct pse51_hkey hkey;
+	pthread_info_t info;
+	pthread_t k_tid;
+	int err;
+
+	hkey.u_tid = __xn_reg_arg1(regs);
+	hkey.mm = current->mm;
+	k_tid = __pthread_find(&hkey);
+
+	if (!k_tid)
+		return -ESRCH;
+
+	err = -pthread_inquire_np(k_tid, &info);
+	if (err)
+		return err;
+
+	return __xn_safe_copy_to_user((void __user *)__xn_reg_arg2(regs),
+				      &info, sizeof(info));
+}
+
 static int __pthread_kill(struct pt_regs *regs)
 {
 	struct pse51_hkey hkey;
@@ -2762,6 +2784,7 @@ static xnsysent_t __systab[] = {
 	[__pse51_condattr_setpshared] =
 	    {&__pthread_condattr_setpshared, __xn_exec_any},
 	[__pse51_select] = {&__select, __xn_exec_primary},
+	[__pse51_thread_inquire] = {&__pthread_inquire_np, __xn_exec_any},
 };
 
 static void __shadow_delete_hook(xnthread_t *thread)
Index: b/ksrc/skins/posix/thread.c
===================================================================
--- a/ksrc/skins/posix/thread.c
+++ b/ksrc/skins/posix/thread.c
@@ -698,6 +698,62 @@ int pthread_set_name_np(pthread_t thread
 	return 0;
 }
 
+/**
+ * Inquire about a thread.
+ *
+ * Return various information about the status of a given thread.
+ *
+ * This service is a non-portable extension of the POSIX interface.
+ *
+ * @param thread identifier of the thread to inquire;
+ *
+ * @param info address of a structure the thread information will be
+ * written to.
+ *
+ * @return 0 on success;
+ * @return an error number if:
+ * - ESRCH, @a thread is invalid;
+ *
+ */
+int pthread_inquire_np(pthread_t thread, pthread_info_t *info)
+{
+	xnticks_t raw_exectime;
+	int err = 0;
+	spl_t s;
+
+	xnlock_get_irqsave(&nklock, s);
+
+	if (!pse51_obj_active(thread, PSE51_THREAD_MAGIC, struct pse51_thread)) {
+		err = ESRCH;
+		goto unlock_and_exit;
+	}
+
+	strcpy(info->name, xnthread_name(&thread->threadbase));
+	info->bprio = xnthread_base_priority(&thread->threadbase);
+	info->cprio = xnthread_current_priority(&thread->threadbase);
+	info->status = xnthread_state_flags(&thread->threadbase) &
+		~(XNZOMBIE | XNRESTART | XNRELAX | XNMAPPED | XNFPU | XNROOT
+		  | XNSWLOCK | 0x0f000000);
+	if (!xnthread_test_state(&thread->threadbase, XNRELAX))
+		info->status |= PTHREAD_PRIMARY;
+	ticks2ts(&info->relpoint,
+		 xntimer_get_date(&thread->threadbase.ptimer));
+	raw_exectime = xnthread_get_exectime(&thread->threadbase);
+	if (thread->threadbase.sched->runthread == &thread->threadbase)
+		raw_exectime += xnstat_exectime_now() -
+			xnthread_get_lastswitch(&thread->threadbase);
+	ticks2ts(&info->exectime, xnarch_tsc_to_ns(raw_exectime));
+	info->modeswitches = xnstat_counter_get(&thread->threadbase.stat.ssw);
+	info->ctxswitches = xnstat_counter_get(&thread->threadbase.stat.csw);
+	info->pagefaults = xnstat_counter_get(&thread->threadbase.stat.pf);
+
+      unlock_and_exit:
+
+	xnlock_put_irqrestore(&nklock, s);
+
+	return err;
+}
+
 void pse51_thread_abort(pthread_t thread, void *status)
 {
 	thread_exit_status(thread) = status;
Index: b/src/skins/posix/thread.c
===================================================================
--- a/src/skins/posix/thread.c
+++ b/src/skins/posix/thread.c
@@ -270,6 +270,13 @@ int pthread_set_name_np(pthread_t thread
 				  __pse51_thread_set_name, thread, name);
 }
 
+int pthread_inquire_np(pthread_t thread, pthread_info_t *info)
+{
+	return -XENOMAI_SKINCALL2(__pse51_muxid,
+				  __pse51_thread_inquire,
+				  thread, info);
+}
+
 int __wrap_pthread_kill(pthread_t thread, int sig)
 {
 	int err;


