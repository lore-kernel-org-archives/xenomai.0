Message-ID: <4618262C.50006@domain.hid>
Date: Sun, 08 Apr 2007 01:15:56 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] rt_heap return codes
References: <200704080000.12934.paul_c@domain.hid>
In-Reply-To: <200704080000.12934.paul_c@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA16F4E1D513EA9C290224BF0"
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
To: Paul <paul_c@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA16F4E1D513EA9C290224BF0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Paul wrote:
> During the course of debugging a simple xeno-native app, I notice some =
of the=20
> return codes for heap functions are at odds with the documentation.. Fo=
r=20
> example rt_heap_bind() when used with TM_NONBLOCK returns -EAGAIN where=
 as=20
> the docs would suggest -EWOULDBLOCK should be returned.

[/usr/include/asm-generic/errno.h]
#define EWOULDBLOCK     EAGAIN

>=20
> Also noted that rt_heap_delete() returns -EBUSY if another task holds a=
 valid=20
> heap descriptor - Undocumented, but well worth having as it can be used=
 to=20
> prevent the RT_HEAP memory from disappearing (either by a module unload=
ing,=20
> or user space app terminating).

Feel free to provide a patch to enhance the doc.

>=20
> Are these return codes likely to change in the forseeable future ?=20
>=20

I don't see why. And once they are documented, there are even less reason=
s.

Jan


--------------enigA16F4E1D513EA9C290224BF0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFGGCYsniDOoMHTA+kRAqnSAJoCFwu/KDxdM8d/1JlvsKpVbWEkdgCfaCKt
toncK0/IiG7pM4XwO/h7zZs=
=nDNe
-----END PGP SIGNATURE-----

--------------enigA16F4E1D513EA9C290224BF0--

