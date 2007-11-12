Message-ID: <4738C3AA.5040207@domain.hid>
Date: Mon, 12 Nov 2007 22:20:42 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <200711121400.lACE0Q7w015963@domain.hid>
In-Reply-To: <200711121400.lACE0Q7w015963@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig813B711CE53E68AEB61B335F"
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
--------------enig813B711CE53E68AEB61B335F
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Patrick wrote:
> Hi,
>=20
> I have another error when I try to compile Xenomai with g++ :
>=20
> /usr/xenomai/include/native/task.h:292: error: expected =91,=92 or =91.=
=2E.=92 before
> =91protected=92

There is no "protected" text pattern in that file, not even in Xenomai
files task.h includes.

Are you sure that you do not drag in some third-party preprocessor
definition that replaces something happened to be used in Xenomai
headers? Try g++ with "-E" to check what the compiler tries to crunch
(or post a simple test case as Gilles requested).

Jan


--------------enig813B711CE53E68AEB61B335F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHOMOtniDOoMHTA+kRAtvXAJ99f3qnkZiripT321zb7OFMEjDDdACfTGYe
nxyf8Pfw7BBlHXZPzWE6PHE=
=1Cdl
-----END PGP SIGNATURE-----

--------------enig813B711CE53E68AEB61B335F--

