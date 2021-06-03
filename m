Sender: chensong_2000@189.cn
From: Song Chen <chensong_2000@189.cn>
Subject: [florian/y2038][PATCH v2 0/3] y2038:mutex_timedlock for timespec64
Date: Thu,  3 Jun 2021 18:55:49 +0800
Message-Id: <1622717749-23101-1-git-send-email-chensong_2000@189.cn>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: florian.bezdeka@siemens.com, xenomai@xenomai.org

This patch serial is aimed to introduce a new syscall mutex_timedlock64
which is specific for 64-bit time_t.

---
v2:
1, new revision regarding review comments

Song Chen (3):
  y2038: cobalt/posix/mutex: Adding mutex_timedlock64
  y2038: lib/cobalt/mutex: dispatch mutex_timedlock
  y2038: testsuite/smokey/y2038: testcase for mutex_timedlock64

 include/cobalt/uapi/syscall.h          |   1 +
 kernel/cobalt/posix/mutex.c            |  22 +++++-
 kernel/cobalt/posix/mutex.h            |   7 ++
 kernel/cobalt/posix/syscall32.c        |   7 ++
 kernel/cobalt/posix/syscall32.h        |   4 +
 lib/cobalt/mutex.c                     |   4 +
 testsuite/smokey/y2038/syscall-tests.c | 136 +++++++++++++++++++++++++++++++++
 7 files changed, 180 insertions(+), 1 deletion(-)

-- 
2.7.4


