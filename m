From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [I-pipe 5.4] [PATCH v2 3/4] ipipe: x86: Fix IRQ migrations,
 pending migrations were never handled
Date: Tue,  1 Mar 2022 13:53:01 +0100
Message-Id: <20220301125302.2368068-4-florian.bezdeka@siemens.com>
In-Reply-To: <20220301125302.2368068-1-florian.bezdeka@siemens.com>
References: <20220301125302.2368068-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

IRQ migrations did not work. Writing a new IRQ SMP affinity into
/proc/irq/<irq>/smp_affinity had no effect.

It turned out that the pending migration was never handled. With
commit d4637fc8663b ("x86/ipipe: fix chained irq handling") do_IRQ() is
bypassed because it is not able to deal with chained IRQs and
generic_handle_irq_desc() is directly called instead.

The bypass forgot to take care about pending IRQ migrations. As
do_IRQ() is no longer used when ipipe is enabled, we can restore it to
the Linux version and move the call of __ipipe_move_root_irq() to
__ipipe_do_IRQ(). With that change applied the first part of the IRQ
migration is working again. IRQs arrive at the new target CPU.

The second part of the IRQ migration (cleanup of the old vector at the
previous target CPU) was broken because __ipipe_do_IRQ() injects the
registers from the last timer tick, so apicd->vector is always -1.
Removing the vector == apicd->vector check allows triggering the
cleanup IPI. This part is now synchronized with Linux >= 5.8.

Fixes: d4637fc8663b ("x86/ipipe: fix chained irq handling")

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 arch/x86/kernel/apic/vector.c |  8 +++++++-
 arch/x86/kernel/irq.c         |  3 +--
 arch/x86/kernel/irq_64.c      | 10 +++++-----
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index a744b78eaa94..32889c2ef4a1 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -949,7 +949,13 @@ static void __irq_complete_move(struct irq_cfg *cfg, unsigned vector)
 	if (likely(!apicd->move_in_progress))
 		return;
 
-	if (vector == apicd->vector && apicd->cpu == smp_processor_id())
+	/*
+	 * If the interrupt arrived on the new target CPU, cleanup the
+	 * vector on the old target CPU. A vector check is not required
+	 * because an interrupt can never move from one vector to another
+	 * on the same CPU.
+	 */
+	if (apicd->cpu == smp_processor_id())
 		__send_cleanup_vector(apicd);
 }
 
diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index f946bc4387e4..7077388e4f1c 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -237,13 +237,12 @@ __visible unsigned int __irq_entry do_IRQ(struct pt_regs *regs)
 	/* high bit used in ret_from_ code  */
 	unsigned vector = ~regs->orig_ax;
 
-	desc = __this_cpu_read(vector_irq[vector]);
-	__ipipe_move_root_irq(desc);
 	entering_irq();
 
 	/* entering_irq() tells RCU that we're not quiescent.  Check it. */
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "IRQ failed to wake up RCU");
 
+	desc = __this_cpu_read(vector_irq[vector]);
 	if (likely(!IS_ERR_OR_NULL(desc))) {
 		if (IS_ENABLED(CONFIG_X86_32))
 			handle_irq(desc, regs);
diff --git a/arch/x86/kernel/irq_64.c b/arch/x86/kernel/irq_64.c
index b998d982cb4a..16ea3c5aed6d 100644
--- a/arch/x86/kernel/irq_64.c
+++ b/arch/x86/kernel/irq_64.c
@@ -76,20 +76,20 @@ int irq_init_percpu_irqstack(unsigned int cpu)
 void __ipipe_do_IRQ(unsigned int irq, void *cookie)
 {
 	struct pt_regs *regs = raw_cpu_ptr(&ipipe_percpu.tick_regs);
+	struct irq_desc *desc = irq_to_desc(irq);
 	struct pt_regs *old_regs = set_irq_regs(regs);
 	unsigned int (*handler)(struct pt_regs *regs);
-	struct irq_desc *desc;
 
 	handler = (typeof(handler))cookie;
 
+	__ipipe_move_root_irq(desc);
+
 	entering_irq();
 
-	if (handler == do_IRQ) {
-		desc = irq_to_desc(irq);
+	if (handler == do_IRQ)
 		generic_handle_irq_desc(desc);
-	} else {
+	else
 		handler(regs);
-	}
 
 	exiting_irq();
 
-- 
2.30.2


