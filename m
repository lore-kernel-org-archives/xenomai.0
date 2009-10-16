MIME-Version: 1.0
In-Reply-To: <4AD57CE3.4050206@domain.hid>
References: <1f3e02580910132319v3ce08b2frb811d749def9f17@domain.hid>
	<4AD57CE3.4050206@domain.hid>
Date: Fri, 16 Oct 2009 14:26:25 +0900
Message-ID: <1f3e02580910152226h4fb94068kfce63fec4be38c3f@domain.hid>
From: Didenko Sergey <didenkos@domain.hid>
Content-Type: multipart/alternative; boundary=000e0cd328121daf35047606a3b9
Subject: Re: [Xenomai-help] Support for ARCH_MV88F6290
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
Cc: xenomai@xenomai.org, Jorge Ramirez <jorge.ramirez.ortiz@domain.hid>, mohamad.sharifi@domain.hid

--000e0cd328121daf35047606a3b9
Content-Type: text/plain; charset=UTF-8

In my case the paths are like:
# $linux_tree = /home/d.sergey/kernel/linux-2.6.29-v02.00.29
# $xenomai_root = /home/d.sergey/xemomai/xenomai-2.4.9.1
# $build_root = /home/d.sergey/build_root
# $staging_dir = /nfs/rootfs
CROSS_COMPILE - arm-none-linux-gnueabi

So, I do

1) $ $xenomai_root/scripts/prepare-kernel.sh --arch=arm  --linux=$linux_tree
ENTER
I  omitt --adeos parameter and the script suggests an appropriate one, ENTER

2) Apply patch from Jorge and fix some compilation errors
3) $ cd $linux_tree
4) $ make ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabi-
O=/home/d.sergey/build_root cosmos_mono_defconfig -j5
5) $ make ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabi-
O=/home/d.sergey/build_root bzImage modules -j5
6) $ cd  $build_root
7) $ /home/d.sergey/xemomai/xenomai-2.4.9.1/configure
--build=i686-pc-linux-gnu --host=arm-linux --enable-arm-mach=generic
--enable-arm-tsc
so far everything looks good
==== LOG

