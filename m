MIME-Version: 1.0
From: Jim Langston <jim.langston@gmail.com>
Date: Tue, 29 Aug 2017 21:17:41 -0400
Message-ID: <CAF06wtj2YM_Ue0Hzw5+LChWtve_3ta390aAu0CixsCQd+12bwg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Xenomai] Issues building old drivers under Xenomai 3.0.5
Reply-To: jlangston@panurgyinc.com
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi all,

I'm having trouble getting an old driver originally built for Xenomai 2.4
to build under Xenomai 3.0.5.  The code won't build under Ubuntu 16.04
patched with Xenomai 3.0.5 and kernel 4.9.24 and the IPipe patch for 4.9.24.

The problem seems to revolve around include pathing, and the simplest case
I can put together is as follows:

------------------
Makefile
------------------
XENOCONFIG:=/usr/xenomai/bin/xeno-config
KDIR ?= /lib/modules/`uname -r`/build
INCLUDEDIR    :=/usr/include
PWD        := $(shell pwd)
$(eval ccflags-y = -v $(shell $(XENOCONFIG) --native --rtdm --compat
--cflags))

ifneq ($(KERNELRELEASE),)
obj-m        := rfidrv2.o
else
rfidrv    : rfidrv2.c
    $(MAKE) -C $(KDIR) M=$(PWD) SUBDIRS=$(PWD) modules
endif

------------------
rfidrv2.c
------------------
#include <native/heap.h>
// Yes, just the one include line -- I removed all the rest of the code
===============================================

Output:

make -C /lib/modules/`uname -r`/build M=/home/jlangston/mi/rfidrv/rfidrv
SUBDIRS=/home/jlangston/mi/rfidrv/rfidrv modules
make[1]: Entering directory '/usr/src/linux-4.9.24'
  CC [M]  /home/jlangston/mi/rfidrv/rfidrv/rfidrv2.o
Using built-in specs.
COLLECT_GCC=gcc
Target: x86_64-linux-gnu
Configured with: ../src/configure -v --with-pkgversion='Ubuntu
5.4.0-6ubuntu1~16.04.4'
--with-bugurl=file:///usr/share/doc/gcc-5/README.Bugs
--enable-languages=c,ada,c++,java,go,d,fortran,objc,obj-c++ --prefix=/usr
--program-suffix=-5 --enable-shared --enable-linker-build-id
--libexecdir=/usr/lib --without-included-gettext --enable-threads=posix
--libdir=/usr/lib --enable-nls --with-sysroot=/ --enable-clocale=gnu
--enable-libstdcxx-debug --enable-libstdcxx-time=yes
--with-default-libstdcxx-abi=new --enable-gnu-unique-object
--disable-vtable-verify --enable-libmpx --enable-plugin --with-system-zlib
--disable-browser-plugin --enable-java-awt=gtk --enable-gtk-cairo
--with-java-home=/usr/lib/jvm/java-1.5.0-gcj-5-amd64/jre --enable-java-home
--with-jvm-root-dir=/usr/lib/jvm/java-1.5.0-gcj-5-amd64
--with-jvm-jar-dir=/usr/lib/jvm-exports/java-1.5.0-gcj-5-amd64
--with-arch-directory=amd64 --with-ecj-jar=/usr/share/java/eclipse-ecj.jar
--enable-objc-gc --enable-multiarch --disable-werror --with-arch-32=i686
--with-abi=m64 --with-multilib-list=m32,m64,mx32 --enable-multilib
--with-tune=generic --enable-checking=release --build=x86_64-linux-gnu
--host=x86_64-linux-gnu --target=x86_64-linux-gnu
Thread model: posix
gcc version 5.4.0 20160609 (Ubuntu 5.4.0-6ubuntu1~16.04.4)
COLLECT_GCC_OPTIONS='-nostdinc' '-isystem'
'/usr/lib/gcc/x86_64-linux-gnu/5/include' '-I' './arch/x86/include' '-I'
'./arch/x86/include/generated/uapi' '-I' './arch/x86/include/generated'
'-I' './include' '-I' './arch/x86/include/uapi' '-I' './include/uapi' '-I'
'./include/generated/uapi' '-include' './include/linux/kconfig.h' '-D'
'__KERNEL__' '-Wall' '-Wundef' '-Wstrict-prototypes' '-Wno-trigraphs'
'-fno-strict-aliasing' '-fno-common'
'-Werror=implicit-function-declaration' '-Wno-format-security' '-std=gnu90'
'-fno-PIE' '-mno-sse' '-mno-mmx' '-mno-sse2' '-mno-3dnow' '-mno-avx' '-m64'
'-falign-jumps=1' '-falign-loops=1' '-mno-80387' '-mno-fp-ret-in-387'
'-mpreferred-stack-boundary=3' '-mskip-rax-setup' '-mtune=generic'
'-mno-red-zone' '-mcmodel=kernel' '-funit-at-a-time'
'-maccumulate-outgoing-args' '-D' 'CONFIG_X86_X32_ABI' '-D'
'CONFIG_AS_CFI=1' '-D' 'CONFIG_AS_CFI_SIGNAL_FRAME=1' '-D'
'CONFIG_AS_CFI_SECTIONS=1' '-D' 'CONFIG_AS_FXSAVEQ=1' '-D'
'CONFIG_AS_SSSE3=1' '-D' 'CONFIG_AS_CRC32=1' '-D' 'CONFIG_AS_AVX=1' '-D'
'CONFIG_AS_AVX2=1' '-D' 'CONFIG_AS_AVX512=1' '-D' 'CONFIG_AS_SHA1_NI=1'
'-D' 'CONFIG_AS_SHA256_NI=1' '-pipe' '-Wno-sign-compare'
'-fno-asynchronous-unwind-tables' '-I' 'arch/x86/xenomai/include' '-I'
'include/xenomai' '-fno-delete-null-pointer-checks' '-O2' '--param'
'allow-store-data-races=0' '-Wframe-larger-than=1024'
'-fstack-protector-strong' '-Wno-unused-but-set-variable'
'-fno-omit-frame-pointer' '-fno-optimize-sibling-calls'
'-fno-var-tracking-assignments' '-g' '-gdwarf-4' '-pg' '-mfentry' '-D'
'CC_USING_FENTRY' '-Wdeclaration-after-statement' '-Wno-pointer-sign'
'-fno-strict-overflow' '-fconserve-stack' '-Werror=implicit-int'
'-Werror=strict-prototypes' '-Werror=date-time'
'-Werror=incompatible-pointer-types' '-D' 'CC_HAVE_ASM_GOTO' '-v' '-I'
'/usr/xenomai/include/trank/posix' '-I' '/usr/xenomai/include/trank' '-D'
'__XENO_COMPAT__' '-I' '/usr/xenomai/include/cobalt' '-I'
'/usr/xenomai/include' '-D' '_GNU_SOURCE' '-D' '_REENTRANT' '-D'
'__COBALT__' '-I' '/usr/xenomai/include/alchemy' '-D' '__COBALT_WRAP__'
'-D' 'MODULE' '-D' 'KBUILD_BASENAME="rfidrv2"' '-D'
'KBUILD_MODNAME="rfidrv2"' '-c' '-o'
'/home/jlangston/mi/rfidrv/rfidrv/.tmp_rfidrv2.o' '-march=x86-64'
 /usr/lib/gcc/x86_64-linux-gnu/5/cc1 -quiet -nostdinc -v -I
