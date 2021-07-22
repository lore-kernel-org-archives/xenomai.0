From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 2/6] gpio: omap: irq_pipeline: enable out-of-band interrupt
 handling
Date: Thu, 22 Jul 2021 11:48:55 +0200
Message-Id: <20210722094859.3580166-3-rpm@xenomai.org>
In-Reply-To: <20210722094859.3580166-1-rpm@xenomai.org>
References: <20210722094859.3580166-1-rpm@xenomai.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Philippe Gerum <rpm@xenomai.org>

We must decode the chained interrupts on the out-of-band stage to
enable end-to-end out-of-band delivery. Set IRQF_OOB for the parent
handler.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 drivers/gpio/gpio-omap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 8c02307ab2d0aa7..9e0eb9a7bfa671b 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1055,7 +1055,7 @@ static int omap_gpio_chip_init(struct gpio_bank *bank, struct irq_chip *irqc)
 
 	ret = devm_request_irq(bank->chip.parent, bank->irq,
 			       omap_gpio_irq_handler,
-			       0, dev_name(bank->chip.parent), bank);
+			       IRQF_OOB, dev_name(bank->chip.parent), bank);
 	if (ret)
 		gpiochip_remove(&bank->chip);
 
-- 
2.31.1


