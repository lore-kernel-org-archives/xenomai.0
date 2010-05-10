Message-ID: <SNT119-W55D22350A5B495E79B9B80B0F90@domain.hid>
Content-Type: multipart/alternative;
	boundary="_c57eb18a-e061-4b31-8c1d-0f8b93dd4ddd_"
From: federico lolli <federicololli@domain.hid>
Date: Mon, 10 May 2010 14:15:32 +0200
MIME-Version: 1.0
Subject: [Xenomai-help] Xenomai for arm:error header files
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

--_c57eb18a-e061-4b31-8c1d-0f8b93dd4ddd_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable


Hi=2C
I would like to compile Xenomai for arm.
processor is: at91sam9g20 -> at91sam9.
the compiler is emdebian=2C arm-linux-gnueabi-gcc
 but I get the following errors in the compilation:

fede@domain.hid$ sudo ./configure --build=3D=
i686-pc-linux-gnueabi --host=3Darm-linux-gnueabi --enable-arm-mach=3Dat91sa=
m9=20
checking build system type... i686-pc-linux-gnueabi
checking host system type... arm-unknown-linux-gnueabi
checking for a BSD-compatible install... /usr/bin/install -c
checking for arm-linux-gnueabi-gcc... arm-linux-gnueabi-gcc
checking whether the C compiler works... yes
checking for C compiler default output file name... a.out
checking for suffix of executables...=20
checking whether we are cross compiling... yes
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether arm-linux-gnueabi-gcc accepts -g... yes
checking for arm-linux-gnueabi-gcc option to accept ISO C89... none needed
checking how to run the C preprocessor... /lib/cpp
checking target system type... arm-unknown-linux-gnueabi
checking for arm-linux-gnueabi-gcc... arm-linux-gnueabi-gcc
checking whether we are using the GNU C compiler... (cached) yes
checking whether arm-linux-gnueabi-gcc accepts -g... yes
checking for arm-linux-gnueabi-gcc option to accept ISO C89... (cached) non=
e needed
checking how to run the C preprocessor... arm-linux-gnueabi-gcc -E
checking whether build environment is sane... yes
checking for a thread-safe mkdir -p... /bin/mkdir -p
checking for gawk... gawk
checking whether make sets $(MAKE)... yes
checking for style of include used by make... GNU
checking for arm-linux-gnueabi-strip... arm-linux-gnueabi-strip
checking dependency style of arm-linux-gnueabi-gcc... gcc3
checking whether to enable maintainer-specific portions of Makefiles... no
checking dependency style of arm-linux-gnueabi-gcc... gcc3
checking for flex... flex
checking lex output file root... lex.yy
checking lex library... none needed
checking whether yytext is a pointer... no
checking for target architecture... arm
checking for a sed that does not truncate output... /bin/sed
checking for grep that handles long lines and -e... /bin/grep
checking for egrep... /bin/grep -E
checking for fgrep... /bin/grep -F
checking for ld used by arm-linux-gnueabi-gcc... /usr/arm-linux-gnueabi/bin=
/ld
checking if the linker (/usr/arm-linux-gnueabi/bin/ld) is GNU ld... yes
checking for BSD- or MS-compatible name lister (nm)... /usr/bin/arm-linux-g=
nueabi-nm -B
checking the name lister (/usr/bin/arm-linux-gnueabi-nm -B) interface... BS=
D nm
checking whether ln -s works... yes
checking the maximum length of command line arguments... 1572864
checking whether the shell understands some XSI constructs... yes
checking whether the shell understands "+=3D"... yes
checking for /usr/arm-linux-gnueabi/bin/ld option to reload object files...=
 -r
