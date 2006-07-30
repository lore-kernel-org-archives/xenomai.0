Subject: Re: [Xenomai-help] Beginner's question / testsuite / latency
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <44CB6EB3.5070707@domain.hid>
References: <442248c90607201417m24729b7cs23a8b82b719ff1cc@domain.hid>
	<200607221152.34298.bidsonux@domain.hid> <44C25DB0.50601@domain.hid>
	<200607282317.34990.bidsonux@domain.hid>  <44CB6EB3.5070707@domain.hid>
Content-Type: text/plain
Date: Sun, 30 Jul 2006 20:03:39 +0200
Message-Id: <1154282619.4970.25.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

On Sat, 2006-07-29 at 16:20 +0200, Jan Kiszka wrote:
> >> :|func        6   xnintr_clock_handler (__ipipe_dispatch_wired)
> >> :|func        6   xnintr_irq_handler (xnintr_clock_handler)
> >> :|func        7   xnpod_announce_tick (xnintr_irq_handler)
> >> :|func        8+  xntimer_do_tick_aperiodic (xnpod_announce_tick)
> >> :|func        9   xnthread_periodic_handler (xntimer_do_tick_aperiodic)
> >> :|func       10   xnpod_resume_thread (xnthread_periodic_handler)
> >> :|[21559]    11+  xnpod_resume_thread (xnthread_periodic_handler)
> >> :|func       13+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
> 
> ...
> 
> >> :|func      363+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
> 
> That are a lot of overruns. Haven't counted, but it should be one
> xnthread_periodic_handler per missed 100 us period (20000 / 100 = 200!).
> [BTW, I think we should handle even this failure scenario without
> looping.

We need to loop in the aperiodic handler in order to catch timers that
could have elapsed while processing the current tick. However,
xnpod_wait_thread_period() - over which rt_task_wait_period() is based -
does not loop, but rather computes the actual count of overruns by
substracting the current time from the deadline.

Which brings us an interesting question: why does the aperiodic handler
loop frenetically in the first place? I would be pretty interested in
checking the TSC values returned by xnarch_get_cpu_tsc() while spinning
inside this deadly loop...

>  And there is another loop in xnpod_wait_thread_period.]

> >> :|func      369+  xnpod_schedule (xnintr_irq_handler)
> >> :|[ 3096]   370+  xnpod_schedule (xnintr_irq_handler)
> >> :|func      372+  __switch_to (xnpod_schedule)
> >> :|[21559]   374+  xnpod_schedule (xnpod_suspend_thread)
> >> :|func      375   __ipipe_restore_pipeline_head (xnpod_wait_thread_period)
> >> <|end       376   __ipipe_restore_pipeline_head (xnpod_wait_thread_period)
> >>  |begin     377   __ipipe_dispatch_event (__ipipe_syscall_root)
> >>
> 
> No final judgement yet, but it looks to me like your hardware doesn't
> want to play with us.
> 
> To exclude the possibility that the timer events get programmed wrongly
> as TSCs are skewed up, you could also try the irqbench test case. All
> you need is a nullmodem cable and a second PC with RS232 port, see
> doc/txt/irqbench.txt. And that test can also take back-traces.
> 
> Jan
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



