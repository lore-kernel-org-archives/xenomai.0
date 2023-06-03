Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0766F20EB
	for <xenomai@lists.linux.dev>; Sat,  3 Jun 2023 14:32:57 +0000 (UTC)
X-GND-Sasl: rpm@xenomai.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1685802770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PmMntMwszmuUznprgZ5+Dd/MKGTIeJQ1nWXT0NtcWQs=;
	b=PptcFLzp36hf5Rvr5E79649hCvDGQ994yR1w7wriZsfHgJ4Im6OGj0GST/I4qBAzuj12jD
	1QuphGj6z4HNKJ0JCluLApnBLcCb6Bu7gTtjb8ziks0C9Roxm9ICCzOeT0lFzFtT+ONn//
	Q0rNKxUnsmAfxJh/1tl0HcSI1oH61wO29lWr1z16qvzrRMrnna+r2Wyb0aiVIfjXkyyoII
	YpFDvh2y5x5F6hCa9xuEqrdWCK+J9AiOhl18/KFgaeshsF55hCE7K+ZM1R4+KVX9y8FEwg
	94+tu/YkLKc6DVYqSOWwseYcI8W5mKyI+MM6B37hG/pDfNu35N5Tiulil0mZkA==
X-GND-Sasl: rpm@xenomai.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id 30FD740005;
	Sat,  3 Jun 2023 14:32:49 +0000 (UTC)
References: <CAAm9oxrZ+g7RgBV0SC5GkvEeKKGXOZb2R_BRjf0qRObQM1wCgg@mail.gmail.com>
 <87mt84h3h0.fsf@xenomai.org> <87ilish1z0.fsf@xenomai.org>
 <CAAm9oxp-Zm+25CpxT7wYUiDWxZGBxStB14D8QnEZWDmCp6jYsQ@mail.gmail.com>
 <87359qwclj.fsf@xenomai.org>
 <CAAm9oxoRmKRZhOCa7PVmazCxouy2OdcHAxwCFJBEXwk1JcDnyQ@mail.gmail.com>
 <874jnoyghn.fsf@xenomai.org> <87zg5gws3p.fsf@xenomai.org>
User-agent: mu4e 1.8.11; emacs 28.2
From: Philippe Gerum <rpm@xenomai.org>
To: Sri Subramanian <sridhar.subramanian@gmail.com>
Cc: xenomai@lists.linux.dev
Subject: Re: Xenomai crash in timer IRQ
Date: Sat, 03 Jun 2023 16:31:59 +0200
In-reply-to: <87zg5gws3p.fsf@xenomai.org>
Message-ID: <87v8g4wr8u.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Philippe Gerum <rpm@xenomai.org> writes:

