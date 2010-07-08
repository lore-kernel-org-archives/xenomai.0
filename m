MIME-Version: 1.0
Date: Thu, 8 Jul 2010 14:42:36 +0300
Message-ID: <AANLkTilhwN4_JeD3KRCEWLxkOZSIcYwij1qZjKRvR8DN@mail.gmail.com>
From: =?ISO-8859-9?Q?G=F6rkem_Karado=F0an?= <gkaradagan@domain.hid>
Content-Type: multipart/alternative; boundary=0016e644d6ca6ea851048adec81b
Subject: [Xenomai-help] How can i fix this error ?
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

--0016e644d6ca6ea851048adec81b
Content-Type: text/plain; charset=ISO-8859-1

root@domain.hid# make
scripts/kconfig/conf -s arch/x86/Kconfig
  CHK     include/linux/version.h
  CHK     include/generated/utsrelease.h
  CC      kernel/bounds.s
  GEN     include/generated/bounds.h
  CC      arch/x86/kernel/asm-offsets.s
In file included from include/linux/sched.h:64,
                 from arch/x86/kernel/asm-offsets_32.c:8,
                 from arch/x86/kernel/asm-offsets.c:2:
include/linux/ipipe.h:31:23: error: asm/ipipe.h: No such file or directory
make[1]: *** [arch/x86/kernel/asm-offsets.s] Error 1
make: *** [prepare0] Error 2
root@domain.hid#

--0016e644d6ca6ea851048adec81b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

root@domain.hid# make<br>scripts/kconfig/conf -s arch/x86/Kco=
nfig<br>=A0 CHK=A0=A0=A0=A0 include/linux/version.h<br>=A0 CHK=A0=A0=A0=A0 =
include/generated/utsrelease.h<br>=A0 CC=A0=A0=A0=A0=A0 kernel/bounds.s<br>=
=A0 GEN=A0=A0=A0=A0 include/generated/bounds.h<br>
=A0 CC=A0=A0=A0=A0=A0 arch/x86/kernel/asm-offsets.s<br>In file included fro=
m include/linux/sched.h:64,<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 from arch/x86/kernel/asm-offsets_32.c:8,<br>=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 from arch/x86/kernel/asm-offsets.c:2:<br>include/l=
inux/ipipe.h:31:23: error: asm/ipipe.h: No such file or directory<br>
make[1]: *** [arch/x86/kernel/asm-offsets.s] Error 1<br>make: *** [prepare0=
] Error 2<br>root@domain.hid# <br><br>

--0016e644d6ca6ea851048adec81b--

