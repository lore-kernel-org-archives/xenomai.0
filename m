content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C657F9.0FB03205"
Date: Tue, 4 Apr 2006 17:04:24 +0200
Message-ID: <CC692F5386B0AA47A62B7484A7CA2B6D027A2D85@domain.hid>
From: "Behre, Frederik - LT" <Behre.Frederik@domain.hid>
Subject: [Xenomai-help] (no subject)
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

This is a multi-part message in MIME format.

------_=_NextPart_001_01C657F9.0FB03205
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello

I have following Problem when I Build my uImage from my kernel.

But first my configuration

Host system:
ix86
Suse Linux 10.0 32bit

Cross Compiler
Denx eldk ver. 3.11
(www.denx.de)

Target System
PPC (MPC8270) on Microsys PM827 Board.
linuxppc_2_4_devel-2005-10-25-1440
xenomai-2.1
adeos-ipipe-2.4.25-ppc-denx-1.0-03.patch

I did following Steps

installing the eldk
export Path to the Cross compiler to system Path
extrakt linux and xenomai=20
copy adeos

THEN
>./xenomai-2.1.0/scripts/prepare-kernel.sh --arch=3Dpowerpc \
	--adeos=3Dadeos-ipipe-2.4.25-ppc-denx-1.0-03patch  \
	--linux=3Dlinuxppc_2_4_devel-2005-10-25-1440/=20
patching file arch/ppc/config.in
patching file arch/ppc/kernel/Makefile
patching file arch/ppc/kernel/entry.S
patching file arch/ppc/kernel/head.S
patching file arch/ppc/kernel/head_440.S
patching file arch/ppc/kernel/head_44x.S
patching file arch/ppc/kernel/head_4xx.S
patching file arch/ppc/kernel/head_8xx.S
patching file arch/ppc/kernel/head_e500.S
patching file arch/ppc/kernel/idle.c
patching file arch/ppc/kernel/ipipe-core.c
patching file arch/ppc/kernel/ipipe-root.c
patching file arch/ppc/kernel/irq.c
patching file arch/ppc/kernel/ppc_ksyms.c
patching file arch/ppc/kernel/traps.c
patching file arch/ppc/mm/fault.c
patching file include/asm-ppc/hw_irq.h
patching file include/asm-ppc/ipipe.h
patching file include/asm-ppc/mmu_context.h
patching file include/asm-ppc/system.h
patching file include/linux/ipipe.h
patching file include/linux/sched.h
patching file init/main.c
patching file kernel/Makefile
patching file kernel/exit.c
patching file kernel/fork.c
patching file kernel/ipipe/Makefile
patching file kernel/ipipe/core.c
patching file kernel/ipipe/generic.c
patching file kernel/printk.c
patching file kernel/sched.c
patching file kernel/signal.c

# I think I is ok ???

>cd linuxppc_2_4_devel-2005-10-25-1440
>make ARCH=3Dppc CROSS_COMPILE=3Dppc_82xx- PM825config
/bin/sh: ppc-82xx-gcc: command not found
make: *** No rule to make target `PM825config'.  Stop.

# default settings for my board

>make ARCH=3Dppc CROSS_COMPILE=3Dppc_82xx- menuconfig
#
# Turn off PCI because my targetboard does not support PCI
# activate Xenomai and Nucleus=20
# nothing more, the rest I leave in default settings
#
# Exit and Save
#
>make ARCH=3Dppc CROSS_COMPILE=3Dppc_82xx- uImage

make[5]: Entering directory
`/root/eldk/311/usr/src/linuxppc_2_4_devel-2005-10-25-1440/kernel/xenoma
i/arch/generic'
ppc_82xx-gcc -D__KERNEL__
-I/root/eldk/311/usr/src/linuxppc_2_4_devel-2005-10-25-1440/include
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing
-fno-common -fomit-frame-pointer
-I/root/eldk/311/usr/src/linuxppc_2_4_devel-2005-10-25-1440/arch/ppc
-fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized
-mmultiple -mstring
-I/root/eldk/311/usr/src/linuxppc_2_4_devel-2005-10-25-1440/include/xeno
mai
-I/root/eldk/311/usr/src/linuxppc_2_4_devel-2005-10-25-1440/include/xeno
mai/compat -nostdinc -I
/root/eldk/311/usr/lib/gcc-lib/ppc-linux/3.3.3/include
-DKBUILD_BASENAME=3Dhal  -c -o hal.o hal.c
In file included from
/root/eldk/311/usr/src/linuxppc_2_4_devel-2005-10-25-1440/include/asm/xe
nomai/hal.h:32,
                 from hal.c:43:
/eldk/311/usr/src/linuxppc_2_4_devel-2005-10-25-1440/include/asm-generic
/xenomai/hal.h:60:2: #error "Adeos kernel support is required to run
this software."
/eldk/311/usr/src/linuxppc_2_4_devel-2005-10-25-1440/include/asm-generic
/xenomai/hal.h:61:2: #error "See http://download.gna.org/adeos/patches/"
In file included from
/root/eldk/311/usr/src/linuxppc_2_4_devel-2005-10-25-1440/include/asm/xe
nomai/hal.h:32,
                 from hal.c:43:
