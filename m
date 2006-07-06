Subject: Re: [Xenomai-core] [RFC, PATCH] per-thread exec-time stats
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <44ACF5FA.2050205@domain.hid>
References: <44ACF5FA.2050205@domain.hid>
Content-Type: text/plain
Date: Thu, 06 Jul 2006 16:32:59 +0200
Message-Id: <1152196379.4978.74.camel@domain.hid>
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

On Thu, 2006-07-06 at 13:37 +0200, Jan Kiszka wrote:

<snip>

> PS: Could someone have a look that I didn't miss an accounting point and my
> acquisition is sound?
> 
> 
> --
>  include/nucleus/pod.h    |   28 ++++++++++++++++++++++++++++
>  include/nucleus/thread.h |    1 +
>  ksrc/nucleus/module.c    |   26 +++++++++++++++++++++-----
>  ksrc/nucleus/pod.c       |    5 +++++
>  ksrc/nucleus/thread.c    |    1 +
>  5 files changed, 56 insertions(+), 5 deletions(-)
> 
> Index: include/nucleus/thread.h
> ===================================================================
> --- include/nucleus/thread.h	(revision 1303)
> +++ include/nucleus/thread.h	(working copy)
> @@ -152,6 +152,7 @@ typedef struct xnthread {
>  	unsigned long csw;	/* Context switches (includes
>  				   secondary -> primary switches) */
>  	unsigned long pf;	/* Number of page faults */
> +	xnticks_t exec_time;	/* Accumulated execution time (ticks) */
>      } stat;
>  #endif /* CONFIG_XENO_OPT_STATS */
>  
> Index: include/nucleus/pod.h
> ===================================================================
> --- include/nucleus/pod.h	(revision 1303)
> +++ include/nucleus/pod.h	(working copy)
> @@ -145,6 +145,10 @@ typedef struct xnsched {
>  
>      xnthread_t rootcb;          /*!< Root thread control block. */
>  
> +#ifdef CONFIG_XENO_OPT_STATS
> +    xnticks_t last_csw;         /*!< Last context switch (ticks). */
> +#endif /* CONFIG_XENO_OPT_STATS */
> +
>  } xnsched_t;
>  
>  #ifdef CONFIG_SMP
> @@ -544,6 +548,30 @@ static inline void xnpod_delete_self (vo
>      xnpod_delete_thread(xnpod_current_thread());
>  }
>  
> +#ifdef CONFIG_XENO_OPT_STATS
> +static inline void xnpod_acc_exec_time(xnsched_t *sched,
> +                                       xnthread_t *threadout)
> +{
> +    xnticks_t now = xntimer_get_rawclock();
> +    threadout->stat.exec_time += now - sched->last_csw;
> +    sched->last_csw = now;
> +}

It would be better to only pass the thread pointer, then use the
thread->sched member. This would clearly explain the relationship
between both, and prevent any bugous attempt at mixing things.

