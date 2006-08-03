MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="tnkTyNrGWA"
Content-Transfer-Encoding: 7bit
Message-ID: <17618.12042.631648.702921@domain.hid>
Date: Thu, 3 Aug 2006 19:14:50 +0200
Subject: Re: [Xenomai-core] Xenomai on PXA
In-Reply-To: <1154617014.5010.29.camel@domain.hid>
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
	<1154596354.9835.28.camel@domain.hid>
	<17617.63387.138316.343123@domain.hid>
	<1154617014.5010.29.camel@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
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
Cc: xenomai@xenomai.org


--tnkTyNrGWA
Content-Type: text/plain; charset=us-ascii
Content-Description: message body and .signature
Content-Transfer-Encoding: 7bit

Philippe Gerum wrote:
 > On Thu, 2006-08-03 at 15:18 +0200, Gilles Chanteperdrix wrote:
 > > Bart Jonkers wrote:
 > >  > > Here is a new version of the ipipe-sa1100-pxa patch that unmaks
 > >  > > interrupts at the end of the demux handlers, and that attempt to fix the
 > >  > > gettimeoffset issue. I have run 20 minutes (time for OSCR to wrap) latency
 > >  > > with a test program verifying that time returned by gettimeofday is
 > >  > > never going backward.
 > >  > > 
 > >  > > The patch and the test program are attached, it would be nice if you
 > >  > > could test them.
 > >  > I have tested the patch and ran the test program.
 > >  > The test program give no problems.
 > >  > 
 > >  > The interrupt problem in Linux is also solved. But I have another one.
 > >  > I have created a small real-time kernel module which uses the native
 > >  > interface to handle an GPIO interrupt. The problem is that Xenomai
 > >  > doesn't see the interrupt. When I use GPIO0 (which doesn't use the
 > >  > chained handler) to receive the interrupt everything works as it should.
 > >  > 
 > >  > So it seems to be that xenomai have a problem with the chained handler.
 > >  > Does someone have an idea to solve this problem?
 > > 
 > > The problem is that the demux handler is a root domain handler, and
 > > directly call the cascaded interrupts root domain handlers through
 > > desc_handle_irq, whereas in order for the I-pipe to intercept the
 > > interrupt for any domain, the demux handler should be run for any
 > > domain, and invoke __ipipe_grab_irq, __ipipe_handle_irq or
 > > ipipe_trigger_irq so that the cascaded interrupts are pipelined.
 > > 
 > > So, there are two possible fixes:
 > > - either fix the I-pipe patch so that the demux handler is invoked when
 > >   the multiplexed interrupt is received for any domain, and triggers
 > >   interrupts through ipipe_trigger_irq;
 > 
 > Fixing the I-pipe is the way to go, definitely. If I understand this
 > correctly, the best way to handle the demux case is to implement an
 > I-pipe variant of the demultiplexing code currently available in
 > pxa_gpio_demux_handler(), which would be called from __ipipe_grab_irq()
 > when processing the multiplexed interrupt channel.
 > 
 > The I-pipe-specific demux code would then log the decoded IRQ by a call
 > to __ipipe_handle_irq() instead of running the root handler directly
 > (i.e. desc_handle_irq), which would in turn preserve the ability to
 > "wire" GPIO interrupts and also handle IRQ stickiness issues.
 > 
 > This would resemble what we are doing right now on the powerpc arch,
 > pulling the received IRQ number from a request to the machine-dependent
 > layer. I'd see no issue in duplicating such handling since this is a
 > rather short piece of invariant, hw-specific code which would not depend
 > on Linux internals, but rather on the I-pipe's.

Ok, here is an implementation of this idea for integrator_cp, sa1100 and
pxa as a patch that should be applied after the ipipe patch. As usual,
Bart, could you test it ?

-- 


					    Gilles Chanteperdrix.

--tnkTyNrGWA
Content-Type: text/plain
Content-Disposition: inline;
	filename="ipipe-sa1100-pxa.3.patch"
Content-Transfer-Encoding: 7bit

