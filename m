Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Xenomai-help] Priority inversion
Date: Fri, 21 Jul 2006 15:39:58 +0200
Message-ID: <FDBBB5CC70676540B3EF7CFE83FD94E05B456D@EINT11.einet.ad.eivd.ch>
In-Reply-To: <1153487776.5019.32.camel@domain.hid>
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
To: rpm@xenomai.org, Daniel Simon <Daniel.Simon@domain.hid>
Cc: xenomai@xenomai.org


> -----Message d'origine-----
> De=A0: xenomai-help-bounces@domain.hid =
[mailto:xenomai-help-bounces@domain.hid] De
> la part de Philippe Gerum
> Envoy=E9=A0: vendredi, 21. juillet 2006 15:16
> =C0=A0: Daniel Simon
> Cc=A0: xenomai@xenomai.org
> Objet=A0: Re: [Xenomai-help] Priority inversion
>=20
> On Fri, 2006-07-21 at 14:51 +0200, Daniel Simon wrote:
> > On Fri, 21 Jul 2006 14:12:47 +0200
> > "ROSSIER Daniel" <Daniel.Rossier@domain.hid> wrote:
> >
> > > but it might be at the spin() level.
> >
> > I have observed that the behaviour of rt_timer_spin() does not fit =
with
> > the expected behaviour as described in the doxygened comment: its =
actual
> > awakening time do not increase when it is preempted.
> >
> > According to the code in timer.c (using 2.1.2) the wakening time =
seems
> > to be computed once for all at the beginning of the function call.
> >
> > Am I right?
> >
>=20
> Yes. But nothing is said in the documentation about the determination =
of
> the end spinning time, so the doc is right; what it says is that your
> task is going to wait for a certain count of nanoseconds, as seen from
> its own POV, it does not say that only cycles spent in actual spinning
> wait on behalf of the caller should be accounted for. Fact is that the
> task will have waited for a certain amount of time before returning,
> what has occurred in the rest of the system during that period is
> irrelevant to the purpose of rt_task_spin().
>=20
> I guess that your interpretation of the behaviour of your application
> has been wrong due to the non-cumulative aspect of rt_timer_spin(), =
i.e.
> a first spinning interrupted by a second one will exit immediately =
upon
> return if the initial end time has been reached, because of the second
> spin time. But in any case, this is an expected behaviour.

Yes, that's definitively the point; and again, sorry for the mishap with =
the mutex/sema, which actually perfectly works :-)

Back to rt_timer_spin(), in other words, does it mean that there is a =
kind of global counter used by this function that evolves over the =
different tasks when rt_timer_spin() is used, or something like this (no =
notion of virtual task time)?

>=20
> > 	Daniel
> >
> --
> Philippe.
>=20
>=20
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

