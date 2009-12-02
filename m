Message-ID: <4B15AFC0.6020805@domain.hid>
Date: Wed, 02 Dec 2009 01:07:28 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [pull request] Signals support.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai core <Xenomai-core@domain.hid>

Hi,

here come the pull request for user-space signals support. The simple 
solution; handling signals upon system call return, has been implemented
since the other solution (handling signals upon any return to 
user-space) required to change the I-pipe patch, and so made the 
upcoming 2.5 only compatible with newer patches.

We pass to kernel-space a sixth argument which is a pointer where 
information about received signals is stored by kernel.

The only architecture for which the implementation is peculiar is 
x86_32, because the register used as sixth argument is ebp, also used 
for the libc backtrace function implementation, so I tried to find a 
solution which makes backtracing still possible (otherwise we would have
said bye-bye to involuntary mode changes chasing with SIGXCPU) without 
breaking too many things.

A new test, creatively called sigtest allows to unit-test the signal
support.

The following changes since commit 5a29ba38d7563097b73f53615fb3fcb7a7e5a6a5:
  Philippe Gerum (1):
        nucleus: initialize heap->stat_link holder

are available in the git repository at:

  git+ssh://git.xenomai.org/xenomai-gch.git for-head

Gilles Chanteperdrix (12):
      bind: Replace bind.h with a convenience library.
      skins: add per-skin user-space signal handler, and dispatch function.
      arm: implement signals handling
      powerpc: implement signals handling
      x86_64: implement signals handling
      x86_32: implement signals handling
      nucleus: implement kernel-space per-thread per-skin signals handling.
      skins: move sigshadow to libxeno_common
      posix: fix pthread_cond_wait restarting
      native: fix rt_cond_wait restarting
      testsuite: add user-space real-time signals unit test
      build: bootstrap

