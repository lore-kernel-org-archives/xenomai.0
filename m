Subject: Re: timer.h in rtdm module
References: <CA+K1mPG_JcR26PUBNrB9_g9q1ifCJYJmDu6eJ-E+e6Y-6iAnXw@mail.gmail.com>
 <d319441e-7fac-b61e-501c-f24b81ab2d6d@siemens.com>
 <CA+K1mPGmOii=krPSdnhG1+5yyU8w1aSY7uvc8uFru1RP-X_tHA@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <72d06793-1885-5884-693b-8f28b51d85fc@siemens.com>
Date: Thu, 7 Oct 2021 10:17:48 +0200
MIME-Version: 1.0
In-Reply-To: <CA+K1mPGmOii=krPSdnhG1+5yyU8w1aSY7uvc8uFru1RP-X_tHA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: C Smith <csmithquestions@gmail.com>
Cc: Xenomai List <xenomai@xenomai.org>

On 07.10.21 10:11, C Smith wrote:
> Thanks for the insight. I removed the -isystem line, I don't know where
> it came from, I have legacy xeno 2.6 Makefiles. I added a few more paths
> to system headers. I am now getting a lot of redefined symbols errors. 
> Here is current attempt to compile: (this is compiled while standing in
> /usr/src/linux/ BTW)
> 
> gcc -Wp,-MD,/home/appuser/src/codebase/ecl/modules/.myapp.o.d -nostdinc
> -I./arch/x86/include -I./arch/x86/include/generated  -I./include
> -I./include/linux -I/usr/lib/gcc/x86_64-redhat-linux/8/include
>  -I./arch/x86/include/uapi -I./arch/x86/include/generated/uapi
> -I./include/uapi -I./include/generated/uapi -include
> ./include/linux/kconfig.h -include ./include/linux/compiler_types.h
> -I/usr/xenomai/include/cobalt -I/usr/include -D__KERNEL__ -Wall -Wundef
> -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common
> -fshort-wchar -Werror-implicit-function-declaration -Wno-format-security
> -std=gnu89 -fno-PIE -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx -m64
> -falign-jumps=1 -falign-loops=1 -mno-80387 -mno-fp-ret-in-387
> -mpreferred-stack-boundary=3 -mskip-rax-setup -mtune=generic
> -mno-red-zone -mcmodel=kernel -funit-at-a-time -DCONFIG_AS_CFI=1
                ^^^^^^^^^^^^^^^

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
> -fno-optimize-sibling-calls -fno-var-tracking-assignments -g -pg
> -mfentry -DCC_USING_FENTRY -Wdeclaration-after-statement
> -Wno-pointer-sign -Wno-stringop-truncation -fno-strict-overflow
> -fno-merge-all-constants -fmerge-constants -fno-stack-check
> -fconserve-stack -Werror=implicit-int -Werror=strict-prototypes
> -Werror=date-time -Werror=incompatible-pointer-types
> -Werror=designated-init -fmacro-prefix-map=./= -fcf-protection=none
> -Wno-packed-not-aligned
> -I/lib/modules/4.19.89xeno3.1-i64x8632/build/include/xenomai
> -I/lib/modules/4.19.89xeno3.1-i64x8632/build/include/xenomai/posix
> -I/home/appuser/src/codebase -I/usr/xenomai/include/trank
> -I/usr/xenomai/include -D__XENO_COMPAT__  -DMODULE
>  -DKBUILD_BASENAME='"myapp"' -DKBUILD_MODNAME='"myapp"' -c -o
> /home/appuser/src/codebase/ecl/modules/myapp.o
> /home/appuser/src/codebase/ecl/modules/myapp.c
> In file included from /usr/xenomai/include/trank/trank.h:21,
>                  from /usr/xenomai/include/trank/native/timer.h:22,
>                  from /home/appuser/src/codebase/ecl/modules/myapp.c:19:
> /usr/xenomai/include/boilerplate/compiler.h:23: warning: "container_of"
> redefined
>  #define container_of(ptr, type, member)     \
>  
> In file included from ./include/linux/list.h:9,
>                  from ./include/linux/module.h:9,
>                  from /home/appuser/src/codebase/ecl/modules/myapp.c:7:
> ./include/linux/kernel.h:1000: note: this is the location of the
            ^^^^^^^^^^^^^^

Your build configuration is completely messed up, using kernel settings
to compile a userspace program.

You usually just need

gcc -o my-app my-app.c $(xeno-config --skin=posix --clflags --ldflags)

Start from there, then add what you actually need.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

