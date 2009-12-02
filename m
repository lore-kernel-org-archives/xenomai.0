Message-ID: <4B167A55.8080407@domain.hid>
Date: Wed, 02 Dec 2009 15:31:49 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4B1663B9.8030306@domain.hid> <4B166A5B.6030400@domain.hid>
	<4B166EFB.8050309@domain.hid> <4B16769A.9060700@domain.hid>
In-Reply-To: <4B16769A.9060700@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Realtime gettimeofday()
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Wolfgang Mauerer <wm@domain.hid>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> Wolfgang Mauerer wrote:
>>>> Hi,
>>>>
>>>> we'd like to implement a gettimeofday() mechanism that works
>>>> in realtime context, both from user- and kernelland. Most importantly,
>>>> the correctins made to the wall time by the NTP protcol on Linux
>>>> must be transferred into the Xenomai domain.
>>> Yes, the real issue is NTP, because other than that, you can simply
>>> implement gettimeofday in terms of clock_gettime(CLOCK_REALTIME).
>> Not truly as Linux processes that tune the host clock do not affect the
>> Xenomai world.
>>
>>> This issue has been discussed several times, but never a lot. We have a
>>> simple solution: starting with 2.4 (if I remember correctly) xenomai
>>> provides clock_settime, so you can simply rely on clock_gettime, and
>>> call clock_settime from time to time to resync the Xenomai clock with
>>> Linux NTP-enhanced clock. This is not pretty, you get a drift increasing
>>> over time, then suddenly been reset. But I guess this has been enough
>>> for current users, until now. You control the maximum drift by how often
>>> you call clock_settime.
>>>
>>> Would not it be enough for your use of xenomai?
>> Nope for the reasons you mentioned.
>>
>> Moreover, reading the Xenomai real-time clock requires a syscall,
>> gettimeofday can work without that penalty (given non-broken TSC).
>>
>> Next issue is that the different clock bases of
>> clock_gettime(CLOCK_REALTIME) and (real) gettimeofday + the switch-back
>> or even lock-up side-effects of the latter have been quite a PITA in our
>> project.
>>
>> And finally, the vision is to have NTP-accurate (or whatever the sync
>> source is, eg. IEEE1588) absolute timing also for the nucleus one day.
>> Having an RT-safe way to obtain the NTP parameters from any context is
>> the first step.
> 
> clock_gettime(CLOCK_MONOTONIC) works without syscall too. And note that
> the real-time clock could work without a syscall for the current scheme,
> but you were the one to explicitly refuse this.

Yes, because we need a scheme like Wolfgang suggests to ensure
consistent states during updates. And we didn't had such thing back then.

> 
> My opinion with regard to these issues is that the I-pipe patch should
> send us an event when the parameters are adjusted (the wall clock time
> changed by Linux, or the slow down/acceleration caused by the NTP
> daemon). And that we should duplicate the processing done by the Linux
> kernel for the Xenomai clock.

That may be a solution for only half of the problem.

> Doing this in user-space without a syscall
> is another issue that will be possible to handle when we have solved the
> kernel-space clock issue. Of course, it supposes that Xenomai should use
> the same clocksource as Linux, so, that we should implement the HPET
> clock source for x86 (on other architectures, we already use the same
> clock source).

Solving the user space transfer automatically includes a solution for
the Linux-to-Xenomai transfer. I really suggest that we discuss a
complete solution to avoid leaving design issues behind that require
another ABI change later on.

> 
> Another possibility is to implement syscalls to allow adjusting the
> nucleus real-time clock parameters the same way ntp does, and to require
> a special ntp daemon that would use these syscalls instead of the linux
> kernel syscalls. After all, if we adjust Xenomai clock, Linux clock will
> follow without any adjustment. On an embedded system, requiring a
> recompiled NTP is not much of an issue.
> 
> So, to summarize, here is what I think we should do:
> - implement the HPET clock source

What for? The days of HPET are counted (both as clock and event source),
modern systems provide proper TSCs.

> - implement the I-pipe events signalling wall clock adjustment and NTP
> related adjustments
> - or implement syscalls to allow NTP related adjustments (we already
> have the syscall allowing to change wall clock)
> - rework the nucleus real-time clock to use these adjustements
> - implement the user-space syscall-less version of the real-time clock read.
> 
> Trying to go directly to the last point looks premature to me.

Why? It delivers us the core mechanism we need for the rest as well -
and it does not require fancy I-pipe hooks.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

