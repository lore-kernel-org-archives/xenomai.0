Message-ID: <48FB5082.5060503@domain.hid>
Date: Sun, 19 Oct 2008 17:21:38 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <48F9F12F.7090708@domain.hid> <48F9F438.7010209@domain.hid>
In-Reply-To: <48F9F438.7010209@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH 1/1] Use SIGWINCH to trigger priority
 change in user-space.
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai core <Xenomai-core@domain.hid>

Gilles Chanteperdrix wrote:
> Gilles Chanteperdrix wrote:
>> Hi,
>>
>> here is a patch which implements the idea discussed previously of 
>> re-using SIGWINCH to trigger priority changes in user-space. There is 
>> only one patch, but the files should have been put in a logical order
>> to make review easier.
> 
> Since there are chances of conflicts with Jan patches series, I will
> rebase this patch after Jan patches have been commited.

Here comes a newer version.

Index: include/nucleus/thread.h
===================================================================
--- include/nucleus/thread.h	(revision 4251)
+++ include/nucleus/thread.h	(working copy)
@@ -116,6 +116,7 @@
 #define XNROBBED  0x00000020 /**< Robbed from resource ownership */
 #define XNATOMIC  0x00000040 /**< In atomic switch from secondary to primary mode */
 #define XNAFFSET  0x00000080 /**< CPU affinity changed from primary mode */
+#define XNPRIOSET 0x00000100 /**< Priority changed from primary mode */
 
 /* These information flags are available to the real-time interfaces */
 #define XNTHREAD_INFO_SPARE0  0x10000000
Index: include/asm-generic/syscall.h
===================================================================
--- include/asm-generic/syscall.h	(revision 4251)
+++ include/asm-generic/syscall.h	(working copy)
@@ -59,7 +59,12 @@ typedef struct xnsysinfo {
     unsigned long tickval;	/* Tick duration (ns) */
 } xnsysinfo_t;
 
-#define SIGHARDEN  SIGWINCH
+#define SIGSHADOW  SIGWINCH
+#define SIGSHADOW_ACTION_HARDEN 1
+#define SIGSHADOW_ACTION_RENICE 2
+#define sigshadow_action(code) ((code) & 0xff)
+#define sigshadow_prio(code) (((code) >> 8) & 0xff)
+#define sigshadow_int(action, prio) ((action) | ((prio) << 8))
 
 #ifdef __KERNEL__
 
Index: include/nucleus/shadow.h
===================================================================
--- include/nucleus/shadow.h	(revision 4251)
+++ include/nucleus/shadow.h	(working copy)
@@ -99,6 +99,7 @@ void xnshadow_reset_shield(void);
 
 void xnshadow_send_sig(struct xnthread *thread,
 		       int sig,
+		       int arg,
 		       int specific);
 
 void xnshadow_rpi_check(void);
Index: ksrc/nucleus/shadow.c
===================================================================
--- ksrc/nucleus/shadow.c	(revision 4251)
+++ ksrc/nucleus/shadow.c	(working copy)
@@ -115,6 +115,14 @@ do { \
    switch_lock_owner[task_cpu(t)] = t; \
 } while(0)
 
+#define xnshadow_sig_mux(sig, arg) ((sig) | (arg << 8))
+#define xnshadow_sig_demux(muxed, sig, arg) \
+	do {				     \
+		int _muxed = (muxed);	     \
+		(sig) = _muxed & 0xff;	     \
+		(arg) = _muxed << 8;	     \
+	} while (0)
+
 static struct task_struct *switch_lock_owner[XNARCH_NR_CPUS];
 
 static int nucleus_muxid = -1;
