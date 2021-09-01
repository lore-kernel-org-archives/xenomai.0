From: Hongzhan Chen <hongzhan.chen@intel.com>
Subject: [PATCH] driver/gpio: gpio-cherryview: call correct api to remove gpio
 device
Date: Wed,  1 Sep 2021 01:21:21 -0400
Message-Id: <20210901052121.15500-1-hongzhan.chen@intel.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

call correct api to remove gpio device.

Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>

diff --git a/kernel/drivers/gpio/gpio-cherryview.c b/kernel/drivers/gpio/gpio-cherryview.c
index 826faff3a..1234a3e12 100644
--- a/kernel/drivers/gpio/gpio-cherryview.c
+++ b/kernel/drivers/gpio/gpio-cherryview.c
@@ -35,7 +35,7 @@ module_init(cherryview_gpio_init);
 
 static void __exit cherryview_gpio_exit(void)
 {
-	rtdm_gpiochip_remove(RTDM_SUBCLASS_CHERRYVIEW);
+	rtdm_gpiochip_remove_by_type(RTDM_SUBCLASS_CHERRYVIEW);
 }
 module_exit(cherryview_gpio_exit);
 
-- 
2.17.1


