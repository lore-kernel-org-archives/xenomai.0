Message-ID: <4DEA1AAB.60403@domain.hid>
Date: Sat, 04 Jun 2011 13:44:43 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] [PATCH] ipipe: Re-read domain data pointer after
 interrupt handler execution
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

This caused subtle system corruptions on SMP: The context which took the
IRQ may migrate to a different CPU during the execution of the IRQ
handler (migration to root domain -> load balancing). So we must refresh
the per-CPU domain data and not use the one obtained on entry.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

Just for early review. I'll send 2.6.38 pull requests for these
patches, some more fixes, and access optimizations for
ipipe_percpu_domain_data::status next week after running more serious
SMP load against them.

Note that this bug affects any ipipe version I've found in git. So the
patch should be applied/backported to all versions we still support.

PS: Months of collecting oopses, more than 1 weeks of debugging.
Yeah, there were more bugs, but this was likely the toughest monster.

 kernel/ipipe/core.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/kernel/ipipe/core.c b/kernel/ipipe/core.c
index 9aa4800..0ed7751 100644
--- a/kernel/ipipe/core.c
+++ b/kernel/ipipe/core.c
@@ -1168,6 +1168,7 @@ void __ipipe_dispatch_wired_nocheck(struct ipipe_domain *head, unsigned irq) /*
 	head->irqs[irq].handler(irq, head->irqs[irq].cookie); /* Call the ISR. */
 	__ipipe_run_irqtail(irq);
 	barrier();
+	p = ipipe_cpudom_ptr(head);
 	__clear_bit(IPIPE_STALL_FLAG, &p->status);
 
 	if (__ipipe_current_domain == head) {
-- 
1.7.1

