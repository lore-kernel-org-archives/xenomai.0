From: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
Date: Thu,  8 Jul 2010 12:18:14 +0200
Message-Id: <1278584301-8064-1-git-send-email-wolfgang.mauerer@domain.hid>
Subject: [Xenomai-core] [PATCH v2 0/7] Host realtime clock support
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org
Cc: jan.kiszka@domain.hid

(This is the Xenomai part of the mechanism, please see the ipipe
 mailing list for the patches that provide the required basis 
 infrastructure)

This patch series extends Xenomai with a new clock, CLOCK_HOST_REALTIME.
It allows for sharing NTP-corrected real time timestamps between
Linux/ipipe and Xenomai. The data are also available in userspace and can
be read without switching to kernel mode. Notice, however, that the new
clock only enables to read to time, but cannot serve as a full time basis.
Some changes to the ipipe layer are required as basis.

Changes since the last submission:

- Unconditionally create an nkvdso instance to get rid of splitting
  the implementation into a pervasive/non-pervasive part
- Remove explicit usage example, update clocktest code for the new clock
  instead
- Include some smaller review comments

The selection of Linux clocks suitable for our purposes remains
as in the last series.

Tested on x86_64, compile tested for all combinations of
IPIPE_HOSTRT, XENO_OPT_HOSTRT and XENO_OPT_PERVASIVE

 include/asm-generic/hal.h             |   11 +
 include/asm-generic/system.h          |    3
 include/asm-sim/system.h              |    3
 include/asm-x86/atomic.h              |    5
 include/nucleus/Makefile.am           |    1
 include/nucleus/hostrt.h              |   54 ++++++
 include/nucleus/seqlock_user.h        |   57 ++++++
 include/nucleus/vdso.h                |   20 +-
 include/posix/time.h                  |    7
 ksrc/nucleus/Kconfig                  |    4
 ksrc/nucleus/module.c                 |   64 ++++++-
 ksrc/skins/posix/clock.c              |   86 +++++++++-
 src/skins/posix/clock.c               |   92 +++++++++-
 src/testsuite/clocktest/clocktest.c   |   64 ++++++-
 src/testsuite/unit/check-vdso.c       |    2
 include/nucleus/Makefile.am           |    1
 src/testsuite/clocktest/clocktest.c   |  292 +++++++++++++++++-----------------
 17 files changed, 594 insertions(+), 172 deletions(-)


