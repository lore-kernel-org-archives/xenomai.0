Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Xenomai-help] Strange behaviour w/mutex&semaphore
Date: Thu, 20 Jul 2006 13:17:32 +0200
Message-ID: <FDBBB5CC70676540B3EF7CFE83FD94E0210E16@domain.hid>
In-Reply-To: <44BF62FE.6080404@domain.hid>
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
To: jan.kiszka@domain.hid
Cc: xenomai@xenomai.org



> -----Message d'origine-----
> De=A0: jan.kiszka@domain.hid [mailto:jan.kiszka@domain.hid]
> Envoy=E9=A0: jeudi, 20. juillet 2006 13:03
> =C0=A0: ROSSIER Daniel
> Cc=A0: xenomai@xenomai.org
> Objet=A0: Re: [Xenomai-help] Strange behaviour w/mutex&semaphore
>=20
> ROSSIER Daniel wrote:
> > Hi all,
> >
> > I've a strange behaviour with the attached piece of code.
> > It's really simple: there are 3 tasks and we're spinning within the =
task
> in order
> > to simulate task load.
> >
> > It's a pure academic exercice, so don't try to think about the
> usefulness of this code ;-)
> >
> >
> > Actually, after insmod'ing the code into the kernel, the system =
freezes
> and
> > the "meteoDataAcquisition" task is suspended runaway by the internal
> xenomai watchdog.
> >
> > Why?
> >
> > Anything wrong in this code?
>=20
> Check the values you assign to rt_task_set_periodic. Kind of... fast?

No, with at these frequencies, there is no problem (the jiffy is at =
1ms). Actually, putting TM_NOW in the rt_task_set_periodic() instead of =
18 as it is, we noticed that it works.
Removing the mutex & semaphore stuff, with the delay in set_periodic(), =
does not change the behaviour.
We came up with this issue after another one, actually, with a more =
sophisticated code showing a priority inversion. We reduce the code, and =
then find this issue. I do not know it both issues are related, but I'd =
like
to solve this one first.

>=20
> >
> > Thanks for any advice.
> >
> > Daniel
> >
> >
> >
> > =
------------------------------------------------------------------------
> >
> > _______________________________________________
> > Xenomai-help mailing list
> > Xenomai-help@domain.hid
> > https://mail.gna.org/listinfo/xenomai-help
>=20



