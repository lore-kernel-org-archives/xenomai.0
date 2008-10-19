Message-ID: <48FB15A8.30703@domain.hid>
Date: Sun, 19 Oct 2008 13:10:32 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48F9F12F.7090708@domain.hid>
In-Reply-To: <48F9F12F.7090708@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE5A95E496AF4BACCCD9FC63C"
Sender: jan.kiszka@domain.hid
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE5A95E496AF4BACCCD9FC63C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Hi,
>=20
> here is a patch which implements the idea discussed previously of=20
> re-using SIGWINCH to trigger priority changes in user-space. There is=20
> only one patch, but the files should have been put in a logical order
> to make review easier.

Thanks for providing this. Find a few comments below, primarily
targeting the (not new) signal hooking strategy.

>=20
> Index: include/nucleus/thread.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- include/nucleus/thread.h	(revision 4218)
> +++ include/nucleus/thread.h	(working copy)
> @@ -116,6 +116,7 @@
>  #define XNROBBED  0x00000020 /**< Robbed from resource ownership */
>  #define XNATOMIC  0x00000040 /**< In atomic switch from secondary to p=
rimary mode */
>  #define XNAFFSET  0x00000080 /**< CPU affinity changed from primary mo=
de */
> +#define XNPRIOSET 0x00000100 /**< Priority changed from primary mode *=
/
> =20
>  /* These information flags are available to the real-time interfaces *=
/
>  #define XNTHREAD_INFO_SPARE0  0x10000000
> Index: include/asm-generic/syscall.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- include/asm-generic/syscall.h	(revision 4218)
> +++ include/asm-generic/syscall.h	(working copy)
> @@ -59,7 +59,12 @@ typedef struct xnsysinfo {
>      unsigned long tickval;	/* Tick duration (ns) */
>  } xnsysinfo_t;
> =20
> -#define SIGHARDEN  SIGWINCH
> +#define SIGSHADOW  SIGWINCH
> +#define SIGSHADOW_ACTION_HARDEN 1
> +#define SIGSHADOW_ACTION_RENICE 2
> +#define sigshadow_action(code) ((code) & 0xff)
> +#define sigshadow_prio(code) (((code) >> 8) & 0xff)
> +#define sigshadow_int(action, prio) ((action) | ((prio) << 8))
> =20
>  #ifdef __KERNEL__
> =20
> Index: include/nucleus/shadow.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- include/nucleus/shadow.h	(revision 4218)
> +++ include/nucleus/shadow.h	(working copy)
> @@ -98,6 +98,7 @@ void xnshadow_reset_shield(void);
> =20
>  void xnshadow_send_sig(struct xnthread *thread,
>  		       int sig,
> +		       int arg,
>  		       int specific);
> =20
>  void xnshadow_rpi_check(void);
> Index: ksrc/nucleus/shadow.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- ksrc/nucleus/shadow.c	(revision 4218)
> +++ ksrc/nucleus/shadow.c	(working copy)
> @@ -115,6 +115,14 @@ do { \
>     switch_lock_owner[task_cpu(t)] =3D t; \
>  } while(0)
> =20
> +#define xnshadow_sig_mux(sig, arg) ((sig) | (arg << 8))
> +#define xnshadow_sig_demux(muxed, sig, arg) \
> +	do {				     \
> +		int _muxed =3D (muxed);	     \
> +		(sig) =3D _muxed & 0xff;	     \
> +		(arg) =3D _muxed << 8;	     \
> +	} while (0)
> +
>  static struct task_struct *switch_lock_owner[XNARCH_NR_CPUS];
> =20
>  static int nucleus_muxid =3D -1;
> @@ -879,7 +887,7 @@ static void xnshadow_dereference_skin(un
> =20
>  static void lostage_handler(void *cookie)
>  {
> -	int cpu =3D smp_processor_id(), reqnum, sig;
> +	int cpu =3D smp_processor_id(), reqnum, sig, arg;
>  	struct __lostagerq *rq =3D &lostagerq[cpu];
> =20
>  	while ((reqnum =3D rq->out) !=3D rq->in) {
> @@ -927,8 +935,16 @@ static void lostage_handler(void *cookie
> =20
>  		case LO_SIGTHR_REQ:
> =20
> -			sig =3D rq->req[reqnum].arg;
> -			send_sig(sig, p, 1);
> +			xnshadow_sig_demux(rq->req[reqnum].arg, sig, arg);
> +			if (sig =3D=3D SIGSHADOW) {
> +				siginfo_t si;
> +				memset(&si, '\0', sizeof(si));
> +				si.si_signo =3D sig;
> +				si.si_code =3D SI_QUEUE;
> +				si.si_int =3D arg;
> +				send_sig_info(sig, &si, p);
> +			} else
> +				send_sig(sig, p, 1);
>  			break;
> =20
>  		case LO_SIGGRP_REQ:
> @@ -1235,6 +1251,13 @@ void xnshadow_relax(int notify)
>  		/* Help debugging spurious relaxes. */
>  		send_sig(SIGXCPU, current, 1);
> =20
> +	if (xnthread_test_info(thread, XNPRIOSET)) {
> +		xnthread_clear_info(thread, XNPRIOSET);
> +		xnshadow_send_sig(thread, SIGSHADOW,
> +				  sigshadow_int(SIGSHADOW_ACTION_RENICE, prio),
> +				  1);
> +	}
> +
>  #ifdef CONFIG_SMP
>  	/* If the shadow thread changed its CPU affinity while in
>  	   primary mode, reset the CPU affinity of its Linux
> @@ -1485,13 +1508,13 @@ void xnshadow_start(xnthread_t *thread)
>  void xnshadow_renice(xnthread_t *thread)
>  {
>  	/* Called with nklock locked, Xenomai interrupts off. */

I think this comment line should be pushed in front of the function at
this chance.

> -	struct task_struct *p =3D xnthread_archtcb(thread)->user_task;
> -
>  	/* We need to bound the priority values in the [1..MAX_RT_PRIO-1]
>  	   range, since the core pod's priority scale is a superset of
>  	   Linux's priority scale. */
>  	int prio =3D normalize_priority(xnthread_current_priority(thread));
> -	schedule_linux_call(LO_RENICE_REQ, p, prio);
> +
> +	xnshadow_send_sig(thread, SIGSHADOW,
> +			  sigshadow_int(SIGSHADOW_ACTION_RENICE, prio), 1);
> =20
>  	if (!xnthread_test_state(thread, XNDORMANT) &&
>  	    xnthread_sched(thread) =3D=3D xnpod_current_sched())
> @@ -1501,8 +1524,7 @@ void xnshadow_renice(xnthread_t *thread)
>  void xnshadow_suspend(xnthread_t *thread)
>  {
>  	/* Called with nklock locked, Xenomai interrupts off. */
> -	struct task_struct *p =3D xnthread_archtcb(thread)->user_task;
> -	schedule_linux_call(LO_SIGTHR_REQ, p, SIGHARDEN);
> +	xnshadow_send_sig(thread, SIGSHADOW, SIGSHADOW_ACTION_HARDEN, 1);
>  }
> =20
>  static int xnshadow_sys_migrate(struct pt_regs *regs)
> @@ -1513,7 +1535,7 @@ static int xnshadow_sys_migrate(struct p
>  				return -EPERM;
> =20
>  			/* Paranoid: a corner case where the
> -			   user-space side fiddles with SIGHARDEN
> +			   user-space side fiddles with SIGSHADOW
>  			   while the target thread is still waiting to
>  			   be started. */
>  			if (xnthread_test_state(xnshadow_thread(current), XNDORMANT))
> @@ -1979,10 +2001,11 @@ static inline int substitute_linux_sysca
>  	return 0;
>  }
> =20
> -void xnshadow_send_sig(xnthread_t *thread, int sig, int specific)
> +void xnshadow_send_sig(xnthread_t *thread, int sig, int arg, int speci=
fic)
>  {
>  	schedule_linux_call(specific ? LO_SIGTHR_REQ : LO_SIGGRP_REQ,
> -			    xnthread_user_task(thread), sig);
> +			    xnthread_user_task(thread),
> +			    xnshadow_sig_mux(sig, specific ? arg : 0));
>  }
> =20
>  static inline int do_hisyscall_event(unsigned event, unsigned domid, v=
oid *data)
> Index: ksrc/nucleus/synch.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- ksrc/nucleus/synch.c	(revision 4218)
> +++ ksrc/nucleus/synch.c	(working copy)
> @@ -121,6 +121,8 @@ static void xnsynch_renice_thread(xnthre
>  #ifdef CONFIG_XENO_OPT_PERVASIVE
>  	if (xnthread_test_state(thread, XNRELAX))
>  		xnshadow_renice(thread);
> +	else if (xnthread_test_state(thread, XNSHADOW))
> +		xnthread_set_info(thread, XNPRIOSET);
>  #endif /* CONFIG_XENO_OPT_PERVASIVE */
>  }
> =20
> Index: ksrc/nucleus/pod.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- ksrc/nucleus/pod.c	(revision 4218)
> +++ ksrc/nucleus/pod.c	(working copy)
> @@ -1162,7 +1162,7 @@ void xnpod_delete_thread(xnthread_t *thr
>  	    !xnthread_test_state(thread, XNDORMANT) &&
>  	    !xnpod_current_p(thread)) {
>  		if (!xnpod_userspace_p())
> -			xnshadow_send_sig(thread, SIGKILL, 1);
> +			xnshadow_send_sig(thread, SIGKILL, 0, 1);
>  		/*
>  		 * Otherwise, assume the interface library has issued
>  		 * pthread_cancel on the target thread, which should
> @@ -1456,7 +1456,7 @@ void xnpod_suspend_thread(xnthread_t *th
>  	   is actually running some code under the control of the
>  	   Linux scheduler (i.e. it's relaxed).  To make this
>  	   possible, we force the target Linux task to migrate back to
> -	   the Xenomai domain by sending it a SIGHARDEN signal the
> +	   the Xenomai domain by sending it a SIGSHADOW signal the
>  	   skin interface libraries trap for this specific internal
>  	   purpose, whose handler is expected to call back the
>  	   nucleus's migration service. By forcing this migration, we
> @@ -1821,8 +1821,12 @@ void xnpod_renice_thread_inner(xnthread_
>  			xnpod_resume_thread(thread, 0);
>  	}
>  #ifdef CONFIG_XENO_OPT_PERVASIVE
> -	if (propagate && xnthread_test_state(thread, XNRELAX))
> -		xnshadow_renice(thread);
> +	if (propagate) {
> +		if (xnthread_test_state(thread, XNRELAX))
> +			xnshadow_renice(thread);
> +		else if (xnthread_test_state(thread, XNSHADOW))
> +			xnthread_set_info(thread, XNPRIOSET);
> +	}
>  #endif /* CONFIG_XENO_OPT_PERVASIVE */
> =20
>  	xnlock_put_irqrestore(&nklock, s);
> Index: include/asm-generic/bits/sigshadow.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- include/asm-generic/bits/sigshadow.h	(revision 0)
> +++ include/asm-generic/bits/sigshadow.h	(revision 0)
> @@ -0,0 +1,72 @@
> +#ifndef _XENO_ASM_GENERIC_BITS_SIGSHADOW_H
> +#define _XENO_ASM_GENERIC_BITS_SIGSHADOW_H
> +
> +#include <pthread.h>
> +#include <signal.h>
> +
> +static pthread_once_t sigshadow_installed =3D PTHREAD_ONCE_INIT;
> +static struct sigaction old_sigshadow_action;
> +
> +static void sigshadow_handler(int sig, siginfo_t *si, void *ctxt)
> +{
> +	int action;
> +
> +	/* Not a signal sent by Xenomai nucleus */
> +	if (si->si_code !=3D SI_QUEUE) {
> +		const struct sigaction *const sa =3D &old_sigshadow_action;
> +		sigset_t old_sigset;
> +
> +	  not_nucleus:
> +		if ((!(sa->sa_flags & SA_SIGINFO) && !sa->sa_handler)
> +		    || ((sa->sa_flags & SA_SIGINFO) && !sa->sa_sigaction))
> +			return;
> +
> +		pthread_sigmask(SIG_SETMASK, &sa->sa_mask, &old_sigset);
> +		if (!(sa->sa_flags & SA_SIGINFO))
> +			sa->sa_handler(sig);
> +		else
> +			sa->sa_sigaction(sig, si, ctxt);
> +		pthread_sigmask(SIG_SETMASK, &old_sigset, NULL);
> +		return;
> +	}
> +
> +	action =3D sigshadow_action(si->si_int);
> +
> +	switch(action) {
> +	case SIGSHADOW_ACTION_HARDEN:
> +		XENOMAI_SYSCALL1(__xn_sys_migrate, XENOMAI_XENO_DOMAIN);
> +		break;
> +
> +	case SIGSHADOW_ACTION_RENICE: {
> +		struct sched_param param;
> +		int policy;
> +
> +		param.sched_priority =3D sigshadow_prio(si->si_int);
> +		policy =3D param.sched_priority > 0 ? SCHED_FIFO: SCHED_OTHER;
> +		pthread_setschedparam(pthread_self(), policy, &param);
> +		break;
> +	}
> +
> +	default:
> +		goto not_nucleus;
> +	}
> +}
> +
> +static void sigshadow_install_once(void)
> +{
> +	struct sigaction new_sigshadow_action;
> +
> +	new_sigshadow_action.sa_flags =3D SA_SIGINFO | SA_RESTART;
> +	new_sigshadow_action.sa_sigaction =3D sigshadow_handler;
> +	sigemptyset(&new_sigshadow_action.sa_mask);
> +
> +	sigaction(SIGSHADOW, &new_sigshadow_action, &old_sigshadow_action);
> +	if (!(old_sigshadow_action.sa_flags & SA_NODEFER))
> +		sigaddset(&old_sigshadow_action.sa_mask, SIGSHADOW);
> +}
> +
> +static inline void sigshadow_install(void)
> +{
> +	pthread_once(&sigshadow_installed, sigshadow_install_once);
> +}
> +#endif /* _XENO_ASM_GENERIC_BITS_SIGSHADOW_H */

I wonder if we shouldn't switch the signal hooking strategy: So far we
install the handler at shadow thread creation time, saving a potentially
installed handler of the application for redirection of
Xenomai-unrelated events. But that only works if the application
installed the handler before it creates the first shadow thread, right?
If the app decides to install/change the SIGWINCH handler later on
(without taking care of our handler), we will loose.

Suggestion: As this is fragile and cannot be solved transparently, lets
document this signal requirement of Xenomai, e.g. in all task/thread
creation functions of the skins. Tell the user that Xenomai will install
a custom SIGWINCH handler and that, if the app wants to override it, it
has to make sure to _first_ call into a Xenomai-provided handler and
check if that one wants to handle the event. I'm thinking of something
like int xeno_sigwinch_handler(int sig, siginfo_t *si, void *ctxt),
where the return code is non-zero in case the signal was processed.

With this policy in place, we can switch the signal handler installation
above to __attribute__ ((construtor)) and save us all the changes
regarding sigshadow_install below.

> Index: src/skins/posix/thread.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- src/skins/posix/thread.c	(revision 4218)
> +++ src/skins/posix/thread.c	(working copy)
> @@ -26,23 +26,13 @@
>  #include <semaphore.h>
>  #include <posix/syscall.h>
>  #include <asm-generic/bits/current.h>
> +#include <asm-generic/bits/sigshadow.h>
> =20
>  extern int __pse51_muxid;
> =20
>  static pthread_attr_t default_attr;
>  static int linuxthreads;
> =20
> -static void (*old_sigharden_handler)(int sig);
> -
> -static void __pthread_sigharden_handler(int sig)
> -{
> -	if (old_sigharden_handler &&
> -	    old_sigharden_handler !=3D &__pthread_sigharden_handler)
> -		old_sigharden_handler(sig);
> -
> -	XENOMAI_SYSCALL1(__xn_sys_migrate, XENOMAI_XENO_DOMAIN);
> -}
> -
>  int __wrap_pthread_setschedparam(pthread_t thread,
>  				 int policy, const struct sched_param *param)
>  {
> @@ -59,7 +49,7 @@ int __wrap_pthread_setschedparam(pthread
>  		__real_pthread_setschedparam(thread, policy, param);
> =20
>  	if (!err && promoted) {
> -		old_sigharden_handler =3D signal(SIGHARDEN, &__pthread_sigharden_han=
dler);
> +		sigshadow_install();
>  		xeno_set_current();
>  		if (policy !=3D SCHED_OTHER)
>  			XENOMAI_SYSCALL1(__xn_sys_migrate, XENOMAI_XENO_DOMAIN);
> @@ -118,7 +108,7 @@ static void *__pthread_trampoline(void *
>  	int parent_prio, policy;
>  	long err;
> =20
> -	old_sigharden_handler =3D signal(SIGHARDEN, &__pthread_sigharden_hand=
ler);
> +	sigshadow_install();
> =20
>  	param.sched_priority =3D iargs->prio;
>  	policy =3D iargs->policy;
> Index: src/skins/native/task.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- src/skins/native/task.c	(revision 4218)
> +++ src/skins/native/task.c	(working copy)
> @@ -26,6 +26,7 @@
>  #include <limits.h>
>  #include <native/syscall.h>
>  #include <native/task.h>
> +#include <asm-generic/bits/sigshadow.h>
>  #include "wrappers.h"
> =20
>  extern pthread_key_t __native_tskey;
> @@ -42,17 +43,6 @@ struct rt_task_iargs {
>  	xncompletion_t *completionp;
>  };
> =20
> -static void (*old_sigharden_handler)(int sig);
> -
> -static void rt_task_sigharden(int sig)
> -{
> -	if (old_sigharden_handler &&
> -	    old_sigharden_handler !=3D &rt_task_sigharden)
> -		old_sigharden_handler(sig);
> -
> -	XENOMAI_SYSCALL1(__xn_sys_migrate, XENOMAI_XENO_DOMAIN);
> -}
> -
>  static void *rt_task_trampoline(void *cookie)
>  {
>  	struct rt_task_iargs *iargs =3D (struct rt_task_iargs *)cookie;
> @@ -74,7 +64,7 @@ static void *rt_task_trampoline(void *co
>  	/* rt_task_delete requires asynchronous cancellation */
>  	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
> =20
> -	old_sigharden_handler =3D signal(SIGHARDEN, &rt_task_sigharden);
> +	sigshadow_install();
> =20
>  	bulk.a1 =3D (u_long)iargs->task;
>  	bulk.a2 =3D (u_long)iargs->name;
> @@ -175,8 +165,7 @@ int rt_task_shadow(RT_TASK *task, const=20
> =20
>  	/* rt_task_delete requires asynchronous cancellation */
>  	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
> -
> -	old_sigharden_handler =3D signal(SIGHARDEN, &rt_task_sigharden);
> +	sigshadow_install();
> =20
>  	if (prio > 0) {
>  		/* Make sure the POSIX library caches the right priority. */
> Index: src/skins/vxworks/taskLib.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- src/skins/vxworks/taskLib.c	(revision 4218)
> +++ src/skins/vxworks/taskLib.c	(working copy)
> @@ -27,6 +27,7 @@
>  #include <errno.h>
>  #include <limits.h>
>  #include <vxworks/vxworks.h>
> +#include <asm-generic/bits/sigshadow.h>
>  #include "wrappers.h"
> =20
>  extern pthread_key_t __vxworks_tskey;
> @@ -54,17 +55,6 @@ struct wind_task_iargs {
>  	xncompletion_t *completionp;
>  };
> =20
> -static void (*old_sigharden_handler)(int sig);
> -
> -static void wind_task_sigharden(int sig)
> -{
> -	if (old_sigharden_handler &&
> -	    old_sigharden_handler !=3D &wind_task_sigharden)
> -		old_sigharden_handler(sig);
> -
> -	XENOMAI_SYSCALL1(__xn_sys_migrate, XENOMAI_XENO_DOMAIN);
> -}
> -
>  static int wind_task_set_posix_priority(int prio, struct sched_param *=
param)
>  {
>  	int maxpprio, pprio;
> @@ -103,8 +93,7 @@ static void *wind_task_trampoline(void *
> =20
>  	/* wind_task_delete requires asynchronous cancellation */
>  	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
> -
> -	old_sigharden_handler =3D signal(SIGHARDEN, &wind_task_sigharden);
> +	sigshadow_install();
> =20
>  	bulk.a1 =3D (u_long)iargs->name;
>  	bulk.a2 =3D (u_long)iargs->prio;
> Index: src/skins/psos+/task.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- src/skins/psos+/task.c	(revision 4218)
> +++ src/skins/psos+/task.c	(working copy)
> @@ -26,6 +26,7 @@
>  #include <memory.h>
>  #include <string.h>
>  #include <psos+/psos.h>
> +#include <asm-generic/bits/sigshadow.h>
> =20
>  extern int __psos_muxid;
> =20
> @@ -38,17 +39,6 @@ struct psos_task_iargs {
>  	xncompletion_t *completionp;
>  };
> =20
> -static void (*old_sigharden_handler)(int sig);
> -
> -static void psos_task_sigharden(int sig)
> -{
> -	if (old_sigharden_handler &&
> -	    old_sigharden_handler !=3D &psos_task_sigharden)
> -		old_sigharden_handler(sig);
> -
> -	XENOMAI_SYSCALL1(__xn_sys_migrate, XENOMAI_XENO_DOMAIN);
> -}
> -
>  static int psos_task_set_posix_priority(int prio, struct sched_param *=
param)
>  {
>  	int maxpprio, pprio;
> @@ -79,8 +69,7 @@ static void *psos_task_trampoline(void *
>  	pthread_setschedparam(pthread_self(), policy, &param);
> =20
>  	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
> -
> -	old_sigharden_handler =3D signal(SIGHARDEN, &psos_task_sigharden);
> +	sigshadow_install();
> =20
>  	err =3D XENOMAI_SKINCALL5(__psos_muxid,
>  				__psos_t_create,
> @@ -174,8 +163,7 @@ u_long t_shadow(const char *name, /* Xen
>  		u_long *tid_r)
>  {
>  	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
> -
> -	old_sigharden_handler =3D signal(SIGHARDEN, &psos_task_sigharden);
> +	sigshadow_install();
> =20
>  	return XENOMAI_SKINCALL5(__psos_muxid,
>  				 __psos_t_create,
> Index: src/skins/vrtx/task.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- src/skins/vrtx/task.c	(revision 4218)
> +++ src/skins/vrtx/task.c	(working copy)
> @@ -27,6 +27,7 @@
>  #include <errno.h>
>  #include <limits.h>
>  #include <vrtx/vrtx.h>
> +#include <asm-generic/bits/sigshadow.h>
> =20
>  extern pthread_key_t __vrtx_tskey;
> =20
> @@ -44,17 +45,6 @@ struct vrtx_task_iargs {
>  	xncompletion_t *completionp;
>  };
> =20
> -static void (*old_sigharden_handler)(int sig);
> -
> -static void vrtx_task_sigharden(int sig)
> -{
> -	if (old_sigharden_handler &&
> -	    old_sigharden_handler !=3D &vrtx_task_sigharden)
> -		old_sigharden_handler(sig);
> -
> -	XENOMAI_SYSCALL1(__xn_sys_migrate, XENOMAI_XENO_DOMAIN);
> -}
> -
>  static int vrtx_task_set_posix_priority(int prio, struct sched_param *=
param)
>  {
>  	int maxpprio, pprio;
> @@ -93,8 +83,7 @@ static void *vrtx_task_trampoline(void *
> =20
>  	/* vrtx_task_delete requires asynchronous cancellation */
>  	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
> -
> -	old_sigharden_handler =3D signal(SIGHARDEN, &vrtx_task_sigharden);
> +	sigshadow_install();
> =20
>  	bulk.a1 =3D (u_long)iargs->tid;
>  	bulk.a2 =3D (u_long)iargs->prio;
> Index: src/skins/uitron/task.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- src/skins/uitron/task.c	(revision 4218)
> +++ src/skins/uitron/task.c	(working copy)
> @@ -24,6 +24,7 @@
>  #include <errno.h>
>  #include <limits.h>
>  #include <asm/xenomai/system.h>
> +#include <asm-generic/bits/sigshadow.h>
>  #include <uitron/uitron.h>
> =20
>  extern int __uitron_muxid;
> @@ -35,17 +36,6 @@ struct uitron_task_iargs {
>  	xncompletion_t *completionp;
>  };
> =20
> -static void (*old_sigharden_handler)(int sig);
> -
> -static void uitron_task_sigharden(int sig)
> -{
> -	if (old_sigharden_handler &&
> -	    old_sigharden_handler !=3D &uitron_task_sigharden)
> -		old_sigharden_handler(sig);
> -
> -	XENOMAI_SYSCALL1(__xn_sys_migrate, XENOMAI_XENO_DOMAIN);
> -}
> -
>  static int uitron_task_set_posix_priority(int prio, struct sched_param=
 *param)
>  {
>  	int maxpprio, pprio;
> @@ -80,7 +70,7 @@ static void *uitron_task_trampoline(void
>  	pthread_setschedparam(pthread_self(), policy, &param);
> =20
>  	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
> -	old_sigharden_handler =3D signal(SIGHARDEN, &uitron_task_sigharden);
> +	sigshadow_install();
> =20
>  	err =3D XENOMAI_SKINCALL3(__uitron_muxid,
>  				__uitron_cre_tsk,
> @@ -157,8 +147,7 @@ ER shd_tsk(ID tskid, T_CTSK *pk_ctsk) /*
>  	pthread_setschedparam(pthread_self(), policy, &param);
> =20
>  	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
> -
> -	old_sigharden_handler =3D signal(SIGHARDEN, &uitron_task_sigharden);
> +	sigshadow_install();
> =20
>  	return XENOMAI_SKINCALL3(__uitron_muxid,
>  				 __uitron_cre_tsk,
>=20

One question currently remains open for me, both regarding your approach
as well as my suggestion: What happens if some app links against more
than onw skin library? I think your approach will cause multiple
sigshadow_handler invocations (as the stack up due to library-local
pthread_once), while mine suffers from multiple xeno_sigwinch_handler
symbols. The latter might be solvable with __attribute__ ((weak)), correc=
t?

Jan


--------------enigE5A95E496AF4BACCCD9FC63C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkj7FbAACgkQniDOoMHTA+mTVwCfUleUWcGlQ5vu5gKqUaTbRg6I
IDoAn0MQWK2q7Z/sUYl6g1iI37qjJn9E
=6srF
-----END PGP SIGNATURE-----

--------------enigE5A95E496AF4BACCCD9FC63C--

