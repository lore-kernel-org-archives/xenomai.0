Subject: Re: [Xenomai-help] Adeos/Xenomai Arm Port
From: =?ISO-8859-1?Q?Schl=E4gl?= "Manfred jun." <manfred.schlaegl@domain.hid>
In-Reply-To: <453A4E5C.3020606@domain.hid>
References: <1161099585.5024.48.camel@domain.hid>
	<1161157955.5093.3.camel@domain.hid>  <4536038A.4000002@domain.hid>
	<1161174276.5093.22.camel@domain.hid>
	<1161442569.5007.25.camel@domain.hid> <453A4E5C.3020606@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-vDnuGRds9ZpN1eIpL5kW"
Date: Wed, 25 Oct 2006 10:03:08 +0200
Message-Id: <1161763388.5114.4.camel@domain.hid>
Mime-Version: 1.0
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>


--=-vDnuGRds9ZpN1eIpL5kW
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> Damn it. What alignment of the compiler is behind this? Fill up to
> multiples of X bytes, ok. But how to find out what X is on some
> platform? Anyone any hint on this?
>=20
> Thanks for tracking down.
>=20
> Jan
>=20

I've found it:

The Kernel is compiled with -mabi=3Dapcs-gnu

With this flag
typedef struct test1 {
    int                     mode;
    unsigned long long      period;
    int                     priority;
    int                     warmup_loops;
    int                     histogram_size;
    int                     histogram_bucketsize;
    int                     freeze_max;
} test1_t;
With flag 	-> size =3D 32
Without flag 	-> size =3D 40

I'll try to find a solution.

	- Manfred

--=-vDnuGRds9ZpN1eIpL5kW
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBFPxo7bMvu5jIEpfsRAjK6AJ44jg1ckZ7McZIoIco9ctsKUnjPkACdG1QD
U6CVt5VGNQ9oaEQX/lmRaVQ=
=GdUH
-----END PGP SIGNATURE-----

--=-vDnuGRds9ZpN1eIpL5kW--


