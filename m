MIME-Version: 1.0
Date: Wed, 9 Jun 2010 18:18:23 +0200
Message-ID: <AANLkTim6W405xv2vwsA57MUle64rB7REu-hLv_t5nFC9@domain.hid>
From: ramon costa <ramoncostacastello@domain.hid>
Content-Type: multipart/alternative; boundary=0015174c125a460a2704889b41d5
Subject: [Xenomai-help] error while compiling the kernel
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai help <xenomai@xenomai.org>

--0015174c125a460a2704889b41d5
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi,

During the compilation  (CONCURRENCY_LEVEL=3D2 fakeroot make-kpkg --initrd
--append-to-version -xenomai-2.5.3 --revision 1.0 binary-arch)
the following error is obtained :

  H16TOFW firmware/matrox/g400_warp.fw
make[2]: Leaving directory `/home/costa/linux-2.6.32.11'
/usr/bin/make -j2 EXTRAVERSION=3D.11-xenomai-2.5.3  ARCH=3Di386 \
                 -C Documentation/lguest
make[2]: Entering directory
`/home/costa/linux-2.6.32.11/Documentation/lguest'
cc -m32 -Wall -Wmissing-declarations -Wmissing-prototypes -O3
-I../../include -I../../arch/x86/include -U_FORTIFY_SOURCE    lguest.c   -o
lguest
lguest.c:21:25: error: sys/eventfd.h: No such file or directory
lguest.c: In function =91create_thread=92:
lguest.c:1027: warning: implicit declaration of function =91eventfd=92
make[2]: *** [lguest] Error 1
make[2]: Leaving directory
`/home/costa/linux-2.6.32.11/Documentation/lguest'
make[1]: *** [debian/stamp/build/kernel] Error 2
make[1]: Leaving directory `/home/costa/linux-2.6.32.11'
make: *** [debian/stamp/do-build-arch] Error 2
debian:/home/costa/linux-2.6.32.11# make menuconfig
scripts/kconfig/mconf arch/x86/Kconfig


any suggestion ?

Ramon

--0015174c125a460a2704889b41d5
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>During the compilation=A0 (CONCURRENCY_LEVEL=3D2 fakeroot make-k=
pkg --initrd --append-to-version -xenomai-2.5.3 --revision 1.0 binary-arch)=
<br>the following error is obtained :<br><br>=A0 H16TOFW firmware/matrox/g4=
00_warp.fw<br>
make[2]: Leaving directory `/home/costa/linux-2.6.32.11&#39;<br>/usr/bin/ma=
ke -j2 EXTRAVERSION=3D.11-xenomai-2.5.3=A0 ARCH=3Di386 \<br>=A0=A0=A0 =A0=
=A0=A0 =A0=A0=A0 =A0=A0=A0=A0 -C Documentation/lguest<br>make[2]: Entering =
directory `/home/costa/linux-2.6.32.11/Documentation/lguest&#39;<br>
cc -m32 -Wall -Wmissing-declarations -Wmissing-prototypes -O3 -I../../inclu=
de -I../../arch/x86/include -U_FORTIFY_SOURCE=A0=A0=A0 lguest.c=A0=A0 -o lg=
uest<br>lguest.c:21:25: error: sys/eventfd.h: No such file or directory<br>=
lguest.c: In function =91create_thread=92:<br>
lguest.c:1027: warning: implicit declaration of function =91eventfd=92<br>m=
ake[2]: *** [lguest] Error 1<br>make[2]: Leaving directory `/home/costa/lin=
ux-2.6.32.11/Documentation/lguest&#39;<br>make[1]: *** [debian/stamp/build/=
kernel] Error 2<br>
make[1]: Leaving directory `/home/costa/linux-2.6.32.11&#39;<br>make: *** [=
debian/stamp/do-build-arch] Error 2<br>debian:/home/costa/linux-2.6.32.11# =
make menuconfig<br>scripts/kconfig/mconf arch/x86/Kconfig<br><br><br>any su=
ggestion ?<br>
<br>Ramon<br>

--0015174c125a460a2704889b41d5--

