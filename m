Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Jul 2008 09:40:52 +0200
Message-ID: <5D63919D95F87E4D9D34FF7748CE2C2A0137F8FD@ARVMAIL1.mra.roland-man.biz>
From: <roderik.wildenburg@domain.hid>
Subject: Re: [Xenomai-help] Thread policy and priority in secondary mode
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

> >> __real_pthread_setschedparam(). Note: this will propagate the=20
> >> priority to the underlying Xenomai thread as well.
> >>
> >=20
> > Does this mean that the Xenomai thread will run with the new (Linux)
> > priority when it returns to primary mode ?
>=20
> Yes. However, the propagation only occurs when the skin and Linux have
> compatible priority scales, which is the case with the POSIX skin.
>=20
> > And the other way round :
> > when a posix thread switches to secondary mode (without using
> > __real_pthread_setschedparam), does it run in Linux with=20
> the priority
> > set in Xenomai (with pthread_setschedparam)?
>=20
> Yes.
>=20
> > Or better : what is the Linux-prority when a Xenomai thread=20
> (posix or or
> > any other Xenomai thread)switches to secondaary mode ?
> >
>=20
> It depends on the skin. When the priority scales are=20
> compatible (i.e. a given
> priority level exists in both and scales are both upwarding,=20
> like POSIX skin <->
> Linux, and native skin <-> Linux), you get the same priority=20
> level in both
> modes, and changing the priority from one mode affects the=20
> other mode as well.
>=20
> When they are not compatible, the skin-based priority is=20
> "normalized" and
> applied to the Linux side when needed (e.g. when VxWorks=20
> taskPrioritySet() is
> invoked), but __real_pthread_setschedparam does not trigger=20
> the converse
> propagation (since 2.4.4 actually, because experience showed=20
> that propagating in
> that case made little sense, and would beget weird=20
> behaviours). The way priority
> levels are normalized depends on the skin.
>=20

Do you know how a Linux priority, set with pthread_setschedparam
(real_pthread_setschedparam),
correlates with the priorities shown by "ps l". In our case we realized
that ps does not show the priority set with pthread_setschedparam. Is
there a command which shows the "real" priority ?

Best regrads
Roderik

Achtung: Neue E-Mail-Adresse! Attention: New e-mail-address! =
roderik.wildenburg@domain.hid
--------------------------------------------------------
manroland AG
Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus =
Rall, Paul Steidle  =20
Sitz der Gesellschaft: Offenbach am Main, Registergericht: Amtsgericht =
Offenbach HRB-Nr. 42592
USt-Ident-Nr. DE 250200933