checking build system type... i686-pc-linux-gnu
checking host system type... arm-unknown-linux-gnu
checking for a BSD-compatible install... /usr/bin/install -c
checking for arm-linux-gcc... no
checking for gcc... gcc
configure: WARNING: using cross tools not prefixed with host triplet
checking for C compiler default output file name... a.out
checking whether the C compiler works... yes
checking whether we are cross compiling... yes
checking for suffix of executables...
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether gcc accepts -g... yes
checking for gcc option to accept ISO C89... none needed
checking how to run the C preprocessor... gcc -E
checking target system type... arm-unknown-linux-gnu
checking for arm-linux-gcc... no
checking for gcc... gcc
checking whether we are using the GNU C compiler... (cached) yes
checking whether gcc accepts -g... no
checking for gcc option to accept ISO C89... (cached) none needed
checking how to run the C preprocessor... gcc -E
checking whether build environment is sane... yes
checking for arm-linux-strip... no
checking for strip... strip
checking for a thread-safe mkdir -p... /bin/mkdir -p
checking for gawk... gawk
checking whether make sets $(MAKE)... yes
checking for style of include used by make... GNU
checking dependency style of gcc... gcc3
checking whether to enable maintainer-specific portions of Makefiles... no
checking for a sed that does not truncate output... /bin/sed
checking for grep that handles long lines and -e... /bin/grep
checking for egrep... /bin/grep -E
checking for fgrep... /bin/grep -F
checking for ld used by gcc... /usr/bin/ld
checking if the linker (/usr/bin/ld) is GNU ld... yes
checking for BSD- or MS-compatible name lister (nm)... no
checking for arm-linux-dumpbin... no
checking for arm-linux-link... no
checking for dumpbin... no
checking for link... link -dump -symbols
checking the name lister (link -dump -symbols) interface... BSD nm
checking whether ln -s works... yes
checking the maximum length of command line arguments... 98304
checking whether the shell understands some XSI constructs... yes
checking whether the shell understands "+="... yes
checking for /usr/bin/ld option to reload object files... -r
checking how to recognize dependent libraries... pass_all
checking for arm-linux-ar... no
checking for ar... ar
checking for arm-linux-strip... strip
checking for arm-linux-ranlib... no
checking for ranlib... ranlib
checking command to parse link -dump -symbols output from gcc object...
failed
checking for ANSI C header files... yes
checking for sys/types.h... yes
checking for sys/stat.h... yes
checking for stdlib.h... yes
checking for string.h... yes
checking for memory.h... yes
checking for strings.h... yes
checking for inttypes.h... yes
checking for stdint.h... yes
checking for unistd.h... yes
checking for dlfcn.h... yes
checking for objdir... .libs
checking if gcc supports -fno-rtti -fno-exceptions... no
checking for gcc option to produce PIC... -fPIC -DPIC
checking if gcc PIC flag -fPIC -DPIC works... yes
checking if gcc static flag -static works... yes
checking if gcc supports -c -o file.o... yes
checking if gcc supports -c -o file.o... (cached) yes
checking whether the gcc linker (/usr/bin/ld) supports shared libraries...
yes
checking whether -lc should be explicitly linked in... no
checking dynamic linker characteristics... GNU/Linux ld.so
checking how to hardcode library paths into programs... immediate
checking whether stripping libraries is possible... yes
checking if libtool supports shared libraries... yes
checking whether to build shared libraries... yes
checking whether to build static libraries... yes
checking dependency style of gcc... gcc3
checking for flex... flex
checking lex output file root... lex.yy
checking lex library... -lfl
checking whether yytext is a pointer... yes
checking for target architecture... arm
checking for debug symbols... no
checking for SMP support... no
checking for ARM machine... generic
checking for ARM architecture version... 4
checking for ARM SA1100 architecture... y
checking for TSC emulation in user-space.... not supported by this board
checking for ARM EABI interface... no
checking whether building Linux in Xenomai build tree... no
checking for Doxygen documentation... no
checking for doxygen... doxygen
checking for dot... NO
checking whether compiling Docbook XML documentation... no
checking for xmllint... xmllint
checking for xsltproc... xsltproc
checking for fop... no
checking whether Docbook XML documentation generation can use network.... no
checking for docbook-xml root dir... network
checking for docbook-xsl root dir... network
checking whether using LaTeX non-stop mode... no
checking mqueue.h usability... yes
checking mqueue.h presence... yes
checking for mqueue.h... yes
checking for sched_setaffinity... ok
checking for specific GCC switches... done
checking whether ld supports @file... yes
checking whether the POSIX skin library automatically calls mlockall... no
checking whether the pSOS skin library automatically calls mlockall... no
checking whether the uITRON skin library automatically calls mlockall... no
checking for shm_open... yes
checking for shm_unlink... yes
checking for mmap64... yes
checking for ftruncate64... yes
configure: creating ./config.status
config.status: creating Makefile
config.status: creating config/Makefile
config.status: creating scripts/Makefile
config.status: creating scripts/xeno-config
config.status: creating scripts/xeno-load
config.status: creating scripts/xeno-test
config.status: creating src/Makefile
config.status: creating src/rtdk/Makefile
config.status: creating src/skins/Makefile
config.status: creating src/skins/posix/Makefile
config.status: creating src/skins/native/Makefile
config.status: creating src/skins/vxworks/Makefile
config.status: creating src/skins/psos+/Makefile
config.status: creating src/skins/vrtx/Makefile
config.status: creating src/skins/rtdm/Makefile
config.status: creating src/skins/rtai/Makefile
config.status: creating src/skins/uitron/Makefile
config.status: creating src/include/Makefile
config.status: creating src/testsuite/Makefile
config.status: creating src/testsuite/latency/Makefile
config.status: creating src/testsuite/switchbench/Makefile
config.status: creating src/testsuite/cyclic/Makefile
config.status: creating src/testsuite/switchtest/Makefile
config.status: creating src/testsuite/irqbench/Makefile
config.status: creating src/testsuite/clocktest/Makefile
config.status: creating src/testsuite/klatency/Makefile
config.status: creating src/utils/Makefile
config.status: creating src/utils/can/Makefile
config.status: creating include/Makefile
config.status: creating include/asm-generic/Makefile
config.status: creating include/asm-generic/bits/Makefile
config.status: creating include/asm-blackfin/Makefile
config.status: creating include/asm-blackfin/bits/Makefile
config.status: creating include/asm-x86/Makefile
config.status: creating include/asm-x86/bits/Makefile
config.status: creating include/asm-powerpc/Makefile
config.status: creating include/asm-powerpc/bits/Makefile
config.status: creating include/asm-ia64/Makefile
config.status: creating include/asm-ia64/bits/Makefile
config.status: creating include/asm-arm/Makefile
config.status: creating include/asm-arm/bits/Makefile
config.status: creating include/asm-sim/Makefile
config.status: creating include/asm-sim/bits/Makefile
config.status: creating include/native/Makefile
config.status: creating include/nucleus/Makefile
config.status: creating include/posix/Makefile
config.status: creating include/posix/sys/Makefile
config.status: creating include/psos+/Makefile
config.status: creating include/rtai/Makefile
config.status: creating include/rtdm/Makefile
config.status: creating include/uitron/Makefile
config.status: creating include/vrtx/Makefile
config.status: creating include/vxworks/Makefile
config.status: creating doc/Makefile
config.status: creating doc/txt/Makefile
config.status: creating doc/man/Makefile
config.status: creating doc/man/clocktest.man
config.status: creating doc/man/cyclictest.man
config.status: creating doc/man/irqbench.man
config.status: creating doc/man/irqloop.man
config.status: creating doc/man/klatency.man
config.status: creating doc/man/latency.man
config.status: creating doc/man/rtcanconfig.man
config.status: creating doc/man/rtcanrecv.man
config.status: creating doc/man/rtcansend.man
config.status: creating doc/man/switchbench.man
config.status: creating doc/man/switchtest.man
config.status: creating doc/man/runinfo.man
config.status: creating doc/man/xeno-config.man
config.status: creating doc/man/xeno-info.man
config.status: creating doc/man/xeno-load.man
config.status: creating doc/man/xeno-test.man
config.status: creating doc/doxygen/Makefile
config.status: creating doc/doxygen/Doxyfile-common
config.status: creating doc/doxygen/Doxyfile
config.status: creating doc/doxygen/Doxyfile-native
config.status: creating doc/doxygen/Doxyfile-nucleus
config.status: creating doc/doxygen/Doxyfile-posix
config.status: creating doc/doxygen/Doxyfile-rtdm
config.status: creating doc/docbook/Makefile
config.status: creating doc/docbook/catalog
config.status: creating doc/docbook/custom-stylesheets/Makefile
config.status: creating doc/docbook/custom-stylesheets/xsl/Makefile
config.status: creating doc/docbook/custom-stylesheets/xsl/common/Makefile
config.status: creating doc/docbook/custom-stylesheets/xsl/fo/Makefile
config.status: creating doc/docbook/custom-stylesheets/xsl/html/Makefile
config.status: creating doc/docbook/custom-stylesheets/xsl/html/chunk.xsl
config.status: creating doc/docbook/custom-stylesheets/xsl/html/onechunk.xsl
config.status: creating doc/docbook/xenomai/Makefile
config.status: creating src/include/xeno_config.h
config.status: linking
/home/d.sergey/xemomai/xenomai-2.4.9.1/include/asm-arm to
src/include/asm/xenomai
config.status: linking
/home/d.sergey/xemomai/xenomai-2.4.9.1/include/asm-generic to
src/include/asm-generic/xenomai
config.status: executing depfiles commands
config.status: executing libtool commands
====

