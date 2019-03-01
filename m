From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 0/4] ipipe-noarch: Revert arch/arm targeting commits
Date: Fri,  1 Mar 2019 13:03:10 +0100
Message-Id: <cover.1551441793.git.jan.kiszka@siemens.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

This commits should be present in the ARM tree only, the small change
to arch_timer_set_cntkctl also in ARM64. By removing them from noarch,
x86 will no longer touch any arch-alien folders.

Jan

Jan Kiszka (4):
  ipipe: Revert changes to ARM arch_timer_set_cntkctl
  Revert "clocksource: imx/imx53: ipipe: add support for user-visible
    TSC"
  Revert "clocksource: imx/imx51: ipipe: add support for user-visible
    TSC"
  Revert "clocksource: omap/dmtimer: ipipe: add support for user-visible
    TSC"

 arch/arm/include/asm/arch_timer.h         |  4 ----
 arch/arm/mach-imx/mach-imx51.c            |  5 -----
 arch/arm/mach-imx/mach-imx53.c            |  5 -----
 arch/arm/plat-omap/dmtimer.c              | 17 ++---------------
 arch/arm/plat-omap/include/plat/dmtimer.h |  6 ------
 5 files changed, 2 insertions(+), 35 deletions(-)

-- 
2.16.4


