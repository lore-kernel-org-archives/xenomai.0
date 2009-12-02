Message-ID: <4B16D403.1070202@domain.hid>
Date: Wed, 02 Dec 2009 21:54:27 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4B1663B9.8030306@domain.hid>	<4B166A5B.6030400@domain.hid>	<4B166EFB.8050309@domain.hid>	<4B16769A.9060700@domain.hid>	<4B167A55.8080407@domain.hid>	<4B167B4B.3010804@domain.hid>
	<4B167FC4.8080904@domain.hid>	<4B1681DA.3090108@domain.hid>
	<4B1684D7.2080501@domain.hid>	<4B1690EC.8030002@domain.hid>
	<4B16949B.2040806@domain.hid> <4B169CF7.2060108@domain.hid>
In-Reply-To: <4B169CF7.2060108@domain.hid>
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Wolfgang Mauerer <wm@domain.hid>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> I surely don't want to duplicate ntp code, just the results it spits out
>> (e.g. into the vdso page).
> 
> Ok, good point, we can avoid duplicating ntp code, but the vdso page
> trick only works on two architectures. So, IMO, the nucleus should get
> the infos, and copies them to the shared area. The question is to know
> if the infos are portable/in usable units such as nanoseconds or clock
> source ticks.

Ok. Had a look, the info is pretty much generic. We can use it on all
architectures. The point which would generate the I-pipe event is
vsyscall_update.

>> The kernel need to synchronize with user land, so the problem is
>> (almost) the same as with obtaining the original data from Linux
>> directly: user land can only use a retry or a smart fall-back mechanism
>> to obtain consistent data.
> 
> Well, ok, I imagine something like a revision counter. But I do not see
> how it would work on an SMP system (kernel writing on one CPU,
> user-space reading on another cpu).

Ok, I had a look at seqlock.h, we can do it the same way, in an area of
the global heap. We will have to provide our own implementation since we
can not include linux/seqlock.h in user-space. update_vsyscall on x86_64
turns off the irqs, to protect against the same code or some reader
being called in an interrupt handler. We will have to do the same.

> 
>>> For the HPET clocksource, well, I do not share your enthusiasm, Linux
>>> keeps complaining about the stability of the tsc of my laptop, though it
>>> is a fairly recent core2 with the "constant_tsc" flag.
>> My point is that we offer Xenomai without a real alternative to tsc for
>> many moons, and no one really stood up so far and complained about
>> missing hpet support. Just like you cannot use every SMI-infected box
>> for RT, you can't do so when the tsc is unfixably broken. I'm not sure
>> how hard hpet addition and maintenance would actually be, if it's
>> trivial, I'm fine. But I think we have more important issues to solve.
> 
> If we do not support HPET, we should have a way to know that Linux is
> currently not using tsc as its clock source, and so that the nucleus
> should ignore the corrections, otherwise we may end up with a system
> drifting even more than if Linux was not running ntp.
> 
> From the ABI point of view, we can add a member in the sysinfo
> structure, giving the address where the kernel updates the clock related
> data, if that member is NULL, the kernel does not update the clock
> related data (it can be a compile-time decision because using a too old
> I-pipe patch, or a run-time decision because Linux does not use the tsc
> as its clocksource), and clock_gettime(CLOCK_REALTIME) uses the syscall.
> We would then postpone the implementation of the non-NULL case (both in
> user-space and kernel-space) to after the initial 2.5 release. Mixing
> kernel and user from either version would not cause any issue.
> 

This still stands. But we have to handle the disabled tsc differently,
probably with a flag in the shared area. Because this can happen after
the sys info have been retrieved.

-- 
					    Gilles.

