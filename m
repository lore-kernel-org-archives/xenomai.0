From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <AANLkTilima6OiNDUW_79WeV08NLO-K8jtrcZWnEw8hdT@mail.gmail.com>
References: <AANLkTim9bUjQBI43P2Z7DL4ZQsZdjMMQ3ZZf2p54bAso@domain.hid>
	<AANLkTikh0wG-xK50wvmfVe0KBB25BKz4k2Ys3O26r7zq@domain.hid>
	<AANLkTilima6OiNDUW_79WeV08NLO-K8jtrcZWnEw8hdT@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 09 Jul 2010 10:51:09 +0200
Message-ID: <1278665469.1810.382.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] xenomia adeos pacht error
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?UTF-8?Q?G=C3=B6rkem_Karado=C4=9Fan?= <gkaradagan@domain.hid>
Cc: xenomai@xenomai.org

On Fri, 2010-07-09 at 11:34 +0300, G=C3=B6rkem Karado=C4=9Fan wrote:
>=20
>=20
> 2010/7/9 G=C3=B6rkem Karado=C4=9Fan <gkaradagan@domain.hid>
>        =20
>        =20
>         ok  Gilles i hope  i understand you now . i changed my linux
>         kernel. and tried again but this time=20
>         when i write this code make ARCH=3Darm CROSS_COMPILE=3Darm-linux-
>         O=3D$build_root bzImage modules
>          i got this errors :S.=20
>        =20
>         thank you again ...


This is not the right list for this question.

Please have a look there first and foremost, you will find useful hints
to set up your kernel project:
http://kernelnewbies.org/FAQ/KernelCompilation

>        =20
>        =20
>        =20
>         root@domain.hid# make ARCH=3Darm
>         CROSS_COMPILE=3Darm-linux- O=3D$build_root bzImage modules
>         make: arm-linux-gcc: Command not found
>         scripts/kconfig/conf -s arch/arm/Kconfig
>         make: arm-linux-gcc: Command not found
>           CHK     include/linux/version.h
>           UPD     include/linux/version.h
>           SYMLINK include/asm-arm/arch -> include/asm-arm/arch-at91
>           Generating include/asm-arm/mach-types.h
>           CHK     include/linux/utsrelease.h
>           UPD     include/linux/utsrelease.h
>           SYMLINK include/asm -> include/asm-arm
>           CC      arch/arm/kernel/asm-offsets.s
>         /bin/sh: arm-linux-gcc: not found
>         make[1]: *** [arch/arm/kernel/asm-offsets.s] Error 127
>         make: *** [prepare0] Error 2
>         root@domain.hid
>=20
> and i forget build_root and i wrote it. again again i have error :S
>=20
> root@domain.hid# make ARCH=3Darm
> CROSS_COMPILE=3Darm-linux- O=3D/opt/linux-2.6.25.11/build_root bzImage
> modules
> make[1]: arm-linux-gcc: Command not found
>   GEN     /opt/linux-2.6.25.11/build_root/Makefile
> scripts/kconfig/conf -s arch/arm/Kconfig
> make[1]: arm-linux-gcc: Command not found
>   CHK     include/linux/version.h
>   SYMLINK include/asm-arm/arch -> include/asm-arm/arch-at91
> make[2]: `/opt/linux-2.6.25.11/include/asm-arm/mach-types.h' is up to
> date.
>   Using /opt/linux-2.6.25.11 as source for kernel
>   /opt/linux-2.6.25.11 is not clean, please run 'make mrproper'
>   in the '/opt/linux-2.6.25.11' directory.
> make[1]: *** [prepare3] Error 1
> make: *** [sub-make] Error 2
> root@domain.hid
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

--=20
Philippe.