But when I  do
8) $ make DESTDIR=/nfs/rootfs install
I have next messages:

=== LOG
[d.sergey@domain.hid build_root]$ make DESTDIR=/nfs/rootfs install
Making install in src
make[1]: Entering directory `/home/d.sergey/build_root/src'
Making install in include
make[2]: Entering directory `/home/d.sergey/build_root/src/include'
make[3]: Entering directory `/home/d.sergey/build_root/src/include'
make[3]: Nothing to be done for `install-exec-am'.
make[3]: Nothing to be done for `install-data-am'.
make[3]: Leaving directory `/home/d.sergey/build_root/src/include'
make[2]: Leaving directory `/home/d.sergey/build_root/src/include'
Making install in rtdk
make[2]: Entering directory `/home/d.sergey/build_root/src/rtdk'
/bin/sh ../../libtool  --tag=CC   --mode=compile gcc -DHAVE_CONFIG_H -I.
-I/home/d.sergey/xemomai/xenomai-2.4.9.1/src/rtdk -I../../src/include  -O2
-D_GNU_SOURCE -D_REENTRANT -Wall -pipe -march=armv4 -D__XENO__ -D__IN_XENO__
-Wstrict-prototypes -I/home/d.sergey/xemomai/xenomai-2.4.9.1/include    -MT
librtdk_la-init.lo -MD -MP -MF .deps/librtdk_la-init.Tpo -c -o
librtdk_la-init.lo `test -f 'init.c' || echo
'/home/d.sergey/xemomai/xenomai-2.4.9.1/src/rtdk/'`init.c
libtool: compile:  gcc -DHAVE_CONFIG_H -I.
-I/home/d.sergey/xemomai/xenomai-2.4.9.1/src/rtdk -I../../src/include -O2
-D_GNU_SOURCE -D_REENTRANT -Wall -pipe -march=armv4 -D__XENO__ -D__IN_XENO__
-Wstrict-prototypes -I/home/d.sergey/xemomai/xenomai-2.4.9.1/include -MT
librtdk_la-init.lo -MD -MP -MF .deps/librtdk_la-init.Tpo -c
/home/d.sergey/xemomai/xenomai-2.4.9.1/src/rtdk/init.c  -fPIC -DPIC -o
.libs/librtdk_la-init.o
/home/d.sergey/xemomai/xenomai-2.4.9.1/src/rtdk/init.c:1: error: bad value
(armv4) for -march= switch
/home/d.sergey/xemomai/xenomai-2.4.9.1/src/rtdk/init.c:1: error: bad value
(armv4) for -mtune= switch
make[2]: *** [librtdk_la-init.lo] Error 1
make[2]: Leaving directory `/home/d.sergey/build_root/src/rtdk'
make[1]: *** [install-recursive] Error 1
make[1]: Leaving directory `/home/d.sergey/build_root/src'
make: *** [install-recursive] Error 1
===

Gilles said: "Your problem here is that you are trying to use gcc (that is
probably an
x86 gcc) with options for an ARM gcc. It does not work. You have to
ensure that the build system uses your cross-compiler."

Which step is wrong? I have only one compiler (located in
/home/d.sergey/compiler/armel-2007q3-51)

Also could you please provide me with the steps how to run the xenomai tests
on my board?
"you can run latency test" is really not enough for me...

Sergey


2009/10/14 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

