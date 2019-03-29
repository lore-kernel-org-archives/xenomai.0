From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH 1/4] drivers/serial: imx: robustify device setup/cleanup
Date: Fri, 29 Mar 2019 18:41:00 +0100
Message-Id: <20190329174103.8158-2-rpm@xenomai.org>
In-Reply-To: <20190329174103.8158-1-rpm@xenomai.org>
References: <20190329174103.8158-1-rpm@xenomai.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

- fix the reset sequence which may have caused random lockups when
  re-opening the device.

- converge to the mainline implementation wrt setting up the UART
  registers.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/drivers/serial/rt_imx_uart.c | 101 ++++++++++++++++++----------
 1 file changed, 67 insertions(+), 34 deletions(-)

diff --git a/kernel/drivers/serial/rt_imx_uart.c b/kernel/drivers/serial/rt_imx_uart.c
index f91d8fb8b..32b472c78 100644
--- a/kernel/drivers/serial/rt_imx_uart.c
+++ b/kernel/drivers/serial/rt_imx_uart.c
@@ -103,6 +103,7 @@ MODULE_LICENSE("GPL");
 #define UCR2_STPB	(1<<6)	/* Stop */
 #define UCR2_WS		(1<<5)	/* Word size */
 #define UCR2_RTSEN	(1<<4)	/* Request to send interrupt enable */
+#define UCR2_ATEN	(1<<3)	/* Aging Timer Enable */
 #define UCR2_TXEN	(1<<2)	/* Transmitter enabled */
 #define UCR2_RXEN	(1<<1)	/* Receiver enabled */
 #define UCR2_SRST	(1<<0)	/* SW reset */
@@ -112,10 +113,11 @@ MODULE_LICENSE("GPL");
 #define UCR3_DSR	(1<<10) /* Data set ready */
 #define UCR3_DCD	(1<<9)	/* Data carrier detect */
 #define UCR3_RI		(1<<8)	/* Ring indicator */
-#define UCR3_TIMEOUTEN	(1<<7)	/* Timeout interrupt enable */
+#define UCR3_ADNIMP	(1<<7)	/* Autobaud Detection Not Improved */
 #define UCR3_RXDSEN	(1<<6)	/* Receive status interrupt enable */
 #define UCR3_AIRINTEN	(1<<5)	/* Async IR wake interrupt enable */
 #define UCR3_AWAKEN	(1<<4)	/* Async wake interrupt enable */
+#define UCR3_DTRDEN	(1<<3)	/* Data Terminal Ready Delta Enable. */
 #define MX1_UCR3_REF25		(1<<3)	/* Ref freq 25 MHz, only on mx1 */
 #define MX1_UCR3_REF30		(1<<2)	/* Ref Freq 30 MHz, only on mx1 */
 #define MX2_UCR3_RXDMUXSEL	(1<<2)	/* RXD Muxed Input Select, on mx2/mx3 */
