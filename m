Message-ID: <4B47B0FE.8060000@domain.hid>
Date: Fri, 08 Jan 2010 23:26:06 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <725957.56219.qm@domain.hid>	<4303dd241001080658q224a43feqafa77aedd694b41c@domain.hid>	<4B4750E1.20703@domain.hid>	<4303dd241001080943v2d279019s1164a5b2aa34790a@domain.hid>	<4303dd241001081002y8d7ef2fmcb7654d84dfd462f@domain.hid>	<4B477495.6010009@domain.hid>	<4303dd241001081127u217e916ax9c20352b7d7efe49@domain.hid>	<4B478825.9000006@domain.hid>	<4303dd241001081142q37797dcjb25fd9103f7e497e@domain.hid>	<4B478B6E.1050400@domain.hid>
	<4303dd241001081354tc22e226j761564dea565ac89@domain.hid>
In-Reply-To: <4303dd241001081354tc22e226j761564dea565ac89@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Porting I-Pipe for new ARM board
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Flavio de Castro Alves Filho <flavio.alves@domain.hid>
Cc: xenomai@xenomai.org

aFlavio de Castro Alves Filho wrote:
> In fact,
> 
> Much easier.
> 
> *** linux-03.20.00.05/arch/arm/mach-davinci/gpio.c    2009-07-29
> 02:53:15.000000000 -0300
> --- linux-03.20.00.05_xenomai/arch/arm/mach-davinci/gpio.c    2010-01-08
> 16:08:35.000000000 -0200
> ***************
> *** 27,32 ****
> --- 27,33 ----
> 
>   #include <asm/mach/irq.h>
> 
> + #include <asm/ipipe.h>
> 
>   static DEFINE_SPINLOCK(gpio_lock);
> 
> ***************
> *** 261,266 ****
> --- 262,315 ----
>       /* now it may re-trigger */
>   }
> 
> + #ifdef CONFIG_IPIPE
> +
> + /* Flavio Alves: for debugging */
> + extern void printascii(const char *);
> +
> + void __ipipe_mach_demux_irq(unsigned irq, struct pt_regs *regs)
> + {
> +     struct gpio_controller *__iomem g = get_irq_chip_data(irq);
> +     struct irq_desc *desc;
> +     u32 mask = 0xffff;
> +
> +     //printascii("1__ipipe_mach_demux_irq\n");
> +
> +     /* we only care about one bank */
> +     if (irq & 1)
> +         mask <<= 16;
> +
> +     desc = &irq_desc[irq];
> +
> +     /* temporarily mask (level sensitive) parent IRQ */
> +     desc->chip->ack(irq);

Wrong comment. ->ack does not mask the parent irq, it just acks it.
masking it would be wrong by the way, since demux should not be done
with parent irq masked, as you will find out in the linux-arm-kernel
mailing list archives

> +     while (1) {
> +         u32        status;
> +         int        n;
> +         int        res;
> +
> +         /* ack any irqs */
> +         status = __raw_readl(&g->intstat) & mask;
> +         if (!status)
> +             break;
> +         __raw_writel(status, &g->intstat);
> +         if (irq & 1)
> +             status >>= 16;
> +
> +         /* now demux them to the right lowlevel handler */
> +         n = (int)get_irq_data(irq);
> +         while (status) {
> +             res = ffs(status);
> +             n += res;
> +             __ipipe_handle_irq((n-1),regs);
> +             status >>= res;
> +         }

This while loop should reread the hardware status at each iteration, to
take into account new interrupts which would have showed up while
handling the last interrupt.

> +     }
> +     desc->chip->unmask(irq);

Not needed since you did not mask the parent irq.

> +     /* now it may re-trigger */
> + }
> + #endif /* CONFIG_IPIPE */
> +
>   /*
>    * NOTE:  for suspend/resume, probably best to make a platform_device with
>    * suspend_late/resume_resume calls hooking into results of the set_wake()
> diff -crB linux-03.20.00.05/arch/arm/mach-davinci/include/mach/irqs.h
> linux-03.20.00.05_xenomai/arch/arm/mach-davinci/include/mach/irqs.h
> *** linux-03.20.00.05/arch/arm/mach-davinci/include/mach/irqs.h
> 2009-07-29 02:53:15.000000000 -0300
> --- linux-03.20.00.05_xenomai/arch/arm/mach-davinci/include/mach/irqs.h
> 2010-01-06 16:45:56.000000000 -0200
> ***************
> *** 359,362 ****
> --- 359,381 ----
>   #define IRQ_DA850_MCBSP1RINT        99
>   #define IRQ_DA850_MCBSP1XINT        100
> 
> + #ifdef CONFIG_IPIPE
> + #if 0
> + #define __ipipe_mach_irq_mux_p(irq) \
> +         ((unsigned) (irq - IRQ_DA8XX_GPIO0) \
> +          <= (IRQ_DA8XX_GPIO7 - IRQ_DA8XX_GPIO0))
> + #endif
> + #define __ipipe_mach_irq_mux_p(irq) \
> +     ((irq) == IRQ_DA8XX_GPIO0 \
> +      || (irq) == IRQ_DA8XX_GPIO1 \
> +      || (irq) == IRQ_DA8XX_GPIO2 \
> +      || (irq) == IRQ_DA8XX_GPIO3 \
> +      || (irq) == IRQ_DA8XX_GPIO4 \
> +      || (irq) == IRQ_DA8XX_GPIO5 \
> +      || (irq) == IRQ_DA8XX_GPIO6 \
> +      || (irq) == IRQ_DA8XX_GPIO7)

Yuck. The "#if 0"ed one solution seems much better. You have to realize
that this macro is called for every interrupt so, it has to be pretty
fast. If the interrupts are not consecutive, then use a bit field
(s3cxxxx does it IIRC). But to get things working it is ok, you can fix
this later.

> +
> +
> + #endif /* CONFIG_IPIPE */
> +
>   #endif /* __ASM_ARCH_IRQS_H */
> diff -crB linux-03.20.00.05/arch/arm/mach-davinci/irq.c
> linux-03.20.00.05_xenomai/arch/arm/mach-davinci/irq.c
> *** linux-03.20.00.05/arch/arm/mach-davinci/irq.c    2009-07-29
> 02:53:15.000000000 -0300
> --- linux-03.20.00.05_xenomai/arch/arm/mach-davinci/irq.c    2010-01-08
> 15:22:13.000000000 -0200
> ***************
> *** 111,119 ****
> --- 111,228 ----
>       .name    = "AINTC",
>       .ack    = davinci_ack_irq,
>       .mask    = davinci_mask_irq,
> + #ifdef CONFIG_IPIPE
> +     .mask_ack = davinci_mask_irq,
> + #endif /* CONFIG_IPIPE */

