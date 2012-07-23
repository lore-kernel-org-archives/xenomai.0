Message-ID: <500D11DE.5010203@xenomai.org>
Date: Mon, 23 Jul 2012 10:57:02 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E2AB2206BF591546A1931EA4E7A9FBC859BAFA22@Maui.in.dynetics.com>
	<500AF14A.30703@xenomai.org> <500B014B.6080206@xenomai.org>
	<500D01AE.2090801@siemens.com> <500D0666.2000700@xenomai.org>
	<500D0E10.1040707@xenomai.org>
In-Reply-To: <500D0E10.1040707@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] RT_TASK affinity on more than 8 CPU's
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 07/23/2012 10:40 AM, Philippe Gerum wrote:

> On 07/23/2012 10:08 AM, Gilles Chanteperdrix wrote:
>> On 07/23/2012 09:47 AM, Jan Kiszka wrote:
>>
>>> On 2012-07-21 21:21, Gilles Chanteperdrix wrote:
>>>> On 07/21/2012 08:13 PM, Philippe Gerum wrote:
>>>>> On 07/16/2012 10:16 PM, Wolz, Troy wrote:
>>>>>> Hello,
>>>>>>
>>>>>> I'm working on a project where I'd like to start more than 8 RT_TASKs each affined to their own CPU. From looking at the documentation, using the native API it appears to be possible to set affinity to a CPU from 0 to RTHAL_NR_CPUS-1. On my machine, RTHAL_NR_CPUS is 255, but when setting affinity above 7, overflow occurs and only the lower 8 CPU's are used.
>>>>>>
>>>>>> Looking into this, the T_CPU macro appears to only use the lower 3 bits of the value passed to it, implying that T_CPU only allows up to 8 CPU's to be used.
>>>>>    Tracing through the use of this mask, it appears that the mode mask
>>>>> passed into rt_task_create uses the top 8 bits of the word as the cpu
>>>>> mask. The bits following the top 8 are used for other flags, so there is
>>>>> no room to expand the cpu mask.
>>>>>>
>>>>>> I see 2 solutions to this limitation for using Xenomai and affinity on more than 8 cpus.
>>>>>> 1. Expand the 'mode' argument from a 32 bit int to a 64 bit long. With the extra bits, the top 32 bits could be used as a CPU mask, allowing for up to 32 cpu's to be masked simultaneously. This change would affect several files, but it should be backwards compatible with applications currently written using a 32 bit mode.
>>>>>>
>>>>>> 2. Pass an additional 64 bit long argument to rt_task_create that only contains the affinity mask. In this case, the mode argument would be used the same as previously, except the affinity would be ignored. This option has the disadvantage of being incompatible with existing Xenomai applications, but it is very easy to set affinity for up to 64 cpu's. We could add a preprocessor define that selects whether the existing rt_task_create method is available or whether the new method is available.
>>>>>>
>>>>>> We are willing to develop a patch that adds this functionality, but I wanted to talk it over with the group to determine if this would be accepted as a patch or if there's a better way to do it. Thanks.
>>>>>>
>>>>>
>>>>> The reason not to provide for more than 8 CPUs stems from our locking
>>>>> model, based on a single big lock to protect the system data structures.
>>>>> This is a design decision to keep the real-time kernel simple and
>>>>> robust, at the expense of scalability limited to few CPUs.
>>>>> Our embedded bias, and the fact that CPU proliferation is not the norm
>>>>> there yet, particularly for dual kernel configurations, explains this.
>>>>>
>>>>> Note that this setting relates to CPUs used in real-time mode, not
>>>>> necessarily to the overall number of CPUs available. E.g. you may pin
>>>>> your tasks on 4 CPUs dedicated to real-time processing, over a 64 CPUs
>>>>> system.
>>>>
>>>> I am afraid for the system to scale poorly, only timer interrupt are
>>>> needed: the timer interrupt handler takes the big lock whether it does
>>>> anything else than handling the linux timer or not. So, if timer
>>>> interrupts happen at the same time on all cpus, we are going to observe
>>>> big latencies, without the help of real-time tasks running on more than
>>>> one cpu.
>>>
>>> We have xeno_hal.supported_cpus to address this issue.
>>>
>>> We are running Xenomai on boxes >= 8 cores for quite a while. RT load is
>>> mostly confined to a single core then.
>>
>>
>> Ah, missed that. But the I-pipe core should be changed then, because
>> ipipe_timers_request looks for and grabs timers on all cpus, switching
>> them to one-shot mode.
>>
> 
> It's really an implementation detail, we could even make it a weakly 
> linked routine to allow for interposing on it from the arch-dependent 
> pipeline code. The bottom line is that we don't have to interpose fully 
> on the linux timer machinery, we only do this because it is a simple 
> default method.
> 
> So, yes, one may have to fix up the pipeline core on a per-platform 
> basis, for using a different set of clock event devices specifically for 
> real-time use. Some platforms provide a set of unused GP timers, or via 
> a PCI watchdog+timer board extension. But this is quite regular stuff to 
> provide, far from a core Xenomai change. The logic of the Xenomai timer 
> sub-system already allows that. But since this can only be a 
> platform-specific solution depending on a particular set of available 
> timers, nobody argues this could be a generic, off-the-shelf option.
> 


As I said, the core does not allow using timers with different
frequencies on different cpus, so basically, it wants the same timer on
all cpus, this is the reason why ipipe_request_timers tries to check
that the timers which will be used on all cpus use the same frequency.

If we want to change that, we have to fix Xenomai, which supposes there
is only one "timer_freq" (rthal_tunables.timer_freq). We can probably
get away with setting RTHAL_TIMER_FREQ to a per_cpu variable on all
architectures but arm which uses the frequency to pre-compute a
multiplicand to avoid division when converting between cpu frequency and
timer frequency in xnarch_program_timer_shot.

Otherwise, we can pass a cpumask to ipipe_request_timers to tell on what
cpus we need timer.

If we do not fix that one way or another, anyone wanting to use another
timer than the default ones will have to provide a timer for each cpu core.

-- 
                                                                Gilles.

