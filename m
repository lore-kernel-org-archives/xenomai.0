From: chensong <chensong@tj.kylinos.cn>
Subject: [PATCH v2 0/5] clock_settime/gettime for timespec64
Date: Fri, 12 Mar 2021 12:01:02 +0800
Message-Id: <1615521662-5770-1-git-send-email-chensong@tj.kylinos.cn>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: florian.bezdeka@siemens.com, xenomai@xenomai.org, rpm@xenomai.org

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

chensong (5):
  [y2038] cobalt: posix: clock: Adding clock_settime64
  [y2038] cobalt: posix: clock: Adding clock_gettime64
  [y2038] lib: cobalt: clock: dispatch clock_settime
  [y2038] lib: cobalt: clock: dispatch clock_gettime
  [y2038] testsuite: smokey: y2038: testcase for settime64 and gettime64

 include/cobalt/kernel/time.h           |   3 +
 include/cobalt/uapi/syscall.h          |   2 +
 kernel/cobalt/posix/clock.c            |  28 +++++++-
 kernel/cobalt/posix/clock.h            |   7 ++
 kernel/cobalt/posix/syscall32.c        |  27 ++++++++
 kernel/cobalt/posix/syscall32.h        |   8 +++
 kernel/cobalt/time.c                   |  11 ++++
 lib/cobalt/clock.c                     |  12 ++++
 testsuite/smokey/y2038/syscall-tests.c | 114 +++++++++++++++++++++++++++++++--
 9 files changed, 206 insertions(+), 6 deletions(-)

-- 
2.7.4