> Didenko Sergey wrote:
> > Dear Gilles
> >
> > when I did change the HW Timer interrupt number (__ipipe_mach_timerint)
> from
> > 0 to 1
> > Patched kernel is able to boot up...but I'm not sure whether Xenomai is
> > running or not even I can see the messages that it is started...
> > To verify whether it is running or not I want to do latency test ..for
> > that..I'm following the HOWTO which says that I have to
> > 1) configure Xenomai
> > $ ./configure --build=i686-pc-linux-gnu --host=arm-linux
> > --enable-arm-mach=generic --enable-arm-tsc
> >
> > 2) make Install
> > When I do "make DESTDIR=/nfs install" where /nfs - is the NFS path to
> rootfs
> > mounted by board.
> > I have next situation...
> >
> > ===
> >
> > [d.sergey@domain.hid xenomai-2.4.9.1]$ make DESTDIR=/nfs install
> > Making install in src
> > make[1]: Entering directory `/home/d.sergey/xemomai/xenomai-2.4.9.1/src'
> > Making install in include
> > make[2]: Entering directory
> > `/home/d.sergey/xemomai/xenomai-2.4.9.1/src/include'
> > make[3]: Entering directory
> > `/home/d.sergey/xemomai/xenomai-2.4.9.1/src/include'
> > make[3]: Nothing to be done for `install-exec-am'.
> > make[3]: Nothing to be done for `install-data-am'.
> > make[3]: Leaving directory
> > `/home/d.sergey/xemomai/xenomai-2.4.9.1/src/include'
> > make[2]: Leaving directory
> > `/home/d.sergey/xemomai/xenomai-2.4.9.1/src/include'
> > Making install in rtdk
> > make[2]: Entering directory
> > `/home/d.sergey/xemomai/xenomai-2.4.9.1/src/rtdk'
> > /bin/sh ../../libtool  --tag=CC   --mode=compile gcc -DHAVE_CONFIG_H -I.
> > -I../../src/include  -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe
> -march=armv4
> > -D__XENO__ -D__IN_XENO__ -Wstrict-prototypes -I../../include    -MT
> > librtdk_la-init.lo -MD -MP -MF .deps/librtdk_la-init.Tpo -c -o
> > librtdk_la-init.lo `test -f 'init.c' || echo './'`init.c
> > libtool: compile:  gcc -DHAVE_CONFIG_H -I. -I../../src/include -O2
> > -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -march=armv4 -D__XENO__
> -D__IN_XENO__
> > -Wstrict-prototypes -I../../include -MT librtdk_la-init.lo -MD -MP -MF
> > .deps/librtdk_la-init.Tpo -c init.c  -fPIC -DPIC -o
> .libs/librtdk_la-init.o
> > init.c:1: error: bad value (armv4) for -march= switch
> > init.c:1: error: bad value (armv4) for -mtune= switch
> > make[2]: *** [librtdk_la-init.lo] Error 1
> > make[2]: Leaving directory
> `/home/d.sergey/xemomai/xenomai-2.4.9.1/src/rtdk'
> > make[1]: *** [install-recursive] Error 1
> > make[1]: Leaving directory `/home/d.sergey/xemomai/xenomai-2.4.9.1/src'
> > make: *** [install-recursive] Error 1
> > [d.sergey@domain.hid xenomai-2.4.9.1]$
>
> Your problem here is that you are trying to use gcc (that is probably an
> x86 gcc) with options for an ARM gcc. It does not work. You have to
> ensure that the build system uses your cross-compiler.
>
> >
> > ====
> >
> > What is wrong?
> > How can I patch the rootfs with Xenomai libraries correctly?
>
> I have no idea. But I can tell you that you do not need to patch
> anything. It should work out of the box.
>
> --
>                                             Gilles.
>

--000e0cd328121daf35047606a3b9
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

In my case the paths are like:<br># $linux_tree =3D /home/d.sergey/kernel/l=
inux-2.6.29-v02.00.29<br># $xenomai_root =3D /home/d.sergey/xemomai/xenomai=
-2.4.9.1<br># $build_root =3D /home/d.sergey/build_root<br># $staging_dir =
=3D /nfs/rootfs<br>
CROSS_COMPILE - arm-none-linux-gnueabi<br><br>So, I do<br><br>1) $ $xenomai=
_root/scripts/prepare-kernel.sh --arch=3Darm=C2=A0 --linux=3D$linux_tree EN=
TER<br>I=C2=A0 omitt --adeos parameter and the script suggests an appropria=
te one, ENTER<br>
<br>2) Apply patch from Jorge and fix some compilation errors<br>3) $ cd $l=
inux_tree<br>4) $ make ARCH=3Darm CROSS_COMPILE=3Darm-none-linux-gnueabi- O=
=3D/home/d.sergey/build_root cosmos_mono_defconfig -j5<br>5) $ make ARCH=3D=
arm CROSS_COMPILE=3Darm-none-linux-gnueabi- O=3D/home/d.sergey/build_root b=
zImage modules -j5<br>
6) $ cd=C2=A0 $build_root<br>7) $ /home/d.sergey/xemomai/xenomai-2.4.9.1/co=
nfigure --build=3Di686-pc-linux-gnu --host=3Darm-linux --enable-arm-mach=3D=
generic --enable-arm-tsc<br>so far everything looks good<br>=3D=3D=3D=3D LO=
G<br><br>checking build system type... i686-pc-linux-gnu<br>
checking host system type... arm-unknown-linux-gnu<br>checking for a BSD-co=
mpatible install... /usr/bin/install -c<br>checking for arm-linux-gcc... no=
<br>checking for gcc... gcc<br>configure: WARNING: using cross tools not pr=
efixed with host triplet<br>
checking for C compiler default output file name... a.out<br>checking wheth=
er the C compiler works... yes<br>checking whether we are cross compiling..=
. yes<br>checking for suffix of executables... <br>checking for suffix of o=
bject files... o<br>
checking whether we are using the GNU C compiler... yes<br>checking whether=
 gcc accepts -g... yes<br>checking for gcc option to accept ISO C89... none=
 needed<br>checking how to run the C preprocessor... gcc -E<br>checking tar=
