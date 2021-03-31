From: chensong <chensong@tj.kylinos.cn>
Subject: [PATCH 0/3] y2038:clock_nanosleep for timespec64 
Date: Wed, 31 Mar 2021 11:25:46 +0800
Message-Id: <1617161146-27094-1-git-send-email-chensong@tj.kylinos.cn>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: florian.bezdeka@siemens.com, xenomai@xenomai.org, rpm@xenomai.org

This patch serial is aimed to introduce a new syscall clock_nanosleep64
which is specific for 64-bit time_t.

chensong (3):
  y2038: cobalt/posix/clock: Adding clock_nanosleep64
  y2038: lib/cobalt/clock: dispatch clock_nanosleep
  y2038: testsuite/smokey/y2038: testcase for nanosleep64

 include/cobalt/uapi/syscall.h          |  1 +
 kernel/cobalt/posix/clock.c            | 23 ++++++++++++
 kernel/cobalt/posix/clock.h            |  5 +++
 kernel/cobalt/posix/syscall32.c        | 23 ++++++++++++
 kernel/cobalt/posix/syscall32.h        |  6 ++++
 lib/cobalt/clock.c                     |  5 +++
 testsuite/smokey/y2038/syscall-tests.c | 65 ++++++++++++++++++++++++++++++++++
 7 files changed, 128 insertions(+)

-- 
2.7.4




