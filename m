Message-ID: <4F184E42.6060300@domain.hid>
Date: Thu, 19 Jan 2012 18:09:22 +0100
From: Fabrice Gasnier <fabrice.gasnier@domain.hid>
MIME-Version: 1.0
References: <4F1080E8.6020408@domain.hid>	<4F1082E5.8000501@domain.hid>	<4F132A7E.4000000@domain.hid>
	<4F16F028.6020507@domain.hid> <4F16F401.2090308@domain.hid>
In-Reply-To: <4F16F401.2090308@domain.hid>
Content-Type: multipart/mixed; boundary="------------040406040700060005070200"
Subject: Re: [Xenomai-help] Omap3630, rtserial, xeno_16550A: crash on insmod
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------040406040700060005070200
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 18/01/2012 17:32, Wolfgang Grandegger wrote:
>> Further investigation indicates that when writing, tx interrupt is not asserted as expected (rt_16550_write):
>> > /* unmask tx interrupt */
>> > ctx->ier_status |= IER_TX;
>> > rt_16550_reg_out(rt_16550_io_mode_from_ctx(ctx),
>> > 		 ctx->base_addr, IER,
>> > 		 ctx->ier_status,
>> > 		 ctx->regshift);
>> > 
>> >>From my understanding this should trigger an irq for data to be put in rt_16550_tx_interrupt().
>> > It seems this is not always the case. Moreover, TX interrupt seem to be triggered by a new RX interrupt.
> The TX interrupt will be enabled as long as there are chars to send,
> IIRC. The isr the puts the chars into the FIFO and triggers the xfer.
Finally, I find out that UART was in sleep mode.
According to omap's reference manual, it enters this mode when conditions are met:
rx line is idle,
tx fifo and shift register are empty,
rx fifo is empty
no interrupts pending

One solution that i've tested successfully is to disable sleep mode in rt_16550_open(). TX interrupts are then being triggered as expected.
> 
>> > 
>> > Would you have an explanation for such a behavior?
>> > I'm not sure how to solve this.
> Depending on the hardware/uart revision, you may need to take care of
> other quirks, see:
> 
> http://lxr.linux.no/#linux+v3.2.1/arch/arm/mach-omap2/serial.c#L742
Thank you for this link! It helps handle the fifo full condition.
However, I noticed a strange value regarding version register. My omap3530 reports 0x46?
Linux serial driver assume this bug is present on revision >= 0x52 ...
But my target freeze when I send more than 16 chars at once (Fifo full without errata handling).
It works when using errata handling.
> 
> Wolfgang.
> 

You'll find attached a patch that works for me.
Please advise. Maybe we can enhance it and push it?

Thanks!
Regards,

Fabrice

--------------040406040700060005070200
Content-Type: text/x-patch;
 name="0001-add-omap3-and-omap4-uart-support-to-xeno_16550A.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-add-omap3-and-omap4-uart-support-to-xeno_16550A.patch"

>From 7245af5003d4fa79823b85d982e975a0c9dc363d Mon Sep 17 00:00:00 2001
From: Fabrice Gasnier <fabrice.gasnier@domain.hid>
Date: Thu, 19 Jan 2012 17:58:58 +0100
Subject: [PATCH] add omap3 and omap4 uart support to xeno_16550A

Add regshift module parameter.
Add omap specific "fifo full" errata handling from linux-3.2 omap-serial

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@domain.hid>
---
 ksrc/drivers/serial/16550A.c    |  130 +++++++++++++++++++++++++------------
 ksrc/drivers/serial/16550A_io.h |  136 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 219 insertions(+), 47 deletions(-)

diff --git a/ksrc/drivers/serial/16550A.c b/ksrc/drivers/serial/16550A.c
index 3672539..81c7b70 100644
--- a/ksrc/drivers/serial/16550A.c
+++ b/ksrc/drivers/serial/16550A.c
@@ -70,6 +70,23 @@
 #define LSR			5	/* Line Status Register */
 #define MSR			6	/* Modem Status Register */
 
