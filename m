Message-ID: <BLU436-SMTP1205A559393D24D1722E9B0F01F0@phx.gbl>
References: <BLU436-SMTP777DC6298F62C65606DFEF0100@phx.gbl>
 <20151114071534.GG1820@hermes.click-hack.org>
From: Mathieu Rondonneau <mathieu_rondonneau@hotmail.com>
Date: Sat, 14 Nov 2015 17:03:30 -0800
MIME-Version: 1.0
In-Reply-To: <20151114071534.GG1820@hermes.click-hack.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] IPIPE patch for BCM2709/RPI2.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 15-11-13 11:15 PM, Gilles Chanteperdrix wrote:
>> +#include <linux/spinlock.h>
>> +
>> +#ifdef CONFIG_IPIPE
>> +#include <linux/ipipe.h>
>> +static IPIPE_DEFINE_RAW_SPINLOCK(irq_controller_lock);
>> +#else
>> +static DEFINE_RAW_SPINLOCK(irq_controller_lock);
>> +#endif
> 
> #ifdefery not needed here:
> - you can always include linux/ipipe.h
> - which will define IPIPE_DEFINE_RAW_SPINLOCK to be
> DEFINE_RAW_SPINLOCK if CONFIG_IPIPE is disabled.
> 
Will fix in next patch.

>>
>>  /* For support of kernels >= 3.0 assume only one VIC for now*/
>>  static unsigned int remap_irqs[(INTERRUPT_ARASANSDIO + 1) -
>> INTERRUPT_JPEG] = {
>> @@ -54,6 +62,9 @@ static void armctrl_mask_irq(struct irq_data *d)
>>  		0
>>  	};
>>  	int i;
>> +	unsigned long flags;
>> +
>> +	raw_spin_lock_irqsave_cond(&irq_controller_lock, flags);
>>  	if (d->irq >= FIQ_START) {
>>  		writel(0, __io_address(ARM_IRQ_FAST));
>>  	} else if (d->irq >= IRQ_ARM_LOCAL_CNTPSIRQ && d->irq <
>> IRQ_ARM_LOCAL_CNTPSIRQ + 4) {
>> @@ -79,6 +90,7 @@ static void armctrl_mask_irq(struct irq_data *d)
>>  	} else if (d->irq == INTERRUPT_ARM_LOCAL_PMU_FAST) {
>>  		writel(0xf, __io_address(ARM_LOCAL_PM_ROUTING_CLR));
>>  	} else { printk("%s: %d\n", __func__, d->irq); BUG(); }
>> +	raw_spin_unlock_irqrestore_cond(&irq_controller_lock, flags);
>>  }
> 
> Not sure why you need a spinlock here. If mainline does not need
> one, chances are I-pipe does not need one either.
>
It looks safer to me to have those. I can remove as I am unsure if they
are required.

