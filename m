Message-ID: <4724CEFD.4010502@domain.hid>
Date: Sun, 28 Oct 2007 19:03:41 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <47226B5E.2050303@domain.hid> <47227713.9020804@domain.hid>
	<4722F8BD.8010401@domain.hid> <47230D83.1030001@domain.hid>
In-Reply-To: <47230D83.1030001@domain.hid>
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
>> Jan Kiszka wrote:
>>> Philippe Gerum wrote:
>>>> The I-pipe/i386 has been ported to 2.6.24-rc1, so that we could swallow
>>>> the i386/x86_64 merge which just happened upstream, without having to
>>>> fiddle at the same time with the slew of other core changes which will
>>>> hit the street before 2.6.24 is released. You need the latest trunk/ to
>>>> configure Xenomai for this kernel properly, or at least update those two
>>>> files:
>>>>
>>>> - scripts/prepare_kernel.sh
>>>> - ksrc/arch/i386/Kconfig.
>>>>
>>>> Please check if this patch runs your x86 hw reasonably well, while I'm
>>>> busy merging ksrc/arch/{i386, x86_64} on the Xenomai side. The plan is
>>>> to have a unified x86* tree for Xenomai 2.4 which has to work with all
>>>> supported kernel releases, including 2.6.24. Yes, I know we are in -rc
>>>> phase, but such merge should mostly reshuffle the directory layout, and
>>>> not the implementation per se, otherwise, it will have to wait for 2.5.
>>> [While building the new toy...] Hmm, I'm not a big fan of this schedule.
>>> Unless we want to delay Xenomai 2.4 for even more months,
>> It usually takes about 2-4 weeks to port Xenomai to a new architecture,
> 
> (To port, but not to test and mature with the help of third parties.)
>

It seems that your perception is the one of an ideal world, when asking
people to test -rc releases actually makes people download them and
hammer them badly: that's just not how it works right now for Xenomai,
at least.

Webalizer says this, not me:
http://stats.gna.org/download.gna.org/xenomai/

As a matter of fact, most people tend to start working with stable
releases directly. So the real point is: do we need this merge now? The
answer is yes, because as far as my evaluation is correct, the
cost/benefit ratio would be good for the x86* architectures, and since
we can't put such a change in any maintenance release, the only possible
solution is to push it now, or forget it until 2.5, which is far away.

The answer is a trade-off between the odds of long and painful
regressions and the benefit from making rather close codebases converge
as much as possible over time. My take is that we can do such
preparatory merge without sinking the boat.

>> so merging two existing ones on a per-file basis can't delay 2.4 for
>> months, really.
> 
> Months when we want to sync with a stable unified kernel, likely weeks
> if we just want to do the internal merge - again: including a reasonable
> test cycle via the community.
> 

Well, we must be talking about different merge approaches then, because
this evaluation is clearly off base when it comes to the undergoing
merge plan. If you suspect regressions of this kind, just don't do the
merge. But I don't suspect such long and painful regressions.

>>  we will not be
>>> able to develop the unification against any stable kernel (the
>>> unification is not yet done with 2.6.24-rc1!).
>>>
>> The unification on the Xenomai side does not depend at all on the one
>> ongoing upstream. The same way, we had the powerpc side unified for
>> 32/64bit support long before the first I-pipe against the powerpc/ tree
>> was available, and this process is even still ongoing upstream right
>> now, long after its came to an end on our side. Conversely, a unified
>> Xenomai tree for x86 would still work with older kernels, so the fact
>> that 2.6.24 is being under development has no impact for us whatsoever.
> 
> If it is decoupled from the kernel, then it doesn't matter when we
> merge, thus also no need to hurry _now_.

Taking the opportunity to have the baseline in shape as soon as
possible, so that we are able to build over it later on, at our own
pace, is anything but rushing in a brainless way.

> 
>>> *IF* such an internal refactoring of Xenomai is actually that
>>> straightforward, why not postpone it until some later 2.4 release?
>> You don't want to change the build system in any significant way for
>> stable releases, because downstream projects may rely on the way it
>> works, or on the directory layout it processes. OTOH, it is still
>> acceptable during -rc. Since we can't push this change during the stable
>> cycle, and if we don't do it during the current -rc cycle either, then
>> we would have to wait for 2.5. Our major release cycle is ~6 months
>> long, even more in the 2.4 case, this would postpone our own unification
>> work until mid-2008.
> 
> Aren't those 6 months the actual problem?
> 

I'd like a 4 months cycle actually, but I'm no wizard. 6 months is
currently the time needed to converge with the resources at hand.

>> Even if we could keep two separate trees for ages while upstream
>> provides only one, there is an opportunity to rationalize things right
>> now. If we can't do this at no significant cost, then we would wait for 2.5.
>>  I
>>> would rather prefer to role out something matured, also
>>> build-system-wise, now instead of risking to generate new regressions.
>>> But to make concreter: Do you plan to just create hal_32.c and hal_64.c,
>>> or do you then also want to merge both into hal.c?
>>>
>> I like the way upstream did this, and I intend to follow this path. The
>> point is about preparing the directory tree now, so that we may make
>> both implementations converge code-wise over time when it is sane and
>> applicable. This means hal_32/64 for now, until we decide whether having
>> a single HAL makes sense later. OTOH, there is no point in keeping
>> separate smi.c files. Again, the first step is about _preparation_,
>> which should pave the way for a deeper unification when it applies.
>> And this later work would be allowed to take place during the stable 2.4
>> series, since the framework would be already in place.
> 
> Even when focusing on infrastructure and really trivial merges, this
> thing _will_ delay the 2.4 release by at least a 1-2 weeks.

Again, I think you are off base here. This thing is likely going to
trigger frenetic tests among x86* users reading this list who happen to
rely on 2.4 already, and we should not see any earthquake following
this. Since you are among those users, well, I have no doubt that you'll
make your best to prove me wrong for that move and test even more
frenetically...

 On the other
> hand, there is still the broken blackfin arch...

And the x86_64 too - just enable AUDIT_SYSCALL. And we need the ARM
upgrade too.
label:
And we can't ask people to give more than they have when it comes to
help the project.

Making trade-offs is part of my job, and this time, the (complex,
believe me) Blackfin bug has been postponed after the x86 merge because
the latter should be closed reasonably fast, which does not mean that
the Blackfin issue is not going to be addressed. goto label.

> 
> Anyway, if you want to go this way, I will try to support the otherwise
> very appreciated approach with testing and - when required - patching.
>

Good. Actually, the merge is done. I'm compiling and running in loop
since this morning on all the platforms I have at hand. When I'm sure
than no trivial showstopper remains hidden, I'll commit the merge in one
go, and -rc6 will only consist of that big change, this way, things
would be easy to revert, if need be.

> Jan
> 


-- 
Philippe.

