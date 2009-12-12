From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <537fde640912111916n49dbee36x1eae81a21c633ad@domain.hid>
References: <537fde640912111916n49dbee36x1eae81a21c633ad@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 12 Dec 2009 11:10:23 +0100
Message-ID: <1260612623.2370.150.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] xenomai-2.4.9 patch to kernel-2.6.29.4 with arch
 powerpc failed
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: yy Hong <yaanhyy@domain.hid>
Cc: xenomai@xenomai.org

On Sat, 2009-12-12 at 11:16 +0800, yy Hong wrote:
> Hi all:
>     I download kernel and its patch from www.kernel.org.
> then unzip kernel  and patch the kernel.
> Then I use xenemai-2.4.9 to patch the kernel following the
> README.INSTALL.
>    But the patch was not applied correctly!
>    I also test other kernel and xenomai version.
>    such as kernel-2.6.30.10 & xenomai-2.4.10.But still fialed.
>    I think I don't  patch xenomai to kernel in right way, can anyone
> help me !
>    Thanks a lot! 
> there was the following errors:

ksrc/arch/powerpc/patches/README

> ithor@domain.hid$ scripts/prepare-kernel.sh
> --linux=/home/ithor/linux-2.6.29.4
> Target architecture [default i686]: powerpc
> Adeos patch
> [default /home/ithor/xenomai-2.4.9/ksrc/arch/powerpc/patches/adeos-ipipe-2.6.29.4-powerpc-DENX-2.6-02.patch]: 
> patching file arch/powerpc/Kconfig
> patching file arch/powerpc/boot/Makefile
> patching file arch/powerpc/include/asm/exception.h
> patching file arch/powerpc/include/asm/hw_irq.h
> patching file arch/powerpc/include/asm/ipipe.h
> patching file arch/powerpc/include/asm/ipipe_base.h
> patching file arch/powerpc/include/asm/irqflags.h
> patching file arch/powerpc/include/asm/mmu_context.h
> patching file arch/powerpc/include/asm/mpic.h
> patching file arch/powerpc/include/asm/paca.h
> patching file arch/powerpc/include/asm/ptrace.h
> patching file arch/powerpc/include/asm/qe_ic.h
> patching file arch/powerpc/include/asm/reg.h
> Hunk #1 succeeded at 766 (offset -3 lines).
> patching file arch/powerpc/include/asm/smp.h
> patching file arch/powerpc/include/asm/thread_info.h
> Hunk #1 succeeded at 112 (offset -2 lines).
> Hunk #2 succeeded at 131 (offset -2 lines).
> patching file arch/powerpc/include/asm/time.h
> patching file arch/powerpc/kernel/Makefile
> patching file arch/powerpc/kernel/asm-offsets.c
> patching file arch/powerpc/kernel/cputable.c
> patching file arch/powerpc/kernel/entry_32.S
> patching file arch/powerpc/kernel/entry_64.S
> Hunk #7 succeeded at 548 (offset -4 lines).
> Hunk #8 succeeded at 568 (offset -4 lines).
> Hunk #9 succeeded at 606 (offset -4 lines).
> Hunk #10 succeeded at 619 (offset -4 lines).
> Hunk #11 succeeded at 731 (offset -4 lines).
> Hunk #12 succeeded at 765 (offset -4 lines).
> Hunk #13 succeeded at 830 (offset -4 lines).
> Hunk #14 succeeded at 1024 (offset -4 lines).
> Hunk #15 succeeded at 1049 (offset -4 lines).
> patching file arch/powerpc/kernel/head_32.S
> patching file arch/powerpc/kernel/head_40x.S
> patching file arch/powerpc/kernel/head_44x.S
> patching file arch/powerpc/kernel/head_64.S
> Hunk #1 succeeded at 346 (offset -22 lines).
> Hunk #2 succeeded at 363 (offset -22 lines).
> Hunk #3 succeeded at 446 (offset -22 lines).
> Hunk #4 succeeded at 685 (offset -22 lines).
> Hunk #5 succeeded at 695 (offset -22 lines).
> Hunk #6 succeeded at 735 (offset -22 lines).
> Hunk #7 succeeded at 746 (offset -22 lines).
> Hunk #8 succeeded at 758 (offset -22 lines).
> Hunk #9 succeeded at 779 (offset -22 lines).
> Hunk #10 succeeded at 814 (offset -22 lines).
> Hunk #11 succeeded at 871 (offset -22 lines).
> Hunk #12 succeeded at 1081 (offset -22 lines).
> Hunk #13 succeeded at 1636 (offset -48 lines).
> Hunk #14 succeeded at 1764 (offset -48 lines).
> Hunk #15 succeeded at 1776 (offset -48 lines).
> patching file arch/powerpc/kernel/head_8xx.S
> patching file arch/powerpc/kernel/head_booke.h
> Hunk #1 succeeded at 209 (offset -9 lines).
> Hunk #2 succeeded at 379 (offset -9 lines).
> Hunk #3 succeeded at 395 (offset -9 lines).
> patching file arch/powerpc/kernel/head_fsl_booke.S
> patching file arch/powerpc/kernel/idle.c
> patching file arch/powerpc/kernel/idle_power4.S
> patching file arch/powerpc/kernel/ipipe.c
> patching file arch/powerpc/kernel/irq.c
> patching file arch/powerpc/kernel/ppc_ksyms.c
> patching file arch/powerpc/kernel/process.c
> Hunk #3 succeeded at 400 (offset -4 lines).
> Hunk #4 FAILED at 419.
> Hunk #5 succeeded at 414 with fuzz 2 (offset -18 lines).
> Hunk #6 succeeded at 1065 (offset -18 lines).
> 1 out of 6 hunks FAILED -- saving rejects to file
> arch/powerpc/kernel/process.c.rej
> patching file arch/powerpc/kernel/prom_init_check.sh
> patching file arch/powerpc/kernel/setup_32.c
> patching file arch/powerpc/kernel/setup_64.c
> patching file arch/powerpc/kernel/smp.c
> patching file arch/powerpc/kernel/time.c
> Hunk #2 FAILED at 545.
> Hunk #3 succeeded at 558 (offset -8 lines).
> Hunk #4 succeeded at 601 (offset -8 lines).
> 1 out of 4 hunks FAILED -- saving rejects to file
> arch/powerpc/kernel/time.c.rej
> patching file arch/powerpc/kernel/traps.c
> patching file arch/powerpc/lib/code-patching.c
> patching file arch/powerpc/lib/feature-fixups.c
> patching file arch/powerpc/mm/fault.c
> patching file arch/powerpc/mm/hash_low_32.S
> patching file arch/powerpc/mm/hash_native_64.c
> Hunk #1 FAILED at 37.
> Hunk #2 succeeded at 133 (offset -4 lines).
> Hunk #3 succeeded at 142 (offset -4 lines).
> Hunk #4 succeeded at 156 with fuzz 2 (offset -4 lines).
> Hunk #5 succeeded at 178 (offset -10 lines).
> Hunk #6 succeeded at 190 (offset -10 lines).
> Hunk #7 succeeded at 217 (offset -10 lines).
> Hunk #8 succeeded at 235 (offset -10 lines).
> Hunk #9 succeeded at 243 (offset -10 lines).
> Hunk #10 succeeded at 261 (offset -10 lines).
> Hunk #11 succeeded at 333 (offset -10 lines).
> 1 out of 11 hunks FAILED -- saving rejects to file
> arch/powerpc/mm/hash_native_64.c.rej
> patching file arch/powerpc/mm/hash_utils_64.c
> patching file arch/powerpc/mm/mmu_context_nohash.c
> patching file arch/powerpc/mm/slb.c
> Hunk #3 succeeded at 152 (offset -10 lines).
> patching file arch/powerpc/mm/tlb_hash32.c
> patching file arch/powerpc/platforms/82xx/pq2ads-pci-pic.c
> patching file arch/powerpc/platforms/85xx/tqm85xx.c
> patching file arch/powerpc/platforms/cell/spu_base.c
> patching file arch/powerpc/platforms/iseries/irq.c
> patching file arch/powerpc/platforms/powermac/pic.c
> patching file arch/powerpc/platforms/ps3/htab.c
> patching file arch/powerpc/platforms/ps3/interrupt.c
> patching file arch/powerpc/platforms/pseries/lpar.c
> patching file arch/powerpc/sysdev/cpm2_pic.c
> patching file arch/powerpc/sysdev/i8259.c
> patching file arch/powerpc/sysdev/ipic.c
> patching file arch/powerpc/sysdev/mpc8xx_pic.c
> patching file arch/powerpc/sysdev/mpic.c
> patching file arch/powerpc/sysdev/qe_lib/qe_ic.c
> patching file arch/powerpc/sysdev/tsi108_pci.c
> patching file arch/powerpc/sysdev/uic.c
> patching file drivers/pci/htirq.c
> patching file drivers/serial/8250.c
> Hunk #1 succeeded at 2988 (offset -151 lines).
> patching file include/asm-generic/cmpxchg-local.h
> patching file include/asm-generic/percpu.h
> patching file include/linux/hardirq.h
> patching file include/linux/ipipe.h
> patching file include/linux/ipipe_base.h
> patching file include/linux/ipipe_compat.h
> patching file include/linux/ipipe_percpu.h
> patching file include/linux/ipipe_tickdev.h
> patching file include/linux/ipipe_trace.h
> patching file include/linux/irq.h
> patching file include/linux/kernel.h
> patching file include/linux/mm.h
> patching file include/linux/preempt.h
> patching file include/linux/sched.h
> Hunk #4 succeeded at 1394 (offset -4 lines).
> Hunk #5 succeeded at 1628 (offset -4 lines).
> patching file include/linux/spinlock.h
> patching file include/linux/spinlock_types.h
> patching file init/Kconfig
> Hunk #2 succeeded at 1065 (offset -12 lines).
> patching file init/main.c
> Hunk #1 succeeded at 542 (offset -1 lines).
> Hunk #2 succeeded at 599 (offset -4 lines).
> Hunk #3 succeeded at 771 (offset -4 lines).
> patching file kernel/Makefile
> patching file kernel/exit.c
> patching file kernel/fork.c
> Hunk #1 succeeded at 482 (offset -25 lines).
> Hunk #2 succeeded at 882 (offset -25 lines).
> Hunk #3 succeeded at 1263 (offset -25 lines).
> patching file kernel/ipipe/Kconfig
> patching file kernel/ipipe/Kconfig.debug
> patching file kernel/ipipe/Makefile
> patching file kernel/ipipe/core.c
> patching file kernel/ipipe/tracer.c
> patching file kernel/irq/chip.c
> patching file kernel/irq/handle.c
> patching file kernel/lockdep.c
> patching file kernel/panic.c
> patching file kernel/power/disk.c
> patching file kernel/printk.c
> Hunk #1 succeeded at 532 (offset -105 lines).
> Hunk #2 succeeded at 591 (offset -105 lines).
> Hunk #3 succeeded at 659 (offset -105 lines).
> patching file kernel/sched.c
> patching file kernel/signal.c
> patching file kernel/spinlock.c
> patching file kernel/time/tick-common.c
> patching file kernel/time/tick-sched.c
> patching file kernel/timer.c
> patching file kernel/trace/Kconfig
> patching file lib/Kconfig.debug
> patching file lib/bust_spinlocks.c
> patching file lib/ioremap.c
> patching file lib/smp_processor_id.c
> patching file lib/spinlock_debug.c
> patching file mm/memory.c
> patching file mm/mlock.c
> patching file mm/vmalloc.c
> prepare-kernel.sh: Unable to patch kernel 2.6.29.4 with
> adeos-ipipe-2.6.29.4-powerpc-DENX-2.6-02.patch.
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 
Philippe.



