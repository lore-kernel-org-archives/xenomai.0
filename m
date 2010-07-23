Message-ID: <4C4960F4.3020306@domain.hid>
Date: Fri, 23 Jul 2010 11:29:24 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTikROCnKiEBnl2W92zNQUNkScJ0reqaKVtS2iFcw@domain.hid>
In-Reply-To: <AANLkTikROCnKiEBnl2W92zNQUNkScJ0reqaKVtS2iFcw@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] staging_dir install errors
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?UTF-8?B?R8O2cmtlbSBLYXJhZG/En2Fu?= <gkaradagan@domain.hid>
Cc: xenomai@xenomai.org

G=C3=B6rkem Karado=C4=9Fan wrote:
> $ /opt/xenomai-2.5.3/scripts/prepare-kernel.sh --arch=3Darm \
> =20
> --adeos=3D/opt/xenomai-2.5.3/ksrc/arch/arm/patches/adeos-ipipe-2.6.33-a=
rm-* \
>   --linux=3D/opt/linux-2.6.33/
> $ cd /opt/linux-2.6.33/
> $ mkdir build_root
> $ make ARCH=3Darm CROSS_COMPILE=3Darm-none-linux-gnueabi-
> O=3D/opt/linux-2.6.33/build_root omap3_evm_defconfig
> $ make ARCH=3Darm CROSS_COMPILE=3Darm-none-linux-gnueabi-
> O=3D/opt/linux-2.6.33/build_root bzImage modules
>=20
> $ cd /opt/linux-2.6.33/build_root
> $ /opt/xenomai-2.5.3/configure --build=3Di686-pc-linux-gnu
> --host=3Darm-linux --enable-arm-mach=3Domap3 --enable-arm-tsc
> $ mkdir staging_dir
> $ cd ..
> $ make DESTDIR=3D/opt/linux-2.6.33/staging_dir install ///// I got this=

> error in this part.


> libtool: compile:  gcc -DHAVE_CONFIG_H -I. -I/opt/xenomai-2.5.3/src/rtd=
k
> -I../../src/include -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe
> -march=3Darmv7-a -D__XENO__ -D__IN_XENO__ -Wstrict-prototypes
> -I/opt/xenomai-2.5.3/include -MT librtdk_la-init.lo -MD -MP -MF
> .deps/librtdk_la-init.Tpo -c /opt/xenomai-2.5.3/src/rtdk/init.c  -fPIC
> -DPIC -o .libs/librtdk_la-init.o
> /opt/xenomai-2.5.3/src/rtdk/init.c:1: error: bad value (armv7-a) for
> -march=3D switch
> /opt/xenomai-2.5.3/src/rtdk/init.c:1: error: bad value (armv7-a) for
> -mtune=3D switch

Sorry, wrong answer. You have not told configure the proper compilation
prefix, so, it failed finding "arm-linux-gcc", and fall back to gcc.
Unfortunately, gcc is not able to generate arm code, only
arm-none-linux-gnueabi-gcc is.

pass --host=3Darm-none-linux-gnueabi to configure, or pass a value for CC=

on configure command line.

--=20
					    Gilles.