/eldk/311/usr/src/linuxppc_2_4_devel-2005-10-25-1440/include/asm-generic
/xenomai/hal.h: In function `rthal_get_cpufreq':
/eldk/311/usr/src/linuxppc_2_4_devel-2005-10-25-1440/include/asm-generic
/xenomai/hal.h:171: error: storage size of `sysinfo' isn't known
...
...
...ect...
...
...
make[5]: *** [hal.o] Error 1
make[5]: Leaving directory
`/root/eldk/311/usr/src/linuxppc_2_4_devel-2005-10-25-1440/kernel/xenoma
i/arch/generic'
make[4]: *** [first_rule] Error 2
make[4]: Leaving directory
`/root/eldk/311/usr/src/linuxppc_2_4_devel-2005-10-25-1440/kernel/xenoma
i/arch/generic'
make[3]: *** [_subdir_generic] Error 2
make[3]: Leaving directory
`/root/eldk/311/usr/src/linuxppc_2_4_devel-2005-10-25-1440/kernel/xenoma
i/arch'
make[2]: *** [_subdir_arch] Error 2
make[2]: Leaving directory
`/root/eldk/311/usr/src/linuxppc_2_4_devel-2005-10-25-1440/kernel/xenoma
i'
make[1]: *** [_subdir_xenomai] Error 2
make[1]: Leaving directory
`/root/eldk/311/usr/src/linuxppc_2_4_devel-2005-10-25-1440/kernel'
make: *** [_dir_kernel] Error 2

#
# and here is my problem=20
# what did I make wrong ??


Thanks a lot for Helping me.

Greetz Freddy'xenomai@xenomai.org'

------_=_NextPart_001_01C657F9.0FB03205
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.0.6603.0">
<TITLE></TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><FONT SIZE=3D2 FACE=3D"Arial">Hello</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">I have following Problem when I Build =
my uImage from my kernel.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">But first my configuration</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Host system:</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">ix86</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Suse Linux 10.0 32bit</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Cross Compiler</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Denx eldk ver. 3.11</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">(</FONT><A =
HREF=3D"file://www.denx.de"><U><FONT COLOR=3D"#0000FF" SIZE=3D2 =
FACE=3D"Arial">www.denx.de</FONT></U></A><FONT SIZE=3D2 =
FACE=3D"Arial">)</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Target System</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">PPC (MPC8270) on Microsys PM827 =
Board.</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">linuxppc_2_4_devel-2005-10-25-1440</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">xenomai-2.1</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">adeos-ipipe-2.4.25-ppc-denx-1.0-03.patch</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">I did following Steps</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">installing the eldk</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">export Path to the Cross compiler to =
system Path</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">extrakt linux and xenomai </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">copy adeos</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">THEN</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">&gt;./xenomai-2.1.0/scripts/prepare-kernel.sh =
--arch=3Dpowerpc \</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Arial">--adeos=3Dadeos-ipipe-2.4.25-ppc-denx-1.0-03patch&nbsp; =
\</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Arial">--linux=3Dlinuxppc_2_4_devel-2005-10-25-1440/ </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">patching file =
arch/ppc/config.in</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">patching file =
arch/ppc/kernel/Makefile</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">patching file =
arch/ppc/kernel/entry.S</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">patching file =
arch/ppc/kernel/head.S</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">patching file =
arch/ppc/kernel/head_440.S</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">patching file =
arch/ppc/kernel/head_44x.S</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">patching file =
arch/ppc/kernel/head_4xx.S</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">patching file =
arch/ppc/kernel/head_8xx.S</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">patching file =
arch/ppc/kernel/head_e500.S</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">patching file =
arch/ppc/kernel/idle.c</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">patching file =
arch/ppc/kernel/ipipe-core.c</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">patching file =
arch/ppc/kernel/ipipe-root.c</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">patching file =
arch/ppc/kernel/irq.c</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">patching file =
arch/ppc/kernel/ppc_ksyms.c</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">patching file =
arch/ppc/kernel/traps.c</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">patching file =
arch/ppc/mm/fault.c</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">patching file =
include/asm-ppc/hw_irq.h</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">patching file =
include/asm-ppc/ipipe.h</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">patching file =
include/asm-ppc/mmu_context.h</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">patching file =
include/asm-ppc/system.h</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">patching file =
include/linux/ipipe.h</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">patching file =
include/linux/sched.h</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">patching file init/main.c</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">patching file kernel/Makefile</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">patching file kernel/exit.c</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">patching file kernel/fork.c</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">patching file =
kernel/ipipe/Makefile</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">patching file =
kernel/ipipe/core.c</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">patching file =
kernel/ipipe/generic.c</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">patching file kernel/printk.c</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">patching file kernel/sched.c</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">patching file kernel/signal.c</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial"># I think I is ok ???</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">&gt;cd =
linuxppc_2_4_devel-2005-10-25-1440</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">&gt;make ARCH=3Dppc =
CROSS_COMPILE=3Dppc_82xx- PM825config</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">/bin/sh: ppc-82xx-gcc: command not =
found</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">make: *** No rule to make target =
`PM825config'.&nbsp; Stop.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial"># default settings for my board</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">&gt;make ARCH=3Dppc =
CROSS_COMPILE=3Dppc_82xx- menuconfig</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">#</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial"># Turn off PCI because my targetboard =
does not support PCI</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial"># activate Xenomai and Nucleus </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial"># nothing more, the rest I leave in =
default settings</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">#</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial"># Exit and Save</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">#</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">&gt;make ARCH=3Dppc =
CROSS_COMPILE=3Dppc_82xx- uImage</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">make[5]: Entering directory =
`/root/eldk/311/usr/src/linuxppc_2_4_devel-2005-10-25-1440/kernel/xenomai=
/arch/generic'</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">ppc_82xx-gcc -D__KERNEL__ =
-I/root/eldk/311/usr/src/linuxppc_2_4_devel-2005-10-25-1440/include =
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing =
-fno-common -fomit-frame-pointer =
-I/root/eldk/311/usr/src/linuxppc_2_4_devel-2005-10-25-1440/arch/ppc =
-fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized =
-mmultiple -mstring&nbsp; =
-I/root/eldk/311/usr/src/linuxppc_2_4_devel-2005-10-25-1440/include/xenom=
ai =
-I/root/eldk/311/usr/src/linuxppc_2_4_devel-2005-10-25-1440/include/xenom=
ai/compat -nostdinc -I =
/root/eldk/311/usr/lib/gcc-lib/ppc-linux/3.3.3/include =
-DKBUILD_BASENAME=3Dhal&nbsp; -c -o hal.o hal.c</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">In file included from =
/root/eldk/311/usr/src/linuxppc_2_4_devel-2005-10-25-1440/include/asm/xen=
omai/hal.h:32,</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from hal.c:43:</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">/eldk/311/usr/src/linuxppc_2_4_devel-2005-10-25-1440/inclu=
de/asm-generic/xenomai/hal.h:60:2: #error &quot;Adeos kernel support is =
required to run this software.&quot;</FONT></P>

<P><FONT SIZE=3D2 =
FACE=3D"Arial">/eldk/311/usr/src/linuxppc_2_4_devel-2005-10-25-1440/inclu=
de/asm-generic/xenomai/hal.h:61:2: #error &quot;See </FONT><A =
HREF=3D"http://download.gna.org/adeos/patches/"><U><FONT =
COLOR=3D"#0000FF" SIZE=3D2 =
FACE=3D"Arial">http://download.gna.org/adeos/patches/</FONT></U></A><FONT=
 SIZE=3D2 FACE=3D"Arial">&quot;</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">In file included from =
/root/eldk/311/usr/src/linuxppc_2_4_devel-2005-10-25-1440/include/asm/xen=
omai/hal.h:32,</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from hal.c:43:</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">/eldk/311/usr/src/linuxppc_2_4_devel-2005-10-25-1440/inclu=
de/asm-generic/xenomai/hal.h: In function =
`rthal_get_cpufreq':</FONT></P>

