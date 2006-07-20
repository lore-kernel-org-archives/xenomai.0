Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Xenomai-help] Strange behaviour w/mutex&semaphore
Date: Thu, 20 Jul 2006 13:59:33 +0200
Message-ID: <FDBBB5CC70676540B3EF7CFE83FD94E05B4515@domain.hid>
In-Reply-To: <17599.28125.410049.220275@domain.hid>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org



> -----Message d'origine-----
> De=A0: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
> Envoy=E9=A0: jeudi, 20. juillet 2006 13:50
> =C0=A0: ROSSIER Daniel
> Cc=A0: jan.kiszka@domain.hid; xenomai@xenomai.org
> Objet=A0: RE: [Xenomai-help] Strange behaviour w/mutex&semaphore
>=20
> ROSSIER Daniel wrote:
>  >
>  >
>  > > -----Message d'origine-----
>  > > De=A0: jan.kiszka@domain.hid [mailto:jan.kiszka@domain.hid]
>  > > Envoy=E9=A0: jeudi, 20. juillet 2006 13:03
>  > > =C0=A0: ROSSIER Daniel
>  > > Cc=A0: xenomai@xenomai.org
>  > > Objet=A0: Re: [Xenomai-help] Strange behaviour w/mutex&semaphore
>  > >
>  > > ROSSIER Daniel wrote:
>  > > > Hi all,
>  > > >
>  > > > I've a strange behaviour with the attached piece of code.
>  > > > It's really simple: there are 3 tasks and we're spinning within =
the
> task
>  > > in order
>  > > > to simulate task load.
>  > > >
>  > > > It's a pure academic exercice, so don't try to think about the
>  > > usefulness of this code ;-)
>  > > >
>  > > >
>  > > > Actually, after insmod'ing the code into the kernel, the system
> freezes
>  > > and
>  > > > the "meteoDataAcquisition" task is suspended runaway by the
> internal
>  > > xenomai watchdog.
>  > > >
>  > > > Why?
>  > > >
>  > > > Anything wrong in this code?
>  > >
>  > > Check the values you assign to rt_task_set_periodic. Kind of... =
fast?
>  >
>  > No, with at these frequencies, there is no problem (the jiffy is at
>  > 1ms).
>=20
> There are two tasks with a period of 20 ms that are spinning 10 ms
> each. Does not this put a 100% load on the RT system ? If yes, then
> Linux has no time left to run. That is what the watchdog is here to
> avoid. You should try reducing the spinning time in order to let some
> time for Linux to run.

No, there are:=20
- a task "MeteoDataAcquisition", with a spin of 10ms, and a period of 1s =
(1000ms).
- a task "BusManagement", with a spin of 5ms, and a period of 20ms
- a task "ComHandling", with a spin of 10ms, and a period of 20ms.

So actually, the CPU load is 10/1000 + 5/20 + 10/20 =3D 0.76; and this =
gives Linux chance to run. (But again Gilles, it works with the =
following statement:  rt_task_set_periodic(&meteoDataAcquisitionTask, =
TM_NOW, 1000);

I don't understand why it doesn't work with a delay of 18ms on the first =
release point of this task.

> --
>=20
>=20

Daniel