checking how to recognize dependent libraries... pass_all
checking for arm-linux-gnueabi-ar... arm-linux-gnueabi-ar
checking for arm-linux-gnueabi-strip... (cached) arm-linux-gnueabi-strip
checking for arm-linux-gnueabi-ranlib... arm-linux-gnueabi-ranlib
checking command to parse /usr/bin/arm-linux-gnueabi-nm -B output from arm-=
linux-gnueabi-gcc object... ok
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
checking if arm-linux-gnueabi-gcc supports -fno-rtti -fno-exceptions... no
checking for arm-linux-gnueabi-gcc option to produce PIC... -fPIC -DPIC
checking if arm-linux-gnueabi-gcc PIC flag -fPIC -DPIC works... yes
checking if arm-linux-gnueabi-gcc static flag -static works... yes
checking if arm-linux-gnueabi-gcc supports -c -o file.o... yes
checking if arm-linux-gnueabi-gcc supports -c -o file.o... (cached) yes
checking whether the arm-linux-gnueabi-gcc linker (/usr/arm-linux-gnueabi/b=
in/ld) supports shared libraries... yes
checking whether -lc should be explicitly linked in... no
checking dynamic linker characteristics... GNU/Linux ld.so
checking how to hardcode library paths into programs... immediate
checking whether stripping libraries is possible... yes
checking if libtool supports shared libraries... yes
checking whether to build shared libraries... yes
checking whether to build static libraries... yes
checking for debug symbols... no
checking for SMP support... no
checking for ARM machine... at91sam9
checking for ARM architecture version... 5
checking for ARM SA1100 architecture... no
checking for ARM Xscale3 architecture... no
checking for TSC emulation in user-space.... yes
checking for ARM EABI interface... no
checking whether building Linux in Xenomai build tree... no
checking for Doxygen documentation... no
checking for doxygen... no
checking for dot... NO
checking whether compiling Docbook XML documentation... no
checking for xmllint... xmllint
checking for xsltproc... xsltproc
checking for fop... no
checking whether Docbook XML documentation generation can use network.... n=
o
checking for docbook-xml root dir... /usr/share/sgml/docbook/dtd/xml/4.2
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
checking for shm_open... no
checking for shm_unlink... no
checking for mmap64... no
checking for ftruncate64... no
checking for pthread_mutexattr_setprotocol... no
checking for pthread_condattr_setclock... no
checking for pthread_spin_lock... no
checking whether to enable dlopen support for skin libraries... no
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
config.status: creating src/skins/common/Makefile
config.status: creating src/skins/posix/Makefile
config.status: creating src/skins/native/Makefile
config.status: creating src/skins/vxworks/Makefile
config.status: creating src/skins/psos+/Makefile
config.status: creating src/skins/vrtx/Makefile
config.status: creating src/skins/rtdm/Makefile
config.status: creating src/skins/rtai/Makefile
config.status: creating src/skins/uitron/Makefile
config.status: creating src/drvlib/Makefile
config.status: creating src/drvlib/analogy/Makefile
config.status: creating src/include/Makefile
config.status: creating src/testsuite/Makefile
config.status: creating src/testsuite/latency/Makefile
config.status: creating src/testsuite/cyclic/Makefile
config.status: creating src/testsuite/switchtest/Makefile
config.status: creating src/testsuite/irqbench/Makefile
config.status: creating src/testsuite/clocktest/Makefile
config.status: creating src/testsuite/klatency/Makefile
config.status: creating src/testsuite/unit/Makefile
config.status: creating src/testsuite/sigtest/Makefile
config.status: creating src/utils/Makefile
config.status: creating src/utils/can/Makefile
config.status: creating src/utils/analogy/Makefile
config.status: creating src/utils/ps/Makefile
config.status: creating include/Makefile
config.status: creating include/asm-generic/Makefile
config.status: creating include/asm-generic/bits/Makefile
config.status: creating include/asm-blackfin/Makefile
config.status: creating include/asm-blackfin/bits/Makefile
config.status: creating include/asm-x86/Makefile
config.status: creating include/asm-x86/bits/Makefile
config.status: creating include/asm-powerpc/Makefile
config.status: creating include/asm-powerpc/bits/Makefile
config.status: creating include/asm-arm/Makefile
config.status: creating include/asm-arm/bits/Makefile
config.status: creating include/asm-nios2/Makefile
config.status: creating include/asm-nios2/bits/Makefile
config.status: creating include/asm-sim/Makefile
config.status: creating include/asm-sim/bits/Makefile
config.status: creating include/native/Makefile
config.status: creating include/nucleus/Makefile
config.status: creating include/posix/Makefile
config.status: creating include/posix/sys/Makefile
config.status: creating include/psos+/Makefile
config.status: creating include/rtai/Makefile
config.status: creating include/rtdm/Makefile
config.status: creating include/analogy/Makefile
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
config.status: creating doc/docbook/custom-stylesheets/xsl/html/onechunk.xs=
l
config.status: creating doc/docbook/xenomai/Makefile
config.status: creating src/include/xeno_config.h
config.status: linking ./include/asm-arm to src/include/asm/xenomai
config.status: linking ./include/asm-generic to src/include/asm-generic/xen=
omai
config.status: executing depfiles commands
config.status: executing libtool commands




