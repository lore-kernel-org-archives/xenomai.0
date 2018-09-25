From: Philippe Gerum <rpm@xenomai.org>
Date: Tue, 25 Sep 2018 12:37:44 +0200
Message-Id: <20180925103809.4932-8-rpm@xenomai.org>
In-Reply-To: <20180925103809.4932-1-rpm@xenomai.org>
References: <20180925103809.4932-1-rpm@xenomai.org>
Subject: [Xenomai] [PATCH 07/32] x86/i8259: ipipe: enable interrupt
 pipelining
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Fix up the legacy 8259 PIC driver to enable out-of-band calls from the
pipeline core for acknowledging incoming IRQs.
---
 arch/x86/include/asm/i8259.h |  2 +-
 arch/x86/kernel/i8259.c      | 31 ++++++++++++++++++++++++-------
 2 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/i8259.h b/arch/x86/include/asm/i8259.h
index 89789e8c80f6..dc376e53aa2a 100644
--- a/arch/x86/include/asm/i8259.h
+++ b/arch/x86/include/asm/i8259.h
@@ -26,7 +26,7 @@ extern unsigned int cached_irq_mask;
 #define SLAVE_ICW4_DEFAULT	0x01
 #define PIC_ICW4_AEOI		2
 
-extern raw_spinlock_t i8259A_lock;
+IPIPE_DECLARE_RAW_SPINLOCK(i8259A_lock);
 
 /* the PIC may need a careful delay on some platforms, hence specific calls */
 static inline unsigned char inb_pic(unsigned int port)
diff --git a/arch/x86/kernel/i8259.c b/arch/x86/kernel/i8259.c
index 02abc134367f..60726586b796 100644
--- a/arch/x86/kernel/i8259.c
+++ b/arch/x86/kernel/i8259.c
@@ -33,7 +33,7 @@
 static void init_8259A(int auto_eoi);
 
 static int i8259A_auto_eoi;
-DEFINE_RAW_SPINLOCK(i8259A_lock);
+IPIPE_DEFINE_RAW_SPINLOCK(i8259A_lock);
 
 /*
  * 8259A PIC functions to handle ISA devices:
@@ -61,6 +61,7 @@ static void mask_8259A_irq(unsigned int irq)
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&i8259A_lock, flags);
+	ipipe_lock_irq(irq);
 	cached_irq_mask |= mask;
 	if (irq & 8)
 		outb(cached_slave_mask, PIC_SLAVE_IMR);
@@ -76,15 +77,18 @@ static void disable_8259A_irq(struct irq_data *data)
 
 static void unmask_8259A_irq(unsigned int irq)
 {
-	unsigned int mask = ~(1 << irq);
+	unsigned int mask = (1 << irq);
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&i8259A_lock, flags);
-	cached_irq_mask &= mask;
-	if (irq & 8)
-		outb(cached_slave_mask, PIC_SLAVE_IMR);
-	else
-		outb(cached_master_mask, PIC_MASTER_IMR);
+	if (cached_irq_mask & mask) {
+		cached_irq_mask &= ~mask;
+		if (irq & 8)
+			outb(cached_slave_mask, PIC_SLAVE_IMR);
+		else
+			outb(cached_master_mask, PIC_MASTER_IMR);
+		ipipe_unlock_irq(irq);
+	}
 	raw_spin_unlock_irqrestore(&i8259A_lock, flags);
 }
 
@@ -170,6 +174,18 @@ static void mask_and_ack_8259A(struct irq_data *data)
 	 */
 	if (cached_irq_mask & irqmask)
 		goto spurious_8259A_irq;
+#ifdef CONFIG_IPIPE
+	if (irq == 0) {
+		/*
+		 * Fast timer ack -- don't mask (unless supposedly
+		 * spurious). We trace outb's in order to detect
+		 * broken hardware inducing large delays.
+		 */
+		outb(0x60, PIC_MASTER_CMD);	/* Specific EOI to master. */
+		raw_spin_unlock_irqrestore(&i8259A_lock, flags);
+		return;
+	}
+#endif /* CONFIG_IPIPE */
 	cached_irq_mask |= irqmask;
 
 handle_real_irq:
@@ -226,6 +242,7 @@ struct irq_chip i8259A_chip = {
 	.irq_disable	= disable_8259A_irq,
 	.irq_unmask	= enable_8259A_irq,
 	.irq_mask_ack	= mask_and_ack_8259A,
+	.flags		= IRQCHIP_PIPELINE_SAFE,
 };
 
 static char irq_trigger[2];
-- 
2.14.4


