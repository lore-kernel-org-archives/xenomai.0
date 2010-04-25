Message-ID: <4BD45469.5040006@domain.hid>
Date: Sun, 25 Apr 2010 16:40:41 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5C571B5C00E311EB77506A71"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [git pull] Fix bogus lock stealing case
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5C571B5C00E311EB77506A71
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

The following changes since commit fbc3b858ee728c1a6b03996e3285198caa7053=
c6:
  Gilles Chanteperdrix (1):
        debug: fix CONFIG_XENO_OPT_DEBUG_* issues

are available in the git repository at:

  git://git.xenomai.org/xenomai-jki.git for-upstream

I'm starting to believe that once our customer stops reporting weird
Xenomai behavior, we have reached the ultimate level of zero bugs. For
now this is just another "bugs--".

Jan Kiszka (2):
      mutex-torture: Add test for disallowed lock stealing
      nucleus: Fix bogus lock stealing case

 ksrc/nucleus/synch.c               |    6 ++--
 src/testsuite/unit/mutex-torture.c |   62 ++++++++++++++++++++++++++++++=
++++++
 2 files changed, 65 insertions(+), 3 deletions(-)


--------------enig5C571B5C00E311EB77506A71
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkvUVGwACgkQitSsb3rl5xTirQCgnAR+yg9N694fBooeyUIjGSI0
498AoLQeG+QIN2e72CQu/dypDuUHNcPs
=e4I8
-----END PGP SIGNATURE-----

--------------enig5C571B5C00E311EB77506A71--

