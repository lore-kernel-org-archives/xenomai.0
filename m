Message-ID: <4B30E0D5.2050403@domain.hid>
Date: Tue, 22 Dec 2009 16:08:05 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1261411260-839-1-git-send-email-wolfgang.mauerer@domain.hid>
	<4B30958D.6060108@domain.hid> <4B30B4D0.5010504@domain.hid>
	<4B30BA01.7060402@domain.hid> <4B30C5C1.4080406@domain.hid>
	<4B30C825.90509@domain.hid> <4B30D351.5070209@domain.hid>
In-Reply-To: <4B30D351.5070209@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] Add support for sharing kernel/userland
 data	between Xenomai and Linux
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
Cc: "Kiszka, Jan" <jan.kiszka@domain.hid>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Wolfgang Mauerer wrote:
> Gilles Chanteperdrix wrote:
>> Wolfgang Mauerer wrote:
>>> Gilles Chanteperdrix wrote:
>>>> Wolfgang Mauerer wrote:
>>>>>>> +enum xnshared_features {
>>>>>>> +/*	XNSHARED_FEAT_A = 1,
>>>>>>> +	XNSHARED_FEAT_B, */
>>>>>>> +	XNSHARED_MAX_FEATURES,
>>>>>>> +};
>>>>>> Xenomai style is to use defines bit with the bit shifted directly, so,
>>>>>> XNSHARED_FEAT_A would rather be 0x0000000000000001, and I am not sure an
>>>>>> enum can be 64 bits.
>>>>> oh yeah, enums are always ints, as a superficial look into the
>>>>> ANSI standard tells me. Wasn't thinking about that. Using
>>>>> your direct definition makes sense (although it's a bit
>>>>> unlikely that there will ever be more than 2^32 shared
>>>>> features...)
>>>> Err, since features are bits, the limit is 32 features, not 2^32, and if
>>>> we make the features member an unsigned long long in the first place, it
>>>> is because we expect to be able to use the 64 bits, no?
>>> Argl. Yes. /me realises that christmas holidays are severely required...
>>>>>> Ok. There is a real question here. Whether we want to put this code in
>>>>>> module.c or shadow.c. I have no definite answer. Arguments for each file:
>>>>>>
>>>>>> module.c: the shared area will be used for NTP by the clock/timer
>>>>>> subsystem, so will be used in kernel-space, even without
>>>>>> CONFIG_XENO_OPT_PERVASIVE.
>>>>>>
>>>>>> shadow.c: global shared heap is uncached on ARM, so, I am not sure we
>>>>>> really want the timer/clock system to use the same area as user-space.
>>>>>> So, we are probably better off using different copies of the same data
>>>>>> in kernel-space and user-space (with a price of a copy every time the
>>>>>> data change and CONFIG_XENO_OPT_PERVASIVE is enabled). This would allow
>>>>>> us to move that code in shadow.c
>>>>> Is there any compelling advantage for shadow.c? Using a copy operation
>>>>> every time the data change seems a bit contrary to the reason for
>>>>> the new mechanism in the first place, namely to have a light-weight
>>>>> means of sharing data.
>>>> The way I see it, the NTP data will be used by the nucleus clock and
>>>> timer subsystem, so several times for each timer tick, so having them on
>>>> an uncached memory will have a performance hit.
>>>>
>>>> The copy, on the other hand, would take place over a non real-time
>>>> context, only once every update of NTP data, i.e. once every 10ms.
>>>> So, let us move it to shadow.c.
>>> I see your point, but it has the disadvantage that the time spent
>>> in the Linux kernel for the copy operations in the vsyscall is
>>> increased -- which might affect the Linux domain, since this is
>>> an optimised hot path. Naturally, in the absence of any quantitative
>>> measurements, this is all just speculation, but if access to the global
>>> semaphore heap is unchached only on ARM, we provide an unnecessary
>>> optimisation for n-1 out of n architectures supported by Xenomai.
>>>
>>> Having the time-keeping code in the Xenomai kernel benefit from NTP
>>> corrections provided by the Linux side is a bit separate from the
>>> ABI change, which would be the same irregardless of whether we
>>> use a second copy for kernel-side NTP operations or not.
>> Exactly, the issue are distinct, the ABI change is a pure user-space
>> issue, so, should only be compiled if CONFIG_XENO_OPT_PERVASIVE is defined.
> okay, that makes sense.
> 
>>  Would it
>>> therefore make sense to restrict the data exchange to the global heap
>>> semaphore, and add an architecture-specific hook for ARM
>>> later on to generate an extra kernel space copy of the NTP data? The
>>> Linux vsyscall time keeping information is architecture-specific, so
>> No. We will make it generic. Nothing arch specific is needed. We will
>> not copy the vsyscall time keeping information, we will copy the data
>> passed to update_vsyscall, which are the same on all architectures.
> 
> Having the possibility to use gettimeofday() without switching to
> kernel mode is all about speed, and I don't see why re-using the
> optimised data structures offered by the Linux kernel, together with the
> already existing optimised read routines for this purpose
> should not be an option for the Xenomai userland. But again, the
> difference between the alternatives is hard to judge without
> quantitative measurements. I'll maybe come back to this.

