From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 00/17] Dovetail integration - the finals
Date: Fri, 11 Jun 2021 20:05:26 +0200
Message-Id: <cover.1623434743.git.jan.kiszka@siemens.com>
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

Now the final bits to git dovetail / 5.10 support into mainline. The
last missing piece was the avoidance xnmalloc in critical paths when
submitting inband work. I've used Hongzhan's patch for xnthread_signal
and also Philippe's patches for the remaining cases. The outcome seems
to work fine for both I-pipe and Dovetail now - but please review!

Not included are necessary RTDM extensions and the addition of latmus as
currently still queued in wip/dovetail. There were some open issues, but
those could not be easily addressed on top of next.

On top, I would also still like to understand - and ideally address
prior to releasing a new major version - if we cannot align the ARM
syscall ABI of Xenomai to the kernel /wrt argument passing. Now is a
good chance to do that.

Jan


CC: Philippe Gerum <rpm@xenomai.org>

Jan Kiszka (9):
  cobalt/thread: Rework kthread check for xnthread_signal
  cobalt/thread: Move xnthread_signal work off the stack
  cobalt/thread: Privatize xnthread_map to map_kthread
  cobalt/thread: Pull kthread inband work onto creator stack
  cobalt/thread: Make sure relax inband work is on a stack outliving the
    wakeup
  lib/cobalt: Reorder low_init for having cobalt_use_legacy_tsc earlier
    available
  cobalt/tick: dovetail: Drop pointless inline specifier from
    pipeline_must_force_program_tick
  cobalt/syscall: Account for different syscall argument marshaling
  ci: Add arm, arm64 and x86 dovetail targets for kernel 5.10

