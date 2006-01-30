Message-ID: <43DE3243.8080603@domain.hid>
Date: Mon, 30 Jan 2006 16:35:31 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [BUG] racy xnshadow_harden under CONFIG_PREEMPT
References: <43D21144.8040005@domain.hid>	<b647ffbd0601220010x3cc023an@domain.hid>	<fd6a47a90601220819n3f4cd382t@domain.hid>	<E1F16LA-0001ku-C4@domain.hid>	<43D52BA3.6020005@domain.hid>
	<43DE27E5.3010206@domain.hid>
In-Reply-To: <43DE27E5.3010206@domain.hid>
Content-Type: multipart/mixed; boundary="------------040509010101030901010603"
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

This is a multi-part message in MIME format.
--------------040509010101030901010603
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Philippe Gerum wrote:
> Jan Kiszka wrote:
> 
>> Gilles Chanteperdrix wrote:
>>
>>> Jeroen Van den Keybus wrote:
>>> > Hello,
>>> > > > I'm currently not at a level to participate in your discussion. 
>>> Although I'm
>>> > willing to supply you with stresstests, I would nevertheless like 
>>> to learn
>>> > more from task migration as this debugging session proceeds. In 
>>> order to do
>>> > so, please confirm the following statements or indicate where I 
>>> went wrong.
>>> > I hope others may learn from this as well.
>>> > > xn_shadow_harden(): This is called whenever a Xenomai thread 
>>> performs a
>>> > Linux (root domain) system call (notified by Adeos ?).
>>> xnshadow_harden() is called whenever a thread running in secondary
>>> mode (that is, running as a regular Linux thread, handled by Linux
>>> scheduler) is switching to primary mode (where it will run as a Xenomai
>>> thread, handled by Xenomai scheduler). Migrations occur for some system
>>> calls. More precisely, Xenomai skin system calls tables associates a few
>>> flags with each system call, and some of these flags cause migration of
>>> the caller when it issues the system call.
>>>
>>> Each Xenomai user-space thread has two contexts, a regular Linux
>>> thread context, and a Xenomai thread called "shadow" thread. Both
>>> contexts share the same stack and program counter, so that at any time,
>>> at least one of the two contexts is seen as suspended by the scheduler
>>> which handles it.
>>>
>>> Before xnshadow_harden is called, the Linux thread is running, and its
>>> shadow is seen in suspended state with XNRELAX bit by Xenomai
>>> scheduler. After xnshadow_harden, the Linux context is seen suspended
>>> with INTERRUPTIBLE state by Linux scheduler, and its shadow is seen as
>>> running by Xenomai scheduler.
>>>
>>> The migrating thread
>>> > (nRT) is marked INTERRUPTIBLE and run by the Linux kernel
>>> > wake_up_interruptible_sync() call. Is this thread actually run or 
>>> does it
>>> > merely put the thread in some Linux to-do list (I assumed the first 
>>> case) ?
>>>
>>> Here, I am not sure, but it seems that when calling
>>> wake_up_interruptible_sync the woken up task is put in the current CPU
>>> runqueue, and this task (i.e. the gatekeeper), will not run until the
>>> current thread (i.e. the thread running xnshadow_harden) marks itself as
>>> suspended and calls schedule(). Maybe, marking the running thread as
>>
>>
>>
>> Depends on CONFIG_PREEMPT. If set, we get a preempt_schedule already
>> here - and a switch if the prio of the woken up task is higher.
>>
>> BTW, an easy way to enforce the current trouble is to remove the "_sync"
>> from wake_up_interruptible. As I understand it this _sync is just an
>> optimisation hint for Linux to avoid needless scheduler runs.
>>
> 
> You could not guarantee the following execution sequence doing so 
> either, i.e.
> 
> 1- current wakes up the gatekeeper
> 2- current goes sleeping to exit the Linux runqueue in schedule()
> 3- the gatekeeper resumes the shadow-side of the old current
> 
> The point is all about making 100% sure that current is going to be 
> unlinked from the Linux runqueue before the gatekeeper processes the 
> resumption request, whatever event the kernel is processing 
> asynchronously in the meantime. This is the reason why, as you already 
> noticed, preempt_schedule_irq() nicely breaks our toy by stealing the 
> CPU from the hardening thread whilst keeping it linked to the runqueue: 
> upon return from such preemption, the gatekeeper might have run already, 
>  hence the newly hardened thread ends up being seen as runnable by both 
> the Linux and Xeno schedulers. Rainy day indeed.
> 
> We could rely on giving "current" the highest SCHED_FIFO priority in 
> xnshadow_harden() before waking up the gk, until the gk eventually 
> promotes it to the Xenomai scheduling mode and downgrades this priority 
> back to normal, but we would pay additional latencies induced by each 
> aborted rescheduling attempt that may occur during the atomic path we 
> want to enforce.
> 
> The other way is to make sure that no in-kernel preemption of the 
> hardening task could occur after step 1) and until step 2) is performed, 
> given that we cannot currently call schedule() with interrupts or 
> preemption off. I'm on it.
> 

 > Could anyone interested in this issue test the following couple of patches?

 > atomic-switch-state.patch is to be applied against Adeos-1.1-03/x86 for 2.6.15
 > atomic-wakeup-and-schedule.patch is to be applied against Xeno 2.1-rc2

 > Both patches are needed to fix the issue.

 > TIA,

