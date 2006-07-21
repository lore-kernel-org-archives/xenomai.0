Subject: RE: [Xenomai-help] Priority inversion
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <FDBBB5CC70676540B3EF7CFE83FD94E05B456D@EINT11.einet.ad.eivd.ch>
References: <FDBBB5CC70676540B3EF7CFE83FD94E05B456D@EINT11.einet.ad.eivd.ch>
Content-Type: text/plain; charset=ISO-8859-1
Date: Fri, 21 Jul 2006 18:16:06 +0200
Message-Id: <1153498566.5019.66.camel@domain.hid>
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
Cc: xenomai@xenomai.org

On Fri, 2006-07-21 at 15:39 +0200, ROSSIER Daniel wrote:
> > -----Message d'origine-----
> > De : xenomai-help-bounces@domain.hid [mailto:xenomai-help-bounces@domain.hid=
g] De
> > la part de Philippe Gerum
> > Envoy=E9 : vendredi, 21. juillet 2006 15:16
> > =C0 : Daniel Simon
> > Cc : xenomai@xenomai.org
> > Objet : Re: [Xenomai-help] Priority inversion
> >=20
> > On Fri, 2006-07-21 at 14:51 +0200, Daniel Simon wrote:
> > > On Fri, 21 Jul 2006 14:12:47 +0200
> > > "ROSSIER Daniel" <Daniel.Rossier@domain.hid> wrote:
> > >
> > > > but it might be at the spin() level.
> > >
> > > I have observed that the behaviour of rt_timer_spin() does not fit =
with
> > > the expected behaviour as described in the doxygened comment: its a=
ctual
> > > awakening time do not increase when it is preempted.
> > >
> > > According to the code in timer.c (using 2.1.2) the wakening time se=
ems
> > > to be computed once for all at the beginning of the function call.
> > >
> > > Am I right?
> > >
> >=20
> > Yes. But nothing is said in the documentation about the determination=
 of
> > the end spinning time, so the doc is right; what it says is that your
> > task is going to wait for a certain count of nanoseconds, as seen fro=
m
> > its own POV, it does not say that only cycles spent in actual spinnin=
g
> > wait on behalf of the caller should be accounted for. Fact is that th=
e
> > task will have waited for a certain amount of time before returning,
> > what has occurred in the rest of the system during that period is
> > irrelevant to the purpose of rt_task_spin().
> >=20
> > I guess that your interpretation of the behaviour of your application
> > has been wrong due to the non-cumulative aspect of rt_timer_spin(), i=
.e.
> > a first spinning interrupted by a second one will exit immediately up=
on
> > return if the initial end time has been reached, because of the secon=
d
> > spin time. But in any case, this is an expected behaviour.
>=20
> Yes, that's definitively the point; and again, sorry for the mishap wit=
h the mutex/sema, which actually perfectly works :-)
>=20
> Back to rt_timer_spin(), in other words, does it mean that there is a k=
ind of global counter used by this function that evolves over the differe=
nt tasks when rt_timer_spin() is used, or something like this (no notion =
of virtual task time)?
>=20

rt_task_spin() relies on the free running counter provided by the hw
platform, e.g. the TSC on x86. Therefore, on x86 this value is local to
the current CPU, but global to any thread executed by this CPU.
rt_task_spin() is basically aimed at providing fine grained and short
delays for synchronizing with hardware ops without involving any
rescheduling.

Xenomai only use real time references, never virtual ones. However,
runtime accounting data are available since v2.2, giving the percentage
of CPU used by any given task (see /proc/xenomai/stat), which is the
only virtual time information available so far, but never used to
specify timings though.

> >=20
> > > 	Daniel
> > >
> > --
> > Philippe.
> >=20
> >=20
> >=20
> > _______________________________________________
> > Xenomai-help mailing list
> > Xenomai-help@domain.hid
> > https://mail.gna.org/listinfo/xenomai-help
--=20
Philippe.



