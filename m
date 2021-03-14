From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 5.4] x86: ipipe: Fix imbalance in slow syscall return path
Message-ID: <1f9defa0-a42e-f194-e8ab-55814114d9b8@siemens.com>
Date: Sun, 14 Mar 2021 17:08:48 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

When ipipe_handle_syscall signals "do not pass, return via slow path",
we must not run syscall_slow_exit_work. So far, this case was detected
by checking the syscall number. However, this missed the case that an
invalid syscall was passed down, forwarded by ipipe_handle_syscall, but
then ignored on exit due to the range check.

Instead, we need to pass the condition from the call site to make the
exit reliably balanced.

At this chance, drop the unneeded #ifdef from do_syscall_64.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Analogous patch queued up for 4.19.

 arch/x86/entry/common.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 970819cbaac0..e8a2c167afb8 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -279,7 +279,7 @@ static void syscall_slow_exit_work(struct pt_regs *regs, u32 cached_flags)
  * Called with IRQs on and fully valid regs.  Returns with IRQs off in a
  * state such that we can immediately switch to user mode.
  */
-__visible inline void syscall_return_slowpath(struct pt_regs *regs)
+static void __syscall_return_slowpath(struct pt_regs *regs, bool do_work)
 {
 	struct thread_info *ti = current_thread_info();
 	u32 cached_flags = READ_ONCE(ti->flags);
@@ -296,16 +296,18 @@ __visible inline void syscall_return_slowpath(struct pt_regs *regs)
 	 * First do one-time work.  If these work items are enabled, we
 	 * want to run them exactly once per syscall exit with IRQs on.
 	 */
-	if (unlikely((!IS_ENABLED(CONFIG_IPIPE) ||
-		      syscall_get_nr(current, regs) <
-				ipipe_root_nr_syscalls(ti)) &&
-		     (cached_flags & SYSCALL_EXIT_WORK_FLAGS)))
+	if (unlikely(do_work && (cached_flags & SYSCALL_EXIT_WORK_FLAGS)))
 		syscall_slow_exit_work(regs, cached_flags);
 
 	disable_local_irqs();
 	prepare_exit_to_usermode(regs);
 }
 
+__visible inline void syscall_return_slowpath(struct pt_regs *regs)
+{
+	__syscall_return_slowpath(regs, true);
+}
+
 #ifdef CONFIG_X86_64
 __visible void do_syscall_64(unsigned long nr, struct pt_regs *regs)
 {
@@ -316,16 +318,16 @@ __visible void do_syscall_64(unsigned long nr, struct pt_regs *regs)
 	enable_local_irqs();
 	ti = current_thread_info();
 
-#ifdef CONFIG_IPIPE
 	#define __SYSCALL_MASK (~0)
 	ret = ipipe_handle_syscall(ti, nr & __SYSCALL_MASK, regs);
 	if (ret > 0) {
 		disable_local_irqs();
 		return;
 	}
-	if (ret < 0)
-		goto done;
-#endif
+	if (ret < 0) {
+		__syscall_return_slowpath(regs, false);
+		return;
+	}
 
 	if (READ_ONCE(ti->flags) & _TIF_WORK_SYSCALL_ENTRY)
 		nr = syscall_trace_enter(regs);
@@ -342,9 +344,6 @@ __visible void do_syscall_64(unsigned long nr, struct pt_regs *regs)
 #endif
 	}
 
-#ifdef CONFIG_IPIPE
-done:
-#endif
 	syscall_return_slowpath(regs);
 }
 #endif
@@ -404,8 +403,10 @@ static __always_inline void do_syscall_32_irqs_on(struct pt_regs *regs)
 		disable_local_irqs();
 		return;
 	}
-	if (ret < 0)
-		goto done;
+	if (ret < 0) {
+		__syscall_return_slowpath(regs, false);
+		return;
+	}
 
 	if (READ_ONCE(ti->flags) & _TIF_WORK_SYSCALL_ENTRY) {
 		/*
@@ -434,7 +435,7 @@ static __always_inline void do_syscall_32_irqs_on(struct pt_regs *regs)
 			(unsigned int)regs->di, (unsigned int)regs->bp);
 #endif /* CONFIG_IA32_EMULATION */
 	}
-done:
+
 	syscall_return_slowpath(regs);
 }
 
-- 
2.26.2

