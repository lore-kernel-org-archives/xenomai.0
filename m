Subject: Re: Trouble building the testsuite for Xenomai-3.0.3
References: <CADXNiGVaXo-vmML4kfR=WTgR4ZoorBzDGJVHeq4UGDjimtFpqw@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <44012fc9-9f2a-313f-f333-d2093d22b0c3@siemens.com>
Date: Sat, 28 Aug 2021 13:14:32 +0200
MIME-Version: 1.0
In-Reply-To: <CADXNiGVaXo-vmML4kfR=WTgR4ZoorBzDGJVHeq4UGDjimtFpqw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jackson Jones <jackson.jones@gmail.com>, xenomai@xenomai.org
Cc: Robert Mehranfar <rmehranfar@stellartec.com>

On 27.08.21 21:46, Jackson Jones via Xenomai wrote:
> I am trying to build Xenomai-3.0.3 on antiX-17.4.1_386-full. The processor
> is a Geode. The kernel version 4.4.43 (with the x86 ipipe for that
> version). It builds the libraries, but it fails on the building of the
> testsuite. The version of gcc is 6.3.0.
> 
> Below is a listing of the build and the contents of the xenoconfig.sh.
> I'd appreciate any help in getting around this problem. We cannot
> swith to a new xenomai since this running on a medical device.
> 
> devel@antix1:~/xenomai_build/xenomai-3.0.3$ ./xenoconfig.sh
> checking whether we build for Cobalt or Mercury core... cobalt
> checking build system type... i686-pc-linux-gnu
> checking host system type... i686-pc-linux-gnu
> checking for a BSD-compatible install... /usr/bin/install -c
> checking for gcc... gcc
> checking whether the C compiler works... yes
> checking for C compiler default output file name... a.out
> checking for suffix of executables...
> checking whether we are cross compiling... no
> checking for suffix of object files... o
> checking whether we are using the GNU C compiler... yes
> checking whether gcc accepts -g... yes
> checking for gcc option to accept ISO C89... none needed
> checking whether gcc understands -c and -o together... yes
> checking how to run the C preprocessor... gcc -E
> checking target system type... i686-pc-linux-gnu
> checking for gcc... gcc
> checking whether we are using the GNU C compiler... (cached) yes
> checking whether gcc accepts -g... yes
> checking for gcc option to accept ISO C89... (cached) none needed
> checking whether gcc understands -c and -o together... (cached) yes
> checking how to run the C preprocessor... gcc -E
> checking for grep that handles long lines and -e... /bin/grep
> checking for BSD- or MS-compatible name lister (nm)... /usr/bin/nm -B
> checking the name lister (/usr/bin/nm -B) interface... BSD nm
> checking for gawk... gawk
> checking for a sed that does not truncate output... /bin/sed
> checking for egrep... /bin/grep -E
> checking for fgrep... /bin/grep -F
> checking how to print strings... printf
> checking for ld used by gcc... /usr/bin/ld
> checking if the linker (/usr/bin/ld) is GNU ld... yes
> checking command to parse /usr/bin/nm -B output from gcc object... ok
> checking for _ prefix in compiled symbols... no
> checking whether build environment is sane... yes
> checking for a thread-safe mkdir -p... /bin/mkdir -p
> checking whether make sets $(MAKE)... yes
> checking for style of include used by make... GNU
> checking whether make supports nested variables... yes
> checking whether UID '1000' is supported by ustar format... yes
> checking whether GID '1000' is supported by ustar format... yes
> checking how to create a ustar tar archive... gnutar
> checking dependency style of gcc... gcc3
> checking whether make supports nested variables... (cached) yes
> checking whether to enable maintainer-specific portions of Makefiles... no
> checking dependency style of gcc... gcc3
> checking for flex... flex
> checking lex output file root... lex.yy
> checking lex library... none needed
> checking whether yytext is a pointer... no
> checking for target architecture... x86
> checking whether ln -s works... yes
> checking the maximum length of command line arguments... 1572864
> checking whether the shell understands some XSI constructs... yes
> checking whether the shell understands "+="... yes
> checking how to convert i686-pc-linux-gnu file names to i686-pc-linux-gnu
> format... func_convert_file_noop
> checking how to convert i686-pc-linux-gnu file names to toolchain format...
> func_convert_file_noop
> checking for /usr/bin/ld option to reload object files... -r
> checking for objdump... objdump
> checking how to recognize dependent libraries... pass_all
> checking for dlltool... no
> checking how to associate runtime and link libraries... printf %s\n
> checking for ar... ar
> checking for archiver @FILE support... @
> checking for strip... strip
> checking for ranlib... ranlib
> checking for sysroot... no
> checking for mt... mt
> checking if mt is a manifest tool... no
> checking for ANSI C header files... yes
> checking for sys/types.h... yes
> checking for sys/stat.h... yes
> checking for stdlib.h... yes
> checking for string.h... yes
> checking for memory.h... yes
> checking for strings.h... yes
> checking for inttypes.h... yes
> checking for stdint.h... yes
> checking for unistd.h... yes
> checking for dlfcn.h... yes
> checking for objdir... .libs
> checking if gcc supports -fno-rtti -fno-exceptions... no
> checking for gcc option to produce PIC... -fPIC -DPIC
> checking if gcc PIC flag -fPIC -DPIC works... yes
> checking if gcc static flag -static works... yes
> checking if gcc supports -c -o file.o... yes
> checking if gcc supports -c -o file.o... (cached) yes
> checking whether the gcc linker (/usr/bin/ld) supports shared libraries...
> yes
> checking whether -lc should be explicitly linked in... no
> checking dynamic linker characteristics... GNU/Linux ld.so
> checking how to hardcode library paths into programs... immediate
> checking whether stripping libraries is possible... yes
> checking if libtool supports shared libraries... yes
> checking whether to build shared libraries... yes
> checking whether to build static libraries... yes
> checking whether to enable debug mode... no
> checking whether to enable the low resolution clock... no
> checking whether we may use CLOCK_MONOTONIC_RAW... y
> checking whether assertions should be enabled... no
> checking whether asynchronous cancellation of threads is enabled... no
> checking whether to enable the workaround for broken PI with condvars... no
> checking whether shared multi-processing should be supported... y
> checking whether the registry should be enabled... y, mounted on
> /var/run/xenomai
> checking for pkg-config... /usr/bin/pkg-config
> checking pkg-config is at least version 0.9.0... yes
> checking for FUSE... yes
> checking for SMP support... y
> checking whether to enable sanity checks... y
> checking for x86 VSYSCALL availability... y
> checking whether to build documentation... checking whether to install
> documentation... y
> checking for doxygen... no
> checking for dot... NO
> checking for LaTeX mode... batch
> checking for asciidoc... asciidoc
> checking for a2x... a2x
> checking for w3m... w3m
> checking valgrind/valgrind.h usability... no
> checking valgrind/valgrind.h presence... no
> checking for valgrind/valgrind.h... no
> checking for Valgrind client API... no
> checking mqueue.h usability... yes
> checking mqueue.h presence... yes
> checking for mqueue.h... yes
> checking for pthread_mutexattr_setprotocol... yes
> checking for pthread_mutexattr_getprotocol... yes
> checking for pthread_mutexattr_setrobust_np... yes
> checking for pthread_condattr_getclock... yes
> checking for pthread_condattr_setclock... yes
> checking for pthread_spin_lock... yes
> checking for fork... yes
> checking for pthread_attr_setaffinity_np... yes
> checking for pthread_setaffinity_np... yes
> checking for pthread_getattr_np... yes
> checking for pthread_atfork... yes
> checking for pthread_setname_np... yes
> checking for sched_getcpu... yes
> checking for clock_nanosleep... yes
> checking for shm_open... yes
> checking for shm_unlink... yes
> checking whether PTHREAD_PRIO_NONE is declared... yes
> checking for shm_open... (cached) yes
> checking whether the compiler provides atomic builtins... yes
> checking for fortify support... autodetect
> checking for __vfprintf_chk... yes
> checking whether ld supports @file... yes
> checking whether to enable dlopening of Xenomai libraries... y
> checking whether to enable TLS support... no
> checking location for test executables... /home/linaro/xeno-test
> checking location for demo programs... /home/linaro/xeno-demo
> checking for test source generation... ok
> checking that generated files are newer than configure... done
> configure: creating ./config.status
> config.status: creating Makefile
> config.status: creating config/Makefile
> config.status: creating scripts/Makefile
> config.status: creating scripts/xeno-config
> config.status: creating scripts/xeno
> config.status: creating lib/Makefile
> config.status: creating lib/boilerplate/Makefile
> config.status: creating lib/boilerplate/init/Makefile
> config.status: creating lib/cobalt/Makefile
> config.status: creating lib/cobalt/arch/Makefile
> config.status: creating lib/cobalt/arch/arm/Makefile
> config.status: creating lib/cobalt/arch/arm/include/Makefile
> config.status: creating lib/cobalt/arch/arm/include/asm/Makefile
> config.status: creating lib/cobalt/arch/arm/include/asm/xenomai/Makefile
> config.status: creating lib/cobalt/arch/powerpc/Makefile
> config.status: creating lib/cobalt/arch/powerpc/include/Makefile
> config.status: creating lib/cobalt/arch/powerpc/include/asm/Makefile
> config.status: creating lib/cobalt/arch/powerpc/include/asm/xenomai/Makefile
> config.status: creating lib/cobalt/arch/blackfin/Makefile
> config.status: creating lib/cobalt/arch/blackfin/include/Makefile
> config.status: creating lib/cobalt/arch/blackfin/include/asm/Makefile
> config.status: creating
> lib/cobalt/arch/blackfin/include/asm/xenomai/Makefile
> config.status: creating lib/cobalt/arch/x86/Makefile
> config.status: creating lib/cobalt/arch/x86/include/Makefile
> config.status: creating lib/cobalt/arch/x86/include/asm/Makefile
> config.status: creating lib/cobalt/arch/x86/include/asm/xenomai/Makefile
> config.status: creating lib/mercury/Makefile
> config.status: creating lib/copperplate/Makefile
> config.status: creating lib/copperplate/regd/Makefile
> config.status: creating lib/alchemy/Makefile
> config.status: creating lib/vxworks/Makefile
> config.status: creating lib/psos/Makefile
> config.status: creating lib/analogy/Makefile
> config.status: creating lib/smokey/Makefile
> config.status: creating lib/trank/Makefile
> config.status: creating testsuite/Makefile
> config.status: creating testsuite/latency/Makefile
> config.status: creating testsuite/switchtest/Makefile
> config.status: creating testsuite/smokey/Makefile
> config.status: creating testsuite/smokey/arith/Makefile
> config.status: creating testsuite/smokey/sched-quota/Makefile
> config.status: creating testsuite/smokey/sched-tp/Makefile
> config.status: creating testsuite/smokey/rtdm/Makefile
> config.status: creating testsuite/smokey/vdso-access/Makefile
> config.status: creating testsuite/smokey/posix-cond/Makefile
> config.status: creating testsuite/smokey/posix-mutex/Makefile
> config.status: creating testsuite/smokey/posix-clock/Makefile
> config.status: creating testsuite/smokey/posix-fork/Makefile
> config.status: creating testsuite/smokey/posix-select/Makefile
> config.status: creating testsuite/smokey/xddp/Makefile
> config.status: creating testsuite/smokey/iddp/Makefile
> config.status: creating testsuite/smokey/bufp/Makefile
> config.status: creating testsuite/smokey/sigdebug/Makefile
> config.status: creating testsuite/smokey/timerfd/Makefile
> config.status: creating testsuite/smokey/tsc/Makefile
> config.status: creating testsuite/smokey/leaks/Makefile
> config.status: creating testsuite/smokey/net_udp/Makefile
> config.status: creating testsuite/smokey/net_packet_dgram/Makefile
> config.status: creating testsuite/smokey/net_packet_raw/Makefile
> config.status: creating testsuite/smokey/net_common/Makefile
> config.status: creating testsuite/smokey/cpu-affinity/Makefile
> config.status: creating testsuite/clocktest/Makefile
> config.status: creating testsuite/xeno-test/Makefile
> config.status: creating utils/Makefile
> config.status: creating utils/hdb/Makefile
> config.status: creating utils/can/Makefile
> config.status: creating utils/analogy/Makefile
> config.status: creating utils/ps/Makefile
> config.status: creating utils/slackspot/Makefile
> config.status: creating utils/corectl/Makefile
> config.status: creating utils/autotune/Makefile
> config.status: creating utils/net/rtnet
> config.status: creating utils/net/rtnet.conf
> config.status: creating utils/net/Makefile
> config.status: creating demo/Makefile
> config.status: creating demo/posix/Makefile
> config.status: creating demo/posix/cyclictest/Makefile
> config.status: creating demo/posix/cobalt/Makefile
> config.status: creating demo/alchemy/Makefile
> config.status: creating demo/alchemy/cobalt/Makefile
> config.status: creating include/Makefile
> config.status: creating include/cobalt/uapi/Makefile
> config.status: creating include/cobalt/uapi/asm-generic/Makefile
> config.status: creating include/cobalt/uapi/kernel/Makefile
> config.status: creating include/cobalt/Makefile
> config.status: creating include/cobalt/sys/Makefile
> config.status: creating include/cobalt/kernel/Makefile
> config.status: creating include/cobalt/kernel/rtdm/Makefile
> config.status: creating include/cobalt/kernel/rtdm/analogy/Makefile
> config.status: creating include/cobalt/boilerplate/Makefile
> config.status: creating include/rtdm/Makefile
> config.status: creating include/rtdm/uapi/Makefile
> config.status: creating include/mercury/Makefile
> config.status: creating include/mercury/boilerplate/Makefile
> config.status: creating include/boilerplate/Makefile
> config.status: creating include/copperplate/Makefile
> config.status: creating include/alchemy/Makefile
> config.status: creating include/vxworks/Makefile
> config.status: creating include/psos/Makefile
> config.status: creating include/smokey/Makefile
> config.status: creating include/trank/Makefile
> config.status: creating include/trank/posix/Makefile
> config.status: creating include/trank/native/Makefile
> config.status: creating include/trank/rtdm/Makefile
> config.status: creating include/xenomai/Makefile
> config.status: creating doc/Makefile
> config.status: creating doc/doxygen/Makefile
> config.status: creating doc/doxygen/xeno3prm-common.conf
> config.status: creating doc/doxygen/xeno3prm-html.conf
> config.status: creating doc/doxygen/xeno3prm-latex.conf
> config.status: creating doc/gitdoc/Makefile
> config.status: creating doc/asciidoc/Makefile
> config.status: creating include/xeno_config.h
> config.status: executing depfiles commands
> config.status: executing libtool commands
> devel@antix1: ~/xenomai_build/xenomai-3.0.3
> Making all in doc
> make[1]: Entering directory '/home/devel/xenomai_build/xenomai-3.0.3/doc'
> Making all in gitdoc
> make[2]: Entering directory
> '/home/devel/xenomai_build/xenomai-3.0.3/doc/gitdoc'
> make[2]: Leaving directory
> '/home/devel/xenomai_build/xenomai-3.0.3/doc/gitdoc'
> Making all in doxygen
> make[2]: Entering directory
> '/home/devel/xenomai_build/xenomai-3.0.3/doc/doxygen'
> make[2]: Nothing to be done for 'all'.
> make[2]: Leaving directory
> '/home/devel/xenomai_build/xenomai-3.0.3/doc/doxygen'
> Making all in asciidoc
> make[2]: Entering directory
> '/home/devel/xenomai_build/xenomai-3.0.3/doc/asciidoc'
> make[2]: Nothing to be done for 'all'.
> make[2]: Leaving directory
> '/home/devel/xenomai_build/xenomai-3.0.3/doc/asciidoc'
> make[2]: Entering directory '/home/devel/xenomai_build/xenomai-3.0.3/doc'
> make[2]: Nothing to be done for 'all-am'.
> make[2]: Leaving directory '/home/devel/xenomai_build/xenomai-3.0.3/doc'
> make[1]: Leaving directory '/home/devel/xenomai_build/xenomai-3.0.3/doc'
> Making all in lib
> make[1]: Entering directory '/home/devel/xenomai_build/xenomai-3.0.3/lib'
> Making all in boilerplate
> make[2]: Entering directory
> '/home/devel/xenomai_build/xenomai-3.0.3/lib/boilerplate'
> make  all-recursive
> make[3]: Entering directory
> '/home/devel/xenomai_build/xenomai-3.0.3/lib/boilerplate'
> Making all in init
> make[4]: Entering directory
> '/home/devel/xenomai_build/xenomai-3.0.3/lib/boilerplate/init'
>   CC       libbootstrap_a-bootstrap.o
>   AR       libbootstrap.a
> ar: `u' modifier ignored since `D' is the default (see `U')
>   CC       libbootstrap_pic_la-bootstrap.lo
>   CCLD     libbootstrap-pic.la
> ar: `u' modifier ignored since `D' is the default (see `U')
> make[4]: Leaving directory
> '/home/devel/xenomai_build/xenomai-3.0.3/lib/boilerplate/init'
> make[4]: Entering directory
> '/home/devel/xenomai_build/xenomai-3.0.3/lib/boilerplate'
>   CC       libversion_la-version.lo
>   CCLD     libversion.la
> ar: `u' modifier ignored since `D' is the default (see `U')
>   CC       iniparser/libiniparser_la-dictionary.lo
>   CC       iniparser/libiniparser_la-iniparser.lo
>   CCLD     libiniparser.la
> ar: `u' modifier ignored since `D' is the default (see `U')
>   CC       libboilerplate_la-ancillaries.lo
>   CC       libboilerplate_la-hash.lo
>   CC       libboilerplate_la-obstack.lo
>   CC       libboilerplate_la-setup.lo
>   CC       libboilerplate_la-time.lo
>   CC       libboilerplate_la-wrappers.lo
>   CC       tlsf/libtlsf_la-tlsf.lo
>   CCLD     libtlsf.la
> ar: `u' modifier ignored since `D' is the default (see `U')
>   CCLD     libboilerplate.la
> ar: `u' modifier ignored since `D' is the default (see `U')
>   CC       version-version.o
>   CCLD     version
> make[4]: Leaving directory
> '/home/devel/xenomai_build/xenomai-3.0.3/lib/boilerplate'
> make[3]: Leaving directory
> '/home/devel/xenomai_build/xenomai-3.0.3/lib/boilerplate'
> make[2]: Leaving directory
> '/home/devel/xenomai_build/xenomai-3.0.3/lib/boilerplate'
> Making all in cobalt
> make[2]: Entering directory
> '/home/devel/xenomai_build/xenomai-3.0.3/lib/cobalt'
> Making all in arch
> make[3]: Entering directory
> '/home/devel/xenomai_build/xenomai-3.0.3/lib/cobalt/arch'
> Making all in x86
> make[4]: Entering directory
> '/home/devel/xenomai_build/xenomai-3.0.3/lib/cobalt/arch/x86'
> Making all in include
> make[5]: Entering directory
> '/home/devel/xenomai_build/xenomai-3.0.3/lib/cobalt/arch/x86/include'
> Making all in asm
> make[6]: Entering directory
> '/home/devel/xenomai_build/xenomai-3.0.3/lib/cobalt/arch/x86/include/asm'
> Making all in xenomai
> make[7]: Entering directory
> '/home/devel/xenomai_build/xenomai-3.0.3/lib/cobalt/arch/x86/include/asm/xenomai'
> make[7]: Nothing to be done for 'all'.
> make[7]: Leaving directory
> '/home/devel/xenomai_build/xenomai-3.0.3/lib/cobalt/arch/x86/include/asm/xenomai'
> make[7]: Entering directory
> '/home/devel/xenomai_build/xenomai-3.0.3/lib/cobalt/arch/x86/include/asm'
> make[7]: Nothing to be done for 'all-am'.
> make[7]: Leaving directory
> '/home/devel/xenomai_build/xenomai-3.0.3/lib/cobalt/arch/x86/include/asm'
> make[6]: Leaving directory
> '/home/devel/xenomai_build/xenomai-3.0.3/lib/cobalt/arch/x86/include/asm'
> make[6]: Entering directory
> '/home/devel/xenomai_build/xenomai-3.0.3/lib/cobalt/arch/x86/include'
> make[6]: Nothing to be done for 'all-am'.
> make[6]: Leaving directory
> '/home/devel/xenomai_build/xenomai-3.0.3/lib/cobalt/arch/x86/include'
> make[5]: Leaving directory
> '/home/devel/xenomai_build/xenomai-3.0.3/lib/cobalt/arch/x86/include'
> make[5]: Entering directory
> '/home/devel/xenomai_build/xenomai-3.0.3/lib/cobalt/arch/x86'
>   CC       libarch_la-features.lo
>   CCLD     libarch.la
> libtool: link: warning: `-version-info/-version-number' is ignored for
> convenience libraries
> ar: `u' modifier ignored since `D' is the default (see `U')
> make[5]: Leaving directory
> '/home/devel/xenomai_build/xenomai-3.0.3/lib/cobalt/arch/x86'
> make[4]: Leaving directory
> '/home/devel/xenomai_build/xenomai-3.0.3/lib/cobalt/arch/x86'
> make[4]: Entering directory
> '/home/devel/xenomai_build/xenomai-3.0.3/lib/cobalt/arch'
> make[4]: Nothing to be done for 'all-am'.
> make[4]: Leaving directory
> '/home/devel/xenomai_build/xenomai-3.0.3/lib/cobalt/arch'
> make[3]: Leaving directory
> '/home/devel/xenomai_build/xenomai-3.0.3/lib/cobalt/arch'
> make[3]: Entering directory
> '/home/devel/xenomai_build/xenomai-3.0.3/lib/cobalt'
>   CC       libcobalt_la-assert_context.lo
>   CC       libcobalt_la-attr.lo
>   CC       libcobalt_la-clock.lo
>   CC       libcobalt_la-cond.lo
>   CC       libcobalt_la-current.lo
>   CC       libcobalt_la-init.lo
>   CC       libcobalt_la-internal.lo
>   CC       libcobalt_la-mq.lo
>   CC       libcobalt_la-mutex.lo
>   CC       libcobalt_la-printf.lo
>   CC       libcobalt_la-rtdm.lo
>   CC       libcobalt_la-sched.lo
>   CC       libcobalt_la-select.lo
>   CC       libcobalt_la-semaphore.lo
>   CC       libcobalt_la-signal.lo
>   CC       libcobalt_la-sigshadow.lo
>   CC       libcobalt_la-thread.lo
>   CC       libcobalt_la-ticks.lo
>   CC       libcobalt_la-timer.lo
>   CC       libcobalt_la-timerfd.lo
>   CC       libcobalt_la-trace.lo
>   CC       libcobalt_la-umm.lo
>   CC       libcobalt_la-wrappers.lo
>   CCLD     libcobalt.la
> ar: `u' modifier ignored since `D' is the default (see `U')
> make[3]: Leaving directory
> '/home/devel/xenomai_build/xenomai-3.0.3/lib/cobalt'
> make[2]: Leaving directory
> '/home/devel/xenomai_build/xenomai-3.0.3/lib/cobalt'
> Making all in analogy
> make[2]: Entering directory
> '/home/devel/xenomai_build/xenomai-3.0.3/lib/analogy'
>   CC       libanalogy_la-async.lo
>   CC       libanalogy_la-descriptor.lo
>   CC       libanalogy_la-info.lo
>   CC       libanalogy_la-math.lo
>   CC       libanalogy_la-calibration.lo
>   CC       libanalogy_la-range.lo
>   CC       libanalogy_la-sync.lo
>   CC       libanalogy_la-sys.lo
>   CCLD     libanalogy.la
> ar: `u' modifier ignored since `D' is the default (see `U')
> make[2]: Leaving directory
> '/home/devel/xenomai_build/xenomai-3.0.3/lib/analogy'
> Making all in trank
> make[2]: Entering directory
> '/home/devel/xenomai_build/xenomai-3.0.3/lib/trank'
>   CC       libtrank_la-init.lo
>   CC       libtrank_la-internal.lo
>   CC       libtrank_la-posix.lo
>   CC       libtrank_la-native.lo
>   CCLD     libtrank.la
> ar: `u' modifier ignored since `D' is the default (see `U')
> make[2]: Leaving directory
> '/home/devel/xenomai_build/xenomai-3.0.3/lib/trank'
> Making all in copperplate
> make[2]: Entering directory
> '/home/devel/xenomai_build/xenomai-3.0.3/lib/copperplate'
> Making all in .
> make[3]: Entering directory
> '/home/devel/xenomai_build/xenomai-3.0.3/lib/copperplate'
>   CC       libcopperplate_la-clockobj.lo
>   CC       libcopperplate_la-cluster.lo
>   CC       libcopperplate_la-eventobj.lo
>   CC       libcopperplate_la-init.lo
>   CC       libcopperplate_la-internal.lo
>   CC       libcopperplate_la-syncobj.lo
>   CC       libcopperplate_la-semobj.lo
>   CC       libcopperplate_la-threadobj.lo
>   CC       libcopperplate_la-timerobj.lo
>   CC       libcopperplate_la-traceobj.lo
>   CC       libcopperplate_la-wrappers.lo
>   CC       libcopperplate_la-heapobj-pshared.lo
>   CC       libcopperplate_la-reference.lo
>   CC       libcopperplate_la-heapobj-tlsf.lo
>   CC       libregistry_la-registry.lo
>   CCLD     libregistry.la
> ar: `u' modifier ignored since `D' is the default (see `U')
>   CCLD     libcopperplate.la
> ar: `u' modifier ignored since `D' is the default (see `U')
> make[3]: Leaving directory
> '/home/devel/xenomai_build/xenomai-3.0.3/lib/copperplate'
> Making all in regd
> make[3]: Entering directory
> '/home/devel/xenomai_build/xenomai-3.0.3/lib/copperplate/regd'
>   CC       regd.o
>   CC       fs-common.o
>   CC       fs-cobalt.o
>   CCLD     sysregd
> make[3]: Leaving directory
> '/home/devel/xenomai_build/xenomai-3.0.3/lib/copperplate/regd'
> make[2]: Leaving directory
> '/home/devel/xenomai_build/xenomai-3.0.3/lib/copperplate'
> Making all in smokey
> make[2]: Entering directory
> '/home/devel/xenomai_build/xenomai-3.0.3/lib/smokey'
>   CC       libsmokey_la-helpers.lo
>   CC       libsmokey_la-init.lo
>   CCLD     libsmokey.la
> ar: `u' modifier ignored since `D' is the default (see `U')
> make[2]: Leaving directory
> '/home/devel/xenomai_build/xenomai-3.0.3/lib/smokey'
> Making all in alchemy
> make[2]: Entering directory
> '/home/devel/xenomai_build/xenomai-3.0.3/lib/alchemy'
>   CC       libalchemy_la-init.lo
>   CC       libalchemy_la-internal.lo
>   CC       libalchemy_la-alarm.lo
>   CC       libalchemy_la-buffer.lo
>   CC       libalchemy_la-cond.lo
>   CC       libalchemy_la-event.lo
>   CC       libalchemy_la-heap.lo
>   CC       libalchemy_la-mutex.lo
>   CC       libalchemy_la-queue.lo
>   CC       libalchemy_la-task.lo
>   CC       libalchemy_la-sem.lo
>   CC       libalchemy_la-timer.lo
>   CC       libalchemy_la-pipe.lo
>   CCLD     libalchemy.la
> ar: `u' modifier ignored since `D' is the default (see `U')
> make[2]: Leaving directory
> '/home/devel/xenomai_build/xenomai-3.0.3/lib/alchemy'
> Making all in vxworks
> make[2]: Entering directory
> '/home/devel/xenomai_build/xenomai-3.0.3/lib/vxworks'
>   CC       libvxworks_la-init.lo
>   CC       libvxworks_la-errnoLib.lo
>   CC       libvxworks_la-intLib.lo
>   CC       libvxworks_la-kernLib.lo
>   CC       libvxworks_la-lstLib.lo
>   CC       libvxworks_la-memPartLib.lo
>   CC       libvxworks_la-msgQLib.lo
>   CC       libvxworks_la-rngLib.lo
>   CC       libvxworks_la-semLib.lo
>   CC       libvxworks_la-taskLib.lo
>   CC       libvxworks_la-taskHookLib.lo
>   CC       libvxworks_la-taskInfo.lo
>   CC       libvxworks_la-tickLib.lo
>   CC       libvxworks_la-wdLib.lo
>   CC       libvxworks_la-sysLib.lo
>   CCLD     libvxworks.la
> ar: `u' modifier ignored since `D' is the default (see `U')
> make[2]: Leaving directory
> '/home/devel/xenomai_build/xenomai-3.0.3/lib/vxworks'
> Making all in psos
> make[2]: Entering directory
> '/home/devel/xenomai_build/xenomai-3.0.3/lib/psos'
>   CC       libpsos_la-init.lo
>   CC       libpsos_la-pt.lo
>   CC       libpsos_la-queue.lo
>   CC       libpsos_la-rn.lo
>   CC       libpsos_la-sem.lo
>   CC       libpsos_la-task.lo
>   CC       libpsos_la-tm.lo
>   CCLD     libpsos.la
> ar: `u' modifier ignored since `D' is the default (see `U')
> make[2]: Leaving directory
> '/home/devel/xenomai_build/xenomai-3.0.3/lib/psos'
> make[2]: Entering directory '/home/devel/xenomai_build/xenomai-3.0.3/lib'
> make[2]: Nothing to be done for 'all-am'.
> make[2]: Leaving directory '/home/devel/xenomai_build/xenomai-3.0.3/lib'
> make[1]: Leaving directory '/home/devel/xenomai_build/xenomai-3.0.3/lib'
> Making all in config
> make[1]: Entering directory '/home/devel/xenomai_build/xenomai-3.0.3/config'
> make[1]: Nothing to be done for 'all'.
> make[1]: Leaving directory '/home/devel/xenomai_build/xenomai-3.0.3/config'
> Making all in include
> make[1]: Entering directory
> '/home/devel/xenomai_build/xenomai-3.0.3/include'
> make  all-recursive
> make[2]: Entering directory
> '/home/devel/xenomai_build/xenomai-3.0.3/include'
> Making all in boilerplate
> make[3]: Entering directory
> '/home/devel/xenomai_build/xenomai-3.0.3/include/boilerplate'
> make[3]: Nothing to be done for 'all'.
> make[3]: Leaving directory
> '/home/devel/xenomai_build/xenomai-3.0.3/include/boilerplate'
> Making all in copperplate
> make[3]: Entering directory
> '/home/devel/xenomai_build/xenomai-3.0.3/include/copperplate'
> make[3]: Nothing to be done for 'all'.
> make[3]: Leaving directory
> '/home/devel/xenomai_build/xenomai-3.0.3/include/copperplate'
> Making all in smokey
> make[3]: Entering directory
> '/home/devel/xenomai_build/xenomai-3.0.3/include/smokey'
> make[3]: Nothing to be done for 'all'.
> make[3]: Leaving directory
> '/home/devel/xenomai_build/xenomai-3.0.3/include/smokey'
> Making all in alchemy
> make[3]: Entering directory
> '/home/devel/xenomai_build/xenomai-3.0.3/include/alchemy'
> make[3]: Nothing to be done for 'all'.
> make[3]: Leaving directory
> '/home/devel/xenomai_build/xenomai-3.0.3/include/alchemy'
> Making all in psos
> make[3]: Entering directory
> '/home/devel/xenomai_build/xenomai-3.0.3/include/psos'
> make[3]: Nothing to be done for 'all'.
> make[3]: Leaving directory
> '/home/devel/xenomai_build/xenomai-3.0.3/include/psos'
> Making all in trank
> make[3]: Entering directory
> '/home/devel/xenomai_build/xenomai-3.0.3/include/trank'
> Making all in posix
> make[4]: Entering directory
> '/home/devel/xenomai_build/xenomai-3.0.3/include/trank/posix'
> make[4]: Nothing to be done for 'all'.
> make[4]: Leaving directory
> '/home/devel/xenomai_build/xenomai-3.0.3/include/trank/posix'
> Making all in native
> make[4]: Entering directory
> '/home/devel/xenomai_build/xenomai-3.0.3/include/trank/native'
> make[4]: Nothing to be done for 'all'.
> make[4]: Leaving directory
> '/home/devel/xenomai_build/xenomai-3.0.3/include/trank/native'
> Making all in rtdm
> make[4]: Entering directory
> '/home/devel/xenomai_build/xenomai-3.0.3/include/trank/rtdm'
> make[4]: Nothing to be done for 'all'.
> make[4]: Leaving directory
> '/home/devel/xenomai_build/xenomai-3.0.3/include/trank/rtdm'
> make[4]: Entering directory
> '/home/devel/xenomai_build/xenomai-3.0.3/include/trank'
> make[4]: Nothing to be done for 'all-am'.
> make[4]: Leaving directory
> '/home/devel/xenomai_build/xenomai-3.0.3/include/trank'
> make[3]: Leaving directory
> '/home/devel/xenomai_build/xenomai-3.0.3/include/trank'
> Making all in vxworks
> make[3]: Entering directory
> '/home/devel/xenomai_build/xenomai-3.0.3/include/vxworks'
> make[3]: Nothing to be done for 'all'.
> make[3]: Leaving directory
> '/home/devel/xenomai_build/xenomai-3.0.3/include/vxworks'
> Making all in xenomai
> make[3]: Entering directory
> '/home/devel/xenomai_build/xenomai-3.0.3/include/xenomai'
> make[3]: Nothing to be done for 'all'.
> make[3]: Leaving directory
> '/home/devel/xenomai_build/xenomai-3.0.3/include/xenomai'
> Making all in cobalt
> make[3]: Entering directory
> '/home/devel/xenomai_build/xenomai-3.0.3/include/cobalt'
> Making all in boilerplate
> make[4]: Entering directory
> '/home/devel/xenomai_build/xenomai-3.0.3/include/cobalt/boilerplate'
> make[4]: Nothing to be done for 'all'.
> make[4]: Leaving directory
> '/home/devel/xenomai_build/xenomai-3.0.3/include/cobalt/boilerplate'
> Making all in kernel
> make[4]: Entering directory
> '/home/devel/xenomai_build/xenomai-3.0.3/include/cobalt/kernel'
> Making all in rtdm
> make[5]: Entering directory
> '/home/devel/xenomai_build/xenomai-3.0.3/include/cobalt/kernel/rtdm'
> Making all in analogy
> make[6]: Entering directory
> '/home/devel/xenomai_build/xenomai-3.0.3/include/cobalt/kernel/rtdm/analogy'
> make[6]: Nothing to be done for 'all'.
> make[6]: Leaving directory
> '/home/devel/xenomai_build/xenomai-3.0.3/include/cobalt/kernel/rtdm/analogy'
> make[6]: Entering directory
> '/home/devel/xenomai_build/xenomai-3.0.3/include/cobalt/kernel/rtdm'
> make[6]: Nothing to be done for 'all-am'.
> make[6]: Leaving directory
> '/home/devel/xenomai_build/xenomai-3.0.3/include/cobalt/kernel/rtdm'
> make[5]: Leaving directory
> '/home/devel/xenomai_build/xenomai-3.0.3/include/cobalt/kernel/rtdm'
> make[5]: Entering directory
> '/home/devel/xenomai_build/xenomai-3.0.3/include/cobalt/kernel'
> make[5]: Nothing to be done for 'all-am'.
> make[5]: Leaving directory
> '/home/devel/xenomai_build/xenomai-3.0.3/include/cobalt/kernel'
> make[4]: Leaving directory
> '/home/devel/xenomai_build/xenomai-3.0.3/include/cobalt/kernel'
> Making all in sys
> make[4]: Entering directory
> '/home/devel/xenomai_build/xenomai-3.0.3/include/cobalt/sys'
> make[4]: Nothing to be done for 'all'.
> make[4]: Leaving directory
> '/home/devel/xenomai_build/xenomai-3.0.3/include/cobalt/sys'
> Making all in uapi
> make[4]: Entering directory
> '/home/devel/xenomai_build/xenomai-3.0.3/include/cobalt/uapi'
> Making all in asm-generic
> make[5]: Entering directory
> '/home/devel/xenomai_build/xenomai-3.0.3/include/cobalt/uapi/asm-generic'
> make[5]: Nothing to be done for 'all'.
> make[5]: Leaving directory
> '/home/devel/xenomai_build/xenomai-3.0.3/include/cobalt/uapi/asm-generic'
> Making all in kernel
> make[5]: Entering directory
> '/home/devel/xenomai_build/xenomai-3.0.3/include/cobalt/uapi/kernel'
> make[5]: Nothing to be done for 'all'.
> make[5]: Leaving directory
> '/home/devel/xenomai_build/xenomai-3.0.3/include/cobalt/uapi/kernel'
> make[5]: Entering directory
> '/home/devel/xenomai_build/xenomai-3.0.3/include/cobalt/uapi'
> make[5]: Nothing to be done for 'all-am'.
> make[5]: Leaving directory
> '/home/devel/xenomai_build/xenomai-3.0.3/include/cobalt/uapi'
> make[4]: Leaving directory
> '/home/devel/xenomai_build/xenomai-3.0.3/include/cobalt/uapi'
> make[4]: Entering directory
> '/home/devel/xenomai_build/xenomai-3.0.3/include/cobalt'
> make[4]: Nothing to be done for 'all-am'.
> make[4]: Leaving directory
> '/home/devel/xenomai_build/xenomai-3.0.3/include/cobalt'
> make[3]: Leaving directory
> '/home/devel/xenomai_build/xenomai-3.0.3/include/cobalt'
> Making all in rtdm
> make[3]: Entering directory
> '/home/devel/xenomai_build/xenomai-3.0.3/include/rtdm'
> Making all in uapi
> make[4]: Entering directory
> '/home/devel/xenomai_build/xenomai-3.0.3/include/rtdm/uapi'
> make[4]: Nothing to be done for 'all'.
> make[4]: Leaving directory
> '/home/devel/xenomai_build/xenomai-3.0.3/include/rtdm/uapi'
> make[4]: Entering directory
> '/home/devel/xenomai_build/xenomai-3.0.3/include/rtdm'
> make[4]: Nothing to be done for 'all-am'.
> make[4]: Leaving directory
> '/home/devel/xenomai_build/xenomai-3.0.3/include/rtdm'
> make[3]: Leaving directory
> '/home/devel/xenomai_build/xenomai-3.0.3/include/rtdm'
> make[3]: Entering directory
> '/home/devel/xenomai_build/xenomai-3.0.3/include'
> make[3]: Leaving directory '/home/devel/xenomai_build/xenomai-3.0.3/include'
> make[2]: Leaving directory '/home/devel/xenomai_build/xenomai-3.0.3/include'
> make[1]: Leaving directory '/home/devel/xenomai_build/xenomai-3.0.3/include'
> Making all in scripts
> make[1]: Entering directory
> '/home/devel/xenomai_build/xenomai-3.0.3/scripts'
> make[1]: Nothing to be done for 'all'.
> make[1]: Leaving directory '/home/devel/xenomai_build/xenomai-3.0.3/scripts'
> Making all in testsuite
> make[1]: Entering directory
> '/home/devel/xenomai_build/xenomai-3.0.3/testsuite'
> Making all in latency
> make[2]: Entering directory
> '/home/devel/xenomai_build/xenomai-3.0.3/testsuite/latency'
>   CC       latency-latency.o
>   CCLD     latency
> /usr/bin/ld: -r and -pie may not be used together
> collect2: error: ld returned 1 exit status
> Makefile:449: recipe for target 'latency' failed

Already had a look at "make V=1" inside that folder? I suspect the local
compiler injects something here. Neither -r nor -pie are coming from the
Xenomai build system.

Also note that 3.0.3 is lacking 8 stable releases behind the latest 3.0
version.

Jan

> make[2]: *** [latency] Error 1
> make[2]: Leaving directory
> '/home/devel/xenomai_build/xenomai-3.0.3/testsuite/latency'
> Makefile:417: recipe for target 'all-recursive' failed
> make[1]: *** [all-recursive] Error 1
> make[1]: Leaving directory
> '/home/devel/xenomai_build/xenomai-3.0.3/testsuite'
> Makefile:458: recipe for target 'all-recursive' failed
> make: *** [all-recursive] Error 1
> devel@antix1:~/xenomai_build/xenomai-3.0.3$ exit
> 
> ----------------------------------------------------------------------------------------------------
> 
> xenoconfig.sh:
> 
> #!/bin/bash
> 
> #export CFLAGS=-O2 LIBS=-lposix
> 
> ./configure \
>     --with-core=cobalt \
>     --enable-smp \
>     --enable-registry \
>     --enable-pshared \
>     --enable-dlopen-libs \
>     --enable-sanity \
>     --disable-tls \
>     --enable-valgrind-client \
>     --disable-assert \
>     --with-testdir=/home/linaro/xeno-test \
>     --with-demodir=/home/linaro/xeno-demo
> 

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

