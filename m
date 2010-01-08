MIME-Version: 1.0
In-Reply-To: <4B478B6E.1050400@domain.hid>
References: <725957.56219.qm@domain.hid>
	<4303dd241001080658q224a43feqafa77aedd694b41c@domain.hid>
	<4B4750E1.20703@domain.hid>
	<4303dd241001080943v2d279019s1164a5b2aa34790a@domain.hid>
	<4303dd241001081002y8d7ef2fmcb7654d84dfd462f@domain.hid>
	<4B477495.6010009@domain.hid>
	<4303dd241001081127u217e916ax9c20352b7d7efe49@domain.hid>
	<4B478825.9000006@domain.hid>
	<4303dd241001081142q37797dcjb25fd9103f7e497e@domain.hid>
	<4B478B6E.1050400@domain.hid>
Date: Fri, 8 Jan 2010 19:54:54 -0200
Message-ID: <4303dd241001081354tc22e226j761564dea565ac89@domain.hid>
From: Flavio de Castro Alves Filho <flavio.alves@domain.hid>
Content-Type: multipart/alternative; boundary=00032555b4ceddfc1a047cae3c2c
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
To: xenomai@xenomai.org

--00032555b4ceddfc1a047cae3c2c
Content-Type: text/plain; charset=ISO-8859-1

In fact,

Much easier.

*** linux-03.20.00.05/arch/arm/mach-davinci/gpio.c    2009-07-29
02:53:15.000000000 -0300
--- linux-03.20.00.05_xenomai/arch/arm/mach-davinci/gpio.c    2010-01-08
16:08:35.000000000 -0200
***************
*** 27,32 ****
--- 27,33 ----

  #include <asm/mach/irq.h>

+ #include <asm/ipipe.h>

  static DEFINE_SPINLOCK(gpio_lock);

***************
*** 261,266 ****
--- 262,315 ----
      /* now it may re-trigger */
  }

+ #ifdef CONFIG_IPIPE
+
+ /* Flavio Alves: for debugging */
+ extern void printascii(const char *);
+
+ void __ipipe_mach_demux_irq(unsigned irq, struct pt_regs *regs)
+ {
+     struct gpio_controller *__iomem g = get_irq_chip_data(irq);
+     struct irq_desc *desc;
+     u32 mask = 0xffff;
+
+     //printascii("1__ipipe_mach_demux_irq\n");
+
+     /* we only care about one bank */
+     if (irq & 1)
+         mask <<= 16;
+
+     desc = &irq_desc[irq];
+
+     /* temporarily mask (level sensitive) parent IRQ */
+     desc->chip->ack(irq);
+     while (1) {
+         u32        status;
+         int        n;
+         int        res;
+
+         /* ack any irqs */
+         status = __raw_readl(&g->intstat) & mask;
+         if (!status)
+             break;
+         __raw_writel(status, &g->intstat);
+         if (irq & 1)
+             status >>= 16;
+
+         /* now demux them to the right lowlevel handler */
+         n = (int)get_irq_data(irq);
+         while (status) {
+             res = ffs(status);
+             n += res;
+             __ipipe_handle_irq((n-1),regs);
+             status >>= res;
+         }
+     }
+     desc->chip->unmask(irq);
+     /* now it may re-trigger */
+ }
+ #endif /* CONFIG_IPIPE */
+
  /*
   * NOTE:  for suspend/resume, probably best to make a platform_device with
   * suspend_late/resume_resume calls hooking into results of the set_wake()
diff -crB linux-03.20.00.05/arch/arm/mach-davinci/include/mach/irqs.h
linux-03.20.00.05_xenomai/arch/arm/mach-davinci/include/mach/irqs.h
*** linux-03.20.00.05/arch/arm/mach-davinci/include/mach/irqs.h
2009-07-29 02:53:15.000000000 -0300
--- linux-03.20.00.05_xenomai/arch/arm/mach-davinci/include/mach/irqs.h
2010-01-06 16:45:56.000000000 -0200
***************
*** 359,362 ****
--- 359,381 ----
  #define IRQ_DA850_MCBSP1RINT        99
  #define IRQ_DA850_MCBSP1XINT        100

+ #ifdef CONFIG_IPIPE
+ #if 0
+ #define __ipipe_mach_irq_mux_p(irq) \
+         ((unsigned) (irq - IRQ_DA8XX_GPIO0) \
+          <= (IRQ_DA8XX_GPIO7 - IRQ_DA8XX_GPIO0))
+ #endif
+ #define __ipipe_mach_irq_mux_p(irq) \
+     ((irq) == IRQ_DA8XX_GPIO0 \
+      || (irq) == IRQ_DA8XX_GPIO1 \
+      || (irq) == IRQ_DA8XX_GPIO2 \
+      || (irq) == IRQ_DA8XX_GPIO3 \
+      || (irq) == IRQ_DA8XX_GPIO4 \
+      || (irq) == IRQ_DA8XX_GPIO5 \
+      || (irq) == IRQ_DA8XX_GPIO6 \
+      || (irq) == IRQ_DA8XX_GPIO7)
+
+
+ #endif /* CONFIG_IPIPE */
+
  #endif /* __ASM_ARCH_IRQS_H */
diff -crB linux-03.20.00.05/arch/arm/mach-davinci/irq.c
linux-03.20.00.05_xenomai/arch/arm/mach-davinci/irq.c
*** linux-03.20.00.05/arch/arm/mach-davinci/irq.c    2009-07-29
02:53:15.000000000 -0300
--- linux-03.20.00.05_xenomai/arch/arm/mach-davinci/irq.c    2010-01-08
15:22:13.000000000 -0200
***************
*** 111,119 ****
--- 111,228 ----
      .name    = "AINTC",
      .ack    = davinci_ack_irq,
      .mask    = davinci_mask_irq,
+ #ifdef CONFIG_IPIPE
+     .mask_ack = davinci_mask_irq,
+ #endif /* CONFIG_IPIPE */
      .unmask = davinci_unmask_irq,
  };

