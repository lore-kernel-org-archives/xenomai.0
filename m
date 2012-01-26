Message-ID: <4F2128F5.8020203@domain.hid>
Date: Thu, 26 Jan 2012 11:20:37 +0100
From: Fabrice Gasnier <fabrice.gasnier@domain.hid>
MIME-Version: 1.0
References: <4F1080E8.6020408@domain.hid>	<4F1082E5.8000501@domain.hid>	<4F132A7E.4000000@domain.hid>	<4F16F028.6020507@domain.hid>
	<4F16F401.2090308@domain.hid>	<4F184E42.6060300@domain.hid>
	<4F19AC80.5010106@domain.hid> <4F19B676.5020403@domain.hid>
	<4F19BAB4.5050204@domain.hid>
In-Reply-To: <4F19BAB4.5050204@domain.hid>
Content-Type: multipart/mixed; boundary="------------080205000304090803000306"
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
--------------080205000304090803000306
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi all,
I've been busy trying to clarify few things discussed here.
Please find attached a re-worked patch and comments interleaved here after.
Thank you very much for your help!
Regards,

Fabrice

On 20/01/2012 20:04, Wolfgang Grandegger wrote:
> On 01/20/2012 07:46 PM, Gilles Chanteperdrix wrote:
>> On 01/20/2012 07:03 PM, Wolfgang Grandegger wrote:
>>> Hi Fabrice and Manfred,
>>>
>>> On 01/19/2012 06:09 PM, Fabrice Gasnier wrote:
>>>> On 18/01/2012 17:32, Wolfgang Grandegger wrote:
>>>>>> Further investigation indicates that when writing, tx interrupt is not asserted as expected (rt_16550_write):
>>>>>>> /* unmask tx interrupt */
>>>>>>> ctx->ier_status |= IER_TX;
>>>>>>> rt_16550_reg_out(rt_16550_io_mode_from_ctx(ctx),
>>>>>>> 		 ctx->base_addr, IER,
>>>>>>> 		 ctx->ier_status,
>>>>>>> 		 ctx->regshift);
>>>>>>>
>>>>>>> >From my understanding this should trigger an irq for data to be put in rt_16550_tx_interrupt().
>>>>>>> It seems this is not always the case. Moreover, TX interrupt seem to be triggered by a new RX interrupt.
>>>>> The TX interrupt will be enabled as long as there are chars to send,
>>>>> IIRC. The isr the puts the chars into the FIFO and triggers the xfer.
>>>> Finally, I find out that UART was in sleep mode.
>>>> According to omap's reference manual, it enters this mode when conditions are met:
>>>> rx line is idle,
>>>> tx fifo and shift register are empty,
>>>> rx fifo is empty
>>>> no interrupts pending
>>>>
>>>> One solution that i've tested successfully is to disable sleep mode in rt_16550_open(). TX interrupts are then being triggered as expected.
Disable sleep seems definitely required (at least on my omap target):
int rt_16550_open( ... ) {
...
	/* disable sleep mode */
	rt_16550_disable_sleep(ctx);
...
}
>>>>>
>>>>>>>
>>>>>>> Would you have an explanation for such a behavior?
>>>>>>> I'm not sure how to solve this.
>>>>> Depending on the hardware/uart revision, you may need to take care of
>>>>> other quirks, see:
>>>>>
>>>>> http://lxr.linux.no/#linux+v3.2.1/arch/arm/mach-omap2/serial.c#L742
>>>> Thank you for this link! It helps handle the fifo full condition.
>>>> However, I noticed a strange value regarding version register. My omap3530 reports 0x46?
>>>> Linux serial driver assume this bug is present on revision >= 0x52 ...
>>>> But my target freeze when I send more than 16 chars at once (Fifo full without errata handling).
I finally found out the cause was not as I thought it was.
I'm running a small test program that write data to serial and exits after closing the device using rt_dev_close.
I figured out that closing dev immediately after write makes the driver not to flush all data!
When closing the device, interrupts are disabled without waiting for fifo to empty.
I also made some testing on another (x86) platform to be sure: behavior is identical.
Next time I open the port, target freeze (omap only).
So, I added a small routine to wait for data being sent when closing:

int rt_16550_close(...) {
...
	/* wait for fifo tx to be empty */
	rt_16550_wait_tx_end(ctx);
...
}

>>>> It works when using errata handling.

Further analysis of both xeno_16550A and omap-serial driver lead me to believe there is no need to use errata handling to write to TX fifo:
from omap-serial http://lxr.linux.no/#linux+v3.2.1/arch/arm/mach-omap2/serial.c#L620
 624        status = __serial_read_reg(up, UART_LSR);
 625        while (!(status & UART_LSR_THRE)) {
 626                /* Wait up to 10ms for the character(s) to be sent. */
 627                if (--tmout == 0)
 628                        break;
 629                udelay(1);
 630                status = __serial_read_reg(up, UART_LSR);
 631        }

