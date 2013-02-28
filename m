From: Stefan Roese <sr@denx.de>
Date: Thu, 28 Feb 2013 17:25:15 +0100
Message-Id: <1362068715-3458-1-git-send-email-sr@denx.de>
Subject: [Xenomai] [PATCH] ipipe: MPC5200: Fix problem with external
	interrupts
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

The MPC5200 external interrupt are not working at all in the Linux
context with the current I-pipe support enabled. For example a
PCI firewire chip connected to an external interrupt doesn't generate
interrupts any more using the Linux FW drivers. With I-pipe
disabled or without the current I-pipe patch for the mpc52xx_pic.c
file, the external interrupts work just fine.

This patch now introduces the xxx_mask_ack() function for these
external interrupts as already done for the other interrupts handled
in this driver. With this change, the interrupts work regardless
if I-pipe support is enabled or not.

Additionally a small coding style issue has been included (spaces
around "-").

Signed-off-by: Stefan Roese <sr@denx.de>
Cc: Philippe Gerum <rpm@xenomai.org>
---
 arch/powerpc/platforms/52xx/mpc52xx_pic.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pic.c b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
index 7ed93f8..2c25c4b 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_pic.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
@@ -195,10 +195,19 @@ static void mpc52xx_extirq_unmask(struct irq_data *d)
 	hard_local_irq_restore(flags);
 }
 
+static void mpc52xx_extirq_mask_ack(struct irq_data *d)
+{
+	int l2irq = irqd_to_hwirq(d) & MPC52xx_IRQ_L2_MASK;
+
+	__io_be_clrbit(&intr->ctrl, 11 - l2irq);
+	__io_be_setbit(&intr->ctrl, 27 - l2irq);
+}
+
 static void mpc52xx_extirq_ack(struct irq_data *d)
 {
 	int l2irq = irqd_to_hwirq(d) & MPC52xx_IRQ_L2_MASK;
-	__io_be_setbit(&intr->ctrl, 27-l2irq);
+
+	__io_be_setbit(&intr->ctrl, 27 - l2irq);
 }
 
 static int mpc52xx_extirq_set_type(struct irq_data *d, unsigned int flow_type)
@@ -233,6 +242,7 @@ static struct irq_chip mpc52xx_extirq_irqchip = {
 	.name = "MPC52xx External",
 	.irq_mask = mpc52xx_extirq_mask,
 	.irq_unmask = mpc52xx_extirq_unmask,
+	.irq_mask_ack = mpc52xx_extirq_mask_ack,
 	.irq_ack = mpc52xx_extirq_ack,
 	.irq_set_type = mpc52xx_extirq_set_type,
 };
-- 
1.8.1.4


