Message-ID: <4A0B1062.7040607@domain.hid>
Date: Wed, 13 May 2009 20:24:34 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4A0AC1C8.4050006@domain.hid> <4A0AC3F9.9090103@domain.hid>	
	<4A0AC8A6.1000701@domain.hid> <1242220962.26544.955.camel@domain.hid>
	<4A0AE726.5090107@domain.hid> <4A0B0E18.9090606@domain.hid>
In-Reply-To: <4A0B0E18.9090606@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] Fix host IRQ propagation
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> On Wed, 2009-05-13 at 15:18 +0200, Jan Kiszka wrote:
>>>> Gilles Chanteperdrix wrote:
>>>>> Jan Kiszka wrote:
>>>>>> Hi Gilles,
>>>>>>
>>>>>> I'm currently facing a nasty effect with switchtest over latest git head
>>>>>> (only tested this so far): running it inside my test VM (ie. with
>>>>>> frequent excessive latencies) I get a stalled Linux timer IRQ quite
>>>>>> quickly. System is otherwise still responsive, Xenomai timers are still
>>>>>> being delivered, other Linux IRQs too. switchtest complained about
>>>>>>
>>>>>>     "Warning: Linux is compiled to use FPU in kernel-space."
>>>>>>
>>>>>> when it was started. Kernels are 2.6.28.9/ipipe-x86-2.2-07 and
>>>>>> 2.6.29.3/ipipe-x86-2.3-01 (LTTng patched in, but unused), both show the
>>>>>> same effect.
>>>>>>
>>>>>> Seen this before?
>>>>> The warning about Linux being compiled to use FPU in kernel-space means
>>>>> that you enabled soft RAID or compiled for K7, Geode, or any other
>>>> RAID is on (ordinary server config).
>>>>
>>>>> configuration using 3DNow for such simple operations as memcpy. It is
>>>>> harmless, it simply means that switchtest can not use fpu in kernel-space.
>>>>>
>>>>> The bug you have is probably the same as the one described here, which I
>>>>> am able to reproduce on my atom:
>>>>> https://mail.gna.org/public/xenomai-help/2009-04/msg00200.html
>>>>>
>>>>> Unfortunately, I for one am working on ARM issues and am not available
>>>>> to debug x86 issues. I think Philippe is busy too...
>>>> OK, looks like I got the same flu here.
>>>>
>>>> Philippe, did you find out any more details in the meantime? Then I'm
>>>> afraid I have to pick this up.
>>> No, I did not resume this task yet. Working from the powerpc side of the
>>> universe here.
>> Hoho, don't think this rain here over x86 would have never made it down
>> to ARM or PPC land! ;)
>>
>> Martin, could you check if this helps you, too?
>>
>> Jan
>>
>> (as usual, ready to be pulled from 'for-upstream')
>>
>> --------->
>>
>> Host IRQs may not only be triggered from non-root domains. But
>> rthal_propagate_irq's implemenation in I-pipe assumes so, which broke
>> host tick propagation under certain load scenarios. Besides that,
>> rthal_schedule_irq_root is the more efficient service for this purpose
>> anyway.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
>> ---
>>
>>  include/asm-generic/hal.h |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/include/asm-generic/hal.h b/include/asm-generic/hal.h
>> index b37e476..8137856 100644
>> --- a/include/asm-generic/hal.h
>> +++ b/include/asm-generic/hal.h
>> @@ -437,7 +437,7 @@ int rthal_irq_host_release(unsigned irq,
>>  
>>  static inline void rthal_irq_host_pend(unsigned irq)
>>  {
>> -	rthal_propagate_irq(irq);
>> +	rthal_schedule_irq_root(irq);
>>  }
>>  
>>  int rthal_apc_alloc(const char *name,
>>
> 
> Well, I would assume this could fix head, with the newly delayed root
> tick irq propagation. But the user reports this bug with 2.4 too...

According to my instrumentation, a delayed tick was not involved. The
problem was 'propagate' vs. non-root trigger domain. So 2.4 should
suffer from the same issue.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

