From: hongzha1 <hongzhan.chen@intel.com>
Subject: [PATCH 2/3] drivers/gpio: core: introduce helper to find gpiochip
Date: Tue, 13 Apr 2021 22:16:24 -0400
Message-Id: <20210414021625.24725-2-hongzhan.chen@intel.com>
In-Reply-To: <20210414021625.24725-1-hongzhan.chen@intel.com>
References: <20210414021625.24725-1-hongzhan.chen@intel.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

To find gpiochip for non-OF platforms like x86

Signed-off-by: hongzha1 <hongzhan.chen@intel.com>

diff --git a/include/cobalt/kernel/rtdm/gpio.h b/include/cobalt/kernel/rtdm/gpio.h
index 00055ec0a..c5fb20f25 100644
--- a/include/cobalt/kernel/rtdm/gpio.h
+++ b/include/cobalt/kernel/rtdm/gpio.h
@@ -61,6 +61,9 @@ int rtdm_gpiochip_add_by_name(struct rtdm_gpio_chip *rgc,
 int rtdm_gpiochip_post_event(struct rtdm_gpio_chip *rgc,
 			     unsigned int offset);
 
+int rtdm_gpiochip_find(struct device_node *from,
+			  const char *label, int type);
+
 #ifdef CONFIG_OF
 
 int rtdm_gpiochip_scan_of(struct device_node *from,
diff --git a/kernel/drivers/gpio/gpio-core.c b/kernel/drivers/gpio/gpio-core.c
index 600ef9789..b3d801fa1 100644
--- a/kernel/drivers/gpio/gpio-core.c
+++ b/kernel/drivers/gpio/gpio-core.c
@@ -520,6 +520,29 @@ int rtdm_gpiochip_add_by_name(struct rtdm_gpio_chip *rgc,
 }
 EXPORT_SYMBOL_GPL(rtdm_gpiochip_add_by_name);
 
+int rtdm_gpiochip_find(struct device_node *from, const char *label,
+			  int type)
+{
+	struct rtdm_gpio_chip *rgc;
+	struct gpio_chip *chip;
+	int ret = -ENODEV;
+
+	if (!rtdm_available())
+		return -ENOSYS;
+
+	chip = find_chip_by_name(label);
+	if (chip == NULL)
+		return ret;
+
+	ret = 0;
+	rgc = rtdm_gpiochip_alloc(chip, type);
+	if (IS_ERR(rgc))
+		ret = PTR_ERR(rgc);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(rtdm_gpiochip_find);
+
 #ifdef CONFIG_OF
 
 #include <linux/of_platform.h>
-- 
2.17.1


