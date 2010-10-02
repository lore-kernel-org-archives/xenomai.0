Message-ID: <4CA6D3A8.8070805@domain.hid>
Date: Sat, 02 Oct 2010 08:39:36 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig08BB7C7A8638F6C01AEDF47F"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [git pull] Patch queue for head
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
--------------enig08BB7C7A8638F6C01AEDF47F
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

The following changes since commit 738ffe93e9e23a78f42a6ff7fe8e952d90462a=
67:

  rtdm: sanitize openfd vfile handling (2010-09-24 09:45:40 +0200)

are available in the git repository at:
  git://git.xenomai.org/xenomai-jki.git for-upstream

Jan Kiszka (14):
      rt_print: Properly return printed length
      RTDM: Protect xnshadow_ppd_get via nklock
      RTDM: Plug race between proc_read_dev_info and device deregistratio=
n
      RTDM: Properly clean up on xnvfile setup errors
      RTDM: Extend device name space in open_fildes proc output
      Fix symbolic status ouput of root threads
      Create watchdog as non-blockable timer
      native: Improve documentation of rt_task_join and rt_task_delete
      nucleus: Fix lock imbalance in registry_proc_callback
      Export rthal_apc_pending/virq to modules
      x86: Add PCI ID of Series 5/3400 Intel chipset to SMI workaround
      x86: Add PCI ID of 631xESB/632xESB/3100 Intel chipset to SMI workar=
ound
      x86: Add PCI ID of Intel ICH9M-E chipset to SMI workaround
      x86: Add PCI ID of Intel ICH9M chipset to SMI workaround

Stefan Kisdaroczi (1):
      RTDM device profiles: Document open_rt, socket_rt and close_rt depr=
ecation

 include/asm-generic/pci_ids.h |   12 +++++++++++
 include/rtdm/rtcan.h          |    4 +-
 include/rtdm/rtserial.h       |    4 +-
 include/rtdm/rttesting.h      |    4 +-
 ksrc/arch/generic/hal.c       |    2 +
 ksrc/arch/x86/smi.c           |    4 +++
 ksrc/nucleus/registry.c       |    3 +-
 ksrc/nucleus/sched.c          |    3 +-
 ksrc/nucleus/thread.c         |    4 +++
 ksrc/skins/native/task.c      |   16 ++++++++++++-
 ksrc/skins/rtdm/core.c        |    2 +
 ksrc/skins/rtdm/proc.c        |   45 +++++++++++++++++++++++++++++++----=
-----
 src/rtdk/rt_print.c           |    1 +
 13 files changed, 84 insertions(+), 20 deletions(-)


--------------enig08BB7C7A8638F6C01AEDF47F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAkym060ACgkQitSsb3rl5xQbAACgh83fPZcmzwwnPrDElEAuoAGx
hzYAoN0Z+Se3xyjhxe/bZU48cM6fN/Fu
=Ps5D
-----END PGP SIGNATURE-----

--------------enig08BB7C7A8638F6C01AEDF47F--