+ #ifdef CONFIG_IPIPE
+ static const u8 da850_default_priorities[DAVINCI_N_AINTC_IRQ] __initdata =
{
+   [IRQ_DA8XX_COMMTX]             = 7,
+   [IRQ_DA8XX_COMMRX]             = 7,
+   [IRQ_DA8XX_NINT]               = 7,
+   [IRQ_DA8XX_EVTOUT0]            = 7,
+   [IRQ_DA8XX_EVTOUT1]            = 7,
+   [IRQ_DA8XX_EVTOUT2]            = 7,
+   [IRQ_DA8XX_EVTOUT3]            = 7,
+   [IRQ_DA8XX_EVTOUT4]            = 7,
+   [IRQ_DA8XX_EVTOUT5]            = 7,
+   [IRQ_DA8XX_EVTOUT6]            = 7,
+   [IRQ_DA8XX_EVTOUT7]            = 7,
+   [IRQ_DA8XX_CCINT0]             = 7,
+   [IRQ_DA8XX_CCERRINT]           = 7,
+   [IRQ_DA8XX_TCERRINT0]          = 7,
+   [IRQ_DA8XX_AEMIFINT]           = 7,
+   [IRQ_DA8XX_I2CINT0]            = 5,
+   [IRQ_DA8XX_MMCSDINT0]          = 5,
+   [IRQ_DA8XX_MMCSDINT1]          = 5,
+   [IRQ_DA8XX_ALLINT0]            = 5,
+   [IRQ_DA8XX_RTC]                = 4,
+   [IRQ_DA8XX_SPINT0]             = 5,
+   [IRQ_DA8XX_TINT12_0]           = 2,
+   [IRQ_DA8XX_TINT34_0]           = 5,
+   [IRQ_DA8XX_TINT12_1]           = 5,
+   [IRQ_DA8XX_TINT34_1]           = 5,
+   [IRQ_DA8XX_UARTINT0]           = 5,
+   [IRQ_DA8XX_KEYMGRINT]          = 7,
+   [IRQ_DA850_MIOPU_BOOTCFG_ERR]  = 7,
+   [IRQ_DA8XX_CHIPINT0]           = 7,
+   [IRQ_DA8XX_CHIPINT1]           = 7,
+   [IRQ_DA8XX_CHIPINT2]           = 7,
+   [IRQ_DA8XX_CHIPINT3]           = 7,
+   [IRQ_DA8XX_TCERRINT1]          = 7,
+   [IRQ_DA8XX_C0_RX_THRESH_PULSE] = 7,
+   [IRQ_DA8XX_C0_RX_PULSE]        = 7,
+   [IRQ_DA8XX_C0_TX_PULSE]        = 7,
+   [IRQ_DA8XX_C0_MISC_PULSE]      = 7,
+   [IRQ_DA8XX_C1_RX_THRESH_PULSE] = 7,
+   [IRQ_DA8XX_C1_RX_PULSE]        = 7,
+   [IRQ_DA8XX_C1_TX_PULSE]        = 7,
+   [IRQ_DA8XX_C1_MISC_PULSE]      = 7,
+   [IRQ_DA8XX_MEMERR]             = 5,
+   [IRQ_DA8XX_GPIO0]              = 6,
+   [IRQ_DA8XX_GPIO1]              = 6,
+   [IRQ_DA8XX_GPIO2]              = 6,
+   [IRQ_DA8XX_GPIO3]              = 6,
+   [IRQ_DA8XX_GPIO4]              = 6,
+   [IRQ_DA8XX_GPIO5]              = 6,
+   [IRQ_DA8XX_GPIO6]              = 6,
+   [IRQ_DA8XX_GPIO7]              = 6,
+   [IRQ_DA8XX_GPIO8]              = 6,
+   [IRQ_DA8XX_I2CINT1]            = 5,
+   [IRQ_DA8XX_LCDINT]             = 5,
+   [IRQ_DA8XX_UARTINT1]           = 5,
+   [IRQ_DA8XX_MCASPINT]           = 5,
+   [IRQ_DA8XX_ALLINT1]            = 5,
+   [IRQ_DA8XX_SPINT1]             = 5,
+   [IRQ_DA8XX_UHPI_INT1]          = 5,
+   [IRQ_DA8XX_USB_INT]            = 5,
+   [IRQ_DA8XX_IRQN]               = 5,
+   [IRQ_DA8XX_RWAKEUP]            = 5,
+   [IRQ_DA8XX_UARTINT2]           = 5,
+   [IRQ_DA8XX_DFTSSINT]           = 5,
+   [IRQ_DA8XX_EHRPWM0]            = 7,
+   [IRQ_DA8XX_EHRPWM0TZ]          = 7,
+   [IRQ_DA8XX_EHRPWM1]            = 7,
+   [IRQ_DA8XX_EHRPWM1TZ]          = 7,
+   [IRQ_DA850_SATAINT]            = 5,
+   [IRQ_DA850_TINT12_2]           = 5,
+   [IRQ_DA8XX_ECAP0]              = 7,
+   [IRQ_DA8XX_ECAP1]              = 7,
+   [IRQ_DA8XX_ECAP2]              = 7,
+   [IRQ_DA850_MMCSDINT0_1]        = 5,
+   [IRQ_DA850_MMCSDINT1_1]        = 5,
+   [IRQ_DA850_T12CMPINT0_2]       = 7,
+   [IRQ_DA850_T12CMPINT1_2]       = 7,
+   [IRQ_DA850_T12CMPINT2_2]       = 7,
+   [IRQ_DA850_T12CMPINT3_2]       = 7,
+   [IRQ_DA850_T12CMPINT4_2]       = 7,
+   [IRQ_DA850_T12CMPINT5_2]       = 7,
+   [IRQ_DA850_T12CMPINT6_2]       = 7,
+   [IRQ_DA850_T12CMPINT7_2]       = 7,
+   [IRQ_DA850_T12CMPINT0_3]       = 7,
+   [IRQ_DA850_T12CMPINT1_3]       = 7,
+   [IRQ_DA850_T12CMPINT2_3]       = 7,
+   [IRQ_DA850_T12CMPINT3_3]       = 7,
+   [IRQ_DA850_T12CMPINT4_3]       = 7,
+   [IRQ_DA850_T12CMPINT5_3]       = 7,
+   [IRQ_DA850_T12CMPINT6_3]       = 7,
+   [IRQ_DA850_T12CMPINT7_3]       = 7,
+   [IRQ_DA8XX_ARMCLKSTOPREQ]      = 7,
+   [IRQ_DA850_RPIINT]             = 7,
+   [IRQ_DA850_VPIFINT]            = 7,
+   [IRQ_DA850_CCINT1]             = 7,
+   [IRQ_DA850_CCERRINT1]          = 7,
+   [IRQ_DA850_TCERRINT2]          = 7,
+   [IRQ_DA850_TINT12_3]           = 5,
+   [IRQ_DA850_MCBSP0RINT]         = 5,
+   [IRQ_DA850_MCBSP0XINT]         = 5,
+   [IRQ_DA850_MCBSP1RINT]         = 5,
+   [IRQ_DA850_MCBSP1XINT]         = 5
+ };
+ #endif /* CONFIG_IPIPE */
+
  /* FIQ are pri 0-1; otherwise 2-7, with 7 lowest priority */
  static const u8 dm644x_default_priorities[DAVINCI_N_AINTC_IRQ] __initdata
= {
      [IRQ_VDINT0]        = 2,
***************
*** 325,330 ****
--- 434,443 ----
          davinci_def_priorities = dm646x_default_priorities;
      else if (cpu_is_davinci_dm355())
          davinci_def_priorities = dm355_default_priorities;
+ #ifdef CONFIG_IPIPE
+     else if (cpu_is_da850())
+       davinci_def_priorities = da850_default_priorities;
+ #endif /* CONFIG_IPIPE */

      /* Clear all interrupt requests */
      davinci_irq_writel(~0x0, FIQ_REG0_OFFSET);
***************
*** 361,369 ****
--- 474,484 ----
      for (i = 0; i < DAVINCI_N_AINTC_IRQ; i++) {
          set_irq_chip(i, &davinci_irq_chip_0);
          set_irq_flags(i, IRQF_VALID | IRQF_PROBE);
+ #ifndef CONFIG_IPIPE
                  if (i != IRQ_TINT1_TINT34)
                          set_irq_handler(i, handle_edge_irq);
                  else
+ #endif /* CONFIG IPIPE */
                          set_irq_handler(i, handle_level_irq);
      }
  }
diff -crB linux-03.20.00.05/arch/arm/mach-davinci/time.c
linux-03.20.00.05_xenomai/arch/arm/mach-davinci/time.c
*** linux-03.20.00.05/arch/arm/mach-davinci/time.c    2009-07-29
02:53:15.000000000 -0300
--- linux-03.20.00.05_xenomai/arch/arm/mach-davinci/time.c    2010-01-08
17:07:36.000000000 -0200
***************
*** 30,35 ****
--- 30,41 ----
  #include <mach/cpu.h>
  #include "clock.h"

+ #ifdef CONFIG_IPIPE
+ #ifdef CONFIG_NO_IDLE_HZ
+ #error "dynamic tick timer not yet supported with IPIPE"
+ #endif /* CONFIG_NO_IDLE_HZ */
+ #endif /* CONFIG_IPIPE */
+
  static struct clock_event_device clockevent_davinci;
  static unsigned int davinci_clock_tick_rate;

***************
*** 70,75 ****
--- 76,102 ----
  static int tid_system;
  static int tid_freerun;

