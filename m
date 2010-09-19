MIME-Version: 1.0
Date: Sun, 19 Sep 2010 16:04:38 +0100
Message-ID: <AANLkTi=5RZVyUPvThyLDRPsmD9U0=A8_UPPm3bUi1E_q@domain.hid>
From: ronny meeus <ronny.meeus@domain.hid>
Content-Type: multipart/alternative; boundary=0016368e327c5c2c8c04909e1d07
Subject: [Xenomai-help] pSOS+ simple example returns error code -14
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

--0016368e327c5c2c8c04909e1d07
Content-Type: text/plain; charset=ISO-8859-1

Hello

I'm using xenomai in a qemu setup.
My final goal is to use xenomai to port extisting pSOS application to the
linux platform.

The first step I did was building a kernel with the pSOS skin enabled. These
traces are generated at kernel startup:
[    0.212363] I-pipe: Domain Xenomai registered.
[    0.212363] Xenomai: hal/i386 started.
[    0.212363] Xenomai: scheduling class idle registered.
[    0.212363] Xenomai: scheduling class rt registered.
[    0.246987] Xenomai: real-time nucleus v2.5.4 (Sleep Walk) loaded.
[    0.246987] Xenomai: debug mode enabled.
[    0.274658] Xenomai: starting native API services.
[    0.274658] Xenomai: starting POSIX services.
[    0.296357] Xenomai: starting RTDM services.
[    0.296357] Xenomai: registered exported object RN#0 (regions)
[    0.296357] Xenomai: starting pSOS+ services.
[    0.305601] HugeTLB registered 4 MB page size, pre-allocated 0 pages

This is the example application:

#include <psos+/psos.h>

void task2_func(u_long a,u_long b,u_long c,u_long d)
{
        while (1) {
                tm_wkafter(1000);
        }
}

int main(int argc, char **argv)
{
        unsigned long tid;
        unsigned long args[4] = {0,0,0,0};

        t_create("TEST",10,160000,160000,0,&tid);
        t_start(tid,0,task2_func,args);
        while (1) {
                sleep(100);
        }
}

The command line used during compilation is:

/home/meeusr/repo/xenomai-configs/buildroot-output/staging/usr/bin/i686-unknown-linux-uclibc-gcc
-Os -pipe -Os -mtune=i686 -march=i686 -D_LARGEFILE_SOURCE
-D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64
-I/home/meeusr/repo/xenomai-configs/buildroot-output/staging/usr/include
-I/home/meeusr/repo/xenomai-configs/buildroot-output/staging/include
--sysroot=/home/meeusr/repo/xenomai-configs/buildroot-output/staging/
-isysroot /home/meeusr/repo/xenomai-configs/buildroot-output/staging
-I/home/meeusr/repo/xenomai-configs/buildroot-output/target/usr/xenomai/include
-D_GNU_SOURCE -D_REENTRANT -Wall -pipe -D__XENO__
-I/home/meeusr/repo/xenomai-configs/buildroot-output/target/usr/xenomai/include/psos+
rtprint.c -lpsos
-L/home/meeusr/repo/xenomai-configs/buildroot-output/target/usr/xenomai/lib
-lxenomai -lpthread  -lpsos -Xlinker -rpath -Xlinker
/home/meeusr/repo/xenomai-configs/buildroot-output/target/usr/xenomai/lib
-lrtdk -o rtprint_ronny


When I try to run the application I get (first time):
# ./rtprint_ronny
Xenomai pSOS skin init: t_shadow() failed, status -14#
#

The second time I get
# ./rtprint_ronny
[  145.049826] Xenomai: FAILED to register object MAIN (unknown type),
status -17
Xenomai pSOS skin init: t_shadow() failed, status -17#
#

I already read somewhere that the -14 and -17 error codes (negative values)
indicate that there is a problem in the nucleus
Can somebody tell me what I do wrong?

Best regards,
Ronny

--0016368e327c5c2c8c04909e1d07
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello<br><br>I&#39;m using xenomai in a qemu setup.<br>My final goal is to =
use xenomai to port extisting pSOS application to the linux platform.<br><b=
r>The first step I did was building a kernel with the pSOS skin enabled. Th=
ese traces are generated at kernel startup:<br>
[=A0=A0=A0 0.212363] I-pipe: Domain Xenomai registered.<br>[=A0=A0=A0 0.212=
363] Xenomai: hal/i386 started.<br>[=A0=A0=A0 0.212363] Xenomai: scheduling=
 class idle registered.<br>[=A0=A0=A0 0.212363] Xenomai: scheduling class r=
