From: Jan Kiszka <jan.kiszka@siemens.com>
Date: Thu,  5 Jul 2018 17:46:07 +0200
Message-Id: <cover.1530805570.git.jan.kiszka@siemens.com>
Subject: [Xenomai] [PATCH 0/4] Avoid RT-unsafe printk_ratelimited,
	RTDM cleanup
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Patch 4 should likely be next-only, the others should go to stable as
well.

Jan

Jan Kiszka (4):
  cobalt/kernel/xnclock: Introduce xnclock_ratelimit()
  cobalt/posix/signal: Replace RT-unsafe printk_ratelimit with
    xnclock_ratelimit
  cobalt/rtdm: Switch rtdm_printk_ratelimited to xnclock_ratelimit
  cobalt/rtdm: Remove rtdm_ratelimit()

 include/cobalt/kernel/clock.h       | 22 ++++++++++++++++++
 include/cobalt/kernel/rtdm/driver.h | 32 +++-----------------------
 kernel/cobalt/clock.c               | 35 ++++++++++++++++++++++++++++
 kernel/cobalt/posix/signal.c        |  2 +-
 kernel/cobalt/rtdm/drvlib.c         | 46 -------------------------------------
 5 files changed, 61 insertions(+), 76 deletions(-)

-- 
2.16.4


