Sender: Michael Welling <mwelling79@gmail.com>
Date: Tue, 16 Feb 2016 11:58:37 -0600
From: Michael Welling <mwelling@ieee.org>
Message-ID: <20160216175837.GC9806@deathstar>
References: <20160215174121.GA10070@deathstar> <56C2B626.8010804@sigmatek.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56C2B626.8010804@sigmatek.at>
Subject: Re: [Xenomai] RT serial cross-link failure
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wolfgang Netbal <wolfgang.netbal@sigmatek.at>
Cc: xenomai@xenomai.org

On Tue, Feb 16, 2016 at 06:39:50AM +0100, Wolfgang Netbal wrote:
> 
> 
> Am 2016-02-15 um 18:41 schrieb Michael Welling:
> >I took the time to update the IMX UART driver such that it registers with the 3.18 kernel.
> >
> >The driver appears to register correctly and the /dev/rtdm/rtser* nodes appear.
> >
> >When I run the cross-link demo the system hangs after an error in read_task.
> >
> >Here is the output that I get:
> >main : write-file opened
> >main : write-config written
> >main : read-file opened
> >main : read-config written
> >main : write-task created
> >main : read-task created
> >main : starting write-task
> >main : strating read-task
> >  Nr |   write-irq    |    irq->read    |   write->read   |
> >----------------------------------------------------------
> >read_task: error on RTSER_RTIOC_WAIT_EVENT, Operation no permitted
> >main : /dev/rtdm/rtser1 (read) -> closed
> >read_task: exit
> >
> >Any ideas why this would happen?
> >
> >I can provide the patch for the driver if necessary. I tried to keep the changes to a minimal.
> Dear Michael,
> 
> I added a patch on December where I extended the IMX UART driver to support
> open firmware, maybe my patch can help you to find your issue.
> I posted the patch in the mailing list, you can find it here
> https://xenomai.org/pipermail/xenomai/2015-December/035655.html
> 
> Kind regards
> Wolfgang

See patch for what I have done so far below:

diff --git a/kernel/drivers/serial/rt_imx_uart.c b/kernel/drivers/serial/rt_imx_uart.c
index 092cecc..91f86ce 100644
--- a/kernel/drivers/serial/rt_imx_uart.c
+++ b/kernel/drivers/serial/rt_imx_uart.c
@@ -36,8 +36,10 @@
 #include <asm/irq.h>
 #include <asm/dma.h>
 #include <asm/div64.h>
-#include <mach/hardware.h>
-#include <mach/imx-uart.h>
+#include <linux/platform_data/serial-imx.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 
 #include <rtdm/serial.h>
 #include <rtdm/driver.h>
@@ -65,7 +67,9 @@ MODULE_LICENSE("GPL");
 #define UBMR	0xa8 /* BRM Modulator Register */
 #define UBRC	0xac /* Baud Rate Count Register */
 #define MX2_ONEMS 0xb0 /* One Millisecond register */
-#define UTS (cpu_is_mx1() ? 0xd0 : 0xb4) /* UART Test Register */
+#define IMX1_UTS 0xd0 /* UART Test Register on i.mx1 */
+#define IMX21_UTS 0xb4 /* UART Test Register on all other i.mx*/
+
 
 /* UART Control Register Bit Fields.*/
 #define URXD_CHARRDY	(1<<15)
@@ -189,18 +193,32 @@ MODULE_LICENSE("GPL");
 #define RT_IMX_UART_MAX		5
 
 static int tx_fifo[RT_IMX_UART_MAX];
-compat_module_param_array(tx_fifo, int, RT_IMX_UART_MAX, 0400);
+module_param_array(tx_fifo, int, NULL, 0400);
 MODULE_PARM_DESC(tx_fifo, "Transmitter FIFO size");
 
