Resent-To: xenomai-core <xenomai@xenomai.org>
Resent-Message-Id: <48F7649D.1030700@domain.hid>
Message-Id: <20081016154620.320953568@domain.hid>
Date: Thu, 16 Oct 2008 17:46:20 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
Subject: [Xenomai-core] [PATCH 00/12] Generic fast xnsynch support & more
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Here comes a significantly reworked patch series to improve fast mutex
support of Xenomai.

This approach now introduces a generic fast xnsynch core and converts
the existing POSIX implementation over. It also comes with a second
user, the Native skin. Additionally, it improves xeno_get_current via
a TLS variable and addresses the issue that threads in secondary mode
acquiring an uncontended mutex need to be migrated first.

At this chance, the TLS optimization is also applied on self-lookups of
task handles (Native, VRTX and VxWorks). And I included my
SMP-by-default patch for user libs which is highly recommended to reduce
the risk of accidental code breakage on SMP with the new mutex code.

Jan

---
 include/asm-generic/atomic.h               |   24 -
 xenomai/README.INSTALL                     |    2 
 xenomai/configure.in                       |   45 +-
 xenomai/include/asm-arm/atomic.h           |    3 
 xenomai/include/asm-blackfin/atomic.h      |    2 
 xenomai/include/asm-generic/Makefile.am    |    2 
 xenomai/include/asm-generic/Makefile.in    |    2 
 xenomai/include/asm-generic/bits/bind.h    |   82 +++-
 xenomai/include/asm-generic/bits/current.h |   36 +
 xenomai/include/asm-generic/features.h     |   24 -
 xenomai/include/asm-ia64/atomic.h          |    2 
 xenomai/include/asm-powerpc/atomic.h       |    2 
 xenomai/include/asm-x86/atomic.h           |    2 
 xenomai/include/native/mutex.h             |   23 -
 xenomai/include/native/syscall.h           |    1 
 xenomai/include/nucleus/registry.h         |    1 
 xenomai/include/nucleus/shadow.h           |    3 
 xenomai/include/nucleus/synch.h            |   70 +++
 xenomai/include/nucleus/thread.h           |   29 +
 xenomai/include/nucleus/types.h            |   13 
 xenomai/include/psos+/syscall.h            |    8 
 xenomai/include/rtdm/rtdm_driver.h         |    2 
 xenomai/include/vrtx/syscall.h             |    1 
 xenomai/include/vxworks/syscall.h          |    1 
 xenomai/ksrc/arch/arm/Kconfig              |    2 
 xenomai/ksrc/arch/powerpc/Kconfig          |    2 
 xenomai/ksrc/arch/x86/Kconfig              |    2 
 xenomai/ksrc/drivers/testing/switchtest.c  |    2 
 xenomai/ksrc/nucleus/pipe.c                |    2 
 xenomai/ksrc/nucleus/registry.c            |    4 
 xenomai/ksrc/nucleus/select.c              |    2 
 xenomai/ksrc/nucleus/shadow.c              |   38 +-
 xenomai/ksrc/nucleus/synch.c               |  534 ++++++++++++++++++++---------
 xenomai/ksrc/nucleus/thread.c              |    2 
 xenomai/ksrc/skins/native/Kconfig          |    1 
 xenomai/ksrc/skins/native/alarm.c          |    2 
 xenomai/ksrc/skins/native/buffer.c         |    4 
 xenomai/ksrc/skins/native/cond.c           |   18 
 xenomai/ksrc/skins/native/event.c          |    2 
 xenomai/ksrc/skins/native/heap.c           |    2 
 xenomai/ksrc/skins/native/intr.c           |    2 
 xenomai/ksrc/skins/native/mutex.c          |  327 ++++++++++-------
 xenomai/ksrc/skins/native/queue.c          |    2 
 xenomai/ksrc/skins/native/sem.c            |    2 
 xenomai/ksrc/skins/native/syscall.c        |  132 +++++--
 xenomai/ksrc/skins/native/task.c           |   28 -
 xenomai/ksrc/skins/posix/Kconfig           |    1 
 xenomai/ksrc/skins/posix/cb_lock.h         |   21 -
 xenomai/ksrc/skins/posix/cond.c            |   34 -
 xenomai/ksrc/skins/posix/intr.c            |    2 
 xenomai/ksrc/skins/posix/mq.c              |    4 
 xenomai/ksrc/skins/posix/mutex.c           |  121 ++++--
 xenomai/ksrc/skins/posix/mutex.h           |  136 +------
 xenomai/ksrc/skins/posix/sem.c             |    2 
 xenomai/ksrc/skins/posix/syscall.c         |   61 +--
 xenomai/ksrc/skins/posix/thread.c          |   14 
 xenomai/ksrc/skins/psos+/Kconfig           |    2 
 xenomai/ksrc/skins/psos+/event.c           |    2 
 xenomai/ksrc/skins/psos+/queue.c           |    2 
 xenomai/ksrc/skins/psos+/rn.c              |    2 
 xenomai/ksrc/skins/psos+/sem.c             |    2 
 xenomai/ksrc/skins/psos+/syscall.c         |   53 +-
 xenomai/ksrc/skins/psos+/task.c            |   20 -
 xenomai/ksrc/skins/rtai/Kconfig            |    1 
 xenomai/ksrc/skins/rtai/sem.c              |   12 
 xenomai/ksrc/skins/rtai/task.c             |   10 
 xenomai/ksrc/skins/rtdm/drvlib.c           |   27 -
 xenomai/ksrc/skins/uitron/Kconfig          |    1 
 xenomai/ksrc/skins/uitron/flag.c           |    2 
 xenomai/ksrc/skins/uitron/mbx.c            |    3 
 xenomai/ksrc/skins/uitron/sem.c            |    3 
 xenomai/ksrc/skins/uitron/syscall.c        |    8 
 xenomai/ksrc/skins/uitron/task.c           |   11 
 xenomai/ksrc/skins/vrtx/Kconfig            |    2 
 xenomai/ksrc/skins/vrtx/event.c            |    2 
 xenomai/ksrc/skins/vrtx/mb.c               |    2 
 xenomai/ksrc/skins/vrtx/mx.c               |    7 
 xenomai/ksrc/skins/vrtx/queue.c            |    2 
 xenomai/ksrc/skins/vrtx/sem.c              |    2 
 xenomai/ksrc/skins/vrtx/syscall.c          |    4 
 xenomai/ksrc/skins/vrtx/task.c             |   17 
 xenomai/ksrc/skins/vxworks/Kconfig         |    2 
 xenomai/ksrc/skins/vxworks/module.c        |    2 
 xenomai/ksrc/skins/vxworks/msgQLib.c       |    2 
 xenomai/ksrc/skins/vxworks/semLib.c        |    8 
 xenomai/ksrc/skins/vxworks/syscall.c       |   37 +-
 xenomai/ksrc/skins/vxworks/taskLib.c       |   12 
 xenomai/src/skins/native/cond.c            |   30 +
 xenomai/src/skins/native/init.c            |    8 
 xenomai/src/skins/native/mutex.c           |  105 +++++
 xenomai/src/skins/native/task.c            |   44 ++
 xenomai/src/skins/posix/mutex.c            |  192 +++++-----
 xenomai/src/skins/posix/thread.c           |   33 +
 xenomai/src/skins/psos+/task.c             |   34 +
 xenomai/src/skins/uitron/task.c            |   29 +
 xenomai/src/skins/vrtx/init.c              |   19 -
 xenomai/src/skins/vrtx/task.c              |   37 +-
 xenomai/src/skins/vxworks/init.c           |    8 
 xenomai/src/skins/vxworks/taskLib.c        |   29 +
 99 files changed, 1809 insertions(+), 909 deletions(-)

--
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux


