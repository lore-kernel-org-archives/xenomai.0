From: lux-integ <lux-integ@domain.hid>
Date: Fri, 19 Feb 2010 15:43:41 +0000
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <201002191543.41733.lux-integ@domain.hid>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] help with adeos-ipipe-2.6.32.7-x86-2.6-00.patch
	patch on pure 64-bit x86_64 setup
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Greetings,

I am having some difficulty using this  patch:-
http://download.gna.org/adeos/patches/v2.6/x86/adeos-ipipe-2.6.32.7-x86-2.6-00.patch

 with Xenomai-2.51.  (The machine uses AMD64cpu athlonX2,  Linux is CLFS/pure 
64-bit, gcc-4.4.2, gibc-2.10.2 (I think))

this is what I did:
a) I downloaded  Xenomai-2.5.1  AND  linux kernel source linux-2.6.32.7  AND  
the patch above
b) I patched the kernel source    like so:-

$SOURCES/xenomai-2.5.1/scripts/prepare-kernel.sh --linux=/usr/src/linux  --adeos=$SOURCES/xenomai251-fix/adeos-ipipe-2.6.32.7-x86-2.6-00.patch  --arch=x86_64

results are below:-
------------------------------------------------------------
linux-2.6.32.7' -> `linux-2.6.32.7XN251-smp'
`linux' -> `linux-2.6.32.7XN251-smp'
###################################
 patching with downloaded 2.6.00.patch
###################################
patching file arch/x86/Kconfig
patching file arch/x86/include/asm/apic.h
patching file arch/x86/include/asm/apicdef.h
patching file arch/x86/include/asm/entry_arch.h
patching file arch/x86/include/asm/hw_irq.h
patching file arch/x86/include/asm/i387.h
patching file arch/x86/include/asm/i8259.h
patching file arch/x86/include/asm/ipi.h
patching file arch/x86/include/asm/ipipe.h
patching file arch/x86/include/asm/ipipe_32.h
patching file arch/x86/include/asm/ipipe_64.h
patching file arch/x86/include/asm/ipipe_base.h
patching file arch/x86/include/asm/irq_vectors.h
patching file arch/x86/include/asm/irqflags.h
patching file arch/x86/include/asm/mmu_context.h
patching file arch/x86/include/asm/nmi.h
patching file arch/x86/include/asm/processor.h
patching file arch/x86/include/asm/system.h
patching file arch/x86/include/asm/traps.h
patching file arch/x86/kernel/Makefile
patching file arch/x86/kernel/apic/apic.c
patching file arch/x86/kernel/apic/apic_flat_64.c
patching file arch/x86/kernel/apic/io_apic.c
patching file arch/x86/kernel/apic/ipi.c
patching file arch/x86/kernel/apic/nmi.c
patching file arch/x86/kernel/apic/x2apic_cluster.c
patching file arch/x86/kernel/apic/x2apic_phys.c
patching file arch/x86/kernel/cpu/mtrr/cyrix.c
patching file arch/x86/kernel/cpu/mtrr/generic.c
patching file arch/x86/kernel/dumpstack.c
patching file arch/x86/kernel/dumpstack_32.c
patching file arch/x86/kernel/dumpstack_64.c
patching file arch/x86/kernel/entry_32.S
patching file arch/x86/kernel/entry_64.S
patching file arch/x86/kernel/i8253.c
patching file arch/x86/kernel/i8259.c
patching file arch/x86/kernel/ipipe.c
patching file arch/x86/kernel/irq.c
patching file arch/x86/kernel/irqinit.c
patching file arch/x86/kernel/process.c
patching file arch/x86/kernel/process_32.c
patching file arch/x86/kernel/process_64.c
patching file arch/x86/kernel/smp.c
patching file arch/x86/kernel/smpboot.c
patching file arch/x86/kernel/time.c
patching file arch/x86/kernel/traps.c
patching file arch/x86/kernel/vm86_32.c
patching file arch/x86/lib/mmx_32.c
patching file arch/x86/lib/thunk_64.S
patching file arch/x86/mm/fault.c
patching file arch/x86/mm/tlb.c
patching file drivers/pci/htirq.c
patching file drivers/serial/8250.c
patching file fs/exec.c
patching file include/asm-generic/atomic.h
patching file include/asm-generic/bitops/atomic.h
patching file include/asm-generic/cmpxchg-local.h
patching file include/asm-generic/percpu.h
patching file include/linux/hardirq.h
patching file include/linux/ipipe.h
patching file include/linux/ipipe_base.h
patching file include/linux/ipipe_compat.h
patching file include/linux/ipipe_lock.h
patching file include/linux/ipipe_percpu.h
patching file include/linux/ipipe_tickdev.h
patching file include/linux/ipipe_trace.h
patching file include/linux/irq.h
patching file include/linux/kernel.h
patching file include/linux/preempt.h
patching file include/linux/sched.h
patching file include/linux/spinlock.h
patching file include/linux/spinlock_api_smp.h
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
patching file kernel/panic.c
patching file kernel/power/hibernate.c
patching file kernel/printk.c
patching file kernel/sched.c
patching file kernel/signal.c
patching file kernel/spinlock.c
patching file kernel/time/tick-common.c
patching file kernel/time/tick-sched.c
patching file kernel/timer.c
patching file kernel/trace/ftrace.c
patching file lib/Kconfig.debug
patching file lib/bust_spinlocks.c
patching file lib/ioremap.c
patching file lib/smp_processor_id.c
patching file mm/memory.c
patching file mm/mmu_context.c
patching file mm/vmalloc.c
###################################################
     kernel-2.6.32.7  is now patched XENOMAI-2.6-00 
  sources are in  /usr/src/linux-2.6.32.7XN251-smp
 configuire and install kernel manually
###################################################

I  then tried to run    make mrproper     like so:-
root [ /usr/src/linux ]# make mrproper

results are below:-
-------------------------------------------------------------
scripts/Makefile.clean:17: /usr/src/linux-2.6.32.7XN251-smp/arch/x86/xenomai/Makefile: 
No such file or directory
make[1]: *** No rule to make target 
`/usr/src/linux-2.6.32.7XN251-smp/arch/x86/xenomai/Makefile'.  Stop.
make: *** [_clean_arch/x86/xenomai] Error 2


help would be appreciated

sincerely
lux-ineg

