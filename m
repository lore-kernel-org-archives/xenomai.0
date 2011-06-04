Message-ID: <4DEA1AC8.9050800@domain.hid>
Date: Sat, 04 Jun 2011 13:45:12 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] [PATCH] ipipe: Fix irqheld/irqpend accesses
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>

From: Jan Kiszka <jan.kiszka@domain.hid>

__ipipe_unlock_irq migrates held back IRQs into the pending bitmap, and
that for all CPUs. Consequently, it uses atomic bit ops. Consequently,
we have to use atomic ops for all related bitmap manipulations, even if
they are per-CPU only, to avoid spurious corruptions.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

Also a bug that affects a longer history of ipipe versions. Fix should
be ported back to the maintained ones.

 kernel/ipipe/core.c |   44 +++++++++++++++++++++-----------------------
 1 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/kernel/ipipe/core.c b/kernel/ipipe/core.c
index 0ed7751..f3603df 100644
--- a/kernel/ipipe/core.c
+++ b/kernel/ipipe/core.c
@@ -555,7 +555,7 @@ void __ipipe_spin_unlock_irqcomplete(unsigned long x)
 static inline void __ipipe_set_irq_held(struct ipipe_percpu_domain_data *p,
 					unsigned int irq)
 {
-	__set_bit(irq, p->irqheld_map);
+	set_bit(irq, p->irqheld_map);
 	p->irqall[irq]++;
 }
 
@@ -571,11 +571,11 @@ void __ipipe_set_irq_pending(struct ipipe_domain *ipd, unsigned int irq)
 	l1b = irq / BITS_PER_LONG;
 
 	if (likely(!test_bit(IPIPE_LOCK_FLAG, &ipd->irqs[irq].control))) {
-		__set_bit(irq, p->irqpend_lomap);
-		__set_bit(l1b, p->irqpend_mdmap);
-		__set_bit(l0b, &p->irqpend_himap);
+		set_bit(irq, p->irqpend_lomap);
+		set_bit(l1b, p->irqpend_mdmap);
+		set_bit(l0b, &p->irqpend_himap);
 	} else
-		__set_bit(irq, p->irqheld_map);
+		set_bit(irq, p->irqheld_map);
 
 	p->irqall[irq]++;
 }
@@ -597,12 +597,12 @@ void __ipipe_lock_irq(struct ipipe_domain *ipd, int cpu, unsigned int irq)
 	l1b = irq / BITS_PER_LONG;
 
 	p = ipipe_percpudom_ptr(ipd, cpu);
-	if (__test_and_clear_bit(irq, p->irqpend_lomap)) {
-		__set_bit(irq, p->irqheld_map);
+	if (test_and_clear_bit(irq, p->irqpend_lomap)) {
+		set_bit(irq, p->irqheld_map);
 		if (p->irqpend_lomap[l1b] == 0) {
-			__clear_bit(l1b, p->irqpend_mdmap);
+			clear_bit(l1b, p->irqpend_mdmap);
 			if (p->irqpend_mdmap[l0b] == 0)
-				__clear_bit(l0b, &p->irqpend_himap);
+				clear_bit(l0b, &p->irqpend_himap);
 		}
 	}
 }
@@ -625,7 +625,6 @@ void __ipipe_unlock_irq(struct ipipe_domain *ipd, unsigned int irq)
 	for_each_online_cpu(cpu) {
 		p = ipipe_percpudom_ptr(ipd, cpu);
 		if (test_and_clear_bit(irq, p->irqheld_map)) {
-			/* We need atomic ops here: */
 			set_bit(irq, p->irqpend_lomap);
 			set_bit(l1b, p->irqpend_mdmap);
 			set_bit(l0b, &p->irqpend_himap);
@@ -656,11 +655,11 @@ static inline int __ipipe_next_irq(struct ipipe_percpu_domain_data *p)
 	l2b = __ipipe_ffnz(l2m);
 	irq = l1b * BITS_PER_LONG + l2b;
 
-	__clear_bit(irq, p->irqpend_lomap);
+	clear_bit(irq, p->irqpend_lomap);
 	if (p->irqpend_lomap[l1b] == 0) {
-		__clear_bit(l1b, p->irqpend_mdmap);
+		clear_bit(l1b, p->irqpend_mdmap);
 		if (p->irqpend_mdmap[l0b] == 0)
-			__clear_bit(l0b, &p->irqpend_himap);
+			clear_bit(l0b, &p->irqpend_himap);
 	}
 
 	return irq;
@@ -672,7 +671,7 @@ static inline int __ipipe_next_irq(struct ipipe_percpu_domain_data *p)
 static inline void __ipipe_set_irq_held(struct ipipe_percpu_domain_data *p,
 					unsigned int irq)
 {
-	__set_bit(irq, p->irqheld_map);
+	set_bit(irq, p->irqheld_map);
 	p->irqall[irq]++;
 }
 
@@ -685,10 +684,10 @@ void __ipipe_set_irq_pending(struct ipipe_domain *ipd, unsigned irq)
 	IPIPE_WARN_ONCE(!irqs_disabled_hw());
 	
 	if (likely(!test_bit(IPIPE_LOCK_FLAG, &ipd->irqs[irq].control))) {
-		__set_bit(irq, p->irqpend_lomap);
-		__set_bit(l0b, &p->irqpend_himap);
+		set_bit(irq, p->irqpend_lomap);
+		set_bit(l0b, &p->irqpend_himap);
 	} else
-		__set_bit(irq, p->irqheld_map);
+		set_bit(irq, p->irqheld_map);
 
 	p->irqall[irq]++;
 }
@@ -707,10 +706,10 @@ void __ipipe_lock_irq(struct ipipe_domain *ipd, int cpu, unsigned irq)
 		return;
 
 	p = ipipe_percpudom_ptr(ipd, cpu);
-	if (__test_and_clear_bit(irq, p->irqpend_lomap)) {
-		__set_bit(irq, p->irqheld_map);
+	if (test_and_clear_bit(irq, p->irqpend_lomap)) {
+		set_bit(irq, p->irqheld_map);
 		if (p->irqpend_lomap[l0b] == 0)
-			__clear_bit(l0b, &p->irqpend_himap);
+			clear_bit(l0b, &p->irqpend_himap);
 	}
 }
 
@@ -729,7 +728,6 @@ void __ipipe_unlock_irq(struct ipipe_domain *ipd, unsigned irq)
 	for_each_online_cpu(cpu) {
 		p = ipipe_percpudom_ptr(ipd, cpu);
 		if (test_and_clear_bit(irq, p->irqheld_map)) {
-			/* We need atomic ops here: */
 			set_bit(irq, p->irqpend_lomap);
 			set_bit(l0b, &p->irqpend_himap);
 		}
@@ -751,9 +749,9 @@ static inline int __ipipe_next_irq(struct ipipe_percpu_domain_data *p)
 		return -1;
 
 	l1b = __ipipe_ffnz(l1m);
-	__clear_bit(l1b, &p->irqpend_lomap[l0b]);
+	clear_bit(l1b, &p->irqpend_lomap[l0b]);
 	if (p->irqpend_lomap[l0b] == 0)
-		__clear_bit(l0b, &p->irqpend_himap);
+		clear_bit(l0b, &p->irqpend_himap);
 
 	return l0b * BITS_PER_LONG + l1b;
 }