diff -Naurdp -x '*~' -x '*.orig' -x '*.rej' linux-2.6.16.5-tcl1-ipipe-ref/arch/arm/kernel/ipipe-root.c linux-2.6.16.5-tcl1-ipipe/arch/arm/kernel/ipipe-root.c
--- linux-2.6.16.5-tcl1-ipipe-ref/arch/arm/kernel/ipipe-root.c	2006-08-03 18:08:48.000000000 +0200
+++ linux-2.6.16.5-tcl1-ipipe/arch/arm/kernel/ipipe-root.c	2006-08-03 17:51:52.000000000 +0200
@@ -302,7 +302,10 @@ asmlinkage int __ipipe_grab_irq(int irq,
 		}
 	}
 
-	__ipipe_handle_irq(irq, regs);
+	if (__ipipe_mach_irq_mux_p(irq))
+		__ipipe_mach_demux_irq(irq, regs);
+	else
+		__ipipe_handle_irq(irq, regs);
 
 	ipipe_load_cpuid();
 
diff -Naurdp -x '*~' -x '*.orig' -x '*.rej' linux-2.6.16.5-tcl1-ipipe-ref/arch/arm/mach-integrator/integrator_cp.c linux-2.6.16.5-tcl1-ipipe/arch/arm/mach-integrator/integrator_cp.c
--- linux-2.6.16.5-tcl1-ipipe-ref/arch/arm/mach-integrator/integrator_cp.c	2006-08-03 18:08:48.000000000 +0200
+++ linux-2.6.16.5-tcl1-ipipe/arch/arm/mach-integrator/integrator_cp.c	2006-08-03 19:05:46.000000000 +0200
@@ -20,6 +20,7 @@
 #include <linux/amba/bus.h>
 #include <linux/amba/kmi.h>
 #include <linux/amba/clcd.h>
+#include <linux/ipipe.h>
 
 #include <asm/hardware.h>
 #include <asm/io.h>
@@ -220,6 +221,31 @@ sic_handle_irq(unsigned int irq, struct 
 	} while (status);
 }
 
+#ifdef CONFIG_IPIPE
+void __ipipe_mach_demux_irq(unsigned irq, struct pt_regs *regs)
+{
+	unsigned long status = sic_readl(INTCP_VA_SIC_BASE + IRQ_STATUS);
+	struct irqdesc *desc_unused = irq_desc + irq;
+	unsigned irq_unused = irq;
+
+	if (status == 0) {
+		do_bad_IRQ(irq, desc_unused, regs);
+		return;
+	}
+
+	do {
+		irq = ffs(status) - 1;
+		status &= ~(1 << irq);
+
+		irq += IRQ_SIC_START;
+
+		__ipipe_handle_irq(irq, regs);
+	} while (status);
+
+	desc_unused->chip->unmask(irq_unused);
+}
+#endif /* CONFIG_IPIPE */
+
 static void __init intcp_init_irq(void)
 {
 	unsigned int i;
diff -Naurdp -x '*~' -x '*.orig' -x '*.rej' linux-2.6.16.5-tcl1-ipipe-ref/arch/arm/mach-pxa/irq.c linux-2.6.16.5-tcl1-ipipe/arch/arm/mach-pxa/irq.c
--- linux-2.6.16.5-tcl1-ipipe-ref/arch/arm/mach-pxa/irq.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.16.5-tcl1-ipipe/arch/arm/mach-pxa/irq.c	2006-08-03 19:04:52.000000000 +0200
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/ptrace.h>
+#include <linux/ipipe.h>
 
 #include <asm/hardware.h>
 #include <asm/irq.h>
@@ -214,6 +215,77 @@ static void pxa_gpio_demux_handler(unsig
 	} while (loop);
 }
 
