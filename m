From: Jouko Haapaluoma <jouko.haapaluoma@wapice.com>
Subject: [PATCH 4/9] clocksource/drivers/tcb_clksrc: Use tcb as sched_clock
Date: Fri, 12 Jun 2020 11:48:11 +0000
Message-ID: <HE1PR03MB3115978E9F6D07C03019E0EDE5810@HE1PR03MB3115.eurprd03.prod.outlook.com>
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

Now that the driver is registered early enough, use the TCB as the
sched_clock which is much more accurate than the jiffies implementation.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Jouko Haapaluoma <jouko.haapaluoma@wapice.com>
---
 drivers/clocksource/tcb_clksrc.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/clocksource/tcb_clksrc.c b/drivers/clocksource/tcb_clk=
src.c
index bf68504..9de8c10 100644
--- a/drivers/clocksource/tcb_clksrc.c
+++ b/drivers/clocksource/tcb_clksrc.c
@@ -11,6 +11,7 @@
 #include <linux/io.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
+#include <linux/sched_clock.h>
 #include <linux/syscore_ops.h>
 #include <soc/at91/atmel_tcb.h>
=20
@@ -114,6 +115,16 @@ static struct clocksource clksrc =3D {
 	.resume		=3D tc_clksrc_resume,
 };
=20
+static u64 notrace tc_sched_clock_read(void)
+{
+	return tc_get_cycles(&clksrc);
+}
+
+static u64 notrace tc_sched_clock_read32(void)
+{
+	return tc_get_cycles32(&clksrc);
+}
+
 #ifdef CONFIG_GENERIC_CLOCKEVENTS
=20
 struct tc_clkevt_device {
@@ -335,6 +346,7 @@ static int __init tcb_clksrc_init(struct device_node *n=
ode)
 	struct atmel_tc tc;
 	struct clk *t0_clk;
 	const struct of_device_id *match;
+	u64 (*tc_sched_clock)(void);
 	u32 rate, divided_rate =3D 0;
 	int best_divisor_idx =3D -1;
 	int clk32k_divisor_idx =3D -1;
@@ -419,6 +431,7 @@ static int __init tcb_clksrc_init(struct device_node *n=
ode)
 		clksrc.read =3D tc_get_cycles32;
 		/* setup ony channel 0 */
 		tcb_setup_single_chan(&tc, best_divisor_idx);
+		tc_sched_clock =3D tc_sched_clock_read32;
 	} else {
 		/* we have three clocks no matter what the
 		 * underlying platform supports.
@@ -430,6 +443,7 @@ static int __init tcb_clksrc_init(struct device_node *n=
ode)
 		}
 		/* setup both channel 0 & 1 */
 		tcb_setup_dual_chan(&tc, best_divisor_idx);
+		tc_sched_clock =3D tc_sched_clock_read;
 	}
=20
 	/* and away we go! */
@@ -442,6 +456,8 @@ static int __init tcb_clksrc_init(struct device_node *n=
ode)
 	if (ret)
 		goto err_unregister_clksrc;
=20
+	sched_clock_register(tc_sched_clock, 32, divided_rate);
+
 	return 0;
=20
 err_unregister_clksrc:
--=20
2.2.2


