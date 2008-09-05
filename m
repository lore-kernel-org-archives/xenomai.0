Message-ID: <48C0FEA6.2050807@domain.hid>
Date: Fri, 05 Sep 2008 11:40:54 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <48BBA9E6.5070400@domain.hid> <48BBAB67.90707@domain.hid>
	<48C0EF18.2030400@domain.hid>
In-Reply-To: <48C0EF18.2030400@domain.hid>
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> @@ -230,18 +230,20 @@ static inline int mutex_save_count(xnthr
>  
>  	mutex = shadow->mutex;
>  
> -	if (clear_claimed(xnarch_atomic_intptr_get(mutex->owner)) != cur)
> +	if (clear_claimed(xnarch_atomic_get(mutex->owner)) !=
> +	    xnthread_handle(cur))
>  		return EPERM;
>  
>  	*count_ptr = shadow->lockcnt;
>  
> -	if (likely(xnarch_atomic_intptr_cmpxchg(mutex->owner, cur, NULL) == cur))
> +	if (likely(xnarch_atomic_cmpxchg(mutex->owner, cur, XN_NO_HANDLE) ==
> +		   xnthread_handle(cur)))
>  		return 0;
>  
>  	owner = xnsynch_wakeup_one_sleeper(&mutex->synchbase);
> -	xnarch_atomic_intptr_set
> -		(mutex->owner,
> -		 set_claimed(owner,xnsynch_nsleepers(&mutex->synchbase)));
> +	xnarch_atomic_set(mutex->owner,
> +			  set_claimed(xnthread_handle(owner),
> +				      xnsynch_nsleepers(&mutex->synchbase)));

Ok. Can we avoid xnthread_handle() everywhere by storing its result in a
local variable and reusing this local variable, here and in the other
functions where xnthread_handle is used multiple times ?

-- 
                                                 Gilles.

