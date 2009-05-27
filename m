Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2009 11:23:49 +0200
Message-ID: <4B2EEE69E41E524EB7FCDC62A15D68D80348DF91@domain.hid>
In-Reply-To: <1242222147.26544.964.camel@domain.hid>
References: <ff1d78710905130504h2588d8c5te0b918dce3a8f0da@domain.hid><1242219577.26544.952.camel@domain.hid>
	<4A0AC81A.7050000@domain.hid><1242221456.26544.960.camel@domain.hid>
	<4A0ACC6A.3010205@domain.hid> <1242222147.26544.964.camel@domain.hid>
From: <thomas.debes@domain.hid>
Subject: Re: [Xenomai-core] [Xenomai-help] Periodic threads not scheduled
	anymore during debug session
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

> -----Urspr=FCngliche Nachricht-----
> Von: xenomai-core-bounces@domain.hid =
[mailto:xenomai-core-bounces@domain.hid]
> Im Auftrag von Philippe Gerum
> Gesendet: Mittwoch, 13. Mai 2009 15:42
> An: Gilles Chanteperdrix
> Cc: Steven Kauffmann; xenomai@xenomai.org
> Betreff: Re: [Xenomai-core] [Xenomai-help] Periodic threads not
> scheduled anymore during debug session
>=20
> On Wed, 2009-05-13 at 15:34 +0200, Gilles Chanteperdrix wrote:
> > Philippe Gerum wrote:
> > > On Wed, 2009-05-13 at 15:16 +0200, Gilles Chanteperdrix wrote:
> > >> Philippe Gerum wrote:
> > >>> On Wed, 2009-05-13 at 14:04 +0200, Steven Kauffmann wrote:
> > >>>> Hi all,
> > >>>>
> > >>>> If I connect a debugger to my application, other Xenomai
> periodic
> > >>>> threads (threads that not belong to the current process I'm
> debugging
> > >>>> ) are not scheduled anymore. Attached you can find a simple
> example
> > >>>> that reproduces the problem. I run the program 2 times in a
> different
> > >>>> terminal and connected a debugger to one of them. When a
> breakpoint is
> > >>>> reached both programs stops their execution but I would expect
> that
> > >>>> only the program that I'm debugging should stop and not both.
> > >>>>
> > >>>> $ cat /proc/xenomai/sched
> > >>>>
> > >>>> CPU  PID    PRI      PERIOD     TIMEOUT    TIMEBASE  STAT
> NAME
> > >>>>   0  0       -1      0          0          master    R
> ROOT
> > >>>>   0  5469     0      1000000001 331274938  master    D
> > >>>>   0  5471     0      1000000001 0          master    XT
> > >>>>
> > >>>> This looks normal one thread is stopped ( thread that reaches
> the
> > >>>> breakpoint ) and the other one is delayed because it's a
> periodic
> > >>>> thread. Every time I call this command the timeout of the
> delayed
> > >>>> thread changes so it looks like this thread is still running =
but
> in
> > >>>> reality it is not.
> > >>> This behavior is wanted (I mean, the implementation does freeze
> all
> > >>> thread timers when a break state is reached on purpose), so that
> you
> > >>> don't get tons of overruns once the debuggee is restarted.
> > >>>
> > >>> However, I'm now wondering if we should not be a bit smarter =
than
> this,
> > >>> and narrow the scope of such action. We do have the mechanisms =
to
> do so,
> > >>> it is just a matter of using them.
> > >> Do we? I mean, are we able to know which process a timer belongs
> to?
> > >>
> > >
> > > We could tag the per-thread timers (rtimer, ptimer) using their
> status
> > > field, and move back to the owner thread using container_of() when
> > > applicable.
> >
> > What if an application uses rt_alarm_create/rt_alarm_wait?
>=20
> Those do not create per-thread timers. We just want to follow a bit
> more
> the principle of least surprise, and prevent common programming
> patterns
> to be affected by this feature.
>=20
> For the rest, we would have to reverse the current logic and tag
> blockable timers instead of non-blockable one. The shadow code would
> then have to tag the ptimer/rtimer of the ptraced thread as blockable,
> leaving all other timers as unblockable by default.
>=20
> >

Do you know when this will be implemented?=20

We have a kernel watchdog service running (Xenomai task) which always =
restarts our system while debugging (because the watchdog is not =
triggered anymore). I assume that this problem is related to the one =
above.

Thanks
Thomas

--------------------------------------------------------
manroland AG
Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus =
Rall, Paul Steidle  =20
Sitz der Gesellschaft: Offenbach am Main, Registergericht: Amtsgericht =
Offenbach HRB-Nr. 42592
USt-Ident-Nr. DE 250200933

