Subject: Re: [Xenomai-core] [PATCH] provide ipipe_traceing via
	nucleus	interface
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <449BB3EA.70807@domain.hid>
References: <449A76D0.30800@domain.hid> <1151046221.4438.16.camel@domain.hid>
	<449BB3EA.70807@domain.hid>
Content-Type: text/plain
Date: Fri, 23 Jun 2006 11:44:50 +0200
Message-Id: <1151055890.4438.36.camel@domain.hid>
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

On Fri, 2006-06-23 at 11:27 +0200, Jan Kiszka wrote:
> >> Index: include/nucleus/ipipe_trace.h
> >> ===================================================================
> > 
> > This file should go to include/asm-generic/ since it depends on the
> > underlying real-time enabler (i.e. I-pipe). This way, there would be
> > no need to check for __XENO_SIM__.
> 
> Ok, but how is the user supposed to include the API then? Or can we drag
> it in implicitly somehow? That would be even nicer I think.
> 

asm-generic/trace.h would be dragged in by include/asm-<arch>/hal.h, so
that we get the proper double dependancy on both the architecture if it
does provide the tracing feature, and also on the HAL which in turn
requires the I-pipe.

> > 
> >> --- include/nucleus/ipipe_trace.h	(Revision 0)
> >> +++ include/nucleus/ipipe_trace.h	(Revision 0)
> >> @@ -0,0 +1,82 @@
> >> +/*
> >> Index: src/testsuite/latency/latency.c
> >> ===================================================================
> >> --- src/testsuite/latency/latency.c	(Revision 1252)
> >> +++ src/testsuite/latency/latency.c	(Arbeitskopie)
> >> @@ -12,6 +12,7 @@
> >>  #include <native/timer.h>
> >>  #include <native/sem.h>
> >>  #include <rtdm/rttesting.h>
> >> +#include <nucleus/ipipe_trace.h>
> >>  
> >>  RT_TASK latency_task, display_task;
> >>  
> >> @@ -130,8 +131,7 @@ void latency (void *cookie)
> >>  
> >>              if (freeze_max && (dt > gmaxjitter) && !(finished ||
> > warmup))
> >>                  {
> >> -                rt_dev_ioctl(benchdev, RTBNCH_RTIOC_REFREEZE_TRACE,
> >> -                             rt_timer_tsc2ns(dt));
> >> +                ipipe_trace_refreeze(rt_timer_tsc2ns(dt));
> > 
> > I don't like the idea of spreading ipipe-something symbols and
> > dependancies all over the entire source code including the generic one,
> > especially when considering that at some point, we are going to have
> > preempt-rt as the other possible real-time enabler, like
> > Adeos is already used now. We should use something more generic.
> > "tracer*" would be ok, I guess.
> > 
> 
> I'm going to rescan Ingo's API to define a common interface where
> feasible (their own user space API seems to hide behind gettimeofday).

Thanks. We should definitely consider the underlying the real-time
enabling technology Xenomai uses to run skins over as an interchangeable
component.

-- 
Philippe.



