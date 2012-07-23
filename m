Message-ID: <500D2E14.5000905@xenomai.org>
Date: Mon, 23 Jul 2012 12:57:24 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <E2AB2206BF591546A1931EA4E7A9FBC859BAFA22@Maui.in.dynetics.com>
	<500AF14A.30703@xenomai.org> <500B014B.6080206@xenomai.org>
	<500D01AE.2090801@siemens.com> <500D0666.2000700@xenomai.org>
	<500D0E10.1040707@xenomai.org> <500D11DE.5010203@xenomai.org>
	<500D211C.4000808@xenomai.org> <500D2A69.5030505@xenomai.org>
In-Reply-To: <500D2A69.5030505@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 07/23/2012 12:41 PM, Gilles Chanteperdrix wrote:
> On 07/23/2012 12:02 PM, Philippe Gerum wrote:>> If we want to change
> that, we have to fix Xenomai, which supposes there
>
>>> is only one "timer_freq" (rthal_tunables.timer_freq). We can probably
>>> get away with setting RTHAL_TIMER_FREQ to a per_cpu variable on all
>>> architectures but arm which uses the frequency to pre-compute a
>>> multiplicand to avoid division when converting between cpu frequency and
>>> timer frequency in xnarch_program_timer_shot.
>>>
>>
>> Maybe it's time to move the hrtimer-freq <-> hrclock-freq computations
>> to some globally visible helpers into the pipeline core. Then, the
>> arch-dep sections of the pipeline could go wild doing these computations
>> the way they want to, without affecting the interface anymore.
>> Typically, there is nothing which would prevent us from introducing
>> ipipe_timer_program(u64 tsc), assuming that such value must be based on
>> our hrclock.
>
>
> It means moving the asm/arith.h code to I-pipe, but since we need it to
> support older patches, this means a whole new source of code duplication.

This is clearly 3.x material, not 2.x since we have entered the 
maintenance cycle for 2.6.x, and we won't go for 2.7.x. We have delayed 
(my bad) 3.x for way too long.

>
> If you mean passing an absolute date to program the timer, I had thought
> about it, I am not sure this is the right way to go:
>

It's not about passing an absolute date, it is about passing a delay 
based on the hrclock to avoid the conversion step, and therefore make 
the requirement to access frequencies useless.

> - most ipipe timers use the clock_event callback anyway, which use a
> delay as argument.
> - it has problems of its own, basically, you have to do what all
> free-running counter + match register do: re-read the free-running
> counter after programming the match register to check that the
> programmed date is not alread passed.
> - On hardware timers with free-running counter and match register, this
> avoids the problem of taking into account the timer calibration, but the
> problem remains for decrementers (the most common case, anyway), and it
> means that the calibration code would be moved to the I-pipe patch too,
> and we have the code duplication issue again.
>

What I mean is to move all timer device-specific handling out of the 
Xenomai core, to the pipeline, where these things already live. The 
motivation behind the new pipeline core is to become Xenomai friendly, 
at last.

>>
>>> Otherwise, we can pass a cpumask to ipipe_request_timers to tell on what
>>> cpus we need timer.
>>>
>>
>> As I said: this is NOT a structural change. The problem statement is
>> plain trivial, and we can address it, by evolving the I-pipe interface
>> for more flexibility in handling clock devices, which in turn should
>> remove such burden from the Xenomai core. The very initial
>>
>> The point we are discussing is about whether using different clock
>> devices to decouple the linux timekeeping machinery from the Xenomai
>> timer subsystem is in essence possible. We seem to agree that this is
>> possible without going back to the drawing board, which is the good news
>> of the day.
>>
>>> If we do not fix that one way or another, anyone wanting to use another
>>> timer than the default ones will have to provide a timer for each cpu core.
>>>
>>
>> Incidentally, I'm moving the pipeline core to 3.4, so this may be a good
>> opportunity to update the timer interface we expose to client domains as
>> well.
>
>
> I would be in favor of adding the cpumask parameter to
> ipipe_request_timers: it means that the "all timers with the same
> frequency" issue will be restricted to cpus which xenomai wants to use.
> And we have an issue when using the "supported_cpus" feature.
>
> As I said, ipipe_request_timers will grab all the timers and switch them
> to one-shot mode. However, Xenomai will only take control of some of them.
>
> So, if the timers were running in periodic mode when
> ipipe_request_timers was called (so, if CONFIG_HIGH_RES_TIMERS is not
> enabled), and xenomai does not take control of them, it means the timer
> will not be reprogrammed after the first tick: we just stopped the
> periodic timer on the cpus xenomai will not use. Admittedly, this is a
> corner case, but still, it exists.
>
> There is a possible fix without breaking the interface, but we still get
> the silly common frequency requirement.
>

3.x, really. Let's break it.

> I am also working on the core-3.4 branch right now.
>

Do you have fixes to the generic core pending? If so, I'd like to merge 
them, so that I can eventually send out an updated patch to the blackfin 
folks.

-- 
Philippe.



