Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C6ACBC.9550BAD2"
Subject: RE: [Xenomai-help] Priority inversion
Date: Fri, 21 Jul 2006 13:55:38 +0200
Message-ID: <FDBBB5CC70676540B3EF7CFE83FD94E0210E1A@EINT11.einet.ad.eivd.ch>
In-Reply-To: <1153473055.5023.65.camel@domain.hid>
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

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6ACBC.9550BAD2
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable



> -----Message d'origine-----
> De=A0: Philippe Gerum [mailto:rpm@xenomai.org]
> Envoy=E9=A0: vendredi, 21. juillet 2006 11:11
> =C0=A0: ROSSIER Daniel
> Cc=A0: xenomai@xenomai.org
> Objet=A0: RE: [Xenomai-help] Priority inversion
>=20
> On Fri, 2006-07-21 at 10:46 +0200, ROSSIER Daniel wrote:
> >
> > Hi Philippe,
> >
> > > -----Message d'origine-----
> > > De : Philippe Gerum [mailto:rpm@xenomai.org]
> > > Envoy=E9 : jeudi, 20. juillet 2006 22:50
> > > =C0 : ROSSIER Daniel
> > > Cc : xenomai@xenomai.org
> > > Objet : Re: [Xenomai-help] Priority inversion
> > >
> > > On Thu, 2006-07-20 at 15:14 +0200, ROSSIER Daniel wrote:
> > > >
> > > > Hi all,
> > > >
> > > > Attached, another tricky piece of code.
> > > >
> > > > We actually try to exhibit a priority inversion by using the
> semaphore
> > > (which does not implement the priority inheritance protocol).
> > > >
> > > > We have the three following tasks:
> > > >
> > > > - meteoDataAcquisition: acquiring the mutex, spinning 10ms,
> releasing
> > > the mutex / priority 1 / delayed at 18ms, and then activated with =
a
> > > frequency of 1000 ms from its first activation (so normally, more =
or
> less
> > > activated at 1018, 2018, 3018, etc.)
> > > >
> > > > - busManagement: acquiring the mutex, spinning 5 ms, releasing =
the
> mutex
> > > / priority 10 / period of 20 ms.
> > > > - comHandling: just spinning 10ms, period of 20 ms.
> > > >
> > > > So, the worst case would be when the meteoDataAcquisition =
acquired
> the
> > > mutex right before the busManagement, so we can say that the =
highest
> > > priority task will be delayed of 10ms at the worst; we put an =
alarm of
> > > 30ms, then no alarm will raise up; and indeed, it works like that.
> > > >
> > > > Doing the same stuff with the semaphore - just change WITH_MUTEX =
to
> 0 -
> > > should theoretically lead to an alarm since the comHandling will =
take
> the
> > > hand, delaying the busManagement over 30ms. Here comes the =
problem: if
> we
> > > leave the alarm at 30ms, the alarm raises up, as expected. But, if =
we
> > > change the alarm to 31ms, there is no alarm anymore... and we do =
not
> > > understand why? Normally we should see some alarms for some values
> from 31
> > > to 35ms, since comHandling spins during 10ms. Mytery...
> > > >
> > > > Normally, the task meteoDataAcquisition is aperiodic, and =
activated
> on
> > > the basis of an IRQ. In order to simulate that, we put the task =
with a
> > > delay of 18ms (yes, that's the reason of 18 ;-)), activated each
> second
> > > (therefore causing the priority inversion systematically). But =
nothing
> > > happens! the system runs, but no alarm raises up with
> > >
> > > With some help from the simulator,
> > > http://download.gna.org/xenomai/screenshots/simulator.png
> > > here is the timeline of your example:
> > >
> > > [sys_date*]	[task]	[alarm_setup*]
> > > 0		com
> > > 10		bus	15
> >
> > Given that the bus prio is 10, and com prio is 5, why the bus =
doesn't
> interrupt the com task right after its start in the init_module. I can
> imagine that the com task has a bit time to execute some instructions, =
but
> never spending more than 1-2ms before the bus starts. Is there a =
problem
> in the pod initialization?
> >
>=20
> Precisely because the task underlying the init_module() routine has a
> lower priority than the com task, so there is no way for the bus task =
to
> be started by the init context before the com task relinquishes the =
CPU
> by calling rt_task_wait_period(). The scheduling is then:
>=20
> init	(pri -1)
> 	start com
> com	(pri 5)
> 	spin
> 	wait_period
> init	(pri -1)
> 	start bus
> bus	(pri 10)
>=20
> > > 18		mto
> > > 20		bus	35
> > > loop:
> > > 20		com
> > > 40		bus	45
> >
> > This behaviour is not correct. The task mto holds the mutex when
> prempted by the bus; the bus is using the same mutex and should not be
> able to run anymore, giving the hand to the mto task in case of mutex, =
or
> giving the hand to the the com, using the sema.
> >
>=20
> Nope, the mto task has reached rt_task_wait_period() when the bus task
> resumes, so the sema4 is free. You should really try running your
> example over the event-driven simulator, it would be much easier for =
you
> to grasp the actual dynamics of this quite tricky code. Even if you
> don't trust the simulator a priori, you could just analyze what it =
says
> the behaviour of your application is, and make your opinion. I've
> tracked it a few times already, and so far, everything is ok.

Ok; I've no problem with an event-driven simulation. We actually did it =
using Cheddar scheduling simulation tool (see attachement), and the =
behaviour does not correspond with what happens in Xenomai.=20
A closer look to the meteo task shows that it spins during 10ms. So, I =
do not see how it can reach the rt_task_wait_period() after 2 ms as =
shown in your simulation result.

Nevertheless, we are now setting up Xenoscope in order to have a clean =
simulation environment as you advice.

>=20
> > Well actually, we found this morning something very strange. It =
seems
> that the mutex/sema can be acquired twice, before releasing it! We =
simply
> added a printk() at the beginning of the critical section (with
> timestamp), and noticed that two P(), or two mutex_lock() were =
performed
> before the release.
> >
>=20
> Nothing strange here: native API mutexes are recursive by =
construction.
> Other threads but the current owner would block trying to acquire it.

Exactly. In our case, there are two different tasks (bus and mto) which =
can acquire the mutex (no recursion). The traces showed us that the lock =
was acquired by the two different tasks without any release in between.

> As for the timestamps, how do you obtain them?

Simply using rt_timer_read() to make sure that printk() doesn't =
interleave the traces.

>=20
> > We think that there is an issue with the use of TM_INFINITE as =
argument
> in the locking functions. We didn't test any other args.
> > > 45		com
> > > 60		bus	65
> > > 65		com
> > > 80		bus	85
> > > 85		com
> > > 100		bus	105
> > > 105		com
> > > 118		mto
> > > 120		bus	135
> > > jump loop
> > >
> > > (*) system and alarm setup dates are expressed in relative ticks =
since
> > > the application startup.
> > >
> > > Given that there is never more than 30 ticks between two alarm =
setups
> in
> > > this timeline (i.e. between ticks #105 and #135), the result you =
got
> > > looks correct.
> > >
> > > --
> > > Philippe.
> > >
> >
> >
> >
> > Daniel
> >
> --
> Philippe.
>=20

Daniel


------_=_NextPart_001_01C6ACBC.9550BAD2
Content-Type: image/png;
	name="mutex.png"
Content-Transfer-Encoding: base64
Content-Description: mutex.png
Content-Disposition: attachment;
	filename="mutex.png"

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
pByOofgAAAAASUVORK5CYII=

------_=_NextPart_001_01C6ACBC.9550BAD2
Content-Type: image/png;
	name="sema.png"
Content-Transfer-Encoding: base64
Content-Description: sema.png
Content-Disposition: attachment;
	filename="sema.png"

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

------_=_NextPart_001_01C6ACBC.9550BAD2--

