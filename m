Message-ID: <43DE54DC.4080802@domain.hid>
Date: Mon, 30 Jan 2006 19:03:08 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [BUG] Interrupt problem on powerpc
References: <43DE1DAD.8050302@domain.hid> <43DE3F54.8090105@domain.hid>
	<43DE44AD.7000208@domain.hid>
In-Reply-To: <43DE44AD.7000208@domain.hid>
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
To: Anders Blomdell <anders.blomdell@domain.hid>
Cc: xenomai@xenomai.org

Anders Blomdell wrote:
> Philippe Gerum wrote:
> 
>> Anders Blomdell wrote:
>>
>>> On a PrPMC800 (PPC 7410 processor) withe Xenomai-2.1-rc2, I get the 
>>> following if the interrupt handler takes too long (i.e. next 
>>> interrupt gets generated before the previous one has finished)
>>>
>>> [   42.543765]  [c00c2008] spin_bug+0xa8/0xc4
>>> [   42.597617]  [c00c22d4] _raw_spin_lock+0x180/0x184
>>
>>
>>
>> Someone (in arch/ppc64/kernel/*.c?) is spinlocking+irqsave desc->lock 
> 
> more likely arch/ppc/kernel/*.c :-)
>

Gah... looks like I'm still confused by ia64 issues I'm chasing right now. (Why on 
earth do we need so many bits on our CPUs that only serve the purpose of raising 
so many problems?)

>> for any given IRQ without using the Adeos *_hw() spinlock variant that 
>> masks the interrupt at hw level. So we seem to have:
>>
>> spin_lock_irqsave(&desc->lock)
>>     <hw IRQ>
>>         __ipipe_grab_irq
>>             __ipipe_handle_irq
>>                 __ipipe_ack_irq
>>                     spin_lock...(&desc->lock)
>>                         deadlock.
>>
>> The point is about having spinlock_irqsave only _virtually_ masking 
>> the interrupts by preventing their associated Linux handler from being 
>> called, but despite this, Adeos still actually acquires and 
>> acknowledges the incoming hw events before logging them, even if their 
>> associated action happen to be postponed until spinlock_irq_restore() 
>> is called.
>>
>> To solve this, all spinlocks potentially touched by the ipipe's 
>> primary IRQ handler and/or the code it calls indirectly, _must_ be 
>> operated using the _hw() call variant all over the kernel, so that no 
>> hw IRQ can be taken while those spinlocks are held by Linux. Usually, 
>> only the spinlock(s) protecting the interrupt descriptors or the PIC 
>> hardware are concerned.
> 
> So you will expect an addition to the ipipe patch then?
>

Yep. We first need to find out who's grabbing the shared spinlock using the 
vanilla Linux primitives.

> /Anders
> 


-- 

Philippe.

