From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 00/25] Dovetail integration, next round
Date: Thu, 20 May 2021 23:44:10 +0200
Message-Id: <cover.1621547075.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

This is just half-way through to one working arch. A split at this at
the point libcobalt is refactored for dovetail ticks. Test target for
this part remains I-pipe, i.e. the check for no regressions on it.

Jan


CC: Hongzhan Chen <hongzhan.chen@intel.com>
CC: Philippe Gerum <rpm@xenomai.org>

Hongzhan Chen (12):
  cobalt/irq: dovetail: implement out-of-band irq management and
    handling
  cobalt/kevents: dovetail: enable back tracing
  cobalt/kernel: dovetail: implement sirq services
  cobalt/sched: dovetail: add task control block initializers
  cobalt/clock: dovetail: provide backend code to CLOCK_HOST_REALTIME
  cobalt/init: dovetail: add oob stage enabling, disabling services
  cobalt/tick: dovetail: install/uninstall proxy tick device
  cobalt/tick: dovetail: implement pipeline_set_timer_shot()
  cobalt/tick: dovetail: implement pipeline_timer_name()
  cobalt/timer: pipeline: abstract handling of ONESHOT_STOPPED mode
  cobalt/timer: dovetail: handle ONESHOT_STOPPED mode
  cobalt/clock: dovetail: implement pipeline_read_cycle_counter()

Jan Kiszka (3):
  cobalt/x86: ipipe: Remove leftover from x86_32 removal
  cobalt/x86: ipipe: Drop unused strncpy_from_user_nocheck
  cobalt/x86: Move shared headers out of pipeline specific folder