get system type... arm-unknown-linux-gnu<br>
checking for arm-linux-gcc... no<br>checking for gcc... gcc<br>checking whe=
ther we are using the GNU C compiler... (cached) yes<br>checking whether gc=
c accepts -g... no<br>checking for gcc option to accept ISO C89... (cached)=
 none needed<br>
checking how to run the C preprocessor... gcc -E<br>checking whether build =
environment is sane... yes<br>checking for arm-linux-strip... no<br>checkin=
g for strip... strip<br>checking for a thread-safe mkdir -p... /bin/mkdir -=
p<br>
checking for gawk... gawk<br>checking whether make sets $(MAKE)... yes<br>c=
hecking for style of include used by make... GNU<br>checking dependency sty=
le of gcc... gcc3<br>checking whether to enable maintainer-specific portion=
s of Makefiles... no<br>
checking for a sed that does not truncate output... /bin/sed<br>checking fo=
r grep that handles long lines and -e... /bin/grep<br>checking for egrep...=
 /bin/grep -E<br>checking for fgrep... /bin/grep -F<br>checking for ld used=
 by gcc... /usr/bin/ld<br>
checking if the linker (/usr/bin/ld) is GNU ld... yes<br>checking for BSD- =
or MS-compatible name lister (nm)... no<br>checking for arm-linux-dumpbin..=
. no<br>checking for arm-linux-link... no<br>checking for dumpbin... no<br>
checking for link... link -dump -symbols<br>checking the name lister (link =
-dump -symbols) interface... BSD nm<br>checking whether ln -s works... yes<=
br>checking the maximum length of command line arguments... 98304<br>checki=
ng whether the shell understands some XSI constructs... yes<br>
checking whether the shell understands &quot;+=3D&quot;... yes<br>checking =
for /usr/bin/ld option to reload object files... -r<br>checking how to reco=
gnize dependent libraries... pass_all<br>checking for arm-linux-ar... no<br=
>
checking for ar... ar<br>checking for arm-linux-strip... strip<br>checking =
for arm-linux-ranlib... no<br>checking for ranlib... ranlib<br>checking com=
mand to parse link -dump -symbols output from gcc object... failed<br>check=
ing for ANSI C header files... yes<br>
checking for sys/types.h... yes<br>checking for sys/stat.h... yes<br>checki=
ng for stdlib.h... yes<br>checking for string.h... yes<br>checking for memo=
ry.h... yes<br>checking for strings.h... yes<br>checking for inttypes.h... =
yes<br>
checking for stdint.h... yes<br>checking for unistd.h... yes<br>checking fo=
r dlfcn.h... yes<br>checking for objdir... .libs<br>checking if gcc support=
s -fno-rtti -fno-exceptions... no<br>checking for gcc option to produce PIC=
... -fPIC -DPIC<br>
checking if gcc PIC flag -fPIC -DPIC works... yes<br>checking if gcc static=
 flag -static works... yes<br>checking if gcc supports -c -o file.o... yes<=
br>checking if gcc supports -c -o file.o... (cached) yes<br>checking whethe=
r the gcc linker (/usr/bin/ld) supports shared libraries... yes<br>
checking whether -lc should be explicitly linked in... no<br>checking dynam=
ic linker characteristics... GNU/Linux ld.so<br>checking how to hardcode li=
brary paths into programs... immediate<br>checking whether stripping librar=
ies is possible... yes<br>
checking if libtool supports shared libraries... yes<br>checking whether to=
 build shared libraries... yes<br>checking whether to build static librarie=
s... yes<br>checking dependency style of gcc... gcc3<br>checking for flex..=
. flex<br>
checking lex output file root... lex.yy<br>checking lex library... -lfl<br>=
checking whether yytext is a pointer... yes<br>checking for target architec=
ture... arm<br>checking for debug symbols... no<br>checking for SMP support=
... no<br>
checking for ARM machine... generic<br>checking for ARM architecture versio=
n... 4<br>checking for ARM SA1100 architecture... y<br>checking for TSC emu=
lation in user-space.... not supported by this board<br>checking for ARM EA=
BI interface... no<br>
checking whether building Linux in Xenomai build tree... no<br>checking for=
 Doxygen documentation... no<br>checking for doxygen... doxygen<br>checking=
 for dot... NO<br>checking whether compiling Docbook XML documentation... n=
o<br>
checking for xmllint... xmllint<br>checking for xsltproc... xsltproc<br>che=
cking for fop... no<br>checking whether Docbook XML documentation generatio=
n can use network.... no<br>checking for docbook-xml root dir... network<br=
>
checking for docbook-xsl root dir... network<br>checking whether using LaTe=
X non-stop mode... no<br>checking mqueue.h usability... yes<br>checking mqu=
eue.h presence... yes<br>checking for mqueue.h... yes<br>checking for sched=
_setaffinity... ok<br>
checking for specific GCC switches... done<br>checking whether ld supports =
@file... yes<br>checking whether the POSIX skin library automatically calls=
 mlockall... no<br>checking whether the pSOS skin library automatically cal=
