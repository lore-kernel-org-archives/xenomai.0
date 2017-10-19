From: Christoph Muellner <christoph.muellner@theobroma-systems.com>
Date: Thu, 19 Oct 2017 12:27:55 +0200
Message-Id: <20171019102755.50905-1-christoph.muellner@theobroma-systems.com>
Subject: [Xenomai] [PATCH] [PATCH] drivers/gpio: Fix of-by-one error in
	create_pin_devices().
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, christoph.muellner@theobroma-systems.com

create_pin_devices() consists of a loop, which creates a device file
for each GPIO of a GPIO chip. The loop's run condition is too strong,
which results in the last GPIO file not being created (e.g. gpio31 is
missing in case gc->ngpio is 32 and gc->base is 0).

This patch addresses this issue in branch 'next'.

Tested on a RK3399 (arm64).

Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
---
 kernel/drivers/gpio/gpio-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/drivers/gpio/gpio-core.c b/kernel/drivers/gpio/gpio-core.c
index 5ffe41ff3..55594f6ae 100644
--- a/kernel/drivers/gpio/gpio-core.c
+++ b/kernel/drivers/gpio/gpio-core.c
@@ -285,7 +285,7 @@ static int create_pin_devices(struct rtdm_gpio_chip *rgc)
 	rtdm_lockctx_t s;
 	int n, ret;
 
-	for (n = gc->base; n < gc->base + gc->ngpio - 1; n++) {
+	for (n = gc->base; n < gc->base + gc->ngpio; n++) {
 		ret = -ENOMEM;
 		pin = kzalloc(sizeof(*pin), GFP_KERNEL);
 		if (pin == NULL)
-- 
2.11.0


