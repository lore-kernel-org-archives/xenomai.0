Message-ID: <43C665AC.2020302@domain.hid>
Date: Thu, 12 Jan 2006 15:20:28 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <43C660A4.1090204@domain.hid>
In-Reply-To: <43C660A4.1090204@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: [PATCH] Fix ppc64 thread switching
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Heikki Lindholm <holindho@domain.hid>
Cc: xenomai@xenomai.org

Heikki Lindholm wrote:
> Add some polish, eg. make it work, for the recent thread switching 
> changes for the ppc64.
> 

Applied, thanks.

> -- Heikki Lindholm
> 
> 
> ------------------------------------------------------------------------
> 
> diff -Nru xenomai/include/asm-powerpc/hal.h xenomai-devel/include/asm-powerpc/hal.h
> --- xenomai/include/asm-powerpc/hal.h	2006-01-11 11:55:17.000000000 +0200
> +++ xenomai-devel/include/asm-powerpc/hal.h	2006-01-12 15:29:03.000000000 +0200
> @@ -165,8 +165,14 @@
>  
>  #define RTHAL_SWITCH_FRAME_SIZE  (STACK_FRAME_OVERHEAD + sizeof(struct pt_regs))
>  
> +#ifdef CONFIG_PPC64
> +asmlinkage void rthal_thread_switch(struct thread_struct *prev,
> +				    struct thread_struct *next,
> +				    int kernel_thread);
> +#else /* !CONFIG_PPC64 */
>  asmlinkage void rthal_thread_switch(struct thread_struct *prev,
>  				    struct thread_struct *next);
> +#endif /* CONFIG_PPC64 */
>  
>  asmlinkage void rthal_thread_trampoline(void);
>  
> diff -Nru xenomai/include/asm-powerpc/system.h xenomai-devel/include/asm-powerpc/system.h
> --- xenomai/include/asm-powerpc/system.h	2006-01-11 11:55:17.000000000 +0200
> +++ xenomai-devel/include/asm-powerpc/system.h	2006-01-12 15:35:31.000000000 +0200
> @@ -239,8 +239,13 @@
>  #endif /* CONFIG_PPC64 */
>  	}
>  
> +#ifdef CONFIG_PPC64
> +    rthal_thread_switch(out_tcb->tsp, in_tcb->tsp, 
> +		    in_tcb->user_task == NULL ? 1 : 0);
> +#else /* !CONFIG_PPC64 */
>      rthal_thread_switch(out_tcb->tsp, in_tcb->tsp);
> -
> +#endif /* CONFIG_PPC64 */
> +    
>      barrier();
>  }
>  
> @@ -299,12 +304,23 @@
>      ksp = (unsigned long *)((unsigned long)tcb->stackbase + tcb->stacksize - RTHAL_SWITCH_FRAME_SIZE - 32);
>      childregs = (struct pt_regs *)ksp;
>      memset(childregs,0,sizeof(*childregs));
> -    childregs->nip = (unsigned long)&rthal_thread_trampoline;
> +    childregs->nip = ((unsigned long *)&rthal_thread_trampoline)[0];
> +    childregs->gpr[2] = ((unsigned long *)&rthal_thread_trampoline)[1];
>      childregs->gpr[14] = flags & ~(MSR_EE | MSR_FP);
>      childregs->gpr[15] = ((unsigned long *)&xnarch_thread_trampoline)[0]; /* lr = entry addr. */
>      childregs->gpr[16] = ((unsigned long *)&xnarch_thread_trampoline)[1]; /* r2 = TOC base. */
>      childregs->gpr[17] = (unsigned long)tcb;
>      tcb->ts.ksp = (unsigned long)childregs - STACK_FRAME_OVERHEAD;
> +    if (cpu_has_feature(CPU_FTR_SLB)) { /* from process.c/copy_thread */
> +	    unsigned long sp_vsid = get_kernel_vsid(tcb->ts.ksp);
> +	    
> +	    sp_vsid <<= SLB_VSID_SHIFT;
> +	    sp_vsid |= SLB_VSID_KERNEL;
> +	    if (cpu_has_feature(CPU_FTR_16M_PAGE))
> +		    sp_vsid |= SLB_VSID_L;
> +	    
> +	    tcb->ts.ksp_vsid = sp_vsid;
> +    }
>  #else /* !CONFIG_PPC64 */
>      ksp = (unsigned long *)((unsigned long)tcb->stackbase + tcb->stacksize - RTHAL_SWITCH_FRAME_SIZE - 4);
>      childregs = (struct pt_regs *)ksp;
> @@ -415,7 +431,7 @@
>      tcb->user_task = NULL;
>      tcb->active_task = NULL;
>      tcb->tsp = &tcb->ts;
> -    /* Note: .pgdir(ppc32)/.VSID(ppc64) == NULL for a Xenomai kthread. */
> +    /* Note: .pgdir(ppc32) == NULL for a Xenomai kthread. */
>      memset(&tcb->ts,0,sizeof(tcb->ts));
>  #ifdef CONFIG_XENO_HW_FPU
>      tcb->user_fpu_owner = NULL;
> diff -Nru xenomai/ksrc/arch/powerpc/switch_64.S xenomai-devel/ksrc/arch/powerpc/switch_64.S
> --- xenomai/ksrc/arch/powerpc/switch_64.S	2006-01-11 11:55:22.000000000 +0200
> +++ xenomai-devel/ksrc/arch/powerpc/switch_64.S	2006-01-12 15:30:18.000000000 +0200
> @@ -33,7 +33,7 @@
>  #include <asm/mmu.h>
>  
>  /*
> - * void rthal_thread_switch(struct thread_struct *prev, struct thread_struct *next)
> + * void rthal_thread_switch(struct thread_struct *prev, struct thread_struct *next, int kernel_thread)
>   */
>  	.align	7
>  _GLOBAL(rthal_thread_switch)
> @@ -68,17 +68,12 @@
>  
>  	ld	r8,KSP(r4)	/* new stack pointer */
>  
> -	lwz	r0,KSP_VSID(r4)
> -        cmpwi   r0, 0
> -        bne+ change_current
> -	mr	r1,r8		/* start using new stack pointer */
> -	b same_current
> +	cmpwi	cr5,r5,0	/* is it a kernel thread */
> +        bne-	cr5,10f		/* if so, don't touch 'current' */
>  
> -change_current:
> -	
>  	addi	r6,r4,-THREAD	/* Convert THREAD to 'current' */
>  	std	r6,PACACURRENT(r13)	/* Set new 'current' */
> -
> +10:
>  BEGIN_FTR_SECTION
>  	clrrdi	r6,r8,28	/* get its ESID */
>  	clrrdi	r9,r1,28	/* get current sp ESID */
> @@ -98,16 +93,16 @@
>  
>  2:
>  END_FTR_SECTION_IFSET(CPU_FTR_SLB)
> +	bne-	cr5,11f		/* kernel thread: don't touch 'current' */
>  	clrrdi	r7,r8,THREAD_SHIFT	/* base of new stack */
>  	/* Note: this uses SWITCH_FRAME_SIZE rather than INT_FRAME_SIZE
>  	   because we don't need to leave the 288-byte ABI gap at the
>  	   top of the kernel stack. */
>  	addi	r7,r7,THREAD_SIZE-SWITCH_FRAME_SIZE
> -
> -	mr	r1,r8		/* start using new stack pointer */
>  	std	r7,PACAKSAVE(r13)
> -
> -same_current:
> +	
> +11:
> +	mr	r1,r8		/* start using new stack pointer */
>  		
>  	ld	r6,_CCR(r1)
>  	mtcrf	0xFF,r6


-- 

Philippe.

