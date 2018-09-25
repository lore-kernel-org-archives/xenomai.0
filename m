From: Philippe Gerum <rpm@xenomai.org>
Date: Tue, 25 Sep 2018 12:37:51 +0200
Message-Id: <20180925103809.4932-15-rpm@xenomai.org>
In-Reply-To: <20180925103809.4932-1-rpm@xenomai.org>
References: <20180925103809.4932-1-rpm@xenomai.org>
Subject: [Xenomai] [PATCH 14/32] x86/vm86_32: ipipe: protect against
 preemption from head domain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

---
 arch/x86/kernel/vm86_32.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/vm86_32.c b/arch/x86/kernel/vm86_32.c
index 9d0b5af7db91..a7faa29ab4f7 100644
--- a/arch/x86/kernel/vm86_32.c
+++ b/arch/x86/kernel/vm86_32.c
@@ -147,12 +147,14 @@ void save_v86_state(struct kernel_vm86_regs *regs, int retval)
 	}
 
 	preempt_disable();
+	hard_cond_local_irq_disable();
 	tsk->thread.sp0 = vm86->saved_sp0;
 	tsk->thread.sysenter_cs = __KERNEL_CS;
 	update_sp0(tsk);
 	refresh_sysenter_cs(&tsk->thread);
 	vm86->saved_sp0 = 0;
 	preempt_enable();
+	hard_cond_local_irq_enable();
 
 	memcpy(&regs->pt, &vm86->regs32, sizeof(struct pt_regs));
 
@@ -365,6 +367,7 @@ static long do_sys_vm86(struct vm86plus_struct __user *user_vm86, bool plus)
 	vm86->saved_sp0 = tsk->thread.sp0;
 	lazy_save_gs(vm86->regs32.gs);
 
+	hard_cond_local_irq_disable();
 	/* make room for real-mode segments */
 	preempt_disable();
 	tsk->thread.sp0 += 16;
@@ -376,6 +379,7 @@ static long do_sys_vm86(struct vm86plus_struct __user *user_vm86, bool plus)
 
 	update_sp0(tsk);
 	preempt_enable();
+	hard_cond_local_irq_enable();
 
 	if (vm86->flags & VM86_SCREEN_BITMAP)
 		mark_screen_rdonly(tsk->mm);
-- 
2.14.4


