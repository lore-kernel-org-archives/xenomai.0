Subject: Re: [Xenomai-help] Adeos/Xenomai Arm Port
From: =?ISO-8859-1?Q?Schl=E4gl?= "Manfred jun." <manfred.schlaegl@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-14Z2AnoH/rzyA9as9sCy"
Date: Tue, 17 Oct 2006 17:39:45 +0200
Message-Id: <1161099585.5024.48.camel@domain.hid>
Mime-Version: 1.0
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


--=-14Z2AnoH/rzyA9as9sCy
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi again!

I've forgotten: I'm using ipipe-1.5-01 on 2.6.15.7 (builtin xenomai
(skins+drivers))

1. spin_debug messages
2. switchtest
3. switchbench
4. cyclictest
5. latency
6. cross-compiled xenomai


Next time i will send my patch too. (i've to clean it a little bit)

-------------

1. With enabled kernel-debugging (spin_debug), while loading xeno_native
(built-in and as module) I get:

[42949377.340000] BUG: spinlock already unlocked on CPU#0, swapper/0
[42949377.340000]  lock: c02dde74, .magic: dead4ead, .owner:
swapper/0, .owner_cpu: 0
[42949377.340000] [<c0125f3c>] (dump_stack+0x0/0x14) from [<c0216a30>]
(spin_bug+0x90/0xa8)
[42949377.340000] [<c02169a0>] (spin_bug+0x0/0xa8) from [<c0216cb4>]
(_raw_spin_unlock+0xa0/0xb8)
[42949377.340000]  r6 =3D 00000000  r5 =3D C031F1E4  r4 =3D C02DDE74=20
[42949377.340000] [<c0216c14>] (_raw_spin_unlock+0x0/0xb8) from
[<c02b0ee4>] (_spin_unlock+0x10/0x14)
[42949377.340000]  r4 =3D 00000005=20
[42949377.340000] [<c02b0ed4>] (_spin_unlock+0x0/0x14) from [<c0121e20>]
(asm_do_IRQ+0x11c/0x138)
[42949377.340000] [<c0121d04>] (asm_do_IRQ+0x0/0x138) from [<c01505e4>]
(__ipipe_sync_stage+0x1f4/0x208)
[42949377.340000] [<c01503f0>] (__ipipe_sync_stage+0x0/0x208) from
[<c0150810>] (ipipe_suspend_domain+0x7c/0xa8)
[42949377.340000] [<c0150794>] (ipipe_suspend_domain+0x0/0xa8) from
[<c01509f8>] (__ipipe_walk_pipeline+0x8c/0xc8)
[42949377.340000]  r8 =3D 00000001  r7 =3D C02E05D8  r6 =3D C02E05E0  r5 =
=3D
00000000
[42949377.340000]  r4 =3D C02E05E0=20
[42949377.340000] [<c015096c>] (__ipipe_walk_pipeline+0x0/0xc8) from
[<c0127618>] (__ipipe_handle_irq+0x140/0x1cc)
[42949377.340000]  r7 =3D C0365BC0  r6 =3D 000000A0  r5 =3D 00000005  r4 =
=3D
C0367920
[42949377.340000] [<c01274d8>] (__ipipe_handle_irq+0x0/0x1cc) from
[<c01276d4>] (__ipipe_grab_irq+0x30/0xe8)
[42949377.340000] [<c01276a4>] (__ipipe_grab_irq+0x0/0xe8) from
[<c0120844>] (__irq_svc+0x24/0xd4)
[42949377.340000] [<c01226c4>] (default_idle+0x0/0x68) from [<c012276c>]
(cpu_idle+0x40/0x5c)
[42949377.340000] [<c012272c>] (cpu_idle+0x0/0x5c) from [<c0120024>]
(__init_end+0x24/0x2c)
[42949377.340000]  r6 =3D C02DDE6C  r5 =3D C032029C  r4 =3D C037E6D0=20
[42949377.340000] [<c0120000>] (__init_end+0x0/0x2c) from [<c0108920>]
(start_kernel+0x120/0x16c)
[42949377.340000] [<c0108800>] (start_kernel+0x0/0x16c) from
[<00108094>] (0x108094)
[42949377.340000]  r4 =3D 00053175=20

/*
 * do_IRQ handles all hardware IRQ's.  Decoded IRQs should not
 * come via this function.  Instead, they should provide their
 * own 'handler'
 */
asmlinkage void asm_do_IRQ(unsigned int irq, struct pt_regs *regs)
{
	struct irqdesc *desc =3D irq_desc + irq;

	/*
	 * Some hardware gives randomly wrong interrupts.  Rather
	 * than crashing, do something sensible.
	 */
	if (irq >=3D NR_IRQS)
		desc =3D &bad_irq_desc;

	irq_enter();
	spin_lock(&irq_controller_lock);

	desc_handle_irq(irq, desc, regs);// unlocks irq_controller_lock

	/*
	 * Now re-run any pending interrupts.
	 */
	if (!list_empty(&irq_pending))
		do_pending_irqs(regs);

	irq_finish(irq);

	spin_unlock(&irq_controller_lock);
	irq_exit();
}

Is this normal, or could this also depend on a "main-bug".



2. switchtest
is running normally

3. switchbench
switchtest works with periods of about 10000 us
-sh-3.00# ./run -- -p 10000        =20
*
*
* Type ^C to stop this application.
*
*
=3D=3D Sampling period: 10000 us
=3D=3D Do not interrupt this program

RTH|     lat min|     lat avg|     lat max|        lost
RTD|       77039|       89337|      150824|           0

works, but

./run -- -n 100 -p 100 (switchbench)

Most of time the system simply stands still (no more timer-activity),
but here i've a kernel-fault with debug-symbols:

[   53.650000] Unable to handle kernel NULL pointer dereference at
virtual address 00000004
[   53.650000] pgd =3D c34c4000
[   53.650000] [00000004] *pgd=3D03b9f031, *pte=3D00000000, *ppte=3D0000000=
0
[   53.650000] Internal error: Oops: 17 [#1]
[   53.650000] Modules linked in:
[   53.650000] CPU: 0
[   53.650000] PC is at xnpod_schedule+0x57c/0x7ec
[   53.650000] LR is at xnpod_schedule+0x570/0x7ec
[   53.650000] pc : [<c01573e8>]    lr : [<c01573dc>]    Not tainted
[   53.650000] sp : c347fddc  ip : c354a044  fp : c347fe10
[   53.650000] r10: c0368e30  r9 : c00c292c  r8 : 00000000
[   53.650000] r7 : 3a485725  r6 : 00000000  r5 : c3487ab4  r4 :
ffffffff
[   53.650000] r3 : 00000000  r2 : 00000000  r1 : c00c292c  r0 :
c354a000
[   53.650000] Flags: NzCv  IRQs off  FIQs on  Mode SVC_32  Segment user
[   53.650000] Control: 5317F  Table: 034C4000  DAC: 00000015
[   53.650000] Process worker (pid: 100, stack limit =3D 0xc347e194)
[   53.650000] Stack: (0xc347fddc to 0xc3480000)
[   53.650000] fdc0:
c0368e00=20
[   53.650000] fde0: c00c292c 00000000 00000000 c0368e00 00000100
c02e05c0 00000001 c347fe38=20
[   53.650000] fe00: c347fe0c c01579e4 c0156e7c c0368e00 00000001
00000000 c347e000 c02e05c0=20
[   53.650000] fe20: 00000001 c00c292c 00000000 c347fe70 c347fe3c
c015c6f4 c0157834 00000000=20
[   53.650000] fe40: c0153990 00000001 c0367050 c00c292c c0365fc0
c0365ba0 20000093 00000001=20
[   53.650000] fe60: 00000000 c347fe8c c347fe74 c0157be8 c015c52c
c00c2f20 c0367050 c0365ba0=20
[   53.650000] fe80: c347fe9c c347fe90 c0158950 c0157b38 c347feb4
c347fea0 c01539ec c015890c=20
[   53.650000] fea0: 00000000 c348000c c347fec8 c347feb8 c0245040
c01539dc 00000000 c347ff0c=20
[   53.650000] fec0: c347fecc c01506f0 c0244ff8 00000000 00000001
c0367900 c0365ba0 c348000c=20
[   53.650000] fee0: 00000000 c02de2cc c3480040 c02e05d8 c0367380
c02e05d8 c02de33c 00000017=20
[   53.650000] ff00: c347ff4c c347ff10 c0128aa0 c0150608 20000013
ffffffff c348000c 00000017=20
[   53.650000] ff20: 00000004 c02de2cc c3480040 c02e05d8 c0367380
c02e05d8 c02de33c 00000017=20
[   53.650000] ff40: c3480008 c347ff50 c0128e68 c01288f8 c347ff5c
c0127834 c348000c 00000004=20
[   53.650000] ff60: 00000000 00000008 00000008 000f0042 60000013
c347e000 00000000 00000000=20
[   53.650000] ff80: c347ff8c c0120e4c c01277e0 2001022b 00014240
c347fff0 00000000 00000000=20
[   53.650000] ffa0: 00000000 00000008 ffffffff 00014240 c347fff0
00000000 00000000 00000008=20
[   53.650000] ffc0: 00000008 00000000 0000001b 00000000 00000000
00000000 00010000 be5ffaf8=20
[   53.650000] ffe0: ffffffff c3480040 c02e05d8 c0367380 c02e05d8
00000093 c0368e30 c3480088=20
[   53.650000] Backtrace:=20
[   53.650000] Backtrace aborted due to bad frame pointer <c347fe10>
[   53.650000] Code: eb03b755 e24b1030 e8910006 e3510000 (e592a004)=20

-sh-3.00# ./run -- -p 1000 =20
*
*
* Type ^C to stop this application.
*
*
=3D=3D Sampling period: 1000 us
=3D=3D Do not interrupt this program

system doesn't react after a while
debugger output
^C
Program received signal SIGSTOP, Stopped (signal).
0xffff000c in ?? ()
(gdb) next
Cannot find bounds of current function
(gdb) next
Cannot find bounds of current function
(gdb) next
Cannot find bounds of current function
(gdb) next
Cannot find bounds of current function
(gdb) next
Cannot find bounds of current function
(gdb) cont
^CRemote failure reply: E01
(gdb) cont
Remote failure reply: E01
(gdb) cont
Remote failure reply: E01


4. cyclictest
cyclictest runs, if i use the run script (built-in xenomai):

-sh-3.00# ./run=20
*
*
* Type ^C to stop this application.
*
*
0.10 0.04 0.01 1/26 94         =20

T: 0 (   94) P:99 I:    1000 C:   22508 Min:      49 Act:      82 Max:
121


but is broken if i call it manually:

-sh-3.00# ./cyclictest=20
0.10 0.04 0.01 2/23 103         =20

T: 0 (  103) P: 0 I:    1000 C:    1699 Min:-2660105 Act:-2660105 Max:
-985769


5. latency

For periodic user-mode task i need very high periods > 1000us.


Here are the latency-checks with printk's of the ioctls:

-sh-3.00# ./run -- -t 1
*
*
* Type ^C to stop this application.
*
*
=3D=3D Sampling period: 100 us
=3D=3D Test mode: in-kernel periodic task
=3D=3D All results in microseconds
[42949519.180000] rt_tmbench_ioctl_rt: request 1076364816 -> ret =3D
-ENOTTY(-25)
latency: failed to start in-kernel timer benchmark, code -25
[42949523.000000] rt_tmbench_ioctl_nrt: request -1071118831 -> ret =3D
-ENOTTY(-25)
---|------------|------------|------------|--------|-----------------------=
--
RTS|-1096532.504|       0.001|      93.252|   93340|
00:00:03/00:00:03

-sh-3.00# ./run -- -t 2
*
*
* Type ^C to stop this application.
*
*
=3D=3D Sampling period: 100 us
=3D=3D Test mode: in-kernel timer handler
=3D=3D All results in microseconds
[42949529.090000] rt_tmbench_ioctl_rt: request 1076364816 -> ret =3D
-ENOTTY(-25)
latency: failed to start in-kernel timer benchmark, code -25
[42949534.680000] rt_tmbench_ioctl_nrt: request -1071118831 -> ret =3D
-ENOTTY(-25)
---|------------|------------|------------|--------|-----------------------=
--
RTS|-1093751.320|       0.001|      93.252|   93340|
00:00:04/00:00:04


Userspace-codes differ from kernelspace-codes, I think...



6. Cross-Compiled Xenomai (Userspace)

I'm using elinos4.0

./configure --prefix=3D/ginzinger/bootdir/nfsroot/xeno-2.2.3/ --host arm=20

checking build system type... i686-pc-linux-gnu
checking host system type... arm-unknown-none
checking for a BSD-compatible install... /usr/bin/install -c
checking for arm-gcc... arm_v4le-gcc
checking for C compiler default output file name... a.out
checking whether the C compiler works... yes
checking whether we are cross compiling... yes
checking for suffix of executables...=20
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether arm_v4le-gcc accepts -g... yes
checking for arm_v4le-gcc option to accept ANSI C... none needed
checking how to run the C preprocessor... arm_v4le-gcc -E
checking target system type... arm-unknown-none
checking for arm-gcc... no
checking for gcc... gcc
checking whether we are using the GNU C compiler... (cached) yes
checking whether gcc accepts -g... no
checking for gcc option to accept ANSI C... (cached) none needed
checking how to run the C preprocessor... gcc -E
checking whether build environment is sane... yes
checking for gawk... gawk
checking whether make sets $(MAKE)... yes
checking for style of include used by make... GNU
checking for arm-strip... no
checking for strip... strip
checking dependency style of arm_v4le-gcc... gcc3
checking whether to enable maintainer-specific portions of Makefiles...
no
checking for a sed that does not truncate output... /bin/sed
checking for egrep... grep -E
checking for ld used by arm_v4le-gcc... arm_v4le-ld
checking if the linker (arm_v4le-ld) is GNU ld... yes
checking for arm_v4le-ld option to reload object files... -r
checking for BSD-compatible nm... arm_v4le-nm
checking whether ln -s works... yes
checking how to recognise dependent libraries... unknown
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
checking for arm-g++... arm_v4le-g++
checking whether we are using the GNU C++ compiler... yes
checking whether arm_v4le-g++ accepts -g... yes
checking dependency style of arm_v4le-g++... gcc3
checking how to run the C++ preprocessor... arm_v4le-g++ -E
checking for arm-g77... no
checking for arm-f77... no
checking for arm-xlf... no
checking for arm-frt... no
checking for arm-pgf77... no
checking for arm-fort77... no
checking for arm-fl32... no
checking for arm-af77... no
checking for arm-f90... no
checking for arm-xlf90... no
checking for arm-pgf90... no
checking for arm-epcf90... no
checking for arm-f95... no
checking for arm-fort... no
checking for arm-xlf95... no
checking for arm-ifc... no
checking for arm-efc... no
checking for arm-pgf95... no
checking for arm-lf95... no
checking for arm-gfortran... no
checking for g77... g77
checking whether we are using the GNU Fortran 77 compiler... yes
checking whether g77 accepts -g... yes
checking the maximum length of command line arguments... 32768
checking command to parse arm_v4le-nm output from arm_v4le-gcc object...
ok
checking for objdir... .libs
checking for arm-ar... arm_v4le-ar
checking for arm-ranlib... arm_v4le-ranlib
checking for arm-strip... strip
checking if arm_v4le-gcc supports -fno-rtti -fno-exceptions... no
checking for arm_v4le-gcc option to produce PIC... -fPIC
checking if arm_v4le-gcc PIC flag -fPIC works... yes
checking if arm_v4le-gcc static flag -static works... yes
checking if arm_v4le-gcc supports -c -o file.o... yes
checking whether the arm_v4le-gcc linker (arm_v4le-ld) supports shared
libraries... yes
checking whether -lc should be explicitly linked in... no
checking dynamic linker characteristics... no
checking how to hardcode library paths into programs... immediate
checking whether stripping libraries is possible... yes
checking if libtool supports shared libraries... no
checking whether to build shared libraries... no
checking whether to build static libraries... yes
configure: creating libtool
appending configuration tag "CXX" to libtool
checking for ld used by arm_v4le-g++... arm_v4le-ld
checking if the linker (arm_v4le-ld) is GNU ld... yes
checking whether the arm_v4le-g++ linker (arm_v4le-ld) supports shared
libraries... no
checking for arm_v4le-g++ option to produce PIC... -fPIC
checking if arm_v4le-g++ PIC flag -fPIC works... yes
checking if arm_v4le-g++ static flag -static works... yes
checking if arm_v4le-g++ supports -c -o file.o... yes
checking whether the arm_v4le-g++ linker (arm_v4le-ld) supports shared
libraries... no
checking dynamic linker characteristics... no
checking how to hardcode library paths into programs... immediate
appending configuration tag "F77" to libtool
checking if libtool supports shared libraries... no
checking whether to build shared libraries... no
checking whether to build static libraries... yes
checking for g77 option to produce PIC... -fPIC
checking if g77 PIC flag -fPIC works... yes
checking if g77 static flag -static works... yes
checking if g77 supports -c -o file.o... yes
checking whether the g77 linker (arm_v4le-ld) supports shared
libraries... yes
checking dynamic linker characteristics... no
checking how to hardcode library paths into programs... immediate
checking for flex... flex
checking for yywrap in -lfl... yes
checking lex output file root... lex.yy
checking whether yytext is a pointer... yes
checking for target architecture... arm
checking for UVM support... y
checking for debug symbols... no
checking for SMP support... no
checking for size of system heap... 128 Kb
checking for ARM architecture version... 4
checking for ARM SA1100 architecture... no
checking whether building Linux in Xenomai build tree... no
checking for Doxygen documentation... no
checking for doxygen... no
checking for dot... NO
checking whether compiling Docbook XML documentation... no
checking for xmllint... no
checking for xsltproc... xsltproc
checking for fop.sh... no
checking whether Docbook XML documentation generation can use
network.... no
checking for docbook-xml root dir... /usr/share/sgml/docbook/dtd/xml/4.2
checking for docbook-xsl root
dir... /usr/share/sgml/docbook/stylesheet/xsl/nwalsh
checking whether using LaTeX non-stop mode... no
checking mqueue.h usability... yes
checking mqueue.h presence... yes
checking for mqueue.h... yes
checking for sched_setaffinity... ok
checking for specific GCC switches... done
checking whether ld supports @file... no
configure: creating ./config.status
config.status: creating Makefile
config.status: creating config/Makefile
config.status: creating scripts/Makefile
config.status: creating scripts/xeno-config
config.status: creating scripts/xeno-load
config.status: creating scripts/xeno-test
config.status: creating src/Makefile
config.status: creating src/skins/Makefile
config.status: creating src/skins/posix/Makefile
config.status: creating src/skins/native/Makefile
config.status: creating src/skins/vxworks/Makefile
config.status: creating src/skins/vrtx/Makefile
config.status: creating src/skins/rtdm/Makefile
config.status: creating src/skins/rtai/Makefile
config.status: creating src/skins/uvm/Makefile
config.status: creating src/skins/uvm/nucleus/Makefile
config.status: creating src/skins/uvm/vxworks/Makefile
config.status: creating src/skins/uvm/psos+/Makefile
config.status: creating src/skins/uvm/vrtx/Makefile
config.status: creating src/skins/uvm/uitron/Makefile
config.status: creating src/include/Makefile
config.status: creating src/testsuite/Makefile
config.status: creating src/testsuite/latency/Makefile
config.status: creating src/testsuite/switchbench/Makefile
config.status: creating src/testsuite/cyclic/Makefile
config.status: creating src/testsuite/switchtest/Makefile
config.status: creating src/testsuite/irqbench/Makefile
config.status: creating include/Makefile
config.status: creating include/asm-generic/Makefile
config.status: creating include/asm-blackfin/Makefile
config.status: creating include/asm-i386/Makefile
config.status: creating include/asm-powerpc/Makefile
config.status: creating include/asm-ia64/Makefile
config.status: creating include/asm-arm/Makefile
config.status: creating include/asm-uvm/Makefile
config.status: creating include/asm-sim/Makefile
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
config.status: creating doc/man/runinfo.man
config.status: creating doc/man/xeno-config.man
config.status: creating doc/man/xeno-info.man
config.status: creating doc/man/xeno-load.man
config.status: creating doc/man/xeno-test.man
config.status: creating doc/doxygen/Makefile
config.status: creating doc/doxygen/Doxyfile
config.status: creating doc/docbook/Makefile
config.status: creating doc/docbook/catalog
config.status: creating doc/docbook/custom-stylesheets/Makefile
config.status: creating doc/docbook/custom-stylesheets/xsl/Makefile
config.status: creating
doc/docbook/custom-stylesheets/xsl/common/Makefile
config.status: creating doc/docbook/custom-stylesheets/xsl/fo/Makefile
config.status: creating doc/docbook/custom-stylesheets/xsl/html/Makefile
config.status: creating
doc/docbook/custom-stylesheets/xsl/html/chunk.xsl
config.status: creating
doc/docbook/custom-stylesheets/xsl/html/onechunk.xsl
config.status: creating doc/docbook/xenomai/Makefile
config.status: creating src/include/xeno_config.h
config.status: src/include/xeno_config.h is unchanged
config.status: linking ./include/asm-arm to src/include/asm/xenomai
config.status: linking ./include/asm-generic to
src/include/asm-generic/xenomai
config.status: executing depfiles commands



--=-14Z2AnoH/rzyA9as9sCy
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBFNPlAbMvu5jIEpfsRAq23AJ9JInKyJZ0NS1AITJfsDXv0vWZf1gCggalb
7qnmafnnzoOwXRN5EUW6Vkw=
=khLs
-----END PGP SIGNATURE-----

--=-14Z2AnoH/rzyA9as9sCy--


