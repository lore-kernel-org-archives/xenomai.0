Message-ID: <4EA2F07C.90108@domain.hid>
Date: Sat, 22 Oct 2011 18:34:04 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] Pull request for ipipe-2.6.38-arm
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Adeos <adeos-main@gna.org>

The following changes since commit 7e123a255731dd6e09eb583402b50fc59414cfbd:

  ipipe noarch: add const attribute to irq_get_irq_data (2011-10-10 20:37:36 +0200)

are available in the git repository at:
  git://git.xenomai.org/ipipe-gch.git for-ipipe-2.6.38-arm

Gilles Chanteperdrix (16):
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
      "Best effort" FCSE: Dynamic FCSE pid switching
      FCSE: add Makefile and compilation option
      Merge branch 'fcse-2.6.38' into for-ipipe-2.6.38-arm2
      omap2+: get sched_clock working without CONFIG_OMAP_32K_TIMER
      omap4/smp_twd: get frequency from SoC clock rate
      forward port, rebase on 2.6.38-noarch, adeos-ipipe-2.6.38.8-arm-1.18-03

 arch/arm/Kconfig                                   |   13 +
 arch/arm/boot/compressed/head.S                    |    9 +
 arch/arm/common/gic.c                              |  140 +++--
 arch/arm/common/it8152.c                           |    7 +-
 arch/arm/common/timer-sp.c                         |   80 +++-
 arch/arm/include/asm/assembler.h                   |   24 +
 arch/arm/include/asm/atomic.h                      |   16 +-
 arch/arm/include/asm/bitops.h                      |   24 +-
 arch/arm/include/asm/cacheflush.h                  |   75 ++-
 arch/arm/include/asm/cpu-multi32.h                 |   10 +
 arch/arm/include/asm/cpu-single.h                  |    5 +
 arch/arm/include/asm/entry-macro-multi.S           |   12 +
 arch/arm/include/asm/fcse.h                        |  181 ++++++
 arch/arm/include/asm/hardware/timer-sp.h           |    2 +-
 arch/arm/include/asm/ipipe.h                       |  340 ++++++++++
 arch/arm/include/asm/ipipe_base.h                  |  150 +++++
 arch/arm/include/asm/irqflags.h                    |  244 +++++---
 arch/arm/include/asm/memory.h                      |    5 +
 arch/arm/include/asm/mmu.h                         |   15 +-
 arch/arm/include/asm/mmu_context.h                 |  128 ++++-
 arch/arm/include/asm/percpu.h                      |    4 +
 arch/arm/include/asm/pgtable.h                     |   82 ++-
 arch/arm/include/asm/proc-fns.h                    |   13 +-
 arch/arm/include/asm/processor.h                   |    5 +
 arch/arm/include/asm/resource.h                    |   10 +
 arch/arm/include/asm/smp_twd.h                     |   60 ++-
 arch/arm/include/asm/system.h                      |   17 +-
 arch/arm/include/asm/thread_info.h                 |   12 +
 arch/arm/include/asm/tlbflush.h                    |   14 +-
 arch/arm/kernel/Makefile                           |    4 +-
 arch/arm/kernel/entry-armv.S                       |  153 +++++-
 arch/arm/kernel/entry-common.S                     |   64 ++-
 arch/arm/kernel/entry-header.S                     |    8 +-
 arch/arm/kernel/ipipe.c                            |  675 ++++++++++++++++++++
 arch/arm/kernel/ipipe_tsc.c                        |  136 ++++
 arch/arm/kernel/ipipe_tsc_asm.S                    |  205 ++++++
 arch/arm/kernel/irq.c                              |    2 +
 arch/arm/kernel/process.c                          |   30 +-
 arch/arm/kernel/ptrace.c                           |    4 +
 arch/arm/kernel/smp.c                              |   83 +++-
 arch/arm/kernel/smp_twd.c                          |  176 +++++-
 arch/arm/kernel/traps.c                            |   10 +
 arch/arm/mach-at91/Kconfig                         |   13 +
 arch/arm/mach-at91/Makefile                        |   11 +
 arch/arm/mach-at91/at91_ipipe_time.c               |  316 +++++++++
 arch/arm/mach-at91/at91rm9200.c                    |   44 ++
 arch/arm/mach-at91/at91sam9260.c                   |   44 ++
 arch/arm/mach-at91/at91sam9261.c                   |   44 ++
 arch/arm/mach-at91/at91sam9263.c                   |   44 ++
 arch/arm/mach-at91/at91sam9rl.c                    |   44 ++
 arch/arm/mach-at91/gpio.c                          |  116 ++++-
 arch/arm/mach-at91/include/mach/hardware.h         |   19 +
 arch/arm/mach-at91/include/mach/irqs.h             |    2 +
 arch/arm/mach-at91/include/mach/timex.h            |    2 +-
 arch/arm/mach-at91/irq.c                           |    3 +
 arch/arm/mach-imx/clock-imx1.c                     |    2 +-
 arch/arm/mach-imx/clock-imx21.c                    |    2 +-
 arch/arm/mach-imx/clock-imx27.c                    |    3 +-
 arch/arm/mach-integrator/core.c                    |    1 +
 .../arm/mach-integrator/include/mach/entry-macro.S |    6 +-
 arch/arm/mach-integrator/include/mach/irqs.h       |    1 -
 arch/arm/mach-integrator/include/mach/platform.h   |    6 +-
 arch/arm/mach-integrator/include/mach/timex.h      |    4 +-
 arch/arm/mach-integrator/integrator_cp.c           |   14 +-
 arch/arm/mach-ixp4xx/common.c                      |  178 +++++-
 arch/arm/mach-ixp4xx/include/mach/platform.h       |    9 +-
 arch/arm/mach-mx3/clock-imx31.c                    |    3 +-
 arch/arm/mach-mx3/clock-imx35.c                    |    5 +-
 arch/arm/mach-mx3/devices.c                        |    1 +
 arch/arm/mach-mx3/mach-mx31_3ds.c                  |    1 +
 arch/arm/mach-mx3/mach-mx31ads.c                   |    3 +-
 arch/arm/mach-mx5/clock-mx51-mx53.c                |    4 +-
 arch/arm/mach-mxc91231/clock.c                     |    3 +-
 arch/arm/mach-omap2/board-cm-t35.c                 |    2 +
 arch/arm/mach-omap2/board-cm-t3517.c               |    2 +
 arch/arm/mach-omap2/board-devkit8000.c             |    2 +
 arch/arm/mach-omap2/clock44xx_data.c               |    9 +
 arch/arm/mach-omap2/irq.c                          |   89 +++-
 arch/arm/mach-omap2/timer-gp.c                     |  121 ++++-
 arch/arm/mach-omap2/timer-mpu.c                    |    4 +-
 arch/arm/mach-pxa/irq.c                            |    3 +
 arch/arm/mach-pxa/leds-idp.c                       |    1 +
 arch/arm/mach-pxa/leds-lubbock.c                   |    1 +
 arch/arm/mach-pxa/leds-mainstone.c                 |    1 +
 arch/arm/mach-pxa/lpd270.c                         |    3 +-
 arch/arm/mach-pxa/lubbock.c                        |    3 +-
 arch/arm/mach-pxa/mainstone.c                      |    3 +-
 arch/arm/mach-pxa/pcm990-baseboard.c               |    3 +-
 arch/arm/mach-pxa/time.c                           |   73 +++-
 arch/arm/mach-pxa/viper.c                          |    3 +-
 arch/arm/mach-realview/core.c                      |    9 +-
 arch/arm/mach-realview/core.h                      |    1 +
 arch/arm/mach-realview/realview_eb.c               |    1 +
 arch/arm/mach-realview/realview_pb1176.c           |    1 +
 arch/arm/mach-realview/realview_pb11mp.c           |    1 +
 arch/arm/mach-realview/realview_pba8.c             |    1 +
 arch/arm/mach-realview/realview_pbx.c              |    1 +
 arch/arm/mach-s3c2410/include/mach/irqs.h          |    2 +
 arch/arm/mach-s3c2440/irq.c                        |    7 +-
 arch/arm/mach-s3c2440/s3c244x-irq.c                |   10 +-
 arch/arm/mach-sa1100/gpio.c                        |    8 +-
 arch/arm/mach-sa1100/irq.c                         |    8 +-
 arch/arm/mach-sa1100/leds-assabet.c                |    1 +
 arch/arm/mach-sa1100/leds-badge4.c                 |    1 +
 arch/arm/mach-sa1100/leds-cerf.c                   |    1 +
 arch/arm/mach-sa1100/leds-hackkit.c                |    1 +
 arch/arm/mach-sa1100/leds-lart.c                   |    1 +
 arch/arm/mach-sa1100/leds-simpad.c                 |    1 +
 arch/arm/mach-sa1100/time.c                        |   76 +++-
 arch/arm/mach-versatile/core.c                     |    9 +-
 arch/arm/mach-vexpress/ct-ca9x4.c                  |    2 +-
 arch/arm/mach-vexpress/v2m.c                       |    2 +-
 arch/arm/mm/Kconfig                                |   84 +++-
 arch/arm/mm/Makefile                               |    1 +
 arch/arm/mm/alignment.c                            |    3 +
 arch/arm/mm/cache-l2x0.c                           |    3 +-
 arch/arm/mm/context.c                              |   57 ++-
 arch/arm/mm/copypage-v4mc.c                        |    2 +-
 arch/arm/mm/copypage-xscale.c                      |    2 +-
 arch/arm/mm/fault-armv.c                           |   33 +
 arch/arm/mm/fault.c                                |   70 ++
 arch/arm/mm/fcse.c                                 |  466 ++++++++++++++
 arch/arm/mm/flush.c                                |    3 +-
 arch/arm/mm/ioremap.c                              |    1 +
 arch/arm/mm/mmap.c                                 |   37 +-
 arch/arm/mm/mmu.c                                  |    2 +-
 arch/arm/mm/pgd.c                                  |   52 ++-
 arch/arm/mm/proc-arm920.S                          |    9 +
 arch/arm/mm/proc-arm926.S                          |    9 +
 arch/arm/mm/proc-feroceon.S                        |   13 +
 arch/arm/mm/proc-xscale.S                          |    9 +
 arch/arm/plat-mxc/avic.c                           |    4 +-
 arch/arm/plat-mxc/cpu.c                            |   35 +-
 arch/arm/plat-mxc/devices.c                        |   22 +
 arch/arm/plat-mxc/gpio.c                           |   89 +++-
 arch/arm/plat-mxc/include/mach/common.h            |    7 +-
 arch/arm/plat-mxc/include/mach/gpio.h              |    5 +-
 arch/arm/plat-mxc/include/mach/irqs.h              |    4 +
 arch/arm/plat-mxc/time.c                           |   97 +++-
 arch/arm/plat-mxc/tzic.c                           |   30 +
 arch/arm/plat-omap/Kconfig                         |    8 +-
 arch/arm/plat-omap/counter_32k.c                   |    2 +-
 arch/arm/plat-omap/dmtimer.c                       |   51 ++-
 arch/arm/plat-omap/gpio.c                          |  356 ++++++++++-
 arch/arm/plat-omap/include/plat/dmtimer.h          |    5 +
 arch/arm/plat-omap/include/plat/irqs.h             |    9 +
 arch/arm/plat-pxa/gpio.c                           |    5 +-
 arch/arm/plat-s3c24xx/irq.c                        |   37 +-
 arch/arm/plat-samsung/include/plat/gpio-core.h     |    2 +-
 arch/arm/plat-samsung/irq-uart.c                   |    8 +-
 arch/arm/plat-samsung/time.c                       |  196 +++++--
 arch/arm/vfp/entry.S                               |    3 +-
 arch/arm/vfp/vfphw.S                               |   16 +-
 arch/arm/vfp/vfpmodule.c                           |   55 ++-
 drivers/mfd/twl4030-irq.c                          |    4 +
 drivers/mfd/twl6030-irq.c                          |    6 +-
 drivers/misc/Kconfig                               |   14 +-
 include/asm-generic/resource.h                     |    8 +
 include/linux/resource.h                           |    6 -
 kernel/ipipe/core.c                                |   72 +-
 kernel/trace/Kconfig                               |    1 +
 161 files changed, 6160 insertions(+), 516 deletions(-)
 create mode 100644 arch/arm/include/asm/fcse.h
 create mode 100644 arch/arm/include/asm/ipipe.h
 create mode 100644 arch/arm/include/asm/ipipe_base.h
 create mode 100644 arch/arm/kernel/ipipe.c
 create mode 100644 arch/arm/kernel/ipipe_tsc.c
 create mode 100644 arch/arm/kernel/ipipe_tsc_asm.S
 create mode 100644 arch/arm/mach-at91/at91_ipipe_time.c
 create mode 100644 arch/arm/mm/fcse.c

-- 
                                                                Gilles.

