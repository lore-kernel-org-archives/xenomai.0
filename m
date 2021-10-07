MIME-Version: 1.0
References: <CA+K1mPG_JcR26PUBNrB9_g9q1ifCJYJmDu6eJ-E+e6Y-6iAnXw@mail.gmail.com>
 <d319441e-7fac-b61e-501c-f24b81ab2d6d@siemens.com>
In-Reply-To: <d319441e-7fac-b61e-501c-f24b81ab2d6d@siemens.com>
From: C Smith <csmithquestions@gmail.com>
Date: Thu, 7 Oct 2021 01:11:56 -0700
Message-ID: <CA+K1mPGmOii=krPSdnhG1+5yyU8w1aSY7uvc8uFru1RP-X_tHA@mail.gmail.com>
Subject: Re: timer.h in rtdm module
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai List <xenomai@xenomai.org>

Thanks for the insight. I removed the -isystem line, I don't know where it
came from, I have legacy xeno 2.6 Makefiles. I added a few more paths to
system headers. I am now getting a lot of redefined symbols errors.  Here
is current attempt to compile: (this is compiled while standing in
/usr/src/linux/ BTW)

gcc -Wp,-MD,/home/appuser/src/codebase/ecl/modules/.myapp.o.d -nostdinc
-I./arch/x86/include -I./arch/x86/include/generated  -I./include
-I./include/linux -I/usr/lib/gcc/x86_64-redhat-linux/8/include
 -I./arch/x86/include/uapi -I./arch/x86/include/generated/uapi
-I./include/uapi -I./include/generated/uapi -include
./include/linux/kconfig.h -include ./include/linux/compiler_types.h
-I/usr/xenomai/include/cobalt -I/usr/include -D__KERNEL__ -Wall -Wundef
-Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common
-fshort-wchar -Werror-implicit-function-declaration -Wno-format-security
-std=gnu89 -fno-PIE -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx -m64
-falign-jumps=1 -falign-loops=1 -mno-80387 -mno-fp-ret-in-387
-mpreferred-stack-boundary=3 -mskip-rax-setup -mtune=generic -mno-red-zone
-mcmodel=kernel -funit-at-a-time -DCONFIG_AS_CFI=1
-DCONFIG_AS_CFI_SIGNAL_FRAME=1 -DCONFIG_AS_CFI_SECTIONS=1
-DCONFIG_AS_FXSAVEQ=1 -DCONFIG_AS_SSSE3=1 -DCONFIG_AS_CRC32=1
-DCONFIG_AS_AVX=1 -DCONFIG_AS_AVX2=1 -DCONFIG_AS_AVX512=1
-DCONFIG_AS_SHA1_NI=1 -DCONFIG_AS_SHA256_NI=1 -pipe -Wno-sign-compare
-fno-asynchronous-unwind-tables -mindirect-branch=thunk-extern
-mindirect-branch-register -fno-jump-tables -Iarch/x86/xenomai/include
-Iinclude/xenomai -fno-delete-null-pointer-checks -Wno-frame-address
-Wno-format-truncation -Wno-format-overflow -Wno-int-in-bool-context -O2
--param=allow-store-data-races=0 -Wframe-larger-than=2048
-fstack-protector-strong -Wno-unused-but-set-variable
-Wno-unused-const-variable -fno-omit-frame-pointer
-fno-optimize-sibling-calls -fno-var-tracking-assignments -g -pg -mfentry
-DCC_USING_FENTRY -Wdeclaration-after-statement -Wno-pointer-sign
-Wno-stringop-truncation -fno-strict-overflow -fno-merge-all-constants
-fmerge-constants -fno-stack-check -fconserve-stack -Werror=implicit-int
-Werror=strict-prototypes -Werror=date-time
-Werror=incompatible-pointer-types -Werror=designated-init
-fmacro-prefix-map=./= -fcf-protection=none -Wno-packed-not-aligned
-I/lib/modules/4.19.89xeno3.1-i64x8632/build/include/xenomai
-I/lib/modules/4.19.89xeno3.1-i64x8632/build/include/xenomai/posix
-I/home/appuser/src/codebase -I/usr/xenomai/include/trank
-I/usr/xenomai/include -D__XENO_COMPAT__  -DMODULE
 -DKBUILD_BASENAME='"myapp"' -DKBUILD_MODNAME='"myapp"' -c -o
/home/appuser/src/codebase/ecl/modules/myapp.o
/home/appuser/src/codebase/ecl/modules/myapp.c
In file included from /usr/xenomai/include/trank/trank.h:21,
                 from /usr/xenomai/include/trank/native/timer.h:22,
                 from /home/appuser/src/codebase/ecl/modules/myapp.c:19:
/usr/xenomai/include/boilerplate/compiler.h:23: warning: "container_of"
redefined
 #define container_of(ptr, type, member)     \

In file included from ./include/linux/list.h:9,
                 from ./include/linux/module.h:9,
                 from /home/appuser/src/codebase/ecl/modules/myapp.c:7:
./include/linux/kernel.h:1000: note: this is the location of the previous
definition
 #define container_of(ptr, type, member) ({    \

In file included from /usr/xenomai/include/copperplate/clockobj.h:22,
                 from /usr/xenomai/include/alchemy/timer.h:22,
                 from /usr/xenomai/include/trank/native/timer.h:23,
                 from /home/appuser/src/codebase/ecl/modules/myapp.c:19:
/usr/xenomai/include/cobalt/pthread.h:33:25: error: field sched_param has
incomplete type
   struct sched_param_ex sched_param;
                         ^~~~~~~~~~~
