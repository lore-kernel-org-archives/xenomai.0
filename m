From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Mon, 19 Apr 2010 12:28:40 +0200
Message-Id: <cover.1271672940.git.jan.kiszka@domain.hid>
Subject: [Xenomai-core] [PATCH v4 00/25] [git pull v4] RTDM fixes and reworks
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

The following changes since commit 2bed24477882dd7937d59f4e33a0811981c7362c:
  Gilles Chanteperdrix (1):
        arm: declare the VFP inline asm snippets as volatile.

are available in the git repository at:

  git://git.xenomai.org/xenomai-jki.git for-upstream

Changes in v4:
 - fixed rtdm_rt_capable()
 - renamed rttesting subclasses to switchtest and timerbench
 - added non-atomic used_fildes patch
 - fixed false-positive deprecated warnings for open_rt
 - fixed test device name regressions of v3

Changes in v3:
 - extended RTDM unit test to check for returned file descriptor number

Changes in v2:
 - compat support for rttest device names
 - documented RTDM close procedure
 - internal rework of the close procedure
 - basic RTDM unit test, so far targeting at the close rework
 - some additional small cleanup patches

Jan Kiszka (24):
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
  RTDM: Use non-atomic bitops for used_fildes

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
 ksrc/drivers/testing/rtdmtest.c       |  191 +++++++++++++
 ksrc/drivers/testing/switchtest.c     |    7 +-
 ksrc/drivers/testing/timerbench.c     |    7 +-
 ksrc/skins/rtdm/API.CHANGES           |    9 +
 ksrc/skins/rtdm/core.c                |  209 ++++++++++----
 ksrc/skins/rtdm/device.c              |   59 ++++-
 ksrc/skins/rtdm/drvlib.c              |   25 ++
 ksrc/skins/rtdm/internal.h            |    8 +-
 ksrc/skins/rtdm/syscall.c             |   10 +-
 src/testsuite/irqbench/Makefile.am    |    2 +-
 src/testsuite/irqbench/irqbench.c     |  480 ++++++++++++++++-----------------
 src/testsuite/irqbench/irqloop.c      |  312 +++++++++++----------
 src/testsuite/latency/latency.c       |   12 +-
 src/testsuite/switchtest/switchtest.c |   15 +-
 src/testsuite/unit/Makefile.am        |   17 ++-
 src/testsuite/unit/rtdm.c             |  114 ++++++++
 32 files changed, 1158 insertions(+), 552 deletions(-)
 create mode 100644 ksrc/drivers/testing/rtdmtest.c
 create mode 100644 src/testsuite/unit/rtdm.c


