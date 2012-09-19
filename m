Message-ID: <5059D412.7020202@siemens.com>
Date: Wed, 19 Sep 2012 16:17:54 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <504F5F1B.4020806@siemens.com> <50550091.50002@xenomai.org>
	<505592B8.9000109@xenomai.org> <5056DBAD.1000903@xenomai.org>
	<5058AE95.2020103@siemens.com> <5058AF21.5000600@xenomai.org>
	<5058BC96.8090601@siemens.com> <5058BE17.5070304@xenomai.org>
	<5058C39C.8000407@siemens.com> <5058C5F6.3040406@xenomai.org>
	<5058C73B.8040006@siemens.com> <5058C79A.5020400@xenomai.org>
	<5058C8EE.1050803@siemens.com> <5058C9FE.5030505@xenomai.org>
In-Reply-To: <5058C9FE.5030505@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [PATCH] ipipe: x86: Populate vector_irq for all
	dispatched vectors
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 2012-09-18 21:22, Gilles Chanteperdrix wrote:
> On 09/18/2012 09:18 PM, Jan Kiszka wrote:
> 
>> On 2012-09-18 21:12, Gilles Chanteperdrix wrote:
>>> On 09/18/2012 09:10 PM, Jan Kiszka wrote:
>>>
>>>> On 2012-09-18 21:05, Gilles Chanteperdrix wrote:
>>>>> rah, vectors_limit is not needed at all. I do not see which look you are
>>>>> talking about.
>>>>
>>>> 		cfg = irq_cfg(irq);
>>>> 		if (!cpumask_test_cpu(cpu, cfg->domain))
>>>> 			per_cpu(vector_irq, cpu)[vector] = -1;
>>>
>>>
>>> Yes, but :
>>>
>>>>>>> -	for (vector = 0; vector < NR_VECTORS; ++vector) {
>>>>>>> +	for (vector = 0; vector < first_system_vector; ++vector) {
>>>
>>
>> And you know all side effects of that change?
>>
>> My point is: We have a working version, released and tested on machines
>> that make use of the affected code paths.
> 
> 
> Come on, look at the code:
> 
> 	for (vector = 0; vector < first_system_vector; ++vector) {
> 		if (vector == IRQ_MOVE_CLEANUP_VECTOR)
> 			continue;
> 
> 		irq = per_cpu(vector_irq, cpu)[vector];
> 		if (irq < 0)
> 			continue;
> 
> 		cfg = irq_cfg(irq);
> 		if (!cpumask_test_cpu(cpu, cfg->domain))
> 			per_cpu(vector_irq, cpu)[vector] = -1;
> 	}
> 
> It simply skips an initialization to -1 because we know that we already
> initialized this part of the array elsewhere.

Yes, it's simple and obvious - and therefore it was wrong. To be fair:
also in 2.6.38.

Below a patch - using your scheme - that survived both another review
and testing round. And it builds for APIC-less x86-32.

Jan

---8<---

Based on patch by Gilles: This fixes the dispatching of
IRQ_MOVE_CLEANUP_VECTOR in __ipipe_handle_irq and simplifies those
lines by always using vector_irq to translate a vector to a Linux IRQ
number. In contrast to the version in 2.6.38 and before, this one also
properly marks unused vectors above first_system_vector as free.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/x86/include/asm/desc.h    |    8 ++++++++
 arch/x86/kernel/apic/io_apic.c |    3 +++
 arch/x86/kernel/ipipe.c        |   12 ++----------
 arch/x86/kernel/irqinit.c      |    5 +++++
 4 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/desc.h b/arch/x86/include/asm/desc.h
index e95822d..5a5b415 100644
--- a/arch/x86/include/asm/desc.h
+++ b/arch/x86/include/asm/desc.h
@@ -4,6 +4,7 @@
 #include <asm/desc_defs.h>
 #include <asm/ldt.h>
 #include <asm/mmu.h>
+#include <asm/hw_irq.h>
 
 #include <linux/smp.h>
 
@@ -351,6 +352,13 @@ extern unsigned long used_vectors[];
 static inline void alloc_system_vector(int vector)
 {
 	if (!test_bit(vector, used_vectors)) {
+#ifdef CONFIG_X86_LOCAL_APIC
+		unsigned cpu;
+
+		for_each_possible_cpu(cpu)
+			per_cpu(vector_irq, cpu)[vector] =
+				ipipe_apic_vector_irq(vector);
+#endif
 		set_bit(vector, used_vectors);
 		if (first_system_vector > vector)
 			first_system_vector = vector;
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 93f84c9..0dd658d 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -1318,6 +1318,9 @@ void __setup_vector_irq(int cpu)
 	}
 	/* Mark the free vectors */
 	for (vector = 0; vector < NR_VECTORS; ++vector) {
+		/* I-pipe requires initialized vector_irq for system vectors */
+		if (test_bit(vector, used_vectors))
+			continue;
 		irq = per_cpu(vector_irq, cpu)[vector];
 		if (irq < 0)
 			continue;
diff --git a/arch/x86/kernel/ipipe.c b/arch/x86/kernel/ipipe.c
index 1a56b5f..fcf8113 100644
--- a/arch/x86/kernel/ipipe.c
+++ b/arch/x86/kernel/ipipe.c
@@ -581,16 +581,8 @@ int __ipipe_handle_irq(struct pt_regs *regs)
 	int irq, vector = regs->orig_ax, flags = 0;
 
 	if (likely(vector < 0)) {
-		vector = ~vector;
-#ifdef CONFIG_X86_LOCAL_APIC
-		if (vector >= FIRST_SYSTEM_VECTOR)
-			irq = ipipe_apic_vector_irq(vector);
-		else
-#endif	/* CONFIG_X86_LOCAL_APIC */
-		{
-			irq = __this_cpu_read(vector_irq[vector]);
-			BUG_ON(irq < 0);
-		}
+		irq = __this_cpu_read(vector_irq[~vector]);
+		BUG_ON(irq < 0);
 	} else { /* Software-generated. */
 		irq = vector;
 		flags = IPIPE_IRQF_NOACK;
diff --git a/arch/x86/kernel/irqinit.c b/arch/x86/kernel/irqinit.c
index 6fa97b2..dd348e1 100644
--- a/arch/x86/kernel/irqinit.c
+++ b/arch/x86/kernel/irqinit.c
@@ -165,6 +165,8 @@ static void __init smp_intr_init(void)
 {
 #ifdef CONFIG_SMP
 #if defined(CONFIG_X86_64) || defined(CONFIG_X86_LOCAL_APIC)
+	unsigned cpu;
+
 	/*
 	 * The reschedule interrupt is a CPU-to-CPU reschedule-helper
 	 * IPI, driven by wakeup.
@@ -254,6 +256,9 @@ static void __init smp_intr_init(void)
 	/* Low priority IPI to cleanup after moving an irq */
 	set_intr_gate(IRQ_MOVE_CLEANUP_VECTOR, irq_move_cleanup_interrupt);
 	set_bit(IRQ_MOVE_CLEANUP_VECTOR, used_vectors);
+	for_each_possible_cpu(cpu)
+		per_cpu(vector_irq, cpu)[IRQ_MOVE_CLEANUP_VECTOR] =
+			IRQ_MOVE_CLEANUP_VECTOR;
 
 	/* IPI used for rebooting/stopping */
 	alloc_intr_gate(REBOOT_VECTOR, reboot_interrupt);
-- 
1.7.3.4