ls mlockall... no<br>
checking whether the uITRON skin library automatically calls mlockall... no=
<br>checking for shm_open... yes<br>checking for shm_unlink... yes<br>check=
ing for mmap64... yes<br>checking for ftruncate64... yes<br>configure: crea=
ting ./config.status<br>
config.status: creating Makefile<br>config.status: creating config/Makefile=
<br>config.status: creating scripts/Makefile<br>config.status: creating scr=
ipts/xeno-config<br>config.status: creating scripts/xeno-load<br>config.sta=
tus: creating scripts/xeno-test<br>
config.status: creating src/Makefile<br>config.status: creating src/rtdk/Ma=
kefile<br>config.status: creating src/skins/Makefile<br>config.status: crea=
ting src/skins/posix/Makefile<br>config.status: creating src/skins/native/M=
akefile<br>
config.status: creating src/skins/vxworks/Makefile<br>config.status: creati=
ng src/skins/psos+/Makefile<br>config.status: creating src/skins/vrtx/Makef=
ile<br>config.status: creating src/skins/rtdm/Makefile<br>config.status: cr=
eating src/skins/rtai/Makefile<br>
config.status: creating src/skins/uitron/Makefile<br>config.status: creatin=
g src/include/Makefile<br>config.status: creating src/testsuite/Makefile<br=
>config.status: creating src/testsuite/latency/Makefile<br>config.status: c=
reating src/testsuite/switchbench/Makefile<br>
config.status: creating src/testsuite/cyclic/Makefile<br>config.status: cre=
ating src/testsuite/switchtest/Makefile<br>config.status: creating src/test=
suite/irqbench/Makefile<br>config.status: creating src/testsuite/clocktest/=
Makefile<br>
config.status: creating src/testsuite/klatency/Makefile<br>config.status: c=
reating src/utils/Makefile<br>config.status: creating src/utils/can/Makefil=
e<br>config.status: creating include/Makefile<br>config.status: creating in=
clude/asm-generic/Makefile<br>
config.status: creating include/asm-generic/bits/Makefile<br>config.status:=
 creating include/asm-blackfin/Makefile<br>config.status: creating include/=
