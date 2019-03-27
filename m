From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 0/8] ipipe-noarch: Pending fixes and cleanups
Date: Wed, 27 Mar 2019 14:17:59 +0100
Message-Id: <cover.1553692686.git.jan.kiszka@siemens.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, Philippe Gerum <rpm@xenomai.org>

The ARM-only reverts I sent before. New are some fixes the the ipipe
tracer, the fix for the ipipe timer ack handler, and a small cleanup of
grab_timer.

Jan

Jan Kiszka (8):
  ipipe: Revert changes to ARM arch_timer_set_cntkctl
  Revert "clocksource: imx/imx53: ipipe: add support for user-visible
    TSC"
  Revert "clocksource: imx/imx51: ipipe: add support for user-visible
    TSC"
  Revert "clocksource: omap/dmtimer: ipipe: add support for user-visible
    TSC"
  ipipe: Fix panic output of tracer
  ipipe: Fix output layout of tracer
  ipipe: Call present ack and end handlers for timer irq unconditionally
  ipipe: Drop unneeded NULL check from grab_timer

 arch/arm/include/asm/arch_timer.h         |  4 ---
 arch/arm/mach-imx/mach-imx51.c            |  5 ----
 arch/arm/mach-imx/mach-imx53.c            |  5 ----
 arch/arm/plat-omap/dmtimer.c              | 17 ++----------
 arch/arm/plat-omap/include/plat/dmtimer.h |  6 -----
 kernel/ipipe/timer.c                      | 17 +++++++-----
 kernel/ipipe/tracer.c                     | 44 +++++++++++++++----------------
 7 files changed, 34 insertions(+), 64 deletions(-)

-- 
2.16.4


