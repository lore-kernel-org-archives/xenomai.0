From: Dario Binacchi <dariobin@libero.it>
Subject: [RESEND PATCH] arm: ipipe: omap-gpio: Fix interrupts delivering
Date: Sun, 26 Sep 2021 12:07:16 +0200
Message-Id: <20210926100716.32080-1-dariobin@libero.it>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: greg@embeddedgreg.com, jan.kiszka@siemens.com, Dario Binacchi <dariobin@libero.it>

If you set the irq trigger as edge rising or falling the interrupts are
no longer delivered to the upper layers. The gpiokeys driver, for
example, no longer detects the change in the state of the pins mapped
to the buttons.

Fixes: c041e938312b ("arm: ipipe: Fix up the omap-gpio driver to deliver interrupts properly to the pipeline")
Signed-off-by: Dario Binacchi <dariobin@libero.it>
---
 drivers/gpio/gpio-omap.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index c8192c82d2b1..ae527d65bfc2 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -577,9 +577,6 @@ static int omap_gpio_irq_type(struct irq_data *d, unsigned type)
 	}
 	raw_spin_unlock_irqrestore(&bank->lock, flags);
 
-#ifdef CONFIG_IPIPE
-	irq_set_handler_locked(d, handle_level_irq);
-#else
 	if (type & (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_LEVEL_HIGH))
 		irq_set_handler_locked(d, handle_level_irq);
 	else if (type & (IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_EDGE_RISING))
@@ -590,7 +587,7 @@ static int omap_gpio_irq_type(struct irq_data *d, unsigned type)
 		 * So just use handle_simple_irq.
 		 */
 		irq_set_handler_locked(d, handle_simple_irq);
-#endif
+
 	return 0;
 
 error:
-- 
2.17.1


