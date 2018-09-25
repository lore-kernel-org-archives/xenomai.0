From: Philippe Gerum <rpm@xenomai.org>
Date: Tue, 25 Sep 2018 12:37:42 +0200
Message-Id: <20180925103809.4932-6-rpm@xenomai.org>
In-Reply-To: <20180925103809.4932-1-rpm@xenomai.org>
References: <20180925103809.4932-1-rpm@xenomai.org>
Subject: [Xenomai] [PATCH 05/32] x86/iommu: enable interrupt pipelining
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Fix up the IRQ remapping code from the IOMMU controller driver in
order to actually ack the APIC upon incoming edge interrupts. A
previous change made ack_APIC_irq() a null placeholder, since the
original interrupt handlers calling it should not ack the APIC
anymore, once pipelining is in place.

We must revert this change in the acknowledge handler though, since
the pipeline core needs it to issue such ack.
---
 drivers/iommu/irq_remapping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/irq_remapping.c b/drivers/iommu/irq_remapping.c
index 49721b4e1975..d26506a24c61 100644
--- a/drivers/iommu/irq_remapping.c
+++ b/drivers/iommu/irq_remapping.c
@@ -158,7 +158,7 @@ void panic_if_irq_remap(const char *msg)
 
 void ir_ack_apic_edge(struct irq_data *data)
 {
-	ack_APIC_irq();
+	__ack_APIC_irq();
 }
 
 /**
-- 
2.14.4


