From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v2 10/12] drivers/gpio: Convert to rtdm_available() and clean
 up
Date: Fri, 13 Sep 2019 18:46:53 +0200
Message-Id: <644a045275b713e7b83832a07060d1cdb1852052.1568393215.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1568393215.git.jan.kiszka@siemens.com>
References: <cover.1568393215.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1568393215.git.jan.kiszka@siemens.com>
References: <cover.1568393215.git.jan.kiszka@siemens.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Jan Kiszka <jan.kiszka@siemens.com>

Properly fail if the core is not available. This also obsoletes the
check on exit.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/gpio/gpio-core.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/kernel/drivers/gpio/gpio-core.c b/kernel/drivers/gpio/gpio-core.c
index 81f9653f12..600ef9789a 100644
--- a/kernel/drivers/gpio/gpio-core.c
+++ b/kernel/drivers/gpio/gpio-core.c
@@ -564,8 +564,8 @@ int rtdm_gpiochip_scan_of(struct device_node *from, const char *compat,
 	struct rtdm_gpio_chip *rgc;
 	int ret = -ENODEV, _ret;
 
-	if (!realtime_core_enabled())
-		return 0;
+	if (!rtdm_available())
+		return -ENOSYS;
 
 	for (;;) {
 		np = of_find_compatible_node(np, NULL, compat);
@@ -622,9 +622,6 @@ void rtdm_gpiochip_remove_of(int type)
 {
 	struct rtdm_gpio_chip *rgc, *n;
 
-	if (!realtime_core_enabled())
-		return;
-
 	mutex_lock(&chip_lock);
 
 	list_for_each_entry_safe(rgc, n, &rtdm_gpio_chips, next) {
-- 
2.16.4


