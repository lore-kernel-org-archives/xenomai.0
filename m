Sender: chensong_2000@189.cn
From: Song Chen <chensong_2000@189.cn>
Subject: [PATCH 0/3] [florian/y2038]y2038: event_wait for timespec64
Date: Tue, 27 Jul 2021 14:55:16 +0800
Message-Id: <1627368916-12502-1-git-send-email-chensong_2000@189.cn>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: florian.bezdeka@siemens.com, xenomai@xenomai.org

This patch serial is aimed to introduce a new syscall event_wait64
which is specific for 64-bit time_t.

Song Chen (3):
  y2038: cobalt/posix/event: Adding event_wait64
  y2038: lib/cobalt/internal: dispatch event_wait
  y2038: testsuite/smokey/y2038: testcase for event_wait64

 include/cobalt/uapi/syscall.h          |  1 +
 kernel/cobalt/posix/event.c            | 37 +++++++++++++++--
 kernel/cobalt/posix/event.h            | 12 ++++++
 kernel/cobalt/posix/syscall32.c        |  9 ++++
 kernel/cobalt/posix/syscall32.h        |  7 ++++
 lib/cobalt/internal.c                  |  7 +++-
 testsuite/smokey/y2038/syscall-tests.c | 76 ++++++++++++++++++++++++++++++++++
 7 files changed, 144 insertions(+), 5 deletions(-)

-- 
2.7.4


