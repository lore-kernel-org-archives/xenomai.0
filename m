Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 1 Dec 2005 11:48:35 +0200
Message-ID: <8DF1258D5F0FC94EBF5810BF2C7BF2FB3FFC9B@ILEX5.IL.NDS.COM>
From: "Ashri, Sarit" <Sashri@domain.hid>
Subject: [Xenomai-help] Problem building MVM: "error: The X11 library
	'-lX11' could not be found"
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

Hi,

I'm trying to build Xenomai 2.0.1 with MVM support.
My target board is PPC and I use patched Linux 2.6.13.4 with it + =20
Xenomai 2.0.1 , cross compiled with the flags: ARCH=3Dppc
CROSS_COMPILE=3Dppc_82xx:

[.../xenomai-2.0.1/build-sim]$ make ARCH=3Dppc CROSS_COMPILE=3Dppc_82xx-
xeno_srctree=3D../=20
-f ../makefile xconfig
make[1]: Entering directory
`/opt/eldk/eldk3.1.1/usr/src/xenomai/xenomai-2.0.1/build-sim/config/kcon
fig'
#
# using defaults found in ../../.xeno_config
#
make[1]: Leaving directory
`/opt/eldk/eldk3.1.1/usr/src/xenomai/xenomai-2.0.1/build-sim/config/kcon
fig'
checking build system type... i686-pc-linux-gnu
checking host system type... powerpc-unknown-linux-gnu
checking for a BSD-compatible install... /usr/bin/install -c
checking for powerpc-unknown-linux-gnu-gcc... ppc_82xx-gcc
=2E..  =20
configure: running /bin/sh
'/opt/src_eldk3.1.1/xenomai/xenomai-2.0.1/sim/configure'
--prefix=3D/usr/realtime  'CROSS_COMPILE=3Dppc_82xx-' 'CC=3Dppc_82xx-gcc'=

