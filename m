From: Philippe Gerum <rpm@xenomai.org>
Date: Tue, 25 Sep 2018 12:27:16 +0200
Message-Id: <20180925102716.4492-12-rpm@xenomai.org>
In-Reply-To: <20180925102716.4492-1-rpm@xenomai.org>
References: <20180925102716.4492-1-rpm@xenomai.org>
Subject: [Xenomai] [PATCH 11/11] arm64: ipipe: preserve the hard interrupt
 state across mayday trap
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

The mayday trap asks the co-kernel to deal with a runaway context
which has been detected earlier. When doing so, the co-kernel might
re-enable hard interrupts, which we have to disable again before
unwinding the IRQ context which triggered the whole process (like a
watchdog event).

Use __ipipe_call_mayday() to fire the notification to the co-kernel
instead of the open coded version, so that we do restore the hard
interrupt state properly before leaving __ipipe_exit_irq().
---
 arch/arm64/kernel/ipipe.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/kernel/ipipe.c b/arch/arm64/kernel/ipipe.c
index 10273ce8a846..0488936bf2ea 100644
--- a/arch/arm64/kernel/ipipe.c
+++ b/arch/arm64/kernel/ipipe.c
@@ -165,21 +165,8 @@ void __ipipe_enable_pipeline(void)
 
 void __ipipe_exit_irq(struct pt_regs *regs)
 {
-	/*
-	 * Testing for user_regs() eliminates foreign stack contexts,
-	 * including from legacy domains which did not set the foreign
-	 * stack bit (foreign stacks are always kernel-based).
-	 */
-	if (user_mode(regs) &&
-	    ipipe_test_thread_flag(TIP_MAYDAY)) {
-		/*
-		 * MAYDAY is never raised under normal circumstances,
-		 * so prefer test then maybe clear over
-		 * test_and_clear.
-		 */
-		ipipe_clear_thread_flag(TIP_MAYDAY);
-		__ipipe_notify_trap(IPIPE_TRAP_MAYDAY, regs);
-	}
+	if (user_mode(regs) && ipipe_test_thread_flag(TIP_MAYDAY))
+		__ipipe_call_mayday(regs);
 }
 
 /* hw irqs off */
-- 
2.14.4


