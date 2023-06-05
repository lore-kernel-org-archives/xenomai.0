Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E00631
	for <xenomai@lists.linux.dev>; Mon,  5 Jun 2023 04:47:16 +0000 (UTC)
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-62614a1dd47so32149946d6.2
        for <xenomai@lists.linux.dev>; Sun, 04 Jun 2023 21:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685940435; x=1688532435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+nXglQPf2qUbviHmcYecLJhA1Gzj/6B5VUFguKAJP0k=;
        b=Q7Yeat/NXL7baCHyMJzAJTIFgjrEqqiY4+nEQOB2bwiM+GXWsd1SS5iovRhARUiaoM
         MIyJZ9bUOi72y95CnYYAgAzPRG92RNGp7/OJ8wkBm6B0XU+3vx9pp4iDfi4Sv4/nd5Ja
         ClIkKvvMvxjFHzdsHUjMf/AHZbyZnNOc1jmUFE+u0MGlKn+iEFm50qdkprFO8uUnr02A
         QsdyqO7A1TxMgyb0vZv7GOsOe8UB65bmJBBvfHjlAgzrtn0s18FVQ2fT9a214oJS/eWw
         mnmMkwHMbOjRtgZsZV6AIXjxhmvdlENcNlylAjXQR2tqhEDp9eycvy66MdeX0+HpTpeq
         /R1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685940435; x=1688532435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+nXglQPf2qUbviHmcYecLJhA1Gzj/6B5VUFguKAJP0k=;
        b=C/YYS8Iy7J1sIT8zjtK8QeCyO+SsuO1kiTmvYFq1IUe4fGuDMyHrq7Sq7Auu+Z6Jds
         EZPb1+LNf956OiK8XQWFwtXcij14DQa3znf2ZLEdVAxO3FjmqFGhxaOVecbMpv4IzHNQ
         HukfEaZUz2Wt0BB4UOdj5diPyoI7u5xMBZn9prVnPRtcVgWx7psrORubcNAP+n/muiqt
         wdE8wGpsl6e2jaPqPjz1leD/whX5rqqnOfL5KMzDy2rg3hc7l+WzzxW5PjGxW+dM2j3K
         3wHPpWNfXQQnJf0JzyckuU1iYKaATNueTyDVAgZ88LNLA0bM0yuGZJgNk0PTRmgc4t2D
         TNpA==
X-Gm-Message-State: AC+VfDxPtRwxy4LTeLNM9WXfXwjbQZFbZ/sdsQmEDjeR8yH54NaUOxC0
	bb8kppwFfOuw2R7vKQ1OXvgXOCzSlRDrOlFM2n2kC1fQ+78=
X-Google-Smtp-Source: ACHHUZ6wPXX3/juwDyhyAyLMZj7PmzLBhnkLbE1wGYmdiPcNci317qHHdJHUpAx+i0BCoKqIl+jKscJiK4wcO6jNiYw=
X-Received: by 2002:a05:6214:2389:b0:626:25f7:3bee with SMTP id
 fw9-20020a056214238900b0062625f73beemr5876112qvb.34.1685940435460; Sun, 04
 Jun 2023 21:47:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAAm9oxrZ+g7RgBV0SC5GkvEeKKGXOZb2R_BRjf0qRObQM1wCgg@mail.gmail.com>
 <87mt84h3h0.fsf@xenomai.org> <87ilish1z0.fsf@xenomai.org> <CAAm9oxp-Zm+25CpxT7wYUiDWxZGBxStB14D8QnEZWDmCp6jYsQ@mail.gmail.com>
 <87359qwclj.fsf@xenomai.org> <CAAm9oxoRmKRZhOCa7PVmazCxouy2OdcHAxwCFJBEXwk1JcDnyQ@mail.gmail.com>
 <874jnoyghn.fsf@xenomai.org> <87zg5gws3p.fsf@xenomai.org>
In-Reply-To: <87zg5gws3p.fsf@xenomai.org>
From: Sri Subramanian <sridhar.subramanian@gmail.com>
Date: Sun, 4 Jun 2023 21:47:04 -0700
Message-ID: <CAAm9oxp9DgeU6GZeF8cnUzkUoQOYMvzm23xgxN4Tf8AszVb_Lw@mail.gmail.com>
Subject: Re: Xenomai crash in timer IRQ
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Philippe,

Thanks for your quick fix! I can confirm it works for the test program
in my environment.

I'll try the fix in the product and let you know.

Thanks again!
Sri

