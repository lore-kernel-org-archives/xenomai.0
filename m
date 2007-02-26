Message-ID: <45E2F4A6.4090005@domain.hid>
Date: Mon, 26 Feb 2007 15:54:30 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Kernel lockup with lapic on old AMD Athlon
References: <45E1641F.1050009@domain.hid>	
	<17889.38390.369037.176076@domain.hid>	
	<45E1A6C0.6030908@domain.hid>
	<1172441002.12230.57.camel@domain.hid>	
	<45E2A380.1050705@domain.hid>
	<1172498970.1764.125.camel@domain.hid>
In-Reply-To: <1172498970.1764.125.camel@domain.hid>
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
To: rpm@xenomai.org
Cc: xenomai-core <xenomai@xenomai.org>

Philippe Gerum wrote:
> On Mon, 2007-02-26 at 10:08 +0100, Wolfgang Grandegger wrote:
>> Philippe Gerum wrote:
>>> On Sun, 2007-02-25 at 16:09 +0100, Wolfgang Grandegger wrote:
>>>> Gilles Chanteperdrix wrote:
>>>>> Wolfgang Grandegger wrote:
>>>>>  > Hello,
>>>>>  > 
>>>>>  > here is the boot log of an hangup of 2.6.20 with I-pipe 1.7-02 and 
>>>>>  > Xenomai todays trunk. I already reported this hangup a while ago but now 
>>>>>  > I get an oops. At that time Gilles said that lapic on old Athlons might 
>>>>>  > be buggy. Does the attached boot log confirm this assumption? 2.6.20-rt8 
>>>>>  > is working, BTW.
>>>>>
>>>>> What I had observed with an old Athlon were some random lockups. I was
>>>>> trying to setup a samba print server at the time, and the lockup always
>>>>> occured when some windows machine was trying to use the shared printer
>>>>> through network. I think the IO-APIC was also enabled. Then, at some
>>>>> later time, I read somewhere on the internet that the IO-APIC or LAPIC
>>>>> could be buggy on some Athlons, so I understood what had happened to
>>>>> me. So, I did not investigate this issue any further.
>>>> I didn't either, especially because it works with lapic disabled in the 
>>>> kernel config. I just thought that this oops might be useful to somebody.
>>>>
> 
> Ok, next try:
> 
> --- ksrc/arch/i386/hal.c	(revision 2256)
> +++ ksrc/arch/i386/hal.c	(working copy)
> @@ -119,23 +119,30 @@
>      }
>  }
>  
> -#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,19)
> -irqreturn_t rthal_broadcast_to_local_timers(int irq,
> -                                            void *dev_id, struct pt_regs *regs)
> -#else /* >= 2.6.19 */
> -irqreturn_t rthal_broadcast_to_local_timers(int irq,
> -                                            void *dev_id)
> -#endif
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
> +#include <asm/smpboot.h>
> +static inline void send_IPI_all(int vector)
>  {
> -    unsigned long flags;
> +	unsigned long flags;
>  
> -    rthal_local_irq_save_hw(flags);
> -    apic_wait_icr_idle();
> -    apic_write_around(APIC_ICR,
> -                      APIC_DM_FIXED | APIC_DEST_ALLINC | LOCAL_TIMER_VECTOR);
> -    rthal_local_irq_restore_hw(flags);
> +	rthal_local_irq_save_hw(flags);
> +	apic_wait_icr_idle();
> +	apic_write_around(APIC_ICR,
> +			  APIC_DM_FIXED | APIC_DEST_ALLINC | INT_DEST_ADDR_MODE | vector);
> +	rthal_local_irq_restore_hw(flags);
> +}
> +#else
> +#include <mach_ipi.h>
> +#endif
>  
> -    return IRQ_HANDLED;
> +DECLARE_LINUX_IRQ_HANDLER(rthal_broadcast_to_local_timers, irq, dev_id)
> +{
> +#ifdef CONFIG_SMP
> +	send_IPI_all(LOCAL_TIMER_VECTOR);
> +#else
> +	rthal_trigger_irq(LOCAL_TIMER_VECTOR -  FIRST_EXTERNAL_VECTOR);
> +#endif
> +	return IRQ_HANDLED;
>  }
>  
>  unsigned long rthal_timer_calibrate(void)
> Index: include/asm-i386/wrappers.h
> ===================================================================
> --- include/asm-i386/wrappers.h	(revision 2256)
> +++ include/asm-i386/wrappers.h	(working copy)
> @@ -131,12 +131,19 @@
>  						void *dev_id,
>  						struct pt_regs *regs);
>  
> +#define DECLARE_LINUX_IRQ_HANDLER(fn, irq, dev_id)		\
> +	irqreturn_t fn(int irq, void *dev_id, struct pt_regs *regs)
> +
>  #define rthal_irq_chip_end(irq)	rthal_irq_chip_enable(irq)
>  #else /* >= 2.6.19 */
>  #define rthal_irq_chip_enable(irq)   ({ rthal_irq_descp(irq)->chip->enable(irq); 0; })
>  #define rthal_irq_chip_disable(irq)  ({ rthal_irq_descp(irq)->chip->disable(irq); 0; })
>  #define rthal_irq_chip_end(irq)      ({ rthal_irq_descp(irq)->ipipe_end(irq, rthal_irq_descp(irq)); 0; })
>  typedef irq_handler_t rthal_irq_host_handler_t;
> +
> +#define DECLARE_LINUX_IRQ_HANDLER(fn, irq, dev_id)	\
> +	irqreturn_t fn(int irq, void *dev_id)
> +
>  #endif
>  
>  #endif /* _XENO_ASM_I386_WRAPPERS_H */

That one worked. At least the kernel boots now.

Thanks.

Wolfgang.

