Subject: Re: [PATCH v2][wip/dovetail] cobalt/sched: init RESCHEDULE_OOB_IPI
 and register interrupt handler
References: <MWHPR11MB17100BC060C1287A9A6CC7DAF21E0@MWHPR11MB1710.namprd11.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <5d39ef29-77d6-68da-c4e0-10bdcf2358a8@siemens.com>
Date: Tue, 27 Oct 2020 17:46:38 +0100
MIME-Version: 1.0
In-Reply-To: <MWHPR11MB17100BC060C1287A9A6CC7DAF21E0@MWHPR11MB1710.namprd11.prod.outlook.com>
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
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 19.10.20 03:14, Chen, Hongzhan wrote:
> create and register RESCHEDULE_OOB_IPI interrupt handler
> 
> Signed-off-by: hongzha1 <hongzhan.chen@intel.com>
> 
> diff --git a/kernel/cobalt/sched.c b/kernel/cobalt/sched.c
> index f39becb90..82a51ce93 100644
> --- a/kernel/cobalt/sched.c
> +++ b/kernel/cobalt/sched.c
> @@ -30,6 +30,13 @@
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/cobalt-core.h>
>  
> +struct xn_machine_cpudata {
> +};
> +
> +DEFINE_PER_CPU(struct xn_machine_cpudata, xn_machine_cpudata);
> +
> +static void xnsched_destroy(struct xnsched *sched);
> +
>  /**
>   * @ingroup cobalt_core
>   * @defgroup cobalt_core_sched Thread scheduling control
> @@ -224,10 +231,18 @@ static void xnsched_init(struct xnsched *sched, int cpu)
>  #endif /* CONFIG_XENO_OPT_WATCHDOG */
>  }
>  
> +static irqreturn_t reschedule_interrupt(int irq, void *dev_id)
> +{
> +	__xnsched_run_handler();
> +
> +	return IRQ_HANDLED;
> +}
> +
>  void xnsched_init_all(void)
>  {
>  	struct xnsched *sched;
>  	int cpu;
> +	int ret;
>  
>  	for_each_online_cpu(cpu) {
>  		sched = &per_cpu(nksched, cpu);
> @@ -235,12 +250,26 @@ void xnsched_init_all(void)
>  	}
>  
>  #ifdef CONFIG_SMP
> -#warning TODO
>  /*	ipipe_request_irq(&xnsched_realtime_domain,
>  			  IPIPE_RESCHEDULE_IPI,
>  			  (ipipe_irq_handler_t)__xnsched_run_handler,
>  			  NULL, NULL);*/
> +	ret = __request_percpu_irq(RESCHEDULE_OOB_IPI,
> +			reschedule_interrupt,
> +			IRQF_OOB,
> +			"Xenomai reschedule",
> +			&xn_machine_cpudata);
> +	if (ret)
> +		goto cleanup_sched;
>  #endif
> +	return;
> +
> +cleanup_sched:
> +	for_each_online_cpu(cpu) {
> +		sched = xnsched_struct(cpu);
> +		xnsched_destroy(sched);
> +	}
> +
>  }
>  
>  static void xnsched_destroy(struct xnsched *sched)
> @@ -264,6 +293,7 @@ void xnsched_destroy_all(void)
>  #ifdef CONFIG_SMP
>  #warning TODO
>  //	ipipe_free_irq(&xnsched_realtime_domain, IPIPE_RESCHEDULE_IPI);
> +	free_percpu_irq(RESCHEDULE_OOB_IPI, &xn_machine_cpudata);

Can we drop this TODO then? Just to remain a good overview about which
places still need a look.

Jan

>  #endif
>  
>  	xnlock_get_irqsave(&nklock, s);
> 

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

