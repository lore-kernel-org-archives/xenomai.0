From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <46D66DA7.6060800@domain.hid>
References: <46D66DA7.6060800@domain.hid>
Content-Type: text/plain
Date: Fri, 07 Sep 2007 09:23:06 +0200
Message-Id: <1189149786.26986.19.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [PATCH 2/2] Round up in RTDM converting ns
	to	ticks
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
Cc: "Markus Osterried (BA/EDD)" <markus.osterried@domain.hid>, xenomai-core <xenomai@xenomai.org>

On Thu, 2007-08-30 at 09:11 +0200, Jan Kiszka wrote:
> As suggested by Markus, this patch lets RTDM round up when nanoseconds
> are to be converted to ticks (only relevant if RTDM runs over a
> periodic, tick-based timebase).

Merged, thanks.

> 
> This is against trunk only, I haven't yet decided what to do with 2.3.x.
> The rounding change may have unexpected side-effects, so I'm hesitating
> to change the stable version as well.
> 

One reason more for people to test -rc releases.

> Jan
> plain text document attachment (round-up-in-rtdm.patch)
> ---
>  include/rtdm/rtdm_driver.h |   11 +++++------
>  ksrc/skins/rtdm/drvlib.c   |   32 ++++++++++++++++----------------
>  2 files changed, 21 insertions(+), 22 deletions(-)
> 
> Index: xenomai/include/rtdm/rtdm_driver.h
> ===================================================================
> --- xenomai.orig/include/rtdm/rtdm_driver.h
> +++ xenomai/include/rtdm/rtdm_driver.h
> @@ -876,8 +876,8 @@ static inline int rtdm_timer_start_in_ha
>  					      nanosecs_rel_t interval,
>  					      enum rtdm_timer_mode mode)
>  {
> -	return xntimer_start(timer, xntbase_ns2ticks(rtdm_tbase, expiry),
> -			     xntbase_ns2ticks(rtdm_tbase, interval),
> +	return xntimer_start(timer, xntbase_ns2ticks_ceil(rtdm_tbase, expiry),
> +			     xntbase_ns2ticks_ceil(rtdm_tbase, interval),
>  			     (xntmode_t)mode);
>  }
>  
> @@ -945,10 +945,9 @@ static inline int rtdm_task_set_period(r
>  {
>  	if (period < 0)
>  		period = 0;
> -	return
> -	    xnpod_set_thread_periodic(task, XN_INFINITE,
> -				      xntbase_ns2ticks(xnthread_time_base(task),
> -						       period));
> +	return xnpod_set_thread_periodic(task, XN_INFINITE,
> +					 xntbase_ns2ticks_ceil
> +					 (xnthread_time_base(task), period));
>  }
>  
>  static inline int rtdm_task_unblock(rtdm_task_t *task)
> Index: xenomai/ksrc/skins/rtdm/drvlib.c
> ===================================================================
> --- xenomai.orig/ksrc/skins/rtdm/drvlib.c
> +++ xenomai/ksrc/skins/rtdm/drvlib.c
> @@ -145,8 +145,8 @@ int rtdm_task_init(rtdm_task_t *task, co
>  
>  	if (period > 0) {
>  		res = xnpod_set_thread_periodic(task, XN_INFINITE,
> -						xntbase_ns2ticks(rtdm_tbase,
> -								 period));
> +						xntbase_ns2ticks_ceil
> +						(rtdm_tbase,  period));
>  		if (res)
>  			goto cleanup_out;
>  	}
> @@ -370,8 +370,8 @@ int __rtdm_task_sleep(xnticks_t timeout,
>  	XENO_ASSERT(RTDM, !xnpod_unblockable_p(), return -EPERM;);
>  
>  	xnpod_suspend_thread(thread, XNDELAY,
> -			     xntbase_ns2ticks(xnthread_time_base(thread),
> -					      timeout), mode, NULL);
> +			     xntbase_ns2ticks_ceil(xnthread_time_base(thread),
> +						   timeout), mode, NULL);
>  
>  	return xnthread_test_info(thread, XNBREAK) ? -EINTR : 0;
>  }
> @@ -544,8 +544,8 @@ int rtdm_timer_start(rtdm_timer_t *timer
>  	int err;
>  
>  	xnlock_get_irqsave(&nklock, s);
> -	err = xntimer_start(timer, xntbase_ns2ticks(rtdm_tbase, expiry),
> -			    xntbase_ns2ticks(rtdm_tbase, interval),
> +	err = xntimer_start(timer, xntbase_ns2ticks_ceil(rtdm_tbase, expiry),
> +			    xntbase_ns2ticks_ceil(rtdm_tbase, interval),
>  			    (xntmode_t)mode);
>  	xnlock_put_irqrestore(&nklock, s);
>  
> @@ -714,7 +714,7 @@ void rtdm_toseq_init(rtdm_toseq_t *timeo
>  	XENO_ASSERT(RTDM, !xnpod_unblockable_p(), /* only warn here */;);
>  
>  	*timeout_seq =
> -	    xntbase_get_jiffies(base) + xntbase_ns2ticks(base, timeout);
> +	    xntbase_get_jiffies(base) + xntbase_ns2ticks_ceil(base, timeout);
>  }
>  
>  EXPORT_SYMBOL(rtdm_toseq_init);
> @@ -934,9 +934,9 @@ int rtdm_event_timedwait(rtdm_event_t *e
>  		} else {
>  			/* infinite or relative timeout */
>  			xnsynch_sleep_on(&event->synch_base,
> -				xntbase_ns2ticks(xnthread_time_base(thread),
> -						 timeout),
> -				XN_RELATIVE);
> +					 xntbase_ns2ticks_ceil
> +					 (xnthread_time_base(thread), timeout),
> +					 XN_RELATIVE);
>  		}
>  
>  		if (likely
> @@ -1143,9 +1143,9 @@ int rtdm_sem_timeddown(rtdm_sem_t *sem, 
>  		} else {
>  			/* infinite or relative timeout */
>  			xnsynch_sleep_on(&sem->synch_base,
> -				xntbase_ns2ticks(xnthread_time_base(thread),
> -						 timeout),
> -				XN_RELATIVE);
> +					 xntbase_ns2ticks_ceil
> +					 (xnthread_time_base(thread), timeout),
> +					 XN_RELATIVE);
>  		}
>  
>  		if (xnthread_test_info(thread, XNTIMEO | XNRMID | XNBREAK)) {
> @@ -1377,9 +1377,9 @@ restart:
>  		} else {
>  			/* infinite or relative timeout */
>  			xnsynch_sleep_on(&mutex->synch_base,
> -				xntbase_ns2ticks(xnthread_time_base(curr_thread),
> -						 timeout),
> -				XN_RELATIVE);
> +					 xntbase_ns2ticks_ceil
> +					 (xnthread_time_base(curr_thread),
> +					  timeout), XN_RELATIVE);
>  		}
>  
>  		if (unlikely(xnthread_test_info(curr_thread,
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
-- 
Philippe.



