Message-ID: <4618EF2A.1000505@domain.hid>
Date: Sun, 08 Apr 2007 15:33:30 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig553D5EEB3B34E91F580A5AE9"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-help] [RFT] Enhanced 16550A driver
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig553D5EEB3B34E91F580A5AE9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I just committed quite a few changes to the xeno_16550A driver:

 - support for controlling the break signal (RTSER_RTIOC_BREAK_CTL)
 - support for memory-mapped 16550A controllers
 - compile-time or runtime selection of hardware access method (io=3D vs.=

   mem=3D module parameters)
 - code refactoring and indentions

The result is lightly tested and shows no obvious regressions. Still,
before it becomes official via the next major release, more testers
would be welcome. As I'm lacking any hardware with a memory-mapped
controller, I would be specifically interested in hearing from someone
who does so if the new code works. Also RTSER_RTIOC_BREAK_CTL is looking
for some user to hammer on it.

Jan


--------------enig553D5EEB3B34E91F580A5AE9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFGGO8qniDOoMHTA+kRAi6bAJ9NSVh0P/Gtr7RRAbDbMdhckR5KogCeMfY9
t4KFwZwnXXGDIOEkYvxett4=
=OF08
-----END PGP SIGNATURE-----

--------------enig553D5EEB3B34E91F580A5AE9--

