Message-ID: <4CA9BF97.2060609@domain.hid>
Date: Mon, 04 Oct 2010 13:50:47 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [git pull] Refreshed & host-clock-enhanced queue for
	head
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>, Xenomai core <Xenomai-core@domain.hid>

The following changes since commit 0f0db62bc5ed90aaf85c87af876fbc319131a640:

  Merge remote branch 'v2.5.x' (2010-10-04 10:27:03 +0200)

are available in the git repository at:

  git://git.xenomai.org/xenomai-jki.git for-upstream

Jan Kiszka (5):
      rt_print: Properly return printed length
      RTDM: Plug race between proc_read_dev_info and device deregistration
      RTDM: Properly clean up on xnvfile setup errors
      RTDM: Extend device name space in open_fildes proc output
      nucleus: Fix lock imbalance in registry_proc_callback

Wolfgang Mauerer (7):
      nucleus: Spelling fix for check-vdso.c
      nucleus: Add userland cpu_relax() definition for x86
      nucleus: Infrastructure for CLOCK_HOST_REALTIME
      posix: Support reading the host realtime clock in realtime context
      posix: Userspace hostrt reading without switching to kernel mode
      Convert clocktest to Xenomai indentation style
      Update clocktest for CLOCK_HOST_REALTIME

 include/asm-generic/hal.h           |   11 +
 include/asm-generic/system.h        |    3 +
 include/asm-sim/system.h            |    3 +
 include/asm-x86/atomic.h            |    5 +
 include/nucleus/Makefile.am         |    2 +
 include/nucleus/hostrt.h            |   54 ++++++
 include/nucleus/seqlock_user.h      |   57 ++++++
 include/nucleus/vdso.h              |   20 ++-
 include/posix/time.h                |    7 +
 ksrc/nucleus/Kconfig                |    4 +
 ksrc/nucleus/module.c               |   64 ++++++-
 ksrc/nucleus/registry.c             |    3 +-
 ksrc/skins/posix/clock.c            |   86 +++++++++-
 ksrc/skins/rtdm/proc.c              |   45 ++++-
 src/rtdk/rt_print.c                 |    1 +
 src/skins/posix/clock.c             |   92 ++++++++--
 src/testsuite/clocktest/clocktest.c |  350 ++++++++++++++++++++---------------
 src/testsuite/unit/check-vdso.c     |    2 +-
 18 files changed, 629 insertions(+), 180 deletions(-)
 create mode 100644 include/nucleus/hostrt.h
 create mode 100644 include/nucleus/seqlock_user.h

