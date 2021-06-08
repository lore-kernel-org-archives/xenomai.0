Sender: chensong_2000@189.cn
From: Song Chen <chensong_2000@189.cn>
Subject: [PATCH 0/5] [florian/y2038][PATCH v3 0/3] y2038: mq_timed{send,
 recv}64
Date: Tue,  8 Jun 2021 10:11:21 +0800
Message-Id: <1623118281-6813-1-git-send-email-chensong_2000@189.cn>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: florian.bezdeka@siemens.com, xenomai@xenomai.org

This patch serial is aimed to introduce new syscalls mq_timedsend64 and
mq_timedreceive64, which are specific for 64-bit time_t.

Song Chen (5):
  y2038: cobalt/posix/muqueue: Adding mq_timedsend64
  y2038: lib/cobalt/mqueue: dispatch mq_timedsend
  y2038: cobalt/posix/muqueue: Adding mq_timedreceive64
  y2038: lib/cobalt/mqueue: dispatch mq_timedreceive
  y2038: testsuite/smokey/y2038: testcase for mq_timed{send,recv}64

 include/cobalt/uapi/syscall.h          |   2 +
 kernel/cobalt/posix/mqueue.c           |  51 +++++++++-
 kernel/cobalt/posix/mqueue.h           |  19 ++++
 kernel/cobalt/posix/syscall32.c        |  18 ++++
 kernel/cobalt/posix/syscall32.h        |  11 +++
 lib/cobalt/mq.c                        |  10 ++
 testsuite/smokey/y2038/syscall-tests.c | 169 +++++++++++++++++++++++++++++++++
 7 files changed, 279 insertions(+), 1 deletion(-)

-- 
2.7.4