./arch/x86/include -I ./arch/x86/include/generated/uapi -I
./arch/x86/include/generated -I ./include -I ./arch/x86/include/uapi -I
./include/uapi -I ./include/generated/uapi -I arch/x86/xenomai/include -I
include/xenomai -I /usr/xenomai/include/trank/posix -I
/usr/xenomai/include/trank -I /usr/xenomai/include/cobalt -I
/usr/xenomai/include -I /usr/xenomai/include/alchemy -imultiarch
x86_64-linux-gnu -D __KERNEL__ -D CONFIG_X86_X32_ABI -D CONFIG_AS_CFI=1 -D
CONFIG_AS_CFI_SIGNAL_FRAME=1 -D CONFIG_AS_CFI_SECTIONS=1 -D
CONFIG_AS_FXSAVEQ=1 -D CONFIG_AS_SSSE3=1 -D CONFIG_AS_CRC32=1 -D
CONFIG_AS_AVX=1 -D CONFIG_AS_AVX2=1 -D CONFIG_AS_AVX512=1 -D
CONFIG_AS_SHA1_NI=1 -D CONFIG_AS_SHA256_NI=1 -D CC_USING_FENTRY -D
CC_HAVE_ASM_GOTO -D __XENO_COMPAT__ -D _GNU_SOURCE -D _REENTRANT -D
__COBALT__ -D __COBALT_WRAP__ -D MODULE -D KBUILD_BASENAME="rfidrv2" -D
KBUILD_MODNAME="rfidrv2" -isystem /usr/lib/gcc/x86_64-linux-gnu/5/include
-include ./include/linux/kconfig.h -MD
/home/jlangston/mi/rfidrv/rfidrv/.rfidrv2.o.d
/home/jlangston/mi/rfidrv/rfidrv/rfidrv2.c -quiet -dumpbase rfidrv2.c
-mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx -m64 -mno-80387
-mno-fp-ret-in-387 -mpreferred-stack-boundary=3 -mskip-rax-setup
-mtune=generic -mno-red-zone -mcmodel=kernel -maccumulate-outgoing-args
-mfentry -march=x86-64 -auxbase-strip
/home/jlangston/mi/rfidrv/rfidrv/.tmp_rfidrv2.o -g -gdwarf-4 -O2 -Wall
-Wundef -Wstrict-prototypes -Wno-trigraphs
-Werror=implicit-function-declaration -Wno-format-security
-Wno-sign-compare -Wframe-larger-than=1024 -Wno-unused-but-set-variable
-Wdeclaration-after-statement -Wno-pointer-sign -Werror=implicit-int
-Werror=strict-prototypes -Werror=date-time
-Werror=incompatible-pointer-types -std=gnu90 -version -p
-fno-strict-aliasing -fno-common -fno-PIE -falign-jumps=1 -falign-loops=1
-funit-at-a-time -fno-asynchronous-unwind-tables
-fno-delete-null-pointer-checks -fstack-protector-strong
-fno-omit-frame-pointer -fno-optimize-sibling-calls
-fno-var-tracking-assignments -fno-strict-overflow -fconserve-stack --param
allow-store-data-races=0 -fstack-protector-strong -o - |
 as -v -I ./arch/x86/include -I ./arch/x86/include/generated/uapi -I