+#ifdef CONFIG_IPIPE
+void __ipipe_mach_demux_irq(unsigned irq, struct pt_regs *regs)
+{
+	struct irqdesc *desc_unused = irq_desc + irq;
+	unsigned irq_unused = irq;
+	unsigned int mask;
+	int loop;
+
+	do {
+		loop = 0;
+
+		mask = GEDR0 & ~3;
+		if (mask) {
+			GEDR0 = mask;
+			irq = IRQ_GPIO(2);
+			mask >>= 2;
+			do {
+				if (mask & 1)
+					__ipipe_handle_irq(irq, regs);
+				irq++;
+				mask >>= 1;
+			} while (mask);
+			loop = 1;
+		}
+
+		mask = GEDR1;
+		if (mask) {
+			GEDR1 = mask;
+			irq = IRQ_GPIO(32);
+			do {
+				if (mask & 1)
+					__ipipe_handle_irq(irq, regs);
+				irq++;
+				mask >>= 1;
+			} while (mask);
+			loop = 1;
+		}
+
+		mask = GEDR2;
+		if (mask) {
+			GEDR2 = mask;
+			irq = IRQ_GPIO(64);
+			do {
+				if (mask & 1)
+					__ipipe_handle_irq(irq, regs);
+				irq++;
+				mask >>= 1;
+			} while (mask);
+			loop = 1;
+		}
+
+#if PXA_LAST_GPIO >= 96
+		mask = GEDR3;
+		if (mask) {
+			GEDR3 = mask;
+			irq = IRQ_GPIO(96);
+			do {
+				if (mask & 1)
+					__ipipe_handle_irq(irq, regs);
+				irq++;
+				mask >>= 1;
+			} while (mask);
+			loop = 1;
+		}
+#endif
+	} while (loop);
+
+	desc_unused->chip->unmask(irq_unused);
+}
+#endif /* CONFIG_IPIPE */
+
 static void pxa_ack_muxed_gpio(unsigned int irq)
 {
 	int gpio = irq - IRQ_GPIO(2) + 2;
diff -Naurdp -x '*~' -x '*.orig' -x '*.rej' linux-2.6.16.5-tcl1-ipipe-ref/arch/arm/mach-pxa/time.c linux-2.6.16.5-tcl1-ipipe/arch/arm/mach-pxa/time.c
--- linux-2.6.16.5-tcl1-ipipe-ref/arch/arm/mach-pxa/time.c	2006-05-07 15:36:35.000000000 +0200
+++ linux-2.6.16.5-tcl1-ipipe/arch/arm/mach-pxa/time.c	2006-08-02 19:17:30.000000000 +0200
@@ -19,6 +19,7 @@
 #include <linux/signal.h>
 #include <linux/errno.h>
 #include <linux/sched.h>
+#include <linux/module.h>
 
 #include <asm/system.h>
 #include <asm/hardware.h>
@@ -30,6 +31,23 @@
 #include <asm/arch/pxa-regs.h>
 
 
+#ifdef CONFIG_IPIPE
+#ifdef CONFIG_NO_IDLE_HZ
+#error "dynamic tick timer not yet supported with IPIPE"
+#endif /* CONFIG_NO_IDLE_HZ */
+int __ipipe_mach_timerint = IRQ_OST0;
+EXPORT_SYMBOL(__ipipe_mach_timerint);
+
+int __ipipe_mach_timerstolen = 0;
+EXPORT_SYMBOL(__ipipe_mach_timerstolen);
+
+unsigned int __ipipe_mach_ticks_per_jiffy = LATCH;
+EXPORT_SYMBOL(__ipipe_mach_ticks_per_jiffy);
+
+static int pxa_timer_initialized;
+static unsigned long pxa_jiffies;
+#endif /* CONFIG_IPIPE */
+
 static inline unsigned long pxa_get_rtc_time(void)
 {
 	return RCNR;
@@ -54,6 +72,9 @@ static unsigned long pxa_gettimeoffset (
 {
 	long ticks_to_match, elapsed, usec;
 
+#ifdef CONFIG_IPIPE
+	if (!__ipipe_mach_timerstolen) {
+#endif
 	/* Get ticks before next timer match */
 	ticks_to_match = OSMR0 - OSCR;
 
@@ -63,6 +84,10 @@ static unsigned long pxa_gettimeoffset (
 	/* don't get fooled by the workaround in pxa_timer_interrupt() */
 	if (elapsed <= 0)
 		return 0;
+#ifdef CONFIG_IPIPE
+	} else
+		elapsed = OSCR - pxa_jiffies * LATCH;
+#endif
 
 	/* Now convert them to usec */
 	usec = (unsigned long)(elapsed * (tick_nsec / 1000))/LATCH;
@@ -105,9 +130,27 @@ pxa_timer_interrupt(int irq, void *dev_i
 	 * affect things only when the timer IRQ has been delayed by nearly
 	 * exactly one tick period which should be a pretty rare event.
 	 */
+#ifdef CONFIG_IPIPE
+	/*
+	 * - if Linux is running natively (no ipipe), ack and reprogram the timer
+	 * - if Linux is running under ipipe, but it still has the control over
+	 *   the timer (no Xenomai for example), then reprogram the timer (ipipe
+	 *   has already acked it)
+	 * - if some other domain has taken over the timer, then do nothing
+	 *   (ipipe has acked it, and the other domain has reprogramed it)
+	 */
+	if (__ipipe_mach_timerstolen) {
+		timer_tick(regs);
+		++pxa_jiffies;
+	} else
+#endif /* CONFIG_IPIPE */
 	do {
 		timer_tick(regs);
+#ifdef CONFIG_IPIPE
+		++pxa_jiffies;
+#else /* !CONFIG_IPIPE */
 		OSSR = OSSR_M0;  /* Clear match on timer 0 */
+#endif /* !CONFIG_IPIPE */
 		next_match = (OSMR0 += LATCH);
 	} while( (signed long)(next_match - OSCR) <= 8 );
 
@@ -139,6 +182,10 @@ static void __init pxa_timer_init(void)
 	setup_irq(IRQ_OST0, &pxa_timer_irq);
 	OIER = OIER_E0;		/* enable match on timer 0 to cause interrupts */
 	OSCR = 0;		/* initialize free-running timer */
+
+#ifdef CONFIG_IPIPE
+	pxa_timer_initialized = 1;
+#endif /* CONFIG_IPIPE */
 }
 
 #ifdef CONFIG_NO_IDLE_HZ
@@ -216,3 +263,69 @@ struct sys_timer pxa_timer = {
 	.dyn_tick	= &pxa_dyn_tick,
 #endif
 };
+
+#ifdef CONFIG_IPIPE
+void __ipipe_mach_acktimer(void)
+{
+	OSSR = OSSR_M0;  /* Clear match on timer 0 */
+}
+
+unsigned long long __ipipe_mach_get_tsc(void)
+{
+	if (likely(pxa_timer_initialized)) {
+		static union {
+#ifdef __BIG_ENDIAN
+			struct {
+				unsigned long high;
+				unsigned long low;
+			};
+#else /* __LITTLE_ENDIAN */
+			struct {
+				unsigned long low;
+				unsigned long high;
+			};
+#endif /* __LITTLE_ENDIAN */
+			unsigned long long full;
+		} tsc[NR_CPUS], *local_tsc;
+		unsigned long stamp, flags;
+		unsigned long long result;
+
+		local_irq_save_hw(flags);
+		local_tsc = &tsc[ipipe_processor_id()];
+		stamp = OSCR;
+		if (unlikely(stamp < local_tsc->low))
+			/* 32 bit counter wrapped, increment high word. */
+			local_tsc->high++;
+		local_tsc->low = stamp;
+		result = local_tsc->full;
+		local_irq_restore_hw(flags);
+
+		return result;
+	}
+	
+        return 0;
+}
+EXPORT_SYMBOL(__ipipe_mach_get_tsc);
+
+/*
+ * Reprogram the timer
+ */
+
+void __ipipe_mach_set_dec(unsigned long delay)
+{
+	if (delay > 8) {
+		unsigned long flags;
+
+		local_irq_save_hw(flags);
+		OSMR0 = delay + OSCR;
+		local_irq_restore_hw(flags);
+	} else
+		ipipe_trigger_irq(IRQ_OST0);
+}
+EXPORT_SYMBOL(__ipipe_mach_set_dec);
+
+unsigned long __ipipe_mach_get_dec(void)
+{
+	return OSMR0 - OSCR;
+}
+#endif /* CONFIG_IPIPE */
diff -Naurdp -x '*~' -x '*.orig' -x '*.rej' linux-2.6.16.5-tcl1-ipipe-ref/arch/arm/mach-sa1100/irq.c linux-2.6.16.5-tcl1-ipipe/arch/arm/mach-sa1100/irq.c
--- linux-2.6.16.5-tcl1-ipipe-ref/arch/arm/mach-sa1100/irq.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.16.5-tcl1-ipipe/arch/arm/mach-sa1100/irq.c	2006-08-03 19:05:03.000000000 +0200
@@ -14,6 +14,7 @@
 #include <linux/ioport.h>
 #include <linux/ptrace.h>
 #include <linux/sysdev.h>
+#include <linux/ipipe.h>
 
 #include <asm/hardware.h>
 #include <asm/irq.h>
@@ -136,6 +137,37 @@ sa1100_high_gpio_handler(unsigned int ir
 	} while (mask);
 }
 
+#ifdef CONFIG_IPIPE
+void __ipipe_mach_demux_irq(unsigned irq, struct pt_regs *regs)
+{
+	struct irqdesc *desc_unused = irq_desc + irq;
+	unsigned irq_unused = irq;
+	unsigned int mask;
+
+	mask = GEDR & 0xfffff800;
+	do {
+		/*
+		 * clear down all currently active IRQ sources.
+		 * We will be processing them all.
+		 */
+		GEDR = mask;
+
+		irq = IRQ_GPIO11;
+		mask >>= 11;
+		do {
+			if (mask & 1)
+				__ipipe_handle_irq(irq, regs);
+			mask >>= 1;
+			irq++;
+		} while (mask);
+
+		mask = GEDR & 0xfffff800;
+	} while (mask);
+
+	desc_unused->chip->unmask(irq_unused);
+}
+#endif /* CONFIG_IPIPE */
+
 /*
  * Like GPIO0 to 10, GPIO11-27 IRQs need to be handled specially.
  * In addition, the IRQs are all collected up into one bit in the
diff -Naurdp -x '*~' -x '*.orig' -x '*.rej' linux-2.6.16.5-tcl1-ipipe-ref/arch/arm/mach-sa1100/time.c linux-2.6.16.5-tcl1-ipipe/arch/arm/mach-sa1100/time.c
--- linux-2.6.16.5-tcl1-ipipe-ref/arch/arm/mach-sa1100/time.c	2006-05-07 15:36:35.000000000 +0200
+++ linux-2.6.16.5-tcl1-ipipe/arch/arm/mach-sa1100/time.c	2006-08-02 19:09:06.000000000 +0200
@@ -13,6 +13,7 @@
 #include <linux/interrupt.h>
 #include <linux/timex.h>
 #include <linux/signal.h>
+#include <linux/module.h>
 
 #include <asm/mach/time.h>
 #include <asm/hardware.h>
@@ -20,6 +21,23 @@
 #define RTC_DEF_DIVIDER		(32768 - 1)
 #define RTC_DEF_TRIM            0
 
+#ifdef CONFIG_IPIPE
+#ifdef CONFIG_NO_IDLE_HZ
+#error "dynamic tick timer not yet supported with IPIPE"
+#endif /* CONFIG_NO_IDLE_HZ */
+int __ipipe_mach_timerint = IRQ_OST0;
+EXPORT_SYMBOL(__ipipe_mach_timerint);
+
+int __ipipe_mach_timerstolen = 0;
+EXPORT_SYMBOL(__ipipe_mach_timerstolen);
+
+unsigned int __ipipe_mach_ticks_per_jiffy = LATCH;
+EXPORT_SYMBOL(__ipipe_mach_ticks_per_jiffy);
+
+static int sa1100_timer_initialized;
+static unsigned long sa1100_jiffies;
+#endif /* CONFIG_IPIPE */
+
 static unsigned long __init sa1100_get_rtc_time(void)
 {
 	/*
@@ -58,11 +76,18 @@ static unsigned long sa1100_gettimeoffse
 {
 	unsigned long ticks_to_match, elapsed, usec;
 
+#ifdef CONFIG_IPIPE
+	if (!__ipipe_mach_timerstolen) {
+#endif
 	/* Get ticks before next timer match */
 	ticks_to_match = OSMR0 - OSCR;
 
 	/* We need elapsed ticks since last match */
 	elapsed = LATCH - ticks_to_match;
+#ifdef CONFIG_IPIPE
+	} else
+		elapsed = OSCR - sa1100_jiffies * LATCH;
+#endif
 
 	/* Now convert them to usec */
 	usec = (unsigned long)(elapsed * (tick_nsec / 1000))/LATCH;
@@ -97,9 +122,27 @@ sa1100_timer_interrupt(int irq, void *de
 	 * ensured, hence we can use do_gettimeofday() from interrupt
 	 * handlers.
 	 */
+#ifdef CONFIG_IPIPE
+	/*
+	 * - if Linux is running natively (no ipipe), ack and reprogram the timer
+	 * - if Linux is running under ipipe, but it still has the control over
+	 *   the timer (no Xenomai for example), then reprogram the timer (ipipe
+	 *   has already acked it)
+	 * - if some other domain has taken over the timer, then do nothing
+	 *   (ipipe has acked it, and the other domain has reprogramed it)
+	 */
+	if (__ipipe_mach_timerstolen) {
+		timer_tick(regs);
+		++sa1100_jiffies;
+	} else
+#endif /* CONFIG_IPIPE */
 	do {
 		timer_tick(regs);
+#ifdef CONFIG_IPIPE
+		++sa1100_jiffies;
+#else /* !CONFIG_IPIPE */
 		OSSR = OSSR_M0;  /* Clear match on timer 0 */
+#endif /* !CONFIG_IPIPE */
 		next_match = (OSMR0 += LATCH);
 	} while ((signed long)(next_match - OSCR) <= 0);
 
@@ -131,6 +174,10 @@ static void __init sa1100_timer_init(voi
 	setup_irq(IRQ_OST0, &sa1100_timer_irq);
 	OIER = OIER_E0;		/* enable match on timer 0 to cause interrupts */
 	OSCR = 0;		/* initialize free-running timer */
+
+#ifdef CONFIG_IPIPE
+	sa1100_timer_initialized = 1;
+#endif /* CONFIG_IPIPE */
 }
 
 #ifdef CONFIG_NO_IDLE_HZ
@@ -209,3 +256,66 @@ struct sys_timer sa1100_timer = {
 	.dyn_tick	= &sa1100_dyn_tick,
 #endif
 };
+
+#ifdef CONFIG_IPIPE
+void __ipipe_mach_acktimer(void)
+{
+	OSSR = OSSR_M0;  /* Clear match on timer 0 */
+}
+
+unsigned long long __ipipe_mach_get_tsc(void)
+{
+	if (likely(sa1100_timer_initialized)) {
+		static union {
+#ifdef __BIG_ENDIAN
+			struct {
+				unsigned long high;
+				unsigned long low;
+			};
+#else /* __LITTLE_ENDIAN */
+			struct {
+				unsigned long low;
+				unsigned long high;
+			};
+#endif /* __LITTLE_ENDIAN */
+			unsigned long long full;
+		} tsc[NR_CPUS], *local_tsc;
+		unsigned long stamp, flags;
+		unsigned long long result;
+
+		local_irq_save_hw(flags);
+		local_tsc = &tsc[ipipe_processor_id()];
+		stamp = OSCR;
+		if (unlikely(stamp < local_tsc->low))
+			/* 32 bit counter wrapped, increment high word. */
+			local_tsc->high++;
+		local_tsc->low = stamp;
+		result = local_tsc->full;
+		local_irq_restore_hw(flags);
+
+		return result;
+	}
+	
+        return 0;
+}
+EXPORT_SYMBOL(__ipipe_mach_get_tsc);
+
+/*
+ * Reprogram the timer
+ */
+
+void __ipipe_mach_set_dec(unsigned long delay)
+{
+	unsigned long flags;
+
+	local_irq_save_hw(flags);
+        OSMR0 = delay + OSCR;
+	local_irq_restore_hw(flags);
+}
+EXPORT_SYMBOL(__ipipe_mach_set_dec);
+
+unsigned long __ipipe_mach_get_dec(void)
+{
+	return OSMR0 - OSCR;
+}
+#endif /* CONFIG_IPIPE */
diff -Naurdp -x '*~' -x '*.orig' -x '*.rej' linux-2.6.16.5-tcl1-ipipe-ref/include/asm-arm/arch-integrator/irqs.h linux-2.6.16.5-tcl1-ipipe/include/asm-arm/arch-integrator/irqs.h
--- linux-2.6.16.5-tcl1-ipipe-ref/include/asm-arm/arch-integrator/irqs.h	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.16.5-tcl1-ipipe/include/asm-arm/arch-integrator/irqs.h	2006-08-03 18:17:55.000000000 +0200
@@ -80,3 +80,6 @@
 
 #define NR_IRQS                         47
 
+#ifdef CONFIG_IPIPE
+#define __ipipe_mach_irq_mux_p(irq) ((irq) == IRQ_CP_CPPLDINT)
+#endif /* CONFIG_IPIPE */
diff -Naurdp -x '*~' -x '*.orig' -x '*.rej' linux-2.6.16.5-tcl1-ipipe-ref/include/asm-arm/arch-pxa/irqs.h linux-2.6.16.5-tcl1-ipipe/include/asm-arm/arch-pxa/irqs.h
--- linux-2.6.16.5-tcl1-ipipe-ref/include/asm-arm/arch-pxa/irqs.h	2006-07-15 20:06:03.000000000 +0200
+++ linux-2.6.16.5-tcl1-ipipe/include/asm-arm/arch-pxa/irqs.h	2006-08-03 18:01:15.000000000 +0200
@@ -73,6 +73,10 @@
 			((i) - IRQ_GPIO(2) + 2)
 #define IRQ_TO_GPIO(i)	(((i) < IRQ_GPIO(2)) ? ((i) - IRQ_GPIO0) : IRQ_TO_GPIO_2_x(i))
 
+#ifdef CONFIG_IPIPE
+#define __ipipe_mach_irq_mux_p(irq) ((irq) == IRQ_GPIO_2_x)
+#endif /* CONFIG_IPIPE */
+
 #if defined(CONFIG_PXA25x)
 #define PXA_LAST_GPIO	80
 #elif defined(CONFIG_PXA27x)
diff -Naurdp -x '*~' -x '*.orig' -x '*.rej' linux-2.6.16.5-tcl1-ipipe-ref/include/asm-arm/arch-sa1100/irqs.h linux-2.6.16.5-tcl1-ipipe/include/asm-arm/arch-sa1100/irqs.h
--- linux-2.6.16.5-tcl1-ipipe-ref/include/asm-arm/arch-sa1100/irqs.h	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.16.5-tcl1-ipipe/include/asm-arm/arch-sa1100/irqs.h	2006-08-03 18:14:34.000000000 +0200
@@ -145,6 +145,10 @@
 #define IRQ_LOCOMO_SPI_OVRN	(IRQ_BOARD_END + 20)
 #define IRQ_LOCOMO_SPI_TEND	(IRQ_BOARD_END + 21)
 
+#ifdef CONFIG_IPIPE
+#define __ipipe_mach_irq_mux_p(irq) ((irq) == IRQ_GPIO11_27)
+#endif /* CONFIG_IPIPE */
+
 /*
  * Figure out the MAX IRQ number.
  *
diff -Naurdp -x '*~' -x '*.orig' -x '*.rej' linux-2.6.16.5-tcl1-ipipe-ref/include/asm-arm/ipipe.h linux-2.6.16.5-tcl1-ipipe/include/asm-arm/ipipe.h
--- linux-2.6.16.5-tcl1-ipipe-ref/include/asm-arm/ipipe.h	2006-08-03 18:08:48.000000000 +0200
+++ linux-2.6.16.5-tcl1-ipipe/include/asm-arm/ipipe.h	2006-08-03 17:52:02.000000000 +0200
@@ -117,6 +117,7 @@ extern void __ipipe_mach_acktimer(void);
 extern unsigned long long __ipipe_mach_get_tsc(void);
 extern void __ipipe_mach_set_dec(unsigned long);
 extern unsigned long __ipipe_mach_get_dec(void);
+extern void __ipipe_mach_demux_irq(unsigned irq, struct pt_regs *regs);
 
 #define ipipe_read_tsc(t)		do { t = __ipipe_mach_get_tsc(); } while (0)
 #define __ipipe_read_timebase()		__ipipe_mach_get_tsc()

--tnkTyNrGWA--