<P><FONT SIZE=3D2 =
FACE=3D"Arial">/eldk/311/usr/src/linuxppc_2_4_devel-2005-10-25-1440/inclu=
de/asm-generic/xenomai/hal.h:171: error: storage size of `sysinfo' isn't =
known</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">...</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">...</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">...ect...</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">...</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">...</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">make[5]: *** [hal.o] Error 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">make[5]: Leaving directory =
`/root/eldk/311/usr/src/linuxppc_2_4_devel-2005-10-25-1440/kernel/xenomai=
/arch/generic'</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">make[4]: *** [first_rule] Error =
2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">make[4]: Leaving directory =
`/root/eldk/311/usr/src/linuxppc_2_4_devel-2005-10-25-1440/kernel/xenomai=
/arch/generic'</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">make[3]: *** [_subdir_generic] Error =
2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">make[3]: Leaving directory =
`/root/eldk/311/usr/src/linuxppc_2_4_devel-2005-10-25-1440/kernel/xenomai=
/arch'</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">make[2]: *** [_subdir_arch] Error =
2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">make[2]: Leaving directory =
`/root/eldk/311/usr/src/linuxppc_2_4_devel-2005-10-25-1440/kernel/xenomai=
'</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">make[1]: *** [_subdir_xenomai] Error =
2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">make[1]: Leaving directory =
`/root/eldk/311/usr/src/linuxppc_2_4_devel-2005-10-25-1440/kernel'</FONT>=


<BR><FONT SIZE=3D2 FACE=3D"Arial">make: *** [_dir_kernel] Error 2</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">#</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial"># and here is my problem </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial"># what did I make wrong ??</FONT>
</P>
<BR>

<P><FONT SIZE=3D2 FACE=3D"Arial">Thanks a lot for Helping me.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Greetz =
Freddy'xenomai@xenomai.org'</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C657F9.0FB03205--

