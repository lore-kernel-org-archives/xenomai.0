Message-ID: <4F197D0C.4060407@domain.hid>
Date: Fri, 20 Jan 2012 15:41:16 +0100
From: Fabrice Gasnier <fabrice.gasnier@domain.hid>
MIME-Version: 1.0
References: <4F1080E8.6020408@domain.hid>	<4F1082E5.8000501@domain.hid>	<4F132A7E.4000000@domain.hid>
	<4F16F028.6020507@domain.hid> <4F16F401.2090308@domain.hid>
	<4F184E42.6060300@domain.hid> <4F19581A.8070300@domain.hid>
In-Reply-To: <4F19581A.8070300@domain.hid>
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
To: Manfred <manfred@domain.hid>
Cc: xenomai@xenomai.org

Dear all, Manfred,

Please find interleaved answers/questions.

On 20/01/2012 13:03, Manfred wrote:
> Hi All,
> 
> I tested the patch on my omap3630 and I ran the cross-link test.
> It works. I want to thank Fabrice Gasnier from my side.
you're welcome.
> 
> I have, however, the following suggestions/questions to the patch:
> - If I got it right, the errata only affects the RX_fifo (not the tx_fifo), so I suggest to handle those cases separately and usually call the normal reg_in, and put the cases were we access RHR in "#ifdef omap"-clauses
It also cares about tx fifo full condition: in rt_16550_reg_out():
lsr = rt_16550_omap_raw_reg_in(io_mode, base, rshift, LSR);
while (!(lsr & RTSER_LSR_THR_EMTPY)) {
	/* Wait up to 10ms for the character(s) to be sent. */
	if(--tmout == 0)
		break;
	rtdm_task_sleep(1000);
	lsr = rt_16550_omap_raw_reg_in(io_mode, base, rshift, LSR);
}

> - There is however another errata (or 'quirk') about the mdr1 register
> http://www.ti.com/pdfs/wtbu/SWPZ017B_4460_Public_SE.pdf
> but I don't think that this register is ever touched by the xeno_16550A driver. (If we would touch it in the future, one would have to add #ifdef clauses and use omapsafe_reg_out)
> - in the mach-omap2/serial.c  in function "serial_out_override" there is this 10ms timeout-value, which should probably be avoided at any cost (it will increase the latency). I actually don't see why we should wait for the transmit_fifo to empty. Why is this necc.? Is there still another errata about the tx_fifo?
I think you're right it adds latencies, but what can we do about this?
e.g. I've made some testing without such a handling: trying to write "lots of" bytes (I assume more than fifo size) freezes target. It has to be handled somehow. Maybe it's wrong to do this way?
Maybe it would be better to write up to fifo full and then return...
- an error ?
- or just the number of written bytes with no error?
This way responsibility would be let to the caller (writting to much bytes will cause a lantency in the end, no ?)
I'm not sure of expected behavior on other platforms such as x86 ?

> 
> So I suggest to usually call the normal reg_out (formerly omap_raw_reg_out) and only call the modified one when necc. (now renamed to omapsafe_reg_out)
> 
> I have made the changes along these lines and attached them in a patch. (this patch is to be applied after the patch from Fabrice Gasnier)
> 
> When I compare the timings between the original patch and with my latest changes (using cross-link and creating load with dohell -s <wlanhost>) I get about 25% better timings under load. (I only ran each test once for 3min each, though). Without load, there is of course no big change in the latencies.
> 
> @Fabrice: Can you check with cross-link.c on your platform? I get worst-case timings of 150micros with your patch, and 115micros with my additional changes. (I think these are round-trip timings, but I am not sure)
I shall try these, but I own a PhyCARD-L that only has one serial port... Cannot run cross-link.
> 
> Let me know, what you think.
> Regards
> Manfred
> 
> On 1/19/12 6:09 PM, Fabrice Gasnier wrote:
>> Finally, I find out that UART was in sleep mode.
>> According to omap's reference manual, it enters this mode when conditions are met:
>> rx line is idle,
>> tx fifo and shift register are empty,
>> rx fifo is empty
>> no interrupts pending
>>
>> One solution that i've tested successfully is to disable sleep mode in rt_16550_open().
>> TX interrupts are then being triggered as expected.
> 
>>> other quirks, see:
>>>
>>> http://lxr.linux.no/#linux+v3.2.1/arch/arm/mach-omap2/serial.c#L742
>> Thank you for this link! It helps handle the fifo full condition.
>> However, I noticed a strange value regarding version register. My omap3530 reports 0x46?
>> Linux serial driver assume this bug is present on revision>= 0x52 ...
>> But my target freeze when I send more than 16 chars at once (Fifo full without errata handling).
>> It works when using errata handling.
> 
>>
>> You'll find attached a patch that works for me.
>> Please advise. Maybe we can enhance it and push it?
>>
>> Thanks!
>> Regards,
>>
>> Fabrice

