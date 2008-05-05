Message-ID: <481F31E0.3050608@domain.hid>
Date: Mon, 05 May 2008 18:12:16 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [HACK] x86-64: Reenable lockdep over i-pipe
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: adeos-main <adeos-main@gna.org>
Cc: Xenomai-core@domain.hid

Hi,

not worth to call it a patch, at least not when looking at the second
file.

Lockdep gets unhappy when I-pipe is enabled because

 a) TRACE_IRQS_ON/OFF instrumentations in entry_64.S do not correlate
    with the root's pipeline state. Instead of fixing the latter (which
    costs extra cycles), the fix relaxes the sanity check.

 b) The exit path of __ipipe_handle_exception reenables Linux IRQs when
    the were not disabled. I do not understand that case fully yet, so
    I hacked the alarm away with that cli.

Jan

---
 arch/x86/kernel/ipipe.c |    1 +
 kernel/lockdep.c        |    4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

Index: b/kernel/lockdep.c
===================================================================
--- a/kernel/lockdep.c
+++ b/kernel/lockdep.c
@@ -2028,7 +2028,7 @@ void trace_hardirqs_on(void)
 	curr->hardirqs_enabled = 1;
 	ip = (unsigned long) __builtin_return_address(0);
 
-	if (DEBUG_LOCKS_WARN_ON(!irqs_disabled()))
+	if (DEBUG_LOCKS_WARN_ON(!irqs_disabled() && !irqs_disabled_hw()))
 		return;
 	if (DEBUG_LOCKS_WARN_ON(current->hardirq_context))
 		return;
@@ -2064,7 +2064,7 @@ void trace_hardirqs_off(void)
 	if (unlikely(!debug_locks || current->lockdep_recursion))
 		return;
 
-	if (DEBUG_LOCKS_WARN_ON(!irqs_disabled()))
+	if (DEBUG_LOCKS_WARN_ON(!irqs_disabled() && !irqs_disabled_hw()))
 		return;
 
 	if (curr->hardirqs_enabled) {
Index: b/arch/x86/kernel/ipipe.c
===================================================================
--- a/arch/x86/kernel/ipipe.c
+++ b/arch/x86/kernel/ipipe.c
@@ -799,6 +799,7 @@ int __ipipe_handle_exception(struct pt_r
 	}
 
 	__ipipe_std_extable[vector](regs, error_code);
+	asm volatile ("cli");
 	local_irq_restore(flags);
 	__fixup_if(regs);
 

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