> +
> +static inline void xnpod_update_csw_date(xnsched_t *sched)
> +{
> +    sched->last_csw = xntimer_get_rawclock();
> +}
> +#else /* !CONFIG_XENO_OPT_STATS */
> +static inline void xnpod_acc_exec_time(xnsched_t *sched,
> +                                       xnthread_t *threadout)
> +{
> +}
> +
> +static inline void xnpod_update_csw_date(xnsched_t *sched)
> +{
> +}
> +#endif /* CONFIG_XENO_OPT_STATS */
> +
>  #ifdef __cplusplus
>  }
>  #endif
> Index: ksrc/nucleus/thread.c
> ===================================================================
> --- ksrc/nucleus/thread.c	(revision 1303)
> +++ ksrc/nucleus/thread.c	(working copy)
> @@ -90,6 +90,7 @@ int xnthread_init(xnthread_t *thread,
>  	thread->stat.ssw = 0;
>  	thread->stat.csw = 0;
>  	thread->stat.pf = 0;
> +	thread->stat.exec_time = 0;
>  #endif /* CONFIG_XENO_OPT_STATS */
>  
>  	/* These will be filled by xnpod_start_thread() */
> Index: ksrc/nucleus/pod.c
> ===================================================================
> --- ksrc/nucleus/pod.c	(revision 1303)
> +++ ksrc/nucleus/pod.c	(working copy)
> @@ -669,6 +669,9 @@ static inline void xnpod_switch_zombie(x
>  
>  	xnthread_cleanup_tcb(threadout);
>  
> +	/* no need to update stats of dying thread */
> +	xnpod_update_csw_date(sched);
> +
>  	xnarch_finalize_and_switch(xnthread_archtcb(threadout),
>  				   xnthread_archtcb(threadin));
>  
> @@ -2431,6 +2434,7 @@ void xnpod_schedule(void)
>  		xnarch_enter_root(xnthread_archtcb(threadin));
>  	}
>  
> +	xnpod_acc_exec_time(sched, threadout);
>  	xnthread_inc_csw(threadin);
>  
>  	xnarch_switch_to(xnthread_archtcb(threadout),
> @@ -2602,6 +2606,7 @@ void xnpod_schedule_runnable(xnthread_t 
>  		nkpod->schedhook(runthread, XNREADY);
>  #endif /* __XENO_SIM__ */
>  
> +	xnpod_acc_exec_time(sched, runthread);
>  	xnthread_inc_csw(threadin);
>  
>  	xnarch_switch_to(xnthread_archtcb(runthread),
> Index: ksrc/nucleus/module.c
> ===================================================================
> --- ksrc/nucleus/module.c	(revision 1303)
> +++ ksrc/nucleus/module.c	(working copy)
> @@ -254,6 +254,7 @@ struct stat_seq_iterator {
>  		unsigned long ssw;
>  		unsigned long csw;
>  		unsigned long pf;
> +		xnticks_t exec_time;
>  	} stat_info[1];
>  };
>  
> @@ -294,13 +295,17 @@ static void stat_seq_stop(struct seq_fil
>  static int stat_seq_show(struct seq_file *seq, void *v)
>  {
>  	if (v == SEQ_START_TOKEN)
> -		seq_printf(seq, "%-3s  %-6s %-10s %-10s %-4s  %-8s  %s\n",
> -			   "CPU", "PID", "MSW", "CSW", "PF", "STAT", "NAME");
> +		seq_printf(seq, "%-3s  %-6s %-10s %-10s %-4s  %-8s  %12s"
> +			   "  %s\n",
> +			   "CPU", "PID", "MSW", "CSW", "PF", "STAT", "TIME",
> +			   "NAME");
>  	else {
>  		struct stat_seq_info *p = (struct stat_seq_info *)v;
> -		seq_printf(seq, "%3u  %-6d %-10lu %-10lu %-4lu  %.8lx  %s\n",
> +		unsigned long long exec_time = xnpod_ticks2ns(p->exec_time);
> +		seq_printf(seq, "%3u  %-6d %-10lu %-10lu %-4lu  %.8lx  %12llu"
> +			   "  %s\n",
>  			   p->cpu, p->pid, p->ssw, p->csw, p->pf, p->status,
> -			   p->name);
> +			   xnarch_ulldiv(exec_time, 1000, NULL), p->name);
>  	}
>  
>  	return 0;
> @@ -318,7 +323,7 @@ static int stat_seq_open(struct inode *i
>  	struct stat_seq_iterator *iter;
>  	struct seq_file *seq;
>  	xnholder_t *holder;
> -	int err, count;
> +	int err, count, cpu;
>  	spl_t s;
>  
>  	if (!nkpod)
> @@ -341,6 +346,16 @@ static int stat_seq_open(struct inode *i
>  
>  	iter->nentries = 0;
>  
> +	/* update exec-time stats of currently running threads */
> +	for_each_online_cpu(cpu) {
> +		xnsched_t *sched;
> +
> +		xnlock_get_irqsave(&nklock, s);
> +		sched = xnpod_sched_slot(cpu);
> +		xnpod_acc_exec_time(sched, sched->runthread);
> +		xnlock_put_irqrestore(&nklock, s);
> +	}
> +

We could do that from the current loop below, given that the
accumulation routine is changed to use thread->sched implicitely.

>  	/* Take a snapshot and release the nucleus lock immediately after,
>  	   so that dumping /proc/xenomai/stat with lots of entries won't
>  	   cause massive jittery. */
> @@ -359,6 +374,7 @@ static int stat_seq_open(struct inode *i
>  		iter->stat_info[n].ssw = thread->stat.ssw;
>  		iter->stat_info[n].csw = thread->stat.csw;
>  		iter->stat_info[n].pf = thread->stat.pf;
> +		iter->stat_info[n].exec_time = thread->stat.exec_time;
>  	}
>  
>  	xnlock_put_irqrestore(&nklock, s);
> 
> 
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
-- 
Philippe.