On Sat, Jun 3, 2023 at 7:14=E2=80=AFAM Philippe Gerum <rpm@xenomai.org> wro=
te:
>
>
> Philippe Gerum <rpm@xenomai.org> writes:
>
> > Sri Subramanian <sridhar.subramanian@gmail.com> writes:
> >
> >> Hi Philippe,
> >>
> >> Sorry for the long pause in this thread.
> >>
> >> However, I am able to reproduce the kernel crash stack (off
> >> timerfd_oob_read) with a simple test program which does the following:
> >>
> >> In a loop:
> >>   create timer fd
> >>   create thread which
> >>        sets up periodic triggers off the monotonic timer
> >>       closes the timer after a few periods.
> >>   join w/thread
> >>
> >> If the main thread and the timer thread are in the same cpu, I can run
> >> it with hectic in the background for 2 hrs at least. However, if the
> >> threads are on different cpus, the kernel crashes within minutes. I am
> >> attaching the crash and the test program.
> >>
> >> Environment:
> >> HW: Raspberry Pi (CM4)
> >> SW: Xenomai 5.15.109 tag, Libevl r44
> >>
> >> Test steps:
> >> # hectic -s 200 -q&
> >> # ./timer-crash1 -a 0 -t 1 -q&
> >>
> >> BTW: this thread's history implies changes to the realtime clock, but
> >> really, this doesn't have anything to do with it.
> >
> > Ouch, confirmed. Something is wrong, this is a generic issue. Working o=
n
> > it.
> >
> > root@homelab-qemu-x86_64:~# ./timerfd_crash -a 1 -t 2
> > 0[  347.430316] ------------[ cut here ]------------
> > [  347.430319] WARNING: CPU: 2 PID: 3241 at kernel/evl/timer.c:430 evl_=
get_timer_overruns+0x1ac/0x1c0
> > [  347.430332] Modules linked in:
> > [  347.430334] CPU: 2 PID: 3241 Comm: timer-crash1-ch Not tainted 6.1.2=
9+ #178
> > [  347.430338] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), B=
IOS 1.16.2-1.fc38 04/01/2014
> > [  347.430340] IRQ stage: EVL
> > [  347.430342] RIP: 0010:evl_get_timer_overruns+0x1ac/0x1c0
> > [  347.430348] Code: eb d5 e8 c7 d7 f5 ff 49 89 c4 e9 9f fe ff ff 4c 89=
 f6 48 89 df e8 44 fd ff ff 48 8b 4b 48 e9 ba fe ff ff 0f 0b e9 13 ff ff ff=
 <0f> 0b e9 2e ff ff ff 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 0f 1f
