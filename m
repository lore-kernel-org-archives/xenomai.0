From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v2 07/12] drivers/serial: Convert to rtdm_available() and
 clean up
Date: Fri, 13 Sep 2019 18:46:50 +0200
Message-Id: <85a72dbdf01f4be56b531e65556f565110ad6601.1568393215.git.jan.kiszka@siemens.com>
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
 kernel/drivers/serial/16550A.c       | 7 ++-----
 kernel/drivers/serial/mpc52xx_uart.c | 7 +++----
 kernel/drivers/serial/rt_imx_uart.c  | 7 +++----
 3 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/kernel/drivers/serial/16550A.c b/kernel/drivers/serial/16550A.c
index 81acc6344e..c9274fb191 100644
--- a/kernel/drivers/serial/16550A.c
+++ b/kernel/drivers/serial/16550A.c
@@ -1103,8 +1103,8 @@ int __init rt_16550_init(void)
 	int err;
 	int i;
 
-	if (!realtime_core_enabled())
-		return 0;
+	if (!rtdm_available())
+		return -ENODEV;
 
 	rt_16550_pnp_init();
 	rt_16550_pci_init();
@@ -1173,9 +1173,6 @@ void rt_16550_exit(void)
 {
 	int i;
 
-	if (!realtime_core_enabled())
-		return;
-
 	for (i = 0; i < MAX_DEVICES; i++)
 		if (device[i]) {
 			rtdm_dev_unregister(device[i]);
diff --git a/kernel/drivers/serial/mpc52xx_uart.c b/kernel/drivers/serial/mpc52xx_uart.c
index a7b357959b..fe469d5987 100644
--- a/kernel/drivers/serial/mpc52xx_uart.c
+++ b/kernel/drivers/serial/mpc52xx_uart.c
@@ -1411,8 +1411,8 @@ static int __init rt_mpc52xx_uart_init(void)
 {
 	int ret;
 
-	if (!realtime_core_enabled())
-		return 0;
+	if (!rtdm_available())
+		return -ENODEV;
 
 	printk(KERN_INFO "RTserial: MPC52xx PSC UART driver\n");
 
@@ -1431,8 +1431,7 @@ static int __init rt_mpc52xx_uart_init(void)
 
 static void __exit rt_mpc52xx_uart_exit(void)
 {
-	if (realtime_core_enabled())
-		platform_driver_unregister(&rt_mpc52xx_uart_of_driver);
+	platform_driver_unregister(&rt_mpc52xx_uart_of_driver);
 }
 
 module_init(rt_mpc52xx_uart_init);
diff --git a/kernel/drivers/serial/rt_imx_uart.c b/kernel/drivers/serial/rt_imx_uart.c
index 6d95cbcab1..2b27b7debb 100644
--- a/kernel/drivers/serial/rt_imx_uart.c
+++ b/kernel/drivers/serial/rt_imx_uart.c
@@ -1656,8 +1656,8 @@ static int __init rt_imx_uart_init(void)
 {
 	int ret;
 
-	if (!realtime_core_enabled())
-		return 0;
+	if (!rtdm_available())
+		return -ENODEV;
 
 	ret = platform_driver_register(&rt_imx_uart_driver);
 	if (ret) {
@@ -1670,8 +1670,7 @@ static int __init rt_imx_uart_init(void)
 
 static void __exit rt_imx_uart_exit(void)
 {
-	if (realtime_core_enabled())
-		platform_driver_unregister(&rt_imx_uart_driver);
+	platform_driver_unregister(&rt_imx_uart_driver);
 }
 
 module_init(rt_imx_uart_init);
-- 
2.16.4


