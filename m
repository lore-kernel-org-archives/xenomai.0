From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH] x86: irq_pipeline: remove stale reference to BAU TLB shootdown
Date: Thu, 23 Sep 2021 15:44:21 +0200
Message-Id: <20210923134421.2561024-1-rpm@xenomai.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Philippe Gerum <rpm@xenomai.org>

The vector handler being referred to is gone since #39297dde739. This
causes a build failure when CONFIG_X86_UV is set.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 arch/x86/kernel/irq_pipeline.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/x86/kernel/irq_pipeline.c b/arch/x86/kernel/irq_pipeline.c
index 8daac9f78ebe637..1f7a0ab1631992b 100644
--- a/arch/x86/kernel/irq_pipeline.c
+++ b/arch/x86/kernel/irq_pipeline.c
@@ -60,8 +60,6 @@ void irq_send_oob_ipi(unsigned int ipi,
 }
 EXPORT_SYMBOL_GPL(irq_send_oob_ipi);
 
-void uv_bau_message_interrupt(struct pt_regs *regs);
-
 static void do_sysvec_inband(struct irq_desc *desc)
 {
 	unsigned int irq = irq_desc_get_irq(desc);
@@ -112,11 +110,6 @@ static void do_sysvec_inband(struct irq_desc *desc)
 	case IRQ_WORK_VECTOR:
 		__sysvec_irq_work(regs);
 		break;
-#ifdef CONFIG_X86_UV
-	case UV_BAU_MESSAGE:
-		__sysvec_uv_bau_message(regs);
-		break;
-#endif
 #ifdef CONFIG_HAVE_KVM
 	case POSTED_INTR_VECTOR:
 		__sysvec_kvm_posted_intr_ipi(regs);
-- 
2.31.1