t registered.<br>[=A0=A0=A0 0.246987] Xenomai: real-time nucleus v2.5.4 (Sl=
eep Walk) loaded.<br>
[=A0=A0=A0 0.246987] Xenomai: debug mode enabled.<br>[=A0=A0=A0 0.274658] X=
enomai: starting native API services.<br>[=A0=A0=A0 0.274658] Xenomai: star=
ting POSIX services.<br>[=A0=A0=A0 0.296357] Xenomai: starting RTDM service=
s.<br>[=A0=A0=A0 0.296357] Xenomai: registered exported object RN#0 (region=
s)<br>
[=A0=A0=A0 0.296357] Xenomai: starting pSOS+ services.<br>[=A0=A0=A0 0.3056=
01] HugeTLB registered 4 MB page size, pre-allocated 0 pages<br><br>This is=
 the example application:<br><br>#include &lt;psos+/psos.h&gt;<br><br>void =
task2_func(u_long a,u_long b,u_long c,u_long d)<br>
{<br>=A0=A0=A0=A0=A0=A0=A0 while (1) {<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 tm_wkafter(1000);<br>=A0=A0=A0=A0=A0=A0=A0 }<br>}<br><br>int m=
ain(int argc, char **argv)<br>{<br>=A0=A0=A0=A0=A0=A0=A0 unsigned long tid;=
<br>=A0=A0=A0=A0=A0=A0=A0 unsigned long args[4] =3D {0,0,0,0};<br><br>=A0=
=A0=A0=A0=A0=A0=A0 t_create(&quot;TEST&quot;,10,160000,160000,0,&amp;tid);<=
br>
=A0=A0=A0=A0=A0=A0=A0 t_start(tid,0,task2_func,args);<br>=A0=A0=A0=A0=A0=A0=
=A0 while (1) {<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sleep(100)=
;<br>=A0=A0=A0=A0=A0=A0=A0 }<br>}<br><br>The command line used during compi=
lation is:<br><br>/home/meeusr/repo/xenomai-configs/buildroot-output/stagin=
g/usr/bin/i686-unknown-linux-uclibc-gcc -Os -pipe -Os -mtune=3Di686 -march=
=3Di686 -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 =
-I/home/meeusr/repo/xenomai-configs/buildroot-output/staging/usr/include -I=
/home/meeusr/repo/xenomai-configs/buildroot-output/staging/include --sysroo=
t=3D/home/meeusr/repo/xenomai-configs/buildroot-output/staging/ -isysroot /=
home/meeusr/repo/xenomai-configs/buildroot-output/staging -I/home/meeusr/re=
po/xenomai-configs/buildroot-output/target/usr/xenomai/include -D_GNU_SOURC=
E -D_REENTRANT -Wall -pipe -D__XENO__ -I/home/meeusr/repo/xenomai-configs/b=
uildroot-output/target/usr/xenomai/include/psos+=A0 rtprint.c -lpsos -L/hom=
e/meeusr/repo/xenomai-configs/buildroot-output/target/usr/xenomai/lib -lxen=
omai -lpthread=A0 -lpsos -Xlinker -rpath -Xlinker /home/meeusr/repo/xenomai=
-configs/buildroot-output/target/usr/xenomai/lib -lrtdk -o rtprint_ronny<br=
>
<br><br>When I try to run the application I get (first time):<br># ./rtprin=
t_ronny<br>Xenomai pSOS skin init: t_shadow() failed, status -14# <br>#<br>=
<br>The second time I get<br># ./rtprint_ronny<br>[=A0 145.049826] Xenomai:=
 FAILED to register object MAIN (unknown type), status -17<br>
Xenomai pSOS skin init: t_shadow() failed, status -17# <br># <br><br>I alre=
ady read somewhere that the -14 and -17 error codes (negative values) indic=
ate that there is a problem in the nucleus <br>Can somebody tell me what I =
do wrong? <br>
<br>Best regards,<br>Ronny<br>

--0016368e327c5c2c8c04909e1d07--

