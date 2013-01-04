Message-ID: <50E6BB87.4020100@siemens.com>
Date: Fri, 04 Jan 2013 12:22:47 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <50E471AC.2000701@siemens.com> <50E5A0E4.4000108@xenomai.org>
	<50E5A75B.6090507@siemens.com> <50E5B174.2040106@xenomai.org>
	<50E5BF03.5020004@siemens.com> <50E5C134.3010804@xenomai.org>
	<50E5C69E.7090707@siemens.com> <50E6A871.9010008@xenomai.org>
	<50E6ABF7.1050503@siemens.com> <50E6AFC3.5080400@xenomai.org>
In-Reply-To: <50E6AFC3.5080400@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] XNARCH_TIMER_IRQ
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 2013-01-04 11:32, Philippe Gerum wrote:
> On 01/04/2013 11:16 AM, Jan Kiszka wrote:
>> On 2013-01-04 11:01, Philippe Gerum wrote:
>>> On 01/03/2013 06:57 PM, Jan Kiszka wrote:
>>>> On 2013-01-03 18:34, Philippe Gerum wrote:
>>>>> On 01/03/2013 06:25 PM, Jan Kiszka wrote:
>>>>>> On 2013-01-03 17:27, Philippe Gerum wrote:
>>>>>>> On 01/03/2013 04:44 PM, Jan Kiszka wrote:
>>>>>>>> On 2013-01-03 16:16, Gilles Chanteperdrix wrote:
>>>>>>>>> On 01/02/2013 06:43 PM, Jan Kiszka wrote:
>>>>>>>>>> Hi,
>>>>>>>>>>
>>>>>>>>>> this may involve some refactoring of the HAL and a bit of I-pipe, so I
>>>>>>>>>> better ask first:
>>>>>>>>>>
>>>>>>>>>> Not sure when it changed, but XNARCH_TIMER_IRQ may no longer return the
>>>>>>>>>> same values when called on different CPUs. Therefore, It should rather
>>>>>>>>>> be called XNARCH_THIS_CPU_TIMER_IRQ now.
>>>>>>>>>>
>>>>>>>>>> Looking at its users (an I-pipe debug warning pointed it out), there are
>>>>>>>>>> two that don't expect this: xnintr_query_next() and format_irq_proc().
>>>>>>>>>> The former actually wants XNARCH_TIMER_IRQ(cpu), the latter needs
>>>>>>>>>> something like is_timer_irq_on_any_cpus(irq).
>>>>>>>>>>
>>>>>>>>>> So I would propose to refactor XNARCH_TIMER_IRQ and RTHAL_TIMER_IRQ
>>>>>>>>>> accordingly. But this unfortunately requires extensions of I-pipe to
>>>>>>>>>> provide something like __ipipe_hrtimer_irq(cpu) and
>>>>>>>>>> __ipipe_this_cpu_hrtimer_irq. And some ugly workaround in Xenomai for
>>>>>>>>>> older I-pipe versions.
>>>>>>>>>>
>>>>>>>>>> Does this make sense?
>>>>>>>>>
>>>>>>>>> Made something similar for forge:
>>>>>>>>> http://git.xenomai.org/?p=xenomai-gch.git;a=commitdiff;h=37ca257af466e7e5fbfb402b39f088487d048fd5;hp=a9971c363fd361b428f12200536bc5a01dff9c05
>>>>>>>>
>>>>>>>
>>>>>>> Caution, this code is WIP. nktimer will have to move to the percpu
>>>>>>> scheduler descriptor to complete this.
>>>>>>
>>>>>> That's nkclock in 2.6. Mostly a cosmetic issue, the interrupt name will
>>>>>> not be properly printed, statistics are already per-cpu. Could be
>>>>>> improved nevertheless.
>>>>>>
>>>>>
>>>>> My point is to tell you that what you look to in -forge regarding this
>>>>> area is in a state of flux. I'm not referring to 2.6, I'm focusing
>>>>> almost exclusively on 3.x these days.
>>>>>
>>>>>> Is there an easy way to find out if we have per-CPU timers on some arch?
>>>>>>
>>>>>
>>>>> Why should we assume differently?
>>>>
>>>> To avoid dumping redundant statistic lines when some timer IRQ has no
>>>> home on a given CPU. But as there are also mixed setups possible as
>>>> Gilles pointed out, we need a different approach, likely just skip when
>>>> there are no hits.
>>>>
>>>
>>> Your question sounded like "is it possible to know whether an SMP arch
>>> may use different per-CPU IRQs for the timer". I was about to answer
>>> that testing for any pipeline core API rev >= 2 would do, excluding all
>>> legacy patches.
>>>
>>> For the cosmetic issue you mention, testing rthal_supported_cpus would do.
>>
>> Nope, this is not sufficient. A per-CPU timer IRQ would then still
>> generate useless lines in stat for all those CPUs it is not bound to.
>>
> 
> You know which CPU has a real-time timer attached via 
> rthal_supported_cpus, which timer IRQ # is attached to each real-time 
> CPU when per-CPU timer IRQs are supported by the pipeline. For legacy 
> patches which only allow a common IRQ line for all timers regardless of 
> the CPU, the matter is solved by design. I still don't get where the 
> issue would be.

rthal_supported_cpus doesn't contain enough information. We need

is_valid_irq(irq, cpu):
	if (timer_irq(cpu) == irq)
		return true
	for_each_cpu(n)
		if (timer_irq(n) == irq)
			return false
	return true

for a cleaned up /stat output as we iterate over all combinations of
(irq, cpu) there. That for_each_cpu is a bit ugly, and that's why I was
considering to derive is_valid_irq from irq.hits > 0.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
Corporate Competence Center Embedded Linux

