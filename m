From: Steve Deiters <SteveDeiters@domain.hid>
Date: Fri, 1 Oct 2010 19:51:37 +0000
Message-ID: <DE2B7FDC88E7C44E90CE24BD414F34F709BFDD@exchange2010.basler.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai-core] enable_kernel_fp broken with IPIPE on PowerPC
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: "Xenomai Core (xenomai@xenomai.org)" <xenomai@xenomai.org>, adeos-main <adeos-main@gna.org>

I'm getting a thread crash where an unaligned floating point access occurs.=
  I tracked the cause down to enable_kernel_fp within the fix_alignment rou=
tine.  The enable_kernel_fp routine is as follows:

void enable_kernel_fp(void)
{
        unsigned long flags;

        WARN_ON(preemptible());

        local_irq_save_hw_cond(flags);

#ifdef CONFIG_SMP
        if (current->thread.regs && (current->thread.regs->msr & MSR_FP))
                giveup_fpu(current);
        else
                giveup_fpu(NULL);       /* just enables FP for kernel */
#else
        giveup_fpu(last_task_used_math);
#endif /* CONFIG_SMP */
        local_irq_restore_hw_cond(flags);
}



The local_irq_save_hw_cond saves the old MSR value in flags.  When this val=
ue is restored with local_irq_restore_hw_cond it loses the MSR[FP] bit that=
 was set in giveup_fpu.  If the MSR[FP] was not previously set before it sa=
ved the flags, I get a FPU exception a bit later in the alignment handling.


As a quick fix I changed the line to restore to

        local_irq_restore_hw_cond(flags|MSR_FP);


I'm not sure this is a correct fix.  I'm don't know where else there might =
be code that is modifying the MSR in a similar fashion.  It seems any such =
case would be broken.

I'm using the ipipe version 2.10-03 patch that was bundled with Xenomai 2.5=
.4 on Linux 2.6.33.5.  I noticed that this is still the same though in the =
2.11-00 ipipe patch.