'CXX=3Dppc_82xx-g++' 'LD=3Dppc_82xx-ld' 'AR=3Dppc_82xx-ar'
'RANLIB=3Dppc_82xx-ranlib' 'STRIP=3Dppc_82xx-strip' 'NM=3Dppc_82xx-nm'
'--build=3Di686-pc-linux-gnu' '--host=3Dpowerpc-unknown-linux-gnu'
'--with-kconfig-file=3D.xeno_config' '--with-linux-dir=3D'
'--prefix=3D/usr/realtime' 'build_alias=3Di686-pc-linux-gnu'
'host_alias=3Dpowerpc-unknown-linux-gnu' --cache-file=3D/dev/null
--srcdir=3D/opt/src_eldk3.1.1/xenomai/xenomai-2.0.1/sim
checking build system type... i686-pc-linux-gnu
checking host system type... powerpc-unknown-linux-gnu
checking for a BSD-compatible install... /usr/bin/install -c
checking for powerpc-unknown-linux-gnu-gcc... ppc_82xx-gcc
=2E..
checking for C compiler default output file name... a.out
checking whether the C compiler works... yes
checking whether we are cross compiling... yes
checking for suffix of executables...=20
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether ppc_82xx-gcc accepts -g... yes
checking for ppc_82xx-gcc option to accept ANSI C... none needed
checking for powerpc-unknown-linux-gnu-g++... ppc_82xx-g++
checking whether we are using the GNU C++ compiler... yes
checking whether ppc_82xx-g++ accepts -g... yes
checking whether build environment is sane... yes
checking for gawk... gawk
checking whether make sets $(MAKE)... yes
checking for style of include used by make... GNU
checking for powerpc-unknown-linux-gnu-strip... ppc_82xx-strip
checking dependency style of ppc_82xx-gcc... gcc3
checking dependency style of ppc_82xx-g++... gcc3
checking whether to enable maintainer-specific portions of Makefiles...
no
checking for a sed that does not truncate output... /bin/sed
checking for egrep... grep -E
checking for ld used by ppc_82xx-gcc... ppc_82xx-ld
checking if the linker (ppc_82xx-ld) is GNU ld... yes
checking for ppc_82xx-ld option to reload object files... -r
checking for BSD-compatible nm... ppc_82xx-nm
checking whether ln -s works... yes
checking how to recognise dependent libraries... pass_all
checking how to run the C preprocessor... ppc_82xx-gcc -E
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
checking dlfcn.h usability... yes
checking dlfcn.h presence... yes
checking for dlfcn.h... yes
checking how to run the C++ preprocessor... ppc_82xx-g++ -E
checking for powerpc-unknown-linux-gnu-g77... no
checking for powerpc-unknown-linux-gnu-f77... no
checking for powerpc-unknown-linux-gnu-xlf... no
checking for powerpc-unknown-linux-gnu-frt... no
checking for powerpc-unknown-linux-gnu-pgf77... no
checking for powerpc-unknown-linux-gnu-fort77... no
checking for powerpc-unknown-linux-gnu-fl32... no
checking for powerpc-unknown-linux-gnu-af77... no
checking for powerpc-unknown-linux-gnu-f90... no
checking for powerpc-unknown-linux-gnu-xlf90... no
checking for powerpc-unknown-linux-gnu-pgf90... no
checking for powerpc-unknown-linux-gnu-epcf90... no
checking for powerpc-unknown-linux-gnu-f95... no
checking for powerpc-unknown-linux-gnu-fort... no
checking for powerpc-unknown-linux-gnu-xlf95... no
checking for powerpc-unknown-linux-gnu-ifc... no
checking for powerpc-unknown-linux-gnu-efc... no
checking for powerpc-unknown-linux-gnu-pgf95... no
checking for powerpc-unknown-linux-gnu-lf95... no
checking for powerpc-unknown-linux-gnu-gfortran... no
checking for g77... g77
checking whether we are using the GNU Fortran 77 compiler... yes
checking whether g77 accepts -g... yes
checking the maximum length of command line arguments... 32768
checking command to parse ppc_82xx-nm output from ppc_82xx-gcc object...
ok
checking for objdir... .libs
checking for powerpc-unknown-linux-gnu-ar... ppc_82xx-ar
checking for powerpc-unknown-linux-gnu-ranlib... ppc_82xx-ranlib
checking for powerpc-unknown-linux-gnu-strip... (cached) ppc_82xx-strip
checking if ppc_82xx-gcc static flag  works... yes
checking if ppc_82xx-gcc supports -fno-rtti -fno-exceptions... no
checking for ppc_82xx-gcc option to produce PIC... -fPIC
checking if ppc_82xx-gcc PIC flag -fPIC works... yes
checking if ppc_82xx-gcc supports -c -o file.o... yes
checking whether the ppc_82xx-gcc linker (ppc_82xx-ld) supports shared
libraries... yes
checking whether -lc should be explicitly linked in... no
checking dynamic linker characteristics... GNU/Linux ld.so
checking how to hardcode library paths into programs... immediate
checking whether stripping libraries is possible... yes
checking if libtool supports shared libraries... yes
checking whether to build shared libraries... yes
checking whether to build static libraries... yes
configure: creating libtool
appending configuration tag "CXX" to libtool
checking for ld used by ppc_82xx-g++... ppc_82xx-ld
checking if the linker (ppc_82xx-ld) is GNU ld... yes
checking whether the ppc_82xx-g++ linker (ppc_82xx-ld) supports shared
libraries... yes
checking for ppc_82xx-g++ option to produce PIC... -fPIC
checking if ppc_82xx-g++ PIC flag -fPIC works... yes
checking if ppc_82xx-g++ supports -c -o file.o... yes
checking whether the ppc_82xx-g++ linker (ppc_82xx-ld) supports shared
libraries... yes
checking dynamic linker characteristics... GNU/Linux ld.so
checking how to hardcode library paths into programs... immediate
checking whether stripping libraries is possible... yes
appending configuration tag "F77" to libtool
checking if libtool supports shared libraries... yes
checking whether to build shared libraries... yes
checking whether to build static libraries... yes
checking for g77 option to produce PIC... -fPIC
checking if g77 PIC flag -fPIC works... yes
checking if g77 supports -c -o file.o... yes
checking whether the g77 linker (ppc_82xx-ld) supports shared
libraries... yes
checking dynamic linker characteristics... GNU/Linux ld.so
checking how to hardcode library paths into programs... immediate
checking whether stripping libraries is possible... yes
checking for flex... flex
checking for yywrap in -lfl... yes
checking lex output file root... lex.yy
checking whether yytext is a pointer... yes
checking for Xenomai installation directory... /usr/realtime
checking for MVM debug support... no
checking for MVM atomic core mode... no
checking for statistics collection in nucleus... y
checking for Xenomai nucleus debug support... no
checking for GCC tarball... /tmp/gcc-2.95.3.tar.bz2
checking Wrap Tcl-scripts in executables... no
checking for pSOS+ simulator... y
checking for VxWorks simulator... y
checking for VRTX simulator... y
checking for uITRON simulator... y
checking for POSIX simulator... y
checking for native API simulator... y
checking for RTAI simulator... y
checking if C compiler is GNU C... yes
checking if C compiler supports -fwritable-strings
-fdollars-in-identifiers... yes
checking if C++ compiler is GNU C++... yes
checking if C++ compiler supports -fno-exceptions... yes
checking if C++ compiler supports -fnonnull-objects... no
checking for X... libraries /usr/X11R6/lib, headers /usr/X11R6/include
checking for dnet_ntoa in -ldnet... no
checking for dnet_ntoa in -ldnet_stub... no
checking for gethostbyname... yes
checking for connect... yes
checking for remove... yes
checking for shmat... yes
checking for IceConnectionNumber in -lICE... no
checking for XOpenDisplay in -lX11... no
configure: error: The X11 library '-lX11' could not be found,
 so I won't go further. Please use the configure
 options '--x-includes=3DDIR' and '--x-libraries=3DDIR'
 to specify the X location. See the file 'config.log'
 for further diagnostics.
