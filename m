MIME-Version: 1.0
Date: Thu, 26 Feb 2009 12:03:54 +0100
Message-ID: <a0ef0a9d0902260303k711d228ct82e4bdae85d5ed1f@domain.hid>
From: Ghanem Lafi <lafi.ghanem@domain.hid>
Content-Type: multipart/alternative; boundary=0015174be854e18a7e0463d04e1e
Subject: [Xenomai-help] Xenomai uClinux issue
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

--0015174be854e18a7e0463d04e1e
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

hello,

my project is running on :

*  uclinux20051014
* linux 2.6.15
* LPC2292 (arm7 tdmi)
* arm-elf-gcc 2.95.3
* xenomai  2.6.4
* Adeos : adeos-ipipe-2.6.15-arm-1.5-08.patch




when i arrive to this step :

> make

i have this error :


root@domain.hid# make
make -C tools/ucfront
make[1]: Entering directory
`/home/sst/Bureau/Exp1/uClinux-dist/tools/ucfront'
make[1]: `ucfront' is up to date.
make[1]: Leaving directory
`/home/sst/Bureau/Exp1/uClinux-dist/tools/ucfront'
ln -sf /home/sst/Bureau/Exp1/uClinux-dist/tools/ucfront/ucfront
tools/ucfront-gcc
ln -sf /home/sst/Bureau/Exp1/uClinux-dist/tools/ucfront/ucfront
tools/ucfront-g++
make ARCH=arm CROSS_COMPILE=arm-elf- -C linux-2.6.x  || exit 1
make[1]: Entering directory `/home/sst/Bureau/Exp1/uClinux-dist/linux-2.6.x'
  CHK     include/linux/version.h
  UPD     include/linux/version.h
  SPLIT   include/linux/autoconf.h -> include/config/*
  SYMLINK include/asm-arm/arch -> include/asm-arm/arch-
  Generating include/asm-arm/mach-types.h
  CC      arch/arm/kernel/asm-offsets.s
In file included from include/linux/sched.h:4,
                 from arch/arm/kernel/asm-offsets.c:13:
include/asm/param.h:14: asm/arch/param.h: No such file or directory
In file included from include/linux/prefetch.h:14,
                 from include/linux/list.h:7,
                 from include/asm/ipipe.h:30,
                 from include/linux/preempt.h:31,
                 from include/linux/spinlock.h:50,
                 from include/linux/ipipe.h:26,
                 from include/linux/sched.h:7,
                 from arch/arm/kernel/asm-offsets.c:13:
include/asm/processor.h:25: asm/arch/memory.h: No such file or directory
In file included from include/asm/ipipe.h:34,
                 from include/linux/preempt.h:31,
                 from include/linux/spinlock.h:50,
                 from include/linux/ipipe.h:26,
                 from include/linux/sched.h:7,
                 from arch/arm/kernel/asm-offsets.c:13:
include/asm/irq.h:4: asm/arch/irqs.h: No such file or directory
In file included from include/linux/slab.h:18,
                 from include/linux/percpu.h:4,
                 from include/linux/ipipe.h:28,
                 from include/linux/sched.h:7,
                 from arch/arm/kernel/asm-offsets.c:13:
include/asm/page.h:11: unterminated `#if' conditional
In file included from include/linux/timex.h:61,
                 from include/linux/sched.h:12,
                 from arch/arm/kernel/asm-offsets.c:13:
include/asm/timex.h:15: asm/arch/timex.h: No such file or directory
In file included from include/linux/sched.h:13,
                 from arch/arm/kernel/asm-offsets.c:13:
include/linux/jiffies.h:213: warning: `CLOCK_TICK_RATE' is not defined
include/linux/jiffies.h:213: warning: `CLOCK_TICK_RATE' is not defined
include/linux/jiffies.h:213: division by zero in #if
include/linux/jiffies.h:213: warning: `CLOCK_TICK_RATE' is not defined
include/linux/jiffies.h:213: warning: `CLOCK_TICK_RATE' is not defined
include/linux/jiffies.h:213: division by zero in #if
include/linux/jiffies.h:213: warning: `CLOCK_TICK_RATE' is not defined
include/linux/jiffies.h:213: warning: `CLOCK_TICK_RATE' is not defined
include/linux/jiffies.h:213: division by zero in #if
include/linux/jiffies.h:213: division by zero in #if
include/linux/jiffies.h:213: warning: `CLOCK_TICK_RATE' is not defined
include/linux/jiffies.h:213: warning: `CLOCK_TICK_RATE' is not defined
include/linux/jiffies.h:213: division by zero in #if
include/linux/jiffies.h:213: warning: `CLOCK_TICK_RATE' is not defined
include/linux/jiffies.h:213: warning: `CLOCK_TICK_RATE' is not defined
include/linux/jiffies.h:213: division by zero in #if
include/linux/jiffies.h:213: warning: `CLOCK_TICK_RATE' is not defined
include/linux/jiffies.h:213: warning: `CLOCK_TICK_RATE' is not defined
include/linux/jiffies.h:213: division by zero in #if
include/linux/jiffies.h:213: division by zero in #if
include/linux/jiffies.h:213: warning: `CLOCK_TICK_RATE' is not defined
include/linux/jiffies.h:213: warning: `CLOCK_TICK_RATE' is not defined
include/linux/jiffies.h:213: division by zero in #if
include/linux/jiffies.h:213: warning: `CLOCK_TICK_RATE' is not defined
include/linux/jiffies.h:213: warning: `CLOCK_TICK_RATE' is not defined
include/linux/jiffies.h:213: division by zero in #if
include/linux/jiffies.h:213: warning: `CLOCK_TICK_RATE' is not defined
include/linux/jiffies.h:213: warning: `CLOCK_TICK_RATE' is not defined
include/linux/jiffies.h:213: division by zero in #if
include/linux/jiffies.h:213: warning: `CLOCK_TICK_RATE' is not defined
include/linux/jiffies.h:213: warning: `CLOCK_TICK_RATE' is not defined
include/linux/jiffies.h:213: division by zero in #if
include/linux/jiffies.h:213: warning: `CLOCK_TICK_RATE' is not defined
include/linux/jiffies.h:213: warning: `CLOCK_TICK_RATE' is not defined
include/linux/jiffies.h:213: division by zero in #if
include/linux/jiffies.h:213: warning: `CLOCK_TICK_RATE' is not defined
include/linux/jiffies.h:213: warning: `CLOCK_TICK_RATE' is not defined
include/linux/jiffies.h:213: division by zero in #if
include/linux/jiffies.h:213: division by zero in #if
include/linux/jiffies.h:385: warning: `CLOCK_TICK_RATE' is not defined
include/linux/jiffies.h:385: warning: `CLOCK_TICK_RATE' is not defined
include/linux/jiffies.h:385: division by zero in #if
include/linux/jiffies.h:385: warning: `CLOCK_TICK_RATE' is not defined
include/linux/jiffies.h:385: warning: `CLOCK_TICK_RATE' is not defined
include/linux/jiffies.h:385: division by zero in #if
include/linux/jiffies.h:385: warning: `CLOCK_TICK_RATE' is not defined
include/linux/jiffies.h:385: warning: `CLOCK_TICK_RATE' is not defined
include/linux/jiffies.h:385: division by zero in #if
include/linux/jiffies.h:385: division by zero in #if
include/linux/jiffies.h:385: warning: `CLOCK_TICK_RATE' is not defined
include/linux/jiffies.h:385: warning: `CLOCK_TICK_RATE' is not defined
include/linux/jiffies.h:385: division by zero in #if
include/linux/jiffies.h:385: warning: `CLOCK_TICK_RATE' is not defined
include/linux/jiffies.h:385: warning: `CLOCK_TICK_RATE' is not defined
include/linux/jiffies.h:385: division by zero in #if
include/linux/jiffies.h:385: warning: `CLOCK_TICK_RATE' is not defined
include/linux/jiffies.h:385: warning: `CLOCK_TICK_RATE' is not defined
include/linux/jiffies.h:385: division by zero in #if
include/linux/jiffies.h:385: division by zero in #if
include/linux/jiffies.h:385: warning: `CLOCK_TICK_RATE' is not defined
include/linux/jiffies.h:385: warning: `CLOCK_TICK_RATE' is not defined
include/linux/jiffies.h:385: division by zero in #if
include/linux/jiffies.h:385: warning: `CLOCK_TICK_RATE' is not defined
include/linux/jiffies.h:385: warning: `CLOCK_TICK_RATE' is not defined
include/linux/jiffies.h:385: division by zero in #if
include/linux/jiffies.h:385: warning: `CLOCK_TICK_RATE' is not defined
include/linux/jiffies.h:385: warning: `CLOCK_TICK_RATE' is not defined
include/linux/jiffies.h:385: division by zero in #if
include/linux/jiffies.h:385: warning: `CLOCK_TICK_RATE' is not defined
include/linux/jiffies.h:385: warning: `CLOCK_TICK_RATE' is not defined
include/linux/jiffies.h:385: division by zero in #if
include/linux/jiffies.h:385: warning: `CLOCK_TICK_RATE' is not defined
include/linux/jiffies.h:385: warning: `CLOCK_TICK_RATE' is not defined
include/linux/jiffies.h:385: division by zero in #if
include/linux/jiffies.h:385: warning: `CLOCK_TICK_RATE' is not defined
include/linux/jiffies.h:385: warning: `CLOCK_TICK_RATE' is not defined
include/linux/jiffies.h:385: division by zero in #if
include/linux/jiffies.h:385: division by zero in #if
include/linux/jiffies.h:416: warning: `CLOCK_TICK_RATE' is not defined
include/linux/jiffies.h:416: warning: `CLOCK_TICK_RATE' is not defined
include/linux/jiffies.h:416: division by zero in #if
include/linux/jiffies.h:416: warning: `CLOCK_TICK_RATE' is not defined
include/linux/jiffies.h:416: warning: `CLOCK_TICK_RATE' is not defined
include/linux/jiffies.h:416: division by zero in #if
include/linux/jiffies.h:416: warning: `CLOCK_TICK_RATE' is not defined
include/linux/jiffies.h:416: warning: `CLOCK_TICK_RATE' is not defined
include/linux/jiffies.h:416: division by zero in #if
include/linux/jiffies.h:416: division by zero in #if
include/linux/jiffies.h:416: warning: `CLOCK_TICK_RATE' is not defined
include/linux/jiffies.h:416: warning: `CLOCK_TICK_RATE' is not defined
include/linux/jiffies.h:416: division by zero in #if
include/linux/jiffies.h:416: warning: `CLOCK_TICK_RATE' is not defined
include/linux/jiffies.h:416: warning: `CLOCK_TICK_RATE' is not defined
include/linux/jiffies.h:416: division by zero in #if
include/linux/jiffies.h:416: warning: `CLOCK_TICK_RATE' is not defined
include/linux/jiffies.h:416: warning: `CLOCK_TICK_RATE' is not defined
include/linux/jiffies.h:416: division by zero in #if
include/linux/jiffies.h:416: division by zero in #if
include/linux/jiffies.h:416: warning: `CLOCK_TICK_RATE' is not defined
include/linux/jiffies.h:416: warning: `CLOCK_TICK_RATE' is not defined
include/linux/jiffies.h:416: division by zero in #if
include/linux/jiffies.h:416: warning: `CLOCK_TICK_RATE' is not defined
include/linux/jiffies.h:416: warning: `CLOCK_TICK_RATE' is not defined
include/linux/jiffies.h:416: division by zero in #if
include/linux/jiffies.h:416: warning: `CLOCK_TICK_RATE' is not defined
include/linux/jiffies.h:416: warning: `CLOCK_TICK_RATE' is not defined
include/linux/jiffies.h:416: division by zero in #if
include/linux/jiffies.h:416: warning: `CLOCK_TICK_RATE' is not defined
include/linux/jiffies.h:416: warning: `CLOCK_TICK_RATE' is not defined
include/linux/jiffies.h:416: division by zero in #if
include/linux/jiffies.h:416: warning: `CLOCK_TICK_RATE' is not defined
include/linux/jiffies.h:416: warning: `CLOCK_TICK_RATE' is not defined
include/linux/jiffies.h:416: division by zero in #if
include/linux/jiffies.h:416: warning: `CLOCK_TICK_RATE' is not defined
include/linux/jiffies.h:416: warning: `CLOCK_TICK_RATE' is not defined
include/linux/jiffies.h:416: division by zero in #if
include/linux/jiffies.h:416: division by zero in #if
In file included from include/linux/sched.h:22,
                 from arch/arm/kernel/asm-offsets.c:13:
include/asm/page.h:11: unterminated `#if' conditional
In file included from include/linux/mm.h:35,
                 from arch/arm/kernel/asm-offsets.c:14:
include/asm/page.h:11: unterminated `#if' conditional
In file included from include/asm/pgtable-nommu.h:21,
                 from include/asm/pgtable.h:17,
                 from include/linux/mm.h:36,
                 from arch/arm/kernel/asm-offsets.c:14:
include/asm/page.h:11: unterminated `#if' conditional
In file included from include/asm/io.h:28,
                 from include/asm/pgtable-nommu.h:22,
                 from include/asm/pgtable.h:17,
                 from include/linux/mm.h:36,
                 from arch/arm/kernel/asm-offsets.c:14:
include/asm/memory.h:28: asm/arch/memory.h: No such file or directory
In file included from include/asm/pgtable-nommu.h:22,
                 from include/asm/pgtable.h:17,
                 from include/linux/mm.h:36,
                 from arch/arm/kernel/asm-offsets.c:14:
include/asm/io.h:71: asm/arch/io.h: No such file or directory
arch/arm/kernel/asm-offsets.c:37: warning: `__GNUC_PATCHLEVEL__' is not
defined
make[2]: *** [arch/arm/kernel/asm-offsets.s] Error 1
make[1]: *** [prepare0] Error 2
make[1]: Leaving directory `/home/sst/Bureau/Exp1/uClinux-dist/linux-2.6.x'
make: *** [linux] Error 1
root@domain.hid#

*********************



how can i correct this mistakes ??

Thanks

Ghanem LAFI

--0015174be854e18a7e0463d04e1e
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">hello,<br><br>my project is running on :<br><br>*=A0 uclin=
ux20051014 <br>* linux 2.6.15<br>* LPC2292 (arm7 tdmi)<br>* arm-elf-gcc 2.9=
5.3<br>* xenomai=A0 2.6.4<br>* Adeos : adeos-ipipe-2.6.15-arm-1.5-08.patch<=
br>
<br><br><br><br>when i arrive to this step :<br><br>&gt; make<br><br>i have=
 this error :<br>
<br><br>root@domain.hid/<div dir=3D"ltr">Bureau/Exp1/uClinux-dis=
t# make<br>make -C tools/ucfront<br>make[1]: Entering directory `/home/sst/=
Bureau/Exp1/uClinux-dist/tools/ucfront&#39;<br>make[1]: `ucfront&#39; is up=
 to date.<br>

make[1]: Leaving directory `/home/sst/Bureau/Exp1/uClinux-dist/tools/ucfron=
t&#39;<br>ln -sf /home/sst/Bureau/Exp1/uClinux-dist/tools/ucfront/ucfront t=
ools/ucfront-gcc<br>ln -sf /home/sst/Bureau/Exp1/uClinux-dist/tools/ucfront=
/ucfront tools/ucfront-g++<br>

make ARCH=3Darm CROSS_COMPILE=3Darm-elf- -C linux-2.6.x=A0 || exit 1<br>mak=
e[1]: Entering directory `/home/sst/Bureau/Exp1/uClinux-dist/linux-2.6.x&#3=
9;<br>=A0 CHK=A0=A0=A0=A0 include/linux/version.h<br>=A0 UPD=A0=A0=A0=A0 in=
clude/linux/version.h<br>

=A0 SPLIT=A0=A0 include/linux/autoconf.h -&gt; include/config/*<br>=A0 SYML=
INK include/asm-arm/arch -&gt; include/asm-arm/arch-<br>=A0 Generating incl=
ude/asm-arm/mach-types.h<br>=A0 CC=A0=A0=A0=A0=A0 arch/arm/kernel/asm-offse=
ts.s<br>In file included from include/linux/sched.h:4,<br>

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 from arch/arm/kernel/asm-o=
ffsets.c:13:<br>include/asm/param.h:14: asm/arch/param.h: No such file or d=
irectory<br>In file included from include/linux/prefetch.h:14,<br>=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 from include/linux/list.h:7,<br>

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 from include/asm/ipipe.h:3=
0,<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 from include/linux/p=
reempt.h:31,<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 from inclu=
de/linux/spinlock.h:50,<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 from include/linux/ipipe.h:26,<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 from include/linux/sched.h:7,<br>

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 from arch/arm/kernel/asm-o=
ffsets.c:13:<br>include/asm/processor.h:25: asm/arch/memory.h: No such file=
 or directory<br>In file included from include/asm/ipipe.h:34,<br>=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 from include/linux/preempt.h:31,<br=
>

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 from include/linux/spinloc=
k.h:50,<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 from include/li=
nux/ipipe.h:26,<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 from in=
clude/linux/sched.h:7,<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
from arch/arm/kernel/asm-offsets.c:13:<br>include/asm/irq.h:4: asm/arch/irq=
s.h: No such file or directory<br>

In file included from include/linux/slab.h:18,<br>=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 from include/linux/percpu.h:4,<br>=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 from include/linux/ipipe.h:28,<br>=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 from include/linux/sched.h:7,<br=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 from arch/arm/kernel/asm-=
offsets.c:13:<br>

include/asm/page.h:11: unterminated `#if&#39; conditional<br>In file includ=
ed from include/linux/timex.h:61,<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 from include/linux/sched.h:12,<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 from arch/arm/kernel/asm-offsets.c:13:<br>

include/asm/timex.h:15: asm/arch/timex.h: No such file or directory<br>In f=
ile included from include/linux/sched.h:13,<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 from arch/arm/kernel/asm-offsets.c:13:<br>include/lin=
ux/jiffies.h:213: warning: `CLOCK_TICK_RATE&#39; is not defined<br>

include/linux/jiffies.h:213: warning: `CLOCK_TICK_RATE&#39; is not defined<=
br>include/linux/jiffies.h:213: division by zero in #if<br>include/linux/ji=
ffies.h:213: warning: `CLOCK_TICK_RATE&#39; is not defined<br>include/linux=
/jiffies.h:213: warning: `CLOCK_TICK_RATE&#39; is not defined<br>

include/linux/jiffies.h:213: division by zero in #if<br>include/linux/jiffi=
es.h:213: warning: `CLOCK_TICK_RATE&#39; is not defined<br>include/linux/ji=
ffies.h:213: warning: `CLOCK_TICK_RATE&#39; is not defined<br>include/linux=
/jiffies.h:213: division by zero in #if<br>

include/linux/jiffies.h:213: division by zero in #if<br>include/linux/jiffi=
es.h:213: warning: `CLOCK_TICK_RATE&#39; is not defined<br>include/linux/ji=
ffies.h:213: warning: `CLOCK_TICK_RATE&#39; is not defined<br>include/linux=
/jiffies.h:213: division by zero in #if<br>

include/linux/jiffies.h:213: warning: `CLOCK_TICK_RATE&#39; is not defined<=
br>include/linux/jiffies.h:213: warning: `CLOCK_TICK_RATE&#39; is not defin=
ed<br>include/linux/jiffies.h:213: division by zero in #if<br>include/linux=
/jiffies.h:213: warning: `CLOCK_TICK_RATE&#39; is not defined<br>

include/linux/jiffies.h:213: warning: `CLOCK_TICK_RATE&#39; is not defined<=
br>include/linux/jiffies.h:213: division by zero in #if<br>include/linux/ji=
ffies.h:213: division by zero in #if<br>include/linux/jiffies.h:213: warnin=
g: `CLOCK_TICK_RATE&#39; is not defined<br>

include/linux/jiffies.h:213: warning: `CLOCK_TICK_RATE&#39; is not defined<=
br>include/linux/jiffies.h:213: division by zero in #if<br>include/linux/ji=
ffies.h:213: warning: `CLOCK_TICK_RATE&#39; is not defined<br>include/linux=
/jiffies.h:213: warning: `CLOCK_TICK_RATE&#39; is not defined<br>

include/linux/jiffies.h:213: division by zero in #if<br>include/linux/jiffi=
es.h:213: warning: `CLOCK_TICK_RATE&#39; is not defined<br>include/linux/ji=
ffies.h:213: warning: `CLOCK_TICK_RATE&#39; is not defined<br>include/linux=
/jiffies.h:213: division by zero in #if<br>

include/linux/jiffies.h:213: warning: `CLOCK_TICK_RATE&#39; is not defined<=
br>include/linux/jiffies.h:213: warning: `CLOCK_TICK_RATE&#39; is not defin=
ed<br>include/linux/jiffies.h:213: division by zero in #if<br>include/linux=
/jiffies.h:213: warning: `CLOCK_TICK_RATE&#39; is not defined<br>

include/linux/jiffies.h:213: warning: `CLOCK_TICK_RATE&#39; is not defined<=
br>include/linux/jiffies.h:213: division by zero in #if<br>include/linux/ji=
ffies.h:213: warning: `CLOCK_TICK_RATE&#39; is not defined<br>include/linux=
/jiffies.h:213: warning: `CLOCK_TICK_RATE&#39; is not defined<br>

include/linux/jiffies.h:213: division by zero in #if<br>include/linux/jiffi=
es.h:213: division by zero in #if<br>include/linux/jiffies.h:385: warning: =
`CLOCK_TICK_RATE&#39; is not defined<br>include/linux/jiffies.h:385: warnin=
g: `CLOCK_TICK_RATE&#39; is not defined<br>

include/linux/jiffies.h:385: division by zero in #if<br>include/linux/jiffi=
es.h:385: warning: `CLOCK_TICK_RATE&#39; is not defined<br>include/linux/ji=
ffies.h:385: warning: `CLOCK_TICK_RATE&#39; is not defined<br>include/linux=
/jiffies.h:385: division by zero in #if<br>

include/linux/jiffies.h:385: warning: `CLOCK_TICK_RATE&#39; is not defined<=
br>include/linux/jiffies.h:385: warning: `CLOCK_TICK_RATE&#39; is not defin=
ed<br>include/linux/jiffies.h:385: division by zero in #if<br>include/linux=
/jiffies.h:385: division by zero in #if<br>

include/linux/jiffies.h:385: warning: `CLOCK_TICK_RATE&#39; is not defined<=
br>include/linux/jiffies.h:385: warning: `CLOCK_TICK_RATE&#39; is not defin=
ed<br>include/linux/jiffies.h:385: division by zero in #if<br>include/linux=
/jiffies.h:385: warning: `CLOCK_TICK_RATE&#39; is not defined<br>

include/linux/jiffies.h:385: warning: `CLOCK_TICK_RATE&#39; is not defined<=
br>include/linux/jiffies.h:385: division by zero in #if<br>include/linux/ji=
ffies.h:385: warning: `CLOCK_TICK_RATE&#39; is not defined<br>include/linux=
/jiffies.h:385: warning: `CLOCK_TICK_RATE&#39; is not defined<br>

include/linux/jiffies.h:385: division by zero in #if<br>include/linux/jiffi=
es.h:385: division by zero in #if<br>include/linux/jiffies.h:385: warning: =
`CLOCK_TICK_RATE&#39; is not defined<br>include/linux/jiffies.h:385: warnin=
g: `CLOCK_TICK_RATE&#39; is not defined<br>

include/linux/jiffies.h:385: division by zero in #if<br>include/linux/jiffi=
es.h:385: warning: `CLOCK_TICK_RATE&#39; is not defined<br>include/linux/ji=
ffies.h:385: warning: `CLOCK_TICK_RATE&#39; is not defined<br>include/linux=
/jiffies.h:385: division by zero in #if<br>

include/linux/jiffies.h:385: warning: `CLOCK_TICK_RATE&#39; is not defined<=
br>include/linux/jiffies.h:385: warning: `CLOCK_TICK_RATE&#39; is not defin=
ed<br>include/linux/jiffies.h:385: division by zero in #if<br>include/linux=
/jiffies.h:385: warning: `CLOCK_TICK_RATE&#39; is not defined<br>

include/linux/jiffies.h:385: warning: `CLOCK_TICK_RATE&#39; is not defined<=
br>include/linux/jiffies.h:385: division by zero in #if<br>include/linux/ji=
ffies.h:385: warning: `CLOCK_TICK_RATE&#39; is not defined<br>include/linux=
/jiffies.h:385: warning: `CLOCK_TICK_RATE&#39; is not defined<br>

include/linux/jiffies.h:385: division by zero in #if<br>include/linux/jiffi=
es.h:385: warning: `CLOCK_TICK_RATE&#39; is not defined<br>include/linux/ji=
ffies.h:385: warning: `CLOCK_TICK_RATE&#39; is not defined<br>include/linux=
/jiffies.h:385: division by zero in #if<br>

include/linux/jiffies.h:385: division by zero in #if<br>include/linux/jiffi=
es.h:416: warning: `CLOCK_TICK_RATE&#39; is not defined<br>include/linux/ji=
ffies.h:416: warning: `CLOCK_TICK_RATE&#39; is not defined<br>include/linux=
/jiffies.h:416: division by zero in #if<br>

include/linux/jiffies.h:416: warning: `CLOCK_TICK_RATE&#39; is not defined<=
br>include/linux/jiffies.h:416: warning: `CLOCK_TICK_RATE&#39; is not defin=
ed<br>include/linux/jiffies.h:416: division by zero in #if<br>include/linux=
/jiffies.h:416: warning: `CLOCK_TICK_RATE&#39; is not defined<br>

include/linux/jiffies.h:416: warning: `CLOCK_TICK_RATE&#39; is not defined<=
br>include/linux/jiffies.h:416: division by zero in #if<br>include/linux/ji=
ffies.h:416: division by zero in #if<br>include/linux/jiffies.h:416: warnin=
g: `CLOCK_TICK_RATE&#39; is not defined<br>

include/linux/jiffies.h:416: warning: `CLOCK_TICK_RATE&#39; is not defined<=
br>include/linux/jiffies.h:416: division by zero in #if<br>include/linux/ji=
ffies.h:416: warning: `CLOCK_TICK_RATE&#39; is not defined<br>include/linux=
/jiffies.h:416: warning: `CLOCK_TICK_RATE&#39; is not defined<br>

include/linux/jiffies.h:416: division by zero in #if<br>include/linux/jiffi=
es.h:416: warning: `CLOCK_TICK_RATE&#39; is not defined<br>include/linux/ji=
ffies.h:416: warning: `CLOCK_TICK_RATE&#39; is not defined<br>include/linux=
/jiffies.h:416: division by zero in #if<br>

include/linux/jiffies.h:416: division by zero in #if<br>include/linux/jiffi=
es.h:416: warning: `CLOCK_TICK_RATE&#39; is not defined<br>include/linux/ji=
ffies.h:416: warning: `CLOCK_TICK_RATE&#39; is not defined<br>include/linux=
/jiffies.h:416: division by zero in #if<br>

include/linux/jiffies.h:416: warning: `CLOCK_TICK_RATE&#39; is not defined<=
br>include/linux/jiffies.h:416: warning: `CLOCK_TICK_RATE&#39; is not defin=
ed<br>include/linux/jiffies.h:416: division by zero in #if<br>include/linux=
/jiffies.h:416: warning: `CLOCK_TICK_RATE&#39; is not defined<br>

include/linux/jiffies.h:416: warning: `CLOCK_TICK_RATE&#39; is not defined<=
br>include/linux/jiffies.h:416: division by zero in #if<br>include/linux/ji=
ffies.h:416: warning: `CLOCK_TICK_RATE&#39; is not defined<br>include/linux=
/jiffies.h:416: warning: `CLOCK_TICK_RATE&#39; is not defined<br>

include/linux/jiffies.h:416: division by zero in #if<br>include/linux/jiffi=
es.h:416: warning: `CLOCK_TICK_RATE&#39; is not defined<br>include/linux/ji=
ffies.h:416: warning: `CLOCK_TICK_RATE&#39; is not defined<br>include/linux=
/jiffies.h:416: division by zero in #if<br>

include/linux/jiffies.h:416: warning: `CLOCK_TICK_RATE&#39; is not defined<=
br>include/linux/jiffies.h:416: warning: `CLOCK_TICK_RATE&#39; is not defin=
ed<br>include/linux/jiffies.h:416: division by zero in #if<br>include/linux=
/jiffies.h:416: division by zero in #if<br>

In file included from include/linux/sched.h:22,<br>=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 from arch/arm/kernel/asm-offsets.c:13:<br>include/=
asm/page.h:11: unterminated `#if&#39; conditional<br>In file included from =
include/linux/mm.h:35,<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
from arch/arm/kernel/asm-offsets.c:14:<br>

include/asm/page.h:11: unterminated `#if&#39; conditional<br>In file includ=
ed from include/asm/pgtable-nommu.h:21,<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 from include/asm/pgtable.h:17,<br>=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 from include/linux/mm.h:36,<br>=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 from arch/arm/kernel/asm-offsets.c:14:<br=
>

include/asm/page.h:11: unterminated `#if&#39; conditional<br>In file includ=
ed from include/asm/io.h:28,<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 from include/asm/pgtable-nommu.h:22,<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 from include/asm/pgtable.h:17,<br>=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 from include/linux/mm.h:36,<br>

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 from arch/arm/kernel/asm-o=
ffsets.c:14:<br>include/asm/memory.h:28: asm/arch/memory.h: No such file or=
 directory<br>In file included from include/asm/pgtable-nommu.h:22,<br>=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 from include/asm/pgtable.h:17=
,<br>

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 from include/linux/mm.h:36=
,<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 from arch/arm/kernel/=
asm-offsets.c:14:<br>include/asm/io.h:71: asm/arch/io.h: No such file or di=
rectory<br>arch/arm/kernel/asm-offsets.c:37: warning: `__GNUC_PATCHLEVEL__&=
#39; is not defined<br>

make[2]: *** [arch/arm/kernel/asm-offsets.s] Error 1<br>make[1]: *** [prepa=
re0] Error 2<br>make[1]: Leaving directory `/home/sst/Bureau/Exp1/uClinux-d=
ist/linux-2.6.x&#39;<br>make: *** [linux] Error 1<br>root@domain.hid=
/sst/Bureau/Exp1/uClinux-dist# <br>

<br>*********************<br><br><br><br>how can i correct this mistakes ??=
<br><br>Thanks <br><br>Ghanem LAFI<br></div></div>

--0015174be854e18a7e0463d04e1e--

