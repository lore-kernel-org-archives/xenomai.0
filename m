Message-ID: <4A9566C9.7000805@domain.hid>
Date: Wed, 26 Aug 2009 18:46:01 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <2f7260f50908260246jed2b885q9c67375b19343920@domain.hid>
In-Reply-To: <2f7260f50908260246jed2b885q9c67375b19343920@domain.hid>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Problem with PXA320 and xenomai 2.4.9
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?ISO-8859-1?Q?Imanol_Mart=EDnez?= <imanolmc@domain.hid>
Cc: xenomai@xenomai.org

Imanol Mart=EDnez wrote:
> Hello all,
>=20
> I have installed xenomai 2.4.9 in a linux 2.6.30 kernel. It seems that
> all the boot is done correctly but when reaching the point to access the
> nfs filesystem I get the following error:
>=20
> <4>[   32.879389] WARNING: at net/sched/sch_generic.c:226
> dev_watchdog+0x2c0/0x2e0()
> [   32.879389] WARNING: at net/sched/sch_generic.c:226
> dev_watchdog+0x2c0/0x2e0()
> <6>[   33.055929] NETDEV WATCHDOG: eth0 (): transmit timed out
> [   33.055929] NETDEV WATCHDOG: eth0 (): transmit timed out
>=20
> and after some seconds
>=20
> <7>[   39.438510] eth0: Tx timed out, lost interrupt? TSR=3D0x1, ISR=3D0x=
3,
> t=3D160.
> <7>[   49.765548] eth0: Tx timed out, lost interrupt? TSR=3D0x1, ISR=3D0x=
2,
> t=3D1025.
> <7>[   51.765562] eth0: Tx timed out, lost interrupt? TSR=3D0x1, ISR=3D0x=
2,
> t=3D124
>=20
> Any idea or help to solve this problem...

Please check that when starting from the configuration where you have
the bug, if you disable Xenomai (CONFIG_XENOMAI) and the interrupt
pipeline (CONFIG_IPIPE), the system works.

If it works, could you try the attached patch?
diff --git a/arch/arm/mach-pxa/irq.c b/arch/arm/mach-pxa/irq.c
index f6e0300..f8a25d5 100644
--- a/arch/arm/mach-pxa/irq.c
+++ b/arch/arm/mach-pxa/irq.c
@@ -111,7 +111,11 @@ static void __init pxa_init_low_gpio_irq(set_wake_t fn)

        for (irq =3D IRQ_GPIO0; irq <=3D IRQ_GPIO1; irq++) {
                set_irq_chip(irq, &pxa_low_gpio_chip);
+#ifndef CONFIG_IPIPE
                set_irq_handler(irq, handle_edge_irq);
+#else /* CONFIG_IPIPE */
+               set_irq_handler(irq, handle_level_irq);
+#endif /* CONFIG_IPIPE */
                set_irq_flags(irq, IRQF_VALID);
        }




--=20
                                          Gilles