fede@domain.hid$ sudo make DESTDIR=3D/home/f=
ede/foxg20/lll installMaking install in src
make[1]: Entering directory `/home/fede/foxg20/kernel/xenomai-2.5.1/src'
Making install in include
make[2]: Entering directory `/home/fede/foxg20/kernel/xenomai-2.5.1/src/inc=
lude'
make[3]: Entering directory `/home/fede/foxg20/kernel/xenomai-2.5.1/src/inc=
lude'
make[3]: Nothing to be done for `install-exec-am'.
make[3]: Nothing to be done for `install-data-am'.
make[3]: Leaving directory `/home/fede/foxg20/kernel/xenomai-2.5.1/src/incl=
ude'
make[2]: Leaving directory `/home/fede/foxg20/kernel/xenomai-2.5.1/src/incl=
ude'
Making install in rtdk
make[2]: Entering directory `/home/fede/foxg20/kernel/xenomai-2.5.1/src/rtd=
k'
/bin/sh ../../libtool --tag=3DCC   --mode=3Dcompile arm-linux-gnueabi-gcc -=
DHAVE_CONFIG_H -I. -I../../src/include  -O2 -D_GNU_SOURCE -D_REENTRANT -Wal=
l -pipe -march=3Darmv5 -D__XENO__ -D__IN_XENO__ -Wstrict-prototypes -I../..=
/include    -MT librtdk_la-rt_print.lo -MD -MP -MF .deps/librtdk_la-rt_prin=
t.Tpo -c -o librtdk_la-rt_print.lo `test -f 'rt_print.c' || echo './'`rt_pr=
int.c
libtool: compile:  arm-linux-gnueabi-gcc -DHAVE_CONFIG_H -I. -I../../src/in=
clude -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -march=3Darmv5 -D__XENO__ =
-D__IN_XENO__ -Wstrict-prototypes -I../../include -MT librtdk_la-rt_print.l=
o -MD -MP -MF .deps/librtdk_la-rt_print.Tpo -c rt_print.c  -fPIC -DPIC -o .=
libs/librtdk_la-rt_print.o
rt_print.c:1: warning: target CPU does not support interworking
In file included from /usr/arm-linux-gnueabi/include/errno.h:36=2C
                 from rt_print.c:19:
/usr/arm-linux-gnueabi/include/bits/errno.h:25:26: error: linux/errno.h: No=
 such file or directory
In file included from /usr/arm-linux-gnueabi/include/bits/posix1_lim.h:153=
=2C
                 from /usr/arm-linux-gnueabi/include/limits.h:145=2C
                 from /usr/lib/gcc/arm-linux-gnueabi/4.3.2/include-fixed/li=
mits.h:122=2C
                 from /usr/lib/gcc/arm-linux-gnueabi/4.3.2/include-fixed/sy=
slimits.h:7=2C
                 from /usr/lib/gcc/arm-linux-gnueabi/4.3.2/include-fixed/li=
mits.h:11=2C
                 from rt_print.c:21:
/usr/arm-linux-gnueabi/include/bits/local_lim.h:36:26: error: linux/limits.=
h: No such file or directory
In file included from ../../src/include/asm/xenomai/system.h:223=2C
                 from rt_print.c:31:
../../include/nucleus/system.h:25:23: error: asm/param.h: No such file or d=
irectory
In file included from /usr/arm-linux-gnueabi/include/signal.h:333=2C
                 from ../../src/include/asm-generic/xenomai/syscall.h:32=2C
                 from ../../src/include/asm/xenomai/syscall.h:29=2C
                 from ../../src/include/asm/xenomai/atomic.h:82=2C
                 from ../../include/nucleus/system.h:26=2C
                 from ../../src/include/asm/xenomai/system.h:223=2C
                 from rt_print.c:31:
/usr/arm-linux-gnueabi/include/bits/sigcontext.h:28:29: error: asm/sigconte=
xt.h: No such file or directory
In file included from /usr/arm-linux-gnueabi/include/signal.h:353=2C
                 from ../../src/include/asm-generic/xenomai/syscall.h:32=2C
                 from ../../src/include/asm/xenomai/syscall.h:29=2C
                 from ../../src/include/asm/xenomai/atomic.h:82=2C
                 from ../../include/nucleus/system.h:26=2C
                 from ../../src/include/asm/xenomai/system.h:223=2C
                 from rt_print.c:31:
/usr/arm-linux-gnueabi/include/sys/ucontext.h:92: error: field =91uc_mconte=
xt=92 has incomplete type
In file included from ../../include/nucleus/system.h:27=2C
                 from ../../src/include/asm/xenomai/system.h:223=2C
                 from rt_print.c:31:
../../include/nucleus/trace.h: In function =91xntrace_max_begin=92:
../../include/nucleus/trace.h:56: error: =91ERESTART=92 undeclared (first u=
se in this function)
../../include/nucleus/trace.h:56: error: (Each undeclared identifier is rep=
orted only once
../../include/nucleus/trace.h:56: error: for each function it appears in.)
../../include/nucleus/trace.h: In function =91xntrace_max_end=92:
../../include/nucleus/trace.h:61: error: =91ERESTART=92 undeclared (first u=
se in this function)
../../include/nucleus/trace.h: In function =91xntrace_max_reset=92:
../../include/nucleus/trace.h:66: error: =91ERESTART=92 undeclared (first u=
se in this function)
../../include/nucleus/trace.h: In function =91xntrace_user_start=92:
../../include/nucleus/trace.h:71: error: =91ERESTART=92 undeclared (first u=
se in this function)
../../include/nucleus/trace.h: In function =91xntrace_user_stop=92:
../../include/nucleus/trace.h:76: error: =91ERESTART=92 undeclared (first u=
se in this function)
../../include/nucleus/trace.h: In function =91xntrace_user_freeze=92:
../../include/nucleus/trace.h:81: error: =91ERESTART=92 undeclared (first u=
se in this function)
../../include/nucleus/trace.h: In function =91xntrace_special=92:
../../include/nucleus/trace.h:87: error: =91ERESTART=92 undeclared (first u=
se in this function)
../../include/nucleus/trace.h: In function =91xntrace_special_u64=92:
../../include/nucleus/trace.h:92: error: =91ERESTART=92 undeclared (first u=
se in this function)
rt_print.c: In function =91print_to_buffer=92:
rt_print.c:98: error: =91EIO=92 undeclared (first use in this function)
rt_print.c: In function =91rt_print_init=92:
rt_print.c:253: error: =91EINVAL=92 undeclared (first use in this function)
rt_print.c:266: error: =91ENOMEM=92 undeclared (first use in this function)
make[2]: *** [librtdk_la-rt_print.lo] Error 1
make[2]: Leaving directory `/home/fede/foxg20/kernel/xenomai-2.5.1/src/rtdk=
'
make[1]: *** [install-recursive] Error 1
make[1]: Leaving directory `/home/fede/foxg20/kernel/xenomai-2.5.1/src'
make: *** [install-recursive] Error 1

