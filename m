Sender: chensong_2000@189.cn
From: Song Chen <chensong_2000@189.cn>
Subject: [PATCH 0/3] y2038:mutex_timedlock for timespec64
Date: Tue, 25 May 2021 11:02:52 +0800
Message-Id: <1621911772-28386-1-git-send-email-chensong_2000@189.cn>
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
 testsuite/smokey/y2038/syscall-tests.c | 139 ++++++++++++++++++++++++++++++++-
 7 files changed, 182 insertions(+), 2 deletions(-)

-- 
2.7.4