+ #ifdef CONFIG_IPIPE
+ int          __ipipe_mach_timerint        = IRQ_DA8XX_TINT12_0;
+ int          __ipipe_mach_timerstolen     = 0;
+ unsigned int __ipipe_mach_ticks_per_jiffy = LATCH;
+ static int   davinci_timer_initialized;
+ union tsc_reg {
+ #ifdef __BIG_ENDIAN
+     struct {
+         unsigned long high;
+         unsigned long low;
+     };
+ #else                /* __LITTLE_ENDIAN */
+     struct {
+         unsigned long low;
+         unsigned long high;
+     };
+ #endif                /* __LITTLE_ENDIAN */
+     unsigned long long full;
+ };
+ #endif /* CONFIG_IPIPE */
+
  /*
   * This driver configures the 2 64-bit count-up timers as 4 independent
   * 32-bit count-up timers used as follows:
***************
*** 92,97 ****
--- 119,125 ----
  #define TGCR                         0x24
  #define WDTCR                        0x28
  #define CMP12(n)             (0x60 + ((n) << 2))
+ #define INTCTLSTAT                   0x44

  /* Timer register bitfields */
  #define TCR_ENAMODE_DISABLE          0x0
***************
*** 137,142 ****
--- 165,283 ----
  #define TIMER_OPTS_ONESHOT    0x01
  #define TIMER_OPTS_PERIODIC   0x02

+ /* Flags to be set when it is necessary to clear the */
+ /* status register for timer interrupts              */
+ #define TIMER12_CLEAR_PRDINT  0x02
+ #define TIMER12_CLEAR_EVTINT  0x04
+
+ #ifdef CONFIG_IPIPE
+ #ifdef CONFIG_SMP
+ static union tsc_reg tsc[NR_CPUS];
+
+ void __ipipe_mach_get_tscinfo(struct __ipipe_tscinfo *info)
+ {
+     info->type = IPIPE_TSC_TYPE_NONE;
+ }
+ #else                /* !CONFIG_SMP */
+ static union tsc_reg *tsc;
+
+ void __ipipe_mach_get_tscinfo(struct __ipipe_tscinfo *info)
+ {
+     info->type = IPIPE_TSC_TYPE_FREERUNNING;
+     info->u.fr.counter = (unsigned *)(DAVINCI_TIMER0_BASE + TIM12);
+     info->u.fr.mask = 0xffffffff;
+     info->u.fr.tsc = &tsc->full;
+ }
+ #endif                /* !CONFIG_SMP */
+
+ void __ipipe_mach_acktimer(void)
+ {
+   void __iomem *base = IO_ADDRESS(DAVINCI_TIMER0_BASE);
+   unsigned long status;
+
+   status = __raw_readl(base + INTCTLSTAT);
+   status |= (TIMER12_CLEAR_PRDINT | TIMER12_CLEAR_EVTINT);
+
+   __raw_writel(status,base+INTCTLSTAT);
+ }
+
+ static void ipipe_mach_update_tsc(void)
+ {
+   union tsc_reg *local_tsc;
+   unsigned long stamp, flags;
+   void __iomem *base = IO_ADDRESS(DAVINCI_TIMER0_BASE);
+
+   local_irq_save_hw(flags);
+   local_tsc = &tsc[ipipe_processor_id()];
+   stamp = __raw_readl(base + TIM12);
+   if (unlikely(stamp < local_tsc->low))
+     /* 32 bit counter wrapped, increment high word. */
+     local_tsc->high++;
+   local_tsc->low = stamp;
+   local_irq_restore_hw(flags);
+ }
+
+ notrace unsigned long long __ipipe_mach_get_tsc(void)
+ {
+   if (likely(davinci_timer_initialized)) {
+     union tsc_reg *local_tsc, result;
+     unsigned long stamp;
+     void __iomem *base = IO_ADDRESS(DAVINCI_TIMER0_BASE);
+
+     local_tsc = &tsc[ipipe_processor_id()];
+
+     __asm__("ldmia %1, %M0\n":
+         "=r"(result.full): "r"(local_tsc), "m"(*local_tsc));
+     barrier();
+     stamp = __raw_readl(base + TIM12);
+     if (unlikely(stamp < result.low))
+       result.high++;
+     result.low = stamp;
+     return result.full;
+   }
+   return 0;
+ }
+ EXPORT_SYMBOL(__ipipe_mach_get_tsc);
+
+ /*
+  * Reprogram the timer
+  */
+ void __ipipe_mach_set_dec(unsigned long delay)
+ {
+   unsigned long flags;
+   unsigned int  value;
+   void __iomem *base = IO_ADDRESS(DAVINCI_TIMER0_BASE);
+
+   if (delay > 20) {
+     local_irq_save_hw(flags);
+
+     value = __raw_readl(base + TIM12) + delay;
+     __raw_writel(value,base + CMP12(0));
+     local_irq_restore_hw(flags);
+   } else {
+     ipipe_trigger_irq(IRQ_DA8XX_TINT12_0);
+   }
+ }
+ EXPORT_SYMBOL(__ipipe_mach_set_dec);
+
+ unsigned long __ipipe_mach_get_dec(void)
+ {
+   unsigned long value;
+   void __iomem *base = IO_ADDRESS(DAVINCI_TIMER0_BASE);
+
+   value  = __raw_readl(base + CMP12(0));
+   value -= __raw_readl(base + TIM12);
+
+   return value;
+ }
+
+ int __ipipe_check_tickdev(const char *devname)
+ {
+   return !strcmp(devname, clockevent_davinci.name);
+ }
+
+ #endif /* CONFIG_IPIPE */
+
  static int timer32_config(struct timer_s *t)
  {
      u32 tcr = __raw_readl(t->base + TCR);
***************
*** 167,176 ****
--- 308,324 ----
      return __raw_readl(t->base + t->tim_off);
  }

+ /* Flavio Alves: for debugging */
+ extern void printascii(const char *);
+
  static irqreturn_t timer_interrupt(int irq, void *dev_id)
  {
      struct clock_event_device *evt = &clockevent_davinci;

+     //    printascii("entrei\n");
+ #ifdef CONFIG_IPIPE
+     ipipe_mach_update_tsc();
+ #endif                          /* CONFIG_IPIPE */
      evt->event_handler(evt);
      return IRQ_HANDLED;
  }
***************
*** 302,307 ****
--- 449,463 ----
              timer32_config(timers[i]);
          }
      }
+
+ #ifdef CONFIG_IPIPE
+ #ifndef CONFIG_SMP
+     tsc = (union tsc_reg *)__ipipe_tsc_area;
+     barrier();
+ #endif                /* CONFIG_SMP */
+     davinci_timer_initialized = 1;
+ #endif                          /* CONFIG_IPIPE */
+
  }

  /*
***************
*** 311,321 ****
  {
      struct timer_s *t;

!     if (tid_freerun == -1)
          t = timers[tid_system];
!     else
          t = timers[tid_freerun];
!
      return (cycles_t)timer32_read(t);
  }

--- 467,478 ----
  {
      struct timer_s *t;

!   if (tid_freerun == -1) {
          t = timers[tid_system];
!   }
!   else {
          t = timers[tid_freerun];
!   }
      return (cycles_t)timer32_read(t);
  }

***************
*** 549,551 ****
--- 706,718 ----
      wdtcr = 0x00004000;
      __raw_writel(wdtcr, base + WDTCR);
  }
+
+ #ifdef CONFIG_IPIPE
+ void __ipipe_mach_release_timer(void)
+ {
+   davinci_set_mode(clockevent_davinci.mode, &clockevent_davinci);
+   if (clockevent_davinci.mode == CLOCK_EVT_MODE_ONESHOT)
+     davinci_set_next_event(LATCH, &clockevent_davinci);
+ }
+ EXPORT_SYMBOL(__ipipe_mach_release_timer);
+ #endif /* CONFIG_IPIPE */

