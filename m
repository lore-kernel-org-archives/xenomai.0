From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v3 0/5] y2038: Add mutex_timedlock64() support 
Date: Fri, 30 Jul 2021 15:58:51 +0200
Message-Id: <20210730135856.12958-1-florian.bezdeka@siemens.com>
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

Hi!

This series is based on the series posted by Song some time ago. The
testing part has been heavily reworked. Details are mentioned in the 
description of the last patch.

@Jan: Patch 1 and 2 are re-sends. They are not directly related to the 
y2038 stuff but the testsuite might fail if they are not applied.

Testing was done on x86 only so far, internal CI is still running but no
problems expected.

Best regards,   
Florian

Changes in v3:
  - Added the syscall to the tracing infrastructure
    (squashed into patch 3 from Song)

Florian Bezdeka (3):
  smokey: posix_mutex: Fix mutex/smokey_barrier leak
  cobalt/posix/mutex: Harmonize pthread_mutex_timedlock() and
    sem_timedwait()
  testsuite/smokey/y2038: Adding test cases for mutex_timedlock64()

Song Chen (2):
  y2038: cobalt/posix/mutex: Adding mutex_timedlock64
  y2038: lib/cobalt/mutex: dispatch mutex_timedlock

 include/cobalt/uapi/syscall.h              |   1 +
 kernel/cobalt/posix/mutex.c                |  28 ++-
 kernel/cobalt/posix/mutex.h                |   7 +
 kernel/cobalt/posix/syscall32.c            |   7 +
 kernel/cobalt/posix/syscall32.h            |   4 +
 kernel/cobalt/trace/cobalt-posix.h         |   3 +-
 lib/cobalt/mutex.c                         |   4 +
 testsuite/smokey/posix-mutex/posix-mutex.c |  62 +++++++
 testsuite/smokey/y2038/syscall-tests.c     | 187 +++++++++++++++++++++
 9 files changed, 301 insertions(+), 2 deletions(-)

-- 
2.30.2


