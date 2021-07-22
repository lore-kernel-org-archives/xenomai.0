From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 4/6] pinctrl: samsung: irq_pipeline: enable out-of-band
 interrupt handling
Date: Thu, 22 Jul 2021 11:48:57 +0200
Message-Id: <20210722094859.3580166-5-rpm@xenomai.org>
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
 drivers/pinctrl/samsung/pinctrl-exynos.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.c b/drivers/pinctrl/samsung/pinctrl-exynos.c
index e1c86adb8f9421e..7da7f80e654380a 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.c
@@ -288,7 +288,7 @@ __init int exynos_eint_gpio_init(struct samsung_pinctrl_drv_data *d)
 	}
 
 	ret = devm_request_irq(dev, d->irq, exynos_eint_gpio_irq,
-					0, dev_name(dev), d);
+					IRQF_OOB, dev_name(dev), d);
 	if (ret) {
 		dev_err(dev, "irq request failed\n");
 		return -ENXIO;
-- 
2.31.1


