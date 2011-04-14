Message-ID: <4DA6D1E8.2030004@domain.hid>
Date: Thu, 14 Apr 2011 12:52:24 +0200
From: Martin Elshuber <martine@domain.hid>
MIME-Version: 1.0
References: <20110412-150152.sv17553.45277@domain.hid>
	<1302631107.2015.112.camel@domain.hid>
In-Reply-To: <1302631107.2015.112.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] NIOS2/Xenomai 2.5.6/Native Skin
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Hallo,

as this discussion could be of interest to other people I continue it here.

On 04/12/2011 07:58 PM, Philippe Gerum wrote:
> On Tue, 2011-04-12 at 17:01 +0200, Martin Elshuber wrote:
>> Hallo Mr. Gerum!
>>
>> First, thx for the answer of the ADEOS list&
>> thx for investing a lot of time in the NIOS port.
>>
>> Can I ask you something else?
>>
>> According to the documentation of the native skin rt_task_sleep delays a task
>> for some delay measured in clock ticks.
>>
>> On my system (NIOS II/f nommu, CPU, hrtimer, hrclock, sys_timer all @150MHz).
>> It seems that rt_task_sleep delays a task for some time measured in
>> nanoseconds.
>> In my experiment I created a single task which calls
>>    rt_task_sleep(1000000000); // 1e9
>> This call delays the task for 1 second. Therefore I guess that the unit is
>> nanoseconds.
>>
>> I did some further debugging and recognized that the hrtimer
>> is programmed with a value of just below 150000000 (150e6).
>> This appears correct, if the unit is nanoseconds.
>>
>> What is the desired behavior of rt_task_sleep (and other timed functions) of
>> the native skin?
>
> Yes, when the timing mode is oneshot/aperiodic, the base tick is the
> highest clock resolution, i.e. 1 ns. Most people use aperiodic timing
> these days with Xenomai, periodic is for legacy apps such as those
> originating from VxWorks, VRTX, pSOS, i.e. traditional RTOSes, where
> timeout values are a count of (a periodic) tick.
In other words a Xenomai clock tick always 1ns and already abstracts 
from the
hardware clock tick?
>>
>> The conversion to nanoseconds seems (a am not sure about this) to take place
>> very soon. Inside the nucleus, for example, rthal_timer_calibrate converts the
>> execution duration rthal_read_tsc to nanoseconds.
>>
>> Is there a reason for not using ipipe_tsc2ns from the adeos API inside this
>> function?
>
> Yes, the per-arch Xenomai routines are usually optimized for speed and
> precision. ipipe_tsc2ns() is merely for tracing/timestamping purpose in
> the Adeos code, using a naive conversion method.
>
>>
>> On the other hand this conversion is reverted (ns->tsc) by
>> xnarch_calibrate_timer. This confuses me!
>>
>
> Because the internal interface does not assume anything from the way the
> calibration code determines the typical timer programming latency, so it
> always asks for a count of ns, before pre-calculating the corresponding
> hardware clock ticks from this. It just happens that arch-dep code for
> timer calibration often uses hardware clock ticks internally when
> computing an average latency value dynamically, but it could also return
> a time constant, expressed in ns the same way.
>
>> The reason for these questions is, that I am trying to remove hrclock and
>> hrtimer, and replace it with another non-standard source. For this I want
>> understand, how the time ticks in Xenomai, first.
>>
>
> Xenomai needs to know:
>
> - the frequency of the timer hardware, to compute delay values to
> program it with. Usually, we have a count of hardware clock tick in
> input from the Xenomai generic timer code, we convert it to a count of
> hardware timer ticks to have the corresponding delay, and we poke this
> delay to the timer hardware to program the next tick date.
> - the frequence of the high resolution hardware clock used in all
> timestamping, to convert a timestamp (i.e. tsc) to ns, and conversely.
> - the irq the timer hardware will raise for signaling a tick.
I have contemplated about these three points. But i think i need to become
more concrete about my time-source, to describe my questions.

What do I have:
  * I have an integrated communication (Network on Chip) and 'timer' 
device.
  * This device follows a static (during application design phase defined)
    time-triggered schedule.
  * The device supports several (8 in my case) up counter with wrap around
    at a, in the schedule defined, max value.
  * The schedule defines the counter values at which periodic interrupts 
are
    are generated. For example the schedule can define:
      Use a max value of 1024 and generate interrupts at 17, 105, and 800.
  * Dynamic reprogramming of these values is not possible.
  * Masking several interrupts is possible.
  * The maximal horizon of one period is 1.6sec. It is possible to read the
    current counter value for each period at any time.
  * The device synchronizes to other on-chip (trivially) and off-chip (some
    external synchronization protocol) devices.
  * One Altera fully featured 32 Bit Timer.

What do I want:
  * By using this device as clock source all events generated by the local
    component (i.e. Xenomai) will be implicitly synchronized to other 
components.
  * Phase align all timer interrupts, to avoid two interrupts at the 
same time.
  * Xenomai Timed events are of secondary interest, as most tasks a 
trigged by
    our 'timer' device.

I am planing
  * to deviate the Linux timer interrupt from our 'timer' source, by
    using a virtual IRQ line, to
    a) phase align it to other events in the schedule
    b) make the timer available to Xenomai, and
  * to implement a read-tsc function and use a spare timer for Xenomai.

My Questions:
  * Are there any implications to Xenomai-services, aside from timed events
    (i.e. sleep, alarms, timeout functions, ...) which need to be 
regarded when
    working on the time source?
  * Is there any hardware dependent code in Xenomai that relies on the 
current
    timer (hrclock, hrtimer) implementation? I.e. can all modifications 
inside
    the ADEOS code?
    I have only identified only ADEOS code so far.

thx & best regards
Martin

>
> PS: This discussion should rather happen on xenomai-help or -core, at
> your will. Maybe those explanations could be of some interest to others.
>
>> Best regards
>> Martin Elshuber
>>
>>
>>
>>
>>
>>
>> _______________________________________________
>>    Message sent via/by Gna!
>>    http://gna.org/
>>
>


