From: Philippe  Gerum <rpm@xenomai.org>
Subject: [Dovetail PATCH 0/5] More clock and IRQ abstraction
Date: Sat, 27 Mar 2021 11:35:19 +0100
Message-Id: <20210327103524.2305814-1-rpm@xenomai.org>
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

Jan Kiszka (1):
  cobalt/intr: dovetail: Don't do anything in xnintr_enable/disable

Philippe Gerum (4):
  cobalt/syscall: dovetail: do not expose clock frequency to user
  cobalt/sched: dovetail: disable separate per-IRQ statistics
  cobalt/intr: pipeline: abstract interrupt system inits
  cobalt/intr: dovetail: implement interrupt management, handling

 include/cobalt/kernel/dovetail/pipeline/irq.h |  24 ++++
 .../kernel/dovetail/pipeline/pipeline.h       |   6 +
 include/cobalt/kernel/intr.h                  |   7 +-
 include/cobalt/kernel/ipipe/pipeline/irq.h    |  14 ++
 .../cobalt/kernel/ipipe/pipeline/pipeline.h   |   6 +
 kernel/cobalt/Kconfig                         |   4 +-
 kernel/cobalt/dovetail/Makefile               |   2 +-
 kernel/cobalt/dovetail/intr.c                 | 129 ++++++++++++++++++
 kernel/cobalt/posix/syscall.c                 |   2 +-
 9 files changed, 185 insertions(+), 9 deletions(-)
 create mode 100644 include/cobalt/kernel/dovetail/pipeline/irq.h
 create mode 100644 include/cobalt/kernel/ipipe/pipeline/irq.h
 create mode 100644 kernel/cobalt/dovetail/intr.c

-- 
2.29.2


