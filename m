From: Jouko Haapaluoma <jouko.haapaluoma@wapice.com>
Subject: [PATCH 6/9] clocksource: TCLIB: Allow higher clock rates for clock
Date: Fri, 12 Jun 2020 11:50:21 +0000
Message-ID: <HE1PR03MB31159E2426C4C1F227A9B6F2E5810@HE1PR03MB3115.eurprd03.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

From: Benedikt Spranger <b.spranger@linutronix.de>

As default the TCLIB uses the 32KiHz base clock rate for clock events.
Add a compile time selection to allow higher clock resolution.

(fixed up by Sami Pietik=E4inen <Sami.Pietikainen@wapice.com>)
(merged to ipipe-arm by Jouko Haapaluoma <jouko.haapaluoma@wapice.com>)

Signed-off-by: Benedikt Spranger <b.spranger@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Jouko Haapaluoma <jouko.haapaluoma@wapice.com>
---
 drivers/clocksource/tcb_clksrc.c | 40 +++++++++++++++++++++++-------------=
----
 drivers/misc/Kconfig             | 11 +++++++++--
 2 files changed, 32 insertions(+), 19 deletions(-)

diff --git a/drivers/clocksource/tcb_clksrc.c b/drivers/clocksource/tcb_clk=
src.c
index 9de8c10..32f840c 100644
--- a/drivers/clocksource/tcb_clksrc.c
+++ b/drivers/clocksource/tcb_clksrc.c
@@ -27,8 +27,7 @@
  *     this 32 bit free-running counter. the second channel is not used.
  *
  *   - The third channel may be used to provide a 16-bit clockevent
- *     source, used in either periodic or oneshot mode.  This runs
- *     at 32 KiHZ, and can handle delays of up to two seconds.
+ *     source, used in either periodic or oneshot mode.
  *
  * REVISIT behavior during system suspend states... we should disable
  * all clocks and save the power.  Easily done for clockevent devices,
@@ -125,12 +124,15 @@ static u64 notrace tc_sched_clock_read32(void)
 	return tc_get_cycles32(&clksrc);
 }
=20
+static const u8 atmel_tcb_divisors[5] =3D { 2, 8, 32, 128, 0, };
+
 #ifdef CONFIG_GENERIC_CLOCKEVENTS
=20
 struct tc_clkevt_device {
 	struct clock_event_device	clkevt;
 	struct clk			*clk;
 	void __iomem			*regs;
+	u32				freq;
 };
=20
 static struct tc_clkevt_device *to_tc_clkevt(struct clock_event_device *cl=
kevt)
@@ -138,13 +140,6 @@ static struct tc_clkevt_device *to_tc_clkevt(struct cl=
ock_event_device *clkevt)
 	return container_of(clkevt, struct tc_clkevt_device, clkevt);
 }
=20
-/* For now, we always use the 32K clock ... this optimizes for NO_HZ,
- * because using one of the divided clocks would usually mean the
- * tick rate can never be less than several dozen Hz (vs 0.5 Hz).
- *
- * A divided clock could be good for high resolution timers, since
- * 30.5 usec resolution can seem "low".
- */
 static u32 timer_clock;
=20
 static int tc_shutdown(struct clock_event_device *d)
@@ -170,7 +165,7 @@ static int tc_set_oneshot(struct clock_event_device *d)
=20
 	clk_enable(tcd->clk);
=20
-	/* slow clock, count up to RC, then irq and stop */
+	/* count up to RC, then irq and stop */
 	writel(timer_clock | ATMEL_TC_CPCSTOP | ATMEL_TC_WAVE |
 		     ATMEL_TC_WAVESEL_UP_AUTO, regs + ATMEL_TC_REG(2, CMR));
 	writel(ATMEL_TC_CPCS, regs + ATMEL_TC_REG(2, IER));
@@ -192,10 +187,10 @@ static int tc_set_periodic(struct clock_event_device =
*d)
 	 */
 	clk_enable(tcd->clk);
=20
-	/* slow clock, count up to RC, then irq and restart */
+	/* count up to RC, then irq and restart */
 	writel(timer_clock | ATMEL_TC_WAVE | ATMEL_TC_WAVESEL_UP_AUTO,
 		     regs + ATMEL_TC_REG(2, CMR));
-	writel((32768 + HZ / 2) / HZ, tcaddr + ATMEL_TC_REG(2, RC));
+	writel((tcd->freq + HZ / 2) / HZ, tcaddr + ATMEL_TC_REG(2, RC));
=20
 	/* Enable clock and interrupts on RC compare */
 	writel(ATMEL_TC_CPCS, regs + ATMEL_TC_REG(2, IER));
