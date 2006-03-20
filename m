Message-ID: <441EFB6D.8000507@domain.hid>
Date: Mon, 20 Mar 2006 19:58:53 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig864B01FB8031003186271E25"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] CONFIG_XENO_OPT_DEBUG_LEVEL
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
--------------enig864B01FB8031003186271E25
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

as I started to actually use XENO_ASSERT, I noticed that there is no
infrastructure yet to enable it. CONFIG_XENO_OPT_DEBUG_LEVEL is nowhere
defined. Add this as integer to Kconfig? Or better convert
nucleus/assert.h to CONFIG_OPT_DEBUG for now until we really feel like
we need more than on/off for this? I would vote for the latter ATM.

Jan


--------------enig864B01FB8031003186271E25
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEHvttniDOoMHTA+kRAkqrAJ9gZYTY5yRslhjMtOLFHrh5HqG59wCfYHx5
Zd70KxoRQeQpvpuaq2ln6YI=
=uzmF
-----END PGP SIGNATURE-----

--------------enig864B01FB8031003186271E25--

