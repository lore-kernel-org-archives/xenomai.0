From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [RFC PATCH v2 0/4] Pattern for implementing y2038 syscalls
Date: Mon,  8 Mar 2021 18:02:02 +0100
Message-Id: <20210308170206.313181-1-florian.bezdeka@siemens.com>
In-Reply-To: <87h7lqzzzw.fsf@xenomai.org>
References: <87h7lqzzzw.fsf@xenomai.org>
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
To: xenomai@xenomai.org, jan.kiszka@siemens.com, rpm@xenomai.org, chensong@kylinos.cn

Changes in v2:
  - Added a smokey plugin named y2038 for running Y2038 related tests
    (Should be extended with all related tests)
  - Review implementations (covered by tests now as well)
  - Drop support for kernel 4.4
  - Added the libcobalt part

Maintainers: Comments about naming / style welcome. That will speed up
the process when we just have to follow the right pattern.

Florian Bezdeka (4):
  y2038: Fixing the sem_timedwait syscall for 32 bit systems
  y2038: Adding sem_timedwait_time64
  y2038: Add tests for the sc_cobalt_sem_timedwait_time64 syscall
  y2038: lib/cobalt: Add support of sc_cobalt_sem_timedwait_time64

 configure.ac                                  |   1 +
 include/cobalt/uapi/syscall.h                 |   1 +
 .../include/asm-generic/xenomai/syscall.h     |  23 +++
 kernel/cobalt/posix/sem.c                     |  53 +++---
 kernel/cobalt/posix/sem.h                     |  10 +-
 kernel/cobalt/posix/syscall32.c               |  23 ++-
 kernel/cobalt/posix/syscall32.h               |   6 +-
 lib/cobalt/semaphore.c                        |   5 +
 testsuite/smokey/Makefile.am                  |   6 +-
 testsuite/smokey/y2038/Makefile.am            |  10 ++
 testsuite/smokey/y2038/syscall-tests.c        | 170 ++++++++++++++++++
 11 files changed, 277 insertions(+), 31 deletions(-)
 create mode 100644 testsuite/smokey/y2038/Makefile.am
 create mode 100644 testsuite/smokey/y2038/syscall-tests.c

-- 
2.29.2


