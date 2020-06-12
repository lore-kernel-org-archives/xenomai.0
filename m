From: Jouko Haapaluoma <jouko.haapaluoma@wapice.com>
Subject: [PATCH 3/9] clocksource/drivers/tcb_clksrc: Stop depending on
Date: Fri, 12 Jun 2020 11:47:13 +0000
Message-ID: <HE1PR03MB31155246205B7B13E0811EE7E5810@HE1PR03MB3115.eurprd03.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
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

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

atmel_tclib is probed too late in the boot process to be able to use the
TCB as the boot clocksource. This is an issue for SoCs without the PIT
(sams70, samv70 and samv71 families) as they simply currently can't boot.

Get rid of the atmel_tclib dependency and probe everything on our own using
the correct device tree binding.

This also allows getting rid of ATMEL_TCB_CLKSRC_BLOCK and makes the driver
a bit more flexible as the TCB is not hardcoded in the kernel anymore.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Jouko Haapaluoma <jouko.haapaluoma@wapice.com>
---
 drivers/clocksource/tcb_clksrc.c | 108 ++++++++++++++++++++++++-----------=
----
 drivers/misc/Kconfig             |  14 +----
 2 files changed, 70 insertions(+), 52 deletions(-)

diff --git a/drivers/clocksource/tcb_clksrc.c b/drivers/clocksource/tcb_clk=
src.c
index 138a120..bf68504 100644
--- a/drivers/clocksource/tcb_clksrc.c
+++ b/drivers/clocksource/tcb_clksrc.c
@@ -9,7 +9,8 @@
 #include <linux/err.h>
 #include <linux/ioport.h>
 #include <linux/io.h>
-#include <linux/platform_device.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
 #include <linux/syscore_ops.h>
 #include <soc/at91/atmel_tcb.h>
=20
@@ -28,13 +29,6 @@
  *     source, used in either periodic or oneshot mode.  This runs
  *     at 32 KiHZ, and can handle delays of up to two seconds.
  *
- * A boot clocksource and clockevent source are also currently needed,
- * unless the relevant platforms (ARM/AT91, AVR32/AT32) are changed so
- * this code can be used when init_timers() is called, well before most
- * devices are set up.  (Some low end AT91 parts, which can run uClinux,
- * have only the timers in one TC block... they currently don't support
- * the tclib code, because of that initialization issue.)
- *
  * REVISIT behavior during system suspend states... we should disable
  * all clocks and save the power.  Easily done for clockevent devices,
  * but clocksources won't necessarily get the needed notifications.
@@ -112,7 +106,6 @@ void tc_clksrc_resume(struct clocksource *cs)
 }
