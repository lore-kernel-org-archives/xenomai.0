From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v5 0/4] Adressing y2038 test failures on ARM and BBB
Date: Fri,  7 May 2021 20:19:49 +0200
Message-Id: <20210507181953.1396348-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

The CI pipeline discovered an invalid instruction on some ARM boards,
especially the BBB (beaglebone black). Applying this patch series should
fix the current test failure on "next" branch.

As already discussed: There might be another problem in the ARM syscall
prologue/epilogue but it still makes sense to use the same macro for
calling the syscalls as libcobalt does.

I'm still asking myself why libcobalt has special macros for calling the
syscalls instead of using plain syscall() from *libc. Any input?

The difference to v4:
 - Fixed the error handling / error reporting bugs introduced by v4
   errno => ret migration gone wrong
 - Took care of some review comments from Jan

The main difference to v3:
 - Migration from syscall() (libc) to XENOAMAI_SYSCALLx()

Florian Bezdeka (4):
  cobalt/sem: y2038: Fixing the sem_timedwait syscall for 32 bit systems
  y2038: Adding sem_timedwait64
  y2038: Add tests for the sc_cobalt_sem_timedwait64 syscall
  y2038: lib/cobalt: Add support of sc_cobalt_sem_timedwait64

 configure.ac                           |   1 +
 include/cobalt/kernel/time.h           |  22 +++
 include/cobalt/uapi/syscall.h          |   1 +
 kernel/cobalt/Makefile                 |   1 +
 kernel/cobalt/posix/sem.c              |  60 ++++++---
 kernel/cobalt/posix/sem.h              |  13 +-
 kernel/cobalt/posix/syscall32.c        |  17 ++-
 kernel/cobalt/posix/syscall32.h        |   6 +-
 kernel/cobalt/time.c                   |  29 ++++
 lib/cobalt/semaphore.c                 |   5 +
 testsuite/smokey/Makefile.am           |   6 +-
 testsuite/smokey/y2038/Makefile.am     |  10 ++
 testsuite/smokey/y2038/syscall-tests.c | 177 +++++++++++++++++++++++++
 13 files changed, 317 insertions(+), 31 deletions(-)
 create mode 100644 include/cobalt/kernel/time.h
 create mode 100644 kernel/cobalt/time.c
 create mode 100644 testsuite/smokey/y2038/Makefile.am
 create mode 100644 testsuite/smokey/y2038/syscall-tests.c

-- 
2.31.1


