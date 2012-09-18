Message-ID: <50583F1E.2050503@siemens.com>
Date: Tue, 18 Sep 2012 11:30:06 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <5056C385.6090403@xenomai.org>	<5056D4AE.2010201@web.de>
	<5056DA52.6040006@xenomai.org>	<5056DCC5.10909@web.de>
	<5056E024.5020904@xenomai.org>	<5056E863.4090606@siemens.com>
	<5056ED68.6050101@xenomai.org>	<5056F09C.8050602@siemens.com>
	<5056F4A1.6070500@xenomai.org>
	<CANKLDmuxUk0XQobqs_OJ8vwQvaMie3Q3JU5Fn5DjpfpfZH3=cg@mail.gmail.com>
	<50570606.7060909@xenomai.org>
	<CANKLDmuTU3351fNd8eTqiY-9+53h2iO5TzWNsX-wqPj98f4gMw@mail.gmail.com>
	<5057173C.9070108@siemens.com> <5057299B.9060804@xenomai.org>
	<50572B95.2060302@siemens.com> <50572D86.3040306@xenomai.org>
	<50573532.20700@siemens.com> <505761DF.3010609@xenomai.org>
	<5057666D.7080404@siemens.com> <50576725.9030601@xenomai.org>
	<50576804.9030109@siemens.com> <505768B9.6000704@siemens.com>
	<50576970.6010306@xenomai.org> <50576C22.4080607@siemens.com>
	<50576DDB.2010709@xenomai.org> <505771CA.50205@siemens.com>
	<50579B16.4050804@xenomai.org> <50583551.7030805@siemens.com>
	<50583981.30706@xenomai.org>
In-Reply-To: <50583981.30706@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] IO-APIC latencies
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <Xenomai@xenomai.org>

On 2012-09-18 11:06, Gilles Chanteperdrix wrote:
> On 09/18/2012 10:48 AM, Jan Kiszka wrote:
>> On 2012-09-17 23:50, Gilles Chanteperdrix wrote:
>>> On 09/17/2012 08:54 PM, Jan Kiszka wrote:
>>>
>>>> On 2012-09-17 20:37, Gilles Chanteperdrix wrote:
>>>>> On 09/17/2012 08:29 PM, Jan Kiszka wrote:
>>>>>
>>>>>> On 2012-09-17 20:18, Gilles Chanteperdrix wrote:
>>>>>>> On 09/17/2012 08:15 PM, Jan Kiszka wrote:
>>>>>>>
>>>>>>>> On 2012-09-17 20:12, Jan Kiszka wrote:
>>>>>>>>> On 2012-09-17 20:08, Gilles Chanteperdrix wrote:
>>>>>>>>>> On 09/17/2012 08:05 PM, Jan Kiszka wrote:
>>>>>>>>>>
>>>>>>>>>>> On 2012-09-17 19:46, Gilles Chanteperdrix wrote:
>>>>>>>>>>>> ipipe_end is a nop when called from primary domain, yes, but this is not
>>>>>>>>>>>> very different from edge irqs. Also, fasteoi become a bit like MSI: in
>>>>>>>>>>>> the same way as we can not mask MSI from primary domain, we should not
>>>>>>>>>>>> mask IO-APIC fasteoi irqs, because the cost is too prohibitive. If we
>>>>>>>>>>>> can live with MSI without masking them in primary mode, I guess we can
>>>>>>>>>>>> do the same with fasteoi irqs.
>>>>>>>>>>>
>>>>>>>>>>> MSIs are edge triggered, fasteois are still level-based. They require
>>>>>>>>>>> masking at the point you defer them - what we do and what Linux may even
>>>>>>>>>>> extend beyond that. If you mask them by raising the task priority, you
>>>>>>>>>>> have to keep it raised until Linux finally handled the IRQ.
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Yes.
>>>>>>>>>>
>>>>>>>>>>> Or you
>>>>>>>>>>> decide to mask it at IO-APIC level again.
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> We do not want that.
>>>>>>>>>>
>>>>>>>>>>> If you keep the TPR raised,
>>>>>>>>>>> you will block more than what Linux wants to block.
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> The point is that if the TPR keeps raised, it means that primary domain
>>>>>>>>>> has preempted Linux, so, we want it to keep that way. Otherwise the TPR
>>>>>>>>>> gets lowered when Linux has handled the interrupt.
>>>>>>>>>>
>>>>>>>>>> A week-end of testing made me sure of one thing: it works. I assure you.
>>>>>>>>>
>>>>>>>>> Probably, in the absence of IRQF_ONESHOT Linux interrupts. No longer if
>>>>>>>>> you face threaded IRQs - I assure you.
>>>>>>>>
>>>>>>>> Well, it may work (if mask/unmask callbacks work as native) but the
>>>>>>>> benefit is gone: masking at IO-APIC level will be done again. Given that
>>>>>>>> threaded IRQs become increasingly popular, it will also be hard to avoid
>>>>>>>> them in common setups.
>>>>>>>
>>>>>>>
>>>>>>> The thing is, if we no longer use the IO-APIC spinlock from primary
>>>>>>> domain, we may not have to turn it into an ipipe_spinlock, and may be
>>>>>>> able to preempt the IO-APIC masking.
>>>>>>
>>>>>> That might be true - but is the latency related to the lock or the
>>>>>> hardware access? In the latter case, you will still stall the CPU on it
>>>>>> and have to isolate the load on a non-RT CPU again.
>>>>>>
>>>>>> BTW, the task priority for the RT domain is a quite important parameter.
>>>>>> If you put it too low, Linux can run out of vectors. If you put it too
>>>>>> high, the same may happen to Xenomai - on bigger boxes.
>>>>>
>>>>>
>>>>> Yes, and there are only 16 levels. But Xenomai does not need to many levels.
>>>>
>>>> How is telling you this? It's part of the system setup. And that may
>>>> lean toward RT or toward non-RT. This level should be adjusted according
>>>> to the current allocation of Linux and the RT domain for a particular
>>>> CPU, not hard-coded or compile-time defined.
>>>
>>>
>>> In theory, I agree, in practice, lets be crasy, assume someone would
>>> want an RT serial driver with 4 irqs, an RT USB driver with 2 irqs, an
>>> RT CAN driver, and say, 4 RTnet boards. That is still less than the 16
>>> vectors that a single level provides, so, we can probably get along with
>>> 2 levels. Or we can use a kernel parameter.
>>
>> Linux - and so should we do - allocates separate levels first as that
>> provides better performance for external interrupts (need to look up the
>> precise reason, should be documented in the x86 code). Only if levels
>> are used up, interrupts will share them.
> 
> I have seen this code, and I wondered if it was not, in fact, only
> useful, where the irq flow handler were reenabling irqs (that is, before
> the removal of IRQF_DISABLED), but am really not sure.

