Message-ID: <4B952D13.3080306@domain.hid>
Date: Mon, 08 Mar 2010 18:00:03 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <mailman.4538.1268063562.8399.xenomai-git@xenomai.org>
	<4B9527FD.3040806@domain.hid>
In-Reply-To: <4B9527FD.3040806@domain.hid>
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
> xenomai-git-request@domain.hid wrote:
>> diff --git a/include/asm-generic/bits/current.h b/include/asm-generic/bits/current.h
>> index f0e569c..b9ac680 100644
>> --- a/include/asm-generic/bits/current.h
>> +++ b/include/asm-generic/bits/current.h
> 
> ...
> 
>> @@ -33,25 +33,16 @@ static inline xnhandle_t xeno_get_current(void)
>>  {
>>  	void *val = pthread_getspecific(xeno_current_key);
>>  
>> -	if (!val)
>> -		return XN_NO_HANDLE;
>> -
>> -	return (xnhandle_t)val;
>> +	return (xnhandle_t)val ?: xeno_slow_get_current();
>>  }
> 
> So when used with normal Linux threads, this will always trigger the
> syscall of xeno_slow_get_current()?
> 
>> diff --git a/src/rtdk/assert_context.c b/src/rtdk/assert_context.c
>> index bad19f3..f67bcd8 100644
>> --- a/src/rtdk/assert_context.c
>> +++ b/src/rtdk/assert_context.c
>> @@ -30,12 +30,9 @@ void assert_nrt(void)
>>  	xnthread_info_t info;
>>  	int err;
>>  
>> -	if (xeno_get_current() != XN_NO_HANDLE)
>> -		return;
>> +	if (unlikely(xeno_get_current() != XN_NO_HANDLE &&
>> +		     !(xeno_get_current_mode() & XNRELAX))) {
> 
> Then please provide a different API for assert_nrt as this makes the
> service too heavy for common use.

It is a non real-time thread. Its performances are not critical. A
non-blocking syscall is not that heavy. Especially compared to the
execution time of malloc. Ok, will not argue on this any more, as
obviously our opinions differ in that area.

The point is that NULL (XN_NO_HANDLE) means at the same time a freed
mode and a mode after the TSD cleanup was run. So, emitting a syscall in
that case is the simplest thing we can do. And no, I did not find it
expensive. But in fact, using an additional syscall, assert_nrt could be
implemented as a simple dummy syscall which returns 0 and asks the
caller to be put in primary mode (and it would be even lighter). So, I
guess if you did not implemented that way, it means that you already
wanted to avoid the syscall.

-- 
					    Gilles.

