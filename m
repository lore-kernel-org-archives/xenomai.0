Message-ID: <46F0E315.10306@domain.hid>
Date: Wed, 19 Sep 2007 10:51:33 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030109050100060009080400"
Subject: [Adeos-main] [PATCH] fix irq statistics
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org
Cc: rpm@xenomai.org

This is a multi-part message in MIME format.
--------------030109050100060009080400
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

IRQ hit counters are broken in latest I-pipe 1.10-x for the wired path. 
This patch moves the counter maintenance out of __ipipe_set_irq_pending 
and instead makes it explicit at the required spots.

Note that this patch also unexports __ipipe_set_irq_pending because I 
found no reason why it should be used outside the i-pipe core. Please 
correct me if I'm wrong on this.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

--------------030109050100060009080400
Content-Type: text/x-patch;
 name="fix-and-refactor-irqstats.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-and-refactor-irqstats.patch"

---
 arch/i386/kernel/ipipe.c |    1 +
 kernel/ipipe/core.c      |    7 +++----
 2 files changed, 4 insertions(+), 4 deletions(-)

Index: linux-2.6.22-ipipe/arch/i386/kernel/ipipe.c
===================================================================
--- linux-2.6.22-ipipe.orig/arch/i386/kernel/ipipe.c
+++ linux-2.6.22-ipipe/arch/i386/kernel/ipipe.c
@@ -727,6 +727,7 @@ int __ipipe_handle_irq(struct pt_regs re
 			 * _first_ in the domain's status flags before
 			 * the PIC is unlocked.
 			 */
+			ipipe_cpudom_var(next_domain, irqall)[irq]++;
 			__ipipe_set_irq_pending(next_domain, irq);
 
 			if (!m_ack && next_domain->irqs[irq].acknowledge != NULL)
Index: linux-2.6.22-ipipe/kernel/ipipe/core.c
===================================================================
--- linux-2.6.22-ipipe.orig/kernel/ipipe/core.c
+++ linux-2.6.22-ipipe/kernel/ipipe/core.c
@@ -493,8 +493,6 @@ void fastcall __ipipe_set_irq_pending(st
 		__set_bit(level,&ipipe_cpudom_var(ipd, irqpend_himask));
 	} else
 		__set_bit(rank, &ipipe_cpudom_var(ipd, irqheld_mask)[level]);
-
-	ipipe_cpudom_var(ipd, irqall)[irq]++;
 }
 
 /* Must be called hw IRQs off. */
@@ -873,12 +871,13 @@ int fastcall __ipipe_dispatch_wired(stru
 {
 	struct ipipe_domain *old;
 
+	ipipe_cpudom_var(head_domain, irqall)[irq]++;
+
 	if (test_bit(IPIPE_LOCK_FLAG, &head_domain->irqs[irq].control)) {
 		/* If we can't process this IRQ right now, we must
 		 * mark it as held, so that it will get played during
 		 * normal log sync when the corresponding interrupt
 		 * source is eventually unlocked. */
-		ipipe_cpudom_var(head_domain, irqall)[irq]++;
 		__set_bit(irq & IPIPE_IRQ_IMASK, &ipipe_cpudom_var(head_domain, irqheld_mask)[irq >> IPIPE_IRQ_ISHIFT]);
 		return 0;
 	}
@@ -1199,6 +1198,7 @@ int fastcall __ipipe_schedule_irq(unsign
 		ipd = list_entry(ln, struct ipipe_domain, p_link);
 
 		if (test_bit(IPIPE_HANDLE_FLAG, &ipd->irqs[irq].control)) {
+			ipipe_cpudom_var(ipd, irqall)[irq]++;
 			__ipipe_set_irq_pending(ipd, irq);
 			local_irq_restore_hw(flags);
 			return 1;
@@ -1597,7 +1597,6 @@ EXPORT_SYMBOL(__ipipe_spin_unlock_irq);
 EXPORT_SYMBOL(__ipipe_spin_lock_irqsave);
 EXPORT_SYMBOL(__ipipe_spin_unlock_irqrestore);
 EXPORT_SYMBOL(__ipipe_pipeline);
-EXPORT_SYMBOL(__ipipe_set_irq_pending);
 EXPORT_SYMBOL(__ipipe_lock_irq);
 EXPORT_SYMBOL(__ipipe_unlock_irq);
 EXPORT_SYMBOL(ipipe_register_domain);


--------------030109050100060009080400--

