Message-ID: <4A4B8617.5000704@domain.hid>
Date: Wed, 01 Jul 2009 17:51:51 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4A48FB71.6070506@domain.hid> <4A49CD81.4060706@domain.hid>	
	<4A49CFF0.7070202@domain.hid> <1246353623.7803.21.camel@domain.hid>	
	<4A49D935.3060900@domain.hid> <1246353913.7803.24.camel@domain.hid>	
	<4A49DA4E.2020604@domain.hid> <1246354047.7803.25.camel@domain.hid>
	<4A49DC0A.5000208@domain.hid> <4A4A391B.8000700@domain.hid>
	<4A4B4ED4.6020208@domain.hid> <4A4B558D.20307@domain.hid>
	<4A4B58E9.4050407@domain.hid> <4A4B5985.3070504@domain.hid>
In-Reply-To: <4A4B5985.3070504@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] x86: Endless minor faults
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> Jan Kiszka wrote:
>>>> Jan Kiszka wrote:
>>>>> It's still unclear what goes on precisely, we are still digging, but the
>>>>> test system that can produce this is highly contended.
>>>> Short update: Further instrumentation revealed that cr3 differs from
>>>> active_mm->pgd while we are looping over that fault, ie. the kernel
>>>> tries to fixup the wrong mm. And that means we have some open race
>>>> window between updating cr3 and active_mm somewhere (isn't switch_mm run
>>>> in a preemptible manner now?).
>>> Maybe the rsp is wrong and leads you to the wrong active_mm ?
>>>
>>>> As a first shot I disabled CONFIG_IPIPE_DELAYED_ATOMICSW, and we are now
>>>> checking if it makes a difference. Digging deeper into the code in the
>>>> meanwhile...
>>> As you have found out in the mean time, we do not use unlocked context
>>> switches on x86.
>>>
>> Yes.
>>
>> The last question I asked myself (but couldn't answer yet due to other
>> activity) was: Where are the local_irq_disable/enable_hw around
>> switch_mm for its Linux callers?
> 
> Ha, that's the point: only activate_mm is protected, but we have more
> spots in 2.6.29 and maybe other kernels, too!

Ok, I do not see where switch_mm is called with IRQs off. What I found,
however, is that leave_mm sets the cr3 and just clears
active_mm->cpu_vm_mask. So, at this point, we have a discrepancy between
cr3 and active_mm. I do not know what could happen if Xenomai could
interrupt leave_mm between the cpu_clear and the write_cr3. From what I
understand, switch_mm called by Xenomai upon return to root would re-set
the bit, and re-set cr3, which would be set to the kernel cr3 right
after that, but this would result in the active_mm.cpu_vm_mask bit being
set instead of cleared as expected. So, maybe an irqs off section is
missing in leave_mm.

-- 
                                          Gilles


