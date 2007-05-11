Message-ID: <46445D81.9010008@domain.hid>
Date: Fri, 11 May 2007 14:11:45 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <0pu1igVN.1178881055.0249710.dchabal@domain.hid>
	<46444745.3070902@domain.hid> <4644577F.1090703@domain.hid>
In-Reply-To: <4644577F.1090703@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig34DCB81BBE6200F2661A00BD"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] 16550A driver and Moxa card / solved
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Maksym Veremeyenko <verem@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig34DCB81BBE6200F2661A00BD
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Maksym Veremeyenko wrote:
> Jan Kiszka =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>> moxa: 912.600/115.200 =3D 8
>>> xeno: =3D 7
>>
>> Yeah, hard arguments. This really cries for a moxa tweak. (The
>> alternative would be to pass an artificially increased baud_base - but=

>> that would be _really_ ugly and we could also ask the user for the
>> divider directly...)
>=20
> As i correctly understand mxser use formula:
>       +-
>       | base/baud, baud <> 134
> div =3D |
>       | 2*base/(2*base + 1), baud =3D=3D 134
>       +-
>=20
> Jan's driver use:
>=20
> div =3D (base + baud/2)/baud
>=20
> What is actual
>=20
> div =3D base/baud + 0.5
>=20
> That seems more correct for rounding....
>=20
>=20
> In additional:
> 1. You should use 921600 value instead of 912.600.

(921600 + (115200 div 2)) div 115200 =3D 8

So back to square #1: misconfiguration? David, please check with the
correct baud base again if you still see relevant divider variations.

> 2. Interface is asynchronous and (IMHO) data could be transfered in a
> range of frequencies (BAUD +/- RANGE%)
>=20

Jan


--------------enig34DCB81BBE6200F2661A00BD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGRF2BniDOoMHTA+kRAnbKAJ9zuw2vrDyhuBF39Q5l1b9BTlkYfACfepVF
wnzECCEMVZGDUqXHOrHV4yg=
=eSv4
-----END PGP SIGNATURE-----

--------------enig34DCB81BBE6200F2661A00BD--

