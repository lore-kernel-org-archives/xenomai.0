Message-ID: <4CA70EBF.8050206@domain.hid>
Date: Sat, 02 Oct 2010 12:51:43 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7DCB7E49B9AF42006912D745"
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] [git pull] Stable fixes for 2.6.34-x86
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7DCB7E49B9AF42006912D745
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

The following changes since commit cf404313bd1d1b46471ab9122958373847021c=
50:

  ipipe-2.6.34.5-x86-2.7-04 (2010-09-04 11:04:35 +0200)

are available in the git repository at:
  git://git.kiszka.org/ipipe-2.6 queues/2.6.34-x86

Jan Kiszka (3):
      ipipe: x86: Work around deadlock between ipipe_critical_enter and r=
wlocks
      ipipe: x86: Fix re-entrance deadlock
      ipipe: x86-64: Fix CONFIG_PREEMPT build

 arch/x86/kernel/ipipe.c |   48 +++++++++++++++++++++++++++++++++++++++++=
+++--
 1 files changed, 45 insertions(+), 3 deletions(-)


--------------enig7DCB7E49B9AF42006912D745
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAkynDsEACgkQitSsb3rl5xTY2wCfX50rlB9iNF8vY12MQ91CeJmL
Qp4AoIZ14J1S2EREBLKi+X7ETGa8Sj2O
=nUc8
-----END PGP SIGNATURE-----

--------------enig7DCB7E49B9AF42006912D745--

