Message-ID: <4F16F028.6020507@domain.hid>
Date: Wed, 18 Jan 2012 17:15:36 +0100
From: Fabrice Gasnier <fabrice.gasnier@domain.hid>
MIME-Version: 1.0
References: <4F1080E8.6020408@domain.hid>	<4F1082E5.8000501@domain.hid>
	<4F132A7E.4000000@domain.hid>
In-Reply-To: <4F132A7E.4000000@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
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
To: xenomai@xenomai.org

Dear all,

On 15/01/2012 20:35, Wolfgang Grandegger wrote:
>> -->
>> > So can I just change the function in 16550A.c like this?:
>> > rt_16550_reg_in(io_mode_t io_mode, unsigned long base, int off, int
>> > regshift)
>> > {
>> >      switch (io_mode) {
>> >     case MODE_PIO:
>> >         return inb(base + off);
>> >     default: /* MODE_MMIO */
>> >          /* ADD REGSHIFT for MMIO Mode: */
>> >          unsigned long paddr=((void*)base+off)<< regshift;
>> >          return readb((void *)base + off);
> You need to shift just the *offset* at the beginning of the function:
> 
> 	off <<= regshift;
> 
> You also need to adjust the region for request_region() or ioremap().
> 


I've done similar modifications and try to run it on an omap3530 (PHYCARD-L) board.
I'm able to receive data correctly. But tx data gives a strange behavior.
Writting a little example that basically do rt_dev_write(fd, data_string, data_len) reports no error but no data is being output.

Another example that basically echo received chars:
while (1){
	rt_dev_read(fd, rx_buf, 1);
	rt_dev_write(fd, rx_buf, 1);
	printf("%c", rx_buf[0]);
}
This one displays data when received but transmit is more random.
When a first character has been received, it is only transmitted back when a second one is received.
But second char is transmitted back immediately, without waiting for a third one ...

Further investigation indicates that when writing, tx interrupt is not asserted as expected (rt_16550_write):
/* unmask tx interrupt */
ctx->ier_status |= IER_TX;
rt_16550_reg_out(rt_16550_io_mode_from_ctx(ctx),
		 ctx->base_addr, IER,
		 ctx->ier_status,
		 ctx->regshift);

>From my understanding this should trigger an irq for data to be put in rt_16550_tx_interrupt().
It seems this is not always the case. Moreover, TX interrupt seem to be triggered by a new RX interrupt.

Would you have an explanation for such a behavior?
I'm not sure how to solve this.

Thanks in advance for your help.
Regards,
Fabrice 

