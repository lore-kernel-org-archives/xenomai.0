From: Jouko Haapaluoma <jouko.haapaluoma@wapice.com>
Subject: [PATCH 7/9] tcb_clksrc: Always use high resolution with 32-bit
 channels
Date: Fri, 12 Jun 2020 11:51:37 +0000
Message-ID: <HE1PR03MB31153D649639376D74D70801E5810@HE1PR03MB3115.eurprd03.prod.outlook.com>
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

From: Jouko Haapaluoma <jouko.haapaluoma@wapice.com>

When TCB channels are 32-bit, it is possible to have 32-bit max_delta
for the clock events. Then it makes no sense to use slow 32k clock at all.

Signed-off-by: Jouko Haapaluoma <jouko.haapaluoma@wapice.com>
---
 drivers/clocksource/tcb_clksrc.c | 33 +++++++++++++++++++++------------
 drivers/misc/Kconfig             |  5 +++--
 2 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/drivers/clocksource/tcb_clksrc.c b/drivers/clocksource/tcb_clk=
src.c
index 32f840c..3598889 100644
--- a/drivers/clocksource/tcb_clksrc.c
+++ b/drivers/clocksource/tcb_clksrc.c
@@ -24,9 +24,9 @@
  *     with a base rate of 5+ MHz, packaged as a clocksource (with
  *     resolution better than 200 nsec).
  *   - Some chips support 32 bit counter. A single channel is used for
- *     this 32 bit free-running counter. the second channel is not used.
+ *     this 32 bit free-running counter. The second channel is not used.
  *
- *   - The third channel may be used to provide a 16-bit clockevent
+ *   - The third channel may be used to provide a 16-bit or 32-bit clockev=
ent
  *     source, used in either periodic or oneshot mode.
  *
  * REVISIT behavior during system suspend states... we should disable
@@ -242,7 +242,8 @@ static irqreturn_t ch2_irq(int irq, void *handle)
 	return IRQ_NONE;
 }
=20
-static int __init setup_clkevents(struct atmel_tc *tc, int divisor_idx)
+static int __init setup_clkevents(struct atmel_tc *tc, int divisor_idx,
+					unsigned long max_delta)
 {
 	unsigned divisor =3D atmel_tcb_divisors[divisor_idx];
 	int ret;
@@ -280,14 +281,16 @@ static int __init setup_clkevents(struct atmel_tc *tc=
, int divisor_idx)
 		return ret;
 	}
=20
-	clockevents_config_and_register(&clkevt.clkevt, clkevt.freq, 1, 0xffff);
+	clockevents_config_and_register(&clkevt.clkevt, clkevt.freq, 1,
+					max_delta);
=20
 	return ret;
 }
=20
 #else /* !CONFIG_GENERIC_CLOCKEVENTS */
=20
-static int __init setup_clkevents(struct atmel_tc *tc, int clk32k_divisor_=
idx)
+static int __init setup_clkevents(struct atmel_tc *tc, int divisor_idx,
+					unsigned long max_delta)
 {
 	/* NOTHING */
 	return 0;
@@ -350,8 +353,9 @@ static int __init tcb_clksrc_init(struct device_node *n=
ode)
 	const struct of_device_id *match;
 	u64 (*tc_sched_clock)(void);
 	u32 rate, divided_rate =3D 0;
+	unsigned long clkevt_max_delta =3D 0xffff;
 	int best_divisor_idx =3D -1;
-	int clk32k_divisor_idx =3D -1;
+	int clkevt_divisor_idx =3D -1;
 	int bits;
 	int i;
 	int ret;
@@ -407,7 +411,7 @@ static int __init tcb_clksrc_init(struct device_node *n=
ode)
=20
 		/* remember 32 KiHz clock for later */
 		if (!divisor) {
-			clk32k_divisor_idx =3D i;
+			clkevt_divisor_idx =3D i;
 			continue;
 		}
=20
@@ -434,6 +438,10 @@ static int __init tcb_clksrc_init(struct device_node *=
node)
 		/* setup ony channel 0 */
 		tcb_setup_single_chan(&tc, best_divisor_idx);
 		tc_sched_clock =3D tc_sched_clock_read32;
+		/* use 32-bit clkevt */
+		clkevt_max_delta =3D 0xffffffff;
+		/* use only high res clkevt when 32-bit*/
+		clkevt_divisor_idx =3D best_divisor_idx;
 	} else {
 		/* we have three clocks no matter what the
 		 * underlying platform supports.
@@ -446,6 +454,11 @@ static int __init tcb_clksrc_init(struct device_node *=
node)
 		/* setup both channel 0 & 1 */
 		tcb_setup_dual_chan(&tc, best_divisor_idx);
 		tc_sched_clock =3D tc_sched_clock_read;
+
+#ifndef CONFIG_ATMEL_TCB_CLKSRC_USE_SLOW_CLOCK
+		/* use high res clkevt */
+		clkevt_divisor_idx =3D best_divisor_idx;
+#endif
 	}
=20
 	/* and away we go! */
@@ -454,11 +467,7 @@ static int __init tcb_clksrc_init(struct device_node *=
node)
 		goto err_disable_t1;
=20
 	/* channel 2:  periodic and oneshot timer support */
-#ifdef CONFIG_ATMEL_TCB_CLKSRC_USE_SLOW_CLOCK
-	ret =3D setup_clkevents(&tc, clk32k_divisor_idx);
-#else
-	ret =3D setup_clkevents(&tc, best_divisor_idx);
-#endif
+	ret =3D setup_clkevents(&tc, clkevt_divisor_idx, clkevt_max_delta);
 	if (ret)
 		goto err_unregister_clksrc;
=20
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index ac7144c..1e4ffbe 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -73,12 +73,13 @@ config ATMEL_TCB_CLKSRC
 	  may be used as a clock event device supporting oneshot mode.
=20
 config ATMEL_TCB_CLKSRC_USE_SLOW_CLOCK
-	bool "TC Block use 32 KiHz clock"
+	bool "TC Block use 32 KiHz clock when 16-bit"
 	depends on ATMEL_TCB_CLKSRC
 	default y
 	help
 	  Select this to use 32 KiHz base clock rate as TC block clock
-	  source for clock events.
+	  source for clock events when TC channels are 16-bit. With 32-bit
+	  channels high resolution is always used.
=20
 config DUMMY_IRQ
 	tristate "Dummy IRQ handler"
--=20
2.2.2


