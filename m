From: Steven Seeger <steven.seeger@nasa.gov>
Date: Sun, 29 Apr 2018 23:21:00 -0400
Message-ID: <2016084.lXyCYvDxLZ@wirbelwind>
In-Reply-To: <4715a857-f535-fe49-2506-5abbb16553ed@xenomai.org>
References: <mailman.27.1522680894.4366.xenomai@xenomai.org>
 <b2cbe5362c38461d9a2eb817b78fb633@EDB3.wapice.localdomain>
 <4715a857-f535-fe49-2506-5abbb16553ed@xenomai.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Subject: Re: [Xenomai] Unrecoverable FP Unavailable Exception 801
Reply-To: steven.seeger@nasa.gov
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Adnan Ali <adnan.ali@wapice.com>, Sakari Junnila <sakari.junnila@wapice.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello all. I've created what Philippe thinks is a good patch for this issue as 
well as looked at other cases of clobbered bits in the MSR as it relates to 
vsx, spe, and altivec. I have checked in a patch on our interim 4.14 IPIPE 
work which is not yet public. It looks trivial to backport this to 4.9. I am a 
new maintainer even though I've been a thorn in Philippe's side for well over 
a decade. Once he takes a minute from his busy life to grant me access to push 
a change for 4.9 I will do so.

In the meantime, for anyone who would like to see this issue patched on 4.9.51 
against the latest ipipe-core-4.9.51-powerpc-3.patch this should work:

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index ed47cc3..866983a 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -172,6 +172,7 @@ void giveup_fpu(struct task_struct *tsk)
 	msr_check_and_set(MSR_FP);
 	__giveup_fpu(tsk);
 	msr_check_and_clear(MSR_FP);
+    flags &= MSR_FP;
 	hard_cond_local_irq_restore(flags);
 }
 EXPORT_SYMBOL(giveup_fpu);
@@ -204,6 +205,11 @@ void flush_fp_to_thread(struct task_struct *tsk)
 			 */
 			BUG_ON(tsk != current);
 			giveup_fpu(tsk);
+
+			/* giveup_fpu clears the MSR_FP bit from MSR
+			 * unconditionally
+			 */
+			flags &= ~MSR_FP;
 		}
 		hard_preempt_enable(flags);
 	}
@@ -219,6 +225,7 @@ void enable_kernel_fp(void)
 	flags = hard_cond_local_irq_save();
 
 	cpumsr = msr_check_and_set(MSR_FP);
+	flags |= MSR_FP; /* must exit this routine with MSR_FP bit set */
 
 	if (current->thread.regs && (current->thread.regs->msr & MSR_FP)) {
 		check_if_tm_restore_required(current);
@@ -285,6 +292,7 @@ void enable_kernel_altivec(void)
 
 	flags = hard_cond_local_irq_save();
 	cpumsr = msr_check_and_set(MSR_VEC);
+	flags |= MSR_VEC; /* must exit this routine with MSR_VEC set in MSR */
 
 	if (current->thread.regs && (current->thread.regs->msr & MSR_VEC)) {
 		check_if_tm_restore_required(current);
@@ -317,6 +325,10 @@ void flush_altivec_to_thread(struct task_struct *tsk)
 		if (tsk->thread.regs->msr & MSR_VEC) {
 			BUG_ON(tsk != current);
 			giveup_altivec(tsk);
+			/* giveup_altivec() clears MSR_VEC
+			 * unconditionally from MSR
+			 */
+			flags &= ~MSR_VEC;
 		}
 		hard_preempt_enable(flags);
 	}
@@ -405,6 +417,10 @@ void flush_vsx_to_thread(struct task_struct *tsk)
 		if (tsk->thread.regs->msr & (MSR_VSX|MSR_VEC|MSR_FP)) {
 			BUG_ON(tsk != current);
 			giveup_vsx(tsk);
+			/* giveup_vsx() clears MSR_FP,VEC,VSX unconditionally
+			 * so clear them in flags
+			 */
+			flags &= ~(MSR_FP|MSR_VEC|MSR_VSX);
 		}
 		hard_preempt_enable(flags);
 	}
@@ -436,6 +452,7 @@ void giveup_spe(struct task_struct *tsk)
 	msr_check_and_set(MSR_SPE);
 	__giveup_spe(tsk);
 	msr_check_and_clear(MSR_SPE);
+    flags &= MSR_SPE;
 	hard_cond_local_irq_restore(flags);
 }
 EXPORT_SYMBOL(giveup_spe);
@@ -448,7 +465,8 @@ void enable_kernel_spe(void)
 
 	flags = hard_cond_local_irq_save();
 	msr_check_and_set(MSR_SPE);
-
+	/* must exit this routine with MSR_SPE set in MSR */
+	flags |= MSR_SPE;
 	if (current->thread.regs && (current->thread.regs->msr & MSR_SPE)) {
 		check_if_tm_restore_required(current);
 		__giveup_spe(current);
@@ -467,6 +485,10 @@ void flush_spe_to_thread(struct task_struct *tsk)
 			BUG_ON(tsk != current);
 			tsk->thread.spefscr = mfspr(SPRN_SPEFSCR);
 			giveup_spe(tsk);
+			/* giveup_spe clears MSR_SPE from MSR, so must clear
+			 * it here to exit rouitine properly
+			 */
+			flags &= MSR_SPE;
 		}
 		hard_preempt_enable(flags);
 	}
@@ -531,6 +553,7 @@ void giveup_all(struct task_struct *tsk)
 #endif
 
 	msr_check_and_clear(msr_all_available);
+    flags &= ~msr_all_available;
 	hard_cond_local_irq_restore(flags);
 }
 EXPORT_SYMBOL(giveup_all);
@@ -563,6 +586,7 @@ void restore_math(struct pt_regs *regs)
 	}
 
 	msr_check_and_clear(msr_all_available);
+    flags &= ~msr_all_available;
 	hard_cond_local_irq_restore(flags);
 
 	regs->msr = msr;
@@ -1225,6 +1249,8 @@ struct task_struct *__switch_to(struct task_struct 
*prev,
 
 	/* Save FPU, Altivec, VSX and SPE state */
 	giveup_all(prev);
+    /* giveup_all clears msr_all_available bits unconditionally */
+	flags &= ~msr_all_available;
 
 	__switch_to_tm(prev, new);
 




