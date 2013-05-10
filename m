Message-ID: <518D11D7.4040409@xenomai.org>
Date: Fri, 10 May 2013 17:27:19 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <50F96C89.8010004@siemens.com>
In-Reply-To: <50F96C89.8010004@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [CRITICAL PATCH] ipipe: Re-read domain context after
 IRQ	processing
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On 01/18/2013 04:38 PM, Jan Kiszka wrote:

> This fixes a nasty bug on SMP boxes: We may migrate to root in the
> context of an IRQ handler, and then also to a different CPU. Therefore,
> we must not use domain contexts read before the invocation but update
> them afterward or use stable information like the domain reference.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
> 
> We are still facing stalled, unkillable RT processes despite this fix,
> but at least the head domain status corruption (and related warnings)
> seems to be gone now.
> 
>  kernel/ipipe/core.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/ipipe/core.c b/kernel/ipipe/core.c
> index 68af0b3..6aa9572 100644
> --- a/kernel/ipipe/core.c
> +++ b/kernel/ipipe/core.c
> @@ -1173,18 +1173,19 @@ static void dispatch_irq_head(unsigned int irq) /* hw interrupts off */
>  	head->irqs[irq].handler(irq, head->irqs[irq].cookie);
>  	__ipipe_run_irqtail(irq);
>  	hard_local_irq_disable();
> +	p = ipipe_this_cpu_head_context();
>  	__clear_bit(IPIPE_STALL_FLAG, &p->status);
>  
>  	/* Are we still running in the head domain? */
>  	if (likely(__ipipe_current_context == p)) {
>  		/* Did we enter this code over the head domain? */
> -		if (old == p) {
> +		if (old->domain == head) {
>  			/* Yes, do immediate synchronization. */
>  			if (__ipipe_ipending_p(p))
>  				__ipipe_sync_stage();
>  			return;
>  		}
> -		__ipipe_set_current_context(old);
> +		__ipipe_set_current_context(ipipe_this_cpu_root_context());
>  	}
>  
>  	/*


Hi Jan,

I may have an issue reported which resembles the problem fixed by this
patch. If I understand your patch, it means that an irq handler may
migrate domain. But if I read __ipipe_sync_stage() code:

void __ipipe_do_sync_stage(void)
{
	struct ipipe_percpu_domain_data *p;
	struct ipipe_domain *ipd;
	int irq;

	p = __ipipe_current_context;
	ipd = p->domain;

	__set_bit(IPIPE_STALL_FLAG, &p->status);
	smp_wmb();

	if (ipd == ipipe_root_domain)
		trace_hardirqs_off();

	for (;;) {
		irq = __ipipe_next_irq(p);
		if (irq < 0)
			break;
		/*
		 * Make sure the compiler does not reorder wrongly, so
		 * that all updates to maps are done before the
		 * handler gets called.
		 */
		barrier();

		if (test_bit(IPIPE_LOCK_FLAG, &ipd->irqs[irq].control))
			continue;

		if (ipd != ipipe_head_domain)
			hard_local_irq_enable();

		if (likely(ipd != ipipe_root_domain)) {
			ipd->irqs[irq].handler(irq, ipd->irqs[irq].cookie);
			__ipipe_run_irqtail(irq);
			hard_local_irq_disable();
		} else if (ipipe_virtual_irq_p(irq)) {
			irq_enter();
			ipd->irqs[irq].handler(irq, ipd->irqs[irq].cookie);
			irq_exit();
			root_stall_after_handler();
			hard_local_irq_disable();
			while (__ipipe_check_root_resched())
				__ipipe_preempt_schedule_irq();
		} else {
			ipd->irqs[irq].handler(irq, ipd->irqs[irq].cookie);
			root_stall_after_handler();
			hard_local_irq_disable();
		}

		p = __ipipe_current_context;
	}

	if (ipd == ipipe_root_domain)
		trace_hardirqs_on();

	__clear_bit(IPIPE_STALL_FLAG, &p->status);
}

It seems to me that at the end of each loop, we re-read p, but we assume
that p->domain did not change. So I would add:

ipd = p->domain

right after the line
p = __ipipe_current_context

But I am not sure that we are supposed to allow irq handlers to migrate
domains.

Regards.

-- 
                                                                Gilles.

