Resent-To: xenomai-core <xenomai@xenomai.org>
Resent-Message-Id: <48F756EB.5010602@domain.hid>
Message-Id: <20081016145758.149651905@domain.hid>
Date: Thu, 16 Oct 2008 16:57:58 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
References: <20081016145757.935266172@domain.hid>
Content-Disposition: inline;
	filename=fix-status-reported-by-rt_task_inquire.patch
Subject: [Xenomai-core] [PATCH 1/2] Fix status values reported by
	rt_task_inquire
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

So far rt_task_inquire simply copied the nucleus thread status, leaking
lots of undocumented or incorrectly described state values to the user.
This patch first of all fixes the T_* documentation, adds further
informative states, and then ensures that only those are reported back
in RT_TASK_INFO.status. This includes correct reporting of T_PRIMARY and
T_JOINABLE.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 include/native/task.h       |   38 +++++++++++++++++++++++---------------
 ksrc/skins/native/syscall.c |    7 +++++++
 ksrc/skins/native/task.c    |    5 ++++-
 3 files changed, 34 insertions(+), 16 deletions(-)

Index: b/include/native/task.h
===================================================================
--- a/include/native/task.h
+++ b/include/native/task.h
@@ -28,7 +28,6 @@
 
 /* Creation flags. */
 #define T_FPU     XNFPU
-#define T_SUSP    XNSUSP
 /* <!> High bits must not conflict with XNFPU|XNSHADOW|XNSHIELD|XNSUSP. */
 #define T_CPU(cpu) (1 << (24 + (cpu & 7))) /* Up to 8 cpus [0-7] */
 #define T_CPUMASK  0xff000000
@@ -40,22 +39,31 @@
   @{
  */
 
-#define T_BLOCKED  XNPEND     /**< See #XNPEND    */
-#define T_DELAYED  XNDELAY    /**< See #XNDELAY   */
-#define T_READY    XNREADY    /**< See #XNREADY   */
-#define T_DORMANT  XNDORMANT  /**< See #XNDORMANT */
-#define T_STARTED  XNSTARTED  /**< See #XNSTARTED */
-#define T_BOOST    XNBOOST    /**< See #XNBOOST   */
-#define T_LOCK     XNLOCK     /**< See #XNLOCK    */
-#define T_RRB      XNRRB      /**< See #XNRRB     */
-#define T_NOSIG    XNASDI     /**< See #XNASDI    */ 
-#define T_SHIELD   XNSHIELD   /**< See #XNSHIELD  */ 
-#define T_WARNSW   XNTRAPSW   /**< See #XNTRAPSW  */ 
-#define T_RPIOFF   XNRPIOFF   /**< See #XNRPIOFF  */ 
-#define T_PRIMARY  0x00000200	/* Recycle internal bits status which */
-#define T_JOINABLE 0x00000400	/* won't be passed to the nucleus.  */
+#define T_SUSP       XNSUSP	/**< Suspended. */
+#define T_BLOCKED    XNPEND	/**< Sleep-wait for a resource. */
+#define T_DELAYED    XNDELAY	/**< Delayed. */
+#define T_READY      XNREADY	/**< Linked to the ready queue. */
+#define T_DORMANT    XNDORMANT	/**< Not started yet or killed. */
+#define T_STARTED    XNSTARTED	/**< Thread has been started. */
+/* Reuses XNRELAX flag, but invertedly. */
+#define T_PRIMARY    0x00000200	/**< Running under Xenomai control (primary mode). */
+#define T_HELD       XNHELD	/**< Held thread from suspended partition. */
+#define T_BOOST      XNBOOST	/**< Undergoes a PIP boost. */
+#define T_DEBUG      XNDEBUG	/**< Hit a debugger breakpoint (user space only). */
+#define T_LOCK       XNLOCK	/**< Holds the scheduler lock (i.e. not preemptible). */
+#define T_RRB        XNRRB	/**< Undergoes a round-robin scheduling. */
+#define T_NOSIG      XNASDI	/**< ASR are disabled. */
+#define T_SHIELD     XNSHIELD	/**< IRQ shield is enabled (user space only). */
+#define T_WARNSW     XNTRAPSW	/**< Trap execution mode switches. */
+#define T_RPIOFF     XNRPIOFF	/**< Stop priority coupling (user space only). */
+#define T_USERSPACE  XNSHADOW	/**< User space task. */
+/* Reuses XNROOT (ROOT is not an addressable task). */
+#define T_JOINABLE   0x00400000	/**< Task electable for rt_task_join. */
 /*! @} */ /* Ends doxygen-group native_task_status */
 
+/* Used to save the T_JOINABLE state after initialization. */
+#define __T_JOINABLE XNTHREAD_INFO_SPARE0
+
 /* Task hook types. */
 #define T_HOOK_START  XNHOOK_THREAD_START
 #define T_HOOK_SWITCH XNHOOK_THREAD_SWITCH
Index: b/ksrc/skins/native/syscall.c
===================================================================
--- a/ksrc/skins/native/syscall.c
+++ b/ksrc/skins/native/syscall.c
@@ -159,6 +159,8 @@ static int __rt_task_create(struct pt_re
 	prio = bulk.a3;
 	/* Task init mode & CPU affinity. */
 	mode = bulk.a4 & (T_CPUMASK | T_SUSP | T_SHIELD);
+	if (bulk.a4 & T_JOINABLE)
+		mode |= __T_JOINABLE;
 
 	task = (RT_TASK *)xnmalloc(sizeof(*task));
 
@@ -516,6 +518,11 @@ static int __rt_task_inquire(struct pt_r
 	if (err)
 		return err;
 
+	if (info.status & __T_JOINABLE) {
+		info.status &= ~__T_JOINABLE;
+		info.status |= T_JOINABLE;
+	}
+
 	if (__xn_safe_copy_to_user((void __user *)__xn_reg_arg2(regs),
 				   &info, sizeof(info)))
 		return -EFAULT;
Index: b/ksrc/skins/native/task.c
===================================================================
--- a/ksrc/skins/native/task.c
+++ b/ksrc/skins/native/task.c
@@ -1129,7 +1129,10 @@ int rt_task_inquire(RT_TASK *task, RT_TA
 	strcpy(info->name, xnthread_name(&task->thread_base));
 	info->bprio = xnthread_base_priority(&task->thread_base);
 	info->cprio = xnthread_current_priority(&task->thread_base);
-	info->status = xnthread_state_flags(&task->thread_base);
+	info->status = xnthread_state_flags(&task->thread_base) &
+		~(XNZOMBIE | XNRESTART | XNMAPPED | XNFPU | XNROOT | XNSWLOCK
+		  | 0x0f000000);
+	info->status ^= T_PRIMARY; /* we use XNRELAX invertedly */
 	info->relpoint = xntimer_get_date(&task->thread_base.ptimer);
 	raw_exectime = xnthread_get_exectime(&task->thread_base);
 	if (task->thread_base.sched->runthread == &task->thread_base)


