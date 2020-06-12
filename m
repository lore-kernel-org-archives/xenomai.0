From: Jouko Haapaluoma <jouko.haapaluoma@wapice.com>
Subject: [PATCH 9/9] pinctrl-at91: Add ipipe pipeline support
Date: Fri, 12 Jun 2020 11:55:53 +0000
Message-ID: <HE1PR03MB3115C8AF10E5F49E163223B6E5810@HE1PR03MB3115.eurprd03.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

From: Jouko Haapaluoma <jouko.haapaluoma@wapice.com>

Make AT91 pinctrl driver compatible with ipipe

Signed-off-by: Jouko Haapaluoma <jouko.haapaluoma@wapice.com>
---
 drivers/pinctrl/pinctrl-at91.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.=
c
index 50f0ec4..c4f60c7 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -1582,6 +1582,7 @@ static struct irq_chip gpio_irqchip =3D {
 	.irq_unmask	=3D gpio_irq_unmask,
 	/* .irq_set_type is set dynamically */
 	.irq_set_wake	=3D gpio_irq_set_wake,
+	.flags		=3D IRQCHIP_PIPELINE_SAFE,
 };
=20
 static void gpio_irq_handler(struct irq_desc *desc)
@@ -1610,8 +1611,8 @@ static void gpio_irq_handler(struct irq_desc *desc)
 		}
=20
 		for_each_set_bit(n, &isr, BITS_PER_LONG) {
-			generic_handle_irq(irq_find_mapping(
-					   gpio_chip->irq.domain, n));
+			ipipe_handle_demuxed_irq(irq_find_mapping(
+					gpio_chip->irq.domain, n));
 		}
 	}
 	chained_irq_exit(chip, desc);
--=20
2.2.2