from 16550A.c:
static inline void rt_16550_tx_interrupt(struct rt_16550_context *ctx)
...
for (count = ctx->tx_fifo;
	 (count > 0) && (ctx->out_npend > 0);
	 count--, ctx->out_npend--) {
	c = ctx->out_buf[ctx->out_head++];
	rt_16550_reg_out(mode, base, THR, c);
	ctx->out_head &= (OUT_BUFFER_SIZE - 1);
}

THR is only written in rt_16550_tx_interrupt. It's only triggered when tx fifo is empty.
So, I think there is no need to use linux driver method.
Moreover, I believe this makes the driver to push data byte-per-byte, instead of using fifo.
I removed it from my fisrt patch.

However, I cannot test this on an omap that should be impacted by errata as my uart revision is 0x46 ( < 0x52 ).
All of this is ok on my side.

@Manfred: maybe you can help, make some more tests ?
>>>
>>> It seems the 16550-compatible UARTs on the OMAP processor are special
>>> and also buggy requiring more or less heavy workarounds, unfortunately.
>>> I can't comment on that as I do not have experience with OMAP processors.
>>>
>>>> You'll find attached a patch that works for me.
>>>> Please advise. Maybe we can enhance it and push it?
>>>
>>> To handle hardware-specific initialization I/O properly, I think we need
>>> first a more flexible interface using callback functions. The existing
>>> interface with
>>>
>>> 	base = ctx->base_addr;
>>> 	mode = rt_16550_io_mode_from_ctx(ctx);
>>> 	regshift = ctx->regshift;
>>> 	rt_16550_reg_in(mode, base, regshift, offset)",
I reworked my patch to follow this guideline:

struct rt_16550_context {
...
	u8 (*rt_16550_reg_in)(struct rt_16550_context *, int);
	void (*rt_16550_reg_out)(struct rt_16550_context *, int, u8);
...
}
#define rt_16550_serial_in(ctx, offset) \
			(ctx->rt_16550_reg_in(ctx, offset))
#define rt_16550_serial_out(ctx, offset, value) \
			(ctx->rt_16550_reg_out(ctx, offset, value))
This is very close to :
http://lxr.linux.no/#linux+v3.2.1/drivers/tty/serial/8250.c#L519

>>>
>>> #ifdef's and switch statements in the I/O functions is really horrible.
>>> A more elegant solution would make integration of the OMAP specialities
>>> much easier.
Removed from all routines in 16550.c but these are still required in 16550_io.h
>>
>> I will wait for Wolfgang's ack before merging anything, then.
> 
> Well, I'm actually not the maintainer. Jan?
> 
> Wolfgang.
> 
> 
> 

--------------080205000304090803000306
Content-Type: text/x-patch;
 name="0001-Add-xeno_16550A-omap-support.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-Add-xeno_16550A-omap-support.patch"

>From bdb16585ee67e746c0f747dfb93a3d8193103594 Mon Sep 17 00:00:00 2001
From: Fabrice Gasnier <fabrice.gasnier@domain.hid>
Date: Thu, 26 Jan 2012 10:13:08 +0100
Subject: [PATCH] Add xeno_16550A omap support
 Add regshift module parameter.
 Add omap specific "fifo full" errata handling from linux-3.2 omap-serial
 Fix closing when tx fifo isn't empty
 Disable sleep mode on omap uart


Signed-off-by: Fabrice Gasnier <fabrice.gasnier@domain.hid>
---
 ksrc/drivers/serial/16550A.c    |  148 +++++++++++++++++---------------
 ksrc/drivers/serial/16550A_io.h |  184 ++++++++++++++++++++++++++++++++++++--
 2 files changed, 253 insertions(+), 79 deletions(-)

diff --git a/ksrc/drivers/serial/16550A.c b/ksrc/drivers/serial/16550A.c
index 3672539..945929e 100644
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
+#define EFR            		2			/* Enhanced feature register (when LCR_CONF_MODE_B) */
+#define EFR_ECB        		0x10 		/* Enhanced control bit */
+#define IERX_SLEEP     		0x10 		/* Enable sleep mode */
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
@@ -107,8 +126,16 @@ struct rt_16550_context {
 	int mcr_status;			/* MCR cache */
 	int status;			/* cache for LSR + soft-states */
 	int saved_errors;		/* error cache for RTIOC_GET_STATUS */
+
+	u8 (*rt_16550_reg_in)(struct rt_16550_context *, int);
+	void (*rt_16550_reg_out)(struct rt_16550_context *, int, u8);
 };
 
