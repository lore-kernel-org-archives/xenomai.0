Date: Wed, 03 Sep 2008 22:26:07 -0700
From: Sam Ferguson <samf48@domain.hid>
Message-ID: <C4E4BF7F.8A0%samf48@domain.hid>
In-Reply-To: <48BE4846.1050307@domain.hid>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Content-transfer-encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai kernel compile issue
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, Xenomai help <xenomai@xenomai.org>

Ok, so I updated my kernel and tried again, the script doesn't error out but
it also doesn't say that it finished. Here's what happens:
igvc@domain.hid$ sudo scripts/prepare-kernel.sh
Linux tree [default /lib/modules/2.6.24-19-generic/source]:
/usr/src/linux-2.6.26.3
Target architecture [default i686]:
Adeos patch [default
/usr/src/xenomai-2.4.4/ksrc/arch/x86/patches/adeos-ipipe-2.6.26-x86-2.0-09.p
atch]: 
patching file Makefile
patching file arch/x86/Kconfig
patching file arch/x86/Makefile
patching file arch/x86/boot/Makefile
patching file arch/x86/boot/compressed/Makefile
patching file arch/x86/kernel/Makefile
patching file arch/x86/kernel/apic_32.c
patching file arch/x86/kernel/apic_64.c
patching file arch/x86/kernel/cpu/mtrr/cyrix.c
patching file arch/x86/kernel/cpu/mtrr/generic.c
patching file arch/x86/kernel/entry_32.S
patching file arch/x86/kernel/entry_64.S
patching file arch/x86/kernel/genapic_flat_64.c
patching file arch/x86/kernel/head64.c
patching file arch/x86/kernel/i8253.c
patching file arch/x86/kernel/i8259_32.c
patching file arch/x86/kernel/i8259_64.c
patching file arch/x86/kernel/io_apic_32.c
patching file arch/x86/kernel/io_apic_64.c
patching file arch/x86/kernel/ipi.c
patching file arch/x86/kernel/ipipe.c
patching file arch/x86/kernel/irq_32.c
patching file arch/x86/kernel/irq_64.c
patching file arch/x86/kernel/mcount_32.S
patching file arch/x86/kernel/mcount_64.S
patching file arch/x86/kernel/nmi_32.c
patching file arch/x86/kernel/nmi_64.c
patching file arch/x86/kernel/process.c
patching file arch/x86/kernel/process_32.c
patching file arch/x86/kernel/process_64.c
patching file arch/x86/kernel/setup64.c
patching file arch/x86/kernel/smp.c
patching file arch/x86/kernel/smpboot.c
patching file arch/x86/kernel/time_32.c
patching file arch/x86/kernel/tlb_32.c
patching file arch/x86/kernel/tlb_64.c
patching file arch/x86/kernel/traps_32.c
patching file arch/x86/kernel/traps_64.c
patching file arch/x86/kernel/vm86_32.c
patching file arch/x86/kernel/vsyscall_64.c
patching file arch/x86/lib/mmx_32.c
patching file arch/x86/lib/thunk_64.S
patching file arch/x86/mach-visws/visws_apic.c
patching file arch/x86/mm/fault.c
patching file drivers/pci/htirq.c
patching file drivers/serial/8250.c
patching file include/asm-generic/cmpxchg-local.h
patching file include/asm-x86/apic.h
patching file include/asm-x86/hw_irq_32.h
patching file include/asm-x86/hw_irq_64.h
patching file include/asm-x86/i8259.h
patching file include/asm-x86/ipi.h
patching file include/asm-x86/ipipe.h
patching file include/asm-x86/ipipe_32.h
patching file include/asm-x86/ipipe_64.h
patching file include/asm-x86/ipipe_base.h
patching file include/asm-x86/ipipe_base_32.h
patching file include/asm-x86/ipipe_base_64.h
patching file include/asm-x86/irqflags.h
patching file include/asm-x86/mmu_context_32.h
patching file include/asm-x86/mmu_context_64.h
patching file include/asm-x86/nmi.h
patching file include/asm-x86/processor.h
patching file include/asm-x86/system.h
patching file include/asm-x86/unistd_32.h
patching file include/asm-x86/unistd_64.h
patching file include/asm-x86/vsyscall.h
patching file include/linux/hardirq.h
patching file include/linux/ipipe.h
patching file include/linux/ipipe_base.h
patching file include/linux/ipipe_compat.h
patching file include/linux/ipipe_percpu.h
patching file include/linux/ipipe_tickdev.h
patching file include/linux/ipipe_trace.h
patching file include/linux/irq.h
patching file include/linux/kernel.h
patching file include/linux/linkage.h
patching file include/linux/mm.h
patching file include/linux/preempt.h
patching file include/linux/sched.h
patching file include/linux/spinlock.h
patching file include/linux/spinlock_types.h
patching file init/Kconfig
patching file init/main.c
patching file kernel/Makefile
patching file kernel/exit.c
patching file kernel/fork.c
patching file kernel/ipipe/Kconfig
patching file kernel/ipipe/Kconfig.debug
patching file kernel/ipipe/Makefile
patching file kernel/ipipe/core.c
patching file kernel/ipipe/tracer.c
patching file kernel/irq/chip.c
patching file kernel/irq/handle.c
patching file kernel/lockdep.c
patching file kernel/power/disk.c
patching file kernel/printk.c
patching file kernel/sched.c
patching file kernel/signal.c
patching file kernel/spinlock.c
patching file kernel/time/tick-common.c
patching file lib/Kconfig.debug
patching file lib/bust_spinlocks.c
patching file lib/ioremap.c
patching file lib/smp_processor_id.c
patching file lib/spinlock_debug.c
patching file mm/memory.c
Hunk #8 succeeded at 2953 (offset 10 lines).
patching file mm/mlock.c
Hunk #1 succeeded at 171 (offset -2 lines).
patching file mm/vmalloc.c
igvc@domain.hid$




On 9/3/08 1:18 AM, "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
wrote:

> Sam Ferguson wrote:
>> Ok it must be a kernel patch issue.  When I patched it initially it seemed
>> to go through, it returned me to the terminal with no errors.  So I tried to
>> patch the kernel doing by running the script from xenomai.  Here is what
>> happens:
>> 
>> igvc@domain.hid$ scripts/prepare-kernel.sh
> 
> Please use the latest release of xenomai.
> 
>> Linux tree [default /lib/modules/2.6.24-19-generic/source]:
>> /lib/modules/2.6.24-19-generic/build
>> Target architecture [default i686]:
>> Adeos patch [default /dev/null]:
>> /usr/src/xenomai-2.4.4/ksrc/arch/x86/patches/adeos-ipipe-2.6.26-x86-2.0-09.p
>> atch
> 
> If you are trying to patch a 2.6.24 kernel with the Adeos patch for
> 2.6.26, it will not work.
> 
> Please do not forget to CC the list.



