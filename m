Message-ID: <515DE96F.7080508@xenomai.org>
Date: Thu, 04 Apr 2013 22:58:23 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] I-pipe on ARM platform.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>


Hi,

The for-core-3.5.7 and for-core-3.8.2 branches in ipipe_gch.git 
repository contain new versions of the I-pipe kernel for the ARM 
architecture. 

The for-core-3.5.7 branch contains an important fix for SMP platforms, 
and the fix for mx28 posted by Martin Krause. 

The for-core-3.8.2 branch is the newest port. Known issues are:
- it has been rebased on v3.8.2, so it will not merge with the branch 
it started from, if preferred, I can push a merged version;
- ftrace is broken, so I wonder if it would not be simpler to have a 
tracer not relying on ftrace, as we did at the beginning of the I-pipe 
tracer;
- threaded fasteoi irqs are broken, the branch contains the latest 
patch posted on this list, but since I received no comment, I am not 
sure it is the right fix.

The pull requests follow.
The following changes since commit 946ca3977e75316751caecc7182f4e64af6499d5:

  ipipe-core-3.5.7-blackfin-3 (2013-01-22 11:41:34 +0100)

are available in the git repository at:
  git://git.xenomai.org/ipipe-gch.git for-core-3.5.7

Gilles Chanteperdrix (2):
      arm/ipipe: fix off-by-one error in IPI virqs allocation
      mx28/ipipe: allow building kernel for both mx28 and mx23

Martin Krause (1):
      mx28/ipipe: fix the timer selected with I-pipe

 arch/arm/kernel/smp.c       |    2 +-
 arch/arm/mach-mxs/timer.c   |   40 ++++++++++++++++------------------------
 drivers/clk/mxs/clk-imx28.c |    4 ++++
 3 files changed, 21 insertions(+), 25 deletions(-)


The following changes since commit 5a16a5a4dd127afcb2446afa057b55a60cffe7f9:

  blackfin/ipipe: import arch-dep bits based on 3.5.7-blackfin-3 (2013-04-04 21:37:51 +0200)

are available in the git repository at:
  git://git.xenomai.org/ipipe-gch.git for-core-3.8.2

Gilles Chanteperdrix (18):
      avoid kernel fault upon coredump on arm with vivt cache
      FCSE: pid life cycle
      FCSE: Conversions between VA and MVA
      FCSE: Address-space limits
      FCSE: Make the shared mappings uncacheable
      FCSE: do not flush cache during context switch
      "Best-effort" FCSE: choose whether to flush cache at run-time
      "Best-effort" FCSE: Allow PID re-use
      "Best-effort" FCSE: Handle mappings above 32 MB
      "Best effort" FCSE: Reserve address-space for stack
      "Best-effort" FCSE: Handle shared mappings
      FCSE: add Makefile and compilation option
      noarch/ipipe: fix ipipe_update_hostrt
      noarch/ipipe: fix one-shot fasteoi irq
      noarch/ipipe: introduce IPIPE_NR_ROOT_IRQS
      arm/ipipe: import arch-dep bits based on 3.5.7-arm-3
      arm/ipipe: avoid calling might_fault() with non-root domains
      mx28/ipipe: allow building kernel for both mx28 and mx23

