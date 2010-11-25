Message-ID: <4CEE9115.6000404@domain.hid>
Date: Thu, 25 Nov 2010 17:38:45 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4CEE8FF0.6000704@domain.hid>
In-Reply-To: <4CEE8FF0.6000704@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] [PATCH 2/3] ipipe: Drop spurious irq_enter/exit from
	__ipipe_sync_stage
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

Invoking irq_enter/exit for root vIRQs is arch business (at least x86
needs to interleave it with exit code).

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 kernel/ipipe/core.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/ipipe/core.c b/kernel/ipipe/core.c
index 756ad02..129113b 100644
--- a/kernel/ipipe/core.c
+++ b/kernel/ipipe/core.c
@@ -1240,11 +1240,9 @@ void __ipipe_sync_stage(void)
 		if (likely(ipd != ipipe_root_domain)) {
 			ipd->irqs[irq].handler(irq, ipd->irqs[irq].cookie);
 			__ipipe_run_irqtail(irq);
-		} else if (ipipe_virtual_irq_p(irq)) {
-			irq_enter();
+		} else if (ipipe_virtual_irq_p(irq))
 			__ipipe_do_root_virq(ipd, irq);
-			irq_exit();
-		} else
+		else
 			__ipipe_do_root_xirq(ipd, irq);
 
 		local_irq_disable_hw();
-- 
1.7.1

