Message-ID: <538CDE00.9000707@xenomai.org>
Date: Mon, 02 Jun 2014 22:26:40 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [GIT PULL] various cleanups
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

The following changes since commit 0750a1e6877fba81269eb4b9f091190971ede117:

  cobalt: add missing include files (2014-06-02 08:47:23 +0200)

are available in the git repository at:

  git://git.xenomai.org/xenomai-gch.git for-forge

for you to fetch changes up to a10143cfa13bf25fd0c5ce84f163f88ab6f3358b:

  testsuite/switchtest: remove struct typedefs (2014-06-02 22:24:40 +0200)

----------------------------------------------------------------
Gilles Chanteperdrix (4):
      cobalt: remove condattr and mutexattr wrappers
      cobalt: sleep upon program termination to flush rt_printfs
      testsuite/mutex-torture: remove call to sched_yield which breaks timings
      testsuite/switchtest: remove struct typedefs

 include/cobalt/uapi/syscall.h       |   15 +-
 include/cobalt/uapi/thread.h        |   12 +-
 kernel/cobalt/posix/Makefile        |    2 -
 kernel/cobalt/posix/cond.c          |   28 +-
 kernel/cobalt/posix/cond.h          |   22 +-
 kernel/cobalt/posix/cond_attr.c     |  396 ----------------------------
 kernel/cobalt/posix/mutex.c         |   35 +--
 kernel/cobalt/posix/mutex.h         |   30 +--
 kernel/cobalt/posix/mutex_attr.c    |  554 ---------------------------------------
 kernel/cobalt/posix/syscall.c       |   14 -
 kernel/cobalt/trace/cobalt-posix.h  |    4 +-
 kernel/drivers/testing/switchtest.c |   74 +++---
 lib/alchemy/cond.c                  |    8 +-
 lib/alchemy/mutex.c                 |   10 +-
 lib/boilerplate/hash.c              |   22 +-
 lib/cobalt/cobalt.wrappers          |   14 -
 lib/cobalt/cond.c                   |   55 ++--
 lib/cobalt/init.c                   |    9 +-
 lib/cobalt/internal.h               |    4 +
 lib/cobalt/mutex.c                  |   77 ++----
 lib/copperplate/clockobj.c          |   10 +-
 lib/copperplate/heapobj-malloc.c    |   10 +-
 lib/copperplate/heapobj-pshared.c   |   22 +-
 lib/copperplate/registry.c          |   34 +--
 lib/copperplate/threadobj.c         |   18 +-
 lib/copperplate/timerobj.c          |   20 +-
 lib/copperplate/traceobj.c          |   20 +-
 lib/psos/pt.c                       |   10 +-
 lib/vxworks/memPartLib.c            |   10 +-
 lib/vxworks/semLib.c                |   10 +-
 lib/vxworks/taskLib.c               |   10 +-
 testsuite/unit/mutex-torture.c      |    1 -
 32 files changed, 235 insertions(+), 1325 deletions(-)
 delete mode 100644 kernel/cobalt/posix/cond_attr.c
 delete mode 100644 kernel/cobalt/posix/mutex_attr.c

-- 
                                                                Gilles.

