Message-ID: <48B51FBA.5020407@domain.hid>
Date: Wed, 27 Aug 2008 11:34:50 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <48B46C89.6000505@domain.hid>
In-Reply-To: <48B46C89.6000505@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [RESEND][PATCH] Refactor xnintr query
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

Jan Kiszka wrote:
> [ Trying the keep my queue short... ]
> 
> This version, posted earlier already, should address all remarks brought
> up. OK to commit?
>

Fine with me.

> ---
>  include/nucleus/intr.h |   25 +++++++++++-----
>  ksrc/nucleus/intr.c    |   76 +++++++++++++++++++++++++++++++------------------
>  ksrc/nucleus/module.c  |   47 ++++++++++--------------------
>  3 files changed, 84 insertions(+), 64 deletions(-)
> 
> Index: b/include/nucleus/intr.h
> ===================================================================
> --- a/include/nucleus/intr.h
> +++ b/include/nucleus/intr.h
> @@ -69,11 +69,23 @@ typedef struct xnintr {
>  
>  } xnintr_t;
>  
> +typedef struct xnintr_iterator {
> +
> +    int cpu;		/* !< Current CPU in iteration. */
> +
> +    unsigned long hits;	/* !< Current hit counter. */
> +
> +    xnticks_t exectime;	/* !< Used CPU time in current accounting period. */
> +
> +    xnticks_t account_period; /* !< Length of accounting period. */
> +
> +    int list_rev;	/* !< System-wide xnintr list revision (internal use). */
> +
> +    xnintr_t *prev;	/* !< Previously visited xnintr object (internal use). */
> +
> +} xnintr_iterator_t;
> +
>  extern xnintr_t nkclock;
> -#ifdef CONFIG_XENO_OPT_STATS
> -extern int xnintr_count;
> -extern int xnintr_list_rev;
> -#endif
>  
>  #ifdef __cplusplus
>  extern "C" {
> @@ -108,9 +120,8 @@ int xnintr_disable(xnintr_t *intr);
>  xnarch_cpumask_t xnintr_affinity(xnintr_t *intr,
>                                   xnarch_cpumask_t cpumask);
>  
> -int xnintr_query(int irq, int *cpu, xnintr_t **prev, int revision, char *name,
> -		 unsigned long *hits, xnticks_t *exectime,
> -		 xnticks_t *account_period);
> +int xnintr_query_init(xnintr_iterator_t *iterator);
> +int xnintr_query_next(int irq, xnintr_iterator_t *iterator, char *name_buf);
>  
>  #ifdef __cplusplus
>  }
> Index: b/ksrc/nucleus/intr.c
> ===================================================================
> --- a/ksrc/nucleus/intr.c
> +++ b/ksrc/nucleus/intr.c
> @@ -42,9 +42,9 @@
>  DEFINE_PRIVATE_XNLOCK(intrlock);
>  
>  #ifdef CONFIG_XENO_OPT_STATS
> -xnintr_t nkclock;	/* Only for statistics */
> -int xnintr_count = 1;	/* Number of attached xnintr objects + nkclock */
> -int xnintr_list_rev;	/* Modification counter of xnintr list */
> +xnintr_t nkclock;	     /* Only for statistics */
> +static int xnintr_count = 1; /* Number of attached xnintr objects + nkclock */
> +static int xnintr_list_rev;  /* Modification counter of xnintr list */
>  
>  /* Both functions update xnintr_list_rev at the very end.
>   * This guarantees that module.c::stat_seq_open() won't get
> @@ -899,55 +899,77 @@ int xnintr_irq_proc(unsigned int irq, ch
>  #endif /* CONFIG_PROC_FS */
>  
>  #ifdef CONFIG_XENO_OPT_STATS
> -int xnintr_query(int irq, int *cpu, xnintr_t **prev, int revision, char *name,
> -		 unsigned long *hits, xnticks_t *exectime,
> -		 xnticks_t *account_period)
> +int xnintr_query_init(xnintr_iterator_t *iterator)
> +{
> +	iterator->cpu = -1;
> +	iterator->prev = NULL;
> +
> +	/* The order is important here: first xnintr_list_rev then
> +	 * xnintr_count.  On the other hand, xnintr_attach/detach()
> +	 * update xnintr_count first and then xnintr_list_rev.  This
> +	 * should guarantee that we can't get an up-to-date
> +	 * xnintr_list_rev and old xnintr_count here. The other way
> +	 * around is not a problem as xnintr_query() will notice this
> +	 * fact later.  Should xnintr_list_rev change later,
> +	 * xnintr_query() will trigger an appropriate error below. */
> +
> +	iterator->list_rev = xnintr_list_rev;
> +	xnarch_memory_barrier();
> +
> +	return xnintr_count;
> +}
> +
> +int xnintr_query_next(int irq, xnintr_iterator_t *iterator, char *name_buf)
>  {
>  	xnintr_t *intr;
>  	xnticks_t last_switch;
> -	int head;
> -	int cpu_no = *cpu;
> +	int cpu_no = iterator->cpu + 1;
>  	int err = 0;
>  	spl_t s;
>  
> +	if (cpu_no == xnarch_num_online_cpus())
> +		cpu_no = 0;
> +	iterator->cpu = cpu_no;
> +
>  	xnlock_get_irqsave(&intrlock, s);
>  
> -	if (revision != xnintr_list_rev) {
> +	if (iterator->list_rev != xnintr_list_rev) {
>  		err = -EAGAIN;
>  		goto unlock_and_exit;
>  	}
>  
> -	if (*prev)
> -		intr = xnintr_shirq_next(*prev);
> -	else if (irq == XNARCH_TIMER_IRQ)
> -		intr = &nkclock;
> -	else
> -		intr = xnintr_shirq_first(irq);
> +	if (!iterator->prev) {
> +		if (irq == XNARCH_TIMER_IRQ)
> +			intr = &nkclock;
> +		else
> +			intr = xnintr_shirq_first(irq);
> +	} else
> +		intr = xnintr_shirq_next(iterator->prev);
>  
>  	if (!intr) {
> +		cpu_no = -1;
> +		iterator->prev = NULL;
>  		err = -ENODEV;
>  		goto unlock_and_exit;
>  	}
>  
> -	head = snprintf(name, XNOBJECT_NAME_LEN, "IRQ%d: ", irq);
> -	name += head;
> -	strncpy(name, intr->name, XNOBJECT_NAME_LEN-head);
> +	snprintf(name_buf, XNOBJECT_NAME_LEN, "IRQ%d: %s", irq, intr->name);
>  
> -	*hits = xnstat_counter_get(&intr->stat[cpu_no].hits);
> +	iterator->hits = xnstat_counter_get(&intr->stat[cpu_no].hits);
>  
>  	last_switch = xnpod_sched_slot(cpu_no)->last_account_switch;
>  
> -	*exectime       = intr->stat[cpu_no].account.total;
> -	*account_period = last_switch - intr->stat[cpu_no].account.start;
> +	iterator->exectime = intr->stat[cpu_no].account.total;
> +	iterator->account_period =
> +		last_switch - intr->stat[cpu_no].account.start;
>  
> -	intr->stat[cpu_no].account.total  = 0;
> +	intr->stat[cpu_no].account.total = 0;
>  	intr->stat[cpu_no].account.start = last_switch;
>  
> -	if (++cpu_no == xnarch_num_online_cpus()) {
> -		cpu_no = 0;
> -		*prev  = intr;
> -	}
> -	*cpu = cpu_no;
> +	/* Proceed to next entry in shared IRQ chain when all CPUs
> +	 * have been visited for this one. */
> +	if (cpu_no + 1 == xnarch_num_online_cpus())
> +		iterator->prev = intr;
>  
>       unlock_and_exit:
>  	xnlock_put_irqrestore(&intrlock, s);
> Index: b/ksrc/nucleus/module.c
> ===================================================================
> --- a/ksrc/nucleus/module.c
> +++ b/ksrc/nucleus/module.c
> @@ -352,7 +352,9 @@ static int stat_seq_open(struct inode *i
>  	struct seq_file *seq;
>  	xnholder_t *holder;
>  	struct stat_seq_info *stat_info;
> -	int err, count, thrq_rev, intr_rev, irq;
> +	xnintr_iterator_t intr_iter;
> +	int err, count, thrq_rev, irq;
> +	int intr_count;
>  	spl_t s;
>  
>  	if (!xnpod_active_p())
> @@ -368,18 +370,8 @@ static int stat_seq_open(struct inode *i
>  
>  	xnlock_put_irqrestore(&nklock, s);
>  
> -	/* The order is important here: first xnintr_list_rev then
> -	 * xnintr_count.  On the other hand, xnintr_attach/detach()
> -	 * update xnintr_count first and then xnintr_list_rev.  This
> -	 * should guarantee that we can't get an up-to-date
> -	 * xnintr_list_rev and old xnintr_count here. The other way
> -	 * around is not a problem as xnintr_query() will notice this
> -	 * fact later.  Should xnintr_list_rev change later,
> -	 * xnintr_query() will trigger an appropriate error below. */
> -
> -	intr_rev = xnintr_list_rev;
> -	xnarch_memory_barrier();
> -	count += xnintr_count * RTHAL_NR_CPUS;
> +	intr_count = xnintr_query_init(&intr_iter);
> +	count += intr_count * RTHAL_NR_CPUS;
>  
>  	if (iter)
>  		kfree(iter);
> @@ -442,35 +434,30 @@ static int stat_seq_open(struct inode *i
>  	}
>  
>  	/* Iterate over all IRQ numbers, ... */
> -	for (irq = 0; irq < XNARCH_NR_IRQS; irq++) {
> -		xnintr_t *prev = NULL;
> -		int cpu = 0, _cpu;
> -		int err;
> -
> +	for (irq = 0; irq < XNARCH_NR_IRQS; irq++)
>  		/* ...over all shared IRQs on all CPUs */
>  		while (1) {
>  			stat_info = &iter->stat_info[iter->nentries];
> -			_cpu = cpu;
>  
> -			err = xnintr_query(irq, &cpu, &prev, intr_rev,
> -					   stat_info->name,
> -					   &stat_info->csw,
> -					   &stat_info->exectime,
> -					   &stat_info->account_period);
> -			if (err == -EAGAIN)
> -				goto restart_unlocked;
> -			if (err)
> +			err = xnintr_query_next(irq, &intr_iter,
> +						stat_info->name);
> +			if (err) {
> +				if (err == -EAGAIN)
> +					goto restart_unlocked;
>  				break; /* line unused or end of chain */
> +			}
>  
> -			stat_info->cpu = _cpu;
> +			stat_info->cpu = intr_iter.cpu;
> +			stat_info->csw = intr_iter.hits;
> +			stat_info->exectime = intr_iter.exectime;
> +			stat_info->account_period = intr_iter.account_period;
>  			stat_info->pid = 0;
>  			stat_info->state =  0;
>  			stat_info->ssw = 0;
>  			stat_info->pf = 0;
>  
>  			iter->nentries++;
> -		};
> -	}
> +		}
>  
>  	seq = file->private_data;
>  	seq->private = iter;
> 
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


-- 
Philippe.

