Subject: Re: timer.h in rtdm module
References: <CA+K1mPG_JcR26PUBNrB9_g9q1ifCJYJmDu6eJ-E+e6Y-6iAnXw@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <d319441e-7fac-b61e-501c-f24b81ab2d6d@siemens.com>
Date: Wed, 6 Oct 2021 12:25:21 +0200
MIME-Version: 1.0
In-Reply-To: <CA+K1mPG_JcR26PUBNrB9_g9q1ifCJYJmDu6eJ-E+e6Y-6iAnXw@mail.gmail.com>
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
To: C Smith <csmithquestions@gmail.com>, Xenomai List <xenomai@xenomai.org>

On 06.10.21 09:40, C Smith via Xenomai wrote:
> I have a legacy RTDM driver I am trying to port from Xenomai 2.6 to 3.1. I
> am attempting to include the /usr/xenomai/include/trank headers. My app
> uses some Alchemy API as well as RTDM API. In particular, rt_timer_read()
> seems to require Alchemy. But when my code does
> #include <native/timer.h>
> I get this compiler error:
> In file included from /home/csmith/src/app3-prog/modules/myapp.c:19:
> /usr/xenomai/include/trank/native/timer.h:21:10: fatal error: errno.h: No
> such file or directory
> 
> I compiled with make V=1 and I will show you the whole gcc command line
> (sorry it's long):
> 
> gcc -Wp,-MD,/home/csmith/src/app3-prog/ecl/modules/.myapp.o.d  -nostdinc
> -isystem /usr/lib/gcc/x86_64-redhat-linux/8/include -I./arch/x86/include

errno.h is expected under the system headers path, which you overwrite
to /usr/lib/gcc/x86_64-redhat-linux/8/include. Apparently, it's missing
there.

Jan

> -I./arch/x86/include/generated  -I./include -I./arch/x86/include/uapi
> -I./arch/x86/include/generated/uapi -I./include/uapi
> -I./include/generated/uapi -include ./include/linux/kconfig.h -include
> ./include/linux/compiler_types.h -D__KERNEL__ -Wall -Wundef
> -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common
> -fshort-wchar -Werror-implicit-function-declaration -Wno-format-security
> -std=gnu89 -fno-PIE -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx -m64
> -falign-jumps=1 -falign-loops=1 -mno-80387 -mno-fp-ret-in-387
> -mpreferred-stack-boundary=3 -mskip-rax-setup -mtune=generic -mno-red-zone
> -mcmodel=kernel -funit-at-a-time -DCONFIG_AS_CFI=1
> -DCONFIG_AS_CFI_SIGNAL_FRAME=1 -DCONFIG_AS_CFI_SECTIONS=1
> -DCONFIG_AS_FXSAVEQ=1 -DCONFIG_AS_SSSE3=1 -DCONFIG_AS_CRC32=1
> -DCONFIG_AS_AVX=1 -DCONFIG_AS_AVX2=1 -DCONFIG_AS_AVX512=1
> -DCONFIG_AS_SHA1_NI=1 -DCONFIG_AS_SHA256_NI=1 -pipe -Wno-sign-compare
> -fno-asynchronous-unwind-tables -mindirect-branch=thunk-extern
> -mindirect-branch-register -fno-jump-tables -Iarch/x86/xenomai/include
> -Iinclude/xenomai -fno-delete-null-pointer-checks -Wno-frame-address
> -Wno-format-truncation -Wno-format-overflow -Wno-int-in-bool-context -O2
> --param=allow-store-data-races=0 -Wframe-larger-than=2048
> -fstack-protector-strong -Wno-unused-but-set-variable
> -Wno-unused-const-variable -fno-omit-frame-pointer
> -fno-optimize-sibling-calls -fno-var-tracking-assignments -g -pg -mfentry
> -DCC_USING_FENTRY -Wdeclaration-after-statement -Wno-pointer-sign
> -Wno-stringop-truncation -fno-strict-overflow -fno-merge-all-constants
> -fmerge-constants -fno-stack-check -fconserve-stack -Werror=implicit-int
> -Werror=strict-prototypes -Werror=date-time
> -Werror=incompatible-pointer-types -Werror=designated-init
> -fmacro-prefix-map=./= -fcf-protection=none -Wno-packed-not-aligned
> -I/lib/modules/4.19.89xeno3.1-i64x8632/build/include/xenomai
> -I/lib/modules/4.19.89xeno3.1-i64x8632/build/include/xenomai/posix
> -I/home/csmith/src/app3-prog -I/usr/xenomai/include/trank
> -I/usr/xenomai/include -D__XENO_COMPAT__  -DMODULE
>  -DKBUILD_BASENAME='"myapp"' -DKBUILD_MODNAME='"myapp"' -c -o
> /home/csmith/src/app3-prog/modules/myapp.o
> /home/csmith/src/app3-prog/modules/myapp.c
> 
> How can I compile with the "trank" to get native/timer.h and
> rt_timer_read() ?
> 
> thanks, -C Smith
> 

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

