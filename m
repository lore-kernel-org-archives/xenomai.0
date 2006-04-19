Message-ID: <4446B634.1060303@domain.hid>
Date: Thu, 20 Apr 2006 00:14:12 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Trap Int3
References: <200604192332.17511.tmarscha@domain.hid>
In-Reply-To: <200604192332.17511.tmarscha@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig15FDA2E6BFEF36C8B1A88044"
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
To: Tobias Marschall <tmarscha@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig15FDA2E6BFEF36C8B1A88044
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Tobias Marschall wrote:
> Hallo,=20
>=20
> I noticed that in /proc/xenomai/faults the count for TRAP 3 (Int3) is >=
0. I=20
> guess that has something to do with running a buggy application of mine=
, but=20
> I would like to know what kind of bug may cause this. I tried google, b=
ut I=20
> didn't find anything that helped me, could someone please give me a hin=
t?

Do you use a debugger? Int3 on x86 is the debugging trap, inserted by
gdb&friends to raise a breakpoint.

Jan


--------------enig15FDA2E6BFEF36C8B1A88044
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFERrY0niDOoMHTA+kRAokrAJ474s27amE+4DWJq8EWpvAxbxwqEQCfcQYz
IjMkGFUhPl5p0aaSJUT4ZaY=
=nRLO
-----END PGP SIGNATURE-----

--------------enig15FDA2E6BFEF36C8B1A88044--

