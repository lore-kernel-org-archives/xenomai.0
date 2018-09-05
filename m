From: Philippe Gerum <rpm@xenomai.org>
Date: Wed, 5 Sep 2018 17:21:58 +0200
Message-Id: <E1fxZtZ-0006M0-8j@xenomai.org>
Subject: [Xenomai] [I-PIPE][PATCH 5/7] arm64: ipipe: route syscalls to
 co-kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Dmitriy Cherkasov <dmitriy@oss-tech.org>
Cc: xenomai@xenomai.org

This commit introduces the changes redirecting "foreign" system calls
to the co-kernel.
---
 arch/arm64/include/asm/unistd.h |  2 ++
 arch/arm64/kernel/entry.S       | 51 +++++++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/ipipe.c       | 14 +++++++++++
 3 files changed, 67 insertions(+)

diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index a0baa9af5487..90e64fd5e50b 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -53,3 +53,5 @@
 #endif
 
 #define NR_syscalls (__NR_syscalls)
+
+#define __ARM_ipipe_syscall	0x10000000
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 6e6c396f9bb0..29786c9baa69 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -964,6 +964,57 @@ el0_svc:
 el0_svc_naked:					// compat entry point
 	stp	x0, xscno, [sp, #S_ORIG_X0]	// save the original x0 and syscall number
 	enable_dbg_and_irq
+
+#ifdef CONFIG_IPIPE
+	ldr     x16, [tsk, #TSK_TI_IPIPE]
+	tst     wscno, __ARM_ipipe_syscall
+	b.eq    fastcall_bypass
+	tst     x16, #_TIP_HEAD
+	b.eq    fastcall_bypass
+	mov     x0, sp
+	bl      ipipe_fastcall_hook
+	cmp     w0, #0
+	b.lt    no_fastcall
+	ldr     x16, [tsk, #TSK_TI_IPIPE]
+	tst     x16, #_TIP_HEAD
+	b.ne    fastcall_exit
+	bl      __ipipe_root_sync
+fastcall_tail:
+	ldr     x0, [sp, #S_X0]
+	b       ret_fast_syscall
+fastcall_exit:
+	tst     x16, #_TIP_MAYDAY
+	b.eq    fastcall_notail
+	mov     x0, sp
+	bl      __ipipe_call_mayday
+fastcall_notail:
+	ldr     x0, [sp, #S_X0]
+	disable_irq
+	ldr     x1, [tsk, #TSK_TI_FLAGS]
+	enable_step_tsk x1, x2
+	kernel_exit 0
+no_fastcall:
+	ldr     x16, [tsk, #TSK_TI_IPIPE]
+fastcall_bypass:
+	tst     x16, #_TIP_NOTIFY
+	b.ne    syscall_pipeline
+	tst     wscno, __ARM_ipipe_syscall
+	b.eq    regular_syscall
+syscall_pipeline:
+	mov     x0, sp
+	bl      __ipipe_notify_syscall
+	ldr     x16, [tsk, #TSK_TI_IPIPE]
+	tst     x16, #_TIP_HEAD
+	b.ne    fastcall_notail
+	cmp     w0, #0
+	b.ne    fastcall_tail
+regular_syscall:
+	ldp     x0, x1, [sp, #S_X0]
+	ldp     x2, x3, [sp, #S_X2]
+	ldp     x4, x5, [sp, #S_X4]
+	ldp     x6, x7, [sp, #S_X6]
+#endif /* CONFIG_IPIPE */
+
 	ct_user_exit 1
 
 	ldr	x16, [tsk, #TSK_TI_FLAGS]	// check for syscall hooks
diff --git a/arch/arm64/kernel/ipipe.c b/arch/arm64/kernel/ipipe.c
index f7d5e0ab8943..10273ce8a846 100644
--- a/arch/arm64/kernel/ipipe.c
+++ b/arch/arm64/kernel/ipipe.c
@@ -225,6 +225,20 @@ static void __ipipe_do_IRQ(unsigned irq, void *cookie)
 	__handle_domain_irq(NULL, irq, false, regs);
 }
 
+void __ipipe_root_sync(void)
+{
+	struct ipipe_percpu_domain_data *p;
+	unsigned long flags;
+
+	flags = hard_local_irq_save();
+
+	p = ipipe_this_cpu_root_context();
+	if (__ipipe_ipending_p(p))
+		__ipipe_sync_stage();
+
+	hard_local_irq_restore(flags);
+}
+
 static struct __ipipe_tscinfo tsc_info;
 
 void __init __ipipe_tsc_register(struct __ipipe_tscinfo *info)
-- 
2.14.4


