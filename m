From: Younes CHALABI <y.chalabi@sinters.fr>
Date: Mon, 29 Apr 2013 14:10:26 +0000
Message-ID: <A46EF8CF1BBB8E4B8A27B73E177C4664EFD6A3@MAIL-SINTERS-01.sinters-int.fr>
References: <A46EF8CF1BBB8E4B8A27B73E177C4664EFC670@MAIL-SINTERS-01.sinters-int.fr>,
	<517E5A11.7040206@xenomai.org>
In-Reply-To: <517E5A11.7040206@xenomai.org>
Content-Language: fr-FR
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] RE : Xenomai : incompatible feature set (APF27)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

Here is the display I had, when applying the --enable-arm-tsc option with "=
--enable-arm-tsc=3Dimx" :

younes@younes-Latitude-E6530:~/APF27/armadeus-xeno0/buildroot/output/build/=
xenomai-2.6.2.1$ ./configure --enable-arm-tsc=3Dimx
checking build system type... i686-pc-linux-gnu
checking host system type... i686-pc-linux-gnu
checking for a BSD-compatible install... /usr/bin/install -c
checking for gcc... gcc
checking whether the C compiler works... yes
checking for C compiler default output file name... a.out
checking for suffix of executables...=20
checking whether we are cross compiling... no
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether gcc accepts -g... yes
checking for gcc option to accept ISO C89... none needed
checking how to run the C preprocessor... gcc -E
checking target system type... i686-pc-linux-gnu
checking for gcc... gcc
checking whether we are using the GNU C compiler... (cached) yes
checking whether gcc accepts -g... yes
checking for gcc option to accept ISO C89... (cached) none needed
checking how to run the C preprocessor... gcc -E
checking whether build environment is sane... yes
checking for a thread-safe mkdir -p... /bin/mkdir -p
checking for gawk... gawk
checking whether make sets $(MAKE)... yes
checking for style of include used by make... GNU
checking dependency style of gcc... gcc3
checking whether to enable maintainer-specific portions of Makefiles... no
checking dependency style of gcc... gcc3
checking for flex... flex
checking lex output file root... lex.yy
checking lex library... -lfl
checking whether yytext is a pointer... yes
checking for target architecture... x86
checking how to print strings... printf
checking for a sed that does not truncate output... /bin/sed
checking for grep that handles long lines and -e... /bin/grep
checking for egrep... /bin/grep -E
checking for fgrep... /bin/grep -F
checking for ld used by gcc... /usr/bin/ld
checking if the linker (/usr/bin/ld) is GNU ld... yes
checking for BSD- or MS-compatible name lister (nm)... /usr/bin/nm -B
checking the name lister (/usr/bin/nm -B) interface... BSD nm
checking whether ln -s works... yes
checking the maximum length of command line arguments... 1572864
checking whether the shell understands some XSI constructs... yes
checking whether the shell understands "+=3D"... yes
checking how to convert i686-pc-linux-gnu file names to i686-pc-linux-gnu f=
ormat... func_convert_file_noop
checking how to convert i686-pc-linux-gnu file names to toolchain format...=
 func_convert_file_noop
