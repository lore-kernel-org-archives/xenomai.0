From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v2 5/6] ipipe: Activate IRQ in ipipe_enable_irq
Date: Thu, 11 Jul 2019 21:56:16 +0200
Message-Id: <ceb083b98c32b9829f230eb7194a988ef4a7577d.1562874977.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1562874977.git.jan.kiszka@siemens.com>
References: <cover.1562874977.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1562874977.git.jan.kiszka@siemens.com>
References: <cover.1562874977.git.jan.kiszka@siemens.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

From: Jan Kiszka <jan.kiszka@siemens.com>

Likely needed since c942cee46bba which split enabling and startup.

This fixes unpopulated vectors in the IOAPIC on x86 at least, possibly
more.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/irq/chip.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 65d345b727be..22386e509f68 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -1087,6 +1087,7 @@ int ipipe_enable_irq(unsigned int irq)
 	struct irq_desc *desc;
 	struct irq_chip *chip;
 	unsigned long flags;
+	int err;
 
 	desc = irq_to_desc(irq);
 	if (desc == NULL)
@@ -1098,6 +1099,10 @@ int ipipe_enable_irq(unsigned int irq)
 
 		ipipe_root_only();
 
+		err = irq_activate(desc);
+		if (err)
+			return err;
+
 		raw_spin_lock_irqsave(&desc->lock, flags);
 		if (desc->istate & IPIPE_IRQS_NEEDS_STARTUP) {
 			desc->istate &= ~IPIPE_IRQS_NEEDS_STARTUP;
-- 
2.16.4


