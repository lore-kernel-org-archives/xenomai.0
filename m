Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E5F37B97
	for <xenomai@lists.linux.dev>; Tue,  6 Jun 2023 15:38:52 +0000 (UTC)
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-62615694bb9so44107336d6.0
        for <xenomai@lists.linux.dev>; Tue, 06 Jun 2023 08:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686065932; x=1688657932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z1jMArw4FWBqKIRKdj62vU2eB9n+UiychQ3D5Jk6iOo=;
        b=iNECLWN07I0+KyZnEMMpF+OH0o4i+UFuRz1i4BOhYDMl8WwTV7ytXQgQ4dPJG2poCj
         sDsRFMcNl2cH1guZ9HfPx4w5AdhZo/ytkh4pxYuA0upzdYtoBg6I0LcAkfeBtS/8S6hA
         pVJ1CfdKnpbMFIFfJlhdsou5y7O2iXRKyymYZSBFn7HvGFv1SO3QJY6sbbF9XSmceOQI
         FxfiWKK8oeUqeduop1R/1vHUbYU8SJGBNbN7eIemYqzW2BPpO7hnekQxDXW1LmhgMWxr
         D0qH7t4FmCeuRaBoNCBQ8lAfBMKhT84g/AYgIAIuW+LLka1UIrNldgzLnJ2GAdBFeYRI
         BiAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686065932; x=1688657932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z1jMArw4FWBqKIRKdj62vU2eB9n+UiychQ3D5Jk6iOo=;
        b=Vz/vEAPGRxp8hOx6xgys3HOJlLwmJQJGHZGK6euARvq+gxiafaSzb2jIT667qfTbGj
         VlxDhi3PUy25E69twu3z/PqhKP+8NEG9wKi/1OykMIiZL1jFtsK8AHZOoA6oY3/NDWD8
         A6rWWuVL9mqQ3Lqes2XUYiACawKMiiSHNs/P+R9FnEOeFu24hsISTS5i6BguL2VdNUle
         KE7JHGl0y8KI7K1eK8SJ5qHm8j7RcwRI7lOUHCM7VXUUobWwp5JQ8U/lx/EhYt1DmaPr
         yx2pU9q0e4ejQITSX9Cgn+tW+VI8HhhTz/at/7UN+/DbMcfir2+SRi0BMleyAd7ML172
         cvqg==
X-Gm-Message-State: AC+VfDzqpLZyFyKGnslKLn9NfV78azmhMXt8h8LO22vsuZV8Vzp5dDC0
	ZJSNOxqDfZESVKtRn6e3QGi4lvssFZBlpHNCEtXEt9H2uJ8=
X-Google-Smtp-Source: ACHHUZ68734ukwsRpRiPYVax7IZsCKsM+6qFA8x4muKuu2Fh5bKBmBzMcL1j4wHu2EOsLtKH6KUj7hqNatVIFecUv78=
X-Received: by 2002:a05:6214:19e9:b0:5b9:ff75:a011 with SMTP id
 q9-20020a05621419e900b005b9ff75a011mr3142961qvc.48.1686065931555; Tue, 06 Jun
 2023 08:38:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAAm9oxrZ+g7RgBV0SC5GkvEeKKGXOZb2R_BRjf0qRObQM1wCgg@mail.gmail.com>
 <87mt84h3h0.fsf@xenomai.org> <87ilish1z0.fsf@xenomai.org> <CAAm9oxp-Zm+25CpxT7wYUiDWxZGBxStB14D8QnEZWDmCp6jYsQ@mail.gmail.com>
 <87359qwclj.fsf@xenomai.org> <CAAm9oxoRmKRZhOCa7PVmazCxouy2OdcHAxwCFJBEXwk1JcDnyQ@mail.gmail.com>
 <874jnoyghn.fsf@xenomai.org> <87zg5gws3p.fsf@xenomai.org> <CAAm9oxp9DgeU6GZeF8cnUzkUoQOYMvzm23xgxN4Tf8AszVb_Lw@mail.gmail.com>
