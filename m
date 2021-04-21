Sender: chensong_2000@189.cn
From: Song Chen <chensong_2000@189.cn>
Subject: [PATCH v2 0/3] y2038:clock_nanosleep for timespec64
Date: Wed, 21 Apr 2021 16:38:20 +0800
Message-Id: <1618994300-21411-1-git-send-email-chensong_2000@189.cn>
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

This patch serial is aimed to introduce a new syscall clock_nanosleep64
which is specific for 64-bit time_t.

---
v2:
1, introduce a new helper __cobalt_clock_nanosleep64 given the behavior
in compat syscall is identical.
2, REALTIME --> MONOTONIC in testsuite
3, more combinations of parameters in testsuite
4, smokey warning if clock_gettime goes wrong in testsuite
5, remove magic number in testsuite

chensong (3):
  y2038: cobalt/posix/clock: Adding clock_nanosleep64
  y2038: lib/cobalt/clock: dispatch clock_nanosleep
  y2038: testsuite/smokey/y2038: testcase for nanosleep64

 include/cobalt/uapi/syscall.h          |  1 +
 kernel/cobalt/posix/clock.c            | 30 ++++++++++++++++++++
 kernel/cobalt/posix/clock.h            |  9 ++++++
 kernel/cobalt/posix/syscall32.c        |  9 ++++++
 kernel/cobalt/posix/syscall32.h        |  6 ++++
 lib/cobalt/clock.c                     |  5 ++++
 testsuite/smokey/y2038/syscall-tests.c | 50 ++++++++++++++++++++++++++++++++++
 7 files changed, 110 insertions(+)

-- 
2.7.4


