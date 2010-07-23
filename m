MIME-Version: 1.0
Date: Fri, 23 Jul 2010 10:33:18 +0300
Message-ID: <AANLkTikROCnKiEBnl2W92zNQUNkScJ0reqaKVtS2iFcw@domain.hid>
From: =?ISO-8859-9?Q?G=F6rkem_Karado=F0an?= <gkaradagan@domain.hid>
Content-Type: multipart/alternative; boundary=0016e640d3d2739a90048c090c15
Subject: [Xenomai-help] staging_dir install errors
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

--0016e640d3d2739a90048c090c15
Content-Type: text/plain; charset=ISO-8859-1

$ /opt/xenomai-2.5.3/scripts/prepare-kernel.sh --arch=arm \
  --adeos=/opt/xenomai-2.5.3/ksrc/arch/arm/patches/adeos-ipipe-2.6.33-arm-*
\
  --linux=/opt/linux-2.6.33/
$ cd /opt/linux-2.6.33/
$ mkdir build_root
$ make ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabi-
O=/opt/linux-2.6.33/build_root omap3_evm_defconfig
$ make ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabi-
O=/opt/linux-2.6.33/build_root bzImage modules

$ cd /opt/linux-2.6.33/build_root
$ /opt/xenomai-2.5.3/configure --build=i686-pc-linux-gnu --host=arm-linux
--enable-arm-mach=omap3 --enable-arm-tsc
$ mkdir staging_dir
$ cd ..
$ make DESTDIR=/opt/linux-2.6.33/staging_dir install ///// I got this error
in this part.


i prepare this installing documents, and i came last part without errors
but last part i got this error code :)

root@domain.hid# make DESTDIR=/opt/linux-2.6.33/staging_dir
install
Making install in src
make[1]: Entering directory `/opt/linux-2.6.33/src'
Making install in include
make[2]: Entering directory `/opt/linux-2.6.33/src/include'
make[3]: Entering directory `/opt/linux-2.6.33/src/include'
make[3]: Nothing to be done for `install-exec-am'.
make[3]: Nothing to be done for `install-data-am'.
make[3]: Leaving directory `/opt/linux-2.6.33/src/include'
make[2]: Leaving directory `/opt/linux-2.6.33/src/include'
Making install in rtdk
make[2]: Entering directory `/opt/linux-2.6.33/src/rtdk'
/bin/bash ../../libtool --tag=CC   --mode=compile gcc -DHAVE_CONFIG_H -I.
-I/opt/xenomai-2.5.3/src/rtdk -I../../src/include  -O2 -D_GNU_SOURCE
-D_REENTRANT -Wall -pipe -march=armv7-a -D__XENO__ -D__IN_XENO__
-Wstrict-prototypes -I/opt/xenomai-2.5.3/include    -MT librtdk_la-init.lo
-MD -MP -MF .deps/librtdk_la-init.Tpo -c -o librtdk_la-init.lo `test -f
'init.c' || echo '/opt/xenomai-2.5.3/src/rtdk/'`init.c
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -I/opt/xenomai-2.5.3/src/rtdk
-I../../src/include -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe
-march=armv7-a -D__XENO__ -D__IN_XENO__ -Wstrict-prototypes
-I/opt/xenomai-2.5.3/include -MT librtdk_la-init.lo -MD -MP -MF
.deps/librtdk_la-init.Tpo -c /opt/xenomai-2.5.3/src/rtdk/init.c  -fPIC -DPIC
-o .libs/librtdk_la-init.o
/opt/xenomai-2.5.3/src/rtdk/init.c:1: error: bad value (armv7-a) for -march=
switch
/opt/xenomai-2.5.3/src/rtdk/init.c:1: error: bad value (armv7-a) for -mtune=
switch
make[2]: *** [librtdk_la-init.lo] Error 1
make[2]: Leaving directory `/opt/linux-2.6.33/src/rtdk'
make[1]: *** [install-recursive] Error 1
make[1]: Leaving directory `/opt/linux-2.6.33/src'
make: *** [install-recursive] Error 1
root@domain.hid# make DESTDIR=/opt/linux-2.6.33/staging_dir
install
Making install in src
make[1]: Entering directory `/opt/linux-2.6.33/src'
Making install in include
make[2]: Entering directory `/opt/linux-2.6.33/src/include'
make[3]: Entering directory `/opt/linux-2.6.33/src/include'
make[3]: Nothing to be done for `install-exec-am'.
make[3]: Nothing to be done for `install-data-am'.
make[3]: Leaving directory `/opt/linux-2.6.33/src/include'
make[2]: Leaving directory `/opt/linux-2.6.33/src/include'
Making install in rtdk
make[2]: Entering directory `/opt/linux-2.6.33/src/rtdk'
/bin/bash ../../libtool --tag=CC   --mode=compile gcc -DHAVE_CONFIG_H -I.
-I/opt/xenomai-2.5.3/src/rtdk -I../../src/include  -O2 -D_GNU_SOURCE
-D_REENTRANT -Wall -pipe -march=armv7-a -D__XENO__ -D__IN_XENO__
-Wstrict-prototypes -I/opt/xenomai-2.5.3/include    -MT librtdk_la-init.lo
-MD -MP -MF .deps/librtdk_la-init.Tpo -c -o librtdk_la-init.lo `test -f
'init.c' || echo '/opt/xenomai-2.5.3/src/rtdk/'`init.c
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -I/opt/xenomai-2.5.3/src/rtdk
-I../../src/include -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe
-march=armv7-a -D__XENO__ -D__IN_XENO__ -Wstrict-prototypes
-I/opt/xenomai-2.5.3/include -MT librtdk_la-init.lo -MD -MP -MF
.deps/librtdk_la-init.Tpo -c /opt/xenomai-2.5.3/src/rtdk/init.c  -fPIC -DPIC
-o .libs/librtdk_la-init.o
/opt/xenomai-2.5.3/src/rtdk/init.c:1: error: bad value (armv7-a) for -march=
switch
/opt/xenomai-2.5.3/src/rtdk/init.c:1: error: bad value (armv7-a) for -mtune=
switch
make[2]: *** [librtdk_la-init.lo] Error 1
make[2]: Leaving directory `/opt/linux-2.6.33/src/rtdk'
make[1]: *** [install-recursive] Error 1
make[1]: Leaving directory `/opt/linux-2.6.33/src'
make: *** [install-recursive] Error 1

