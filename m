From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH 18/18] drivers/serial: imx: add required clock preparation
Date: Mon,  4 Feb 2019 11:56:47 +0100
Message-Id: <20190204105647.5034-19-rpm@xenomai.org>
In-Reply-To: <20190204105647.5034-1-rpm@xenomai.org>
References: <20190204105647.5034-1-rpm@xenomai.org>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>

---
 kernel/drivers/serial/rt_imx_uart.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/drivers/serial/rt_imx_uart.c b/kernel/drivers/serial/rt_imx_uart.c
index 1aec219b7..443a34261 100644
--- a/kernel/drivers/serial/rt_imx_uart.c
+++ b/kernel/drivers/serial/rt_imx_uart.c
@@ -1579,8 +1579,8 @@ static int rt_imx_uart_probe(struct platform_device *pdev)
 	if (IS_ERR(port->clk_per))
 		return PTR_ERR(port->clk_per);
 
-	clk_enable(port->clk_ipg);
-	clk_enable(port->clk_per);
+	clk_prepare_enable(port->clk_ipg);
+	clk_prepare_enable(port->clk_per);
 	port->uartclk = clk_get_rate(port->clk_per);
 
 	port->use_hwflow = 1;
@@ -1605,6 +1605,8 @@ static int rt_imx_uart_remove(struct platform_device *pdev)
 	pdata = pdev->dev.platform_data;
 	platform_set_drvdata(pdev, NULL);
 
+	clk_disable_unprepare(port->clk_ipg);
+	clk_disable_unprepare(port->clk_per);
 	rtdm_dev_unregister(dev);
 
 	return 0;
-- 
2.17.2


