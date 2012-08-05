Message-ID: <501EF07E.7010300@xenomai.org>
Date: Mon, 06 Aug 2012 00:15:26 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <6B3AC2788014DD49B43AF9611365BBAA21B0B94DE9@mary.at.omicron.at>	<5009902B.7070705@xenomai.org>	<6B3AC2788014DD49B43AF9611365BBAA21B0B954F3@mary.at.omicron.at>	<500D298C.6080601@xenomai.org>	<6B3AC2788014DD49B43AF9611365BBAA21B0B9550A@mary.at.omicron.at>	<6B3AC2788014DD49B43AF9611365BBAA21B0B95718@mary.at.omicron.at>
	<500E4603.2000002@xenomai.org> <5011A6ED.2080303@xenomai.org>
	<6B3AC2788014DD49B43AF9611365BBAA21B0C0D253@mary.at.omicron.at>
	<5016B61F.5050702@xenomai.org>
	<6B3AC2788014DD49B43AF9611365BBAA21B0C0D2C5@mary.at.omicron.at>
In-Reply-To: <6B3AC2788014DD49B43AF9611365BBAA21B0C0D2C5@mary.at.omicron.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] xenomai 2.6.1 on ixp4xx hangs on boot
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Lausch <michael.lausch@omicron.at>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 07/31/2012 08:15 AM, Michael Lausch wrote:

> Ok.
> Will prepare the patch for 3.2.21, but I'll be using 3.2.max until I have to freeze the kernel version.
> As always I read your email with the pointer to the very nice ipipe porting guide *after* I pressed the
> Send button. There's also the exaplanation of the ipipe_timer struct and I'll use the info in there to 
> clean up my patch. 


I do not understand what cleanup is needed: as far as I can tell, the 
conversion to ipipe_timer was already done in the I-pipe core patch. 
What is missing is the kuser based tsc emulation. It seems the 
following patch would be sufficient. Could you test it and tell us 
whether it works?

Regards.

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 6e5da70..0ea9b7d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -528,6 +528,7 @@ config ARCH_IXP4XX
 	select HAVE_SCHED_CLOCK
 	select MIGHT_HAVE_PCI
 	select DMABOUNCE if PCI
+	select IPIPE_ARM_KUSER_TSC if IPIPE
 	help
 	  Support for Intel's IXP4XX (XScale) family of processors.
 
diff --git a/arch/arm/mach-ixp4xx/common.c b/arch/arm/mach-ixp4xx/common.c
index f4b878e..cbb1cd5 100644
--- a/arch/arm/mach-ixp4xx/common.c
+++ b/arch/arm/mach-ixp4xx/common.c
@@ -50,53 +50,6 @@ static void __init ixp4xx_clocksource_init(void);
 static void __init ixp4xx_clockevent_init(void);
 static struct clock_event_device clockevent_ixp4xx;
 
-#ifdef CONFIG_IPIPE
-static int ixp4xx_timer_initialized;
-
-#define ONE_SHOT_ENABLE (IXP4XX_OST_ENABLE|IXP4XX_OST_ONE_SHOT)
-
-union tsc_reg {
-#ifdef __BIG_ENDIAN
-	struct {
-		unsigned long high;
-		unsigned long low;
-	};
-#else /* __LITTLE_ENDIAN */
-	struct {
-		unsigned long low;
-		unsigned long high;
-	};
-#endif /* __LITTLE_ENDIAN */
-	unsigned long long full;
-};
-
-#ifdef CONFIG_SMP
-static union tsc_reg tsc[NR_CPUS];
-
-void __ipipe_mach_get_tscinfo(struct __ipipe_tscinfo *info)
-{
-	info->type = IPIPE_TSC_TYPE_NONE;
-}
-
-#else /* !CONFIG_SMP */
-static union tsc_reg *tsc;
-
-void __ipipe_mach_get_tscinfo(struct __ipipe_tscinfo *info)
-{
-	info->type = IPIPE_TSC_TYPE_FREERUNNING;
-	info->u.fr.counter =
-		(unsigned *)
-		(IXP4XX_TIMER_BASE_PHYS + IXP4XX_OSTS_OFFSET);
-	info->u.fr.mask = 0xffffffff;
-	info->u.fr.tsc = &tsc->full;
-}
-#endif /* !CONFIG_SMP */
-
-static void ipipe_mach_update_tsc(void);
-#else /* !CONFIG_IPIPE */
-#define ipipe_mach_update_tsc() do { } while (0)
-#endif /* !CONFIG_IPIPE */
-
 /*************************************************************************
  * IXP4xx chipset I/O mapping
  *************************************************************************/