some iedea??
thanks

Federico Lolli
Tel:+39  3476802428
E-mail: federicololli@domain.hid
web: www.federicololli.com


 		 	   		 =20
_________________________________________________________________
MSN ti offre esattamente quello che cerchi: il tuo browser personale
http://www.pimpit.it/ie8msn/=

--_c57eb18a-e061-4b31-8c1d-0f8b93dd4ddd_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px=3B
padding:0px
}
body.hmmessage
{
font-size: 10pt=3B
font-family:Verdana
}
--></style>
</head>
<body class=3D'hmmessage'>
Hi=2C<br><span id=3D"result_box" class=3D"medium_text"><span style=3D"" tit=
le=3D"">I would like to compile Xenomai for arm.<br></span><span title=3D""=
>processor is: at91sam9g20 -&gt=3B at91sam9.<br>the compiler is emdebian=2C=
 arm-linux-gnueabi-gcc<br>&nbsp=3B</span><span title=3D"">but I get the fol=
lowing errors in the compilation:</span></span><br><br>fede@domain.hid=
oxg20/kernel/xenomai-2.5.1$ sudo ./configure --build=3Di686-pc-linux-gnueab=
i --host=3Darm-linux-gnueabi --enable-arm-mach=3Dat91sam9 <br>checking buil=
d system type... i686-pc-linux-gnueabi<br>checking host system type... arm-=
unknown-linux-gnueabi<br>checking for a BSD-compatible install... /usr/bin/=
install -c<br>checking for arm-linux-gnueabi-gcc... arm-linux-gnueabi-gcc<b=
r>checking whether the C compiler works... yes<br>checking for C compiler d=
efault output file name... a.out<br>checking for suffix of executables... <=
br>checking whether we are cross compiling... yes<br>checking for suffix of=
 object files... o<br>checking whether we are using the GNU C compiler... y=
es<br>checking whether arm-linux-gnueabi-gcc accepts -g... yes<br>checking =
for arm-linux-gnueabi-gcc option to accept ISO C89... none needed<br>checki=
ng how to run the C preprocessor... /lib/cpp<br>checking target system type=
... arm-unknown-linux-gnueabi<br>checking for arm-linux-gnueabi-gcc... arm-=
linux-gnueabi-gcc<br>checking whether we are using the GNU C compiler... (c=
ached) yes<br>checking whether arm-linux-gnueabi-gcc accepts -g... yes<br>c=
hecking for arm-linux-gnueabi-gcc option to accept ISO C89... (cached) none=
 needed<br>checking how to run the C preprocessor... arm-linux-gnueabi-gcc =
