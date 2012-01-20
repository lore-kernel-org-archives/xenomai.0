Message-ID: <4F19581A.8070300@domain.hid>
Date: Fri, 20 Jan 2012 13:03:38 +0100
From: Manfred <manfred@domain.hid>
MIME-Version: 1.0
References: <4F1080E8.6020408@domain.hid>	<4F1082E5.8000501@domain.hid>	<4F132A7E.4000000@domain.hid>
	<4F16F028.6020507@domain.hid> <4F16F401.2090308@domain.hid>
	<4F184E42.6060300@domain.hid>
In-Reply-To: <4F184E42.6060300@domain.hid>
Content-Type: multipart/mixed; boundary="------------000407060804020909050808"
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
To: Fabrice Gasnier <fabrice.gasnier@domain.hid>
Cc: xenomai@xenomai.org

--------------000407060804020909050808
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

Hi All,

I tested the patch on my omap3630 and I ran the cross-link test.
It works. I want to thank Fabrice Gasnier from my side.

I have, however, the following suggestions/questions to the patch:
- If I got it right, the errata only affects the RX_fifo (not the 
tx_fifo), so I suggest to handle those cases separately and usually call 
the normal reg_in, and put the cases were we access RHR in "#ifdef 
omap"-clauses
- There is however another errata (or 'quirk') about the mdr1 register
http://www.ti.com/pdfs/wtbu/SWPZ017B_4460_Public_SE.pdf
but I don't think that this register is ever touched by the xeno_16550A 
driver. (If we would touch it in the future, one would have to add 
#ifdef clauses and use omapsafe_reg_out)
- in the mach-omap2/serial.c  in function "serial_out_override" there is 
this 10ms timeout-value, which should probably be avoided at any cost 
(it will increase the latency). I actually don't see why we should wait 
for the transmit_fifo to empty. Why is this necc.? Is there still 
another errata about the tx_fifo?

So I suggest to usually call the normal reg_out (formerly 
omap_raw_reg_out) and only call the modified one when necc. (now renamed 
to omapsafe_reg_out)

I have made the changes along these lines and attached them in a patch. 
(this patch is to be applied after the patch from Fabrice Gasnier)

When I compare the timings between the original patch and with my latest 
changes (using cross-link and creating load with dohell -s <wlanhost>) I 
get about 25% better timings under load. (I only ran each test once for 
3min each, though). Without load, there is of course no big change in 
the latencies.

@Fabrice: Can you check with cross-link.c on your platform? I get 
worst-case timings of 150micros with your patch, and 115micros with my 
additional changes. (I think these are round-trip timings, but I am not 
sure)

Let me know, what you think.
Regards
Manfred

On 1/19/12 6:09 PM, Fabrice Gasnier wrote:
> Finally, I find out that UART was in sleep mode.
> According to omap's reference manual, it enters this mode when conditions are met:
> rx line is idle,
> tx fifo and shift register are empty,
> rx fifo is empty
> no interrupts pending
>
> One solution that i've tested successfully is to disable sleep mode in rt_16550_open().
 > TX interrupts are then being triggered as expected.

>> other quirks, see:
>>
>> http://lxr.linux.no/#linux+v3.2.1/arch/arm/mach-omap2/serial.c#L742
> Thank you for this link! It helps handle the fifo full condition.
> However, I noticed a strange value regarding version register. My omap3530 reports 0x46?
> Linux serial driver assume this bug is present on revision>= 0x52 ...
> But my target freeze when I send more than 16 chars at once (Fifo full without errata handling).
> It works when using errata handling.

>
> You'll find attached a patch that works for me.
> Please advise. Maybe we can enhance it and push it?
>
> Thanks!
> Regards,
>
> Fabrice

--------------000407060804020909050808
Content-Type: text/plain; x-mac-type=0; x-mac-creator=0;
	name="0001b-omap3andomap4-uart-xeno_16550A-updates.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0001b-omap3andomap4-uart-xeno_16550A-updates.patch"

diff --git a/ksrc/drivers/serial/16550A.c b/ksrc/drivers/serial/16550A.c
index 81c7b70..8eb9bdb 100644
--- a/ksrc/drivers/serial/16550A.c
+++ b/ksrc/drivers/serial/16550A.c
@@ -175,7 +175,12 @@ static inline int rt_16550_rx_interrupt(struct rt_16550_context *ctx,
 	int c;
 
 	do {
+#if defined (CONFIG_ARCH_OMAP3) || \
+defined (CONFIG_ARCH_OMAP4)
+		c = rt_16550_omapsafe_reg_in(mode, base, regshift, RHR);	/* read input char */
+#else
 		c = rt_16550_reg_in(mode, base, regshift, RHR);	/* read input char */
+#endif
 
 		ctx->in_buf[ctx->in_tail] = c;
 		if (ctx->in_history)
@@ -568,7 +573,12 @@ int rt_16550_close(struct rtdm_dev_context *context,
 	rt_16550_reg_out(mode, base, regshift, IER, 0);
 	rt_16550_reg_in(mode, base, regshift, IIR);
 	rt_16550_reg_in(mode, base, regshift, LSR);
+#if defined (CONFIG_ARCH_OMAP3) || \
+defined (CONFIG_ARCH_OMAP4)
+	rt_16550_omapsafe_reg_in(mode, base, regshift, RHR);
+#else
 	rt_16550_reg_in(mode, base, regshift, RHR);
+#endif
 	rt_16550_reg_in(mode, base, regshift, MSR);
 
 	in_history = ctx->in_history;
@@ -810,7 +820,12 @@ int rt_16550_ioctl(struct rtdm_dev_context *context,
 			ctx->in_npend = 0;
 			ctx->status = 0;
 			fcr |= FCR_FIFO | FCR_RESET_RX;
+#if defined (CONFIG_ARCH_OMAP3) || \
+defined (CONFIG_ARCH_OMAP4)
+			rt_16550_omapsafe_reg_in(mode, base, regshift, RHR);
+#else
 			rt_16550_reg_in(mode, base, regshift, RHR);
+#endif
 		}
 		if ((long)arg & RTDM_PURGE_TX_BUFFER) {
 			ctx->out_head = 0;
@@ -1204,7 +1219,12 @@ int __init rt_16550_init(void)
 		rt_16550_reg_out(mode, base, regshift, IER, 0);
 		rt_16550_reg_in(mode, base, regshift, IIR);
 		rt_16550_reg_in(mode, base, regshift, LSR);
+#if defined (CONFIG_ARCH_OMAP3) || \
+defined (CONFIG_ARCH_OMAP4)
+		rt_16550_omapsafe_reg_in(mode, base, regshift, RHR);
+#else
 		rt_16550_reg_in(mode, base, regshift, RHR);
+#endif
 		rt_16550_reg_in(mode, base, regshift, MSR);
 
 		err = rtdm_dev_register(dev);
diff --git a/ksrc/drivers/serial/16550A_io.h b/ksrc/drivers/serial/16550A_io.h
index c42bdba..9a04383 100644
--- a/ksrc/drivers/serial/16550A_io.h
+++ b/ksrc/drivers/serial/16550A_io.h
@@ -189,7 +189,7 @@ rt_16550_init_io_ctx(int dev_id, struct rt_16550_context *ctx)
 	defined (CONFIG_ARCH_OMAP4)
 
 static RT_16550_IO_INLINE u8
-rt_16550_omap_raw_reg_in(io_mode_t io_mode, unsigned long base, unsigned char rshift, int off)
+rt_16550_reg_in(io_mode_t io_mode, unsigned long base, unsigned char rshift, int off)
 {
 	off <<= rshift;	/* regshift */
 	switch (io_mode) {
@@ -201,7 +201,7 @@ rt_16550_omap_raw_reg_in(io_mode_t io_mode, unsigned long base, unsigned char rs
 }
 
 static RT_16550_IO_INLINE void
-rt_16550_omap_raw_reg_out(io_mode_t io_mode, unsigned long base, unsigned char rshift, int off, u8 val)
+rt_16550_reg_out(io_mode_t io_mode, unsigned long base, unsigned char rshift, int off, u8 val)
 {
 	off <<= rshift;	/* regshift */
 	switch (io_mode) {
@@ -225,7 +225,7 @@ rt_16550_errata(io_mode_t io_mode, unsigned long base, unsigned char rshift)
 	 */
 	if (cpu_is_omap44xx() /* FIXME: || cpu_is_ti816x() */)
 		errata |= UART_ERRATA_FIFO_FULL_ABORT;
-	else if ((rev = rt_16550_omap_raw_reg_in(io_mode, base, rshift, OMAP_MVR)) >= UART_OMAP_NO_EMPTY_FIFO_READ_IP_REV)
+	else if ((rev = rt_16550_reg_in(io_mode, base, rshift, OMAP_MVR)) >= UART_OMAP_NO_EMPTY_FIFO_READ_IP_REV)
 		errata |= UART_ERRATA_FIFO_FULL_ABORT;
 
 	return errata;
@@ -236,49 +236,49 @@ rt_16550_disable_sleep(io_mode_t io_mode, unsigned long base, unsigned char rshi
 {
 	unsigned char lcr, efr, ier;
 
-	lcr = rt_16550_omap_raw_reg_in(io_mode, base, rshift, LCR);
-	rt_16550_omap_raw_reg_out(io_mode, base, rshift, LCR, LCR_CONF_MODE_B);
-	efr = rt_16550_omap_raw_reg_in(io_mode, base, rshift, EFR);
-	rt_16550_omap_raw_reg_out(io_mode, base, rshift, EFR, EFR_ECB);
-	rt_16550_omap_raw_reg_out(io_mode, base, rshift, LCR, 0x0); /* Operational mode */
-	ier = rt_16550_omap_raw_reg_in(io_mode, base, rshift, IER);
+	lcr = rt_16550_reg_in(io_mode, base, rshift, LCR);
+	rt_16550_reg_out(io_mode, base, rshift, LCR, LCR_CONF_MODE_B);
+	efr = rt_16550_reg_in(io_mode, base, rshift, EFR);
+	rt_16550_reg_out(io_mode, base, rshift, EFR, EFR_ECB);
+	rt_16550_reg_out(io_mode, base, rshift, LCR, 0x0); /* Operational mode */
+	ier = rt_16550_reg_in(io_mode, base, rshift, IER);
 	ier &= ~IERX_SLEEP;	/* disable sleep */
-	rt_16550_omap_raw_reg_out(io_mode, base, rshift, IER, ier);
-	rt_16550_omap_raw_reg_out(io_mode, base, rshift, LCR, LCR_CONF_MODE_B);
-	rt_16550_omap_raw_reg_out(io_mode, base, rshift, EFR, efr);
-	rt_16550_omap_raw_reg_out(io_mode, base, rshift, LCR, lcr);
+	rt_16550_reg_out(io_mode, base, rshift, IER, ier);
+	rt_16550_reg_out(io_mode, base, rshift, LCR, LCR_CONF_MODE_B);
+	rt_16550_reg_out(io_mode, base, rshift, EFR, efr);
+	rt_16550_reg_out(io_mode, base, rshift, LCR, lcr);
 }
 
 static RT_16550_IO_INLINE u8
-rt_16550_reg_in(io_mode_t io_mode, unsigned long base, unsigned char rshift, int off)
+rt_16550_omapsafe_reg_in(io_mode_t io_mode, unsigned long base, unsigned char rshift, int off)
 {
 	if (rt_16550_errata(io_mode, base, rshift)) {
 		if (RHR == off) {
 			unsigned char lsr;
-			lsr = rt_16550_omap_raw_reg_in(io_mode, base, rshift, LSR);
+			lsr = rt_16550_reg_in(io_mode, base, rshift, LSR);
 			if (!(lsr & RTSER_LSR_DATA)) /* Receiver data ready */
 				return 0; /* FIXME: -EPERM should be returned as error */
 		}
 	}
-	return rt_16550_omap_raw_reg_in(io_mode, base, rshift, off);
+	return rt_16550_reg_in(io_mode, base, rshift, off);
 }
 
 static RT_16550_IO_INLINE void
-rt_16550_reg_out(io_mode_t io_mode, unsigned long base, unsigned char rshift, int off, u8 val)
+rt_16550_omapsafe_reg_out(io_mode_t io_mode, unsigned long base, unsigned char rshift, int off, u8 val)
 {
 	if (rt_16550_errata(io_mode, base, rshift)) {
 		unsigned char lsr;
 		unsigned int tmout=10000;
-		lsr = rt_16550_omap_raw_reg_in(io_mode, base, rshift, LSR);
+		lsr = rt_16550_reg_in(io_mode, base, rshift, LSR);
 		while (!(lsr & RTSER_LSR_THR_EMTPY)) {
 			/* Wait up to 10ms for the character(s) to be sent. */
 			if(--tmout == 0)
 				break;
 			rtdm_task_sleep(1000);
-			lsr = rt_16550_omap_raw_reg_in(io_mode, base, rshift, LSR);
+			lsr = rt_16550_reg_in(io_mode, base, rshift, LSR);
 		}
 	}
-	rt_16550_omap_raw_reg_out(io_mode, base, rshift, off, val);
+	rt_16550_reg_out(io_mode, base, rshift, off, val);
 }
 
 #else

--------------000407060804020909050808--

