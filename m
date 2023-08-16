Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82A0101E6
	for <xenomai@lists.linux.dev>; Wed, 16 Aug 2023 11:24:37 +0000 (UTC)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202308161124348954bf04c4f4dc3b89
        for <xenomai@lists.linux.dev>;
        Wed, 16 Aug 2023 13:24:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=SIrMnsCKXrUhzaRGnVmy5VoZ7O9TmNFE9sS601PwjDg=;
 b=cy4OxkO6o5od9nU3oXocNaVUIkr+zh6bIPT/jZWV9BuHTIzJcHVDIVhxfh8xmLb76fYuwN
 TF28gvx+0Sorkxrn7b90eyKKeqQsUK/G+nwwFjmIowB3YlPOpYo+vi9UEfaeY+/IBKJxD3Db
 1h7sv9Z1+DpT5tzadXDR72t7gqTAk=;
Message-ID: <d5e43ccdceba5f28de7798c0826318e1bbcfc1d4.camel@siemens.com>
Subject: Re: [PATCH 1/3] [POC] test implementaion of rt-signals
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>, 
	xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Date: Wed, 16 Aug 2023 13:24:28 +0200
In-Reply-To: <20230816101842.3377643-1-johannes.kirchmair@sigmatek.at>
References: <20230816101842.3377643-1-johannes.kirchmair@sigmatek.at>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

On Wed, 2023-08-16 at 12:18 +0200, Johannes Kirchmair wrote:
> We implement rt signals to handle exceptions in rt stage.
>=20
> This is done using dovetail specific functions for setting up the signal
> frame.
>=20
> This can be used to handle fpe exceptions on the fly, like fixing
> division by zero. An other use case are breakpoints, implemented using th=
e
> illegal opcode exception. The real time handling of the breakpoints would
> be handy for conditional breakpoints or also for stopping watchdogs and
> other tasks in time.
>=20
> Signed-off-by: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
> ---
>  include/cobalt/kernel/ppd.h                   |  3 +
>  include/cobalt/kernel/thread.h                |  2 +
>  include/cobalt/signal.h                       |  2 +
>  include/cobalt/uapi/signal.h                  |  1 +
>  include/cobalt/uapi/syscall.h                 |  6 ++
>  kernel/cobalt/arch/x86/Makefile               |  2 +-
>  .../arch/x86/include/asm/xenomai/thread.h     | 13 ++++
>  kernel/cobalt/arch/x86/signal_ia32.c          | 75 +++++++++++++++++++
>  kernel/cobalt/arch/x86/signal_ia64.c          | 37 +++++++++
>  kernel/cobalt/dovetail/kevents.c              |  5 ++
>  kernel/cobalt/posix/process.c                 |  3 +-
>  kernel/cobalt/posix/syscall.c                 | 28 +++++++
>  kernel/cobalt/posix/syscall32.c               | 16 ++++
>  kernel/cobalt/thread.c                        | 39 ++++++++++
>  lib/cobalt/arch/x86/Makefile.am               |  2 +-
>  lib/cobalt/arch/x86/sigreturn.c               | 36 +++++++++
>  lib/cobalt/internal.h                         |  2 +
>  lib/cobalt/signal.c                           | 13 ++++
>  18 files changed, 282 insertions(+), 3 deletions(-)
>  create mode 100644 kernel/cobalt/arch/x86/signal_ia32.c
>  create mode 100644 kernel/cobalt/arch/x86/signal_ia64.c
>  create mode 100644 lib/cobalt/arch/x86/sigreturn.c
>=20
> diff --git a/include/cobalt/kernel/ppd.h b/include/cobalt/kernel/ppd.h
> index f0079fe6e..fb2f682da 100644
> --- a/include/cobalt/kernel/ppd.h
> +++ b/include/cobalt/kernel/ppd.h
> @@ -22,6 +22,7 @@
>  #include <linux/types.h>
>  #include <linux/atomic.h>
>  #include <linux/rbtree.h>
> +#include <linux/signal.h>
>  #include <cobalt/kernel/heap.h>
> =20
>  struct cobalt_umm {
> @@ -32,6 +33,8 @@ struct cobalt_umm {
> =20
>  struct cobalt_ppd {
>  	struct cobalt_umm umm;
> +	void __user *sighand[_NSIG];
> +	void __user *sigrestorer;
>  	atomic_t refcnt;
>  	char *exe_path;
>  	struct rb_root fds;
> diff --git a/include/cobalt/kernel/thread.h b/include/cobalt/kernel/threa=
d.h
> index b79cb8429..33d468419 100644
> --- a/include/cobalt/kernel/thread.h
> +++ b/include/cobalt/kernel/thread.h
> @@ -574,6 +574,8 @@ static inline void xnthread_propagate_schedparam(stru=
ct xnthread *curr)
>  		__xnthread_propagate_schedparam(curr);
>  }
> =20
> +int xnthread_handle_rt_signals(unsigned int trapnr, struct pt_regs *regs=
);
> +
>  extern struct xnthread_personality xenomai_personality;
> =20
>  /** @} */
> diff --git a/include/cobalt/signal.h b/include/cobalt/signal.h
> index 62694f93a..3d6540aff 100644
> --- a/include/cobalt/signal.h
> +++ b/include/cobalt/signal.h
> @@ -54,6 +54,8 @@ COBALT_DECL(int, kill(pid_t pid, int sig));
>  COBALT_DECL(int, sigqueue(pid_t pid, int sig,
>  			  const union sigval value));
> =20
> +int cobalt_rt_signal(int sig, void (*handler)(int, siginfo_t *, void *))=
;
> +
>  #ifdef __cplusplus
>  }
>  #endif
> diff --git a/include/cobalt/uapi/signal.h b/include/cobalt/uapi/signal.h
> index 8a7ea15a4..1afb6050a 100644
> --- a/include/cobalt/uapi/signal.h
> +++ b/include/cobalt/uapi/signal.h
> @@ -68,6 +68,7 @@
>  #define SIGDEBUG_RESCNT_IMBALANCE	7
>  #define SIGDEBUG_LOCK_BREAK		8
>  #define SIGDEBUG_MUTEX_SLEEP		9
> +#define SIGDEBUG_SIGRESTOR		10
> =20
>  #define COBALT_DELAYMAX			2147483647U
> =20
> diff --git a/include/cobalt/uapi/syscall.h b/include/cobalt/uapi/syscall.=
h
> index 3e65efaab..f14bd8ffe 100644
> --- a/include/cobalt/uapi/syscall.h
> +++ b/include/cobalt/uapi/syscall.h
> @@ -142,6 +142,12 @@
>  #define sc_cobalt_timerfd_gettime64		119
>  #define sc_cobalt_pselect64			120
> =20
> +/*
> + * Sigmatek specific syscalls
> + */

The goal would be to become generic so no longer=C2=A0
"sigmatek specific" ;-)

