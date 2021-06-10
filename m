Subject: Re: [PATCH] cobalt/tick: dovetail: Fix non-SMP build
References: <be8ef36d-5e37-d88e-c088-fcb76e43bdc2@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <fa53a917-b07f-1006-3c6d-d1d525d00804@siemens.com>
Date: Thu, 10 Jun 2021 18:44:53 +0200
MIME-Version: 1.0
In-Reply-To: <be8ef36d-5e37-d88e-c088-fcb76e43bdc2@siemens.com>
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
To: Xenomai <xenomai@xenomai.org>

On 10.06.21 18:39, Jan Kiszka via Xenomai wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  kernel/cobalt/dovetail/tick.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/kernel/cobalt/dovetail/tick.c b/kernel/cobalt/dovetail/tick.c
> index 81eaab84a..570f6a1f5 100644
> --- a/kernel/cobalt/dovetail/tick.c
> +++ b/kernel/cobalt/dovetail/tick.c
> @@ -130,23 +130,27 @@ static void setup_proxy(struct clock_proxy_device *dev)
>  	__this_cpu_write(proxy_device, dev);
>  }
>  
> +#ifdef CONFIG_SMP
>  static irqreturn_t tick_ipi_handler(int irq, void *dev_id)
>  {
>  	xnintr_core_clock_handler();
>  
>  	return IRQ_HANDLED;
>  }
> +#endif
>  
>  int pipeline_install_tick_proxy(void)
>  {
>  	int ret;
>  
> +#ifdef CONFIG_SMP
>  	ret = __request_percpu_irq(TIMER_OOB_IPI,
>  				tick_ipi_handler,
>  				IRQF_OOB, "Xenomai timer IPI",
>  				&cobalt_machine_cpudata);
>  	if (ret)
>  		return ret;
> +#endif
>  
>  	/* Install the proxy tick device */
>  	ret = tick_install_proxy(setup_proxy, &xnsched_realtime_cpus);
> @@ -156,7 +160,9 @@ int pipeline_install_tick_proxy(void)
>  	return 0;
>  
>  fail_proxy:
> +#ifdef CONFIG_SMP
>  	free_percpu_irq(TIMER_OOB_IPI, &cobalt_machine_cpudata);
> +#endif
>  
>  	return ret;
>  }
> @@ -166,5 +172,7 @@ void pipeline_uninstall_tick_proxy(void)
>  	/* Uninstall the proxy tick device. */
>  	tick_uninstall_proxy(&xnsched_realtime_cpus);
>  
> +#ifdef CONFIG_SMP
>  	free_percpu_irq(TIMER_OOB_IPI, &cobalt_machine_cpudata);
> +#endif
>  }
> 

Should have been more precise: This definitely breaks on arm, possibly
on other archs as well.

Found while diff'ing broken to (possibly) working .configs for
BeagleBone Black.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

