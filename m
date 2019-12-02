From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 0/5] Rework pthread_setschedprio support
Date: Mon,  2 Dec 2019 08:12:13 +0100
Message-Id: <cover.1575270738.git.jan.kiszka@siemens.com>
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

Jan

Jan Kiszka (5):
  cobalt/posix/thread: Factor out thread_lookup_or_shadow
  cobalt/posix: Add thread_setschedprio
  lib/cobalt: Use new thread_setschedprio syscall
  Revert "cobalt/kernel: Introduce __SCHED_CURRENT policy to
    setschedparam_ex"
  testsuite/smokey: Add pthread_setschedprio to setsched test case

 include/cobalt/uapi/sched.h                        |  3 -
 include/cobalt/uapi/syscall.h                      |  1 +
 .../arch/x86/include/asm/xenomai/syscall32-table.h |  1 +
 kernel/cobalt/posix/syscall32.c                    |  9 +++
 kernel/cobalt/posix/syscall32.h                    |  6 ++
 kernel/cobalt/posix/thread.c                       | 85 ++++++++++++++++------
 kernel/cobalt/posix/thread.h                       | 11 +++
 kernel/cobalt/trace/cobalt-posix.h                 | 18 ++++-
 lib/cobalt/thread.c                                | 33 ++++++++-
 testsuite/smokey/setsched/setsched.c               | 19 +++++
 10 files changed, 155 insertions(+), 31 deletions(-)

-- 
2.16.4


