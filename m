From: hongzha1 <hongzhan.chen@intel.com>
Subject: [PATCH 4/5] drivers/gpio: core: introduce helper to find gpiochip
Date: Sat, 20 Feb 2021 00:53:10 -0500
Message-Id: <20210220055311.23826-4-hongzhan.chen@intel.com>
In-Reply-To: <20210220055311.23826-1-hongzhan.chen@intel.com>
References: <20210220055311.23826-1-hongzhan.chen@intel.com>
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
index 00055ec0a..1d1e67bf7 100644
--- a/include/cobalt/kernel/rtdm/gpio.h
+++ b/include/cobalt/kernel/rtdm/gpio.h
@@ -61,6 +61,9 @@ int rtdm_gpiochip_add_by_name(struct rtdm_gpio_chip *rgc,
 int rtdm_gpiochip_post_event(struct rtdm_gpio_chip *rgc,
 			     unsigned int offset);
 
+int rtdm_gpiochip_find(struct device_node *from,
+			  void *compat, int type);
+
 #ifdef CONFIG_OF
 
 int rtdm_gpiochip_scan_of(struct device_node *from,
diff --git a/kernel/drivers/gpio/gpio-core.c b/kernel/drivers/gpio/gpio-core.c
index 600ef9789..7ab989e94 100644
--- a/kernel/drivers/gpio/gpio-core.c
+++ b/kernel/drivers/gpio/gpio-core.c
@@ -554,6 +554,34 @@ static int match_gpio_chip(struct gpio_chip *gc, void *data)
 	return 0;
 }
 
+static int chip_match_name(struct gpio_chip *chip, void *data)
+{
+	return !strncmp(chip->label, data, strlen(data));
+}
+
+int rtdm_gpiochip_find(struct device_node *from, void *compat,
+			  int type)
+{
+	struct rtdm_gpio_chip *rgc;
+	struct gpio_chip *chip;
+	int ret = -ENODEV;
+
+	if (!rtdm_available())
+		return -ENOSYS;
+
+	chip = gpiochip_find(compat, chip_match_name);
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
 int rtdm_gpiochip_scan_of(struct device_node *from, const char *compat,
 			  int type)
 {
-- 
2.17.1


