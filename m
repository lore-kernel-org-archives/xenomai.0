From: =?utf-8?Q?Christoph_M=C3=BCllner?=
 <christoph.muellner@theobroma-systems.com>
Message-Id: <37D41E97-DE59-44BA-984A-D8A08D6DDCB5@theobroma-systems.com>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Date: Tue, 14 Nov 2017 14:46:35 +0100
In-Reply-To: <28f6b55060c9421dbfc06a64973093e8@NANS01204.it.intra.sercel.com>
References: <28f6b55060c9421dbfc06a64973093e8@NANS01204.it.intra.sercel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] prepare-kernel.sh error on linux 4.9.24 for target
 arm64
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: MINIER Bertrand <Bertrand.MINIER@sercel.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>


> On 14 Nov 2017, at 13:59, MINIER Bertrand <Bertrand.MINIER@sercel.com> wrote:
> 
> Hi,
> 
> 
> I am trying to install the COBALT kernel alongside the linux v4.9.24 for the target AArch64 Cortex-A53.
> 
> 
> 
> I have executed the following script:
> 
> ./scripts/prepare-kernel.sh --linux=../../linux-repo --ipipe../../ipipe-core-4.9.24-arm64-2.patch --arch=arm

Hi Bertrand,

try with --arch=arm64

BR
Christoph

