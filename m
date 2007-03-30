From: =?ISO-8859-1?Q?Schl=E4gl?= "Manfred jun." <manfred.schlaegl@domain.hid>
In-Reply-To: <460D219D.5070302@domain.hid>
References: <899865CA54E4444DAF2E3639C04C5F4805EC60@domain.hid>
	<460D219D.5070302@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-nqazLp7S1JaWnWcs+AWD"
Date: Fri, 30 Mar 2007 23:29:23 +0200
Message-Id: <1175290163.5363.16.camel@domain.hid>
Mime-Version: 1.0
Subject: [Adeos-main] Re: Porting to Intel IXP425
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org


--=-nqazLp7S1JaWnWcs+AWD
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Freitag, den 30.03.2007, 16:41 +0200 schrieb Gilles Chanteperdrix:
> Richard Cochran wrote:
> >>The timer is aperiodic (most of the time) when running Xenomai, so
> >>__ipipe_mach_set_dec is called for each timer tick and programs the
> >>timer hardware for the next tick.
> >=20
> >=20
> > Okay, so does that mean that I should implement a "one-shot" timer, or
> > are we talking about resetting the periodic timer once in a while?
> >=20
> > (BTW, in one-shot mode, the IXP425 timer does not do what the Developer=
s
> > Manual, part 252480-006, says that it does!)
>=20
> Yes, the one shot mode is Xenomai default mode. The implementation of a
> periodic timer over the one-shot timer is already done by the generic
> ARM part of the Adeos patch.

It's better to use a periodic implementation in background, because then
you are able to messure the lost ticks between a timer-interrupt and
programming next timer-event.

Example with 16bit timer:
 * Periode: 27000 Ticks=20
 * Timer counts down to zero (Interrupt) & wrap around to 2^16-1=20
 * Reprogramm Timer with new Periode (lost-ticks =3D 2^16 - timerval)

These lost-ticks should be added to the global time-stamp (returned by
get_tsc) and should mentioned at the linux-gettimeoffset-function also.


Lost-ticks could sum up to a bothering time-error.

- Manfred Schlaegl


--=-nqazLp7S1JaWnWcs+AWD
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBGDYEzbMvu5jIEpfsRAq9dAJ94CP+aU6r6qgYiOB1KKW/2zxXiPwCdFyiG
LTvFbv41pn4WrrRGaCOEjsA=
=veRq
-----END PGP SIGNATURE-----

--=-nqazLp7S1JaWnWcs+AWD--