@@ -879,7 +887,7 @@ static void xnshadow_dereference_skin(un
 
 static void lostage_handler(void *cookie)
 {
-	int cpu = smp_processor_id(), reqnum, sig;
+	int cpu = smp_processor_id(), reqnum, sig, arg;
 	struct __lostagerq *rq = &lostagerq[cpu];
 
 	while ((reqnum = rq->out) != rq->in) {
@@ -927,8 +935,16 @@ static void lostage_handler(void *cookie
 
 		case LO_SIGTHR_REQ:
 
-			sig = rq->req[reqnum].arg;
-			send_sig(sig, p, 1);
+			xnshadow_sig_demux(rq->req[reqnum].arg, sig, arg);
+			if (sig == SIGSHADOW) {
+				siginfo_t si;
+				memset(&si, '\0', sizeof(si));
+				si.si_signo = sig;
+				si.si_code = SI_QUEUE;
+				si.si_int = arg;
+				send_sig_info(sig, &si, p);
+			} else
+				send_sig(sig, p, 1);
 			break;
 
 		case LO_SIGGRP_REQ:
@@ -1237,6 +1253,13 @@ void xnshadow_relax(int notify)
 		/* Help debugging spurious relaxes. */
 		send_sig(SIGXCPU, current, 1);
 
+	if (xnthread_test_info(thread, XNPRIOSET)) {
+		xnthread_clear_info(thread, XNPRIOSET);
+		xnshadow_send_sig(thread, SIGSHADOW,
+				  sigshadow_int(SIGSHADOW_ACTION_RENICE, prio),
+				  1);
+	}
+
 #ifdef CONFIG_SMP
 	/* If the shadow thread changed its CPU affinity while in
 	   primary mode, reset the CPU affinity of its Linux
@@ -1500,16 +1523,16 @@ void xnshadow_start(xnthread_t *thread)
 		schedule_linux_call(LO_START_REQ, p, 0);
 }
 
+/* Called with nklock locked, Xenomai interrupts off. */
 void xnshadow_renice(xnthread_t *thread)
 {
-	/* Called with nklock locked, Xenomai interrupts off. */
-	struct task_struct *p = xnthread_archtcb(thread)->user_task;
-
 	/* We need to bound the priority values in the [1..MAX_RT_PRIO-1]
 	   range, since the core pod's priority scale is a superset of
 	   Linux's priority scale. */
 	int prio = normalize_priority(xnthread_current_priority(thread));
-	schedule_linux_call(LO_RENICE_REQ, p, prio);
+
+	xnshadow_send_sig(thread, SIGSHADOW,
+			  sigshadow_int(SIGSHADOW_ACTION_RENICE, prio), 1);
 
 	if (!xnthread_test_state(thread, XNDORMANT) &&
 	    xnthread_sched(thread) == xnpod_current_sched())
@@ -1519,8 +1542,7 @@ void xnshadow_renice(xnthread_t *thread)
 void xnshadow_suspend(xnthread_t *thread)
 {
 	/* Called with nklock locked, Xenomai interrupts off. */
-	struct task_struct *p = xnthread_archtcb(thread)->user_task;
-	schedule_linux_call(LO_SIGTHR_REQ, p, SIGHARDEN);
+	xnshadow_send_sig(thread, SIGSHADOW, SIGSHADOW_ACTION_HARDEN, 1);
 }
 
 static int xnshadow_sys_migrate(struct pt_regs *regs)
@@ -1531,7 +1553,7 @@ static int xnshadow_sys_migrate(struct p
 				return -EPERM;
 
 			/* Paranoid: a corner case where the
-			   user-space side fiddles with SIGHARDEN
+			   user-space side fiddles with SIGSHADOW
 			   while the target thread is still waiting to
 			   be started. */
 			if (xnthread_test_state(xnshadow_thread(current), XNDORMANT))
@@ -2007,10 +2029,11 @@ static inline int substitute_linux_sysca
 	return 0;
 }
 
-void xnshadow_send_sig(xnthread_t *thread, int sig, int specific)
+void xnshadow_send_sig(xnthread_t *thread, int sig, int arg, int specific)
 {
 	schedule_linux_call(specific ? LO_SIGTHR_REQ : LO_SIGGRP_REQ,
-			    xnthread_user_task(thread), sig);
+			    xnthread_user_task(thread),
+			    xnshadow_sig_mux(sig, specific ? arg : 0));
 }
 
 static inline int do_hisyscall_event(unsigned event, unsigned domid, void *data)
Index: ksrc/nucleus/synch.c
===================================================================
--- ksrc/nucleus/synch.c	(revision 4251)
+++ ksrc/nucleus/synch.c	(working copy)
@@ -343,6 +343,8 @@ static void xnsynch_renice_thread(xnthre
 #ifdef CONFIG_XENO_OPT_PERVASIVE
 	if (xnthread_test_state(thread, XNRELAX))
 		xnshadow_renice(thread);
+	else if (xnthread_test_state(thread, XNSHADOW))
+		xnthread_set_info(thread, XNPRIOSET);
 #endif /* CONFIG_XENO_OPT_PERVASIVE */
 }
 
Index: ksrc/nucleus/pod.c
===================================================================
--- ksrc/nucleus/pod.c	(revision 4251)
+++ ksrc/nucleus/pod.c	(working copy)
@@ -1162,7 +1162,7 @@ void xnpod_delete_thread(xnthread_t *thr
 	    !xnthread_test_state(thread, XNDORMANT) &&
 	    !xnpod_current_p(thread)) {
 		if (!xnpod_userspace_p())
-			xnshadow_send_sig(thread, SIGKILL, 1);
+			xnshadow_send_sig(thread, SIGKILL, 0, 1);
 		/*
 		 * Otherwise, assume the interface library has issued
 		 * pthread_cancel on the target thread, which should
@@ -1456,7 +1456,7 @@ void xnpod_suspend_thread(xnthread_t *th
 	   is actually running some code under the control of the
 	   Linux scheduler (i.e. it's relaxed).  To make this
 	   possible, we force the target Linux task to migrate back to
-	   the Xenomai domain by sending it a SIGHARDEN signal the
+	   the Xenomai domain by sending it a SIGSHADOW signal the
 	   skin interface libraries trap for this specific internal
 	   purpose, whose handler is expected to call back the
 	   nucleus's migration service. By forcing this migration, we
@@ -1821,8 +1821,12 @@ void xnpod_renice_thread_inner(xnthread_
 			xnpod_resume_thread(thread, 0);
 	}
 #ifdef CONFIG_XENO_OPT_PERVASIVE
-	if (propagate && xnthread_test_state(thread, XNRELAX))
-		xnshadow_renice(thread);
+	if (propagate) {
+		if (xnthread_test_state(thread, XNRELAX))
+			xnshadow_renice(thread);
+		else if (xnthread_test_state(thread, XNSHADOW))
+			xnthread_set_info(thread, XNPRIOSET);
+	}
 #endif /* CONFIG_XENO_OPT_PERVASIVE */
 
 	xnlock_put_irqrestore(&nklock, s);
Index: include/asm-generic/bits/sigshadow.h
===================================================================
--- include/asm-generic/bits/sigshadow.h	(revision 0)
+++ include/asm-generic/bits/sigshadow.h	(revision 0)
@@ -0,0 +1,73 @@
+#ifndef _XENO_ASM_GENERIC_BITS_SIGSHADOW_H
+#define _XENO_ASM_GENERIC_BITS_SIGSHADOW_H
+
+#include <pthread.h>
+#include <signal.h>
+
+pthread_once_t __attribute__((weak))
+	xeno_sigshadow_installed = PTHREAD_ONCE_INIT;
+static struct sigaction old_sigshadow_action;
+
+static void sigshadow_handler(int sig, siginfo_t *si, void *ctxt)
+{
+	int action;
+
+	/* Not a signal sent by Xenomai nucleus */
+	if (si->si_code != SI_QUEUE) {
+		const struct sigaction *const sa = &old_sigshadow_action;
+		sigset_t old_sigset;
+
+	  not_nucleus:
+		if ((!(sa->sa_flags & SA_SIGINFO) && !sa->sa_handler)
+		    || ((sa->sa_flags & SA_SIGINFO) && !sa->sa_sigaction))
+			return;
+
+		pthread_sigmask(SIG_SETMASK, &sa->sa_mask, &old_sigset);
+		if (!(sa->sa_flags & SA_SIGINFO))
+			sa->sa_handler(sig);
+		else
+			sa->sa_sigaction(sig, si, ctxt);
+		pthread_sigmask(SIG_SETMASK, &old_sigset, NULL);
+		return;
+	}
+
+	action = sigshadow_action(si->si_int);
+
+	switch(action) {
+	case SIGSHADOW_ACTION_HARDEN:
+		XENOMAI_SYSCALL1(__xn_sys_migrate, XENOMAI_XENO_DOMAIN);
+		break;
+
+	case SIGSHADOW_ACTION_RENICE: {
+		struct sched_param param;
+		int policy;
+
+		param.sched_priority = sigshadow_prio(si->si_int);
+		policy = param.sched_priority > 0 ? SCHED_FIFO: SCHED_OTHER;
+		pthread_setschedparam(pthread_self(), policy, &param);
+		break;
+	}
+
+	default:
+		goto not_nucleus;
+	}
+}
+
+static void sigshadow_install_once(void)
+{
+	struct sigaction new_sigshadow_action;
+
+	new_sigshadow_action.sa_flags = SA_SIGINFO | SA_RESTART;
+	new_sigshadow_action.sa_sigaction = sigshadow_handler;
+	sigemptyset(&new_sigshadow_action.sa_mask);
+
+	sigaction(SIGSHADOW, &new_sigshadow_action, &old_sigshadow_action);
+	if (!(old_sigshadow_action.sa_flags & SA_NODEFER))
+		sigaddset(&old_sigshadow_action.sa_mask, SIGSHADOW);
+}
+
+static inline void sigshadow_install(void)
+{
+	pthread_once(&xeno_sigshadow_installed, sigshadow_install_once);
+}
+#endif /* _XENO_ASM_GENERIC_BITS_SIGSHADOW_H */
Index: src/skins/posix/thread.c
===================================================================
--- src/skins/posix/thread.c	(revision 4251)
+++ src/skins/posix/thread.c	(working copy)
@@ -26,23 +26,13 @@
 #include <semaphore.h>
 #include <posix/syscall.h>
 #include <asm-generic/bits/current.h>
+#include <asm-generic/bits/sigshadow.h>
 
 extern int __pse51_muxid;
 
 static pthread_attr_t default_attr;
 static int linuxthreads;
 
-static void (*old_sigharden_handler)(int sig);
-
-static void __pthread_sigharden_handler(int sig)
-{
-	if (old_sigharden_handler &&
-	    old_sigharden_handler != &__pthread_sigharden_handler)
-		old_sigharden_handler(sig);
-
-	XENOMAI_SYSCALL1(__xn_sys_migrate, XENOMAI_XENO_DOMAIN);
-}
-
 int __wrap_pthread_setschedparam(pthread_t thread,
 				 int policy, const struct sched_param *param)
 {
@@ -67,11 +57,9 @@ int __wrap_pthread_setschedparam(pthread
 
 	if (err == EPERM)
 		return __real_pthread_setschedparam(thread, policy, param);
-	else
-		__real_pthread_setschedparam(thread, policy, param);
 
 	if (!err && promoted) {
-		old_sigharden_handler = signal(SIGHARDEN, &__pthread_sigharden_handler);
+		sigshadow_install();
 #ifndef HAVE___THREAD
 		pthread_setspecific(xeno_current_mode_key, mode_buf);
 #endif /* !HAVE___THREAD */
@@ -138,7 +126,7 @@ static void *__pthread_trampoline(void *
 	unsigned long *mode_buf;
 	long err;
 
-	old_sigharden_handler = signal(SIGHARDEN, &__pthread_sigharden_handler);
+	sigshadow_install();
 
 	param.sched_priority = iargs->prio;
 	policy = iargs->policy;
Index: src/skins/native/task.c
===================================================================
--- src/skins/native/task.c	(revision 4251)
+++ src/skins/native/task.c	(working copy)
@@ -26,6 +26,7 @@
 #include <limits.h>
 #include <native/syscall.h>
 #include <native/task.h>
+#include <asm-generic/bits/sigshadow.h>
 #include <asm-generic/bits/current.h>
 #include "wrappers.h"
 
@@ -50,17 +51,6 @@ struct rt_task_iargs {
 	xncompletion_t *completionp;
 };
 
-static void (*old_sigharden_handler)(int sig);
-
-static void rt_task_sigharden(int sig)
-{
-	if (old_sigharden_handler &&
-	    old_sigharden_handler != &rt_task_sigharden)
-		old_sigharden_handler(sig);
-
-	XENOMAI_SYSCALL1(__xn_sys_migrate, XENOMAI_XENO_DOMAIN);
-}
-
 static void *rt_task_trampoline(void *cookie)
 {
 	struct rt_task_iargs *iargs = (struct rt_task_iargs *)cookie;
@@ -82,7 +72,7 @@ static void *rt_task_trampoline(void *co
 	/* rt_task_delete requires asynchronous cancellation */
 	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
 
-	old_sigharden_handler = signal(SIGHARDEN, &rt_task_sigharden);
+	sigshadow_install();
 
 	bulk.a1 = (u_long)iargs->task;
 	bulk.a2 = (u_long)iargs->name;
@@ -196,8 +186,7 @@ int rt_task_shadow(RT_TASK *task, const 
 
 	/* rt_task_delete requires asynchronous cancellation */
 	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
-
-	old_sigharden_handler = signal(SIGHARDEN, &rt_task_sigharden);
+	sigshadow_install();
 
 	if (prio > 0) {
 		/* Make sure the POSIX library caches the right priority. */
Index: src/skins/vxworks/taskLib.c
===================================================================
--- src/skins/vxworks/taskLib.c	(revision 4251)
+++ src/skins/vxworks/taskLib.c	(working copy)
@@ -27,6 +27,7 @@
 #include <errno.h>
 #include <limits.h>
 #include <vxworks/vxworks.h>
+#include <asm-generic/bits/sigshadow.h>
 #include <asm-generic/bits/current.h>
 #include "wrappers.h"
 
@@ -62,17 +63,6 @@ struct wind_task_iargs {
 	xncompletion_t *completionp;
 };
 
-static void (*old_sigharden_handler)(int sig);
-
-static void wind_task_sigharden(int sig)
-{
-	if (old_sigharden_handler &&
-	    old_sigharden_handler != &wind_task_sigharden)
-		old_sigharden_handler(sig);
-
-	XENOMAI_SYSCALL1(__xn_sys_migrate, XENOMAI_XENO_DOMAIN);
-}
-
 static int wind_task_set_posix_priority(int prio, struct sched_param *param)
 {
 	int maxpprio, pprio;
@@ -111,8 +101,7 @@ static void *wind_task_trampoline(void *
 
 	/* wind_task_delete requires asynchronous cancellation */
 	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
-
-	old_sigharden_handler = signal(SIGHARDEN, &wind_task_sigharden);
+	sigshadow_install();
 
 	bulk.a1 = (u_long)iargs->name;
 	bulk.a2 = (u_long)iargs->prio;
Index: src/skins/psos+/task.c
===================================================================
--- src/skins/psos+/task.c	(revision 4251)
+++ src/skins/psos+/task.c	(working copy)
@@ -26,6 +26,7 @@
 #include <memory.h>
 #include <string.h>
 #include <psos+/psos.h>
+#include <asm-generic/bits/sigshadow.h>
 #include <asm-generic/bits/current.h>
 
 extern int __psos_muxid;
@@ -39,17 +40,6 @@ struct psos_task_iargs {
 	xncompletion_t *completionp;
 };
 
-static void (*old_sigharden_handler)(int sig);
-
-static void psos_task_sigharden(int sig)
-{
-	if (old_sigharden_handler &&
-	    old_sigharden_handler != &psos_task_sigharden)
-		old_sigharden_handler(sig);
-
-	XENOMAI_SYSCALL1(__xn_sys_migrate, XENOMAI_XENO_DOMAIN);
-}
-
 static int psos_task_set_posix_priority(int prio, struct sched_param *param)
 {
 	int maxpprio, pprio;
@@ -81,8 +71,7 @@ static void *psos_task_trampoline(void *
 	pthread_setschedparam(pthread_self(), policy, &param);
 
 	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
-
-	old_sigharden_handler = signal(SIGHARDEN, &psos_task_sigharden);
+	sigshadow_install();
 
 	bulk.a1 = (u_long)iargs->name;
 	bulk.a2 = (u_long)iargs->prio;
@@ -189,8 +178,7 @@ u_long t_shadow(const char *name, /* Xen
 	int err;
 
 	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
-
-	old_sigharden_handler = signal(SIGHARDEN, &psos_task_sigharden);
+	sigshadow_install();
 
 	err = XENOMAI_SKINCALL5(__psos_muxid,
 				__psos_t_create,
Index: src/skins/vrtx/task.c
===================================================================
--- src/skins/vrtx/task.c	(revision 4251)
+++ src/skins/vrtx/task.c	(working copy)
@@ -27,6 +27,7 @@
 #include <errno.h>
 #include <limits.h>
 #include <vrtx/vrtx.h>
+#include <asm-generic/bits/sigshadow.h>
 #include <asm-generic/bits/current.h>
 
 #ifdef HAVE___THREAD
@@ -49,17 +50,6 @@ struct vrtx_task_iargs {
 	xncompletion_t *completionp;
 };
 
-static void (*old_sigharden_handler)(int sig);
-
-static void vrtx_task_sigharden(int sig)
-{
-	if (old_sigharden_handler &&
-	    old_sigharden_handler != &vrtx_task_sigharden)
-		old_sigharden_handler(sig);
-
-	XENOMAI_SYSCALL1(__xn_sys_migrate, XENOMAI_XENO_DOMAIN);
-}
-
 static int vrtx_task_set_posix_priority(int prio, struct sched_param *param)
 {
 	int maxpprio, pprio;
@@ -113,7 +103,7 @@ static void *vrtx_task_trampoline(void *
 	pthread_setspecific(__vrtx_tskey, tcb);
 #endif /* !HAVE___THREAD */
 
-	old_sigharden_handler = signal(SIGHARDEN, &vrtx_task_sigharden);
+	sigshadow_install();
 
 	bulk.a1 = (u_long)iargs->tid;
 	bulk.a2 = (u_long)iargs->prio;
Index: src/skins/uitron/task.c
===================================================================
--- src/skins/uitron/task.c	(revision 4251)
+++ src/skins/uitron/task.c	(working copy)
@@ -24,6 +24,7 @@
 #include <errno.h>
 #include <limits.h>
 #include <asm/xenomai/system.h>
+#include <asm-generic/bits/sigshadow.h>
 #include <uitron/uitron.h>
 #include <asm-generic/bits/current.h>
 
@@ -36,17 +37,6 @@ struct uitron_task_iargs {
 	xncompletion_t *completionp;
 };
 
-static void (*old_sigharden_handler)(int sig);
-
-static void uitron_task_sigharden(int sig)
-{
-	if (old_sigharden_handler &&
-	    old_sigharden_handler != &uitron_task_sigharden)
-		old_sigharden_handler(sig);
-
-	XENOMAI_SYSCALL1(__xn_sys_migrate, XENOMAI_XENO_DOMAIN);
-}
-
 static int uitron_task_set_posix_priority(int prio, struct sched_param *param)
 {
 	int maxpprio, pprio;
@@ -82,7 +72,7 @@ static void *uitron_task_trampoline(void
 	pthread_setschedparam(pthread_self(), policy, &param);
 
 	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
-	old_sigharden_handler = signal(SIGHARDEN, &uitron_task_sigharden);
+	sigshadow_install();
 
 	mode = xeno_init_current_mode();
 	if (!mode) {
@@ -167,8 +157,7 @@ ER shd_tsk(ID tskid, T_CTSK *pk_ctsk) /*
 	pthread_setschedparam(pthread_self(), policy, &param);
 
 	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
-
-	old_sigharden_handler = signal(SIGHARDEN, &uitron_task_sigharden);
+	sigshadow_install();
 
 	err = XENOMAI_SKINCALL3(__uitron_muxid,
 				__uitron_cre_tsk,


-- 
					    Gilles.

