Message-ID: <4BE082A7.1040500@domain.hid>
Date: Tue, 04 May 2010 22:25:11 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] adeos-ipipe-2.6.31-arm-1.16-01 pull request.
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Adeos <adeos-main@gna.org>

The following changes since commit 9508665feb17608178a1c6b1051525d644de2f8f:
  Jan Kiszka (1):
        Disable both real and virtual interrupts during ftrace code changes

are available in the git repository at:

  git://git.xenomai.org/ipipe-gch.git for-ipipe-2.6.31-arm

Fabian Godehardt (1):
      Fix hang on 'Calibrating delay loop...' on S3C24xx

Gilles Chanteperdrix (27):
      FCSE: pid life cycle.
      FCSE: Conversions between VA and MVA.
      FCSE: Address-space limits.
      FCSE: differentiate cpu_tlb_mask from cpu_vm_mask.
      FCSE: Make the shared mappings uncacheable.
      "Best-effort" FCSE: choose whether to flush cache at run-time.
      "Best-effort" FCSE: Allow PID re-use.
      "Best-effort" FCSE: Handle shared mappings.
      "Best-effort" FCSE: Handle mappings above 32 MB
      FCSE: add Makefile and compilation option.
      adeos-ipipe-2.6.31-arm-1.15-01
      Add missing export symbol
      Add missing clobber for operations on cp15
      Fix memory layout
      Fix ptrace with FCSE
      Cosmetic fixes
      Add support for FCSE on Feroceon
      Track more accurately which tasks are currently in cache
      Dynamic FCSE pid-reallocation
      FCSE: finalize v4
      FCSE v4 optimizations
      Integrate I-pipe with FCSE v4
      Disable omap low-power irq controller feature
      Disable OMAP I2C irq line to avoid spurious irqs
      Reduce interrupt masking section for VFP exceptions handling
      Remove dead code
      adeos-ipipe-2.6.31-arm-1.16-01

