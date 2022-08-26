Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE41C4401
	for <xenomai@lists.linux.dev>; Fri, 26 Aug 2022 17:16:29 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id E5BE31BF209;
	Fri, 26 Aug 2022 17:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1661534187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0wY7mOGPR5SrIehHEfhfLl2RpgwQmozeF6L2xtq+zxE=;
	b=UFI9qHB7VfZEjQpgMNdnTGnviI709TuQ8cDhMUA56X/7MGlNhfk2NLcHJAbnnQxelZwXrn
	6kXy3efQiOqAqhZq2Ayp9faCG3S1FFPU1uSs7md/qNZ56xj9HpPx11QtU2y4WXZEPf70hd
	tmSJoti8DSD2bbA5W9UQQ58tBozTxOD48OzoB3HRL6R8kizZcGRrFimJjfiu+bssC5w53S
	0ls6I/6SzW0Ow+OsSAvAhKO2uoY8qBZLcOSJiSUWfIQU4IuNySA8pi2/6r/RQnFGrWQtLY
	FTF+O4uqa2fcFdyX+zmVX+wT9ls0W7KIuHfEkC9nzvJE2WpX6XO5I++sCS4MeQ==
References: <a4c1ed74-2ae9-9427-994b-54dd7773399e@bela.io>
 <87pmgnnkyb.fsf@xenomai.org>
User-agent: mu4e 1.6.6; emacs 28.1
From: Philippe Gerum <rpm@xenomai.org>
To: Giulio Moro <giulio@bela.io>
Cc: xenomai@lists.linux.dev
Cc: "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>
Subject: Re: Issues with evl_mutex_trylock()
Date: Fri, 26 Aug 2022 18:17:18 +0200
In-reply-to: <87pmgnnkyb.fsf@xenomai.org>
Message-ID: <87h71zncwl.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Philippe Gerum <rpm@xenomai.org> writes:

> Giulio Moro <giulio@bela.io> writes:
>
>> In the toy example below I start some pthreads with SCHED_FIFO, priority 94 and setting the affinity of one thread per core. I then attach them to the EVL core and share a lock between them and the main thread. The main thread has a settable priority and schedule (SCHED_OTHER with prio 0 or SCHED_FIFO with higher priority) and its affinity is set to all available cores.
>>
>> Here's a summary of what I get when running the test with some
>> parameters (arguments are: "max iterations", "number of threads to
>> create", "priority of the main thread", "flags (t means don't print
>> anything). The error code reported alongside failures is the base 2
>> representation of the return code. 100 means that errors were
>> detected in evl_unlock_mutex() in the main thread following a
>> successful call to evl_trylock_mutex(). During these tests, the
>> output is piped to cat and then redirected to /dev/null.
>>
>> mutex-test 100000 0 0 t :  Success real 0m13.583s user 0m1.218s sys 0m0.000s
>> mutex-test 100000 0 90 t :  Success real 0m13.350s user 0m1.177s sys 0m0.000s
>> mutex-test 100000 0 99 t :  Success real 0m13.347s user 0m1.179s sys 0m0.000s
>> mutex-test 100000 1 0 t :  Success real 0m20.087s user 0m3.575s sys 0m0.000s
>> mutex-test 100000 1 90 t :  Success real 0m17.610s user 0m2.133s sys 0m0.000s
>> mutex-test 100000 1 99 t :  Success real 0m15.466s user 0m1.333s sys 0m0.000s
>> mutex-test 100000 2 0 t :  Failed 100 real 0m0.259s user 0m0.083s sys 0m0.000s
>> mutex-test 100000 2 90 t :  Failed 100 real 0m0.374s user 0m0.176s sys 0m0.000s
>> mutex-test 100000 2 99 t :  Failed 100 real 0m0.207s user 0m0.109s sys 0m0.000s
>> mutex-test 100000 3 0 t :  Failed 100 real 0m0.253s user 0m0.124s sys 0m0.000s
>> mutex-test 100000 3 90 t :  Failed 100 real 0m0.383s user 0m0.149s sys 0m0.000s
>> mutex-test 100000 3 99 t :  Failed 100 real 0m0.283s user 0m0.151s sys 0m0.000s
>> mutex-test 100000 4 0 t :  Failed 100 real 0m0.526s user 0m0.221s sys 0m0.000s
>> mutex-test 100000 4 90 t :  Failed 100 real 0m0.438s user 0m0.178s sys 0m0.000s
>> mutex-test 100000 4 99 t :  Failed 100 real 0m0.434s user 0m0.178s sys 0m0.000s
>>
>> So, when running with 2 or more threads, the same error keeps surfacing very quickly.
>>
>
> Confirmed. There is something wrong.
>

Please retry with this patch in. There is clearly a race in the current
implementation of the mutex release code, specifically the release path.

@Jan: If believe this gremlin may be in Cobalt too. The key issue is
with the handle transitioning to NO_HANDLE before transfer_ownership()
switches it to the handle of the first contender in line. If userland
manages to slip in with a fast_acquire() during this tiny window, we may
be toast, with two threads actually holding the same lock. The issue was
made more obvious with EVL which does not serialize the trylock code
around cmpxchg in kernel space, triggering the issue faster. I'll have a
second look to Cobalt, but since you know the mutex code in depth there,
four eyeballs would be better.

diff --git a/kernel/evl/mutex.c b/kernel/evl/mutex.c
index e0cf1ba21d5b4..d96f8c9f04df7 100644
--- a/kernel/evl/mutex.c
+++ b/kernel/evl/mutex.c
@@ -899,14 +899,16 @@ void __evl_unlock_mutex(struct evl_mutex *mutex)
 	if (mutex->flags & EVL_MUTEX_CEILING)
 		clear_boost_locked(mutex, curr, EVL_MUTEX_CEILING);
 
+	/*
+	 * The whole logic is based on the invariant that the current
+	 * thread does own the mutex being released.
+	 * IOW: currh == atomic_read(lockp) & ~(EVL_MUTEX_FLCLAIM|EVL_MUTEX_FLCEIL).
+	 */
 	h = atomic_read(lockp);
-	h = atomic_cmpxchg(lockp, h, EVL_NO_HANDLE);
-	if ((h & ~EVL_MUTEX_FLCEIL) != currh) {
-		/* FLCLAIM set, mutex is contended. */
+	if (h & EVL_MUTEX_FLCLAIM) { /* Is there a contender? */
 		transfer_ownership(mutex, curr);
 	} else {
-		if (h != currh)	/* FLCEIL set, FLCLAIM clear. */
-			atomic_set(lockp, EVL_NO_HANDLE);
+		atomic_set(lockp, EVL_NO_HANDLE);
 		untrack_owner(mutex);
 	}
 
-- 
Philippe.
