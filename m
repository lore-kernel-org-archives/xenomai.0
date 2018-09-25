From: Philippe Gerum <rpm@xenomai.org>
Date: Tue, 25 Sep 2018 12:38:02 +0200
Message-Id: <20180925103809.4932-26-rpm@xenomai.org>
In-Reply-To: <20180925103809.4932-1-rpm@xenomai.org>
References: <20180925103809.4932-1-rpm@xenomai.org>
Subject: [Xenomai] [PATCH 25/32] x86/irq: ipipe: reconcile lockdep tracing
 with virtual IRQ state
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

---
 arch/x86/entry/entry_64.S | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index c304b11facb5..f6fe849d66ed 100644
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


