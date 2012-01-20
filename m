Message-ID: <4F19B676.5020403@domain.hid>
Date: Fri, 20 Jan 2012 19:46:14 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4F1080E8.6020408@domain.hid>	<4F1082E5.8000501@domain.hid>	<4F132A7E.4000000@domain.hid>	<4F16F028.6020507@domain.hid>
	<4F16F401.2090308@domain.hid>	<4F184E42.6060300@domain.hid>
	<4F19AC80.5010106@domain.hid>
In-Reply-To: <4F19AC80.5010106@domain.hid>
Content-Type: text/plain; charset=UTF-8
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
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai@xenomai.org

On 01/20/2012 07:03 PM, Wolfgang Grandegger wrote:
> Hi Fabrice and Manfred,
> 
> On 01/19/2012 06:09 PM, Fabrice Gasnier wrote:
>> On 18/01/2012 17:32, Wolfgang Grandegger wrote:
>>>> Further investigation indicates that when writing, tx interrupt is not asserted as expected (rt_16550_write):
>>>>> /* unmask tx interrupt */
>>>>> ctx->ier_status |= IER_TX;
>>>>> rt_16550_reg_out(rt_16550_io_mode_from_ctx(ctx),
>>>>> 		 ctx->base_addr, IER,
>>>>> 		 ctx->ier_status,
>>>>> 		 ctx->regshift);
>>>>>
>>>>> >From my understanding this should trigger an irq for data to be put in rt_16550_tx_interrupt().
>>>>> It seems this is not always the case. Moreover, TX interrupt seem to be triggered by a new RX interrupt.
>>> The TX interrupt will be enabled as long as there are chars to send,
>>> IIRC. The isr the puts the chars into the FIFO and triggers the xfer.
>> Finally, I find out that UART was in sleep mode.
>> According to omap's reference manual, it enters this mode when conditions are met:
>> rx line is idle,
>> tx fifo and shift register are empty,
>> rx fifo is empty
>> no interrupts pending
>>
>> One solution that i've tested successfully is to disable sleep mode in rt_16550_open(). TX interrupts are then being triggered as expected.
>>>
>>>>>
>>>>> Would you have an explanation for such a behavior?
>>>>> I'm not sure how to solve this.
>>> Depending on the hardware/uart revision, you may need to take care of
>>> other quirks, see:
>>>
>>> http://lxr.linux.no/#linux+v3.2.1/arch/arm/mach-omap2/serial.c#L742
>> Thank you for this link! It helps handle the fifo full condition.
>> However, I noticed a strange value regarding version register. My omap3530 reports 0x46?
>> Linux serial driver assume this bug is present on revision >= 0x52 ...
>> But my target freeze when I send more than 16 chars at once (Fifo full without errata handling).
>> It works when using errata handling.
> 
> It seems the 16550-compatible UARTs on the OMAP processor are special
> and also buggy requiring more or less heavy workarounds, unfortunately.
> I can't comment on that as I do not have experience with OMAP processors.
> 
>> You'll find attached a patch that works for me.
>> Please advise. Maybe we can enhance it and push it?
> 
> To handle hardware-specific initialization I/O properly, I think we need
> first a more flexible interface using callback functions. The existing
> interface with
> 
> 	base = ctx->base_addr;
> 	mode = rt_16550_io_mode_from_ctx(ctx);
> 	regshift = ctx->regshift;
> 	rt_16550_reg_in(mode, base, regshift, offset)",
> 
> #ifdef's and switch statements in the I/O functions is really horrible.
> A more elegant solution would make integration of the OMAP specialities
> much easier.

I will wait for Wolfgang's ack before merging anything, then.

-- 
                                                                Gilles.

