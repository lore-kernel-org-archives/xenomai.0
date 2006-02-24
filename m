Message-ID: <43FF13BE.7080505@domain.hid>
Date: Fri, 24 Feb 2006 15:10:06 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0357BD194E044EE0C860191E"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] skin libs, libtool warnings, and -module
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>, xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0357BD194E044EE0C860191E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

I noticed you fixed the libtool warning during xenomai build - by
linking the testsuite statically... :-/ This is just a workaround and
doesn't help external users.

Isn't the reason for this warnings that "-module" in every skin
Makefile.am? At least, removing it also fixes external apps. Do we need
it? I don't think so: -module is for preparing dlopen usage, but who
will use it with skin libs?

Jan


--------------enig0357BD194E044EE0C860191E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD/xO+niDOoMHTA+kRAvkzAJ4q/SqvBv+HkFBO9rSItiiQVbUlLwCcCIon
x/0IO1uQCmKu1bt+727HzDE=
=ZfUM
-----END PGP SIGNATURE-----

--------------enig0357BD194E044EE0C860191E--

