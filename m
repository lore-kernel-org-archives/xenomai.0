Message-ID: <4B952EFD.5020509@domain.hid>
Date: Mon, 08 Mar 2010 18:08:13 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <mailman.4538.1268063562.8399.xenomai-git@xenomai.org>
	<4B9527FD.3040806@domain.hid> <4B952D13.3080306@domain.hid>
In-Reply-To: <4B952D13.3080306@domain.hid>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> xenomai-git-request@domain.hid wrote:
>>> diff --git a/include/asm-generic/bits/current.h b/include/asm-generic/bits/current.h
>>> index f0e569c..b9ac680 100644
>>> --- a/include/asm-generic/bits/current.h
>>> +++ b/include/asm-generic/bits/current.h
>> ...
>>
>>> @@ -33,25 +33,16 @@ static inline xnhandle_t xeno_get_current(void)
>>>  {
>>>  	void *val = pthread_getspecific(xeno_current_key);
>>>  
>>> -	if (!val)
>>> -		return XN_NO_HANDLE;
>>> -
>>> -	return (xnhandle_t)val;
>>> +	return (xnhandle_t)val ?: xeno_slow_get_current();
>>>  }
>> So when used with normal Linux threads, this will always trigger the
>> syscall of xeno_slow_get_current()?
>>
>>> diff --git a/src/rtdk/assert_context.c b/src/rtdk/assert_context.c
>>> index bad19f3..f67bcd8 100644
>>> --- a/src/rtdk/assert_context.c
>>> +++ b/src/rtdk/assert_context.c
>>> @@ -30,12 +30,9 @@ void assert_nrt(void)
>>>  	xnthread_info_t info;
>>>  	int err;
>>>  
>>> -	if (xeno_get_current() != XN_NO_HANDLE)
>>> -		return;
>>> +	if (unlikely(xeno_get_current() != XN_NO_HANDLE &&
>>> +		     !(xeno_get_current_mode() & XNRELAX))) {
>> Then please provide a different API for assert_nrt as this makes the
>> service too heavy for common use.
> 
> It is a non real-time thread. Its performances are not critical. A
> non-blocking syscall is not that heavy. Especially compared to the
> execution time of malloc. Ok, will not argue on this any more, as
> obviously our opinions differ in that area.

Sorry, disagree. We are using it in mixed applications where both RT
latency as well as non-RT throughput matters. The assert_nrt fast was
designed to remain lightweight for both non-Xenomai threads as well as
migrated threads.

> 
> The point is that NULL (XN_NO_HANDLE) means at the same time a freed
> mode and a mode after the TSD cleanup was run. So, emitting a syscall in
> that case is the simplest thing we can do. And no, I did not find it
> expensive. But in fact, using an additional syscall, assert_nrt could be
> implemented as a simple dummy syscall which returns 0 and asks the
> caller to be put in primary mode (and it would be even lighter). So, I
> guess if you did not implemented that way, it means that you already
> wanted to avoid the syscall.

Can't follow on this yet.

The point of assert_nrt remains to issue no syscall in the fast path. We
have this in malloc, and issuing one syscall per allocation/release of
every chunk is unacceptable - my colleague will shot me!

I'm fine with changing the semantic of xeno_get_current, but please let
us add some special service that does not go beyond checking in user space.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

