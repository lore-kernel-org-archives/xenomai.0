Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Apr 2007 08:02:41 +0200
Message-ID: <899865CA54E4444DAF2E3639C04C5F4805EC70@domain.hid>
From: "Richard Cochran" <richard.cochran@domain.hid>
Subject: [Xenomai-core] [PATCH] Adeos support for IXP4xx
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: adeos-main@gna.org
Cc: xenomai@xenomai.org

This patch adds Adeos support for the Intel IXP425 processor. It may
also work on the IXP465, but I only tested it on the 425. The patch
is against a vanilla 2.6.19 kernel.

Enjoy,

Richard

********************************************************************
Richard Cochran (Mr), Software Development
OMICRON electronics GmbH, Oberes Ried 1, A-6833 Klaus / Austria
http://www.omicron.at/
********************************************************************

---

diff --git a/arch/arm/mach-ixp4xx/common.c
b/arch/arm/mach-ixp4xx/common.c
index fbe288a..794e348 100644
--- a/arch/arm/mach-ixp4xx/common.c
+++ b/arch/arm/mach-ixp4xx/common.c
@@ -39,6 +39,30 @@
 #include <asm/mach/irq.h>
 #include <asm/mach/time.h>
=20
+#ifdef CONFIG_IPIPE
+#include <linux/ipipe.h>
+
+/* We have no cascaded interrupts. */
+void __ipipe_mach_demux_irq(unsigned irq, struct pt_regs *regs) {}
+
+#ifdef CONFIG_NO_IDLE_HZ
+#error "dynamic tick timer not yet supported with IPIPE"
+#endif
+
+int __ipipe_mach_timerint =3D IRQ_IXP4XX_TIMER1;
+int __ipipe_mach_timerstolen =3D 0;
+unsigned int __ipipe_mach_ticks_per_jiffy =3D LATCH;
+
+EXPORT_SYMBOL(__ipipe_mach_timerint);
+EXPORT_SYMBOL(__ipipe_mach_timerstolen);
+EXPORT_SYMBOL(__ipipe_mach_ticks_per_jiffy);
+
+static int ixp4xx_timer_initialized;
+
+#define ONE_SHOT_ENABLE (IXP4XX_OST_ENABLE|IXP4XX_OST_ONE_SHOT)
+
+#endif /* CONFIG_IPIPE */
+
=20
/***********************************************************************
**
  * IXP4xx chipset I/O mapping
=20
************************************************************************
*/
@@ -240,6 +264,37 @@ static unsigned volatile last_jiffy_time;
=20
 #define CLOCK_TICKS_PER_USEC	((CLOCK_TICK_RATE + USEC_PER_SEC/2) /
USEC_PER_SEC)
=20
+#ifdef CONFIG_IPIPE
+
+static irqreturn_t ixp4xx_timer_interrupt(int irq, void *dev_id)
+{
+	write_seqlock(&xtime_lock);
+	if (__ipipe_mach_timerstolen) {
+		/* If some other domain has taken over the timer, then
+		 * do nothing (ipipe has acked it, and the other
+		 * domain has reprogramed it)
+		 */
+	} else {
+		/* If Linux is running under ipipe, but it still has
+		 * the control over the timer (no Xenomai for
+		 * example), then reprogram the timer (ipipe has
+		 * already acked it)
+		 */
+		*IXP4XX_OSRT1 =3D LATCH | ONE_SHOT_ENABLE;
+	}
+	/*
+	 * Catch up with the real idea of time
+	 */
+	while ((signed long)(*IXP4XX_OSTS - last_jiffy_time) >=3D LATCH) {
+		timer_tick();
+		last_jiffy_time +=3D LATCH;
+	}
+	write_sequnlock(&xtime_lock);
+	return IRQ_HANDLED;
+}
+
+#else /* !CONFIG_IPIPE */
+
 static irqreturn_t ixp4xx_timer_interrupt(int irq, void *dev_id)
 {
 	write_seqlock(&xtime_lock);
@@ -260,6 +315,8 @@ static irqreturn_t ixp4xx_timer_interrupt(int irq,
void *dev_id)
 	return IRQ_HANDLED;
 }