> > [  347.430350] RSP: 0018:ffffc900016c7dc0 EFLAGS: 00010002
> > [  347.430353] RAX: 0000000000000005 RBX: ffff88810429b400 RCX: 0000000=
000000007
> > [  347.430355] RDX: 00000000000025f9 RSI: 00000000000061a8 RDI: ffff888=
237ac87d0
> > [  347.430357] RBP: ffff888237ac87d0 R08: 00000000ffffffff R09: 0000000=
000000001
> > [  347.430358] R10: 0000000000000082 R11: 0000000000000000 R12: 0000005=
0e066c458
> > [  347.430360] R13: 0000000000000001 R14: ffff88810429b4b0 R15: ffff888=
10429b400
> > [  347.430368] FS:  00007fa304e746c0(0000) GS:ffff888237b00000(0000) kn=
lGS:0000000000000000
> > [  347.430370] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  347.430372] CR2: 0000563c64c7d018 CR3: 00000001050ea000 CR4: 0000000=
0000406e0
> > [  347.430374] Call Trace:
> > [  347.430376]  <TASK>
> > [  347.430378]  timerfd_oob_read+0x190/0x210
> > [  347.430385]  EVL_read+0x46/0x90
> > [  347.430388]  do_oob_syscall+0x11a/0x360
> > [  347.430392]  handle_oob_syscall+0xa5/0xf0
> > [  347.430395]  pipeline_syscall+0x93/0x110
> > [  347.430399]  syscall_enter_from_user_mode+0x57/0x120
> > [  347.430406]  do_syscall_64+0x1d/0xa0
> > [  347.430410]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > [  347.430414] RIP: 0033:0x7fa305064308
> > [  347.430416] Code: Unable to access opcode bytes at 0x7fa3050642de.
> > [  347.430418] RSP: 002b:00007fa304e73a30 EFLAGS: 00000246 ORIG_RAX: 00=
000000000
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
>         int status;
>         ktime_t interval;       /* 0 =3D=3D oneshot */
>         ktime_t start_date;
> -       u64 pexpect_ticks;      /* periodic release date */
> +       u64 consumed_ticks;     /* advanced by evl_get_timer_overruns() *=
/
>         u64 periodic_ticks;
>  #ifdef CONFIG_SMP
>         struct evl_rq *rq;
> @@ -263,7 +263,7 @@ static inline
>  ktime_t evl_get_timer_next_date(struct evl_timer *timer)
>  {
>         return ktime_add_ns(timer->start_date,
> -                       timer->pexpect_ticks * ktime_to_ns(timer->interva=
l));
> +                       timer->consumed_ticks * ktime_to_ns(timer->interv=
al));
>  }
>
>  void __evl_init_timer(struct evl_timer *timer,
> diff --git a/kernel/evl/clock.c b/kernel/evl/clock.c
> index ca5422f2de3fd..e72db15cc6ca8 100644
> --- a/kernel/evl/clock.c
> +++ b/kernel/evl/clock.c
> @@ -85,7 +85,7 @@ static void adjust_timer(struct evl_clock *clock,
>                  */
>                 div =3D ktime_divns(-diff, ktime_to_ns(period));
>                 timer->periodic_ticks -=3D div;
> -               timer->pexpect_ticks -=3D div;
> +               timer->consumed_ticks -=3D div;
>                 evl_update_timer_date(timer);
>         }
>
> diff --git a/kernel/evl/timer.c b/kernel/evl/timer.c
> index c609676eae5ba..a53a53eb3e6f9 100644
> --- a/kernel/evl/timer.c
> +++ b/kernel/evl/timer.c
> @@ -160,7 +160,7 @@ void evl_start_timer(struct evl_timer *timer,
>         if (!timeout_infinite(interval)) {
>                 timer->interval =3D interval;
>                 timer->start_date =3D value;
> -               timer->pexpect_ticks =3D 0;
> +               timer->consumed_ticks =3D 0;
>                 timer->periodic_ticks =3D 0;
>                 timer->status |=3D EVL_TIMER_PERIODIC;
>         }
> @@ -415,21 +415,59 @@ unsigned long evl_get_timer_overruns(struct evl_tim=
er *timer)
>         struct evl_tqueue *tq;
>         ktime_t now, delta;
>
> -       now =3D evl_read_clock(timer->clock);
> +       if (EVL_WARN_ON_ONCE(CORE, !evl_timer_is_periodic(timer)))
> +               return 0;
> +
>         base =3D lock_timer_base(timer, &flags);
> +       now =3D evl_read_clock(timer->clock);
>
> +       /*
> +        * Measure the lateness with respect to the expected expiry
> +        * date in the timeline for this timer. This ideal expiry date
> +        * would be the start date of the timer, plus the interval
> +        * duration times the number of ticks which were consumed so
> +        * far. Any delay longer than the periodic interval denotes an
> +        * overrun condition since we missed at least one tick.
> +        */
>         delta =3D ktime_sub(now, evl_get_timer_next_date(timer));
>         if (likely(delta < timer->interval))
>                 goto done;
>
>         overruns =3D ktime_divns(delta, ktime_to_ns(timer->interval));
> -       timer->pexpect_ticks +=3D overruns;
> +
> +       /*
> +        * Compensate for the current lateness as the timer progresses
> +        * in the timeline, consuming all missed ticks in one gulp to
> +        * catch up.
> +        */
> +       timer->consumed_ticks +=3D overruns;
> +
> +       /*
> +        * We are about to re-enqueue the timer for its next expiry
> +        * date. However, we refrain from doing so if either:
> +        *
> +        * - the timer was deactivated, in which case there is no
> +        * point in planning for further expiry.
> +        *
> +        * - the timer is still running but not queued, which means
> +        * that do_clock_tick() dequeued it then released the base
> +        * lock on a remote CPU for running its handler. Since the
> +        * timer is running and we hold that lock at the moment,
> +        * do_clock_tick() is certainly going to either advance the
> +        * expiry as required or shut the timer down after we drop the
> +        * base lock. IOW, we may leave reprogramming to the core tick
> +        * handler.
> +        */
>         if (!evl_timer_is_running(timer))
>                 goto done;
>
> -       EVL_WARN_ON_ONCE(CORE, (timer->status &
> -                       (EVL_TIMER_DEQUEUED|EVL_TIMER_PERIODIC))
> -                       !=3D EVL_TIMER_PERIODIC);
> +       if (timer->status & EVL_TIMER_DEQUEUED)
> +               goto done;
> +
> +       /*
> +        * Re-enqueue the periodic timer so that it ticks at the next
> +        * interval boundary.
> +        */
>         tq =3D &base->q;
>         evl_dequeue_timer(timer, tq);
>         while (evl_tdate(timer) < now) {
> @@ -439,7 +477,7 @@ unsigned long evl_get_timer_overruns(struct evl_timer=
 *timer)
>
>         program_timer(timer, tq);
>  done:
> -       timer->pexpect_ticks++;
> +       timer->consumed_ticks++;
>
>         unlock_timer_base(base, flags);
>
> --
> Philippe.