I thought we had been through this already and that we agreed. So, let
us make things clear, for once, and I will not be able to exchange much
further mails this afternoon.

We are not talking about speed. We already have speed:
clock_gettime(CLOCK_MONOTONIC) just reads the tsc, and converts the
result to a struct timespec, without a syscall, without even a division.
This is about as fast as it can be, and enough for 99% of real-time
applications. What we are talking about, is synchronizing
CLOCK_MONOTONIC and CLOCK_REALTIME with NTP corrections, without
sacrificing too much performance. Because, yes,  we are going to
sacrifice performance, the computations using NTP data will be slower
than our current multiplication only conversion. This, for a very
specific kind of application.

Of the 5 architectures on which Xenomai is currently ported, only two
implement the update_vsyscall() function. That is a minority. And we are
not interested in yet-another x86-only hack. What we want, because we
want the same level of support for all architectures, that will be
easier to maintain, is a solution as much generic as possible. Minimal
#ifdefs, minimal architecture code. After all, this feature is only
needed for a few specific applications, so, there is no reason for it to
become a maintenance burden.

Let us compare what we are talking about. My idea, is to get the I-pipe
patches emit an event when update_vsyscall is called, and in the xenomai
handler for this event, do the computations of the constants which will
be used by the clock and timer operations until next update. This
computation will happen with a xeno-seqlock locked irqs off.

Actually, I thought there were some computations when starting this
mail, but the computations we are talking about are in fact the copy of
a handful of 32 bits and 64 bits variables. What you are talking about
is, in the xenomai handler for the NTP I-pipe event, call an arch
dependent hook which will copy the data from the x86 specific
vsyscall_gtod_data structure. Unless I misunderstood you, there is no
difference in terms of performance between the two implementations. And
even if there was a difference, we are talking about code which is run
as part of Linux timer handler, that is, when Xenomai tasks have
relinquished the system. This only adds to the overhead of something
that is already of some importance.

To make things even more clear, the code in question on x86_64:

void update_vsyscall(struct timespec *wall_time, struct clocksource *clock)
{
        unsigned long flags;

        write_seqlock_irqsave(&vsyscall_gtod_data.lock, flags);
        /* copy vsyscall data */
        vsyscall_gtod_data.clock.vread = clock->vread;
        vsyscall_gtod_data.clock.cycle_last = clock->cycle_last;
        vsyscall_gtod_data.clock.mask = clock->mask;
        vsyscall_gtod_data.clock.mult = clock->mult;
        vsyscall_gtod_data.clock.shift = clock->shift;
        vsyscall_gtod_data.wall_time_sec = wall_time->tv_sec;
        vsyscall_gtod_data.wall_time_nsec = wall_time->tv_nsec;
        vsyscall_gtod_data.wall_to_monotonic = wall_to_monotonic;
        write_sequnlock_irqrestore(&vsyscall_gtod_data.lock, flags);
}

Why bother copying arch-specific vsyscall_gtod_data.clock.shift whereas
you can get generic clock->shift ?


-- 
					    Gilles.