-E<br>checking whether build environment is sane... yes<br>checking for a t=
hread-safe mkdir -p... /bin/mkdir -p<br>checking for gawk... gawk<br>checki=
ng whether make sets $(MAKE)... yes<br>checking for style of include used b=
y make... GNU<br>checking for arm-linux-gnueabi-strip... arm-linux-gnueabi-=
strip<br>checking dependency style of arm-linux-gnueabi-gcc... gcc3<br>chec=
king whether to enable maintainer-specific portions of Makefiles... no<br>c=
hecking dependency style of arm-linux-gnueabi-gcc... gcc3<br>checking for f=
lex... flex<br>checking lex output file root... lex.yy<br>checking lex libr=
ary... none needed<br>checking whether yytext is a pointer... no<br>checkin=
g for target architecture... arm<br>checking for a sed that does not trunca=
te output... /bin/sed<br>checking for grep that handles long lines and -e..=
. /bin/grep<br>checking for egrep... /bin/grep -E<br>checking for fgrep... =
/bin/grep -F<br>checking for ld used by arm-linux-gnueabi-gcc... /usr/arm-l=
inux-gnueabi/bin/ld<br>checking if the linker (/usr/arm-linux-gnueabi/bin/l=
d) is GNU ld... yes<br>checking for BSD- or MS-compatible name lister (nm).=
.. /usr/bin/arm-linux-gnueabi-nm -B<br>checking the name lister (/usr/bin/a=
rm-linux-gnueabi-nm -B) interface... BSD nm<br>checking whether ln -s works=
... yes<br>checking the maximum length of command line arguments... 1572864=
<br>checking whether the shell understands some XSI constructs... yes<br>ch=
ecking whether the shell understands "+=3D"... yes<br>checking for /usr/arm=
-linux-gnueabi/bin/ld option to reload object files... -r<br>checking how t=
o recognize dependent libraries... pass_all<br>checking for arm-linux-gnuea=
bi-ar... arm-linux-gnueabi-ar<br>checking for arm-linux-gnueabi-strip... (c=
ached) arm-linux-gnueabi-strip<br>checking for arm-linux-gnueabi-ranlib... =
arm-linux-gnueabi-ranlib<br>checking command to parse /usr/bin/arm-linux-gn=
ueabi-nm -B output from arm-linux-gnueabi-gcc object... ok<br>checking for =
ANSI C header files... yes<br>checking for sys/types.h... yes<br>checking f=
or sys/stat.h... yes<br>checking for stdlib.h... yes<br>checking for string=
.h... yes<br>checking for memory.h... yes<br>checking for strings.h... yes<=
br>checking for inttypes.h... yes<br>checking for stdint.h... yes<br>checki=
ng for unistd.h... yes<br>checking for dlfcn.h... yes<br>checking for objdi=
r... .libs<br>checking if arm-linux-gnueabi-gcc supports -fno-rtti -fno-exc=
eptions... no<br>checking for arm-linux-gnueabi-gcc option to produce PIC..=
. -fPIC -DPIC<br>checking if arm-linux-gnueabi-gcc PIC flag -fPIC -DPIC wor=
ks... yes<br>checking if arm-linux-gnueabi-gcc static flag -static works...=
 yes<br>checking if arm-linux-gnueabi-gcc supports -c -o file.o... yes<br>c=
hecking if arm-linux-gnueabi-gcc supports -c -o file.o... (cached) yes<br>c=
hecking whether the arm-linux-gnueabi-gcc linker (/usr/arm-linux-gnueabi/bi=
n/ld) supports shared libraries... yes<br>checking whether -lc should be ex=
plicitly linked in... no<br>checking dynamic linker characteristics... GNU/=
Linux ld.so<br>checking how to hardcode library paths into programs... imme=
diate<br>checking whether stripping libraries is possible... yes<br>checkin=
g if libtool supports shared libraries... yes<br>checking whether to build =
shared libraries... yes<br>checking whether to build static libraries... ye=
s<br>checking for debug symbols... no<br>checking for SMP support... no<br>=
checking for ARM machine... at91sam9<br>checking for ARM architecture versi=
on... 5<br>checking for ARM SA1100 architecture... no<br>checking for ARM X=
scale3 architecture... no<br>checking for TSC emulation in user-space.... y=
es<br>checking for ARM EABI interface... no<br>checking whether building Li=
nux in Xenomai build tree... no<br>checking for Doxygen documentation... no=
<br>checking for doxygen... no<br>checking for dot... NO<br>checking whethe=
r compiling Docbook XML documentation... no<br>checking for xmllint... xmll=
int<br>checking for xsltproc... xsltproc<br>checking for fop... no<br>check=
ing whether Docbook XML documentation generation can use network.... no<br>=
checking for docbook-xml root dir... /usr/share/sgml/docbook/dtd/xml/4.2<br=
>checking for docbook-xsl root dir... network<br>checking whether using LaT=
eX non-stop mode... no<br>checking mqueue.h usability... yes<br>checking mq=
ueue.h presence... yes<br>checking for mqueue.h... yes<br>checking for sche=
d_setaffinity... ok<br>checking for specific GCC switches... done<br>checki=
ng whether ld supports @file... yes<br>checking whether the POSIX skin libr=
ary automatically calls mlockall... no<br>checking whether the pSOS skin li=
brary automatically calls mlockall... no<br>checking whether the uITRON ski=
n library automatically calls mlockall... no<br>checking for shm_open... no=
<br>checking for shm_unlink... no<br>checking for mmap64... no<br>checking =
for ftruncate64... no<br>checking for pthread_mutexattr_setprotocol... no<b=
r>checking for pthread_condattr_setclock... no<br>checking for pthread_spin=
_lock... no<br>checking whether to enable dlopen support for skin libraries=
... no<br>configure: creating ./config.status<br>config.status: creating Ma=
kefile<br>config.status: creating config/Makefile<br>config.status: creatin=
g scripts/Makefile<br>config.status: creating scripts/xeno-config<br>config=
.status: creating scripts/xeno-load<br>config.status: creating scripts/xeno=
-test<br>config.status: creating src/Makefile<br>config.status: creating sr=
c/rtdk/Makefile<br>config.status: creating src/skins/Makefile<br>config.sta=
tus: creating src/skins/common/Makefile<br>config.status: creating src/skin=
s/posix/Makefile<br>config.status: creating src/skins/native/Makefile<br>co=
nfig.status: creating src/skins/vxworks/Makefile<br>config.status: creating=
 src/skins/psos+/Makefile<br>config.status: creating src/skins/vrtx/Makefil=