Philippe Gerum (2):
      blackfin: introduce support for real-time signals
      nios: implement signals handling

 Makefile.in                                        |  193 +-
 aclocal.m4                                         |  323 +-
 config/Makefile.in                                 |   43 +-
 configure                                          | 5869 ++++++++++++--------
 configure.in                                       |    5 +
 doc/Makefile.in                                    |  131 +-
 doc/docbook/Makefile.in                            |  131 +-
 doc/docbook/custom-stylesheets/Makefile.in         |  131 +-
 doc/docbook/custom-stylesheets/xsl/Makefile.in     |  131 +-
 .../custom-stylesheets/xsl/common/Makefile.in      |   43 +-
 doc/docbook/custom-stylesheets/xsl/fo/Makefile.in  |   43 +-
 .../custom-stylesheets/xsl/html/Makefile.in        |   43 +-
 doc/docbook/xenomai/Makefile.in                    |   43 +-
 doc/doxygen/Makefile.in                            |   43 +-
 doc/man/Makefile.in                                |  215 +-
 doc/txt/Makefile.in                                |   82 +-
 include/Makefile.am                                |    2 +-
 include/Makefile.in                                |  194 +-
 include/analogy/Makefile.in                        |  105 +-
 include/asm-arm/Makefile.in                        |  170 +-
 include/asm-arm/bits/Makefile.in                   |  105 +-
 include/asm-arm/features.h                         |    2 +-
 include/asm-arm/syscall.h                          |   66 +-
 include/asm-blackfin/Makefile.in                   |  170 +-
 include/asm-blackfin/bits/Makefile.in              |  105 +-
 include/asm-blackfin/features.h                    |    2 +-
 include/asm-blackfin/syscall.h                     |  241 +-
 include/asm-generic/Makefile.in                    |  170 +-
 include/asm-generic/bits/Makefile.in               |  105 +-
 include/asm-generic/bits/bind.h                    |  305 +-
 include/asm-generic/bits/current.h                 |    3 +
 include/asm-generic/bits/sigshadow.h               |   74 +-
 include/asm-generic/syscall.h                      |   58 +-
 include/asm-nios2/Makefile.in                      |  170 +-
 include/asm-nios2/bits/Makefile.in                 |  105 +-
 include/asm-nios2/syscall.h                        |   73 +-
 include/asm-powerpc/Makefile.in                    |  170 +-
 include/asm-powerpc/bits/Makefile.in               |  105 +-
 include/asm-powerpc/features.h                     |    2 +-
 include/asm-powerpc/syscall.h                      |   58 +-
 include/asm-sim/Makefile.in                        |  170 +-
 include/asm-sim/bits/Makefile.in                   |  105 +-
 include/asm-x86/Makefile.in                        |  170 +-
 include/asm-x86/bits/Makefile.in                   |  105 +-
 include/asm-x86/features_32.h                      |    2 +-
 include/asm-x86/features_64.h                      |    2 +-
 include/asm-x86/syscall.h                          |  219 +-
 include/native/Makefile.in                         |  105 +-
 include/native/cond.h                              |    6 +-
 include/native/syscall.h                           |    3 +-
 include/nucleus/Makefile.in                        |  105 +-
 include/nucleus/shadow.h                           |    6 +
 include/nucleus/thread.h                           |    7 +
 include/posix/Makefile.in                          |  170 +-
 include/posix/sys/Makefile.in                      |  105 +-
 include/psos+/Makefile.in                          |  105 +-
 include/rtai/Makefile.in                           |  105 +-
 include/rtdm/Makefile.in                           |  105 +-
 include/testing/sigtest_syscall.h                  |   16 +
 include/uitron/Makefile.in                         |  105 +-
 include/vrtx/Makefile.in                           |  105 +-
 include/vxworks/Makefile.in                        |  105 +-
 ksrc/drivers/testing/Config.in                     |    2 +
 ksrc/drivers/testing/Kconfig                       |   10 +-
 ksrc/drivers/testing/Makefile                      |    8 +-
 ksrc/drivers/testing/sigtest_module.c              |  137 +
 ksrc/nucleus/pod.c                                 |    5 +-
 ksrc/nucleus/shadow.c                              |  119 +-
 ksrc/nucleus/thread.c                              |    4 +
 ksrc/skins/native/cond.c                           |   51 +-
 ksrc/skins/native/syscall.c                        |   74 +-
 ksrc/skins/posix/syscall.c                         |   29 +-
 ksrc/skins/psos+/syscall.c                         |    1 +
 ksrc/skins/rtai/syscall.c                          |    1 +
 ksrc/skins/rtdm/syscall.c                          |    1 +
 ksrc/skins/uitron/syscall.c                        |    1 +
 ksrc/skins/vrtx/syscall.c                          |    1 +
 ksrc/skins/vxworks/syscall.c                       |    1 +
 scripts/Makefile.in                                |  104 +-
 src/Makefile.in                                    |  131 +-
 src/drvlib/Makefile.in                             |  131 +-
 src/drvlib/analogy/Makefile.in                     |  149 +-
 src/include/Makefile.in                            |   47 +-
 src/include/xeno_config.h.in                       |    3 -
 src/rtdk/Makefile.in                               |  137 +-
 src/skins/Makefile.am                              |    2 +-
 src/skins/Makefile.in                              |  133 +-
 src/skins/common/Makefile.am                       |   12 +
 src/skins/common/Makefile.in                       |  537 ++
 src/skins/common/bind.c                            |   99 +
 src/skins/common/current.c                         |   74 +
 src/skins/common/sem_heap.c                        |   88 +
 src/skins/common/sem_heap.h                        |   12 +
 src/skins/common/sigshadow.c                       |   75 +
 src/skins/native/Makefile.am                       |    2 +
 src/skins/native/Makefile.in                       |  206 +-
 src/skins/native/cond.c                            |   55 +-
 src/skins/native/init.c                            |    2 +-
 src/skins/posix/Makefile.am                        |    2 +
 src/skins/posix/Makefile.in                        |  194 +-
 src/skins/posix/cond.c                             |   44 +-
 src/skins/posix/init.c                             |    3 +-
 src/skins/psos+/Makefile.am                        |    2 +
 src/skins/psos+/Makefile.in                        |  158 +-
 src/skins/psos+/init.c                             |    3 +-
 src/skins/rtai/Makefile.am                         |    2 +
 src/skins/rtai/Makefile.in                         |  128 +-
 src/skins/rtai/init.c                              |    3 +-
 src/skins/rtdm/Makefile.am                         |    2 +
 src/skins/rtdm/Makefile.in                         |  128 +-
 src/skins/rtdm/init.c                              |    3 +-
 src/skins/uitron/Makefile.am                       |    2 +
 src/skins/uitron/Makefile.in                       |  146 +-
 src/skins/uitron/init.c                            |    3 +-
 src/skins/vrtx/Makefile.am                         |    2 +
 src/skins/vrtx/Makefile.in                         |  182 +-
 src/skins/vrtx/init.c                              |    2 +-
 src/skins/vxworks/Makefile.am                      |    2 +
 src/skins/vxworks/Makefile.in                      |  188 +-
 src/skins/vxworks/init.c                           |    2 +-
 src/testsuite/Makefile.am                          |    2 +-
 src/testsuite/Makefile.in                          |  133 +-
 src/testsuite/clocktest/Makefile.in                |  133 +-
 src/testsuite/cyclic/Makefile.in                   |  133 +-
 src/testsuite/irqbench/Makefile.in                 |  137 +-
 src/testsuite/klatency/Makefile.in                 |  133 +-
 src/testsuite/latency/Makefile.in                  |  133 +-
 src/testsuite/sigtest/Makefile.am                  |   29 +
 src/testsuite/sigtest/Makefile.in                  |  553 ++
 src/testsuite/sigtest/runinfo.in                   |    1 +
 src/testsuite/sigtest/sigtest.c                    |  315 ++
 src/testsuite/switchtest/Makefile.in               |  133 +-
 src/testsuite/unit/Makefile.in                     |  149 +-
 src/utils/Makefile.in                              |  131 +-
 src/utils/analogy/Makefile.in                      |  185 +-
 src/utils/can/Makefile.in                          |  185 +-
 src/utils/ps/Makefile.in                           |  129 +-
 137 files changed, 9130 insertions(+), 9084 deletions(-)
 create mode 100644 include/testing/sigtest_syscall.h
 create mode 100644 ksrc/drivers/testing/sigtest_module.c
 create mode 100644 src/skins/common/Makefile.am
 create mode 100644 src/skins/common/Makefile.in
 create mode 100644 src/skins/common/bind.c
 create mode 100644 src/skins/common/current.c
 create mode 100644 src/skins/common/sem_heap.c
 create mode 100644 src/skins/common/sem_heap.h
 create mode 100644 src/skins/common/sigshadow.c
 create mode 100644 src/testsuite/sigtest/Makefile.am
 create mode 100644 src/testsuite/sigtest/Makefile.in
 create mode 100644 src/testsuite/sigtest/runinfo.in
 create mode 100644 src/testsuite/sigtest/sigtest.c


-- 
					    Gilles.

