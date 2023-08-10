Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FF2186C
	for <xenomai@lists.linux.dev>; Thu, 10 Aug 2023 08:53:27 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 401032000C;
	Thu, 10 Aug 2023 08:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1691657598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ewLWJ2RW8dN9lrizpoQ3yQgDBiCTF4APIjwbjpgtduM=;
	b=nYGJQSkSL3CX3KrQVINRE+/XPrjVWMDVSXt+lkkphFZDZu7bzTgxoJgaLDlVKEXNptjyRK
	KzegsYSWOZBf5+EligOE/AaEdGfDOPGmuddGmXTuZvH07qg30XpIeepuD7ZFvt74jGqeQw
	ARjncuSeNcWbLs8SlKrBhatQMHvX3iJOALxMrwkzyP8TApGpjIDaWGQCElXRrWZ2ZoSFgG
	S/H9H8S5v5RzWASqtQdoniNdXONjoXCYsIX23TVYKacdrY+8NkgJ16hojnVhzG9cn0DD6G
	NOrjYbf61rCv8/4NjF0rHwRXpzF9rfKO6E3D40sFnKU6LibFtFXQchZrE/z4Zw==
References: <a4c1ed74-2ae9-9427-994b-54dd7773399e@bela.io>
 <87pmgnnkyb.fsf@xenomai.org> <87h71zncwl.fsf@xenomai.org>
 <87h71xblu1.fsf@xenomai.org>
 <a2b3c058-6166-41fb-9e34-6f414faf814d@siemens.com>
User-agent: mu4e 1.8.11; emacs 28.2
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@lists.linux.dev, sang yo <stlfatboy@hotmail.com>
Subject: Re: Issues with evl_mutex_trylock()
Date: Thu, 10 Aug 2023 10:18:25 +0200
In-reply-to: <a2b3c058-6166-41fb-9e34-6f414faf814d@siemens.com>
Message-ID: <87bkffqnwi.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org


Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 27.08.22 19:53, Philippe Gerum wrote:
>> 
>> Philippe Gerum <rpm@xenomai.org> writes:
>> 
>>> Philippe Gerum <rpm@xenomai.org> writes:
>>>
>>>> Giulio Moro <giulio@bela.io> writes:
>>>>
>>>>> In the toy example below I start some pthreads with SCHED_FIFO, priority 94 and setting the affinity of one thread per core. I then attach them to the EVL core and share a lock between them and the main thread. The main thread has a settable priority and schedule (SCHED_OTHER with prio 0 or SCHED_FIFO with higher priority) and its affinity is set to all available cores.
>>>>>
>>>>> Here's a summary of what I get when running the test with some
>>>>> parameters (arguments are: "max iterations", "number of threads to
>>>>> create", "priority of the main thread", "flags (t means don't print
>>>>> anything). The error code reported alongside failures is the base 2
>>>>> representation of the return code. 100 means that errors were
>>>>> detected in evl_unlock_mutex() in the main thread following a
>>>>> successful call to evl_trylock_mutex(). During these tests, the
>>>>> output is piped to cat and then redirected to /dev/null.
>>>>>
>>>>> mutex-test 100000 0 0 t :  Success real 0m13.583s user 0m1.218s sys 0m0.000s
>>>>> mutex-test 100000 0 90 t :  Success real 0m13.350s user 0m1.177s sys 0m0.000s
>>>>> mutex-test 100000 0 99 t :  Success real 0m13.347s user 0m1.179s sys 0m0.000s
>>>>> mutex-test 100000 1 0 t :  Success real 0m20.087s user 0m3.575s sys 0m0.000s
>>>>> mutex-test 100000 1 90 t :  Success real 0m17.610s user 0m2.133s sys 0m0.000s
>>>>> mutex-test 100000 1 99 t :  Success real 0m15.466s user 0m1.333s sys 0m0.000s
>>>>> mutex-test 100000 2 0 t :  Failed 100 real 0m0.259s user 0m0.083s sys 0m0.000s
>>>>> mutex-test 100000 2 90 t :  Failed 100 real 0m0.374s user 0m0.176s sys 0m0.000s
>>>>> mutex-test 100000 2 99 t :  Failed 100 real 0m0.207s user 0m0.109s sys 0m0.000s
>>>>> mutex-test 100000 3 0 t :  Failed 100 real 0m0.253s user 0m0.124s sys 0m0.000s
>>>>> mutex-test 100000 3 90 t :  Failed 100 real 0m0.383s user 0m0.149s sys 0m0.000s
>>>>> mutex-test 100000 3 99 t :  Failed 100 real 0m0.283s user 0m0.151s sys 0m0.000s
>>>>> mutex-test 100000 4 0 t :  Failed 100 real 0m0.526s user 0m0.221s sys 0m0.000s
>>>>> mutex-test 100000 4 90 t :  Failed 100 real 0m0.438s user 0m0.178s sys 0m0.000s
>>>>> mutex-test 100000 4 99 t :  Failed 100 real 0m0.434s user 0m0.178s sys 0m0.000s
>>>>>
>>>>> So, when running with 2 or more threads, the same error keeps surfacing very quickly.
>>>>>
>>>>
>>>> Confirmed. There is something wrong.
>>>>
>>>
>>> Please retry with this patch in. There is clearly a race in the current
>>> implementation of the mutex release code, specifically the release path.
>>>
>>> @Jan: If believe this gremlin may be in Cobalt too. The key issue is
>>> with the handle transitioning to NO_HANDLE before transfer_ownership()
>>> switches it to the handle of the first contender in line. If userland
>>> manages to slip in with a fast_acquire() during this tiny window, we may
>>> be toast, with two threads actually holding the same lock. The issue was
>>> made more obvious with EVL which does not serialize the trylock code
>>> around cmpxchg in kernel space, triggering the issue faster. I'll have a
>>> second look to Cobalt, but since you know the mutex code in depth there,
>>> four eyeballs would be better.
>>>
>> 
>> I believe that the problem just fixed in the EVL core also affects
>> Cobalt. This is a suggested patch for fixing the same issue in the
>> latter on top of 3.2.2. Smokey's posix_mutex test still happy with it.
>> 
>> NOTE: the issue at hand is two threads being granted the _same_ lock
>> concurrently, so this might be potentially catastrophic.
>> 
>> ---
>> 
>> commit 4417674f427a78ba7fe2c8e5b2607d5ca6886ec0 (HEAD -> master)
>> Author: Philippe Gerum <rpm@xenomai.org>
>> Date:   Sat Aug 27 19:44:30 2022 +0200
>> 
>>     cobalt/sync: fix race in release path
>>     
>>     The mutex owner handle transitions to XN_NO_HANDLE before
>>     transfer_ownership() may switch it to the handle of the first
>>     contender in line. If a user context manage to slip in with a
>>     succcessful cmpxchg() in this tiny window, two threads may actually
>>     end up holding the same lock.
>>     
>>     To address this bug, set the handle directly to its final value as a
>>     result of transferring ownership, without transitioning via
>>     XN_NO_HANDLE, closing the race window.
>>     
>>     At this chance, stop duplicating the logic which transfer_ownership()
>>     already provides.  We may unconditionally rely on this routine for
>>     either passing the lock to the next waiter in line, or marking the
>>     lock as free, updating the fast handle accordingly in both cases.
>>     
>>     Signed-off-by: Philippe Gerum <rpm@xenomai.org>
>> 
>> diff --git a/kernel/cobalt/synch.c b/kernel/cobalt/synch.c
>> index 6e50e537f..c5398dba3 100644
>> --- a/kernel/cobalt/synch.c
>> +++ b/kernel/cobalt/synch.c
>> @@ -850,6 +850,17 @@ static bool transfer_ownership(struct xnsynch *synch,
>>  	xnhandle_t nextownerh;
>>  	atomic_t *lockp;
>>  
>> +	/*
>> +	 * FLCEIL may only be raised by the owner, or when the owner
>> +	 * is blocked waiting for the synch (ownership transfer). In
>> +	 * addition, only the current owner of a synch may release it,
>> +	 * therefore we can't race while testing FLCEIL locklessly.
>> +	 * All updates to FLCLAIM are covered by the superlock.
>> +	 *
>> +	 * Therefore, clearing the fastlock racelessly in this routine
>> +	 * without leaking FLCEIL/FLCLAIM updates can be achieved by
>> +	 * holding the superlock.
>> +	 */
>>  	lockp = xnsynch_fastlock(synch);
>>  
>>  	/*
>> @@ -862,6 +873,8 @@ static bool transfer_ownership(struct xnsynch *synch,
>>  		return false;
>>  	}
>>  
>> +	XENO_WARN_ON(COBALT, !xnsynch_fast_is_claimed(atomic_read(lockp)));
>> +
>>  	nextowner = list_first_entry(&synch->pendq, struct xnthread, plink);
>>  	list_del(&nextowner->plink);
>>  	nextowner->wchan = NULL;
>> @@ -916,8 +929,6 @@ static bool transfer_ownership(struct xnsynch *synch,
>>  bool xnsynch_release(struct xnsynch *synch, struct xnthread *curr)
>>  {
>>  	bool need_resched = false;
>> -	xnhandle_t currh, h;
>> -	atomic_t *lockp;
>>  	spl_t s;
>>  
>>  	XENO_BUG_ON(COBALT, (synch->status & XNSYNCH_OWNER) == 0);
>> @@ -927,19 +938,6 @@ bool xnsynch_release(struct xnsynch *synch, struct xnthread *curr)
>>  	if (xnthread_put_resource(curr))
>>  		return false;
>>  
>> -	lockp = xnsynch_fastlock(synch);
>> -	currh = curr->handle;
>> -	/*
>> -	 * FLCEIL may only be raised by the owner, or when the owner
>> -	 * is blocked waiting for the synch (ownership transfer). In
>> -	 * addition, only the current owner of a synch may release it,
>> -	 * therefore we can't race while testing FLCEIL locklessly.
>> -	 * All updates to FLCLAIM are covered by the superlock.
>> -	 *
>> -	 * Therefore, clearing the fastlock racelessly in this routine
>> -	 * without leaking FLCEIL/FLCLAIM updates can be achieved by
>> -	 * holding the superlock.
>> -	 */
>>  	xnlock_get_irqsave(&nklock, s);
>>  
>>  	if (synch->status & XNSYNCH_CEILING) {
>> @@ -947,12 +945,7 @@ bool xnsynch_release(struct xnsynch *synch, struct xnthread *curr)
>>  		need_resched = true;
>>  	}
>>  
>> -	h = atomic_cmpxchg(lockp, currh, XN_NO_HANDLE);
>> -	if ((h & ~XNSYNCH_FLCEIL) != currh)
>> -		/* FLCLAIM set, synch is contended. */
>> -		need_resched = transfer_ownership(synch, curr);
>> -	else if (h != currh)	/* FLCEIL set, FLCLAIM clear. */
>> -		atomic_set(lockp, XN_NO_HANDLE);
>> +	need_resched |= transfer_ownership(synch, curr);
>>  
>>  	xnlock_put_irqrestore(&nklock, s);
>>  
>
> This apparently fell through the cracks on my side, not being submitted
> as top-level patch, thanks for pointing out, Sang Yo.
>
> Philippe, this is still valid?

From reading xnsynch_release() in Cobalt and the explanations in that
commit log, it is. Since you were a direct recipient of this patch, I
assumed you queued it for a deep review given its criticality, so I
moved on, sorry for this.

> How can we check if we need it and it
> does the think it is supposed to do?

Unfortunately I have no xenomai3 test at hand, this bug was originally
uncovered in xenomai4 which initially imported the xenomai3 mutex logic
into the EVL core before I reworked it heavily last year, starting with
fixing this bug. Maybe the test case [1] Giulio posted back then could
also trigger the issue with xenomai3 which still runs the original
mutex implementation.

[1]
https://lore.kernel.org/xenomai/a4c1ed74-2ae9-9427-994b-54dd7773399e@bela.io/

-- 
Philippe.
