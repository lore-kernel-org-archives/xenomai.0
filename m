MIME-Version: 1.0
In-Reply-To: <AANLkTikh0wG-xK50wvmfVe0KBB25BKz4k2Ys3O26r7zq@domain.hid>
References: <AANLkTim9bUjQBI43P2Z7DL4ZQsZdjMMQ3ZZf2p54bAso@domain.hid>
	<AANLkTikh0wG-xK50wvmfVe0KBB25BKz4k2Ys3O26r7zq@domain.hid>
Date: Fri, 9 Jul 2010 11:34:34 +0300
Message-ID: <AANLkTilima6OiNDUW_79WeV08NLO-K8jtrcZWnEw8hdT@mail.gmail.com>
From: =?ISO-8859-9?Q?G=F6rkem_Karado=F0an?= <gkaradagan@domain.hid>
Content-Type: multipart/alternative; boundary=0016e6d433aec64c76048af045bc
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
To: xenomai@xenomai.org

--0016e6d433aec64c76048af045bc
Content-Type: text/plain; charset=ISO-8859-9
Content-Transfer-Encoding: quoted-printable

2010/7/9 G=F6rkem Karado=F0an <gkaradagan@domain.hid>

>
>
> ok  Gilles i hope  i understand you now . i changed my linux kernel. and
> tried again but this time
> when i write this code make ARCH=3Darm CROSS_COMPILE=3Darm-linux- O=3D$bu=
ild_root
> bzImage modules
>  i got this errors :S.
>
> thank you again ...
>
>
>
> root@domain.hid# make ARCH=3Darm CROSS_COMPILE=3Darm-lin=
ux-
> O=3D$build_root bzImage modules
> make: arm-linux-gcc: Command not found
> scripts/kconfig/conf -s arch/arm/Kconfig
> make: arm-linux-gcc: Command not found
>   CHK     include/linux/version.h
>   UPD     include/linux/version.h
>   SYMLINK include/asm-arm/arch -> include/asm-arm/arch-at91
>   Generating include/asm-arm/mach-types.h
>   CHK     include/linux/utsrelease.h
>   UPD     include/linux/utsrelease.h
>   SYMLINK include/asm -> include/asm-arm
>   CC      arch/arm/kernel/asm-offsets.s
> /bin/sh: arm-linux-gcc: not found
> make[1]: *** [arch/arm/kernel/asm-offsets.s] Error 127
> make: *** [prepare0] Error 2
> root@domain.hid#


and i forget build_root and i wrote it. again again i have error :S

root@domain.hid# make ARCH=3Darm CROSS_COMPILE=3Darm-linux=
-
O=3D/opt/linux-2.6.25.11/build_root bzImage modules
make[1]: arm-linux-gcc: Command not found
  GEN     /opt/linux-2.6.25.11/build_root/Makefile
scripts/kconfig/conf -s arch/arm/Kconfig
make[1]: arm-linux-gcc: Command not found
  CHK     include/linux/version.h
  SYMLINK include/asm-arm/arch -> include/asm-arm/arch-at91
make[2]: `/opt/linux-2.6.25.11/include/asm-arm/mach-types.h' is up to date.
  Using /opt/linux-2.6.25.11 as source for kernel
  /opt/linux-2.6.25.11 is not clean, please run 'make mrproper'
  in the '/opt/linux-2.6.25.11' directory.
make[1]: *** [prepare3] Error 1
make: *** [sub-make] Error 2
root@domain.hid#

--0016e6d433aec64c76048af045bc
Content-Type: text/html; charset=ISO-8859-9
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">2010/7/9 G=F6rkem Karado=F0an <span dir=
=3D"ltr">&lt;<a href=3D"mailto:gkaradagan@domain.hid">gkaradagan@domain.hid</=
a>&gt;</span><br><blockquote class=3D"gmail_quote" style=3D"border-left: 1p=
x solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<br><br>ok=A0 <span>Gilles i hope=A0 i understand you now . i changed my li=
nux kernel. and tried again but this time <br>when i write this code make A=
RCH=3Darm CROSS_COMPILE=3Darm-linux- O=3D$build_root bzImage modules<br>
=A0i got this errors :S. <br><br>thank you again ...<br><br><br></span><br>=
root@domain.hid# make ARCH=3Darm CROSS_COMPILE=3Darm-linux=
- O=3D$build_root bzImage modules<br>
make: arm-linux-gcc: Command not found<br>
scripts/kconfig/conf -s arch/arm/Kconfig<br>
make: arm-linux-gcc: Command not found<br>
=A0 CHK=A0=A0=A0=A0 include/linux/version.h<br>
=A0 UPD=A0=A0=A0=A0 include/linux/version.h<br>
=A0 SYMLINK include/asm-arm/arch -&gt; include/asm-arm/arch-at91<br>
=A0 Generating include/asm-arm/mach-types.h<br>
=A0 CHK=A0=A0=A0=A0 include/linux/utsrelease.h<br>
=A0 UPD=A0=A0=A0=A0 include/linux/utsrelease.h<br>
=A0 SYMLINK include/asm -&gt; include/asm-arm<br>
=A0 CC=A0=A0=A0=A0=A0 arch/arm/kernel/asm-offsets.s<br>
/bin/sh: arm-linux-gcc: not found<br>
make[1]: *** [arch/arm/kernel/asm-offsets.s] Error 127<br>
make: *** [prepare0] Error 2<br>
root@domain.hid# <span></span>
</blockquote></div><br>and i forget build_root and i wrote it. again again =
i have error :S<br><br>root@domain.hid# make ARCH=3Darm CR=
OSS_COMPILE=3Darm-linux- O=3D/opt/linux-2.6.25.11/build_root bzImage module=
s<br>
make[1]: arm-linux-gcc: Command not found<br>=A0 GEN=A0=A0=A0=A0 /opt/linux=
-2.6.25.11/build_root/Makefile<br>scripts/kconfig/conf -s arch/arm/Kconfig<=
br>make[1]: arm-linux-gcc: Command not found<br>=A0 CHK=A0=A0=A0=A0 include=
/linux/version.h<br>
=A0 SYMLINK include/asm-arm/arch -&gt; include/asm-arm/arch-at91<br>make[2]=
: `/opt/linux-2.6.25.11/include/asm-arm/mach-types.h&#39; is up to date.<br=
>=A0 Using /opt/linux-2.6.25.11 as source for kernel<br>=A0 /opt/linux-2.6.=
25.11 is not clean, please run &#39;make mrproper&#39;<br>
=A0 in the &#39;/opt/linux-2.6.25.11&#39; directory.<br>make[1]: *** [prepa=
re3] Error 1<br>make: *** [sub-make] Error 2<br>root@domain.hid.=
25.11# <br><br>

--0016e6d433aec64c76048af045bc--