checking for /usr/bin/ld option to reload object files... -r
checking for objdump... objdump
checking how to recognize dependent libraries... pass_all
checking for dlltool... no
checking how to associate runtime and link libraries... printf %s\n
checking for ar... ar
checking for archiver @FILE support... @
checking for strip... strip
checking for ranlib... ranlib
checking command to parse /usr/bin/nm -B output from gcc object... ok
checking for sysroot... no
checking for mt... mt
checking if mt is a manifest tool... no
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
checking whether the gcc linker (/usr/bin/ld) supports shared libraries... =
yes
checking whether -lc should be explicitly linked in... no
checking dynamic linker characteristics... GNU/Linux ld.so
checking how to hardcode library paths into programs... immediate
checking whether stripping libraries is possible... yes
checking if libtool supports shared libraries... yes
checking whether to build shared libraries... yes
checking whether to build static libraries... yes
checking for debug symbols... no
checking for atomic operation support... ad-hoc
checking for SMP support... y
checking for x86 SEP instructions in syscalls... y
checking for x86 TSC support... y
checking whether installing documentation... doc
checking for Doxygen documentation... no
checking for doxygen... no
checking for dot... NO
checking whether compiling Docbook XML documentation... no
checking for xmllint... no
checking for xsltproc... no
checking for fop... no
checking whether Docbook XML documentation generation can use network.... n=
o
checking for docbook-xml root dir... network
checking for docbook-xsl root dir... network
checking whether using LaTeX non-stop mode... no
checking for asciidoc documentation... no
checking for asciidoc... no
checking for a2x... no
checking for w3m... no
checking mqueue.h usability... yes
checking mqueue.h presence... yes
checking for mqueue.h... yes
checking for shm_open... yes
checking for shm_unlink... yes
checking for mmap64... yes
checking for ftruncate64... yes
checking for pthread_mutexattr_setprotocol... yes
checking for pthread_condattr_setclock... yes
checking for pthread_spin_lock... yes
checking for fork... yes
checking for sched_setaffinity... ok
checking for specific GCC switches... done
checking whether ld supports @file... yes
checking whether the POSIX skin library automatically calls mlockall... no
checking whether the pSOS skin library automatically calls mlockall... no
checking whether the uITRON skin library automatically calls mlockall... no
checking whether to enable dlopen support for skin libraries... no
checking for __thread... yes
checking location for test binaries... ${exec_prefix}/bin
configure: creating ./config.status
config.status: creating Makefile
config.status: creating config/Makefile
config.status: creating scripts/Makefile
config.status: creating scripts/xeno-config
config.status: creating scripts/xeno
config.status: creating src/Makefile
config.status: creating src/skins/Makefile
config.status: creating src/skins/common/Makefile
config.status: creating src/skins/posix/Makefile
config.status: creating src/skins/native/Makefile
config.status: creating src/skins/native/libxenomai_native.pc
config.status: creating src/skins/vxworks/Makefile
config.status: creating src/skins/vxworks/libxenomai_vxworks.pc
config.status: creating src/skins/psos+/Makefile
config.status: creating src/skins/psos+/libxenomai_psos+.pc
config.status: creating src/skins/vrtx/Makefile
config.status: creating src/skins/vrtx/libxenomai_vrtx.pc
config.status: creating src/skins/rtdm/Makefile
config.status: creating src/skins/rtdm/libxenomai_rtdm.pc
config.status: creating src/skins/uitron/Makefile
config.status: creating src/skins/uitron/libxenomai_uitron.pc
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
config.status: creating src/testsuite/xeno-test/Makefile
config.status: creating src/testsuite/regression/Makefile
config.status: creating src/testsuite/regression/native/Makefile
config.status: creating src/testsuite/regression/posix/Makefile
config.status: creating src/testsuite/regression/native+posix/Makefile
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
config.status: creating include/asm-x86/ipipe/Makefile
config.status: creating include/asm-powerpc/Makefile
config.status: creating include/asm-powerpc/bits/Makefile
config.status: creating include/asm-arm/Makefile
config.status: creating include/asm-arm/bits/Makefile
config.status: creating include/asm-nios2/Makefile
config.status: creating include/asm-nios2/bits/Makefile
config.status: creating include/asm-sh/Makefile
config.status: creating include/asm-sh/bits/Makefile
config.status: creating include/asm-sim/Makefile
config.status: creating include/asm-sim/bits/Makefile
config.status: creating include/native/Makefile
config.status: creating include/nucleus/Makefile
config.status: creating include/posix/Makefile
config.status: creating include/posix/sys/Makefile
config.status: creating include/psos+/Makefile
config.status: creating include/rtdm/Makefile
config.status: creating include/analogy/Makefile
config.status: creating include/uitron/Makefile
config.status: creating include/vrtx/Makefile
config.status: creating include/vxworks/Makefile
config.status: creating src/skins/posix/libxenomai_posix.pc
config.status: creating doc/Makefile
config.status: creating doc/txt/Makefile
config.status: creating doc/man/Makefile
config.status: creating doc/doxygen/Makefile
config.status: creating doc/doxygen/Doxyfile-common
config.status: creating doc/doxygen/Doxyfile
config.status: creating doc/doxygen/Doxyfile-native
config.status: creating doc/doxygen/Doxyfile-nucleus
config.status: creating doc/doxygen/Doxyfile-posix
config.status: creating doc/doxygen/Doxyfile-rtdm
config.status: creating doc/asciidoc/Makefile
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
config.status: src/include/xeno_config.h is unchanged
config.status: linking ./include/asm-x86 to src/include/asm/xenomai
config.status: linking ./include/asm-generic to src/include/asm-generic/xen=
omai
config.status: executing depfiles commands
config.status: executing libtool commands

Which versions of Linux and Adeos you advise me to use with xenomai-2.6.2.1=
 ? (In the goal to use the xeno-test)


Younes
________________________________________
De : Gilles Chanteperdrix [gilles.chanteperdrix@xenomai.org]
Date d'envoi : lundi 29 avril 2013 13:31
=C0 : Younes CHALABI
Cc : xenomai@xenomai.org
Objet : Re: Xenomai : incompatible feature set (APF27)

On 04/29/2013 12:05 PM, Younes CHALABI wrote:

> Hi all,
>
> I'm using xenomai-2.6.2.1 with the APF27 board using the following config=
uration :
>
> - Buildroot : 2013.02
> - gcc : 4.4.7
> - libc : uClibc 0.9.33.2
> - busybox : 1.21.0
> - U-boot : 2012.04
> - Linux : 2.6.29.6
> - Adeos_patch : adeos-ipipe-2.6.29-arm-1.13-05.patch
>
> The installation and the deployment were done correctly, and after transf=
ered the images on the target. I checked the correct installation of Xenoma=
i on the board with : # dmesg | grep Xenomai and have this display :
>
> I-pipe: Domain Xenomai registered.
> Xenomai: hal/arm started.
> Xenomai: scheduling class idle registered.
> Xenomai: scheduling class rt registered.
> Xenomai: real-time nucleus v2.6.2.1 (Day At The Beach) loaded.
> Xenomai: starting native API services.
> Xenomai: starting POSIX services.
> Xenomai: starting RTDM services.
>
> Now I want to use the tests proposed by Xenomai with : # xeno-test but ha=
ve this following error message :
>
> Started child 472: /bin/sh /usr/bin/xeno-test-run-wrapper /usr/bin/xeno-t=
est
> + echo 0
> + /usr/bin/arith
> Xenomai: incompatible feature set
> (userland requires "kuser_tsc fastsynch", kernel provides "sa1100 eabi fa=
stsynch nosmp", missing=3D"kuser_tsc").
>
> Searching in troubleshooting, I found that I have to --enable-arm-tsc opt=
ion which I did by : ./configure --enable-arm-tsc=3Dimx


Could you show us the messages printed by configure when running it with
this option?

Also note that this happens because you are using the I-pipe patch for
Linux 2.6.29 which is pretty old, and we have not been testing this
configuration for a long time. Linux 2.6.29 was released in 2009. That
is 4 years ago.


--
                                                                Gilles.