No, no, no. BIG BUG here. Your PIC has different ack and mask routines,
so, both should be called by mask_ack.

You did not get this idea from the porting howto. I made this on some
platforms whre the ack and mask routines were the same, so that mask_ack
ended up doing twice the same thing.

Anyway, this kind of optimization is to be left aside when starting the
port.

>       .unmask = davinci_unmask_irq,
>   };
> 
> + #ifdef CONFIG_IPIPE
> + static const u8 da850_default_priorities[DAVINCI_N_AINTC_IRQ] __initdata =
> {
> +   [IRQ_DA8XX_COMMTX]             = 7,
> +   [IRQ_DA8XX_COMMRX]             = 7,
> +   [IRQ_DA8XX_NINT]               = 7,
> +   [IRQ_DA8XX_EVTOUT0]            = 7,
> +   [IRQ_DA8XX_EVTOUT1]            = 7,
> +   [IRQ_DA8XX_EVTOUT2]            = 7,
> +   [IRQ_DA8XX_EVTOUT3]            = 7,
> +   [IRQ_DA8XX_EVTOUT4]            = 7,
> +   [IRQ_DA8XX_EVTOUT5]            = 7,
> +   [IRQ_DA8XX_EVTOUT6]            = 7,
> +   [IRQ_DA8XX_EVTOUT7]            = 7,
> +   [IRQ_DA8XX_CCINT0]             = 7,
> +   [IRQ_DA8XX_CCERRINT]           = 7,
> +   [IRQ_DA8XX_TCERRINT0]          = 7,
> +   [IRQ_DA8XX_AEMIFINT]           = 7,
> +   [IRQ_DA8XX_I2CINT0]            = 5,
> +   [IRQ_DA8XX_MMCSDINT0]          = 5,
> +   [IRQ_DA8XX_MMCSDINT1]          = 5,
> +   [IRQ_DA8XX_ALLINT0]            = 5,
> +   [IRQ_DA8XX_RTC]                = 4,
> +   [IRQ_DA8XX_SPINT0]             = 5,
> +   [IRQ_DA8XX_TINT12_0]           = 2,
> +   [IRQ_DA8XX_TINT34_0]           = 5,
> +   [IRQ_DA8XX_TINT12_1]           = 5,
> +   [IRQ_DA8XX_TINT34_1]           = 5,
> +   [IRQ_DA8XX_UARTINT0]           = 5,
> +   [IRQ_DA8XX_KEYMGRINT]          = 7,
> +   [IRQ_DA850_MIOPU_BOOTCFG_ERR]  = 7,
> +   [IRQ_DA8XX_CHIPINT0]           = 7,
> +   [IRQ_DA8XX_CHIPINT1]           = 7,
> +   [IRQ_DA8XX_CHIPINT2]           = 7,
> +   [IRQ_DA8XX_CHIPINT3]           = 7,
> +   [IRQ_DA8XX_TCERRINT1]          = 7,
> +   [IRQ_DA8XX_C0_RX_THRESH_PULSE] = 7,
> +   [IRQ_DA8XX_C0_RX_PULSE]        = 7,
> +   [IRQ_DA8XX_C0_TX_PULSE]        = 7,
> +   [IRQ_DA8XX_C0_MISC_PULSE]      = 7,
> +   [IRQ_DA8XX_C1_RX_THRESH_PULSE] = 7,
> +   [IRQ_DA8XX_C1_RX_PULSE]        = 7,
> +   [IRQ_DA8XX_C1_TX_PULSE]        = 7,
> +   [IRQ_DA8XX_C1_MISC_PULSE]      = 7,
> +   [IRQ_DA8XX_MEMERR]             = 5,
> +   [IRQ_DA8XX_GPIO0]              = 6,
> +   [IRQ_DA8XX_GPIO1]              = 6,
> +   [IRQ_DA8XX_GPIO2]              = 6,
> +   [IRQ_DA8XX_GPIO3]              = 6,
> +   [IRQ_DA8XX_GPIO4]              = 6,
> +   [IRQ_DA8XX_GPIO5]              = 6,
> +   [IRQ_DA8XX_GPIO6]              = 6,
> +   [IRQ_DA8XX_GPIO7]              = 6,
> +   [IRQ_DA8XX_GPIO8]              = 6,
> +   [IRQ_DA8XX_I2CINT1]            = 5,
> +   [IRQ_DA8XX_LCDINT]             = 5,
> +   [IRQ_DA8XX_UARTINT1]           = 5,
> +   [IRQ_DA8XX_MCASPINT]           = 5,
> +   [IRQ_DA8XX_ALLINT1]            = 5,
> +   [IRQ_DA8XX_SPINT1]             = 5,
> +   [IRQ_DA8XX_UHPI_INT1]          = 5,
> +   [IRQ_DA8XX_USB_INT]            = 5,
> +   [IRQ_DA8XX_IRQN]               = 5,
> +   [IRQ_DA8XX_RWAKEUP]            = 5,
> +   [IRQ_DA8XX_UARTINT2]           = 5,
> +   [IRQ_DA8XX_DFTSSINT]           = 5,
> +   [IRQ_DA8XX_EHRPWM0]            = 7,
> +   [IRQ_DA8XX_EHRPWM0TZ]          = 7,
> +   [IRQ_DA8XX_EHRPWM1]            = 7,
> +   [IRQ_DA8XX_EHRPWM1TZ]          = 7,
> +   [IRQ_DA850_SATAINT]            = 5,
> +   [IRQ_DA850_TINT12_2]           = 5,
> +   [IRQ_DA8XX_ECAP0]              = 7,
> +   [IRQ_DA8XX_ECAP1]              = 7,
> +   [IRQ_DA8XX_ECAP2]              = 7,
> +   [IRQ_DA850_MMCSDINT0_1]        = 5,
> +   [IRQ_DA850_MMCSDINT1_1]        = 5,
> +   [IRQ_DA850_T12CMPINT0_2]       = 7,
> +   [IRQ_DA850_T12CMPINT1_2]       = 7,
> +   [IRQ_DA850_T12CMPINT2_2]       = 7,
> +   [IRQ_DA850_T12CMPINT3_2]       = 7,
> +   [IRQ_DA850_T12CMPINT4_2]       = 7,
> +   [IRQ_DA850_T12CMPINT5_2]       = 7,
> +   [IRQ_DA850_T12CMPINT6_2]       = 7,
> +   [IRQ_DA850_T12CMPINT7_2]       = 7,
> +   [IRQ_DA850_T12CMPINT0_3]       = 7,
> +   [IRQ_DA850_T12CMPINT1_3]       = 7,
> +   [IRQ_DA850_T12CMPINT2_3]       = 7,
> +   [IRQ_DA850_T12CMPINT3_3]       = 7,
> +   [IRQ_DA850_T12CMPINT4_3]       = 7,
> +   [IRQ_DA850_T12CMPINT5_3]       = 7,
> +   [IRQ_DA850_T12CMPINT6_3]       = 7,
> +   [IRQ_DA850_T12CMPINT7_3]       = 7,
> +   [IRQ_DA8XX_ARMCLKSTOPREQ]      = 7,
> +   [IRQ_DA850_RPIINT]             = 7,
> +   [IRQ_DA850_VPIFINT]            = 7,
> +   [IRQ_DA850_CCINT1]             = 7,
> +   [IRQ_DA850_CCERRINT1]          = 7,
> +   [IRQ_DA850_TCERRINT2]          = 7,
> +   [IRQ_DA850_TINT12_3]           = 5,
> +   [IRQ_DA850_MCBSP0RINT]         = 5,
> +   [IRQ_DA850_MCBSP0XINT]         = 5,
> +   [IRQ_DA850_MCBSP1RINT]         = 5,
> +   [IRQ_DA850_MCBSP1XINT]         = 5
> + };
> + #endif /* CONFIG_IPIPE */

