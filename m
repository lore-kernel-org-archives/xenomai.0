From: Leopold Palomo-Avellaneda <leo@domain.hid>
Date: Thu, 29 Oct 2009 12:25:26 +0100
References: <200910281314.00378.leo@domain.hid>
	<200910291123.21542.leo@domain.hid> <4AE974A0.30509@domain.hid>
In-Reply-To: <4AE974A0.30509@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200910291225.27382.leo@domain.hid>
Subject: Re: [Xenomai-help] Xenomai patches
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

A Dijous 29 Octubre 2009, Gilles Chanteperdrix va escriure:
> Leopold Palomo-Avellaneda wrote:
> > A Dijous 29 Octubre 2009, Gilles Chanteperdrix va escriure:
> >> Gilles Chanteperdrix wrote:
> >>> Leopold Palomo-Avellaneda wrote:
> >>>> OTOH, the debian package has a bug. I cannot compile xenomai, using
> >>>> the debian way on kernels 2.6.28, 2.6.29 and 2.6.30 because the
> >>>> package add something that fails with make menuconfig. I should write
> >>>> a bug. Just for information, it's not a xenomai upstream related
> >>>> question. ;-)
> >>>
> >>> Please check xenomai-2.4.9.1. It may happen that the bug has been
> >>> already solved.
> >>
> >> 2.4.10
> >
> > nops, sorry again my fingers were so fast ...
> >
> > we are talking about the same? I got:
> >
> > cripts/kconfig/conf -o arch/x86/Kconfig
> > arch/x86/Kconfig:74: unexpected option "select"
> > arch/x86/Kconfig:75: unexpected option "select"
> > make[3]: *** [oldconfig] Error 1
> > make[2]: *** [oldconfig] Error 2
>
> I am not talking about any specific bug. It was just a general advice.
> In any case, we are not responsible for the Xenomai packages made by the
> Debian team, but if you find bugs in the debian directory which is part
> of the Xenomai package, we are interested in fixing them, of course.

well, I have found two things:

1) the debian directory is very similar in both (upstream and debian=20
official). The method to create the package is described in the xenomai wik=
i=20
and have been working so well till now (at least in my case). The script or=
=20
the patch applied in the versions of the kernel 2.6.28>=3D introduces somet=
hing=20
that make fail the make menuconfig step. If you apply the patch with the=20
script (scripts/prepare-kernel.sh) the make menuconfig works

2) after the step of preparing the kernel, (with xenomai 2.4.10) when I=20
compile the kernel (2.6.30., it fails in:

 CC      arch/x86/xenomai/hal-common.o
arch/x86/xenomai/hal_32.c: In function =E2=80=98rthal_latency_above_max=E2=
=80=99:
arch/x86/xenomai/hal_32.c:139: warning: passing argument 1 of =E2=80=98die_=
nmi=E2=80=99 from=20
incompatible pointer type
arch/x86/xenomai/hal_32.c:139: warning: passing argument 2 of =E2=80=98die_=
nmi=E2=80=99 from=20
incompatible pointer type
arch/x86/xenomai/hal_32.c:139: error: too few arguments to function =E2=80=
=98die_nmi=E2=80=99
make[2]: *** [arch/x86/xenomai/hal_32.o] Error 1
make[2]: *** Waiting for unfinished jobs....
  LD      arch/x86/oprofile/built-in.o
  CC      net/socket.o


Now, I'm compiling 2.6.29 with 2.4.10 ...

Leo