asm-blackfin/bits/Makefile<br>config.status: creating include/asm-x86/Makef=
ile<br>
config.status: creating include/asm-x86/bits/Makefile<br>config.status: cre=
ating include/asm-powerpc/Makefile<br>config.status: creating include/asm-p=
owerpc/bits/Makefile<br>config.status: creating include/asm-ia64/Makefile<b=
r>
config.status: creating include/asm-ia64/bits/Makefile<br>config.status: cr=
eating include/asm-arm/Makefile<br>config.status: creating include/asm-arm/=
bits/Makefile<br>config.status: creating include/asm-sim/Makefile<br>config=
.status: creating include/asm-sim/bits/Makefile<br>
config.status: creating include/native/Makefile<br>config.status: creating =
include/nucleus/Makefile<br>config.status: creating include/posix/Makefile<=
br>config.status: creating include/posix/sys/Makefile<br>config.status: cre=
ating include/psos+/Makefile<br>
config.status: creating include/rtai/Makefile<br>config.status: creating in=
clude/rtdm/Makefile<br>config.status: creating include/uitron/Makefile<br>c=
onfig.status: creating include/vrtx/Makefile<br>config.status: creating inc=
lude/vxworks/Makefile<br>
config.status: creating doc/Makefile<br>config.status: creating doc/txt/Mak=
efile<br>config.status: creating doc/man/Makefile<br>config.status: creatin=
g doc/man/clocktest.man<br>config.status: creating doc/man/cyclictest.man<b=
r>
config.status: creating doc/man/irqbench.man<br>config.status: creating doc=
/man/irqloop.man<br>config.status: creating doc/man/klatency.man<br>config.=
status: creating doc/man/latency.man<br>config.status: creating doc/man/rtc=
anconfig.man<br>
config.status: creating doc/man/rtcanrecv.man<br>config.status: creating do=
c/man/rtcansend.man<br>config.status: creating doc/man/switchbench.man<br>c=
onfig.status: creating doc/man/switchtest.man<br>config.status: creating do=
c/man/runinfo.man<br>
config.status: creating doc/man/xeno-config.man<br>config.status: creating =
doc/man/xeno-info.man<br>config.status: creating doc/man/xeno-load.man<br>c=
onfig.status: creating doc/man/xeno-test.man<br>config.status: creating doc=
/doxygen/Makefile<br>
config.status: creating doc/doxygen/Doxyfile-common<br>config.status: creat=
ing doc/doxygen/Doxyfile<br>config.status: creating doc/doxygen/Doxyfile-na=
tive<br>config.status: creating doc/doxygen/Doxyfile-nucleus<br>config.stat=
us: creating doc/doxygen/Doxyfile-posix<br>
config.status: creating doc/doxygen/Doxyfile-rtdm<br>config.status: creatin=
g doc/docbook/Makefile<br>config.status: creating doc/docbook/catalog<br>co=
nfig.status: creating doc/docbook/custom-stylesheets/Makefile<br>config.sta=
tus: creating doc/docbook/custom-stylesheets/xsl/Makefile<br>
config.status: creating doc/docbook/custom-stylesheets/xsl/common/Makefile<=
br>config.status: creating doc/docbook/custom-stylesheets/xsl/fo/Makefile<b=
r>config.status: creating doc/docbook/custom-stylesheets/xsl/html/Makefile<=
br>
config.status: creating doc/docbook/custom-stylesheets/xsl/html/chunk.xsl<b=
r>config.status: creating doc/docbook/custom-stylesheets/xsl/html/onechunk.=
xsl<br>config.status: creating doc/docbook/xenomai/Makefile<br>config.statu=
s: creating src/include/xeno_config.h<br>
config.status: linking /home/d.sergey/xemomai/xenomai-2.4.9.1/include/asm-a=
rm to src/include/asm/xenomai<br>config.status: linking /home/d.sergey/xemo=
mai/xenomai-2.4.9.1/include/asm-generic to src/include/asm-generic/xenomai<=
br>
config.status: executing depfiles commands<br>config.status: executing libt=
ool commands<br>=3D=3D=3D=3D<br><br>But when I=C2=A0 do<br>8) $ make DESTDI=
R=3D/nfs/rootfs install<br>I have next messages:<br><br>=3D=3D=3D LOG<br>[d=
.sergey@domain.hid build_root]$ make DESTDIR=3D/nfs/rootfs install<br>
Making install in src<br>make[1]: Entering directory `/home/d.sergey/build_=
root/src&#39;<br>Making install in include<br>make[2]: Entering directory `=
/home/d.sergey/build_root/src/include&#39;<br>make[3]: Entering directory `=
/home/d.sergey/build_root/src/include&#39;<br>
make[3]: Nothing to be done for `install-exec-am&#39;.<br>make[3]: Nothing =
to be done for `install-data-am&#39;.<br>make[3]: Leaving directory `/home/=
d.sergey/build_root/src/include&#39;<br>make[2]: Leaving directory `/home/d=
.sergey/build_root/src/include&#39;<br>
Making install in rtdk<br>make[2]: Entering directory `/home/d.sergey/build=
_root/src/rtdk&#39;<br>/bin/sh ../../libtool=C2=A0 --tag=3DCC=C2=A0=C2=A0 -=
-mode=3Dcompile gcc -DHAVE_CONFIG_H -I. -I/home/d.sergey/xemomai/xenomai-2.=
4.9.1/src/rtdk -I../../src/include=C2=A0 -O2 -D_GNU_SOURCE -D_REENTRANT -Wa=
ll -pipe -march=3Darmv4 -D__XENO__ -D__IN_XENO__ -Wstrict-prototypes -I/hom=
e/d.sergey/xemomai/xenomai-2.4.9.1/include=C2=A0=C2=A0=C2=A0 -MT librtdk_la=
-init.lo -MD -MP -MF .deps/librtdk_la-init.Tpo -c -o librtdk_la-init.lo `te=
st -f &#39;init.c&#39; || echo &#39;/home/d.sergey/xemomai/xenomai-2.4.9.1/=
src/rtdk/&#39;`init.c<br>
libtool: compile:=C2=A0 gcc -DHAVE_CONFIG_H -I. -I/home/d.sergey/xemomai/xe=
nomai-2.4.9.1/src/rtdk -I../../src/include -O2 -D_GNU_SOURCE -D_REENTRANT -=
Wall -pipe -march=3Darmv4 -D__XENO__ -D__IN_XENO__ -Wstrict-prototypes -I/h=
ome/d.sergey/xemomai/xenomai-2.4.9.1/include -MT librtdk_la-init.lo -MD -MP=
 -MF .deps/librtdk_la-init.Tpo -c /home/d.sergey/xemomai/xenomai-2.4.9.1/sr=
c/rtdk/init.c=C2=A0 -fPIC -DPIC -o .libs/librtdk_la-init.o<br>
/home/d.sergey/xemomai/xenomai-2.4.9.1/src/rtdk/init.c:1: error: bad value =
(armv4) for -march=3D switch<br>/home/d.sergey/xemomai/xenomai-2.4.9.1/src/=
rtdk/init.c:1: error: bad value (armv4) for -mtune=3D switch<br>make[2]: **=
* [librtdk_la-init.lo] Error 1<br>
make[2]: Leaving directory `/home/d.sergey/build_root/src/rtdk&#39;<br>make=
[1]: *** [install-recursive] Error 1<br>make[1]: Leaving directory `/home/d=
.sergey/build_root/src&#39;<br>make: *** [install-recursive] Error 1<br>
=3D=3D=3D<br><br>Gilles said: &quot;Your problem here is that you are tryin=
g to use gcc (that is probably an<br>
x86 gcc) with options for an ARM gcc. It does not work. You have to<br>
ensure that the build system uses your cross-compiler.&quot;<br><br>Which s=
tep is wrong? I have only one compiler (located in /home/d.sergey/compiler/=
armel-2007q3-51)<br><br>Also could you please provide me with the steps how=
 to run the xenomai tests on my board?<br>
