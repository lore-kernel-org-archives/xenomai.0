Message-ID: <44D0FF4C.9090006@domain.hid>
Date: Wed, 02 Aug 2006 21:38:52 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Re: problem with reading from rt_pipe with a normal
	linux process
References: <eaqrtk$vkb$1@domain.hid>
	<eaqsbk$vkb$2@domain.hid>	<44D0F5DE.3010508@domain.hid>
	<eaqt5i$4l0$1@domain.hid>
In-Reply-To: <eaqt5i$4l0$1@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig58EA734BDA9DF343C6970E19"
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
To: Marco Jackel <ich@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig58EA734BDA9DF343C6970E19
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Marco Jackel wrote:
> Jan Kiszka wrote:
>> Hint: read returns its error code in errno. What does that one tell yo=
u?
>=20
> read returns -1, "operation not permitted"
>=20

errno =3D=3D EPERM? A bit weird. Try strace'ing both your program and the=

cat tool to look for a difference.

Jan


--------------enig58EA734BDA9DF343C6970E19
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE0P9MniDOoMHTA+kRAsuqAJ95n54DL1MxYs3pGrZh6VY+pgyFgACfdb9f
EVGPhNPGXGCczzrTeOrCokk=
=ucAS
-----END PGP SIGNATURE-----

--------------enig58EA734BDA9DF343C6970E19--