Henri Roosen (1):
      Fix bug on imx31 when accessing hardware timer in user-space

 arch/arm/Kconfig                                   |    4 +
 arch/arm/boot/compressed/head.S                    |    9 +
 arch/arm/common/it8152.c                           |    7 +-
 arch/arm/include/asm/assembler.h                   |   24 +
 arch/arm/include/asm/atomic.h                      |   16 +-
 arch/arm/include/asm/bitops.h                      |   24 +-
 arch/arm/include/asm/cacheflush.h                  |   80 +++-
 arch/arm/include/asm/cpu-multi32.h                 |    5 +-
 arch/arm/include/asm/cpu-single.h                  |    3 +-
 arch/arm/include/asm/fcse.h                        |  177 +++++++
 arch/arm/include/asm/ipipe.h                       |  274 ++++++++++
 arch/arm/include/asm/ipipe_base.h                  |  108 ++++
 arch/arm/include/asm/irqflags.h                    |  130 ++++-
 arch/arm/include/asm/memory.h                      |    5 +
 arch/arm/include/asm/mmu.h                         |   11 +
 arch/arm/include/asm/mmu_context.h                 |  105 ++++-
 arch/arm/include/asm/pgtable.h                     |   59 ++-
 arch/arm/include/asm/proc-fns.h                    |    5 +-
 arch/arm/include/asm/processor.h                   |    5 +
 arch/arm/include/asm/resource.h                    |   10 +
 arch/arm/include/asm/system.h                      |   19 +-
 arch/arm/include/asm/thread_info.h                 |   12 +
 arch/arm/include/asm/tlbflush.h                    |   14 +-
 arch/arm/kernel/Makefile                           |    2 +
 arch/arm/kernel/entry-armv.S                       |  142 +++++-
 arch/arm/kernel/entry-common.S                     |   72 +++-
 arch/arm/kernel/entry-header.S                     |   11 +
 arch/arm/kernel/fcse.c                             |  465 +++++++++++++++++
 arch/arm/kernel/ipipe.c                            |  533 ++++++++++++++++++++
 arch/arm/kernel/irq.c                              |    2 +
 arch/arm/kernel/process.c                          |   10 +-
 arch/arm/kernel/ptrace.c                           |    4 +
 arch/arm/kernel/smp.c                              |    7 +-
 arch/arm/kernel/traps.c                            |   20 +
 arch/arm/mach-at91/Kconfig                         |   13 +
 arch/arm/mach-at91/Makefile                        |   11 +
 arch/arm/mach-at91/at91_ipipe_time.c               |  418 +++++++++++++++
 arch/arm/mach-at91/at91rm9200.c                    |   44 ++
 arch/arm/mach-at91/at91sam9260.c                   |   44 ++
 arch/arm/mach-at91/at91sam9261.c                   |   44 ++
 arch/arm/mach-at91/at91sam9263.c                   |   44 ++
 arch/arm/mach-at91/at91sam9rl.c                    |   44 ++
 arch/arm/mach-at91/gpio.c                          |   53 ++-
 arch/arm/mach-at91/include/mach/hardware.h         |   19 +
 arch/arm/mach-at91/include/mach/irqs.h             |    2 +
 arch/arm/mach-at91/include/mach/timex.h            |    2 +-
 arch/arm/mach-at91/irq.c                           |    3 +
 arch/arm/mach-integrator/core.c                    |  171 +++++--
 .../arm/mach-integrator/include/mach/entry-macro.S |    6 +-
 arch/arm/mach-integrator/include/mach/irqs.h       |    1 -
 arch/arm/mach-integrator/include/mach/platform.h   |    7 +-
 arch/arm/mach-integrator/include/mach/timex.h      |    4 +-
 arch/arm/mach-integrator/integrator_cp.c           |   20 +-
 arch/arm/mach-ixp4xx/common.c                      |  173 +++++++
 arch/arm/mach-mx3/devices.c                        |   13 +
 arch/arm/mach-mx3/mx31ads.c                        |    2 +-
 arch/arm/mach-mx3/mx31pdk.c                        |    3 +-
 arch/arm/mach-omap2/irq.c                          |   12 +-
 arch/arm/mach-omap2/timer-gp.c                     |  164 ++++++-
 arch/arm/mach-pxa/irq.c                            |    3 +
 arch/arm/mach-pxa/leds-idp.c                       |    1 +
 arch/arm/mach-pxa/leds-lubbock.c                   |    1 +
 arch/arm/mach-pxa/leds-mainstone.c                 |    1 +
 arch/arm/mach-pxa/lpd270.c                         |    3 +-
 arch/arm/mach-pxa/lubbock.c                        |    3 +-
 arch/arm/mach-pxa/mainstone.c                      |    3 +-
 arch/arm/mach-pxa/pcm990-baseboard.c               |    3 +-
 arch/arm/mach-pxa/time.c                           |  154 ++++++-
 arch/arm/mach-pxa/viper.c                          |    3 +-
 arch/arm/mach-s3c2410/include/mach/irqs.h          |    2 +
 arch/arm/mach-s3c2440/irq.c                        |    7 +-
 arch/arm/mach-sa1100/irq.c                         |    6 +-
 arch/arm/mach-sa1100/leds-assabet.c                |    1 +
 arch/arm/mach-sa1100/leds-badge4.c                 |    1 +
 arch/arm/mach-sa1100/leds-cerf.c                   |    1 +
 arch/arm/mach-sa1100/leds-hackkit.c                |    1 +
 arch/arm/mach-sa1100/leds-lart.c                   |    1 +
 arch/arm/mach-sa1100/leds-simpad.c                 |    1 +
 arch/arm/mach-sa1100/time.c                        |  153 ++++++-
 arch/arm/mm/Kconfig                                |   80 +++
 arch/arm/mm/alignment.c                            |    3 +
 arch/arm/mm/context.c                              |    7 +-
 arch/arm/mm/copypage-v4mc.c                        |    2 +-
 arch/arm/mm/copypage-xscale.c                      |    2 +-
 arch/arm/mm/fault-armv.c                           |   60 +++-
 arch/arm/mm/fault.c                                |   69 +++
 arch/arm/mm/flush.c                                |   29 +-
 arch/arm/mm/ioremap.c                              |    1 +
 arch/arm/mm/mmap.c                                 |   34 +-
 arch/arm/mm/pgd.c                                  |   50 ++-
 arch/arm/mm/proc-arm920.S                          |    9 +
 arch/arm/mm/proc-arm926.S                          |    9 +
 arch/arm/mm/proc-feroceon.S                        |   13 +
 arch/arm/mm/proc-xscale.S                          |    9 +
 arch/arm/plat-mxc/cpu.c                            |   28 +-
 arch/arm/plat-mxc/gpio.c                           |   18 +-
 arch/arm/plat-mxc/include/mach/common.h            |    4 +
 arch/arm/plat-mxc/time.c                           |  185 +++++++
 arch/arm/plat-omap/Kconfig                         |    2 +
 arch/arm/plat-omap/dmtimer.c                       |    7 +
 arch/arm/plat-omap/gpio.c                          |    3 +-
 arch/arm/plat-omap/include/mach/dmtimer.h          |    3 +
 arch/arm/plat-pxa/gpio.c                           |    5 +-
 arch/arm/plat-s3c/time.c                           |  211 +++++++--
 arch/arm/plat-s3c24xx/irq.c                        |   29 +-
 arch/arm/plat-s3c24xx/s3c244x-irq.c                |    9 +-
 arch/arm/vfp/entry.S                               |    3 +-
 arch/arm/vfp/vfphw.S                               |   13 +-
 arch/arm/vfp/vfpmodule.c                           |   37 +-
 drivers/i2c/busses/i2c-omap.c                      |   10 +
 drivers/misc/Kconfig                               |    2 +-
 include/asm-generic/resource.h                     |    8 +
 include/linux/lockdep.h                            |    2 +-
 include/linux/resource.h                           |    6 -
 kernel/trace/Kconfig                               |    1 +
 115 files changed, 4712 insertions(+), 291 deletions(-)
 create mode 100644 arch/arm/include/asm/fcse.h
 create mode 100644 arch/arm/include/asm/ipipe.h
 create mode 100644 arch/arm/include/asm/ipipe_base.h
 create mode 100644 arch/arm/kernel/fcse.c
 create mode 100644 arch/arm/kernel/ipipe.c
 create mode 100644 arch/arm/mach-at91/at91_ipipe_time.c

-- 
					    Gilles.

