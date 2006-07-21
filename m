Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Xenomai-help] Priority inversion
Date: Fri, 21 Jul 2006 14:12:47 +0200
Message-ID: <FDBBB5CC70676540B3EF7CFE83FD94E05B4564@domain.hid>
In-Reply-To: <FDBBB5CC70676540B3EF7CFE83FD94E0210E1A@EINT11.einet.ad.eivd.ch>
From: "ROSSIER Daniel" <Daniel.Rossier@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org


My apologies. Please ignore my previous mail.
Indeed, we made a bad analysis. The mutex seems to be released; we still =
have the problem, but it might be at the spin() level.

We're now investigating further.=20
Daniel


> -----Message d'origine-----
> De=A0: xenomai-help-bounces@domain.hid =
[mailto:xenomai-help-bounces@domain.hid] De
> la part de ROSSIER Daniel
> Envoy=E9=A0: vendredi, 21. juillet 2006 13:56
> =C0=A0: rpm@xenomai.org
> Cc=A0: xenomai@xenomai.org
> Objet=A0: RE: [Xenomai-help] Priority inversion
>=20
>=20
>=20
> > -----Message d'origine-----
> > De=A0: Philippe Gerum [mailto:rpm@xenomai.org]
> > Envoy=E9=A0: vendredi, 21. juillet 2006 11:11
> > =C0=A0: ROSSIER Daniel
> > Cc=A0: xenomai@xenomai.org
> > Objet=A0: RE: [Xenomai-help] Priority inversion
> >
> > On Fri, 2006-07-21 at 10:46 +0200, ROSSIER Daniel wrote:
> > >
> > > Hi Philippe,
> > >
> > > > -----Message d'origine-----
> > > > De : Philippe Gerum [mailto:rpm@xenomai.org]
> > > > Envoy=E9 : jeudi, 20. juillet 2006 22:50
> > > > =C0 : ROSSIER Daniel
> > > > Cc : xenomai@xenomai.org
> > > > Objet : Re: [Xenomai-help] Priority inversion
> > > >
> > > > On Thu, 2006-07-20 at 15:14 +0200, ROSSIER Daniel wrote:
> > > > >
> > > > > Hi all,
> > > > >
> > > > > Attached, another tricky piece of code.
> > > > >
> > > > > We actually try to exhibit a priority inversion by using the
> > semaphore
> > > > (which does not implement the priority inheritance protocol).
> > > > >
> > > > > We have the three following tasks:
> > > > >
> > > > > - meteoDataAcquisition: acquiring the mutex, spinning 10ms,
> > releasing
> > > > the mutex / priority 1 / delayed at 18ms, and then activated =
with a
> > > > frequency of 1000 ms from its first activation (so normally, =
more or
> > less
> > > > activated at 1018, 2018, 3018, etc.)
> > > > >
> > > > > - busManagement: acquiring the mutex, spinning 5 ms, releasing =
the
> > mutex
> > > > / priority 10 / period of 20 ms.
> > > > > - comHandling: just spinning 10ms, period of 20 ms.
> > > > >
> > > > > So, the worst case would be when the meteoDataAcquisition =
acquired
> > the
> > > > mutex right before the busManagement, so we can say that the =
highest
> > > > priority task will be delayed of 10ms at the worst; we put an =
alarm
> of
> > > > 30ms, then no alarm will raise up; and indeed, it works like =
that.
> > > > >
> > > > > Doing the same stuff with the semaphore - just change =
WITH_MUTEX
> to
> > 0 -
> > > > should theoretically lead to an alarm since the comHandling will
> take
> > the
> > > > hand, delaying the busManagement over 30ms. Here comes the =
problem:
> if
> > we
> > > > leave the alarm at 30ms, the alarm raises up, as expected. But, =
if
> we
> > > > change the alarm to 31ms, there is no alarm anymore... and we do =
not
> > > > understand why? Normally we should see some alarms for some =
values
> > from 31
> > > > to 35ms, since comHandling spins during 10ms. Mytery...
> > > > >
> > > > > Normally, the task meteoDataAcquisition is aperiodic, and
> activated
> > on
> > > > the basis of an IRQ. In order to simulate that, we put the task =
with
> a
> > > > delay of 18ms (yes, that's the reason of 18 ;-)), activated each
> > second
> > > > (therefore causing the priority inversion systematically). But
> nothing
> > > > happens! the system runs, but no alarm raises up with
> > > >
> > > > With some help from the simulator,
> > > > http://download.gna.org/xenomai/screenshots/simulator.png
> > > > here is the timeline of your example:
> > > >
> > > > [sys_date*]	[task]	[alarm_setup*]
> > > > 0		com
> > > > 10		bus	15
> > >
> > > Given that the bus prio is 10, and com prio is 5, why the bus =
doesn't
> > interrupt the com task right after its start in the init_module. I =
can
> > imagine that the com task has a bit time to execute some =
instructions,
> but
> > never spending more than 1-2ms before the bus starts. Is there a =
problem
> > in the pod initialization?
> > >
> >
> > Precisely because the task underlying the init_module() routine has =
a
> > lower priority than the com task, so there is no way for the bus =
task to
> > be started by the init context before the com task relinquishes the =
CPU
> > by calling rt_task_wait_period(). The scheduling is then:
> >
> > init	(pri -1)
> > 	start com
> > com	(pri 5)
> > 	spin
> > 	wait_period
> > init	(pri -1)
> > 	start bus
> > bus	(pri 10)
> >
> > > > 18		mto
> > > > 20		bus	35
> > > > loop:
> > > > 20		com
> > > > 40		bus	45
> > >
> > > This behaviour is not correct. The task mto holds the mutex when
> > prempted by the bus; the bus is using the same mutex and should not =
be
> > able to run anymore, giving the hand to the mto task in case of =
mutex,
> or
> > giving the hand to the the com, using the sema.
> > >
> >
> > Nope, the mto task has reached rt_task_wait_period() when the bus =
task
> > resumes, so the sema4 is free. You should really try running your
> > example over the event-driven simulator, it would be much easier for =
you
> > to grasp the actual dynamics of this quite tricky code. Even if you
> > don't trust the simulator a priori, you could just analyze what it =
says
> > the behaviour of your application is, and make your opinion. I've
> > tracked it a few times already, and so far, everything is ok.
>=20
> Ok; I've no problem with an event-driven simulation. We actually did =
it
> using Cheddar scheduling simulation tool (see attachement), and the
> behaviour does not correspond with what happens in Xenomai.
> A closer look to the meteo task shows that it spins during 10ms. So, I =
do
> not see how it can reach the rt_task_wait_period() after 2 ms as shown =
in
> your simulation result.
>=20
> Nevertheless, we are now setting up Xenoscope in order to have a clean
> simulation environment as you advice.
>=20
> >
> > > Well actually, we found this morning something very strange. It =
seems
> > that the mutex/sema can be acquired twice, before releasing it! We
> simply
> > added a printk() at the beginning of the critical section (with
> > timestamp), and noticed that two P(), or two mutex_lock() were =
performed
> > before the release.
> > >
> >
> > Nothing strange here: native API mutexes are recursive by =
construction.
> > Other threads but the current owner would block trying to acquire =
it.
>=20
> Exactly. In our case, there are two different tasks (bus and mto) =
which
> can acquire the mutex (no recursion). The traces showed us that the =
lock
> was acquired by the two different tasks without any release in =
between.
>=20
> > As for the timestamps, how do you obtain them?
>=20
> Simply using rt_timer_read() to make sure that printk() doesn't =
interleave
> the traces.
>=20
> >
> > > We think that there is an issue with the use of TM_INFINITE as
> argument
> > in the locking functions. We didn't test any other args.
> > > > 45		com
> > > > 60		bus	65
> > > > 65		com
> > > > 80		bus	85
> > > > 85		com
> > > > 100		bus	105
> > > > 105		com
> > > > 118		mto
> > > > 120		bus	135
> > > > jump loop
> > > >
> > > > (*) system and alarm setup dates are expressed in relative ticks
> since
> > > > the application startup.
> > > >
> > > > Given that there is never more than 30 ticks between two alarm
> setups
> > in
> > > > this timeline (i.e. between ticks #105 and #135), the result you =
got
> > > > looks correct.
> > > >
> > > > --
> > > > Philippe.
> > > >
> > >
> > >
> > >
> > > Daniel
> > >
> > --
> > Philippe.
> >
>=20
> Daniel


