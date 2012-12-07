From: Jan Kiszka <jan.kiszka@siemens.com>
Date: Fri,  7 Dec 2012 18:09:46 +0100
Message-Id: <7d16b3d2e8f37f164eecf46ba2a8fad4e753facf.1354900184.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1354900184.git.jan.kiszka@siemens.com>
References: <cover.1354900184.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1354900184.git.jan.kiszka@siemens.com>
References: <cover.1354900184.git.jan.kiszka@siemens.com>
Subject: [Xenomai] [PATCH 3/3] ipipe: Clear IRQ_MASKED from irq descriptor
	on setup
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

This bit is set my the kernel on __free_irq. That's unproblematic in the
absence of ipipe, but when it is enabled, handle_fasteoi_irq will fail
to reenable the line on exit due to this spurious state. Only required
on 2.6 kernels, later versions properly clear the MASKED state
themselves.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/irq/chip.c   |    2 +-
 kernel/irq/manage.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index b79ec1d..aeb8cc1 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -878,7 +878,7 @@ __set_irq_handler(unsigned int irq, irq_flow_handler_t handle, int is_chained,
 	desc->name = name;
 
 	if (handle != handle_bad_irq && is_chained) {
-		desc->status &= ~IRQ_DISABLED;
+		desc->status &= ~(IRQ_DISABLED | IRQ_MASKED);
 		desc->status |= IRQ_NOREQUEST | IRQ_NOPROBE;
 		desc->depth = 0;
 		desc->irq_data.chip->irq_startup(&desc->irq_data);
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 9033c1c..57fdf57 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -785,7 +785,7 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 
 		if (!(desc->status & IRQ_NOAUTOEN)) {
 			desc->depth = 0;
-			desc->status &= ~IRQ_DISABLED;
+			desc->status &= ~(IRQ_DISABLED | IRQ_MASKED);
 			desc->irq_data.chip->irq_startup(&desc->irq_data);
 		} else
 			/* Undo nested disables: */
-- 
1.7.3.4