+/* i.mx21 type uart runs on all i.mx except i.mx1 */
+enum imx_uart_type {
+        IMX1_UART,
+        IMX21_UART,
+        IMX6Q_UART,
+};
+
+/* device type dependent stuff */
+struct imx_uart_data {
+        unsigned uts_reg;
+        enum imx_uart_type devtype;
+};
+
 struct rt_imx_uart_port {
 	unsigned char __iomem *membase;	/* read/write[bwl] */
-	resource_size_t mapbase;	/* for ioremap */
 	unsigned int irq;		/* irq number */
 	int tx_fifo;			/* TX fifo size*/
 	unsigned int have_rtscts;
 	unsigned int use_dcedte;
 	unsigned int use_hwflow;
-	struct clk *clk;		/* clock id for UART clock */
+	struct clk *clk_ipg;
+	struct clk *clk_per;
+	const struct imx_uart_data *devdata;
 	unsigned int uartclk;		/* base uart clock */
 	struct rtdm_device rtdm_dev;	/* RTDM device structure */
 };
@@ -344,6 +362,7 @@ static int rt_imx_uart_rx_chars(struct rt_imx_uart_ctx *ctx,
 static void rt_imx_uart_tx_chars(struct rt_imx_uart_ctx *ctx)
 {
 	int ch, count;
+	unsigned uts_reg = ctx->port->devdata->uts_reg;
 
 	for (count = ctx->port->tx_fifo;
 	     (count > 0) && (ctx->out_npend > 0);
@@ -352,7 +371,7 @@ static void rt_imx_uart_tx_chars(struct rt_imx_uart_ctx *ctx)
 		writel(ch, ctx->port->membase + URTX0);
 		ctx->out_head &= (OUT_BUFFER_SIZE - 1);
 
-		if (readl(ctx->port->membase + UTS) & UTS_TXFULL)
+		if (readl(ctx->port->membase + uts_reg) & UTS_TXFULL)
 			break;
 	}
 }
@@ -493,9 +512,10 @@ static unsigned int rt_imx_uart_get_msr(struct rt_imx_uart_ctx *ctx)
 static void rt_imx_uart_set_mcr(struct rt_imx_uart_ctx *ctx,
 				unsigned int mcr)
 {
+	unsigned uts_reg = ctx->port->devdata->uts_reg;
 	unsigned long ucr2 = readl(ctx->port->membase + UCR2);
 	unsigned long ucr3 = readl(ctx->port->membase + UCR3);
-	unsigned long uts = readl(ctx->port->membase + UTS);
+	unsigned long uts = readl(ctx->port->membase + uts_reg);
 
 	if (mcr & RTSER_MCR_RTS) {
 		/*
@@ -523,7 +543,7 @@ static void rt_imx_uart_set_mcr(struct rt_imx_uart_ctx *ctx,
 		uts |= UTS_LOOP;
 	else
 		uts &= ~UTS_LOOP;
-	writel(uts, ctx->port->membase + UTS);
+	writel(uts, ctx->port->membase + uts_reg);
 }
 
 static void rt_imx_uart_break_ctl(struct rt_imx_uart_ctx *ctx,
@@ -723,7 +743,7 @@ static int rt_imx_uart_setup_ufcr(struct rt_imx_uart_port *port)
 	 * RFDIV is set such way to satisfy requested uartclk value
 	 */
 	val = TXTL << 10 | RXTL;
-	ufcr_rfdiv = (clk_get_rate(port->clk) + port->uartclk / 2) /
+	ufcr_rfdiv = (clk_get_rate(port->clk_per) + port->uartclk / 2) /
 		port->uartclk;
 
 	if (!ufcr_rfdiv)
@@ -897,7 +917,7 @@ static int rt_imx_uart_ioctl(struct rtdm_fd *fd,
 		}
 
 		if ((config->config_mask & RTSER_SET_BAUD) &&
-		    (config->baud_rate > clk_get_rate(ctx->port->clk) / 16 ||
+		    (config->baud_rate > clk_get_rate(ctx->port->clk_per) / 16 ||
 		     config->baud_rate <= 0))
 			/* invalid baudrate for this port */
 			return -EINVAL;
@@ -1382,42 +1402,134 @@ static struct rtdm_driver imx_uart_driver = {
 	},
 };
 
+static struct imx_uart_data imx_uart_devdata[] = {
+        [IMX1_UART] = {
+                .uts_reg = IMX1_UTS,
+                .devtype = IMX1_UART,
+        },
+        [IMX21_UART] = {
+                .uts_reg = IMX21_UTS,
+                .devtype = IMX21_UART,
+        },
+        [IMX6Q_UART] = {
+                .uts_reg = IMX21_UTS,
+                .devtype = IMX6Q_UART,
+        },
+};
+
+static struct platform_device_id rt_imx_uart_id_table[] = {
+        {
+                .name = "imx1-uart",
+                .driver_data = (kernel_ulong_t) &imx_uart_devdata[IMX1_UART],
+        }, {
+                .name = "imx21-uart",
+                .driver_data = (kernel_ulong_t) &imx_uart_devdata[IMX21_UART],
+        }, {
+                .name = "imx6q-uart",
+                .driver_data = (kernel_ulong_t) &imx_uart_devdata[IMX6Q_UART],
+        }, {
+                /* sentinel */
+        }
+};
+MODULE_DEVICE_TABLE(platform, rt_imx_uart_id_table);
+
+static struct of_device_id rt_imx_uart_dt_ids[] = {
+        { .compatible = "fsl,imx6q-uart", .data = &imx_uart_devdata[IMX6Q_UART], },
+        { .compatible = "fsl,imx1-uart", .data = &imx_uart_devdata[IMX1_UART], },
+        { .compatible = "fsl,imx21-uart", .data = &imx_uart_devdata[IMX21_UART], },
+        { /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, rt_imx_uart_dt_ids);
+
+#ifdef CONFIG_OF
+
+/*
+ * This function returns 1 iff pdev isn't a device instatiated by dt, 0 iff it
+ * could successfully get all information from dt or a negative errno.
+ */
+static int rt_imx_uart_probe_dt(struct rt_imx_uart_port *port,
+                struct platform_device *pdev)
+{
+        struct device_node *np = pdev->dev.of_node;
+        const struct of_device_id *of_id =
+                        of_match_device(rt_imx_uart_dt_ids, &pdev->dev);
+        int ret;
+
+        if (!np)
+                /* no device tree device */
+                return 1;
+
+        ret = of_alias_get_id(np, "serial");
+        if (ret < 0) {
+                dev_err(&pdev->dev, "failed to get alias id, errno %d\n", ret);
+                return ret;
+        }
+
+	pdev->id = ret;
+
+        if (of_get_property(np, "fsl,uart-has-rtscts", NULL))
+                port->have_rtscts = 1;
+
+        if (of_get_property(np, "fsl,irda-mode", NULL))
+                dev_warn(&pdev->dev, "IRDA not yet supported\n");
+
+        if (of_get_property(np, "fsl,dte-mode", NULL))
+		port->use_dcedte = 1;
+
+        port->devdata = of_id->data;
+
+        return 0;
+}
+#else
+static inline int rt_imx_uart_probe_dt(struct rt_imx_uart_port *port,
+                struct platform_device *pdev)
+{
+        return 1;
+}
+#endif
+
+static void rt_imx_uart_probe_pdata(struct rt_imx_uart_port *port,
+                struct platform_device *pdev)
+{
+        struct imxuart_platform_data *pdata = dev_get_platdata(&pdev->dev);
+
+        port->devdata = (struct imx_uart_data  *) pdev->id_entry->driver_data;
+
+        if (!pdata)
+                return;
+
+        if (pdata->flags & IMXUART_HAVE_RTSCTS)
+                port->have_rtscts = 1;
+}
+
 static int rt_imx_uart_probe(struct platform_device *pdev)
 {
-	struct imxuart_platform_data *pdata;
 	struct rtdm_device *dev;
 	struct rt_imx_uart_port *port;
 	struct resource *res;
-	int err;
+	int ret;
 
-	port = kzalloc(sizeof(*port), GFP_KERNEL);
+	port = devm_kzalloc(&pdev->dev, sizeof(*port), GFP_KERNEL);
 	if (!port)
 		return -ENOMEM;
 
+        ret = rt_imx_uart_probe_dt(port, pdev);
+        if (ret > 0)
+                rt_imx_uart_probe_pdata(port, pdev);
+        else if (ret < 0)
+                return ret;
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		err = -ENODEV;
-		goto kfree_out;
-	}
-	port->mapbase = res->start;
+	if (!res)
+		return -ENODEV;
 
 	port->irq = platform_get_irq(pdev, 0);
-	if (port->irq <= 0) {
-		err = -ENODEV;
-		goto kfree_out;
-	}
-
-	if (!request_mem_region(port->mapbase, PAGE_SIZE, DRIVER_NAME)) {
-		err = -EBUSY;
-		goto kfree_out;
-	}
-
-	port->membase = ioremap(port->mapbase, PAGE_SIZE);
-	if (!port->membase) {
-		err = -ENOMEM;
-		goto release_mem_region_out;
-	}
+	if (port->irq <= 0)
+		return -ENODEV;
 
+	port->membase = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(port->membase))
+		return PTR_ERR(port->membase);
 
 	dev = &port->rtdm_dev;
 	dev->driver = &imx_uart_driver;
@@ -1429,54 +1541,31 @@ static int rt_imx_uart_probe(struct platform_device *pdev)
 	else
 		port->tx_fifo = tx_fifo[pdev->id];
 
-	port->clk = clk_get(&pdev->dev, "uart");
-	if (IS_ERR(port->clk)) {
-		err = PTR_ERR(port->clk);
-		goto iounmap_out;
-	}
-	clk_enable(port->clk);
-	port->uartclk = clk_get_rate(port->clk);
+	port->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
+	if (IS_ERR(port->clk_ipg))
+		return PTR_ERR(port->clk_ipg);
 
-	port->use_hwflow = 1;
+	port->clk_per = devm_clk_get(&pdev->dev, "per");
+	if (IS_ERR(port->clk_per))
+		return PTR_ERR(port->clk_per);
 
-	pdata = pdev->dev.platform_data;
-	if (pdata && (pdata->flags & IMXUART_HAVE_RTSCTS))
-		port->have_rtscts = 1;
-	if (pdata && (pdata->flags & IMXUART_USE_DCEDTE))
-		port->use_dcedte = 1;
-	if (pdata && pdata->init) {
-		err = pdata->init(pdev);
-		if (err)
-			goto clk_disable_out;
-	}
+	clk_enable(port->clk_ipg);
+	clk_enable(port->clk_per);
+	port->uartclk = clk_get_rate(port->clk_per);
+
+	port->use_hwflow = 1;
 
-	err = rtdm_dev_register(dev);
-	if (err)
-		goto pdata_exit_out;
+	ret = rtdm_dev_register(dev);
+	if (ret)
+		return ret;
 
 	platform_set_drvdata(pdev, port);
 
 	printk(KERN_INFO
-	       "%s on IMX UART%d: membase=0x%p mapbase=%#x irq=%d uartclk=%d\n",
-	       dev->name, pdev->id, port->membase, (u32)port->mapbase,
-	       port->irq, port->uartclk);
+	       "%s on IMX UART%d: membase=0x%p irq=%d uartclk=%d\n",
+	       dev->name, pdev->id, port->membase, port->irq, port->uartclk);
 
 	return 0;
-
-pdata_exit_out:
-	if (pdata && pdata->exit)
-		pdata->exit(pdev);
-clk_disable_out:
-	clk_put(port->clk);
-	clk_disable(port->clk);
-iounmap_out:
-	iounmap(port->membase);
-release_mem_region_out:
-	release_mem_region(port->mapbase, SZ_4K);
-kfree_out:
-	kfree(port);
-
-	return err;
 }
 
 static int rt_imx_uart_remove(struct platform_device *pdev)
@@ -1490,26 +1579,9 @@ static int rt_imx_uart_remove(struct platform_device *pdev)
 
 	rtdm_dev_unregister(dev);
 
-	if (port->clk) {
-		clk_put(port->clk);
-		clk_disable(port->clk);
-	}
-
-	if (pdata && pdata->exit)
-		pdata->exit(pdev);
-
-	iounmap(port->membase);
-	release_mem_region(port->mapbase, PAGE_SIZE);
-	kfree(port);
-
 	return 0;
 }
 
-static const struct platform_device_id rt_imx_uart_id_table[] = {
-	{"imx-uart",},
-	{},
-};
-
 static struct platform_driver rt_imx_uart_driver = {
 	.probe = rt_imx_uart_probe,
 	.remove	= rt_imx_uart_remove,
@@ -1517,6 +1589,7 @@ static struct platform_driver rt_imx_uart_driver = {
 	.driver = {
 		.name = DRIVER_NAME,
 		.owner = THIS_MODULE,
+		.of_match_table = rt_imx_uart_dt_ids,
 	},
 };
 

