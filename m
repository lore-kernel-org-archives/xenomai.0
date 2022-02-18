Message-ID: <8656840e-02c3-01ac-02d9-ec0bcafee3d3@siemens.com>
Date: Fri, 18 Feb 2022 10:07:55 +0100
MIME-Version: 1.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] x86: dovetail: Drop superfluous oob trap hooks from
 kernelmode_fixup_or_oops
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

Due to an earlier check for running_oob(), this path will always be
entered in-band. So the hooks are pointless.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/x86/mm/fault.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 37111d88add2..75df0fa390cf 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -740,7 +740,6 @@ kernelmode_fixup_or_oops(struct pt_regs *regs, unsigned long error_code,
 		if (current->thread.sig_on_uaccess_err && signal) {
 			sanitize_error_code(address, &error_code);
 
-			oob_trap_notify(X86_TRAP_PF, regs);
 			set_signal_archinfo(address, error_code);
 
 			if (si_code == SEGV_PKUERR) {
@@ -749,7 +748,6 @@ kernelmode_fixup_or_oops(struct pt_regs *regs, unsigned long error_code,
 				/* XXX: hwpoison faults will set the wrong code. */
 				force_sig_fault(signal, si_code, (void __user *)address);
 			}
-			oob_trap_unwind(X86_TRAP_PF, regs);
 		}
 
 		/*
-- 
2.34.1

