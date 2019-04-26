Subject: Re: rt_dev_send() stalls periodic task
References: <CA+K1mPFgaiP3fGFnd169MXhdRWo+a1TGz5fnEoj7MOCr11UbLQ@mail.gmail.com>
 <c6a9ba79-c7c5-195d-be1e-030fb44f5abc@siemens.com>
 <CA+K1mPEvKLN+gyDPwLE0OovtSn-iQ_BBZ86zQf12Fv65Ht5KbQ@mail.gmail.com>
 <2ade719a-84c7-c53d-9895-a5e6eea354a3@siemens.com>
 <CA+K1mPHhMrw-2t0k1_AgKE4iZ+2+Vvx7TV_ScHnOFis_sBxt=Q@mail.gmail.com>
 <5CBCCE3F.5090000@freyder.net>
 <CA+K1mPGZiuAvumxhdvKk2R=UvO9WwE_ppfkXeMaWLt7dP5hB3w@mail.gmail.com>
 <ebb4d71b-3d5b-9d66-270f-ca35e7785bce@web.de>
 <dccf6d29-e996-5c78-93fe-a74879270a44@siemens.com>
 <CA+K1mPHKN42HPMEjQ1aL+P_TjtDt6sUXy95xFRt=y_9qe9y7VQ@mail.gmail.com>
 <e1a9aa13-c5a4-2ba0-4012-5c668db15e33@siemens.com>
 <CA+K1mPFeW8KnzC++1D5p=GET5VOdrdNvHa9PrJvuoY0TP_-6wg@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <b6061b5f-2b57-2569-041e-1fa007a6f271@siemens.com>
Date: Fri, 26 Apr 2019 18:38:13 +0200
MIME-Version: 1.0
In-Reply-To: <CA+K1mPFeW8KnzC++1D5p=GET5VOdrdNvHa9PrJvuoY0TP_-6wg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: C Smith <csmithquestions@gmail.com>
Cc: Xenomai List <xenomai@xenomai.org>, Steve Freyder <steve@freyder.net>, w1@codecraftsmen.org

On 26.04.19 02:59, C Smith wrote:
> On Thu, Apr 25, 2019 at 1:23 AM Jan Kiszka <jan.kiszka@siemens.com 
> <mailto:jan.kiszka@siemens.com>> wrote:
> 
>     On 25.04.19 09:15, C Smith wrote:
>      > Hi Jan,
>      >
>      > Your patch worked somewhat but not completely. It prevents my app from
>     stalling
>      > forever, but I caugh the serial transmission itself stalling on the
>     oscilloscope
>      > for quite a long time. My 72 byte TX packet from the xenomai periodic
>     task gets
>      > cut in half and there is no transmission for 7msec, then the transmission
>      > resumes. (I'll send you a screenshot)
> 
>     What is driver and application state during that phase? Who is waiting on what?
>     This will be the key to resolve that issue as I'm not yet seeing another
>     mistake
>     in the driver.
> 
> 
> I don't think there is a bug in the serial driver, per se, but my strange UART 
> requires more from a driver to prevent stalls.
> This is a BCM corp 'BCM87Q' industrial motherboard. They are still sold, not yet 
> EOL.
> 
> We do know a lot about the state the serial driver is in: It is just waiting, 
> thinking it doesn't have any more bytes to transmit. Remember in previous tests 
> the IIR indicated no pending bytes in the THR. I've demonstrated how to get past 
> this state with my TX "polling patch".  I ran my latest test for 12+ hours where 
> I was using your patch plus my polling patch and there were no stalls whatsoever 
> of the serial driver, as verified by an Oscilloscope which triggers on a TX 
> stall. The maximum inter-packet jitter of my TX packet was also fairly low, at 
> <= 450us. In my polling patch, during a RX interrupt, the code redundantly 
> checks the high level transmit buffer to see if rt_16550_tx_fill() should be 
> called. Sure, this workaround only helps when you have full-duplex 
> communications, it would not help during simplex communications.
> 
> Since a device driver can't be reliably polled, I'd prefer some self-correcting 
> mechanism in the driver which set a callback when it thinks it has transmitted 
> the last byte, and wakes up and checks one more time about 100us later to see if 
> it needs to transmit anything else.

I'd prefer to install any watchdog for potential hardware issues until
we really know they aren't software races.

If there a chance to either break a trace or record the full run when
the issue happens? Then you could try this instrumentation, together with ftrace (trace-cmd record -e "cobalt*"):

diff --git a/kernel/drivers/serial/16550A.c b/kernel/drivers/serial/16550A.c
index 81acc6344e..504d85ccbe 100644
--- a/kernel/drivers/serial/16550A.c
+++ b/kernel/drivers/serial/16550A.c
@@ -197,6 +197,7 @@ static void rt_16550_tx_fill(struct rt_16550_context *ctx)
 	unsigned long base = ctx->base_addr;
 	int mode = rt_16550_io_mode_from_ctx(ctx);
 
+	trace_printk("tx_fill, out_npend: %ld", ctx->out_npend);
 /*	if (uart->modem & MSR_CTS)*/
 	{
 		for (count = ctx->tx_fifo;
@@ -239,6 +240,7 @@ static int rt_16550_interrupt(rtdm_irq_t * irq_context)
 
 	while (1) {
 		iir = rt_16550_reg_in(mode, base, IIR) & IIR_MASK;
+		trace_printk("IIR: 0x%x", iir);
 		if (iir & IIR_PIRQ)
 			break;
 
@@ -284,6 +286,7 @@ static int rt_16550_interrupt(rtdm_irq_t * irq_context)
 	}
 
 	if ((ctx->ier_status & IER_TX) && (ctx->out_npend == 0)) {
+		trace_printk("IER_TX off");
 		/* mask transmitter empty interrupt */
 		ctx->ier_status &= ~IER_TX;
 
@@ -1030,10 +1033,12 @@ ssize_t rt_16550_write(struct rtdm_fd *fd, const void *buf, size_t nbyte)
 
 			lsr = rt_16550_reg_in(rt_16550_io_mode_from_ctx(ctx),
 					      ctx->base_addr, LSR);
+			trace_printk("LSR: 0x%x", lsr);
 			if (lsr & RTSER_LSR_THR_EMTPY)
 				rt_16550_tx_fill(ctx);
 
 			if (ctx->out_npend > 0 && !(ctx->ier_status & IER_TX)) {
+				trace_printk("IER_TX on, out_npend: %lu", ctx->out_npend);
 				/* unmask tx interrupt */
 				ctx->ier_status |= IER_TX;
 				rt_16550_reg_out(rt_16550_io_mode_from_ctx(ctx),


Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