Philippe Gerum (8):
  cobalt/thread: dovetail: keep hard irqs off on transition to in-band
  cobalt/sched: dovetail: prevent early scheduling on uninit runqueues
  cobalt/arm: dovetail: add architecture bits
  lib/cobalt/arm: dovetail: skip detection of KUSER_TSC support
  lib/cobalt/arm64: dovetail: skip detection of KUSER_TSC support
  cobalt/tick: dovetail: improve accuracy of the host tick delay
  cobalt/clock: dovetail: abstract interface to hardware TSC
  cobalt/arm64: dovetail: add architecture bits

 .gitlab-ci.yml                                |  26 ++
 .../kernel/dovetail/pipeline/pipeline.h       |  11 +
 .../cobalt/kernel/dovetail/pipeline/sched.h   |  12 +
 .../cobalt/kernel/dovetail/pipeline/tick.h    |   2 +-
 .../cobalt/kernel/ipipe/pipeline/pipeline.h   |  12 +
 include/cobalt/kernel/ipipe/pipeline/sched.h  |  20 +
 include/cobalt/kernel/thread.h                |  24 +-
 include/cobalt/sys/cobalt.h                   |   2 +
 include/copperplate/clockobj.h                |  12 +-
 kernel/cobalt/arch/arm/Kconfig                |   4 +
 kernel/cobalt/arch/arm/dovetail/Makefile      |   5 +
 .../include/asm/xenomai/calibration.h         |  39 ++
 .../dovetail/include/asm/xenomai/features.h   |  30 ++
 .../arm/dovetail/include/asm/xenomai/fptest.h |  52 +++
 .../dovetail}/include/asm/xenomai/machine.h   |  67 +--
 .../dovetail/include/asm/xenomai/syscall.h    | 101 +++++
 .../dovetail/include/asm/xenomai/syscall32.h  |  24 ++
 .../arm/dovetail/include/asm/xenomai/thread.h |  32 ++
 .../dovetail/include/asm/xenomai/wrappers.h   |  27 ++
 kernel/cobalt/arch/arm/dovetail/machine.c     |  44 ++
 kernel/cobalt/arch/arm64/dovetail/Makefile    |   5 +
 .../include/asm/xenomai/calibration.h         |  24 ++
 .../dovetail/include/asm/xenomai/features.h   |  15 +
 .../dovetail/include/asm/xenomai/fptest.h     |  35 ++
 .../dovetail/include/asm/xenomai/machine.h    |  33 ++
 .../dovetail/include/asm/xenomai/syscall.h    |  63 +++
 .../dovetail/include/asm/xenomai/syscall32.h  |  12 +
 .../dovetail/include/asm/xenomai/thread.h     |  22 +
 .../dovetail/include/asm/xenomai/wrappers.h   |  15 +
 kernel/cobalt/arch/arm64/dovetail/machine.c   |  41 ++
 .../arm64/ipipe/include/asm/xenomai/machine.h |   3 +
 kernel/cobalt/arch/arm64/ipipe/machine.c      |   3 +
 .../dovetail/include/asm/xenomai/syscall.h    |   5 -
 kernel/cobalt/dovetail/kevents.c              |   2 +-
 kernel/cobalt/dovetail/sched.c                |   1 +
 kernel/cobalt/dovetail/tick.c                 |  14 +-
 .../include/asm-generic/xenomai/syscall.h     |   7 -
 kernel/cobalt/ipipe/kevents.c                 |   2 +-
 kernel/cobalt/posix/syscall.c                 |  14 +-
 kernel/cobalt/sched.c                         |  10 +-
 kernel/cobalt/synch.c                         |   4 +-
 kernel/cobalt/thread.c                        | 402 ++++++++----------
 lib/cobalt/arch/arm/features.c                |   4 +
 lib/cobalt/arch/arm/include/asm/xenomai/tsc.h |   2 +-
 lib/cobalt/arch/arm64/features.c              |   4 +
 .../arch/arm64/include/asm/xenomai/tsc.h      |   2 +-
 .../arch/powerpc/include/asm/xenomai/tsc.h    |   2 +-
 lib/cobalt/arch/x86/include/asm/xenomai/tsc.h |   2 +-
 lib/cobalt/clock.c                            |   6 +-
 lib/cobalt/init.c                             |   2 +-
 lib/cobalt/internal.c                         |  18 +-
 lib/copperplate/clockobj.c                    |  12 +-
 testsuite/smokey/tsc/tsc.c                    |   2 +-
 53 files changed, 1030 insertions(+), 304 deletions(-)
 create mode 100644 kernel/cobalt/arch/arm/dovetail/Makefile
 create mode 100644 kernel/cobalt/arch/arm/dovetail/include/asm/xenomai/calibration.h
 create mode 100644 kernel/cobalt/arch/arm/dovetail/include/asm/xenomai/features.h
 create mode 100644 kernel/cobalt/arch/arm/dovetail/include/asm/xenomai/fptest.h
 copy kernel/cobalt/arch/{arm64/ipipe => arm/dovetail}/include/asm/xenomai/machine.h (59%)
 create mode 100644 kernel/cobalt/arch/arm/dovetail/include/asm/xenomai/syscall.h
 create mode 100644 kernel/cobalt/arch/arm/dovetail/include/asm/xenomai/syscall32.h
 create mode 100644 kernel/cobalt/arch/arm/dovetail/include/asm/xenomai/thread.h
 create mode 100644 kernel/cobalt/arch/arm/dovetail/include/asm/xenomai/wrappers.h
 create mode 100644 kernel/cobalt/arch/arm/dovetail/machine.c
 create mode 100644 kernel/cobalt/arch/arm64/dovetail/Makefile
 create mode 100644 kernel/cobalt/arch/arm64/dovetail/include/asm/xenomai/calibration.h
 create mode 100644 kernel/cobalt/arch/arm64/dovetail/include/asm/xenomai/features.h
 create mode 100644 kernel/cobalt/arch/arm64/dovetail/include/asm/xenomai/fptest.h
 create mode 100644 kernel/cobalt/arch/arm64/dovetail/include/asm/xenomai/machine.h
 create mode 100644 kernel/cobalt/arch/arm64/dovetail/include/asm/xenomai/syscall.h
 create mode 100644 kernel/cobalt/arch/arm64/dovetail/include/asm/xenomai/syscall32.h
 create mode 100644 kernel/cobalt/arch/arm64/dovetail/include/asm/xenomai/thread.h
 create mode 100644 kernel/cobalt/arch/arm64/dovetail/include/asm/xenomai/wrappers.h
 create mode 100644 kernel/cobalt/arch/arm64/dovetail/machine.c

-- 
2.26.2


