From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Message-ID: <17599.28125.410049.220275@domain.hid>
Date: Thu, 20 Jul 2006 13:49:49 +0200
Subject: RE: [Xenomai-help] Strange behaviour w/mutex&semaphore
In-Reply-To: <FDBBB5CC70676540B3EF7CFE83FD94E0210E16@domain.hid>
References: <44BF62FE.6080404@domain.hid>
	<FDBBB5CC70676540B3EF7CFE83FD94E0210E16@domain.hid>
Content-Transfer-Encoding: Quoted-Printable
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

ROSSIER Daniel wrote:
 >=20
 >=20
 > > -----Message d'origine-----
 > > De=A0: jan.kiszka@domain.hid [mailto:jan.kiszka@domain.hid]
 > > Envoy=E9=A0: jeudi, 20. juillet 2006 13:03
 > > =C0=A0: ROSSIER Daniel
 > > Cc=A0: xenomai@xenomai.org
 > > Objet=A0: Re: [Xenomai-help] Strange behaviour w/mutex&semaphore
 > >=20
 > > ROSSIER Daniel wrote:
 > > > Hi all,
 > > >
 > > > I've a strange behaviour with the attached piece of code.
 > > > It's really simple: there are 3 tasks and we're spinning within th=
e task
 > > in order
 > > > to simulate task load.
 > > >
 > > > It's a pure academic exercice, so don't try to think about the
 > > usefulness of this code ;-)
 > > >
 > > >
 > > > Actually, after insmod'ing the code into the kernel, the system fr=
eezes
 > > and
 > > > the "meteoDataAcquisition" task is suspended runaway by the intern=
al
 > > xenomai watchdog.
 > > >
 > > > Why?
 > > >
 > > > Anything wrong in this code?
 > >=20
 > > Check the values you assign to rt_task_set_periodic. Kind of... fast=
?
 >=20
 > No, with at these frequencies, there is no problem (the jiffy is at
 > 1ms).

There are two tasks with a period of 20 ms that are spinning 10 ms
each. Does not this put a 100% load on the RT system ? If yes, then
Linux has no time left to run. That is what the watchdog is here to
avoid. You should try reducing the spinning time in order to let some
time for Linux to run.

--=20


					    Gilles Chanteperdrix.

