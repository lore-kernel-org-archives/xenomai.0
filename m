From: Hongzhan Chen <hongzhan.chen@intel.com>
Subject: [PATCH 1/3] drivers/gpio: core: move out of OF config conditional
 compilation
Date: Mon, 30 Aug 2021 02:45:25 -0400
Message-Id: <20210830064527.18206-2-hongzhan.chen@intel.com>
In-Reply-To: <20210830064527.18206-1-hongzhan.chen@intel.com>
References: <20210830064527.18206-1-hongzhan.chen@intel.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

The api would be called by both non-OF and OF platform to remove rtdm
gpiochip device.

Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
---
 include/cobalt/kernel/rtdm/gpio.h | 3 +--
 kernel/drivers/gpio/gpio-core.c   | 4 ++--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/cobalt/kernel/rtdm/gpio.h b/include/cobalt/kernel/rtdm/gpio.h
index 72cc3a035..c307b1572 100644
--- a/include/cobalt/kernel/rtdm/gpio.h
+++ b/include/cobalt/kernel/rtdm/gpio.h
@@ -70,9 +70,8 @@ int rtdm_gpiochip_scan_of(struct device_node *from,
 int rtdm_gpiochip_scan_array_of(struct device_node *from,
 				const char *compat[],
 				int nentries, int type);
+#endif
 
 void rtdm_gpiochip_remove_of(int type);
 
-#endif
-
 #endif /* !_COBALT_RTDM_GPIO_H */
diff --git a/kernel/drivers/gpio/gpio-core.c b/kernel/drivers/gpio/gpio-core.c
index 06a19b33a..ddda62b24 100644
--- a/kernel/drivers/gpio/gpio-core.c
+++ b/kernel/drivers/gpio/gpio-core.c
@@ -626,6 +626,8 @@ int rtdm_gpiochip_scan_array_of(struct device_node *from,
 }
 EXPORT_SYMBOL_GPL(rtdm_gpiochip_scan_array_of);
 
+#endif /* CONFIG_OF */
+
 void rtdm_gpiochip_remove_of(int type)
 {
 	struct rtdm_gpio_chip *rgc, *n;
@@ -644,5 +646,3 @@ void rtdm_gpiochip_remove_of(int type)
 	mutex_unlock(&chip_lock);
 }
 EXPORT_SYMBOL_GPL(rtdm_gpiochip_remove_of);
-
-#endif /* CONFIG_OF */
-- 
2.17.1