e<br>config.status: creating src/skins/rtdm/Makefile<br>config.status: crea=
ting src/skins/rtai/Makefile<br>config.status: creating src/skins/uitron/Ma=
kefile<br>config.status: creating src/drvlib/Makefile<br>config.status: cre=
ating src/drvlib/analogy/Makefile<br>config.status: creating src/include/Ma=
kefile<br>config.status: creating src/testsuite/Makefile<br>config.status: =
creating src/testsuite/latency/Makefile<br>config.status: creating src/test=
suite/cyclic/Makefile<br>config.status: creating src/testsuite/switchtest/M=
akefile<br>config.status: creating src/testsuite/irqbench/Makefile<br>confi=
g.status: creating src/testsuite/clocktest/Makefile<br>config.status: creat=
ing src/testsuite/klatency/Makefile<br>config.status: creating src/testsuit=
e/unit/Makefile<br>config.status: creating src/testsuite/sigtest/Makefile<b=
r>config.status: creating src/utils/Makefile<br>config.status: creating src=
/utils/can/Makefile<br>config.status: creating src/utils/analogy/Makefile<b=
r>config.status: creating src/utils/ps/Makefile<br>config.status: creating =
include/Makefile<br>config.status: creating include/asm-generic/Makefile<br=
>config.status: creating include/asm-generic/bits/Makefile<br>config.status=
: creating include/asm-blackfin/Makefile<br>config.status: creating include=
/asm-blackfin/bits/Makefile<br>config.status: creating include/asm-x86/Make=
file<br>config.status: creating include/asm-x86/bits/Makefile<br>config.sta=
tus: creating include/asm-powerpc/Makefile<br>config.status: creating inclu=
de/asm-powerpc/bits/Makefile<br>config.status: creating include/asm-arm/Mak=
efile<br>config.status: creating include/asm-arm/bits/Makefile<br>config.st=
atus: creating include/asm-nios2/Makefile<br>config.status: creating includ=
e/asm-nios2/bits/Makefile<br>config.status: creating include/asm-sim/Makefi=
le<br>config.status: creating include/asm-sim/bits/Makefile<br>config.statu=
s: creating include/native/Makefile<br>config.status: creating include/nucl=
eus/Makefile<br>config.status: creating include/posix/Makefile<br>config.st=
atus: creating include/posix/sys/Makefile<br>config.status: creating includ=
e/psos+/Makefile<br>config.status: creating include/rtai/Makefile<br>config=
.status: creating include/rtdm/Makefile<br>config.status: creating include/=
analogy/Makefile<br>config.status: creating include/uitron/Makefile<br>conf=
ig.status: creating include/vrtx/Makefile<br>config.status: creating includ=
e/vxworks/Makefile<br>config.status: creating doc/Makefile<br>config.status=
: creating doc/txt/Makefile<br>config.status: creating doc/man/Makefile<br>=
config.status: creating doc/man/clocktest.man<br>config.status: creating do=
c/man/cyclictest.man<br>config.status: creating doc/man/irqbench.man<br>con=
fig.status: creating doc/man/irqloop.man<br>config.status: creating doc/man=
/klatency.man<br>config.status: creating doc/man/latency.man<br>config.stat=
us: creating doc/man/rtcanconfig.man<br>config.status: creating doc/man/rtc=
anrecv.man<br>config.status: creating doc/man/rtcansend.man<br>config.statu=
s: creating doc/man/switchbench.man<br>config.status: creating doc/man/swit=
chtest.man<br>config.status: creating doc/man/runinfo.man<br>config.status:=
 creating doc/man/xeno-config.man<br>config.status: creating doc/man/xeno-i=
