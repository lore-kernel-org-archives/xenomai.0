Message-ID: <4BB21210.8050508@domain.hid>
Date: Tue, 30 Mar 2010 17:00:32 +0200
From: Patrice Kadionik <kadionik@domain.hid>
MIME-Version: 1.0
References: <507168.65506.qm@domain.hid>,
	<4BAF58F7.7070707@domain.hid>
	<B66DE711C138E84F96E6A2EDD078830B5F2A4D39D0@domain.hid>
	<4BB1287B.6020205@domain.hid>
	<4BB1BEF2.5040600@domain.hid>
	<4BB1C719.4000305@domain.hid>
	<4BB1C88D.8060506@domain.hid>
	<4BB1D673.2050600@domain.hid>
In-Reply-To: <4BB1D673.2050600@domain.hid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Problem to cross-compile
	Xenomai	user-space	support
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
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Le 30/03/2010 12:46, Gilles Chanteperdrix a =C3=A9crit :
> diff --git a/src/testsuite/unit/cond-torture.c
> b/src/testsuite/unit/cond-torture.c
> index a20e12f..2d40a29 100644
> --- a/src/testsuite/unit/cond-torture.c
> +++ b/src/testsuite/unit/cond-torture.c
> @@ -47,13 +47,13 @@ int mutex_init(mutex_t *mutex, int type, int pi)
>
>          pthread_mutexattr_init(&mattr);
>          pthread_mutexattr_settype(&mattr, type);
> -       if (pi !=3D 0)
>   #ifdef HAVE_PTHREAD_MUTEXATTR_SETPROTOCOL
> +       if (pi !=3D 0)
>                  pthread_mutexattr_setprotocol(&mattr, PTHREAD_PRIO_INH=
ERIT);
>
>          err =3D pthread_mutex_init(mutex,&mattr);
>   #else
> -       else {
> +       if (pi !=3D 0) {
>                  err =3D ENOSYS;
>                  goto out;
>          }
>   =20
The patch is OK. Everything compiles now. It runs on my NIOS II board.
Thanks Gilles.

Please find a patch for updating the Xenomai README file concerning NIOS =
II.

Cheers;
Patrice


--=20
--
Patrice Kadionik. F6KQH / F4CUQ
-----------

+----------------------------------------------------------------------+
+"Tout doit etre aussi simple que possible, pas seulement plus simple" +
+----------------------------------------------------------------------+
+ Patrice Kadionik             http://www.enseirb-matmeca.fr/~kadionik +
+ IMS Laboratory               http://www.ims-bordeaux.fr/             +
+ ENSEIRB-MATMECA              http://www.enseirb-matmeca.fr           +
+ PO BOX 99                    fax   : +33 5.56.37.20.23               +
+ 33402 TALENCE Cedex          voice : +33 5.56.84.23.47               +
+ FRANCE                       mailto:patrice.kadionik@domain.hid +
+----------------------------------------------------------------------+

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
--- xenomai-2.5.2/README.INSTALL	2010-01-16 01:09:31.000000000 +0100
+++ xenomai-2.5.2.new/README.INSTALL	2010-03-30 16:48:54.000000000 +0200
@@ -451,8 +451,8 @@
  Note in Linux, IRQ 0 means auto-detected, so you must not use IRQ 0 for=
 ANY devices.

  The Xenomai port for NIOS II uses extra hardware that you have to add i=
n SOPC builder:
-- A  full featured 32-bit Timer named hrtimer with a 1 =C2=B5s period.
-- A  full featured High Resolution 64-bit Timer named hrclock used for t=
ime stamping (1 =C2=B5s period for example).
+- A full featured 32-bit Timer named hrtimer with a 1 us period.
+- A full featured High Resolution 64-bit Timer named hrclock used for ti=
me stamping (1 us period for example).

  PLEASE RESPECT hrtimer, hrclock names because the Xenomai port is based=
 on them!

@@ -465,9 +465,10 @@

  You should first verify that uClinux without Xenomai can run on the tar=
get board.
  The typical actions for building the uClinux kernel for NIOS II (availa=
ble here: http://www.nioswiki.com/) are:
-If $uClinux-dist is the path of NIOS II uClinux release, for example: /h=
ome/test/nios2-linux/uClinux-dist
+- If $linux_tree is the path of the NIOS II uClinux kernel source direct=
ory, for example: /home/test/nios2-linux/linux-2.6
+- If $uclinux is the path of the NIOS II uClinux distribution, for examp=
le: /home/test/nios2-linux/uClinux-dist

-$ cd $uClinux-dist
+$ cd $uclinux
  $ make menuconfig
  $ make vendor_hwselect SYSPTF=3D<path to your system ptf>
  $ make
@@ -475,11 +476,12 @@
  If the NIOS II cross-compiler is called nios2-linux-gcc, a typical comp=
ilation will look like:

  $ $xenomai_root/scripts/prepare-kernel.sh --arch=3Dnios2 \
-  --adeos=3D$xenomai_root/ksrc/arch/nios2/patches/adeos-ipipe-2.6.26-rc6=
-nios2-* \
+  --adeos=3D$xenomai_root/ksrc/arch/nios2/patches/adeos-ipipe-2.6.30-nio=
s2-* \
    --linux=3D$linux_tree
+
  $ $xenomai_root/configure --host=3Dnios2-linux
-$ make install DESTDIR=3D$uClinux-dist/romf
-$ cd $uClinux-dist
+$ make install DESTDIR=3D$uclinux/romf
+$ cd $uclinux
  $ make

  2.6 Building with the --enable-linux-build option


