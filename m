From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <465030CD.8030906@domain.hid>
References: <465030CD.8030906@domain.hid>
Content-Type: text/plain
Date: Sun, 20 May 2007 15:37:29 +0200
Message-Id: <1179668250.473.21.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [PATCH] Refactor nucleus timer IRQ path
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

On Sun, 2007-05-20 at 13:28 +0200, Jan Kiszka wrote:
> The timer IRQ currently goes through a dedicated trampoline
> (xnintr_clock_handler), the generic xnintr_irq_handler which handles it
> via a special nkclock xnintr_t object, then xnpod_announce_tick, until
> it finally ends in xntimer_tick_aperiodic.
> 
> This patch refactors this path so that we now have only a specialised
> xnintr_clock_handler which incorporates all previously scattered steps.
> Furthermore, tick-specific handling is removed from xnintr_irq_handler
> and nkclock is now only required when statistic are generated. This
> refactoring results in a tiny, but measurable performance gain on i386,
> other archs with small caches may benefit more significantly.
> 

Ok, I like this, primarily because aside of saving a few cycles by being
I-cache friendly, it does express the fact that there is something
special about the timer interrupt, and conversely that not every IRQ
source might fit as a time source, e.g. wrt host tick relay and such.

I'm going to queue this for a later merge (before -rc1 though); please
people give this hell during this grace period.