+#if defined (CONFIG_ARCH_OMAP3) || \
+	defined (CONFIG_ARCH_OMAP4)
+#define OMAP_SCR	0x10	/* Supplementary control register */
+#define OMAP_MVR	0x14	/* Module Version Register */
+#define OMAP_SYSC	0x15	/* System configuration register */
+#define OMAP_WER	0x17	/* Wake-up enable register */
+#define REGION_MAX	OMAP_WER	/* end of io/memory region */
+
+#define LCR_CONF_MODE_A		LCR_DLAB	/* Configutation mode A */
+#define LCR_CONF_MODE_B		0xBF		/* Configutation mode B */
+#define EFR					2			/* Enhanced feature register (when LCR_CONF_MODE_B) */
+#define EFR_ECB				0x10 		/* Enhanced control bit */
+#define IERX_SLEEP			0x10 		/* Enable sleep mode */
+#else
+#define REGION_MAX			MSR			/* end of io/memory region   */
+#endif
+
 struct rt_16550_context {
 	struct rtser_config config;	/* current device configuration */
 
@@ -80,6 +97,8 @@ struct rt_16550_context {
 #ifdef CONFIG_XENO_DRIVERS_16550A_ANY
 	int io_mode;			/* hardware IO-access mode */
 #endif
+	unsigned char regshift;		/* register shift */
+
 	int tx_fifo;			/* cached global tx_fifo[<device>] */
 
 	int in_head;			/* RX ring buffer, head pointer */
@@ -149,13 +168,14 @@ static inline int rt_16550_rx_interrupt(struct rt_16550_context *ctx,
 					uint64_t * timestamp)
 {
 	unsigned long base = ctx->base_addr;
+	unsigned char regshift = ctx->regshift;
 	int mode = rt_16550_io_mode_from_ctx(ctx);
 	int rbytes = 0;
 	int lsr = 0;
 	int c;
 
 	do {
-		c = rt_16550_reg_in(mode, base, RHR);	/* read input char */
+		c = rt_16550_reg_in(mode, base, regshift, RHR);	/* read input char */
 
 		ctx->in_buf[ctx->in_tail] = c;
 		if (ctx->in_history)
@@ -169,7 +189,7 @@ static inline int rt_16550_rx_interrupt(struct rt_16550_context *ctx,
 
 		rbytes++;
 		lsr &= ~RTSER_LSR_DATA;
-		lsr |= (rt_16550_reg_in(mode, base, LSR) &
+		lsr |= (rt_16550_reg_in(mode, base, regshift, LSR) &
 			(RTSER_LSR_DATA | RTSER_LSR_OVERRUN_ERR |
 			 RTSER_LSR_PARITY_ERR | RTSER_LSR_FRAMING_ERR |
 			 RTSER_LSR_BREAK_IND));
@@ -196,6 +216,7 @@ static inline void rt_16550_tx_interrupt(struct rt_16550_context *ctx)
 	int c;
 	int count;
 	unsigned long base = ctx->base_addr;
+	unsigned char regshift = ctx->regshift;
 	int mode = rt_16550_io_mode_from_ctx(ctx);
 
 /*	if (uart->modem & MSR_CTS)*/
@@ -204,7 +225,7 @@ static inline void rt_16550_tx_interrupt(struct rt_16550_context *ctx)
 		     (count > 0) && (ctx->out_npend > 0);
 		     count--, ctx->out_npend--) {
 			c = ctx->out_buf[ctx->out_head++];
-			rt_16550_reg_out(mode, base, THR, c);
+			rt_16550_reg_out(mode, base, regshift, THR, c);
 			ctx->out_head &= (OUT_BUFFER_SIZE - 1);
 		}
 	}
@@ -213,9 +234,10 @@ static inline void rt_16550_tx_interrupt(struct rt_16550_context *ctx)
 static inline void rt_16550_stat_interrupt(struct rt_16550_context *ctx)
 {
 	unsigned long base = ctx->base_addr;
+	unsigned char regshift = ctx->regshift;
 	int mode = rt_16550_io_mode_from_ctx(ctx);
 
-	ctx->status |= (rt_16550_reg_in(mode, base, LSR) &
+	ctx->status |= (rt_16550_reg_in(mode, base, regshift, LSR) &
 			(RTSER_LSR_OVERRUN_ERR | RTSER_LSR_PARITY_ERR |
 			 RTSER_LSR_FRAMING_ERR | RTSER_LSR_BREAK_IND));
 }
@@ -224,6 +246,7 @@ static int rt_16550_interrupt(rtdm_irq_t * irq_context)
 {
 	struct rt_16550_context *ctx;
 	unsigned long base;
+	unsigned char regshift;
 	int mode;
 	int iir;
 	uint64_t timestamp = rtdm_clock_read();
@@ -234,12 +257,13 @@ static int rt_16550_interrupt(rtdm_irq_t * irq_context)
 
 	ctx = rtdm_irq_get_arg(irq_context, struct rt_16550_context);
 	base = ctx->base_addr;
+	regshift = ctx->regshift;
 	mode = rt_16550_io_mode_from_ctx(ctx);
 
 	rtdm_lock_get(&ctx->lock);
 
 	while (1) {
-		iir = rt_16550_reg_in(mode, base, IIR) & IIR_MASK;
+		iir = rt_16550_reg_in(mode, base, regshift, IIR) & IIR_MASK;
 		if (testbits(iir, IIR_PIRQ))
 			break;
 
@@ -251,7 +275,7 @@ static int rt_16550_interrupt(rtdm_irq_t * irq_context)
 		else if (iir == IIR_TX)
 			rt_16550_tx_interrupt(ctx);
 		else if (iir == IIR_MODEM) {
-			modem = rt_16550_reg_in(mode, base, MSR);
+			modem = rt_16550_reg_in(mode, base, regshift, MSR);
 			if (modem & (modem << 4))
 				events |= RTSER_EVENT_MODEMHI;
 			if ((modem ^ 0xF0) & (modem << 4))
@@ -292,7 +316,7 @@ static int rt_16550_interrupt(rtdm_irq_t * irq_context)
 	}
 
 	/* update interrupt mask */
-	rt_16550_reg_out(mode, base, IER, ctx->ier_status);
+	rt_16550_reg_out(mode, base, regshift, IER, ctx->ier_status);
 
 	rtdm_lock_put(&ctx->lock);
 
@@ -305,6 +329,7 @@ static int rt_16550_set_config(struct rt_16550_context *ctx,
 {
 	rtdm_lockctx_t lock_ctx;
 	unsigned long base = ctx->base_addr;
+	unsigned char regshift = ctx->regshift;
 	int mode = rt_16550_io_mode_from_ctx(ctx);
 	int err = 0;
 
@@ -320,9 +345,9 @@ static int rt_16550_set_config(struct rt_16550_context *ctx,
 		ctx->config.baud_rate = config->baud_rate;
 		baud_div = (baud_base[dev_id] + (ctx->config.baud_rate>>1)) /
 			ctx->config.baud_rate;
-		rt_16550_reg_out(mode, base, LCR, LCR_DLAB);
-		rt_16550_reg_out(mode, base, DLL, baud_div & 0xff);
-		rt_16550_reg_out(mode, base, DLM, baud_div >> 8);
+		rt_16550_reg_out(mode, base, regshift, LCR, LCR_DLAB);
+		rt_16550_reg_out(mode, base, regshift, DLL, baud_div & 0xff);
+		rt_16550_reg_out(mode, base, regshift, DLM, baud_div >> 8);
 	}
 
 	if (testbits(config->config_mask, RTSER_SET_PARITY))
@@ -336,7 +361,7 @@ static int rt_16550_set_config(struct rt_16550_context *ctx,
 					  RTSER_SET_DATA_BITS |
 					  RTSER_SET_STOP_BITS |
 					  RTSER_SET_BAUD)) {
-		rt_16550_reg_out(mode, base, LCR,
+		rt_16550_reg_out(mode, base, regshift, LCR,
 				 (ctx->config.parity << 3) |
 				 (ctx->config.stop_bits << 2) |
 				 ctx->config.data_bits);
@@ -346,9 +371,9 @@ static int rt_16550_set_config(struct rt_16550_context *ctx,
 
 	if (testbits(config->config_mask, RTSER_SET_FIFO_DEPTH)) {
 		ctx->config.fifo_depth = config->fifo_depth & FIFO_MASK;
-		rt_16550_reg_out(mode, base, FCR,
+		rt_16550_reg_out(mode, base, regshift, FCR,
 				 FCR_FIFO | FCR_RESET_RX | FCR_RESET_TX);
-		rt_16550_reg_out(mode, base, FCR,
+		rt_16550_reg_out(mode, base, regshift, FCR,
 				 FCR_FIFO | ctx->config.fifo_depth);
 	}
 
@@ -405,7 +430,7 @@ static int rt_16550_set_config(struct rt_16550_context *ctx,
 		else
 			/* disable modem status interrupt */
 			ctx->ier_status &= ~IER_MODEM;
-		rt_16550_reg_out(mode, base, IER, ctx->ier_status);
+		rt_16550_reg_out(mode, base, regshift, IER, ctx->ier_status);
 
 		rtdm_lock_put_irqrestore(&ctx->lock, lock_ctx);
 	}
@@ -425,7 +450,7 @@ static int rt_16550_set_config(struct rt_16550_context *ctx,
 			    RTSER_MCR_DTR | RTSER_MCR_RTS | RTSER_MCR_OUT2;
 			break;
 		}
-		rt_16550_reg_out(mode, base, MCR, ctx->mcr_status);
+		rt_16550_reg_out(mode, base, regshift, MCR, ctx->mcr_status);
 
 		rtdm_lock_put_irqrestore(&ctx->lock, lock_ctx);
 	}
@@ -449,6 +474,10 @@ int rt_16550_open(struct rtdm_dev_context *context,
 	int err;
 	uint64_t *dummy;
 	rtdm_lockctx_t lock_ctx;
+#if defined (CONFIG_ARCH_OMAP3) || \
+	defined (CONFIG_ARCH_OMAP4)
+	int ier;
+#endif
 
 	ctx = (struct rt_16550_context *)context->dev_private;
 
@@ -487,19 +516,28 @@ int rt_16550_open(struct rtdm_dev_context *context,
 	if (err) {
 		/* reset DTR and RTS */
 		rt_16550_reg_out(rt_16550_io_mode_from_ctx(ctx), ctx->base_addr,
-				 MCR, 0);
+				 ctx->regshift, MCR, 0);
 
 		rt_16550_cleanup_ctx(ctx);
 
 		return err;
 	}
 
+#if defined (CONFIG_ARCH_OMAP3) || \
+	defined (CONFIG_ARCH_OMAP4)
+	ier = rt_16550_reg_in(rt_16550_io_mode_from_ctx(ctx),
+			ctx->base_addr, ctx->regshift, IER);
+	if (ier & IERX_SLEEP)
+		rt_16550_disable_sleep(rt_16550_io_mode_from_ctx(ctx), ctx->base_addr,
+				ctx->regshift);
+#endif
+
 	rtdm_lock_get_irqsave(&ctx->lock, lock_ctx);
 
 	/* enable interrupts */
 	ctx->ier_status = IER_RX;
-	rt_16550_reg_out(rt_16550_io_mode_from_ctx(ctx), ctx->base_addr, IER,
-			 IER_RX);
+	rt_16550_reg_out(rt_16550_io_mode_from_ctx(ctx), ctx->base_addr,
+			 ctx->regshift, IER, IER_RX);
 
 	rtdm_lock_put_irqrestore(&ctx->lock, lock_ctx);
 
@@ -511,25 +549,27 @@ int rt_16550_close(struct rtdm_dev_context *context,
 {
 	struct rt_16550_context *ctx;
 	unsigned long base;
+	unsigned char regshift;
 	int mode;
 	uint64_t *in_history;
 	rtdm_lockctx_t lock_ctx;
 
 	ctx = (struct rt_16550_context *)context->dev_private;
 	base = ctx->base_addr;
+	regshift = ctx->regshift;
 	mode = rt_16550_io_mode_from_ctx(ctx);
 
 	rtdm_lock_get_irqsave(&ctx->lock, lock_ctx);
 
 	/* reset DTR and RTS */
-	rt_16550_reg_out(mode, base, MCR, 0);
+	rt_16550_reg_out(mode, base, regshift, MCR, 0);
 
 	/* mask all UART interrupts and clear pending ones. */
-	rt_16550_reg_out(mode, base, IER, 0);
-	rt_16550_reg_in(mode, base, IIR);
-	rt_16550_reg_in(mode, base, LSR);
-	rt_16550_reg_in(mode, base, RHR);
-	rt_16550_reg_in(mode, base, MSR);
+	rt_16550_reg_out(mode, base, regshift, IER, 0);
+	rt_16550_reg_in(mode, base, regshift, IIR);
+	rt_16550_reg_in(mode, base, regshift, LSR);
+	rt_16550_reg_in(mode, base, regshift, RHR);
+	rt_16550_reg_in(mode, base, regshift, MSR);
 
 	in_history = ctx->in_history;
 	ctx->in_history = NULL;
@@ -553,10 +593,12 @@ int rt_16550_ioctl(struct rtdm_dev_context *context,
 	struct rt_16550_context *ctx;
 	int err = 0;
 	unsigned long base;
+	unsigned char regshift;
 	int mode;
 
 	ctx = (struct rt_16550_context *)context->dev_private;
 	base = ctx->base_addr;
+	regshift = ctx->regshift;
 	mode = rt_16550_io_mode_from_ctx(ctx);
 
 	switch (request) {
@@ -638,9 +680,9 @@ int rt_16550_ioctl(struct rtdm_dev_context *context,
 			struct rtser_status status_buf;
 
 			status_buf.line_status =
-			    rt_16550_reg_in(mode, base, LSR) | status;
+			    rt_16550_reg_in(mode, base, regshift, LSR) | status;
 			status_buf.modem_status =
-			    rt_16550_reg_in(mode, base, MSR);
+			    rt_16550_reg_in(mode, base, regshift, MSR);
 
 			err =
 			    rtdm_safe_copy_to_user(user_info, arg,
@@ -649,9 +691,9 @@ int rt_16550_ioctl(struct rtdm_dev_context *context,
 							  rtser_status));
 		} else {
 			((struct rtser_status *)arg)->line_status =
-			    rt_16550_reg_in(mode, base, LSR) | status;
+			    rt_16550_reg_in(mode, base, regshift, LSR) | status;
 			((struct rtser_status *)arg)->modem_status =
-			    rt_16550_reg_in(mode, base, MSR);
+			    rt_16550_reg_in(mode, base, regshift, MSR);
 		}
 		break;
 	}
@@ -672,7 +714,7 @@ int rt_16550_ioctl(struct rtdm_dev_context *context,
 
 		rtdm_lock_get_irqsave(&ctx->lock, lock_ctx);
 		ctx->mcr_status = new_mcr;
-		rt_16550_reg_out(mode, base, MCR, new_mcr);
+		rt_16550_reg_out(mode, base, regshift, MCR, new_mcr);
 		rtdm_lock_put_irqrestore(&ctx->lock, lock_ctx);
 		break;
 	}
@@ -698,7 +740,7 @@ int rt_16550_ioctl(struct rtdm_dev_context *context,
 			if (testbits(ctx->config.event_mask,
 				     RTSER_EVENT_ERRPEND)) {
 				ctx->ier_status |= IER_STAT;
-				rt_16550_reg_out(mode, base, IER,
+				rt_16550_reg_out(mode, base, regshift, IER,
 						 ctx->ier_status);
 			}
 
@@ -752,7 +794,7 @@ int rt_16550_ioctl(struct rtdm_dev_context *context,
 		    (ctx->config.parity << 3) | (ctx->config.stop_bits << 2) |
 		    ctx->config.data_bits;
 
-		rt_16550_reg_out(mode, base, LCR, lcr);
+		rt_16550_reg_out(mode, base, regshift, LCR, lcr);
 
 		rtdm_lock_put_irqrestore(&ctx->lock, lock_ctx);
 		break;
@@ -768,7 +810,7 @@ int rt_16550_ioctl(struct rtdm_dev_context *context,
 			ctx->in_npend = 0;
 			ctx->status = 0;
 			fcr |= FCR_FIFO | FCR_RESET_RX;
-			rt_16550_reg_in(mode, base, RHR);
+			rt_16550_reg_in(mode, base, regshift, RHR);
 		}
 		if ((long)arg & RTDM_PURGE_TX_BUFFER) {
 			ctx->out_head = 0;
@@ -777,8 +819,8 @@ int rt_16550_ioctl(struct rtdm_dev_context *context,
 			fcr |= FCR_FIFO | FCR_RESET_TX;
 		}
 		if (fcr) {
-			rt_16550_reg_out(mode, base, FCR, fcr);
-			rt_16550_reg_out(mode, base, FCR,
+			rt_16550_reg_out(mode, base, regshift, FCR, fcr);
+			rt_16550_reg_out(mode, base, regshift, FCR,
 					 FCR_FIFO | ctx->config.fifo_depth);
 		}
 		rtdm_lock_put_irqrestore(&ctx->lock, lock_ctx);
@@ -831,8 +873,8 @@ ssize_t rt_16550_read(struct rtdm_dev_context * context,
 		if (!testbits(ctx->ier_status, IER_STAT)) {
 			ctx->ier_status |= IER_STAT;
 			rt_16550_reg_out(rt_16550_io_mode_from_ctx(ctx),
-					 ctx->base_addr, IER,
-					 ctx->ier_status);
+					 ctx->base_addr, ctx->regshift,
+					 IER, ctx->ier_status);
 		}
 
 		if (ctx->status) {
@@ -1046,8 +1088,8 @@ ssize_t rt_16550_write(struct rtdm_dev_context * context,
 			/* unmask tx interrupt */
 			ctx->ier_status |= IER_TX;
 			rt_16550_reg_out(rt_16550_io_mode_from_ctx(ctx),
-					 ctx->base_addr, IER,
-					 ctx->ier_status);
+					 ctx->base_addr, ctx->regshift,
+					 IER, ctx->ier_status);
 
 			rtdm_lock_put_irqrestore(&ctx->lock, lock_ctx);
 			continue;
@@ -1117,6 +1159,7 @@ int __init rt_16550_init(void)
 {
 	struct rtdm_device *dev;
 	unsigned long base;
+	unsigned char regshift;
 	int mode;
 	int err;
 	int i;
@@ -1157,11 +1200,12 @@ int __init rt_16550_init(void)
 		/* Mask all UART interrupts and clear pending ones. */
 		base = rt_16550_base_addr(i);
 		mode = rt_16550_io_mode(i);
-		rt_16550_reg_out(mode, base, IER, 0);
-		rt_16550_reg_in(mode, base, IIR);
-		rt_16550_reg_in(mode, base, LSR);
-		rt_16550_reg_in(mode, base, RHR);
-		rt_16550_reg_in(mode, base, MSR);
+		regshift = rt_16550_regshift(i);
+		rt_16550_reg_out(mode, base, regshift, IER, 0);
+		rt_16550_reg_in(mode, base, regshift, IIR);
+		rt_16550_reg_in(mode, base, regshift, LSR);
+		rt_16550_reg_in(mode, base, regshift, RHR);
+		rt_16550_reg_in(mode, base, regshift, MSR);
 
 		err = rtdm_dev_register(dev);
 
diff --git a/ksrc/drivers/serial/16550A_io.h b/ksrc/drivers/serial/16550A_io.h
index 92d21a5..c42bdba 100644
--- a/ksrc/drivers/serial/16550A_io.h
+++ b/ksrc/drivers/serial/16550A_io.h
@@ -31,15 +31,25 @@ MODULE_PARM_DESC(io, "I/O port addresses of the serial devices");
     defined(CONFIG_XENO_DRIVERS_16550A_ANY)
 static unsigned long mem[MAX_DEVICES];
 static void *mapped_io[MAX_DEVICES];
+static unsigned char regshift[MAX_DEVICES];
 compat_module_param_array(mem, ulong, MAX_DEVICES, 0400);
+compat_module_param_array(regshift, byte, MAX_DEVICES, 0400);
 MODULE_PARM_DESC(mem, "I/O memory addresses of the serial devices");
+MODULE_PARM_DESC(regshift, "register shift (ex: on some omap, use regshift=2)");
 #endif /* CONFIG_XENO_DRIVERS_16550A_MMIO || CONFIG_XENO_DRIVERS_16550A_ANY */
 
+#if defined (CONFIG_ARCH_OMAP3) || \
+	defined (CONFIG_ARCH_OMAP4)
+#define UART_OMAP_NO_EMPTY_FIFO_READ_IP_REV     0x46
+#define UART_ERRATA_FIFO_FULL_ABORT     		(0x1 << 0)
+#endif
+
 #ifdef CONFIG_XENO_DRIVERS_16550A_PIO
 
 #define RT_16550_IO_INLINE inline
 
 extern void *mapped_io[]; /* dummy */
+static unsigned char regshift[]; /* dummy */
 
 static inline unsigned long rt_16550_addr_param(int dev_id)
 {
@@ -61,6 +71,11 @@ static inline io_mode_t rt_16550_io_mode(int dev_id)
 	return MODE_PIO;
 }
 
+static inline unsigned char rt_16550_regshift(int dev_id)
+{
+	return 0;
+}
+
 static inline io_mode_t
 rt_16550_io_mode_from_ctx(struct rt_16550_context *ctx)
 {
@@ -99,6 +114,11 @@ static inline io_mode_t rt_16550_io_mode(int dev_id)
 	return MODE_MMIO;
 }
 
+static inline unsigned char rt_16550_regshift(int dev_id)
+{
+	return (unsigned char)regshift[dev_id];
+}
+
 static inline io_mode_t
 rt_16550_io_mode_from_ctx(struct rt_16550_context *ctx)
 {
@@ -109,6 +129,7 @@ static inline void
 rt_16550_init_io_ctx(int dev_id, struct rt_16550_context *ctx)
 {
 	ctx->base_addr = (unsigned long)mapped_io[dev_id];
+	ctx->regshift = (unsigned char)regshift[dev_id];
 }
 
 #elif defined(CONFIG_XENO_DRIVERS_16550A_ANY)
@@ -135,6 +156,11 @@ static inline io_mode_t rt_16550_io_mode(int dev_id)
 	return (io[dev_id]) ? MODE_PIO : MODE_MMIO;
 }
 
+static inline unsigned char rt_16550_regshift(int dev_id)
+{
+	return (io[dev_id]) ? 0 : (unsigned char)regshift[dev_id];
+}
+
 static inline io_mode_t
 rt_16550_io_mode_from_ctx(struct rt_16550_context *ctx)
 {
@@ -151,15 +177,115 @@ rt_16550_init_io_ctx(int dev_id, struct rt_16550_context *ctx)
 		ctx->base_addr = (unsigned long)mapped_io[dev_id];
 		ctx->io_mode   = MODE_MMIO;
 	}
+	ctx->regshift = (unsigned char)regshift[dev_id];
 }
 
 #else
 # error Unsupported I/O access method
 #endif
 
+
+#if defined (CONFIG_ARCH_OMAP3) || \
+	defined (CONFIG_ARCH_OMAP4)
+
+static RT_16550_IO_INLINE u8
+rt_16550_omap_raw_reg_in(io_mode_t io_mode, unsigned long base, unsigned char rshift, int off)
+{
+	off <<= rshift;	/* regshift */
+	switch (io_mode) {
+	case MODE_PIO:
+		return inb(base + off);
+	default: /* MODE_MMIO */
+		return readb((void *)base + off);
+	}
+}
+
+static RT_16550_IO_INLINE void
+rt_16550_omap_raw_reg_out(io_mode_t io_mode, unsigned long base, unsigned char rshift, int off, u8 val)
+{
+	off <<= rshift;	/* regshift */
+	switch (io_mode) {
+	case MODE_PIO:
+		outb(val, base + off);
+		break;
+	case MODE_MMIO:
+		writeb(val, (void *)base + off);
+		break;
+	}
+}
+
+static RT_16550_IO_INLINE int
+rt_16550_errata(io_mode_t io_mode, unsigned long base, unsigned char rshift)
+{
+	int errata = 0, rev;
+	/*
+	 * omap44xx, ti816x: Never read empty UART fifo
+	 * omap3xxx: Never read empty UART fifo on UARTs
+	 * with IP rev >=0x46
+	 */
+	if (cpu_is_omap44xx() /* FIXME: || cpu_is_ti816x() */)
+		errata |= UART_ERRATA_FIFO_FULL_ABORT;
+	else if ((rev = rt_16550_omap_raw_reg_in(io_mode, base, rshift, OMAP_MVR)) >= UART_OMAP_NO_EMPTY_FIFO_READ_IP_REV)
+		errata |= UART_ERRATA_FIFO_FULL_ABORT;
+
+	return errata;
+}
+
+static RT_16550_IO_INLINE void
+rt_16550_disable_sleep(io_mode_t io_mode, unsigned long base, unsigned char rshift)
+{
+	unsigned char lcr, efr, ier;
+
+	lcr = rt_16550_omap_raw_reg_in(io_mode, base, rshift, LCR);
+	rt_16550_omap_raw_reg_out(io_mode, base, rshift, LCR, LCR_CONF_MODE_B);
+	efr = rt_16550_omap_raw_reg_in(io_mode, base, rshift, EFR);
+	rt_16550_omap_raw_reg_out(io_mode, base, rshift, EFR, EFR_ECB);
+	rt_16550_omap_raw_reg_out(io_mode, base, rshift, LCR, 0x0); /* Operational mode */
+	ier = rt_16550_omap_raw_reg_in(io_mode, base, rshift, IER);
+	ier &= ~IERX_SLEEP;	/* disable sleep */
+	rt_16550_omap_raw_reg_out(io_mode, base, rshift, IER, ier);
+	rt_16550_omap_raw_reg_out(io_mode, base, rshift, LCR, LCR_CONF_MODE_B);
+	rt_16550_omap_raw_reg_out(io_mode, base, rshift, EFR, efr);
+	rt_16550_omap_raw_reg_out(io_mode, base, rshift, LCR, lcr);
+}
+
+static RT_16550_IO_INLINE u8
+rt_16550_reg_in(io_mode_t io_mode, unsigned long base, unsigned char rshift, int off)
+{
+	if (rt_16550_errata(io_mode, base, rshift)) {
+		if (RHR == off) {
+			unsigned char lsr;
+			lsr = rt_16550_omap_raw_reg_in(io_mode, base, rshift, LSR);
+			if (!(lsr & RTSER_LSR_DATA)) /* Receiver data ready */
+				return 0; /* FIXME: -EPERM should be returned as error */
+		}
+	}
+	return rt_16550_omap_raw_reg_in(io_mode, base, rshift, off);
+}
+
+static RT_16550_IO_INLINE void
+rt_16550_reg_out(io_mode_t io_mode, unsigned long base, unsigned char rshift, int off, u8 val)
+{
+	if (rt_16550_errata(io_mode, base, rshift)) {
+		unsigned char lsr;
+		unsigned int tmout=10000;
+		lsr = rt_16550_omap_raw_reg_in(io_mode, base, rshift, LSR);
+		while (!(lsr & RTSER_LSR_THR_EMTPY)) {
+			/* Wait up to 10ms for the character(s) to be sent. */
+			if(--tmout == 0)
+				break;
+			rtdm_task_sleep(1000);
+			lsr = rt_16550_omap_raw_reg_in(io_mode, base, rshift, LSR);
+		}
+	}
+	rt_16550_omap_raw_reg_out(io_mode, base, rshift, off, val);
+}
+
+#else
 static RT_16550_IO_INLINE u8
-rt_16550_reg_in(io_mode_t io_mode, unsigned long base, int off)
+rt_16550_reg_in(io_mode_t io_mode, unsigned long base, unsigned char rshift, int off)
 {
+	off <<= rshift;	/* regshift */
 	switch (io_mode) {
 	case MODE_PIO:
 		return inb(base + off);
@@ -169,8 +295,9 @@ rt_16550_reg_in(io_mode_t io_mode, unsigned long base, int off)
 }
 
 static RT_16550_IO_INLINE void
-rt_16550_reg_out(io_mode_t io_mode, unsigned long base, int off, u8 val)
+rt_16550_reg_out(io_mode_t io_mode, unsigned long base, unsigned char rshift, int off, u8 val)
 {
+	off <<= rshift;	/* regshift */
 	switch (io_mode) {
 	case MODE_PIO:
 		outb(val, base + off);
@@ -180,16 +307,17 @@ rt_16550_reg_out(io_mode_t io_mode, unsigned long base, int off, u8 val)
 		break;
 	}
 }
+#endif //CONFIG_ARCH_OMAP3/4
 
 static int rt_16550_init_io(int dev_id, char* name)
 {
 	switch (rt_16550_io_mode(dev_id)) {
 	case MODE_PIO:
-		if (!request_region(rt_16550_addr_param(dev_id), 8, name))
+		if (!request_region(rt_16550_addr_param(dev_id), REGION_MAX, name))
 			return -EBUSY;
 		break;
 	case MODE_MMIO:
-		mapped_io[dev_id] = ioremap(rt_16550_addr_param(dev_id), 8);
+		mapped_io[dev_id] = ioremap(rt_16550_addr_param(dev_id), REGION_MAX << regshift[dev_id]);
 		if (!mapped_io[dev_id])
 			return -EBUSY;
 		break;
-- 
1.7.0.4


--------------040406040700060005070200--

