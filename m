Message-ID: <48AEE285.1000803@domain.hid>
Date: Fri, 22 Aug 2008 18:00:05 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <48AEBA77.2040608@domain.hid> <48AEC742.4090902@domain.hid>
	<48AEC8DC.20406@domain.hid> <48AECCAD.7030405@domain.hid>
	<48AED396.3040903@domain.hid> <48AED454.3050701@domain.hid>
	<48AED7A4.20604@domain.hid> <48AED929.8040708@domain.hid>
	<48AEE03E.1080607@domain.hid> <48AEE154.2000103@domain.hid>
	<48AEE1C1.2040208@domain.hid>
In-Reply-To: <48AEE1C1.2040208@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] userspace: Make CONFIG_SMP default
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
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>> Gilles Chanteperdrix wrote:
>>>> Jan Kiszka wrote:
>>>>> Gilles Chanteperdrix wrote:
>>>>>> Jan Kiszka wrote:
>>>>>>> Gilles Chanteperdrix wrote:
>>>>>>>> Jan Kiszka wrote:
>>>>>>>>> Gilles Chanteperdrix wrote:
>>>>>>>>>> Jan Kiszka wrote:
>>>>>>>>>>> Disabling SMP (on platforms where this isn't off by design already) is
>>>>>>>>>>> an optimization. In contrast, not enabling it by default is doomed to
>>>>>>>>>>> cause problems for users that run ./configure without looking into each
>>>>>>>>>>> and every switch - now that CONFIG_SMP is very important for all the
>>>>>>>>>>> fast locking stuff.
>>>>>>>>>> I would consider setting CONFIG_SMP by default on x86... because on some
>>>>>>>>>> other architectures like arm, it is not even yet a valid configuration.
>>>>>>>>> But it is on PowerPC or IA64. Would it cause troubles for the
>>>>>>>>> non-SMP-ready archs? Then we can disable it on those selectively.
>>>>>>>> Are you sure that the lock prefix on an UP x86 or lsync on an UP powerpc
>>>>>>>> is hamrless ?
>>>>>>> LOCK is harmless (except for potential overhead), can't comment isync,
>>>>>>> but I strongly suspect the same (locking at the glibc e.g.). There is a
>>>>>>> simple idea behind this: Do you have to install a special glibc in order
>>>>>>> to enable/disable SMP support?
>>>>>>>
>>>>>>> [ BTW, I think the current pthread_mutex implementation lacks the LOCK
>>>>>>> prefix even in SMP mode due to include issues. Will get fixed with my
>>>>>>> patches under preparation, which also unifies that stuff on x86. ]
>>>>>> Should be easy to check, disassemble pthread_mutex_lock with CONFIG_SMP
>>>>>> enabled.
>>>>>>
>>>>>> You mean we should include asm/xenomai/features.h before using CONFIG_SMP ?
>>>>> That helps as well - I added xeno_config.h explicitly so far, but
>>>>> features.h implies xeno_config.h, of course.
>>>> asm/xenomai/features.h does convert the configure.in options into the
>>>> kernel "namespace" options. But it seems that CONFIG_SMP is directly set
>>>> by configure.in anyway.
>>>>
>>>>> Jan - who seems to have run into alignment issues of cmpxchg on x86_64
>>>> pthread_mutex_lock uses xnheap_alloc to allocate the piece of memory
>>>> used for the mutex. So, if the piece of memory is not eight bytes
>>>> aligned, this is xnheap_alloc's fault...
>>> Maybe it's far simpler: XNARCH_HAVE_US_ATOMIC_CMPXCHG - where the heck
>>> does this come from? I just thought I only forgot to define it for
>>> x86_64, but I don't find any traces for 32-bit as well. Hmm, should this
>>> be called "CONFIG_XENO_FASTSEM" now? Testing...
>> Yes, XNARCH_HAVE_US_ATOMIC_CMPXCHG is dead now, it was replaced with
>> CONFIG_XENO_FASTSEM.
>> CONFIG_XENO_FASTSEM, in turn is set by Kconfig in kernel space, and
>> configure.in in user-space.
>>
> 
> Then this should fix fastsem support again (still preparing the
> test...):

Yes, please commit.

-- 
                                                 Gilles.

