Subject: RE: [Adeos-main] Re: Re: Porting to Intel IXP425
From: =?ISO-8859-1?Q?Schl=E4gl?= "Manfred jun." <manfred.schlaegl@domain.hid>
In-Reply-To: <899865CA54E4444DAF2E3639C04C5F4805EC65@domain.hid>
References: <899865CA54E4444DAF2E3639C04C5F4805EC65@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-zVTP+BlR4iIzF9HopD9r"
Date: Mon, 02 Apr 2007 14:01:44 +0200
Message-Id: <1175515305.5342.29.camel@domain.hid>
Mime-Version: 1.0
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org


--=-zVTP+BlR4iIzF9HopD9r
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Montag, den 02.04.2007, 13:34 +0200 schrieb Richard Cochran:
> > Then you have to implement it like I described.=20
> >=20
> > Take a look at the implementation for integrator-platforms.
> > (Timer with wraparound)
>=20
> Well, as I said, the IXP425 one-shot timer mode does _not_ wrap around.
> It just stops.

> I'm not sure how (or why) to account for the clock ticks that transpire
> during the interrupt handler.
>=20
> There are no clock ticks lost in __ipipe_mach_get_tsc, since this gets th=
e
> value of a free-flowing timer.
>=20
> Previously you wrote,
>=20
> > These lost-ticks should be added to the global time-stamp (returned by
> > get_tsc) and should mentioned at the linux-gettimeoffset-function also.
>=20
> Can you be more specific? What is the "linux-gettimeoffset-function" of
> which you speak?

Linux gettimeoffset calls a march-specific function
(ixp4xx_gettimeoffset) which delivers the time in us since the last
timer-tick (timer-interrupt).

> > Lost-ticks could sum up to a bothering time-error.
>=20
> But in the plain-old Linux code, no such adjustment is made (using a
> periodic timer, see below).

In this implementation a time-stamp register is used. Excuse me, I
misunderstood your mail before...
Forget what i said. It's quite simpler to use such a timer for adeos.=20
Gilles Chanteperdrix is right.

>=20
> Does the Linux IXP4xx timer code have a bug?
>=20
> Richard
>=20
>=20
> linux-2.6.19/arch/arm/mach-ixp4xx/common.c, from line 223:
>=20
> /************************************************************************=
*
>  * IXP4xx timer tick
>  * We use OS timer1 on the CPU for the timer tick and the timestamp=20
>  * counter as a source of real clock ticks to account for missed jiffies.
>  ************************************************************************=
*/
>=20
> static unsigned volatile last_jiffy_time;
>=20
> #define CLOCK_TICKS_PER_USEC	((CLOCK_TICK_RATE + USEC_PER_SEC/2) / USEC_P=
ER_SEC)
>=20
> static irqreturn_t ixp4xx_timer_interrupt(int irq, void *dev_id)
> {
> 	write_seqlock(&xtime_lock);
>=20
> 	/* Clear Pending Interrupt by writing '1' to it */
> 	*IXP4XX_OSST =3D IXP4XX_OSST_TIMER_1_PEND;
>=20
> 	/*
> 	 * Catch up with the real idea of time
> 	 */
> 	while ((signed long)(*IXP4XX_OSTS - last_jiffy_time) >=3D LATCH) {
> 		timer_tick();
> 		last_jiffy_time +=3D LATCH;
> 	}
>=20
> 	write_sequnlock(&xtime_lock);
>=20
> 	return IRQ_HANDLED;
> }
>=20
> static struct irqaction ixp4xx_timer_irq =3D {
> 	.name		=3D "IXP4xx Timer Tick",
> 	.flags		=3D IRQF_DISABLED | IRQF_TIMER,
> 	.handler	=3D ixp4xx_timer_interrupt,
> };
>=20
> static void __init ixp4xx_timer_init(void)
> {
> 	/* Clear Pending Interrupt by writing '1' to it */
> 	*IXP4XX_OSST =3D IXP4XX_OSST_TIMER_1_PEND;
>=20
> 	/* Setup the Timer counter value */
> 	*IXP4XX_OSRT1 =3D (LATCH & ~IXP4XX_OST_RELOAD_MASK) | IXP4XX_OST_ENABLE;
>=20
> 	/* Reset time-stamp counter */
> 	*IXP4XX_OSTS =3D 0;
> 	last_jiffy_time =3D 0;
>=20
> 	/* Connect the interrupt handler and enable the interrupt */
> 	setup_irq(IRQ_IXP4XX_TIMER1, &ixp4xx_timer_irq);
> }
>=20
> >=20
> >=20
> > - Manfred Schlaegl
> >=20

- Manfred Schlaegl

--=-zVTP+BlR4iIzF9HopD9r
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBGEPCobMvu5jIEpfsRAv6dAJ9yMRhtbpYqnP0U3gTA31krfYh+bACfTxxF
ExgSm3c4YFbXj0oh6uvYSZU=
=0gbU
-----END PGP SIGNATURE-----

--=-zVTP+BlR4iIzF9HopD9r--


