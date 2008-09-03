Message-ID: <48BE520D.3000108@domain.hid>
Date: Wed, 03 Sep 2008 10:59:57 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <48BD409B.8000309@domain.hid>
	<48BD4577.3000307@domain.hid>	<48BD4CE2.4020406@domain.hid>
	<48BD5180.4080509@domain.hid>	<48BD54FE.8010406@domain.hid>
	<48BD5BC3.4040903@domain.hid>	<48BD5D26.4010807@domain.hid>
	<48BD5F17.6050707@domain.hid> <48BD7EFE.1050302@domain.hid>
	<48BD826E.5090401@domain.hid> <48BD8540.1050504@domain.hid>
	<48BE3A07.7070305@domain.hid>
In-Reply-To: <48BE3A07.7070305@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] POSIX: Fix race when setting claimed bit
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
>>>>>>> OTOH, we can safe some text size which is precious as well. So I'm
>>>>>>> convinced to go your way (with a modification):
>>>>>> My approach sucks: we get a silly atomic_cmpxchg if the mutex is already
>>>>>> claimed, which is as least as much a common case as a currently
>>>>>> unclaimed mutex. Need to think a bit. But I think a good solution is to
>>>>>> re-read only if the mutex has been seen as already claimed.
>>>>> That makes no difference as then we will go through the cmpxchg path anyway.
>>>>>
>>>>> There is _no_ way around re-reading under nklock, all we can avoid is
>>>>> atomic cmpxchg in the case of >1 waiters. But that would come at the
>>>>> price of more complexity for all waiter.
>>>>>
>>>>> However, let's find some solution. I bet things will look different
>>>>> again when we start fiddling with a generic lock + the additional bit to
>>>>> replace XNWAKEN.
>>>> What I meant is that if the claimed bit is already set, we can avoid the
>>>> cmpxchg altogether, which was the intent of the original code. So I propose
>>>> the following version:
>>>>
>>>> 	if(test_claimed(owner))
>>>> 		owner = xnarch_atomic_intptr_get(mutex->owner);
>>> This version lacks a test for owner == 0 here, otherwise you re-create
>>> my old bug that bite me today.
>> Ok, so jumping in the middle of the loop is the best thing to do then.
>>
>>>> 	while(!test_claimed(owner)) {
>>>> 		old = xnarch_atomic_intptr_cmpxchg(mutex->owner,
>>>> 						   owner, set_claimed(owner, 1));
>>>> 		if (likely(old == owner))
>>>> 			break;
>>>> 		if (old == NULL) {
>>>> 			/* Owner called fast mutex_unlock
>>>> 			   (on another cpu) */
>>>> 			xnlock_put_irqrestore(&nklock, s);
>>>> 			goto retry_lock;
>>>> 		}
>>>> 		owner = old;
>>>> 	}
>>>>
>>>> The compiler rearranges things correctly (at least on ARM), and avoids the
>>>> redundant test.
>>>>
>>> My latest concern remains: Is all this additional complexity, are all
>>> these conditional branches and the text size increase worth the effort?
>>> How much cycles or micoseconds would be gain on the most suffering
>>> architecture?
>> Since the else and the while are folded together and the loop becomes
>> post-tested, and with the help of conditional instructions, I do not
>> think there is much more conditional branch (we need to to jump over
>> the while loop anyway). However avoiding the cmpxchg is a real gain,
>> since it is implemented as irq save/irq restore on an old arm.
>>
>> 	if(test_claimed(owner)) {
>> 		old = xnarch_atomic_intptr_get(mutex->owner);
>> 		goto test_old;
>> 	}
>> 	while(!test_claimed(owner)) {
>> 		old = xnarch_atomic_intptr_cmpxchg(mutex->owner,
>> 						   owner, set_claimed(owner, 1));
>> 		if (likely(old == owner))
>> 			break;
>> 	test_old:
>> 		if (old == NULL) {
>> 			/* Owner called fast mutex_unlock
>> 			   (on another cpu) */
>> 			xnlock_put_irqrestore(&nklock, s);
>> 			goto retry_lock;
>> 		}
>> 		owner = old;
>> 	}
> 
> Should work now, but the beautifulness of the code suffers a bit...
> 
> What about making the expected compiler optimizations explicit?

Yes, of course.

-- 
                                                 Gilles.

