Message-ID: <4722F8BD.8010401@domain.hid>
Date: Sat, 27 Oct 2007 10:37:17 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <47226B5E.2050303@domain.hid> <47227713.9020804@domain.hid>
In-Reply-To: <47227713.9020804@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] I-pipe/i386 for 2.6.24-rc1 - x86/x86_64 merge to
 come
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Philippe Gerum wrote:
>> The I-pipe/i386 has been ported to 2.6.24-rc1, so that we could swallow
>> the i386/x86_64 merge which just happened upstream, without having to
>> fiddle at the same time with the slew of other core changes which will
>> hit the street before 2.6.24 is released. You need the latest trunk/ to
>> configure Xenomai for this kernel properly, or at least update those two
>> files:
>>
>> - scripts/prepare_kernel.sh
>> - ksrc/arch/i386/Kconfig.
>>
>> Please check if this patch runs your x86 hw reasonably well, while I'm
>> busy merging ksrc/arch/{i386, x86_64} on the Xenomai side. The plan is
>> to have a unified x86* tree for Xenomai 2.4 which has to work with all
>> supported kernel releases, including 2.6.24. Yes, I know we are in -rc
>> phase, but such merge should mostly reshuffle the directory layout, and
>> not the implementation per se, otherwise, it will have to wait for 2.5.
> 
> [While building the new toy...] Hmm, I'm not a big fan of this schedule.
> Unless we want to delay Xenomai 2.4 for even more months,

It usually takes about 2-4 weeks to port Xenomai to a new architecture,
so merging two existing ones on a per-file basis can't delay 2.4 for
months, really.

 we will not be
> able to develop the unification against any stable kernel (the
> unification is not yet done with 2.6.24-rc1!).
>

The unification on the Xenomai side does not depend at all on the one
ongoing upstream. The same way, we had the powerpc side unified for
32/64bit support long before the first I-pipe against the powerpc/ tree
was available, and this process is even still ongoing upstream right
now, long after its came to an end on our side. Conversely, a unified
Xenomai tree for x86 would still work with older kernels, so the fact
that 2.6.24 is being under development has no impact for us whatsoever.

> *IF* such an internal refactoring of Xenomai is actually that
> straightforward, why not postpone it until some later 2.4 release?

You don't want to change the build system in any significant way for
stable releases, because downstream projects may rely on the way it
works, or on the directory layout it processes. OTOH, it is still
acceptable during -rc. Since we can't push this change during the stable
cycle, and if we don't do it during the current -rc cycle either, then
we would have to wait for 2.5. Our major release cycle is ~6 months
long, even more in the 2.4 case, this would postpone our own unification
work until mid-2008.

Even if we could keep two separate trees for ages while upstream
provides only one, there is an opportunity to rationalize things right
now. If we can't do this at no significant cost, then we would wait for 2.5.
 I
> would rather prefer to role out something matured, also
> build-system-wise, now instead of risking to generate new regressions.
> But to make concreter: Do you plan to just create hal_32.c and hal_64.c,
> or do you then also want to merge both into hal.c?
>

I like the way upstream did this, and I intend to follow this path. The
point is about preparing the directory tree now, so that we may make
both implementations converge code-wise over time when it is sane and
applicable. This means hal_32/64 for now, until we decide whether having
a single HAL makes sense later. OTOH, there is no point in keeping
separate smi.c files. Again, the first step is about _preparation_,
which should pave the way for a deeper unification when it applies.
And this later work would be allowed to take place during the stable 2.4
series, since the framework would be already in place.

>> At the end of the day (i.e. sometime during the v2.4 maintenance cycle),
>> we should have the I-pipe/x86_64 merged with the I-pipe/i386 support,
>> leading to the I-pipe/x86-2.0 series, on top of 2.6.24, and all of that
>> usable with a unified ia32/64 Xenomai support, which is basically what
>> we already have now on the powerpc side of the universe.
>>
>> http://download.gna.org/adeos/patches/v2.6/i386/adeos-ipipe-2.6.24-rc1-i386-1.10-11.patch
>>
>> PS: slightly tested here. Looks ok, sun is still shining, birds are
>> still singing, hardware is not burning - yet.
>>
> 
> Will let you know the result from my box soon.
> 
> Jan
> 


-- 
Philippe.

