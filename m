From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v2 0/7] Rework pthread_setschedprio support
Date: Tue,  3 Dec 2019 12:32:10 +0100
Message-Id: <cover.1575372737.git.jan.kiszka@siemens.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

It turned out just in time that the __CURRENT_SCHED-approach is broken
and not reasonably fixable. This introduces a separate syscall for
implementing that posix function.

Changes in v2:
 - account for !CONFIG_XENO_LAZY_SETSCHED in setsched test
 - split smokey changes into two patches
 - enable lazy-setsched in debian package

Jan

Jan Kiszka (7):
  cobalt/posix/thread: Factor out thread_lookup_or_shadow
  cobalt/posix: Add thread_setschedprio
  lib/cobalt: Use new thread_setschedprio syscall
  Revert "cobalt/kernel: Introduce __SCHED_CURRENT policy to
    setschedparam_ex"
  testsuite/smokey: Fix setsched /wrt lazy scheduling parameter
    application
  testsuite/smokey: Add pthread_setschedprio to setsched test case
  debian: Enable lazy-setsched in userspace package

 debian/rules                                       |  1 +
 include/cobalt/uapi/sched.h                        |  3 -
 include/cobalt/uapi/syscall.h                      |  1 +
 .../arch/x86/include/asm/xenomai/syscall32-table.h |  1 +
 kernel/cobalt/posix/syscall32.c                    |  9 +++
 kernel/cobalt/posix/syscall32.h                    |  6 ++
 kernel/cobalt/posix/thread.c                       | 85 ++++++++++++++++------
 kernel/cobalt/posix/thread.h                       | 11 +++
 kernel/cobalt/trace/cobalt-posix.h                 | 18 ++++-
 lib/cobalt/thread.c                                | 33 ++++++++-
 testsuite/smokey/setsched/setsched.c               | 31 +++++++-
 11 files changed, 167 insertions(+), 32 deletions(-)

-- 
2.16.4