And now, Ladies and Gentlemen, with the patches attached.

-- 

Philippe.


--------------040509010101030901010603
Content-Type: text/x-patch;
 name="atomic-switch-state.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="atomic-switch-state.patch"

--- 2.6.15-x86/kernel/sched.c	2006-01-07 15:18:31.000000000 +0100
+++ 2.6.15-ipipe/kernel/sched.c	2006-01-30 15:15:27.000000000 +0100
@@ -2963,7 +2963,7 @@
 	 * Otherwise, whine if we are scheduling when we should not be.
 	 */
 	if (likely(!current->exit_state)) {
-		if (unlikely(in_atomic())) {
+		if (unlikely(!(current->state & TASK_ATOMICSWITCH) && in_atomic())) {
 			printk(KERN_ERR "scheduling while atomic: "
 				"%s/0x%08x/%d\n",
 				current->comm, preempt_count(), current->pid);
@@ -2972,8 +2972,13 @@
 	}
 	profile_hit(SCHED_PROFILING, __builtin_return_address(0));
 
+	if (unlikely(current->state & TASK_ATOMICSWITCH)) {
+		current->state &= ~TASK_ATOMICSWITCH;
+		goto preemption_off;
+	}
 need_resched:
 	preempt_disable();
+preemption_off:
 #ifdef CONFIG_IPIPE
 	if (unlikely(ipipe_current_domain != ipipe_root_domain)) {
 		preempt_enable();
--- 2.6.15-x86/include/linux/sched.h	2006-01-07 15:18:31.000000000 +0100
+++ 2.6.15-ipipe/include/linux/sched.h	2006-01-30 15:14:43.000000000 +0100
@@ -128,6 +128,11 @@
 #define EXIT_DEAD		32
 /* in tsk->state again */
 #define TASK_NONINTERACTIVE	64
+#ifdef CONFIG_IPIPE
+#define TASK_ATOMICSWITCH	512
+#else  /* !CONFIG_IPIPE */
+#define TASK_ATOMICSWITCH	0
+#endif /* CONFIG_IPIPE */
 
 #define __set_task_state(tsk, state_value)		\
 	do { (tsk)->state = (state_value); } while (0)

--------------040509010101030901010603
Content-Type: text/x-patch;
 name="atomic-wakeup-and-schedule.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="atomic-wakeup-and-schedule.patch"

Index: include/asm-generic/wrappers.h
===================================================================
--- include/asm-generic/wrappers.h	(revision 487)
+++ include/asm-generic/wrappers.h	(working copy)
@@ -60,6 +60,10 @@
 /* Sched */
 #define MAX_RT_PRIO 100
 #define task_cpu(p) ((p)->processor)
+#ifndef CONFIG_PREEMPT
+#define preempt_disable()  do { } while(0)
+#define preempt_enable()   do { } while(0)
+#endif /* CONFIG_PREEMPT */
 
 /* Signals */
 #define wrap_sighand_lock(p)     ((p)->sigmask_lock)
Index: include/asm-generic/hal.h
===================================================================
--- include/asm-generic/hal.h	(revision 487)
+++ include/asm-generic/hal.h	(working copy)
@@ -216,6 +216,11 @@
 #define IPIPE_EVENT_SELF  0
 #endif /* !IPIPE_EVENT_SELF */
 
+#ifndef TASK_ATOMICSWITCH
+/* Some early I-pipe versions don't have this either. */
+#define TASK_ATOMICSWITCH  0
+#endif /* !TASK_ATOMICSWITCH */
+
 #define rthal_catch_taskexit(hdlr)	\
     ipipe_catch_event(ipipe_root_domain,IPIPE_EVENT_EXIT,hdlr)
 #define rthal_catch_sigwake(hdlr)	\
Index: ksrc/nucleus/shadow.c
===================================================================
--- ksrc/nucleus/shadow.c	(revision 487)
+++ ksrc/nucleus/shadow.c	(working copy)
@@ -453,50 +453,33 @@
        the Xenomai domain. This will cause the shadow thread to resume
        using the register state of the current Linux task. For this to
        happen, we set up the migration data, prepare to suspend the
-       current task then wake up the gatekeeper which will perform the
-       actual transition. */
+       current task, wake up the gatekeeper which will perform the
+       actual transition, then schedule out. Most of this sequence
+       must be atomic, and we get this guarantee by disabling
+       preemption and using the TASK_ATOMICSWITCH cumulative state
+       provided by Adeos to Linux tasks. */
 
     gk->thread = thread;
-    set_current_state(TASK_INTERRUPTIBLE);
+    preempt_disable();
+    set_current_state(TASK_INTERRUPTIBLE|TASK_ATOMICSWITCH);
     wake_up_interruptible_sync(&gk->waitq);
+    schedule();
 
-    if (rthal_current_domain == rthal_root_domain) {
+    /* Rare case: we might have been awaken by a signal before the
+       gatekeeper sent us to primary mode. Since TASK_UNINTERRUPTIBLE
+       is unavailable to us without wrecking the runqueue's count of
+       uniniterruptible tasks, we just notice the issue and gracefully
+       fail; the caller will have to process this signal anyway. */
 
-        /* On non-preemptible kernels, we always enter this code,
-	   since there is no preemption opportunity before we
-	   explicitely call schedule(). On preemptible kernels, we
-	   might have been switched out on our way in/out
-	   wake_up_interruptible_sync(), and scheduled back after the
-	   gatekeeper kicked the Xenomai scheduler. In such a case, we
-	   need to check the current Adeos domain: if this is Xenomai,
-	   then the switch has already taken place and the current
-	   task is already running in primary mode; if it's not, then
-	   we need to call schedule() in order to force the current
-	   task out and let the gatekeeper switch us back in primary
-	   mode. The small race window between the test and the call
-	   to schedule() is closed by the latter routine, which denies
-	   rescheduling over non-root domains (I-pipe patches >=
-	   1.0-08 for ppc, or 1.0-12 for x86). */
-
-	schedule();
-
-	/* Rare case: we might have been awaken by a signal before the
-	   gatekeeper sent us to primary mode. Since
-	   TASK_UNINTERRUPTIBLE is unavailable to us without wrecking
-	   the runqueue's count of uniniterruptible tasks, we just
-	   notice the issue and gracefully fail; the caller will have
-	   to process this signal anyway. */
-
-	if (rthal_current_domain == rthal_root_domain) {
+    if (rthal_current_domain == rthal_root_domain) {
 #ifdef CONFIG_XENO_OPT_DEBUG
-	    if (!signal_pending(this_task) ||
-		this_task->state != TASK_RUNNING)
-		xnpod_fatal("xnshadow_harden() failed for thread %s[%d]",
-			    thread->name,
-			    xnthread_user_pid(thread));
+    	if (!signal_pending(this_task) ||
+	    this_task->state != TASK_RUNNING)
+	    xnpod_fatal("xnshadow_harden() failed for thread %s[%d]",
+			thread->name,
+			xnthread_user_pid(thread));
 #endif /* CONFIG_XENO_OPT_DEBUG */
-	    return -ERESTARTSYS;
-	}
+	return -ERESTARTSYS;
     }
 
     /* "current" is now running into the Xenomai domain. */

--------------040509010101030901010603--

