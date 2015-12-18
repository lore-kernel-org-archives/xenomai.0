References: <567423D3.3020303@sigmatek.at>
From: Wolfgang Netbal <wolfgang.netbal@sigmatek.at>
Message-ID: <567425A6.9090702@sigmatek.at>
Date: Fri, 18 Dec 2015 16:26:30 +0100
MIME-Version: 1.0
In-Reply-To: <567423D3.3020303@sigmatek.at>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Adapted rt_uart_imx.c to work with kernel 3.10
Reply-To: wolfgang.netbal@sigmatek.at
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Dear All,

please find below the patch.
Sorry that I sent my first mail as html.

Kind regards
Wolfgang

 >From cc90e56573d512e44badf16c2feb200f456ad935 Mon Sep 17 00:00:00 2001
From: Wolfgang Netbal <wolfgang.netbal@sigmatek.at>
Date: Fri, 18 Dec 2015 15:44:06 +0100
Subject: [PATCH] [RM103] Fixing rt_uart driver for device tree 3.10.53

---
  ksrc/drivers/serial/rt_imx_uart.c |  141 
++++++++++++++++++++++++++++++-------
  1 file changed, 116 insertions(+), 25 deletions(-)

diff --git a/ksrc/drivers/serial/rt_imx_uart.c 
b/ksrc/drivers/serial/rt_imx_uart.c
index 34df11a..b15d537 100644
--- a/ksrc/drivers/serial/rt_imx_uart.c
+++ b/ksrc/drivers/serial/rt_imx_uart.c
@@ -240,9 +240,11 @@ struct rt_imx_uart_port {
      unsigned int have_rtscts;
      unsigned int use_dcedte;
      unsigned int use_hwflow;
-    struct clk *clk;        /* clock id for UART clock */
+    struct clk *clk_ipg;
+    struct clk *clk_per;
      unsigned int uartclk;        /* base uart clock */
      struct rtdm_device rtdm_dev;    /* RTDM device structure */
+    unsigned int        line;            /* port index */

      /* Steuerleitungen funktionieren nicht richtig, wenn sie Ã¼ber
       * die Register des UARTs angesprochen werden, daher besteht
@@ -327,6 +329,83 @@ static const struct rtser_config default_config = {
      .event_mask = RTSER_DEF_EVENT_MASK,
  };

+/* Compatibility functions to support old kernel versions */
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,10,0)
+static inline void rt_imx_uart_clk_enable(struct rt_imx_uart_port *priv)
+{
+    clk_prepare_enable(priv->clk_ipg);
+    clk_prepare_enable(priv->clk_per);
+}
+static inline void rt_imx_uart_clk_disable(struct rt_imx_uart_port *priv)
+{
+    clk_disable_unprepare(priv->clk_ipg);
+    clk_disable_unprepare(priv->clk_per);
+}
+#elif LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0)
+static inline void rt_imx_uart_clk_enable(struct rt_imx_uart_port *priv)
+{
+    clk_prepare_enable(priv->clk);
+}
+static inline void rt_imx_uart_clk_disable(struct rt_imx_uart_port *priv)
+{
+    clk_disable_unprepare(priv->clk);
+}
+#else
+static inline void rt_imx_uart_clk_enable(struct rt_imx_uart_port *priv)
+{
+    clk_enable(priv->clk);
+}
+static inline void rt_imx_uart_clk_disable(struct rt_imx_uart_port *priv)
+{
+    clk_disable(priv->clk);
+}
+#endif
+
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,10,0)
+static void rt_imx_uart_put_clocks(struct rt_imx_uart_port *priv)
+{
+    clk_put(priv->clk_per);
+    clk_put(priv->clk_ipg);
+}
+#else
+static void rt_imx_uart_put_clocks(struct rt_imx_uart_port *priv)
+{
+    clk_put(priv->clk);
+}
+#endif
+
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,10,0)
+static struct clk* rt_imx_uart_get_clocks(struct rt_imx_uart_port *priv)
+{
+    clk_put(priv->clk_per);
+    clk_put(priv->clk_ipg);
+    if(priv != NULL && priv->clk_per != NULL && priv->clk_ipg != NULL)
+        return priv->clk_per;
+
+    return NULL;
+}
+#else
+static void rt_imx_uart_get_clocks(struct rt_imx_uart_port *priv)
+{
+    if(priv != NULL)
+        return priv->clk;
+
+    return NULL;
+}
+#endif
+
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,10,0)
+static inline unsigned long rt_imx_uart_clk_get_rate(struct 
rt_imx_uart_port *priv)
+{
+    return clk_get_rate(priv->clk_per);
+}
+#else
+static inline  unsigned long rt_imx_uart_clk_get_rate(struct 
rt_imx_uart_port *priv)
+{
+    return clk_get_rate(port->clk);
+}
+#endif
+
  static ssize_t rt_imx_uart_read_timestamps(struct rtdm_dev_context 
*context,
               rtdm_user_info_t *user_info, void *buf, size_t nbyte);

