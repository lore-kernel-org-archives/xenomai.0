From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [y2038][PATCH v3 0/4] Pattern for implementing y2038 syscalls
Date: Wed, 10 Mar 2021 14:09:31 +0100
Message-Id: <20210310130935.255197-1-florian.bezdeka@siemens.com>
In-Reply-To: <20210308170206.313181-5-florian.bezdeka@siemens.com>
References: <20210308170206.313181-5-florian.bezdeka@siemens.com>
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

This series was tested against the following branches:
  - upstream: wip/dovetail
  - philippe-private: for-upstream/dovetail

Song can take this series as template and continue to bring in more
y2038 syscalls, while I will go and fixup some of the things that are
alredy broken (on 32 bit systems).

Changes in v3:
  - Removed RFC tag
  - Extended tests to cover one of the POSIX edge cases found during
    review 
                                                                                    
Changes in v2:                                                                      
  - Added a smokey plugin named y2038 for running Y2038 related tests               
    (Should be extended with all related tests)                                     
  - Review implementations (covered by tests now as well)                           
  - Drop support for kernel 4.4                                                     
  - Added the libcobalt part 

Florian Bezdeka (4):
  y2038: Fixing the sem_timedwait syscall for 32 bit systems
  y2038: Adding sem_timedwait64
  y2038: Add tests for the sc_cobalt_sem_timedwait64 syscall
  y2038: lib/cobalt: Add support of sc_cobalt_sem_timedwait64

 configure.ac                           |   1 +
 include/cobalt/kernel/time.h           |  22 ++++
 include/cobalt/uapi/syscall.h          |   1 +
 kernel/cobalt/Makefile                 |   1 +
 kernel/cobalt/posix/sem.c              |  60 +++++----
 kernel/cobalt/posix/sem.h              |  13 +-
 kernel/cobalt/posix/syscall32.c        |  17 ++-
 kernel/cobalt/posix/syscall32.h        |   6 +-
 kernel/cobalt/time.c                   |  29 ++++
 lib/cobalt/semaphore.c                 |   5 +
 testsuite/smokey/Makefile.am           |   6 +-
 testsuite/smokey/y2038/Makefile.am     |  10 ++
 testsuite/smokey/y2038/syscall-tests.c | 175 +++++++++++++++++++++++++
 13 files changed, 315 insertions(+), 31 deletions(-)
 create mode 100644 include/cobalt/kernel/time.h
 create mode 100644 kernel/cobalt/time.c
 create mode 100644 testsuite/smokey/y2038/Makefile.am
 create mode 100644 testsuite/smokey/y2038/syscall-tests.c

-- 
2.29.2


