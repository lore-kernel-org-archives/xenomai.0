From: Philippe Gerum <rpm@xenomai.org>
Date: Tue, 25 Sep 2018 12:38:04 +0200
Message-Id: <20180925103809.4932-28-rpm@xenomai.org>
In-Reply-To: <20180925103809.4932-1-rpm@xenomai.org>
References: <20180925103809.4932-1-rpm@xenomai.org>
Subject: [Xenomai] [PATCH 27/32] x86/msi: ipipe: advertise pipelining support
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
 arch/x86/kernel/apic/msi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index 5a1006a8e66d..8ee66f4d1237 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -68,7 +68,7 @@ static struct irq_chip pci_msi_controller = {
 #if defined(CONFIG_IPIPE) && defined(CONFIG_SMP)
 	.irq_move		= move_xxapic_irq,
 #endif
-	.flags			= IRQCHIP_SKIP_SET_WAKE,
+	.flags			= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_PIPELINE_SAFE,
 };
 
 int native_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
@@ -169,7 +169,7 @@ static struct irq_chip pci_msi_ir_controller = {
 #if defined(CONFIG_IPIPE) && defined(CONFIG_SMP)
 	.irq_move		= move_xxapic_irq,
 #endif
-	.flags			= IRQCHIP_SKIP_SET_WAKE,
+	.flags			= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_PIPELINE_SAFE,
 };
 
 static struct msi_domain_info pci_msi_ir_domain_info = {
@@ -214,7 +214,7 @@ static struct irq_chip dmar_msi_controller = {
 #if defined(CONFIG_IPIPE) && defined(CONFIG_SMP)
 	.irq_move		= move_xxapic_irq,
 #endif
-	.flags			= IRQCHIP_SKIP_SET_WAKE,
+	.flags			= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_PIPELINE_SAFE,
 };
 
 static irq_hw_number_t dmar_msi_get_hwirq(struct msi_domain_info *info,
@@ -314,7 +314,7 @@ static struct irq_chip hpet_msi_controller __ro_after_init = {
 #if defined(CONFIG_IPIPE) && defined(CONFIG_SMP)
 	.irq_move = move_xxapic_irq,
 #endif
-	.flags = IRQCHIP_SKIP_SET_WAKE,
+	.flags = IRQCHIP_SKIP_SET_WAKE | IRQCHIP_PIPELINE_SAFE,
 };
 
 static irq_hw_number_t hpet_msi_get_hwirq(struct msi_domain_info *info,
-- 
2.14.4


