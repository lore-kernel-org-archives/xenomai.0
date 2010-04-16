Message-ID: <4BC848F0.3090704@domain.hid>
Date: Fri, 16 Apr 2010 13:24:32 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [git pull] RTDM fixes and reworks
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

The following changes since commit 113ea4d56e8b215cb56ae7673013163ea5a5987d:
  Gilles Chanteperdrix (1):
        switchtest: increase stack sizes

are available in the git repository at:

  git://git.xenomai.org/xenomai-jki.git for-upstream


This is the first of likely three rounds of patches for 2.5.x. It mostly
deals with introducing rtdm_rt_capable to replace the
__xn_exec_conforming marks of RTDM syscalls and with deprecating RT
open/socket/close for RTDM devices. The latter affects quite a few
devices in our tree, so I'm CC'ing the maintainers to check if they see
any problems in dropping RT creation/closure at this point.

Besides some smaller fixes and an irqbench refactoring, this series also
contains a solution for the confusions about incompatible rttest<n>
devices. It simply avoids collisions be using different device names for
the different device subclasses.

Please review and merge if no concerns remain.

BTW, the other two rounds I mentioned will deal with /proc overflow
fixes and avoiding RTDM context polling on close (I still need to finish
my unit test, therefore this delay). Those should follow over the
weekend.


Jan Kiszka (16):
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

Wolfgang Mauerer (1):
      RTDM: Fix potential NULL pointer dereference

 configure.in                          |    2 +-
 include/asm-generic/wrappers.h        |    2 +-
 include/rtdm/rtdm.h                   |    4 +-
 include/rtdm/rtdm_driver.h            |   27 ++-
 include/rtdm/rttesting.h              |   10 +-
 ksrc/drivers/analogy/rtdm_interface.c |    2 -
 ksrc/drivers/can/rtcan_raw.c          |    2 -
 ksrc/drivers/ipc/rtipc.c              |   13 +-
 ksrc/drivers/serial/16550A.c          |   51 +---
 ksrc/drivers/testing/irqbench.c       |    4 +-
 ksrc/drivers/testing/switchtest.c     |    4 +-
 ksrc/drivers/testing/timerbench.c     |    4 +-
 ksrc/skins/rtdm/API.CHANGES           |    9 +
 ksrc/skins/rtdm/core.c                |   41 +++-
 ksrc/skins/rtdm/device.c              |   13 +-
 ksrc/skins/rtdm/drvlib.c              |   25 ++
 ksrc/skins/rtdm/syscall.c             |   10 +-
 src/testsuite/irqbench/Makefile.am    |    2 +-
 src/testsuite/irqbench/irqbench.c     |  480 ++++++++++++++++-----------------
 src/testsuite/irqbench/irqloop.c      |  304 +++++++++++----------
 src/testsuite/latency/latency.c       |    2 +-
 src/testsuite/switchtest/switchtest.c |   50 +---
 22 files changed, 554 insertions(+), 507 deletions(-)

