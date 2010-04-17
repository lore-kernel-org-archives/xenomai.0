Message-ID: <4BC9F841.20009@domain.hid>
Date: Sat, 17 Apr 2010 20:04:49 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC8C44CD958B6FF41EC33A669"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [git pull v2] RTDM fixes and reworks
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Alexis Berlemont <berlemont.hauw@domain.hid>, xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC8C44CD958B6FF41EC33A669
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

The following changes since commit 113ea4d56e8b215cb56ae7673013163ea5a598=
7d:
  Gilles Chanteperdrix (1):
        switchtest: increase stack sizes

are available in the git repository at:

  git://git.xenomai.org/xenomai-jki.git for-upstream


Changes in v2:
 - compat support for rttest device names
 - documented RTDM close procedure
 - internal rework of the close procedure
 - basic RTDM unit test, so far targeting at the close rework
 - some additional small cleanup patches

Beyond that series, there is now also our full /proc rework updated in
git, see

  git://git.xenomai.org/xenomai-jki.git queues/proc

I will send a separate pull request for that one later, either on top of
this (if there are no further concerns) or against master (it should
be orthogonal).


Jan Kiszka (23):
      RTDM: Add rtdm_rt_capable() service
      RTDM: Bump API version and document changes
      Revert "rtdm: tag syscalls as conforming"
      RTDM: Deprecate open_rt, socket_rt, and close_rt
      RTIPC: Fix memory leak on failing socket creation
      RTIPC: Drop support for RT socket creation/deletion
      RTCAN: Drop support for socket creation/deletion in real-time
      16550A: Drop support for device opening/closing in real-time
      Analogy: Drop support for opening/closing in real-time
      RTDM: Instrument rtdm_context_lock/unlock to detect misuses
      RTDM: Add rtdm_context_put()
      Fix historic msleep wrapping
      irqbench: Fix x86-64 build
      irqbench: Refactor user space helpers
      irqbench: Auto-detect bases of port address and IRQ values
      rttest: Resolved test device conflicts via separate name spaces
      testing: Clean up Kconfig rules
      RTIPC: Drop unused wrapper around close_lock_count
      RTDM: Document device close procedure
      Add list_first_entry wrapper for older kernels
      Add legacy kernel support for delayed_work
      RTDM: Early fd release with poll-free context reference tracking
      RTDM: Add basic unit test

Wolfgang Mauerer (1):
      RTDM: Fix potential NULL pointer dereference

 configure.in                          |    2 +-
 include/asm-generic/wrappers.h        |   10 +-
 include/compat/linux/workqueue.h      |   13 +
 include/rtdm/rtdm.h                   |    4 +-
 include/rtdm/rtdm_driver.h            |   50 +++-
 include/rtdm/rttesting.h              |   19 ++-
 ksrc/drivers/analogy/rtdm_interface.c |    2 -
 ksrc/drivers/can/rtcan_raw.c          |    2 -
 ksrc/drivers/ipc/internal.h           |    5 -
 ksrc/drivers/ipc/rtipc.c              |   13 +-
 ksrc/drivers/serial/16550A.c          |   51 +---
 ksrc/drivers/testing/Config.in        |    6 +-
 ksrc/drivers/testing/Kconfig          |   27 ++-
 ksrc/drivers/testing/Makefile         |   12 +-
 ksrc/drivers/testing/irqbench.c       |    9 +-
 ksrc/drivers/testing/klat.c           |    8 +-
 ksrc/drivers/testing/rtdmtest.c       |  151 +++++++++++
 ksrc/drivers/testing/switchtest.c     |    7 +-
 ksrc/drivers/testing/timerbench.c     |    7 +-
 ksrc/skins/rtdm/API.CHANGES           |    9 +
 ksrc/skins/rtdm/core.c                |  207 ++++++++++----
 ksrc/skins/rtdm/device.c              |   58 ++++-
 ksrc/skins/rtdm/drvlib.c              |   25 ++
 ksrc/skins/rtdm/internal.h            |    8 +-
 ksrc/skins/rtdm/syscall.c             |   10 +-
 src/testsuite/irqbench/Makefile.am    |    2 +-
 src/testsuite/irqbench/irqbench.c     |  480 ++++++++++++++++-----------=
------
 src/testsuite/irqbench/irqloop.c      |  312 +++++++++++----------
 src/testsuite/latency/latency.c       |   12 +-
 src/testsuite/switchtest/switchtest.c |   13 +-
 src/testsuite/unit/Makefile.am        |   17 ++-
 src/testsuite/unit/rtdm.c             |  105 +++++++
 32 files changed, 1106 insertions(+), 550 deletions(-)
 create mode 100644 ksrc/drivers/testing/rtdmtest.c
 create mode 100644 src/testsuite/unit/rtdm.c


--------------enigC8C44CD958B6FF41EC33A669
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkvJ+EkACgkQitSsb3rl5xT8NACg7vTelWDkDLJxxVdHMC6OmMWD
V7EAn00I4KE68rvoJJdcQbrLBJwK/5JK
=OLpb
-----END PGP SIGNATURE-----

--------------enigC8C44CD958B6FF41EC33A669--

