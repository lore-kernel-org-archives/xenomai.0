Subject: Re: [Xenomai-core] [PATCH] provide ipipe_traceing via nucleus
	interface
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <449A76D0.30800@domain.hid>
References: <449A76D0.30800@domain.hid>
Content-Type: text/plain
Date: Fri, 23 Jun 2006 09:03:41 +0200
Message-Id: <1151046221.4438.16.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Thu, 2006-06-22 at 12:54 +0200, Jan Kiszka wrote:
> Hi,
> 
> having to load xeno_timerbench and to open its device just for
> triggering the I-pipe tracer was not a smart decision of mine. This
> patch makes is more comfortable to call the tracer from user space.

> Index: include/asm-generic/syscall.h
> ===================================================================
> --- include/asm-generic/syscall.h	(Revision 1252)
> +++ include/asm-generic/syscall.h	(Arbeitskopie)
> @@ -30,6 +30,13 @@
>  #define __xn_sys_info       4	/* xnshadow_get_info(muxid,&info) */
>  #define __xn_sys_arch       5	/* r = xnarch_local_syscall(args) */
>  
> +#define __xn_sys_trace_begin    6   /* ipipe_trace_begin(v) */
> +#define __xn_sys_trace_end      7   /* ipipe_trace_end(v) */
> +#define __xn_sys_trace_freeze   8   /* ipipe_trace_freeze(v) */
> +#define __xn_sys_trace_specl    9   /*
ipipe_trace_special(special_id, v) */
> +#define __xn_sys_trace_mreset   10  /* ipipe_trace_max_reset() */
> +#define __xn_sys_trace_freset   11  /* ipipe_trace_frozen_reset() */
> +

Ok for providing a tracer syscall from the nucleus table, but let's
not pollute the namespace uselessly. We could just have a single
tracer entry point, using the first arg as a function code for begin,
end, freeze etc. Given that those ops are not on the fast path, there
is nothing to gain in having them as separate calls. See __xn_sys_arch
for ARM.

>  
> Index: include/nucleus/ipipe_trace.h
> ===================================================================

This file should go to include/asm-generic/ since it depends on the
underlying real-time enabler (i.e. I-pipe). This way, there would be
no need to check for __XENO_SIM__.

> --- include/nucleus/ipipe_trace.h	(Revision 0)
> +++ include/nucleus/ipipe_trace.h	(Revision 0)
> @@ -0,0 +1,82 @@
> +/*
> Index: src/testsuite/latency/latency.c
> ===================================================================
> --- src/testsuite/latency/latency.c	(Revision 1252)
> +++ src/testsuite/latency/latency.c	(Arbeitskopie)
> @@ -12,6 +12,7 @@
>  #include <native/timer.h>
>  #include <native/sem.h>
>  #include <rtdm/rttesting.h>
> +#include <nucleus/ipipe_trace.h>
>  
>  RT_TASK latency_task, display_task;
>  
> @@ -130,8 +131,7 @@ void latency (void *cookie)
>  
>              if (freeze_max && (dt > gmaxjitter) && !(finished ||
warmup))
>                  {
> -                rt_dev_ioctl(benchdev, RTBNCH_RTIOC_REFREEZE_TRACE,
> -                             rt_timer_tsc2ns(dt));
> +                ipipe_trace_refreeze(rt_timer_tsc2ns(dt));

I don't like the idea of spreading ipipe-something symbols and
dependancies all over the entire source code including the generic one,
especially when considering that at some point, we are going to have
preempt-rt as the other possible real-time enabler, like
Adeos is already used now. We should use something more generic.
"tracer*" would be ok, I guess.

-- 
Philippe.



