From: Hongzhan Chen <hongzhan.chen@intel.com>
Subject: [PATCH 2/3] drivers/gpio: core: Introduce helper to find gpiochip
Date: Tue, 31 Aug 2021 01:07:35 -0400
Message-Id: <20210831050736.5371-3-hongzhan.chen@intel.com>
In-Reply-To: <20210831050736.5371-1-hongzhan.chen@intel.com>
References: <20210831050736.5371-1-hongzhan.chen@intel.com>
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

Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
---
 include/cobalt/kernel/rtdm/gpio.h |  7 ++++++
 kernel/drivers/gpio/gpio-core.c   | 42 +++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/include/cobalt/kernel/rtdm/gpio.h b/include/cobalt/kernel/rtdm/gpio.h
index 29f26d6c6..98279e242 100644
--- a/include/cobalt/kernel/rtdm/gpio.h
+++ b/include/cobalt/kernel/rtdm/gpio.h
@@ -62,6 +62,13 @@ int rtdm_gpiochip_add_by_name(struct rtdm_gpio_chip *rgc,
 int rtdm_gpiochip_post_event(struct rtdm_gpio_chip *rgc,
 			     unsigned int offset);
 
+int rtdm_gpiochip_find(struct device_node *from,
+			  const char *label, int type);
+
+int rtdm_gpiochip_array_find(struct device_node *from,
+				const char *compat[],
+				int nentries, int type);
+
 #ifdef CONFIG_OF
 
 int rtdm_gpiochip_scan_of(struct device_node *from,
diff --git a/kernel/drivers/gpio/gpio-core.c b/kernel/drivers/gpio/gpio-core.c
index ccda67bd1..ce80e8d73 100644
--- a/kernel/drivers/gpio/gpio-core.c
+++ b/kernel/drivers/gpio/gpio-core.c
@@ -528,6 +528,48 @@ int rtdm_gpiochip_add_by_name(struct rtdm_gpio_chip *rgc,
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
+int rtdm_gpiochip_array_find(struct device_node *from,
+				const char *compat[],
+				int nentries, int type)
+{
+	int ret = -ENODEV, _ret, n;
+
+	for (n = 0; n < nentries; n++) {
+		_ret = rtdm_gpiochip_find(from, compat[n], type);
+		if (_ret) {
+			if (_ret != -ENODEV)
+				return _ret;
+		} else
+			ret = 0;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(rtdm_gpiochip_array_find);
+
 #ifdef CONFIG_OF
 
 #include <linux/of_platform.h>
-- 
2.17.1


