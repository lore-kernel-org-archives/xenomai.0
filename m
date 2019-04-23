Subject: Re: rt_dev_send() stalls periodic task
References: <CA+K1mPFgaiP3fGFnd169MXhdRWo+a1TGz5fnEoj7MOCr11UbLQ@mail.gmail.com>
 <c6a9ba79-c7c5-195d-be1e-030fb44f5abc@siemens.com>
 <CA+K1mPEvKLN+gyDPwLE0OovtSn-iQ_BBZ86zQf12Fv65Ht5KbQ@mail.gmail.com>
 <2ade719a-84c7-c53d-9895-a5e6eea354a3@siemens.com>
 <CA+K1mPHhMrw-2t0k1_AgKE4iZ+2+Vvx7TV_ScHnOFis_sBxt=Q@mail.gmail.com>
 <5CBCCE3F.5090000@freyder.net>
 <CA+K1mPGZiuAvumxhdvKk2R=UvO9WwE_ppfkXeMaWLt7dP5hB3w@mail.gmail.com>
 <ebb4d71b-3d5b-9d66-270f-ca35e7785bce@web.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <dccf6d29-e996-5c78-93fe-a74879270a44@siemens.com>
Date: Tue, 23 Apr 2019 14:15:58 +0200
MIME-Version: 1.0
In-Reply-To: <ebb4d71b-3d5b-9d66-270f-ca35e7785bce@web.de>
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
To: C Smith <csmithquestions@gmail.com>, Steve Freyder <steve@freyder.net>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 22.04.19 08:45, Jan Kiszka via Xenomai wrote:
> On 22.04.19 08:40, C Smith via Xenomai wrote:
>> Thanks for your insight, Steve. I didn't realize rt_dev_write() doesnt
>> actually stall until it is called many times and the 4K TX buffer gets
>> full. (is that right Jan?)
>> It that is the case, sure I could find a way to check the TX buffer fill
>> level to prevent my app from stalling.
>>
>> I rewrote the xeno_16550A driver RTSER_RTIOC_GET_STATUS ioctl to return to
>> userspace the contents of the IIR and the IER too.
>> I'm getting IIR = 0b 0001 0100, so the source of the latest interrupt is a
>> RX (not surprising, as I'm doing full duplex) and there is no THRE
>> interrupt pending.
>> So regardless of the ultimate cause, this state will never empty the TX
>> buffer.
>>
>> I think my only choice is to try something I had to do once before on a
>> similarly misbehaving serial port: I'll rewrite the xeno_16550A interrupt
>> handlers to redundantly check for data pending in the TX buffer whenever
>> any interrupt like an RX interrupt happens. I do have bidirectional traffic
>> after all, so the driver will wake up frequently and keep the TX data
>> transmitting.
>>
>> Interesting enough, the stall problem did not occur when I used the sample
>> serial code provided by xenomai: cross-link.c . I also rewrote cross-link.c
>> to send a 72 byte packet and receive on the same port (I installed a
>> physical loopback device on the serial port). No stalls for 12+ hours with
>> packets streaming at 100 Hz.
>> The only difference in the serial configuration between that cross-link.c
>> app and my app was :
>> struct rtser_config :
>>          .rx_timeout        = RTSER_DEF_TIMEOUT  // infinite ,  no stall for
>> many hours in cross-link.c
>> versus:
>>          .rx_timeout        = 500000   // 500us, stalls within an hour in my
>> app
>> I don't know why an RX setting affects TX behavior. I also can't use
>> RTSER_DEF_TIMEOUT in my application or it dies when it starts up - no clue
>> why.  But I did try setting
>>    .rx_timeout        = 5000000   // 5 ms. my app doesnt stall for several
>> hours
>> and though that did not cause the serial to stall in my app for several
>> hours of testing, it is just open-loop finger-crossing, and not a real
>> solution.
>> I need the TX interrupts to fire reliably. So I think I must rewrite that
>> interrupt handler, as above.
>>
> 
> I think we have a race between rt_16550_write filling the software queue that
> the tx interrupt is supposed to write out and the latter already firing,
> consuming that event without seeing the queue filled. I'll think about a better
> algorithm tomorrow, one that can possibly get rid of some interrupt events as well.
> 

Could you try this diff?

diff --git a/kernel/drivers/serial/16550A.c b/kernel/drivers/serial/16550A.c
index 24415cf67c..369d65be66 100644
--- a/kernel/drivers/serial/16550A.c
+++ b/kernel/drivers/serial/16550A.c
@@ -190,7 +190,7 @@ static inline int rt_16550_rx_interrupt(struct rt_16550_context *ctx,
 	return rbytes;
 }
 
-static inline void rt_16550_tx_interrupt(struct rt_16550_context *ctx)
+static void rt_16550_tx_fill(struct rt_16550_context *ctx)
 {
 	int c;
 	int count;
@@ -248,7 +248,7 @@ static int rt_16550_interrupt(rtdm_irq_t * irq_context)
 		} else if (iir == IIR_STAT)
 			rt_16550_stat_interrupt(ctx);
 		else if (iir == IIR_TX)
-			rt_16550_tx_interrupt(ctx);
+			rt_16550_tx_fill(ctx);
 		else if (iir == IIR_MODEM) {
 			modem = rt_16550_reg_in(mode, base, MSR);
 			if (modem & (modem << 4))
@@ -951,6 +951,7 @@ ssize_t rt_16550_write(struct rtdm_fd *fd, const void *buf, size_t nbyte)
 	int block;
 	int subblock;
 	int out_pos;
+	int lsr;
 	char *in_pos = (char *)buf;
 	rtdm_toseq_t timeout_seq;
 	ssize_t ret;
@@ -1027,11 +1028,18 @@ ssize_t rt_16550_write(struct rtdm_fd *fd, const void *buf, size_t nbyte)
 			    (ctx->out_tail + block) & (OUT_BUFFER_SIZE - 1);
 			ctx->out_npend += block;
 
-			/* unmask tx interrupt */
-			ctx->ier_status |= IER_TX;
-			rt_16550_reg_out(rt_16550_io_mode_from_ctx(ctx),
-					 ctx->base_addr, IER,
-					 ctx->ier_status);
+			lsr = rt_16550_reg_in(rt_16550_io_mode_from_ctx(ctx),
+					      ctx->base_addr, LSR);
+			if (lsr & RTSER_LSR_THR_EMTPY)
+				rt_16550_tx_fill(ctx);
+
+			if (ctx->out_npend > 0) {
+				/* unmask tx interrupt */
+				ctx->ier_status |= IER_TX;
+				rt_16550_reg_out(rt_16550_io_mode_from_ctx(ctx),
+						ctx->base_addr, IER,
+						ctx->ier_status);
+			}
 
 			rtdm_lock_put_irqrestore(&ctx->lock, lock_ctx);
 			continue;

Only compile-tested so far. In theory, it should plug that race and
avoid enabling the TX interrupt in case the FIFO can take the complete
write directly.

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

