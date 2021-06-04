From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 00/12] Dovetail integration, moving forward
Date: Fri,  4 Jun 2021 12:05:10 +0200
Message-Id: <cover.1622801122.git.jan.kiszka@siemens.com>
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

This pulls the first half of the last half, up to the RT-NRT signaling
patches that need more work (Hongzhan is on that).

Jan


CC: Hongzhan Chen <hongzhan.chen@intel.com>
CC: Philippe Gerum <rpm@xenomai.org>

Hongzhan Chen (1):
  cobalt/sched: dovetail: fix missed switching to OOB opportunities

Jan Kiszka (1):
  cobalt/trace: Avoid clash with kernel trace definitions

Philippe Gerum (10):
  cobalt/kevents: dovetail: provide thread info initializer
  cobalt/thread: pipeline: refactor thread control block
  cobalt/build: pipeline: enable Dovetail support if detected
  cobalt/trace: dovetail: enable basic tracepoints
  cobalt/trace: add tracing call to notify of a latency peak
  cobalt/kevents: dovetail: unregister thread resuming from ptrace stop
  cobalt/clock: dovetail: use refined monotonic source
  cobalt/clock: pipeline: abstract handling of CLOCK_REALTIME
  rtdm/fd: move inband work description off the stack
  drivers/udd: move inband work description off the stack

 include/cobalt/kernel/clock.h                 | 12 ++-
 .../cobalt/kernel/dovetail/pipeline/clock.h   | 21 +++-
 .../cobalt/kernel/dovetail/pipeline/trace.h   | 56 +++++------
 include/cobalt/kernel/ipipe/pipeline/clock.h  |  5 +
 include/cobalt/kernel/ipipe/pipeline/trace.h  |  5 +
 include/cobalt/kernel/thread.h                |  6 +-
 include/cobalt/trace.h                        |  2 +
 include/cobalt/uapi/kernel/trace.h            |  1 +
 include/mercury/boilerplate/trace.h           |  4 +
 .../arm/ipipe/include/asm/xenomai/thread.h    |  8 +-
 .../arm64/ipipe/include/asm/xenomai/thread.h  |  8 +-
 .../ipipe/include/asm/xenomai/thread.h        |  8 +-
 .../x86/dovetail/include/asm/xenomai/thread.h |  8 +-
 .../x86/ipipe/include/asm/xenomai/thread.h    |  8 +-
 kernel/cobalt/clock.c                         | 66 +++++++------
 kernel/cobalt/dovetail/kevents.c              | 41 ++++++--
 kernel/cobalt/dovetail/sched.c                | 17 +++-
 .../asm-generic/xenomai/dovetail/thread.h     | 24 +++++
 .../asm-generic/xenomai/{ => ipipe}/thread.h  |  9 +-
 kernel/cobalt/ipipe/clock.c                   | 15 +++
 kernel/cobalt/ipipe/tick.c                    |  3 -
 kernel/cobalt/posix/clock.c                   |  9 +-
 kernel/cobalt/posix/syscall.c                 |  6 ++
 kernel/cobalt/rtdm/fd.c                       | 22 ++---
 kernel/cobalt/trace/cobalt-core.h             | 98 +++++++++++++++++++
 kernel/cobalt/trace/cobalt-posix.h            | 12 +--
 kernel/drivers/testing/timerbench.c           |  2 +-
 kernel/drivers/udd/udd.c                      | 25 +++--
 lib/cobalt/trace.c                            |  5 +
 scripts/Kconfig.frag                          |  1 +
 testsuite/latency/latency.c                   |  2 +-
 31 files changed, 375 insertions(+), 134 deletions(-)
 create mode 100644 kernel/cobalt/include/asm-generic/xenomai/dovetail/thread.h
 rename kernel/cobalt/include/asm-generic/xenomai/{ => ipipe}/thread.h (87%)

-- 
2.26.2


