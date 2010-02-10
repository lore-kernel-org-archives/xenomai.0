MIME-Version: 1.0
From: =?ISO-8859-1?Q?Felipe_Brand=E3o_Cavalcanti?= <cavalkaf@domain.hid>
Date: Wed, 10 Feb 2010 12:27:06 +0100
Message-ID: <8b216e9e1002100327h3aa332ddl13ec590fcb81f0b7@domain.hid>
Content-Type: multipart/alternative; boundary=00504502cb15ab7bd5047f3d519a
Subject: [Xenomai-help] Problems when cross-compiling Xenomai
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

--00504502cb15ab7bd5047f3d519a
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,

I am having some problems when trying to cross-compile the userspace portio=
n
of the latest Xenomai (2.5.1) for ARM. I am attempting to get Xenomai
running on a IGEPv2 OMAP board (Beagleboard based), so I am cross-compiling
with bitbake on top of a poky Linux distribution.

I get the following error:
| libtool: link: ../../../scripts/wrap-link.sh arm-none-linux-gnueabi-gcc
-march=3Darmv7-a -mtune=3Dcortex-a8 -mfpu=3Dneon -mfloat-abi=3Dsoftfp
-fno-tree-vectorize -fexpensive-optimizations -fomit-frame-pointer
-frename-registers -O2 -ggdb -feliminate-unused-debug-types
-Wl,@/home/jdoe/poky/poky/build/tmp-poky/work/armv7a-none-linux-gnueabi/xen=
omai-2.5.1-r0/xenomai-2.5.1/src/skins/posix/posix.wrappers
-rdynamic -Wl,-O1 -Wl,--as-needed -o .libs/sigtest sigtest-sigtest.o
../../skins/posix/.libs/libpthread_rt.so -lpthread -lrt
| ../../skins/posix/.libs/libpthread_rt.so: undefined reference to
`shm_open'
| ../../skins/posix/.libs/libpthread_rt.so: undefined reference to
`shm_unlink'
| collect2: ld returned 1 exit status

Libpthread_rt.so doesnt seem to be linked to librt.so from GLIBC... any
clues on how to fix this? I am getting this exact error in several points o=
f
the compiling process.

(I am running ./configure --prefix=3D/usr --includedir=3D/usr/include/xenom=
ai
--enable-arm-mach=3Domap3 --enable-arm-eabi --enable-arm-tsc --disable-dox-=
doc
--disable-dbx --host=3Darm-linux beforehand, and the kernel portion seems t=
o
be working fine.)

Thanks in advance,
      -Felipe Brand=E3o Cavalcanti
      LARA - Robotics and Automation Laboratory
      Department of Electrical Engineering
      UnB - University of Bras=EDlia, Brazil
      http://www.lara.unb.br/~fbcavalcanti/

--00504502cb15ab7bd5047f3d519a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,<br><br>I am having some problems when trying to cross-compile the us=
erspace portion of the latest Xenomai (2.5.1) for ARM. I am attempting to g=
et Xenomai running on a IGEPv2 OMAP board (Beagleboard based), so I am cros=
s-compiling with bitbake on top of a poky Linux distribution.<br>

<br>I get the following error:<br>| libtool: link: ../../../scripts/wrap-li=
nk.sh arm-none-linux-gnueabi-gcc -march=3Darmv7-a -mtune=3Dcortex-a8 -mfpu=
=3Dneon -mfloat-abi=3Dsoftfp -fno-tree-vectorize -fexpensive-optimizations =
-fomit-frame-pointer -frename-registers -O2 -ggdb -feliminate-unused-debug-=
types -Wl,@/home/jdoe/poky/poky/build/tmp-poky/work/armv7a-none-linux-gnuea=
bi/xenomai-2.5.1-r0/xenomai-2.5.1/src/skins/posix/posix.wrappers -rdynamic =
-Wl,-O1 -Wl,--as-needed -o .libs/sigtest sigtest-sigtest.o=A0 ../../skins/p=
osix/.libs/libpthread_rt.so -lpthread -lrt<br>

| ../../skins/posix/.libs/libpthread_rt.so: undefined reference to `shm_ope=
n&#39;<br>| ../../skins/posix/.libs/libpthread_rt.so: undefined reference t=
o `shm_unlink&#39;<br>| collect2: ld returned 1 exit status<br><br>Libpthre=
ad_rt.so doesnt seem to be linked to librt.so from GLIBC... any clues on ho=
w to fix this? I am getting this exact error in several points of the compi=
ling process.<br>

<br>(I am running ./configure --prefix=3D/usr --includedir=3D/usr/include/x=
enomai --enable-arm-mach=3Domap3 --enable-arm-eabi --enable-arm-tsc --disab=
le-dox-doc --disable-dbx --host=3Darm-linux beforehand, and the kernel port=
ion seems to be working fine.)<br>

<br>Thanks in advance,<br> =A0 =A0 =A0 -Felipe Brand=E3o Cavalcanti<br> =A0=
 =A0 =A0 LARA - Robotics and Automation Laboratory<br> =A0 =A0 =A0 Departme=
nt of Electrical Engineering<br> =A0 =A0 =A0 UnB - University of Bras=EDlia=
, Brazil<br> =A0 =A0 =A0 <a href=3D"http://www.lara.unb.br/~fbcavalcanti/">=
http://www.lara.unb.br/~fbcavalcanti/</a><br>



--00504502cb15ab7bd5047f3d519a--