Philippe Gerum (10):
  cobalt/kernel: ipipe: rename xnsched_realtime_domain to
    xnsched_primary_domain
  cobalt/kevents: dovetail: drop call to obsolete force_commit_memory()
  cobalt/intr: dovetail: implement interrupt management, handling
  cobalt/x86: dovetail: add architecture bits
  cobalt/timer: Check if nklock is held in timer services
  cobalt/tick: dovetail: flatten the call stack to pipeline services
  lib/cobalt: ticks: drop cobalt_read_hrclock()
  lib/cobalt: dovetail: allow representing time as count of nanoseconds
  lib/cobalt: add default wrapper to clock_settime()
  lib/cobalt: dovetail: use clock_gettime() vcall for reading timestamps

 .../cobalt/kernel/dovetail/pipeline/clock.h   |  30 +-
 include/cobalt/kernel/dovetail/pipeline/irq.h |  24 ++
 .../kernel/dovetail/pipeline/pipeline.h       |  40 +--
 .../cobalt/kernel/dovetail/pipeline/sirq.h    |  28 +-
 .../cobalt/kernel/dovetail/pipeline/tick.h    |   4 +
 .../cobalt/kernel/ipipe/pipeline/pipeline.h   |   2 +-
 include/cobalt/kernel/ipipe/pipeline/tick.h   |   6 +
 include/cobalt/kernel/sched.h                 |   5 +
 include/cobalt/ticks.h                        |  50 +++-
 kernel/cobalt/arch/x86/dovetail/Makefile      |   5 +
 kernel/cobalt/arch/x86/dovetail/c1e.c         |   1 +
 .../include/asm/xenomai/calibration.h}        |  34 +--
 .../x86/dovetail/include/asm/xenomai/fptest.h |  70 +++++
 .../include/asm/xenomai/machine.h             |   7 +-
 .../include/asm/xenomai/syscall.h             |  19 +-
 .../x86/dovetail/include/asm/xenomai/thread.h |  38 +++
 .../arch/x86/{ipipe => dovetail}/machine.c    |  29 +-
 kernel/cobalt/arch/x86/dovetail/smi.c         |   1 +
 .../x86/{ipipe => }/include/asm/xenomai/c1e.h |   0
 .../include/asm/xenomai/features.h            |   0
 .../x86/{ipipe => }/include/asm/xenomai/smi.h |   0
 .../include/asm/xenomai/syscall32-table.h     |   0
 .../include/asm/xenomai/syscall32.h           |   0
 .../include/asm/xenomai/wrappers.h            |   0
 .../x86/ipipe/include/asm/xenomai/machine.h   |   4 -
 .../x86/ipipe/include/asm/xenomai/syscall.h   |   8 -
 kernel/cobalt/arch/x86/ipipe/machine.c        |  19 --
 kernel/cobalt/arch/x86/ipipe/smi.c            |   4 +-
 kernel/cobalt/clock.c                         |   2 +-
 kernel/cobalt/dovetail/Makefile               |   2 +-
 kernel/cobalt/dovetail/init.c                 |   4 +-
 kernel/cobalt/dovetail/intr.c                 | 130 ++++++++
 kernel/cobalt/dovetail/kevents.c              |  15 +-
 kernel/cobalt/dovetail/sched.c                |  12 +-
 kernel/cobalt/dovetail/tick.c                 | 141 ++++++++-
 kernel/cobalt/ipipe/init.c                    |  12 +-
 kernel/cobalt/ipipe/intr.c                    |  20 +-
 kernel/cobalt/ipipe/kevents.c                 |   2 +-
 kernel/cobalt/ipipe/syscall.c                 |   2 +-
 kernel/cobalt/timer.c                         |  17 +-
 lib/cobalt/Makefile.am                        |   1 +
 .../arch/arm/include/asm/xenomai/time.h       |  16 +
 .../arch/arm64/include/asm/xenomai/time.h     |  16 +
 .../arch/powerpc/include/asm/xenomai/time.h   |  16 +
 .../arch/x86/include/asm/xenomai/time.h       |  16 +
 lib/cobalt/clock.c                            | 107 ++++---
 lib/cobalt/internal.h                         |   6 +
 lib/cobalt/parse_vdso.c                       | 281 ++++++++++++++++++
 lib/cobalt/ticks.c                            |  65 ++--
 lib/cobalt/wrappers.c                         |   6 +
 50 files changed, 1060 insertions(+), 257 deletions(-)
 create mode 100644 include/cobalt/kernel/dovetail/pipeline/irq.h
 create mode 100644 kernel/cobalt/arch/x86/dovetail/Makefile
 create mode 120000 kernel/cobalt/arch/x86/dovetail/c1e.c
 copy kernel/cobalt/arch/x86/{ipipe/include/asm/xenomai/machine.h => dovetail/include/asm/xenomai/calibration.h} (52%)
 create mode 100644 kernel/cobalt/arch/x86/dovetail/include/asm/xenomai/fptest.h
 copy kernel/cobalt/arch/x86/{ipipe => dovetail}/include/asm/xenomai/machine.h (88%)
 copy kernel/cobalt/arch/x86/{ipipe => dovetail}/include/asm/xenomai/syscall.h (87%)
 create mode 100644 kernel/cobalt/arch/x86/dovetail/include/asm/xenomai/thread.h
 copy kernel/cobalt/arch/x86/{ipipe => dovetail}/machine.c (80%)
 create mode 120000 kernel/cobalt/arch/x86/dovetail/smi.c
 rename kernel/cobalt/arch/x86/{ipipe => }/include/asm/xenomai/c1e.h (100%)
 rename kernel/cobalt/arch/x86/{ipipe => }/include/asm/xenomai/features.h (100%)
 rename kernel/cobalt/arch/x86/{ipipe => }/include/asm/xenomai/smi.h (100%)
 rename kernel/cobalt/arch/x86/{ipipe => }/include/asm/xenomai/syscall32-table.h (100%)
 rename kernel/cobalt/arch/x86/{ipipe => }/include/asm/xenomai/syscall32.h (100%)
 rename kernel/cobalt/arch/x86/{ipipe => }/include/asm/xenomai/wrappers.h (100%)
 create mode 100644 kernel/cobalt/dovetail/intr.c
 create mode 100644 lib/cobalt/arch/arm/include/asm/xenomai/time.h
 create mode 100644 lib/cobalt/arch/arm64/include/asm/xenomai/time.h
 create mode 100644 lib/cobalt/arch/powerpc/include/asm/xenomai/time.h
 create mode 100644 lib/cobalt/arch/x86/include/asm/xenomai/time.h
 create mode 100644 lib/cobalt/parse_vdso.c

-- 
2.26.2


