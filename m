Message-ID: <43E20074.2040306@domain.hid>
Date: Thu, 02 Feb 2006 13:52:04 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Missing IRQ end function on PowerPC
References: <43CE1C28.6060001@domain.hid>	<17359.34362.870823.168739@domain.hid>	<43CF8ECF.4020805@domain.hid>	<17359.37814.257893.95482@domain.hid>
	<43D5FF83.7050305@domain.hid>
In-Reply-To: <43D5FF83.7050305@domain.hid>
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
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai@xenomai.org

Wolfgang Grandegger wrote:
> Gilles Chanteperdrix wrote:
> 
>> Wolfgang Grandegger wrote:
>>  > Therefore we need a dedicated function to re-enable interrupts in 
>> the  > ISR. We could name it *_end_irq, but maybe *_enable_isr_irq is 
>> more  > obvious. On non-PPC archs it would translate to *_irq_enable. 
>> I  > realized, that *_irq_enable is used in various place/skins and 
>> therefore  > I have not yet provided a patch.
>>
>> The function xnarch_irq_enable seems to be called in only two functions,
>> xintr_enable and xnintr_irq_handler when the flag XN_ISR_ENABLE is set.
>>
>> In any case, since I am not sure if this has to be done at the Adeos
>> level or in Xenomai, we will wait for Philippe to come back and decide.
> 
> 
> Attached is a temporary Xenomai patch fixing the IRQ end problem for the 
> PowerPC arch. I had a closer look to the various IRQ end functions on 
> PowerPC:

Applied and generalized for all archs, thanks.

> 
>   ic_end(unsigned int irq)
>   {
>         ic_ack(irq);
>         if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS))) {
>                 ic_enable(irq);
>         }
>   }
> 
> In most cases the end functions do the same than the begin functions but 
> there are exceptions where the end functions do an additional ic_ack()
> as shown above.
> 
> Wolfgang.
> 
> 
> 
> ------------------------------------------------------------------------
> 
> + diff -u xenomai/include/asm-generic/hal.h.IRQEND xenomai/include/asm-generic/hal.h
> --- xenomai/include/asm-generic/hal.h.IRQEND	2006-01-11 18:03:34.000000000 +0100
> +++ xenomai/include/asm-generic/hal.h	2006-01-19 20:52:40.000000000 +0100
> @@ -357,6 +357,8 @@
>  
>  int rthal_irq_disable(unsigned irq);
>  
> +int rthal_irq_end(unsigned irq);
> +
>  int rthal_irq_host_request(unsigned irq,
>  			   irqreturn_t (*handler)(int irq,
>  						  void *dev_id,
> + diff -u xenomai/include/asm-generic/system.h.IRQEND xenomai/include/asm-generic/system.h
> --- xenomai/include/asm-generic/system.h.IRQEND	2006-01-11 18:03:34.000000000 +0100
> +++ xenomai/include/asm-generic/system.h	2006-01-19 20:50:17.000000000 +0100
> @@ -496,6 +496,12 @@
>      return rthal_irq_disable(irq);
>  }
>  
> +static inline int xnarch_end_irq (unsigned irq)
> +
> +{
> +     return rthal_irq_end(irq);
> +}
> +                                                                                
>  static inline void xnarch_chain_irq (unsigned irq)
>  
>  {
> + diff -u xenomai/include/asm-uvm/system.h.IRQEND xenomai/include/asm-uvm/system.h
> --- xenomai/include/asm-uvm/system.h.IRQEND	2006-01-11 18:03:34.000000000 +0100
> +++ xenomai/include/asm-uvm/system.h	2006-01-19 20:51:36.000000000 +0100
> @@ -296,6 +296,13 @@
>      return -ENOSYS;
>  }
>  
> +static inline int xnarch_end_irq (unsigned irq)
> +
> +{
> +    return -ENOSYS;
> +}
> +                                                                                
> +
>  static inline void xnarch_chain_irq (unsigned irq)
>  
>  { /* Nop */ }
> + diff -u xenomai/ksrc/arch/generic/hal.c.IRQEND xenomai/ksrc/arch/generic/hal.c
> --- xenomai/ksrc/arch/generic/hal.c.IRQEND	2006-01-11 18:03:42.000000000 +0100
> +++ xenomai/ksrc/arch/generic/hal.c	2006-01-19 20:54:06.000000000 +0100
> @@ -1156,6 +1156,7 @@
>  EXPORT_SYMBOL(rthal_irq_release);
>  EXPORT_SYMBOL(rthal_irq_enable);
>  EXPORT_SYMBOL(rthal_irq_disable);
> +EXPORT_SYMBOL(rthal_irq_end);
>  EXPORT_SYMBOL(rthal_irq_host_request);
>  EXPORT_SYMBOL(rthal_irq_host_release);
>  EXPORT_SYMBOL(rthal_irq_host_pend);
> + diff -u xenomai/ksrc/arch/powerpc/hal.c.IRQEND xenomai/ksrc/arch/powerpc/hal.c
> --- xenomai/ksrc/arch/powerpc/hal.c.IRQEND	2006-01-11 18:03:41.000000000 +0100
> +++ xenomai/ksrc/arch/powerpc/hal.c	2006-01-19 21:56:19.000000000 +0100
> @@ -356,6 +356,27 @@
>      return 0;
>  }
>  
> +int rthal_irq_end (unsigned irq)
> +
> +{
> +    if (irq >= IPIPE_NR_XIRQS)
> +	return -EINVAL;
> +
> +    if (rthal_irq_descp(irq)->handler != NULL)
> +        {
> +	if (rthal_irq_descp(irq)->handler->end != NULL)
> +	    rthal_irq_descp(irq)->handler->end(irq);
> +	else if (rthal_irq_descp(irq)->handler->enable != NULL)
> +	    rthal_irq_descp(irq)->handler->enable(irq);
> +	else
> +	    return -ENODEV;
> +	}
> +    else
> +	return -ENODEV;
> +
> +    return 0;
> +}
> +
>  static inline int do_exception_event (unsigned event, unsigned domid, void *data)
>  
>  {
> + diff -u xenomai/ksrc/nucleus/intr.c.IRQEND xenomai/ksrc/nucleus/intr.c
> --- xenomai/ksrc/nucleus/intr.c.IRQEND	2006-01-11 18:03:42.000000000 +0100
> +++ xenomai/ksrc/nucleus/intr.c	2006-01-19 20:42:53.000000000 +0100
> @@ -363,7 +363,7 @@
>      ++intr->hits;
>  
>      if (s & XN_ISR_ENABLE)
> -	xnarch_enable_irq(irq);
> +	xnarch_end_irq(irq);
>  
>      if (s & XN_ISR_CHAINED)
>  	xnarch_chain_irq(irq);
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

