Message-ID: <43536E90.2050001@domain.hid>
Date: Mon, 17 Oct 2005 11:27:44 +0200
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig01E71A003D673613100A3B76"
Subject: [Xenomai-core] [bug-reminder] user/kernel space header deps
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig01E71A003D673613100A3B76
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Hi,

just to avoid that this issue got lost during the migration to Xenomai:

It's still not possible to compile a C++ POSIX program with CFLAGS
obtained via "xeno-config --posix-ldflags". This is due to the fact that
low-level, C++-incompatible headers get included in that case. Moreover,
the same scenarion works for native skin programs only by chance at the
moment.

On the long term, a clear separation between types, defines, function
prototypes, etc. needed for the user API on the one and for core
compilation on the other side is required.

Jan

--------------enig01E71A003D673613100A3B76
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDU26RncNeS9Q0k+IRAuqwAJwPjtC43bB3niR7/3jyF2MgK4LCHQCgsdIC
I2Fmb7Jn8q592q1FyxQ0A+Y=
=tO6m
-----END PGP SIGNATURE-----

--------------enig01E71A003D673613100A3B76--

