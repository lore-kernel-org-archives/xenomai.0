Subject: Re: [Xenomai-core] Xenomai on PXA
From: Bart Jonkers <jonkersbart@domain.hid>
In-Reply-To: <17616.59841.283196.201008@domain.hid>
References: <200607071703.10700.vagninu@domain.hid>
	<17582.50372.830923.414981@domain.hid>
	<44B34343.9F56F13@domain.hid>
	<17595.47131.142881.132531@domain.hid>
	<1153153788.11603.2.camel@domain.hid>
	<17595.49478.157044.654500@domain.hid>
	<1154334859.9569.12.camel@domain.hid>
	<44CDCB61.2DEDCBFF@vollmann.ch>
	<1154342029.9569.27.camel@domain.hid>
	<44CDE4C2.77465253@domain.hid>
	<17616.42011.663899.554796@domain.hid>
	<1154525585.9559.22.camel@domain.hid>
	<17616.59841.283196.201008@domain.hid>
Content-Type: text/plain
Date: Thu, 03 Aug 2006 13:23:09 +0200
Message-Id: <1154604189.9835.42.camel@domain.hid>
Mime-Version: 1.0
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Wed, 2006-08-02 at 20:06 +0200, Gilles Chanteperdrix wrote:
> Bart Jonkers wrote:
>  > On Wed, 2006-08-02 at 15:09 +0200, Gilles Chanteperdrix wrote:
>  > > Detlef Vollmann wrote:
>  > >  > > I also added an interrupt handler on a button which is connected to GPIO
>  > >  > > pin. The interrupt handler should print something when it is executed.
>  > >  > > When I push the button a couple of times nothing happens. So GPIO
>  > >  > > interrupts doesn't seems to work.
>  > >  > Probably GPIO0 and GPIO1 work.
>  > >  > I suspect it's the cascading interrupt that doesn't work.
>  > >  > When I played around with an earlier version of ipipe, I found that
>  > >  > the IRQ_GPIO_2_80 (IRQ 10 on PXA270) is masked, but never unmasked
>  > >  > again.
>  > >  > 
>  > >  > The problem is that for the cascading interrupt you need a special
>  > >  > IPIPE handler, and I don't think there is currently one for PXA.
>  > >  > 
>  > >  > How is that done on other machines/architectures?
>  > > 
>  > > When looking at the ipipe_enable_pipeline function, we see that
>  > > interrupts management routines are all intercepted by the I-pipe, so the
>  > > cascaded interrupts management routines should be automatically
>  > > intercepted. 
>  > > 
>  > > In order to have a better understanding of the issue, it would be
>  > > interesting if you could trace the functions that are called on the path
>  > > from the interrupt to the execution of the final handler.
>  > 
>  > I have tracked and solved the issue. I have looked to the i.MX21 port
>  > and they added some code to the GPIO interrupt handler of the i.MX21.
>  > When IPIPE is active they unmask the interrupt for the GPIO pins at the
>  > end of the handler. I did the same for PXA and my GPIO interrupt problem
>  > is solved. I think that the same is needed for SA-1100.
> 
> Here is a new version of the ipipe-sa1100-pxa patch that unmaks
> interrupts at the end of the demux handlers, and that attempt to fix the
> gettimeoffset issue. I have run 20 minutes (time for OSCR to wrap) latency
> with a test program verifying that time returned by gettimeofday is
> never going backward.
> 
> The patch and the test program are attached, it would be nice if you
> could test them.
> 

To let the GPIO interrupts also work in the real-time domain we need to
set up a chain handler for these interrupts. The problem is that I know
very less of the internals of xenomai to implement this. So could
someone help me with this?
I've already take a look to the i.mx21 platform but doesn't see anything
that could help us. Maybe GPIO interrupts also doesn't work on the
i.mx21 platform. Could the people that work on this platform confirm
that?

