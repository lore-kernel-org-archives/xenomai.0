From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH 0/8] assorted fixes, ARM port to kernel 4.19
Date: Sat,  1 Jun 2019 17:14:54 +0200
Message-Id: <20190601151502.27216-1-rpm@xenomai.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>

This is material for both 3.0.9 and -next.

Philippe Gerum (8):
  lib/cobalt: init: fix misleading message
  cobalt/arm: fix context switching code for 4.19+
  drivers/udd: fix spurious select() read events
  testsuite/smokey: sched-quota: allow up to 1.5% deviation from plan
  testsuite/smokey: reset main()'s SCHED_OTHER policy before each test
  cobalt/thread: send backtracing request only when XNWARN is set
  cobalt/thread: fix error status (-EINTR) of xnthread_killall()
  lib/cobalt: kickstart backtrace() from safe context

 include/cobalt/kernel/rtdm/udd.h           |  2 +-
 kernel/cobalt/arch/arm/switch.S            | 54 +++++++++++++++++++++-
 kernel/cobalt/thread.c                     | 10 ++--
 kernel/drivers/udd/udd.c                   | 31 ++++++++-----
 lib/cobalt/init.c                          |  2 +-
 lib/cobalt/sigshadow.c                     |  8 ++++
 testsuite/smokey/main.c                    |  2 +
 testsuite/smokey/sched-quota/sched-quota.c |  2 +-
 8 files changed, 91 insertions(+), 20 deletions(-)

-- 
2.20.1