Fiddling with IRQ priorities is mostly useless if you send the EOI to
the interrupt controller at the beginning of the interrupt handling as
davinci_ack_irq seems to do it.

Besides, we have the (undocumented) PIC mute functionality wich is even
better than interrupt priorities. I need to document it sometimes.

> +
>   /* FIQ are pri 0-1; otherwise 2-7, with 7 lowest priority */
>   static const u8 dm644x_default_priorities[DAVINCI_N_AINTC_IRQ] __initdata
> = {
>       [IRQ_VDINT0]        = 2,
> ***************
> *** 325,330 ****
> --- 434,443 ----
>           davinci_def_priorities = dm646x_default_priorities;
>       else if (cpu_is_davinci_dm355())
>           davinci_def_priorities = dm355_default_priorities;
> + #ifdef CONFIG_IPIPE
> +     else if (cpu_is_da850())
> +       davinci_def_priorities = da850_default_priorities;
> + #endif /* CONFIG_IPIPE */
> 
>       /* Clear all interrupt requests */
>       davinci_irq_writel(~0x0, FIQ_REG0_OFFSET);
> ***************
> *** 361,369 ****
> --- 474,484 ----
>       for (i = 0; i < DAVINCI_N_AINTC_IRQ; i++) {
>           set_irq_chip(i, &davinci_irq_chip_0);
>           set_irq_flags(i, IRQF_VALID | IRQF_PROBE);
> + #ifndef CONFIG_IPIPE
>                   if (i != IRQ_TINT1_TINT34)
>                           set_irq_handler(i, handle_edge_irq);
>                   else
> + #endif /* CONFIG IPIPE */
>                           set_irq_handler(i, handle_level_irq);
>       }
>   }
> diff -crB linux-03.20.00.05/arch/arm/mach-davinci/time.c
> linux-03.20.00.05_xenomai/arch/arm/mach-davinci/time.c
> *** linux-03.20.00.05/arch/arm/mach-davinci/time.c    2009-07-29
> 02:53:15.000000000 -0300
> --- linux-03.20.00.05_xenomai/arch/arm/mach-davinci/time.c    2010-01-08
> 17:07:36.000000000 -0200
> ***************
> *** 30,35 ****
> --- 30,41 ----
>   #include <mach/cpu.h>
>   #include "clock.h"
> 
> + #ifdef CONFIG_IPIPE
> + #ifdef CONFIG_NO_IDLE_HZ
> + #error "dynamic tick timer not yet supported with IPIPE"
> + #endif /* CONFIG_NO_IDLE_HZ */
> + #endif /* CONFIG_IPIPE */
> +
>   static struct clock_event_device clockevent_davinci;
>   static unsigned int davinci_clock_tick_rate;
> 
> ***************
> *** 70,75 ****
> --- 76,102 ----
>   static int tid_system;
>   static int tid_freerun;
> 
> + #ifdef CONFIG_IPIPE
> + int          __ipipe_mach_timerint        = IRQ_DA8XX_TINT12_0;
> + int          __ipipe_mach_timerstolen     = 0;
> + unsigned int __ipipe_mach_ticks_per_jiffy = LATCH;
> + static int   davinci_timer_initialized;
> + union tsc_reg {
> + #ifdef __BIG_ENDIAN
> +     struct {
> +         unsigned long high;
> +         unsigned long low;
> +     };
> + #else                /* __LITTLE_ENDIAN */
> +     struct {
> +         unsigned long low;
> +         unsigned long high;
> +     };
> + #endif                /* __LITTLE_ENDIAN */
> +     unsigned long long full;
> + };
> + #endif /* CONFIG_IPIPE */
> +
>   /*
>    * This driver configures the 2 64-bit count-up timers as 4 independent
>    * 32-bit count-up timers used as follows:
> ***************
> *** 92,97 ****
> --- 119,125 ----
>   #define TGCR                         0x24
>   #define WDTCR                        0x28
>   #define CMP12(n)             (0x60 + ((n) << 2))
> + #define INTCTLSTAT                   0x44
> 
>   /* Timer register bitfields */
>   #define TCR_ENAMODE_DISABLE          0x0
> ***************
> *** 137,142 ****
> --- 165,283 ----
>   #define TIMER_OPTS_ONESHOT    0x01
>   #define TIMER_OPTS_PERIODIC   0x02
> 
> + /* Flags to be set when it is necessary to clear the */
> + /* status register for timer interrupts              */
> + #define TIMER12_CLEAR_PRDINT  0x02
> + #define TIMER12_CLEAR_EVTINT  0x04
> +
> + #ifdef CONFIG_IPIPE
> + #ifdef CONFIG_SMP
> + static union tsc_reg tsc[NR_CPUS];
> +
> + void __ipipe_mach_get_tscinfo(struct __ipipe_tscinfo *info)
> + {
> +     info->type = IPIPE_TSC_TYPE_NONE;
> + }
> + #else                /* !CONFIG_SMP */
> + static union tsc_reg *tsc;
> +
> + void __ipipe_mach_get_tscinfo(struct __ipipe_tscinfo *info)
> + {
> +     info->type = IPIPE_TSC_TYPE_FREERUNNING;
> +     info->u.fr.counter = (unsigned *)(DAVINCI_TIMER0_BASE + TIM12);
> +     info->u.fr.mask = 0xffffffff;
> +     info->u.fr.tsc = &tsc->full;
> + }
> + #endif                /* !CONFIG_SMP */
> +
> + void __ipipe_mach_acktimer(void)
> + {
> +   void __iomem *base = IO_ADDRESS(DAVINCI_TIMER0_BASE);
> +   unsigned long status;
> +
> +   status = __raw_readl(base + INTCTLSTAT);
> +   status |= (TIMER12_CLEAR_PRDINT | TIMER12_CLEAR_EVTINT);
> +
> +   __raw_writel(status,base+INTCTLSTAT);
> + }
> +
> + static void ipipe_mach_update_tsc(void)
> + {
> +   union tsc_reg *local_tsc;
> +   unsigned long stamp, flags;
> +   void __iomem *base = IO_ADDRESS(DAVINCI_TIMER0_BASE);
> +
> +   local_irq_save_hw(flags);
> +   local_tsc = &tsc[ipipe_processor_id()];
> +   stamp = __raw_readl(base + TIM12);
> +   if (unlikely(stamp < local_tsc->low))
> +     /* 32 bit counter wrapped, increment high word. */
> +     local_tsc->high++;
> +   local_tsc->low = stamp;
> +   local_irq_restore_hw(flags);
> + }
> +
> + notrace unsigned long long __ipipe_mach_get_tsc(void)
> + {
> +   if (likely(davinci_timer_initialized)) {
> +     union tsc_reg *local_tsc, result;
> +     unsigned long stamp;
> +     void __iomem *base = IO_ADDRESS(DAVINCI_TIMER0_BASE);
> +
> +     local_tsc = &tsc[ipipe_processor_id()];
> +
> +     __asm__("ldmia %1, %M0\n":
> +         "=r"(result.full): "r"(local_tsc), "m"(*local_tsc));
> +     barrier();
> +     stamp = __raw_readl(base + TIM12);
> +     if (unlikely(stamp < result.low))
> +       result.high++;
> +     result.low = stamp;
> +     return result.full;
> +   }
> +   return 0;
> + }
> + EXPORT_SYMBOL(__ipipe_mach_get_tsc);
> +
> + /*
> +  * Reprogram the timer
> +  */
> + void __ipipe_mach_set_dec(unsigned long delay)
> + {
> +   unsigned long flags;
> +   unsigned int  value;
> +   void __iomem *base = IO_ADDRESS(DAVINCI_TIMER0_BASE);
> +
> +   if (delay > 20) {
> +     local_irq_save_hw(flags);
> +
> +     value = __raw_readl(base + TIM12) + delay;
> +     __raw_writel(value,base + CMP12(0));
> +     local_irq_restore_hw(flags);
> +   } else {
> +     ipipe_trigger_irq(IRQ_DA8XX_TINT12_0);
> +   }
> + }

