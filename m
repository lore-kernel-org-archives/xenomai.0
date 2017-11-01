MIME-Version: 1.0
From: Danrae Pray <danrae.pray@metecs.com>
Date: Wed, 1 Nov 2017 13:13:31 -0500
Message-ID: <CAOocw5uUjKL5=jWd70z8nV5BbWyDxxaAtgb6+1hZaFknfbZj2w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Xenomai] prepare-kernel.sh error on Ubuntu 14.04
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

I am trying to install the COBALT kernel alongside the Ubuntu 14.04 kernel
in a VirtualBox VM and have executed the following script:

./scripts/prepare-kernel.sh --arch=x86_64 --linux=/usr/src/linux-4.4.95
--ipipe=/usr/src/ipipe-core-4.4.43-x86-8.patch

The xenomai code and ipipe patch came from the xenomai downloads site and
the linux distro is from kernel.org...

Can someone please help me understand why prepare-kernel.sh is failing?

Here's the output I got from the perpare-kernel.sh script:

checking file arch/x86/Kconfig
checking file arch/x86/entry/common.c
checking file arch/x86/entry/entry_32.S
checking file arch/x86/entry/entry_64.S
checking file arch/x86/entry/vsyscall/vsyscall_64.c
checking file arch/x86/entry/vsyscall/vsyscall_gtod.c
checking file arch/x86/include/asm/apic.h
checking file arch/x86/include/asm/apicdef.h
checking file arch/x86/include/asm/debugreg.h
checking file arch/x86/include/asm/desc.h
checking file arch/x86/include/asm/fpu/internal.h
checking file arch/x86/include/asm/fpu/types.h
checking file arch/x86/include/asm/hw_irq.h
checking file arch/x86/include/asm/i8259.h
checking file arch/x86/include/asm/ipi.h
checking file arch/x86/include/asm/ipipe.h
checking file arch/x86/include/asm/ipipe_32.h
checking file arch/x86/include/asm/ipipe_64.h
checking file arch/x86/include/asm/ipipe_base.h
checking file arch/x86/include/asm/irq_vectors.h
checking file arch/x86/include/asm/irqflags.h
checking file arch/x86/include/asm/mmu_context.h
checking file arch/x86/include/asm/preempt.h
checking file arch/x86/include/asm/processor.h
checking file arch/x86/include/asm/special_insns.h
checking file arch/x86/include/asm/switch_to.h
checking file arch/x86/include/asm/thread_info.h
checking file arch/x86/include/asm/traps.h
checking file arch/x86/include/asm/tsc.h
checking file arch/x86/kernel/Makefile
checking file arch/x86/kernel/apic/apic.c
checking file arch/x86/kernel/apic/apic_flat_64.c
checking file arch/x86/kernel/apic/htirq.c
checking file arch/x86/kernel/apic/io_apic.c
Hunk #12 FAILED at 1973.
Hunk #13 FAILED at 1984.
Hunk #14 succeeded at 2017 (offset 2 lines).
Hunk #15 succeeded at 2047 (offset 2 lines).
Hunk #16 succeeded at 2169 (offset 2 lines).
Hunk #17 succeeded at 2266 (offset 4 lines).
Hunk #18 succeeded at 2278 (offset 4 lines).
Hunk #19 succeeded at 2626 (offset 4 lines).
Hunk #20 succeeded at 3079 (offset 4 lines).
2 out of 20 hunks FAILED
checking file arch/x86/kernel/apic/ipi.c
checking file arch/x86/kernel/apic/msi.c
checking file arch/x86/kernel/apic/vector.c
checking file arch/x86/kernel/apic/x2apic_cluster.c
checking file arch/x86/kernel/apic/x2apic_phys.c
checking file arch/x86/kernel/asm-offsets.c
checking file arch/x86/kernel/cpu/common.c
checking file arch/x86/kernel/cpu/mcheck/mce.c
checking file arch/x86/kernel/cpu/mtrr/cyrix.c
checking file arch/x86/kernel/cpu/mtrr/generic.c
checking file arch/x86/kernel/fpu/core.c
checking file arch/x86/kernel/fpu/init.c
Hunk #2 succeeded at 290 (offset 1 line).
checking file arch/x86/kernel/hpet.c
Hunk #4 succeeded at 589 (offset 1 line).
Hunk #5 succeeded at 658 (offset 1 line).
checking file arch/x86/kernel/i8253.c
checking file arch/x86/kernel/i8259.c
checking file arch/x86/kernel/ipipe.c
checking file arch/x86/kernel/irq.c
checking file arch/x86/kernel/irq_64.c
checking file arch/x86/kernel/irqinit.c
checking file arch/x86/kernel/kgdb.c
checking file arch/x86/kernel/pcspeaker.c
checking file arch/x86/kernel/process.c
checking file arch/x86/kernel/process_32.c
checking file arch/x86/kernel/process_64.c
checking file arch/x86/kernel/smp.c
checking file arch/x86/kernel/smpboot.c
checking file arch/x86/kernel/traps.c
checking file arch/x86/kernel/tsc.c
checking file arch/x86/kernel/vm86_32.c
checking file arch/x86/kvm/svm.c
checking file arch/x86/kvm/vmx.c
Hunk #1 succeeded at 1981 (offset -1 lines).
Hunk #2 succeeded at 2358 (offset -1 lines).
Hunk #3 succeeded at 2388 (offset -1 lines).
Hunk #4 succeeded at 8391 (offset 9 lines).
Hunk #5 succeeded at 8839 (offset 21 lines).
Hunk #6 succeeded at 8868 with fuzz 2 (offset 21 lines).
checking file arch/x86/kvm/x86.c
Hunk #7 succeeded at 6587 (offset 31 lines).
Hunk #8 succeeded at 6604 (offset 31 lines).
checking file arch/x86/lib/Makefile
checking file arch/x86/lib/mmx_32.c
checking file arch/x86/lib/usercopy.c
checking file arch/x86/mm/fault.c
checking file arch/x86/mm/tlb.c
checking file drivers/clocksource/Makefile
checking file drivers/clocksource/i8253.c
checking file drivers/clocksource/ipipe_i486_tsc_emu.S
checking file drivers/pci/htirq.c
checking file drivers/cpuidle/Kconfig
checking file drivers/iommu/irq_remapping.c
checking file drivers/tty/serial/8250/8250_core.c
checking file fs/exec.c
Hunk #1 succeeded at 866 (offset 21 lines).
Hunk #2 succeeded at 890 (offset 21 lines).
checking file include/asm-generic/atomic.h
checking file include/asm-generic/bitops/atomic.h
checking file include/asm-generic/cmpxchg-local.h
checking file include/asm-generic/percpu.h
Hunk #2 succeeded at 159 (offset 20 lines).
Hunk #3 succeeded at 179 (offset 20 lines).
Hunk #4 succeeded at 190 (offset 20 lines).
Hunk #5 succeeded at 202 (offset 20 lines).
checking file include/asm-generic/preempt.h
checking file include/asm-generic/switch_to.h
checking file include/clocksource/timer-sp804.h
checking file include/ipipe/setup.h
checking file include/ipipe/thread_info.h
checking file include/linux/basic_mmio_gpio.h
checking file include/linux/clockchips.h
checking file include/linux/clocksource.h
checking file include/linux/console.h
checking file include/linux/ftrace.h
checking file include/linux/hardirq.h
checking file include/linux/i8253.h
checking file include/linux/ipipe.h
checking file include/linux/ipipe_base.h
checking file include/linux/ipipe_compat.h
checking file include/linux/ipipe_debug.h
checking file include/linux/ipipe_domain.h
checking file include/linux/ipipe_lock.h
checking file include/linux/ipipe_tickdev.h
checking file include/linux/ipipe_trace.h
checking file include/linux/irq.h
checking file include/linux/irqchip/arm-gic.h
checking file include/linux/irqdesc.h
checking file include/linux/irqnr.h
checking file include/linux/kernel.h
checking file include/linux/kvm_host.h
checking file include/linux/preempt.h
checking file include/linux/printk.h
checking file include/linux/rwlock.h
checking file include/linux/rwlock_api_smp.h
checking file include/linux/sched.h
Hunk #5 succeeded at 1775 (offset 14 lines).
checking file include/linux/spinlock.h
checking file include/linux/spinlock_api_smp.h
checking file include/linux/spinlock_up.h
checking file include/linux/timekeeper_internal.h
Hunk #1 succeeded at 132 (offset -1 lines).
checking file include/uapi/asm-generic/mman-common.h
checking file include/uapi/asm-generic/resource.h
checking file include/uapi/linux/resource.h
checking file init/Kconfig
checking file init/main.c
checking file kernel/Makefile
checking file kernel/context_tracking.c
checking file kernel/debug/debug_core.c
checking file kernel/debug/gdbstub.c
checking file kernel/exit.c
checking file kernel/fork.c
Hunk #1 succeeded at 363 (offset 1 line).
Hunk #2 succeeded at 707 (offset 1 line).
Hunk #3 succeeded at 1642 (offset 4 lines).
checking file kernel/ipipe/Kconfig
checking file kernel/ipipe/Kconfig.debug
checking file kernel/ipipe/Makefile
checking file kernel/ipipe/compat.c
checking file kernel/ipipe/core.c
checking file kernel/ipipe/ipipe.c
checking file kernel/ipipe/timer.c
checking file kernel/ipipe/tracer.c
checking file kernel/irq/chip.c
checking file kernel/irq/generic-chip.c
checking file kernel/irq/internals.h
checking file kernel/irq/irqdesc.c
checking file kernel/irq/manage.c
checking file kernel/locking/lockdep.c
checking file kernel/locking/spinlock.c
checking file kernel/module.c
checking file kernel/panic.c
checking file kernel/power/hibernate.c
checking file kernel/printk/printk.c
checking file kernel/sched/core.c
Hunk #16 succeeded at 8676 (offset 24 lines).
checking file kernel/sched/wait.c
checking file kernel/signal.c
Hunk #1 succeeded at 647 (offset 8 lines).
Hunk #2 succeeded at 874 (offset 8 lines).
checking file kernel/time/clockevents.c
checking file kernel/time/clocksource.c
checking file kernel/time/tick-common.c
checking file kernel/time/tick-sched.c
checking file kernel/time/timekeeping.c
Hunk #1 succeeded at 489 (offset 22 lines).
checking file kernel/time/timer.c
checking file kernel/trace/Kconfig
checking file kernel/trace/ftrace.c
Hunk #6 succeeded at 4914 (offset 11 lines).
Hunk #7 succeeded at 5016 (offset 11 lines).
Hunk #8 succeeded at 5213 (offset 11 lines).
checking file kernel/trace/ring_buffer.c
checking file kernel/trace/trace.c
checking file kernel/trace/trace_clock.c
checking file kernel/trace/trace_functions.c
checking file kernel/trace/trace_functions_graph.c
checking file kernel/trace/trace_irqsoff.c
checking file lib/Kconfig.debug
checking file lib/atomic64.c
checking file lib/bust_spinlocks.c
checking file lib/ioremap.c
checking file lib/smp_processor_id.c
checking file mm/memory.c
Hunk #6 succeeded at 3935 (offset -37 lines).
checking file mm/mlock.c
Hunk #1 succeeded at 794 (offset 1 line).
checking file mm/mmap.c
Hunk #2 succeeded at 2793 (offset 34 lines).
checking file mm/mmu_context.c
checking file mm/mprotect.c
Hunk #2 succeeded at 96 (offset 1 line).
Hunk #3 succeeded at 109 (offset 1 line).
Hunk #4 succeeded at 253 (offset 1 line).
checking file mm/vmalloc.c
prepare-kernel.sh: Unable to patch kernel 4.4.95 with
ipipe-core-4.4.43-x86-8.patch.

Thanks,
Danrae
