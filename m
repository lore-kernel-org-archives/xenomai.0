From: Peter Howard <phoward@gme.net.au>
Date: Wed, 28 May 2014 00:37:59 +0000
Message-ID: <B2415EB1697ACE44AE82CBBFA957DEED48B153@EXCH01.gme.net.au>
References: <1401236892.2728.11.camel@nswph.gme.net.au>
In-Reply-To: <1401236892.2728.11.camel@nswph.gme.net.au>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] [PATCH 2/2] Add ipipe support for Ti da850 board
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

---
 arch/arm/mach-davinci/Kconfig   |  1 +
 arch/arm/mach-davinci/cp_intc.c |  1 +
 arch/arm/mach-davinci/time.c    | 46 ++++++++++++++++++++++++++++++++++++=
+++++
 drivers/gpio/gpio-davinci.c     |  7 +++++++
 4 files changed, 55 insertions(+)

diff --git a/arch/arm/mach-davinci/Kconfig b/arch/arm/mach-davinci/Kconfig=

index a075b3e..c7cb9f1 100644
--- a/arch/arm/mach-davinci/Kconfig
+++ b/arch/arm/mach-davinci/Kconfig
@@ -41,6 +41,7 @@ config ARCH_DAVINCI_DA850
 =09select ARCH_DAVINCI_DA8XX
 =09select ARCH_HAS_CPUFREQ
 =09select CP_INTC
+=09select IPIPE_ARM_KUSER_TSC if IPIPE
=20
 config ARCH_DAVINCI_DA8XX
 =09bool
diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_in=
tc.c
index 006dae8..816affe 100644
--- a/arch/arm/mach-davinci/cp_intc.c
+++ b/arch/arm/mach-davinci/cp_intc.c
@@ -17,6 +17,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
+#include <linux/ipipe.h>
=20
 #include <mach/common.h>
 #include <mach/cp_intc.h>
diff --git a/arch/arm/mach-davinci/time.c b/arch/arm/mach-davinci/time.c
index 24ad30f..51d7336 100644
--- a/arch/arm/mach-davinci/time.c
+++ b/arch/arm/mach-davinci/time.c
@@ -19,6 +19,10 @@
 #include <linux/err.h>
 #include <linux/platform_device.h>
 #include <linux/sched_clock.h>
+#ifdef CONFIG_IPIPE
+#include <linux/ipipe.h>
+#include <linux/ipipe_tickdev.h>
+#endif /* CONFIG_IPIPE */
=20
 #include <asm/mach/irq.h>
 #include <asm/mach/time.h>
@@ -94,9 +98,15 @@ struct timer_s {
 =09unsigned long opts;
 =09unsigned long flags;
 =09void __iomem *base;
+#ifdef CONFIG_IPIPE
+=09void *pbase;
+#endif /*CONFIG_IPIPE */
 =09unsigned long tim_off;
 =09unsigned long prd_off;
 =09unsigned long enamode_shift;
+#ifdef CONFIG_IPIPE
+=09int irq;
+#endif /* CONFIG_IPIPE */
 =09struct irqaction irqaction;
 };
 static struct timer_s timers[];
@@ -166,6 +176,9 @@ static irqreturn_t timer_interrupt(int irq, void *dev_=
id)
 {
 =09struct clock_event_device *evt =3D &clockevent_davinci;
=20
+#ifdef CONFIG_IPIPE
+=09__ipipe_tsc_update();
+#endif /* CONFIG_IPIPE */
 =09evt->event_handler(evt);
 =09return IRQ_HANDLED;
 }
@@ -241,6 +254,9 @@ static void __init timer_init(void)
 =09=09t->base =3D base[timer];
 =09=09if (!t->base)
 =09=09=09continue;
+#ifdef CONFIG_IPIPE
+=09=09t->pbase =3D (void *)dtip[timer].base;
+#endif /* CONFIG_IPIPE */
=20
 =09=09if (IS_TIMER_BOT(t->id)) {
 =09=09=09t->enamode_shift =3D 6;
@@ -262,6 +278,9 @@ static void __init timer_init(void)
 =09=09=09irq =3D USING_COMPARE(t) ? dtip[i].cmp_irq : irq;
 =09=09=09setup_irq(irq, &t->irqaction);
 =09=09}