I can not really comment on that, since I do not really know the
hardware details, though the code seems to indicate that the minimum is
1, not 20. 20 should be Ok for a first run though:

        clockevent_davinci.min_delta_ns =
                clockevent_delta2ns(1, &clockevent_davinci);

> + EXPORT_SYMBOL(__ipipe_mach_set_dec);
> +
> + unsigned long __ipipe_mach_get_dec(void)
> + {
> +   unsigned long value;
> +   void __iomem *base = IO_ADDRESS(DAVINCI_TIMER0_BASE);
> +
> +   value  = __raw_readl(base + CMP12(0));
> +   value -= __raw_readl(base + TIM12);
> +
> +   return value;
> + }
> +
> + int __ipipe_check_tickdev(const char *devname)
> + {
> +   return !strcmp(devname, clockevent_davinci.name);
> + }
> +
> + #endif /* CONFIG_IPIPE */
> +
>   static int timer32_config(struct timer_s *t)
>   {
>       u32 tcr = __raw_readl(t->base + TCR);
> ***************
> *** 167,176 ****
> --- 308,324 ----
>       return __raw_readl(t->base + t->tim_off);
>   }
> 
> + /* Flavio Alves: for debugging */
> + extern void printascii(const char *);
> +
>   static irqreturn_t timer_interrupt(int irq, void *dev_id)
>   {
>       struct clock_event_device *evt = &clockevent_davinci;
> 
> +     //    printascii("entrei\n");
> + #ifdef CONFIG_IPIPE
> +     ipipe_mach_update_tsc();
> + #endif                          /* CONFIG_IPIPE */
>       evt->event_handler(evt);
>       return IRQ_HANDLED;
>   }

