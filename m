MIME-Version: 1.0
Date: Wed, 14 Oct 2009 15:19:42 +0900
Message-ID: <1f3e02580910132319v3ce08b2frb811d749def9f17@domain.hid>
From: Didenko Sergey <didenkos@domain.hid>
Content-Type: multipart/alternative; boundary=00504502ccb704bb180475df26d7
Subject: [Xenomai-help]  Support for ARCH_MV88F6290
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
Cc: xenomai@xenomai.org

--00504502ccb704bb180475df26d7
Content-Type: text/plain; charset=UTF-8

Dear Gilles

when I did change the HW Timer interrupt number (__ipipe_mach_timerint) from
0 to 1
Patched kernel is able to boot up...but I'm not sure whether Xenomai is
running or not even I can see the messages that it is started...
To verify whether it is running or not I want to do latency test ..for
that..I'm following the HOWTO which says that I have to
1) configure Xenomai
$ ./configure --build=i686-pc-linux-gnu --host=arm-linux
--enable-arm-mach=generic --enable-arm-tsc

2) make Install
When I do "make DESTDIR=/nfs install" where /nfs - is the NFS path to rootfs
mounted by board.
I have next situation...

===

[d.sergey@domain.hid xenomai-2.4.9.1]$ make DESTDIR=/nfs install
Making install in src
make[1]: Entering directory `/home/d.sergey/xemomai/xenomai-2.4.9.1/src'
Making install in include
make[2]: Entering directory
`/home/d.sergey/xemomai/xenomai-2.4.9.1/src/include'
make[3]: Entering directory
`/home/d.sergey/xemomai/xenomai-2.4.9.1/src/include'
make[3]: Nothing to be done for `install-exec-am'.
make[3]: Nothing to be done for `install-data-am'.
make[3]: Leaving directory
`/home/d.sergey/xemomai/xenomai-2.4.9.1/src/include'
make[2]: Leaving directory
`/home/d.sergey/xemomai/xenomai-2.4.9.1/src/include'
Making install in rtdk
make[2]: Entering directory
`/home/d.sergey/xemomai/xenomai-2.4.9.1/src/rtdk'
/bin/sh ../../libtool  --tag=CC   --mode=compile gcc -DHAVE_CONFIG_H -I.
-I../../src/include  -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -march=armv4
-D__XENO__ -D__IN_XENO__ -Wstrict-prototypes -I../../include    -MT
librtdk_la-init.lo -MD -MP -MF .deps/librtdk_la-init.Tpo -c -o
librtdk_la-init.lo `test -f 'init.c' || echo './'`init.c
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -I../../src/include -O2
-D_GNU_SOURCE -D_REENTRANT -Wall -pipe -march=armv4 -D__XENO__ -D__IN_XENO__
-Wstrict-prototypes -I../../include -MT librtdk_la-init.lo -MD -MP -MF
.deps/librtdk_la-init.Tpo -c init.c  -fPIC -DPIC -o .libs/librtdk_la-init.o
init.c:1: error: bad value (armv4) for -march= switch
init.c:1: error: bad value (armv4) for -mtune= switch
make[2]: *** [librtdk_la-init.lo] Error 1
make[2]: Leaving directory `/home/d.sergey/xemomai/xenomai-2.4.9.1/src/rtdk'
make[1]: *** [install-recursive] Error 1
make[1]: Leaving directory `/home/d.sergey/xemomai/xenomai-2.4.9.1/src'
make: *** [install-recursive] Error 1
[d.sergey@domain.hid xenomai-2.4.9.1]$

====

What is wrong?
How can I patch the rootfs with Xenomai libraries correctly?

Sergey

--00504502ccb704bb180475df26d7
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Dear Gilles<br><br>when I did change the HW Timer interrupt number (__ipipe=
_mach_timerint) from 0 to 1<br>Patched kernel is able to boot up...but I&#3=
9;m not sure whether Xenomai is running or not even I can see the messages =
that it is started...<br>
To verify whether it is running or not I want to do latency test ..for that=
..I&#39;m following the HOWTO which says that I have to <br>1) configure Xe=
nomai<br>$ ./configure --build=3Di686-pc-linux-gnu --host=3Darm-linux --ena=
ble-arm-mach=3Dgeneric --enable-arm-tsc<br>
<br>2) make Install<br>When I do &quot;make DESTDIR=3D/nfs install&quot; wh=
ere /nfs - is the NFS path to rootfs mounted by board.<br>I have next situa=
tion...<br><br>=3D=3D=3D<br><br>[d.sergey@domain.hid xenomai-2.4.9.1]$ make D=
ESTDIR=3D/nfs install<br>
Making install in src<br>make[1]: Entering directory `/home/d.sergey/xemoma=
i/xenomai-2.4.9.1/src&#39;<br>Making install in include<br>make[2]: Enterin=
g directory `/home/d.sergey/xemomai/xenomai-2.4.9.1/src/include&#39;<br>
make[3]: Entering directory `/home/d.sergey/xemomai/xenomai-2.4.9.1/src/inc=
lude&#39;<br>make[3]: Nothing to be done for `install-exec-am&#39;.<br>make=
[3]: Nothing to be done for `install-data-am&#39;.<br>make[3]: Leaving dire=
ctory `/home/d.sergey/xemomai/xenomai-2.4.9.1/src/include&#39;<br>
make[2]: Leaving directory `/home/d.sergey/xemomai/xenomai-2.4.9.1/src/incl=
ude&#39;<br>Making install in rtdk<br>make[2]: Entering directory `/home/d.=
sergey/xemomai/xenomai-2.4.9.1/src/rtdk&#39;<br>/bin/sh ../../libtool=C2=A0=
 --tag=3DCC=C2=A0=C2=A0 --mode=3Dcompile gcc -DHAVE_CONFIG_H -I. -I../../sr=
c/include=C2=A0 -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -march=3Darmv4 -=
D__XENO__ -D__IN_XENO__ -Wstrict-prototypes -I../../include=C2=A0=C2=A0=C2=
=A0 -MT librtdk_la-init.lo -MD -MP -MF .deps/librtdk_la-init.Tpo -c -o libr=
tdk_la-init.lo `test -f &#39;init.c&#39; || echo &#39;./&#39;`init.c<br>
libtool: compile:=C2=A0 gcc -DHAVE_CONFIG_H -I. -I../../src/include -O2 -D_=
GNU_SOURCE -D_REENTRANT -Wall -pipe -march=3Darmv4 -D__XENO__ -D__IN_XENO__=
 -Wstrict-prototypes -I../../include -MT librtdk_la-init.lo -MD -MP -MF .de=
ps/librtdk_la-init.Tpo -c init.c=C2=A0 -fPIC -DPIC -o .libs/librtdk_la-init=
.o<br>
init.c:1: error: bad value (armv4) for -march=3D switch<br>init.c:1: error:=
 bad value (armv4) for -mtune=3D switch<br>make[2]: *** [librtdk_la-init.lo=
] Error 1<br>make[2]: Leaving directory `/home/d.sergey/xemomai/xenomai-2.4=
.9.1/src/rtdk&#39;<br>
make[1]: *** [install-recursive] Error 1<br>make[1]: Leaving directory `/ho=
me/d.sergey/xemomai/xenomai-2.4.9.1/src&#39;<br>make: *** [install-recursiv=
e] Error 1<br>[d.sergey@domain.hid xenomai-2.4.9.1]$ <br><br>=3D=3D=3D=3D<br>=
<br>
What is wrong?<br>How can I patch the rootfs with Xenomai libraries correct=
ly?<br><br>Sergey<br><br>

--00504502ccb704bb180475df26d7--

