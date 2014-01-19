Message-ID: <52DC4E56.1000505@xenomai.org>
Date: Sun, 19 Jan 2014 23:14:46 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Pull request
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

The following changes since commit bf3a1b1df9f7df874e36faf60b6e5311ecfeb913:

  doc: regenerate documentation (2014-01-17 15:38:12 +0100)

are available in the git repository at:

  git://git.xenomai.org/xenomai-gch.git for-forge

for you to fetch changes up to ae62edaa5cc9372d36f298779b378e4852463e4d:

  cobalt/nsem: rebase on xnid (2014-01-19 19:17:07 +0100)

----------------------------------------------------------------
Gilles Chanteperdrix (10):
      cobalt/arm: fix compilation warning
      testsuite: add select+mq test
      cobalt: wrap the glibc function pthread_setname_np
      cobalt/timer: return overruns on 64 bits
      switchtest: avoid printf stack overflow
      cobalt/timer: make timer_id per-process instead of global
      cobalt/arm: fix VFP related lockup
      cobalt: replace ppd mechanism
      cobalt: add xnid, rbtree based per-process ids table
      cobalt/nsem: rebase on xnid

 include/cobalt/kernel/ppd.h               |   45 ++--
 include/cobalt/kernel/shadow.h            |   22 +-
 include/cobalt/kernel/timer.h             |    2 +-
 include/cobalt/kernel/tree.h              |   74 +++++++
 include/cobalt/pthread.h                  |    2 +
 kernel/cobalt/Makefile                    |    3 +-
 kernel/cobalt/arch/arm/switch.S           |   16 ++
 kernel/cobalt/arch/arm/thread.c           |   32 ++-
 kernel/cobalt/include/ipipe/thread_info.h |    6 +-
 kernel/cobalt/posix/init.c                |    9 -
 kernel/cobalt/posix/internal.h            |   25 +--
 kernel/cobalt/posix/nsem.c                |  105 +++------
 kernel/cobalt/posix/process.h             |   10 +-
 kernel/cobalt/posix/sem.h                 |    4 -
 kernel/cobalt/posix/syscall.c             |   22 +-
 kernel/cobalt/posix/timer.c               |  209 +++++++++---------
 kernel/cobalt/posix/timer.h               |   19 +-
 kernel/cobalt/rtdm/core.c                 |    8 +-
 kernel/cobalt/rtdm/internal.h             |    2 -
 kernel/cobalt/rtdm/syscall.c              |    9 +-
 kernel/cobalt/shadow.c                    |  365 ++++++++++++++------------------
 kernel/cobalt/timer.c                     |    4 +-
 kernel/cobalt/tree.c                      |   58 +++++
 lib/cobalt/cobalt.wrappers                |    1 +
 lib/cobalt/thread.c                       |    6 +
 testsuite/regression/posix/Makefile.am    |    4 +-
 testsuite/regression/posix/mq_select.c    |  118 +++++++++++
 testsuite/switchtest/switchtest.c         |    9 +-
 28 files changed, 675 insertions(+), 514 deletions(-)
 create mode 100644 include/cobalt/kernel/tree.h
 create mode 100644 kernel/cobalt/tree.c
 create mode 100644 testsuite/regression/posix/mq_select.c

-- 
                                                                Gilles.