=20
 static struct clocksource clksrc =3D {
-	.name           =3D "tcb_clksrc",
 	.rating         =3D 200,
 	.read           =3D tc_get_cycles,
 	.mask           =3D CLOCKSOURCE_MASK(32),
@@ -214,7 +207,6 @@ static int tc_next_event(unsigned long delta, struct cl=
ock_event_device *d)
=20
 static struct tc_clkevt_device clkevt =3D {
 	.clkevt	=3D {
-		.name			=3D "tc_clkevt",
 		.features		=3D CLOCK_EVT_FEAT_PERIODIC |
 					  CLOCK_EVT_FEAT_ONESHOT,
 		/* Should be lower than at91rm9200's system timer */
@@ -330,39 +322,73 @@ static void __init tcb_setup_single_chan(struct atmel=
_tc *tc, int mck_divisor_id
 	writel(ATMEL_TC_SYNC, tcaddr + ATMEL_TC_BCR);
 }
=20
-static int __init tcb_clksrc_init(void)
-{
-	static char bootinfo[] __initdata
-		=3D KERN_DEBUG "%s: tc%d at %d.%03d MHz\n";
+static const u8 atmel_tcb_divisors[5] =3D { 2, 8, 32, 128, 0, };
+
+static const struct of_device_id atmel_tcb_of_match[] =3D {
+	{ .compatible =3D "atmel,at91rm9200-tcb", .data =3D (void *)16, },
+	{ .compatible =3D "atmel,at91sam9x5-tcb", .data =3D (void *)32, },
+	{ /* sentinel */ }
+};
=20
-	struct platform_device *pdev;
-	struct atmel_tc *tc;
+static int __init tcb_clksrc_init(struct device_node *node)
+{
+	struct atmel_tc tc;
 	struct clk *t0_clk;
+	const struct of_device_id *match;
 	u32 rate, divided_rate =3D 0;
 	int best_divisor_idx =3D -1;
 	int clk32k_divisor_idx =3D -1;
+	int bits;
 	int i;
 	int ret;
=20
-	tc =3D atmel_tc_alloc(CONFIG_ATMEL_TCB_CLKSRC_BLOCK);
-	if (!tc) {
-		pr_debug("can't alloc TC for clocksource\n");
-		return -ENODEV;
+	/* Protect against multiple calls */
+	if (tcaddr)
+		return 0;
+
+	tc.regs =3D of_iomap(node->parent, 0);
+	if (!tc.regs)
+		return -ENXIO;
+
+	t0_clk =3D of_clk_get_by_name(node->parent, "t0_clk");
+	if (IS_ERR(t0_clk))
+		return PTR_ERR(t0_clk);
+
+	tc.slow_clk =3D of_clk_get_by_name(node->parent, "slow_clk");
+	if (IS_ERR(tc.slow_clk))
+		return PTR_ERR(tc.slow_clk);
+
+	tc.clk[0] =3D t0_clk;
+	tc.clk[1] =3D of_clk_get_by_name(node->parent, "t1_clk");
+	if (IS_ERR(tc.clk[1]))
+		tc.clk[1] =3D t0_clk;
+	tc.clk[2] =3D of_clk_get_by_name(node->parent, "t2_clk");
+	if (IS_ERR(tc.clk[2]))
+		tc.clk[2] =3D t0_clk;
+
+	tc.irq[2] =3D of_irq_get(node->parent, 2);
+	if (tc.irq[2] <=3D 0) {
+		tc.irq[2] =3D of_irq_get(node->parent, 0);
+		if (tc.irq[2] <=3D 0)
+			return -EINVAL;
 	}
-	tcaddr =3D tc->regs;
-	pdev =3D tc->pdev;
=20
-	t0_clk =3D tc->clk[0];
+	match =3D of_match_node(atmel_tcb_of_match, node->parent);
+	bits =3D (uintptr_t)match->data;
+
+	for (i =3D 0; i < ARRAY_SIZE(tc.irq); i++)
+		writel(ATMEL_TC_ALL_IRQ, tc.regs + ATMEL_TC_REG(i, IDR));
+
 	ret =3D clk_prepare_enable(t0_clk);
 	if (ret) {
 		pr_debug("can't enable T0 clk\n");
-		goto err_free_tc;
+		return ret;
 	}
=20
 	/* How fast will we be counting?  Pick something over 5 MHz.  */
 	rate =3D (u32) clk_get_rate(t0_clk);
-	for (i =3D 0; i < 5; i++) {
-		unsigned divisor =3D atmel_tc_divisors[i];
+	for (i =3D 0; i < ARRAY_SIZE(atmel_tcb_divisors); i++) {
+		unsigned divisor =3D atmel_tcb_divisors[i];
 		unsigned tmp;
=20
 		/* remember 32 KiHz clock for later */
@@ -381,27 +407,29 @@ static int __init tcb_clksrc_init(void)
 		best_divisor_idx =3D i;
 	}
=20
-
-	printk(bootinfo, clksrc.name, CONFIG_ATMEL_TCB_CLKSRC_BLOCK,
-			divided_rate / 1000000,
+	clksrc.name =3D kbasename(node->parent->full_name);
+	clkevt.clkevt.name =3D kbasename(node->parent->full_name);
+	pr_debug("%s at %d.%03d MHz\n", clksrc.name, divided_rate / 1000000,
 			((divided_rate % 1000000) + 500) / 1000);
=20
-	if (tc->tcb_config && tc->tcb_config->counter_width =3D=3D 32) {
+	tcaddr =3D tc.regs;
+
+	if (bits =3D=3D 32) {
 		/* use apropriate function to read 32 bit counter */
 		clksrc.read =3D tc_get_cycles32;
 		/* setup ony channel 0 */
-		tcb_setup_single_chan(tc, best_divisor_idx);
+		tcb_setup_single_chan(&tc, best_divisor_idx);
 	} else {
-		/* tclib will give us three clocks no matter what the
+		/* we have three clocks no matter what the
 		 * underlying platform supports.
 		 */
-		ret =3D clk_prepare_enable(tc->clk[1]);
+		ret =3D clk_prepare_enable(tc.clk[1]);
 		if (ret) {
 			pr_debug("can't enable T1 clk\n");
 			goto err_disable_t0;
 		}
 		/* setup both channel 0 & 1 */
-		tcb_setup_dual_chan(tc, best_divisor_idx);
+		tcb_setup_dual_chan(&tc, best_divisor_idx);
 	}
=20
 	/* and away we go! */
@@ -410,7 +438,7 @@ static int __init tcb_clksrc_init(void)
 		goto err_disable_t1;
=20
 	/* channel 2:  periodic and oneshot timer support */
-	ret =3D setup_clkevents(tc, clk32k_divisor_idx);
+	ret =3D setup_clkevents(&tc, clk32k_divisor_idx);
 	if (ret)
 		goto err_unregister_clksrc;
=20
@@ -420,14 +448,14 @@ static int __init tcb_clksrc_init(void)
 	clocksource_unregister(&clksrc);
=20
 err_disable_t1:
-	if (!tc->tcb_config || tc->tcb_config->counter_width !=3D 32)
-		clk_disable_unprepare(tc->clk[1]);
+	if (bits !=3D 32)
+		clk_disable_unprepare(tc.clk[1]);
=20
 err_disable_t0:
 	clk_disable_unprepare(t0_clk);
=20
-err_free_tc:
-	atmel_tc_free(tc);
+	tcaddr =3D NULL;
+
 	return ret;
 }
-arch_initcall(tcb_clksrc_init);
+TIMER_OF_DECLARE(atmel_tcb_clksrc, "atmel,tcb-timer", tcb_clksrc_init);
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 3726eac..0b14ff3 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -61,7 +61,8 @@ config ATMEL_TCLIB
=20
 config ATMEL_TCB_CLKSRC
 	bool "TC Block Clocksource"
-	depends on ATMEL_TCLIB
+	depends on ARCH_AT91
+	select TIMER_OF if OF
 	default y
 	help
 	  Select this to get a high precision clocksource based on a
@@ -72,17 +73,6 @@ config ATMEL_TCB_CLKSRC
 	  may be used as a clock event device supporting oneshot mode
 	  (delays of up to two seconds) based on the 32 KiHz clock.
=20
-config ATMEL_TCB_CLKSRC_BLOCK
-	int
-	depends on ATMEL_TCB_CLKSRC
-	default 0
-	range 0 1
-	help
-	  Some chips provide more than one TC block, so you have the
-	  choice of which one to use for the clock framework.  The other
-	  TC can be used for other purposes, such as PWM generation and
-	  interval timing.
-
 config DUMMY_IRQ
 	tristate "Dummy IRQ handler"
 	default n
--=20
2.2.2


