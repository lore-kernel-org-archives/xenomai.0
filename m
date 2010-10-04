From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <DE2B7FDC88E7C44E90CE24BD414F34F709BFDD@exchange2010.basler.com>
References: <DE2B7FDC88E7C44E90CE24BD414F34F709BFDD@exchange2010.basler.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 04 Oct 2010 12:12:19 +0200
Message-ID: <1286187139.1702.94.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Adeos-main] enable_kernel_fp broken with IPIPE
	on PowerPC
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Steve Deiters <SteveDeiters@domain.hid>
Cc: adeos-main <adeos-main@gna.org>, "Xenomai Core (xenomai@xenomai.org)" <xenomai@xenomai.org>

On Fri, 2010-10-01 at 19:51 +0000, Steve Deiters wrote:
> I'm getting a thread crash where an unaligned floating point access occurs.  I tracked the cause down to enable_kernel_fp within the fix_alignment routine.  The enable_kernel_fp routine is as follows:
> 
> void enable_kernel_fp(void)
> {
>         unsigned long flags;
> 
>         WARN_ON(preemptible());
> 
>         local_irq_save_hw_cond(flags);
> 
> #ifdef CONFIG_SMP
>         if (current->thread.regs && (current->thread.regs->msr & MSR_FP))
>                 giveup_fpu(current);
>         else
>                 giveup_fpu(NULL);       /* just enables FP for kernel */
> #else
>         giveup_fpu(last_task_used_math);
> #endif /* CONFIG_SMP */
>         local_irq_restore_hw_cond(flags);
> }
> 
> 
> 
> The local_irq_save_hw_cond saves the old MSR value in flags.  When this value is restored with local_irq_restore_hw_cond it loses the MSR[FP] bit that was set in giveup_fpu.  If the MSR[FP] was not previously set before it saved the flags, I get a FPU exception a bit later in the alignment handling.
> 
> 
> As a quick fix I changed the line to restore to
> 
>         local_irq_restore_hw_cond(flags|MSR_FP);
> 
> 
> I'm not sure this is a correct fix.  I'm don't know where else there might be code that is modifying the MSR in a similar fashion.  It seems any such case would be broken.
> 
> I'm using the ipipe version 2.10-03 patch that was bundled with Xenomai 2.5.4 on Linux 2.6.33.5.  I noticed that this is still the same though in the 2.11-00 ipipe patch.
> 

Actually, giveup_fpu already handles the interrupt state properly, so
the protection code in enable_kernel_fp is buggy and useless as well.
I did not see any other spot where calling assembly code which may touch
the MSR would conflict with interrupt protection in the caller. Could
you try this patch instead?

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index e4eaca4..3743b27 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -98,12 +98,8 @@ void flush_fp_to_thread(struct task_struct *tsk)
 
 void enable_kernel_fp(void)
 {
-	unsigned long flags;
-
 	WARN_ON(preemptible());
 
-	local_irq_save_hw_cond(flags);
-
 #ifdef CONFIG_SMP
 	if (current->thread.regs && (current->thread.regs->msr & MSR_FP))
 		giveup_fpu(current);
@@ -112,7 +108,6 @@ void enable_kernel_fp(void)
 #else
 	giveup_fpu(last_task_used_math);
 #endif /* CONFIG_SMP */
-	local_irq_restore_hw_cond(flags);
 }
 EXPORT_SYMBOL(enable_kernel_fp);
 

> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> https://mail.gna.org/listinfo/adeos-main

-- 
Philippe.



