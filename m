MIME-Version: 1.0
Date: Tue, 20 Jan 2009 09:19:40 +0100
Message-ID: <6fca2a340901200019ubc33787qc82aa056bd0819b8@domain.hid>
From: =?ISO-8859-1?Q?sa=E2dia_dhouib?= <dhouib@domain.hid>
Content-Type: multipart/alternative; boundary=001636c5a92b69af9c0460e5b382
Subject: [Xenomai-help] xupv2p xenomai installation problem
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

--001636c5a92b69af9c0460e5b382
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi all,
I want to install xenomai on a xupv2p board embedding ppc405 processor.
I use ELDK cross compiler.
I have patched and compiled successfully the linux kernel. And Now I want to
do the next steps:
(from the README.INSTALL)
$ cd $build_root
$ $xenomai_root/configure --build=i686-pc-linux-gnu
--host=ppc-unknown-linux-gnu CC=ppc_4xx-gcc \
  CXX=ppc_4xx-g++ LD=ppc_4xx-ld
$ make DESTDIR=$staging_dir install

My questions are:

1- What is the staging dir ??
The root file system of the linux 2.6 kernel  is on a flash disk. So the
staging dir is a the path
to the rfs in the flash disk??

2- When I do:
export build_root=/home/dhouib/xupv2p/build_xeno
export xenomai_root=/home/dhouib/xupv2p/xenomai-2.4.6/
export staging_dir=/media/disk-3
$ cd $build_root
$ $xenomai_root/configure --build=i686-pc-linux-gnu
--host=ppc-unknown-linux-gnu CC=ppc_4xx-gcc \
  CXX=ppc_4xx-g++ LD=ppc_4xx-ld
$ make DESTDIR=$staging_dir install

I have the following errors:
make[2]: Entering directory `/home/dhouib/xupv2p/build_xeno/src/rtdk'
/bin/bash ../../libtool --tag=CC   --mode=link ppc_4xx-gcc   -version-info
0:0:0 -lpthread  -o librtdk.la -rpath /usr/xenomai/lib librtdk_la-init.lo
librtdk_la-rt_print.lo
ppc_4xx-gcc -shared  .libs/librtdk_la-init.o .libs/librtdk_la-rt_print.o
-lpthread  -Wl,-soname -Wl,librtdk.so.0 -o .libs/librtdk.so.0.0.0
/home/dhouib/xupv2p/elkd/usr/bin/../lib/gcc/powerpc-linux/4.2.2/../../../../powerpc-linux/bin/ld:
.libs/librtdk_la-init.o: Relocations in generic ELF (EM: 3)
/home/dhouib/xupv2p/elkd/usr/bin/../lib/gcc/powerpc-linux/4.2.2/../../../../powerpc-linux/bin/ld:
.libs/librtdk_la-init.o: Relocations in generic ELF (EM: 3)
.libs/librtdk_la-init.o: could not read symbols: File in wrong format
collect2: ld returned 1 exit status
make[2]: *** [librtdk.la] Error 1
make[2]: Leaving directory `/home/dhouib/xupv2p/build_xeno/src/rtdk'
make[1]: *** [install-recursive] Error 1
make[1]: Leaving directory `/home/dhouib/xupv2p/build_xeno/src'
make: *** [install-recursive] Error 1

Can someone help me?
Thanks

--001636c5a92b69af9c0460e5b382
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi all,<br>I want to install xenomai on a xupv2p board embedding ppc405 pro=
cessor.<br>I use ELDK cross compiler.<br>I have patched and compiled succes=
sfully the linux kernel. And Now I want to do the next steps:<br>(from the =
README.INSTALL)<br>
$ cd $build_root<br>$ $xenomai_root/configure --build=3Di686-pc-linux-gnu -=
-host=3Dppc-unknown-linux-gnu CC=3Dppc_4xx-gcc \<br>&nbsp; CXX=3Dppc_4xx-g+=
+ LD=3Dppc_4xx-ld<br>$ make DESTDIR=3D$staging_dir install<br><br>My questi=
ons are:<br><br>
1- What is the staging dir ?? <br>The root file system of the linux 2.6 ker=
nel&nbsp; is on a flash disk. So the staging dir is a the path<br>to the rf=
s in the flash disk??<br><br>2- When I do:<br>export build_root=3D/home/dho=
uib/xupv2p/build_xeno<br>
export xenomai_root=3D/home/dhouib/xupv2p/xenomai-2.4.6/<br>export staging_=
dir=3D/media/disk-3<br>$ cd $build_root<br>$ $xenomai_root/configure --buil=
d=3Di686-pc-linux-gnu --host=3Dppc-unknown-linux-gnu CC=3Dppc_4xx-gcc \<br>=
&nbsp; CXX=3Dppc_4xx-g++ LD=3Dppc_4xx-ld<br>
$ make DESTDIR=3D$staging_dir install<br><br>I have the following errors:<b=
r>make[2]: Entering directory `/home/dhouib/xupv2p/build_xeno/src/rtdk&#39;=
<br>/bin/bash ../../libtool --tag=3DCC&nbsp;&nbsp; --mode=3Dlink ppc_4xx-gc=
c&nbsp;&nbsp; -version-info 0:0:0 -lpthread&nbsp; -o <a href=3D"http://libr=
tdk.la">librtdk.la</a> -rpath /usr/xenomai/lib librtdk_la-init.lo librtdk_l=
a-rt_print.lo&nbsp; <br>
ppc_4xx-gcc -shared&nbsp; .libs/librtdk_la-init.o .libs/librtdk_la-rt_print=
.o&nbsp; -lpthread&nbsp; -Wl,-soname -Wl,librtdk.so.0 -o .libs/librtdk.so.0=
.0.0<br>/home/dhouib/xupv2p/elkd/usr/bin/../lib/gcc/powerpc-linux/4.2.2/../=
../../../powerpc-linux/bin/ld: .libs/librtdk_la-init.o: Relocations in gene=
ric ELF (EM: 3)<br>
/home/dhouib/xupv2p/elkd/usr/bin/../lib/gcc/powerpc-linux/4.2.2/../../../..=
/powerpc-linux/bin/ld: .libs/librtdk_la-init.o: Relocations in generic ELF =
(EM: 3)<br>.libs/librtdk_la-init.o: could not read symbols: File in wrong f=
ormat<br>
collect2: ld returned 1 exit status<br>make[2]: *** [<a href=3D"http://libr=
tdk.la">librtdk.la</a>] Error 1<br>make[2]: Leaving directory `/home/dhouib=
/xupv2p/build_xeno/src/rtdk&#39;<br>make[1]: *** [install-recursive] Error =
1<br>
make[1]: Leaving directory `/home/dhouib/xupv2p/build_xeno/src&#39;<br>make=
: *** [install-recursive] Error 1<br><br>Can someone help me?<br>Thanks<br>=
<br>

--001636c5a92b69af9c0460e5b382--

