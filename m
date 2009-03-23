Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Mar 2009 15:25:32 +0100
Message-ID: <5D63919D95F87E4D9D34FF7748CE2C2A018D3CFB@ARVMAIL1.mra.roland-man.biz>
In-Reply-To: <49B16B2F.8090305@domain.hid>
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
To: rpm@xenomai.org, wg@domain.hid
Cc: xenomai@xenomai.org

Hello Philippe,

could you find out something new with this issue ?

Roderik

> Wolfgang Grandegger wrote:
> > Philippe Gerum wrote:
> >> roderik.wildenburg@domain.hid wrote:
> >>> On behalf of Thomas I would like to answer :=20
> >>>
> >>>> Do you have CONFIG_XENO_OPT_DEBUG_NUCLEUS enabled in your=20
> >>> yes, we can aahhh have this option enabled.
> >>>
> >>>> kconfig, and if so, do
> >>>> you get any message in your kernel log when running fetest?
> >>> no, no message anywhere (/var/log/messages, console, dmesg).
> >>> fetest runs and runs till I sent CTRL-C.
> >=20
> > I just tried the program fetest on my TQM5200 with a fresh=20
> Xenomai 2.4.x
> > and the linuxppc_2_4_devel tree and the excepetion does *not* get
> > triggered. Actually I realize the following wired behavior:
> >
>=20
> I can reproduce this as well on the tqm now. This seems to be=20
> a nucleus issue=20
> wrt FPU management. More later.
>=20
> > /fpu_test
> > ^C
> > ./fpu_test
> > ^C
> > Feb  3 17:16:12 tqm5200 kernel: Xenomai: Switching trivial=20
> to secondary
> > mode after exception #1792 from user-space at 0x10001974 (pid 342)
> > Floating point exception
> > bash-2.05b# ./fpu_test
> > ^C
> > bash-2.05b# ./fpu_test
> >  ^C
> > bash-2.05b# ./fpu_test
> >=20
> > After aborting the fpu_test program with ^C, I get the=20
> message above,
> > but only after the second try.
> >=20
> >> Gilles sent you a patch affecting=20
> include/asm-powerpc/bits/pod.h a few weeks
> >> ago, that fixed an FPU issue. Are you running with this=20
> patch applied?
> >=20
> > $ svn log include/asm-powerpc/bits/pod.h
> >=20
> --------------------------------------------------------------
> ----------
> > r4600 | gch | 2009-01-31 19:46:37 +0100 (Sat, 31 Jan 2009) | 1 line
> >=20
> > Is that the patch you have in mind?
> >=20
> > Wolfgang.
> >=20
>=20
>

--------------------------------------------------------
manroland AG
Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus =
Rall, Paul Steidle  =20
Sitz der Gesellschaft: Offenbach am Main, Registergericht: Amtsgericht =
Offenbach HRB-Nr. 42592
USt-Ident-Nr. DE 250200933