@@ -693,16 +695,16 @@ static int rt_imx_uart_set_config(struct rt_imx_uart_ctx *ctx,
 				   RTSER_SET_EVENT_MASK |
 				   RTSER_SET_HANDSHAKE)) {
 		struct rt_imx_uart_port *port = ctx->port;
-		unsigned int ucr2, old_ucr1, old_txrxen;
+		unsigned int ucr2, old_ucr1, old_txrxen, old_ucr2;
 		unsigned int baud = ctx->config.baud_rate;
 		unsigned int div, ufcr;
 		unsigned long num, denom;
 		uint64_t tdiv64;
 
 		if (ctx->config.data_bits == RTSER_8_BITS)
-			ucr2 = UCR2_WS | UCR2_SRST | UCR2_IRTS;
+			ucr2 = UCR2_WS | UCR2_IRTS;
 		else
-			ucr2 = UCR2_SRST | UCR2_IRTS;
+			ucr2 = UCR2_IRTS;
 
 		if (ctx->config.handshake == RTSER_RTSCTS_HAND) {
 			if (port->have_rtscts) {
@@ -727,6 +729,8 @@ static int rt_imx_uart_set_config(struct rt_imx_uart_ctx *ctx,
 		old_ucr1 &= ~UCR1_RTSDEN; /* reset in  rt_imx_uart_enable_ms()*/
 		writel(old_ucr1 & ~(UCR1_TXMPTYEN | UCR1_RRDYEN),
 		       port->membase + UCR1);
+		old_ucr2 = readl(port->membase + USR2);
+		writel(old_ucr2 & ~UCR2_ATEN, port->membase + USR2);
 		while (!(readl(port->membase + USR2) & USR2_TXDC))
 			barrier();
 
@@ -818,13 +822,27 @@ static int rt_imx_uart_setup_ufcr(struct rt_imx_uart_port *port)
 /* half the RX buffer size */
 #define CTSTL 16
 
+static void uart_reset(struct rt_imx_uart_port *port)
+{
+	unsigned int uts_reg = port->devdata->uts_reg;
+	int n = 100;
+	u32 temp;
+
+	/* Reset fifo's and state machines */
+	temp = readl(port->membase + UCR2);
+	temp &= ~UCR2_SRST;
+	writel(temp, port->membase + UCR2);
+	n = 100;
+	while (!(readl(port->membase + uts_reg) & UTS_SOFTRST) && --n > 0)
+		udelay(1);
+}
+
 static int rt_imx_uart_open(struct rtdm_fd *fd, int oflags)
 {
 	struct rt_imx_uart_ctx *ctx;
 	struct rt_imx_uart_port *port;
 	rtdm_lockctx_t lock_ctx;
 	unsigned long temp;
-	int retval;
 	uint64_t *dummy;
 
 	ctx = rtdm_fd_to_private(fd);
@@ -855,8 +873,6 @@ static int rt_imx_uart_open(struct rtdm_fd *fd, int oflags)
 	ctx->status = 0;
 	ctx->saved_errors = 0;
 
-	rt_imx_uart_setup_ufcr(port);
-
 	/*
 	 * disable the DREN bit (Data Ready interrupt enable) before
 	 * requesting IRQs
@@ -868,70 +884,86 @@ static int rt_imx_uart_open(struct rtdm_fd *fd, int oflags)
 	temp |= CTSTL << UCR4_CTSTL_SHF;
 	writel(temp & ~UCR4_DREN, port->membase + UCR4);
 
-	rt_imx_uart_set_config(ctx, &default_config, &dummy);
-
-	retval = rtdm_irq_request(&ctx->irq_handle,
-				  port->irq, rt_imx_uart_int, 0,
-				  rtdm_fd_device(fd)->name, ctx);
-	if (retval)
-		return retval;
+	uart_reset(port);
 
 	rtdm_lock_get_irqsave(&ctx->lock, lock_ctx);
 
 	/*
 	 * Finally, clear status and enable interrupts
 	 */
-	writel(0xFFFF, port->membase + USR1);
-	writel(0xFFFF, port->membase + USR2);
+	writel(USR1_RTSD | USR1_DTRD, port->membase + USR1);
+	writel(USR2_ORE, port->membase + USR2);
 
-	temp = readl(port->membase + UCR1);
-	temp |= UCR1_RRDYEN  | UCR1_UARTEN;
+	temp = readl(port->membase + UCR1) & ~UCR1_RRDYEN;
+	temp |= UCR1_UARTEN;
+	if (port->have_rtscts)
+		temp |= UCR1_RTSDEN;
 	writel(temp, port->membase + UCR1);
 
-	temp = readl(port->membase + UCR2);
+	temp = readl(port->membase + UCR4);
+	temp |= UCR4_OREN;
+	writel(temp, port->membase + UCR4);
+
+	temp = readl(port->membase + UCR2) & ~(UCR2_ATEN|UCR2_RTSEN);
 	temp |= (UCR2_RXEN | UCR2_TXEN);
+	if (!port->have_rtscts)
+		temp |= UCR2_IRTS;
 	writel(temp, port->membase + UCR2);
 
 	temp = readl(port->membase + UCR3);
 	temp |= MX2_UCR3_RXDMUXSEL;
 	writel(temp, port->membase + UCR3);
 
+	temp = readl(port->membase + UCR1);
+	temp |= UCR1_RRDYEN;
+	writel(temp, port->membase + UCR1);
+
+	temp = readl(port->membase + UCR2);
+	temp |= UCR2_ATEN;
+	writel(temp, port->membase + UCR2);
+
 	rtdm_lock_put_irqrestore(&ctx->lock, lock_ctx);
 
-	return 0;
+	rt_imx_uart_set_config(ctx, &default_config, &dummy);
+
+	rt_imx_uart_setup_ufcr(port);
+
+	return rtdm_irq_request(&ctx->irq_handle,
+				port->irq, rt_imx_uart_int, 0,
+				rtdm_fd_device(fd)->name, ctx);
 }
 
 void rt_imx_uart_close(struct rtdm_fd *fd)
 {
+	struct rt_imx_uart_port *port;
 	struct rt_imx_uart_ctx *ctx;
-	uint64_t *in_history;
 	rtdm_lockctx_t lock_ctx;
 	unsigned long temp;
 
 	ctx = rtdm_fd_to_private(fd);
+	port = ctx->port;
 
 	rtdm_lock_get_irqsave(&ctx->lock, lock_ctx);
 
-	temp = readl(ctx->port->membase + UCR2);
-	temp &= ~(UCR2_TXEN);
-	writel(temp, ctx->port->membase + UCR2);
-
+	temp = readl(port->membase + UCR2);
+	temp &= ~(UCR2_ATEN|UCR2_RTSEN|UCR2_RXEN|UCR2_TXEN|UCR2_IRTS);
+	writel(temp, port->membase + UCR2);
 	/*
-	 * Disable all interrupts, port and break condition.
+	 * Disable all interrupts, port and break condition, then
+	 * reset.
 	 */
-	temp = readl(ctx->port->membase + UCR1);
+	temp = readl(port->membase + UCR1);
 	temp &= ~(UCR1_TXMPTYEN | UCR1_RRDYEN | UCR1_RTSDEN | UCR1_UARTEN);
-	writel(temp, ctx->port->membase + UCR1);
-
-	in_history = ctx->in_history;
-	ctx->in_history = NULL;
+	writel(temp, port->membase + UCR1);
 
 	rtdm_lock_put_irqrestore(&ctx->lock, lock_ctx);
 
 	rtdm_irq_free(&ctx->irq_handle);
-	rt_imx_uart_cleanup_ctx(ctx);
 
-	kfree(in_history);
+	uart_reset(port);
+
+	rt_imx_uart_cleanup_ctx(ctx);
+	kfree(ctx->in_history);
 }
 
 static int rt_imx_uart_ioctl(struct rtdm_fd *fd,
@@ -1490,7 +1522,8 @@ static int rt_imx_uart_probe_dt(struct rt_imx_uart_port *port,
 
 	pdev->id = ret;
 
-	if (of_get_property(np, "fsl,uart-has-rtscts", NULL))
+	if (of_get_property(np, "uart-has-rtscts", NULL) ||
+	    of_get_property(np, "fsl,uart-has-rtscts", NULL) /* deprecated */)
 		port->have_rtscts = 1;
 	if (of_get_property(np, "fsl,irda-mode", NULL))
 		dev_warn(&pdev->dev, "IRDA not yet supported\n");
-- 
2.20.1


