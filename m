Message-ID: <4E241E77.6090508@domain.hid>
Date: Mon, 18 Jul 2011 13:52:23 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [RFC] Waitqueue-free gatekeeper wakeup
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>

Hi Philippe,

trying to decouple the PREEMPT-RT gatekeeper wakeup path from XNATOMIC
(to fix the remaining races there), I wondered why we need a waitqueue
here at all.

What about an approach like below, i.e. waking up the gatekeeper
directly via wake_up_process? That could even be called from interrupt
context. We should be able to avoid missing a wakeup by setting the task
state to INTERRUPTIBLE before signaling the semaphore.

Am I missing something?

Jan


diff --git a/include/nucleus/sched.h b/include/nucleus/sched.h
index e251329..df8853b 100644
--- a/include/nucleus/sched.h
+++ b/include/nucleus/sched.h
@@ -111,7 +111,6 @@ typedef struct xnsched {
 
 #ifdef CONFIG_XENO_OPT_PERVASIVE
 	struct task_struct *gatekeeper;
-	wait_queue_head_t gkwaitq;
 	struct semaphore gksync;
 	struct xnthread *gktarget;
 #endif
diff --git a/ksrc/nucleus/shadow.c b/ksrc/nucleus/shadow.c
index f6b1e16..238317a 100644
--- a/ksrc/nucleus/shadow.c
+++ b/ksrc/nucleus/shadow.c
@@ -92,7 +92,6 @@ static struct __lostagerq {
 #define LO_SIGGRP_REQ 2
 #define LO_SIGTHR_REQ 3
 #define LO_UNMAP_REQ  4
-#define LO_GKWAKE_REQ 5
 		int type;
 		struct task_struct *task;
 		int arg;
@@ -759,9 +758,6 @@ static void lostage_handler(void *cookie)
 	int cpu, reqnum, type, arg, sig, sigarg;
 	struct __lostagerq *rq;
 	struct task_struct *p;
-#ifdef CONFIG_PREEMPT_RT
-	struct xnsched *sched;
-#endif
 
 	cpu = smp_processor_id();
 	rq = &lostagerq[cpu];
@@ -819,13 +815,6 @@ static void lostage_handler(void *cookie)
 		case LO_SIGGRP_REQ:
 			kill_proc(p->pid, arg, 1);
 			break;
-
-#ifdef CONFIG_PREEMPT_RT
-		case LO_GKWAKE_REQ:
-			sched = xnpod_sched_slot(cpu);
-			wake_up_interruptible_sync(&sched->gkwaitq);
-			break;
-#endif
 		}
 	}
 }
@@ -873,7 +862,6 @@ static inline int normalize_priority(int prio)
 static int gatekeeper_thread(void *data)
 {
 	struct task_struct *this_task = current;
-	DECLARE_WAITQUEUE(wait, this_task);
 	int cpu = (long)data;
 	struct xnsched *sched = xnpod_sched_slot(cpu);
 	struct xnthread *target;
@@ -886,12 +874,10 @@ static int gatekeeper_thread(void *data)
 	set_cpus_allowed(this_task, cpumask);
 	set_linux_task_priority(this_task, MAX_RT_PRIO - 1);
 
-	init_waitqueue_head(&sched->gkwaitq);
-	add_wait_queue_exclusive(&sched->gkwaitq, &wait);
+	set_current_state(TASK_INTERRUPTIBLE);
 	up(&sched->gksync);	/* Sync with xnshadow_mount(). */
 
 	for (;;) {
-		set_current_state(TASK_INTERRUPTIBLE);
 		up(&sched->gksync); /* Make the request token available. */
 		schedule();
 
@@ -937,6 +923,7 @@ static int gatekeeper_thread(void *data)
 			xnlock_put_irqrestore(&nklock, s);
 			xnpod_schedule();
 		}
+		set_current_state(TASK_INTERRUPTIBLE);
 	}
 
 	return 0;
@@ -1014,23 +1001,9 @@ redo:
 	thread->gksched = sched;
 	xnthread_set_info(thread, XNATOMIC);
 	set_current_state(TASK_INTERRUPTIBLE | TASK_ATOMICSWITCH);
-#ifndef CONFIG_PREEMPT_RT
-	/*
-	 * We may not hold the preemption lock across calls to
-	 * wake_up_*() services over fully preemptible kernels, since
-	 * tasks might sleep when contending for spinlocks. The wake
-	 * up call for the gatekeeper will happen later, over an APC
-	 * we kick in do_schedule_event() on the way out for the
-	 * hardening task.
-	 *
-	 * We could delay the wake up call over non-RT 2.6 kernels as
-	 * well, but not when running over 2.4 (scheduler innards
-	 * would not allow this, causing weirdnesses when hardening
-	 * tasks). So we always do the early wake up when running
-	 * non-RT, which includes 2.4.
-	 */
-	wake_up_interruptible_sync(&sched->gkwaitq);
-#endif
+
+	wake_up_process(sched->gatekeeper);
+
 	schedule();
 
 	/*

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

