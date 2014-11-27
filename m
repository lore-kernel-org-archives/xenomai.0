Message-ID: <54778F5D.1060009@siemens.com>
Date: Thu, 27 Nov 2014 21:53:49 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [PATCH] x86/ipipe: Fix root state on return from certain
	exceptions
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

do_stack_segment, do_int3 and do_debug disable interrupts of the root
domain before returning the exception trampoline code. However, I-ipipe
does not update the root state before returning from exceptions. So we
erroneously stalled root this way, specifically during gdb sessions. The
issue was easily triggerable by enabling CONFIG_DEBUG_ATOMIC_SLEEP and
then trying to debug a program.

This now simply disables physical interrupts and leaves the root state
untouched across exception return.

Note: There is also conditional_cli, but that's unused by Linux.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

For review. Still not totally sure if there aren't more of such corner
cases or if this can have some side effect.

 arch/x86/kernel/traps.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index c086b59..f78f79c 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -102,7 +102,16 @@ static inline void conditional_cli(struct pt_regs *regs)
 static inline void preempt_conditional_cli(struct pt_regs *regs)
 {
 	if (regs->flags & X86_EFLAGS_IF)
-		local_irq_disable();
+		/*
+		 * I-pipe doesn't virtualize the IRQ flags in the entry code.
+		 * Therefore we cannot call the original local_irq_disable here
+		 * because there will be no pairing IRQ enable for the root
+		 * domain. So just disable interrupts physically.
+		 *
+		 * There is also no I-pipe hard-irq tracing on return from the
+		 * exception, so do not trace here either.
+		 */
+		hard_local_irq_disable_notrace();
 	preempt_count_dec();
 }
 
-- 
1.8.4.5

