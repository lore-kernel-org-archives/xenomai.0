From: Philippe Gerum <rpm@xenomai.org>
Date: Sun, 9 Sep 2018 17:50:54 +0200
Message-Id: <E1fz3yD-00049W-JA@xenomai.org>
Subject: [Xenomai] [PATCH 1/4] x86/irq: ipipe: map the cleanup vector to a
 legit IRQ number
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

The cleanup vector is not part of the system vector range but rather
belongs to the external IRQ range, however we still need to map it
early to a legit interrupt number for pipelining.
---
 arch/x86/kernel/idt.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index c6d6ccafb287..ec06e62e44ee 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -316,11 +316,21 @@ void __init idt_setup_apic_and_irq_gates(void)
 {
 	int i = FIRST_EXTERNAL_VECTOR;
 	void *entry;
-	unsigned int __maybe_unused cpu;
+	unsigned int __maybe_unused cpu, ret;
 
 	idt_setup_from_table(idt_table, apic_idts, ARRAY_SIZE(apic_idts), true);
 
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) && defined(CONFIG_IPIPE)
+	/*
+	 * The cleanup vector is not part of the system vector range
+	 * but rather belongs to the external IRQ range, however we
+	 * still need to map it early to a legit interrupt number for
+	 * pipelining. Allocate a specific descriptor manually for it,
+	 * using IRQ_MOVE_CLEANUP_VECTOR as both the vector number and
+	 * interrupt number, so that we know the latter at build time.
+	 */
+	ret = irq_alloc_descs(IRQ_MOVE_CLEANUP_VECTOR, 0, 1, 0);
+	BUG_ON(IRQ_MOVE_CLEANUP_VECTOR != ret);
 	for_each_possible_cpu(cpu)
 		per_cpu(vector_irq, cpu)[IRQ_MOVE_CLEANUP_VECTOR] =
 			irq_to_desc(IRQ_MOVE_CLEANUP_VECTOR);
-- 
2.14.4