./arch/x86/include/generated -I ./include -I ./arch/x86/include/uapi -I
./include/uapi -I ./include/generated/uapi -I arch/x86/xenomai/include -I
include/xenomai -I /usr/xenomai/include/trank/posix -I
/usr/xenomai/include/trank -I /usr/xenomai/include/cobalt -I
/usr/xenomai/include -I /usr/xenomai/include/alchemy --64 -o
/home/jlangston/mi/rfidrv/rfidrv/.tmp_rfidrv2.o
GNU assembler version 2.26.1 (x86_64-linux-gnu) using BFD version (GNU
Binutils for Ubuntu) 2.26.1
GNU C89 (Ubuntu 5.4.0-6ubuntu1~16.04.4) version 5.4.0 20160609
(x86_64-linux-gnu)
    compiled by GNU C version 5.4.0 20160609, GMP version 6.1.0, MPFR
version 3.1.4, MPC version 1.0.3
GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
#include "..." search starts here:
#include <...> search starts here:
 ./arch/x86/include
 ./arch/x86/include/generated/uapi
 ./arch/x86/include/generated
 ./include
 ./arch/x86/include/uapi
 ./include/uapi
 ./include/generated/uapi
 arch/x86/xenomai/include
 include/xenomai
 /usr/xenomai/include/trank/posix
 /usr/xenomai/include/trank
 /usr/xenomai/include/cobalt
 /usr/xenomai/include
 /usr/xenomai/include/alchemy
 /usr/lib/gcc/x86_64-linux-gnu/5/include
End of search list.
GNU C89 (Ubuntu 5.4.0-6ubuntu1~16.04.4) version 5.4.0 20160609
(x86_64-linux-gnu)
    compiled by GNU C version 5.4.0 20160609, GMP version 6.1.0, MPFR
version 3.1.4, MPC version 1.0.3
GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
Compiler executable checksum: 78b6f8b2ed219a71c67c16db887e4800
In file included from /usr/xenomai/include/alchemy/heap.h:21:0,
                 from /usr/xenomai/include/trank/native/heap.h:21,
                 from /home/jlangston/mi/rfidrv/rfidrv/rfidrv2.c:2:
/usr/lib/gcc/x86_64-linux-gnu/5/include/stdint.h:9:26: error: no include
path in which to search for stdint.h
In file included from /usr/xenomai/include/trank/posix/pthread.h:19:0,
                 from /usr/xenomai/include/copperplate/clockobj.h:22,
                 from /usr/xenomai/include/alchemy/timer.h:22,
                 from /usr/xenomai/include/alchemy/heap.h:22,
                 from /usr/xenomai/include/trank/native/heap.h:21,
                 from /home/jlangston/mi/rfidrv/rfidrv/rfidrv2.c:2:
/usr/xenomai/include/cobalt/pthread.h:19:26: fatal error: pthread.h: No
such file or directory
compilation terminated.
scripts/Makefile.build:299: recipe for target
'/home/jlangston/mi/rfidrv/rfidrv/rfidrv2.o' failed
make[2]: *** [/home/jlangston/mi/rfidrv/rfidrv/rfidrv2.o] Error 1
Makefile:1490: recipe for target '_module_/home/jlangston/mi/rfidrv/rfidrv'
failed
make[1]: *** [_module_/home/jlangston/mi/rfidrv/rfidrv] Error 2
make[1]: Leaving directory '/usr/src/linux-4.9.24'
Makefile:11: recipe for target 'rfidrv' failed
make: *** [rfidrv] Error 2

Does anyone have a driver that they could post up that uses the heap
functions, a sample 'Makefile' with different flags/include options, or any
suggestions on how to resolve the include file mess here?

Thanks,
Jim
