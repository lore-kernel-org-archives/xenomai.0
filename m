Message-ID: <4540B58B.5090101@domain.hid>
Date: Thu, 26 Oct 2006 15:18:03 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] 2.6.18 ppc ipipe patch patch
References: <200610261331.34958.paul_c@domain.hid>
In-Reply-To: <200610261331.34958.paul_c@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Paul <paul_c@domain.hid>
Cc: xenomai@xenomai.org

Paul wrote:
> Currently have a G3 Mac on loan and thought it worth trying out a 2.6.18.1 
> kernel - The prepare-kernel.sh patched without any errors, a few offset lines, 
> but that is to be expected.. Once configured however, compilation failed with 
> some fatal errors over ipipe.h and line 223 - It would appear that the 
> adeos-ipipe patch is adding a malformed line from the preamble of the 
> following chunk. The ppc-ipipe_fix patch corrects this issue, and the second 
> attempts to clean up the rest of the patch.

Thanks for the fix. Did it work then? Note that this patch only supports 
systems in the arch/ppc tree (and not in the arch/powerpc tree).

Wolfgang,

> 
> Regards, Paul.
> 
> 
> ------------------------------------------------------------------------
> 
> Index: ksrc/arch/powerpc/patches/adeos-ipipe-2.6.18-ppc-1.4-01.patch
> ===================================================================
> --- ksrc/arch/powerpc/patches/adeos-ipipe-2.6.18-ppc-1.4-01.patch	(revision 1732)
> +++ ksrc/arch/powerpc/patches/adeos-ipipe-2.6.18-ppc-1.4-01.patch	(working copy)
> @@ -1,4 +1,4 @@
> -+ diff -u linux-2.6.18/arch/powerpc/kernel/idle.c.ORIG linux-2.6.18/arch/powerpc/kernel/idle.c
> +diff -u linux-2.6.18/arch/powerpc/kernel/idle.c.ORIG linux-2.6.18/arch/powerpc/kernel/idle.c
>  --- linux-2.6.18/arch/powerpc/kernel/idle.c.ORIG	2006-09-20 05:42:06.000000000 +0200
>  +++ linux-2.6.18/arch/powerpc/kernel/idle.c	2006-09-30 10:14:30.845052232 +0200
>  @@ -51,6 +51,7 @@
> @@ -31,7 +31,7 @@
>   				set_thread_flag(TIF_POLLING_NRFLAG);
>   
>   			} else {
> -+ diff -u linux-2.6.18/arch/powerpc/kernel/irq.c.ORIG linux-2.6.18/arch/powerpc/kernel/irq.c
> +diff -u linux-2.6.18/arch/powerpc/kernel/irq.c.ORIG linux-2.6.18/arch/powerpc/kernel/irq.c
>  --- linux-2.6.18/arch/powerpc/kernel/irq.c.ORIG	2006-09-20 05:42:06.000000000 +0200
>  +++ linux-2.6.18/arch/powerpc/kernel/irq.c	2006-09-24 20:35:04.000000000 +0200
>  @@ -68,7 +68,11 @@
> @@ -46,7 +46,7 @@
>   
>   #ifdef CONFIG_PPC32
>   EXPORT_SYMBOL(__irq_offset_value);
> -+ diff -u linux-2.6.18/arch/ppc/Kconfig.ORIG linux-2.6.18/arch/ppc/Kconfig
> +diff -u linux-2.6.18/arch/ppc/Kconfig.ORIG linux-2.6.18/arch/ppc/Kconfig
>  --- linux-2.6.18/arch/ppc/Kconfig.ORIG	2006-09-20 05:42:06.000000000 +0200
>  +++ linux-2.6.18/arch/ppc/Kconfig	2006-09-24 14:02:26.000000000 +0200
>  @@ -950,6 +950,8 @@
> @@ -58,7 +58,7 @@
>   config HIGHMEM
>   	bool "High memory support"
>   
> -+ diff -u linux-2.6.18/arch/ppc/kernel/entry.S.ORIG linux-2.6.18/arch/ppc/kernel/entry.S
> +diff -u linux-2.6.18/arch/ppc/kernel/entry.S.ORIG linux-2.6.18/arch/ppc/kernel/entry.S
>  --- linux-2.6.18/arch/ppc/kernel/entry.S.ORIG	2006-09-20 05:42:06.000000000 +0200
>  +++ linux-2.6.18/arch/ppc/kernel/entry.S	2006-09-30 10:11:25.664204000 +0200
>  @@ -132,8 +132,23 @@
> @@ -204,7 +204,7 @@
>  +        bne+ ret_from_except
>  +        b restore
>  +#endif /* CONFIG_IPIPE */
> -+ diff -u linux-2.6.18/arch/ppc/kernel/head_44x.S.ORIG linux-2.6.18/arch/ppc/kernel/head_44x.S
> +diff -u linux-2.6.18/arch/ppc/kernel/head_44x.S.ORIG linux-2.6.18/arch/ppc/kernel/head_44x.S
>  --- linux-2.6.18/arch/ppc/kernel/head_44x.S.ORIG	2006-09-20 05:42:06.000000000 +0200
>  +++ linux-2.6.18/arch/ppc/kernel/head_44x.S	2006-09-24 14:02:26.000000000 +0200
>  @@ -427,7 +427,11 @@
> @@ -220,7 +220,7 @@
>   
>   	/* Alignment Interrupt */
>   	ALIGNMENT_EXCEPTION
> -+ diff -u linux-2.6.18/arch/ppc/kernel/head_4xx.S.ORIG linux-2.6.18/arch/ppc/kernel/head_4xx.S
> +diff -u linux-2.6.18/arch/ppc/kernel/head_4xx.S.ORIG linux-2.6.18/arch/ppc/kernel/head_4xx.S
>  --- linux-2.6.18/arch/ppc/kernel/head_4xx.S.ORIG	2006-09-20 05:42:06.000000000 +0200
>  +++ linux-2.6.18/arch/ppc/kernel/head_4xx.S	2006-09-24 14:02:26.000000000 +0200
>  @@ -228,6 +228,12 @@
> @@ -260,7 +260,7 @@
>   
>   #if 0
>   /* NOTE:
> -+ diff -u linux-2.6.18/arch/ppc/kernel/head_8xx.S.ORIG linux-2.6.18/arch/ppc/kernel/head_8xx.S
> +diff -u linux-2.6.18/arch/ppc/kernel/head_8xx.S.ORIG linux-2.6.18/arch/ppc/kernel/head_8xx.S
>  --- linux-2.6.18/arch/ppc/kernel/head_8xx.S.ORIG	2006-09-20 05:42:06.000000000 +0200
>  +++ linux-2.6.18/arch/ppc/kernel/head_8xx.S	2006-09-24 14:02:26.000000000 +0200
>  @@ -186,6 +186,11 @@
> @@ -299,7 +299,7 @@
>   
>   	EXCEPTION(0xa00, Trap_0a, unknown_exception, EXC_XFER_EE)
>   	EXCEPTION(0xb00, Trap_0b, unknown_exception, EXC_XFER_EE)
> -+ diff -u linux-2.6.18/arch/ppc/kernel/head_booke.h.ORIG linux-2.6.18/arch/ppc/kernel/head_booke.h
> +diff -u linux-2.6.18/arch/ppc/kernel/head_booke.h.ORIG linux-2.6.18/arch/ppc/kernel/head_booke.h
>  --- linux-2.6.18/arch/ppc/kernel/head_booke.h.ORIG	2006-09-20 05:42:06.000000000 +0200
>  +++ linux-2.6.18/arch/ppc/kernel/head_booke.h	2006-09-24 14:02:26.000000000 +0200
>  @@ -187,6 +187,12 @@
> @@ -339,7 +339,7 @@
>   
>   #define FP_UNAVAILABLE_EXCEPTION					      \
>   	START_EXCEPTION(FloatingPointUnavailable)			      \
> -+ diff -u linux-2.6.18/arch/ppc/kernel/head_fsl_booke.S.ORIG linux-2.6.18/arch/ppc/kernel/head_fsl_booke.S
> +diff -u linux-2.6.18/arch/ppc/kernel/head_fsl_booke.S.ORIG linux-2.6.18/arch/ppc/kernel/head_fsl_booke.S
>  --- linux-2.6.18/arch/ppc/kernel/head_fsl_booke.S.ORIG	2006-09-20 05:42:06.000000000 +0200
>  +++ linux-2.6.18/arch/ppc/kernel/head_fsl_booke.S	2006-09-24 14:02:26.000000000 +0200
>  @@ -526,7 +526,11 @@
> @@ -354,7 +354,7 @@
>   
>   	/* Alignment Interrupt */
>   	ALIGNMENT_EXCEPTION
> -+ diff -u linux-2.6.18/arch/ppc/kernel/head.S.ORIG linux-2.6.18/arch/ppc/kernel/head.S
> +diff -u linux-2.6.18/arch/ppc/kernel/head.S.ORIG linux-2.6.18/arch/ppc/kernel/head.S
>  --- linux-2.6.18/arch/ppc/kernel/head.S.ORIG	2006-09-20 05:42:06.000000000 +0200
>  +++ linux-2.6.18/arch/ppc/kernel/head.S	2006-09-24 14:02:26.000000000 +0200
>  @@ -295,6 +295,12 @@
> @@ -394,7 +394,7 @@
>   
>   	EXCEPTION(0xa00, Trap_0a, unknown_exception, EXC_XFER_EE)
>   	EXCEPTION(0xb00, Trap_0b, unknown_exception, EXC_XFER_EE)
> -+ diff -u linux-2.6.18/arch/ppc/kernel/ipipe-core.c.ORIG linux-2.6.18/arch/ppc/kernel/ipipe-core.c
> +diff -u linux-2.6.18/arch/ppc/kernel/ipipe-core.c.ORIG linux-2.6.18/arch/ppc/kernel/ipipe-core.c
>  --- linux-2.6.18/arch/ppc/kernel/ipipe-core.c.ORIG	2006-09-24 14:02:26.000000000 +0200
>  +++ linux-2.6.18/arch/ppc/kernel/ipipe-core.c	2006-09-24 14:02:26.000000000 +0200
>  @@ -0,0 +1,265 @@
> @@ -663,7 +663,7 @@
>  +EXPORT_SYMBOL(ipipe_trigger_irq);
>  +EXPORT_SYMBOL(ipipe_get_sysinfo);
>  +EXPORT_SYMBOL(ipipe_tune_timer);
> -+ diff -u linux-2.6.18/arch/ppc/kernel/ipipe-root.c.ORIG linux-2.6.18/arch/ppc/kernel/ipipe-root.c
> +diff -u linux-2.6.18/arch/ppc/kernel/ipipe-root.c.ORIG linux-2.6.18/arch/ppc/kernel/ipipe-root.c
>  --- linux-2.6.18/arch/ppc/kernel/ipipe-root.c.ORIG	2006-09-24 14:02:26.000000000 +0200
>  +++ linux-2.6.18/arch/ppc/kernel/ipipe-root.c	2006-09-24 19:35:11.000000000 +0200
>  @@ -0,0 +1,498 @@
> @@ -1165,7 +1165,7 @@
>  +void notrace _mcount(void);
>  +EXPORT_SYMBOL(_mcount);
>  +#endif /* CONFIG_IPIPE_TRACE */
> -+ diff -u linux-2.6.18/arch/ppc/kernel/Makefile.ORIG linux-2.6.18/arch/ppc/kernel/Makefile
> +diff -u linux-2.6.18/arch/ppc/kernel/Makefile.ORIG linux-2.6.18/arch/ppc/kernel/Makefile
>  --- linux-2.6.18/arch/ppc/kernel/Makefile.ORIG	2006-09-20 05:42:06.000000000 +0200
>  +++ linux-2.6.18/arch/ppc/kernel/Makefile	2006-09-24 17:58:23.000000000 +0200
>  @@ -17,6 +17,8 @@
> @@ -1177,7 +1177,7 @@
>   obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o
>   
>   ifndef CONFIG_MATH_EMULATION
> -+ diff -u linux-2.6.18/arch/ppc/kernel/traps.c.ORIG linux-2.6.18/arch/ppc/kernel/traps.c
> +diff -u linux-2.6.18/arch/ppc/kernel/traps.c.ORIG linux-2.6.18/arch/ppc/kernel/traps.c
>  --- linux-2.6.18/arch/ppc/kernel/traps.c.ORIG	2006-09-20 05:42:06.000000000 +0200
>  +++ linux-2.6.18/arch/ppc/kernel/traps.c	2006-09-24 14:02:26.000000000 +0200
>  @@ -233,6 +233,9 @@
> @@ -1311,7 +1311,7 @@
>   	spefscr = current->thread.spefscr;
>   	fpexc_mode = current->thread.fpexc_mode;
>   
> -+ diff -u linux-2.6.18/arch/ppc/mm/fault.c.ORIG linux-2.6.18/arch/ppc/mm/fault.c
> +diff -u linux-2.6.18/arch/ppc/mm/fault.c.ORIG linux-2.6.18/arch/ppc/mm/fault.c
>  --- linux-2.6.18/arch/ppc/mm/fault.c.ORIG	2006-09-20 05:42:06.000000000 +0200
>  +++ linux-2.6.18/arch/ppc/mm/fault.c	2006-09-24 14:02:26.000000000 +0200
>  @@ -113,6 +113,9 @@
> @@ -1324,7 +1324,7 @@
>   #if defined(CONFIG_XMON) || defined(CONFIG_KGDB)
>   	if (debugger_fault_handler && TRAP(regs) == 0x300) {
>   		debugger_fault_handler(regs);
> -+ diff -u linux-2.6.18/arch/ppc/platforms/85xx/sbc85xx.h.ORIG linux-2.6.18/arch/ppc/platforms/85xx/sbc85xx.h
> +diff -u linux-2.6.18/arch/ppc/platforms/85xx/sbc85xx.h.ORIG linux-2.6.18/arch/ppc/platforms/85xx/sbc85xx.h
>  --- linux-2.6.18/arch/ppc/platforms/85xx/sbc85xx.h.ORIG	2006-09-20 05:42:06.000000000 +0200
>  +++ linux-2.6.18/arch/ppc/platforms/85xx/sbc85xx.h	2006-09-24 14:02:26.000000000 +0200
>  @@ -15,7 +15,6 @@
> @@ -1335,7 +1335,7 @@
>   #include <asm/ppcboot.h>
>   
>   #define BOARD_CCSRBAR		((uint)0xff700000)
> -+ diff -u linux-2.6.18/arch/ppc/syslib/open_pic.c.ORIG linux-2.6.18/arch/ppc/syslib/open_pic.c
> +diff -u linux-2.6.18/arch/ppc/syslib/open_pic.c.ORIG linux-2.6.18/arch/ppc/syslib/open_pic.c
>  --- linux-2.6.18/arch/ppc/syslib/open_pic.c.ORIG	2006-09-20 05:42:06.000000000 +0200
>  +++ linux-2.6.18/arch/ppc/syslib/open_pic.c	2006-09-24 14:02:26.000000000 +0200
>  @@ -821,7 +821,7 @@
> @@ -1356,7 +1356,7 @@
>   	if (!(irq_desc[irq_nr].status & (IRQ_DISABLED|IRQ_INPROGRESS))
>   	    && irq_desc[irq_nr].action)
>   		openpic_enable_irq(irq_nr);
> -+ diff -u linux-2.6.18/drivers/pci/msi.c.ORIG linux-2.6.18/drivers/pci/msi.c
> +diff -u linux-2.6.18/drivers/pci/msi.c.ORIG linux-2.6.18/drivers/pci/msi.c
>  --- linux-2.6.18/drivers/pci/msi.c.ORIG	2006-09-20 05:42:06.000000000 +0200
>  +++ linux-2.6.18/drivers/pci/msi.c	2006-09-24 14:04:16.000000000 +0200
>  @@ -164,6 +164,21 @@
> @@ -1408,7 +1408,7 @@
>   	.end		= end_msi_irq_wo_maskbit,
>   	.set_affinity	= set_msi_affinity
>   };
> -+ diff -u linux-2.6.18/include/asm-powerpc/hw_irq.h.ORIG linux-2.6.18/include/asm-powerpc/hw_irq.h
> +diff -u linux-2.6.18/include/asm-powerpc/hw_irq.h.ORIG linux-2.6.18/include/asm-powerpc/hw_irq.h
>  --- linux-2.6.18/include/asm-powerpc/hw_irq.h.ORIG	2006-09-20 05:42:06.000000000 +0200
>  +++ linux-2.6.18/include/asm-powerpc/hw_irq.h	2006-09-24 19:09:41.000000000 +0200
>  @@ -12,6 +12,166 @@
> @@ -1587,7 +1587,7 @@
>   #define mask_irq(irq)						\
>   	({							\
>   	 	irq_desc_t *desc = get_irq_desc(irq);		\
> -+ diff -u linux-2.6.18/include/asm-powerpc/irq.h.ORIG linux-2.6.18/include/asm-powerpc/irq.h
> +diff -u linux-2.6.18/include/asm-powerpc/irq.h.ORIG linux-2.6.18/include/asm-powerpc/irq.h
>  --- linux-2.6.18/include/asm-powerpc/irq.h.ORIG	2006-09-20 05:42:06.000000000 +0200
>  +++ linux-2.6.18/include/asm-powerpc/irq.h	2006-09-24 19:47:56.000000000 +0200
>  @@ -12,7 +12,9 @@
> @@ -1600,10 +1600,10 @@
>   
>   #include <asm/types.h>
>   #include <asm/atomic.h>
> -+ diff -u linux-2.6.18/include/asm-ppc/ipipe.h.ORIG linux-2.6.18/include/asm-ppc/ipipe.h
> +diff -u linux-2.6.18/include/asm-ppc/ipipe.h.ORIG linux-2.6.18/include/asm-ppc/ipipe.h
>  --- linux-2.6.18/include/asm-ppc/ipipe.h.ORIG	2006-09-24 14:02:26.000000000 +0200
>  +++ linux-2.6.18/include/asm-ppc/ipipe.h	2006-09-24 19:59:09.000000000 +0200
> -@@ -0,0 +1,223 @@
> +@@ -0,0 +1,222 @@
>  +/* -*- linux-c -*-
>  + * include/asm-ppc/ipipe.h
>  + *
> @@ -1826,7 +1826,7 @@
>  +#endif /* CONFIG_IPIPE */
>  +
>  +#endif	/* !__PPC_IPIPE_H */
> -+ diff -u linux-2.6.18/include/asm-ppc/mmu_context.h.ORIG linux-2.6.18/include/asm-ppc/mmu_context.h
> +diff -u linux-2.6.18/include/asm-ppc/mmu_context.h.ORIG linux-2.6.18/include/asm-ppc/mmu_context.h
>  --- linux-2.6.18/include/asm-ppc/mmu_context.h.ORIG	2006-09-20 05:42:06.000000000 +0200
>  +++ linux-2.6.18/include/asm-ppc/mmu_context.h	2006-09-24 19:11:59.000000000 +0200
>  @@ -153,7 +153,10 @@
> @@ -1863,7 +1863,7 @@
>   
>   extern void mmu_context_init(void);
>   
> -+ diff -u linux-2.6.18/include/asm-ppc/pgalloc.h.ORIG linux-2.6.18/include/asm-ppc/pgalloc.h
> +diff -u linux-2.6.18/include/asm-ppc/pgalloc.h.ORIG linux-2.6.18/include/asm-ppc/pgalloc.h
>  --- linux-2.6.18/include/asm-ppc/pgalloc.h.ORIG	2006-09-20 05:42:06.000000000 +0200
>  +++ linux-2.6.18/include/asm-ppc/pgalloc.h	2006-09-24 14:02:26.000000000 +0200
>  @@ -39,5 +39,10 @@
> @@ -1877,7 +1877,7 @@
>  +
>   #endif /* _PPC_PGALLOC_H */
>   #endif /* __KERNEL__ */
> -+ diff -u linux-2.6.18/include/linux/hardirq.h.ORIG linux-2.6.18/include/linux/hardirq.h
> +diff -u linux-2.6.18/include/linux/hardirq.h.ORIG linux-2.6.18/include/linux/hardirq.h
>  --- linux-2.6.18/include/linux/hardirq.h.ORIG	2006-09-20 05:42:06.000000000 +0200
>  +++ linux-2.6.18/include/linux/hardirq.h	2006-09-24 14:09:27.000000000 +0200
>  @@ -123,7 +123,20 @@
> @@ -1901,7 +1901,7 @@
>  +#endif /* CONFIG_IPIPE */
>   
>   #endif /* LINUX_HARDIRQ_H */
> -+ diff -u linux-2.6.18/include/linux/ipipe.h.ORIG linux-2.6.18/include/linux/ipipe.h
> +diff -u linux-2.6.18/include/linux/ipipe.h.ORIG linux-2.6.18/include/linux/ipipe.h
>  --- linux-2.6.18/include/linux/ipipe.h.ORIG	2006-09-24 14:02:25.000000000 +0200
>  +++ linux-2.6.18/include/linux/ipipe.h	2006-09-24 14:02:25.000000000 +0200
>  @@ -0,0 +1,764 @@
> @@ -2669,7 +2669,7 @@
>  +#endif	/* CONFIG_IPIPE */
>  +
>  +#endif	/* !__LINUX_IPIPE_H */
> -+ diff -u linux-2.6.18/include/linux/linkage.h.ORIG linux-2.6.18/include/linux/linkage.h
> +diff -u linux-2.6.18/include/linux/linkage.h.ORIG linux-2.6.18/include/linux/linkage.h
>  --- linux-2.6.18/include/linux/linkage.h.ORIG	2006-09-20 05:42:06.000000000 +0200
>  +++ linux-2.6.18/include/linux/linkage.h	2006-09-24 14:02:25.000000000 +0200
>  @@ -60,4 +60,8 @@
> @@ -2681,7 +2681,7 @@
>  +#endif
>  +
>   #endif
> -+ diff -u linux-2.6.18/include/linux/preempt.h.ORIG linux-2.6.18/include/linux/preempt.h
> +diff -u linux-2.6.18/include/linux/preempt.h.ORIG linux-2.6.18/include/linux/preempt.h
>  --- linux-2.6.18/include/linux/preempt.h.ORIG	2006-09-24 14:25:30.000000000 +0200
>  +++ linux-2.6.18/include/linux/preempt.h	2006-09-24 14:25:15.000000000 +0200
>  @@ -26,22 +26,39 @@
> @@ -2730,7 +2730,7 @@
>   } while (0)
>   
>   #define preempt_enable() \
> -+ diff -u linux-2.6.18/include/linux/sched.h.ORIG linux-2.6.18/include/linux/sched.h
> +diff -u linux-2.6.18/include/linux/sched.h.ORIG linux-2.6.18/include/linux/sched.h
>  --- linux-2.6.18/include/linux/sched.h.ORIG	2006-09-20 05:42:06.000000000 +0200
>  +++ linux-2.6.18/include/linux/sched.h	2006-09-24 14:32:22.000000000 +0200
>  @@ -41,6 +41,7 @@
> @@ -2775,7 +2775,7 @@
>   
>   /*
>    * Only the _current_ task can read/write to tsk->flags, but other
> -+ diff -u linux-2.6.18/init/Kconfig.ORIG linux-2.6.18/init/Kconfig
> +diff -u linux-2.6.18/init/Kconfig.ORIG linux-2.6.18/init/Kconfig
>  --- linux-2.6.18/init/Kconfig.ORIG	2006-09-20 05:42:06.000000000 +0200
>  +++ linux-2.6.18/init/Kconfig	2006-09-24 14:02:25.000000000 +0200
>  @@ -66,6 +66,7 @@
> @@ -2786,7 +2786,7 @@
>   	help
>   	  Append an extra string to the end of your kernel version.
>   	  This will show up when you type uname, for example.
> -+ diff -u linux-2.6.18/init/main.c.ORIG linux-2.6.18/init/main.c
> +diff -u linux-2.6.18/init/main.c.ORIG linux-2.6.18/init/main.c
>  --- linux-2.6.18/init/main.c.ORIG	2006-09-20 05:42:06.000000000 +0200
>  +++ linux-2.6.18/init/main.c	2006-09-24 14:37:26.000000000 +0200
>  @@ -512,6 +512,11 @@
> @@ -2809,7 +2809,7 @@
>   
>   	do_initcalls();
>   }
> -+ diff -u linux-2.6.18/kernel/exit.c.ORIG linux-2.6.18/kernel/exit.c
> +diff -u linux-2.6.18/kernel/exit.c.ORIG linux-2.6.18/kernel/exit.c
>  --- linux-2.6.18/kernel/exit.c.ORIG	2006-09-20 05:42:06.000000000 +0200
>  +++ linux-2.6.18/kernel/exit.c	2006-09-24 14:41:33.000000000 +0200
>  @@ -909,6 +909,7 @@
> @@ -2820,7 +2820,7 @@
>   	exit_mm(tsk);
>   
>   	if (group_dead)
> -+ diff -u linux-2.6.18/kernel/fork.c.ORIG linux-2.6.18/kernel/fork.c
> +diff -u linux-2.6.18/kernel/fork.c.ORIG linux-2.6.18/kernel/fork.c
>  --- linux-2.6.18/kernel/fork.c.ORIG	2006-09-20 05:42:06.000000000 +0200
>  +++ linux-2.6.18/kernel/fork.c	2006-09-24 14:55:21.000000000 +0200
>  @@ -375,6 +375,7 @@
> @@ -2847,7 +2847,7 @@
>   	return p;
>   
>   bad_fork_cleanup_namespace:
> -+ diff -u linux-2.6.18/kernel/ipipe/core.c.ORIG linux-2.6.18/kernel/ipipe/core.c
> +diff -u linux-2.6.18/kernel/ipipe/core.c.ORIG linux-2.6.18/kernel/ipipe/core.c
>  --- linux-2.6.18/kernel/ipipe/core.c.ORIG	2006-09-24 14:02:25.000000000 +0200
>  +++ linux-2.6.18/kernel/ipipe/core.c	2006-09-24 14:02:25.000000000 +0200
>  @@ -0,0 +1,1059 @@
> @@ -3910,7 +3910,7 @@
>  +EXPORT_SYMBOL(__ipipe_pipeline);
>  +EXPORT_SYMBOL(__ipipe_pipelock);
>  +EXPORT_SYMBOL(__ipipe_virtual_irq_map);
> -+ diff -u linux-2.6.18/kernel/ipipe/generic.c.ORIG linux-2.6.18/kernel/ipipe/generic.c
> +diff -u linux-2.6.18/kernel/ipipe/generic.c.ORIG linux-2.6.18/kernel/ipipe/generic.c
>  --- linux-2.6.18/kernel/ipipe/generic.c.ORIG	2006-09-24 14:02:25.000000000 +0200
>  +++ linux-2.6.18/kernel/ipipe/generic.c	2006-09-24 14:02:25.000000000 +0200
>  @@ -0,0 +1,424 @@
> @@ -4338,7 +4338,7 @@
>  +EXPORT_SYMBOL(ipipe_set_irq_affinity);
>  +EXPORT_SYMBOL(ipipe_send_ipi);
>  +EXPORT_SYMBOL(__ipipe_schedule_irq);
> -+ diff -u linux-2.6.18/kernel/ipipe/Kconfig.ORIG linux-2.6.18/kernel/ipipe/Kconfig
> +diff -u linux-2.6.18/kernel/ipipe/Kconfig.ORIG linux-2.6.18/kernel/ipipe/Kconfig
>  --- linux-2.6.18/kernel/ipipe/Kconfig.ORIG	2006-09-24 14:02:25.000000000 +0200
>  +++ linux-2.6.18/kernel/ipipe/Kconfig	2006-09-24 14:02:25.000000000 +0200
>  @@ -0,0 +1,6 @@
> @@ -4348,14 +4348,14 @@
>  +	---help---
>  +	  Activate this option if you want the interrupt pipeline to be
>  +	  compiled in.
> -+ diff -u linux-2.6.18/kernel/ipipe/Makefile.ORIG linux-2.6.18/kernel/ipipe/Makefile
> +diff -u linux-2.6.18/kernel/ipipe/Makefile.ORIG linux-2.6.18/kernel/ipipe/Makefile
>  --- linux-2.6.18/kernel/ipipe/Makefile.ORIG	2006-09-24 14:02:25.000000000 +0200
>  +++ linux-2.6.18/kernel/ipipe/Makefile	2006-09-24 14:02:25.000000000 +0200
>  @@ -0,0 +1,3 @@
>  +
>  +obj-$(CONFIG_IPIPE)	+= core.o generic.o
>  +obj-$(CONFIG_IPIPE_TRACE) += tracer.o
> -+ diff -u linux-2.6.18/kernel/irq/handle.c.ORIG linux-2.6.18/kernel/irq/handle.c
> +diff -u linux-2.6.18/kernel/irq/handle.c.ORIG linux-2.6.18/kernel/irq/handle.c
>  --- linux-2.6.18/kernel/irq/handle.c.ORIG	2006-09-20 05:42:06.000000000 +0200
>  +++ linux-2.6.18/kernel/irq/handle.c	2006-09-24 15:01:44.000000000 +0200
>  @@ -134,6 +134,17 @@
> @@ -4397,7 +4397,7 @@
>   	/*
>   	 * REPLAY is when Linux resends an IRQ that was dropped earlier
>   	 * WAITING is used by probe to mark irqs that are being tested
> -+ diff -u linux-2.6.18/kernel/Makefile.ORIG linux-2.6.18/kernel/Makefile
> +diff -u linux-2.6.18/kernel/Makefile.ORIG linux-2.6.18/kernel/Makefile
>  --- linux-2.6.18/kernel/Makefile.ORIG	2006-09-20 05:42:06.000000000 +0200
>  +++ linux-2.6.18/kernel/Makefile	2006-09-24 14:39:07.000000000 +0200
>  @@ -50,6 +50,7 @@
> @@ -4408,7 +4408,7 @@
>   
>   ifneq ($(CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER),y)
>   # According to Alan Modra <alan@domain.hid>, the -fno-omit-frame-pointer is
> -+ diff -u linux-2.6.18/kernel/printk.c.ORIG linux-2.6.18/kernel/printk.c
> +diff -u linux-2.6.18/kernel/printk.c.ORIG linux-2.6.18/kernel/printk.c
>  --- linux-2.6.18/kernel/printk.c.ORIG	2006-09-20 05:42:06.000000000 +0200
>  +++ linux-2.6.18/kernel/printk.c	2006-09-24 14:02:25.000000000 +0200
>  @@ -488,6 +488,78 @@
> @@ -4498,7 +4498,7 @@
>   
>   /* cpu currently holding logbuf_lock */
>   static volatile unsigned int printk_cpu = UINT_MAX;
> -+ diff -u linux-2.6.18/kernel/sched.c.ORIG linux-2.6.18/kernel/sched.c
> +diff -u linux-2.6.18/kernel/sched.c.ORIG linux-2.6.18/kernel/sched.c
>  --- linux-2.6.18/kernel/sched.c.ORIG	2006-09-20 05:42:06.000000000 +0200
>  +++ linux-2.6.18/kernel/sched.c	2006-09-24 19:55:08.000000000 +0200
>  @@ -1373,7 +1373,7 @@
> @@ -4640,7 +4640,7 @@
>  +EXPORT_SYMBOL(ipipe_reenter_root);
>  +
>  +#endif /* CONFIG_IPIPE */
> -+ diff -u linux-2.6.18/kernel/signal.c.ORIG linux-2.6.18/kernel/signal.c
> +diff -u linux-2.6.18/kernel/signal.c.ORIG linux-2.6.18/kernel/signal.c
>  --- linux-2.6.18/kernel/signal.c.ORIG	2006-09-20 05:42:06.000000000 +0200
>  +++ linux-2.6.18/kernel/signal.c	2006-09-24 14:02:25.000000000 +0200
>  @@ -499,6 +499,7 @@
> @@ -4651,7 +4651,7 @@
>   
>   	/*
>   	 * For SIGKILL, we want to wake it up in the stopped/traced case.
> -+ diff -u linux-2.6.18/lib/smp_processor_id.c.ORIG linux-2.6.18/lib/smp_processor_id.c
> +diff -u linux-2.6.18/lib/smp_processor_id.c.ORIG linux-2.6.18/lib/smp_processor_id.c
>  --- linux-2.6.18/lib/smp_processor_id.c.ORIG	2006-09-20 05:42:06.000000000 +0200
>  +++ linux-2.6.18/lib/smp_processor_id.c	2006-09-24 14:02:25.000000000 +0200
>  @@ -13,6 +13,11 @@
> @@ -4666,7 +4666,7 @@
>   	if (likely(preempt_count))
>   		goto out;
>   
> -+ diff -u linux-2.6.18/mm/vmalloc.c.ORIG linux-2.6.18/mm/vmalloc.c
> +diff -u linux-2.6.18/mm/vmalloc.c.ORIG linux-2.6.18/mm/vmalloc.c
>  --- linux-2.6.18/mm/vmalloc.c.ORIG	2006-09-20 05:42:06.000000000 +0200
>  +++ linux-2.6.18/mm/vmalloc.c	2006-09-24 14:02:25.000000000 +0200
>  @@ -19,6 +19,7 @@
> 
> 
> ------------------------------------------------------------------------
> 
> Index: ksrc/arch/powerpc/patches/adeos-ipipe-2.6.18-ppc-1.4-01.patch
> ===================================================================
> --- ksrc/arch/powerpc/patches/adeos-ipipe-2.6.18-ppc-1.4-01.patch	(revision 1732)
> +++ ksrc/arch/powerpc/patches/adeos-ipipe-2.6.18-ppc-1.4-01.patch	(working copy)
> @@ -1603,7 +1603,7 @@
>  + diff -u linux-2.6.18/include/asm-ppc/ipipe.h.ORIG linux-2.6.18/include/asm-ppc/ipipe.h
>  --- linux-2.6.18/include/asm-ppc/ipipe.h.ORIG	2006-09-24 14:02:26.000000000 +0200
>  +++ linux-2.6.18/include/asm-ppc/ipipe.h	2006-09-24 19:59:09.000000000 +0200
> -@@ -0,0 +1,223 @@
> +@@ -0,0 +1,222 @@
>  +/* -*- linux-c -*-
>  + * include/asm-ppc/ipipe.h
>  + *
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


