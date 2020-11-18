From: Jona Ostermann <Jona.Ostermann@janztec.com>
Subject: Xenomai patch for kernel 4.19.94 i386
Date: Wed, 18 Nov 2020 21:32:22 +0000
Message-ID: <FRXPR01MB0984F4AE4E3D8B778451D5FA8FE10@FRXPR01MB0984.DEUPRD01.PROD.OUTLOOK.DE>
Content-Language: de-DE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello,

I am trying to build the linux kernel version 4.19.94 with xenomai 3.1 and =
the ipipe patch version 4.19.94-cip18-x86-10 on a debian 9 system.
I did not change anything in the kernel config except for disabling Hyper-V=
.
This works fine for the 64 bit kernel, but if I try to build a 32 bit kerne=
l I get an error:

+ make -j 4
Makefile:590: include/config/auto.conf: No such file or directory
Makefile:621: include/config/auto.conf.cmd: No such file or directory
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/kconfig/conf.o
  YACC    scripts/kconfig/zconf.tab.c
  LEX     scripts/kconfig/zconf.lex.c
  HOSTCC  scripts/kconfig/zconf.tab.o
  HOSTLD  scripts/kconfig/conf
scripts/kconfig/conf  --syncconfig Kconfig

WARNING: unmet direct dependencies detected for IPIPE
  Depends on [n]: HAVE_IPIPE_SUPPORT [=3Dn]
  Selected by [y]:
  - XENOMAI [=3Dy] && (X86_TSC [=3Dy] || !X86 [=3Dy])

WARNING: unmet direct dependencies detected for IPIPE
  Depends on [n]: HAVE_IPIPE_SUPPORT [=3Dn]
  Selected by [y]:
  - XENOMAI [=3Dy] && (X86_TSC [=3Dy] || !X86 [=3Dy])
  SYSTBL  arch/x86/include/generated/asm/syscalls_32.h
  WRAP    arch/x86/include/generated/uapi/asm/bpf_perf_event.h
[...]
  HOSTCC  scripts/asn1_compiler
  HOSTCC  scripts/extract-cert
  CC      kernel/bounds.s
  UPD     include/generated/timeconst.h
  UPD     include/generated/bounds.h
  CC      arch/x86/kernel/asm-offsets.s
In file included from ./arch/x86/include/asm/uaccess.h:10:0,
                 from ./include/linux/uaccess.h:14,
                 from ./include/linux/crypto.h:26,
                 from arch/x86/kernel/asm-offsets.c:9:
./include/linux/ipipe.h:223:28: error: field 'arch' has incomplete type
  struct ipipe_arch_sysinfo arch;
                            ^~~~
Kbuild:56: recipe for target 'arch/x86/kernel/asm-offsets.s' failed
make[1]: *** [arch/x86/kernel/asm-offsets.s] Error 1
Makefile:1102: recipe for target 'prepare0' failed


This output is from a 32 bit system, I get the same error if I try to build=
 on a 64 bit system with "make ARCH=3Di386".
I have also checked the kernel config HAVE_IPIPE_SUPPORT via "make menuconf=
ig", it says:

Symbol: HAVE_IPIPE_SUPPORT [=3Dn]
  x Type  : bool
  x   Defined at kernel/ipipe/Kconfig:2
  x   Depends on: GENERIC_CLOCKEVENTS [=3Dy]=20
  x   Selected by [n]:=20
  x   - X86 [=3Dy] && X86_64 [=3Dn]


Does this mean I can only build a 64 bit kernel with version 4.19.94 as the=
re is no ipipe support for 32 bit or am I misinterpreting the HAVE_IPIPE_SU=
PPORT warning?
What else could be the issue?


Best regards
Jona

