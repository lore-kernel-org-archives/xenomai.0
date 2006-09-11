Message-ID: <450533AF.1070000@domain.hid>
Date: Mon, 11 Sep 2006 12:00:15 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] No hardware interrupts with xenomai on ppc405
References: <4503EB88.2040309@domain.hid>
	<4503F0A8.8050602@domain.hid>
	<200609111058.44417.matthias.fuchs@domain.hid>
In-Reply-To: <200609111058.44417.matthias.fuchs@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Matthias Fuchs <matthias.fuchs@domain.hid>
Cc: xenomai@xenomai.org

Matthias Fuchs wrote:
> On Sunday 10 September 2006 13:02, Wolfgang Grandegger wrote:
>> Hi Matthias,
>>
>> Matthias Fuchs wrote:
>>> Hi,
>>>
>>> I was trying to use some external hardware interupts on a PPC405 board
>>> as part of a hacking session with Jan to bring up the rtcan driver on
>>> this board.
>>>
>> Could you please add printk statements to the ack, enable and end 
>> functions to arch/ppc/syslib/ppc4xx_pic.c if the irq number matches. 
>> Please print also SR, ER and status.
> 
> 1) insmodding the driver:
> bash-3.00# modprobe xeno_rtcan_isa mem=0xf0000000 irq=25
> rtcan: registered rtcan0
> _enable: ER=003f0040, SR=c0000000
> 
> 2) receiving
> bash-3.00# /sbin/rtcanconfig rtcan0 -b 500000 up
> bash-3.00# ./bin/rtcanrecv rtcan0
> _ack: ER=003f0000, SR=c0000040
> _end: ER=003f0000, SR=c0000000
> #0: (1) <0x000> [8] 00 00 00 00 01 00 00 00

OK. I will lookup the meaning later today.

> That's it. When sending a 2nd message to the board, nothing happens. 
> We have a LED on the SJA1000 interrupt signal. After sending the 2nd message 
> this LED stays on, so the interrupt is never handled.
> 
> It seems that the interrupt is not reenabled (bit 25) in the "end" function.

Could you please add a printout of status. It's important that the 
following if statement is entered in the end function:


	if (!(status & (IRQ_DISABLED | IRQ_INPROGRESS))) {
                 ppc_cached_irq_mask[n] |= mask;
                 mtdcr(DCRN_UIC_ER(UIC##n), ppc_cached_irq_mask[n]);
         }


And could you also try replacing all lines

         if (status & IRQ_LEVEL) { 


with

         if (status & IRQ_LEVEL || irq == <your-irq>) { 


Thanks.

Wolfgang.


