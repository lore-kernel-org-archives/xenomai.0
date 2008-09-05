Message-ID: <48C1022F.6040903@domain.hid>
Date: Fri, 05 Sep 2008 11:55:59 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48BBA9E6.5070400@domain.hid> <48BBAB67.90707@domain.hid>
	<48C0EF18.2030400@domain.hid> <48C0FEA6.2050807@domain.hid>
	<48C0FFF6.1020305@domain.hid> <48C100FD.8020908@domain.hid>
In-Reply-To: <48C100FD.8020908@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH 2/9] Switch to handle-based fast mutex
 owners	- v2
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
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
>> Gilles Chanteperdrix wrote:
>>> Jan Kiszka wrote:
>>>> @@ -230,18 +230,20 @@ static inline int mutex_save_count(xnthr
>>>>  
>>>>  	mutex = shadow->mutex;
>>>>  
>>>> -	if (clear_claimed(xnarch_atomic_intptr_get(mutex->owner)) != cur)
>>>> +	if (clear_claimed(xnarch_atomic_get(mutex->owner)) !=
>>>> +	    xnthread_handle(cur))
>>>>  		return EPERM;
>>>>  
>>>>  	*count_ptr = shadow->lockcnt;
>>>>  
>>>> -	if (likely(xnarch_atomic_intptr_cmpxchg(mutex->owner, cur, NULL) == cur))
>>>> +	if (likely(xnarch_atomic_cmpxchg(mutex->owner, cur, XN_NO_HANDLE) ==
>>>> +		   xnthread_handle(cur)))
>>>>  		return 0;
>>>>  
>>>>  	owner = xnsynch_wakeup_one_sleeper(&mutex->synchbase);
>>>> -	xnarch_atomic_intptr_set
>>>> -		(mutex->owner,
>>>> -		 set_claimed(owner,xnsynch_nsleepers(&mutex->synchbase)));
>>>> +	xnarch_atomic_set(mutex->owner,
>>>> +			  set_claimed(xnthread_handle(owner),
>>>> +				      xnsynch_nsleepers(&mutex->synchbase)));
>>> Ok. Can we avoid xnthread_handle() everywhere by storing its result in a
>>> local variable and reusing this local variable, here and in the other
>>> functions where xnthread_handle is used multiple times ?
>> True for 'cur' here (will fix), but the other case have already been
>> optimized as far as possible (i.e. within the respective scope).
> 
> I have found several other spots where xnthread_handle is called
> multiple times in the same function. mutex_unlock comes to my mind.

Please point me to the concrete spot. I went again through all
xnthread_handle instances in this patch, checking that they aren't
needed due to owner changes, but only found the one above. Specifically
pthread_mutex_unlock, pse51_mutex_unlock_internal and
__pthread_mutex_unlock have only a single reference or reference
different threads.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

