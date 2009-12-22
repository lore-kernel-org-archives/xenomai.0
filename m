Message-ID: <4B30E7FA.70600@domain.hid>
Date: Tue, 22 Dec 2009 16:38:34 +0100
From: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
MIME-Version: 1.0
References: <1261411260-839-1-git-send-email-wolfgang.mauerer@domain.hid>
	<4B30958D.6060108@domain.hid> <4B30B4D0.5010504@domain.hid>
	<4B30BA01.7060402@domain.hid> <4B30C5C1.4080406@domain.hid>
	<4B30C825.90509@domain.hid> <4B30D351.5070209@domain.hid>
	<4B30E0D5.2050403@domain.hid>
In-Reply-To: <4B30E0D5.2050403@domain.hid>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "Kiszka, Jan" <jan.kiszka@domain.hid>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Wolfgang Mauerer wrote:
>> Gilles Chanteperdrix wrote:
>>> Wolfgang Mauerer wrote:
>>>> Gilles Chanteperdrix wrote:
>>>>> Wolfgang Mauerer wrote:

(...)

>>>  Would it
>>>> therefore make sense to restrict the data exchange to the global heap
>>>> semaphore, and add an architecture-specific hook for ARM
>>>> later on to generate an extra kernel space copy of the NTP data? The
>>>> Linux vsyscall time keeping information is architecture-specific, so
>>> No. We will make it generic. Nothing arch specific is needed. We will
>>> not copy the vsyscall time keeping information, we will copy the data
>>> passed to update_vsyscall, which are the same on all architectures.
>> Having the possibility to use gettimeofday() without switching to
>> kernel mode is all about speed, and I don't see why re-using the
>> optimised data structures offered by the Linux kernel, together with the
>> already existing optimised read routines for this purpose
>> should not be an option for the Xenomai userland. But again, the
>> difference between the alternatives is hard to judge without
>> quantitative measurements. I'll maybe come back to this.
> 
> I thought we had been through this already and that we agreed. So, let
> us make things clear, for once, and I will not be able to exchange much
> further mails this afternoon.

well, the agreement was on  "3- implement the nucleus callback
for the I-pipe event which copies relevant data", and
obviously we were taking different things to be the
relevant data ;-)
> 
> We are not talking about speed. We already have speed:
> clock_gettime(CLOCK_MONOTONIC) just reads the tsc, and converts the
> result to a struct timespec, without a syscall, without even a division.
> This is about as fast as it can be, and enough for 99% of real-time
> applications. What we are talking about, is synchronizing
> CLOCK_MONOTONIC and CLOCK_REALTIME with NTP corrections, without
> sacrificing too much performance. Because, yes,  we are going to
> sacrifice performance, the computations using NTP data will be slower
> than our current multiplication only conversion. This, for a very
> specific kind of application.
> 
> Of the 5 architectures on which Xenomai is currently ported, only two
> implement the update_vsyscall() function. That is a minority. And we are
> not interested in yet-another x86-only hack. What we want, because we
> want the same level of support for all architectures, that will be
> easier to maintain, is a solution as much generic as possible. Minimal
> #ifdefs, minimal architecture code. After all, this feature is only
> needed for a few specific applications, so, there is no reason for it to
> become a maintenance burden.
> 
> Let us compare what we are talking about. My idea, is to get the I-pipe
> patches emit an event when update_vsyscall is called, and in the xenomai
> handler for this event, do the computations of the constants which will
> be used by the clock and timer operations until next update. This
> computation will happen with a xeno-seqlock locked irqs off.
> 
> Actually, I thought there were some computations when starting this
> mail, but the computations we are talking about are in fact the copy of
> a handful of 32 bits and 64 bits variables. What you are talking about
> is, in the xenomai handler for the NTP I-pipe event, call an arch
> dependent hook which will copy the data from the x86 specific
> vsyscall_gtod_data structure. Unless I misunderstood you, there is no
> difference in terms of performance between the two implementations. And
> even if there was a difference, we are talking about code which is run
> as part of Linux timer handler, that is, when Xenomai tasks have
> relinquished the system. This only adds to the overhead of something
> that is already of some importance.

there are indeed no calculations for AMD64, just for PPC. Since
some architectures also require arch-specific hooks for
gettimeofday() (albeit non of those with vsyscall and supported
by Xenomai), I was trying to design a solution that could also
cope with future archs that would require such a hook. But when
easier maintainability is more important than optimal performance,
I agree that the generic solution is by far better. So let's do it
this way.

Best, Wolfgang

