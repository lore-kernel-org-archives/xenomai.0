Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 1 Dec 2005 12:00:30 +0200
Message-ID: <8DF1258D5F0FC94EBF5810BF2C7BF2FB3FFCB7@domain.hid>
From: "Ashri, Sarit" <Sashri@domain.hid>
Subject: [Xenomai-help] RE: Problem building MVM: "error: The X11 library
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

=20
I forgot to mention that I located the library libX11.a in
/usr/X11R6/lib.
After executing configure with the additional flags:
--x-includes=3D/usr/X11R6/include/X11
--x-libraries=3D/usr/X11R6/lib I receives the same error.
BTW when I ran sim/configure it passed and so did make and make install=20=

of the simulator directly in sim directory, but when I tried to compile=20=

the demos with gcic (make sim) I received the error message:
"gcic:instrumenter/compiler is missing -- please check your
installation."

Thanks again,
Sarit.

Ashri, Sarit wrote
>=20
> Hi,
>=20
> I'm trying to build Xenomai 2.0.1 with MVM support.
> My target board is PPC and I use patched Linux 2.6.13.4 with=20
> it + Xenomai 2.0.1 , cross compiled with the flags: ARCH=3Dppc=20
> CROSS_COMPILE=3Dppc_82xx:
>=20
> [.../xenomai-2.0.1/build-sim]$ make ARCH=3Dppc=20
> CROSS_COMPILE=3Dppc_82xx- xeno_srctree=3D../ -f ../makefile xconfig
> make[1]: Entering directory=20
> `/opt/eldk/eldk3.1.1/usr/src/xenomai/xenomai-2.0.1/build-sim/c
> onfig/kconfig'
> #
> # using defaults found in ../../.xeno_config #
> make[1]: Leaving directory=20
> `/opt/eldk/eldk3.1.1/usr/src/xenomai/xenomai-2.0.1/build-sim/c
> onfig/kconfig'
> checking build system type... i686-pc-linux-gnu checking host=20
> system type... powerpc-unknown-linux-gnu checking for a=20
> BSD-compatible install... /usr/bin/install -c checking for=20
> powerpc-unknown-linux-gnu-gcc... ppc_82xx-gcc
> ...  =20
> configure: running /bin/sh=20
> '/opt/src_eldk3.1.1/xenomai/xenomai-2.0.1/sim/configure'=20
> --prefix=3D/usr/realtime  'CROSS_COMPILE=3Dppc_82xx-'=20
> 'CC=3Dppc_82xx-gcc' 'CXX=3Dppc_82xx-g++' 'LD=3Dppc_82xx-ld'=20
> 'AR=3Dppc_82xx-ar' 'RANLIB=3Dppc_82xx-ranlib'=20
> 'STRIP=3Dppc_82xx-strip' 'NM=3Dppc_82xx-nm'=20
> '--build=3Di686-pc-linux-gnu'=20
> '--host=3Dpowerpc-unknown-linux-gnu'=20
> '--with-kconfig-file=3D.xeno_config' '--with-linux-dir=3D'=20
> '--prefix=3D/usr/realtime' 'build_alias=3Di686-pc-linux-gnu'=20
> 'host_alias=3Dpowerpc-unknown-linux-gnu' --cache-file=3D/dev/null=20
> --srcdir=3D/opt/src_eldk3.1.1/xenomai/xenomai-2.0.1/sim
> checking build system type... i686-pc-linux-gnu checking host=20
> system type... powerpc-unknown-linux-gnu checking for a=20
> BSD-compatible install... /usr/bin/install -c checking for=20
> powerpc-unknown-linux-gnu-gcc... ppc_82xx-gcc ... checking for=20
> C compiler default output file name... a.out checking whether=20
> the C compiler works... yes checking whether we are cross=20
> compiling... yes checking for suffix of executables...=20
> checking for suffix of object files... o checking whether we=20
> are using the GNU C compiler... yes checking whether=20
> ppc_82xx-gcc accepts -g... yes checking for ppc_82xx-gcc=20
> option to accept ANSI C... none needed checking for=20
> powerpc-unknown-linux-gnu-g++... ppc_82xx-g++ checking=20
> whether we are using the GNU C++ compiler... yes checking=20
> whether ppc_82xx-g++ accepts -g... yes checking whether build=20
> environment is sane... yes checking for gawk... gawk checking=20
> whether make sets $(MAKE)... yes checking for style of=20
> include used by make... GNU checking for=20
> powerpc-unknown-linux-gnu-strip... ppc_82xx-strip checking=20
> dependency style of ppc_82xx-gcc... gcc3 checking dependency=20
> style of ppc_82xx-g++... gcc3 checking whether to enable=20
> maintainer-specific portions of Makefiles... no checking for=20
> a sed that does not truncate output... /bin/sed checking for=20
> egrep... grep -E checking for ld used by ppc_82xx-gcc...=20
> ppc_82xx-ld checking if the linker (ppc_82xx-ld) is GNU ld...=20
> yes checking for ppc_82xx-ld option to reload object files...=20
> -r checking for BSD-compatible nm... ppc_82xx-nm checking=20
> whether ln -s works... yes checking how to recognise=20
> dependent libraries... pass_all checking how to run the C=20
> preprocessor... ppc_82xx-gcc -E checking for ANSI C header=20
> files... yes checking for sys/types.h... yes checking for=20
> sys/stat.h... yes checking for stdlib.h... yes checking for=20
> string.h... yes checking for memory.h... yes checking for=20
> strings.h... yes checking for inttypes.h... yes checking for=20
> stdint.h... yes checking for unistd.h... yes checking dlfcn.h=20
> usability... yes checking dlfcn.h presence... yes checking=20
> for dlfcn.h... yes checking how to run the C++=20
> preprocessor... ppc_82xx-g++ -E checking for=20
> powerpc-unknown-linux-gnu-g77... no checking for=20
> powerpc-unknown-linux-gnu-f77... no checking for=20
> powerpc-unknown-linux-gnu-xlf... no checking for=20
> powerpc-unknown-linux-gnu-frt... no checking for=20
> powerpc-unknown-linux-gnu-pgf77... no checking for=20
> powerpc-unknown-linux-gnu-fort77... no checking for=20
> powerpc-unknown-linux-gnu-fl32... no checking for=20
> powerpc-unknown-linux-gnu-af77... no checking for=20
> powerpc-unknown-linux-gnu-f90... no checking for=20
> powerpc-unknown-linux-gnu-xlf90... no checking for=20
> powerpc-unknown-linux-gnu-pgf90... no checking for=20
> powerpc-unknown-linux-gnu-epcf90... no checking for=20
> powerpc-unknown-linux-gnu-f95... no checking for=20
> powerpc-unknown-linux-gnu-fort... no checking for=20
> powerpc-unknown-linux-gnu-xlf95... no checking for=20
> powerpc-unknown-linux-gnu-ifc... no checking for=20
> powerpc-unknown-linux-gnu-efc... no checking for=20
> powerpc-unknown-linux-gnu-pgf95... no checking for=20
> powerpc-unknown-linux-gnu-lf95... no checking for=20
> powerpc-unknown-linux-gnu-gfortran... no checking for g77...=20
> g77 checking whether we are using the GNU Fortran 77=20
> compiler... yes checking whether g77 accepts -g... yes=20
> checking the maximum length of command line arguments...=20
> 32768 checking command to parse ppc_82xx-nm output from=20
> ppc_82xx-gcc object... ok checking for objdir... .libs=20
> checking for powerpc-unknown-linux-gnu-ar... ppc_82xx-ar=20
> checking for powerpc-unknown-linux-gnu-ranlib...=20
> ppc_82xx-ranlib checking for=20
> powerpc-unknown-linux-gnu-strip... (cached) ppc_82xx-strip=20
> checking if ppc_82xx-gcc static flag  works... yes checking=20
> if ppc_82xx-gcc supports -fno-rtti -fno-exceptions... no=20
> checking for ppc_82xx-gcc option to produce PIC... -fPIC=20
> checking if ppc_82xx-gcc PIC flag -fPIC works... yes checking=20
> if ppc_82xx-gcc supports -c -o file.o... yes checking whether=20
> the ppc_82xx-gcc linker (ppc_82xx-ld) supports shared=20
> libraries... yes checking whether -lc should be explicitly=20
> linked in... no checking dynamic linker characteristics...=20
> GNU/Linux ld.so checking how to hardcode library paths into=20
> programs... immediate checking whether stripping libraries is=20
> possible... yes checking if libtool supports shared=20
> libraries... yes checking whether to build shared=20
> libraries... yes checking whether to build static libraries... yes
> configure: creating libtool
> appending configuration tag "CXX" to libtool checking for ld=20
> used by ppc_82xx-g++... ppc_82xx-ld checking if the linker=20
> (ppc_82xx-ld) is GNU ld... yes checking whether the=20
> ppc_82xx-g++ linker (ppc_82xx-ld) supports shared=20
> libraries... yes checking for ppc_82xx-g++ option to produce=20
> PIC... -fPIC checking if ppc_82xx-g++ PIC flag -fPIC works...=20
> yes checking if ppc_82xx-g++ supports -c -o file.o... yes=20
> checking whether the ppc_82xx-g++ linker (ppc_82xx-ld)=20
> supports shared libraries... yes checking dynamic linker=20
> characteristics... GNU/Linux ld.so checking how to hardcode=20
> library paths into programs... immediate checking whether=20
> stripping libraries is possible... yes appending=20
> configuration tag "F77" to libtool checking if libtool=20
> supports shared libraries... yes checking whether to build=20
> shared libraries... yes checking whether to build static=20
> libraries... yes checking for g77 option to produce PIC...=20
> -fPIC checking if g77 PIC flag -fPIC works... yes checking if=20
> g77 supports -c -o file.o... yes checking whether the g77=20
> linker (ppc_82xx-ld) supports shared libraries... yes=20
> checking dynamic linker characteristics... GNU/Linux ld.so=20
> checking how to hardcode library paths into programs...=20
> immediate checking whether stripping libraries is possible...=20
> yes checking for flex... flex checking for yywrap in -lfl...=20
> yes checking lex output file root... lex.yy checking whether=20
> yytext is a pointer... yes checking for Xenomai installation=20
> directory... /usr/realtime checking for MVM debug support...=20
> no checking for MVM atomic core mode... no checking for=20
> statistics collection in nucleus... y checking for Xenomai=20
> nucleus debug support... no checking for GCC tarball...=20
> /tmp/gcc-2.95.3.tar.bz2 checking Wrap Tcl-scripts in=20
> executables... no checking for pSOS+ simulator... y checking=20
> for VxWorks simulator... y checking for VRTX simulator... y=20
> checking for uITRON simulator... y checking for POSIX=20
> simulator... y checking for native API simulator... y=20
> checking for RTAI simulator... y checking if C compiler is=20
> GNU C... yes checking if C compiler supports=20
> -fwritable-strings -fdollars-in-identifiers... yes checking=20
> if C++ compiler is GNU C++... yes checking if C++ compiler=20
> supports -fno-exceptions... yes checking if C++ compiler=20
> supports -fnonnull-objects... no checking for X... libraries=20
> /usr/X11R6/lib, headers /usr/X11R6/include checking for=20
> dnet_ntoa in -ldnet... no checking for dnet_ntoa in=20
> -ldnet_stub... no checking for gethostbyname... yes checking=20
> for connect... yes checking for remove... yes checking for=20
> shmat... yes checking for IceConnectionNumber in -lICE... no=20
> checking for XOpenDisplay in -lX11... no
> configure: error: The X11 library '-lX11' could not be found,=20
>  so I won't go further. Please use the configure  options=20
> '--x-includes=3DDIR' and '--x-libraries=3DDIR'
>  to specify the X location. See the file 'config.log'
>  for further diagnostics.
> configure: error: /bin/sh=20
> '/opt/src_eldk3.1.1/xenomai/xenomai-2.0.1/sim/configure'=20
> failed for sim
> make: *** [config.status] Error 1
>=20
> *************************
> From config.log file:
> *************************
> This file contains any messages produced by compilers while=20
> running configure, to aid debugging if configure makes a mistake.
>=20
> It was created by Xenomai configure 2.0.1, which was=20
> generated by GNU Autoconf 2.59.  Invocation command line was
>=20
>   $ /opt/src_eldk3.1.1/xenomai/xenomai-2.0.1/configure=20
> CROSS_COMPILE=3Dppc_82xx- CC=3Dppc_82xx-gcc CXX=3Dppc_82xx-g++=20
> LD=3Dppc_82xx-ld AR=3Dppc_82xx-ar RANLIB=3Dppc_82xx-ranlib=20
> STRIP=3Dppc_82xx-strip NM=3Dppc_82xx-nm --build=3Di686-pc-linux-gnu=20
> --host=3Dpowerpc-unknown-linux-gnu=20
> --with-kconfig-file=3D.xeno_config --with-linux-dir=3D=20
> --prefix=3D/usr/realtime
>=20
> ## --------- ##
> ## Platform. ##
> ## --------- ##
>=20
> hostname =3D sashri-lin
> uname -m =3D i686
> uname -r =3D 2.4.21-32.EL
> uname -s =3D Linux
> uname -v =3D #1 Fri Apr 15 21:29:19 EDT 2005
>=20
> /usr/bin/uname -p =3D unknown
> /bin/uname -X     =3D unknown
>=20
> /bin/arch              =3D i686
> /usr/bin/arch -k       =3D unknown
> /usr/convex/getsysinfo =3D unknown
> hostinfo               =3D unknown
> /bin/machine           =3D unknown
> /usr/bin/oslevel       =3D unknown
> /bin/universe          =3D unknown
>=20
> PATH: /users/sashri/bin
> PATH: /home/oracle/orahome/bin
> PATH: /usr/kerberos/bin
> PATH: /bin
> PATH: /usr/bin
> PATH: /usr/bin/X11
> PATH: /usr/local/bin
> PATH: /usr/bin
> PATH: /usr/X11R6/bin
> PATH: ../bin
> PATH: /usr/bin/X11
> PATH: /usr/contrib/bin/X11
> PATH: /users/bin
> PATH: .
> PATH: /usr/softbench/bin
> PATH: /etc
> PATH: /sbin
> PATH: /opt/eldk/eldk3.1.1/usr/bin
> PATH: /opt/eldk/eldk3.1.1/bin
> PATH: //opt/eldk/eldk3.1.1/ppc_82xx/usr/realtime/bin
> PATH: /sbin
> ...
> config.status:1546: executing depfiles commands
> configure:25617: configuring in sim
> configure:25734: running /bin/sh=20
> '/opt/src_eldk3.1.1/xenomai/xenomai-2.0.1/sim/configure'=20
> --prefix=3D/usr/realtime  'CROSS_COMPILE=3Dppc_82xx-'=20
> 'CC=3Dppc_82xx-gcc' 'CXX=3Dppc_82xx-g++' 'LD=3Dppc_82xx-ld'=20
> 'AR=3Dppc_82xx-ar' 'RANLIB=3Dppc_82xx-ranlib'=20
> 'STRIP=3Dppc_82xx-strip' 'NM=3Dppc_82xx-nm'=20
> '--build=3Di686-pc-linux-gnu'=20
> '--host=3Dpowerpc-unknown-linux-gnu'=20
> '--with-kconfig-file=3D.xeno_config' '--with-linux-dir=3D'=20
> '--prefix=3D/usr/realtime' 'build_alias=3Di686-pc-linux-gnu'=20
> 'host_alias=3Dpowerpc-unknown-linux-gnu' --cache-file=3D/dev/null=20
> --srcdir=3D/opt/src_eldk3.1.1/xenomai/xenomai-2.0.1/sim
> configure:25739: error: /bin/sh=20
> '/opt/src_eldk3.1.1/xenomai/xenomai-2.0.1/sim/configure'=20
> failed for sim ...
> configure: exit 1
>=20
> I'll appreciate any help you can give me Thanks, Sarit.
>=20
>=20
>=20
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

