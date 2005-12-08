Message-ID: <43988C40.3070003@domain.hid>
Date: Thu, 08 Dec 2005 20:40:48 +0100
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5DC3E3FA01F723EB5E9472C7"
Subject: [Xenomai-core] anonymous rt_tasks in userspace / registry
	dependencies
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
--------------enig5DC3E3FA01F723EB5E9472C7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi again,

some questions just came up for me:

1. Is it intended that tasks created with NULL name in userspace are not
accessible even to the creator? I.e. don't they have to register
anonymously in that case like semaphores e.g. do?

2. Doesn't render switching off XENO_OPT_NATIVE_REGISTRY the native skin
unusable in userspace? If I got this correctly, all kernel objects are
resolved from the user handle via the registry. If this is true, did I
oversee some big fat warning sign somewhere...?

Jan


--------------enig5DC3E3FA01F723EB5E9472C7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFDmIxBncNeS9Q0k+IRAqfcAJwK9btiutkC2PPTc0tyiODk0gqDaACgxjPp
KG3gV4JpDHcUgz+411iRi20=
=Otzd
-----END PGP SIGNATURE-----

--------------enig5DC3E3FA01F723EB5E9472C7--