This pattern is still present with IRQF_ONESHOT, aka threaded IRQs.

> 
> Also, some additional results on my atom:
> the IO-APIC is on IO controller HUB, which is... an ICH4 if I read lspci
> and the datasheets correctly. And what is more, its registers are
> accessed through the (slow) LPC bus, the ISA bus replacement. It is
> probably the reason why it is so slow.

Yes, I was expecting some architectural limitation like this.

> 
> And last but not least, it is not really a multi-core processor, it has
> hyper-threading. Booting the processor in UP mode yields a much more
> reasonable latency of 23us (still with using the TPR), whereas the usual
> latency was around 30u (running the test now, will have results at
> noon), so, the real gain of using the TPR is in fact much lower than
> what originally announced. Basically, it seems with hyper threading,
> everything is doubled.

True, hyper-threading doesn't help with latencies in this range.

> 
> http://sisyphus.hd.free.fr/core-3.4-latencies/atom.png
> 
>> Out of the 16 we have, about
>> 3-4 should already be occupied by exception and system vectors. And, if
>> you look at today's NICs e.g., you get around 3 vectors per interface at
>> least. I have a more or less ordinary one here (single port, no SR-IOV)
>> with 8(!) per port. So interrupt vector shortage is not that far away.
> 
> MSI vectors, or legacy vectors?

MSI-X, not legacy MSI. Linux only supports one legacy MSI vector per
device due to the need to allocate multiple vectors in a consecutive
range - hard to achieve on x86 across all CPUs.

> Here we generate PCIe peripherals using
> FPGAs, and such peripherals can only declare one legacy interrupt,
> whereas they can declare several MSI vectors. Though I do not know if
> this is a limitation of the PCIe FPGA IP or of the PCIe standard.

PCIe recommends MSI-X, IIRC. Legacy INTx and MSI are still allowed and
can also be found in the field.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
Corporate Competence Center Embedded Linux