--0016e640d3d2739a90048c090c15
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

$ /opt/xenomai-2.5.3/scripts/prepare-kernel.sh --arch=3Darm \<br>=A0 --adeo=
s=3D/opt/xenomai-2.5.3/ksrc/arch/arm/patches/adeos-ipipe-2.6.33-arm-* \<br>=
=A0 --linux=3D/opt/linux-2.6.33/<br>$ cd /opt/linux-2.6.33/<br>$ mkdir buil=
d_root<br>
$ make ARCH=3Darm CROSS_COMPILE=3Darm-none-linux-gnueabi- O=3D/opt/linux-2.=
6.33/build_root omap3_evm_defconfig<br>$ make ARCH=3Darm CROSS_COMPILE=3Dar=
m-none-linux-gnueabi- O=3D/opt/linux-2.6.33/build_root bzImage modules<br><=
br>$ cd /opt/linux-2.6.33/build_root<br>
$ /opt/xenomai-2.5.3/configure --build=3Di686-pc-linux-gnu --host=3Darm-lin=
ux --enable-arm-mach=3Domap3 --enable-arm-tsc<br>$ mkdir staging_dir<br>$ c=
d ..<br>$ make DESTDIR=3D/opt/linux-2.6.33/staging_dir install ///// I got =
this error in this part. <br>
<br><br>i prepare this installing documents, and i came last part without e=
rrors=A0 but last part i got this error code :) <br><br>root@domain.hid=
nux-2.6.33# make DESTDIR=3D/opt/linux-2.6.33/staging_dir install<br>Making =
install in src<br>
make[1]: Entering directory `/opt/linux-2.6.33/src&#39;<br>Making install i=
n include<br>make[2]: Entering directory `/opt/linux-2.6.33/src/include&#39=
;<br>make[3]: Entering directory `/opt/linux-2.6.33/src/include&#39;<br>
make[3]: Nothing to be done for `install-exec-am&#39;.<br>make[3]: Nothing =
to be done for `install-data-am&#39;.<br>make[3]: Leaving directory `/opt/l=
inux-2.6.33/src/include&#39;<br>make[2]: Leaving directory `/opt/linux-2.6.=
33/src/include&#39;<br>
Making install in rtdk<br>make[2]: Entering directory `/opt/linux-2.6.33/sr=
c/rtdk&#39;<br>/bin/bash ../../libtool --tag=3DCC=A0=A0 --mode=3Dcompile gc=
c -DHAVE_CONFIG_H -I. -I/opt/xenomai-2.5.3/src/rtdk -I../../src/include=A0 =
-O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -march=3Darmv7-a -D__XENO__ -D__=
IN_XENO__ -Wstrict-prototypes -I/opt/xenomai-2.5.3/include=A0=A0=A0 -MT lib=
rtdk_la-init.lo -MD -MP -MF .deps/librtdk_la-init.Tpo -c -o librtdk_la-init=
.lo `test -f &#39;init.c&#39; || echo &#39;/opt/xenomai-2.5.3/src/rtdk/&#39=
;`init.c<br>
libtool: compile:=A0 gcc -DHAVE_CONFIG_H -I. -I/opt/xenomai-2.5.3/src/rtdk =
-I../../src/include -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -march=3Darm=
v7-a -D__XENO__ -D__IN_XENO__ -Wstrict-prototypes -I/opt/xenomai-2.5.3/incl=
ude -MT librtdk_la-init.lo -MD -MP -MF .deps/librtdk_la-init.Tpo -c /opt/xe=
nomai-2.5.3/src/rtdk/init.c=A0 -fPIC -DPIC -o .libs/librtdk_la-init.o<br>
/opt/xenomai-2.5.3/src/rtdk/init.c:1: error: bad value (armv7-a) for -march=
=3D switch<br>/opt/xenomai-2.5.3/src/rtdk/init.c:1: error: bad value (armv7=
-a) for -mtune=3D switch<br>make[2]: *** [librtdk_la-init.lo] Error 1<br>ma=
ke[2]: Leaving directory `/opt/linux-2.6.33/src/rtdk&#39;<br>
make[1]: *** [install-recursive] Error 1<br>make[1]: Leaving directory `/op=
t/linux-2.6.33/src&#39;<br>make: *** [install-recursive] Error 1<br>root@domain.hid=
rkem:/opt/linux-2.6.33# make DESTDIR=3D/opt/linux-2.6.33/staging_dir instal=
l<br>
Making install in src<br>make[1]: Entering directory `/opt/linux-2.6.33/src=
&#39;<br>Making install in include<br>make[2]: Entering directory `/opt/lin=
ux-2.6.33/src/include&#39;<br>make[3]: Entering directory `/opt/linux-2.6.3=
3/src/include&#39;<br>
make[3]: Nothing to be done for `install-exec-am&#39;.<br>make[3]: Nothing =
to be done for `install-data-am&#39;.<br>make[3]: Leaving directory `/opt/l=
inux-2.6.33/src/include&#39;<br>make[2]: Leaving directory `/opt/linux-2.6.=
33/src/include&#39;<br>
Making install in rtdk<br>make[2]: Entering directory `/opt/linux-2.6.33/sr=
c/rtdk&#39;<br>/bin/bash ../../libtool --tag=3DCC=A0=A0 --mode=3Dcompile gc=
c -DHAVE_CONFIG_H -I. -I/opt/xenomai-2.5.3/src/rtdk -I../../src/include=A0 =
-O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -march=3Darmv7-a -D__XENO__ -D__=
IN_XENO__ -Wstrict-prototypes -I/opt/xenomai-2.5.3/include=A0=A0=A0 -MT lib=
rtdk_la-init.lo -MD -MP -MF .deps/librtdk_la-init.Tpo -c -o librtdk_la-init=
.lo `test -f &#39;init.c&#39; || echo &#39;/opt/xenomai-2.5.3/src/rtdk/&#39=
;`init.c<br>
libtool: compile:=A0 gcc -DHAVE_CONFIG_H -I. -I/opt/xenomai-2.5.3/src/rtdk =
-I../../src/include -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -march=3Darm=
v7-a -D__XENO__ -D__IN_XENO__ -Wstrict-prototypes -I/opt/xenomai-2.5.3/incl=
ude -MT librtdk_la-init.lo -MD -MP -MF .deps/librtdk_la-init.Tpo -c /opt/xe=
nomai-2.5.3/src/rtdk/init.c=A0 -fPIC -DPIC -o .libs/librtdk_la-init.o<br>
/opt/xenomai-2.5.3/src/rtdk/init.c:1: error: bad value (armv7-a) for -march=
=3D switch<br>/opt/xenomai-2.5.3/src/rtdk/init.c:1: error: bad value (armv7=
-a) for -mtune=3D switch<br>make[2]: *** [librtdk_la-init.lo] Error 1<br>ma=
ke[2]: Leaving directory `/opt/linux-2.6.33/src/rtdk&#39;<br>
make[1]: *** [install-recursive] Error 1<br>make[1]: Leaving directory `/op=
t/linux-2.6.33/src&#39;<br>make: *** [install-recursive] Error 1<br><br><br=
>

--0016e640d3d2739a90048c090c15--

