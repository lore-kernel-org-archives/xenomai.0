Subject: Re: [PATCH] cobalt/intr: fix interrupt stat iterator
References: <20190424102940.12754-1-rpm@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <e2d59fb7-93fd-579e-44a9-410c03562f5f@siemens.com>
Date: Thu, 25 Apr 2019 16:53:35 +0200
MIME-Version: 1.0
In-Reply-To: <20190424102940.12754-1-rpm@xenomai.org>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

On 24.04.19 12:29, Philippe Gerum via Xenomai wrote:
> The implementation does not iterate fully over all CPU slots for every
> handler, leaving some of them uncollected. In addition, if maxcpus= is
> used to restrict the number of available CPUs to a subset of the
> present ones, with the highest numbered CPU marked offline, the
> iterator rescans the first valid IRQ slot indefinitely, eventually
> leading to memory corruption due to out-of-bound writes.

The patch looks good and works fine for the common case, so I've applied it to next.

But I cannot reproduce your maxcpus setup as - for to-be-debugged reasons - we 
are already crashing on 4.14 and 4.4 on x86 during boot. Did you test on ARM?

Jan

> 
> Rewrite the iterator in order to implement the following loop as
> expected:
> 
> for_each_irq(irq)
>      for_each_handler_of_irq(handler, irq)
>      	for_each_online_cpu(cpu)
> 	    collect_stats(irq, handler, cpu);
> ---
>   kernel/cobalt/intr.c  | 48 +++++++++++++++++++------------------------
>   kernel/cobalt/sched.c |  2 +-
>   2 files changed, 22 insertions(+), 28 deletions(-)
> 
> diff --git a/kernel/cobalt/intr.c b/kernel/cobalt/intr.c
> index ba6409ebb..9c3f55508 100644
> --- a/kernel/cobalt/intr.c
> +++ b/kernel/cobalt/intr.c
> @@ -1015,7 +1015,6 @@ void xnintr_put_query_lock(void)
>   
>   int xnintr_query_init(struct xnintr_iterator *iterator)
>   {
> -	iterator->cpu = -1;
>   	iterator->prev = NULL;
>   
>   	/* The order is important here: first xnintr_list_rev then
> @@ -1039,43 +1038,38 @@ int xnintr_query_next(int irq, struct xnintr_iterator *iterator,
>   	int cpu, nr_cpus = num_present_cpus();
>   	struct xnintr *intr;
>   
> -	for (cpu = iterator->cpu + 1; cpu < nr_cpus; ++cpu) {
> -		if (cpu_online(cpu))
> -			break;
> -	}
> -	if (cpu == nr_cpus)
> -		cpu = 0;
> -	iterator->cpu = cpu;
> -
>   	if (iterator->list_rev != xnintr_list_rev)
>   		return -EAGAIN;
>   
> -	if (!iterator->prev) {
> +	intr = iterator->prev;
> +	if (intr == NULL) {
>   		if (xnintr_is_timer_irq(irq))
>   			intr = &nktimer;
>   		else
>   			intr = xnintr_vec_first(irq);
> -	} else
> -		intr = xnintr_vec_next(iterator->prev);
> -
> -	if (intr == NULL) {
> -		cpu = -1;
> -		iterator->prev = NULL;
> -		return -ENODEV;
> +		if (intr == NULL)
> +			return -ENODEV;
> +		iterator->prev = intr;
> +		iterator->cpu = -1;
>   	}
>   
> -	ksformat(name_buf, XNOBJECT_NAME_LEN, "IRQ%d: %s", irq, intr->name);
> +	for (;;) {
> +		for (cpu = iterator->cpu + 1; cpu < nr_cpus; ++cpu) {
> +			if (cpu_online(cpu)) {
> +				ksformat(name_buf, XNOBJECT_NAME_LEN, "IRQ%d: %s",
> +					irq, intr->name);
> +				query_irqstats(intr, cpu, iterator);
> +				iterator->cpu = cpu;
> +				return 0;
> +			}
> +		}
>   
> -	query_irqstats(intr, cpu, iterator);
> +		iterator->prev = xnintr_vec_next(intr);
> +		if (iterator->prev == NULL)
> +			return -ENODEV;
>   
> -	/*
> -	 * Proceed to next entry in shared IRQ chain when all CPUs
> -	 * have been visited for this one.
> -	 */
> -	if (cpu + 1 == nr_cpus)
> -		iterator->prev = intr;
> -
> -	return 0;
> +		iterator->cpu = -1;
> +	}
>   }
>   
>   #endif /* CONFIG_XENO_OPT_STATS */
> diff --git a/kernel/cobalt/sched.c b/kernel/cobalt/sched.c
> index f7d16fa37..9c7a729b8 100644
> --- a/kernel/cobalt/sched.c
> +++ b/kernel/cobalt/sched.c
> @@ -1265,7 +1265,7 @@ static int vfile_schedstat_rewind(struct xnvfile_snapshot_iterator *it)
>   	 */
>   	priv->curr = list_first_entry(&nkthreadq, struct xnthread, glink);
>   	priv->irq = 0;
> -	irqnr = xnintr_query_init(&priv->intr_it) * NR_CPUS;
> +	irqnr = xnintr_query_init(&priv->intr_it) * num_online_cpus();
>   
>   	return irqnr + cobalt_nrthreads;
>   }
> 


-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

