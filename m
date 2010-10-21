Message-ID: <4CC00958.5010900@domain.hid>
Date: Thu, 21 Oct 2010 11:35:20 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4CBE77DD.8050601@domain.hid> <4CBFEDA3.8020606@domain.hid>
	<4CBFF6F7.6060905@domain.hid> <4CC007AD.30303@domain.hid>
In-Reply-To: <4CC007AD.30303@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] hostrt broken on ARM.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Wolfgang Mauerer wrote:
> Gilles Chanteperdrix wrote:
>> Wolfgang Mauerer wrote:
>>> Gilles Chanteperdrix wrote:
>>>
>>>> the hostrt stuff did not compile on ARM, at this chance, I had a look 
>>>> and found a few things which I did not like:
>>>> - the kernel-space and user-space did not use seqcount implementations 
>>>> from the same header, and what is more, seqcount is not available on 2.4
>>>> kernels. Since we provide an implementation anyway, I changed the code 
>>>> so that only this implementation is used both in kernel-space and 
>>>> user-space. Prefixing everything with xn to avoid namespace clashes.
>>> that makes sense, good point!
>>>
>>>> - the xnarch_hostrt_data also had two different definitions, one for 
>>>> user-space, one for kernel-space, since this definition is supposed to 
>>>> come from newer I-pipe in kernel-space, the code did not compile with 
>>>> older I-pipe patches. I separated xnarch_hostrt_data, the structure 
>>>> passed by the I-pipe to do_hostrt_event, from xnvdso_hostrt_data, the 
>>>> structure, part of the vdso used for exchanges between user-space and 
>>>> kernel-space. We can now get xnvdso_hostrt_data defined all the time. We
>>>> can probably even move xnvdso_hostrt_data definition to vdso.h
>>> I assume your main intention is to fix the Xenomai compile when the
>>> underlying ipipe does not support hostrt? But when the ipipe layer is
>>> too old for hostrt, it does not really make sense to include hostrt
>>> support in the vdso -- it may be cleaner to define an empty
>>> stub for struct xnarch_hostrt when ipipe does not provide hostrt info.
>> No. The point is to avoid the comment: "hell will break loose if this
>> struct is not keep in sync with one defined by the I-pipe". Having two
>> pieces of code relying on different headers to get the same structure
>> defined is really shooting ourself in the foot and asking for more. The
>> only case where we can admit that is when one piece of code is assembly.
>> And even then, it is dangerous (look at the linux kernel code, the
>> developers devised asm-offsets.h to solve exactly this issue).
>>
>> Besides, having two structures defined for the two different layers
>> allows us to modify one structure without any impact on the other.
>>
>> Keeping the structure defined even if the I-pipe does not define it is
>> just a side effect which avoids #ifdefery. The vdso is part of a heap
>> mapped in user-space, so the granularity is 4 Kbi, we do not really care
>> about a structure we do not use. But this is debatable, I agree.
> It'd be nicer to eliminate it when there's no support for it, but no
> religious issue here.

The point is that if we want to do that, we have a user-space issue,
user-space has no CONFIG_* to know whether the structure definition is
needed. So, having the structure defined at all times is the simpler
solution.

>>>> - avoided cycle_t and u32 in order to avoid user-space namespace 
>>>> pollution and need for many typedefs with 2.4 kernels. Using unsigned 
>>>> long long directly instead of cycle_t revealed a bug in clocktest.c.
>>> While typedefs are generally debatable, the intention here was to
>>> create as much symmetry with the Linux kernel implementation as
>>> possible since this code is fairly well tested. I cannot
>>> point to any particular problem with the non-fixed-width definitions,
>>> but with them, we do at least avoid the possibility of introducing
>>> any scaled math issues.
>> unsigned long long is 64 bits
>> unsigned is 32 bits
>> unsigned long has the natural processor word size.
>> So, in reality, they are fixed width definitions. Portable accross all
>> architectures supported by Linux. No typedefs needed.
> 
> that's correct for almost all programming models (and all reasonable
> ones, and certainly for everything the kernel runs on AFIK), but I still
> don't see a benefit in removing analogies to the kernel for no
> particular gain. A few lines before, you argued that things should
> resemble the kernel approach.

The gain is #ifdefery again, with multiple typedefs which need to be
tested in all conditions in order to be sure that we do not clash or
miss the definition in some conditions (2.4 kernel for instance).
Besides, with the cycle_t define, we had an undetected bug in
clocktest.c. And typedefs would leak in user-space. I do not really like
to take the decision to forbid Xenomai users to use the cycle_t typedef
in their application for their own purposes.

-- 
					    Gilles.