@@ -328,7 +281,7 @@ static irqreturn_t ixp4xx_timer_interrupt(int irq, void *dev_id)
 	if (!clockevent_ipipe_stolen(evt))
 		ixp4xx_timer_ack();
 
-	ipipe_mach_update_tsc();
+	__ipipe_tsc_update();
 
 	evt->event_handler(evt);
 
@@ -353,14 +306,6 @@ void __init ixp4xx_timer_init(void)
 	/* Reset time-stamp counter */
 	*IXP4XX_OSTS = 0;
 
-#ifdef CONFIG_IPIPE
-#ifndef CONFIG_SMP
-	tsc = (union tsc_reg *) __ipipe_tsc_area;
-	barrier();
-#endif /* CONFIG_SMP */
-
-	ixp4xx_timer_initialized = 1;
-#endif
 	/* Connect the interrupt handler and enable the interrupt */
 	setup_irq(IRQ_IXP4XX_TIMER1, &ixp4xx_timer_irq);
 
@@ -537,12 +482,31 @@ static cycle_t ixp4xx_clocksource_read(struct clocksource *c)
 
 unsigned long ixp4xx_timer_freq = IXP4XX_TIMER_FREQ;
 EXPORT_SYMBOL(ixp4xx_timer_freq);
+
+#ifdef CONFIG_IPIPE
+static struct __ipipe_tscinfo tsc_info = {
+	.type = IPIPE_TSC_TYPE_FREERUNNING,
+	.freq = IXP4XX_TIMER_FREQ,
+	.counter_vaddr = (unsigned long)IXP4XX_OSTS,
+	.u = {
+		{
+			.mask = 0xffffffff,
+			.counter_paddr = IXP4XX_TIMER_BASE_PHYS,
+		},
+	},
+};
+#endif /* CONFIG_IPIPE */
+
 static void __init ixp4xx_clocksource_init(void)
 {
 	init_sched_clock(&cd, ixp4xx_update_sched_clock, 32, ixp4xx_timer_freq);
 
 	clocksource_mmio_init(NULL, "OSTS", ixp4xx_timer_freq, 200, 32,
 			ixp4xx_clocksource_read);
+
+#ifdef CONFIG_IPIPE
+	__ipipe_tsc_register(&tsc_info);
+#endif
 }
 
 /*
@@ -593,6 +557,7 @@ static void ixp4xx_set_mode(enum clock_event_mode mode,
 static struct ipipe_timer ixp4xx_itimer = {
 	.irq = IRQ_IXP4XX_TIMER1,
 	.min_delay_ticks = 333, /* 5 usec with the 66.66 MHz system clock */
+	.ack = ixp4xx_timer_ack,
 };
 #endif /* CONFIG_IPIPE */
 
@@ -620,44 +585,3 @@ static void __init ixp4xx_clockevent_init(void)
 
 	clockevents_register_device(&clockevent_ixp4xx);
 }
-
-#ifdef CONFIG_IPIPE
-static void ipipe_mach_update_tsc(void)
-{
-	union tsc_reg *local_tsc;
-	unsigned long stamp, flags;
-
-	flags = hard_local_irq_save();
-	local_tsc = &tsc[ipipe_processor_id()];
-	stamp = *IXP4XX_OSTS;
-	if (unlikely(stamp < local_tsc->low))
-		/* 32 bit counter wrapped, increment high word. */
-		local_tsc->high++;
-	local_tsc->low = stamp;
-	hard_local_irq_restore(flags);
-}
-
-notrace unsigned long long __ipipe_mach_get_tsc(void)
-{
-	if (likely(ixp4xx_timer_initialized)) {
-		union tsc_reg *local_tsc, result;
-		unsigned long stamp;
-
-		local_tsc = &tsc[ipipe_processor_id()];
-
-		__asm__ ("ldmia %1, %M0\n":
-			 "=r"(result.full): "r"(local_tsc), "m"(*local_tsc));
-		barrier();
-		stamp = *IXP4XX_OSTS;
-		if (unlikely(stamp < result.low))
-			/* 32 bit counter wrapped, increment high word. */
-			result.high++;
-		result.low = stamp;
-		return result.full;
-	}
-
-	return 0;
-}
-
-EXPORT_SYMBOL(__ipipe_mach_get_tsc);
-#endif /* CONFIG_IPIPE */


-- 
                                                                Gilles.

