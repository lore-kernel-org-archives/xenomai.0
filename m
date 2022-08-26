Received: from antelope.elm.relay.mailchannels.net (antelope.elm.relay.mailchannels.net [23.83.212.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BB42F2E
	for <xenomai@lists.linux.dev>; Fri, 26 Aug 2022 15:16:38 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|giulio@bela.io
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id CAED51229DE;
	Fri, 26 Aug 2022 15:16:30 +0000 (UTC)
Received: from pdx1-sub0-mail-a305 (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 48986122A8B;
	Fri, 26 Aug 2022 15:16:29 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1661526990; a=rsa-sha256;
	cv=none;
	b=k3h3VEgfT74B1aAoku6jy/tznpQOBgWwX7Qn4Sw1kCrHKFyWs0YF3SEJjCVpsIh60bvhdI
	dqoSXq/3EF5O2z7bKp9K17AzQkEsOXDivjIOYtaRb/meR4HKYtQqYjkVc9VzqMzQDKMMY8
	X+/7DfWOtRw6EDRcPmTDTM3tbUxf3k9CGfx6hZZ6VJEMaCM4+r20QbLxBZrFRKx5D23LXS
	YwpQvuOnxDnFkldqvolEbPhaDmDQ9y2nEZkWoMqqxzDJtLeEROQyDdNEczGynTJd1bWNbe
	OU8xth/w8nyjx/RnZPMUw7u7Xj6Kd3n1I4CyP5OnhpVi+K7mOa/iffxs/5dPTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1661526990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=lM3UCbSOTrDyF2EQiqeMe7ivmNTRn5AHb8rBHJedvGo=;
	b=0vJHu4feRkMZ3q8PDyCLsXcT4Zj7OYnJEQdSBuSe8gj6nkUcmeAstwIjvAB+/QmVk5sfe2
	vrwbYwCwrSCBCSZV7sbBeQCbwPBO1ALkK6hPydDBc6mztAbErdjB2aWDeemfeXVvA5+y/S
	sEE24jRiqrd1cgbhjbQ7Bi53XFFAEHciAq0I6q5Z6rTwwVELgS3fRUZOS8/0tTHDwdmbAD
	9BeMUOR3HWm3xtnFW4q97i/wRd2DK8eXWrU35Z+GqhQcZpxjo3bUlfMlF4DER+Sj+EJNHQ
	w/y9jDjkIWIqb5U1myAwCymLBQAlOvwuN2FE+ATPcytzpzyi+C7UD5DXAAhnJA==
ARC-Authentication-Results: i=1;
	rspamd-64cc6f7466-zvcgj;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=giulio@bela.io
X-Sender-Id: dreamhost|x-authsender|giulio@bela.io
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|giulio@bela.io
X-MailChannels-Auth-Id: dreamhost
X-Arithmetic-Irritate: 3a6c8c5a756e8b00_1661526990565_793131426
X-MC-Loop-Signature: 1661526990565:1664546061
X-MC-Ingress-Time: 1661526990565
Received: from pdx1-sub0-mail-a305 (pop.dreamhost.com [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.112.55.199 (trex/6.7.1);
	Fri, 26 Aug 2022 15:16:30 +0000
Received: from [192.168.1.77] (unknown [5.77.118.161])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: giulio@bela.io)
	by pdx1-sub0-mail-a305 (Postfix) with ESMTPSA id 4MDk230bM8zTq;
	Fri, 26 Aug 2022 08:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bela.io;
	s=dreamhost; t=1661526988;
	bh=lM3UCbSOTrDyF2EQiqeMe7ivmNTRn5AHb8rBHJedvGo=;
	h=Subject:To:Cc:From:Date:Content-Type:Content-Transfer-Encoding;
	b=gVQmyLh3RBnY/j9TsaWbEZZyLKf3vx3sJd9PJ+vDcSd35WTIzyb0Y1tzd4UIOvJmu
	 +7CRRCldvHYss2BUjr9dUuW5QzZ6TdfP8mCKkKGCFI7MlR/7TpbYnidPHiv1K9GJuE
	 uy8iL/I0B2T+8sc4LNerthwjNQ7FrJdREmr5pydeHiCSdcbsPEARIyPszJIYCbfhg7
	 E8GU5Y4/+gu4nxuGzGsXUH02q2eZB8He0B45ZZ21LnsaD21xRQM6CoZFViV77w4QdY
	 X2jtLC/SzIY2E2+z2bAekdOcKTsEo7ZQ/6FyCm93ujVt+Y8WRQ1ltycB9G7+antrV+
	 gi2Ek9dLSFriw==
Subject: Re: Issues with evl_mutex_trylock()
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev
References: <a4c1ed74-2ae9-9427-994b-54dd7773399e@bela.io>
 <87pmgnnkyb.fsf@xenomai.org>
From: Giulio Moro <giulio@bela.io>
Message-ID: <1e4dc605-2ad5-7646-85d5-0bc45cdb8b30@bela.io>
Date: Fri, 26 Aug 2022 17:16:24 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Firefox/60.0 SeaMonkey/2.53.4
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <87pmgnnkyb.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

> This is due to an issue in your test code: evl_attach_thread() inherits
> the current POSIX scheduling params for the caller, so you need to set
> them prior to calling this routine. Otherwise, you need to change them
> EVL-wise after attachment using evl_set_schedattr().

OK thanks, I fixed it and ISW on the main thread go away when the main thread is set to SCHED_FIFO before evl_attach_self().

It's probably worth adding a note about it in the description of evl_attach_thread() https://evlproject.org/core/user-api/thread/ around the table discussing scheduling policies. The statement there about using `sched_setaffinity()` to set affinity post-attach suggested that regular sched_* calls would still be valid. By the way, is there a way to contribute to the documentation?

> This is the expected behavior unless you switch the file descriptor to
> the stdout/stderr proxy to non blocking I/O. If you do, the oob caller
> would not wait for the output to drain and return immediately with
> -EAGAIN, dropping the current message in the same move.

Ah well that explains why I don't get the usual output scrambling that I'd get with Xenomai's rt_printf() when printing plenty of data. I guess everything comes with a price. I am wondering though: why do these ISW only take place only when the thread is SCHED_WEAK and not with SCHED_FIFO.

>> - running with `./mutex-test 100000 1 X q`, where 'q' is for "don't print anything", gives me 90% of the time an immediate hard lock up of the board (not even a stacktrace out of the UART!) (X can be any priority). Note that if this is run with `t` (throttled printing) or `a` (print all), it works kind of OK, apart from the issue mentione in the previous bullet point
> 
> Which is expected as well: although your main thread does sleep for 100
> µs at each iteration, thread 1-n don't, the starving the system from CPU
> time on their respecting processors. Enabling the watchdog in the EVL
> debug settings would likely trigger a report from the core.

Just to clarify, in this case, the code is running with only 1 worker thread and the main thread. main() will have affinity set to all CPUs, while the other thread will be on the last CPU. In other words, I am not hogging all CPUs and in particular not CPU 0. I will try again with EVL_WATCHDOG enabled.

>> - occasionally I get other lockups of the board during these tests that harder to reproduce. For instance, one happened at some point while running `./mutex-test 10000 3 0 t`
> 
> Could be the same issue as above

It makes sense, however when there are more than 1 worker threads, no thread will run at 100% CPU, because they are contending for the lock and doing actual work while holding it. env ps indicates that the load gets spread evenly across the worker threads.

Thanks,
Giulio

Philippe Gerum wrote on 26/08/2022 16:09:
> 
> Giulio Moro <giulio@bela.io> writes:
> 
>> In the toy example below I start some pthreads with SCHED_FIFO, priority 94 and setting the affinity of one thread per core. I then attach them to the EVL core and share a lock between them and the main thread. The main thread has a settable priority and schedule (SCHED_OTHER with prio 0 or SCHED_FIFO with higher priority) and its affinity is set to all available cores.
>>
>> Here's a summary of what I get when running the test with some parameters (arguments are: "max iterations", "number of threads to create", "priority of the main thread", "flags (t means don't print anything). The error code reported alongside failures is the base 2 representation of the return code. 100 means that errors were detected in evl_unlock_mutex() in the main thread following a successful call to evl_trylock_mutex(). During these tests, the output is piped to cat and then redirected to /dev/null.
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
>> I further observe the following unexpected behaviours:
>> - in the 0 and 1 thread cases, I get increasing values in the ISW
>> column for the main thread when monitoring with evl ps -st. This
>> happens regardless of the priority of the main thread and of the
>> amount of data printed to the screen doesn't happen with 2, 3 or 4
>> threads (for these I have to run with 'k' to keep going after the
>> errors and be able to observe the output of evl ps)
> 
> This is due to an issue in your test code: evl_attach_thread() inherits
> the current POSIX scheduling params for the caller, so you need to set
> them prior to calling this routine. Otherwise, you need to change them
> EVL-wise after attachment using evl_set_schedattr().
> 
>> - running `./mutex-test 100000 1 X a` (where 'a' stands for "print
>> all", and for any priority X) will almost always quickly show the
>> following behaviour: the main thread to stops running, and process
>> kworker/u8:3+stdout:3033.O runs at 100% CPU. I don't think it's
>> expected that a SCHED_FIFO thread attached to the EVL core becomes
>> blocked because it calls evl_printf(). Note that only the main thread
>> is blocked, the other thread runs. This doesn't happen when numThreads
>> == 0 or numThreads >= 2.
> 
> This is the expected behavior unless you switch the file descriptor to
> the stdout/stderr proxy to non blocking I/O. If you do, the oob caller
> would not wait for the output to drain and return immediately with
> -EAGAIN, dropping the current message in the same move.
> 
>> - running with `./mutex-test 100000 1 X q`, where 'q' is for "don't print anything", gives me 90% of the time an immediate hard lock up of the board (not even a stacktrace out of the UART!) (X can be any priority). Note that if this is run with `t` (throttled printing) or `a` (print all), it works kind of OK, apart from the issue mentione in the previous bullet point
> 
> Which is expected as well: although your main thread does sleep for 100
> µs at each iteration, thread 1-n don't, the starving the system from CPU
> time on their respecting processors. Enabling the watchdog in the EVL
> debug settings would likely trigger a report from the core.
> 
>> - occasionally I get other lockups of the board during these tests that harder to reproduce. For instance, one happened at some point while running `./mutex-test 10000 3 0 t`
> 
> Could be the same issue as above.
> 
>> - I do get some EVL-related stacktraces relatively often when ctrl-C a starting program. I will make a separate post about this.
>>
>> As previously, this is tested on TI's SK-AM62 with this branch https://source.denx.de/Xenomai/xenomai4/linux-evl/-/tree/vendor/ti/v5.10.120 and commit 7ccc58d62905724f1b8de4823e0fe8e0129b0fb7 of libevl (r37 + 1 )
>>
> 
