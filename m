Subject: Re: [PATCH] cobalt/thread: get rid of dynamic allocation for
 xnthread_signal
References: <20210608070436.1198-1-hongzhan.chen@intel.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <768ca079-fefa-e11c-2271-7c5340be69c1@siemens.com>
Date: Tue, 8 Jun 2021 10:27:35 +0200
MIME-Version: 1.0
In-Reply-To: <20210608070436.1198-1-hongzhan.chen@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Hongzhan Chen <hongzhan.chen@intel.com>, xenomai@xenomai.org

On 08.06.21 09:04, Hongzhan Chen via Xenomai wrote:
> Add one or more "signal slots" per possible cause of in-band signal
> into struct xnthread to get rid of dynamic allocation.
> 
> For SIGDEBUG, except SIGDEBUG_WATCHDOG all other SIGDEBUG_* cause
> including SIGDEBUG_MIGRATE_SIGNAL, SIGDEBUG_MIGRATE_SYSCALL,
> SIGDEBUG_MIGRATE_FAULT, SIGDEBUG_MIGRATE_PRIOINV, SIGDEBUG_NOMLOCK,
> SIGDEBUG_RESCNT_IMBALANCE, SIGDEBUG_LOCK_BREAK, SIGDEBUG_MUTEX_SLEEP
> are synchronous and mutually exclusive due to the oob->in-band transition.
> But SIGDEBUG_WATCHDOG is triggered asynchronously by the oob timer.
> 
> All SIGSHADOW_* events need their own slot: SIGSHADOW_ACTION_HARDEN and
> SIGSHADOW_ACTION_HOME can be raised by remote threads asynchronously to
> the target thread. SIGSHADOW_ACTION_BACKTRACE comes in addition to
> SIGDEBUG_MIGRATE_*. For the latter reason, SIGSHADOW_ACTION_BACKTRACE
> cannot pile up though.
> 
> Including SIGTERM, we have totally 6 slots.
> 

Please rebase on top of next, rather than wip/dovetail. It will replace
the related patch in wip/dovetail.

> Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
> 
> diff --git a/include/cobalt/kernel/thread.h b/include/cobalt/kernel/thread.h
> index bc83cc556..29795f79c 100644
> --- a/include/cobalt/kernel/thread.h
> +++ b/include/cobalt/kernel/thread.h
> @@ -42,6 +42,7 @@
>   */
>  #define XNTHREAD_BLOCK_BITS   (XNSUSP|XNPEND|XNDELAY|XNDORMANT|XNRELAX|XNHELD|XNDBGSTOP)
>  #define XNTHREAD_MODE_BITS    (XNRRB|XNWARN|XNTRAPLB)
> +#define XNTHREAD_SIGNALS_NUM  6
>  
>  struct xnthread;
>  struct xnsched;
> @@ -51,6 +52,13 @@ struct xnsched_tpslot;
>  struct xnthread_personality;
>  struct completion;
>  
> +struct lostage_signal {
> +	struct pipeline_inband_work inband_work; /* Must be first. */
> +	struct task_struct *task;
> +	int signo, sigval;
> +	struct lostage_signal *self; /* Revisit: I-pipe requirement */
> +};
> +
>  struct xnthread_init_attr {
>  	struct xnthread_personality *personality;
>  	cpumask_t affinity;
> @@ -205,6 +213,29 @@ struct xnthread {
>  	const char *exe_path;	/* Executable path */
>  	u32 proghash;		/* Hash value for exe_path */
>  #endif
> +	/*
> +	 * Each slot handle different cause of signal
> +	 * slot 0:
> +	 * 	SIGDEBUG_MIGRATE_SIGNAL
> +	 * 	SIGDEBUG_MIGRATE_SYSCALL
> +	 * 	SIGDEBUG_MIGRATE_FAULT
> +	 * 	SIGDEBUG_MIGRATE_PRIOINV
> +	 * 	SIGDEBUG_NOMLOCK
> +	 * 	SIGDEBUG_RESCNT_IMBALANCE
> +	 * 	SIGDEBUG_LOCK_BREAK
> +	 * 	SIGDEBUG_MUTEX_SLEEP
> +	 * slot 1:
> +	 * 	SIGDEBUG_WATCHDOG

I'm still a bit undecided if we should serialize watchdog events with
other SIGDEBUG reasons, but that could also be done on top later on as
it appears to me now as slightly more complicated.

> +	 * slot 2:
> +	 * 	SIGSHADOW_ACTION_HARDEN
> +	 * slot 3:
> +	 * 	SIGSHADOW_ACTION_BACKTRACE
> +	 * slot 4:
> +	 * 	SIGSHADOW_ACTION_HOME
> +	 * slot 5:
> +	 * 	SIGTERM
> +	 */

Could we also define names for the slots?

> +	struct lostage_signal sigarray[XNTHREAD_SIGNALS_NUM];
>  };
>  
>  static inline int xnthread_get_state(const struct xnthread *thread)
> diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
> index 9c7753ac4..ebb798b58 100644
> --- a/kernel/cobalt/thread.c
> +++ b/kernel/cobalt/thread.c
> @@ -2065,13 +2065,6 @@ void xnthread_relax(int notify, int reason)
>  }
>  EXPORT_SYMBOL_GPL(xnthread_relax);
>  
> -struct lostage_signal {
> -	struct pipeline_inband_work inband_work; /* Must be first. */
> -	struct task_struct *task;
> -	int signo, sigval;
> -	struct lostage_signal *self; /* Revisit: I-pipe requirement */
> -};
> -
>  static inline void do_kthread_signal(struct task_struct *p,
>  				     struct xnthread *thread,
>  				     struct lostage_signal *rq)
> @@ -2111,7 +2104,7 @@ static void lostage_task_signal(struct pipeline_inband_work *inband_work)
>  	} else
>  		send_sig(signo, p, 1);
>  out:
> -	xnfree(rq->self);
> +	memset(rq->self, 0, sizeof(*rq));
>  }
>  
>  static int force_wakeup(struct xnthread *thread) /* nklock locked, irqs off */
> @@ -2273,14 +2266,56 @@ void xnthread_demote(struct xnthread *thread)
>  }
>  EXPORT_SYMBOL_GPL(xnthread_demote);
>  
> +int get_slot_index_from_sig(int sig, int arg)
> +{
> +	int action;
> +
> +	switch (sig) {
> +	case SIGDEBUG:
> +		switch (arg) {
> +		case SIGDEBUG_WATCHDOG:
> +			return 1;
> +		case SIGDEBUG_MIGRATE_SIGNAL:
> +		case SIGDEBUG_MIGRATE_SYSCALL:
> +		case SIGDEBUG_MIGRATE_FAULT:
> +		case SIGDEBUG_MIGRATE_PRIOINV:
> +		case SIGDEBUG_NOMLOCK:
> +		case SIGDEBUG_RESCNT_IMBALANCE:
> +		case SIGDEBUG_LOCK_BREAK:
> +		case SIGDEBUG_MUTEX_SLEEP:
> +			return 0;
> +		}
> +		break;
> +	case SIGSHADOW:
> +		action = sigshadow_action(arg);
> +		switch (action) {
> +		case SIGSHADOW_ACTION_HARDEN:
> +			return 2;
> +		case SIGSHADOW_ACTION_BACKTRACE:
> +			return 3;
> +		case SIGSHADOW_ACTION_HOME:
> +			return 4;
> +		}
> +		break;
> +	case SIGTERM:
> +		return 5;
> +	}
> +
> +	return -1;
> +}
> +
>  void xnthread_signal(struct xnthread *thread, int sig, int arg)
>  {
>  	struct lostage_signal *sigwork;
> +	int slot;
> +
> +	slot = get_slot_index_from_sig(sig, arg);
>  
> -	sigwork = xnmalloc(sizeof(*sigwork));
> -	if (WARN_ON(sigwork == NULL))
> +	if (slot < 0 || slot >= XNTHREAD_SIGNALS_NUM)
>  		return;

Should keep the warning on errors. And >= XNTHREAD_SIGNALS_NUM cannot
happen (over-defensive programming).

>  
> +	sigwork = &thread->sigarray[slot];
> +

Does this automatically handle the case of duplicate submissions on the
same slot?

>  	sigwork->inband_work = (struct pipeline_inband_work)
>  			PIPELINE_INBAND_WORK_INITIALIZER(*sigwork,
>  					lostage_task_signal);
> 

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