In file included from /usr/xenomai/include/copperplate/clockobj.h:23,
                 from /usr/xenomai/include/alchemy/timer.h:22,
                 from /usr/xenomai/include/trank/native/timer.h:23,
                 from /home/appuser/src/codebase/ecl/modules/myapp.c:19:
/usr/xenomai/include/xeno_config.h:74: warning:
"CONFIG_XENO_REVISION_LEVEL" redefined
 #define CONFIG_XENO_REVISION_LEVEL

In file included from ././include/linux/kconfig.h:5,
                 from <command-line>:
./include/generated/autoconf.h:1916: note: this is the location of the
previous definition
 #define CONFIG_XENO_REVISION_LEVEL 0

I really don't have a tutorial as to how a RTDM module should be compiled.
Can you tell me why the headers above seem to conflict?
thanks  -C Smith


On Wed, Oct 6, 2021 at 3:25 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:

> On 06.10.21 09:40, C Smith via Xenomai wrote:
> > I have a legacy RTDM driver I am trying to port from Xenomai 2.6 to 3.1.
> I
> > am attempting to include the /usr/xenomai/include/trank headers. My app
> > uses some Alchemy API as well as RTDM API. In particular, rt_timer_read()
> > seems to require Alchemy. But when my code does
> > #include <native/timer.h>
> > I get this compiler error:
> > In file included from /home/csmith/src/app3-prog/modules/myapp.c:19:
> > /usr/xenomai/include/trank/native/timer.h:21:10: fatal error: errno.h: No
> > such file or directory
> >
> > I compiled with make V=1 and I will show you the whole gcc command line
> > (sorry it's long):
> >
> > gcc -Wp,-MD,/home/csmith/src/app3-prog/ecl/modules/.myapp.o.d  -nostdinc
> > -isystem /usr/lib/gcc/x86_64-redhat-linux/8/include -I./arch/x86/include
>
> errno.h is expected under the system headers path, which you overwrite
> to /usr/lib/gcc/x86_64-redhat-linux/8/include. Apparently, it's missing
> there.
>
> Jan
>
> > -I./arch/x86/include/generated  -I./include -I./arch/x86/include/uapi
> > -I./arch/x86/include/generated/uapi -I./include/uapi
> > -I./include/generated/uapi -include ./include/linux/kconfig.h -include
> > ./include/linux/compiler_types.h -D__KERNEL__ -Wall -Wundef
> > -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common
> > -fshort-wchar -Werror-implicit-function-declaration -Wno-format-security
> > -std=gnu89 -fno-PIE -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx -m64
> > -falign-jumps=1 -falign-loops=1 -mno-80387 -mno-fp-ret-in-387
> > -mpreferred-stack-boundary=3 -mskip-rax-setup -mtune=generic
> -mno-red-zone
> > -mcmodel=kernel -funit-at-a-time -DCONFIG_AS_CFI=1
> > -DCONFIG_AS_CFI_SIGNAL_FRAME=1 -DCONFIG_AS_CFI_SECTIONS=1
> > -DCONFIG_AS_FXSAVEQ=1 -DCONFIG_AS_SSSE3=1 -DCONFIG_AS_CRC32=1
> > -DCONFIG_AS_AVX=1 -DCONFIG_AS_AVX2=1 -DCONFIG_AS_AVX512=1
> > -DCONFIG_AS_SHA1_NI=1 -DCONFIG_AS_SHA256_NI=1 -pipe -Wno-sign-compare
> > -fno-asynchronous-unwind-tables -mindirect-branch=thunk-extern
> > -mindirect-branch-register -fno-jump-tables -Iarch/x86/xenomai/include
> > -Iinclude/xenomai -fno-delete-null-pointer-checks -Wno-frame-address
> > -Wno-format-truncation -Wno-format-overflow -Wno-int-in-bool-context -O2
> > --param=allow-store-data-races=0 -Wframe-larger-than=2048
> > -fstack-protector-strong -Wno-unused-but-set-variable
> > -Wno-unused-const-variable -fno-omit-frame-pointer
> > -fno-optimize-sibling-calls -fno-var-tracking-assignments -g -pg -mfentry
> > -DCC_USING_FENTRY -Wdeclaration-after-statement -Wno-pointer-sign
> > -Wno-stringop-truncation -fno-strict-overflow -fno-merge-all-constants
> > -fmerge-constants -fno-stack-check -fconserve-stack -Werror=implicit-int
> > -Werror=strict-prototypes -Werror=date-time
> > -Werror=incompatible-pointer-types -Werror=designated-init
> > -fmacro-prefix-map=./= -fcf-protection=none -Wno-packed-not-aligned
> > -I/lib/modules/4.19.89xeno3.1-i64x8632/build/include/xenomai
> > -I/lib/modules/4.19.89xeno3.1-i64x8632/build/include/xenomai/posix
> > -I/home/csmith/src/app3-prog -I/usr/xenomai/include/trank
> > -I/usr/xenomai/include -D__XENO_COMPAT__  -DMODULE
> >  -DKBUILD_BASENAME='"myapp"' -DKBUILD_MODNAME='"myapp"' -c -o
> > /home/csmith/src/app3-prog/modules/myapp.o
> > /home/csmith/src/app3-prog/modules/myapp.c
> >
> > How can I compile with the "trank" to get native/timer.h and
> > rt_timer_read() ?
> >
> > thanks, -C Smith
> >
>
> --
> Siemens AG, T RDA IOT
> Corporate Competence Center Embedded Linux
>
