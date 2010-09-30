Message-ID: <4CA5157D.8080505@domain.hid>
Date: Fri, 01 Oct 2010 00:55:57 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] [pull request] ipipe-2.6.33-arm-1.18-00
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Adeos <adeos-main@gna.org>

The following changes since commit b94a1b70ad2675f45d177aec16a814695a799a99:
  Philippe Gerum (1):
        Merge remote branch 'gilles-2.6.33' into ipipe-2.6.33-arm

are available in the git repository at:

  git://git.xenomai.org/ipipe-gch.git for-ipipe-2.6.33-arm

Gilles Chanteperdrix (34):
      chained irqs: align on powerpc implementation
      Merge commit 'origin/ipipe-2.6.33-noarch' into new-for-ipipe-2.6.33-arm
      remove traces of previous gpio muxing code
      ipipe_sync_pipeline no longer need arguments
      add missing definition of __ipipe_mach_ext_hrtimer_p
      at91: move ipipe_halt_root to process.c
      mxc: ipipe_cpu_freq() -> __ipipe_cpu_freq
      id_lock: only init in SMP case
      irq: avoid duplicating test.
      streamline traps event dispatching
      streamline syscall handling
      remove leftover from fcse v3
      Re-run check_context when restarting root context switches
      ipipe arm: Fix compilation of I-pipe tracer
      arm/ipipe: inline calls to __ipipe_check_root* in entry-armv.S when not SMP
      Merge commit 'origin/ipipe-2.6.33-noarch' into for-ipipe-2.6.33-arm
      arm/ipipe: fix inlined assembly replacement for ipipe_check_root*
      ipipe arm: add infrastructure for tsc emulation code
      ipipe arm & AT91: rework pic muting
      fcse: rework debug messages
      ipipe AT91: re-enable IRQS when demultiplexing GPIOs
      ipipe AT91: Use common tsc emulation
      ipipe omap: reduce interrupt overhead
      ipipe omap: implement pic muting
      ipipe omap: allow requesting non posted timers
      ipipe omap: use the common tsc emulation
      ipipe omap: change the dmtimers used
      ipipe ixp4xx: use the common tsc emulation
      ipipe mxc: use the common tsc emulation
      ipipe pxa: use the common tsc emulation
      ipipe s3c: use the common tsc emulation
      ipipe sa1100: use the common tsc emulation
      ipipe omap: A better fix for the twl4030 interrupts issue
      adeos-ipipe-2.6.33-arm-1.18-00

Philippe Gerum (11):
      ipipe: remove extraneous arg from ipipe_root_cpudom_ptr()
      ipipe: introduce ipipe-conditional warnings
      ipipe: add debug checks to IRQ bitmap updates
      ipipe: remove "virtual irq only" pipeline sync option
      arm/ipipe: introduce SMP support
      ipipe: split the pipeline init code
      ipipe: virtual IRQ may inherit the root acknowledge handler
      ipipe: remove prefetching
      arm/ipipe: remove references to obsolete fcse_tlb_mask
      arm/ipipe: make default __my_cpu_offset domain-safe
      arm/ipipe: do not fetch irq_desc for virqs

 arch/arm/Kconfig                          |    7 +
 arch/arm/common/it8152.c                  |    6 +-
 arch/arm/include/asm/ipipe.h              |  210 ++++++++---
 arch/arm/include/asm/ipipe_base.h         |   37 ++-
 arch/arm/include/asm/mmu_context.h        |   36 ++-
 arch/arm/include/asm/percpu.h             |    4 +
 arch/arm/include/asm/system.h             |    6 +-
 arch/arm/kernel/Makefile                  |    1 +
 arch/arm/kernel/entry-armv.S              |  158 +++++---
 arch/arm/kernel/entry-common.S            |   27 +-
 arch/arm/kernel/fcse.c                    |   20 +-
 arch/arm/kernel/ipipe.c                   |  579 ++++++++++++++++++++---------
 arch/arm/kernel/ipipe_tsc.c               |  113 ++++++
 arch/arm/kernel/ipipe_tsc_asm.S           |  167 +++++++++
 arch/arm/kernel/process.c                 |   40 ++-
 arch/arm/kernel/smp.c                     |  154 +++++++-
 arch/arm/kernel/traps.c                   |   10 -
 arch/arm/mach-at91/at91_ipipe_time.c      |  138 +------
 arch/arm/mach-at91/gpio.c                 |   91 ++++-
 arch/arm/mach-integrator/integrator_cp.c  |    2 +-
 arch/arm/mach-ixp4xx/common.c             |  173 +++-------
 arch/arm/mach-mx3/mx31ads.c               |    2 +-
 arch/arm/mach-mx3/mx31pdk.c               |    2 +-
 arch/arm/mach-omap2/irq.c                 |   83 ++++-
 arch/arm/mach-omap2/timer-gp.c            |  119 ++-----
 arch/arm/mach-pxa/lpd270.c                |    2 +-
 arch/arm/mach-pxa/lubbock.c               |    2 +-
 arch/arm/mach-pxa/mainstone.c             |    2 +-
 arch/arm/mach-pxa/pcm990-baseboard.c      |    2 +-
 arch/arm/mach-pxa/time.c                  |  172 +++------
 arch/arm/mach-pxa/viper.c                 |    2 +-
 arch/arm/mach-s3c2440/irq.c               |    4 +-
 arch/arm/mach-sa1100/irq.c                |    2 +-
 arch/arm/mach-sa1100/time.c               |   95 +----
 arch/arm/mm/context.c                     |  163 ++++++++-
 arch/arm/plat-mxc/gpio.c                  |    2 +-
 arch/arm/plat-mxc/time.c                  |  206 +++--------
 arch/arm/plat-omap/dmtimer.c              |   44 ++-
 arch/arm/plat-omap/gpio.c                 |  145 +++++++-
 arch/arm/plat-omap/include/plat/dmtimer.h |    2 +
 arch/arm/plat-omap/include/plat/irqs.h    |    2 +
 arch/arm/plat-pxa/gpio.c                  |    2 +-
 arch/arm/plat-s3c/time.c                  |   58 ++--
 arch/arm/plat-s3c24xx/irq.c               |   14 +-
 arch/arm/plat-s3c24xx/s3c244x-irq.c       |    4 +-
 arch/arm/vfp/vfphw.S                      |    3 +
 arch/arm/vfp/vfpmodule.c                  |    5 +-
 drivers/mfd/twl4030-irq.c                 |    7 +-
 include/linux/ipipe.h                     |   16 +-
 include/linux/ipipe_base.h                |    3 -
 include/linux/ipipe_percpu.h              |    2 +-
 init/main.c                               |    1 +
 kernel/ipipe/Kconfig.debug                |    2 -
 kernel/ipipe/core.c                       |   94 ++---
 54 files changed, 2008 insertions(+), 1235 deletions(-)
 create mode 100644 arch/arm/kernel/ipipe_tsc.c
 create mode 100644 arch/arm/kernel/ipipe_tsc_asm.S

-- 
                                                                Gilles.

