Sender: chensong_2000@189.cn
From: Song Chen <chensong_2000@189.cn>
Subject: [PATCH 0/3] y2038:clock_getres for timespec64
Date: Tue, 27 Apr 2021 15:36:25 +0800
Message-Id: <1619508985-23029-1-git-send-email-chensong_2000@189.cn>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: florian.bezdeka@siemens.com, xenomai@xenomai.org

This patch serial is aimed to introduce a new syscall clock_getres64
which is specific for 64-bit time_t.

chensong (3):
  y2038: cobalt/posix/clock: Adding clock_getres64
  y2038: lib/cobalt/clock: dispatch clock_getres
  y2038: testsuite/smokey/y2038: testcase for getres64

 include/cobalt/uapi/syscall.h          |  1 +
 kernel/cobalt/posix/clock.c            | 26 ++++++++++++++++++++++++-
 kernel/cobalt/posix/clock.h            |  6 ++++++
 kernel/cobalt/posix/syscall32.c        |  7 +++++++
 kernel/cobalt/posix/syscall32.h        |  4 ++++
 lib/cobalt/clock.c                     |  5 +++++
 testsuite/smokey/y2038/syscall-tests.c | 35 ++++++++++++++++++++++++++++++++++
 7 files changed, 83 insertions(+), 1 deletion(-)

-- 
2.7.4