Best regards,

Flavio

Flavio de Castro Alves Filho
Phi Innovations - Embedded Software Services
www.phiinnovations.com
Phone: +55 11 84 94 56 76
Skype: flavio.de.castro.alves.filho


2010/1/8 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

> Flavio de Castro Alves Filho wrote:
> > Of course :-)
> >
> > As I don't know the best way to send it, I attached the files.
> >
> > I hope everything is in there. I'm sorry if you find some ugly commented
> > debug code.
>
> Please send a diff.
>
> --
>                                             Gilles.
>

--00032555b4ceddfc1a047cae3c2c
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

In fact,<br><br>Much easier.<br><br>*** linux-03.20.00.05/arch/arm/mach-dav=
inci/gpio.c=A0=A0=A0 2009-07-29 02:53:15.000000000 -0300<br>--- linux-03.20=
.00.05_xenomai/arch/arm/mach-davinci/gpio.c=A0=A0=A0 2010-01-08 16:08:35.00=
0000000 -0200<br>
***************<br>*** 27,32 ****<br>--- 27,33 ----<br>=A0 <br>=A0 #include=
 &lt;asm/mach/irq.h&gt;<br>=A0 <br>+ #include &lt;asm/ipipe.h&gt;<br>=A0 <b=
r>=A0 static DEFINE_SPINLOCK(gpio_lock);<br>=A0 <br>***************<br>*** =
261,266 ****<br>
--- 262,315 ----<br>=A0 =A0=A0=A0 /* now it may re-trigger */<br>=A0 }<br>=
=A0 <br>+ #ifdef CONFIG_IPIPE<br>+ <br>+ /* Flavio Alves: for debugging */<=
br>+ extern void printascii(const char *);<br>+ <br>+ void __ipipe_mach_dem=
ux_irq(unsigned irq, struct pt_regs *regs)<br>
+ {<br>+ =A0=A0=A0 struct gpio_controller *__iomem g =3D get_irq_chip_data(=
irq);<br>+ =A0=A0=A0 struct irq_desc *desc;<br>+ =A0=A0=A0 u32 mask =3D 0xf=
fff;<br>+ <br>+ =A0=A0=A0 //printascii(&quot;1__ipipe_mach_demux_irq\n&quot=
;);<br>+ <br>+ =A0=A0=A0 /* we only care about one bank */<br>
+ =A0=A0=A0 if (irq &amp; 1)<br>+ =A0=A0=A0 =A0=A0=A0 mask &lt;&lt;=3D 16;<=
br>+ <br>+ =A0=A0=A0 desc =3D &amp;irq_desc[irq];<br>+ <br>+ =A0=A0=A0 /* t=
emporarily mask (level sensitive) parent IRQ */<br>+ =A0=A0=A0 desc-&gt;chi=
p-&gt;ack(irq);<br>+ =A0=A0=A0 while (1) {<br>
+ =A0=A0=A0 =A0=A0=A0 u32=A0=A0=A0 =A0=A0=A0 status;<br>+ =A0=A0=A0 =A0=A0=
=A0 int=A0=A0=A0 =A0=A0=A0 n;<br>+ =A0=A0=A0 =A0=A0=A0 int=A0=A0=A0 =A0=A0=
=A0 res;<br>+ <br>+ =A0=A0=A0 =A0=A0=A0 /* ack any irqs */<br>+ =A0=A0=A0 =
=A0=A0=A0 status =3D __raw_readl(&amp;g-&gt;intstat) &amp; mask;<br>+ =A0=
=A0=A0 =A0=A0=A0 if (!status)<br>+ =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 break;<br>
+ =A0=A0=A0 =A0=A0=A0 __raw_writel(status, &amp;g-&gt;intstat);<br>+ =A0=A0=
=A0 =A0=A0=A0 if (irq &amp; 1)<br>+ =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 status &g=
t;&gt;=3D 16;<br>+ <br>+ =A0=A0=A0 =A0=A0=A0 /* now demux them to the right=
 lowlevel handler */<br>+ =A0=A0=A0 =A0=A0=A0 n =3D (int)get_irq_data(irq);=
<br>
+ =A0=A0=A0 =A0=A0=A0 while (status) {<br>+ =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 r=
es =3D ffs(status);<br>+ =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 n +=3D res;<br>+ =A0=
=A0=A0 =A0=A0=A0 =A0=A0=A0 __ipipe_handle_irq((n-1),regs);<br>+ =A0=A0=A0 =
=A0=A0=A0 =A0=A0=A0 status &gt;&gt;=3D res;<br>+ =A0=A0=A0 =A0=A0=A0 }<br>+=
 =A0=A0=A0 }<br>+ =A0=A0=A0 desc-&gt;chip-&gt;unmask(irq);<br>
+ =A0=A0=A0 /* now it may re-trigger */<br>+ }<br>+ #endif /* CONFIG_IPIPE =
*/<br>+ <br>=A0 /*<br>=A0=A0 * NOTE:=A0 for suspend/resume, probably best t=
o make a platform_device with<br>=A0=A0 * suspend_late/resume_resume calls =
hooking into results of the set_wake()<br>
diff -crB linux-03.20.00.05/arch/arm/mach-davinci/include/mach/irqs.h linux=
-03.20.00.05_xenomai/arch/arm/mach-davinci/include/mach/irqs.h<br>*** linux=
-03.20.00.05/arch/arm/mach-davinci/include/mach/irqs.h=A0=A0=A0 2009-07-29 =
02:53:15.000000000 -0300<br>
--- linux-03.20.00.05_xenomai/arch/arm/mach-davinci/include/mach/irqs.h=A0=
=A0=A0 2010-01-06 16:45:56.000000000 -0200<br>***************<br>*** 359,36=
2 ****<br>--- 359,381 ----<br>=A0 #define IRQ_DA850_MCBSP1RINT=A0=A0=A0 =A0=
=A0=A0 99<br>=A0 #define IRQ_DA850_MCBSP1XINT=A0=A0=A0 =A0=A0=A0 100<br>
=A0 <br>+ #ifdef CONFIG_IPIPE<br>+ #if 0<br>+ #define __ipipe_mach_irq_mux_=
p(irq) \<br>+=A0=A0=A0=A0=A0=A0=A0=A0 ((unsigned) (irq - IRQ_DA8XX_GPIO0) \=
<br>+=A0=A0=A0=A0=A0=A0=A0=A0=A0 &lt;=3D (IRQ_DA8XX_GPIO7 - IRQ_DA8XX_GPIO0=
))<br>+ #endif<br>+ #define __ipipe_mach_irq_mux_p(irq) \<br>
+ =A0=A0=A0 ((irq) =3D=3D IRQ_DA8XX_GPIO0 \<br>+ =A0=A0=A0 =A0|| (irq) =3D=
=3D IRQ_DA8XX_GPIO1 \<br>+ =A0=A0=A0 =A0|| (irq) =3D=3D IRQ_DA8XX_GPIO2 \<b=
r>+ =A0=A0=A0 =A0|| (irq) =3D=3D IRQ_DA8XX_GPIO3 \<br>+ =A0=A0=A0 =A0|| (ir=
q) =3D=3D IRQ_DA8XX_GPIO4 \<br>+ =A0=A0=A0 =A0|| (irq) =3D=3D IRQ_DA8XX_GPI=
O5 \<br>
+ =A0=A0=A0 =A0|| (irq) =3D=3D IRQ_DA8XX_GPIO6 \<br>+ =A0=A0=A0 =A0|| (irq)=
 =3D=3D IRQ_DA8XX_GPIO7)<br>+ <br>+ <br>+ #endif /* CONFIG_IPIPE */<br>+ <b=
