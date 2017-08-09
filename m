Date: Wed, 9 Aug 2017 08:59:14 +0200
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20170809085914.4311644f@md1em3qc>
In-Reply-To: <CAF06wtiywQ4P7J4QO-2N1H2pPhysgoaRmhWpx7sVDaBzgp1UMA@mail.gmail.com>
References: <CAF06wtiywQ4P7J4QO-2N1H2pPhysgoaRmhWpx7sVDaBzgp1UMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Issues with Xenomai 3.0.5 under Buildroot...
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jim Langston <jim.langston@gmail.com>
Cc: xenomai@xenomai.org

Am Tue, 8 Aug 2017 22:07:41 -0400
schrieb Jim Langston <jim.langston@gmail.com>:

> Hi all,
> 
> I'm having issues porting an old driver from Xenomai 2.4 to Xenomai
> 3.0.5.
> 
> The driver is written using the old 'Alchemy/Native' API, and uses the
> <native/heap.h> header file, where all my problems start.
> 
> From looking through the Xenomai headers, they all make use of the new
> "#include_next<>" statement, so at least in this case, "pthread.h"
> cannot be found:
> 
> rm -f *~  *mod*c  *.o  *.ko testrfi Module.symvers modules.order
> make
> CROSS_COMPILE=/home/jlangston/mi/Xenomai3_3365_Atom/buildroot-2017.02.2/output/host/usr/bin/i686-linux-
> -C
> /home/jlangston/mi/Xenomai3_3365_Atom/buildroot-2017.02.2/output/build/linux-4.1.18
> SUBDIRS=/home/jlangston/mi/Xenomai3_3365_Atom/mi750/rf/source/rfidrv
> modules make[1]: Entering directory
> '/home/jlangston/mi/Xenomai3_3365_Atom/buildroot-2017.02.2/output/build/linux-4.1.18'
>   CC [M]
> /home/jlangston/mi/Xenomai3_3365_Atom/mi750/rf/source/rfidrv/rfidrv.o
> Using built-in specs.
> COLLECT_GCC=/home/jlangston/mi/Xenomai3_3365_Atom/buildroot-2017.02.2/output/host/usr/bin/i686-linux-gcc.br_real
> Target: i686-buildroot-linux-gnu
> Configured with: ./configure
> --prefix=/home/jlangston/mi/Xenomai3_3365_Atom/buildroot-2017.02.2/output/host/usr
> --sysconfdir=/home/jlangston/mi/Xenomai3_3365_Atom/buildroot-2017.02.2/output/host/etc
> --enable-static --target=i686-buildroot-linux-gnu
> --with-sysroot=/home/jlangston/mi/Xenomai3_3365_Atom/buildroot-2017.02.2/output/host/usr/i686-buildroot-linux-gnu/sysroot
> --disable-__cxa_atexit --with-gnu-ld --disable-libssp
> --disable-multilib
> --with-gmp=/home/jlangston/mi/Xenomai3_3365_Atom/buildroot-2017.02.2/output/host/usr
> --with-mpc=/home/jlangston/mi/Xenomai3_3365_Atom/buildroot-2017.02.2/output/host/usr
> --with-mpfr=/home/jlangston/mi/Xenomai3_3365_Atom/buildroot-2017.02.2/output/host/usr
> --with-pkgversion='Buildroot 2017.02.2' --with-bugurl=
> http://bugs.buildroot.net/ --enable-libquadmath --enable-tls
> --disable-libmudflap --enable-threads --without-isl --without-cloog
> --disable-decimal-float --with-arch=atom --enable-languages=c,c++
> --with-build-time-tools=/home/jlangston/mi/Xenomai3_3365_Atom/buildroot-2017.02.2/output/host/usr/i686-buildroot-linux-gnu/bin
> --enable-shared --disable-libgomp Thread model: posix
> gcc version 5.4.0 (Buildroot 2017.02.2)
> COLLECT_GCC_OPTIONS='-nostdinc' '-isystem'
> '/home/jlangston/mi/Xenomai3_3365_Atom/buildroot-2017.02.2/output/host/usr/lib/gcc/i686-buildroot-linux-gnu/5.4.0/include'
> '-I' './arch/x86/include' '-I' 'arch/x86/include/generated/uapi' '-I'
> 'arch/x86/include/generated' '-I' 'include' '-I'
> './arch/x86/include/uapi' '-I' 'arch/x86/include/generated/uapi' '-I'
> './include/uapi' '-I' 'include/generated/uapi' '-include'
> './include/linux/kconfig.h' '-D' '__KERNEL__' '-Wall' '-Wundef'
> '-Wstrict-prototypes' '-Wno-trigraphs' '-fno-strict-aliasing'
> '-fno-common' '-Werror=implicit-function-declaration'
> '-Wno-format-security' '-std=gnu90' '-m32' '-msoft-float'
> '-mregparm=3' '-freg-struct-return' '-fno-pic'
> '-mpreferred-stack-boundary=2' '-march=atom' '-mtune=atom'
> '-mtune=generic' '-ffreestanding' '-D' 'CONFIG_AS_CFI=1' '-D'
> 'CONFIG_AS_CFI_SIGNAL_FRAME=1' '-D' 'CONFIG_AS_CFI_SECTIONS=1' '-D'
> 'CONFIG_AS_SSSE3=1' '-D' 'CONFIG_AS_CRC32=1' '-D' 'CONFIG_AS_AVX=1'
> '-D' 'CONFIG_AS_AVX2=1' '-pipe' '-Wno-sign-compare'
> '-fno-asynchronous-unwind-tables' '-mno-sse' '-mno-mmx' '-mno-sse2'
> '-mno-3dnow' '-mno-avx' '-I' 'arch/x86/xenomai/include' '-I'
> 'include/xenomai' '-fno-delete-null-pointer-checks' '-O2' '--param'
> 'allow-store-data-races=0' '-Wframe-larger-than=2048'
> '-fno-stack-protector' '-Wno-unused-but-set-variable'
> '-fno-omit-frame-pointer' '-fno-optimize-sibling-calls'
> '-fno-var-tracking-assignments' '-Wdeclaration-after-statement'
> '-Wno-pointer-sign' '-fno-strict-overflow' '-fconserve-stack'
> '-Werror=implicit-int' '-Werror=strict-prototypes'
> '-Werror=date-time' '-D' 'CC_HAVE_ASM_GOTO' '-v' '-I'
> '/home/jlangston/mi/Xenomai3_3365_Atom/buildroot-2017.02.2/output/host/usr/i686-buildroot-linux-gnu/sysroot/usr/include/xenomai/cobalt'
> '-I'
> '/home/jlangston/mi/Xenomai3_3365_Atom/buildroot-2017.02.2/output/host/usr/i686-buildroot-linux-gnu/sysroot/usr/include/xenomai'
> '-D' '_LARGEFILE_SOURCE' '-D' '_LARGEFILE64_SOURCE' '-D'
> '_FILE_OFFSET_BITS=64' '-Os' '-D' '_GNU_SOURCE' '-D' '_REENTRANT'
> '-D' '__COBALT__' '-D' '__COBALT_WRAP__' '-D' '__COBALT_WRAP__' '-I'
> '/home/jlangston/mi/Xenomai3_3365_Atom/buildroot-2017.02.2/output/build/linux-4.1.18/include/xenomai'
> '-D' 'MODULE' '-D' 'KBUILD_STR(s)=#s' '-D'
> 'KBUILD_BASENAME=KBUILD_STR(rfidrv)' '-D'
> 'KBUILD_MODNAME=KBUILD_STR(rfidrv)' '-c' '-o'
> '/home/jlangston/mi/Xenomai3_3365_Atom/mi750/rf/source/rfidrv/rfidrv.o' /home/jlangston/mi/Xenomai3_3365_Atom/buildroot-2017.02.2/output/host/usr/libexec/gcc/i686-buildroot-linux-gnu/5.4.0/cc1
> -quiet -nostdinc -v -I ./arch/x86/include -I
> arch/x86/include/generated/uapi -I arch/x86/include/generated -I
> include -I ./arch/x86/include/uapi -I arch/x86/include/generated/uapi
> -I ./include/uapi -I include/generated/uapi -I
> arch/x86/xenomai/include -I include/xenomai
> -I /home/jlangston/mi/Xenomai3_3365_Atom/buildroot-2017.02.2/output/host/usr/i686-buildroot-linux-gnu/sysroot/usr/include/xenomai/cobalt
> -I /home/jlangston/mi/Xenomai3_3365_Atom/buildroot-2017.02.2/output/host/usr/i686-buildroot-linux-gnu/sysroot/usr/include/xenomai
> -I
> /home/jlangston/mi/Xenomai3_3365_Atom/buildroot-2017.02.2/output/build/linux-4.1.18/include/xenomai
> -isysroot
> /home/jlangston/mi/Xenomai3_3365_Atom/buildroot-2017.02.2/output/host/usr/i686-buildroot-linux-gnu/sysroot
> -D __KERNEL__ -D CONFIG_AS_CFI=1 -D CONFIG_AS_CFI_SIGNAL_FRAME=1 -D
> CONFIG_AS_CFI_SECTIONS=1 -D CONFIG_AS_SSSE3=1 -D CONFIG_AS_CRC32=1 -D
> CONFIG_AS_AVX=1 -D CONFIG_AS_AVX2=1 -D CC_HAVE_ASM_GOTO -D
> _LARGEFILE_SOURCE -D _LARGEFILE64_SOURCE -D _FILE_OFFSET_BITS=64 -D
> _GNU_SOURCE -D _REENTRANT -D __COBALT__ -D __COBALT_WRAP__ -D
> __COBALT_WRAP__ -D MODULE -D KBUILD_STR(s)=#s -D
> KBUILD_BASENAME=KBUILD_STR(rfidrv) -D
> KBUILD_MODNAME=KBUILD_STR(rfidrv) -isystem
> /home/jlangston/mi/Xenomai3_3365_Atom/buildroot-2017.02.2/output/host/usr/lib/gcc/i686-buildroot-linux-gnu/5.4.0/include
> -include ./include/linux/kconfig.h -MD
> /home/jlangston/mi/Xenomai3_3365_Atom/mi750/rf/source/rfidrv/.rfidrv.o.d
> /home/jlangston/mi/Xenomai3_3365_Atom/mi750/rf/source/rfidrv/rfidrv.c
> -quiet -dumpbase rfidrv.c -m32 -msoft-float -mregparm=3
> -mpreferred-stack-boundary=2 -march=atom -mtune=atom -mtune=generic
> -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx -auxbase-strip
> /home/jlangston/mi/Xenomai3_3365_Atom/mi750/rf/source/rfidrv/rfidrv.o
> -O2 -Os -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs
> -Werror=implicit-function-declaration -Wno-format-security
> -Wno-sign-compare -Wframe-larger-than=2048
> -Wno-unused-but-set-variable -Wdeclaration-after-statement
> -Wno-pointer-sign -Werror=implicit-int -Werror=strict-prototypes
> -Werror=date-time -std=gnu90 -version -fno-strict-aliasing
> -fno-common -freg-struct-return -fno-pic -ffreestanding
> -fno-asynchronous-unwind-tables -fno-delete-null-pointer-checks
> -fno-stack-protector -fno-omit-frame-pointer
> -fno-optimize-sibling-calls -fno-var-tracking-assignments
> -fno-strict-overflow -fconserve-stack --param
> allow-store-data-races=0 -o -
> | /home/jlangston/mi/Xenomai3_3365_Atom/buildroot-2017.02.2/output/host/usr/lib/gcc/i686-buildroot-linux-gnu/5.4.0/../../../../i686-buildroot-linux-gnu/bin/as
> -v -I ./arch/x86/include -I arch/x86/include/generated/uapi -I
> arch/x86/include/generated -I include -I ./arch/x86/include/uapi -I
> arch/x86/include/generated/uapi -I ./include/uapi -I
> include/generated/uapi -I arch/x86/xenomai/include -I include/xenomai
> -I /home/jlangston/mi/Xenomai3_3365_Atom/buildroot-2017.02.2/output/host/usr/i686-buildroot-linux-gnu/sysroot/usr/include/xenomai/cobalt
> -I /home/jlangston/mi/Xenomai3_3365_Atom/buildroot-2017.02.2/output/host/usr/i686-buildroot-linux-gnu/sysroot/usr/include/xenomai
> -I
> /home/jlangston/mi/Xenomai3_3365_Atom/buildroot-2017.02.2/output/build/linux-4.1.18/include/xenomai
> --32 -mtune=generic32 -o
> /home/jlangston/mi/Xenomai3_3365_Atom/mi750/rf/source/rfidrv/rfidrv.o
> GNU assembler version 2.26.1 (i686-buildroot-linux-gnu) using BFD
> version (GNU Binutils) 2.26.1
> GNU C89 (Buildroot 2017.02.2) version 5.4.0 (i686-buildroot-linux-gnu)
>     compiled by GNU C version 5.4.0 20160609, GMP version 6.1.2, MPFR
> version 3.1.5, MPC version 1.0.3
> GGC heuristics: --param ggc-min-expand=100 --param
> ggc-min-heapsize=131072 ignoring duplicate directory
> "arch/x86/include/generated/uapi" ignoring duplicate directory
> "/home/jlangston/mi/Xenomai3_3365_Atom/buildroot-2017.02.2/output/build/linux-4.1.18/include/xenomai"
> #include "..." search starts here:
> #include <...> search starts here:
>  ./arch/x86/include
>  arch/x86/include/generated/uapi
>  arch/x86/include/generated
>  include
>  ./arch/x86/include/uapi
>  ./include/uapi
>  include/generated/uapi
>  arch/x86/xenomai/include
>  include/xenomai
>  /home/jlangston/mi/Xenomai3_3365_Atom/buildroot-2017.02.2/output/host/usr/i686-buildroot-linux-gnu/sysroot/usr/include/xenomai/cobalt
>  /home/jlangston/mi/Xenomai3_3365_Atom/buildroot-2017.02.2/output/host/usr/i686-buildroot-linux-gnu/sysroot/usr/include/xenomai
>  /home/jlangston/mi/Xenomai3_3365_Atom/buildroot-2017.02.2/output/host/usr/lib/gcc/i686-buildroot-linux-gnu/5.4.0/include
> End of search list.
> 
> Unfortunately, the "-nostdinc" flag seems to kill off the only path
> with the 'final' pthread.h:
> 
> /home/jlangston/mi/Xenomai3_3365_Atom/buildroot-2017.02.2
> /output/host/usr/i686-buildroot-linux-gnu/sysroot/usr/include/pthread.h
> 
> So, while I realize that this is likely some sort of a Buildroot
> problem, I'm completely at a loss as to how to fix it... I tried
> adding it back to the end of the path using '-idirafter', but that
> results in a large number of 'redefinition' errors, so I don't think
> that is the right solution.
> 
> Anyone have any suggestions?

I think what might be happening is that you build all of the driver as
kernel module and kbuild forces its flags on your application.
The module part should probably be build with kbuild while any
additional stuff should maybe have its own build-system. And the split
should be clear, in case of shared files there is "ifdef __KERNEL__".

Maybe start with building manually, gradually find the problems and fix
your buildroot "recipe" accordingly.

regards,
Henning
 
> Thanks,
> Jim
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai


