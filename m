Message-ID: <4B16EB51.90808@domain.hid>
Date: Wed, 02 Dec 2009 23:33:53 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4B1663B9.8030306@domain.hid>	<4B166A5B.6030400@domain.hid>	<4B166EFB.8050309@domain.hid>	<4B16769A.9060700@domain.hid>	<4B167A55.8080407@domain.hid>	<4B167B4B.3010804@domain.hid>	<4B167FC4.8080904@domain.hid>	<4B1681DA.3090108@domain.hid>	<4B1684D7.2080501@domain.hid>	<4B1690EC.8030002@domain.hid>	<4B16949B.2040806@domain.hid>
	<4B169CF7.2060108@domain.hid>	<4B16D403.1070202@domain.hid>
	<4B16E417.3000400@domain.hid> <4B16E813.6050906@domain.hid>
In-Reply-To: <4B16E813.6050906@domain.hid>
Content-Type: text/plain; charset=UTF-8
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
To: Wolfgang Mauerer <wm@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Wolfgang Mauerer wrote:
>> Gilles Chanteperdrix wrote:
>>> Gilles Chanteperdrix wrote:
>>>> Jan Kiszka wrote:
>>>>> I surely don't want to duplicate ntp code, just the results it spits out
>>>>> (e.g. into the vdso page).
>>>> Ok, good point, we can avoid duplicating ntp code, but the vdso page
>>>> trick only works on two architectures. So, IMO, the nucleus should get
>>>> the infos, and copies them to the shared area. The question is to know
>>>> if the infos are portable/in usable units such as nanoseconds or clock
>>>> source ticks.
>>> Ok. Had a look, the info is pretty much generic. We can use it on all
>>> architectures. The point which would generate the I-pipe event is
>>> vsyscall_update.
>> completely agreed. But this required arch-specific changes to the
>> I-pipe patch and cannot be done in a generic fashion.
> 
> Well, it can be done in many ways. One of them is to create a function
> 
> static inline ipipe_vsyscall_update(whatever)
> {
> 	vsyscall_update(whatever);
> 	ipipe_dispatch_event(whatever);
> }
> 
> in linux/clocksource.h
> 
> and replace calls to vsyscall_update in generic code with a call to
> ipipe_vsyscall_update.
> 
> So, no, this does not necessarily requires arch-specific changes.
> However, changing it in the arch-specific way is probably the easier to
> maintain on the long run (if we use the method just sketched, we will
> have to check with every release if a new call to vsyscall_update
> appears). Besides, for the architectures which do not implement
> vsyscall_update (the majority, xenomai-wise, only x86 and ppc implement
> vsyscall_update), the call to ipipe_dispatch_event may be put in the
> empty implementation which may be found in linux/clocksource.h.
> 
>>>>> The kernel need to synchronize with user land, so the problem is
>>>>> (almost) the same as with obtaining the original data from Linux
>>>>> directly: user land can only use a retry or a smart fall-back mechanism
>>>>> to obtain consistent data.
>>>> Well, ok, I imagine something like a revision counter. But I do not see
>>>> how it would work on an SMP system (kernel writing on one CPU,
>>>> user-space reading on another cpu).
>>> Ok, I had a look at seqlock.h, we can do it the same way, in an area of
>>> the global heap. We will have to provide our own implementation since we
>>> can not include linux/seqlock.h in user-space. update_vsyscall on x86_64
>>> turns off the irqs, to protect against the same code or some reader
>>> being called in an interrupt handler. We will have to do the same.
>> But then the code can loop potentially unbounded, can't it? It may be
>> that I'm missing something, but this was the initial reasaon for the
>> three-buffer idea I've presented initially.
> 
> Well, on a normally running system, the update takes place for every
> Linux timer interrupt (or is it only for the periodic tick ?), anyway,
> if real-time code is running, there is no chance that it can be
> preempted by a Linux timer interrupt, and if the code is called from non
> real-time context, we do not care much.
> 
> Note that we already use such code for tsc emulation on some platforms,
> and well, it works. And this is normal, the chances to get preempted
> several times in a row by a timer interrupt without being able to
> complete the loop are pretty low. Otherwise it would mean that there are
> plenty of timer interrupts.
> 

There is another more important issue. Currently, the timer code is
designed around the idea that the parameters used for conversion between
cpu time and wall clock time do not change often, namely only when
xnpod_set_time is called. If we start using dynamic parameters for the
conversion, it will break the assumption, and break the current timer
code (namely, real-time timers expiry date will be approximate). So, we
will have to rework the real-time timers handling code.

So, I think we should focus on the ABI issue and find a way to keep
these changes for later.

-- 
					    Gilles.

