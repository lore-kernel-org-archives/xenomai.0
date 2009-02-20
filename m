Message-ID: <499EBF45.900@domain.hid>
Date: Fri, 20 Feb 2009 15:33:41 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] [PATCH] x86: Proper root domain state management for
	ipipe_handle_exception
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>

This is an attempt to fix the broken root domain state adjustment in
__ipipe_handle_exception. Patch below fixes the issues recently reported
by Roman Pisl. Also, it currently makes much more sense to me than what
we have so far.

In short, this patch propagates the hardware irq state into the root
domains stall flag shortly before calling into the Linux handler, and
only then. This avoids spurious root domain stalls the end up over the
wrong Linux context due to context switches between enter and exit of
ipipe_handle_exception. Also, this patch drops the bogus
local_irq_save/restore pair that doesn't account for Linux irq state
changes inside its fault handler.

But that doesn't mean that the ripped-out code may not have been there
for a reason. Maybe I oversee some corner case that regresses now. If
anyone knows such a case, please share your knowledge so that it can be
addressed and (very important!) properly documented in the code.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>

---
 arch/x86/kernel/ipipe.c |   34 +++++++++-------------------------
 1 file changed, 9 insertions(+), 25 deletions(-)

Index: b/arch/x86/kernel/ipipe.c
===================================================================
--- a/arch/x86/kernel/ipipe.c
+++ b/arch/x86/kernel/ipipe.c
@@ -755,39 +755,18 @@ static int __ipipe_xlate_signo[] = {
 
 int __ipipe_handle_exception(struct pt_regs *regs, long error_code, int vector)
 {
-	unsigned long flags;
-
-	local_save_flags(flags);
-
-	/* Track the hw interrupt state before calling the Linux
-	 * exception handler, replicating it into the virtual mask. */
-
-	if (irqs_disabled_hw()) {
-		/* Do not trigger the alarm in ipipe_check_context() by using
-		 * plain local_irq_disable(). */
-		__ipipe_stall_root();
-		trace_hardirqs_off();
-		barrier();
-	}
+	int irqs_disabled = irqs_disabled_hw();
 
 #ifdef CONFIG_KGDB
 	/* catch exception KGDB is interested in over non-root domains */
 	if (!ipipe_root_domain_p &&
 	    __ipipe_xlate_signo[vector] >= 0 &&
-	    !kgdb_handle_exception(vector, __ipipe_xlate_signo[vector], error_code, regs)) {
-		if (flags & X86_EFLAGS_IF)
-			__clear_bit(IPIPE_STALL_FLAG,
-				    &ipipe_root_cpudom_var(status));
+	    !kgdb_handle_exception(vector, __ipipe_xlate_signo[vector], error_code, regs))
 		return 1;
-	}
 #endif /* CONFIG_KGDB */
 
-	if (unlikely(ipipe_trap_notify(vector, regs))) {
-		if (flags & X86_EFLAGS_IF)
-			__clear_bit(IPIPE_STALL_FLAG,
-				    &ipipe_root_cpudom_var(status));
+	if (unlikely(ipipe_trap_notify(vector, regs)))
 		return 1;
-	}
 
 	/* Detect unhandled faults over non-root domains. */
 
@@ -818,9 +797,14 @@ int __ipipe_handle_exception(struct pt_r
 		}
 	}
 
+	/* Track the hw interrupt state before calling the Linux
+	 * exception handler, replicating it into the virtual mask. */
+
+	if (irqs_disabled)
+		local_irq_disable();
+
 	__ipipe_std_extable[vector](regs, error_code);
 	local_irq_disable_hw();
-	local_irq_restore(flags);
 	__fixup_if(regs);
 
 	return 0;