configure: error: /bin/sh
'/opt/src_eldk3.1.1/xenomai/xenomai-2.0.1/sim/configure' failed for sim
make: *** [config.status] Error 1

*************************
>From config.log file:
*************************
This file contains any messages produced by compilers while
running configure, to aid debugging if configure makes a mistake.

It was created by Xenomai configure 2.0.1, which was
generated by GNU Autoconf 2.59.  Invocation command line was

  $ /opt/src_eldk3.1.1/xenomai/xenomai-2.0.1/configure
CROSS_COMPILE=3Dppc_82xx- CC=3Dppc_82xx-gcc CXX=3Dppc_82xx-g++ LD=3Dppc_8=
2xx-ld
AR=3Dppc_82xx-ar RANLIB=3Dppc_82xx-ranlib STRIP=3Dppc_82xx-strip
NM=3Dppc_82xx-nm --build=3Di686-pc-linux-gnu
--host=3Dpowerpc-unknown-linux-gnu --with-kconfig-file=3D.xeno_config
--with-linux-dir=3D --prefix=3D/usr/realtime

## --------- ##
## Platform. ##
## --------- ##

hostname =3D sashri-lin
uname -m =3D i686
uname -r =3D 2.4.21-32.EL
uname -s =3D Linux
uname -v =3D #1 Fri Apr 15 21:29:19 EDT 2005

/usr/bin/uname -p =3D unknown
/bin/uname -X     =3D unknown

/bin/arch              =3D i686
/usr/bin/arch -k       =3D unknown
/usr/convex/getsysinfo =3D unknown
hostinfo               =3D unknown
/bin/machine           =3D unknown
/usr/bin/oslevel       =3D unknown
/bin/universe          =3D unknown

PATH: /users/sashri/bin
PATH: /home/oracle/orahome/bin
PATH: /usr/kerberos/bin
PATH: /bin
PATH: /usr/bin
PATH: /usr/bin/X11
PATH: /usr/local/bin
PATH: /usr/bin
PATH: /usr/X11R6/bin
PATH: ../bin
PATH: /usr/bin/X11
PATH: /usr/contrib/bin/X11
PATH: /users/bin
PATH: .
PATH: /usr/softbench/bin
PATH: /etc
PATH: /sbin
PATH: /opt/eldk/eldk3.1.1/usr/bin
PATH: /opt/eldk/eldk3.1.1/bin
PATH: //opt/eldk/eldk3.1.1/ppc_82xx/usr/realtime/bin
PATH: /sbin
=2E..
config.status:1546: executing depfiles commands
configure:25617: configuring in sim
configure:25734: running /bin/sh
'/opt/src_eldk3.1.1/xenomai/xenomai-2.0.1/sim/configure'
--prefix=3D/usr/realtime  'CROSS_COMPILE=3Dppc_82xx-' 'CC=3Dppc_82xx-gcc'=

'CXX=3Dppc_82xx-g++' 'LD=3Dppc_82xx-ld' 'AR=3Dppc_82xx-ar'
'RANLIB=3Dppc_82xx-ranlib' 'STRIP=3Dppc_82xx-strip' 'NM=3Dppc_82xx-nm'
'--build=3Di686-pc-linux-gnu' '--host=3Dpowerpc-unknown-linux-gnu'
'--with-kconfig-file=3D.xeno_config' '--with-linux-dir=3D'
'--prefix=3D/usr/realtime' 'build_alias=3Di686-pc-linux-gnu'
'host_alias=3Dpowerpc-unknown-linux-gnu' --cache-file=3D/dev/null
--srcdir=3D/opt/src_eldk3.1.1/xenomai/xenomai-2.0.1/sim
configure:25739: error: /bin/sh
'/opt/src_eldk3.1.1/xenomai/xenomai-2.0.1/sim/configure' failed for sim
=2E..
configure: exit 1

I'll appreciate any help you can give me
Thanks,
Sarit.


*************************************************************************=
**********
This email message and any attachments thereto are intended only for use =
by the addressee(s) named above, and may contain legally privileged and/o=
r confidential information. If the reader of this message is not the inte=
nded recipient, or the employee or agent responsible to deliver it to the=
 intended recipient, you are hereby notified that any dissemination, dist=
ribution or copying of this communication is strictly prohibited. If you =
have received this communication in error, please immediately notify the =
postmaster@domain.hid and destroy the original message.
*************************************************************************=
**********