> Philippe Gerum <rpm@xenomai.org> writes:
>
>> Sri Subramanian <sridhar.subramanian@gmail.com> writes:
>>
>>> Hi Philippe,
>>>
>>> Sorry for the long pause in this thread.
>>>
>>> However, I am able to reproduce the kernel crash stack (off
>>> timerfd_oob_read) with a simple test program which does the following:
>>>
>>> In a loop:
>>>   create timer fd
>>>   create thread which
>>>        sets up periodic triggers off the monotonic timer
>>>       closes the timer after a few periods.
>>>   join w/thread
>>>
>>> If the main thread and the timer thread are in the same cpu, I can run
>>> it with hectic in the background for 2 hrs at least. However, if the
>>> threads are on different cpus, the kernel crashes within minutes. I am
>>> attaching the crash and the test program.
>>>
>>> Environment:
>>> HW: Raspberry Pi (CM4)
>>> SW: Xenomai 5.15.109 tag, Libevl r44
>>>
>>> Test steps:
>>> # hectic -s 200 -q&
>>> # ./timer-crash1 -a 0 -t 1 -q&
>>>
>>> BTW: this thread's history implies changes to the realtime clock, but
>>> really, this doesn't have anything to do with it.
>>
>> Ouch, confirmed. Something is wrong, this is a generic issue. Working on
>> it.
>>
>> root@homelab-qemu-x86_64:~# ./timerfd_crash -a 1 -t 2
>> 0[  347.430316] ------------[ cut here ]------------
>> [  347.430319] WARNING: CPU: 2 PID: 3241 at kernel/evl/timer.c:430 evl_g=
et_timer_overruns+0x1ac/0x1c0
>> [  347.430332] Modules linked in:
>> [  347.430334] CPU: 2 PID: 3241 Comm: timer-crash1-ch Not tainted 6.1.29=
+ #178
>> [  347.430338] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BI=
OS 1.16.2-1.fc38 04/01/2014
>> [  347.430340] IRQ stage: EVL
>> [  347.430342] RIP: 0010:evl_get_timer_overruns+0x1ac/0x1c0
>> [  347.430348] Code: eb d5 e8 c7 d7 f5 ff 49 89 c4 e9 9f fe ff ff 4c 89 =
f6 48 89 df e8 44 fd ff ff 48 8b 4b 48 e9 ba fe ff ff 0f 0b e9 13 ff ff ff =
<0f> 0b e9 2e ff ff ff 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 0f 1f
>> [  347.430350] RSP: 0018:ffffc900016c7dc0 EFLAGS: 00010002
>> [  347.430353] RAX: 0000000000000005 RBX: ffff88810429b400 RCX: 00000000=
00000007
>> [  347.430355] RDX: 00000000000025f9 RSI: 00000000000061a8 RDI: ffff8882=
37ac87d0
>> [  347.430357] RBP: ffff888237ac87d0 R08: 00000000ffffffff R09: 00000000=
00000001
>> [  347.430358] R10: 0000000000000082 R11: 0000000000000000 R12: 00000050=
e066c458
>> [  347.430360] R13: 0000000000000001 R14: ffff88810429b4b0 R15: ffff8881=
0429b400
>> [  347.430368] FS:  00007fa304e746c0(0000) GS:ffff888237b00000(0000) knl=
GS:0000000000000000
>> [  347.430370] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [  347.430372] CR2: 0000563c64c7d018 CR3: 00000001050ea000 CR4: 00000000=
000406e0
>> [  347.430374] Call Trace:
>> [  347.430376]  <TASK>
>> [  347.430378]  timerfd_oob_read+0x190/0x210
>> [  347.430385]  EVL_read+0x46/0x90
>> [  347.430388]  do_oob_syscall+0x11a/0x360
>> [  347.430392]  handle_oob_syscall+0xa5/0xf0
>> [  347.430395]  pipeline_syscall+0x93/0x110
>> [  347.430399]  syscall_enter_from_user_mode+0x57/0x120
>> [  347.430406]  do_syscall_64+0x1d/0xa0
>> [  347.430410]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>> [  347.430414] RIP: 0033:0x7fa305064308
>> [  347.430416] Code: Unable to access opcode bytes at 0x7fa3050642de.
>> [  347.430418] RSP: 002b:00007fa304e73a30 EFLAGS: 00000246 ORIG_RAX: 000=
00000000
>
> Please try this patch, this should help. To sum up, the conditions for
> the bug to trigger are as follows:
>
> - the timer and the thread consuming its ticks should run on distinct
>   CPUs,
>
> - an overrun condition must exist (the interval set to 25=C2=B5s in the t=
est
>   case made this more likely fortunately),
>
> This is an architecture-independent issue, caused by a SMP race.
>
> Thanks for the neat test case, this definitely helped in spotting the
> issue quickly.
>
> diff --git a/include/evl/timer.h b/include/evl/timer.h
> index 0f5616b26e385..c5ce4a0fff406 100644
> --- a/include/evl/timer.h
> +++ b/include/evl/timer.h
> @@ -179,7 +179,7 @@ struct evl_timer {
>  	int status;
>  	ktime_t interval;	/* 0 =3D=3D oneshot */
>  	ktime_t start_date;
> -	u64 pexpect_ticks;	/* periodic release date */
> +	u64 consumed_ticks;	/* advanced by evl_get_timer_overruns() */
>  	u64 periodic_ticks;
>  #ifdef CONFIG_SMP
>  	struct evl_rq *rq;
> @@ -263,7 +263,7 @@ static inline
>  ktime_t evl_get_timer_next_date(struct evl_timer *timer)
>  {
>  	return ktime_add_ns(timer->start_date,
> -			timer->pexpect_ticks * ktime_to_ns(timer->interval));
> +			timer->consumed_ticks * ktime_to_ns(timer->interval));
>  }
>=20=20
>  void __evl_init_timer(struct evl_timer *timer,
> diff --git a/kernel/evl/clock.c b/kernel/evl/clock.c
> index ca5422f2de3fd..e72db15cc6ca8 100644
> --- a/kernel/evl/clock.c
> +++ b/kernel/evl/clock.c
> @@ -85,7 +85,7 @@ static void adjust_timer(struct evl_clock *clock,
>  		 */
>  		div =3D ktime_divns(-diff, ktime_to_ns(period));
>  		timer->periodic_ticks -=3D div;
> -		timer->pexpect_ticks -=3D div;
> +		timer->consumed_ticks -=3D div;
>  		evl_update_timer_date(timer);
>  	}
>=20=20
> diff --git a/kernel/evl/timer.c b/kernel/evl/timer.c
> index c609676eae5ba..a53a53eb3e6f9 100644
> --- a/kernel/evl/timer.c
> +++ b/kernel/evl/timer.c
> @@ -160,7 +160,7 @@ void evl_start_timer(struct evl_timer *timer,
>  	if (!timeout_infinite(interval)) {
>  		timer->interval =3D interval;
>  		timer->start_date =3D value;
> -		timer->pexpect_ticks =3D 0;
> +		timer->consumed_ticks =3D 0;
>  		timer->periodic_ticks =3D 0;
>  		timer->status |=3D EVL_TIMER_PERIODIC;
>  	}
> @@ -415,21 +415,59 @@ unsigned long evl_get_timer_overruns(struct evl_tim=
er *timer)
>  	struct evl_tqueue *tq;
>  	ktime_t now, delta;
>=20=20
> -	now =3D evl_read_clock(timer->clock);
> +	if (EVL_WARN_ON_ONCE(CORE, !evl_timer_is_periodic(timer)))
> +		return 0;
> +
>  	base =3D lock_timer_base(timer, &flags);
> +	now =3D evl_read_clock(timer->clock);
>=20=20
> +	/*
> +	 * Measure the lateness with respect to the expected expiry
> +	 * date in the timeline for this timer. This ideal expiry date
> +	 * would be the start date of the timer, plus the interval
> +	 * duration times the number of ticks which were consumed so
> +	 * far. Any delay longer than the periodic interval denotes an
> +	 * overrun condition since we missed at least one tick.
> +	 */
>  	delta =3D ktime_sub(now, evl_get_timer_next_date(timer));
>  	if (likely(delta < timer->interval))
>  		goto done;
>=20=20
>  	overruns =3D ktime_divns(delta, ktime_to_ns(timer->interval));
> -	timer->pexpect_ticks +=3D overruns;
> +
> +	/*
> +	 * Compensate for the current lateness as the timer progresses
> +	 * in the timeline, consuming all missed ticks in one gulp to
> +	 * catch up.
> +	 */
> +	timer->consumed_ticks +=3D overruns;
> +
> +	/*
> +	 * We are about to re-enqueue the timer for its next expiry
> +	 * date. However, we refrain from doing so if either:
> +	 *
> +	 * - the timer was deactivated, in which case there is no
> +	 * point in planning for further expiry.
> +	 *
> +	 * - the timer is still running but not queued, which means
> +	 * that do_clock_tick() dequeued it then released the base
> +	 * lock on a remote CPU for running its handler. Since the
> +	 * timer is running and we hold that lock at the moment,
> +	 * do_clock_tick() is certainly going to either advance the
> +	 * expiry as required or shut the timer down after we drop the
> +	 * base lock. IOW, we may leave reprogramming to the core tick
> +	 * handler.
> +	 */
>  	if (!evl_timer_is_running(timer))
>  		goto done;
>=20=20
> -	EVL_WARN_ON_ONCE(CORE, (timer->status &
> -			(EVL_TIMER_DEQUEUED|EVL_TIMER_PERIODIC))
> -			!=3D EVL_TIMER_PERIODIC);
> +	if (timer->status & EVL_TIMER_DEQUEUED)
> +		goto done;
> +
> +	/*
> +	 * Re-enqueue the periodic timer so that it ticks at the next
> +	 * interval boundary.
> +	 */
>  	tq =3D &base->q;
>  	evl_dequeue_timer(timer, tq);
>  	while (evl_tdate(timer) < now) {
> @@ -439,7 +477,7 @@ unsigned long evl_get_timer_overruns(struct evl_timer=
 *timer)
>=20=20
>  	program_timer(timer, tq);
>  done:
> -	timer->pexpect_ticks++;
> +	timer->consumed_ticks++;
>=20=20
>  	unlock_timer_base(base, flags);

Full patch with the appropriate commit log.

commit 1a2f7029b1f8e408d0ba47c3fd1517e077013423 (HEAD -> rebase/v6.1.y-evl)
Author: Philippe Gerum <rpm@xenomai.org>
Date:   Sat Jun 3 16:14:46 2023 +0200

    evl/timer: fix SMP race in overrun handling
=20=20=20=20
    evl_get_timer_overruns() might attempt to dequeue an unqueued timer
    when handling an overrun, if the caller and the timer run on distinct
    CPUs.
=20=20=20=20
    Fix this by detecting the pattern illustrated below, in which case
    evl_get_timer_overruns() may leave the requeuing operation to the core
    clock tick handler.
=20=20=20=20
    T: a thread waiting for wakeup events on a periodic timeline.
    t: the periodic timer.
=20=20=20=20
    CPU0                        CPU1
    ----                        ----
=20=20=20=20
                                T: <wait_for_next_period>
    do_clock_tick()
        lock(t->base)
        dequeue(t)
        unlock(t->base)
           t->handler()
        lock(t->base)
        enqueue(t)
        unlock(t->base)
        remote-wakeup(T)
=20=20=20=20
    <OVERRUN>
=20=20=20=20
    do_clock_tick()
        lock(t->base)
        dequeue(t)
        unlock(t->base)
                                T: evl_get_timer_overruns()
                                        lock(t->base)
                                        dequeue(t)
                                        <!> double removal
=20=20=20=20
    See https://lore.kernel.org/xenomai/874jnoyghn.fsf@xenomai.org/T/
=20=20=20=20
    Signed-off-by: Philippe Gerum <rpm@xenomai.org>

diff --git a/include/evl/timer.h b/include/evl/timer.h
index 0f5616b26e385..c5ce4a0fff406 100644
--- a/include/evl/timer.h
+++ b/include/evl/timer.h
@@ -179,7 +179,7 @@ struct evl_timer {
 	int status;
 	ktime_t interval;	/* 0 =3D=3D oneshot */
 	ktime_t start_date;
-	u64 pexpect_ticks;	/* periodic release date */
+	u64 consumed_ticks;	/* advanced by evl_get_timer_overruns() */
 	u64 periodic_ticks;
 #ifdef CONFIG_SMP
 	struct evl_rq *rq;
@@ -263,7 +263,7 @@ static inline
 ktime_t evl_get_timer_next_date(struct evl_timer *timer)
 {
 	return ktime_add_ns(timer->start_date,
-			timer->pexpect_ticks * ktime_to_ns(timer->interval));
+			timer->consumed_ticks * ktime_to_ns(timer->interval));
 }
=20
 void __evl_init_timer(struct evl_timer *timer,
diff --git a/kernel/evl/clock.c b/kernel/evl/clock.c
index ca5422f2de3fd..e72db15cc6ca8 100644
--- a/kernel/evl/clock.c
+++ b/kernel/evl/clock.c
@@ -85,7 +85,7 @@ static void adjust_timer(struct evl_clock *clock,
 		 */
 		div =3D ktime_divns(-diff, ktime_to_ns(period));
 		timer->periodic_ticks -=3D div;
-		timer->pexpect_ticks -=3D div;
+		timer->consumed_ticks -=3D div;
 		evl_update_timer_date(timer);
 	}
=20
diff --git a/kernel/evl/timer.c b/kernel/evl/timer.c
index c609676eae5ba..a53a53eb3e6f9 100644
--- a/kernel/evl/timer.c
+++ b/kernel/evl/timer.c
@@ -160,7 +160,7 @@ void evl_start_timer(struct evl_timer *timer,
 	if (!timeout_infinite(interval)) {
 		timer->interval =3D interval;
 		timer->start_date =3D value;
-		timer->pexpect_ticks =3D 0;
+		timer->consumed_ticks =3D 0;
 		timer->periodic_ticks =3D 0;
 		timer->status |=3D EVL_TIMER_PERIODIC;
 	}
@@ -415,21 +415,59 @@ unsigned long evl_get_timer_overruns(struct evl_timer=
 *timer)
 	struct evl_tqueue *tq;
 	ktime_t now, delta;
=20
-	now =3D evl_read_clock(timer->clock);
+	if (EVL_WARN_ON_ONCE(CORE, !evl_timer_is_periodic(timer)))
+		return 0;
+
 	base =3D lock_timer_base(timer, &flags);
+	now =3D evl_read_clock(timer->clock);
=20
+	/*
+	 * Measure the lateness with respect to the expected expiry
+	 * date in the timeline for this timer. This ideal expiry date
+	 * would be the start date of the timer, plus the interval
+	 * duration times the number of ticks which were consumed so
+	 * far. Any delay longer than the periodic interval denotes an
+	 * overrun condition since we missed at least one tick.
+	 */
 	delta =3D ktime_sub(now, evl_get_timer_next_date(timer));
 	if (likely(delta < timer->interval))
 		goto done;
=20
 	overruns =3D ktime_divns(delta, ktime_to_ns(timer->interval));
-	timer->pexpect_ticks +=3D overruns;
+
+	/*
+	 * Compensate for the current lateness as the timer progresses
+	 * in the timeline, consuming all missed ticks in one gulp to
+	 * catch up.
+	 */
+	timer->consumed_ticks +=3D overruns;
+
+	/*
+	 * We are about to re-enqueue the timer for its next expiry
+	 * date. However, we refrain from doing so if either:
+	 *
+	 * - the timer was deactivated, in which case there is no
+	 * point in planning for further expiry.
+	 *
+	 * - the timer is still running but not queued, which means
+	 * that do_clock_tick() dequeued it then released the base
+	 * lock on a remote CPU for running its handler. Since the
+	 * timer is running and we hold that lock at the moment,
+	 * do_clock_tick() is certainly going to either advance the
+	 * expiry as required or shut the timer down after we drop the
+	 * base lock. IOW, we may leave reprogramming to the core tick
+	 * handler.
+	 */
 	if (!evl_timer_is_running(timer))
 		goto done;
=20
-	EVL_WARN_ON_ONCE(CORE, (timer->status &
-			(EVL_TIMER_DEQUEUED|EVL_TIMER_PERIODIC))
-			!=3D EVL_TIMER_PERIODIC);
+	if (timer->status & EVL_TIMER_DEQUEUED)
+		goto done;
+
+	/*
+	 * Re-enqueue the periodic timer so that it ticks at the next
+	 * interval boundary.
+	 */
 	tq =3D &base->q;
 	evl_dequeue_timer(timer, tq);
 	while (evl_tdate(timer) < now) {
@@ -439,7 +477,7 @@ unsigned long evl_get_timer_overruns(struct evl_timer *=
timer)
=20
 	program_timer(timer, tq);
 done:
-	timer->pexpect_ticks++;
+	timer->consumed_ticks++;
=20
 	unlock_timer_base(base, flags);

--=20
Philippe.
