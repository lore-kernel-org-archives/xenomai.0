Message-ID: <4CA6D3C0.4010900@domain.hid>
Date: Sat, 02 Oct 2010 08:40:00 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig71E400C5B9E8736A03FB58AC"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [git pull] Patch queue for 2.5.x
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig71E400C5B9E8736A03FB58AC
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

The following changes since commit 5e7cfa5c25672e4478a721eadbd6f6c5b4f88a=
2f:

  nucleus/sched: fix rescheduling bit test macros (2010-09-30 02:34:27 +0=
200)

are available in the git repository at:
  git://git.xenomai.org/xenomai-jki.git for-2.5.x

Jan Kiszka (8):
      RTDM: Protect xnshadow_ppd_get via nklock
      Fix symbolic status ouput of root threads
      Create watchdog as non-blockable timer
      native: Improve documentation of rt_task_join and rt_task_delete
      x86: Add PCI ID of Series 5/3400 Intel chipset to SMI workaround
      x86: Add PCI ID of 631xESB/632xESB/3100 Intel chipset to SMI workar=
ound
      x86: Add PCI ID of Intel ICH9M-E chipset to SMI workaround
      x86: Add PCI ID of Intel ICH9M chipset to SMI workaround

Stefan Kisdaroczi (1):
      RTDM device profiles: Document open_rt, socket_rt and close_rt depr=
ecation

 include/asm-generic/pci_ids.h |   12 ++++++++++++
 include/rtdm/rtcan.h          |    4 ++--
 include/rtdm/rtserial.h       |    4 ++--
 include/rtdm/rttesting.h      |    4 ++--
 ksrc/arch/x86/smi.c           |    4 ++++
 ksrc/nucleus/sched.c          |    3 ++-
 ksrc/nucleus/thread.c         |    4 ++++
 ksrc/skins/native/task.c      |   16 ++++++++++++++--
 ksrc/skins/rtdm/core.c        |    2 ++
 9 files changed, 44 insertions(+), 9 deletions(-)


--------------enig71E400C5B9E8736A03FB58AC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAkym08AACgkQitSsb3rl5xSD5QCggohICTfCyj11BSiC3kACP0vJ
5agAoLOHa7dtegQLt/CUfWYjm7SW980u
=7Q9T
-----END PGP SIGNATURE-----

--------------enig71E400C5B9E8736A03FB58AC--

