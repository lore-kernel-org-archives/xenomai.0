Subject: Re: [Adeos-main] Re: Re: Porting to Intel IXP425
From: =?ISO-8859-1?Q?Schl=E4gl?= "Manfred jun." <manfred.schlaegl@domain.hid>
In-Reply-To: <899865CA54E4444DAF2E3639C04C5F4805EC63@domain.hid>
References: <899865CA54E4444DAF2E3639C04C5F4805EC63@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-AUA0Cl4XQAxYvldIyOHR"
Date: Mon, 02 Apr 2007 12:56:44 +0200
Message-Id: <1175511404.5342.12.camel@domain.hid>
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


--=-AUA0Cl4XQAxYvldIyOHR
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Montag, den 02.04.2007, 08:52 +0200 schrieb Richard Cochran:
> > This is needed for machines where the hardware timer is based on a
> > decrementer. But for machines with a free-running counter and a match
> > register, reading the value of the free-running counter is
> > simpler. IXP425 is in the  "free-running counter and match register
> > category". So, its implementation should look like the one of the PXA.
>=20
> The IXP425 does not have a match register, AFAICT.
>=20
> It does have four 32-bit counters clocked at 66.66 MHz: a watch dog, a
> free-running timestamp, and two general purpose timers.
>=20
> The general purpose timers may be used either as one-shot timers
> (count down to zero and stop) or as periodic times (count down,
> automatically reload, and keep going).
>=20
> I already have xenomai running on the IXP425, but I will have to take
> a closer look at the timer code.
>=20
> Richard

Then you have to implement it like I described.=20

Take a look at the implementation for integrator-platforms.
(Timer with wraparound)


- Manfred Schlaegl

--=-AUA0Cl4XQAxYvldIyOHR
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBGEOFrbMvu5jIEpfsRAsxXAJ0Ztwz25pK5fgNMEozX7TMxpX8ZpQCbBSwk
O8SSY6Cwg17QkcAG4gfUGJE=
=kob5
-----END PGP SIGNATURE-----

--=-AUA0Cl4XQAxYvldIyOHR--


