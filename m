Message-ID: <4B8D9711.5090704@domain.hid>
Date: Tue, 02 Mar 2010 23:54:09 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1CA0386650398E1C8E96AA31"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [pull request] Fixes and workarounds for the cond
	issues
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "Charlton, John" <john.charlton@domain.hid>, xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1CA0386650398E1C8E96AA31
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

The following changes since commit af93ec87f975b387243127090b578d57922b38=
dc:
  Gilles Chanteperdrix (1):
        posix: fix recursive condvar implementation

are available in the git repository at:

  git://git.xenomai.org/xenomai-jki.git for-upstream

These patches pass basic testings, specifically our extended testsuite,
but I'm still unhappy with the workaround. Specifically the fact that we
lose -EINTR as valid return code for the Native side is fairly annoying.

For that reason, I will continue to work out fixed prologue/epilogue
syscalls for both skins that up-to-date user space will be able to
benefit from (native kernel space part is already done). The majority of
users will continue to update kernel and user space synchronously
anyway, for the rest we will provide these workarounds here.


Jan Kiszka (8):
      testsuite: Fix posix mutex test for non-auto-shadow setups
      testsuite: Add timed mutex and cond tests
      Native: Fix error signedness in rt_cont_wait_until
      Native: Fix return code of in-kernel rt_cond_wait[_until]
      Native: Ensure to re-acquire the mutex on cond_wait return
      Native: Work around for error code corruption in rt_cond_wait[_unti=
l]
      POSIX: Fix signess issue in EFAULT path of cond_wait_prologue
      POSIX: Work around for error code corruption in pthread_cond_[timed=
]wait

 ksrc/skins/native/cond.c           |   19 +++--
 ksrc/skins/native/syscall.c        |   30 +++++-
 ksrc/skins/posix/syscall.c         |   29 ++++--
 src/skins/native/cond.c            |    6 +-
 src/testsuite/unit/mutex-torture.c |  185 ++++++++++++++++++++++++++++++=
------
 5 files changed, 213 insertions(+), 56 deletions(-)


--------------enig1CA0386650398E1C8E96AA31
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkuNlxkACgkQitSsb3rl5xSiugCghmLi6HBVdV6EJ8EQaikCnyOp
WjMAn3Aeil+6Uc4ic9hH2M7ZtcrK4IFK
=VL4N
-----END PGP SIGNATURE-----

--------------enig1CA0386650398E1C8E96AA31--

