From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v2 0/9] y2038 groundwork and first steps
Date: Wed,  5 May 2021 18:52:59 +0200
Message-Id: <cover.1620233588.git.jan.kiszka@siemens.com>
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

Picking up from Philippe's queue:

This patch series prepares the tree for the upcoming y2038 work,
converting obsolete/ambiguous time specification types to the proper
ones introduced upstream by the v5.x kernel series.

In v2, feedback on the first round has been addressed, primarily
regarding folding fixing into the patches that need them.

In addition, this includes 3 patches from Florian that add
sem_timedwait64 system call and a test suite for it.

Jan


CC: Florian Bezdeka <florian.bezdeka@siemens.com>
CC: Philippe Gerum <rpm@xenomai.org>

Florian Bezdeka (4):
  cobalt/sem: y2038: Fixing the sem_timedwait syscall for 32 bit systems
  y2038: Adding sem_timedwait64
  y2038: Add tests for the sc_cobalt_sem_timedwait64 syscall
  y2038: lib/cobalt: Add support of sc_cobalt_sem_timedwait64

Philippe Gerum (5):
  cobalt/kernel: y2038: convert struct timespec to timespec64
  lib: y2038: convert to internal timespec type
  cobalt/kernel: y2038: convert struct itimerspec to itimerspec64
  cobalt/kernel: y2038: convert struct timex to __kernel_timex
  cobalt/kernel: y2038: switch to new legacy type names

 configure.ac                                  |   1 +
 include/cobalt/kernel/clock.h                 |  13 +-
 include/cobalt/kernel/compat.h                |  34 ++--
 .../cobalt/kernel/dovetail/pipeline/clock.h   |   4 +-
 include/cobalt/kernel/ipipe/pipeline/clock.h  |   4 +-
 include/cobalt/kernel/rtdm/fd.h               |   2 +-
 include/cobalt/kernel/time.h                  |  22 +++
 include/cobalt/uapi/kernel/types.h            |  53 ++++++
 include/cobalt/uapi/sched.h                   |  12 +-
 include/cobalt/uapi/syscall.h                 |   1 +
 kernel/cobalt/Makefile                        |   1 +
 .../include/asm-generic/xenomai/syscall.h     | 103 ++++++++++
 .../include/asm-generic/xenomai/wrappers.h    |   7 +
 kernel/cobalt/ipipe/clock.c                   |   2 +-
 kernel/cobalt/posix/clock.c                   |  44 ++---
 kernel/cobalt/posix/clock.h                   |  43 +++--
 kernel/cobalt/posix/compat.c                  |  86 ++++++---
 kernel/cobalt/posix/cond.c                    |  11 +-
 kernel/cobalt/posix/cond.h                    |   4 +-
 kernel/cobalt/posix/event.c                   |   8 +-
 kernel/cobalt/posix/event.h                   |   4 +-
 kernel/cobalt/posix/extension.h               |   4 +-
 kernel/cobalt/posix/io.c                      |   6 +-
 kernel/cobalt/posix/io.h                      |   2 +-
 kernel/cobalt/posix/monitor.c                 |   8 +-
 kernel/cobalt/posix/monitor.h                 |   4 +-
 kernel/cobalt/posix/mqueue.c                  |  21 +--
 kernel/cobalt/posix/mqueue.h                  |   8 +-
 kernel/cobalt/posix/mutex.c                   |  13 +-
 kernel/cobalt/posix/mutex.h                   |   6 +-
 kernel/cobalt/posix/sched.c                   |  16 +-
 kernel/cobalt/posix/sem.c                     |  60 +++---
 kernel/cobalt/posix/sem.h                     |  13 +-
 kernel/cobalt/posix/signal.c                  |   6 +-
 kernel/cobalt/posix/signal.h                  |   4 +-
 kernel/cobalt/posix/syscall32.c               |  93 +++++----
 kernel/cobalt/posix/syscall32.h               |  48 ++---
 kernel/cobalt/posix/thread.c                  |   6 +-
 kernel/cobalt/posix/timer.c                   |  30 +--
 kernel/cobalt/posix/timer.h                   |  16 +-
 kernel/cobalt/posix/timerfd.c                 |  22 +--
 kernel/cobalt/posix/timerfd.h                 |  12 +-
 kernel/cobalt/rtdm/fd.c                       |   4 +-
 kernel/cobalt/time.c                          |  29 +++
 kernel/cobalt/trace/cobalt-posix.h            |  34 ++--
 kernel/drivers/ipc/rtipc.c                    |   4 +-
 lib/alchemy/task.c                            |   9 +-
 lib/cobalt/semaphore.c                        |   5 +
 lib/copperplate/threadobj.c                   |   9 +-
 lib/psos/task.c                               |   9 +-
 lib/vxworks/kernLib.c                         |   6 +-
 lib/vxworks/taskLib.c                         |   6 +-
 testsuite/smokey/Makefile.am                  |   6 +-
 testsuite/smokey/y2038/Makefile.am            |   9 +
 testsuite/smokey/y2038/syscall-tests.c        | 176 ++++++++++++++++++
 55 files changed, 835 insertions(+), 328 deletions(-)
 create mode 100644 include/cobalt/kernel/time.h
 create mode 100644 kernel/cobalt/time.c
 create mode 100644 testsuite/smokey/y2038/Makefile.am
 create mode 100644 testsuite/smokey/y2038/syscall-tests.c

-- 
2.26.2


