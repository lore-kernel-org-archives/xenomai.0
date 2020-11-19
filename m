Subject: Re: Xenomai patch for kernel 4.19.94 i386
References: <FRXPR01MB0984F4AE4E3D8B778451D5FA8FE10@FRXPR01MB0984.DEUPRD01.PROD.OUTLOOK.DE>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <8cbd5acf-8434-2deb-3bed-74f1fa594619@siemens.com>
Date: Thu, 19 Nov 2020 08:05:59 +0100
MIME-Version: 1.0
In-Reply-To: <FRXPR01MB0984F4AE4E3D8B778451D5FA8FE10@FRXPR01MB0984.DEUPRD01.PROD.OUTLOOK.DE>
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
To: Jona Ostermann <Jona.Ostermann@janztec.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 18.11.20 22:32, Jona Ostermann via Xenomai wrote:
> Hello,
> 
> I am trying to build the linux kernel version 4.19.94 with xenomai 3.1 and the ipipe patch version 4.19.94-cip18-x86-10 on a debian 9 system.
> I did not change anything in the kernel config except for disabling Hyper-V.
> This works fine for the 64 bit kernel, but if I try to build a 32 bit kernel I get an error:
> 
> + make -j 4
> Makefile:590: include/config/auto.conf: No such file or directory
> Makefile:621: include/config/auto.conf.cmd: No such file or directory
>   HOSTCC  scripts/basic/fixdep
>   HOSTCC  scripts/kconfig/conf.o
>   YACC    scripts/kconfig/zconf.tab.c
>   LEX     scripts/kconfig/zconf.lex.c
>   HOSTCC  scripts/kconfig/zconf.tab.o
>   HOSTLD  scripts/kconfig/conf
> scripts/kconfig/conf  --syncconfig Kconfig
> 
> WARNING: unmet direct dependencies detected for IPIPE
>   Depends on [n]: HAVE_IPIPE_SUPPORT [=n]
>   Selected by [y]:
>   - XENOMAI [=y] && (X86_TSC [=y] || !X86 [=y])
> 
> WARNING: unmet direct dependencies detected for IPIPE
>   Depends on [n]: HAVE_IPIPE_SUPPORT [=n]
>   Selected by [y]:
>   - XENOMAI [=y] && (X86_TSC [=y] || !X86 [=y])
>   SYSTBL  arch/x86/include/generated/asm/syscalls_32.h
>   WRAP    arch/x86/include/generated/uapi/asm/bpf_perf_event.h
> [...]
>   HOSTCC  scripts/asn1_compiler
>   HOSTCC  scripts/extract-cert
>   CC      kernel/bounds.s
>   UPD     include/generated/timeconst.h
>   UPD     include/generated/bounds.h
>   CC      arch/x86/kernel/asm-offsets.s
> In file included from ./arch/x86/include/asm/uaccess.h:10:0,
>                  from ./include/linux/uaccess.h:14,
>                  from ./include/linux/crypto.h:26,
>                  from arch/x86/kernel/asm-offsets.c:9:
> ./include/linux/ipipe.h:223:28: error: field 'arch' has incomplete type
>   struct ipipe_arch_sysinfo arch;
>                             ^~~~
> Kbuild:56: recipe for target 'arch/x86/kernel/asm-offsets.s' failed
> make[1]: *** [arch/x86/kernel/asm-offsets.s] Error 1
> Makefile:1102: recipe for target 'prepare0' failed
> 
> 
> This output is from a 32 bit system, I get the same error if I try to build on a 64 bit system with "make ARCH=i386".
> I have also checked the kernel config HAVE_IPIPE_SUPPORT via "make menuconfig", it says:
> 
> Symbol: HAVE_IPIPE_SUPPORT [=n]
>   x Type  : bool
>   x   Defined at kernel/ipipe/Kconfig:2
>   x   Depends on: GENERIC_CLOCKEVENTS [=y] 
>   x   Selected by [n]: 
>   x   - X86 [=y] && X86_64 [=n]
> 
> 
> Does this mean I can only build a 64 bit kernel with version 4.19.94 as there is no ipipe support for 32 bit or am I misinterpreting the HAVE_IPIPE_SUPPORT warning?
> What else could be the issue?
> 

We've stopped supporting i386 configurations for the kernel. Even
vanilla i386 receives minimal testing, for many years now. Everyone is
at least on a 64-bit kernel if not also userland, possibly with compat
support for 32-bit applications. In fact, the latter is what we are also
using in one product.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

