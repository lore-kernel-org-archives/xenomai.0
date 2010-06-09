Message-ID: <4C0FC39D.8040008@domain.hid>
Date: Wed, 09 Jun 2010 18:38:53 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTim6W405xv2vwsA57MUle64rB7REu-hLv_t5nFC9@domain.hid>
In-Reply-To: <AANLkTim6W405xv2vwsA57MUle64rB7REu-hLv_t5nFC9@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] error while compiling the kernel
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: ramon costa <ramoncostacastello@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

ramon costa wrote:
> Hi,
>=20
> During the compilation  (CONCURRENCY_LEVEL=3D2 fakeroot make-kpkg --ini=
trd
> --append-to-version -xenomai-2.5.3 --revision 1.0 binary-arch)
> the following error is obtained :
>=20
>   H16TOFW firmware/matrox/g400_warp.fw
> make[2]: Leaving directory `/home/costa/linux-2.6.32.11'
> /usr/bin/make -j2 EXTRAVERSION=3D.11-xenomai-2.5.3  ARCH=3Di386 \
>                  -C Documentation/lguest
> make[2]: Entering directory
> `/home/costa/linux-2.6.32.11/Documentation/lguest'
> cc -m32 -Wall -Wmissing-declarations -Wmissing-prototypes -O3
> -I../../include -I../../arch/x86/include -U_FORTIFY_SOURCE    lguest.c =
=20
> -o lguest
> lguest.c:21:25: error: sys/eventfd.h: No such file or directory
> lguest.c: In function =E2=80=98create_thread=E2=80=99:
> lguest.c:1027: warning: implicit declaration of function =E2=80=98event=
fd=E2=80=99
> make[2]: *** [lguest] Error 1
> make[2]: Leaving directory
> `/home/costa/linux-2.6.32.11/Documentation/lguest'
> make[1]: *** [debian/stamp/build/kernel] Error 2
> make[1]: Leaving directory `/home/costa/linux-2.6.32.11'
> make: *** [debian/stamp/do-build-arch] Error 2
> debian:/home/costa/linux-2.6.32.11# make menuconfig
> scripts/kconfig/mconf arch/x86/Kconfig

Do you have the same problem when compiling the same kernel without
Xenomai enabled? If yes, then you are not asking your question in the
right place. We know a thing or two about compiling a kernel with
Xenomai, but we do not know everything about compiling a Linux kernel.

--=20
					    Gilles.