@@ -410,7 +489,6 @@ static void rt_imx_uart_start_tx(struct 
rt_imx_uart_ctx *ctx)

      temp = readl(ctx->port->membase + UCR1);
      writel(temp | UCR1_TXMPTYEN, ctx->port->membase + UCR1);
-
      if (port->rs485.flags & SER_RS485_ENABLED) {
          writel(readl(port->membase + UCR4) | UCR4_TCEN, port->membase 
+ UCR4);
          imx_rs485_switch_to_tx(port);
@@ -941,7 +1019,7 @@ static int rt_imx_uart_setup_ufcr(struct 
rt_imx_uart_port *port)
       * RFDIV is set such way to satisfy requested uartclk value
       */
      val = TXTL << 10 | RXTL;
-    ufcr_rfdiv = (clk_get_rate(port->clk) + port->uartclk / 2) /
+    ufcr_rfdiv = (rt_imx_uart_clk_get_rate(port) + port->uartclk / 2) /
          port->uartclk;

      if (!ufcr_rfdiv)
@@ -1134,7 +1212,7 @@ static int rt_imx_uart_ioctl(struct 
rtdm_dev_context *context,
          }

          if (testbits(config->config_mask, RTSER_SET_BAUD) &&
-            (config->baud_rate > clk_get_rate(ctx->port->clk) / 16 ||
+            (config->baud_rate > rt_imx_uart_clk_get_rate(ctx->port) / 
16 ||
               config->baud_rate <= 0))
              /* invalid baudrate for this port */
              return -EINVAL;
@@ -1898,6 +1976,7 @@ static int serial_imx_probe_dt(struct 
rt_imx_uart_port *sport,
          dev_err(&pdev->dev, "failed to get alias id, errno %d\n", ret);
          return ret;
      }
+    sport->line = ret;

      if (of_get_property(np, "fsl,uart-has-rtscts", NULL))
          sport->have_rtscts = 1;
@@ -1964,7 +2043,9 @@ static void serial_imx_probe_pdata(struct 
rt_imx_uart_port *sport,

  static int rt_imx_uart_probe(struct platform_device *pdev)
  {
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,10,53)
      struct imxuart_platform_data *pdata;
+#endif
      struct rtdm_device *dev;
      struct rt_imx_uart_port *port;
      struct resource *res;
@@ -1975,9 +2056,10 @@ static int rt_imx_uart_probe(struct 
platform_device *pdev)
          return -ENOMEM;

      err = serial_imx_probe_dt(port, pdev);
-    if (err > 0)
+    if (err > 0) {
          serial_imx_probe_pdata(port, pdev);
-    else if (err < 0)
+        port->line = pdev->id;
+    } else if (err < 0)
          return err;

      res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -1997,7 +2079,6 @@ static int rt_imx_uart_probe(struct 
platform_device *pdev)
          err = -EBUSY;
          goto kfree_out;
      }
-
      port->membase = ioremap(port->mapbase, PAGE_SIZE);
      if (!port->membase) {
          err = -ENOMEM;
@@ -2007,33 +2088,40 @@ static int rt_imx_uart_probe(struct 
platform_device *pdev)
      dev = &port->rtdm_dev;
      memcpy(dev, &device_tmpl, sizeof(struct rtdm_device));
      snprintf(dev->device_name, RTDM_MAX_DEVNAME_LEN, "rtser%d",
-         start_index + pdev->id);
-    dev->device_id = pdev->id;
+         start_index + port->line);
+    dev->device_id = port->line;
      dev->device_data = port;

      dev->proc_name = dev->device_name;
-
-    if (!tx_fifo[pdev->id] || tx_fifo[pdev->id] > TX_FIFO_SIZE)
+    if (!tx_fifo[port->line] || tx_fifo[port->line] > TX_FIFO_SIZE)
          port->tx_fifo = TX_FIFO_SIZE;
      else
-        port->tx_fifo = tx_fifo[pdev->id];
+        port->tx_fifo = tx_fifo[port->line];

-    port->clk = clk_get(&pdev->dev, "uart");
-    if (IS_ERR(port->clk)) {
-        err = PTR_ERR(port->clk);
+    port->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
+    if (IS_ERR(port->clk_ipg)) {
+        err = PTR_ERR(port->clk_ipg);
          goto iounmap_out;
      }
-    clk_enable(port->clk);
-    port->uartclk = clk_get_rate(port->clk);

-    port->use_hwflow = 1;
+    port->clk_per = devm_clk_get(&pdev->dev, "per");
+    if (IS_ERR(port->clk_per)) {
+        err = PTR_ERR(port->clk_per);
+        goto iounmap_out;
+    }

+    rt_imx_uart_clk_enable(port);
+    port->uartclk = rt_imx_uart_clk_get_rate(port);
+
+    port->use_hwflow = 1;
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,10,53)
      pdata = pdev->dev.platform_data;
      if (pdata && pdata->init) {
          err = pdata->init(pdev);
          if (err)
              goto clk_disable_out;
      }
+#endif

      if (port->gpio_cts) {
          err = gpio_request_one(port->gpio_cts, GPIOF_DIR_IN, "uart_cts");
@@ -2077,7 +2165,6 @@ static int rt_imx_uart_probe(struct 
platform_device *pdev)
              return err;
          }
      }
-
      err = rtdm_dev_register(dev);
      if (err)
          goto pdata_exit_out;
@@ -2086,17 +2173,19 @@ static int rt_imx_uart_probe(struct 
platform_device *pdev)

      printk(KERN_INFO
             "%s on IMX UART%d: membase=0x%p mapbase=%#x irq=%d 
uartclk=%d\n",
-           dev->device_name, pdev->id, port->membase, (u32)port->mapbase,
+           dev->device_name, port->line, port->membase, (u32)port->mapbase,
             port->irq, port->uartclk);

      return 0;

  pdata_exit_out:
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,10,53)
      if (pdata && pdata->exit)
          pdata->exit(pdev);
  clk_disable_out:
