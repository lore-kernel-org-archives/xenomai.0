Message-ID: <43EA310D.70807@domain.hid>
Date: Wed, 08 Feb 2006 18:57:33 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] Slow is faster arch/ppc/syslib/open_pic.c
References: <b647ffbd0601311053s2f9f77c3m@domain.hid>	<43E0BEC1.2060400@domain.hid>	<43E73441.9090702@domain.hid>	<43E8C523.2030107@domain.hid>	<43E8C7CB.8050401@domain.hid>
	<43E9BC7D.6020803@domain.hid>
In-Reply-To: <43E9BC7D.6020803@domain.hid>
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
> Philippe Gerum wrote:
> 
>> Anders Blomdell wrote:
>>
>>> When trying to run Xenomai on PowerPC with OpenPIC, I have (finally) 
>>> found that interrupt latency is much improved with the following patch:
>>>
>>>
>>>
>>> --- arch/ppc/syslib/open_pic.c~ 2006-01-08 03:15:24.000000000 +0100
>>> +++ arch/ppc/syslib/open_pic.c  2006-02-07 16:56:14.000000000 +0100
>>> @@ -820,7 +820,7 @@
>>>   */
>>>  static void openpic_ack_irq(unsigned int irq_nr)
>>>  {
>>> -#ifdef __SLOW_VERSION__
>>> +#if defined(__SLOW_VERSION__) || defined(CONFIG_IPIPE)
>>>         openpic_disable_irq(irq_nr);
>>>         openpic_eoi();
>>>  #else
>>> @@ -831,7 +831,7 @@
>>>
>>>  static void openpic_end_irq(unsigned int irq_nr)
>>>  {
>>> -#ifdef __SLOW_VERSION__
>>> +#if defined(__SLOW_VERSION__) || defined(CONFIG_IPIPE)
>>>         if (!(irq_desc[irq_nr].status & (IRQ_DISABLED|IRQ_INPROGRESS))
>>>             && irq_desc[irq_nr].action)
>>>                 openpic_enable_irq(irq_nr);
>>>
>>>
>>>
>>> The reason for this, is that the fast version doesn't call 
>>> openpic_eoi until the interrupt is ended, which means that all 
>>> RT-interrupts are delayed by a pending Linux interrupt.
>>>
>>
>> Gasp. Will check on my Icecube asap, thanks (a lot).
>>
> 
> The mpc52xx is using its own version of PIC management - which should 
> not induce such delay on eoi, so I cannot experiment this change yet. 
> However, I've revisited your patch so that the OpenPIC code always sends 
> eoi in fast mode, regardless of the interrupt polarity. Could you try 
> the patch below and let me know of the outcome? TIA,
> 

Ok. Drop this to /dev/null. I've misread the original ->ack() code, and as you 
pointed out, this patch would not work. -ENOBRAIN again.

> --- arch/ppc/syslib/open_pic.c~    2005-10-28 02:02:08.000000000 +0200
> +++ arch/ppc/syslib/open_pic.c    2006-02-08 10:30:22.000000000 +0100
> @@ -824,7 +824,9 @@
>      openpic_disable_irq(irq_nr);
>      openpic_eoi();
>  #else
> +#ifndef CONFIG_IPIPE
>      if ((irq_desc[irq_nr].status & IRQ_LEVEL) == 0)
> +#endif /* CONFIG_IPIPE */
>          openpic_eoi();
>  #endif
>  }
> @@ -836,8 +838,10 @@
>          && irq_desc[irq_nr].action)
>          openpic_enable_irq(irq_nr);
>  #else
> +#ifndef CONFIG_IPIPE
>      if ((irq_desc[irq_nr].status & IRQ_LEVEL) != 0)
>          openpic_eoi();
> +#endif /* CONFIG_IPIPE */
>  #endif
>  }
> 
> 


-- 

Philippe.

