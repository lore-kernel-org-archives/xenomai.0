Message-ID: <4E655CE9.7080006@domain.hid>
Date: Tue, 06 Sep 2011 09:36:09 +1000
From: Tom Evans <tom_usenet@domain.hid>
MIME-Version: 1.0
References: <4E5EEC62.2020307@domain.hid>
	<1314871016.18201.14.camel@domain.hid>
In-Reply-To: <1314871016.18201.14.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] NULL interrupt handler "ipd->irqs[irq].handler" in
 __ipipe_run_irq()
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org
Cc: Philippe Gerum <rpm@xenomai.org>

Philippe Gerum wrote:
> On Thu, 2011-09-01 at 12:22 +1000, Tom Evans wrote:
>> This problem has probably been solved years ago, but Google and 
>> searching this list didn't find me anything.
>>
>> I'm running an old (2006) Linux 2.4 kernel with Xenomai 2.1 with the 
>> Adeos patches on an MPC5200 (ppc).
>>
>> Every now and then when I stress the system it crashes because 
>> "ipd->irqs[irq].handler" is NULL for "irq == 1" (a valid irq on this 
>> system) in this code:
> 
> <snip>
> 
>> So it looks like the interrupt is happening in hardware and being queued 
>> and THEN it is being deregistered (with the handler being set to zero in 
>> ipipe_virtualize_irq()) and then it is being pulled from the pipe, run 
>> and (usually) crashes.

<snip>

>> I'd be interested in any observations, comments or pointers to the "real 
>> cause" and any other "real fixes".
> 
> ipipe_virtualize_irq() is an internal service which should be called for
> unregistering an IRQ only after the source was shut at device level, and
> possibly masked on the interrupt controller. It must be called with
> interrupt enabled for the domain which owns the unregistered handler.
> On uniprocessor systems, these two conditions are enough to make sure
> that no IRQ is lingering in the interrupt log after the handler was
> nullified.
> 
> I can't spot the routines appearing in the backtrace you sent in the
> vanilla linux/xenomai code I have at hand, but if this is a real-time
> CAN stack, you may want to check whether the device is properly quiesced
> and the IRQ line masked prior to unregistering the interrupt in the
> pipeline.

Thanks for your prompt and detailed reply.

Yes, it is a real time CAN stack. It supports Philips SJA1000 CAN chips 
on Peak Systems PCMCIA cards connected through TI PCI1520 PCI bridge 
chips (using the "Yenta" drivers) through a Freescale MPC5200's PCI 
interface The four CAN chips and the PCMCIA Bridge all use a single 
shared interrupt. The CAN chip interrupts are real-time, but if they 
find none of the CAN chips are responsible the interrupt is handballed 
(via XN_ISR_PROPAGATE) to the Linux-based PCMCIA code to see if it was a 
card insert event.

There's a lot to go wrong. Frankly it is amazing it works as well as it 
does. I can't guarantee that "all interrupt sources are shut down" at 
the time of the ipipe_virtualize_irq() because of the PCMCIA sharing.

I've found that checking for a null interrupt vector and ignoring it 
solves my problem, and makes the code more robust against any other 
corner cases.

Tom

