Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE7F2F2E
	for <xenomai@lists.linux.dev>; Fri, 26 Aug 2022 15:51:50 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 07CDA1BF206;
	Fri, 26 Aug 2022 15:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1661529109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EWVar06vd1t9p5+bojSon1NkOldIN9JsgAfVeZ+AvQc=;
	b=gw3tznN+gQGTE4NYFqGeyUrx0ZtGJc6yfFYfx2Y7LjAMHh/CGx0g3ohqaPSSSjnfkPZDBu
	YXQk/AlvhQFZytRgCGizWjFxHKIR2284hpFwylVxY/6YU0Pfcnz+6Tkp39OcRFzkSp1ump
	rlOjGYyqYZj0dA94udGX1X61v4/lM6bgixqIj7MqFEK04llaRP9F4OoqEzKxnW9BIHgdSw
	L4vwx0Zdt1krNfXpyxqMnP9QBWyegY2qa/KZT8T7VlufOgfcvr40VQoPgoY9iVNHUoJxCW
	i4VhkMgKOa4oyjHgukEuIZDHlyG/vPZ7s38L2DGLv9hU2uSxMZ+lg3w4DXL5Fg==
References: <a4c1ed74-2ae9-9427-994b-54dd7773399e@bela.io>
 <87pmgnnkyb.fsf@xenomai.org>
 <1e4dc605-2ad5-7646-85d5-0bc45cdb8b30@bela.io>
User-agent: mu4e 1.6.6; emacs 28.1
From: Philippe Gerum <rpm@xenomai.org>
To: Giulio Moro <giulio@bela.io>
Cc: xenomai@lists.linux.dev
Subject: Re: Issues with evl_mutex_trylock()
Date: Fri, 26 Aug 2022 17:33:29 +0200
In-reply-to: <1e4dc605-2ad5-7646-85d5-0bc45cdb8b30@bela.io>
Message-ID: <87lerbngtn.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Giulio Moro <giulio@bela.io> writes:

>> This is due to an issue in your test code: evl_attach_thread() inherits
>> the current POSIX scheduling params for the caller, so you need to set
>> them prior to calling this routine. Otherwise, you need to change them
>> EVL-wise after attachment using evl_set_schedattr().
>
> OK thanks, I fixed it and ISW on the main thread go away when the main th=
read is set to SCHED_FIFO before evl_attach_self().
>
> It's probably worth adding a note about it in the description of
> evl_attach_thread() https://evlproject.org/core/user-api/thread/
> around the table discussing scheduling policies. The statement there
> about using `sched_setaffinity()` to set affinity post-attach
> suggested that regular sched_* calls would still be valid. By the way,
> is there a way to contribute to the documentation?
>

Sure, involving people who do use the API is actually the best way to
get it right. Please clone the following repo, patches should be sent to
this list:

https://source.denx.de/Xenomai/xenomai4/website

This is markdown format parsed by the Hugo static site generator.

>> This is the expected behavior unless you switch the file descriptor to
>> the stdout/stderr proxy to non blocking I/O. If you do, the oob caller
>> would not wait for the output to drain and return immediately with
>> -EAGAIN, dropping the current message in the same move.
>
> Ah well that explains why I don't get the usual output scrambling that
> I'd get with Xenomai's rt_printf() when printing plenty of data. I

There is a (kernel) interface to set the size of the output buffer for
these proxies already. The current limit is set to the STDSTREAM_BUFSZ
constant in the library code ATM. Maybe a user interface is missing to
make it a bit more flexible, at least at application startup (e.g. via
evl_init()).

> guess everything comes with a price. I am wondering though: why do
> these ISW only take place only when the thread is SCHED_WEAK and not
> with SCHED_FIFO.

Because SCHED_WEAK means that in-band is the regular execution stage for
the thread, with the ability to switch oob when required by some EVL
syscall it issues. When it comes to mutexes, a thread undergoing the
SCHED_WEAK policy switches oob as a result of grabbing the lock, and
stays there until it drops it, at which point the core switches it back
automatically to the in-band stage. The latter causes the ISW counter to
increase. This is obviously a costly sequence of operations, so this
should not be done lightly, and certainly not in a tight loop.

>
>>> - running with `./mutex-test 100000 1 X q`, where 'q' is for "don't pri=
nt anything", gives me 90% of the time an immediate hard lock up of the boa=
rd (not even a stacktrace out of the UART!) (X can be any priority). Note t=
hat if this is run with `t` (throttled printing) or `a` (print all), it wor=
ks kind of OK, apart from the issue mentione in the previous bullet point
>> Which is expected as well: although your main thread does sleep for
>> 100
>> =C2=B5s at each iteration, thread 1-n don't, the starving the system fro=
m CPU
>> time on their respecting processors. Enabling the watchdog in the EVL
>> debug settings would likely trigger a report from the core.
>
> Just to clarify, in this case, the code is running with only 1 worker thr=
ead and the main thread. main() will have affinity set to all CPUs, while t=
he other thread will be on the last CPU. In other words, I am not hogging a=
ll CPUs and in particular not CPU 0. I will try again with EVL_WATCHDOG ena=
bled.
>

Every CPU must be allowed a small portion of the bandwidth in order for
the in-band kernel to deal with housekeeping work (e.g. serving IPIs
from other cores).

>>> - occasionally I get other lockups of the board during these tests that=
 harder to reproduce. For instance, one happened at some point while runnin=
g `./mutex-test 10000 3 0 t`
>> Could be the same issue as above
>
> It makes sense, however when there are more than 1 worker threads, no thr=
ead will run at 100% CPU, because they are contending for the lock and doin=
g actual work while holding it. env ps indicates that the load gets spread =
evenly across the worker threads.
>

Maybe not 100% would be consumed, but possibly still too much for the
in-band kernel to run the housekeeping tasks. We should have a look at
this when the mutex-related is fixed (I'm on it), to make sure we start
investigating from a clean state.

--=20
Philippe.
