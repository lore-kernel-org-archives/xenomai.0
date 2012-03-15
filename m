Message-ID: <4F6209FD.5080808@domain.hid>
Date: Thu, 15 Mar 2012 16:25:49 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] [PATCH 2.6.38+] ipipe: x86: Fix user land detection on
 unhandled non-root faults
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>, adeos-main <adeos-main@gna.org>

Not only page faults are processed by __ipipe_handle_exception, so the
validity and encoding of error_code varies. Use user_mode_vm instead to
detect if the fault was raised over a user context.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 arch/x86/kernel/ipipe.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/x86/kernel/ipipe.c b/arch/x86/kernel/ipipe.c
index 5be7005..b2e2a5b 100644
--- a/arch/x86/kernel/ipipe.c
+++ b/arch/x86/kernel/ipipe.c
@@ -560,7 +560,8 @@ int __ipipe_handle_exception(struct pt_regs *regs, long error_code, int vector)
 		ipipe_trace_panic_freeze();
 
 		/* Always warn about user land and unfixable faults. */
-		if ((error_code & 4) || !search_exception_tables(instruction_pointer(regs))) {
+		if (user_mode_vm(regs) ||
+		    !search_exception_tables(instruction_pointer(regs))) {
 			printk(KERN_ERR "BUG: Unhandled exception over domain"
 			       " %s at 0x%lx - switching to ROOT\n",
 			       ipd->name, instruction_pointer(regs));
-- 
1.7.3.4