> 
> 
> 
> The xenomai code and ipipe patch came from the xenomai downloads site and the linux kernel comes from kernel.org
> 
> 
> 
> Can someone please help me understand why prepare-kernel.sh is failing?
> 
> 
> 
> Here's the output I got from the perpare-kernel.sh script:
> 
> 
> 
> patching file arch/arm64/Kconfig
> 
> patching file arch/arm64/include/asm/assembler.h
> 
> patching file arch/arm64/include/asm/ipipe.h
> 
> patching file arch/arm64/include/asm/ipipe_base.h
> 
> patching file arch/arm64/include/asm/ipipe_hwirq.h
> 
> patching file arch/arm64/include/asm/irqflags.h
> 
> patching file arch/arm64/include/asm/mmu_context.h
> 
> patching file arch/arm64/include/asm/proc-fns.h
> 
> patching file arch/arm64/include/asm/smp_plat.h
> 
> patching file arch/arm64/include/asm/thread_info.h
> 
> patching file arch/arm64/include/asm/uaccess.h
> 
> patching file arch/arm64/include/asm/unistd.h
> 
> patching file arch/arm64/kernel/Makefile
> 
> patching file arch/arm64/kernel/asm-offsets.c
> 
> patching file arch/arm64/kernel/entry.S
> 
> patching file arch/arm64/kernel/fpsimd.c
> 
> patching file arch/arm64/kernel/ipipe.c
> 
> patching file arch/arm64/kernel/process.c
> 
> patching file arch/arm64/kernel/ptrace.c
> 
> patching file arch/arm64/kernel/setup.c
> 
> patching file arch/arm64/kernel/signal.c
> 
> patching file arch/arm64/kernel/smp.c
> 
> patching file arch/arm64/kernel/traps.c
> 
> patching file arch/arm64/mm/context.c
> 
> patching file arch/arm64/mm/fault.c
> 
> patching file drivers/clocksource/arm_arch_timer.c
> 
> patching file drivers/clocksource/timer-sp804.c
> 
> patching file drivers/gpio/gpio-pl061.c
> 
> patching file drivers/irqchip/irq-gic-v3.c
> 
> patching file drivers/irqchip/irq-gic.c
> 
> patching file drivers/tty/serial/amba-pl011.c
> 
> patching file drivers/cpuidle/Kconfig
> 
> patching file drivers/iommu/irq_remapping.c
> 
> patching file drivers/tty/serial/8250/8250_core.c
> 
> patching file fs/exec.c
> 
> patching file include/asm-generic/atomic.h
> 
> patching file include/asm-generic/bitops/atomic.h
> 
> patching file include/asm-generic/cmpxchg-local.h
> 
> patching file include/asm-generic/percpu.h
> 
> patching file include/asm-generic/preempt.h
> 
> patching file include/asm-generic/switch_to.h
> 
> patching file include/clocksource/timer-sp804.h
> 
> patching file include/ipipe/setup.h
> 
> patching file include/ipipe/thread_info.h
> 
> patching file include/linux/clockchips.h
> 
> patching file include/linux/clocksource.h
> 
> patching file include/linux/console.h
> 
> patching file include/linux/ftrace.h
> 
> patching file include/linux/gpio/driver.h
> 
> patching file include/linux/hardirq.h
> 
> patching file include/linux/i8253.h
> 
> patching file include/linux/ipipe.h
> 
> patching file include/linux/ipipe_base.h
> 
> patching file include/linux/ipipe_compat.h
> 
> patching file include/linux/ipipe_debug.h
> 
> patching file include/linux/ipipe_domain.h
> 
> patching file include/linux/ipipe_lock.h
> 
> patching file include/linux/ipipe_tickdev.h
> 
> patching file include/linux/ipipe_trace.h
> 
> patching file include/linux/irq.h
> 
> patching file include/linux/irqchip/arm-gic.h
> 
> patching file include/linux/irqdesc.h
> 
> patching file include/linux/irqnr.h
> 
> patching file include/linux/kernel.h
> 
> patching file include/linux/kvm_host.h
> 
> patching file include/linux/preempt.h
> 
> patching file include/linux/printk.h
> 
> patching file include/linux/rwlock.h
> 
> patching file include/linux/rwlock_api_smp.h
> 
> patching file include/linux/sched.h
> 
> patching file include/linux/spinlock.h
> 
> patching file include/linux/spinlock_api_smp.h
> 
> patching file include/linux/spinlock_up.h
> 
> patching file include/linux/timekeeper_internal.h
> 
> patching file include/soc/fsl/qe/qe_ic.h
> 
> patching file include/uapi/asm-generic/mman-common.h
> 
> patching file include/uapi/asm-generic/resource.h
> 
> patching file include/uapi/linux/resource.h
> 
> patching file init/Kconfig
> 
> patching file init/main.c
> 
> patching file kernel/Makefile
> 
> patching file kernel/context_tracking.c
> 
> patching file kernel/debug/debug_core.c
> 
> patching file kernel/debug/gdbstub.c
> 
> patching file kernel/exit.c
> 
> patching file kernel/fork.c
> 
> patching file kernel/ipipe/Kconfig
> 
> patching file kernel/ipipe/Kconfig.debug
> 
> patching file kernel/ipipe/Makefile
> 
> patching file kernel/ipipe/compat.c
> 
> patching file kernel/ipipe/core.c
> 
> patching file kernel/ipipe/ipipe.c
> 
> patching file kernel/ipipe/timer.c
> 
> patching file kernel/ipipe/tracer.c
> 
> patching file kernel/irq/chip.c
> 
> patching file kernel/irq/generic-chip.c
> 
> patching file kernel/irq/internals.h
> 
> patching file kernel/irq/irqdesc.c
> 
> patching file kernel/irq/manage.c
> 
> patching file kernel/locking/lockdep.c
> 
> patching file kernel/locking/spinlock.c
> 
> patching file kernel/module.c
> 
> patching file kernel/panic.c
> 
> patching file kernel/power/hibernate.c
> 
> patching file kernel/printk/printk.c
> 
> patching file kernel/sched/core.c
> 
> patching file kernel/sched/idle.c
> 
> patching file kernel/sched/wait.c
> 
> patching file kernel/signal.c
> 
> patching file kernel/time/clockevents.c
> 
> patching file kernel/time/clocksource.c
> 
> patching file kernel/time/tick-common.c
> 
> patching file kernel/time/tick-sched.c
> 
> patching file kernel/time/timekeeping.c
> 
> patching file kernel/time/timer.c
> 
> patching file kernel/trace/Kconfig
> 
> patching file kernel/trace/ftrace.c
> 
> patching file kernel/trace/ring_buffer.c
> 
> patching file kernel/trace/trace.c
> 
> patching file kernel/trace/trace_clock.c
> 
> patching file kernel/trace/trace_functions.c
> 
> patching file kernel/trace/trace_functions_graph.c
> 
> patching file kernel/trace/trace_irqsoff.c
> 
> patching file lib/Kconfig.debug
> 
> patching file lib/atomic64.c
> 
> patching file lib/bust_spinlocks.c
> 
> patching file lib/ioremap.c
> 
> patching file lib/smp_processor_id.c
> 
> patching file mm/memory.c
> 
> patching file mm/mlock.c
> 
> patching file mm/mmap.c
> 
> patching file mm/mmu_context.c
> 
> patching file mm/mprotect.c
> 
> patching file mm/vmalloc.c
> 
> prepare-kernel.sh: /continuus/bm50210/linux-repo has no I-pipe support for arm
> 
> 
> 
> Having a look to the prepare-kernel.sh script, I seems it fails at line 350:
> 
> 
> 
> if test \! -r $linux_tree/arch/$linux_arch/include/asm/ipipe.h; then
> 
>   echo "$me: $linux_tree has no I-pipe support for $linux_arch" >&2
> 
>   exit 2
> 
> fi
> 
> 
> 
> I'm trying to apply the arm64 I-pipe patch so ipipe.h is applied to arch/arm64 /include/asm/ folder.
> 
> 
> 
> I also tried to call the prepare-script with arm64 argument but the script doesn't support it.
> 
> 
> 
> 
> 
> Thanks
> 
> 
> 
> Bertrand
> 
> 
> This e-mail and any accompanying attachments are confidential. If you are not the intended recipient, you must not review, disclose, copy, distribute or use this e-mail; please delete it from your system and notify the sender immediately.
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 874 bytes
Desc: Message signed with OpenPGP
URL: <http://xenomai.org/pipermail/xenomai/attachments/20171114/a810cb6f/attachment.sig>