> [Note that the patch also contains some LTT-related changes around the
> tick IRQ. They only serve as a reminder, the final LTTng marker
> format and the probe modules will look differently.]
> 
> Jan
> 
> 
> ---
>  include/nucleus/pod.h   |    2 -
>  ksrc/nucleus/intr.c     |   51 +++++++++++++++++++++++++++++++----------
>  ksrc/nucleus/ltt.c      |    4 +--
>  ksrc/nucleus/pod.c      |   59 ++++--------------------------------------------
>  ksrc/nucleus/timebase.c |    3 ++
>  5 files changed, 50 insertions(+), 69 deletions(-)
> 
> Index: xenomai/ksrc/nucleus/intr.c
> ===================================================================
> --- xenomai.orig/ksrc/nucleus/intr.c
> +++ xenomai/ksrc/nucleus/intr.c
> @@ -41,9 +41,8 @@
>  
>  DEFINE_PRIVATE_XNLOCK(intrlock);
>  
> -xnintr_t nkclock;
> -
>  #ifdef CONFIG_XENO_OPT_STATS
> +xnintr_t nkclock;	/* Only for statistics */
>  int xnintr_count = 1;	/* Number of attached xnintr objects + nkclock */
>  int xnintr_list_rev;	/* Modification counter of xnintr list */
>  
> @@ -113,6 +112,42 @@ static void xnintr_irq_handler(unsigned 
>  	if (--sched->inesting == 0 && xnsched_resched_p())
>  		xnpod_schedule();
>  
> +	xnltt_log_event(xeno_ev_iexit, irq);
> +	xnstat_runtime_switch(sched, prev);
> +}
> +
> +/* Low-level clock irq handler. */
> +
> +void xnintr_clock_handler(void)
> +{
> +	xnsched_t *sched = xnpod_current_sched();
> +	xnstat_runtime_t *prev;
> +	xnticks_t start;
> +
> +	xnarch_memory_barrier();
> +
> +	prev  = xnstat_runtime_get_current(sched);
> +	start = xnstat_runtime_now();
> +
> +	xnarch_announce_tick();
> +
> +	xnltt_log_event(xeno_ev_ienter, XNARCH_TIMER_IRQ);
> +	xnltt_log_event(xeno_ev_tstick, nktbase.name,
> +			xnpod_current_thread()->name);
> +
> +	++sched->inesting;
> +
> +	xnlock_get(&nklock);
> +	xntimer_tick_aperiodic();
> +	xnlock_put(&nklock);
> +
> +	xnstat_counter_inc(&nkclock.stat[xnsched_cpu(sched)].hits);
> +	xnstat_runtime_lazy_switch(sched,
> +		&nkclock.stat[xnsched_cpu(sched)].account, start);
> +
> +	if (--sched->inesting == 0 && xnsched_resched_p())
> +		xnpod_schedule();
> +
>  	/* Since the host tick is low priority, we can wait for returning
>  	   from the rescheduling procedure before actually calling the
>  	   propagation service, if it is pending. */
> @@ -122,18 +157,10 @@ static void xnintr_irq_handler(unsigned 
>  		xnarch_relay_tick();
>  	}
>  
> -	xnltt_log_event(xeno_ev_iexit, irq);
> +	xnltt_log_event(xeno_ev_iexit, XNARCH_TIMER_IRQ);
>  	xnstat_runtime_switch(sched, prev);
>  }
>  
> -/* Low-level clock irq handler. */
> -
> -void xnintr_clock_handler(void)
> -{
> -	xnarch_announce_tick();
> -	xnintr_irq_handler(nkclock.irq, &nkclock);
> -}
> -
>  /* Optional support for shared interrupts. */
>  
>  #if defined(CONFIG_XENO_OPT_SHIRQ_LEVEL) || defined(CONFIG_XENO_OPT_SHIRQ_EDGE)
> @@ -809,7 +836,7 @@ int xnintr_irq_proc(unsigned int irq, ch
>  		p += sprintf(p, "         [virtual]");
>  		return p - str;
>  	} else if (irq == XNARCH_TIMER_IRQ) {
> -		p += sprintf(p, "         %s", nkclock.name);
> +		p += sprintf(p, "         [timer]");
>  		return p - str;
>  	}
>  
> Index: xenomai/include/nucleus/pod.h
> ===================================================================
> --- xenomai.orig/include/nucleus/pod.h
> +++ xenomai/include/nucleus/pod.h
> @@ -438,8 +438,6 @@ static inline void xnpod_unlock_sched(vo
>  	xnlock_put_irqrestore(&nklock, s);
>  }
>  
> -int xnpod_announce_tick(struct xnintr *intr);
> -
>  void xnpod_activate_rr(xnticks_t quantum);
>  
>  void xnpod_deactivate_rr(void);
> Index: xenomai/ksrc/nucleus/pod.c
> ===================================================================
> --- xenomai.orig/ksrc/nucleus/pod.c
> +++ xenomai/ksrc/nucleus/pod.c
> @@ -3004,12 +3004,11 @@ int xnpod_enable_timesource(void)
>  
>  	xnltt_log_event(xeno_ev_tsenable);
>  
> -	/* The clock interrupt does not need to be attached since the
> -	   timer service will handle the arch-dependent setup. The IRQ
> -	   source will be attached directly by the arch-dependent layer
> -	   (xnarch_start_timer). */
> -
> -	xnintr_init(&nkclock, "[timer]", XNARCH_TIMER_IRQ, &xnpod_announce_tick, NULL, 0);
> +#ifdef CONFIG_XENO_OPT_STATS
> +	/* Only for statistical purpose, the clock interrupt will be attached
> +	   directly by the arch-dependent layer (xnarch_start_timer). */
> +	xnintr_init(&nkclock, "[timer]", XNARCH_TIMER_IRQ, NULL, NULL, 0);
> +#endif /* CONFIG_XENO_OPT_STATS */
>  
>  	nktbase.status = XNTBRUN;
>  
> @@ -3109,51 +3108,7 @@ void xnpod_disable_timesource(void)
>  	   resource is associated with this object. */
>  }
>  
> -/*! 
> - * \fn int xnpod_announce_tick(xnintr_t *intr)
> - *
> - * \brief Announce a new clock tick.
> - *
> - * This is the default service routine for clock ticks which performs
> - * the necessary housekeeping chores for time-related services managed
> - * by the nucleus. In a way or another, this routine must be called
> - * to announce each incoming clock tick to the nucleus.
> - *
> - * @param intr The descriptor address of the interrupt object
> - * associated to the timer interrupt.
> - *
> - * Side-effect: Since this routine manages the round-robin scheduling,
> - * the running thread (which has been preempted by the timer
> - * interrupt) can be switched out as a result of its time credit being
> - * exhausted. The nucleus always calls the rescheduling procedure
> - * after the outer interrupt has been processed.
> - *
> - * @return XN_ISR_HANDLED|XN_ISR_NOENABLE is always returned.
> - *
> - * Environments:
> - *
> - * This service can be called from:
> - *
> - * - Interrupt service routine, must be called with interrupts off.
> - *
> - * Rescheduling: possible.
> - *
> - */
> -
> -int xnpod_announce_tick(xnintr_t *intr)
> -{
> -	xnlock_get(&nklock);
> -
> -	xnltt_log_event(xeno_ev_tstick, xnpod_current_thread()->name);
> -
> -	xntimer_tick_aperiodic(); /* Update the master time base. */
> -
> -	xnlock_put(&nklock);
> -
> -	return XN_ISR_HANDLED | XN_ISR_NOENABLE;
> -}
> -
> -/*! 
> +/*!
>   * \fn int xnpod_set_thread_periodic(xnthread_t *thread,xnticks_t idate,xnticks_t period)
>   * \brief Make a thread periodic.
>   *
> @@ -3368,7 +3323,6 @@ int xnpod_wait_thread_period(unsigned lo
>  
>  EXPORT_SYMBOL(xnpod_activate_rr);
>  EXPORT_SYMBOL(xnpod_add_hook);
> -EXPORT_SYMBOL(xnpod_announce_tick);
>  EXPORT_SYMBOL(xnpod_check_context);
>  EXPORT_SYMBOL(xnpod_deactivate_rr);
>  EXPORT_SYMBOL(xnpod_delete_thread);
> @@ -3395,7 +3349,6 @@ EXPORT_SYMBOL(xnpod_unblock_thread);
>  EXPORT_SYMBOL(xnpod_wait_thread_period);
>  EXPORT_SYMBOL(xnpod_welcome_thread);
>  
> -EXPORT_SYMBOL(nkclock);
>  EXPORT_SYMBOL(nkpod);
>  
>  #ifdef CONFIG_SMP
> Index: xenomai/ksrc/nucleus/ltt.c
> ===================================================================
> --- xenomai.orig/ksrc/nucleus/ltt.c
> +++ xenomai/ksrc/nucleus/ltt.c
> @@ -123,8 +123,8 @@ struct xnltt_evmap xnltt_evtable[] = {
>  	    {"Xenomai sigdispatch", "thread=%s, sigpend=0x%x", -1, xeno_evall},
>  	[xeno_ev_thrboot] =
>  	    {"Xenomai thread begin", "thread=%s", -1, xeno_evthr},
> -	[xeno_ev_tstick] =
> -	    {"Xenomai time source tick", "runthread=%s", -1, xeno_evirq},
> +	[xeno_ev_tstick] = {"Xenomai time source tick",
> +			    "base=%s, runthread=%s", -1, xeno_evirq},
>  	[xeno_ev_sleepon] =
>  	    {"Xenomai sleepon", "thread=%s, sync=%p", -1, xeno_evthr},
>  	[xeno_ev_wakeup1] =
> Index: xenomai/ksrc/nucleus/timebase.c
> ===================================================================
> --- xenomai.orig/ksrc/nucleus/timebase.c
> +++ xenomai/ksrc/nucleus/timebase.c
> @@ -433,6 +433,9 @@ void xntbase_tick(xntbase_t *base)
>  
>  	xnlock_get_irqsave(&nklock, s);
>  
> +	xnltt_log_event(xeno_ev_tstick, base->name,
> +			xnpod_current_thread()->name);
> +
>  	if (base == &nktbase)
>  		xntimer_tick_aperiodic();
>  	else {
> 
-- 
Philippe.



