MIME-Version: 1.0
In-Reply-To: <AANLkTim9bUjQBI43P2Z7DL4ZQsZdjMMQ3ZZf2p54bAso@domain.hid>
References: <AANLkTim9bUjQBI43P2Z7DL4ZQsZdjMMQ3ZZf2p54bAso@domain.hid>
Date: Fri, 9 Jul 2010 11:26:50 +0300
Message-ID: <AANLkTikh0wG-xK50wvmfVe0KBB25BKz4k2Ys3O26r7zq@domain.hid>
From: =?ISO-8859-9?Q?G=F6rkem_Karado=F0an?= <gkaradagan@domain.hid>
Content-Type: multipart/alternative; boundary=00163691fc6625437e048af02ae2
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

--00163691fc6625437e048af02ae2
Content-Type: text/plain; charset=ISO-8859-1

ok  Gilles i hope  i understand you now . i changed my linux kernel. and
tried again but this time
when i write this code make ARCH=arm CROSS_COMPILE=arm-linux- O=$build_root
bzImage modules
 i got this errors :S.

thank you again ...



root@domain.hid# make ARCH=arm CROSS_COMPILE=arm-linux-
O=$build_root bzImage modules
make: arm-linux-gcc: Command not found
scripts/kconfig/conf -s arch/arm/Kconfig
make: arm-linux-gcc: Command not found
  CHK     include/linux/version.h
  UPD     include/linux/version.h
  SYMLINK include/asm-arm/arch -> include/asm-arm/arch-at91
  Generating include/asm-arm/mach-types.h
  CHK     include/linux/utsrelease.h
  UPD     include/linux/utsrelease.h
  SYMLINK include/asm -> include/asm-arm
  CC      arch/arm/kernel/asm-offsets.s
/bin/sh: arm-linux-gcc: not found
make[1]: *** [arch/arm/kernel/asm-offsets.s] Error 127
make: *** [prepare0] Error 2
root@domain.hid#

--00163691fc6625437e048af02ae2
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br>ok=A0 <span class=3D"lHQn1d">Gilles i hope=A0 i understand you now =
. i changed my linux kernel. and tried again but this time <br>when i write=
 this code make ARCH=3Darm CROSS_COMPILE=3Darm-linux- O=3D$build_root bzIma=
ge modules<br>
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
root@domain.hid# <span class=3D"ik"></span>

--00163691fc6625437e048af02ae2--

