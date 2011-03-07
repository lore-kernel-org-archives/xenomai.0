Message-ID: <4D74F4A5.5070208@domain.hid>
Date: Mon, 07 Mar 2011 16:07:17 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] Pull request for 2.6.35-arm
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Adeos <adeos-main@gna.org>

Beware, it is based on the patched 2.6.35-noarch branch for which the pull request was sent earlier.

The following changes since commit 934f47882879d0158825b56d1f14f5f4c6a765ab:
  Gilles Chanteperdrix (1):
        ipipe: inline irq_to_desc for non-sparse irqs

are available in the git repository at:

  git://git.xenomai.org/ipipe-gch.git for-ipipe-2.6.35-arm

Gilles Chanteperdrix (18):
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
      forward port, rebase on 2.6.35-noarch, adeos-ipipe-2.6.35-arm-1.18-01
      ipipe arm: get integrator CP to compile
      ipipe at91: return to periodic mode
      ipipe pxa: return the gpio flow handler to edge
      ipipe imx51: implement pic muting
      ipipe arm: avoid turning irqs off in __ipipe_mach_set_dec

Mika Westerberg (1):
      ARM: fix spinlock recursion in adjust_pte()

 arch/arm/Kconfig                                   |   11 +
 arch/arm/boot/compressed/head.S                    |    9 +
 arch/arm/common/it8152.c                           |    7 +-
 arch/arm/include/asm/assembler.h                   |   24 +
 arch/arm/include/asm/atomic.h                      |   16 +-
 arch/arm/include/asm/bitops.h                      |   24 +-
 arch/arm/include/asm/cacheflush.h                  |   75 ++-
 arch/arm/include/asm/cpu-multi32.h                 |   10 +
 arch/arm/include/asm/cpu-single.h                  |    5 +
 arch/arm/include/asm/fcse.h                        |  181 ++++++
 arch/arm/include/asm/ipipe.h                       |  340 ++++++++++
 arch/arm/include/asm/ipipe_base.h                  |  136 ++++
 arch/arm/include/asm/irqflags.h                    |  130 ++++-
 arch/arm/include/asm/memory.h                      |    5 +
 arch/arm/include/asm/mmu.h                         |   13 +-
 arch/arm/include/asm/mmu_context.h                 |  125 ++++-
 arch/arm/include/asm/percpu.h                      |    4 +
 arch/arm/include/asm/pgtable.h                     |   56 ++-
 arch/arm/include/asm/proc-fns.h                    |   13 +-
 arch/arm/include/asm/processor.h                   |    5 +
 arch/arm/include/asm/resource.h                    |   10 +
 arch/arm/include/asm/system.h                      |   17 +-
 arch/arm/include/asm/thread_info.h                 |   12 +
 arch/arm/include/asm/tlbflush.h                    |   14 +-
 arch/arm/kernel/Makefile                           |    4 +-
 arch/arm/kernel/entry-armv.S                       |  171 +++++-
 arch/arm/kernel/entry-common.S                     |   59 ++-
 arch/arm/kernel/entry-header.S                     |    6 +
 arch/arm/kernel/ipipe.c                            |  676 ++++++++++++++++++++
 arch/arm/kernel/ipipe_tsc.c                        |  113 ++++
 arch/arm/kernel/ipipe_tsc_asm.S                    |  165 +++++
 arch/arm/kernel/irq.c                              |    2 +
 arch/arm/kernel/process.c                          |   30 +-
 arch/arm/kernel/ptrace.c                           |    4 +
 arch/arm/kernel/smp.c                              |  123 +++-
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
 arch/arm/mach-integrator/core.c                    |    1 +
 .../arm/mach-integrator/include/mach/entry-macro.S |    6 +-
 arch/arm/mach-integrator/include/mach/irqs.h       |    1 -
 arch/arm/mach-integrator/include/mach/platform.h   |    6 +-
 arch/arm/mach-integrator/include/mach/timex.h      |    4 +-
 arch/arm/mach-integrator/integrator_cp.c           |   14 +-
 arch/arm/mach-ixp4xx/common.c                      |  100 +++-
 arch/arm/mach-ixp4xx/include/mach/platform.h       |    9 +-
 arch/arm/mach-mx1/clock.c                          |    3 +-
 arch/arm/mach-mx2/clock_imx21.c                    |    2 +-
 arch/arm/mach-mx2/clock_imx27.c                    |    3 +-
 arch/arm/mach-mx25/clock.c                         |    3 +-
 arch/arm/mach-mx25/devices.c                       |   12 +
 arch/arm/mach-mx3/clock-imx31.c                    |    3 +-
 arch/arm/mach-mx3/clock-imx35.c                    |    5 +-
 arch/arm/mach-mx3/devices.c                        |   13 +
 arch/arm/mach-mx3/mach-mx31_3ds.c                  |    3 +-
 arch/arm/mach-mx3/mach-mx31ads.c                   |    3 +-
 arch/arm/mach-mx5/clock-mx51.c                     |    2 +-
 arch/arm/mach-mxc91231/clock.c                     |    3 +-
 arch/arm/mach-omap2/irq.c                          |   86 +++-
 arch/arm/mach-omap2/timer-gp.c                     |  103 +++-
 arch/arm/mach-pxa/irq.c                            |    3 +
 arch/arm/mach-pxa/leds-idp.c                       |    1 +
 arch/arm/mach-pxa/leds-lubbock.c                   |    1 +
 arch/arm/mach-pxa/leds-mainstone.c                 |    1 +
 arch/arm/mach-pxa/lpd270.c                         |    3 +-
 arch/arm/mach-pxa/lubbock.c                        |    3 +-
 arch/arm/mach-pxa/mainstone.c                      |    3 +-
 arch/arm/mach-pxa/pcm990-baseboard.c               |    3 +-
 arch/arm/mach-pxa/time.c                           |   73 ++-
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
 arch/arm/mach-sa1100/irq.c                         |    6 +-
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
 arch/arm/mm/Kconfig                                |   82 +++
 arch/arm/mm/Makefile                               |    1 +
 arch/arm/mm/alignment.c                            |    3 +
 arch/arm/mm/context.c                              |   57 ++-
 arch/arm/mm/copypage-v4mc.c                        |    2 +-
 arch/arm/mm/copypage-xscale.c                      |    2 +-
 arch/arm/mm/fault-armv.c                           |   63 ++-
 arch/arm/mm/fault.c                                |   69 ++
 arch/arm/mm/fcse.c                                 |  466 ++++++++++++++
 arch/arm/mm/flush.c                                |    3 +-
 arch/arm/mm/ioremap.c                              |    1 +
 arch/arm/mm/mmap.c                                 |   37 +-
 arch/arm/mm/pgd.c                                  |   50 ++-
 arch/arm/mm/proc-arm920.S                          |    9 +
 arch/arm/mm/proc-arm926.S                          |    9 +
 arch/arm/mm/proc-feroceon.S                        |   13 +
 arch/arm/mm/proc-xscale.S                          |    9 +
 arch/arm/plat-mxc/cpu.c                            |   28 +-
 arch/arm/plat-mxc/gpio.c                           |   52 ++-
 arch/arm/plat-mxc/include/mach/common.h            |    6 +-
 arch/arm/plat-mxc/include/mach/gpio.h              |    5 +-
 arch/arm/plat-mxc/include/mach/irqs.h              |    4 +
 arch/arm/plat-mxc/irq.c                            |    4 +-
 arch/arm/plat-mxc/time.c                           |   97 +++-
 arch/arm/plat-mxc/tzic.c                           |   30 +
 arch/arm/plat-omap/Kconfig                         |    2 +
 arch/arm/plat-omap/dmtimer.c                       |   49 ++-
 arch/arm/plat-omap/gpio.c                          |  150 ++++-
 arch/arm/plat-omap/include/plat/dmtimer.h          |    5 +
 arch/arm/plat-omap/include/plat/irqs.h             |    2 +
 arch/arm/plat-pxa/gpio.c                           |    5 +-
 arch/arm/plat-s3c24xx/irq.c                        |   29 +-
 arch/arm/plat-samsung/include/plat/gpio-core.h     |    2 +-
 arch/arm/plat-samsung/time.c                       |  194 +++++--
 arch/arm/plat-versatile/include/plat/timer-sp.h    |    2 +-
 arch/arm/plat-versatile/timer-sp.c                 |   80 +++-
 arch/arm/vfp/entry.S                               |    3 +-
 arch/arm/vfp/vfphw.S                               |   16 +-
 arch/arm/vfp/vfpmodule.c                           |   45 +-
 drivers/mfd/twl4030-irq.c                          |    4 +
 drivers/misc/Kconfig                               |    2 +-
 include/asm-generic/resource.h                     |    8 +
 include/linux/resource.h                           |    6 -
 kernel/ipipe/core.c                                |   72 +-
 kernel/trace/Kconfig                               |    1 +
 148 files changed, 5364 insertions(+), 344 deletions(-)
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