@@ -221,7 +216,11 @@ static struct tc_clkevt_device clkevt =3D {
 		.features		=3D CLOCK_EVT_FEAT_PERIODIC |
 					  CLOCK_EVT_FEAT_ONESHOT,
 		/* Should be lower than at91rm9200's system timer */
+#ifdef CONFIG_ATMEL_TCB_CLKSRC_USE_SLOW_CLOCK
 		.rating			=3D 125,
+#else
+		.rating			=3D 200,
+#endif
 		.set_next_event		=3D tc_next_event,
 		.set_state_shutdown	=3D tc_shutdown,
 		.set_state_periodic	=3D tc_set_periodic,
@@ -243,8 +242,9 @@ static irqreturn_t ch2_irq(int irq, void *handle)
 	return IRQ_NONE;
 }
=20
-static int __init setup_clkevents(struct atmel_tc *tc, int clk32k_divisor_=
idx)
+static int __init setup_clkevents(struct atmel_tc *tc, int divisor_idx)
 {
+	unsigned divisor =3D atmel_tcb_divisors[divisor_idx];
 	int ret;
 	struct clk *t2_clk =3D tc->clk[2];
 	int irq =3D tc->irq[2];
@@ -265,7 +265,11 @@ static int __init setup_clkevents(struct atmel_tc *tc,=
 int clk32k_divisor_idx)
 	clkevt.regs =3D tc->regs;
 	clkevt.clk =3D t2_clk;
=20
-	timer_clock =3D clk32k_divisor_idx;
+	timer_clock =3D divisor_idx;
+	if (!divisor)
+		clkevt.freq =3D 32768;
+	else
+		clkevt.freq =3D clk_get_rate(t2_clk) / divisor;
=20
 	clkevt.clkevt.cpumask =3D cpumask_of(0);
=20
@@ -276,7 +280,7 @@ static int __init setup_clkevents(struct atmel_tc *tc, =
int clk32k_divisor_idx)
 		return ret;
 	}
=20
-	clockevents_config_and_register(&clkevt.clkevt, 32768, 1, 0xffff);
+	clockevents_config_and_register(&clkevt.clkevt, clkevt.freq, 1, 0xffff);
=20
 	return ret;
 }
@@ -333,8 +337,6 @@ static void __init tcb_setup_single_chan(struct atmel_t=
c *tc, int mck_divisor_id
 	writel(ATMEL_TC_SYNC, tcaddr + ATMEL_TC_BCR);
 }
=20
-static const u8 atmel_tcb_divisors[5] =3D { 2, 8, 32, 128, 0, };
-
 static const struct of_device_id atmel_tcb_of_match[] =3D {
 	{ .compatible =3D "atmel,at91rm9200-tcb", .data =3D (void *)16, },
 	{ .compatible =3D "atmel,at91sam9x5-tcb", .data =3D (void *)32, },
@@ -452,7 +454,11 @@ static int __init tcb_clksrc_init(struct device_node *=
node)
 		goto err_disable_t1;
=20
 	/* channel 2:  periodic and oneshot timer support */
+#ifdef CONFIG_ATMEL_TCB_CLKSRC_USE_SLOW_CLOCK
 	ret =3D setup_clkevents(&tc, clk32k_divisor_idx);
+#else
+	ret =3D setup_clkevents(&tc, best_divisor_idx);
+#endif
 	if (ret)
 		goto err_unregister_clksrc;
=20
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 0b14ff3..ac7144c 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -70,8 +70,15 @@ config ATMEL_TCB_CLKSRC
 	  are combined to make a single 32-bit timer.
=20
 	  When GENERIC_CLOCKEVENTS is defined, the third timer channel
-	  may be used as a clock event device supporting oneshot mode
-	  (delays of up to two seconds) based on the 32 KiHz clock.
+	  may be used as a clock event device supporting oneshot mode.
+
+config ATMEL_TCB_CLKSRC_USE_SLOW_CLOCK
+	bool "TC Block use 32 KiHz clock"
+	depends on ATMEL_TCB_CLKSRC
+	default y
+	help
+	  Select this to use 32 KiHz base clock rate as TC block clock
+	  source for clock events.
=20
 config DUMMY_IRQ
 	tristate "Dummy IRQ handler"
--=20
2.2.2