nfo.man<br>config.status: creating doc/man/xeno-load.man<br>config.status: =
creating doc/man/xeno-test.man<br>config.status: creating doc/doxygen/Makef=
ile<br>config.status: creating doc/doxygen/Doxyfile-common<br>config.status=
: creating doc/doxygen/Doxyfile<br>config.status: creating doc/doxygen/Doxy=
file-native<br>config.status: creating doc/doxygen/Doxyfile-nucleus<br>conf=
ig.status: creating doc/doxygen/Doxyfile-posix<br>config.status: creating d=
oc/doxygen/Doxyfile-rtdm<br>config.status: creating doc/docbook/Makefile<br=
>config.status: creating doc/docbook/catalog<br>config.status: creating doc=
/docbook/custom-stylesheets/Makefile<br>config.status: creating doc/docbook=
/custom-stylesheets/xsl/Makefile<br>config.status: creating doc/docbook/cus=
tom-stylesheets/xsl/common/Makefile<br>config.status: creating doc/docbook/=
custom-stylesheets/xsl/fo/Makefile<br>config.status: creating doc/docbook/c=
ustom-stylesheets/xsl/html/Makefile<br>config.status: creating doc/docbook/=
custom-stylesheets/xsl/html/chunk.xsl<br>config.status: creating doc/docboo=
k/custom-stylesheets/xsl/html/onechunk.xsl<br>config.status: creating doc/d=
ocbook/xenomai/Makefile<br>config.status: creating src/include/xeno_config.=
h<br>config.status: linking ./include/asm-arm to src/include/asm/xenomai<br=
>config.status: linking ./include/asm-generic to src/include/asm-generic/xe=
nomai<br>config.status: executing depfiles commands<br>config.status: execu=
ting libtool commands<br><br><br><br><br>fede@domain.hid=
enomai-2.5.1$ sudo make DESTDIR=3D/home/fede/foxg20/lll installMaking insta=
ll in src<br>make[1]: Entering directory `/home/fede/foxg20/kernel/xenomai-=
2.5.1/src'<br>Making install in include<br>make[2]: Entering directory `/ho=
me/fede/foxg20/kernel/xenomai-2.5.1/src/include'<br>make[3]: Entering direc=
tory `/home/fede/foxg20/kernel/xenomai-2.5.1/src/include'<br>make[3]: Nothi=
ng to be done for `install-exec-am'.<br>make[3]: Nothing to be done for `in=
stall-data-am'.<br>make[3]: Leaving directory `/home/fede/foxg20/kernel/xen=
omai-2.5.1/src/include'<br>make[2]: Leaving directory `/home/fede/foxg20/ke=
rnel/xenomai-2.5.1/src/include'<br>Making install in rtdk<br>make[2]: Enter=
ing directory `/home/fede/foxg20/kernel/xenomai-2.5.1/src/rtdk'<br>/bin/sh =
../../libtool --tag=3DCC&nbsp=3B&nbsp=3B --mode=3Dcompile arm-linux-gnueabi=
-gcc -DHAVE_CONFIG_H -I. -I../../src/include&nbsp=3B -O2 -D_GNU_SOURCE -D_R=
EENTRANT -Wall -pipe -march=3Darmv5 -D__XENO__ -D__IN_XENO__ -Wstrict-proto=
types -I../../include&nbsp=3B&nbsp=3B&nbsp=3B -MT librtdk_la-rt_print.lo -M=
D -MP -MF .deps/librtdk_la-rt_print.Tpo -c -o librtdk_la-rt_print.lo `test =
-f 'rt_print.c' || echo './'`rt_print.c<br>libtool: compile:&nbsp=3B arm-li=
nux-gnueabi-gcc -DHAVE_CONFIG_H -I. -I../../src/include -O2 -D_GNU_SOURCE -=
D_REENTRANT -Wall -pipe -march=3Darmv5 -D__XENO__ -D__IN_XENO__ -Wstrict-pr=
ototypes -I../../include -MT librtdk_la-rt_print.lo -MD -MP -MF .deps/librt=
dk_la-rt_print.Tpo -c rt_print.c&nbsp=3B -fPIC -DPIC -o .libs/librtdk_la-rt=
_print.o<br>rt_print.c:1: warning: target CPU does not support interworking=
<br>In file included from /usr/arm-linux-gnueabi/include/errno.h:36=2C<br>&=
nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbs=
p=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B from rt_print.c:19:<br=
>/usr/arm-linux-gnueabi/include/bits/errno.h:25:26: error: linux/errno.h: N=
o such file or directory<br>In file included from /usr/arm-linux-gnueabi/in=
clude/bits/posix1_lim.h:153=2C<br>&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&=
nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbs=
p=3B&nbsp=3B from /usr/arm-linux-gnueabi/include/limits.h:145=2C<br>&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B from /usr/lib/gcc/arm-linu=
x-gnueabi/4.3.2/include-fixed/limits.h:122=2C<br>&nbsp=3B&nbsp=3B&nbsp=3B&n=
bsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B from /usr/lib/gcc/arm-linux-gnueabi/4.3.2/inclu=
de-fixed/syslimits.h:7=2C<br>&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B from /usr/lib/gcc/arm-linux-gnueabi/4.3.2/include-fixed/limits.h:1=
1=2C<br>&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B from rt_print=
.c:21:<br>/usr/arm-linux-gnueabi/include/bits/local_lim.h:36:26: error: lin=
ux/limits.h: No such file or directory<br>In file included from ../../src/i=
nclude/asm/xenomai/system.h:223=2C<br>&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B from rt_print.c:31:<br>../../include/nucleus/system.h:25:2=
3: error: asm/param.h: No such file or directory<br>In file included from /=
usr/arm-linux-gnueabi/include/signal.h:333=2C<br>&nbsp=3B&nbsp=3B&nbsp=3B&n=
bsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B from ../../src/include/asm-generic/xenomai/sysc=
all.h:32=2C<br>&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbs=
p=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B from .=
./../src/include/asm/xenomai/syscall.h:29=2C<br>&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B from ../../src/include/asm/xenomai/atomic.h:82=
=2C<br>&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbs=
p=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B from ../../inc=
lude/nucleus/system.h:26=2C<br>&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbs=
p=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B from ../../src/include/asm/xenomai/system.h:223=2C<br>&nbsp=3B&=
nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbs=
p=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B from rt_print.c:31:<br>/usr/ar=
m-linux-gnueabi/include/bits/sigcontext.h:28:29: error: asm/sigcontext.h: N=
o such file or directory<br>In file included from /usr/arm-linux-gnueabi/in=
clude/signal.h:353=2C<br>&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&n=
bsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B from ../../src/include/asm-generic/xenomai/syscall.h:32=2C<br>&nbsp=3B&=
nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbs=
p=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B from ../../src/include/asm/xen=
omai/syscall.h:29=2C<br>&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B from ../../src/include/asm/xenomai/atomic.h:82=2C<br>&nbsp=3B&nbsp=3B&n=
bsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B from ../../include/nucleus/system.h:26=
=2C<br>&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbs=
p=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B from ../../src=
/include/asm/xenomai/system.h:223=2C<br>&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B from rt_print.c:31:<br>/usr/arm-linux-gnueabi/include/s=
ys/ucontext.h:92: error: field =91uc_mcontext=92 has incomplete type<br>In =
file included from ../../include/nucleus/system.h:27=2C<br>&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B from ../../src/include/asm/xenomai/sy=
stem.h:223=2C<br>&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&n=
bsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B from=
 rt_print.c:31:<br>../../include/nucleus/trace.h: In function =91xntrace_ma=
x_begin=92:<br>../../include/nucleus/trace.h:56: error: =91ERESTART=92 unde=
clared (first use in this function)<br>../../include/nucleus/trace.h:56: er=
ror: (Each undeclared identifier is reported only once<br>../../include/nuc=
leus/trace.h:56: error: for each function it appears in.)<br>../../include/=
nucleus/trace.h: In function =91xntrace_max_end=92:<br>../../include/nucleu=
s/trace.h:61: error: =91ERESTART=92 undeclared (first use in this function)=
<br>../../include/nucleus/trace.h: In function =91xntrace_max_reset=92:<br>=
../../include/nucleus/trace.h:66: error: =91ERESTART=92 undeclared (first u=
se in this function)<br>../../include/nucleus/trace.h: In function =91xntra=
ce_user_start=92:<br>../../include/nucleus/trace.h:71: error: =91ERESTART=
=92 undeclared (first use in this function)<br>../../include/nucleus/trace.=
h: In function =91xntrace_user_stop=92:<br>../../include/nucleus/trace.h:76=
: error: =91ERESTART=92 undeclared (first use in this function)<br>../../in=
clude/nucleus/trace.h: In function =91xntrace_user_freeze=92:<br>../../incl=
ude/nucleus/trace.h:81: error: =91ERESTART=92 undeclared (first use in this=
 function)<br>../../include/nucleus/trace.h: In function =91xntrace_special=
=92:<br>../../include/nucleus/trace.h:87: error: =91ERESTART=92 undeclared =
(first use in this function)<br>../../include/nucleus/trace.h: In function =
=91xntrace_special_u64=92:<br>../../include/nucleus/trace.h:92: error: =91E=
RESTART=92 undeclared (first use in this function)<br>rt_print.c: In functi=
on =91print_to_buffer=92:<br>rt_print.c:98: error: =91EIO=92 undeclared (fi=
rst use in this function)<br>rt_print.c: In function =91rt_print_init=92:<b=
r>rt_print.c:253: error: =91EINVAL=92 undeclared (first use in this functio=
n)<br>rt_print.c:266: error: =91ENOMEM=92 undeclared (first use in this fun=
ction)<br>make[2]: *** [librtdk_la-rt_print.lo] Error 1<br>make[2]: Leaving=
 directory `/home/fede/foxg20/kernel/xenomai-2.5.1/src/rtdk'<br>make[1]: **=
* [install-recursive] Error 1<br>make[1]: Leaving directory `/home/fede/fox=
g20/kernel/xenomai-2.5.1/src'<br>make: *** [install-recursive] Error 1<br><=
br><span id=3D"result_box" class=3D"short_text"><span style=3D"" title=3D""=
>some iedea??<br></span><span title=3D"">thanks</span></span><br><br>Federi=
co Lolli<br>Tel:+39&nbsp=3B 3476802428<br>E-mail: federicololli@domain.hid=
<br>web: www.federicololli.com<br><br><br> 		 	   		  <br /><hr />Tanti acc=
ount di posta? <a href=3D'http://www.windowslive.it/hotmail/UnicaCasellaDiP=
osta.aspx' target=3D'_new'>Unisci tutto sotto Hotmail</a></body>
</html>=

--_c57eb18a-e061-4b31-8c1d-0f8b93dd4ddd_--

