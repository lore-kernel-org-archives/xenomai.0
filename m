Message-ID: <4F1C5DB8.1080001@domain.hid>
Date: Sun, 22 Jan 2012 20:04:24 +0100
From: Manfred <manfred@domain.hid>
MIME-Version: 1.0
References: <4F1080E8.6020408@domain.hid>	<4F1082E5.8000501@domain.hid>	<4F132A7E.4000000@domain.hid>
	<4F16F028.6020507@domain.hid> <4F16F401.2090308@domain.hid>
	<4F184E42.6060300@domain.hid> <4F19581A.8070300@domain.hid>
	<4F197D0C.4060407@domain.hid>
In-Reply-To: <4F197D0C.4060407@domain.hid>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
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
To: Fabrice Gasnier <fabrice.gasnier@domain.hid>
Cc: xenomai@xenomai.org


On 1/20/12 3:41 PM, Fabrice Gasnier wrote:
> Dear all, Manfred,
>
> Please find interleaved answers/questions.
>
> On 20/01/2012 13:03, Manfred wrote:
>> Hi All,
>>
>> I tested the patch on my omap3630 and I ran the cross-link test.
>> It works. I want to thank Fabrice Gasnier from my side.
> you're welcome.
>>
>> I have, however, the following suggestions/questions to the patch:
>> - If I got it right, the errata only affects the RX_fifo (not the tx_fifo),
>> so I suggest to handle those cases separately and usually call the normal reg_in,
 >> and put the cases were we access RHR in "#ifdef omap"-clauses
> It also cares about tx fifo full condition: in rt_16550_reg_out():
> lsr = rt_16550_omap_raw_reg_in(io_mode, base, rshift, LSR);
> while (!(lsr&  RTSER_LSR_THR_EMTPY)) {
> 	/* Wait up to 10ms for the character(s) to be sent. */
> 	if(--tmout == 0)
> 		break;
> 	rtdm_task_sleep(1000);
> 	lsr = rt_16550_omap_raw_reg_in(io_mode, base, rshift, LSR);
> }
>


Ok, I could reproduce the tx fifo full condition (I could not find the 
precise errata, but it is indeed mentioned in the omap-serial.c )
Nevertheless, I would prefer any solution that avoids timeouts and keeps 
the if-statements to a minimum in these performance-critical parts.

For the tx_fifo full errata I would suggest the following:
(The idea is to read the current tx_fifo_level before writing, and make 
sure we don't fill it)
--------

static inline void rt_16550_tx_interrupt(struct rt_16550_context *ctx)
{
	int c;
	int count;
	unsigned long base = ctx->base_addr;
	unsigned char regshift = ctx->regshift;
	int mode = rt_16550_io_mode_from_ctx(ctx);

	unsigned char tx_fifo_level=0;
#if defined (CONFIG_ARCH_OMAP3) || \
defined (CONFIG_ARCH_OMAP4)
	/*Make sure we don't overrun the txfifo*/
      tx_fifo_level=rt_16550_reg_in(io_mode,base,rshift,TXFIFO_LVL_REG);
#endif

/*	if (uart->modem & MSR_CTS)*/
	{
		for (count = ctx->tx_fifo-tx_fifo_level;
		     (count > 0) && (ctx->out_npend > 0);
		     count--, ctx->out_npend--) {
			c = ctx->out_buf[ctx->out_head++];
			rt_16550_reg_out(mode, base, regshift, THR, c);
			ctx->out_head &= (OUT_BUFFER_SIZE - 1);
		}
	}
}
-------

I tested the code with long writes on my platform (250 bytes) (fifo is 
64) at 9600Baud (slow on purpose) with the periodic task at 10Hz 
(standard) and it seems to work.

I have however some more issues (which appear also with your original 
patch):
- when I try to push the cross-link.c example to the limit , by 
increasing the frequency of the periodic tasks to 500Hz (was 10Hz). I 
get corrupt data after some 1000 iterations. (The timestamp suddenly 
jumps from 70000 to a very high value). If I interrupt the code then and 
want to start it again, the machine freezes (If I first unload and 
reload the kernel module, the machine does not freeze). So my guess is, 
that the write function is being interrupted by a read-interrupt before 
finishing the write. But somehow this seems not to be catched by the 
corresponding error-handler (number of bytes written <size)

- Is there a debug-tool for xenomai to see where the code has been 
interrupted, or which interrupts have been handled recently. Or can I 
prevent the write-routine from being interrupted?

- Has anyone tried to push the cross-link example on a different 
platform to the limit, and seen similar effects?

- I would also like to enable parity bits on the serial link, but if I 
set the config_flags (for write and read device) like this:
.parity            = RTSER_ODD_PARITY,
cross-link hangs before the first read ... and freezes the machine..
Has anyone tried using Parity bits with xeno_16550A ? Do I have to 
change other flags to make it work?

Regards,
Manfred





