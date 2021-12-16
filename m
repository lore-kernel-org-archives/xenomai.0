From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 0/5] Remove support for I-pipe / kernels < 5.10
Date: Thu, 16 Dec 2021 16:48:20 +0100
Message-ID: <cover.1639669704.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Move forward and cut off the ropes that binds us to I-pipe kernels, thus
anything older than 5.10.

This series primarily removes no longer used files and kernel version
wrappings. It does not yet fold dovetail code into the pipeline
abstractions once established to work with both patches. That can be
done later.

Jan

Jan Kiszka (5):
  ci: Drop builds for kernels older than 5.10
  cobalt: Drop support for I-pipe based kernels
  cobalt: Drop vmalloc_kernel wrapper
  cobalt: Drop wrappings for kernels < 5.10
  cobalt: Fold dovetail directory in arch-specific sections

 .gitlab-ci.yml                                |   56 -
 doc/asciidoc/README.INSTALL.adoc              |   31 +-
 .../kernel/dovetail/pipeline/wrappers.h       |    9 -
 include/cobalt/kernel/ipipe/pipeline/clock.h  |   45 -
 .../kernel/ipipe/pipeline/inband_work.h       |   32 -
 include/cobalt/kernel/ipipe/pipeline/irq.h    |   14 -
 .../cobalt/kernel/ipipe/pipeline/kevents.h    |   36 -
 include/cobalt/kernel/ipipe/pipeline/lock.h   |   21 -
 .../cobalt/kernel/ipipe/pipeline/machine.h    |   55 -
 .../cobalt/kernel/ipipe/pipeline/pipeline.h   |   96 --
 include/cobalt/kernel/ipipe/pipeline/sched.h  |   58 -
 include/cobalt/kernel/ipipe/pipeline/sirq.h   |   59 -
 include/cobalt/kernel/ipipe/pipeline/thread.h |   27 -
 include/cobalt/kernel/ipipe/pipeline/tick.h   |   18 -
 include/cobalt/kernel/ipipe/pipeline/trace.h  |  116 --
 .../kernel/ipipe/pipeline/vdso_fallback.h     |   16 -
 .../cobalt/kernel/ipipe/pipeline/wrappers.h   |   25 -
 include/cobalt/kernel/rtdm/driver.h           |    4 +-
 .../cobalt/arch/arm/{dovetail => }/Makefile   |    0
 .../dovetail/include/asm/xenomai/features.h   |   30 -
 .../dovetail/include/asm/xenomai/wrappers.h   |   27 -
 .../include/asm/xenomai/calibration.h         |    6 +-
 .../include/asm/xenomai/features.h            |    6 +-
 .../include/asm/xenomai/fptest.h              |    6 +-
 .../include/asm/xenomai/machine.h             |    6 +-
 .../include/asm/xenomai/syscall.h             |    6 +-
 .../include/asm/xenomai/syscall32.h           |    0
 .../include/asm/xenomai/thread.h              |    8 +-
 .../include/asm/xenomai/wrappers.h            |    3 -
 kernel/cobalt/arch/arm/ipipe/Makefile         |    5 -
 kernel/cobalt/arch/arm/ipipe/README           |    3 -
 .../ipipe/include/asm/xenomai/calibration.h   |   63 -
 .../arm/ipipe/include/asm/xenomai/fptest.h    |   52 -
 .../arm/ipipe/include/asm/xenomai/machine.h   |   85 --
 .../arm/ipipe/include/asm/xenomai/syscall.h   |   91 --
 .../arm/ipipe/include/asm/xenomai/syscall32.h |   24 -
 .../arm/ipipe/include/asm/xenomai/thread.h    |  119 --
 kernel/cobalt/arch/arm/ipipe/machine.c        |   63 -
 kernel/cobalt/arch/arm/ipipe/switch.S         |  219 ---
 kernel/cobalt/arch/arm/ipipe/syscall.c        |   53 -
 kernel/cobalt/arch/arm/ipipe/thread.c         |  343 -----
 .../cobalt/arch/arm/{dovetail => }/machine.c  |    0
 .../cobalt/arch/arm64/{dovetail => }/Makefile |    0
 .../include/asm/xenomai/calibration.h         |    6 +-
 .../include/asm/xenomai/features.h            |    6 +-
 .../include/asm/xenomai/fptest.h              |    6 +-
 .../include/asm/xenomai/machine.h             |    6 +-
 .../include/asm/xenomai/syscall.h             |    6 +-
 .../include/asm/xenomai/syscall32.h           |    6 +-
 .../include/asm/xenomai/thread.h              |    8 +-
 .../include/asm/xenomai/wrappers.h            |    3 -
 kernel/cobalt/arch/arm64/ipipe/Makefile       |    5 -
 kernel/cobalt/arch/arm64/ipipe/README         |    3 -
 .../ipipe/include/asm/xenomai/calibration.h   |   37 -
 .../ipipe/include/asm/xenomai/features.h      |   30 -
 .../arm64/ipipe/include/asm/xenomai/fptest.h  |   47 -
 .../arm64/ipipe/include/asm/xenomai/machine.h |   68 -
 .../arm64/ipipe/include/asm/xenomai/syscall.h |   77 --
 .../ipipe/include/asm/xenomai/syscall32.h     |   24 -
 .../arm64/ipipe/include/asm/xenomai/thread.h  |   97 --
 .../ipipe/include/asm/xenomai/wrappers.h      |   27 -
 kernel/cobalt/arch/arm64/ipipe/machine.c      |   66 -
 kernel/cobalt/arch/arm64/ipipe/syscall.c      |   53 -
 kernel/cobalt/arch/arm64/ipipe/thread.c       |  156 ---
 .../arch/arm64/{dovetail => }/machine.c       |    0
 .../cobalt/arch/x86/{dovetail => }/Makefile   |    0
 kernel/cobalt/arch/x86/{ipipe => }/c1e.c      |    0
 kernel/cobalt/arch/x86/dovetail/c1e.c         |    1 -
 kernel/cobalt/arch/x86/dovetail/smi.c         |    1 -
 .../include/asm/xenomai/calibration.h         |    0
 .../include/asm/xenomai/fptest.h              |    0
 .../include/asm/xenomai/machine.h             |    0
 .../include/asm/xenomai/syscall.h             |    0
 .../include/asm/xenomai/thread.h              |    2 +-
 .../arch/x86/include/asm/xenomai/wrappers.h   |   40 -
 kernel/cobalt/arch/x86/ipipe/Makefile         |    5 -
 kernel/cobalt/arch/x86/ipipe/README           |    3 -
 .../ipipe/include/asm/xenomai/calibration.h   |   71 -
 .../x86/ipipe/include/asm/xenomai/fptest.h    |   83 --
 .../x86/ipipe/include/asm/xenomai/machine.h   |   35 -
 .../x86/ipipe/include/asm/xenomai/syscall.h   |   81 --
 .../x86/ipipe/include/asm/xenomai/thread.h    |  101 --
 kernel/cobalt/arch/x86/ipipe/machine.c        |   78 --
 kernel/cobalt/arch/x86/ipipe/thread.c         |  526 -------
 .../cobalt/arch/x86/{dovetail => }/machine.c  |    0
 kernel/cobalt/arch/x86/{ipipe => }/smi.c      |    0
 kernel/cobalt/debug.c                         |    1 +
 kernel/cobalt/heap.c                          |    2 +-
 .../asm-generic/xenomai/ipipe/thread.h        |   39 -
 .../include/asm-generic/xenomai/syscall.h     |   14 +-
 .../xenomai/{dovetail => }/thread.h           |    6 +-
 .../include/asm-generic/xenomai/wrappers.h    |  198 +--
 kernel/cobalt/include/ipipe/thread_info.h     |   38 -
 .../cobalt/include/linux/xenomai/wrappers.h   |   44 -
 kernel/cobalt/ipipe/Makefile                  |    5 -
 kernel/cobalt/ipipe/clock.c                   |  158 ---
 kernel/cobalt/ipipe/init.c                    |   81 --
 kernel/cobalt/ipipe/intr.c                    | 1230 -----------------
 kernel/cobalt/ipipe/kevents.c                 |  541 --------
 kernel/cobalt/ipipe/sched.c                   |  198 ---
 kernel/cobalt/ipipe/syscall.c                 |   29 -
 kernel/cobalt/ipipe/tick.c                    |  286 ----
 kernel/cobalt/pipe.c                          |    5 +-
 kernel/cobalt/posix/clock.c                   |    4 +-
 kernel/cobalt/posix/compat.c                  |   24 +-
 kernel/cobalt/posix/io.c                      |   10 +-
 kernel/cobalt/posix/memory.c                  |    2 +-
 kernel/cobalt/posix/mqueue.c                  |    4 +-
 kernel/cobalt/posix/process.c                 |    3 +-
 kernel/cobalt/posix/signal.c                  |    2 +-
 kernel/cobalt/posix/syscall32.c               |    2 +-
 kernel/cobalt/posix/timerfd.c                 |    2 +-
 kernel/cobalt/rtdm/Makefile                   |    3 +-
 kernel/cobalt/rtdm/wrappers.c                 |  106 --
 kernel/cobalt/thread.c                        |    1 +
 .../analogy/national_instruments/mio_common.c |    2 -
 .../analogy/national_instruments/mite.c       |    3 -
 .../analogy/national_instruments/ni_660x.c    |    2 -
 .../analogy/national_instruments/tio_common.c |    1 -
 kernel/drivers/gpio/gpio-core.c               |    2 +-
 kernel/drivers/ipc/rtipc.c                    |    2 +-
 kernel/drivers/net/addons/proxy.c             |    3 -
 kernel/drivers/net/drivers/e1000e/netdev.c    |   27 -
 .../drivers/experimental/e1000/e1000_main.c   |    3 -
 .../net/drivers/experimental/e1000/kcompat.h  |    8 -
 .../drivers/net/drivers/freescale/fec_main.c  |   21 -
 kernel/drivers/net/drivers/igb/igb_main.c     |   31 -
 kernel/drivers/net/drivers/r8169.c            |    4 -
 kernel/drivers/net/stack/rtcfg/rtcfg_ioctl.c  |    6 +-
 kernel/drivers/net/stack/rtdev.c              |    4 -
 scripts/prepare-kernel.sh                     |   40 +-
 scripts/xeno-config-cobalt.in                 |    3 -
 132 files changed, 110 insertions(+), 6790 deletions(-)
 delete mode 100644 include/cobalt/kernel/dovetail/pipeline/wrappers.h
 delete mode 100644 include/cobalt/kernel/ipipe/pipeline/clock.h
 delete mode 100644 include/cobalt/kernel/ipipe/pipeline/inband_work.h
 delete mode 100644 include/cobalt/kernel/ipipe/pipeline/irq.h
 delete mode 100644 include/cobalt/kernel/ipipe/pipeline/kevents.h
 delete mode 100644 include/cobalt/kernel/ipipe/pipeline/lock.h
 delete mode 100644 include/cobalt/kernel/ipipe/pipeline/machine.h
 delete mode 100644 include/cobalt/kernel/ipipe/pipeline/pipeline.h
 delete mode 100644 include/cobalt/kernel/ipipe/pipeline/sched.h
 delete mode 100644 include/cobalt/kernel/ipipe/pipeline/sirq.h
 delete mode 100644 include/cobalt/kernel/ipipe/pipeline/thread.h
 delete mode 100644 include/cobalt/kernel/ipipe/pipeline/tick.h
 delete mode 100644 include/cobalt/kernel/ipipe/pipeline/trace.h
 delete mode 100644 include/cobalt/kernel/ipipe/pipeline/vdso_fallback.h
 delete mode 100644 include/cobalt/kernel/ipipe/pipeline/wrappers.h
 rename kernel/cobalt/arch/arm/{dovetail => }/Makefile (100%)
 delete mode 100644 kernel/cobalt/arch/arm/dovetail/include/asm/xenomai/features.h
 delete mode 100644 kernel/cobalt/arch/arm/dovetail/include/asm/xenomai/wrappers.h
 rename kernel/cobalt/arch/arm/{dovetail => }/include/asm/xenomai/calibration.h (90%)
 rename kernel/cobalt/arch/arm/{ipipe => }/include/asm/xenomai/features.h (89%)
 rename kernel/cobalt/arch/arm/{dovetail => }/include/asm/xenomai/fptest.h (91%)
 rename kernel/cobalt/arch/arm/{dovetail => }/include/asm/xenomai/machine.h (92%)
 rename kernel/cobalt/arch/arm/{dovetail => }/include/asm/xenomai/syscall.h (96%)
 rename kernel/cobalt/arch/arm/{dovetail => }/include/asm/xenomai/syscall32.h (100%)
 rename kernel/cobalt/arch/arm/{dovetail => }/include/asm/xenomai/thread.h (86%)
 rename kernel/cobalt/arch/arm/{ipipe => }/include/asm/xenomai/wrappers.h (92%)
 delete mode 100644 kernel/cobalt/arch/arm/ipipe/Makefile
 delete mode 100644 kernel/cobalt/arch/arm/ipipe/README
 delete mode 100644 kernel/cobalt/arch/arm/ipipe/include/asm/xenomai/calibration.h
 delete mode 100644 kernel/cobalt/arch/arm/ipipe/include/asm/xenomai/fptest.h
 delete mode 100644 kernel/cobalt/arch/arm/ipipe/include/asm/xenomai/machine.h
 delete mode 100644 kernel/cobalt/arch/arm/ipipe/include/asm/xenomai/syscall.h
 delete mode 100644 kernel/cobalt/arch/arm/ipipe/include/asm/xenomai/syscall32.h
 delete mode 100644 kernel/cobalt/arch/arm/ipipe/include/asm/xenomai/thread.h
 delete mode 100644 kernel/cobalt/arch/arm/ipipe/machine.c
 delete mode 100644 kernel/cobalt/arch/arm/ipipe/switch.S
 delete mode 100644 kernel/cobalt/arch/arm/ipipe/syscall.c
 delete mode 100644 kernel/cobalt/arch/arm/ipipe/thread.c
 rename kernel/cobalt/arch/arm/{dovetail => }/machine.c (100%)
 rename kernel/cobalt/arch/arm64/{dovetail => }/Makefile (100%)
 rename kernel/cobalt/arch/arm64/{dovetail => }/include/asm/xenomai/calibration.h (79%)
 rename kernel/cobalt/arch/arm64/{dovetail => }/include/asm/xenomai/features.h (64%)
 rename kernel/cobalt/arch/arm64/{dovetail => }/include/asm/xenomai/fptest.h (79%)
 rename kernel/cobalt/arch/arm64/{dovetail => }/include/asm/xenomai/machine.h (82%)
 rename kernel/cobalt/arch/arm64/{dovetail => }/include/asm/xenomai/syscall.h (92%)
 rename kernel/cobalt/arch/arm64/{dovetail => }/include/asm/xenomai/syscall32.h (52%)
 rename kernel/cobalt/arch/arm64/{dovetail => }/include/asm/xenomai/thread.h (75%)
 rename kernel/cobalt/arch/arm64/{dovetail => }/include/asm/xenomai/wrappers.h (78%)
 delete mode 100644 kernel/cobalt/arch/arm64/ipipe/Makefile
 delete mode 100644 kernel/cobalt/arch/arm64/ipipe/README
 delete mode 100644 kernel/cobalt/arch/arm64/ipipe/include/asm/xenomai/calibration.h
 delete mode 100644 kernel/cobalt/arch/arm64/ipipe/include/asm/xenomai/features.h
 delete mode 100644 kernel/cobalt/arch/arm64/ipipe/include/asm/xenomai/fptest.h
 delete mode 100644 kernel/cobalt/arch/arm64/ipipe/include/asm/xenomai/machine.h
 delete mode 100644 kernel/cobalt/arch/arm64/ipipe/include/asm/xenomai/syscall.h
 delete mode 100644 kernel/cobalt/arch/arm64/ipipe/include/asm/xenomai/syscall32.h
 delete mode 100644 kernel/cobalt/arch/arm64/ipipe/include/asm/xenomai/thread.h
 delete mode 100644 kernel/cobalt/arch/arm64/ipipe/include/asm/xenomai/wrappers.h
 delete mode 100644 kernel/cobalt/arch/arm64/ipipe/machine.c
 delete mode 100644 kernel/cobalt/arch/arm64/ipipe/syscall.c
 delete mode 100644 kernel/cobalt/arch/arm64/ipipe/thread.c
 rename kernel/cobalt/arch/arm64/{dovetail => }/machine.c (100%)
 rename kernel/cobalt/arch/x86/{dovetail => }/Makefile (100%)
 rename kernel/cobalt/arch/x86/{ipipe => }/c1e.c (100%)
 delete mode 120000 kernel/cobalt/arch/x86/dovetail/c1e.c
 delete mode 120000 kernel/cobalt/arch/x86/dovetail/smi.c
 rename kernel/cobalt/arch/x86/{dovetail => }/include/asm/xenomai/calibration.h (100%)
 rename kernel/cobalt/arch/x86/{dovetail => }/include/asm/xenomai/fptest.h (100%)
 rename kernel/cobalt/arch/x86/{dovetail => }/include/asm/xenomai/machine.h (100%)
 rename kernel/cobalt/arch/x86/{dovetail => }/include/asm/xenomai/syscall.h (100%)
 rename kernel/cobalt/arch/x86/{dovetail => }/include/asm/xenomai/thread.h (96%)
 delete mode 100644 kernel/cobalt/arch/x86/ipipe/Makefile
 delete mode 100644 kernel/cobalt/arch/x86/ipipe/README
 delete mode 100644 kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/calibration.h
 delete mode 100644 kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/fptest.h
 delete mode 100644 kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/machine.h
 delete mode 100644 kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/syscall.h
 delete mode 100644 kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/thread.h
 delete mode 100644 kernel/cobalt/arch/x86/ipipe/machine.c
 delete mode 100644 kernel/cobalt/arch/x86/ipipe/thread.c
 rename kernel/cobalt/arch/x86/{dovetail => }/machine.c (100%)
 rename kernel/cobalt/arch/x86/{ipipe => }/smi.c (100%)
 delete mode 100644 kernel/cobalt/include/asm-generic/xenomai/ipipe/thread.h
 rename kernel/cobalt/include/asm-generic/xenomai/{dovetail => }/thread.h (78%)
 delete mode 100644 kernel/cobalt/include/ipipe/thread_info.h
 delete mode 100644 kernel/cobalt/include/linux/xenomai/wrappers.h
 delete mode 100644 kernel/cobalt/ipipe/Makefile
 delete mode 100644 kernel/cobalt/ipipe/clock.c
 delete mode 100644 kernel/cobalt/ipipe/init.c
 delete mode 100644 kernel/cobalt/ipipe/intr.c
 delete mode 100644 kernel/cobalt/ipipe/kevents.c
 delete mode 100644 kernel/cobalt/ipipe/sched.c
 delete mode 100644 kernel/cobalt/ipipe/syscall.c
 delete mode 100644 kernel/cobalt/ipipe/tick.c
 delete mode 100644 kernel/cobalt/rtdm/wrappers.c

-- 
2.31.1


