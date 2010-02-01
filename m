From: Sinisa Denic <sinisa.denic@domain.hid>
Date: Mon, 1 Feb 2010 10:11:30 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <201002011011.30715.sinisa.denic@domain.hid>
Subject: [Xenomai-help] =?utf-8?q?=2E/src/include/asm/xenomai/syscall=2Eh?=
	=?utf-8?b?OjM3NzogZXJyb3I6IOKAmHN0ZGVycuKAmSB1bmRlY2xhcmVk?=
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org.

Hi there, last days I've got in some troubles building xeno2.5 with uclibc=
=20
eabi toolchain, here is snippet:
=2D------------------------------------------------------------------------=
=2D-------------------------
init.c:1: warning: target CPU does not support interworking
In file included from ../../../src/include/asm/xenomai/atomic.h:82,
                 from ../../../include/nucleus/system.h:26,
                 from ../../../src/include/asm/xenomai/system.h:223,
                 from ../../../include/nucleus/types.h:40,
                 from ../../../include/nucleus/thread.h:25,
                 from ../../../include/posix/pthread.h:136,
                =20
from /opt/toolchains/arm926t-uclibcgnueabi/usr/include/bits/uClibc_mutex.h:=
15,
                =20
from /opt/toolchains/arm926t-uclibcgnueabi/usr/include/bits/uClibc_stdio.h:=
119,
                =20
from /opt/toolchains/arm926t-uclibcgnueabi/usr/include/stdio.h:72,
                 from init.c:19:
=2E./../../src/include/asm/xenomai/syscall.h: In=20
function =E2=80=98xeno_arm_features_check=E2=80=99:
=2E./../../src/include/asm/xenomai/syscall.h:377: error: =E2=80=98stderr=E2=
=80=99 undeclared=20
(first use in this function)
=2E./../../src/include/asm/xenomai/syscall.h:377: error: (Each undeclared=20
identifier is reported only once
=2E./../../src/include/asm/xenomai/syscall.h:377: error: for each function =
it=20
appears in.)
make[3]: *** [libpthread_rt_la-init.lo] Error 1
make[3]: Leaving directory=20
`/opt/pct210_build/xenomai-2.5.0-eabi/src/skins/posix'
make[2]: *** [all-recursive] Error 1
make[2]: Leaving directory `/opt/pct210_build/xenomai-2.5.0-eabi/src/skins'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/opt/pct210_build/xenomai-2.5.0-eabi/src'
=2D------------------------------------------------------------------
head config.log
=20
$ ./configure --build=3Di686-linux --host=3Darm-linux --prefix=3D/usr/xenom=
ai-2.5.0-eabi --enable-shared=20
CC=3D/opt/toolchains/arm926t-uclibcgnueabi/usr/bin/arm-linux-gcc=20
LD=3D/opt/toolchains/arm926t-uclibcgnueabi/usr/bin/arm-linux-ld --enable-ar=
m-mach=3Dat91sam926x

Thank you in advance,Sinisa.