> +#define sc_cobalt_sigreturn			121
> +#define sc_cobalt_sigaction			122
> +
>  #define __NR_COBALT_SYSCALLS			128 /* Power of 2 */
> =20
>  #endif /* !_COBALT_UAPI_SYSCALL_H */
> diff --git a/kernel/cobalt/arch/x86/Makefile b/kernel/cobalt/arch/x86/Mak=
efile
> index 93929b645..e725afbff 100644
> --- a/kernel/cobalt/arch/x86/Makefile
> +++ b/kernel/cobalt/arch/x86/Makefile
> @@ -1,5 +1,5 @@
> =20
>  obj-$(CONFIG_XENOMAI) +=3D xenomai.o
> -xenomai-y :=3D machine.o smi.o c1e.o
> +xenomai-y :=3D machine.o smi.o c1e.o signal_ia32.o signal_ia64.o
> =20
>  ccflags-y :=3D -I$(srctree)/arch/x86/xenomai/include -I$(srctree)/includ=
e/xenomai
> diff --git a/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h b/kernel=
/cobalt/arch/x86/include/asm/xenomai/thread.h
> index 745c32467..4d004680b 100644
> --- a/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h
> +++ b/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h
> @@ -28,5 +28,18 @@
>  #define xnarch_fault_bp_p(__nr)		((current->ptrace & PT_PTRACED) &&	\
>  					 ((__nr) =3D=3D X86_TRAP_DB || (__nr) =3D=3D X86_TRAP_BP))
>  #define xnarch_fault_notify(__nr)	(!xnarch_fault_bp_p(__nr))
> +#define xnarch_fault_code(__regs)		((__regs)->orig_ax)
> +int xnarch_setup_trap_info(unsigned int vector, struct pt_regs *regs,
> +			   long errcode, int *sig, struct kernel_siginfo *info);
> +
> +int xnarch_setup_rt_frame_ia32(int sig, void *handler, struct kernel_sig=
info *si,
> +			  struct pt_regs *regs, void __user *restorer);
> +
> +int xnarch_rt_sigreturn_ia32(struct pt_regs *regs);
> +
> +int xnarch_setup_rt_frame_ia64(int sig, void *handler, struct kernel_sig=
info *si,
> +			  struct pt_regs *regs, void __user *restorer);
> +
> +int xnarch_rt_sigreturn_ia64(struct pt_regs *regs);
> =20
>  #endif /* !_COBALT_X86_ASM_THREAD_H */
> diff --git a/kernel/cobalt/arch/x86/signal_ia32.c b/kernel/cobalt/arch/x8=
6/signal_ia32.c
> new file mode 100644
> index 000000000..140016460
> --- /dev/null
> +++ b/kernel/cobalt/arch/x86/signal_ia32.c
> @@ -0,0 +1,75 @@
> +#include <linux/signal.h>
> +#include <linux/uaccess.h>
> +#include <cobalt/kernel/thread.h>
> +
> +#include <asm/sigframe.h>
> +#include <asm/sighandling.h>
> +#include <asm/fpu/signal.h>
> +
> +int xnarch_setup_trap_info(unsigned int vector, struct pt_regs *regs,
> +			   long errcode, int *sig, struct kernel_siginfo *info)
> +{
> +	switch (vector) {
> +	case 0: /* divide_error */

Can't we assign names to the possible values of vector? Can't we model
that as enum?

> +		*sig =3D SIGFPE;
> +		info->si_signo =3D *sig;
> +		info->si_errno =3D 0;
> +		info->si_code =3D FPE_INTDIV;
> +		info->si_addr =3D (void __user *)regs->ip;
> +		return 0;
> +	case 1: /* trap_error */ {
> +		unsigned long condition;
> +		get_debugreg(condition, 6);
> +		set_debugreg(0, 7);
> +		*sig =3D SIGTRAP;
> +		info->si_signo =3D *sig;
> +		info->si_errno =3D errcode;
> +		info->si_code =3D get_si_code(condition);
> +		info->si_addr =3D (void __user *)regs->ip;
> +		return 0;
> +	}
> +	case 3: /* trap_error */
> +		*sig =3D SIGTRAP;
> +		info->si_signo =3D *sig;
> +		info->si_errno =3D errcode;
> +		info->si_code =3D SI_KERNEL;
> +		info->si_addr =3D (void __user *)regs->ip;
> +		return 0;
> +	case 6: /* invalid_op */
> +		*sig =3D SIGILL;
> +		info->si_signo =3D *sig;
> +		info->si_errno =3D 0;
> +		info->si_code =3D ILL_ILLOPN;
> +		info->si_addr =3D (void __user *)regs->ip;
> +		return 0;
> +	case 16: { /* coprocessor_error */
> +		*sig =3D SIGFPE;
> +
> +		info->si_signo =3D *sig;
> +		info->si_errno =3D 0;
> +		info->si_code =3D 0;
> +		info->si_addr =3D (void __user *)regs->ip;
> +		return 0;
> +	}
> +	default:
> +		break;
> +	}
> +
> +	return -ENOSYS;
> +}
> +
> +int xnarch_rt_sigreturn_ia32(struct pt_regs *regs)
> +{
> +	int ret;
> +
> +	ret =3D dovetail_restore_rt_signal_frame(regs);
> +	if (ret < 0)
> +		goto badframe;
> +
> +	return regs->ax;
> +
> +badframe:
> +	xnthread_call_mayday(xnthread_current(), SIGDEBUG_SIGRESTOR);
> +	return -1;
> +}
> +
> diff --git a/kernel/cobalt/arch/x86/signal_ia64.c b/kernel/cobalt/arch/x8=
6/signal_ia64.c
> new file mode 100644
> index 000000000..3b8cd3330
> --- /dev/null
> +++ b/kernel/cobalt/arch/x86/signal_ia64.c
> @@ -0,0 +1,37 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *  Copyright (C) 1991, 1992  Linus Torvalds
> + *  Copyright (C) 2000, 2001, 2002 Andi Kleen SuSE Labs
> + *
> + *  1997-11-28  Modified for POSIX.1b signals by Richard Henderson
> + *  2000-06-20  Pentium III FXSR, SSE support by Gareth Hughes
> + *  2000-2002   x86-64 support by Andi Kleen
> + */

