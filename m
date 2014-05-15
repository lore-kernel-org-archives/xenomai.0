Message-ID: <537507CB.5050806@xenomai.org>
Date: Thu, 15 May 2014 20:30:35 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Please pull changes for forge
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

The following changes since commit de9d8f3c99094485b9e324486b8a8bc6d1efff54:

  copperplate: tag high-level blocking services with warn_unused_result (2014-05-15 18:43:42 +0200)

are available in the git repository at:

  git://git.xenomai.org/xenomai-gch.git for-forge-fd-rework

for you to fetch changes up to d0510efb1bd21a4af76cdcb48713803f4b29ed8d:

  testsuite/latency: rebase on posix and timerfd (2014-05-15 20:21:32 +0200)

----------------------------------------------------------------
Gilles Chanteperdrix (17):
      cobalt/rtdm: base protocol devices on xnid
      cobalt/rtdm: base named devices on nucleus registry
      cobalt/rtdm: extract fd API
      drivers/testing: adapt timerbench after RTDM changes
      drivers/testing: adapt switchtest after RTDM changes
      drivers/testing: adapt rtdmtest after RTDM changes
      drivers/ipc: adapt XDDP after RTDM changes
      drivers/ipc: adapt IDDP after RTDM changes
      drivers/ipc: adapt BUFP after RTDM changes
      drivers/rtdm: rename
      analogy: adapt to RTDM API changes
      drivers/rtdm: update documentation
      drivers/rtdm: increment API and structs versions
      cobalt/mq: rebase on registry and common fd
      cobalt/posix: remove the now unused posix registry
      cobalt: add timerfd services
      testsuite/latency: rebase on posix and timerfd

 include/cobalt/kernel/ppd.h                           |    3 +-
 include/cobalt/kernel/rtdm/analogy/buffer.h           |   12 +-
 include/cobalt/kernel/rtdm/analogy/context.h          |    8 +-
 include/cobalt/kernel/rtdm/analogy/subdevice.h        |    2 +-
 include/cobalt/kernel/rtdm/driver.h                   |  395 ++-------
 include/cobalt/kernel/rtdm/fd.h                       |  186 ++++
 include/cobalt/kernel/rtdm/rtdm.h                     |   48 +-
 include/cobalt/sys/timerfd.h                          |   42 +
 include/cobalt/uapi/rtdm/syscall.h                    |   17 +-
 include/cobalt/uapi/syscall.h                         |    7 +-
 include/cobalt/uapi/time.h                            |    8 +
 include/rtdm/uapi/rtdm.h                              |    4 +-
 include/rtdm/uapi/testing.h                           |    3 +-
 kernel/cobalt/Kconfig                                 |   16 +-
 kernel/cobalt/init.c                                  |    3 +
 kernel/cobalt/posix/Makefile                          |    6 +-
 kernel/cobalt/posix/init.c                            |    4 +-
 kernel/cobalt/posix/internal.h                        |    5 +-
 kernel/cobalt/posix/mqueue.c                          |  965 +++++++++------------
 kernel/cobalt/posix/mqueue.h                          |   11 -
 kernel/cobalt/posix/process.h                         |    1 -
 kernel/cobalt/posix/registry.c                        |  446 ----------
 kernel/cobalt/posix/registry.h                        |  126 ---
 kernel/cobalt/posix/select.c                          |   47 +-
 kernel/cobalt/posix/syscall.c                         |    9 +-
 kernel/cobalt/posix/timer.c                           |   70 +-
 kernel/cobalt/posix/timer.h                           |    7 +
 kernel/cobalt/posix/timerfd.c                         |  296 +++++++
 kernel/cobalt/posix/timerfd.h                         |   14 +
 kernel/cobalt/rtdm/Makefile                           |    1 +
 kernel/cobalt/rtdm/core.c                             |  548 ++----------
 kernel/cobalt/rtdm/device.c                           |  260 ++----
 kernel/cobalt/rtdm/drvlib.c                           |   36 +-
 kernel/cobalt/rtdm/fd.c                               |  608 +++++++++++++
 kernel/cobalt/rtdm/internal.h                         |   12 +-
 kernel/cobalt/rtdm/proc.c                             |  187 ++--
 kernel/cobalt/rtdm/syscall.c                          |   68 +-
 kernel/cobalt/shadow.c                                |    3 +
 kernel/drivers/analogy/buffer.c                       |   46 +-
 kernel/drivers/analogy/command.c                      |    4 +-
 kernel/drivers/analogy/device.c                       |   10 +-
 kernel/drivers/analogy/instruction.c                  |   17 +-
 kernel/drivers/analogy/intel/8255.c                   |    3 +-
 kernel/drivers/analogy/intel/parport.c                |    4 +-
 .../drivers/analogy/national_instruments/mio_common.c |   16 +-
 kernel/drivers/analogy/rtdm_interface.c               |   51 +-
 kernel/drivers/analogy/subdevice.c                    |   23 +-
 kernel/drivers/analogy/testing/fake.c                 |   12 +-
 kernel/drivers/analogy/testing/loop.c                 |    4 +-
 kernel/drivers/ipc/bufp.c                             |  126 +--
 kernel/drivers/ipc/iddp.c                             |  129 +--
 kernel/drivers/ipc/internal.h                         |   38 +-
 kernel/drivers/ipc/rtipc.c                            |   81 +-
 kernel/drivers/ipc/xddp.c                             |  129 +--
 kernel/drivers/testing/rtdmtest.c                     |   56 +-
 kernel/drivers/testing/switchtest.c                   |  111 +--
 kernel/drivers/testing/timerbench.c                   |   89 +-
 lib/cobalt/Makefile.am                                |    1 +
 lib/cobalt/cobalt.wrappers                            |    3 +
 lib/cobalt/init.c                                     |    7 +-
 lib/cobalt/mq.c                                       |   10 +-
 lib/cobalt/rtdm.c                                     |  494 +++++------
 lib/cobalt/timerfd.c                                  |   73 ++
 testsuite/latency/Makefile.am                         |    6 +-
 testsuite/latency/latency.c                           |  285 +++---
 testsuite/regression/posix/Makefile.am                |    5 +-
 testsuite/regression/posix/timerfd.c                  |  294 +++++++
 testsuite/unit/rtdm.c                                 |   11 -
 68 files changed, 3262 insertions(+), 3360 deletions(-)
 create mode 100644 include/cobalt/kernel/rtdm/fd.h
 create mode 100644 include/cobalt/sys/timerfd.h
 delete mode 100644 kernel/cobalt/posix/registry.c
 delete mode 100644 kernel/cobalt/posix/registry.h
 create mode 100644 kernel/cobalt/posix/timerfd.c
 create mode 100644 kernel/cobalt/posix/timerfd.h
 create mode 100644 kernel/cobalt/rtdm/fd.c
 create mode 100644 lib/cobalt/timerfd.c
 create mode 100644 testsuite/regression/posix/timerfd.c

-- 
                                                                Gilles.

