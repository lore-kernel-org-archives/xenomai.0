Received: from eastern.birch.relay.mailchannels.net (eastern.birch.relay.mailchannels.net [23.83.209.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466594413
	for <xenomai@lists.linux.dev>; Sat, 27 Aug 2022 16:13:04 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|giulio@bela.io
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id EF0117E0CBA;
	Sat, 27 Aug 2022 16:12:57 +0000 (UTC)
Received: from pdx1-sub0-mail-a305 (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 5B6E87E1612;
	Sat, 27 Aug 2022 16:12:57 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1661616777; a=rsa-sha256;
	cv=none;
	b=RD+3wA8S5VYVLIFo58fBSdd4quFDdYLuM4VUjo4jRTtQ3wcko01okOYG3XpxgQF4nbXpht
	ICwfxQ4NFdO28Mv7/4UqMwKhoOK8GWKpaIxjWiUIh5YMjwzkavK3b9JhdbpnVcBLKFedJL
	SgpUUh2s+8mR9RZgoyS1aX89VpxVVQaAqRLPSvn629YSJcCvj1MzYnsQr3qzojjynyWAQy
	AxpxBVHhBMwaOjhsdrkc/AlL5gbDbFZTC5j2lRqmDHQ6mQLt+lZf1f/yBwT2SwRCtRzle5
	S8/BcNNnGNbpECPL18t61y3BGkKWsqkU6n8gwSyh7NGPry5IHbPAdpDc209jpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1661616777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=OpGGmczUH6ynqLGv4exDRZURPQA+I/g8xLtlzQtxXBU=;
	b=kM4HObUYm7qXUlN6f8ITvF0zr1ldRL46VtaFkEMe6VIrwF0EEt2ZWv7aVu1j5yDqm0IFws
	0p3EOqvFDJntTRQuFziWDmtMp+C8AAnX0n4H4v1nIrLEvamfUKA7D20w/wJNhvDHYjp9ES
	Pjnu70qBaiYS6Xe56OhlQkmKLsrUp7hdSYsQOS+XOsbFqaSQCQpxeXWu0sSrrSL42OsfnR
	SzqS1RZHTY7jyxK992dA29cxpTL2Zk5oLvkALnSbcnGGUTTkGKVwp/FWJQqcBzveS4HZ93
	dq6nSmMBpxHzLfeQzo38eFPFw+CJRKsq0my/N6gsn8aNwfcYZqu2xSUl8IFR1Q==
ARC-Authentication-Results: i=1;
	rspamd-75b4464bd-shprm;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=giulio@bela.io
X-Sender-Id: dreamhost|x-authsender|giulio@bela.io
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|giulio@bela.io
X-MailChannels-Auth-Id: dreamhost
X-Zesty-Glossy: 038bb9136225c6e4_1661616777637_1490607980
X-MC-Loop-Signature: 1661616777637:3806417288
X-MC-Ingress-Time: 1661616777637
Received: from pdx1-sub0-mail-a305 (pop.dreamhost.com [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.119.194.207 (trex/6.7.1);
	Sat, 27 Aug 2022 16:12:57 +0000
Received: from [192.168.1.77] (unknown [5.179.185.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: giulio@bela.io)
	by pdx1-sub0-mail-a305 (Postfix) with ESMTPSA id 4MFMDl3MCMzRZ;
	Sat, 27 Aug 2022 09:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bela.io;
	s=dreamhost; t=1661616777;
	bh=OpGGmczUH6ynqLGv4exDRZURPQA+I/g8xLtlzQtxXBU=;
	h=Subject:To:Cc:From:Date:Content-Type:Content-Transfer-Encoding;
	b=BVWTwJzlwKGjZDbimWaI5bWWUIerj1Ex8IOHqCczhQPv8Yj6/Nykfvss82WvmNkh9
	 K5oXOa/82JV3lzzLhjsVR72qIcbrRwlkEWesT3bRQryXPmjz/OjMJSLYedz5ZAnnP/
	 yw4BlKDuA1YC2dqcrLnZzgYOgQsCGqRYZJIme3/K1H8MrPRZ25jcSyuor0wQeEEK0+
	 BugOU64/mfEloXsg6ffhERqsS+UxJhJUjkhMhOY1SFjRv7JaZ8H7HIIPYob/7yJ0D7
	 avU9b4RwOKSm2GGFOZdd/1m14hMraaE0dmdUMmx/vmR40nakc8E4GFT3fMRKM9/sLE
	 euOpUkgJZ/I/g==
Subject: Re: Issues with evl_mutex_trylock()
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>
References: <a4c1ed74-2ae9-9427-994b-54dd7773399e@bela.io>
 <87pmgnnkyb.fsf@xenomai.org> <87h71zncwl.fsf@xenomai.org>
From: Giulio Moro <giulio@bela.io>
Message-ID: <328b680c-5970-4e7a-abec-835a9062e0e6@bela.io>
Date: Sat, 27 Aug 2022 18:12:53 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Firefox/60.0 SeaMonkey/2.53.4
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <87h71zncwl.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> Please retry with this patch in. There is clearly a race in the current
> implementation of the mutex release code, specifically the release path.

I retried with your recently pushed branch which includes that patch (alongside 59700fc66877ea9ffa958b46e2cdaf2925840f0a evl/mutex: simplify the release path) and the tests do indeed succeed.
Thanks,
Giulio


Philippe Gerum wrote on 26/08/2022 18:17:
> 
> Philippe Gerum <rpm@xenomai.org> writes:
> 
>> Giulio Moro <giulio@bela.io> writes:
>>
>>> In the toy example below I start some pthreads with SCHED_FIFO, priority 94 and setting the affinity of one thread per core. I then attach them to the EVL core and share a lock between them and the main thread. The main thread has a settable priority and schedule (SCHED_OTHER with prio 0 or SCHED_FIFO with higher priority) and its affinity is set to all available cores.
>>>
>>> Here's a summary of what I get when running the test with some
>>> parameters (arguments are: "max iterations", "number of threads to
>>> create", "priority of the main thread", "flags (t means don't print
>>> anything). The error code reported alongside failures is the base 2
>>> representation of the return code. 100 means that errors were
>>> detected in evl_unlock_mutex() in the main thread following a
>>> successful call to evl_trylock_mutex(). During these tests, the
>>> output is piped to cat and then redirected to /dev/null.
>>>
>>> mutex-test 100000 0 0 t :  Success real 0m13.583s user 0m1.218s sys 0m0.000s
>>> mutex-test 100000 0 90 t :  Success real 0m13.350s user 0m1.177s sys 0m0.000s
>>> mutex-test 100000 0 99 t :  Success real 0m13.347s user 0m1.179s sys 0m0.000s
>>> mutex-test 100000 1 0 t :  Success real 0m20.087s user 0m3.575s sys 0m0.000s
>>> mutex-test 100000 1 90 t :  Success real 0m17.610s user 0m2.133s sys 0m0.000s
>>> mutex-test 100000 1 99 t :  Success real 0m15.466s user 0m1.333s sys 0m0.000s
>>> mutex-test 100000 2 0 t :  Failed 100 real 0m0.259s user 0m0.083s sys 0m0.000s
>>> mutex-test 100000 2 90 t :  Failed 100 real 0m0.374s user 0m0.176s sys 0m0.000s
>>> mutex-test 100000 2 99 t :  Failed 100 real 0m0.207s user 0m0.109s sys 0m0.000s
>>> mutex-test 100000 3 0 t :  Failed 100 real 0m0.253s user 0m0.124s sys 0m0.000s
>>> mutex-test 100000 3 90 t :  Failed 100 real 0m0.383s user 0m0.149s sys 0m0.000s
>>> mutex-test 100000 3 99 t :  Failed 100 real 0m0.283s user 0m0.151s sys 0m0.000s
>>> mutex-test 100000 4 0 t :  Failed 100 real 0m0.526s user 0m0.221s sys 0m0.000s
>>> mutex-test 100000 4 90 t :  Failed 100 real 0m0.438s user 0m0.178s sys 0m0.000s
>>> mutex-test 100000 4 99 t :  Failed 100 real 0m0.434s user 0m0.178s sys 0m0.000s
>>>
>>> So, when running with 2 or more threads, the same error keeps surfacing very quickly.
>>>
>>
>> Confirmed. There is something wrong.
>>
> 
> Please retry with this patch in. There is clearly a race in the current
> implementation of the mutex release code, specifically the release path.
> 
> @Jan: If believe this gremlin may be in Cobalt too. The key issue is
> with the handle transitioning to NO_HANDLE before transfer_ownership()
> switches it to the handle of the first contender in line. If userland
> manages to slip in with a fast_acquire() during this tiny window, we may
> be toast, with two threads actually holding the same lock. The issue was
> made more obvious with EVL which does not serialize the trylock code
> around cmpxchg in kernel space, triggering the issue faster. I'll have a
> second look to Cobalt, but since you know the mutex code in depth there,
> four eyeballs would be better.
> 
> diff --git a/kernel/evl/mutex.c b/kernel/evl/mutex.c
> index e0cf1ba21d5b4..d96f8c9f04df7 100644
> --- a/kernel/evl/mutex.c
> +++ b/kernel/evl/mutex.c
> @@ -899,14 +899,16 @@ void __evl_unlock_mutex(struct evl_mutex *mutex)
>   	if (mutex->flags & EVL_MUTEX_CEILING)
>   		clear_boost_locked(mutex, curr, EVL_MUTEX_CEILING);
>   
> +	/*
> +	 * The whole logic is based on the invariant that the current
> +	 * thread does own the mutex being released.
> +	 * IOW: currh == atomic_read(lockp) & ~(EVL_MUTEX_FLCLAIM|EVL_MUTEX_FLCEIL).
> +	 */
>   	h = atomic_read(lockp);
> -	h = atomic_cmpxchg(lockp, h, EVL_NO_HANDLE);
> -	if ((h & ~EVL_MUTEX_FLCEIL) != currh) {
> -		/* FLCLAIM set, mutex is contended. */
> +	if (h & EVL_MUTEX_FLCLAIM) { /* Is there a contender? */
>   		transfer_ownership(mutex, curr);
>   	} else {
> -		if (h != currh)	/* FLCEIL set, FLCLAIM clear. */
> -			atomic_set(lockp, EVL_NO_HANDLE);
> +		atomic_set(lockp, EVL_NO_HANDLE);
>   		untrack_owner(mutex);
>   	}
>   
> 
