Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711183D6D
	for <xenomai@lists.linux.dev>; Fri, 26 Aug 2022 14:22:38 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 95D5B1C0007;
	Fri, 26 Aug 2022 14:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1661523757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yC62KVKzunZPchwierKTk/XDfiDgU2qT7+Qn4iitldU=;
	b=dScSQQP9EDcDplTWf7bjvRraoUVpTwEKc65YLjnCw0pCgEHxoHiXQoAaqJ+6JHbUNfCiyY
	Fz5pdHhh2k5iGqOkD8/PAepYqpwD5nRrZmo+prm1bBJg+bW141SfV/rsW4WaZkMESnvbA1
	unt3Ltyox1EXYL36Eov5UQKkTXeZcAJTS6Zeo3oDWAPybI6N2vDje4RV0XfaGgPKykFdJn
	eNL/M4nPIj7TEh5w4mITt3g9lijQjTYweS/C2IvmBT9PYsB7nAlQDmBUyXIkdq4GNGIIGV
	q8WKQH0jvxICfUhxFBKGwLNgO7pM4EJh0o/xmKt4GpKBVrDNOrbfjp36Pm3h6Q==
References: <a4c1ed74-2ae9-9427-994b-54dd7773399e@bela.io>
User-agent: mu4e 1.6.6; emacs 28.1
From: Philippe Gerum <rpm@xenomai.org>
To: Giulio Moro <giulio@bela.io>
Cc: xenomai@lists.linux.dev
Subject: Re: Issues with evl_mutex_trylock()
Date: Fri, 26 Aug 2022 16:09:25 +0200
In-reply-to: <a4c1ed74-2ae9-9427-994b-54dd7773399e@bela.io>
Message-ID: <87pmgnnkyb.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Giulio Moro <giulio@bela.io> writes:

> In the toy example below I start some pthreads with SCHED_FIFO, priority =
94 and setting the affinity of one thread per core. I then attach them to t=
he EVL core and share a lock between them and the main thread. The main thr=
ead has a settable priority and schedule (SCHED_OTHER with prio 0 or SCHED_=
FIFO with higher priority) and its affinity is set to all available cores.
>
> Here's a summary of what I get when running the test with some parameters=
 (arguments are: "max iterations", "number of threads to create", "priority=
 of the main thread", "flags (t means don't print anything). The error code=
 reported alongside failures is the base 2 representation of the return cod=
e. 100 means that errors were detected in evl_unlock_mutex() in the main th=
read following a successful call to evl_trylock_mutex(). During these tests=
, the output is piped to cat and then redirected to /dev/null.
>
> mutex-test 100000 0 0 t :  Success real 0m13.583s user 0m1.218s sys 0m0.0=
00s
> mutex-test 100000 0 90 t :  Success real 0m13.350s user 0m1.177s sys 0m0.=
000s
> mutex-test 100000 0 99 t :  Success real 0m13.347s user 0m1.179s sys 0m0.=
000s
> mutex-test 100000 1 0 t :  Success real 0m20.087s user 0m3.575s sys 0m0.0=
00s
> mutex-test 100000 1 90 t :  Success real 0m17.610s user 0m2.133s sys 0m0.=
000s
> mutex-test 100000 1 99 t :  Success real 0m15.466s user 0m1.333s sys 0m0.=
000s
> mutex-test 100000 2 0 t :  Failed 100 real 0m0.259s user 0m0.083s sys 0m0=
.000s
> mutex-test 100000 2 90 t :  Failed 100 real 0m0.374s user 0m0.176s sys 0m=
0.000s
> mutex-test 100000 2 99 t :  Failed 100 real 0m0.207s user 0m0.109s sys 0m=
0.000s
> mutex-test 100000 3 0 t :  Failed 100 real 0m0.253s user 0m0.124s sys 0m0=
.000s
> mutex-test 100000 3 90 t :  Failed 100 real 0m0.383s user 0m0.149s sys 0m=
0.000s
> mutex-test 100000 3 99 t :  Failed 100 real 0m0.283s user 0m0.151s sys 0m=
0.000s
> mutex-test 100000 4 0 t :  Failed 100 real 0m0.526s user 0m0.221s sys 0m0=
.000s
> mutex-test 100000 4 90 t :  Failed 100 real 0m0.438s user 0m0.178s sys 0m=
0.000s
> mutex-test 100000 4 99 t :  Failed 100 real 0m0.434s user 0m0.178s sys 0m=
0.000s
>
> So, when running with 2 or more threads, the same error keeps surfacing v=
ery quickly.
>

Confirmed. There is something wrong.

> I further observe the following unexpected behaviours:
> - in the 0 and 1 thread cases, I get increasing values in the ISW
> column for the main thread when monitoring with evl ps -st. This
> happens regardless of the priority of the main thread and of the
> amount of data printed to the screen doesn't happen with 2, 3 or 4
> threads (for these I have to run with 'k' to keep going after the
> errors and be able to observe the output of evl ps)

This is due to an issue in your test code: evl_attach_thread() inherits
the current POSIX scheduling params for the caller, so you need to set
them prior to calling this routine. Otherwise, you need to change them
EVL-wise after attachment using evl_set_schedattr().

> - running `./mutex-test 100000 1 X a` (where 'a' stands for "print
> all", and for any priority X) will almost always quickly show the
> following behaviour: the main thread to stops running, and process
> kworker/u8:3+stdout:3033.O runs at 100% CPU. I don't think it's
> expected that a SCHED_FIFO thread attached to the EVL core becomes
> blocked because it calls evl_printf(). Note that only the main thread
> is blocked, the other thread runs. This doesn't happen when numThreads
> =3D=3D 0 or numThreads >=3D 2.

This is the expected behavior unless you switch the file descriptor to
the stdout/stderr proxy to non blocking I/O. If you do, the oob caller
would not wait for the output to drain and return immediately with
-EAGAIN, dropping the current message in the same move.

> - running with `./mutex-test 100000 1 X q`, where 'q' is for "don't print=
 anything", gives me 90% of the time an immediate hard lock up of the board=
 (not even a stacktrace out of the UART!) (X can be any priority). Note tha=
t if this is run with `t` (throttled printing) or `a` (print all), it works=
 kind of OK, apart from the issue mentione in the previous bullet point

Which is expected as well: although your main thread does sleep for 100
=C2=B5s at each iteration, thread 1-n don't, the starving the system from C=
PU
time on their respecting processors. Enabling the watchdog in the EVL
debug settings would likely trigger a report from the core.

> - occasionally I get other lockups of the board during these tests that h=
arder to reproduce. For instance, one happened at some point while running =
`./mutex-test 10000 3 0 t`

Could be the same issue as above.

> - I do get some EVL-related stacktraces relatively often when ctrl-C a st=
arting program. I will make a separate post about this.
>
> As previously, this is tested on TI's SK-AM62 with this branch https://so=
urce.denx.de/Xenomai/xenomai4/linux-evl/-/tree/vendor/ti/v5.10.120 and comm=
it 7ccc58d62905724f1b8de4823e0fe8e0129b0fb7 of libevl (r37 + 1 )
>

--=20
Philippe.
