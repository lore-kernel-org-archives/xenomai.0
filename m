Message-ID: <4B5D58E2.60603@domain.hid>
Date: Mon, 25 Jan 2010 09:40:02 +0100
From: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020505030903070504040003"
Subject: [Xenomai-core] Fwd: Re: [RFC][PATCH] x86: Fix root domain state
 restoring on exception return
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: "Kiszka, Jan" <jan.kiszka@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>, adeos-main@gna.org

This is a multi-part message in MIME format.
--------------020505030903070504040003
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

(sorry if you get this twice, the cc addresses were screwed up
by copy and paste last time)

Kiszka, Jan wrote:

> If we enter __ipipe_handle_exception over a non-root domain and leave it
> due to migration in the event handler over root, we must not restore the
> root domain state so far saved on entry. This caused subtle pipeline
> state corruptions. Actually, we only need to save the state if we enter
> over the root domain and have to align its state to the hardware
> interrupt mask.
>
> Moreover, the x86-32 regs.eflags fix-up must happen based on the current
> root domain state to avoid more spurious corruptions.

unfortunately, this won't boot on x86-32: During CPU bug checking
in check_hlt, the kernel will really go into the halt state and
never recover. By modifying __ipipe_handle_exception to use
raw_irqs_disabled_flags as argument to __fixup_if instead of
raw_irqs_disabled, everything is back to normal again. However,
I'm not sure if this is a) the proper solution or b) won't cause
problems somewhere else, so a discussion would be highly welcome...

Cheers, Wolfgang

--------------020505030903070504040003
Content-Type: text/x-patch;
 name="ipipe.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ipipe.diff"

diff --git a/arch/x86/kernel/ipipe.c b/arch/x86/kernel/ipipe.c
index 4442d96..5527e3c 100644
--- a/arch/x86/kernel/ipipe.c
+++ b/arch/x86/kernel/ipipe.c
@@ -702,19 +702,20 @@ static int __ipipe_xlate_signo[] = {
 
 int __ipipe_handle_exception(struct pt_regs *regs, long error_code, int vector)
 {
-	unsigned long flags;
+	bool restore_flags = false;
+	unsigned long flags = 0;
 
 	/* Pick up the root domain state of the interrupted context. */
 	local_save_flags(flags);
 
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
@@ -725,7 +726,8 @@ int __ipipe_handle_exception(struct pt_regs *regs, long error_code, int vector)
 #endif /* CONFIG_KGDB */
 
 	if (unlikely(ipipe_trap_notify(vector, regs))) {
-		local_irq_restore_nosync(flags);
+		if (restore_flags)
+			local_irq_restore_nosync(flags);
 		return 1;
 	}
 
@@ -734,9 +736,14 @@ int __ipipe_handle_exception(struct pt_regs *regs, long error_code, int vector)
 	 * handler, restore the original IF from exception entry as the
 	 * low-level return code will evaluate it.
 	 */
-	__fixup_if(raw_irqs_disabled_flags(flags), regs);
-
-	if (unlikely(!ipipe_root_domain_p)) {
+	if (likely(ipipe_root_domain_p)) {
+		/*
+		* 32-bit: In case we migrated to root domain inside the event
+		* handler, align regs.flags with the root domain state as the
+		* low-level return code will evaluate it.
+		*/
+		__fixup_if(raw_irqs_disabled_flags(flags), regs);
+	} else {
 		/* Detect unhandled faults over non-root domains. */
 		struct ipipe_domain *ipd = ipipe_current_domain;
 
@@ -770,21 +777,26 @@ int __ipipe_handle_exception(struct pt_regs *regs, long error_code, int vector)
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
@@ -804,16 +816,20 @@ int __ipipe_divert_exception(struct pt_regs *regs, int vector)
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

--------------020505030903070504040003--

