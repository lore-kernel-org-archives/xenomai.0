Message-ID: <4DBAFF5A.30108@domain.hid>
Date: Fri, 29 Apr 2011 20:11:38 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] [PATCH] ipipe: Restore root state before disabling hw
	irqs
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

root_stall_after_handler is a fixup for the root state, required when
CONFIG_TRACE_IRQFLAGS is enabled. It then calls local_irq_disable which
reenables hard irqs as a side effect. This causes all types of
corruptions after return from __ipipe_sync_stage which is supposed to
leave hard irqs off.

Fix it by reordering root_stall_after_handler and local_irq_disable_hw.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 kernel/ipipe/core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/ipipe/core.c b/kernel/ipipe/core.c
index 9ad7757..9aa4800 100644
--- a/kernel/ipipe/core.c
+++ b/kernel/ipipe/core.c
@@ -1277,14 +1277,14 @@ void __ipipe_sync_stage(void)
 			irq_enter();
 			ipd->irqs[irq].handler(irq, ipd->irqs[irq].cookie);
 			irq_exit();
-			local_irq_disable_hw();
 			root_stall_after_handler();
+			local_irq_disable_hw();
 			while (__ipipe_check_root_resched())
 				__ipipe_preempt_schedule_irq();
 		} else {
 			__ipipe_do_root_xirq(ipd, irq);
-			local_irq_disable_hw();
 			root_stall_after_handler();
+			local_irq_disable_hw();
 		}
 
 		p = ipipe_cpudom_ptr(__ipipe_current_domain);
-- 
1.7.1

