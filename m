From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 0/8] y2038 groundwork
Date: Sat, 27 Mar 2021 10:54:09 +0100
Message-Id: <20210327095417.2289913-1-rpm@xenomai.org>
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

From: Philippe Gerum <rpm@xenomai.org>

This patch series prepares the tree for the upcoming y2038 work,
converting obsolete/ambiguous time specification types to the proper
ones introduced upstream by the v5.x kernel series.

Florian Bezdeka (3):
  cobalt/mutex: Bring back ia32 support for mutex_timedwait
  cobalt/mqueue: Bring back ia32 support for mq_timed{send,receive}
  cobalt/sem: y2038: Fixing the sem_timedwait syscall for 32 bit systems

Philippe Gerum (5):
  cobalt/kernel: y2038: convert struct timespec to timespec64
  lib: y2038: convert to internal timespec type
  cobalt/kernel: y2038: convert struct itimerspec to itimerspec64
  cobalt/kernel: y2038: convert struct timex to __kernel_timex
  cobalt/kernel: y2038: switch to new legacy type names

 include/cobalt/kernel/clock.h                 |  13 ++-
 include/cobalt/kernel/compat.h                |  34 +++---
 .../cobalt/kernel/dovetail/pipeline/clock.h   |   4 +-
 include/cobalt/kernel/ipipe/pipeline/clock.h  |   4 +-
 include/cobalt/kernel/rtdm/fd.h               |   2 +-
 include/cobalt/uapi/kernel/types.h            |  53 +++++++++
 include/cobalt/uapi/sched.h                   |  12 +-
 .../include/asm-generic/xenomai/syscall.h     | 103 ++++++++++++++++++
 .../include/asm-generic/xenomai/wrappers.h    |  10 ++
 kernel/cobalt/ipipe/clock.c                   |   2 +-
 kernel/cobalt/posix/clock.c                   |  44 ++++----
 kernel/cobalt/posix/clock.h                   |  43 +++++---
 kernel/cobalt/posix/compat.c                  |  86 ++++++++++-----
 kernel/cobalt/posix/cond.c                    |  11 +-
 kernel/cobalt/posix/cond.h                    |   4 +-
 kernel/cobalt/posix/event.c                   |   8 +-
 kernel/cobalt/posix/event.h                   |   4 +-
 kernel/cobalt/posix/extension.h               |   4 +-
 kernel/cobalt/posix/io.c                      |   6 +-
 kernel/cobalt/posix/io.h                      |   2 +-
 kernel/cobalt/posix/monitor.c                 |   8 +-
 kernel/cobalt/posix/monitor.h                 |   4 +-
 kernel/cobalt/posix/mqueue.c                  |  21 ++--
 kernel/cobalt/posix/mqueue.h                  |   8 +-
 kernel/cobalt/posix/mutex.c                   |  13 +--
 kernel/cobalt/posix/mutex.h                   |   6 +-
 kernel/cobalt/posix/sched.c                   |  16 +--
 kernel/cobalt/posix/sem.c                     |  40 +++----
 kernel/cobalt/posix/sem.h                     |   6 +-
 kernel/cobalt/posix/signal.c                  |   6 +-
 kernel/cobalt/posix/signal.h                  |   4 +-
 kernel/cobalt/posix/syscall32.c               |  86 ++++++++-------
 kernel/cobalt/posix/syscall32.h               |  44 ++++----
 kernel/cobalt/posix/thread.c                  |   6 +-
 kernel/cobalt/posix/timer.c                   |  30 ++---
 kernel/cobalt/posix/timer.h                   |  16 +--
 kernel/cobalt/posix/timerfd.c                 |  22 ++--
 kernel/cobalt/posix/timerfd.h                 |  12 +-
 kernel/cobalt/rtdm/fd.c                       |   4 +-
 kernel/cobalt/trace/cobalt-posix.h            |  34 +++---
 kernel/drivers/ipc/rtipc.c                    |   4 +-
 lib/alchemy/task.c                            |   9 +-
 lib/copperplate/threadobj.c                   |   9 +-
 lib/psos/task.c                               |   9 +-
 lib/vxworks/kernLib.c                         |   6 +-
 lib/vxworks/taskLib.c                         |   6 +-
 46 files changed, 552 insertions(+), 326 deletions(-)

-- 
2.29.2


