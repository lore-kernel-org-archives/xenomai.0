MIME-Version: 1.0
In-Reply-To: <4BC5A1D3.5020202@domain.hid>
References: <g2u132366a01004140355v13765a3hcd5940f489b25dba@domain.hid> 
	<4BC5A1D3.5020202@domain.hid>
From: Luc ANTOLINOS <luciogistr@domain.hid>
Date: Wed, 14 Apr 2010 14:05:58 +0200
Message-ID: <g2q132366a01004140505v20bff90ds352bcc1e7e516006@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai-help] prepare_kernel.sh for PowerPC
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

On 14 April 2010 13:06, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> arch/ppc existed in other versions of Linux sources, with which we
> maintain compatibility.
> Could you show us the output of prepare-kernel.sh when you use ppc as
> architecture?
/usr/src/xenomai-2.5.2# scripts/prepare-kernel.sh
Linux tree [default /lib/modules/2.6.26-2-486/source]: /usr/src/linux-2.6.33
Target architecture [default i686]: ppc
Adeos patch [default
/usr/src/xenomai-2.5.2/ksrc/arch/powerpc/patches/adeos-ipipe-2.6.33-powerpc-2.9-00.patch]:
patching file arch/powerpc/Kconfig
patching file arch/powerpc/boot/Makefile
patching file arch/powerpc/include/asm/exception-64s.h
patching file arch/powerpc/include/asm/ftrace.h
patching file arch/powerpc/include/asm/hw_irq.h
patching file arch/powerpc/include/asm/ipipe.h
patching file arch/powerpc/include/asm/ipipe_base.h
patching file arch/powerpc/include/asm/ipipe_hwirq.h
patching file arch/powerpc/include/asm/irqflags.h
patching file arch/powerpc/include/asm/mmu_context.h
patching file arch/powerpc/include/asm/mpic.h
patching file arch/powerpc/include/asm/paca.h
patching file arch/powerpc/include/asm/ptrace.h
patching file arch/powerpc/include/asm/qe_ic.h
patching file arch/powerpc/include/asm/reg.h
patching file arch/powerpc/include/asm/smp.h
patching file arch/powerpc/include/asm/thread_info.h
patching file arch/powerpc/include/asm/time.h
patching file arch/powerpc/kernel/Makefile
patching file arch/powerpc/kernel/asm-offsets.c
patching file arch/powerpc/kernel/cputable.c
patching file arch/powerpc/kernel/entry_32.S
patching file arch/powerpc/kernel/entry_64.S
patching file arch/powerpc/kernel/exceptions-64s.S
patching file arch/powerpc/kernel/fpu.S
patching file arch/powerpc/kernel/head_32.S
patching file arch/powerpc/kernel/head_40x.S
patching file arch/powerpc/kernel/head_44x.S
patching file arch/powerpc/kernel/head_64.S
patching file arch/powerpc/kernel/head_8xx.S
patching file arch/powerpc/kernel/head_booke.h
patching file arch/powerpc/kernel/head_fsl_booke.S
patching file arch/powerpc/kernel/idle.c
patching file arch/powerpc/kernel/idle_power4.S
patching file arch/powerpc/kernel/ipipe.c
patching file arch/powerpc/kernel/irq.c
patching file arch/powerpc/kernel/ppc_ksyms.c
patching file arch/powerpc/kernel/process.c
patching file arch/powerpc/kernel/prom_init_check.sh
patching file arch/powerpc/kernel/setup_32.c
patching file arch/powerpc/kernel/setup_64.c
patching file arch/powerpc/kernel/smp.c
patching file arch/powerpc/kernel/time.c
patching file arch/powerpc/kernel/traps.c
patching file arch/powerpc/lib/code-patching.c
patching file arch/powerpc/lib/feature-fixups.c
patching file arch/powerpc/mm/fault.c
patching file arch/powerpc/mm/hash_low_32.S
patching file arch/powerpc/mm/hash_native_64.c
patching file arch/powerpc/mm/hash_utils_64.c
patching file arch/powerpc/mm/mmu_context_nohash.c
patching file arch/powerpc/mm/slb.c
patching file arch/powerpc/mm/stab.c
patching file arch/powerpc/mm/tlb_hash32.c
patching file arch/powerpc/platforms/82xx/pq2ads-pci-pic.c
patching file arch/powerpc/platforms/85xx/tqm85xx.c
patching file arch/powerpc/platforms/cell/spu_base.c
patching file arch/powerpc/platforms/iseries/irq.c
patching file arch/powerpc/platforms/powermac/pic.c
patching file arch/powerpc/platforms/ps3/htab.c
patching file arch/powerpc/platforms/ps3/interrupt.c
patching file arch/powerpc/platforms/pseries/lpar.c
patching file arch/powerpc/sysdev/cpm2_pic.c
patching file arch/powerpc/sysdev/i8259.c
patching file arch/powerpc/sysdev/ipic.c
patching file arch/powerpc/sysdev/mpc8xx_pic.c
patching file arch/powerpc/sysdev/mpic.c
patching file arch/powerpc/sysdev/qe_lib/qe_ic.c
patching file arch/powerpc/sysdev/tsi108_pci.c
patching file arch/powerpc/sysdev/uic.c
patching file drivers/pci/htirq.c
patching file drivers/serial/8250.c
patching file fs/exec.c
patching file fs/proc/array.c
patching file include/asm-generic/atomic.h
patching file include/asm-generic/bitops/atomic.h
patching file include/asm-generic/cmpxchg-local.h
patching file include/asm-generic/percpu.h
patching file include/linux/autoconf.h
patching file include/linux/bounds.h
patching file include/linux/compile.h
patching file include/linux/hardirq.h
patching file include/linux/ipipe.h
patching file include/linux/ipipe_base.h
patching file include/linux/ipipe_lock.h
patching file include/linux/ipipe_percpu.h
patching file include/linux/ipipe_tickdev.h
patching file include/linux/ipipe_trace.h
patching file include/linux/irq.h
patching file include/linux/kernel.h
patching file include/linux/preempt.h
patching file include/linux/rwlock.h
patching file include/linux/rwlock_api_smp.h
patching file include/linux/sched.h
patching file include/linux/spinlock.h
patching file include/linux/spinlock_api_smp.h
patching file include/linux/spinlock_up.h
patching file include/linux/utsrelease.h
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

<== Here the scripts hangs

I think the problem is line 412 :
asm_ipipe_h=`ls
$linux_tree/include/asm-{$linux_arch,$xenomai_arch}/ipipe.h
2>/dev/null|head -n1`
In this case, ls fail and then asm_ipipe_h is empty.
Line 415 wait forever on stdin :
adeos_version=`grep '^#define.*IPIPE_ARCH_STRING.*"' $asm_ipipe_h
2>/dev/null|head -n1|sed -e 's,.*"\(.*\)"$,\1,'`



-- 
Luc

