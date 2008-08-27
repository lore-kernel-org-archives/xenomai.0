Message-ID: <48B57D32.60504@domain.hid>
Date: Wed, 27 Aug 2008 18:13:38 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <48B5592B.1090005@domain.hid> <48B55F7C.5030901@domain.hid>
	<48B56685.4060500@domain.hid> <48B570AF.4090900@domain.hid>
	<48B57281.2090109@domain.hid> <48B57626.8070404@domain.hid>
	<48B576F2.5010409@domain.hid> <48B57BE0.8000701@domain.hid>
In-Reply-To: <48B57BE0.8000701@domain.hid>
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
>>>>>>> +	xnarch_atomic_set(mutex->owner,
>>>>>>> +		 	  set_claimed(xnthread_handle(owner),
>>>>>>> +				      xnsynch_nsleepers(&mutex->synchbase)));
>>>>>> Ok. I think you have spotted a bug here. This should be mutex->sleepers
>>>>>> instead of xnsynch_nsleepers.
>>>>> BTW, why do you need to track sleepers separately in POSIX? Native
>>>>> doesn't do so, e.g.
>>>> Because of the "syscall-needed-when-unlocking-stolen-mutex" issue I
>>>> already explained (sleepers - xnsynch_nsleepers is precisely the count
>>>> of pending threads which have been awake then robbed the mutex).
>>> Hmm, sounds like the new lock owner should better clear the 'claimed'
>>> bit then, not the old one on return from unlock. Or where is the
>>> pitfall? How does the futex algorithm handle this scenario?
>> Ok. Please read my explanation again, I have already explained this in
>> another mail.
> 
> I did this, but I'm unable to derive the answer for my question from it.
> Let's go through it in more details:
> 
> When we pass a mutex to a new owner, we set its reference in the fast
> lock variable + set the claimed bit if there are more waiters. Instead,
> I would simple set that bit if there is a new owner. That owner will
> then pick up the mutex eventually and clear 'claimed' on exit from it
> lock service (if there are no further waiters then). If the new owner is
> not able to run and we steal the lock, we simple keep the 'claimed' bit
> as is. On exit from the stolen lock we find it set, thus we are forced
> to issue a syscall as it should be.
> 
> OK, what happens if some waiter wants to leave the party while we are
> holding the stolen lock? Then the sleeper number must be correct - that
> is one pitfall!
> 
> I will have to dig into this more deeply, considering more cases. But
> the additional "sleepers" field remains at least misplaced IMHO.
> xnsynch_sleepers should better be fixed to respect lock stealing, as
> lock stealing is an xnsynch property, nothing POSIX-specific.

Ok. I have read this but did not get what you mean. I will read it again
 quietly from home.

-- 
                                                 Gilles.