&quot;you can run latency test&quot; is really not enough for me...<br><br>=
Sergey<br><br><br><div class=3D"gmail_quote">2009/10/14 Gilles Chanteperdri=
x <span dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org"=
>gilles.chanteperdrix@xenomai.org</a>&gt;</span><br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div><div></div><=
div class=3D"h5">Didenko Sergey wrote:<br>
&gt; Dear Gilles<br>
&gt;<br>
&gt; when I did change the HW Timer interrupt number (__ipipe_mach_timerint=
) from<br>
&gt; 0 to 1<br>
&gt; Patched kernel is able to boot up...but I&#39;m not sure whether Xenom=
ai is<br>
&gt; running or not even I can see the messages that it is started...<br>
&gt; To verify whether it is running or not I want to do latency test ..for=
<br>
&gt; that..I&#39;m following the HOWTO which says that I have to<br>
&gt; 1) configure Xenomai<br>
&gt; $ ./configure --build=3Di686-pc-linux-gnu --host=3Darm-linux<br>
&gt; --enable-arm-mach=3Dgeneric --enable-arm-tsc<br>
&gt;<br>
&gt; 2) make Install<br>
&gt; When I do &quot;make DESTDIR=3D/nfs install&quot; where /nfs - is the =
NFS path to rootfs<br>
&gt; mounted by board.<br>
&gt; I have next situation...<br>
&gt;<br>
&gt; =3D=3D=3D<br>
&gt;<br>
&gt; [d.sergey@domain.hid xenomai-2.4.9.1]$ make DESTDIR=3D/nfs install<br>
&gt; Making install in src<br>
&gt; make[1]: Entering directory `/home/d.sergey/xemomai/xenomai-2.4.9.1/sr=
c&#39;<br>
&gt; Making install in include<br>
&gt; make[2]: Entering directory<br>
&gt; `/home/d.sergey/xemomai/xenomai-2.4.9.1/src/include&#39;<br>
&gt; make[3]: Entering directory<br>
&gt; `/home/d.sergey/xemomai/xenomai-2.4.9.1/src/include&#39;<br>
&gt; make[3]: Nothing to be done for `install-exec-am&#39;.<br>
&gt; make[3]: Nothing to be done for `install-data-am&#39;.<br>
&gt; make[3]: Leaving directory<br>
&gt; `/home/d.sergey/xemomai/xenomai-2.4.9.1/src/include&#39;<br>
&gt; make[2]: Leaving directory<br>
&gt; `/home/d.sergey/xemomai/xenomai-2.4.9.1/src/include&#39;<br>
&gt; Making install in rtdk<br>
&gt; make[2]: Entering directory<br>
&gt; `/home/d.sergey/xemomai/xenomai-2.4.9.1/src/rtdk&#39;<br>
&gt; /bin/sh ../../libtool =C2=A0--tag=3DCC =C2=A0 --mode=3Dcompile gcc -DH=
AVE_CONFIG_H -I.<br>
&gt; -I../../src/include =C2=A0-O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -=
march=3Darmv4<br>
&gt; -D__XENO__ -D__IN_XENO__ -Wstrict-prototypes -I../../include =C2=A0 =
=C2=A0-MT<br>
&gt; librtdk_la-init.lo -MD -MP -MF .deps/librtdk_la-init.Tpo -c -o<br>
&gt; librtdk_la-init.lo `test -f &#39;init.c&#39; || echo &#39;./&#39;`init=
.c<br>
&gt; libtool: compile: =C2=A0gcc -DHAVE_CONFIG_H -I. -I../../src/include -O=
2<br>
&gt; -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -march=3Darmv4 -D__XENO__ -D__I=
N_XENO__<br>
&gt; -Wstrict-prototypes -I../../include -MT librtdk_la-init.lo -MD -MP -MF=
<br>
&gt; .deps/librtdk_la-init.Tpo -c init.c =C2=A0-fPIC -DPIC -o .libs/librtdk=
_la-init.o<br>
&gt; init.c:1: error: bad value (armv4) for -march=3D switch<br>
&gt; init.c:1: error: bad value (armv4) for -mtune=3D switch<br>
&gt; make[2]: *** [librtdk_la-init.lo] Error 1<br>
&gt; make[2]: Leaving directory `/home/d.sergey/xemomai/xenomai-2.4.9.1/src=
/rtdk&#39;<br>
&gt; make[1]: *** [install-recursive] Error 1<br>
&gt; make[1]: Leaving directory `/home/d.sergey/xemomai/xenomai-2.4.9.1/src=
&#39;<br>
&gt; make: *** [install-recursive] Error 1<br>
&gt; [d.sergey@domain.hid xenomai-2.4.9.1]$<br>
<br>
</div></div>Your problem here is that you are trying to use gcc (that is pr=
obably an<br>
x86 gcc) with options for an ARM gcc. It does not work. You have to<br>
ensure that the build system uses your cross-compiler.<br>
<div class=3D"im"><br>
&gt;<br>
&gt; =3D=3D=3D=3D<br>
&gt;<br>
&gt; What is wrong?<br>
&gt; How can I patch the rootfs with Xenomai libraries correctly?<br>
<br>
</div>I have no idea. But I can tell you that you do not need to patch<br>
anything. It should work out of the box.<br>
<br>
--<br>
<font color=3D"#888888"> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Gilles.<br>
</font></blockquote></div><br>

--000e0cd328121daf35047606a3b9--

