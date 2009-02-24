Message-ID: <49A42D71.8040702@domain.hid>
Date: Tue, 24 Feb 2009 18:25:05 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] [PATCH] x86: Document exception handling
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

...so that validating these code paths becomes easier in case of future
troubles.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>

[ PS: Find the patch also at
git://git.kiszka.org/ipipe-2.6.git queues/2.6.28-x86
(together with other pending patches). ]
---

 arch/x86/kernel/ipipe.c |   26 ++++++++++++++++++++++----
 1 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/ipipe.c b/arch/x86/kernel/ipipe.c
index 6d3c434..964691f 100644
--- a/arch/x86/kernel/ipipe.c
+++ b/arch/x86/kernel/ipipe.c
@@ -631,13 +631,15 @@ int __ipipe_handle_exception(struct pt_regs *regs, long error_code, int vector)
 {
 	unsigned long flags;
 
+	/* Pick up the root domain state of the interrupted context. */
 	local_save_flags(flags);
 
-	/*
-	 * Track the hw interrupt state before calling the I-pipe
-	 * event handler, replicating it into the virtual mask.
-	 */
 	if (ipipe_root_domain_p) {
+		/*
+		 * Replicate hw interrupt state into the virtual mask before
+		 * calling the I-pipe event handler over the root domain. Also
+		 * required later when calling the Linux exception handler.
+		 */
 		if (irqs_disabled_hw())
 			local_irq_disable();
 	}
@@ -654,6 +656,11 @@ int __ipipe_handle_exception(struct pt_regs *regs, long error_code, int vector)
 		return 1;
 	}
 
+	/*
+	 * 32-bit: In case we migrated to root domain inside the event
+	 * handler, restore the original IF from exception entry as the
+	 * low-level return code will evaluate it.
+	 */
 	__fixup_if(raw_irqs_disabled_flags(flags), regs);
 
 	if (unlikely(!ipipe_root_domain_p)) {
@@ -685,6 +692,11 @@ int __ipipe_handle_exception(struct pt_regs *regs, long error_code, int vector)
 	}
 
 	__ipipe_std_extable[vector](regs, error_code);
+
+	/*
+	 * Relevant for 64-bit: Restore root domain state as the low-level
+	 * return code will not align it to regs.flags.
+	 */
 	local_irq_restore_nosync(flags);
 
 	return 0;
@@ -694,6 +706,7 @@ int __ipipe_divert_exception(struct pt_regs *regs, int vector)
 {
 	unsigned long flags;
 
+	/* Same root state handling as in __ipipe_handle_exception. */
 	local_save_flags(flags);
 
 	if (ipipe_root_domain_p) {
@@ -722,6 +735,11 @@ int __ipipe_divert_exception(struct pt_regs *regs, int vector)
 		return 1;
 	}
 
+	/*
+	 * 32-bit: Due to possible migration inside the event handler, we have
+	 * to restore IF so that low-level return code sets the root domain
+	 * state correctly.
+	 */
 	__fixup_if(raw_irqs_disabled_flags(flags), regs);
 
 	return 0;

