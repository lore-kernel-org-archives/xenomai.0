Message-ID: <48B568FD.9010905@domain.hid>
Date: Wed, 27 Aug 2008 16:47:25 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <48B5592B.1090005@domain.hid> <48B55F7C.5030901@domain.hid>
	<48B56685.4060500@domain.hid> <48B56876.3090601@domain.hid>
In-Reply-To: <48B56876.3090601@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [RFC][PATCH 2/3] Switch to handle-based fast
	mutex owners
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
>>
>>> -#define test_claimed(owner) ((long) (owner) & 1)
>>> -#define clear_claimed(owner) ((xnthread_t *) ((long) (owner) & ~1))
>>> -#define set_claimed(owner, bit) \
>>> -        ((xnthread_t *) ((long) clear_claimed(owner) | !!(bit)))
>>> +#define __CLAIMED_BIT		XN_HANDLE_SPARE3
>>> +
>>> +#define test_claimed(owner)	xnhandle_test_spare(owner, __CLAIMED_BIT)
>>> +#define clear_claimed(owner)	xnhandle_mask_spare(owner)
>>> +#define set_claimed(owner, bit) ({ \
>>> +	xnhandle_t __tmp = xnhandle_mask_spare(owner); \
>>> +	if (bit) \
>>> +		xnhandle_set_spare(__tmp, __CLAIMED_BIT); \
>>> +	__tmp; \
>>> +})
>> I liked doing this with no conditional.
> 
> You mean let the caller pass 'bit' as 0 or __CLAIMED_BIT (the latter
> would require some renaming then, I guess)?
> 
>>> +	xnarch_atomic_set(mutex->owner,
>>> +		 	  set_claimed(xnthread_handle(owner),
>>> +				      xnsynch_nsleepers(&mutex->synchbase)));
>> Ok. I think you have spotted a bug here. This should be mutex->sleepers
>> instead of xnsynch_nsleepers.
> 
> OK. Will you fix? I will rebase then.
> 
>>> +	/* Consistency check for owner handle - is the object a thread? */
>>> +	if (unlikely(xnthread_handle(owner) != clear_claimed(ownerh))) {
>>> +		err = -EINVAL;
>>> +		goto error;
>>>  	}
>> What is this ?
> 
> This ensures that we are not dereferences some arbitrary registry object
> due to a borken handle in the mutex variable: The the object registered
> on this handle is an xnthread, we will find the very same handle value
> at the well-known place in the object. Kind of magic for xnthread
> objects (instead of adding a magic field to them).

Yes, but the point is: how can the handle be borken ? It looks like a
useless check to me.

-- 
                                                 Gilles.

