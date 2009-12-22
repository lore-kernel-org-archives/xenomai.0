Message-ID: <4B30C5C1.4080406@domain.hid>
Date: Tue, 22 Dec 2009 14:12:33 +0100
From: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
MIME-Version: 1.0
References: <1261411260-839-1-git-send-email-wolfgang.mauerer@domain.hid>
	<4B30958D.6060108@domain.hid> <4B30B4D0.5010504@domain.hid>
	<4B30BA01.7060402@domain.hid>
In-Reply-To: <4B30BA01.7060402@domain.hid>
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
>>>> +enum xnshared_features {
>>>> +/*	XNSHARED_FEAT_A = 1,
>>>> +	XNSHARED_FEAT_B, */
>>>> +	XNSHARED_MAX_FEATURES,
>>>> +};
>>> Xenomai style is to use defines bit with the bit shifted directly, so,
>>> XNSHARED_FEAT_A would rather be 0x0000000000000001, and I am not sure an
>>> enum can be 64 bits.
>> oh yeah, enums are always ints, as a superficial look into the
>> ANSI standard tells me. Wasn't thinking about that. Using
>> your direct definition makes sense (although it's a bit
>> unlikely that there will ever be more than 2^32 shared
>> features...)
> 
> Err, since features are bits, the limit is 32 features, not 2^32, and if
> we make the features member an unsigned long long in the first place, it
> is because we expect to be able to use the 64 bits, no?

Argl. Yes. /me realises that christmas holidays are severely required...
> 
>>> Ok. There is a real question here. Whether we want to put this code in
>>> module.c or shadow.c. I have no definite answer. Arguments for each file:
>>>
>>> module.c: the shared area will be used for NTP by the clock/timer
>>> subsystem, so will be used in kernel-space, even without
>>> CONFIG_XENO_OPT_PERVASIVE.
>>>
>>> shadow.c: global shared heap is uncached on ARM, so, I am not sure we
>>> really want the timer/clock system to use the same area as user-space.
>>> So, we are probably better off using different copies of the same data
>>> in kernel-space and user-space (with a price of a copy every time the
>>> data change and CONFIG_XENO_OPT_PERVASIVE is enabled). This would allow
>>> us to move that code in shadow.c
>> Is there any compelling advantage for shadow.c? Using a copy operation
>> every time the data change seems a bit contrary to the reason for
>> the new mechanism in the first place, namely to have a light-weight
>> means of sharing data.
> 
> The way I see it, the NTP data will be used by the nucleus clock and
> timer subsystem, so several times for each timer tick, so having them on
> an uncached memory will have a performance hit.
> 
> The copy, on the other hand, would take place over a non real-time
> context, only once every update of NTP data, i.e. once every 10ms.

> So, let us move it to shadow.c.

I see your point, but it has the disadvantage that the time spent
in the Linux kernel for the copy operations in the vsyscall is
increased -- which might affect the Linux domain, since this is
an optimised hot path. Naturally, in the absence of any quantitative
measurements, this is all just speculation, but if access to the global
semaphore heap is unchached only on ARM, we provide an unnecessary
optimisation for n-1 out of n architectures supported by Xenomai.

Having the time-keeping code in the Xenomai kernel benefit from NTP
corrections provided by the Linux side is a bit separate from the
ABI change, which would be the same irregardless of whether we
use a second copy for kernel-side NTP operations or not. Would it
therefore make sense to restrict the data exchange to the global heap
semaphore, and add an architecture-specific hook for ARM
later on to generate an extra kernel space copy of the NTP data? The
Linux vsyscall time keeping information is architecture-specific, so
arch specific hooks make sense in this area anyway. We could therefore
restrict the second copy to ARM without much effort. Or am I missing
something in your considerations?

>>>>  	
>>>>  #ifdef __KERNEL__
>>>> diff --git a/ksrc/nucleus/shadow.c b/ksrc/nucleus/shadow.c
>>>> index 0c94a60..0373a8d 100644
>>>> --- a/ksrc/nucleus/shadow.c
>>>> +++ b/ksrc/nucleus/shadow.c
>>>> @@ -50,6 +50,7 @@
>>>>  #include <nucleus/trace.h>
>>>>  #include <nucleus/stat.h>
>>>>  #include <nucleus/sys_ppd.h>
>>>> +#include <nucleus/xnshared.h>
>>>>  #include <asm/xenomai/features.h>
>>>>  #include <asm/xenomai/syscall.h>
>>>>  #include <asm/xenomai/bits/shadow.h>
>>>> @@ -1746,6 +1747,9 @@ static int xnshadow_sys_info(struct pt_regs *regs)
>>>>  
>>>>  	info.cpufreq = xnarch_get_cpu_freq();
>>>>  
>>>> +	info.xnshared_offset =
>>>> +	  xnheap_mapped_offset(&xnsys_ppd_get(1)->sem_heap, xnshared);
>>>> +
>>>>  	return __xn_safe_copy_to_user((void __user *)infarg, &info, sizeof(info));
>>>>  }
>>>>  
>>> And the user-space part? It would be nice to at least define the
>>> structure in user-space and read the "features" member, to check that
>>> the inclusion of the nucleus/xnshared header works and that we read 0
>>> and there is no gag on all architectures
> 
> We can not expect to read 0, since we want this user-space to continue
> working with later versions of the ABI. Actually, we can not expect
> features to be of an specific form (I was thinking (1 << max_bit) - 1,
> but it would mean that we can not remove feature bits).
> 
>> I haven't included the userland part on purpose because I wanted
>> to make sure that the ABI change is merged for 2.5 - all the rest
>> can be added later without problems. It will follow once I've
>> polished the code (if having the userland part should be
>> a prerequisite for merging the ABI change, I can try to speed
>> things up a bit; otherwise, I'd submit the userland read side
>> together with the NTP base mechanics).
> 
> It would be embarassing (though unlikely) to think having changed the
> ABI, and finally find out, when we start to use it, that the ABI change
> does not work. So, please add the user-space code. So, that our run-time
> tests on various architectures can be used to check that the
> modification actually works.
> 
> The really really nice thing to do, would be a unit test which checks
> for a specific value of the ABI features. So, we can run
> "check_xeno_abi_features 0", to check that the thing actually works with
> release 2.5.0.

okay, so I'll make sure to have the userland bits ready in time
before the 2.5.0 release.

Cheers, Wolfgang

