Message-ID: <44FB46B7.60702@domain.hid>
Date: Sun, 03 Sep 2006 23:18:47 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] RTCAN bug fix
References: <44FACF17.2020806@domain.hid>
In-Reply-To: <44FACF17.2020806@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig57CDB7042BFC68787F3463DD"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig57CDB7042BFC68787F3463DD
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Wolfgang Grandegger wrote:
> Hello,
>=20
> attached is a patch changing:
>=20
>    * ksrc/drivers/can/rtcan_dev.c (rtcan_dev_register): Bug fixed
>    when maximum number of devices is exeeded.

Applied.

>=20
> BTW, a similar bug is present in RTnet as well.

Yep, fixed there as well. Thanks.

All pending CAN patches are now in SVN.

Jan


--------------enig57CDB7042BFC68787F3463DD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE+0a7niDOoMHTA+kRAjiOAJ902/waoaI3Lx5fcV/4e0PxWckh5QCeIkpB
XOk2vnV5Cj6OkgBzhkavBk0=
=BONc
-----END PGP SIGNATURE-----

--------------enig57CDB7042BFC68787F3463DD--

