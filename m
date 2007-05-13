Message-ID: <46478F98.1040101@domain.hid>
Date: Mon, 14 May 2007 00:22:16 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig36E6C103562E30EC0F119AF3"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [BUG] pit clocksource broken under Xenomai
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>, adeos-main <adeos-main@gna.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig36E6C103562E30EC0F119AF3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

just checked on real hardware (found in qemu originally):

When Linux uses the pit clocksource AND Xenomai is attached, the system
time no longer makes progress. Observed under 2.6.20 with 1.7-03 and
newer patches, Xenomai trunk.

I guess not many people will be affected by this and I'm lacking time to
debug, so I'm just dumping the report and running away...

Jan


--------------enig36E6C103562E30EC0F119AF3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFGR4+cniDOoMHTA+kRAnxbAJ95JH5r6KP8ydKvQIRJ5peUZg3TMgCfS69N
Y1wDaOhHdqlJSfbm3IzxdcU=
=ZpBP
-----END PGP SIGNATURE-----

--------------enig36E6C103562E30EC0F119AF3--