r>=A0 #endif /* __ASM_ARCH_IRQS_H */<br>diff -crB linux-03.20.00.05/arch/ar=
m/mach-davinci/irq.c linux-03.20.00.05_xenomai/arch/arm/mach-davinci/irq.c<=
br>
*** linux-03.20.00.05/arch/arm/mach-davinci/irq.c=A0=A0=A0 2009-07-29 02:53=
:15.000000000 -0300<br>--- linux-03.20.00.05_xenomai/arch/arm/mach-davinci/=
irq.c=A0=A0=A0 2010-01-08 15:22:13.000000000 -0200<br>***************<br>**=
* 111,119 ****<br>
--- 111,228 ----<br>=A0 =A0=A0=A0 .name=A0=A0=A0 =3D &quot;AINTC&quot;,<br>=
=A0 =A0=A0=A0 .ack=A0=A0=A0 =3D davinci_ack_irq,<br>=A0 =A0=A0=A0 .mask=A0=
=A0=A0 =3D davinci_mask_irq,<br>+ #ifdef CONFIG_IPIPE<br>+ =A0=A0=A0 .mask_=
ack =3D davinci_mask_irq,<br>+ #endif /* CONFIG_IPIPE */<br>
=A0 =A0=A0=A0 .unmask =3D davinci_unmask_irq,<br>=A0 };<br>=A0 <br>+ #ifdef=
 CONFIG_IPIPE<br>+ static const u8 da850_default_priorities[DAVINCI_N_AINTC=
_IRQ] __initdata =3D {<br>+=A0=A0 [IRQ_DA8XX_COMMTX]=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 =3D 7,<br>+=A0=A0 [IRQ_DA8XX_COMMRX]=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 =3D 7,<br>
+=A0=A0 [IRQ_DA8XX_NINT]=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 7,<b=
r>+=A0=A0 [IRQ_DA8XX_EVTOUT0]=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 7,<br>+=
=A0=A0 [IRQ_DA8XX_EVTOUT1]=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 7,<br>+=A0=
=A0 [IRQ_DA8XX_EVTOUT2]=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 7,<br>+=A0=A0 =
[IRQ_DA8XX_EVTOUT3]=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 7,<br>+=A0=A0 [IRQ=
_DA8XX_EVTOUT4]=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 7,<br>
+=A0=A0 [IRQ_DA8XX_EVTOUT5]=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 7,<br>+=A0=
=A0 [IRQ_DA8XX_EVTOUT6]=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 7,<br>+=A0=A0 =
[IRQ_DA8XX_EVTOUT7]=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 7,<br>+=A0=A0 [IRQ=
_DA8XX_CCINT0]=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 7,<br>+=A0=A0 [IRQ_D=
A8XX_CCERRINT]=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 7,<br>+=A0=A0 [IRQ_DA8XX_T=
CERRINT0]=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 7,<br>
+=A0=A0 [IRQ_DA8XX_AEMIFINT]=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 7,<br>+=A0=
=A0 [IRQ_DA8XX_I2CINT0]=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 5,<br>+=A0=A0 =
[IRQ_DA8XX_MMCSDINT0]=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 5,<br>+=A0=A0 [IRQ_DA8=
XX_MMCSDINT1]=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 5,<br>+=A0=A0 [IRQ_DA8XX_ALLIN=
T0]=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 5,<br>+=A0=A0 [IRQ_DA8XX_RTC]=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 4,<br>
+=A0=A0 [IRQ_DA8XX_SPINT0]=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 5,<br>+=
=A0=A0 [IRQ_DA8XX_TINT12_0]=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 2,<br>+=A0=A0=
 [IRQ_DA8XX_TINT34_0]=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 5,<br>+=A0=A0 [IRQ_=
DA8XX_TINT12_1]=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 5,<br>+=A0=A0 [IRQ_DA8XX_=
TINT34_1]=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 5,<br>+=A0=A0 [IRQ_DA8XX_UARTIN=
T0]=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 5,<br>
+=A0=A0 [IRQ_DA8XX_KEYMGRINT]=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 7,<br>+=A0=A0 =
[IRQ_DA850_MIOPU_BOOTCFG_ERR]=A0 =3D 7,<br>+=A0=A0 [IRQ_DA8XX_CHIPINT0]=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 7,<br>+=A0=A0 [IRQ_DA8XX_CHIPINT1]=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 =3D 7,<br>+=A0=A0 [IRQ_DA8XX_CHIPINT2]=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 =3D 7,<br>+=A0=A0 [IRQ_DA8XX_CHIPINT3]=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 =3D 7,<br>
+=A0=A0 [IRQ_DA8XX_TCERRINT1]=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 7,<br>+=A0=A0 =
[IRQ_DA8XX_C0_RX_THRESH_PULSE] =3D 7,<br>+=A0=A0 [IRQ_DA8XX_C0_RX_PULSE]=A0=
=A0=A0=A0=A0=A0=A0 =3D 7,<br>+=A0=A0 [IRQ_DA8XX_C0_TX_PULSE]=A0=A0=A0=A0=A0=
=A0=A0 =3D 7,<br>+=A0=A0 [IRQ_DA8XX_C0_MISC_PULSE]=A0=A0=A0=A0=A0 =3D 7,<br=
>+=A0=A0 [IRQ_DA8XX_C1_RX_THRESH_PULSE] =3D 7,<br>
+=A0=A0 [IRQ_DA8XX_C1_RX_PULSE]=A0=A0=A0=A0=A0=A0=A0 =3D 7,<br>+=A0=A0 [IRQ=
_DA8XX_C1_TX_PULSE]=A0=A0=A0=A0=A0=A0=A0 =3D 7,<br>+=A0=A0 [IRQ_DA8XX_C1_MI=
SC_PULSE]=A0=A0=A0=A0=A0 =3D 7,<br>+=A0=A0 [IRQ_DA8XX_MEMERR]=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 =3D 5,<br>+=A0=A0 [IRQ_DA8XX_GPIO0]=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 =3D 6,<br>+=A0=A0 [IRQ_DA8XX_GPIO1]=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 =3D 6,<br>
+=A0=A0 [IRQ_DA8XX_GPIO2]=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 6,<br>=
+=A0=A0 [IRQ_DA8XX_GPIO3]=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 6,<br>=
+=A0=A0 [IRQ_DA8XX_GPIO4]=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 6,<br>=
+=A0=A0 [IRQ_DA8XX_GPIO5]=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 6,<br>=
+=A0=A0 [IRQ_DA8XX_GPIO6]=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 6,<br>=
+=A0=A0 [IRQ_DA8XX_GPIO7]=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 6,<br>
+=A0=A0 [IRQ_DA8XX_GPIO8]=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 6,<br>=
+=A0=A0 [IRQ_DA8XX_I2CINT1]=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 5,<br>+=A0=
=A0 [IRQ_DA8XX_LCDINT]=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 5,<br>+=A0=
=A0 [IRQ_DA8XX_UARTINT1]=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 5,<br>+=A0=A0 [I=
RQ_DA8XX_MCASPINT]=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 5,<br>+=A0=A0 [IRQ_DA8=
XX_ALLINT1]=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 5,<br>
+=A0=A0 [IRQ_DA8XX_SPINT1]=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 5,<br>+=
=A0=A0 [IRQ_DA8XX_UHPI_INT1]=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 5,<br>+=A0=A0 [=
IRQ_DA8XX_USB_INT]=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 5,<br>+=A0=A0 [IRQ_=
DA8XX_IRQN]=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 5,<br>+=A0=A0 [IR=
Q_DA8XX_RWAKEUP]=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 5,<br>+=A0=A0 [IRQ_DA=
8XX_UARTINT2]=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 5,<br>
+=A0=A0 [IRQ_DA8XX_DFTSSINT]=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 5,<br>+=A0=
=A0 [IRQ_DA8XX_EHRPWM0]=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 7,<br>+=A0=A0 =
[IRQ_DA8XX_EHRPWM0TZ]=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 7,<br>+=A0=A0 [IRQ_DA8=
XX_EHRPWM1]=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 7,<br>+=A0=A0 [IRQ_DA8XX_E=
HRPWM1TZ]=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 7,<br>+=A0=A0 [IRQ_DA850_SATAINT]=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 5,<br>
+=A0=A0 [IRQ_DA850_TINT12_2]=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 5,<br>+=A0=
=A0 [IRQ_DA8XX_ECAP0]=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 7,<br>+=A0=
=A0 [IRQ_DA8XX_ECAP1]=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 7,<br>+=A0=
=A0 [IRQ_DA8XX_ECAP2]=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 7,<br>+=A0=
=A0 [IRQ_DA850_MMCSDINT0_1]=A0=A0=A0=A0=A0=A0=A0 =3D 5,<br>+=A0=A0 [IRQ_DA8=
50_MMCSDINT1_1]=A0=A0=A0=A0=A0=A0=A0 =3D 5,<br>
+=A0=A0 [IRQ_DA850_T12CMPINT0_2]=A0=A0=A0=A0=A0=A0 =3D 7,<br>+=A0=A0 [IRQ_D=
A850_T12CMPINT1_2]=A0=A0=A0=A0=A0=A0 =3D 7,<br>+=A0=A0 [IRQ_DA850_T12CMPINT=
2_2]=A0=A0=A0=A0=A0=A0 =3D 7,<br>+=A0=A0 [IRQ_DA850_T12CMPINT3_2]=A0=A0=A0=
=A0=A0=A0 =3D 7,<br>+=A0=A0 [IRQ_DA850_T12CMPINT4_2]=A0=A0=A0=A0=A0=A0 =3D =
7,<br>+=A0=A0 [IRQ_DA850_T12CMPINT5_2]=A0=A0=A0=A0=A0=A0 =3D 7,<br>
+=A0=A0 [IRQ_DA850_T12CMPINT6_2]=A0=A0=A0=A0=A0=A0 =3D 7,<br>+=A0=A0 [IRQ_D=
A850_T12CMPINT7_2]=A0=A0=A0=A0=A0=A0 =3D 7,<br>+=A0=A0 [IRQ_DA850_T12CMPINT=
0_3]=A0=A0=A0=A0=A0=A0 =3D 7,<br>+=A0=A0 [IRQ_DA850_T12CMPINT1_3]=A0=A0=A0=
=A0=A0=A0 =3D 7,<br>+=A0=A0 [IRQ_DA850_T12CMPINT2_3]=A0=A0=A0=A0=A0=A0 =3D =
7,<br>+=A0=A0 [IRQ_DA850_T12CMPINT3_3]=A0=A0=A0=A0=A0=A0 =3D 7,<br>
+=A0=A0 [IRQ_DA850_T12CMPINT4_3]=A0=A0=A0=A0=A0=A0 =3D 7,<br>+=A0=A0 [IRQ_D=
A850_T12CMPINT5_3]=A0=A0=A0=A0=A0=A0 =3D 7,<br>+=A0=A0 [IRQ_DA850_T12CMPINT=
6_3]=A0=A0=A0=A0=A0=A0 =3D 7,<br>+=A0=A0 [IRQ_DA850_T12CMPINT7_3]=A0=A0=A0=
=A0=A0=A0 =3D 7,<br>+=A0=A0 [IRQ_DA8XX_ARMCLKSTOPREQ]=A0=A0=A0=A0=A0 =3D 7,=
<br>+=A0=A0 [IRQ_DA850_RPIINT]=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 7,<b=
r>
+=A0=A0 [IRQ_DA850_VPIFINT]=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 7,<br>+=A0=
=A0 [IRQ_DA850_CCINT1]=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 7,<br>+=A0=
=A0 [IRQ_DA850_CCERRINT1]=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 7,<br>+=A0=A0 [IRQ=
_DA850_TCERRINT2]=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 7,<br>+=A0=A0 [IRQ_DA850_T=
INT12_3]=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 5,<br>+=A0=A0 [IRQ_DA850_MCBSP0R=
INT]=A0=A0=A0=A0=A0=A0=A0=A0 =3D 5,<br>
+=A0=A0 [IRQ_DA850_MCBSP0XINT]=A0=A0=A0=A0=A0=A0=A0=A0 =3D 5,<br>+=A0=A0 [I=
RQ_DA850_MCBSP1RINT]=A0=A0=A0=A0=A0=A0=A0=A0 =3D 5,<br>+=A0=A0 [IRQ_DA850_M=
CBSP1XINT]=A0=A0=A0=A0=A0=A0=A0=A0 =3D 5<br>+ };<br>+ #endif /* CONFIG_IPIP=
E */<br>+ <br>=A0 /* FIQ are pri 0-1; otherwise 2-7, with 7 lowest priority=
 */<br>