I think the copyright information is just wrong.

> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +
> +#include <linux/signal.h>
> +#include <linux/uaccess.h>
> +#include <cobalt/kernel/thread.h>
> +
> +#include <asm/sigframe.h>
> +#include <asm/sighandling.h>
> +#include <asm/fpu/signal.h>
> +
> +int xnarch_rt_sigreturn_ia64(struct pt_regs *regs)
> +{
> +	int ret;
> +
> +	ret =3D dovetail_restore_rt_signal_frame(regs);
> +	if (ret < 0)
> +		goto badframe;
> +
> +	return regs->ax;
> +
> +badframe:
> +	xnthread_call_mayday(xnthread_current(), SIGDEBUG_SIGRESTOR);
> +	return -1;
> +
> +}
> +
> diff --git a/kernel/cobalt/dovetail/kevents.c b/kernel/cobalt/dovetail/ke=
vents.c
> index 4da4f51b7..61417717b 100644
> --- a/kernel/cobalt/dovetail/kevents.c
> +++ b/kernel/cobalt/dovetail/kevents.c
> @@ -57,6 +57,9 @@ void handle_oob_trap_entry(unsigned int trapnr, struct =
pt_regs *regs)
>  		xnsched_run();
>  	}
> =20
> +	if (xnthread_handle_rt_signals(trapnr, regs) =3D=3D 0)
> +		return;
> +
>  	/*
>  	 * If we experienced a trap on behalf of a shadow thread
>  	 * running in primary mode, move it to the Linux domain,
> @@ -88,6 +91,8 @@ void handle_oob_trap_entry(unsigned int trapnr, struct =
pt_regs *regs)
>  		xnstat_counter_inc(&thread->stat.pf);
> =20
>  	xnthread_relax(xnarch_fault_notify(trapnr), SIGDEBUG_MIGRATE_FAULT);
> +
> +	return;
>  }
> =20
>  static inline int handle_setaffinity_event(struct dovetail_migration_dat=
a *d)
> diff --git a/kernel/cobalt/posix/process.c b/kernel/cobalt/posix/process.=
c
> index 1abc86f37..2069129cb 100644
> --- a/kernel/cobalt/posix/process.c
> +++ b/kernel/cobalt/posix/process.c
> @@ -738,9 +738,10 @@ void cobalt_unregister_debugged_thread(struct xnthre=
ad *thread)
>  		cobalt_resume_debugged_process(process);
>  }
> =20
> +#ifdef CONFIG_SMP
> +
>  int cobalt_handle_setaffinity_event(struct task_struct *task)
>  {
> -#ifdef CONFIG_SMP
>  	struct xnthread *thread;
>  	spl_t s;
> =20
> diff --git a/kernel/cobalt/posix/syscall.c b/kernel/cobalt/posix/syscall.=
c
> index 46c4998e4..b4bd4c587 100644
> --- a/kernel/cobalt/posix/syscall.c
> +++ b/kernel/cobalt/posix/syscall.c
> @@ -277,6 +277,34 @@ static COBALT_SYSCALL(serialdbg, current,
>  	return 0;
>  }
> =20
> +static COBALT_SYSCALL(sigreturn, current, (void))
> +{
> +	struct pt_regs *regs =3D task_pt_regs(current);
> +
> +	if (regs->cs =3D=3D __USER_CS)
> +		xnarch_rt_sigreturn_ia64(regs);
> +	if (regs->cs =3D=3D __USER32_CS)
> +		xnarch_rt_sigreturn_ia32(regs);
> +
> +	return __xn_reg_rval(regs);
> +}
> +
> +static COBALT_SYSCALL(sigaction, current, (int sig, void __user *handler=
,
> +		      void __user *restorer))
> +{
> +	struct cobalt_ppd *sys_ppd =3D cobalt_ppd_get(0);
> +
> +	if (sig < 0 || sig >=3D _NSIG)
> +		return -EINVAL;
> +
> +	sys_ppd->sighand[sig] =3D handler;
> +
> +	if (!sys_ppd->sigrestorer)
> +		sys_ppd->sigrestorer =3D restorer;

No error if sys_ppd->sighand[sig] or sys_ppd->sigrestorer is
overwritten?=C2=A0
Or the other way around: Why can only the handler be overwritten?

> +
> +	return 0;
> +}
> +
>  static void stringify_feature_set(unsigned long fset, char *buf, int siz=
e)
>  {
>  	unsigned long feature;
> diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscal=
l32.c
> index 780d276b1..7c858f904 100644
> --- a/kernel/cobalt/posix/syscall32.c
> +++ b/kernel/cobalt/posix/syscall32.c
> @@ -705,6 +705,22 @@ COBALT_SYSCALL32emu(sigqueue, conforming,
>  	return ret ?: __cobalt_sigqueue(pid, sig, &val);
>  }
> =20
> +COBALT_SYSCALL32emu(sigaction, current,
> +		    (int sig, void __user *handler, void __user *restorer))
> +{
> +	struct cobalt_ppd *sys_ppd =3D cobalt_ppd_get(0);
> +
> +	if (sig < 0 || sig >=3D _NSIG)
> +		return -EINVAL;
> +
> +	sys_ppd->sighand[sig] =3D handler;
> +
> +	if (!sys_ppd->sigrestorer)
> +		sys_ppd->sigrestorer =3D restorer;
> +
> +	return 0;
> +}
> +

You did not touch the syscall32-table.h (x86 specific), so I would
expect that your compat support is broken right now. You should end up
in the "native" so x86_64 implementation. That brings me to the next
question:

Can't we avoid a special compat case here? The pointers themselfs are
corrected by the syscall entry machinery but the memory pointed to is
not. So is the memory pointed to by handler and restorer different in
terms of memory layout/padding?

In addition you should update kernel/cobalt/trace/cobalt-posix.h to get
proper trace support.


>  COBALT_SYSCALL32emu(monitor_wait, nonrestartable,
>  		    (struct cobalt_monitor_shadow __user *u_mon,
>  		     int event, const struct old_timespec32 __user *u_ts,
> diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
> index 41804b24f..71f97c481 100644
> --- a/kernel/cobalt/thread.c
> +++ b/kernel/cobalt/thread.c
> @@ -25,6 +25,7 @@
>  #include <linux/signal.h>
>  #include <linux/pid.h>
>  #include <linux/sched.h>
> +#include <asm/sighandling.h>
>  #include <uapi/linux/sched/types.h>
>  #include <cobalt/kernel/sched.h>
>  #include <cobalt/kernel/timer.h>
> @@ -43,6 +44,7 @@
>  #include <pipeline/inband_work.h>
>  #include <pipeline/sched.h>
>  #include <trace/events/cobalt-core.h>
> +#include "posix/process.h"
>  #include "debug.h"
> =20
>  static DECLARE_WAIT_QUEUE_HEAD(join_all);
> @@ -2520,6 +2522,43 @@ int xnthread_killall(int grace, int mask)
>  }
>  EXPORT_SYMBOL_GPL(xnthread_killall);
> =20
> +int xnthread_handle_rt_signals(unsigned int trapnr, struct pt_regs *regs=
)
> +{
> +	struct ksignal ksig;
> +
> +	unsigned int vector =3D trapnr;
> +	unsigned int code =3D xnarch_fault_code(regs);
> +	struct cobalt_ppd *sys_ppd;
> +	int sig, ret =3D 0;
> +	struct kernel_siginfo si;

Style: Reverse christmas tree.

> +
> +	code =3D xnarch_fault_code(regs);
> +	ret =3D xnarch_setup_trap_info(vector, regs, code, &sig, &si);
> +	if (ret || sig =3D=3D 0)
> +		return 1;

Why not:

	if (ret)
		return ret;

	if (sig =3D=3D 0)
		return -EINVAL;

> +
> +	sys_ppd =3D cobalt_ppd_get(0);
> +	if (sig >=3D _NSIG ||
> +	    sys_ppd->sighand[sig] =3D=3D NULL ||
> +	    sys_ppd->sighand[sig] =3D=3D SIG_DFL)
> +		return 1;
> +
> +	if (sys_ppd->sigrestorer =3D=3D NULL)
> +		return 1;
> +
> +	ksig.sig =3D sig;
> +	memcpy(&ksig.info, &si, sizeof(si));
> +	ksig.ka.sa.sa_flags =3D SA_SIGINFO | SA_RESTORER;
> +	ksig.ka.sa.sa_restorer =3D sys_ppd->sigrestorer;
> +	ksig.ka.sa.sa_handler =3D sys_ppd->sighand[sig];
> +
> +	ret =3D dovetail_setup_rt_signal_frame(&ksig, regs);
> +	if (ret)
> +		return 1;

Applies here and on more locations: Why returning 1 instead of
reporting the underlying issue (return ret;) ?

> +
> +	return 0;
> +}
> +
>  /* Xenomai's generic personality. */
>  struct xnthread_personality xenomai_personality =3D {
>  	.name =3D "core",
> diff --git a/lib/cobalt/arch/x86/Makefile.am b/lib/cobalt/arch/x86/Makefi=
le.am
> index a5095be3d..14f5eff97 100644
> --- a/lib/cobalt/arch/x86/Makefile.am
> +++ b/lib/cobalt/arch/x86/Makefile.am
> @@ -2,7 +2,7 @@ noinst_LTLIBRARIES =3D libarch.la
> =20
>  libarch_la_LDFLAGS =3D @XENO_LIB_LDFLAGS@
> =20
> -libarch_la_SOURCES =3D features.c
> +libarch_la_SOURCES =3D features.c sigreturn.c
> =20
>  libarch_la_CPPFLAGS =3D			\
>  	@XENO_COBALT_CFLAGS@ 		\
> diff --git a/lib/cobalt/arch/x86/sigreturn.c b/lib/cobalt/arch/x86/sigret=
urn.c
> new file mode 100644
> index 000000000..df961469e
> --- /dev/null
> +++ b/lib/cobalt/arch/x86/sigreturn.c
> @@ -0,0 +1,36 @@
> +#include <cobalt/uapi/syscall.h>
> +#include "internal.h"
> +
> +extern void cobalt_sigreturn (void) asm ("__cobalt_sigreturn") __attribu=
te__ ((visibility ("hidden")));
> +
> +#define TO_STR(x) #x
> +
> +#ifdef __x86_64__
> +#define build_restorer(syscall_bit, syscall)                            =
       \
> +	asm(".text\n"                                                          =
\
> +	    "    .align 16\n"                                                  =
\
> +	    "__cobalt_sigreturn:\n"                                            =
\
> +	    "    movq $ " TO_STR(syscall_bit) ", %rax\n"                       =
\
> +	    "    orq $ " TO_STR(syscall) ", %rax\n"                            =
\
> +	    "    syscall")
> +#endif
> +
> +#ifdef __i386__
> +#define build_restorer(syscall_bit, syscall)                            =
       \
> +	asm(".text\n"                                                          =
\
> +	    "    .align 16\n"                                                  =
\
> +	    "__cobalt_sigreturn:\n"                                            =
\
> +	    "    movl $ " TO_STR(syscall_bit) ", %eax\n"                       =
\
> +	    "    orl $ " TO_STR(syscall) ", %eax\n"                            =
\
> +	    "    int  $0x80")
> +#endif
> +
> +/*
> + * __COBALT_SYSCALL_BIT | sc_cobalt_sigreturn
> + */
> +build_restorer(__COBALT_SYSCALL_BIT, sc_cobalt_sigreturn);

This looks like a partial bypass to the XENOMAI_SYSCALL() machinery. In
case we wan't to change the implementation of that interface (targeting
prctl usage) we would have to touch the rt signal interface as well...

