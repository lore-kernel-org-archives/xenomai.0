Message-ID: <48B56EFC.6060001@domain.hid>
Date: Wed, 27 Aug 2008 17:13:00 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <48B5592B.1090005@domain.hid> <48B55F7C.5030901@domain.hid>
	<48B56685.4060500@domain.hid> <48B56876.3090601@domain.hid>
	<48B568FD.9010905@domain.hid> <48B56A0C.9060006@domain.hid>
	<48B56AF6.6080509@domain.hid> <48B56C06.1030808@domain.hid>
	<48B56D05.6020509@domain.hid> <48B56E69.9000100@domain.hid>
In-Reply-To: <48B56E69.9000100@domain.hid>
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
>>> Gilles Chanteperdrix wrote:
>>>> Jan Kiszka wrote:
>>>>> Gilles Chanteperdrix wrote:
>>>>>> Jan Kiszka wrote:
>>>>>>> Gilles Chanteperdrix wrote:
>>>>>>>> Jan Kiszka wrote:
>>>>>>>>
>>>>>>>>> -#define test_claimed(owner) ((long) (owner) & 1)
>>>>>>>>> -#define clear_claimed(owner) ((xnthread_t *) ((long) (owner) & ~1))
>>>>>>>>> -#define set_claimed(owner, bit) \
>>>>>>>>> -        ((xnthread_t *) ((long) clear_claimed(owner) | !!(bit)))
>>>>>>>>> +#define __CLAIMED_BIT		XN_HANDLE_SPARE3
>>>>>>>>> +
>>>>>>>>> +#define test_claimed(owner)	xnhandle_test_spare(owner, __CLAIMED_BIT)
>>>>>>>>> +#define clear_claimed(owner)	xnhandle_mask_spare(owner)
>>>>>>>>> +#define set_claimed(owner, bit) ({ \
>>>>>>>>> +	xnhandle_t __tmp = xnhandle_mask_spare(owner); \
>>>>>>>>> +	if (bit) \
>>>>>>>>> +		xnhandle_set_spare(__tmp, __CLAIMED_BIT); \
>>>>>>>>> +	__tmp; \
>>>>>>>>> +})
>>>>>>>> I liked doing this with no conditional.
>>>>>>> You mean let the caller pass 'bit' as 0 or __CLAIMED_BIT (the latter
>>>>>>> would require some renaming then, I guess)?
>>>>>>>
>>>>>>>>> +	xnarch_atomic_set(mutex->owner,
>>>>>>>>> +		 	  set_claimed(xnthread_handle(owner),
>>>>>>>>> +				      xnsynch_nsleepers(&mutex->synchbase)));
>>>>>>>> Ok. I think you have spotted a bug here. This should be mutex->sleepers
>>>>>>>> instead of xnsynch_nsleepers.
>>>>>>> OK. Will you fix? I will rebase then.
>>>>>>>
>>>>>>>>> +	/* Consistency check for owner handle - is the object a thread? */
>>>>>>>>> +	if (unlikely(xnthread_handle(owner) != clear_claimed(ownerh))) {
>>>>>>>>> +		err = -EINVAL;
>>>>>>>>> +		goto error;
>>>>>>>>>  	}
>>>>>>>> What is this ?
>>>>>>> This ensures that we are not dereferences some arbitrary registry object
>>>>>>> due to a borken handle in the mutex variable: The the object registered
>>>>>>> on this handle is an xnthread, we will find the very same handle value
>>>>>>> at the well-known place in the object. Kind of magic for xnthread
>>>>>>> objects (instead of adding a magic field to them).
>>>>>> Yes, but the point is: how can the handle be borken ? It looks like a
>>>>>> useless check to me.
>>>>> This is user memory. Everything can be borken. And I don't want to
>>>>> create yet another source for user-triggered kernel bugs (including
>>>>> silent ones) like with our heap management structures that are
>>>>> corruptible by userland. That's headache guarantee.
>>>> No, we assume that the user application will only clobber our heap if it
>>>> is broken too. Add this with a XENO_DEBUG option if you want (not
>>>> XENO_DEBUG(POSIX)).
>>> No problem for me. This check is almost 100% identical (specifically
>>> overhead-wise) to the usual object magic checks after querying the
>>> registry, and as those are unconditionally performed, I saw no need to
>>> handle this case differently.
>> But the registry lookup is already a validation in itself. I mean, if an
>> application uses 5 as a file descriptor, there are only two cases:
>> - the file descriptor 5 exists in the application and the kernel has no
>> other choice than to believe that the application is using this file
>> descriptor, and nothing will go wrong because this is a valid descriptor;
>> - the file descriptor does not exist, and we will return EBADF, and
>> nothing wrong will happen either...
> 
> File descriptors are all identically structured objects, so at worst you
> ruin some other app's day. But the registry contains arbitrary objects
> with different internal layout. If you start assuming object_a * is
> object_b * and use the pointer etc. included in a as if they have the
> meaning of b, you quickly ruin the kernel's day as well. Therefore,
> native, e.g., does magic checks after fetching from the registry. As I
> said, this test here works differently, but it has the same effect and
> impact.

Ok. Got it. Leave the check then.

-- 
                                                 Gilles.

