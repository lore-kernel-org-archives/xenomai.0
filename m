From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] x86: ipipe: Turn off context check in __ipipe_trap_prologue
Message-ID: <70c51d28-9fc5-31b8-6f50-26986d3e7eb7@siemens.com>
Date: Tue, 14 Apr 2020 08:11:35 +0200
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

If the head domain is stalled due to a bug, reporting the fault will
trigger also the context checker at various points, piling up misleading
bug reports.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/x86/kernel/ipipe.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kernel/ipipe.c b/arch/x86/kernel/ipipe.c
index afe730649a5f..5c74312f3331 100644
--- a/arch/x86/kernel/ipipe.c
+++ b/arch/x86/kernel/ipipe.c
@@ -421,6 +421,13 @@ dotraplinkage int __ipipe_trap_prologue(struct pt_regs *regs, int trapnr, unsign
 		ipd = __ipipe_current_domain;
 		__ipipe_set_current_domain(ipipe_root_domain);
 
+		/*
+		 * Prevent warnings of this debug checker to focus on the
+		 * actual bug.
+		 */
+		if (test_bit(IPIPE_STALL_FLAG, &__ipipe_head_status))
+			ipipe_context_check_off();
+
 		/* Sync Linux interrupt state with hardware state on entry. */
 		if (entry_irqs_off)
 			local_irq_disable();
-- 
2.16.4