=A0 static const u8 dm644x_default_priorities[DAVINCI_N_AINTC_IRQ] __initda=
ta =3D {<br>=A0 =A0=A0=A0 [IRQ_VDINT0]=A0=A0=A0 =A0=A0=A0 =3D 2,<br>*******=
********<br>*** 325,330 ****<br>--- 434,443 ----<br>=A0 =A0=A0=A0 =A0=A0=A0=
 davinci_def_priorities =3D dm646x_default_priorities;<br>
=A0 =A0=A0=A0 else if (cpu_is_davinci_dm355())<br>=A0 =A0=A0=A0 =A0=A0=A0 d=
avinci_def_priorities =3D dm355_default_priorities;<br>+ #ifdef CONFIG_IPIP=
E<br>+ =A0=A0=A0 else if (cpu_is_da850())<br>+ =A0=A0=A0 =A0 davinci_def_pr=
iorities =3D da850_default_priorities;<br>
+ #endif /* CONFIG_IPIPE */<br>=A0 <br>=A0 =A0=A0=A0 /* Clear all interrupt=
 requests */<br>=A0 =A0=A0=A0 davinci_irq_writel(~0x0, FIQ_REG0_OFFSET);<br=
>***************<br>*** 361,369 ****<br>--- 474,484 ----<br>=A0 =A0=A0=A0 f=
or (i =3D 0; i &lt; DAVINCI_N_AINTC_IRQ; i++) {<br>
=A0 =A0=A0=A0 =A0=A0=A0 set_irq_chip(i, &amp;davinci_irq_chip_0);<br>=A0 =
=A0=A0=A0 =A0=A0=A0 set_irq_flags(i, IRQF_VALID | IRQF_PROBE);<br>+ #ifndef=
 CONFIG_IPIPE<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (i =
!=3D IRQ_TINT1_TINT34)<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 set_irq_handler(i, handle_edge_irq);<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 else<br>+ #endif /* CON=
FIG IPIPE */<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 set_irq_handler(i, handle_level_irq);<br>=A0 =A0=A0=A0 }=
<br>=A0 }<br>diff -crB linux-03.20.00.05/arch/arm/mach-davinci/time.c linux=
-03.20.00.05_xenomai/arch/arm/mach-davinci/time.c<br>
*** linux-03.20.00.05/arch/arm/mach-davinci/time.c=A0=A0=A0 2009-07-29 02:5=
3:15.000000000 -0300<br>--- linux-03.20.00.05_xenomai/arch/arm/mach-davinci=
/time.c=A0=A0=A0 2010-01-08 17:07:36.000000000 -0200<br>***************<br>=
*** 30,35 ****<br>
--- 30,41 ----<br>=A0 #include &lt;mach/cpu.h&gt;<br>=A0 #include &quot;clo=
ck.h&quot;<br>=A0 <br>+ #ifdef CONFIG_IPIPE<br>+ #ifdef CONFIG_NO_IDLE_HZ<b=
r>+ #error &quot;dynamic tick timer not yet supported with IPIPE&quot;<br>+=
 #endif /* CONFIG_NO_IDLE_HZ */<br>
