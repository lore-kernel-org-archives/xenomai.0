Sender: chensong_2000@189.cn
From: Song Chen <chensong_2000@189.cn>
Subject: [florian/y2038][PATCH v3 0/3] y2038: sigtimedwait for timespec64
Date: Fri,  9 Jul 2021 15:09:44 +0800
Message-Id: <1625814584-22289-1-git-send-email-chensong_2000@189.cn>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: florian.bezdeka@siemens.com, xenomai@xenomai.org

This patch serial is aimed to introduce a new syscall sigtimedwait64
which is specific for 64-bit time_t.

Song Chen (3):
  y2038: cobalt/posix/signal: Adding sigtimedwait64
  y2038: lib/cobalt/signal: dispatch sigtimedwait
  y2038: testsuite/smokey/y2038: testcase for sigtimedwait64

 include/cobalt/uapi/syscall.h          |  1 +
 kernel/cobalt/posix/signal.c           | 23 +++++++++--
 kernel/cobalt/posix/signal.h           |  5 +++
 kernel/cobalt/posix/syscall32.c        | 21 ++++++++++
 kernel/cobalt/posix/syscall32.h        |  5 +++
 lib/cobalt/signal.c                    |  4 ++
 testsuite/smokey/y2038/syscall-tests.c | 72 ++++++++++++++++++++++++++++++++++
 7 files changed, 128 insertions(+), 3 deletions(-)

-- 
2.7.4


