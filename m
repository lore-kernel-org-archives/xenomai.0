Message-ID: <511A196C.10506@siemens.com>
Date: Tue, 12 Feb 2013 11:29:00 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [PULL] ipipe: Establish new baseline using 3.8-rc7 and
	x86 support
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

Philippe,

The following changes since commit 836dc9e3fbbab0c30aa6e664417225f5c1fb1c39:

  Linux 3.8-rc7 (2013-02-09 08:20:39 +1100)

are available in the git repository at:
  git://git.xenomai.org/ipipe-jki for-upstream/master

Please consider pulling these as the baseline for the next I-pipe
version. On top of it, we should be able to add support for more archs.
Also, I will rebase my fixes for/additions of ftrace, kgdb and KVM
support over it.

Xenomai depends on my for-upstream queue to build and run. Tested
successfully on x86-64 (KVM and real HW) as well as x86-32 (KVM only).

Jan


Jan Kiszka (14):
      ipipe: Import generic and x86 bits based on 3.5.7-x86-3
      x86/ipipe: Disable eagerfpu under I-pipe
      x86/ipipe: Add missing irq_move handler to MSI and DMAR MSI irqchips
      ipipe: Export ipipe_root_only also for non-GPL modules
      ipipe: Export __ipipe_spin_unlock_debug also for non-GPL modules
      ipipe: Allow local_irq_enable/disable etc. for non-GPL modules
      ipipe: Mark tracer ops as recursion safe
      x86/ipipe: Fix irqoff tracing in __ipipe_syscall_root
      x86/ipipe: Stop saving/restoring flags in __ipipe_syscall_root
      x86/ipipe: Consolidate printing of I-pipe domain in show_regs
      x86/ipipe: Cleanup trivial spurious changes and whitespace damages
      ipipe: Clean up main Kconfig
      ipipe: Convert ipipe_check_irqoff into macro
      ipipe: Remove unused get_wall_to_monotonic

 arch/x86/Kconfig                         |    9 +-
 arch/x86/Kconfig.debug                   |    2 +-
 arch/x86/include/asm/apic.h              |    6 +
 arch/x86/include/asm/apicdef.h           |    3 +
 arch/x86/include/asm/desc.h              |    8 +
 arch/x86/include/asm/fpu-internal.h      |   10 +
 arch/x86/include/asm/hw_irq.h            |    2 +
 arch/x86/include/asm/i8259.h             |    2 +-
 arch/x86/include/asm/ipi.h               |   16 +-
 arch/x86/include/asm/ipipe.h             |  104 ++
 arch/x86/include/asm/ipipe_32.h          |   96 ++
 arch/x86/include/asm/ipipe_64.h          |   95 ++
 arch/x86/include/asm/ipipe_base.h        |  226 ++++
 arch/x86/include/asm/irq_vectors.h       |   11 +
 arch/x86/include/asm/irqflags.h          |  210 ++++
 arch/x86/include/asm/mmu_context.h       |   21 +-
 arch/x86/include/asm/page_64_types.h     |    4 +
 arch/x86/include/asm/processor.h         |    1 +
 arch/x86/include/asm/special_insns.h     |   12 +
 arch/x86/include/asm/switch_to.h         |    7 +-
 arch/x86/include/asm/thread_info.h       |    2 +
 arch/x86/include/asm/traps.h             |    2 +-
 arch/x86/include/asm/tsc.h               |    1 +
 arch/x86/kernel/Makefile                 |    1 +
 arch/x86/kernel/apic/apic.c              |   38 +-
 arch/x86/kernel/apic/apic_flat_64.c      |    4 +-
 arch/x86/kernel/apic/io_apic.c           |  205 +++-
 arch/x86/kernel/apic/ipi.c               |   20 +-
 arch/x86/kernel/apic/x2apic_cluster.c    |    4 +-
 arch/x86/kernel/apic/x2apic_phys.c       |    4 +-
 arch/x86/kernel/cpu/mtrr/cyrix.c         |   12 +-
 arch/x86/kernel/cpu/mtrr/generic.c       |   12 +-
 arch/x86/kernel/dumpstack_32.c           |    3 +
 arch/x86/kernel/dumpstack_64.c           |    3 +
 arch/x86/kernel/entry_32.S               |  155 +++-
 arch/x86/kernel/entry_64.S               |  246 ++++-
 arch/x86/kernel/hpet.c                   |   27 +-
 arch/x86/kernel/i387.c                   |    3 +
 arch/x86/kernel/i8253.c                  |    4 +
 arch/x86/kernel/i8259.c                  |   30 +-
 arch/x86/kernel/ipipe.c                  |  661 ++++++++++++
 arch/x86/kernel/irq.c                    |    7 +-
 arch/x86/kernel/irqinit.c                |   12 +
 arch/x86/kernel/pcspeaker.c              |    7 +
 arch/x86/kernel/process.c                |   27 +-
 arch/x86/kernel/process_32.c             |    2 +-
 arch/x86/kernel/process_64.c             |    4 +-
 arch/x86/kernel/ptrace.c                 |    5 +
 arch/x86/kernel/smp.c                    |    4 +-
 arch/x86/kernel/smpboot.c                |   10 +-
 arch/x86/kernel/traps.c                  |    4 +
 arch/x86/kernel/tsc.c                    |   12 +-
 arch/x86/kernel/vm86_32.c                |    4 +
 arch/x86/kernel/vsyscall_64.c            |    4 +
 arch/x86/kernel/xsave.c                  |    4 +
 arch/x86/kvm/svm.c                       |    4 +-
 arch/x86/kvm/vmx.c                       |   13 +-
 arch/x86/kvm/x86.c                       |   72 +-
 arch/x86/lib/mmx_32.c                    |    2 +-
 arch/x86/lib/thunk_64.S                  |   21 +
 arch/x86/mm/fault.c                      |   56 +-
 arch/x86/mm/tlb.c                        |    4 +
 arch/x86/platform/uv/tlb_uv.c            |    5 +
 drivers/clocksource/Makefile             |    3 +
 drivers/clocksource/i8253.c              |   55 +-
 drivers/clocksource/ipipe_i486_tsc_emu.S |  106 ++
 drivers/cpuidle/Kconfig                  |    1 +
 drivers/pci/htirq.c                      |    2 +-
 drivers/tty/serial/8250/8250.c           |   78 ++
 fs/exec.c                                |    3 +
 fs/proc/array.c                          |    4 +
 include/asm-generic/atomic.h             |   12 +-
 include/asm-generic/bitops/atomic.h      |    8 +-
 include/asm-generic/cmpxchg-local.h      |    8 +-
 include/asm-generic/percpu.h             |   18 +
 include/ipipe/setup.h                    |   10 +
 include/ipipe/thread_info.h              |   14 +
 include/linux/clockchips.h               |    9 +
 include/linux/clocksource.h              |    4 +
 include/linux/hardirq.h                  |    2 +
 include/linux/i8253.h                    |    3 +-
 include/linux/ipipe.h                    |  431 ++++++++
 include/linux/ipipe_base.h               |  359 ++++++
 include/linux/ipipe_compat.h             |  284 +++++
 include/linux/ipipe_debug.h              |   98 ++
 include/linux/ipipe_domain.h             |  311 ++++++
 include/linux/ipipe_lock.h               |  257 +++++
 include/linux/ipipe_tickdev.h            |  145 +++
 include/linux/ipipe_trace.h              |   77 ++
 include/linux/irq.h                      |   33 +-
 include/linux/irqdesc.h                  |   11 +
 include/linux/irqnr.h                    |    4 +
 include/linux/kernel.h                   |    8 +-
 include/linux/kvm_host.h                 |    3 +
 include/linux/preempt.h                  |   11 +-
 include/linux/rwlock.h                   |    8 +-
 include/linux/rwlock_api_smp.h           |    4 +-
 include/linux/sched.h                    |   31 +-
 include/linux/spinlock.h                 |   86 +-
 include/linux/spinlock_api_smp.h         |    6 +-
 include/linux/spinlock_up.h              |   14 +-
 include/uapi/asm-generic/mman-common.h   |    3 +
 include/uapi/asm-generic/resource.h      |    8 +
 include/uapi/linux/resource.h            |    6 -
 init/Kconfig                             |    1 +
 init/main.c                              |    9 +-
 kernel/Makefile                          |    1 +
 kernel/exit.c                            |    1 +
 kernel/fork.c                            |    4 +
 kernel/ipipe/Kconfig                     |   56 +
 kernel/ipipe/Kconfig.debug               |   95 ++
 kernel/ipipe/Makefile                    |    3 +
 kernel/ipipe/compat.c                    |  268 +++++
 kernel/ipipe/core.c                      | 1733 ++++++++++++++++++++++++++++++
 kernel/ipipe/timer.c                     |  482 +++++++++
 kernel/ipipe/tracer.c                    | 1444 +++++++++++++++++++++++++
 kernel/irq/chip.c                        |  150 +++
 kernel/irq/generic-chip.c                |   45 +-
 kernel/irq/irqdesc.c                     |    2 +
 kernel/lockdep.c                         |    8 +-
 kernel/panic.c                           |    3 +
 kernel/power/hibernate.c                 |    3 +
 kernel/printk.c                          |   94 ++-
 kernel/sched/core.c                      |   78 ++-
 kernel/signal.c                          |    4 +
 kernel/spinlock.c                        |    4 +-
 kernel/time/clockevents.c                |    4 +
 kernel/time/clocksource.c                |   92 ++
 kernel/time/tick-common.c                |    2 +-
 kernel/time/tick-sched.c                 |    2 +-
 kernel/timer.c                           |   19 +
 kernel/trace/Kconfig                     |    1 +
 kernel/trace/ftrace.c                    |   18 +-
 lib/Kconfig.debug                        |    2 +
 lib/bust_spinlocks.c                     |    2 +
 lib/ioremap.c                            |    4 +-
 lib/smp_processor_id.c                   |    5 +-
 mm/Kconfig                               |    1 +
 mm/memory.c                              |  143 ++-
 mm/mlock.c                               |   18 +
 mm/mmap.c                                |    2 +-
 mm/mmu_context.c                         |    5 +-
 mm/mprotect.c                            |    6 +
 mm/vmalloc.c                             |    2 +
 144 files changed, 9585 insertions(+), 334 deletions(-)
 create mode 100644 arch/x86/include/asm/ipipe.h
 create mode 100644 arch/x86/include/asm/ipipe_32.h
 create mode 100644 arch/x86/include/asm/ipipe_64.h
 create mode 100644 arch/x86/include/asm/ipipe_base.h
 create mode 100644 arch/x86/kernel/ipipe.c
 create mode 100644 drivers/clocksource/ipipe_i486_tsc_emu.S
 create mode 100644 include/ipipe/setup.h
 create mode 100644 include/ipipe/thread_info.h
 create mode 100644 include/linux/ipipe.h
 create mode 100644 include/linux/ipipe_base.h
 create mode 100644 include/linux/ipipe_compat.h
 create mode 100644 include/linux/ipipe_debug.h
 create mode 100644 include/linux/ipipe_domain.h
 create mode 100644 include/linux/ipipe_lock.h
 create mode 100644 include/linux/ipipe_tickdev.h
 create mode 100644 include/linux/ipipe_trace.h
 create mode 100644 kernel/ipipe/Kconfig
 create mode 100644 kernel/ipipe/Kconfig.debug
 create mode 100644 kernel/ipipe/Makefile
 create mode 100644 kernel/ipipe/compat.c
 create mode 100644 kernel/ipipe/core.c
 create mode 100644 kernel/ipipe/timer.c
 create mode 100644 kernel/ipipe/tracer.c

