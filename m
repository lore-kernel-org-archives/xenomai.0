Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Feb 2009 09:44:10 +0100
Message-ID: <5D63919D95F87E4D9D34FF7748CE2C2A0183D12A@ARVMAIL1.mra.roland-man.biz>
In-Reply-To: <499D789D.3040109@domain.hid>
From: <roderik.wildenburg@domain.hid>
Subject: Re: [Xenomai-help] Floating Point Exceptions in RT-Tasks
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
Cc: xenomai@xenomai.org, wg@domain.hid

On behalf of Thomas I would like to answer your question :

We too use Eldk 3.1.1 with a libc-2.3.1.so (from the Eldk 3.1.1 rootfs) =
and an adeos-ipipe-2.4.25-ppc-DENX-1.2-02.patch.

We do not use Eldk=B4s rootfs completely, as our system is busybox =
based, but many parts form it (for example the libraries and bash). Do =
you know anything else, we have to activate/keep care of to get =
FPU-exceptions ? From my point of view everything should be configured =
all right, as we get exceptions when the thread switches to secondary =
mode!??

Dr. Grandegger : could you be so kind to try Thomas=B4 testprogram on =
our plattfrom with Eldk 3.1.1?

Many thanks in advance for your help
Roderik

> -----Urspr=FCngliche Nachricht-----
> Von: xenomai-help-bounces@domain.hid
> [mailto:xenomai-help-bounces@domain.hid] Im Auftrag von Philippe Gerum
> Gesendet: Donnerstag, 19. Februar 2009 16:20
> An: Debes, Thomas RAEK3 MRA
> Cc: xenomai@xenomai.org
> Betreff: Re: [Xenomai-help] Floating Point Exceptions in RT-Tasks
>=20
> Philippe Gerum wrote:
> > thomas.debes@domain.hid wrote:
> >> Thanks for testing it - that is exactly what I would like=20
> to see. Obviously it's a kernel/I-Pipe related thing which=20
> prevents me from getting the exception. Unfortunately=20
> updating to kernel 2.6 is not an option for now.
> >>
> >=20
> > I'm afraid this is not I-pipe related, this would have been=20
> too easy. The test
> > snippet works fine here as well on a lite5200 +=20
> ipipe-2.4.25-1.2-02, ELDK-4.1
> > environment.
> >=20
> > Now we should suspect something going on with your target=20
> environment; which
> > libc are you based on?
> >
>=20
> Works fine with ELDK-3.1.1 rootfs as well.
>=20
> >=20
> >> Thomas
> >>
> >> -----Urspr=FCngliche Nachricht-----
> >> Von: Wolfgang Grandegger [mailto:wg@domain.hid
> >> Gesendet: Mittwoch, 18. Februar 2009 19:59
> >> An: Debes, Thomas RAEK3 MRA
> >> Cc: xenomai@xenomai.org; Gilles Chanteperdrix
> >> Betreff: Re: [Xenomai-help] Floating Point Exceptions in RT-Tasks
> >>
> >> Wolfgang Grandegger wrote:
> >>> thomas.debes@domain.hid wrote:
> >>>> Unfortunately I don't have a newer kernel, I will talk=20
> to Wolfgang Grandegger, maybe he can do a short test with my=20
> formerly attached sample application.
> >>> I will try it out on my TQM5200 board later today or tomorrow.
> >> With I-Pipe v2.4-03, Xenomai v2.5-devel (SVN revision=20
> 4519) and Linux
> >> 2.6.26 on my TQM85200 I get:
> >>
> >>   -bash-3.2# ./fpu-exception-test
> >>   Floating point exception
> >>
> >>   -bash-3.2# dmesg|tail
> >>   ...
> >>   Xenomai: Switching trivial to secondary mode after
> >>   exception #1792 from user-space at 0x10001840 (pid 1127)
> >>
> >> Is that the expected behavior?
> >>
> >> Wolfgang.
> >>
> >> --------------------------------------------------------
> >> manroland AG
> >> Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
> >> Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch,=20
> Dr. Markus Rall, Paul Steidle  =20
> >> Sitz der Gesellschaft: Offenbach am Main, Registergericht:=20
> Amtsgericht Offenbach HRB-Nr. 42592
> >> USt-Ident-Nr. DE 250200933
> >>
> >> _______________________________________________
> >> Xenomai-help mailing list
> >> Xenomai-help@domain.hid
> >> https://mail.gna.org/listinfo/xenomai-help
> >>
> >=20
> >=20
>=20
>=20
> --=20
> Philippe.
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>

--------------------------------------------------------
manroland AG
Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus =
Rall, Paul Steidle  =20
Sitz der Gesellschaft: Offenbach am Main, Registergericht: Amtsgericht =
Offenbach HRB-Nr. 42592
USt-Ident-Nr. DE 250200933

