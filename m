Message-ID: <43B25CAB.7090603@domain.hid>
Date: Wed, 28 Dec 2005 10:36:43 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [rt shared irqs] ipipe-related changes (draft)
References: <b647ffbd0512260117n7023fb93h@domain.hid>
In-Reply-To: <b647ffbd0512260117n7023fb93h@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: xenomai@xenomai.org

Hi Dmitry,

Dmitry Adamushko wrote:
> Hi everybody,
> 
> the enclosed patches (the first version, hence it's still raw) are
> supposed to build the basis needed on the ipipe layer for adding
> support of real-time shared interrupts. As a side effect, the
> irq_trampoline() layer has been eliminated and the irq processing
> chain has become shorter.

Mm, it seems that everybody is working except me these days. Ah! these 
are delightfully unfair times.

> 
> Some points are more likely to be changed in the next iteration (e.g.
> __ipipe_irq_cookie() vs. changing the ipipe_virtualize_irq()
> interface).

Ack.

> The struct rthal_realtime_irq::hits[per-IRQ] is missed so far.
> 

I think we should move this counter to the Adeos layer directly and 
remove it from the HAL, in parallel to maintaining the current irq_hits 
(which should be renamed irq_pending_count or something along these 
lines); doing so would likely reduce the number of cache misses since 
the IRQ syncer is already peeking at the same memory area before firing 
the handler.

> Anyway, comments are very wellcome.
>

A few comments follow, but I would definitely merge something along 
these lines for the 1.1 series.

> 
> --
> Best regards,
> Dmitry Adamushko
> 
> 
> ------------------------------------------------------------------------
> 
> diff -urp linux-2.6.14.2-ipipe-1.0-10/arch/i386/kernel/ipipe-core.c linux-2.6.14.2-ipipe-1.0-10-ext/arch/i386/kernel/ipipe-core.c
> --- linux-2.6.14.2-ipipe-1.0-10/arch/i386/kernel/ipipe-core.c	2005-12-22 14:15:17.000000000 +0100
> +++ linux-2.6.14.2-ipipe-1.0-10-ext/arch/i386/kernel/ipipe-core.c	2005-12-23 16:37:32.000000000 +0100
> @@ -98,13 +98,14 @@ static void (*__ipipe_cpu_sync) (void);
>  	                 "pushl %%edx\n\t" \
>  	                 "pushl %%ecx\n\t" \
>  	                 "pushl %%ebx\n\t" \
> +			 "pushl %2\n\t" \
>                           "pushl %%eax\n\t" \
>                           "call *%1\n\t" \
> -			 "addl $4,%%esp\n\t" \
> +			 "addl $8,%%esp\n\t" \
>  	                 "jmp ret_from_intr\n\t" \
>  	                 "1:\n" \
>  			 : /* no output */ \
> -			 : "a" (irq), "m" ((ipd)->irqs[irq].handler))
> +			 : "a" (irq), "m" ((ipd)->irqs[irq].handler), "r" ((ipd)->irqs[irq].cookie))
>  
>  static __inline__ unsigned long flnz(unsigned long word)
>  {
> @@ -125,7 +126,7 @@ int __ipipe_ack_system_irq(unsigned irq)
>  
>  /* Always called with hw interrupts off. */
>  
> -void __ipipe_do_critical_sync(unsigned irq)
> +void __ipipe_do_critical_sync(unsigned irq, void *cookie)
>  {
>  	ipipe_declare_cpuid;
>  
> @@ -301,7 +302,7 @@ void fastcall __ipipe_sync_stage(unsigne
>  				local_irq_disable_hw();
>  			} else {
>  				__clear_bit(IPIPE_SYNC_FLAG, &cpudata->status);
> -				ipd->irqs[irq].handler(irq);
> +				ipd->irqs[irq].handler(irq, ipd->irqs[irq].cookie);
>  				__set_bit(IPIPE_SYNC_FLAG, &cpudata->status);
>  			}
>  
> @@ -415,7 +416,7 @@ int fastcall __ipipe_send_ipi (unsigned 
>  
>  int ipipe_virtualize_irq(struct ipipe_domain *ipd,
>  			 unsigned irq,
> -			 void (*handler) (unsigned irq),
> +			 ipipe_irq_handler_t handler,
>  			 int (*acknowledge) (unsigned irq),

Let's define ipipe_irq_ackfn_t while we are at it.

<snip>

> +static void rthal_apc_handler (unsigned virq, void *cookie)
>  
>  {
>      void (*handler)(void *), *cookie;
> @@ -650,7 +631,7 @@ static int rthal_apc_thread (void *data)
>      return 0;
>  }
>  
> -void rthal_apc_kicker (unsigned virq)
> +void rthal_apc_kicker (unsigned virq, void *cookie)
>  
>  {
>      wake_up_process(rthal_apc_servers[smp_processor_id()]);
> @@ -877,14 +858,14 @@ static int irq_read_proc (char *page,
>  
>      for (irq = 0; irq < IPIPE_NR_IRQS; irq++) {
>  
> -	if (rthal_realtime_irq[irq].handler == NULL)
> -	    continue;
> +//	if (rthal_realtime_irq[irq].handler == NULL)
> +//	    continue;
>  
>  	p += sprintf(p,"\n%3d:",irq);
>  
> -	for_each_online_cpu(cpu) {
> -	    p += sprintf(p,"%12lu",rthal_realtime_irq[irq].hits[cpu]);
> -	}
> +//	for_each_online_cpu(cpu) {
> +//	    p += sprintf(p,"%12lu",rthal_realtime_irq[irq].hits[cpu]);
> +//	}
>      }

Likely some cleanup here.

>  
>      p += sprintf(p,"\n");
> @@ -1093,6 +1074,9 @@ int rthal_init (void)
>  			       &rthal_apc_trampoline,
>  			       NULL,
>  			       IPIPE_HANDLE_MASK);
> +
> +    rthal_irq_cookie(rthal_current_domain, irq) = NULL;
> +
>      if (err)
>      {
>          printk(KERN_ERR "Xenomai: Failed to virtualize IRQ.\n");
> diff -urp xenomai-2.1-clean/ksrc/skins/rtai/intr.c xenomai-2.1-ext/ksrc/skins/rtai/intr.c
> --- xenomai-2.1-clean/ksrc/skins/rtai/intr.c	2005-11-21 21:52:58.000000000 +0100
> +++ xenomai-2.1-ext/ksrc/skins/rtai/intr.c	2005-12-22 13:38:34.000000000 +0100
> @@ -24,7 +24,7 @@ int rt_request_irq (unsigned irq,
>  		    void (*handler)(unsigned irq, void *cookie),
>  		    void *cookie)
>  {
> -    return rthal_irq_request(irq,handler,NULL,cookie);
> +    return xnarch_hook_irq(irq,handler,NULL,cookie);
>  }

Oops, yes. Indeed.

-- 

Philippe.

