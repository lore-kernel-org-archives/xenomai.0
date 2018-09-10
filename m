From: Philippe Gerum <rpm@xenomai.org>
Date: Mon, 10 Sep 2018 10:40:43 +0200
Message-Id: <E1fzHmf-0004vb-SA@xenomai.org>
Subject: [Xenomai] [PATCH 1/1] x86/irq: ipipe: reconcile lockdep tracing
 with virtual IRQ state
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henning Schild <henning.schild@siemens.com>
Cc: xenomai@xenomai.org

---
 arch/x86/entry/entry_64.S | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 65389737b283..4780bd7c020f 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -557,8 +557,13 @@ END(irq_entries_start)
 
 1:
 	ENTER_IRQ_STACK old_rsp=%rdi
-	/* We entered an interrupt context - irqs are off: */
+#ifndef CONFIG_IPIPE	
+	/* We entered an interrupt context - irqs are off unless
+	   pipelining is enabled, in which case we defer tracing until
+	   __ipipe_do_sync_stage() where the virtual IRQ state is
+	   updated for the root stage. */
 	TRACE_IRQS_OFF
+#endif
 
 	call	\func	/* rdi points to pt_regs */
 	.endm
-- 
2.14.4


