Message-ID: <4B966637.8020007@domain.hid>
Date: Tue, 09 Mar 2010 16:16:07 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <mailman.4538.1268063562.8399.xenomai-git@xenomai.org>
	<4B9527FD.3040806@domain.hid> <4B952D13.3080306@domain.hid>
	<4B952EFD.5020509@domain.hid> <4B95308A.1000309@domain.hid>
	<4B96592A.9060707@domain.hid> <4B96600C.8060600@domain.hid>
In-Reply-To: <4B96600C.8060600@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Xenomai-git] common: do not let u_mode
 exceptional cases leak out of current.[ch]
List-Id: Xenomai life and development <xenomai.xenomai.org>
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
>>> Jan Kiszka wrote:
>>>> Gilles Chanteperdrix wrote:
>>>>> Jan Kiszka wrote:
>>>>>> xenomai-git-request@domain.hid wrote:
>>>>>>> diff --git a/include/asm-generic/bits/current.h b/include/asm-generic/bits/current.h
>>>>>>> index f0e569c..b9ac680 100644
>>>>>>> --- a/include/asm-generic/bits/current.h
>>>>>>> +++ b/include/asm-generic/bits/current.h
>>>>>> ...
>>>>>>
>>>>>>> @@ -33,25 +33,16 @@ static inline xnhandle_t xeno_get_current(void)
>>>>>>>  {
>>>>>>>  	void *val = pthread_getspecific(xeno_current_key);
>>>>>>>  
>>>>>>> -	if (!val)
>>>>>>> -		return XN_NO_HANDLE;
>>>>>>> -
>>>>>>> -	return (xnhandle_t)val;
>>>>>>> +	return (xnhandle_t)val ?: xeno_slow_get_current();
>>>>>>>  }
>>>>>> So when used with normal Linux threads, this will always trigger the
>>>>>> syscall of xeno_slow_get_current()?
>>>>>>
>>>>>>> diff --git a/src/rtdk/assert_context.c b/src/rtdk/assert_context.c
>>>>>>> index bad19f3..f67bcd8 100644
>>>>>>> --- a/src/rtdk/assert_context.c
>>>>>>> +++ b/src/rtdk/assert_context.c
>>>>>>> @@ -30,12 +30,9 @@ void assert_nrt(void)
>>>>>>>  	xnthread_info_t info;
>>>>>>>  	int err;
>>>>>>>  
>>>>>>> -	if (xeno_get_current() != XN_NO_HANDLE)
>>>>>>> -		return;
>>>>>>> +	if (unlikely(xeno_get_current() != XN_NO_HANDLE &&
>>>>>>> +		     !(xeno_get_current_mode() & XNRELAX))) {
>>>>>> Then please provide a different API for assert_nrt as this makes the
>>>>>> service too heavy for common use.
>>>>> It is a non real-time thread. Its performances are not critical. A
>>>>> non-blocking syscall is not that heavy. Especially compared to the
>>>>> execution time of malloc. Ok, will not argue on this any more, as
>>>>> obviously our opinions differ in that area.
>>>> Sorry, disagree. We are using it in mixed applications where both RT
>>>> latency as well as non-RT throughput matters. The assert_nrt fast was
>>>> designed to remain lightweight for both non-Xenomai threads as well as
>>>> migrated threads.
>>>>
>>>>> The point is that NULL (XN_NO_HANDLE) means at the same time a freed
>>>>> mode and a mode after the TSD cleanup was run. So, emitting a syscall in
>>>>> that case is the simplest thing we can do. And no, I did not find it
>>>>> expensive. But in fact, using an additional syscall, assert_nrt could be
>>>>> implemented as a simple dummy syscall which returns 0 and asks the
>>>>> caller to be put in primary mode (and it would be even lighter). So, I
>>>>> guess if you did not implemented that way, it means that you already
>>>>> wanted to avoid the syscall.
>>>> Can't follow on this yet.
>>> ...specifically as an unset current key is a bug for a Xenomai thread.
>>> Every skin library is supposed to set it, so there should be no need for
>>> falling back to a syscall for them, and there is no point in trying it
>>> for non-Xenomai threads.
>>>
>>> So why this fallback? Does it simplify something else that I miss ATM?
>> So, to summarize, the problem here, is that current == XN_NO_HANDLE may
>> mean that the current thread is not a real-time thread, or that it is a
>> real-time thread, but that we are in the TSD cleanup, and the current
>> TSD was set to 0, as is done for TSD which have no destructor.
>>
>> We need get_current() to be correct, for the implementation of mutexes,
>> and in that case we want the additional syscall.
> 
> Right, at least for !HAVE___THREAD. For HAVE___THREAD, I don't see a
> need for a syscall. Do you?

No, I would think gcc/glibc probably guarantees that no user-space code
is ever executed in a context where the __thread variable has an
unexpected value, that would be silly.

> 
>> We need get_current()
>> to be correct for clock_gettime(), because as I understand, calling
>> linux' vdso clock_gettime may deadlock if we are not in secondary mode,
>> I do not know if you think that using a syscall for clock_gettime over
>> plain linux threads matters in that case.
>>
>> For the wrapping of malloc and free, I would say we do not really care
>> to absolutely get the real current. I do not think that a syscall for
>> each call to malloc and free is that prohibitive, their execution time
>> may already been long anyway, and the current implementation is correct.
>> It is only sub-optimal for your very peculiar case, so, I will let you
>> sweat on this issue.
> 
> I will post a patch to add a "less-accurate" check for an
> assert_nrt_fast variant. As this only reduces accuracy for TSD
> destructor contexts, and that only under !HAVE___THREAD, I don't think
> it justifies the additional syscall for the majority of use cases of
> assert_nrt. But let's make the user choose the accuracy (s)he
> explicitly: assert_nrt for always correct results, assert_nrt_fast for
> syscall-less checks with known (and to-be-documented) limitations.

Ok. But please hide the syscall in current.h, for the case where there
would be other users of the fast mode.

-- 
					    Gilles.