In-Reply-To: <CAAm9oxp9DgeU6GZeF8cnUzkUoQOYMvzm23xgxN4Tf8AszVb_Lw@mail.gmail.com>
From: Sri Subramanian <sridhar.subramanian@gmail.com>
Date: Tue, 6 Jun 2023 08:38:40 -0700
Message-ID: <CAAm9oxpjXe98YC-PReRCza40_t-A3fx3F+VVDj-gAbichXwWFw@mail.gmail.com>
Subject: Re: Xenomai crash in timer IRQ
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Phillipe,

I've tested the patch on the product, and can confirm that the patched
kernel works well and doesn't crash.

Thanks,
Sri

On Sun, Jun 4, 2023 at 9:47=E2=80=AFPM Sri Subramanian
<sridhar.subramanian@gmail.com> wrote:
>
> Hello Philippe,
>
> Thanks for your quick fix! I can confirm it works for the test program
> in my environment.
>
> I'll try the fix in the product and let you know.
>
> Thanks again!
> Sri
>
> On Sat, Jun 3, 2023 at 7:14=E2=80=AFAM Philippe Gerum <rpm@xenomai.org> w=
rote:
> >
> >
> > Philippe Gerum <rpm@xenomai.org> writes:
> >
> > > Sri Subramanian <sridhar.subramanian@gmail.com> writes:
> > >
> > >> Hi Philippe,
> > >>
> > >> Sorry for the long pause in this thread.
> > >>
> > >> However, I am able to reproduce the kernel crash stack (off
> > >> timerfd_oob_read) with a simple test program which does the followin=
g:
> > >>
> > >> In a loop:
> > >>   create timer fd
> > >>   create thread which
> > >>        sets up periodic triggers off the monotonic timer
> > >>       closes the timer after a few periods.
> > >>   join w/thread
> > >>
> > >> If the main thread and the timer thread are in the same cpu, I can r=
un
> > >> it with hectic in the background for 2 hrs at least. However, if the
> > >> threads are on different cpus, the kernel crashes within minutes. I =
am
> > >> attaching the crash and the test program.
> > >>
> > >> Environment:
> > >> HW: Raspberry Pi (CM4)
> > >> SW: Xenomai 5.15.109 tag, Libevl r44
> > >>
> > >> Test steps:
> > >> # hectic -s 200 -q&
> > >> # ./timer-crash1 -a 0 -t 1 -q&
> > >>
> > >> BTW: this thread's history implies changes to the realtime clock, bu=
t
> > >> really, this doesn't have anything to do with it.
> > >
> > > Ouch, confirmed. Something is wrong, this is a generic issue. Working=
 on
> > > it.
> > >
> > > root@homelab-qemu-x86_64:~# ./timerfd_crash -a 1 -t 2
> > > 0[  347.430316] ------------[ cut here ]------------
> > > [  347.430319] WARNING: CPU: 2 PID: 3241 at kernel/evl/timer.c:430 ev=
l_get_timer_overruns+0x1ac/0x1c0
> > > [  347.430332] Modules linked in:
> > > [  347.430334] CPU: 2 PID: 3241 Comm: timer-crash1-ch Not tainted 6.1=
.29+ #178
> > > [  347.430338] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),=
 BIOS 1.16.2-1.fc38 04/01/2014
