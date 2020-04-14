From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] x86: ipipe: Do not dump panic traces outside of an oops
Message-ID: <229d03dc-91e5-5d0d-9c17-dc32b2be7f28@siemens.com>
Date: Tue, 14 Apr 2020 08:11:56 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

If the reported error leads to an oops, those messages can easily get
lost as they will be dumped only after the oops report - if we get
there and do not lock up earlier. And the dump by the oops will not find
a trace anymore as the first one consumed it. It is more important to
have the trace reliably on oopses than on warnings.

Move up the freeze a bit at this chance.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/x86/kernel/ipipe.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/ipipe.c b/arch/x86/kernel/ipipe.c
index 5c74312f3331..4b0955c3ff49 100644
--- a/arch/x86/kernel/ipipe.c
+++ b/arch/x86/kernel/ipipe.c
@@ -421,6 +421,8 @@ dotraplinkage int __ipipe_trap_prologue(struct pt_regs *regs, int trapnr, unsign
 		ipd = __ipipe_current_domain;
 		__ipipe_set_current_domain(ipipe_root_domain);
 
+		ipipe_trace_panic_freeze();
+
 		/*
 		 * Prevent warnings of this debug checker to focus on the
 		 * actual bug.
@@ -432,8 +434,6 @@ dotraplinkage int __ipipe_trap_prologue(struct pt_regs *regs, int trapnr, unsign
 		if (entry_irqs_off)
 			local_irq_disable();
 
-		ipipe_trace_panic_freeze();
-
 		/* Always warn about user land and unfixable faults. */
 		if (user_mode(regs) ||
 		    !search_exception_tables(instruction_pointer(regs))) {
@@ -441,14 +441,12 @@ dotraplinkage int __ipipe_trap_prologue(struct pt_regs *regs, int trapnr, unsign
 			       " %s at 0x%lx - switching to ROOT\n",
 			       ipd->name, instruction_pointer(regs));
 			dump_stack();
-			ipipe_trace_panic_dump();
 		} else if (IS_ENABLED(CONFIG_IPIPE_DEBUG)) {
 			/* Also report fixable ones when debugging is enabled. */
 			printk(KERN_WARNING "WARNING: Fixable exception over "
 			       "domain %s at 0x%lx - switching to ROOT\n",
 			       ipd->name, instruction_pointer(regs));
 			dump_stack();
-			ipipe_trace_panic_dump();
 		}
 	}
 
-- 
2.16.4

