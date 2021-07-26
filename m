Sender: chensong_2000@189.cn
From: Song Chen <chensong_2000@189.cn>
Subject: [PATCH 0/3] [florian/y2038]y2038: monitor_wait for timespec64
Date: Mon, 26 Jul 2021 15:16:10 +0800
Message-Id: <1627283770-3795-1-git-send-email-chensong_2000@189.cn>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: florian.bezdeka@siemens.com, xenomai@xenomai.org

This patch serial is aimed to introduce a new syscall monitor_wait64
which is specific for 64-bit time_t.

Song Chen (3):
  y2038: cobalt/posix/monitor: Adding monitor_wait64
  y2038: lib/cobalt/internal: dispatch monitor_wait
  y2038: testsuite/smokey/y2038: testcase for monitor_wait64

 include/cobalt/uapi/syscall.h          |  2 +-
 kernel/cobalt/posix/monitor.c          | 31 ++++++++++++-
 kernel/cobalt/posix/monitor.h          |  9 ++++
 kernel/cobalt/posix/syscall32.c        |  8 ++++
 kernel/cobalt/posix/syscall32.h        |  6 +++
 lib/cobalt/internal.c                  |  5 ++
 testsuite/smokey/y2038/syscall-tests.c | 83 +++++++++++++++++++++++++++++++++-
 7 files changed, 140 insertions(+), 4 deletions(-)

-- 
2.7.4


