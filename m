MIME-Version: 1.0
In-Reply-To: <20141022062825.GC29673@sisyphus.hd.free.fr>
References: <20141005220404.GL14975@sisyphus.hd.free.fr>
 <CACreCVJFa6FB=3WR_OuMvACeYOWaA035T4KK7dFg8vHhyqkz8w@mail.gmail.com>
 <20141005223051.GN14975@sisyphus.hd.free.fr>
 <CACreCVLQsaq01vsNA_V_bu9_NyMCTwZTiZJo2sFXJHgaaVjQVg@mail.gmail.com>
 <54365E17.3020102@xenomai.org>
 <CACreCV+QtwuhhGeFpnuLP-6Y1FfLCQHqNkrzyfwgqEgrxXU9eQ@mail.gmail.com>
 <5436607B.7090609@xenomai.org>
 <CACreCV+HdWC9Deysy2miL2NZ65RFVRRk87uG9rBaUBrn=hhqag@mail.gmail.com>
 <5436A64B.90705@xenomai.org>
 <CACreCVJUPiiX_7733g1EWZCVmUH0oFWhLknhKB2K8se1fi4a1g@mail.gmail.com>
 <20141022062825.GC29673@sisyphus.hd.free.fr>
Date: Wed, 29 Oct 2014 09:23:16 +0800
Message-ID: <CACreCVJSytzK85ANWmwWjctBpJfEr1b916R6dNPmSGugN_vRLA@mail.gmail.com>
From: GP Orcullo <kinsamanka@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Switchtest failures on ODROIDU3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On Wed, Oct 22, 2014 at 2:28 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> On Mon, Oct 20, 2014 at 03:29:26PM +0800, GP Orcullo wrote:
>> On Oct 9, 2014 11:14 PM, "Gilles Chanteperdrix" <
>> gilles.chanteperdrix@xenomai.org> wrote:
>> >
>> > On 10/09/2014 01:06 PM, GP Orcullo wrote:
>> > > On Oct 9, 2014 6:16 PM, "Gilles Chanteperdrix" <
>> > > gilles.chanteperdrix@xenomai.org> wrote:
>> > >>
>> > >> On 10/09/2014 12:12 PM, GP Orcullo wrote:
>> > >>> On Thu, Oct 9, 2014 at 6:06 PM, Gilles Chanteperdrix
>> > >>> <gilles.chanteperdrix@xenomai.org> wrote:
>> > >>>> On 10/09/2014 12:02 PM, GP Orcullo wrote:
>> > >>>>> On Mon, Oct 6, 2014 at 6:30 AM, Gilles Chanteperdrix
>> > >>>>> <gilles.chanteperdrix@xenomai.org> wrote:
>> > >>>>>>
>> > >>>>>> It means that Linux was interrupted by Xenomai during its timer
>> > >>>>>> interrupt, and that Xenomai interrupted it for 280us. This may
>> > >>>>>> happens with switchtest if it has a really long chain of context
>> > >>>>>> switches. If you want to check what happened, enable the I-pipe
>> > >>>>>> tracer, and trigger a trace freeze right before this message.
>> > >>>>>>
>> > >>>>>
>> > >>>>> One more piece to the puzzle: disabling CONFIG_IPIPE_DEBUG_INTERNAL
>> > >>>>> causes the system to lockup.
>> > >>>>>
>> > >>>> How do you know this is related?
>> > >>>>
>> > >>>>
>>  Gilles.
>> > >>>
>> > >>> Sorry, I quoted the wrong message.
>> > >>>
>> > >>> If CONFIG_PREEMPT is disabled and CONFIG_IPIPE_DEBUG_INTERNAL is not
>> > >>> disabled, the system works fine.
>> > >>>
>> > >> So, there is a problem, likely in your port with CONFIG_PREEMPT, but
>> > >> maybe in Xenomai (I need to check, because I am not so sure I tested
>> > >> xeno-regression-test without CONFIG_PREEMPT).
>> > >>
>> > >> And there is a problem in your port without
>> CONFIG_IPIPE_DEBUG_INTERNAL.
>> > >> This I do not need to check, I have tested Xenomai wihout this option
>> > >> enabled.
>> > >>
>> > >> So, my question is: how do you know the two issues are related?
>> > >>
>> > >
>> > > I don't know the answer.
>> > >
>> > > I'm only looking at the effects and not the cause of the issue.
>> > >
>> > > So,  where shall I start digging?  What's in
>> CONFIG_IPIPE_DEBUG_INTERNAL
>> > > that would somehow suppress the problem?
>> > >
>> >
>> > Quite frankly, I would go the other way: check that every piece of code
>> > which may be executed over real-time context does not use any Linux
>> > code. That does not include a lot of code, actually all that is covered
>> > by the porting guide:
>> > - the interrupt controller callbacks (note that the GIC handles some SOC
>> > specific callabcks, so if you have some, you need to check them)
>> > - the chained interrupt demux handlers
>> > - the timer and tsc management functions.
>> > - some workaround specific code that hooks in the iowrite/writel
>> > functions, such as the L2 cache synchronization on omap4.
>> >
>> > And it seems that is all, so, there should not be a lot of code to check.
>> >
>> >
>>
>> Hello Gilles,
>>
>> Thanks for all the help.
>>
>> The problem was traced to the tsc emulation,  the counter somehow gets
>> messed up when the global timer is shared with Linux.
>
> Hi,
>
> could you try the following patch and tell me if it avoids the
> issue?
>
> Thanks.
> Regards.
>
> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
> index fb28b2e..150beb5 100644
> --- a/arch/arm/boot/dts/imx6qdl.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> @@ -106,6 +106,12 @@
>                         clocks = <&clks 15>;
>                 };
>
> +               timer@00a00200 {
> +                       compatible = "arm,cortex-a9-global-timer";
> +                       reg = <0x00a00200 0x20>;
> +                       clocks = <&clks 15>;
> +               };
> +
>                 L2: l2-cache@00a02000 {
>                         compatible = "arm,pl310-cache";
>                         reg = <0x00a02000 0x1000>;
> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
> index a914496..2cb8144 100644
> --- a/arch/arm/boot/dts/omap4.dtsi
> +++ b/arch/arm/boot/dts/omap4.dtsi
> @@ -67,6 +67,12 @@
>                 interrupts = <GIC_PPI 13 (GIC_CPU_MASK_RAW(3) | IRQ_TYPE_LEVEL_HIGH)>;
>         };
>
> +       global_timer: timer@48240200 {
> +               compatible = "arm,cortex-a9-global-timer";
> +               reg = <0x48240200 0x20>;
> +               clocks = <&mpu_periphclk>;
> +       };
> +
>         /*
>          * The soc node represents the soc top level view. It is uses for IPs
>          * that are not memory mapped in the MPU view or for the MPU itself.
> diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
> index f0b7c52..864651c 100644
> --- a/arch/arm/kernel/smp_twd.c
> +++ b/arch/arm/kernel/smp_twd.c
> @@ -28,7 +28,6 @@
>  #include <asm/smp_plat.h>
>  #include <asm/smp_twd.h>
>  #include <asm/cputype.h>
> -#include <asm/ipipe.h>
>
>  /* set up by the platform code */
>  static void __iomem *twd_base;
> @@ -51,42 +50,9 @@ static void twd_ack(void)
>         writel_relaxed(1, twd_base + TWD_TIMER_INTSTAT);
>  }
>
> -static struct __ipipe_tscinfo tsc_info;
> -
>  static void twd_get_clock(struct device_node *np);
>  static void __cpuinit twd_calibrate_rate(void);
>
> -static void __init gt_setup(unsigned long base_paddr, unsigned bits)
> -{
> -       if ((read_cpuid_id() & 0xf00000) == 0)
> -               return;
> -
> -       gt_base = ioremap(base_paddr, SZ_256);
> -       BUG_ON(!gt_base);
> -
> -       /* Start global timer */
> -       __raw_writel(1, gt_base + 0x8);
> -
> -       tsc_info.type = IPIPE_TSC_TYPE_FREERUNNING;
> -       tsc_info.freq = twd_timer_rate;
> -       tsc_info.counter_vaddr = (unsigned long)gt_base;
> -       tsc_info.u.counter_paddr = base_paddr;
> -
> -       switch(bits) {
> -       case 64:
> -               tsc_info.u.mask = 0xffffffffffffffffULL;
> -               break;
> -       case 32:
> -               tsc_info.u.mask = 0xffffffff;
> -               break;
> -       default:
> -               /* Only supported as a 32 bits or 64 bits */
> -               BUG();
> -       }
> -
> -       __ipipe_tsc_register(&tsc_info);
> -}
> -
>  #ifdef CONFIG_IPIPE_DEBUG_INTERNAL
>
>  static DEFINE_PER_CPU(int, irqs);
> @@ -460,8 +426,6 @@ out_free:
>
>  int __init twd_local_timer_register(struct twd_local_timer *tlt)
>  {
> -       int rc;
> -
>         if (twd_base || twd_evt)
>                 return -EBUSY;
>
> @@ -472,13 +436,7 @@ int __init twd_local_timer_register(struct twd_local_timer *tlt)
>                 return -ENOMEM;
>
>
> -       rc = twd_local_timer_common_register(NULL);
> -       if (rc == 0)
> -#ifdef CONFIG_IPIPE
> -               gt_setup(tlt->res[0].start - 0x400, 32);
> -#endif
> -
> -       return rc;
> +       return twd_local_timer_common_register(NULL);
>  }
>
>  #ifdef CONFIG_OF
> @@ -503,16 +461,6 @@ static void __init twd_local_timer_of_register(struct device_node *np)
>
>
>         err = twd_local_timer_common_register(np);
> -#ifdef CONFIG_IPIPE
> -       if (err == 0) {
> -               struct resource res;
> -
> -               if (of_address_to_resource(np, 0, &res))
> -                       res.start = 0;
> -
> -               gt_setup(res.start - 0x400, 32);
> -       }
> -#endif /* CONFIG_IPIPE */
>
>  out:
>         WARN(err, "twd_local_timer_of_register failed (%d)\n", err);
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index 33567aa..b825a09 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -808,6 +808,7 @@ config SOC_IMX6Q
>         select PL310_ERRATA_727915 if CACHE_PL310
>         select PL310_ERRATA_769419 if CACHE_PL310
>         select PM_OPP if PM
> +       select ARM_GLOBAL_TIMER if SMP && IPIPE
>
>         help
>           This enables support for Freescale i.MX6 Quad processor.
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index 0af7ca0..63a5b42 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -45,6 +45,7 @@ config ARCH_OMAP4
>         select USB_ARCH_HAS_EHCI if USB_SUPPORT
>         select ARM_ERRATA_754322
>         select ARM_ERRATA_775420
> +       select ARM_GLOBAL_TIMER if IPIPE && SMP
>
>  config SOC_OMAP5
>         bool "TI OMAP5"
> diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksource/arm_global_timer.c
> index 0fc31d0..62e208b 100644
> --- a/drivers/clocksource/arm_global_timer.c
> +++ b/drivers/clocksource/arm_global_timer.c
> @@ -24,6 +24,7 @@
>  #include <linux/sched_clock.h>
>
>  #include <asm/cputype.h>
> +#include <asm/ipipe.h>
>
>  #define GT_COUNTER0    0x00
>  #define GT_COUNTER1    0x04
> @@ -48,6 +49,7 @@
>   * the units for all operations.
>   */
>  static void __iomem *gt_base;
> +static unsigned long gt_pbase;
>  static unsigned long gt_clk_rate;
>  static int gt_ppi;
>  static struct clock_event_device __percpu *gt_evt;
> @@ -210,6 +212,16 @@ static u64 notrace gt_sched_clock_read(void)
>
>  static void __init gt_clocksource_init(void)
>  {
> +#ifdef CONFIG_IPIPE
> +       struct __ipipe_tscinfo tsc_info = {
> +               .type = IPIPE_TSC_TYPE_FREERUNNING,
> +               .freq = gt_clk_rate,
> +               .counter_vaddr = (unsigned long)gt_base,
> +               .u.counter_paddr = gt_pbase,
> +               .u.mask = 0xffffffff,
> +       };
> +#endif
> +
>         writel(0, gt_base + GT_CONTROL);
>         writel(0, gt_base + GT_COUNTER0);
>         writel(0, gt_base + GT_COUNTER1);
> @@ -219,6 +231,9 @@ static void __init gt_clocksource_init(void)
>  #ifdef CONFIG_CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
>         sched_clock_register(gt_sched_clock_read, 64, gt_clk_rate);
>  #endif
> +#ifdef CONFIG_IPIPE
> +       __ipipe_tsc_register(&tsc_info);
> +#endif
>         clocksource_register_hz(&gt_clocksource, gt_clk_rate);
>  }
>
> @@ -242,8 +257,9 @@ static struct notifier_block gt_cpu_nb = {
>
>  static void __init global_timer_of_register(struct device_node *np)
>  {
> +       int err = 0, install_clockevent = 1;
> +       struct resource res;
>         struct clk *gt_clk;
> -       int err = 0;
>
>         /*
>          * In r2p0 the comparators for each processor with the global timer
> @@ -252,13 +268,15 @@ static void __init global_timer_of_register(struct device_node *np)
>          */
>         if ((read_cpuid_id() & 0xf0000f) < 0x200000) {
>                 pr_warn("global-timer: non support for this cpu version.\n");
> -               return;
> +               install_clockevent = 0;
>         }
>
> -       gt_ppi = irq_of_parse_and_map(np, 0);
> -       if (!gt_ppi) {
> -               pr_warn("global-timer: unable to parse irq\n");
> -               return;
> +       if (install_clockevent) {
> +               gt_ppi = irq_of_parse_and_map(np, 0);
> +               if (!gt_ppi) {
> +                       pr_warn("global-timer: unable to parse irq\n");
> +                       install_clockevent = 0;
> +               }
>         }
>
>         gt_base = of_iomap(np, 0);
> @@ -267,6 +285,11 @@ static void __init global_timer_of_register(struct device_node *np)
>                 return;
>         }
>
> +       if (of_address_to_resource(np, 0, &res))
> +               res.start = 0;
> +
> +       gt_pbase = res.start;
> +
>         gt_clk = of_clk_get(np, 0);
>         if (!IS_ERR(gt_clk)) {
>                 err = clk_prepare_enable(gt_clk);
> @@ -279,37 +302,39 @@ static void __init global_timer_of_register(struct device_node *np)
>         }
>
>         gt_clk_rate = clk_get_rate(gt_clk);
> -       gt_evt = alloc_percpu(struct clock_event_device);
> -       if (!gt_evt) {
> -               pr_warn("global-timer: can't allocate memory\n");
> -               err = -ENOMEM;
> -               goto out_clk;
> -       }
> -
> -       err = request_percpu_irq(gt_ppi, gt_clockevent_interrupt,
> +       if (install_clockevent) {
> +               gt_evt = alloc_percpu(struct clock_event_device);
> +               if (!gt_evt) {
> +                       pr_warn("global-timer: can't allocate memory\n");
> +                       err = -ENOMEM;
> +                       goto out_clk;
> +               }
> +
> +               err = request_percpu_irq(gt_ppi, gt_clockevent_interrupt,
>                                  "gt", gt_evt);
> -       if (err) {
> -               pr_warn("global-timer: can't register interrupt %d (%d)\n",
> -                       gt_ppi, err);
> -               goto out_free;
> -       }
> -
> -       err = register_cpu_notifier(&gt_cpu_nb);
> -       if (err) {
> -               pr_warn("global-timer: unable to register cpu notifier.\n");
> -               goto out_irq;
> +               if (err) {
> +                       pr_warn("global-timer: can't register interrupt %d (%d)\n",
> +                               gt_ppi, err);
> +                       goto out_free;
> +               }
> +
> +               err = register_cpu_notifier(&gt_cpu_nb);
> +               if (err) {
> +                       pr_warn("global-timer: unable to register cpu notifier.\n");
> +                       free_percpu_irq(gt_ppi, gt_evt);
> +                 out_free:
> +                       free_percpu(gt_evt);
> +                       install_clockevent = 0;
> +               }
>         }
>
>         /* Immediately configure the timer on the boot CPU */
>         gt_clocksource_init();
> -       gt_clockevents_init(this_cpu_ptr(gt_evt));
> +       if (install_clockevent)
> +               gt_clockevents_init(this_cpu_ptr(gt_evt));
>
>         return;
>
> -out_irq:
> -       free_percpu_irq(gt_ppi, gt_evt);
> -out_free:
> -       free_percpu(gt_evt);
>  out_clk:
>         clk_disable_unprepare(gt_clk);
>  out_unmap:
>
> --
>                                             Gilles.

Exynos is not using the arm global timers.

I'm still experiencing some intermittent "rcu_preempt detected stalls".

Maybe I'm dealing with more than one issue here.

-- 
GP Orcullo

