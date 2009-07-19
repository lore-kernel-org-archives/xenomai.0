Message-ID: <4A62D28E.1020401@domain.hid>
Date: Sun, 19 Jul 2009 10:00:14 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig99EBFDEDEBE9336F6EBBBB5B"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [Pull Request] Pending x86 syscall and native doc
	fixes
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig99EBFDEDEBE9336F6EBBBB5B
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

The following changes since commit 72a8fb179e1ce090f38795f907e5dbe6d19b68=
7c:
  Philippe Gerum (1):
        Merge commit 'jan'

are available in the git repository at:

  git://git.xenomai.org/xenomai-jki.git for-upstream

Jan Kiszka (3):
      native: Align documentation to code
      x86-64: Work around gcc issues with populating syscall registers
      x86: Merge syscall_{32|64}.h into syscall.h

 include/asm-x86/Makefile.am  |    2 -
 include/asm-x86/syscall.h    |  318 ++++++++++++++++++++++++++++++++++++=
+++++-
 include/asm-x86/syscall_32.h |  226 ------------------------------
 include/asm-x86/syscall_64.h |  173 -----------------------
 ksrc/skins/native/task.c     |   12 +-
 5 files changed, 322 insertions(+), 409 deletions(-)
 delete mode 100644 include/asm-x86/syscall_32.h
 delete mode 100644 include/asm-x86/syscall_64.h


--------------enig99EBFDEDEBE9336F6EBBBB5B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkpi0pkACgkQniDOoMHTA+nnsACgg2Ki/eRcpcTtdrkQ4lxXa1wB
mcEAn3tMzmFjrlqjdGNPWhhSQkkTzESf
=9keA
-----END PGP SIGNATURE-----

--------------enig99EBFDEDEBE9336F6EBBBB5B--

