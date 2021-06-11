Subject: Re: [PATCH] cobalt: dovetail: fix SMP kernel boot on uniprocessor
 machine
References: <20210611153002.2416047-1-rpm@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <7e140b27-91f4-51f3-e0f1-e02aa955622c@siemens.com>
Date: Fri, 11 Jun 2021 18:24:10 +0200
MIME-Version: 1.0
In-Reply-To: <20210611153002.2416047-1-rpm@xenomai.org>
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

On 11.06.21 17:30, Philippe Gerum via Xenomai wrote:
> From: Philippe Gerum <rpm@xenomai.org>
> 
> We may be running a SMP kernel on a uniprocessor machine whose
> interrupt controller supports no IPI. We should attempt to hook IPIs
> only if the hardware can support multiple CPUs, otherwise it is
> unneeded and poised to fail.
> 
> Signed-off-by: Philippe Gerum <rpm@xenomai.org>
> ---
>  .../kernel/dovetail/pipeline/pipeline.h       |  9 +++++--
>  kernel/cobalt/dovetail/tick.c                 | 26 +++++++++++++------
>  2 files changed, 25 insertions(+), 10 deletions(-)
> 
> diff --git a/include/cobalt/kernel/dovetail/pipeline/pipeline.h b/include/cobalt/kernel/dovetail/pipeline/pipeline.h
> index 980350dce..2ee7b3210 100644
> --- a/include/cobalt/kernel/dovetail/pipeline/pipeline.h
> +++ b/include/cobalt/kernel/dovetail/pipeline/pipeline.h
> @@ -6,6 +6,7 @@
>  #define _COBALT_KERNEL_DOVETAIL_PIPELINE_H
>  
>  #include <linux/irq_pipeline.h>
> +#include <linux/cpumask.h>
>  #include <cobalt/kernel/assert.h>
>  #include <asm/xenomai/features.h>
>  #include <asm/xenomai/syscall.h>
> @@ -37,6 +38,9 @@ irqreturn_t pipeline_reschedule_ipi_handler(int irq, void *dev_id);
>  
>  static inline int pipeline_request_resched_ipi(void (*handler)(void))
>  {
> +	if (num_possible_cpus() == 1)
> +		return 0;
> +
>  	/* Trap the out-of-band rescheduling interrupt. */
>  	return __request_percpu_irq(RESCHEDULE_OOB_IPI,
>  			pipeline_reschedule_ipi_handler,
> @@ -47,8 +51,9 @@ static inline int pipeline_request_resched_ipi(void (*handler)(void))
>  
>  static inline void pipeline_free_resched_ipi(void)
>  {
> -	/* Release the out-of-band rescheduling interrupt. */
> -	free_percpu_irq(RESCHEDULE_OOB_IPI, &cobalt_machine_cpudata);
> +	if (num_possible_cpus() > 1)
> +		/* Release the out-of-band rescheduling interrupt. */
> +		free_percpu_irq(RESCHEDULE_OOB_IPI, &cobalt_machine_cpudata);
>  }
>  
>  static inline void pipeline_send_resched_ipi(const struct cpumask *dest)
> diff --git a/kernel/cobalt/dovetail/tick.c b/kernel/cobalt/dovetail/tick.c
> index c945f7da4..ac343e4d3 100644
> --- a/kernel/cobalt/dovetail/tick.c
> +++ b/kernel/cobalt/dovetail/tick.c
> @@ -146,12 +146,20 @@ int pipeline_install_tick_proxy(void)
>  	int ret;
>  
>  #ifdef CONFIG_SMP
> -	ret = __request_percpu_irq(TIMER_OOB_IPI,
> -				tick_ipi_handler,
> -				IRQF_OOB, "Xenomai timer IPI",
> -				&cobalt_machine_cpudata);
> -	if (ret)
> -		return ret;
> +	/*
> +	 * We may be running a SMP kernel on a uniprocessor machine
> +	 * whose interrupt controller provides no IPI: attempt to hook
> +	 * the timer IPI only if the hardware can support multiple
> +	 * CPUs.
> +	 */
> +	if (num_possible_cpus() > 1) {
> +		ret = __request_percpu_irq(TIMER_OOB_IPI,
> +					tick_ipi_handler,
> +					IRQF_OOB, "Xenomai timer IPI",
> +					&cobalt_machine_cpudata);
> +		if (ret)
> +			return ret;
> +	}
>  #endif
>  
>  	/* Install the proxy tick device */
> @@ -163,7 +171,8 @@ int pipeline_install_tick_proxy(void)
>  
>  fail_proxy:
>  #ifdef CONFIG_SMP
> -	free_percpu_irq(TIMER_OOB_IPI, &cobalt_machine_cpudata);
> +	if (num_possible_cpus() > 1)
> +		free_percpu_irq(TIMER_OOB_IPI, &cobalt_machine_cpudata);
>  #endif
>  
>  	return ret;
> @@ -175,6 +184,7 @@ void pipeline_uninstall_tick_proxy(void)
>  	tick_uninstall_proxy(&xnsched_realtime_cpus);
>  
>  #ifdef CONFIG_SMP
> -	free_percpu_irq(TIMER_OOB_IPI, &cobalt_machine_cpudata);
> +	if (num_possible_cpus() > 1)
> +		free_percpu_irq(TIMER_OOB_IPI, &cobalt_machine_cpudata);
>  #endif
>  }
> 

Applied to next, thanks.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

