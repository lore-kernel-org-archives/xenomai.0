From: Jouko Haapaluoma <jouko.haapaluoma@wapice.com>
Subject: [PATCH 8/9] tcb_clksrc: Add ipipe_timer and ipipe_tsc support
Date: Fri, 12 Jun 2020 11:53:00 +0000
Message-ID: <HE1PR03MB31159D25783A6215CC223451E5810@HE1PR03MB3115.eurprd03.prod.outlook.com>
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

Add ipipe timer and clocksource into the TCB

Signed-off-by: Jouko Haapaluoma <jouko.haapaluoma@wapice.com>
---
 drivers/clocksource/tcb_clksrc.c | 56 ++++++++++++++++++++++++++++++++++--=
----
 1 file changed, 48 insertions(+), 8 deletions(-)

diff --git a/drivers/clocksource/tcb_clksrc.c b/drivers/clocksource/tcb_clk=
src.c
index 3598889..3ade938 100644
--- a/drivers/clocksource/tcb_clksrc.c
+++ b/drivers/clocksource/tcb_clksrc.c
@@ -15,6 +15,8 @@
 #include <linux/syscore_ops.h>
 #include <soc/at91/atmel_tcb.h>
=20
+#include <linux/ipipe.h>
+#include <linux/ipipe_tickdev.h>
=20
 /*
  * We're configured to use a specific TC block, one that's not hooked
@@ -228,18 +230,25 @@ static struct tc_clkevt_device clkevt =3D {
 	},
 };
=20
+static void tcb_clkevt_ack(void)
+{
+	readl_relaxed(tcaddr + ATMEL_TC_REG(2, SR));
+}
+
+#ifdef CONFIG_IPIPE
+static struct ipipe_timer tcb_itimer =3D {
+	.ack =3D tcb_clkevt_ack,
+};
+#endif /* CONFIG_IPIPE */
+
 static irqreturn_t ch2_irq(int irq, void *handle)
 {
 	struct tc_clkevt_device	*dev =3D handle;
-	unsigned int		sr;
-
-	sr =3D readl_relaxed(dev->regs + ATMEL_TC_REG(2, SR));
-	if (sr & ATMEL_TC_CPCS) {
-		dev->clkevt.event_handler(&dev->clkevt);
-		return IRQ_HANDLED;
-	}
+	if (!clockevent_ipipe_stolen(&dev->clkevt))
+		tcb_clkevt_ack();
=20
-	return IRQ_NONE;
+	dev->clkevt.event_handler(&dev->clkevt);
+	return IRQ_HANDLED;
 }
=20
 static int __init setup_clkevents(struct atmel_tc *tc, int divisor_idx,
@@ -281,6 +290,14 @@ static int __init setup_clkevents(struct atmel_tc *tc,=
 int divisor_idx,
 		return ret;
 	}
=20
+#ifdef CONFIG_IPIPE
+	tcb_itimer.irq =3D irq;
+	/* TCB clkevt oneshot timer always stops before reprogrammed */
+	/* no need for extra ticks */
+	tcb_itimer.min_delay_ticks =3D 1;
+	clkevt.clkevt.ipipe_timer =3D &tcb_itimer;
+#endif /* CONFIG_IPIPE */
+
 	clockevents_config_and_register(&clkevt.clkevt, clkevt.freq, 1,
 					max_delta);
=20
@@ -346,11 +363,23 @@ static const struct of_device_id atmel_tcb_of_match[]=
 =3D {
 	{ /* sentinel */ }
 };
=20
+#ifdef CONFIG_IPIPE
+static struct __ipipe_tscinfo tsc_info =3D {
+	.type =3D IPIPE_TSC_TYPE_FREERUNNING,
+	.u =3D {
+		{
+			.mask =3D 0xffffffffU,
+		},
+	},
+};
+#endif /* CONFIG_IPIPE */
+
 static int __init tcb_clksrc_init(struct device_node *node)
 {
 	struct atmel_tc tc;
 	struct clk *t0_clk;
 	const struct of_device_id *match;
+	struct resource r;
 	u64 (*tc_sched_clock)(void);
 	u32 rate, divided_rate =3D 0;
 	unsigned long clkevt_max_delta =3D 0xffff;
@@ -368,6 +397,9 @@ static int __init tcb_clksrc_init(struct device_node *n=
ode)
 	if (!tc.regs)
 		return -ENXIO;
=20
+	if (of_address_to_resource(node->parent, 0, &r))
+		return -ENXIO;
+
 	t0_clk =3D of_clk_get_by_name(node->parent, "t0_clk");
 	if (IS_ERR(t0_clk))
 		return PTR_ERR(t0_clk);
@@ -473,6 +505,14 @@ static int __init tcb_clksrc_init(struct device_node *=
node)
=20
 	sched_clock_register(tc_sched_clock, 32, divided_rate);
=20
+#ifdef CONFIG_IPIPE
+	tsc_info.counter_vaddr =3D
+		(unsigned long)(tcaddr + ATMEL_TC_REG(0, CV));
+	tsc_info.u.counter_paddr =3D (r.start + ATMEL_TC_REG(0, CV));
+	tsc_info.freq =3D divided_rate;
+	__ipipe_tsc_register(&tsc_info);
+#endif
+
 	return 0;
=20
 err_unregister_clksrc:
--=20
2.2.2