=20
+#endif /* !CONFIG_IPIPE */
+
 static struct irqaction ixp4xx_timer_irq =3D {
 	.name		=3D "IXP4xx Timer Tick",
 	.flags		=3D IRQF_DISABLED | IRQF_TIMER,
@@ -272,7 +329,12 @@ static void __init ixp4xx_timer_init(void)
 	*IXP4XX_OSST =3D IXP4XX_OSST_TIMER_1_PEND;
=20
 	/* Setup the Timer counter value */
+#ifdef CONFIG_IPIPE
+	ixp4xx_timer_initialized =3D 1;
+	*IXP4XX_OSRT1 =3D LATCH | ONE_SHOT_ENABLE;
+#else
 	*IXP4XX_OSRT1 =3D (LATCH & ~IXP4XX_OST_RELOAD_MASK) |
IXP4XX_OST_ENABLE;
+#endif
=20
 	/* Reset time-stamp counter */
 	*IXP4XX_OSTS =3D 0;
@@ -365,3 +427,92 @@ static int __init ixp4xx_clocksource_init(void)
 }
=20
 device_initcall(ixp4xx_clocksource_init);
+
+#ifdef CONFIG_IPIPE
+
+void __ipipe_mach_acktimer(void)
+{
+	/* Clear Pending Interrupt by writing '1' to it */
+	*IXP4XX_OSST =3D IXP4XX_OSST_TIMER_1_PEND;
+}
+
+EXPORT_SYMBOL(__ipipe_mach_acktimer);
+
+unsigned long long __ipipe_mach_get_tsc(void)
+{
+	if (likely(ixp4xx_timer_initialized)) {
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
+		local_tsc =3D &tsc[ipipe_processor_id()];
+		stamp =3D *IXP4XX_OSTS;
+		if (unlikely(stamp < local_tsc->low))
+			/* 32 bit counter wrapped, increment high word.
*/
+			local_tsc->high++;
+		local_tsc->low =3D stamp;
+		result =3D local_tsc->full;
+		local_irq_restore_hw(flags);
+
+		return result;
+	}
+=09
+        return 0;
+}
+
+EXPORT_SYMBOL(__ipipe_mach_get_tsc);
+
+/*
+ * Reprogram the timer
+ *
+ * The timer is aperiodic (most of the time) when running Xenomai, so
+ * __ipipe_mach_set_dec is called for each timer tick and programs the
+ * timer hardware for the next tick.
+ *
+ */
+void __ipipe_mach_set_dec(unsigned long delay)
+{
+	unsigned long flags;
+	if (delay > 8) {
+		local_irq_save_hw(flags);
+		*IXP4XX_OSRT1 =3D delay | ONE_SHOT_ENABLE;
+		local_irq_restore_hw(flags);
+	} else {
+		ipipe_trigger_irq(IRQ_IXP4XX_TIMER1);
+	}
+}
+
+EXPORT_SYMBOL(__ipipe_mach_set_dec);
+
+/*
+ * This returns the number of clock ticks remaining.
+ */
+unsigned long __ipipe_mach_get_dec(void)
+{
+	return(*IXP4XX_OST1); /* remaining */
+}
+
+EXPORT_SYMBOL(__ipipe_mach_get_dec);
+
+void __ipipe_mach_release_timer(void)
+{
+       __ipipe_mach_set_dec(__ipipe_mach_ticks_per_jiffy);
+}
+
+EXPORT_SYMBOL(__ipipe_mach_release_timer);
+
+#endif /* CONFIG_IPIPE */
diff --git a/include/asm-arm/arch-ixp4xx/irqs.h
b/include/asm-arm/arch-ixp4xx/irqs.h
index f24b763..04609bd 100644
--- a/include/asm-arm/arch-ixp4xx/irqs.h
+++ b/include/asm-arm/arch-ixp4xx/irqs.h
@@ -70,6 +70,10 @@
=20
 #define	XSCALE_PMU_IRQ		(IRQ_IXP4XX_XSCALE_PMU)
=20
+#ifdef CONFIG_IPIPE
+#define __ipipe_mach_irq_mux_p(irq) 0 /* We have no cascaded
interrupts. */
+#endif
+
 /*
  * IXDP425 board IRQs
  */