Ah. You have to realize that if the clockevent framework chooses an
other clockevent than this one, timer_interrupt will no longer be
called, so the tsc will wrap instead of incrementing correctly. So, as
explained in a previous mail, you have to:
- either increment clockevent_davinci.rating (currently uninitialized if
I read the code correctly, so 0)
- or base Xenomai timer on the other clockevent,
- or call ipipe_mach_update_tsc() in __ipipe_mach_acktimer (not a good
long term solution, but good for a quick test)



> ***************
> *** 302,307 ****
> --- 449,463 ----
>               timer32_config(timers[i]);
>           }
>       }
> +
> + #ifdef CONFIG_IPIPE
> + #ifndef CONFIG_SMP
> +     tsc = (union tsc_reg *)__ipipe_tsc_area;
> +     barrier();
> + #endif                /* CONFIG_SMP */
> +     davinci_timer_initialized = 1;
> + #endif                          /* CONFIG_IPIPE */
> +
>   }
> 
>   /*
> ***************
> *** 311,321 ****
>   {
>       struct timer_s *t;
> 
> !     if (tid_freerun == -1)
>           t = timers[tid_system];
> !     else
>           t = timers[tid_freerun];
> !
>       return (cycles_t)timer32_read(t);
>   }
> 
> --- 467,478 ----
>   {
>       struct timer_s *t;
> 
> !   if (tid_freerun == -1) {
>           t = timers[tid_system];
> !   }
> !   else {
>           t = timers[tid_freerun];
> !   }
>       return (cycles_t)timer32_read(t);
>   }
> 
> ***************
> *** 549,551 ****
> --- 706,718 ----
>       wdtcr = 0x00004000;
>       __raw_writel(wdtcr, base + WDTCR);
>   }
> +
> + #ifdef CONFIG_IPIPE
> + void __ipipe_mach_release_timer(void)
> + {
> +   davinci_set_mode(clockevent_davinci.mode, &clockevent_davinci);
> +   if (clockevent_davinci.mode == CLOCK_EVT_MODE_ONESHOT)
> +     davinci_set_next_event(LATCH, &clockevent_davinci);
> + }
> + EXPORT_SYMBOL(__ipipe_mach_release_timer);
> + #endif /* CONFIG_IPIPE */
> 
> Best regards,

Ok. I think the bug really comes from the ack_mask thing. Other than
that, great work, the patch looks fine. Good luck.

-- 
					    Gilles.

