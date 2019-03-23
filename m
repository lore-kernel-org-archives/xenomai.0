Subject: Re: x86_64 kernel does not start under qemu
References: <CAFLxGvyyMEJ3t4K3dShxXMZccXCkuLN=bkTaTKLDugMieFD8ZA@mail.gmail.com>
 <73309048-fefd-20a4-31ae-1ce41b0fb8a6@siemens.com>
 <ddd256e9-0e93-30bc-ddf0-e4f333d24d7f@siemens.com>
 <3154485.mhzyMJEECq@blindfold>
 <fc014cdd-e4a8-5363-e68e-adf9b311f8f0@siemens.com>
 <2137b0d1-bb5c-9e8a-883e-9ff13c43bdc1@siemens.com>
 <96240aed-e6cd-8444-de8a-f9564b3db407@xenomai.org>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <2147f70a-0b5c-b4b2-4e0f-153fceca8b65@xenomai.org>
Date: Sat, 23 Mar 2019 11:16:32 +0100
MIME-Version: 1.0
In-Reply-To: <96240aed-e6cd-8444-de8a-f9564b3db407@xenomai.org>
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
To: Jan Kiszka <jan.kiszka@siemens.com>, Richard Weinberger <richard@nod.at>
Cc: "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

On 3/23/19 11:04 AM, Philippe Gerum via Xenomai wrote:
> On 3/22/19 9:50 PM, Jan Kiszka wrote:
>> On 21.03.19 17:07, Jan Kiszka wrote:
>>> On 21.03.19 12:57, Richard Weinberger wrote:
>>>> Am Donnerstag, 21. März 2019, 12:02:45 CET schrieb Jan Kiszka:
>>>>> FWIW, I've just seen this issue as well, with QEMU in KVM mode: I ran into that
>>>>> lockup when my host was under full load while Xenomai booted in the VM. And it
>>>>> seems reproducible. Debugging...
>>>>
>>>> Oh, good to hear that!
>>>> I played a little with your config but got badly interrupted with other stuff.
>>>> Your config seems to work but mostly because things are slower due to debugging stuff
>>>> you've enabled. Maybe this info helps.
>>>>
>>>
>>> It's a race, so everything that changes timing also changes
>>> probabilities. I'm starting to nail it down:
>>>
>>> (gdb) info threads
>>>    Id   Target Id         Frame
>>> * 4    Thread 4 (CPU#3 [halted ]) __ipipe_halt_root (use_mwait=-2147483634) at ../arch/x86/kernel/ipipe.c:317
>>>    3    Thread 3 (CPU#2 [running]) rep_nop () at ../arch/x86/include/asm/processor.h:655
>>>    2    Thread 2 (CPU#1 [halted ]) __ipipe_halt_root (use_mwait=-2147483634) at ../arch/x86/kernel/ipipe.c:317
>>>    1    Thread 1 (CPU#0 [halted ]) __ipipe_halt_root (use_mwait=-2147483634) at ../arch/x86/kernel/ipipe.c:317
>>> (gdb) monitor info lapic
>>> dumping local APIC state for CPU 3
>>>
>>> LVT0     0x00010700 active-hi edge  masked                      ExtINT (vec 0)
>>> LVT1     0x00010400 active-hi edge  masked                      NMI
>>> LVTPC    0x00010400 active-hi edge  masked                      NMI
>>> LVTERR   0x000000fe active-hi edge                              Fixed  (vec 254)
>>> LVTTHMR  0x00010000 active-hi edge  masked                      Fixed  (vec 0)
>>> LVTT     0x000400ef active-hi edge                 tsc-deadline Fixed  (vec 239)
>>> Timer    DCR=0x0 (divide by 2) initial_count = 0
>>> SPIV     0x000001ff APIC enabled, focus=off, spurious vec 255
>>> ICR      0x000008fd logical edge de-assert no-shorthand
>>> ICR2     0x02000000 mask 00000010 (APIC ID)
>>> ESR      0x00000000
>>> ISR      239
>>> IRR      236 237 238 239
>>>
>>> APR 0x00 TPR 0x00 DFR 0x0f LDR 0x08 PPR 0xe0
>>>
>>>
>>> So we are halting while we didn't finish vector 239 (timer) yet. And
>>> that means we re-enabled interrupts while the timer was being processed
>>> - a bug in I-pipe.
>>>
>>> This is while another CPU tries to run ipipe_critical_enter, never
>>> reaching CPU 3 this way (via IPI_CRITICAL_VECTOR = 236).
>>>
>>> Jan
>>>
>>
>> This might be the fix, but I need to sleep over it. Will send a PR next 
>> week.
>>
>> ---8<---
>>
>> ipipe: Call present timer ack handlers unconditionally
>>
>> This plugs a race for timers that are per-CPU but share the same
>> interrupt number. When setting them up, there is a window where the
>> first CPU already called ipipe_request_irq, but some other CPU did not
>> yet ran through grab_timer, thus have ipipe_stolen = 0.
>>
>> Moreover, it is questionable that non-stolen timers should not call
>> their ack functions.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>  kernel/ipipe/timer.c | 11 ++++-------
>>  1 file changed, 4 insertions(+), 7 deletions(-)
>>
>> diff --git a/kernel/ipipe/timer.c b/kernel/ipipe/timer.c
>> index 98d1192a2727..2d5f468ce7fb 100644
>> --- a/kernel/ipipe/timer.c
>> +++ b/kernel/ipipe/timer.c
>> @@ -369,13 +369,10 @@ static void __ipipe_ack_hrtimer_irq(struct irq_desc *desc)
>>  
>>  	if (desc)
>>  		desc->ipipe_ack(desc);
>> -
>> -	if (timer->host_timer->ipipe_stolen) {
>> -		if (timer->ack)
>> -			timer->ack();
>> -		if (desc)
>> -			desc->ipipe_end(desc);
>> -	}
>> +	if (timer->ack)
>> +		timer->ack();
>> +	if (desc && timer->host_timer->ipipe_stolen)
>> +		desc->ipipe_end(desc);
>>  }
>>  
>>  static int do_set_oneshot(struct clock_event_device *cdev)
>>
> 
> This is a regression I introduced in 4.14. Bottom line is that testing
> for ipipe_stolen in this context is pointless: if
> __ipipe_ack_hrtimer_irq() is called, this means that ipipe_request_irq()
> is in effect for the tick event, which requires this front handler to
> acknowledge the event, no matter what.
> 
> The reason is that we may not assume that the original tick handler
> (i.e. in the clockevent layer) would run next in that case, so the only
> safe place to ack the timer event is from __ipipe_ack_hrtimer_irq() if
> the timer is grabbed for the current CPU.
> 

That reasoning also applies to calling ipipe_end(): this must be done
unconditionally, because if __ipipe_ack_hrtimer_irq() is called, the
tick event will be delivered to Xenomai next, which will neither call
ipipe_end() for a tick event, nor propagate such event to the root stage
(at least not using the same IRQ line, but the host emulation tick
vector instead).

-- 
Philippe.