+#define rt_16550_serial_in(ctx, offset) \
+			(ctx->rt_16550_reg_in(ctx, offset))
+#define rt_16550_serial_out(ctx, offset, value) \
+			(ctx->rt_16550_reg_out(ctx, offset, value))
+
 static const struct rtser_config default_config = {
 	0xFFFF, RTSER_DEF_BAUD, RTSER_DEF_PARITY, RTSER_DEF_BITS,
 	RTSER_DEF_STOPB, RTSER_DEF_HAND, RTSER_DEF_FIFO_DEPTH, 0,
@@ -148,14 +175,12 @@ MODULE_AUTHOR("jan.kiszka@domain.hid");
 static inline int rt_16550_rx_interrupt(struct rt_16550_context *ctx,
 					uint64_t * timestamp)
 {
-	unsigned long base = ctx->base_addr;
-	int mode = rt_16550_io_mode_from_ctx(ctx);
 	int rbytes = 0;
 	int lsr = 0;
 	int c;
 
 	do {
-		c = rt_16550_reg_in(mode, base, RHR);	/* read input char */
+		c = rt_16550_serial_in(ctx, RHR);	/* read input char */
 
 		ctx->in_buf[ctx->in_tail] = c;
 		if (ctx->in_history)
@@ -169,7 +194,7 @@ static inline int rt_16550_rx_interrupt(struct rt_16550_context *ctx,
 
 		rbytes++;
 		lsr &= ~RTSER_LSR_DATA;
-		lsr |= (rt_16550_reg_in(mode, base, LSR) &
+		lsr |= (rt_16550_serial_in(ctx, LSR) &
 			(RTSER_LSR_DATA | RTSER_LSR_OVERRUN_ERR |
 			 RTSER_LSR_PARITY_ERR | RTSER_LSR_FRAMING_ERR |
 			 RTSER_LSR_BREAK_IND));
@@ -195,8 +220,6 @@ static inline void rt_16550_tx_interrupt(struct rt_16550_context *ctx)
 {
 	int c;
 	int count;
-	unsigned long base = ctx->base_addr;
-	int mode = rt_16550_io_mode_from_ctx(ctx);
 
 /*	if (uart->modem & MSR_CTS)*/
 	{
@@ -204,7 +227,7 @@ static inline void rt_16550_tx_interrupt(struct rt_16550_context *ctx)
 		     (count > 0) && (ctx->out_npend > 0);
 		     count--, ctx->out_npend--) {
 			c = ctx->out_buf[ctx->out_head++];
-			rt_16550_reg_out(mode, base, THR, c);
+			rt_16550_serial_out(ctx, THR, c);
 			ctx->out_head &= (OUT_BUFFER_SIZE - 1);
 		}
 	}
@@ -212,10 +235,7 @@ static inline void rt_16550_tx_interrupt(struct rt_16550_context *ctx)
 
 static inline void rt_16550_stat_interrupt(struct rt_16550_context *ctx)
 {
-	unsigned long base = ctx->base_addr;
-	int mode = rt_16550_io_mode_from_ctx(ctx);
-
-	ctx->status |= (rt_16550_reg_in(mode, base, LSR) &
+	ctx->status |= (rt_16550_serial_in(ctx, LSR) &
 			(RTSER_LSR_OVERRUN_ERR | RTSER_LSR_PARITY_ERR |
 			 RTSER_LSR_FRAMING_ERR | RTSER_LSR_BREAK_IND));
 }
@@ -223,8 +243,6 @@ static inline void rt_16550_stat_interrupt(struct rt_16550_context *ctx)
 static int rt_16550_interrupt(rtdm_irq_t * irq_context)
 {
 	struct rt_16550_context *ctx;
-	unsigned long base;
-	int mode;
 	int iir;
 	uint64_t timestamp = rtdm_clock_read();
 	int rbytes = 0;
@@ -233,13 +251,11 @@ static int rt_16550_interrupt(rtdm_irq_t * irq_context)
 	int ret = RTDM_IRQ_NONE;
 
 	ctx = rtdm_irq_get_arg(irq_context, struct rt_16550_context);
-	base = ctx->base_addr;
-	mode = rt_16550_io_mode_from_ctx(ctx);
 
 	rtdm_lock_get(&ctx->lock);
 
 	while (1) {
-		iir = rt_16550_reg_in(mode, base, IIR) & IIR_MASK;
+		iir = rt_16550_serial_in(ctx, IIR) & IIR_MASK;
 		if (testbits(iir, IIR_PIRQ))
 			break;
 
@@ -251,7 +267,7 @@ static int rt_16550_interrupt(rtdm_irq_t * irq_context)
 		else if (iir == IIR_TX)
 			rt_16550_tx_interrupt(ctx);
 		else if (iir == IIR_MODEM) {
-			modem = rt_16550_reg_in(mode, base, MSR);
+			modem = rt_16550_serial_in(ctx, MSR);
 			if (modem & (modem << 4))
 				events |= RTSER_EVENT_MODEMHI;
 			if ((modem ^ 0xF0) & (modem << 4))
@@ -292,7 +308,7 @@ static int rt_16550_interrupt(rtdm_irq_t * irq_context)
 	}
 
 	/* update interrupt mask */
-	rt_16550_reg_out(mode, base, IER, ctx->ier_status);
+	rt_16550_serial_out(ctx, IER, ctx->ier_status);
 
 	rtdm_lock_put(&ctx->lock);
 
@@ -304,8 +320,6 @@ static int rt_16550_set_config(struct rt_16550_context *ctx,
 			       uint64_t **in_history_ptr)
 {
 	rtdm_lockctx_t lock_ctx;
-	unsigned long base = ctx->base_addr;
-	int mode = rt_16550_io_mode_from_ctx(ctx);
 	int err = 0;
 
 	/* make line configuration atomic and IRQ-safe */
@@ -320,9 +334,9 @@ static int rt_16550_set_config(struct rt_16550_context *ctx,
 		ctx->config.baud_rate = config->baud_rate;
 		baud_div = (baud_base[dev_id] + (ctx->config.baud_rate>>1)) /
 			ctx->config.baud_rate;
-		rt_16550_reg_out(mode, base, LCR, LCR_DLAB);
-		rt_16550_reg_out(mode, base, DLL, baud_div & 0xff);
-		rt_16550_reg_out(mode, base, DLM, baud_div >> 8);
+		rt_16550_serial_out(ctx, LCR, LCR_DLAB);
+		rt_16550_serial_out(ctx, DLL, baud_div & 0xff);
+		rt_16550_serial_out(ctx, DLM, baud_div >> 8);
 	}
 
 	if (testbits(config->config_mask, RTSER_SET_PARITY))
@@ -336,7 +350,7 @@ static int rt_16550_set_config(struct rt_16550_context *ctx,
 					  RTSER_SET_DATA_BITS |
 					  RTSER_SET_STOP_BITS |
 					  RTSER_SET_BAUD)) {
-		rt_16550_reg_out(mode, base, LCR,
+		rt_16550_serial_out(ctx, LCR,
 				 (ctx->config.parity << 3) |
 				 (ctx->config.stop_bits << 2) |
 				 ctx->config.data_bits);
@@ -346,9 +360,9 @@ static int rt_16550_set_config(struct rt_16550_context *ctx,
 
 	if (testbits(config->config_mask, RTSER_SET_FIFO_DEPTH)) {
 		ctx->config.fifo_depth = config->fifo_depth & FIFO_MASK;
-		rt_16550_reg_out(mode, base, FCR,
+		rt_16550_serial_out(ctx, FCR,
 				 FCR_FIFO | FCR_RESET_RX | FCR_RESET_TX);
-		rt_16550_reg_out(mode, base, FCR,
+		rt_16550_serial_out(ctx, FCR,
 				 FCR_FIFO | ctx->config.fifo_depth);
 	}
 
@@ -405,7 +419,7 @@ static int rt_16550_set_config(struct rt_16550_context *ctx,
 		else
 			/* disable modem status interrupt */
 			ctx->ier_status &= ~IER_MODEM;
-		rt_16550_reg_out(mode, base, IER, ctx->ier_status);
+		rt_16550_serial_out(ctx, IER, ctx->ier_status);
 
 		rtdm_lock_put_irqrestore(&ctx->lock, lock_ctx);
 	}
@@ -425,7 +439,7 @@ static int rt_16550_set_config(struct rt_16550_context *ctx,
 			    RTSER_MCR_DTR | RTSER_MCR_RTS | RTSER_MCR_OUT2;
 			break;
 		}
-		rt_16550_reg_out(mode, base, MCR, ctx->mcr_status);
+		rt_16550_serial_out(ctx, MCR, ctx->mcr_status);
 
 		rtdm_lock_put_irqrestore(&ctx->lock, lock_ctx);
 	}
@@ -486,20 +500,21 @@ int rt_16550_open(struct rtdm_dev_context *context,
 			       context->device->proc_name, ctx);
 	if (err) {
 		/* reset DTR and RTS */
-		rt_16550_reg_out(rt_16550_io_mode_from_ctx(ctx), ctx->base_addr,
-				 MCR, 0);
+		rt_16550_serial_out(ctx, MCR, 0);
 
 		rt_16550_cleanup_ctx(ctx);
 
 		return err;
 	}
 
+	/* disable sleep mode */
+	rt_16550_disable_sleep(ctx);
+
 	rtdm_lock_get_irqsave(&ctx->lock, lock_ctx);
 
 	/* enable interrupts */
 	ctx->ier_status = IER_RX;
-	rt_16550_reg_out(rt_16550_io_mode_from_ctx(ctx), ctx->base_addr, IER,
-			 IER_RX);
+	rt_16550_serial_out(ctx, IER, IER_RX);
 
 	rtdm_lock_put_irqrestore(&ctx->lock, lock_ctx);
 
@@ -510,26 +525,25 @@ int rt_16550_close(struct rtdm_dev_context *context,
 		   rtdm_user_info_t * user_info)
 {
 	struct rt_16550_context *ctx;
-	unsigned long base;
-	int mode;
 	uint64_t *in_history;
 	rtdm_lockctx_t lock_ctx;
 
 	ctx = (struct rt_16550_context *)context->dev_private;
-	base = ctx->base_addr;
-	mode = rt_16550_io_mode_from_ctx(ctx);
+
+	/* wait for fifo tx to be empty */
+	rt_16550_wait_tx_end(ctx);
 
 	rtdm_lock_get_irqsave(&ctx->lock, lock_ctx);
 
 	/* reset DTR and RTS */
-	rt_16550_reg_out(mode, base, MCR, 0);
+	rt_16550_serial_out(ctx, MCR, 0);
 
 	/* mask all UART interrupts and clear pending ones. */
-	rt_16550_reg_out(mode, base, IER, 0);
-	rt_16550_reg_in(mode, base, IIR);
-	rt_16550_reg_in(mode, base, LSR);
-	rt_16550_reg_in(mode, base, RHR);
-	rt_16550_reg_in(mode, base, MSR);
+	rt_16550_serial_out(ctx, IER, 0);
+	rt_16550_serial_in(ctx, IIR);
+	rt_16550_serial_in(ctx, LSR);
+	rt_16550_serial_in(ctx, RHR);
+	rt_16550_serial_in(ctx, MSR);
 
 	in_history = ctx->in_history;
 	ctx->in_history = NULL;
@@ -552,12 +566,8 @@ int rt_16550_ioctl(struct rtdm_dev_context *context,
 	rtdm_lockctx_t lock_ctx;
 	struct rt_16550_context *ctx;
 	int err = 0;
-	unsigned long base;
-	int mode;
 
 	ctx = (struct rt_16550_context *)context->dev_private;
-	base = ctx->base_addr;
-	mode = rt_16550_io_mode_from_ctx(ctx);
 
 	switch (request) {
 	case RTSER_RTIOC_GET_CONFIG:
@@ -638,9 +648,9 @@ int rt_16550_ioctl(struct rtdm_dev_context *context,
 			struct rtser_status status_buf;
 
 			status_buf.line_status =
-			    rt_16550_reg_in(mode, base, LSR) | status;
+			    rt_16550_serial_in(ctx, LSR) | status;
 			status_buf.modem_status =
-			    rt_16550_reg_in(mode, base, MSR);
+			    rt_16550_serial_in(ctx, MSR);
 
 			err =
 			    rtdm_safe_copy_to_user(user_info, arg,
@@ -649,9 +659,9 @@ int rt_16550_ioctl(struct rtdm_dev_context *context,
 							  rtser_status));
 		} else {
 			((struct rtser_status *)arg)->line_status =
-			    rt_16550_reg_in(mode, base, LSR) | status;
+			    rt_16550_serial_in(ctx, LSR) | status;
 			((struct rtser_status *)arg)->modem_status =
-			    rt_16550_reg_in(mode, base, MSR);
+			    rt_16550_serial_in(ctx, MSR);
 		}
 		break;
 	}
@@ -672,7 +682,7 @@ int rt_16550_ioctl(struct rtdm_dev_context *context,
 
 		rtdm_lock_get_irqsave(&ctx->lock, lock_ctx);
 		ctx->mcr_status = new_mcr;
-		rt_16550_reg_out(mode, base, MCR, new_mcr);
+		rt_16550_serial_out(ctx, MCR, new_mcr);
 		rtdm_lock_put_irqrestore(&ctx->lock, lock_ctx);
 		break;
 	}
@@ -698,7 +708,7 @@ int rt_16550_ioctl(struct rtdm_dev_context *context,
 			if (testbits(ctx->config.event_mask,
 				     RTSER_EVENT_ERRPEND)) {
 				ctx->ier_status |= IER_STAT;
-				rt_16550_reg_out(mode, base, IER,
+				rt_16550_serial_out(ctx, IER,
 						 ctx->ier_status);
 			}
 
@@ -752,7 +762,7 @@ int rt_16550_ioctl(struct rtdm_dev_context *context,
 		    (ctx->config.parity << 3) | (ctx->config.stop_bits << 2) |
 		    ctx->config.data_bits;
 
-		rt_16550_reg_out(mode, base, LCR, lcr);
+		rt_16550_serial_out(ctx, LCR, lcr);
 
 		rtdm_lock_put_irqrestore(&ctx->lock, lock_ctx);
 		break;
@@ -768,7 +778,7 @@ int rt_16550_ioctl(struct rtdm_dev_context *context,
 			ctx->in_npend = 0;
 			ctx->status = 0;
 			fcr |= FCR_FIFO | FCR_RESET_RX;
-			rt_16550_reg_in(mode, base, RHR);
+			rt_16550_serial_in(ctx, RHR);
 		}
 		if ((long)arg & RTDM_PURGE_TX_BUFFER) {
 			ctx->out_head = 0;
@@ -777,8 +787,8 @@ int rt_16550_ioctl(struct rtdm_dev_context *context,
 			fcr |= FCR_FIFO | FCR_RESET_TX;
 		}
 		if (fcr) {
-			rt_16550_reg_out(mode, base, FCR, fcr);
-			rt_16550_reg_out(mode, base, FCR,
+			rt_16550_serial_out(ctx, FCR, fcr);
+			rt_16550_serial_out(ctx, FCR,
 					 FCR_FIFO | ctx->config.fifo_depth);
 		}
 		rtdm_lock_put_irqrestore(&ctx->lock, lock_ctx);
@@ -830,8 +840,7 @@ ssize_t rt_16550_read(struct rtdm_dev_context * context,
 		/* switch on error interrupt - the user is ready to listen */
 		if (!testbits(ctx->ier_status, IER_STAT)) {
 			ctx->ier_status |= IER_STAT;
-			rt_16550_reg_out(rt_16550_io_mode_from_ctx(ctx),
-					 ctx->base_addr, IER,
+			rt_16550_serial_out(ctx, IER,
 					 ctx->ier_status);
 		}
 
@@ -1045,8 +1054,7 @@ ssize_t rt_16550_write(struct rtdm_dev_context * context,
 
 			/* unmask tx interrupt */
 			ctx->ier_status |= IER_TX;
-			rt_16550_reg_out(rt_16550_io_mode_from_ctx(ctx),
-					 ctx->base_addr, IER,
+			rt_16550_serial_out(ctx, IER,
 					 ctx->ier_status);
 
 			rtdm_lock_put_irqrestore(&ctx->lock, lock_ctx);
@@ -1116,8 +1124,7 @@ void rt_16550_exit(void);
 int __init rt_16550_init(void)
 {
 	struct rtdm_device *dev;
-	unsigned long base;
-	int mode;
+	struct rt_16550_context ctx;
 	int err;
 	int i;
 
@@ -1155,13 +1162,16 @@ int __init rt_16550_init(void)
 			tx_fifo[i] = DEFAULT_TX_FIFO;
 
 		/* Mask all UART interrupts and clear pending ones. */
-		base = rt_16550_base_addr(i);
-		mode = rt_16550_io_mode(i);
-		rt_16550_reg_out(mode, base, IER, 0);
-		rt_16550_reg_in(mode, base, IIR);
-		rt_16550_reg_in(mode, base, LSR);
-		rt_16550_reg_in(mode, base, RHR);
-		rt_16550_reg_in(mode, base, MSR);
+		ctx.base_addr = rt_16550_base_addr(i);
+#ifdef CONFIG_XENO_DRIVERS_16550A_ANY
+		ctx.mode = rt_16550_io_mode(i);
+#endif
+		ctx.regshift = rt_16550_regshift(i);
+		rt_16550_reg_out(&ctx, IER, 0);
+		rt_16550_reg_in(&ctx, IIR);
+		rt_16550_reg_in(&ctx, LSR);
+		rt_16550_reg_in(&ctx, RHR);
+		rt_16550_reg_in(&ctx, MSR);
 
 		err = rtdm_dev_register(dev);
 
diff --git a/ksrc/drivers/serial/16550A_io.h b/ksrc/drivers/serial/16550A_io.h
index 92d21a5..ff55f46 100644
--- a/ksrc/drivers/serial/16550A_io.h
+++ b/ksrc/drivers/serial/16550A_io.h
@@ -31,15 +31,34 @@ MODULE_PARM_DESC(io, "I/O port addresses of the serial devices");
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
+#define UART_OMAP_NO_EMPTY_FIFO_READ_IP_REV     0x52
+#define UART_ERRATA_FIFO_FULL_ABORT     		(0x1 << 0)
+#endif
+
 #ifdef CONFIG_XENO_DRIVERS_16550A_PIO
 
 #define RT_16550_IO_INLINE inline
 
 extern void *mapped_io[]; /* dummy */
+static unsigned char regshift[]; /* dummy */
+
+/* prototypes */
+static RT_16550_IO_INLINE int
+rt_16550_handle_errata(struct rt_16550_context *ctx);
+static RT_16550_IO_INLINE u8
+rt_16550_reg_in(struct rt_16550_context *ctx, int off);
+static RT_16550_IO_INLINE void
+rt_16550_reg_out(struct rt_16550_context *ctx, int off, u8 val);
+
 
 static inline unsigned long rt_16550_addr_param(int dev_id)
 {
@@ -61,6 +80,11 @@ static inline io_mode_t rt_16550_io_mode(int dev_id)
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
@@ -71,6 +95,9 @@ static inline void
 rt_16550_init_io_ctx(int dev_id, struct rt_16550_context *ctx)
 {
 	ctx->base_addr = io[dev_id];
+	ctx->rt_16550_reg_in = rt_16550_reg_in;
+	ctx->rt_16550_reg_out = rt_16550_reg_out;
+	rt_16550_handle_errata(ctx);
 }
 
 #elif defined(CONFIG_XENO_DRIVERS_16550A_MMIO)
@@ -79,6 +106,14 @@ rt_16550_init_io_ctx(int dev_id, struct rt_16550_context *ctx)
 
 extern unsigned long io[]; /* dummy */
 
+/* prototypes */
+static RT_16550_IO_INLINE int
+rt_16550_handle_errata(struct rt_16550_context *ctx);
+static RT_16550_IO_INLINE u8
+rt_16550_reg_in(struct rt_16550_context *ctx, int off);
+static RT_16550_IO_INLINE void
+rt_16550_reg_out(struct rt_16550_context *ctx, int off, u8 val);
+
 static inline unsigned long rt_16550_addr_param(int dev_id)
 {
 	return mem[dev_id];
@@ -99,6 +134,11 @@ static inline io_mode_t rt_16550_io_mode(int dev_id)
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
@@ -109,12 +149,24 @@ static inline void
 rt_16550_init_io_ctx(int dev_id, struct rt_16550_context *ctx)
 {
 	ctx->base_addr = (unsigned long)mapped_io[dev_id];
+	ctx->regshift = (unsigned char)regshift[dev_id];
+	ctx->rt_16550_reg_in = rt_16550_reg_in;
+	ctx->rt_16550_reg_out = rt_16550_reg_out;
+	rt_16550_handle_errata(ctx);
 }
 
 #elif defined(CONFIG_XENO_DRIVERS_16550A_ANY)
 
 #define RT_16550_IO_INLINE /* uninline */
 
+/* prototypes */
+static RT_16550_IO_INLINE int
+rt_16550_handle_errata(struct rt_16550_context *ctx);
+static RT_16550_IO_INLINE u8
+rt_16550_reg_in(struct rt_16550_context *ctx, int off);
+static RT_16550_IO_INLINE void
+rt_16550_reg_out(struct rt_16550_context *ctx, int off, u8 val);
+
 static inline unsigned long rt_16550_addr_param(int dev_id)
 {
 	return (io[dev_id]) ? io[dev_id] : mem[dev_id];
@@ -135,6 +187,11 @@ static inline io_mode_t rt_16550_io_mode(int dev_id)
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
@@ -151,6 +208,11 @@ rt_16550_init_io_ctx(int dev_id, struct rt_16550_context *ctx)
 		ctx->base_addr = (unsigned long)mapped_io[dev_id];
 		ctx->io_mode   = MODE_MMIO;
 	}
+	ctx->regshift = (unsigned char)regshift[dev_id];
+	ctx->rt_16550_reg_in = rt_16550_reg_in;
+	ctx->rt_16550_reg_out = rt_16550_reg_out;
+	/* handle errata */
+	rt_16550_handle_errata (ctx);
 }
 
 #else
@@ -158,25 +220,27 @@ rt_16550_init_io_ctx(int dev_id, struct rt_16550_context *ctx)
 #endif
 
 static RT_16550_IO_INLINE u8
-rt_16550_reg_in(io_mode_t io_mode, unsigned long base, int off)
+rt_16550_reg_in(struct rt_16550_context *ctx, int off)
 {
-	switch (io_mode) {
+	off <<= ctx->regshift;
+	switch (rt_16550_io_mode_from_ctx(ctx)) {
 	case MODE_PIO:
-		return inb(base + off);
+		return inb(ctx->base_addr + off);
 	default: /* MODE_MMIO */
-		return readb((void *)base + off);
+		return readb((void *)ctx->base_addr + off);
 	}
 }
 
 static RT_16550_IO_INLINE void
-rt_16550_reg_out(io_mode_t io_mode, unsigned long base, int off, u8 val)
+rt_16550_reg_out(struct rt_16550_context *ctx, int off, u8 val)
 {
-	switch (io_mode) {
+	off <<= ctx->regshift;		/* regshift */
+	switch (rt_16550_io_mode_from_ctx(ctx)) {
 	case MODE_PIO:
-		outb(val, base + off);
+		outb(val, ctx->base_addr + off);
 		break;
 	case MODE_MMIO:
-		writeb(val, (void *)base + off);
+		writeb(val, (void *)ctx->base_addr + off);
 		break;
 	}
 }
@@ -185,11 +249,11 @@ static int rt_16550_init_io(int dev_id, char* name)
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
@@ -208,3 +272,103 @@ static void rt_16550_release_io(int dev_id)
 		break;
 	}
 }
+
+static RT_16550_IO_INLINE void
+rt_16550_wait_tx_end(struct rt_16550_context *ctx)
+{
+	unsigned char lsr;
+	unsigned char nbits;
+	unsigned int tmout;
+
+	nbits = 5 + ctx->config.data_bits; // 5..8 data bits
+	nbits += 1 + ctx->config.stop_bits + 3; // 1..2 stop bits
+	nbits += 2; // start + parity;
+	nbits += 2; // overhead (round up, so tmout > tx duration);
+
+	tmout = (nbits * ctx->out_npend * 1000000) / ctx->config.baud_rate;
+
+	lsr = rt_16550_reg_in(ctx, LSR);
+	while (ctx->out_npend) {
+		/* Wait for the character(s) to be sent. */
+		if(--tmout == 0)
+			break;
+		rtdm_task_busy_sleep(1000);
+		lsr = rt_16550_reg_in(ctx, LSR);
+	}
+	return;
+}
+
+#if defined (CONFIG_ARCH_OMAP3) || \
+	defined (CONFIG_ARCH_OMAP4)
+
+static RT_16550_IO_INLINE u8
+rt_16550_omapsafe_reg_in(struct rt_16550_context *ctx, int off)
+{
+	if (RHR == off) {
+		unsigned char lsr;
+		lsr = rt_16550_reg_in(ctx, LSR);
+		if (!(lsr & RTSER_LSR_DATA)) /* Receiver data ready */
+			return 0; /* FIXME: -EPERM should be returned as error */
+	}
+	return rt_16550_reg_in(ctx, off);
+}
+
+static RT_16550_IO_INLINE void
+rt_16550_disable_sleep(struct rt_16550_context *ctx)
+{
+	unsigned char lcr, efr, ier;
+
+	ier = rt_16550_reg_in(ctx, IER);
+	if (ier & IERX_SLEEP)
+	{
+		lcr = rt_16550_reg_in(ctx, LCR);
+		rt_16550_reg_out(ctx, LCR, LCR_CONF_MODE_B);
+		efr = rt_16550_reg_in(ctx, EFR);
+		rt_16550_reg_out(ctx, EFR, EFR_ECB);
+		rt_16550_reg_out(ctx, LCR, 0x0); /* Operational mode */
+
+		ier = rt_16550_reg_in(ctx, IER);
+		ier &= ~IERX_SLEEP;	/* disable sleep */
+
+		rt_16550_reg_out(ctx, IER, ier);
+		rt_16550_reg_out(ctx, LCR, LCR_CONF_MODE_B);
+		rt_16550_reg_out(ctx, EFR, efr);
+		rt_16550_reg_out(ctx, LCR, lcr);
+	}
+}
+
+static RT_16550_IO_INLINE int
+rt_16550_handle_errata(struct rt_16550_context *ctx)
+{
+	int errata = 0, rev;
+	/*
+	 * omap44xx, ti816x: Never read empty UART fifo
+	 * omap3xxx: Never read empty UART fifo on UARTs
+	 * with IP rev >=0x52
+	 */
+	if (cpu_is_omap44xx() /* FIXME: || cpu_is_ti816x() */)
+		errata |= UART_ERRATA_FIFO_FULL_ABORT;
+	else if ((rev = rt_16550_reg_in(ctx, OMAP_MVR))
+			>= UART_OMAP_NO_EMPTY_FIFO_READ_IP_REV)
+		errata |= UART_ERRATA_FIFO_FULL_ABORT;
+
+	if (errata)
+		ctx->rt_16550_reg_in = rt_16550_omapsafe_reg_in;
+
+	return errata;
+}
+#else
+
+static RT_16550_IO_INLINE void
+rt_16550_disable_sleep(struct rt_16550_context *ctx)
+{
+	return;
+}
+
+static RT_16550_IO_INLINE int
+rt_16550_handle_errata(struct rt_16550_context *ctx)
+{
+	return 0;
+}
+
+#endif //CONFIG_ARCH_OMAP3/4
-- 
1.7.0.4


--------------080205000304090803000306--

