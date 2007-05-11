Message-ID: <46446EC2.3080005@domain.hid>
Date: Fri, 11 May 2007 15:25:22 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <RYexwPRg.1178892718.6286610.dchabal@domain.hid>
In-Reply-To: <RYexwPRg.1178892718.6286610.dchabal@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig179D3563AA4E24CD05BAB0FC"
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
To: CHABAL David <david.chabal@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig179D3563AA4E24CD05BAB0FC
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

CHABAL David wrote:
>>> In additional:
>>> 1. You should use 921600 value instead of 912.600.
>=20
> The "." was here for reading facility only, I consider it as an integer=

> in my computations.

The point was not the point, but the flipped digits.

>=20
>> (921600 + (115200 div 2)) div 115200 =3D 8
>>
>> So back to square #1: misconfiguration? David, please check with the
>> correct baud base again if you still see relevant divider variations.
>>
>=20
> moxa:  921600/115200 =3D 8 (not 7, I apologize for this mistake but we
> guess here that the baud base is always 921600 and according to the
> mxser file it can be 230400 for some cards)

(230400+57600)/115200=3D2,5 =3D> 2

230400/115200=3D2

???

>=20
> xeno: (921600+57600)/115200 =3D 8.5 rounded to 8

So we have the same results for both formulas and I don't see the need
for a patch anymore. Do you? Otherwise I would just commit the
div-by-zero fix to trunk now and keep the rest as is.

Jan


--------------enig179D3563AA4E24CD05BAB0FC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGRG7CniDOoMHTA+kRAgOuAJ9FjsKTTS/33QgzgROIM3g6q+4qZgCeJFuO
2ddEHHhjTVdFq/qXLJdvDVI=
=Q8QY
-----END PGP SIGNATURE-----

--------------enig179D3563AA4E24CD05BAB0FC--