+ #endif /* CONFIG_IPIPE */<br>+ <br>=A0 static struct clock_event_device c=
lockevent_davinci;<br>=A0 static unsigned int davinci_clock_tick_rate;<br>=
=A0 <br>***************<br>*** 70,75 ****<br>--- 76,102 ----<br>=A0 static =
int tid_system;<br>
=A0 static int tid_freerun;<br>=A0 <br>+ #ifdef CONFIG_IPIPE<br>+ int=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 __ipipe_mach_timerint=A0=A0=A0=A0=A0=A0=A0 =3D IRQ_DA=
8XX_TINT12_0;<br>+ int=A0=A0=A0=A0=A0=A0=A0=A0=A0 __ipipe_mach_timerstolen=
=A0=A0=A0=A0 =3D 0;<br>+ unsigned int __ipipe_mach_ticks_per_jiffy =3D LATC=
H;<br>
+ static int=A0=A0 davinci_timer_initialized;<br>+ union tsc_reg {<br>+ #if=
def __BIG_ENDIAN<br>+ =A0=A0=A0 struct {<br>+ =A0=A0=A0 =A0=A0=A0 unsigned =
long high;<br>+ =A0=A0=A0 =A0=A0=A0 unsigned long low;<br>+ =A0=A0=A0 };<br=
>+ #else=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 /* __LITTLE_ENDIAN */<br>
+ =A0=A0=A0 struct {<br>+ =A0=A0=A0 =A0=A0=A0 unsigned long low;<br>+ =A0=
=A0=A0 =A0=A0=A0 unsigned long high;<br>+ =A0=A0=A0 };<br>+ #endif=A0=A0=A0=
 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 /* __LITTLE_ENDIAN */<br>+ =A0=A0=A0 unsigne=
d long long full;<br>+ };<br>+ #endif /* CONFIG_IPIPE */<br>+ <br>
=A0 /*<br>=A0=A0 * This driver configures the 2 64-bit count-up timers as 4=
 independent<br>=A0=A0 * 32-bit count-up timers used as follows:<br>*******=
********<br>*** 92,97 ****<br>--- 119,125 ----<br>=A0 #define TGCR=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x24<br>
=A0 #define WDTCR=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 0x28<br>=A0 #define CMP12(n)=A0=A0=A0 =A0=A0=A0 =A0=A0=A0=A0 (=
0x60 + ((n) &lt;&lt; 2))<br>+ #define INTCTLSTAT=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x44<br>=A0 <br>=A0 /* Timer register bitfields=
 */<br>=A0 #define TCR_ENAMODE_DISABLE=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x0<br>
***************<br>*** 137,142 ****<br>--- 165,283 ----<br>=A0 #define TIME=
R_OPTS_ONESHOT=A0=A0=A0 0x01<br>=A0 #define TIMER_OPTS_PERIODIC=A0=A0 0x02<=
br>=A0 <br>+ /* Flags to be set when it is necessary to clear the */<br>+ /=
* status register for timer interrupts=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 */<br>
+ #define TIMER12_CLEAR_PRDINT=A0 0x02<br>+ #define TIMER12_CLEAR_EVTINT=A0=
 0x04<br>+ <br>+ #ifdef CONFIG_IPIPE<br>+ #ifdef CONFIG_SMP<br>+ static uni=
