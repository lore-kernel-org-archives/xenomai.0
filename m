Message-ID: <4729B715.9060706@domain.hid>
Date: Thu, 01 Nov 2007 12:23:01 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <200711011114.lA1BEr0t027337@domain.hid>
In-Reply-To: <200711011114.lA1BEr0t027337@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8CB8C400F3A83F5DAB2F66BC"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] RT, nonRT communication
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Patrick <kpa_info@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8CB8C400F3A83F5DAB2F66BC
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Patrick wrote:
> I have tried to compile my QT application with --posix-cflags and
> --posix-ldflags but without success. I have a compilation error in sysc=
all.h
> :
>=20
> /usr/xenomai/include/asm/xenomai/syscall.h:235: error: expected
> primary-expression before =91.=92 Token
>=20
> I think it's because QT is C++ application so it uses g++ and not gcc. =
And
> Xenomai is not intended to be compiled with C++ compiler.

It _is_ intended and _is_ being used with C++. This doesn't exclude
regressions or arch-specific bugs in the headers though. What version,
what arch are you using? Can you post the full (related) compiler output?=


Jan


--------------enig8CB8C400F3A83F5DAB2F66BC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHKbcYniDOoMHTA+kRAmWTAJ9/FueeOOg5fJalmXVAzQcJy0Ij5wCcCNzj
IWcGlon/R7s4XAzYMyuKGjY=
=pxHE
-----END PGP SIGNATURE-----

--------------enig8CB8C400F3A83F5DAB2F66BC--

