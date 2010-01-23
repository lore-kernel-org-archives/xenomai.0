Message-ID: <4B5B02E3.8060103@domain.hid>
Date: Sat, 23 Jan 2010 15:08:35 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [RFC][PATCH] x86: Fix root domain state restoring on
	exception return
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>, Wolfgang Mauerer <wolfgang.mauerer@domain.hid>, xenomai-core <xenomai@xenomai.org>

If we enter __ipipe_handle_exception over a non-root domain and leave it
due to migration in the event handler over root, we must not restore the
root domain state so far saved on entry. This caused subtle pipeline
state corruptions. Actually, we only need to save the state if we enter
over the root domain and have to align its state to the hardware
interrupt mask.

Moreover, the x86-32 regs.eflags fix-up must happen based on the current
root domain state to avoid more spurious corruptions.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

This patch is so far running fine on the x86-64 boxes of our colleagues
@Healthcare. It currently makes most sense to me, also for (untested)
x86-32, but maybe I'm still missing a problematic scenario.

 arch/x86/kernel/ipipe.c |   64 ++++++++++++++++++++++++++--------------------
 1 files changed, 36 insertions(+), 28 deletions(-)

diff --git a/arch/x86/kernel/ipipe.c b/arch/x86/kernel/ipipe.c
index 4442d96..8253993 100644
--- a/arch/x86/kernel/ipipe.c
+++ b/arch/x86/kernel/ipipe.c
@@ -702,19 +702,17 @@ static int __ipipe_xlate_signo[] = {
 
 int __ipipe_handle_exception(struct pt_regs *regs, long error_code, int vector)
 {
-	unsigned long flags;
-
-	/* Pick up the root domain state of the interrupted context. */
-	local_save_flags(flags);
+	bool restore_flags = false;
+	unsigned long flags = 0;
 
-	if (ipipe_root_domain_p) {
+	if (ipipe_root_domain_p && irqs_disabled_hw()) {
 		/*
 		 * Replicate hw interrupt state into the virtual mask before
 		 * calling the I-pipe event handler over the root domain. Also
 		 * required later when calling the Linux exception handler.
 		 */
-		if (irqs_disabled_hw())
-			local_irq_disable();
+		local_irq_save(flags);
+		restore_flags = true;
 	}
 #ifdef CONFIG_KGDB
 	/* catch exception KGDB is interested in over non-root domains */
@@ -725,18 +723,19 @@ int __ipipe_handle_exception(struct pt_regs *regs, long error_code, int vector)
 #endif /* CONFIG_KGDB */
 
 	if (unlikely(ipipe_trap_notify(vector, regs))) {
-		local_irq_restore_nosync(flags);
+		if (restore_flags)
+			local_irq_restore_nosync(flags);
 		return 1;
 	}
 
-	/*
-	 * 32-bit: In case we migrated to root domain inside the event
-	 * handler, restore the original IF from exception entry as the
-	 * low-level return code will evaluate it.
-	 */
-	__fixup_if(raw_irqs_disabled_flags(flags), regs);
-
-	if (unlikely(!ipipe_root_domain_p)) {
+	if (likely(ipipe_root_domain_p)) {
+		/*
+		 * 32-bit: In case we migrated to root domain inside the event
+		 * handler, align regs.flags with the root domain state as the
+		 * low-level return code will evaluate it.
+		 */
+		__fixup_if(raw_irqs_disabled(), regs);
+	} else {
 		/* Detect unhandled faults over non-root domains. */
 		struct ipipe_domain *ipd = ipipe_current_domain;
 
@@ -770,21 +769,26 @@ int __ipipe_handle_exception(struct pt_regs *regs, long error_code, int vector)
 	 * Relevant for 64-bit: Restore root domain state as the low-level
 	 * return code will not align it to regs.flags.
 	 */
-	local_irq_restore_nosync(flags);
+	if (restore_flags)
+		local_irq_restore_nosync(flags);
 
 	return 0;
 }
 
 int __ipipe_divert_exception(struct pt_regs *regs, int vector)
 {
-	unsigned long flags;
-
-	/* Same root state handling as in __ipipe_handle_exception. */
-	local_save_flags(flags);
+	bool restore_flags = false;
+	unsigned long flags = 0;
 
 	if (ipipe_root_domain_p) {
-		if (irqs_disabled_hw())
-			local_irq_disable();
+		if (irqs_disabled_hw()) {
+			/*
+			 * Same root state handling as in
+			 * __ipipe_handle_exception.
+			 */
+			local_irq_save(flags);
+			restore_flags = true;
+		}
 	}
 #ifdef CONFIG_KGDB
 	/* catch int1 and int3 over non-root domains */
@@ -804,16 +808,20 @@ int __ipipe_divert_exception(struct pt_regs *regs, int vector)
 #endif /* CONFIG_KGDB */
 
 	if (unlikely(ipipe_trap_notify(vector, regs))) {
-		local_irq_restore_nosync(flags);
+		if (restore_flags)
+			local_irq_restore_nosync(flags);
 		return 1;
 	}
 
+	if (likely(ipipe_root_domain_p)) {
+		/* see __ipipe_handle_exception */
+		__fixup_if(raw_irqs_disabled(), regs);
+	}
+
 	/*
-	 * 32-bit: Due to possible migration inside the event handler, we have
-	 * to restore IF so that low-level return code sets the root domain
-	 * state correctly.
+	 * No need to restore root state in the 64-bit case, the Linux handler
+	 * and the return code will take care of it.
 	 */
-	__fixup_if(raw_irqs_disabled_flags(flags), regs);
 
 	return 0;
 }
-- 
1.6.0.2

