Sender: chensong_2000@189.cn
From: Song Chen <chensong_2000@189.cn>
Subject: [PATCH 0/3] y2038:clock_adjtime for 64bit timex
Date: Thu, 29 Apr 2021 15:44:05 +0800
Message-Id: <1619682245-15325-1-git-send-email-chensong_2000@189.cn>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: florian.bezdeka@siemens.com, xenomai@xenomai.org

This patch serial is aimed to introduce a new syscall clock_adjtime64
which is specific for 64-bit time_t.

Song Chen (3):
  y2038: cobalt/posix/clock: Adding clock_adjtime64
  y2038: lib/cobalt/clock: dispatch clock_adjtime
  y2038: testsuite/smokey/y2038: testcase for adjtime64

 include/cobalt/uapi/syscall.h          |  1 +
 kernel/cobalt/posix/clock.c            | 22 +++++++++++
 kernel/cobalt/posix/clock.h            |  6 +++
 kernel/cobalt/posix/syscall32.c        |  7 ++++
 kernel/cobalt/posix/syscall32.h        |  4 ++
 lib/cobalt/clock.c                     |  5 +++
 testsuite/smokey/y2038/syscall-tests.c | 71 ++++++++++++++++++++++++++++++++++
 7 files changed, 116 insertions(+)

-- 
2.7.4


