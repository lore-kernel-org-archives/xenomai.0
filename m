Subject: Re: [PATCH Dovetail 06/13] cobalt/sched, clock: pipeline: abstract
 IPI management
References: <20210102093353.3195090-1-rpm@xenomai.org>
 <20210102093353.3195090-7-rpm@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <6c2e91b7-2cbe-7eb4-56c5-fd9994825af1@siemens.com>
Date: Fri, 8 Jan 2021 10:40:55 +0100
MIME-Version: 1.0
In-Reply-To: <20210102093353.3195090-7-rpm@xenomai.org>
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
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

On 02.01.21 10:33, Philippe Gerum wrote:
> From: Philippe Gerum <rpm@xenomai.org>
> 
> The I-pipe and Dovetail share the very same concept of out-of-band,
> high-priority IPI, but using a different interface. Let's abstract the
> calls manipulating those IPIs to make them pipeline-specific.
> 
> No functional change is introduced.
> 
> Signed-off-by: Philippe Gerum <rpm@xenomai.org>
> ---
>  .../cobalt/kernel/ipipe/pipeline/pipeline.h   | 50 ++++++++++++++++++-
>  kernel/cobalt/clock.c                         |  2 +-
>  .../include/asm-generic/xenomai/wrappers.h    |  4 --
>  kernel/cobalt/sched.c                         | 11 ++--
>  kernel/cobalt/timer.c                         |  7 +--
>  5 files changed, 56 insertions(+), 18 deletions(-)
> 
> diff --git a/include/cobalt/kernel/ipipe/pipeline/pipeline.h b/include/cobalt/kernel/ipipe/pipeline/pipeline.h
> index 317fa62d7..6f6958402 100644
> --- a/include/cobalt/kernel/ipipe/pipeline/pipeline.h
> +++ b/include/cobalt/kernel/ipipe/pipeline/pipeline.h
> @@ -5,7 +5,13 @@
>  #ifndef _COBALT_KERNEL_IPIPE_PIPELINE_H
>  #define _COBALT_KERNEL_IPIPE_PIPELINE_H
>  
> -#include <linux/ipipe.h>
> +#ifdef CONFIG_IPIPE_LEGACY
> +#error "CONFIG_IPIPE_LEGACY must be switched off"
> +#endif
> +
> +#include <pipeline/machine.h>
> +
> +#define PIPELINE_NR_IRQS  IPIPE_NR_IRQS
>  
>  typedef unsigned long spl_t;
>  
> @@ -22,4 +28,46 @@ typedef unsigned long spl_t;
>  #define is_secondary_domain()	ipipe_root_p
>  #define is_primary_domain()	(!ipipe_root_p)
>  
> +#ifdef CONFIG_SMP
> +
> +static inline int pipeline_request_resched_ipi(void (*handler)(void))
> +{
> +	return ipipe_request_irq(&cobalt_pipeline.domain,
> +				IPIPE_RESCHEDULE_IPI,
> +				(ipipe_irq_handler_t)handler,
> +				NULL, NULL);
> +}
> +
> +static inline void pipeline_free_resched_ipi(void)
> +{
> +	ipipe_free_irq(&cobalt_pipeline.domain,
> +		IPIPE_RESCHEDULE_IPI);
> +}
> +
> +static inline void pipeline_send_resched_ipi(const struct cpumask *dest)
> +{
> +	ipipe_send_ipi(IPIPE_RESCHEDULE_IPI, *dest);
> +}
> +
> +static inline int pipeline_request_timer_ipi(void (*handler)(void))
> +{
> +	return ipipe_request_irq(&cobalt_pipeline.domain,
> +				IPIPE_HRTIMER_IPI,
> +				(ipipe_irq_handler_t)handler,
> +				NULL, NULL);
> +}
> +
> +static inline void pipeline_free_timer_ipi(void)
> +{
> +	return ipipe_free_irq(&cobalt_pipeline.domain,
> +			IPIPE_HRTIMER_IPI);
> +}
> +
> +static inline void pipeline_send_timer_ipi(const struct cpumask *dest)
> +{
> +	ipipe_send_ipi(IPIPE_HRTIMER_IPI, *dest);
> +}
> +
> +#endif
> +
>  #endif /* !_COBALT_KERNEL_IPIPE_PIPELINE_H */
> diff --git a/kernel/cobalt/clock.c b/kernel/cobalt/clock.c
> index 2a5b61760..d73ade3f9 100644
> --- a/kernel/cobalt/clock.c
> +++ b/kernel/cobalt/clock.c
> @@ -228,7 +228,7 @@ void xnclock_core_local_shot(struct xnsched *sched)
>  #ifdef CONFIG_SMP
>  void xnclock_core_remote_shot(struct xnsched *sched)
>  {
> -	ipipe_send_ipi(IPIPE_HRTIMER_IPI, *cpumask_of(xnsched_cpu(sched)));
> +	pipeline_send_timer_ipi(cpumask_of(xnsched_cpu(sched)));
>  }
>  #endif
>  
> diff --git a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
> index e266d5acf..e093676e1 100644
> --- a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
> +++ b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
> @@ -20,10 +20,6 @@
>  
>  #include <linux/xenomai/wrappers.h>
>  
> -#ifdef CONFIG_IPIPE_LEGACY
> -#error "CONFIG_IPIPE_LEGACY must be switched off"
> -#endif
> -
>  #define COBALT_BACKPORT(__sym) __cobalt_backport_ ##__sym
>  
>  /*
> diff --git a/kernel/cobalt/sched.c b/kernel/cobalt/sched.c
> index b16903bd8..a44109e78 100644
> --- a/kernel/cobalt/sched.c
> +++ b/kernel/cobalt/sched.c
> @@ -235,10 +235,7 @@ void xnsched_init_all(void)
>  	}
>  
>  #ifdef CONFIG_SMP
> -	ipipe_request_irq(&xnsched_realtime_domain,
> -			  IPIPE_RESCHEDULE_IPI,
> -			  (ipipe_irq_handler_t)__xnsched_run_handler,
> -			  NULL, NULL);
> +	pipeline_request_resched_ipi(__xnsched_run_handler);
>  #endif
>  }
>  
> @@ -261,7 +258,7 @@ void xnsched_destroy_all(void)
>  	spl_t s;
>  
>  #ifdef CONFIG_SMP
> -	ipipe_free_irq(&xnsched_realtime_domain, IPIPE_RESCHEDULE_IPI);
> +	pipeline_free_resched_ipi();
>  #endif
>  
>  	xnlock_get_irqsave(&nklock, s);
> @@ -860,7 +857,7 @@ static inline int test_resched(struct xnsched *sched)
>  	/* Send resched IPI to remote CPU(s). */
>  	if (unlikely(!cpumask_empty(&sched->resched))) {
>  		smp_mb();
> -		ipipe_send_ipi(IPIPE_RESCHEDULE_IPI, sched->resched);
> +		pipeline_send_resched_ipi(&sched->resched);
>  		cpumask_clear(&sched->resched);
>  	}
>  #endif
> @@ -1280,7 +1277,7 @@ static int vfile_schedstat_next(struct xnvfile_snapshot_iterator *it,
>  
>  scan_irqs:
>  #ifdef CONFIG_XENO_OPT_STATS_IRQS
> -	if (priv->irq >= IPIPE_NR_IRQS)
> +	if (priv->irq >= PIPELINE_NR_IRQS)
>  		return 0;	/* All done. */
>  
>  	ret = xnintr_query_next(priv->irq, &priv->intr_it, p->name);
> diff --git a/kernel/cobalt/timer.c b/kernel/cobalt/timer.c
> index ccd3c3b70..b8c3f5a11 100644
> --- a/kernel/cobalt/timer.c
> +++ b/kernel/cobalt/timer.c
> @@ -578,15 +578,12 @@ EXPORT_SYMBOL_GPL(__xntimer_set_affinity);
>  
>  int xntimer_setup_ipi(void)
>  {
> -	return ipipe_request_irq(&xnsched_realtime_domain,
> -				 IPIPE_HRTIMER_IPI,
> -				 (ipipe_irq_handler_t)xnintr_core_clock_handler,
> -				 NULL, NULL);
> +	return pipeline_request_timer_ipi(xnintr_core_clock_handler);
>  }
>  
>  void xntimer_release_ipi(void)
>  {
> -	ipipe_free_irq(&xnsched_realtime_domain, IPIPE_HRTIMER_IPI);
> +	pipeline_free_timer_ipi();
>  }
>  
>  #endif /* CONFIG_SMP */
> 

Thanks, applied up to here (with the fixup of patch 1), just waiting for
feedback on my comments on patch 7 and beyond.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

