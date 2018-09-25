From: Philippe Gerum <rpm@xenomai.org>
Date: Tue, 25 Sep 2018 12:37:56 +0200
Message-Id: <20180925103809.4932-20-rpm@xenomai.org>
In-Reply-To: <20180925103809.4932-1-rpm@xenomai.org>
References: <20180925103809.4932-1-rpm@xenomai.org>
Subject: [Xenomai] [PATCH 19/32] x86: ipipe: route syscalls to co-kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

This commit introduces the changes redirecting "foreign" system calls
to the co-kernel.
---
 arch/x86/entry/common.c | 75 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 72 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 5cc2f617a2e3..c75d32d8873f 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -274,7 +274,9 @@ __visible inline void syscall_return_slowpath(struct pt_regs *regs)
 	 * First do one-time work.  If these work items are enabled, we
 	 * want to run them exactly once per syscall exit with IRQs on.
 	 */
-	if (unlikely(cached_flags & SYSCALL_EXIT_WORK_FLAGS))
+	if (unlikely((!IS_ENABLED(CONFIG_IPIPE) ||
+		      syscall_get_nr(current, regs) < NR_syscalls) &&
+		     (cached_flags & SYSCALL_EXIT_WORK_FLAGS)))
 		syscall_slow_exit_work(regs, cached_flags);
 
 	local_irq_disable();
@@ -282,15 +284,74 @@ __visible inline void syscall_return_slowpath(struct pt_regs *regs)
 	prepare_exit_to_usermode(regs);
 }
 
+#ifdef CONFIG_IPIPE
+
+#ifdef CONFIG_X86_32
+static inline int pipeline_syscall_32(struct thread_info *ti,
+				   unsigned long nr, struct pt_regs *regs)
+{
+	return ipipe_handle_syscall(ti, nr, regs);
+}
+#else
+static inline int pipeline_syscall_64(struct thread_info *ti,
+				   unsigned long nr, struct pt_regs *regs)
+{
+	return ipipe_handle_syscall(ti, nr, regs);
+}
+
+static inline int pipeline_syscall_32(struct thread_info *ti,
+				   unsigned long nr, struct pt_regs *regs)
+{
+	struct pt_regs regs64 = *regs;
+	int ret;
+
+	regs64.di = (unsigned int)regs->bx;
+	regs64.si = (unsigned int)regs->cx;
+	regs64.r10 = (unsigned int)regs->si;
+	regs64.r8 = (unsigned int)regs->di;
+	regs64.r9 = (unsigned int)regs->bp;
+	ret = ipipe_handle_syscall(ti, nr, &regs64);
+	regs->ax = (unsigned int)regs64.ax;
+
+	return ret;
+}
+#endif /* CONFIG_X86_32 */
+
+#else  /* CONFIG_IPIPE */
+
+static inline int pipeline_syscall_32(struct thread_info *ti,
+				   unsigned long nr, struct pt_regs *regs)
+{
+	return 0;
+}
+
+static inline int pipeline_syscall_64(struct thread_info *ti,
+				   unsigned long nr, struct pt_regs *regs)
+{
+	return 0;
+}
+
+#endif /* CONFIG_IPIPE */
+
 #ifdef CONFIG_X86_64
 __visible void do_syscall_64(struct pt_regs *regs)
 {
 	struct thread_info *ti = current_thread_info();
 	unsigned long nr = regs->orig_ax;
+	int ret;
 
 	enter_from_user_mode();
 	local_irq_enable();
 
+	ret = pipeline_syscall_64(ti, nr, regs);
+	if (ret > 0) {
+		local_irq_disable();
+		hard_cond_local_irq_disable();
+		return;
+	}
+	if (ret < 0)
+		goto done;
+
 	if (READ_ONCE(ti->flags) & _TIF_WORK_SYSCALL_ENTRY)
 		nr = syscall_trace_enter(regs);
 
@@ -305,7 +366,7 @@ __visible void do_syscall_64(struct pt_regs *regs)
 			regs->di, regs->si, regs->dx,
 			regs->r10, regs->r8, regs->r9);
 	}
-
+done:
 	syscall_return_slowpath(regs);
 }
 #endif
@@ -321,11 +382,19 @@ static __always_inline void do_syscall_32_irqs_on(struct pt_regs *regs)
 {
 	struct thread_info *ti = current_thread_info();
 	unsigned int nr = (unsigned int)regs->orig_ax;
+	int ret;
 
 #ifdef CONFIG_IA32_EMULATION
 	ti->status |= TS_COMPAT;
 #endif
 
+	ret = pipeline_syscall_32(ti, nr, regs);
+	if (ret > 0)
+		return;
+
+	if (ret < 0)
+		goto done;
+
 	if (READ_ONCE(ti->flags) & _TIF_WORK_SYSCALL_ENTRY) {
 		/*
 		 * Subtlety here: if ptrace pokes something larger than
@@ -349,7 +418,7 @@ static __always_inline void do_syscall_32_irqs_on(struct pt_regs *regs)
 			(unsigned int)regs->dx, (unsigned int)regs->si,
 			(unsigned int)regs->di, (unsigned int)regs->bp);
 	}
-
+done:
 	syscall_return_slowpath(regs);
 }
 
-- 
2.14.4