-    clk_put(port->clk);
-    clk_disable(port->clk);
+#endif
+    rt_imx_uart_put_clocks(port);
+    rt_imx_uart_clk_disable(port);
  iounmap_out:
      iounmap(port->membase);
  release_mem_region_out:
@@ -2118,13 +2207,15 @@ static int rt_imx_uart_remove(struct 
platform_device *pdev)

      rtdm_dev_unregister(dev, 1000);

-    if (port->clk) {
-        clk_put(port->clk);
-        clk_disable(port->clk);
+    if (rt_imx_uart_get_clocks(port)) {
+        rt_imx_uart_put_clocks(port);
+        rt_imx_uart_clk_disable(port);
      }

+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,10,53)
      if (pdata && pdata->exit)
          pdata->exit(pdev);
+#endif

      iounmap(port->membase);
      release_mem_region(port->mapbase, PAGE_SIZE);




Am 2015-12-18 um 16:18 schrieb Wolfgang Netbal:
> Dear Wolfgang Grandegger,
>
> I extended your driver for the realtime serial on imx to work with 
> device treefiles,
> we use kernel 3.10 with devicetree thats why I used #ifdef < 3,10,0.
>
> As a base I used commit _a7b7adec9123dc60587d160f0818322a9a547630_ 
> <http://git.xenomai.org/xenomai-2.6.git/commit/ksrc/drivers/can/rtcan_flexcan.c?id=a7b7adec9123dc60587d160f0818322a9a547630> 
> can/flexcan: fixup for kernel release >= 3.11
> __ 
> <http://git.xenomai.org/xenomai-2.6.git/commit/ksrc/drivers/can/rtcan_flexcan.c?id=a7b7adec9123dc60587d160f0818322a9a547630>
> Feel free to add the attached patch to xenomai if it helps.
> We are using xenomai 2.6.4 as base, but have to change a few things in 
> the file,
> because of this I think the patch wont apply out of the box.
>
> Kind regards
> <http://git.xenomai.org/xenomai-2.6.git/commit/ksrc/drivers/can/rtcan_flexcan.c?id=a7b7adec9123dc60587d160f0818322a9a547630> 
>


