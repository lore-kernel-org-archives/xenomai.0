Message-ID: <4534A451.1040209@domain.hid>
Date: Tue, 17 Oct 2006 11:37:21 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Adeos/Xenomai Arm Port
References: <1161076997.5024.0.camel@domain.hid>
In-Reply-To: <1161076997.5024.0.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig035FF75B16DE8E9999E31385"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?ISO-8859-15?Q?=22Schl=E4gl_=5C=22Manfred_jun=2E=5C=22=22?= <manfred.schlaegl@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig035FF75B16DE8E9999E31385
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Schl=E4gl Manfred jun. wrote:
> Here some test-cases:
>=20
>=20
> -sh-3.00# cat /proc/xenomai/rtdm/rttest0/information=20
> driver:         xeno_timerbench
> version:        0.2.0
> peripheral:     Timer Latency Benchmark
> provider:       Jan Kiszka
> class:          6
> sub-class:      0
> flags:          NAMED_DEVICE =20
> lock count:     0

Then "-D0" is the correct device argument for latency, and that's
default anyway.

> -sh-3.00# cat /proc/xenomai/rtdm/rttest1/information=20
> driver:         xeno_irqbench
> version:        0.1.0
> peripheral:     IRQ Latency Benchmark
> provider:       Jan Kiszka
> class:          6
> sub-class:      1
> flags:          NAMED_DEVICE =20
> lock count:     0
> -sh-3.00# cat /proc/xenomai/rtdm/rttest2/information=20
> driver:         xeno_switchtest
> version:        0.1.1
> peripheral:     Context Switch Test
> provider:       Gilles Chanteperdrix
> class:          6
> sub-class:      2
> flags:          NAMED_DEVICE =20
> lock count:     0
> -sh-3.00# cat /proc/xenomai/rtdm/named_devices      =20
> Hash    Name                            /proc
> D6      rttest0                         rttest0
> D7      rttest1                         rttest1
> D8      rttest2                         rttest2
>=20
>=20
> -sh-3.00# ./latency -D0 -t 1 -T 10 -p 10000
> =3D=3D Sampling period: 10000 us
> =3D=3D Test mode: in-kernel periodic task
> =3D=3D All results in microseconds
> latency: failed to start in-kernel timer benchmark, code -25

Ok, we must have some more complicated problem here. Please follow
Philippe's suggestion to instrument the involved code (e.g. the
timerbench driver) with printk to see what is called with which arguments=
=2E

Jan


--------------enig035FF75B16DE8E9999E31385
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFNKRRniDOoMHTA+kRAuINAJwLD8/INPa2E0I0NVujdMAUVoTsiACeO89O
a39BVBauW8GBnHuJB1jvYlY=
=EHsJ
-----END PGP SIGNATURE-----

--------------enig035FF75B16DE8E9999E31385--

