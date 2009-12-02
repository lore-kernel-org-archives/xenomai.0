Message-ID: <4B169CF7.2060108@domain.hid>
Date: Wed, 02 Dec 2009 17:59:35 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4B1663B9.8030306@domain.hid>
	<4B166A5B.6030400@domain.hid>	<4B166EFB.8050309@domain.hid>
	<4B16769A.9060700@domain.hid>	<4B167A55.8080407@domain.hid>
	<4B167B4B.3010804@domain.hid> <4B167FC4.8080904@domain.hid>
	<4B1681DA.3090108@domain.hid> <4B1684D7.2080501@domain.hid>
	<4B1690EC.8030002@domain.hid> <4B16949B.2040806@domain.hid>
In-Reply-To: <4B16949B.2040806@domain.hid>
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Wolfgang Mauerer <wm@domain.hid>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>> Gilles Chanteperdrix wrote:
>>>> Jan Kiszka wrote:
>>>>> Gilles Chanteperdrix wrote:
>>>>>> Jan Kiszka wrote:
>>>>>>> Why? It delivers us the core mechanism we need for the rest as well -
>>>>>>> and it does not require fancy I-pipe hooks.
>>>>>> Because relying on the vdso/vsyscall only works on x86. Whereas
>>>>>> implementing clock slew down/acceleration at nucleus level and simply
>>>>>> sharing data between kernel and user through the the global sem heap,
>>>>>> works for all architectures.
>>>>> There are three kind of archs:
>>>>>  - those that already support vgettimeofday & friends (x86, powerpc,
>>>>>    maybe more)
>>>>>  - those that do not yet though they could (I strongly suspect arm falls
>>>>>    into this category as well)
>>>>>  - those that never will (due to lacking user-readable time sources)
>>>>>
>>>>> We need temporary/permanent i-pipe workarounds for the last two, but I
>>>>> see no point in complicating the first category. This design aims at a
>>>>> longer term.
>>>> Well, I may be wrong, but I prefer generic code to arch-specific code.
>>>> Nucleus code to handle clock slow down/acceleration would be generic;
>>>> I-pipe code to signal NTP syscalls would be generic (and yes, even if
>>>> I-pipe patches are generated for all architectures, whether the code is
>>>> generic or specific makes a big difference);
>>>> User-space code to implement clock_gettime(CLOCK_REALTIME) using data
>>>> shared through the global sem heap would be generic.
>>>>
>>>> So, I think this design is future proof and easy to maintain. And I do
>>>> not see how it complicates x86 situation, since it is only made of
>>>> generic code.
>>> Well, OK, then place a small optional I-pipe hook into that part that
>>> normally writes the update into the vdso page (I think that is
>>> arch-specific anyway), replicating it into a specified page the nucleus
>>> may set up on a globally shared heap. That hook also has to maintain a
>>> seqlock like Linux does, ie. generating the same layout and semantics.
>>> It's just the transport mechanism, we can easily select it based on the
>>> arch's level of support.
>>>
>>> But I'm against any needless redirection through the nucleus (including
>>> potential nklocks etc.).
>> I do not really understand why you want to use the vdso page, since we
>> have the global sem heap anyway. clock_gettime already has a mean to
>> read a clock source and the frequency of this clock source, this is
>> guaranteed on all platforms, so I think the correction code can be made
>> generic.
> 
> Again, the page is not the point, what it contains is important. Our
> currently published data is not sufficient to support dynamic updates,
> but the vdso _contains_ all the data we could reuse with an enhanced
> algorithm to provide a dynamically adjusted time base.
> 
>> However, duplicating the ntp related kernel code may be the real issue.
>> I have to look at that code to see how complex it is.
> 
> I surely don't want to duplicate ntp code, just the results it spits out
> (e.g. into the vdso page).

Ok, good point, we can avoid duplicating ntp code, but the vdso page
trick only works on two architectures. So, IMO, the nucleus should get
the infos, and copies them to the shared area. The question is to know
if the infos are portable/in usable units such as nanoseconds or clock
source ticks.

> 
>> For the locking, well, if we have variables on a shared area to update
>> every time ntp corrects the clock, we will have problems doing it under
>> nklock anyway (the irq locking prevents from preemption on the local
>> cpu, but does not prevent the remote cpus running user-space programs
>> from accessing the shared area). So, we will have to devise some locking
>> mechanisms. But I do not see the reason for making this linux
>> compatible. If we keep the nucleus business separated, the nucleus
>> shared area will never have to be accessed by plain Linux, which will
>> access its area in the vdso, the Linux kernel doing its house keeping.
> 
> The kernel need to synchronize with user land, so the problem is
> (almost) the same as with obtaining the original data from Linux
> directly: user land can only use a retry or a smart fall-back mechanism
> to obtain consistent data.

Well, ok, I imagine something like a revision counter. But I do not see
how it would work on an SMP system (kernel writing on one CPU,
user-space reading on another cpu).

> 
>> For the HPET clocksource, well, I do not share your enthusiasm, Linux
>> keeps complaining about the stability of the tsc of my laptop, though it
>> is a fairly recent core2 with the "constant_tsc" flag.
> 
> My point is that we offer Xenomai without a real alternative to tsc for
> many moons, and no one really stood up so far and complained about
> missing hpet support. Just like you cannot use every SMI-infected box
> for RT, you can't do so when the tsc is unfixably broken. I'm not sure
> how hard hpet addition and maintenance would actually be, if it's
> trivial, I'm fine. But I think we have more important issues to solve.

If we do not support HPET, we should have a way to know that Linux is
currently not using tsc as its clock source, and so that the nucleus
should ignore the corrections, otherwise we may end up with a system
drifting even more than if Linux was not running ntp.

>From the ABI point of view, we can add a member in the sysinfo
structure, giving the address where the kernel updates the clock related
data, if that member is NULL, the kernel does not update the clock
related data (it can be a compile-time decision because using a too old
I-pipe patch, or a run-time decision because Linux does not use the tsc
as its clocksource), and clock_gettime(CLOCK_REALTIME) uses the syscall.
We would then postpone the implementation of the non-NULL case (both in
user-space and kernel-space) to after the initial 2.5 release. Mixing
kernel and user from either version would not cause any issue.

-- 
                                          Gilles


