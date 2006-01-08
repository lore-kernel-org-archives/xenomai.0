Subject: Re: [Xenomai-core] latency kernel part crashes on ppc64
From: Stelian Pop <stelian.pop@domain.hid>
In-Reply-To: <43C14453.3040907@domain.hid>
References: <43C12304.4040802@domain.hid> <43C12CEC.8070403@domain.hid>
	<43C14453.3040907@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Date: Sun, 08 Jan 2006 22:02:29 +0100
Message-Id: <1136754149.17443.21.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Heikki Lindholm <holindho@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

Le dimanche 08 janvier 2006 =E0 18:56 +0200, Heikki Lindholm a =E9crit :

> >>Some recent changes (*cough* RTDM benchmark driver *cough*) broke ker=
nel
> >>mode benchmarking for ppc64. Previously klatency worked fine, but now
> >>latency -t 1 crashes somewhere in xnpod_schedule. Jan, any pending
> >>patches a comin'?

So it seems I'm not alone.=20

I have done some additionnal debugging on this issue in the last days. I
still haven't find the bug but I narrowed it down a bit.
>=20
> >=20
> > Nope, it should work as it is. But as Stelian also reported problems =
on
> > his fresh ARM port with the in-kernel test, I cannot exclude that the=
re
> > /might/ be a problem in the benchmark.
> >=20
> > As I don't have any ppc64 hanging around somewhere, we will have to g=
o
> > through this together. Things I would like to know:
>=20
> Dammit, I hoped you'd whip up a fix just from me noting a problem. Well=
,=20
> all right then, I'll play along...;)
>=20
> >  o When and how does it crash? At start-up immediately? Or after a
> >    while?
>=20
> I inserted some serial debug prints and it gets two passes to=20
> eval_outer_loop done (enter/exit function). After that it freezes.=20

It freezes exactly upon the invocation of rtdm_event_pulse() which
causes a scheduling. In xnpod_schedule, the scheduler queue has been
corrupted and this causes the illegal accesses.

> Without the debug printing it dies with kernel access of illegal memory=
=20
> at xnpod_schedule, which btw. has been quite a common place to die.

Same for me.

> >  o Are there any details / backtraces available with the crash?
>=20
> Becaktrace limits to xnpod_schedule if I remember right.

Same for me. But very often I don't even get a backtrace, it just hangs.

> >  o Does -t2 work?
>=20
> Umm. Probably not. See below.

Heikki said in a later mail that it works for him, and so it does for me
too.

> >  o What happens if your disable "rtdm_event_pulse(&ctx->result_event)=
;"
> >    in eval_outer_loop (thus no signalling of intermediate results dur=
ing
> >    the test)? Does it still crash, maybe later during cleanup now?

> Doesn't freeze and can be exited with ctrl-c and even re-run.

Same for me.

Some additionnal information: I've disabled FPU handling in Xeno and it
doesn't change anything, it still crashes.

As I said before, the old klatency test does work reliably for me, with
the latest Xenomai.

I tried moving the 'display' thread into the kernel, and in this
configuration it does no longer crash.

I've started simplifying the code trying to get to the simplest code
which does have the problem. The results is at
http://www.popies.net/tmp/xenobug/bug.tgz if somebody wants to take a
look.

I'll be working on this again tomorrow...

Stelian.
--=20
Stelian Pop <stelian.pop@domain.hid>
Open Wide