> > > [  347.430340] IRQ stage: EVL
> > > [  347.430342] RIP: 0010:evl_get_timer_overruns+0x1ac/0x1c0
> > > [  347.430348] Code: eb d5 e8 c7 d7 f5 ff 49 89 c4 e9 9f fe ff ff 4c =
89 f6 48 89 df e8 44 fd ff ff 48 8b 4b 48 e9 ba fe ff ff 0f 0b e9 13 ff ff =
ff <0f> 0b e9 2e ff ff ff 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 0f 1f
> > > [  347.430350] RSP: 0018:ffffc900016c7dc0 EFLAGS: 00010002
> > > [  347.430353] RAX: 0000000000000005 RBX: ffff88810429b400 RCX: 00000=
00000000007
> > > [  347.430355] RDX: 00000000000025f9 RSI: 00000000000061a8 RDI: ffff8=
88237ac87d0
> > > [  347.430357] RBP: ffff888237ac87d0 R08: 00000000ffffffff R09: 00000=
00000000001
> > > [  347.430358] R10: 0000000000000082 R11: 0000000000000000 R12: 00000=
050e066c458
> > > [  347.430360] R13: 0000000000000001 R14: ffff88810429b4b0 R15: ffff8=
8810429b400
> > > [  347.430368] FS:  00007fa304e746c0(0000) GS:ffff888237b00000(0000) =
knlGS:0000000000000000
> > > [  347.430370] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [  347.430372] CR2: 0000563c64c7d018 CR3: 00000001050ea000 CR4: 00000=
000000406e0
> > > [  347.430374] Call Trace:
> > > [  347.430376]  <TASK>
> > > [  347.430378]  timerfd_oob_read+0x190/0x210
> > > [  347.430385]  EVL_read+0x46/0x90
> > > [  347.430388]  do_oob_syscall+0x11a/0x360
> > > [  347.430392]  handle_oob_syscall+0xa5/0xf0
> > > [  347.430395]  pipeline_syscall+0x93/0x110
> > > [  347.430399]  syscall_enter_from_user_mode+0x57/0x120
> > > [  347.430406]  do_syscall_64+0x1d/0xa0
> > > [  347.430410]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > > [  347.430414] RIP: 0033:0x7fa305064308
> > > [  347.430416] Code: Unable to access opcode bytes at 0x7fa3050642de.
> > > [  347.430418] RSP: 002b:00007fa304e73a30 EFLAGS: 00000246 ORIG_RAX: =
00000000000
> >
> > Please try this patch, this should help. To sum up, the conditions for
> > the bug to trigger are as follows:
> >
> > - the timer and the thread consuming its ticks should run on distinct
> >   CPUs,
> >
> > - an overrun condition must exist (the interval set to 25=C2=B5s in the=
 test
> >   case made this more likely fortunately),
> >
> > This is an architecture-independent issue, caused by a SMP race.
> >
> > Thanks for the neat test case, this definitely helped in spotting the
> > issue quickly.
> >
> > diff --git a/include/evl/timer.h b/include/evl/timer.h
> > index 0f5616b26e385..c5ce4a0fff406 100644
> > --- a/include/evl/timer.h
> > +++ b/include/evl/timer.h
> > @@ -179,7 +179,7 @@ struct evl_timer {
> >         int status;
> >         ktime_t interval;       /* 0 =3D=3D oneshot */
> >         ktime_t start_date;
> > -       u64 pexpect_ticks;      /* periodic release date */
> > +       u64 consumed_ticks;     /* advanced by evl_get_timer_overruns()=
 */
> >         u64 periodic_ticks;
> >  #ifdef CONFIG_SMP
> >         struct evl_rq *rq;
> > @@ -263,7 +263,7 @@ static inline
> >  ktime_t evl_get_timer_next_date(struct evl_timer *timer)
> >  {
> >         return ktime_add_ns(timer->start_date,
> > -                       timer->pexpect_ticks * ktime_to_ns(timer->inter=
val));
> > +                       timer->consumed_ticks * ktime_to_ns(timer->inte=
rval));
> >  }
> >
> >  void __evl_init_timer(struct evl_timer *timer,
> > diff --git a/kernel/evl/clock.c b/kernel/evl/clock.c
> > index ca5422f2de3fd..e72db15cc6ca8 100644
> > --- a/kernel/evl/clock.c
> > +++ b/kernel/evl/clock.c
> > @@ -85,7 +85,7 @@ static void adjust_timer(struct evl_clock *clock,
> >                  */
> >                 div =3D ktime_divns(-diff, ktime_to_ns(period));
> >                 timer->periodic_ticks -=3D div;
> > -               timer->pexpect_ticks -=3D div;
> > +               timer->consumed_ticks -=3D div;
> >                 evl_update_timer_date(timer);
> >         }
> >
> > diff --git a/kernel/evl/timer.c b/kernel/evl/timer.c
> > index c609676eae5ba..a53a53eb3e6f9 100644
> > --- a/kernel/evl/timer.c
> > +++ b/kernel/evl/timer.c
> > @@ -160,7 +160,7 @@ void evl_start_timer(struct evl_timer *timer,
> >         if (!timeout_infinite(interval)) {
> >                 timer->interval =3D interval;
> >                 timer->start_date =3D value;
> > -               timer->pexpect_ticks =3D 0;
> > +               timer->consumed_ticks =3D 0;
> >                 timer->periodic_ticks =3D 0;
> >                 timer->status |=3D EVL_TIMER_PERIODIC;
> >         }
> > @@ -415,21 +415,59 @@ unsigned long evl_get_timer_overruns(struct evl_t=
imer *timer)
> >         struct evl_tqueue *tq;
> >         ktime_t now, delta;
> >
> > -       now =3D evl_read_clock(timer->clock);
> > +       if (EVL_WARN_ON_ONCE(CORE, !evl_timer_is_periodic(timer)))
> > +               return 0;
> > +
> >         base =3D lock_timer_base(timer, &flags);
> > +       now =3D evl_read_clock(timer->clock);
> >
> > +       /*
> > +        * Measure the lateness with respect to the expected expiry
> > +        * date in the timeline for this timer. This ideal expiry date
> > +        * would be the start date of the timer, plus the interval
> > +        * duration times the number of ticks which were consumed so
> > +        * far. Any delay longer than the periodic interval denotes an
> > +        * overrun condition since we missed at least one tick.
> > +        */
> >         delta =3D ktime_sub(now, evl_get_timer_next_date(timer));
> >         if (likely(delta < timer->interval))
> >                 goto done;
> >
> >         overruns =3D ktime_divns(delta, ktime_to_ns(timer->interval));
> > -       timer->pexpect_ticks +=3D overruns;
> > +
> > +       /*
> > +        * Compensate for the current lateness as the timer progresses
> > +        * in the timeline, consuming all missed ticks in one gulp to
> > +        * catch up.
> > +        */
> > +       timer->consumed_ticks +=3D overruns;
> > +
> > +       /*
> > +        * We are about to re-enqueue the timer for its next expiry
> > +        * date. However, we refrain from doing so if either:
> > +        *
> > +        * - the timer was deactivated, in which case there is no
> > +        * point in planning for further expiry.
> > +        *
> > +        * - the timer is still running but not queued, which means
> > +        * that do_clock_tick() dequeued it then released the base
> > +        * lock on a remote CPU for running its handler. Since the
> > +        * timer is running and we hold that lock at the moment,
> > +        * do_clock_tick() is certainly going to either advance the
> > +        * expiry as required or shut the timer down after we drop the
> > +        * base lock. IOW, we may leave reprogramming to the core tick
> > +        * handler.
> > +        */
> >         if (!evl_timer_is_running(timer))
> >                 goto done;
> >
> > -       EVL_WARN_ON_ONCE(CORE, (timer->status &
> > -                       (EVL_TIMER_DEQUEUED|EVL_TIMER_PERIODIC))
> > -                       !=3D EVL_TIMER_PERIODIC);
> > +       if (timer->status & EVL_TIMER_DEQUEUED)
> > +               goto done;
> > +
> > +       /*
> > +        * Re-enqueue the periodic timer so that it ticks at the next
> > +        * interval boundary.
> > +        */
> >         tq =3D &base->q;
> >         evl_dequeue_timer(timer, tq);
> >         while (evl_tdate(timer) < now) {
> > @@ -439,7 +477,7 @@ unsigned long evl_get_timer_overruns(struct evl_tim=
er *timer)
> >
> >         program_timer(timer, tq);
> >  done:
> > -       timer->pexpect_ticks++;
> > +       timer->consumed_ticks++;
> >
> >         unlock_timer_base(base, flags);
> >
> > --
> > Philippe.