> +
> +void *cobalt_get_restorer(void)
> +{
> +	return &cobalt_sigreturn;
> +}
> diff --git a/lib/cobalt/internal.h b/lib/cobalt/internal.h
> index acb3989f1..4782d154a 100644
> --- a/lib/cobalt/internal.h
> +++ b/lib/cobalt/internal.h
> @@ -132,4 +132,6 @@ static inline bool cobalt_features_available(unsigned=
 int feat_mask)
>  	return (cobalt_features & feat_mask) =3D=3D feat_mask;
>  }
> =20
> +extern void *cobalt_get_restorer(void);
> +
>  #endif /* _LIB_COBALT_INTERNAL_H */
> diff --git a/lib/cobalt/signal.c b/lib/cobalt/signal.c
> index 40d315ebb..af174d570 100644
> --- a/lib/cobalt/signal.c
> +++ b/lib/cobalt/signal.c
> @@ -126,3 +126,16 @@ COBALT_IMPL(int, sigqueue, (pid_t pid, int sig, cons=
t union sigval value))
> =20
>  	return 0;
>  }
> +
> +int cobalt_rt_signal(int sig, void (*handler)(int, siginfo_t *, void *))
> +{
> +	int ret;
> +
> +	ret =3D XENOMAI_SYSCALL3(sc_cobalt_sigaction, sig, handler, cobalt_get_=
restorer());
> +	if (ret) {
> +		errno =3D -ret;
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> --=20
> 2.25.1
>=20

