Message-ID: <522CAAE3.6040303@xenomai.org>
Date: Sun, 08 Sep 2013 18:50:43 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] ipipe 3.10 pull request
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

The following changes since commit 261a3fdbae01f22e3a1ba1c5aaeccde3557e16fe:

  ipipe: Protect ioremap_page_range against NMI usage by APEI (2013-09-03 19:23:39 +0200)

are available in the git repository at:

  git://git.xenomai.org/ipipe-gch for-ipipe-3.10

for you to fetch changes up to bb9e72f86bf7bb161b4f814645cec402d5e97a35:

  arm/ipipe: fix compilation without Xenomai patch (2013-09-08 18:45:20 +0200)

----------------------------------------------------------------
Charles Steinkuehler (1):
      scripts/ipipe: make genpatches.sh more portable

Gilles Chanteperdrix (3):
      arm/ipipe: 3.10 merge fixup
      arm/ipipe: fix ARMv4/v5 mm switch without CONFIG_IPIPE
      arm/ipipe: fix compilation without Xenomai patch

 arch/arm/Kconfig                         |   61 +--
 arch/arm/common/timer-sp.c               |   33 +-
 arch/arm/include/asm/fcse.h              |   26 +-
 arch/arm/include/asm/hardware/timer-sp.h |   16 +-
 arch/arm/include/asm/ipipe_base.h        |    2 +-
 arch/arm/include/asm/mmu_context.h       |   44 ++-
 arch/arm/kernel/arch_timer.c             |  444 ---------------------
 arch/arm/kernel/entry-armv.S             |    9 -
 arch/arm/kernel/entry-common.S           |   14 +-
 arch/arm/kernel/entry-header.S           |   63 +--
 arch/arm/kernel/ipipe.c                  |   78 +++-
 arch/arm/kernel/ipipe_tsc.c              |   14 +-
 arch/arm/kernel/ipipe_tsc_asm.S          |   53 ++-
 arch/arm/kernel/setup.c                  |    8 +-
 arch/arm/kernel/smp_twd.c                |   36 +-
 arch/arm/mach-at91/Kconfig               |  147 +------
 arch/arm/mach-at91/at91rm9200.c          |    2 +-
 arch/arm/mach-at91/at91rm9200_time.c     |    5 -
 arch/arm/mach-at91/at91x40_time.c        |    1 -
 arch/arm/mach-at91/irq.c                 |    4 +-
 arch/arm/mach-highbank/highbank.c        |   25 --
 arch/arm/mach-imx/mach-imx6q.c           |   15 +-
 arch/arm/mach-imx/mm-imx3.c              |    5 +-
 arch/arm/mach-ixp4xx/common.c            |    5 +-
 arch/arm/mach-omap2/gpmc.c               |    6 +-
 arch/arm/mach-omap2/io.c                 |   17 +-
 arch/arm/mach-omap2/pm34xx.c             |    4 -
 arch/arm/mach-omap2/pm44xx.c             |    4 -
 arch/arm/mach-omap2/timer.c              |   50 +--
 arch/arm/mach-pxa/time.c                 |  101 ++---
 arch/arm/mach-s3c24xx/irq-s3c2416.c      |  349 -----------------
 arch/arm/mach-s3c24xx/irq-s3c2443.c      |  282 --------------
 arch/arm/mach-sa1100/time.c              |   71 +---
 arch/arm/mach-spear/Kconfig              |    1 +
 arch/arm/mach-spear/time.c               |    8 -
 arch/arm/mach-versatile/core.c           |   23 --
 arch/arm/mach-vexpress/v2m.c             |    7 -
 arch/arm/mm/Kconfig                      |    2 +-
 arch/arm/mm/cache-l2x0.c                 |   39 ++
 arch/arm/mm/context.c                    |   14 +-
 arch/arm/mm/fcse.c                       |   70 ++--
 arch/arm/mm/idmap.c                      |    4 -
 arch/arm/plat-omap/dmtimer.c             |   13 +-
 arch/arm/plat-s3c24xx/irq.c              |  691 ---------------------------------
 arch/arm/plat-samsung/samsung-time.c     |   40 +-
 drivers/clocksource/arm_arch_timer.c     |   79 +++-
 drivers/clocksource/mxs_timer.c          |   41 +-
 drivers/gpio/gpio-omap.c                 |    9 +-
 drivers/irqchip/irq-gic.c                |    5 +-
 drivers/irqchip/irq-mxs.c                |    2 +-
 drivers/irqchip/irq-s3c24xx.c            |    5 +-
 drivers/irqchip/irq-vic.c                |    2 +-
 kernel/context_tracking.c                |    4 +-
 scripts/ipipe/genpatches.sh              |   18 +-
 54 files changed, 570 insertions(+), 2501 deletions(-)
 delete mode 100644 arch/arm/mach-s3c24xx/irq-s3c2416.c
 delete mode 100644 arch/arm/mach-s3c24xx/irq-s3c2443.c
 delete mode 100644 arch/arm/plat-s3c24xx/irq.c


-- 
                                                                Gilles.