Thanks,
Bart
> plain text document attachment (ipipe-sa1100-pxa.2.patch)
> --- linux-2.6.16.5-tcl1/arch/arm/mach-pxa/irq.c	2005-10-28 02:02:08.000000000 +0200
> +++ linux-2.6.16.5-tcl1-ipipe/arch/arm/mach-pxa/irq.c	2006-08-02 17:57:30.000000000 +0200
> @@ -143,6 +143,10 @@ static struct irqchip pxa_low_gpio_chip 
>  static void pxa_gpio_demux_handler(unsigned int irq, struct irqdesc *desc,
>  				   struct pt_regs *regs)
>  {
> +#ifdef CONFIG_IPIPE
> +	struct irqdesc *desc_unused = desc;
> +	unsigned irq_unused = irq;
> +#endif /* CONFIG_IPIPE */
>  	unsigned int mask;
>  	int loop;
>  
> @@ -212,6 +216,10 @@ static void pxa_gpio_demux_handler(unsig
>  		}
>  #endif
>  	} while (loop);
> +
> +#ifdef CONFIG_IPIPE
> +	desc_unused->chip->unmask(irq_unused);
> +#endif /* CONFIG_IPIPE */
>  }
>  
>  static void pxa_ack_muxed_gpio(unsigned int irq)
> --- linux-2.6.16.5-tcl1/arch/arm/mach-pxa/time.c	2006-05-07 15:36:35.000000000 +0200
> +++ linux-2.6.16.5-tcl1-ipipe/arch/arm/mach-pxa/time.c	2006-08-02 19:17:30.000000000 +0200
> @@ -19,6 +19,7 @@
>  #include <linux/signal.h>
>  #include <linux/errno.h>
>  #include <linux/sched.h>
> +#include <linux/module.h>
>  
>  #include <asm/system.h>
>  #include <asm/hardware.h>
> @@ -30,6 +31,23 @@
>  #include <asm/arch/pxa-regs.h>
>  
> 
> +#ifdef CONFIG_IPIPE
> +#ifdef CONFIG_NO_IDLE_HZ
> +#error "dynamic tick timer not yet supported with IPIPE"
> +#endif /* CONFIG_NO_IDLE_HZ */
> +int __ipipe_mach_timerint = IRQ_OST0;
> +EXPORT_SYMBOL(__ipipe_mach_timerint);
> +
> +int __ipipe_mach_timerstolen = 0;
> +EXPORT_SYMBOL(__ipipe_mach_timerstolen);
> +
> +unsigned int __ipipe_mach_ticks_per_jiffy = LATCH;
> +EXPORT_SYMBOL(__ipipe_mach_ticks_per_jiffy);
> +
> +static int pxa_timer_initialized;
> +static unsigned long pxa_jiffies;
> +#endif /* CONFIG_IPIPE */
> +
>  static inline unsigned long pxa_get_rtc_time(void)
>  {
>  	return RCNR;
> @@ -54,6 +72,9 @@ static unsigned long pxa_gettimeoffset (
>  {
>  	long ticks_to_match, elapsed, usec;
>  
> +#ifdef CONFIG_IPIPE
> +	if (!__ipipe_mach_timerstolen) {
> +#endif
>  	/* Get ticks before next timer match */
>  	ticks_to_match = OSMR0 - OSCR;
>  
> @@ -63,6 +84,10 @@ static unsigned long pxa_gettimeoffset (
>  	/* don't get fooled by the workaround in pxa_timer_interrupt() */
>  	if (elapsed <= 0)
>  		return 0;
> +#ifdef CONFIG_IPIPE
> +	} else
> +		elapsed = OSCR - pxa_jiffies * LATCH;
> +#endif
>  
>  	/* Now convert them to usec */
>  	usec = (unsigned long)(elapsed * (tick_nsec / 1000))/LATCH;
> @@ -105,9 +130,27 @@ pxa_timer_interrupt(int irq, void *dev_i
>  	 * affect things only when the timer IRQ has been delayed by nearly
>  	 * exactly one tick period which should be a pretty rare event.
>  	 */
> +#ifdef CONFIG_IPIPE
> +	/*
> +	 * - if Linux is running natively (no ipipe), ack and reprogram the timer
> +	 * - if Linux is running under ipipe, but it still has the control over
> +	 *   the timer (no Xenomai for example), then reprogram the timer (ipipe
> +	 *   has already acked it)
> +	 * - if some other domain has taken over the timer, then do nothing
> +	 *   (ipipe has acked it, and the other domain has reprogramed it)
> +	 */
> +	if (__ipipe_mach_timerstolen) {
> +		timer_tick(regs);
> +		++pxa_jiffies;
> +	} else
> +#endif /* CONFIG_IPIPE */
>  	do {
>  		timer_tick(regs);
> +#ifdef CONFIG_IPIPE
> +		++pxa_jiffies;
> +#else /* !CONFIG_IPIPE */
>  		OSSR = OSSR_M0;  /* Clear match on timer 0 */
> +#endif /* !CONFIG_IPIPE */
>  		next_match = (OSMR0 += LATCH);
>  	} while( (signed long)(next_match - OSCR) <= 8 );
>  
> @@ -139,6 +182,10 @@ static void __init pxa_timer_init(void)
>  	setup_irq(IRQ_OST0, &pxa_timer_irq);
>  	OIER = OIER_E0;		/* enable match on timer 0 to cause interrupts */
>  	OSCR = 0;		/* initialize free-running timer */
> +
> +#ifdef CONFIG_IPIPE
> +	pxa_timer_initialized = 1;
> +#endif /* CONFIG_IPIPE */
>  }
>  
>  #ifdef CONFIG_NO_IDLE_HZ
> @@ -216,3 +263,69 @@ struct sys_timer pxa_timer = {
>  	.dyn_tick	= &pxa_dyn_tick,
>  #endif
>  };
> +
> +#ifdef CONFIG_IPIPE
> +void __ipipe_mach_acktimer(void)
> +{
> +	OSSR = OSSR_M0;  /* Clear match on timer 0 */
> +}
> +
> +unsigned long long __ipipe_mach_get_tsc(void)
> +{
> +	if (likely(pxa_timer_initialized)) {
> +		static union {
> +#ifdef __BIG_ENDIAN
> +			struct {
> +				unsigned long high;
> +				unsigned long low;
> +			};
> +#else /* __LITTLE_ENDIAN */
> +			struct {
> +				unsigned long low;
> +				unsigned long high;
> +			};
> +#endif /* __LITTLE_ENDIAN */
> +			unsigned long long full;
> +		} tsc[NR_CPUS], *local_tsc;
> +		unsigned long stamp, flags;
> +		unsigned long long result;
> +
> +		local_irq_save_hw(flags);
> +		local_tsc = &tsc[ipipe_processor_id()];
> +		stamp = OSCR;
> +		if (unlikely(stamp < local_tsc->low))
> +			/* 32 bit counter wrapped, increment high word. */
> +			local_tsc->high++;
> +		local_tsc->low = stamp;
> +		result = local_tsc->full;
> +		local_irq_restore_hw(flags);
> +
> +		return result;
> +	}
> +	
> +        return 0;
> +}
> +EXPORT_SYMBOL(__ipipe_mach_get_tsc);
> +
> +/*
> + * Reprogram the timer
> + */
> +
> +void __ipipe_mach_set_dec(unsigned long delay)
> +{
> +	if (delay > 8) {
> +		unsigned long flags;
> +
> +		local_irq_save_hw(flags);
> +		OSMR0 = delay + OSCR;
> +		local_irq_restore_hw(flags);
> +	} else
> +		ipipe_trigger_irq(IRQ_OST0);
> +}
> +EXPORT_SYMBOL(__ipipe_mach_set_dec);
> +
> +unsigned long __ipipe_mach_get_dec(void)
> +{
> +	return OSMR0 - OSCR;
> +}
> +#endif /* CONFIG_IPIPE */
> --- linux-2.6.16.5-tcl1/arch/arm/mach-sa1100/irq.c	2005-10-28 02:02:08.000000000 +0200
> +++ linux-2.6.16.5-tcl1-ipipe/arch/arm/mach-sa1100/irq.c	2006-08-02 17:55:48.000000000 +0200
> @@ -111,6 +111,10 @@ static void
>  sa1100_high_gpio_handler(unsigned int irq, struct irqdesc *desc,
>  			 struct pt_regs *regs)
>  {
> +#ifdef CONFIG_IPIPE
> +	struct irqdesc *desc_unused = desc;
> +	unsigned irq_unused = irq;
> +#endif /* CONFIG_IPIPE */
>  	unsigned int mask;
>  
>  	mask = GEDR & 0xfffff800;
> @@ -134,6 +138,10 @@ sa1100_high_gpio_handler(unsigned int ir
>  
>  		mask = GEDR & 0xfffff800;
>  	} while (mask);
> +
> +#ifdef CONFIG_IPIPE
> +	desc_unused->chip->unmask(irq_unused);
> +#endif /* CONFIG_IPIPE */
>  }
>  
>  /*
> --- linux-2.6.16.5-tcl1/arch/arm/mach-sa1100/time.c	2006-05-07 15:36:35.000000000 +0200
> +++ linux-2.6.16.5-tcl1-ipipe/arch/arm/mach-sa1100/time.c	2006-08-02 19:09:06.000000000 +0200
> @@ -13,6 +13,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/timex.h>
>  #include <linux/signal.h>
> +#include <linux/module.h>
>  
>  #include <asm/mach/time.h>
>  #include <asm/hardware.h>
> @@ -20,6 +21,23 @@
>  #define RTC_DEF_DIVIDER		(32768 - 1)
>  #define RTC_DEF_TRIM            0
>  
> +#ifdef CONFIG_IPIPE
> +#ifdef CONFIG_NO_IDLE_HZ
> +#error "dynamic tick timer not yet supported with IPIPE"
> +#endif /* CONFIG_NO_IDLE_HZ */
> +int __ipipe_mach_timerint = IRQ_OST0;
> +EXPORT_SYMBOL(__ipipe_mach_timerint);
> +
> +int __ipipe_mach_timerstolen = 0;
> +EXPORT_SYMBOL(__ipipe_mach_timerstolen);
> +
> +unsigned int __ipipe_mach_ticks_per_jiffy = LATCH;
> +EXPORT_SYMBOL(__ipipe_mach_ticks_per_jiffy);
> +
> +static int sa1100_timer_initialized;
> +static unsigned long sa1100_jiffies;
> +#endif /* CONFIG_IPIPE */
> +
>  static unsigned long __init sa1100_get_rtc_time(void)
>  {
>  	/*
> @@ -58,11 +76,18 @@ static unsigned long sa1100_gettimeoffse
>  {
>  	unsigned long ticks_to_match, elapsed, usec;
>  
> +#ifdef CONFIG_IPIPE
> +	if (!__ipipe_mach_timerstolen) {
> +#endif
>  	/* Get ticks before next timer match */
>  	ticks_to_match = OSMR0 - OSCR;
>  
>  	/* We need elapsed ticks since last match */
>  	elapsed = LATCH - ticks_to_match;
> +#ifdef CONFIG_IPIPE
> +	} else
> +		elapsed = OSCR - sa1100_jiffies * LATCH;
> +#endif
>  
>  	/* Now convert them to usec */
>  	usec = (unsigned long)(elapsed * (tick_nsec / 1000))/LATCH;
> @@ -97,9 +122,27 @@ sa1100_timer_interrupt(int irq, void *de
>  	 * ensured, hence we can use do_gettimeofday() from interrupt
>  	 * handlers.
>  	 */
> +#ifdef CONFIG_IPIPE
> +	/*
> +	 * - if Linux is running natively (no ipipe), ack and reprogram the timer
> +	 * - if Linux is running under ipipe, but it still has the control over
> +	 *   the timer (no Xenomai for example), then reprogram the timer (ipipe
> +	 *   has already acked it)
> +	 * - if some other domain has taken over the timer, then do nothing
> +	 *   (ipipe has acked it, and the other domain has reprogramed it)
> +	 */
> +	if (__ipipe_mach_timerstolen) {
> +		timer_tick(regs);
> +		++sa1100_jiffies;
> +	} else
> +#endif /* CONFIG_IPIPE */
>  	do {
>  		timer_tick(regs);
> +#ifdef CONFIG_IPIPE
> +		++sa1100_jiffies;
> +#else /* !CONFIG_IPIPE */
>  		OSSR = OSSR_M0;  /* Clear match on timer 0 */
> +#endif /* !CONFIG_IPIPE */
>  		next_match = (OSMR0 += LATCH);
>  	} while ((signed long)(next_match - OSCR) <= 0);
>  
> @@ -131,6 +174,10 @@ static void __init sa1100_timer_init(voi
>  	setup_irq(IRQ_OST0, &sa1100_timer_irq);
>  	OIER = OIER_E0;		/* enable match on timer 0 to cause interrupts */
>  	OSCR = 0;		/* initialize free-running timer */
> +
> +#ifdef CONFIG_IPIPE
> +	sa1100_timer_initialized = 1;
> +#endif /* CONFIG_IPIPE */
>  }
>  
>  #ifdef CONFIG_NO_IDLE_HZ
> @@ -209,3 +256,66 @@ struct sys_timer sa1100_timer = {
>  	.dyn_tick	= &sa1100_dyn_tick,
>  #endif
>  };
> +
> +#ifdef CONFIG_IPIPE
> +void __ipipe_mach_acktimer(void)
> +{
> +	OSSR = OSSR_M0;  /* Clear match on timer 0 */
> +}
> +
> +unsigned long long __ipipe_mach_get_tsc(void)
> +{
> +	if (likely(sa1100_timer_initialized)) {
> +		static union {
> +#ifdef __BIG_ENDIAN
> +			struct {
> +				unsigned long high;
> +				unsigned long low;
> +			};
> +#else /* __LITTLE_ENDIAN */
> +			struct {
> +				unsigned long low;
> +				unsigned long high;
> +			};
> +#endif /* __LITTLE_ENDIAN */
> +			unsigned long long full;
> +		} tsc[NR_CPUS], *local_tsc;
> +		unsigned long stamp, flags;
> +		unsigned long long result;
> +
> +		local_irq_save_hw(flags);
> +		local_tsc = &tsc[ipipe_processor_id()];
> +		stamp = OSCR;
> +		if (unlikely(stamp < local_tsc->low))
> +			/* 32 bit counter wrapped, increment high word. */
> +			local_tsc->high++;
> +		local_tsc->low = stamp;
> +		result = local_tsc->full;
> +		local_irq_restore_hw(flags);
> +
> +		return result;
> +	}
> +	
> +        return 0;
> +}
> +EXPORT_SYMBOL(__ipipe_mach_get_tsc);
> +
> +/*
> + * Reprogram the timer
> + */
> +
> +void __ipipe_mach_set_dec(unsigned long delay)
> +{
> +	unsigned long flags;
> +
> +	local_irq_save_hw(flags);
> +        OSMR0 = delay + OSCR;
> +	local_irq_restore_hw(flags);
> +}
> +EXPORT_SYMBOL(__ipipe_mach_set_dec);
> +
> +unsigned long __ipipe_mach_get_dec(void)
> +{
> +	return OSMR0 - OSCR;
> +}
> +#endif /* CONFIG_IPIPE */
> plain text document attachment (test_gettimeofday.c)
> #include <stdio.h>
> #include <time.h>
> #include <sys/time.h>
> 
> int main(void)
> {
> 	struct timeval tv, old_tv;
> 
> 	gettimeofday(&old_tv, NULL);
> 	for (;;) {
> 		gettimeofday(&tv, NULL);
> 		if (tv.tv_sec < old_tv.tv_sec ||
> 		    (tv.tv_sec == old_tv.tv_sec && tv.tv_usec < old_tv.tv_usec))
> 			printf("Time is going backward !\n");
> 		old_tv = tv;
> 	}
> }


