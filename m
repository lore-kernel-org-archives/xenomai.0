Message-ID: <43BEBA0D.5090708@domain.hid>
Date: Fri, 06 Jan 2006 20:42:21 +0200
From: Heikki Lindholm <holindho@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080704050601020007070402"
Subject: [Xenomai-core] [PATCH] Fix ppc fpu support
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------080704050601020007070402
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Xenomai might preempt linux when linux has cleared a tasks MSR_FP, but 
not yet set last_task_used_math to NULL. As a result the tasks MSR_FP 
will get set, although it should be cleared. If the task happens to hit 
one of the codepaths that save FPU state if MSR_FP is set, the wrong FPU 
state might be saved to the task. The attached patch should fix this. I 
couldn't try it on most recent Xenomai trunk, because latency wouldn't 
build anymore. However, I see no reason it shouldn't work. All thee 
having trouble with X and Xenomai, give this a shot.

-- Heikki Lindholm

--------------080704050601020007070402
Content-Type: text/plain; x-mac-type="0"; x-mac-creator="0";
	name="xenomai-060106-ppc-hwfpu.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xenomai-060106-ppc-hwfpu.patch"

diff -Nru xenomai/include/asm-powerpc/system.h xenomai-devel/include/asm-powerpc/system.h
--- xenomai/include/asm-powerpc/system.h	2006-01-06 15:55:19.000000000 +0200
+++ xenomai-devel/include/asm-powerpc/system.h	2006-01-06 16:44:53.000000000 +0200
@@ -55,6 +55,7 @@
     rthal_fpenv_t fpuenv  __attribute__ ((aligned (16)));
     rthal_fpenv_t *fpup;	/* Pointer to the FPU backup area */
     struct task_struct *user_fpu_owner;
+    unsigned long user_fpu_owner_prev_msr;
     /* Pointer the the FPU owner in userspace:
        - NULL for RT K threads,
        - last_task_used_math for Linux US threads (only current or NULL when MP)
@@ -368,7 +369,10 @@
         rthal_save_fpu(tcb->fpup);
 
         if(tcb->user_fpu_owner && tcb->user_fpu_owner->thread.regs)
+            {
+            tcb->user_fpu_owner_prev_msr = tcb->user_fpu_owner->thread.regs->msr;
             tcb->user_fpu_owner->thread.regs->msr &= ~MSR_FP;
+            }
         }   
 
 #endif /* CONFIG_XENO_HW_FPU */
@@ -383,7 +387,13 @@
         {
         rthal_restore_fpu(tcb->fpup);
 
-        if(tcb->user_fpu_owner && tcb->user_fpu_owner->thread.regs)
+	/* Note: Only enable FP in MSR, if it was enabled when we saved the
+	 * fpu state. We might have preempted Linux when it had disabled FP
+	 * for the thread, but not yet set last_task_used_math to NULL 
+	 */
+        if(tcb->user_fpu_owner && 
+			tcb->user_fpu_owner->thread.regs &&
+			((tcb->user_fpu_owner_prev_msr & MSR_FP) != 0))
             tcb->user_fpu_owner->thread.regs->msr |= MSR_FP;
         }   
 

--------------080704050601020007070402--

