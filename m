From: Henning Schild <henning.schild@siemens.com>
Date: Thu, 27 Aug 2015 11:39:35 +0200
Message-Id: <1440668375-9773-1-git-send-email-henning.schild@siemens.com>
In-Reply-To: <20150827091217.GB20679@hermes.click-hack.org>
References: <20150827091217.GB20679@hermes.click-hack.org>
Subject: [Xenomai] [PATCHv2] x86/ipipe: reserve irq num we use for
	IRQ_MOVE_CLEANUP_VECTOR
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>

vector_irq must not contain the same irq number for two different
vectors because ipipe dispatches based on irq numbers.
For the special case of IRQ_MOVE_CLEANUP_VECTOR, the ipipe patch
inserts a new entry in vector_irq. To ensure the required uniqueness
we have to make sure Linux will never make a vector point to irq number
IRQ_MOVE_CLEANUP_VECTOR.

Before that patch ipipe did dispatch device interrupts that happened to
receive number 32 (IRQ_MOVE_CLEANUP_VECTOR) to the cleanup function, the
device effectively lost its interrupts. Up to 3.18 that was no problem
since the allocator did not hand out the number ipipe failed to reserve.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 arch/x86/kernel/irqinit.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kernel/irqinit.c b/arch/x86/kernel/irqinit.c
index e850981..5ca517f 100644
--- a/arch/x86/kernel/irqinit.c
+++ b/arch/x86/kernel/irqinit.c
@@ -126,6 +126,7 @@ static void __init smp_intr_init(void)
 #ifdef CONFIG_SMP
 #if defined(CONFIG_X86_64) || defined(CONFIG_X86_LOCAL_APIC)
 	unsigned cpu;
+	int ret;
 
 	/*
 	 * The reschedule interrupt is a CPU-to-CPU reschedule-helper
@@ -143,9 +144,13 @@ static void __init smp_intr_init(void)
 	/* Low priority IPI to cleanup after moving an irq */
 	set_intr_gate(IRQ_MOVE_CLEANUP_VECTOR, irq_move_cleanup_interrupt);
 	set_bit(IRQ_MOVE_CLEANUP_VECTOR, used_vectors);
+#ifdef CONFIG_IPIPE
+	ret = irq_alloc_descs(IRQ_MOVE_CLEANUP_VECTOR, 0, 1, 0);
+	BUG_ON(IRQ_MOVE_CLEANUP_VECTOR != ret);
 	for_each_possible_cpu(cpu)
 		per_cpu(vector_irq, cpu)[IRQ_MOVE_CLEANUP_VECTOR] =
 			IRQ_MOVE_CLEANUP_VECTOR;
+#endif
 
 	/* IPI used for rebooting/stopping */
 	alloc_intr_gate(REBOOT_VECTOR, reboot_interrupt);
-- 
2.4.6


