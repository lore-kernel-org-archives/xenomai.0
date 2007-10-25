Message-ID: <47204948.7050109@domain.hid>
Date: Thu, 25 Oct 2007 09:44:08 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <e4ef24880710241635p102f5f44i3f5e5e88bc0e4b02@domain.hid>	
	<472043C1.1040506@domain.hid>
	<e4ef24880710250033x31c7ba0y8f28ddc6f30d2635@domain.hid>
In-Reply-To: <e4ef24880710250033x31c7ba0y8f28ddc6f30d2635@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig798F353644D931B7FBD2638D"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Problems building Xenomai 2.4-rc4 and linux
	2.6.23
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Robert Gubler <rgubler@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig798F353644D931B7FBD2638D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Robert Gubler wrote:
> Well, sadly I don't have it with me.  I can post it tomorrow, But,
> essentially the config is whatever the default is.  I didn't change any=

> options when I ran `make menuconfig`.

OK, will retry your steps later, maybe it also triggers for me.

>=20
> The other configurations I tried were:
>=20
> linux-2.6.23.1.tar.bz2
> xenomai-2.4-rc4.tar.bz2
> adeos-ipipe-2.6.23-i386-1.10-10.patch
>=20
>=20
> And,
>=20
> linux-2.6.23.1.tar.bz2
> xenomai-2.3.4.tar.bz2
> adeos-ipipe-2.6.23-i386-1.10-10.patch

This combination will not work "by design" (2.3.x only supports kernels
up to 2.6.20).

Jan


--------------enig798F353644D931B7FBD2638D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHIElIniDOoMHTA+kRApujAJ9GsoF+ef2LuoMSy3R71E2Ep7AX0ACffmdy
ZuMQs9CtgE51OEy/jkt8YMg=
=a4yn
-----END PGP SIGNATURE-----

--------------enig798F353644D931B7FBD2638D--