>>
>>  static void armctrl_unmask_irq(struct irq_data *d)
>> @@ -90,6 +102,9 @@ static void armctrl_unmask_irq(struct irq_data *d)
>>  		0
>>  	};
>>  	int i;
>> +	unsigned long flags;
>> +
>> +	raw_spin_lock_irqsave_cond(&irq_controller_lock, flags);
>>  	if (d->irq >= FIQ_START) {
>>  		unsigned int data;
>>  		if (num_online_cpus() > 1) {
>> @@ -124,6 +139,7 @@ static void armctrl_unmask_irq(struct irq_data *d)
>>  	} else if (d->irq == INTERRUPT_ARM_LOCAL_PMU_FAST) {
>>  		writel(0xf, __io_address(ARM_LOCAL_PM_ROUTING_SET));
>>  	} else { printk("%s: %d\n", __func__, d->irq); BUG(); }
>> +	raw_spin_unlock_irqrestore_cond(&irq_controller_lock, flags);
>>  }
> 
> Same remark.
>
It looks safer to me to have those. I can remove as I am unsure if they
are required. Mainline should have this in my opinion. This is not ipipe
specific.
I think that's where the pre.patch might come in (to add mainline
specifics).
This could be clarified in the doc
(https://xenomai.org/2014/09/porting-xenomai-dual-kernel-to-a-new-arm-soc/#Working_with_vendor_forks)

>>
>>  #ifdef CONFIG_OF
>> @@ -333,6 +349,10 @@ static struct irq_chip armctrl_chip = {
>>  	.irq_mask = armctrl_mask_irq,
>>  	.irq_unmask = armctrl_unmask_irq,
>>  	.irq_set_wake = armctrl_set_wake,
>> +#ifdef CONFIG_IPIPE
>> +	.irq_hold = armctrl_mask_irq,
>> +	.irq_release = armctrl_unmask_irq,
>> +#endif
>>  };
>>
>>  /**
>> diff --git a/arch/arm/mach-bcm2709/bcm2708_gpio.c
>> b/arch/arm/mach-bcm2709/bcm2708_gpio.c
>> index c1e9254..49485ab 100644
>> --- a/arch/arm/mach-bcm2709/bcm2708_gpio.c
>> +++ b/arch/arm/mach-bcm2709/bcm2708_gpio.c
>> @@ -24,6 +24,9 @@
>>  #include <linux/pinctrl/consumer.h>
>>
>>  #include <linux/platform_data/bcm2708.h>
>> +#ifdef CONFIG_IPIPE
>> +#include <linux/ipipe.h>
>> +#endif
> 
> Same as above.
>
Will fix in next patch.

>>
>>  #define BCM_GPIO_DRIVER_NAME "bcm2708_gpio"
>>  #define DRIVER_NAME BCM_GPIO_DRIVER_NAME
>> @@ -56,7 +59,11 @@ enum { GPIO_FSEL_INPUT, GPIO_FSEL_OUTPUT,
>>  	 * the GPIO code. This also makes the case of a GPIO routine call from
>>  	 * the IRQ code simpler.
>>  	 */
>> -static DEFINE_SPINLOCK(lock);	/* GPIO registers */
>> +#ifdef CONFIG_IPIPE
>> +static IPIPE_DEFINE_SPINLOCK(lock); /* GPIO registers */
>> +#else
>> +static DEFINE_SPINLOCK(lock); /* GPIO registers */
>> +#endif
> 
> Same as above.
>
Will fix in next patch.

>>
>>  struct bcm2708_gpio {
>>  	struct list_head list;
>> @@ -294,7 +301,11 @@ static irqreturn_t bcm2708_gpio_interrupt(int irq,
>> void *dev_id)
>>  			if (!(level_bits & (1<<i)))
>>  				writel(1<<i,
>>  				       __io_address(GPIO_BASE) + GPIOEDS(bank));
>> +#ifdef CONFIG_IPIPE
>> +			ipipe_handle_demuxed_irq(gpio_to_irq(gpio));
>> +#else
>>  			generic_handle_irq(gpio_to_irq(gpio));
>> +#endif
> 
> No #ifdef needed here, ipipe_handle_demuxed_irq is defined to
> generic_handle_irq if CONFIG_IPIPE is disabled.
>
Will fix in next patch.

>>  			/* ack level triggered IRQ after handling them */
>>  			if (level_bits & (1<<i))
>>  				writel(1<<i,
>> diff --git a/arch/arm/mach-bcm2709/bcm2709.c
>> b/arch/arm/mach-bcm2709/bcm2709.c
>> index 6bfd99e..4dd796c 100644
>> --- a/arch/arm/mach-bcm2709/bcm2709.c
>> +++ b/arch/arm/mach-bcm2709/bcm2709.c
>> @@ -1072,11 +1072,13 @@ static void __init bcm2709_timer_init(void)
>>  static void __init bcm2709_timer_init(void)
>>  {
>>  	extern void dc4_arch_timer_init(void);
>> +#ifndef CONFIG_IPIPE
>>  	// timer control
>>  	writel(0, __io_address(ARM_LOCAL_CONTROL));
>>  	// timer pre_scaler
>>  	writel(0x80000000, __io_address(ARM_LOCAL_PRESCALER)); // 19.2MHz
>>  	//writel(0x06AAAAAB, __io_address(ARM_LOCAL_PRESCALER)); // 1MHz
>> +#endif
>>
>>  	if (use_dt)
>>  	{
>> @@ -1085,6 +1087,13 @@ static void __init bcm2709_timer_init(void)
>>  	}
>>  	else
>>  		dc4_arch_timer_init();
>> +
>> +#ifdef CONFIG_IPIPE
>> +	// timer control
>> +	writel(0, __io_address(ARM_LOCAL_CONTROL));
>> +	// timer pre_scaler
>> +	writel(0x80000000, __io_address(ARM_LOCAL_PRESCALER)); // 19.2MHz
>> +#endif
>>  }
> 
> Why is that needed?
> 
>
Bad handling in mainline to me, interrupt starts firing before handler
gets set (timer_init).

>>
>>  #endif
>> diff --git a/arch/arm/mach-bcm2709/include/mach/entry-macro.S
>> b/arch/arm/mach-bcm2709/include/mach/entry-macro.S
>> index 101d9f1..9e089c8 100644
>> --- a/arch/arm/mach-bcm2709/include/mach/entry-macro.S
>> +++ b/arch/arm/mach-bcm2709/include/mach/entry-macro.S
>> @@ -52,7 +52,11 @@
>>  	dsb
>>  	mov	r1, sp
>>  	adr	lr, BSYM(1b)
>> -	b	do_IPI
>> +#ifdef CONFIG_IPIPE
>> +        b	__ipipe_grab_ipi
>> +#else
>> +        b	do_IPI
>> +#endif
>>
>>  1030:
>>  	/* check gpu interrupt */
>> @@ -107,7 +111,11 @@
>>  	@ routine called with r0 = irq number, r1 = struct pt_regs *
>>  	@
>>  	adr	lr, BSYM(1b)
>> -	b	asm_do_IRQ
>> +#ifdef CONFIG_IPIPE
>> +        b	__ipipe_grab_irq
>> +#else
>> +        b	asm_do_IRQ
>> +#endif
>>
>>  1020:	@ EQ will be set if no irqs pending
>>  	.endm
> 
> I believe this way of defining irqs handlers has been deprecated for
> a long long time. It prevents kernel to be built for multiple
> platforms.
> 
bcm2709 redefines the arch_irq_handler_default from
arch/arm/include/asm/entry-macro-multi.S into this file to add some IPI
and videocore handling in the macro. I have just ported the ipipe
changes from the default arm macro to the bcm2709 one.


