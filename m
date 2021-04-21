Sender: chensong_2000@189.cn
From: Song Chen <chensong_2000@189.cn>
Subject: [PATCH v5 0/5]  y2038:clock_settime/gettime for timespec64
Date: Wed, 21 Apr 2021 16:32:54 +0800
Message-Id: <1618993974-21011-1-git-send-email-chensong_2000@189.cn>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, florian.bezdeka@siemens.com
Cc: chensong <chensong@tj.kylinos.cn>

From: chensong <chensong@tj.kylinos.cn>

This patch serial is aimed to introduce a new syscall clock_settime64
and clock_gettime64 which are specific for 64-bit time_t.

There is no impact to current implementation of clock_settime, nothing
broken.

---
v2:
1, merge clock_settime64 and compat clock_settime64
2, remove checking __xn_feat_time64
3, add clock_gettime64
4, add smokey test for clock_settime64 and clock_gettime64

v3:
1, flip patch order: clock_settime64 and clock_gettime54
2, flip syscall number order:
   sc_cobalt_clock_gettime64 and sc_cobalt_clock_settime64
3, add documentation for cobalt_put_timespec64
4, new implementation of smokey test for
   clock_gettime64 and clock_settime64
   it only validates syscalls and doesn't trigger y2038 problem
   to avoid jeopardizing environment.

v4:
1, return run_y2038 to its original approach

v5:
1, introduce a new helper __cobalt_clock_settime64 given the behavior
in compat syscall is identical.
2, introduce a new helper __cobalt_clock_gettime64 given the behavior
in compat syscall is identical.
3, REALTIME --> MONOTONIC in testsuite
4, smokey warning if clock_gettime goes wrong in testsuite

chensong (5):
  y2038: cobalt/posix/clock: Adding clock_gettime64
  y2038: cobalt/posix/clock: Adding clock_settime64
  y2038: lib/cobalt/clock: dispatch clock_settime
  y2038: lib/cobalt/clock: dispatch clock_gettime
  y2038: testsuite/smokey/y2038: testcase for settime64 and gettime64

 include/cobalt/kernel/time.h           | 11 +++++
 include/cobalt/uapi/syscall.h          |  2 +
 kernel/cobalt/posix/clock.c            | 40 +++++++++++++++++-
 kernel/cobalt/posix/clock.h            | 13 ++++++
 kernel/cobalt/posix/syscall32.c        | 15 +++++++
 kernel/cobalt/posix/syscall32.h        |  8 ++++
 kernel/cobalt/time.c                   | 11 +++++
 lib/cobalt/clock.c                     | 12 ++++++
 testsuite/smokey/y2038/syscall-tests.c | 77 +++++++++++++++++++++++++++++++++-
 9 files changed, 186 insertions(+), 3 deletions(-)

-- 
2.7.4


