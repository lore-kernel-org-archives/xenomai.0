From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH Dovetail 00/13] Keep on abstracting the pipeline interface
Date: Sat,  2 Jan 2021 10:33:40 +0100
Message-Id: <20210102093353.3195090-1-rpm@xenomai.org>
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

Most importantly: Happy new year, and best wishes.

Sidenote: this is the next series of patches (out of 70+) which adds
an abstraction layer to the Cobalt core, so that we can choose to
interface it to the legacy I-pipe or Dovetail at build time. This is
on top of the -next branch as usual.

Philippe Gerum (13):
  cobalt/thread: pipeline: abstract threadinfo accessor
  cobalt/apc: pipeline: abstract interface for deferred routine calls
  cobalt/trace: pipeline: abstract trace calls
  cobalt/lock: pipeline: abstract hard lock API
  cobalt/kernel: pipeline: abstract execution stage predicates
  cobalt/sched, clock: pipeline: abstract IPI management
  cobalt/clock: pipeline: make HOSTRT depend on IPIPE
  cobalt/build: pipeline: select IPIPE layer only if present
  cobalt/clock: pipeline: abstract clock, timer access services
  cobalt/wrappers: pipeline: abstract pipeline-related bits
  cobalt/timer: pipeline: abstract tick management
  cobalt/debug: pipeline: abstract panic prep call
  cobalt/syscall: pipeline: abstract syscall entry points

 include/cobalt/kernel/apc.h                   |  51 +---
 include/cobalt/kernel/assert.h                |   5 +-
 include/cobalt/kernel/clock.h                 |   8 +-
 include/cobalt/kernel/intr.h                  |   1 -
 include/cobalt/kernel/ipipe/pipeline/clock.h  |  32 ++
 .../cobalt/kernel/ipipe/pipeline/kevents.h    |   3 +
 include/cobalt/kernel/ipipe/pipeline/lock.h   |  21 ++
 .../cobalt/kernel/ipipe/pipeline/pipeline.h   |  80 +++++
 include/cobalt/kernel/ipipe/pipeline/thread.h |  26 ++
 include/cobalt/kernel/ipipe/pipeline/tick.h   |  12 +
 include/cobalt/kernel/ipipe/pipeline/trace.h  | 111 +++++++
 .../cobalt/kernel/ipipe/pipeline/wrappers.h   |  25 ++
 include/cobalt/kernel/lock.h                  |  44 +--
 include/cobalt/kernel/rtdm/driver.h           |  11 +-
 include/cobalt/kernel/sched.h                 |   2 -
 include/cobalt/kernel/stat.h                  |   3 -
 include/cobalt/kernel/thread.h                |   5 +-
 include/cobalt/kernel/timer.h                 |   4 -
 include/cobalt/kernel/trace.h                 | 101 +------
 include/cobalt/kernel/vdso.h                  |  18 +-
 kernel/cobalt/Kconfig                         |   4 -
 kernel/cobalt/Makefile                        |   3 +-
 kernel/cobalt/clock.c                         |   7 +-
 kernel/cobalt/debug.c                         |   2 +-
 .../include/asm-generic/xenomai/wrappers.h    |   4 -
 .../cobalt/include/linux/xenomai/wrappers.h   |  23 +-
 kernel/cobalt/init.c                          |   5 +-
 kernel/cobalt/ipipe/Makefile                  |   2 +-
 kernel/cobalt/{ => ipipe}/apc.c               |  42 +++
 kernel/cobalt/ipipe/init.c                    |   2 +
 kernel/cobalt/ipipe/intr.c                    |   2 +-
 kernel/cobalt/ipipe/kevents.c                 |  20 +-
 kernel/cobalt/ipipe/syscall.c                 |  29 ++
 kernel/cobalt/ipipe/tick.c                    | 278 ++++++++++++++++++
 kernel/cobalt/posix/clock.c                   |   4 +-
 kernel/cobalt/posix/corectl.c                 |   8 +-
 kernel/cobalt/posix/process.c                 |   6 +-
 kernel/cobalt/posix/process.h                 |   8 +-
 kernel/cobalt/posix/syscall.c                 |  32 +-
 kernel/cobalt/posix/syscall.h                 |   7 +
 kernel/cobalt/registry.c                      |   2 +-
 kernel/cobalt/rtdm/drvlib.c                   |   2 +-
 kernel/cobalt/rtdm/fd.c                       |  14 +-
 kernel/cobalt/sched.c                         |  16 +-
 kernel/cobalt/thread.c                        |   6 +-
 kernel/cobalt/timer.c                         | 272 +----------------
 kernel/drivers/testing/timerbench.c           |  12 +-
 scripts/Kconfig.frag                          |   8 +-
 48 files changed, 776 insertions(+), 607 deletions(-)
 create mode 100644 include/cobalt/kernel/ipipe/pipeline/clock.h
 create mode 100644 include/cobalt/kernel/ipipe/pipeline/lock.h
 create mode 100644 include/cobalt/kernel/ipipe/pipeline/pipeline.h
 create mode 100644 include/cobalt/kernel/ipipe/pipeline/thread.h
 create mode 100644 include/cobalt/kernel/ipipe/pipeline/tick.h
 create mode 100644 include/cobalt/kernel/ipipe/pipeline/trace.h
 create mode 100644 include/cobalt/kernel/ipipe/pipeline/wrappers.h
 rename kernel/cobalt/{ => ipipe}/apc.c (80%)
 create mode 100644 kernel/cobalt/ipipe/syscall.c
 create mode 100644 kernel/cobalt/ipipe/tick.c

-- 
2.26.2


