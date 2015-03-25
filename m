From: Stefan Roese <sr@denx.de>
Date: Wed, 25 Mar 2015 05:15:43 +0100
Message-Id: <1427256943-8654-1-git-send-email-sr@denx.de>
Subject: [Xenomai] [PATCH] ipipe: drivers/irqchip/irq-vic.c: Fix problems
	with ipipe in VIC
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

These changes are needed to enable the VIC interrupt handler for I-pipe usage.
This patch version is for the "ipipe-3.18" branch in Philippes "ipipe" git
respository. But a quick search reveals that such a fix very likely is needed
for kernel version from v3.10 onward.

Tested on SPEAr600 based board with v3.18.

Signed-off-by: Stefan Roese <sr@denx.de>
---
 drivers/irqchip/irq-vic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-vic.c b/drivers/irqchip/irq-vic.c
index 46da75e..9302875 100644
--- a/drivers/irqchip/irq-vic.c
+++ b/drivers/irqchip/irq-vic.c
@@ -220,7 +220,7 @@ static int handle_one_vic(struct vic_device *vic, struct pt_regs *regs)
 
 	while ((stat = readl_relaxed(vic->base + VIC_IRQ_STATUS))) {
 		irq = ffs(stat) - 1;
-		handle_domain_irq(vic->domain, irq, regs);
+		ipipe_handle_multi_irq(irq_find_mapping(vic->domain, irq), regs);
 		handled = 1;
 	}
 
@@ -237,7 +237,7 @@ static void vic_handle_irq_cascaded(unsigned int irq, struct irq_desc *desc)
 
 	while ((stat = readl_relaxed(vic->base + VIC_IRQ_STATUS))) {
 		hwirq = ffs(stat) - 1;
-		generic_handle_irq(irq_find_mapping(vic->domain, hwirq));
+		ipipe_handle_demuxed_irq(irq_find_mapping(vic->domain, hwirq));
 	}
 
 	chained_irq_exit(host_chip, desc);
-- 
2.3.4


