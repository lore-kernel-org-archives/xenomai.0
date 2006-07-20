Subject: RE: [Xenomai-help] Strange behaviour w/mutex&semaphore
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <FDBBB5CC70676540B3EF7CFE83FD94E0210E16@domain.hid>
References: <FDBBB5CC70676540B3EF7CFE83FD94E0210E16@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Date: Thu, 20 Jul 2006 14:04:26 +0200
Message-Id: <1153397066.5078.10.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: ROSSIER Daniel <Daniel.Rossier@domain.hid>
Cc: xenomai@xenomai.org, jan.kiszka@domain.hid

On Thu, 2006-07-20 at 13:17 +0200, ROSSIER Daniel wrote:
>=20
> > -----Message d'origine-----
> > De : jan.kiszka@domain.hid [mailto:jan.kiszka@domain.hid]
> > Envoy=E9 : jeudi, 20. juillet 2006 13:03
> > =C0 : ROSSIER Daniel
> > Cc : xenomai@xenomai.org
> > Objet : Re: [Xenomai-help] Strange behaviour w/mutex&semaphore
> >=20
> > ROSSIER Daniel wrote:
> > > Hi all,
> > >
> > > I've a strange behaviour with the attached piece of code.
> > > It's really simple: there are 3 tasks and we're spinning within the=
 task
> > in order
> > > to simulate task load.
> > >
> > > It's a pure academic exercice, so don't try to think about the
> > usefulness of this code ;-)
> > >
> > >
> > > Actually, after insmod'ing the code into the kernel, the system fre=
ezes
> > and
> > > the "meteoDataAcquisition" task is suspended runaway by the interna=
l
> > xenomai watchdog.
> > >
> > > Why?
> > >
> > > Anything wrong in this code?
> >=20
> > Check the values you assign to rt_task_set_periodic. Kind of... fast?
>=20
> No, with at these frequencies, there is no problem (the jiffy is at 1ms=
). Actually, putting TM_NOW in the rt_task_set_periodic() instead of 18 a=
s it is, we noticed that it works.
> Removing the mutex & semaphore stuff, with the delay in set_periodic(),=
 does not change the behaviour.
> We came up with this issue after another one, actually, with a more sop=
histicated code showing a priority inversion. We reduce the code, and the=
n find this issue. I do not know it both issues are related, but I'd like
> to solve this one first.
>=20

-  rt_task_set_periodic(&meteoDataAcquisitionTask, 18, 1000);
+  rt_task_set_periodic(&meteoDataAcquisitionTask, rt_timer_read() + 18,
1000);

The current call should return with -ETIMEDOUT, in which case, the
associated acquisition thread would enter a runaway loop, with
rt_task_wait_period() systematically bailing out upon the same error,
which in turn makes the task sucking all the available CPU. Then came
the relentless watchdog...

> >=20
> > >
> > > Thanks for any advice.
> > >
> > > Daniel
> > >
> > >
> > >
> > > -------------------------------------------------------------------=
-----
> > >
> > > _______________________________________________
> > > Xenomai-help mailing list
> > > Xenomai-help@domain.hid
> > > https://mail.gna.org/listinfo/xenomai-help
> >=20
>=20
>=20
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
--=20
Philippe.