Martin Krause (1):
      mx28/ipipe: fix the timer selected with I-pipe

 arch/arm/Kconfig                                 |   13 +
 arch/arm/boot/compressed/decompress.c            |    4 +-
 arch/arm/boot/compressed/head.S                  |    9 +
 arch/arm/boot/compressed/string.c                |   17 +
 arch/arm/common/gic.c                            |  117 ++++-
 arch/arm/common/it8152.c                         |    7 +-
 arch/arm/common/timer-sp.c                       |   47 ++-
 arch/arm/common/vic.c                            |    6 +-
 arch/arm/include/asm/Kbuild                      |    1 -
 arch/arm/include/asm/assembler.h                 |   28 +-
 arch/arm/include/asm/atomic.h                    |   16 +-
 arch/arm/include/asm/bitops.h                    |   24 +-
 arch/arm/include/asm/bug.h                       |    1 +
 arch/arm/include/asm/cacheflush.h                |   76 +++-
 arch/arm/include/asm/cmpxchg.h                   |    8 +-
 arch/arm/include/asm/entry-macro-multi.S         |    8 +
 arch/arm/include/asm/fcse.h                      |  188 +++++++
 arch/arm/include/asm/hardware/timer-sp.h         |    9 +-
 arch/arm/include/asm/ipipe.h                     |  270 ++++++++++
 arch/arm/include/asm/ipipe_base.h                |  147 ++++++
 arch/arm/include/asm/ipipe_hwirq.h               |  269 ++++++++++
 arch/arm/include/asm/irq.h                       |    6 +-
 arch/arm/include/asm/irqflags.h                  |    5 +
 arch/arm/include/asm/memory.h                    |    5 +
 arch/arm/include/asm/mmu.h                       |   11 +
 arch/arm/include/asm/mmu_context.h               |  156 +++++-
 arch/arm/include/asm/percpu.h                    |    6 +-
 arch/arm/include/asm/pgtable.h                   |   61 ++-
 arch/arm/include/asm/proc-fns.h                  |   23 +-
 arch/arm/include/asm/processor.h                 |    5 +
 arch/arm/include/asm/resource.h                  |   16 +
 arch/arm/include/asm/switch_to.h                 |    9 +
 arch/arm/include/asm/thread_info.h               |   15 +
 arch/arm/include/asm/tlbflush.h                  |   14 +-
 arch/arm/include/asm/uaccess.h                   |   16 +-
 arch/arm/include/uapi/asm/mman.h                 |    2 +
 arch/arm/kernel/Makefile                         |    2 +
 arch/arm/kernel/entry-armv.S                     |  107 ++++-
 arch/arm/kernel/entry-common.S                   |   69 +++-
 arch/arm/kernel/entry-header.S                   |   48 ++-
 arch/arm/kernel/ipipe.c                          |  596 ++++++++++++++++++++++
 arch/arm/kernel/ipipe_tsc.c                      |  164 ++++++
 arch/arm/kernel/ipipe_tsc_asm.S                  |  246 +++++++++
 arch/arm/kernel/process.c                        |   46 ++-
 arch/arm/kernel/ptrace.c                         |    4 +
 arch/arm/kernel/setup.c                          |   13 +-
 arch/arm/kernel/signal.c                         |    6 +-
 arch/arm/kernel/smp.c                            |  122 ++++-
 arch/arm/kernel/smp_twd.c                        |  110 ++++-
 arch/arm/kernel/suspend.c                        |    2 +-
 arch/arm/kernel/traps.c                          |   24 +
 arch/arm/mach-at91/Kconfig                       |   21 +-
 arch/arm/mach-at91/Makefile                      |    2 +
 arch/arm/mach-at91/at91_ipipe.c                  |  260 ++++++++++
 arch/arm/mach-at91/at91_ipipe.h                  |   19 +
 arch/arm/mach-at91/at91rm9200.c                  |   51 ++
 arch/arm/mach-at91/at91rm9200_time.c             |    5 +-
 arch/arm/mach-at91/at91sam9260.c                 |   52 ++
 arch/arm/mach-at91/at91sam9261.c                 |   51 ++
 arch/arm/mach-at91/at91sam9263.c                 |   51 ++
 arch/arm/mach-at91/at91sam926x_time.c            |    4 +
 arch/arm/mach-at91/at91sam9g45.c                 |   53 ++
 arch/arm/mach-at91/at91sam9rl.c                  |   51 ++
 arch/arm/mach-at91/at91x40.c                     |    2 +
 arch/arm/mach-at91/at91x40_time.c                |    3 +-
 arch/arm/mach-at91/clock.c                       |    2 +
 arch/arm/mach-at91/gpio.c                        |  130 +++++-
 arch/arm/mach-at91/include/mach/hardware.h       |   21 +
 arch/arm/mach-at91/irq.c                         |   45 ++-
 arch/arm/mach-highbank/highbank.c                |    7 +-
 arch/arm/mach-imx/3ds_debugboard.c               |    3 +-
 arch/arm/mach-imx/Kconfig                        |    1 +
 arch/arm/mach-imx/avic.c                         |    5 +-
 arch/arm/mach-imx/clk-imx1.c                     |    3 +-
 arch/arm/mach-imx/clk-imx21.c                    |    3 +-
 arch/arm/mach-imx/clk-imx25.c                    |   11 +-
 arch/arm/mach-imx/clk-imx27.c                    |    3 +-
 arch/arm/mach-imx/clk-imx31.c                    |    3 +-
 arch/arm/mach-imx/clk-imx35.c                    |    6 +-
 arch/arm/mach-imx/clk-imx51-imx53.c              |   10 +-
 arch/arm/mach-imx/clk-imx6q.c                    |    9 +-
 arch/arm/mach-imx/common.h                       |    3 +-
 arch/arm/mach-imx/cpu.c                          |    2 +-
 arch/arm/mach-imx/mach-imx6q.c                   |    4 +
 arch/arm/mach-imx/mach-mx31_3ds.c                |    1 +
 arch/arm/mach-imx/mach-mx31ads.c                 |    3 +-
 arch/arm/mach-imx/mm-imx1.c                      |    1 +
 arch/arm/mach-imx/mm-imx25.c                     |    7 +
 arch/arm/mach-imx/mm-imx27.c                     |   13 +
 arch/arm/mach-imx/mm-imx3.c                      |    8 +
 arch/arm/mach-imx/time.c                         |   63 ++-
 arch/arm/mach-imx/tzic.c                         |   31 ++-
 arch/arm/mach-integrator/common.h                |    2 +-
 arch/arm/mach-integrator/core.c                  |    1 +
 arch/arm/mach-integrator/include/mach/platform.h |    2 +-
 arch/arm/mach-integrator/include/mach/timex.h    |    4 +-
 arch/arm/mach-integrator/integrator_cp.c         |    3 +-
 arch/arm/mach-ixp4xx/common.c                    |   57 ++-
 arch/arm/mach-ixp4xx/include/mach/platform.h     |   15 +-
 arch/arm/mach-mxs/Kconfig                        |    1 +
 arch/arm/mach-mxs/icoll.c                        |   13 +
 arch/arm/mach-mxs/timer.c                        |   80 +++-
 arch/arm/mach-omap2/gpmc.c                       |    3 +-
 arch/arm/mach-omap2/io.c                         |    7 +
 arch/arm/mach-omap2/irq.c                        |   56 ++-
 arch/arm/mach-omap2/mux.c                        |    5 +-
 arch/arm/mach-omap2/omap-wakeupgen.c             |    2 +
 arch/arm/mach-omap2/pm34xx.c                     |    3 +
 arch/arm/mach-omap2/pm44xx.c                     |    6 +-
 arch/arm/mach-omap2/prm_common.c                 |    4 +-
 arch/arm/mach-omap2/timer.c                      |  182 +++++++-
 arch/arm/mach-pxa/irq.c                          |    7 +-
 arch/arm/mach-pxa/lpd270.c                       |    3 +-
 arch/arm/mach-pxa/lubbock.c                      |    3 +-
 arch/arm/mach-pxa/mainstone.c                    |    5 +-
 arch/arm/mach-pxa/pcm990-baseboard.c             |    3 +-
 arch/arm/mach-pxa/time.c                         |   46 ++-
 arch/arm/mach-pxa/viper.c                        |    7 +-
 arch/arm/mach-realview/core.c                    |    9 +-
 arch/arm/mach-realview/core.h                    |    1 +
 arch/arm/mach-realview/realview_eb.c             |    1 +
 arch/arm/mach-realview/realview_pb1176.c         |    1 +
 arch/arm/mach-realview/realview_pb11mp.c         |    1 +
 arch/arm/mach-realview/realview_pba8.c           |    1 +
 arch/arm/mach-realview/realview_pbx.c            |    1 +
 arch/arm/mach-s3c24xx/bast-irq.c                 |    3 +-
 arch/arm/mach-s3c24xx/irq-s3c2412.c              |    5 +-
 arch/arm/mach-s3c24xx/irq-s3c2416.c              |    3 +-
 arch/arm/mach-s3c24xx/irq-s3c2440.c              |    5 +-
 arch/arm/mach-s3c24xx/irq-s3c2443.c              |    3 +-
 arch/arm/mach-s3c24xx/irq-s3c244x.c              |    5 +-
 arch/arm/mach-sa1100/irq.c                       |    8 +-
 arch/arm/mach-sa1100/time.c                      |   45 ++-
 arch/arm/mach-versatile/core.c                   |   10 +-
 arch/arm/mach-vexpress/v2m.c                     |    3 +-
 arch/arm/mm/Kconfig                              |   73 +++
 arch/arm/mm/Makefile                             |    1 +
 arch/arm/mm/alignment.c                          |   11 +-
 arch/arm/mm/cache-l2x0.c                         |   20 +-
 arch/arm/mm/context.c                            |   10 +-
 arch/arm/mm/copypage-v4mc.c                      |    2 +-
 arch/arm/mm/copypage-xscale.c                    |    2 +-
 arch/arm/mm/fault-armv.c                         |   33 ++
 arch/arm/mm/fault.c                              |  112 ++++-
 arch/arm/mm/fcse.c                               |  444 ++++++++++++++++
 arch/arm/mm/flush.c                              |    3 +-
 arch/arm/mm/idmap.c                              |    2 +-
 arch/arm/mm/ioremap.c                            |    1 +
 arch/arm/mm/mmap.c                               |   53 ++-
 arch/arm/mm/pgd.c                                |   53 ++-
 arch/arm/mm/proc-arm920.S                        |    9 +
 arch/arm/mm/proc-arm926.S                        |    9 +
 arch/arm/mm/proc-feroceon.S                      |   13 +
 arch/arm/mm/proc-xscale.S                        |    9 +
 arch/arm/plat-omap/dmtimer.c                     |   16 +-
 arch/arm/plat-omap/include/plat/dmtimer.h        |    6 +
 arch/arm/plat-s3c24xx/irq.c                      |   37 +-
 arch/arm/plat-samsung/include/plat/gpio-core.h   |    2 +-
 arch/arm/plat-samsung/time.c                     |  214 +++++++--
 arch/arm/plat-spear/time.c                       |   88 +++-
 arch/arm/vfp/entry.S                             |    3 +-
 arch/arm/vfp/vfphw.S                             |   26 +-
 arch/arm/vfp/vfpmodule.c                         |   49 ++-
 drivers/clk/mxs/clk-imx28.c                      |    4 +
 drivers/gpio/gpio-mxc.c                          |  125 +++++-
 drivers/gpio/gpio-omap.c                         |  199 +++++++-
 drivers/gpio/gpio-pxa.c                          |    5 +-
 drivers/gpio/gpio-sa1100.c                       |    8 +-
 drivers/irqchip/irq-versatile-fpga.c             |    7 +-
 drivers/irqchip/spear-shirq.c                    |    7 +-
 drivers/mfd/twl4030-irq.c                        |    1 +
 drivers/mfd/twl6030-irq.c                        |    8 +-
 drivers/misc/Kconfig                             |   14 +-
 include/linux/ipipe_base.h                       |    4 +
 kernel/ipipe/core.c                              |    8 +-
 kernel/ipipe/timer.c                             |    6 +-
 kernel/irq/chip.c                                |   12 +-
 kernel/irq/manage.c                              |    5 +
 mm/mmap.c                                        |    4 +
 179 files changed, 6125 insertions(+), 415 deletions(-)
 create mode 100644 arch/arm/include/asm/fcse.h
 create mode 100644 arch/arm/include/asm/ipipe.h
 create mode 100644 arch/arm/include/asm/ipipe_base.h
 create mode 100644 arch/arm/include/asm/ipipe_hwirq.h
 create mode 100644 arch/arm/include/asm/resource.h
 create mode 100644 arch/arm/kernel/ipipe.c
 create mode 100644 arch/arm/kernel/ipipe_tsc.c
 create mode 100644 arch/arm/kernel/ipipe_tsc_asm.S
 create mode 100644 arch/arm/mach-at91/at91_ipipe.c
 create mode 100644 arch/arm/mach-at91/at91_ipipe.h
 create mode 100644 arch/arm/mm/fcse.c


-- 
                                                                Gilles.

