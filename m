Message-ID: <502565A4.1040604@xenomai.org>
Date: Fri, 10 Aug 2012 21:48:52 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] core-3.4 pull request
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <Xenomai@xenomai.org>

The following changes since commit 475836ccc516763b2ea478dbfbbe8bc01d48a210:

  Merge remote-tracking branch 'gilles-3.4' into core-3.4 (2012-07-28 23:02:38 +0200)

are available in the git repository at:

  git://git.xenomai.org/ipipe-gch.git for-core-3.4

Gilles Chanteperdrix (21):
      ipipe: allow ipi to be handled as virq
      ipipe/arm: fix IPIs handling
      ipipe/arm: fix arm926 detection
      ipipe/arm: rework __switch_mm
      ipipe/arm: fix mm switch with CONFIG_ARM_FCSE_BEST_EFFORT
      ipipe/blackfin: provide ipipe_head_switch_mm
      ipipe/powerpc: provide ipipe_head_switch_mm
      ipipe/x86: provide ipipe_head_switch_mm
      ipipe/arm: mask eoi irq before eoi for GIC
      ipipe/x86: do not restore during context switch
      ipipe/x86: mask io_apic EOI irq before EOI
      ipipe/core: call irq_to_desc only once during irq handling
      ipipe/core: bump API rev to 2 (for ipipe_head_switch_mm)
      ipipe/arm: fix SMP cpu_logical_map initialization
      ipipe/arm: normalize frequencies
      ipipe/blackfin: define __ipipe_hrclock_freq
      ipipe/powerpc: fix __ipipe_hrclock_freq definition
      ipipe/timers: allow requesting timers only on some cpus
      ipipe/timers: get ipipe_timer_set to do the clock to timer frequency conversion
      ipipe/arm: convert ixp4xx to kuser tsc emulation
      ipipe/arm: fix thumb build

 arch/arm/Kconfig                        |    1 +
 arch/arm/common/gic.c                   |    6 +-
 arch/arm/include/asm/ipipe.h            |   13 ++--
 arch/arm/include/asm/ipipe_base.h       |    4 +-
 arch/arm/include/asm/mmu_context.h      |   92 +++++++++++-------------
 arch/arm/kernel/ipipe.c                 |   45 +++++++++++-
 arch/arm/kernel/ipipe_tsc_asm.S         |    2 +
 arch/arm/kernel/setup.c                 |    9 ++-
 arch/arm/kernel/smp.c                   |   28 +++++--
 arch/arm/mach-ixp4xx/common.c           |  118 ++++++-------------------------
 arch/arm/mm/fcse.c                      |    1 +
 arch/arm/vfp/vfphw.S                    |    6 +-
 arch/blackfin/include/asm/ipipe.h       |    3 +
 arch/blackfin/include/asm/mmu_context.h |    3 +
 arch/powerpc/include/asm/ipipe.h        |    2 +-
 arch/powerpc/include/asm/mmu_context.h  |    3 +
 arch/x86/include/asm/fpu-internal.h     |   10 +++
 arch/x86/include/asm/mmu_context.h      |    3 +
 arch/x86/kernel/apic/io_apic.c          |    2 +-
 include/linux/ipipe.h                   |    3 +-
 include/linux/ipipe_base.h              |    2 +-
 include/linux/ipipe_tickdev.h           |   10 ++-
 kernel/ipipe/core.c                     |   13 +++-
 kernel/ipipe/timer.c                    |   56 +++++++++------
 kernel/sched/core.c                     |    4 +
 25 files changed, 233 insertions(+), 206 deletions(-)

-- 
                                                                Gilles.