on tsc_reg tsc[NR_CPUS];<br>+ <br>+ void __ipipe_mach_get_tscinfo(struct __=
ipipe_tscinfo *info)<br>
+ {<br>+ =A0=A0=A0 info-&gt;type =3D IPIPE_TSC_TYPE_NONE;<br>+ }<br>+ #else=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 /* !CONFIG_SMP */<br>+ static union=
 tsc_reg *tsc;<br>+ <br>+ void __ipipe_mach_get_tscinfo(struct __ipipe_tsci=
nfo *info)<br>+ {<br>+ =A0=A0=A0 info-&gt;type =3D IPIPE_TSC_TYPE_FREERUNNI=
NG;<br>
+ =A0=A0=A0 info-&gt;u.fr.counter =3D (unsigned *)(DAVINCI_TIMER0_BASE + TI=
M12);<br>+ =A0=A0=A0 info-&gt;u.fr.mask =3D 0xffffffff;<br>+ =A0=A0=A0 info=
-&gt;u.fr.tsc =3D &amp;tsc-&gt;full;<br>+ }<br>+ #endif=A0=A0=A0 =A0=A0=A0 =
=A0=A0=A0 =A0=A0=A0 /* !CONFIG_SMP */<br>+ <br>
+ void __ipipe_mach_acktimer(void)<br>+ {<br>+=A0=A0 void __iomem *base =3D=
 IO_ADDRESS(DAVINCI_TIMER0_BASE);<br>+=A0=A0 unsigned long status;<br>+ <br=
>+=A0=A0 status =3D __raw_readl(base + INTCTLSTAT);<br>+=A0=A0 status |=3D =
(TIMER12_CLEAR_PRDINT | TIMER12_CLEAR_EVTINT);<br>
+ <br>+=A0=A0 __raw_writel(status,base+INTCTLSTAT);<br>+ }<br>+ <br>+ stati=
c void ipipe_mach_update_tsc(void)<br>+ {<br>+=A0=A0 union tsc_reg *local_t=
sc;<br>+=A0=A0 unsigned long stamp, flags;<br>+=A0=A0 void __iomem *base =
=3D IO_ADDRESS(DAVINCI_TIMER0_BASE);<br>
+ <br>+=A0=A0 local_irq_save_hw(flags);<br>+=A0=A0 local_tsc =3D &amp;tsc[i=
pipe_processor_id()];<br>+=A0=A0 stamp =3D __raw_readl(base + TIM12);<br>+=
=A0=A0 if (unlikely(stamp &lt; local_tsc-&gt;low))<br>+=A0=A0=A0=A0 /* 32 b=
it counter wrapped, increment high word. */<br>
+=A0=A0=A0=A0 local_tsc-&gt;high++;<br>+=A0=A0 local_tsc-&gt;low =3D stamp;=
<br>+=A0=A0 local_irq_restore_hw(flags);<br>+ }<br>+ <br>+ notrace unsigned=
 long long __ipipe_mach_get_tsc(void)<br>+ {<br>+=A0=A0 if (likely(davinci_=
timer_initialized)) {<br>
+=A0=A0=A0=A0 union tsc_reg *local_tsc, result;<br>+=A0=A0=A0=A0 unsigned l=
ong stamp;<br>+=A0=A0=A0=A0 void __iomem *base =3D IO_ADDRESS(DAVINCI_TIMER=
0_BASE);<br>+ <br>+=A0=A0=A0=A0 local_tsc =3D &amp;tsc[ipipe_processor_id()=
];<br>+ <br>+=A0=A0=A0=A0 __asm__(&quot;ldmia %1, %M0\n&quot;:<br>
+ =A0=A0=A0 =A0=A0=A0 &quot;=3Dr&quot;(result.full): &quot;r&quot;(local_ts=
c), &quot;m&quot;(*local_tsc));<br>+=A0=A0=A0=A0 barrier();<br>+=A0=A0=A0=
=A0 stamp =3D __raw_readl(base + TIM12);<br>+=A0=A0=A0=A0 if (unlikely(stam=
p &lt; result.low))<br>+=A0=A0=A0=A0=A0=A0 result.high++;<br>
+=A0=A0=A0=A0 result.low =3D stamp;<br>+=A0=A0=A0=A0 return result.full;<br=
>+=A0=A0 }<br>+=A0=A0 return 0;<br>+ }<br>+ EXPORT_SYMBOL(__ipipe_mach_get_=
tsc);<br>+ <br>+ /*<br>+=A0 * Reprogram the timer<br>+=A0 */<br>+ void __ip=
ipe_mach_set_dec(unsigned long delay)<br>
+ {<br>+=A0=A0 unsigned long flags;<br>+=A0=A0 unsigned int=A0 value;<br>+=
=A0=A0 void __iomem *base =3D IO_ADDRESS(DAVINCI_TIMER0_BASE);<br>+ <br>+=
=A0=A0 if (delay &gt; 20) {<br>+=A0=A0=A0=A0 local_irq_save_hw(flags);<br>+=
=A0=A0=A0=A0 <br>+=A0=A0=A0=A0 value =3D __raw_readl(base + TIM12) + delay;=
<br>
+=A0=A0=A0=A0 __raw_writel(value,base + CMP12(0));<br>+=A0=A0=A0=A0 local_i=
rq_restore_hw(flags);<br>+=A0=A0 } else {<br>+=A0=A0=A0=A0 ipipe_trigger_ir=
q(IRQ_DA8XX_TINT12_0);<br>+=A0=A0 }<br>+ }<br>+ EXPORT_SYMBOL(__ipipe_mach_=
set_dec);<br>+ <br>+ unsigned long __ipipe_mach_get_dec(void)<br>
+ {<br>+=A0=A0 unsigned long value;<br>+=A0=A0 void __iomem *base =3D IO_AD=
DRESS(DAVINCI_TIMER0_BASE);<br>+ <br>+=A0=A0 value=A0 =3D __raw_readl(base =
+ CMP12(0));<br>+=A0=A0 value -=3D __raw_readl(base + TIM12);<br>+ <br>+=A0=
=A0 return value;<br>+ }<br>
+ <br>+ int __ipipe_check_tickdev(const char *devname)<br>+ {<br>+=A0=A0 re=
turn !strcmp(devname, <a href=3D"http://clockevent_davinci.name">clockevent=
_davinci.name</a>);<br>+ }<br>+ <br>+ #endif /* CONFIG_IPIPE */<br>+ <br>=
=A0 static int timer32_config(struct timer_s *t)<br>
=A0 {<br>=A0 =A0=A0=A0 u32 tcr =3D __raw_readl(t-&gt;base + TCR);<br>******=
*********<br>*** 167,176 ****<br>--- 308,324 ----<br>=A0 =A0=A0=A0 return _=
_raw_readl(t-&gt;base + t-&gt;tim_off);<br>=A0 }<br>=A0 <br>+ /* Flavio Alv=
es: for debugging */<br>
+ extern void printascii(const char *);<br>+ <br>=A0 static irqreturn_t tim=
er_interrupt(int irq, void *dev_id)<br>=A0 {<br>=A0 =A0=A0=A0 struct clock_=
event_device *evt =3D &amp;clockevent_davinci;<br>=A0 <br>+ =A0=A0=A0 //=A0=
=A0=A0 printascii(&quot;entrei\n&quot;);<br>
+ #ifdef CONFIG_IPIPE<br>+ =A0=A0=A0 ipipe_mach_update_tsc();<br>+ #endif=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 /* CONFIG_IPIPE */<br>=A0 =A0=A0=A0 evt-&gt;event_handler(evt);<br>=A0 =A0=
=A0=A0 return IRQ_HANDLED;<br>=A0 }<br>***************<br>*** 302,307 ****<=
br>
--- 449,463 ----<br>=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 timer32_config(timers=
[i]);<br>=A0 =A0=A0=A0 =A0=A0=A0 }<br>=A0 =A0=A0=A0 }<br>+ <br>+ #ifdef CON=
FIG_IPIPE<br>+ #ifndef CONFIG_SMP<br>+ =A0=A0=A0 tsc =3D (union tsc_reg *)_=
_ipipe_tsc_area;<br>+ =A0=A0=A0 barrier();<br>+ #endif=A0=A0=A0 =A0=A0=A0 =
=A0=A0=A0 =A0=A0=A0 /* CONFIG_SMP */<br>
+ =A0=A0=A0 davinci_timer_initialized =3D 1;<br>+ #endif=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* CONFIG_IPIPE *=
/<br>+ <br>=A0 }<br>=A0 <br>=A0 /*<br>***************<br>*** 311,321 ****<b=
r>=A0 {<br>=A0 =A0=A0=A0 struct timer_s *t;<br>=A0 <br>! =A0=A0=A0 if (tid_=
freerun =3D=3D -1)<br>
=A0 =A0=A0=A0 =A0=A0=A0 t =3D timers[tid_system];<br>! =A0=A0=A0 else<br>=
=A0 =A0=A0=A0 =A0=A0=A0 t =3D timers[tid_freerun];<br>! <br>=A0 =A0=A0=A0 r=
eturn (cycles_t)timer32_read(t);<br>=A0 }<br>=A0 <br>--- 467,478 ----<br>=
=A0 {<br>=A0 =A0=A0=A0 struct timer_s *t;<br>=A0 <br>!=A0=A0 if (tid_freeru=
n =3D=3D -1) {<br>
=A0 =A0=A0=A0 =A0=A0=A0 t =3D timers[tid_system];<br>!=A0=A0 }<br>!=A0=A0 e=
lse {<br>=A0 =A0=A0=A0 =A0=A0=A0 t =3D timers[tid_freerun];<br>!=A0=A0 }<br=
>=A0 =A0=A0=A0 return (cycles_t)timer32_read(t);<br>=A0 }<br>=A0 <br>******=
*********<br>*** 549,551 ****<br>--- 706,718 ----<br>
=A0 =A0=A0=A0 wdtcr =3D 0x00004000;<br>=A0 =A0=A0=A0 __raw_writel(wdtcr, ba=
se + WDTCR);<br>=A0 }<br>+ <br>+ #ifdef CONFIG_IPIPE<br>+ void __ipipe_mach=
_release_timer(void)<br>+ {<br>+=A0=A0 davinci_set_mode(clockevent_davinci.=
mode, &amp;clockevent_davinci);<br>
+=A0=A0 if (clockevent_davinci.mode =3D=3D CLOCK_EVT_MODE_ONESHOT)<br>+=A0=
=A0=A0=A0 davinci_set_next_event(LATCH, &amp;clockevent_davinci);<br>+ }<br=
>+ EXPORT_SYMBOL(__ipipe_mach_release_timer);<br>+ #endif /* CONFIG_IPIPE *=
/<br><br>Best regards,<br>
<br>Flavio<br><br clear=3D"all">Flavio de Castro Alves Filho<br>Phi Innovat=
ions - Embedded Software Services<br><a href=3D"http://www.phiinnovations.c=
om">www.phiinnovations.com</a><br>Phone: +55 11 84 94 56 76<br>Skype: flavi=
o.de.castro.alves.filho<br>

<br><br><div class=3D"gmail_quote">2010/1/8 Gilles Chanteperdrix <span dir=
=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.cha=
nteperdrix@domain.hid</a>&gt;</span><br><blockquote class=3D"gmail_quote" =
style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8=
ex; padding-left: 1ex;">
<div class=3D"im">Flavio de Castro Alves Filho wrote:<br>
</div><div class=3D"im">&gt; Of course :-)<br>
&gt;<br>
&gt; As I don&#39;t know the best way to send it, I attached the files.<br>
&gt;<br>
&gt; I hope everything is in there. I&#39;m sorry if you find some ugly com=
mented<br>
&gt; debug code.<br>
<br>
</div>Please send a diff.<br>
<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.<br>
</font></blockquote></div><br>

--00032555b4ceddfc1a047cae3c2c--

