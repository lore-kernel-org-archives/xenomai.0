Message-ID: <4BD554BD.4060803@domain.hid>
Date: Mon, 26 Apr 2010 10:54:21 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] [PATCH] x86: Update comment regarding __fixup_if
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

Properly reflect the changes ed2e37c brought.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 arch/x86/kernel/ipipe.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/ipipe.c b/arch/x86/kernel/ipipe.c
index 116fee7..9425fbd 100644
--- a/arch/x86/kernel/ipipe.c
+++ b/arch/x86/kernel/ipipe.c
@@ -749,11 +749,12 @@ int __ipipe_handle_exception(struct pt_regs *regs, long error_code, int vector)
 
 	if (likely(ipipe_root_domain_p)) {
 		/*
-		 * In case we faulted in the iret path, regs.flags do not
-		 * match the root domain state. The fault handler or the
-		 * low-level return code may evaluate it. Fix this up, either
-		 * by the root state sampled on entry or, if we migrated to
-		 * root, with the current state.
+		 * If root is not the topmost domain or in case we faulted in
+		 * the iret path of x86-32, regs.flags does not match the root
+		 * domain state. The fault handler or the low-level return
+		 * code may evaluate it. So fix this up, either by the root
+		 * state sampled on entry or, if we migrated to root, with the
+		 * current state.
 		 */
 		__fixup_if(root_entry ? raw_irqs_disabled_flags(flags) :
 					raw_irqs_disabled(), regs);


