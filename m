MIME-Version: 1.0
Date: Fri, 25 Sep 2009 15:12:52 +0900
Message-ID: <1f3e02580909242312i2a817f43y6a63a8d15631d3ec@domain.hid>
From: Didenko Sergey <didenkos@domain.hid>
Content-Type: multipart/alternative; boundary=001636e1f73e99318f047460d664
Subject: [Xenomai-help] Support for ARCH_MV88F6290
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
Cc: jorge.ramirez@domain.hid, "Me (Samsung Account)" <d.sergey@domain.hid>, mohamad.sharifi@domain.hid

--001636e1f73e99318f047460d664
Content-Type: text/plain; charset=UTF-8

Hello All

I'm porting Xenomai 2.4.9 to the Linux Kernel 2.6.29.

Target platform is MV 88F6290
CPU: ARM926EJ-S
Adeos patch: adeos-ipipe-2.6.29-arm-1.13-03.patch

I do patch the kernel with xenomai and adeos:
./prepare-kernel.sh --arch=arm --linux=/.../kernel/linux-2.6.29-v02.00.29/
--adeos=/.../xenomai-2.4.9/ksrc/arch/arm/patches/adeos-ipipe-2.6.29-arm-1.13-03.patch

Then I compile the Linux kernel.
At the time when I start to compile the kernel I have to answer for many
questions regarding configuration, it is Ok!
But finally I got the compile error like:

===
arch/arm/kernel/ipipe.c: In function '__ipipe_grab_irq':
arch/arm/kernel/ipipe.c:492: error: implicit declaration of function
'__ipipe_mach_irq_mux_p'
make[1]: *** [arch/arm/kernel/ipipe.o] Error 1
make: *** [arch/arm/kernel] Error 2
===

the reason of this error is that there is no definition of the macro
"__ipipe_mach_irq_mux_p" for the target platform as well as there are no the
others CPU dependent definitions.

If I refer to the file "arch/arm/mach-at91/include/mach/irqs.h" all
definitions like
CONFIG_ARCH_AT91SAM9* are not defined

But, in the Xenomai's build questionnaire messages (build time) I found next
lines:

===

*
* System Type
*
ARM system type
  1. Agilent AAEC-2000 based (ARCH_AAEC2000)
 .
 .
 .
  38. Nuvoton W90X900 CPU (ARCH_W90X900)
> 39. Marvell MV88F6290 (ARCH_MV88F6290)
choice[1-39]: 39

===

Actually I did not select any system type anyhow. And it does not allow me
to select it somehow, but the default choice is correct - system type is
MV88F6290! I don't know why but it is a very nice that default system type
is exactly what I need :) (please give some comments on it)

The questions!

1) It looks like Xenomai do support the target SoC (MV88F6290), as well as
do support processor type ARM926 it has.
Then why I can not find the CPU dependent definitions in the patched
kernel's source code?
2) What does it takes for you to support this system and CPU if it is not
supported yet?

IF you do support for this system for 2.6.29 version of kernel It would be
great because I can test it on my target board and give you all feed back
with the results, and finally you can include it to the next patches.

Looking forward to hearing from you any help regarding anything I can do to
run the patched kernel on my board successfully.

Sergey Didenko

--001636e1f73e99318f047460d664
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello All<br><br>I&#39;m porting Xenomai 2.4.9 to the Linux Kernel 2.6.29.<=
br><br>Target platform is MV 88F6290<br>CPU: ARM926EJ-S<br>Adeos patch: ade=
os-ipipe-2.6.29-arm-1.13-03.patch<br><br>I do patch the kernel with xenomai=
 and adeos:<br>
./prepare-kernel.sh --arch=3Darm --linux=3D/.../kernel/linux-2.6.29-v02.00.=
29/ --adeos=3D/.../xenomai-2.4.9/ksrc/arch/arm/patches/adeos-ipipe-2.6.29-a=
rm-1.13-03.patch<br>
<br>Then I compile the Linux kernel.<br>At the time when I start to compile=
 the kernel I have to answer for many questions regarding configuration, it=
 is Ok!<br>But finally I got the compile error like:<br><br>=3D=3D=3D<br>ar=
ch/arm/kernel/ipipe.c: In function &#39;__ipipe_grab_irq&#39;:<br>

arch/arm/kernel/ipipe.c:492: error: implicit declaration of function &#39;_=
_ipipe_mach_irq_mux_p&#39;<br>make[1]: *** [arch/arm/kernel/ipipe.o] Error =
1<br>make: *** [arch/arm/kernel] Error 2<br>=3D=3D=3D<br><br>the reason of =
this error is that there is no definition of the macro &quot;__ipipe_mach_i=
rq_mux_p&quot; for the target platform as well as there are no the others C=
PU dependent definitions.<br>
<br>
If I refer to the file &quot;arch/arm/mach-at91/include/mach/irqs.h&quot; a=
ll definitions like <br>CONFIG_ARCH_AT91SAM9* are not defined<br><br>But, i=
n the Xenomai&#39;s build questionnaire messages (build time) I found next =
lines:<br>

<br>=3D=3D=3D<br><br>*<br>* System Type<br>*<br>ARM system type<br>=C2=A0 1=
. Agilent AAEC-2000 based (ARCH_AAEC2000)<br>=C2=A0.<br>=C2=A0.<br>=C2=A0.<=
br>=C2=A0 38. Nuvoton W90X900 CPU (ARCH_W90X900)<br>&gt; 39. Marvell MV88F6=
290 (ARCH_MV88F6290)<br>choice[1-39]: 39<br>

<br>=3D=3D=3D<br><br>Actually I did not select any system type anyhow. And =
it does not allow me to select it somehow, but the default choice is correc=
t - system type is MV88F6290! I don&#39;t know why but it is a very nice th=
at default system type is exactly what I need :) (please give some comments=
 on it)<br>

<br>The questions!<br><br>1) It looks like Xenomai do support the target So=
C (MV88F6290), as well as do support processor type ARM926 it has.<br>Then =
why I can not find the CPU dependent definitions in the patched kernel&#39;=
s source code?<br>

2) What does it takes for you to support this system and CPU if it is not s=
upported yet?<br><br>IF you do support for this system for 2.6.29 version o=
f kernel It would be great because I can test it on my target board and giv=
e you all feed back with the results, and finally you can include it to the=
 next patches.<br>
<br>Looking forward to hearing from you any help regarding anything I can d=
o to run the patched kernel on my board successfully.<br><br>Sergey Didenko=
<br>

--001636e1f73e99318f047460d664--

