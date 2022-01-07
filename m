From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 4/6] drivers/serial: rt_imx_uart: Make it DT-only
Date: Fri, 7 Jan 2022 12:35:33 +0100
Message-ID: <167c7e6a85eb4cefb73ec811c5599c7e722d917d.1641555334.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1641555334.git.jan.kiszka@siemens.com>
References: <cover.1641555334.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

Aligns us with upstream and allows to compile against 5.11+.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/serial/rt_imx_uart.c | 32 +++--------------------------
 1 file changed, 3 insertions(+), 29 deletions(-)

diff --git a/kernel/drivers/serial/rt_imx_uart.c b/kernel/drivers/serial/rt_imx_uart.c
index 94efe873a6..00fdd5f363 100644
--- a/kernel/drivers/serial/rt_imx_uart.c
+++ b/kernel/drivers/serial/rt_imx_uart.c
@@ -36,7 +36,6 @@
 #include <asm/irq.h>
 #include <asm/dma.h>
 #include <asm/div64.h>
-#include <linux/platform_data/serial-imx.h>
 #include <linux/slab.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -1497,11 +1496,9 @@ static struct rtdm_driver imx_uart_driver = {
 };
 
 
-#ifdef CONFIG_OF
-
 /*
- * This function returns 1 iff pdev isn't a device instatiated by dt, 0 iff it
- * could successfully get all information from dt or a negative errno.
+ * This function returns 0 iff it could successfully get all information
+ * from dt or a negative errno.
  */
 static int rt_imx_uart_probe_dt(struct rt_imx_uart_port *port,
 				struct platform_device *pdev)
@@ -1536,27 +1533,6 @@ static int rt_imx_uart_probe_dt(struct rt_imx_uart_port *port,
 
 	return 0;
 }
-#else
-static inline int rt_imx_uart_probe_dt(struct rt_imx_uart_port *port,
-				       struct platform_device *pdev)
-{
-	return 1;
-}
-#endif
-
-static void rt_imx_uart_probe_pdata(struct rt_imx_uart_port *port,
-				    struct platform_device *pdev)
-{
-	struct imxuart_platform_data *pdata = dev_get_platdata(&pdev->dev);
-
-	port->devdata = (struct imx_uart_data  *) pdev->id_entry->driver_data;
-
-	if (!pdata)
-		return;
-
-	if (pdata->flags & IMXUART_HAVE_RTSCTS)
-		port->have_rtscts = 1;
-}
 
 static int rt_imx_uart_probe(struct platform_device *pdev)
 {
@@ -1570,9 +1546,7 @@ static int rt_imx_uart_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	ret = rt_imx_uart_probe_dt(port, pdev);
-	if (ret > 0)
-		rt_imx_uart_probe_pdata(port, pdev);
-	else if (ret < 0)
+	if (ret < 0)
 		return ret;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
2.31.1