+#ifdef CONFIG_IPIPE
+=09=09t->irq =3D irq;
+#endif /* CONFIG_IPIPE */
 =09}
 }
=20
@@ -329,10 +348,26 @@ static void davinci_set_mode(enum clock_event_mode m=
ode,
 =09}
 }
=20
+#ifdef CONFIG_IPIPE
+static struct ipipe_timer davinci_itimer;
+
+static struct __ipipe_tscinfo tsc_info =3D {
+=09.type =3D IPIPE_TSC_TYPE_FREERUNNING,
+=09.u =3D {
+=09=09=09{
+=09=09=09=09.mask =3D 0xffffffff,
+=09=09=09},
+=09},
+};
+#endif /* CONFIG_IPIPE */
+
 static struct clock_event_device clockevent_davinci =3D {
 =09.features       =3D CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
 =09.set_next_event=09=3D davinci_set_next_event,
 =09.set_mode=09=3D davinci_set_mode,
+#ifdef CONFIG_IPIPE
+=09.ipipe_timer=09=3D &davinci_itimer,
+#endif /* CONFIG_IPIPE */
 };
=20
=20
@@ -398,6 +433,17 @@ void __init davinci_timer_init(void)
 =09clockevent_davinci.name =3D id_to_name[timers[TID_CLOCKEVENT].id];
=20
 =09clockevent_davinci.cpumask =3D cpumask_of(0);
+#ifdef CONFIG_IPIPE
+=09tsc_info.freq =3D davinci_clock_tick_rate;
+=09tsc_info.counter_vaddr =3D (void *)(timers[TID_CLOCKSOURCE].base +
+=09=09=09timers[TID_CLOCKSOURCE].tim_off);
+=09tsc_info.u.counter_paddr =3D timers[TID_CLOCKSOURCE].pbase +
+=09=09=09timers[TID_CLOCKSOURCE].tim_off;
+=09__ipipe_tsc_register(&tsc_info);
+
+=09davinci_itimer.irq =3D timers[TID_CLOCKEVENT].irq;
+=09davinci_itimer.min_delay_ticks =3D 3;
+#endif /* CONFIG_IPIPE */
 =09clockevents_config_and_register(&clockevent_davinci,
 =09=09=09=09=09davinci_clock_tick_rate, 1, 0xfffffffe);
=20
diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
index 7629b4f..937399a 100644
--- a/drivers/gpio/gpio-davinci.c
+++ b/drivers/gpio/gpio-davinci.c
@@ -23,6 +23,7 @@
 #include <linux/platform_device.h>
 #include <linux/platform_data/gpio-davinci.h>
 #include <linux/irqchip/chained_irq.h>
+#include <linux/ipipe.h>
=20
 struct davinci_gpio_regs {
 =09u32=09dir;
@@ -338,9 +339,15 @@ gpio_irq_handler(unsigned irq, struct irq_desc *desc)=

 =09=09while (status) {
 =09=09=09bit =3D __ffs(status);
 =09=09=09status &=3D ~BIT(bit);
+#ifdef CONFIG_IPIPE
+=09=09=09ipipe_handle_demuxed_irq(
+=09=09=09=09irq_find_mapping(d->irq_domain,
+=09=09=09=09=09=09 d->chip.base + bit));
+#else
 =09=09=09generic_handle_irq(
 =09=09=09=09irq_find_mapping(d->irq_domain,
 =09=09=09=09=09=09 d->chip.base + bit));
+#endif /* CONFIG_IPIPE */
 =09=09}
 =09}
 =09chained_irq_exit(irq_desc_get_chip(desc), desc);
--=20
1.9.3

______________________________________________________________________
This email has been scanned by the Symantec Email Security.cloud service.
For more information please visit http://www.symanteccloud.com
______________________________________________________________________

