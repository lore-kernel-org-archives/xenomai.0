Message-ID: <13402262.2612151287339120062.JavaMail.defaultUser@domain.hid>
Date: Sun, 17 Oct 2010 20:12:00 +0200 (CEST)
From: "gprizzi@domain.hid" <gprizzi@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_314624_7892787.1287339120062"
Subject: [Xenomai-help] Error building xenomai 2.5.5.1 on kubuntu 10.10 64
	bit
Reply-To: "gprizzi@domain.hid" <gprizzi@domain.hid>
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

------=_Part_314624_7892787.1287339120062
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

 Hello everyone,

 I am a new user of xenomai.
 I am trying to install xenomai on a system with the following characterist=
ics:

 - Intel Q6600
 - Kubuntu 10.10 - 64 bits version
 - linux kernel 2.6.35.7
 - xenomai 2.5.5.1
 - ggc  compiler version (Ubuntu/Linaro 4.4.4-14ubuntu5) 4.4.5


I followed the instructions for "Buildin Debian packages" from xenomai.org.
Everything was OK till applying patch to kernel.

After that I tried to build the kernel executing the following command:

CONCURRENCY_LEVEL=3D2 CLEAN_SOURCE=3Dno fakeroot make-kpkg --initrd --appen=
d-to-version -xenomai-2.5.5.1 --revision 1.0 kernel_image kernel_headers

but i get the following errors and build fails.









CC      kernel/xenomai/nucleus/pod.o
In file included from /home/giampy/linux-2.6.35.7/arch/x86/include/asm/xeno=
mai/bits/pod.h:4,
                 from kernel/xenomai/nucleus/pod.c:47:
/home/giampy/linux-2.6.35.7/arch/x86/include/asm/xenomai/bits/pod_64.h: In =
function =E2=80=98xnarch_switch_to=E2=80=99:
/home/giampy/linux-2.6.35.7/arch/x86/include/asm/xenomai/bits/pod_64.h:98: =
error: implicit declaration of function =E2=80=98per_cpu_var=E2=80=99
/home/giampy/linux-2.6.35.7/arch/x86/include/asm/xenomai/bits/pod_64.h:98: =
error: lvalue required in asm statement
/home/giampy/linux-2.6.35.7/arch/x86/include/asm/xenomai/bits/pod_64.h:98: =
error: invalid lvalue in asm output 6
/home/giampy/linux-2.6.35.7/arch/x86/include/asm/xenomai/bits/pod_64.h:98: =
error: memory input 14 is not directly addressable
/home/giampy/linux-2.6.35.7/arch/x86/include/asm/xenomai/bits/pod_64.h: In =
function =E2=80=98xnarch_thread_trampoline=E2=80=99:
/home/giampy/linux-2.6.35.7/arch/x86/include/asm/xenomai/bits/pod_64.h:113:=
 error: lvalue required in asm statement
/home/giampy/linux-2.6.35.7/arch/x86/include/asm/xenomai/bits/pod_64.h:113:=
 error: invalid lvalue in asm output 0
make[4]: *** [kernel/xenomai/nucleus/pod.o] Error 1
make[3]: *** [kernel/xenomai/nucleus] Error 2
make[2]: *** [kernel/xenomai] Error 2
make[1]: *** [kernel] Error 2
make[1]: *** Waiting for unfinished jobs....


Please can anyone help me to solve this problem?



Thank you in advance.

Gianpaolo Rizzi
 
------=_Part_314624_7892787.1287339120062
Content-Type: text/html;charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

&nbsp;Hello everyone,<BR><BR>&nbsp;I am a new user of xenomai.<BR>&nbsp;I a=
m trying to install xenomai on a system with the following characteristics:=
<BR><BR>&nbsp;- Intel Q6600<BR>&nbsp;- Kubuntu 10.10 - 64 bits version<BR>&=
nbsp;- linux kernel 2.6.35.7<BR>&nbsp;- xenomai 2.5.5.1<BR>&nbsp;- ggc&nbsp=
; compiler version (Ubuntu/Linaro 4.4.4-14ubuntu5) 4.4.5<BR><BR><BR>I follo=
wed the instructions for "Buildin Debian packages" from xenomai.org.<BR>Eve=
rything was OK till applying patch to kernel.<BR><BR>After that I tried to =
build the kernel&nbsp;executing the following command:<BR><BR><PRE>CONCURRE=
NCY_LEVEL=3D2 CLEAN_SOURCE=3Dno fakeroot make-kpkg --initrd --append-to-ver=
sion -xenomai-2.5.5.1 --revision 1.0 kernel_image kernel_headers<BR><BR>but=
 i get the following errors and build fails.<BR><BR><BR><BR><BR><BR><BR><BR=
><BR><BR>CC      kernel/xenomai/nucleus/pod.o<BR>In file included from /hom=
e/giampy/linux-2.6.35.7/arch/x86/include/asm/xenomai/bits/pod.h:4,<BR>     =
            from kernel/xenomai/nucleus/pod.c:47:<BR>/home/giampy/linux-2.6=
.35.7/arch/x86/include/asm/xenomai/bits/pod_64.h: In function =E2=80=98xnar=
ch_switch_to=E2=80=99:<BR>/home/giampy/linux-2.6.35.7/arch/x86/include/asm/=
xenomai/bits/pod_64.h:98: error: implicit declaration of function =E2=80=98=
per_cpu_var=E2=80=99<BR>/home/giampy/linux-2.6.35.7/arch/x86/include/asm/xe=
nomai/bits/pod_64.h:98: error: lvalue required in asm statement<BR>/home/gi=
ampy/linux-2.6.35.7/arch/x86/include/asm/xenomai/bits/pod_64.h:98: error: i=
nvalid lvalue in asm output 6<BR>/home/giampy/linux-2.6.35.7/arch/x86/inclu=
de/asm/xenomai/bits/pod_64.h:98: error: memory input 14 is not directly add=
ressable<BR>/home/giampy/linux-2.6.35.7/arch/x86/include/asm/xenomai/bits/p=
od_64.h: In function =E2=80=98xnarch_thread_trampoline=E2=80=99:<BR>/home/g=
iampy/linux-2.6.35.7/arch/x86/include/asm/xenomai/bits/pod_64.h:113: error:=
 lvalue required in asm statement<BR>/home/giampy/linux-2.6.35.7/arch/x86/i=
nclude/asm/xenomai/bits/pod_64.h:113: error: invalid lvalue in asm output 0=
<BR>make[4]: *** [kernel/xenomai/nucleus/pod.o] Error 1<BR>make[3]: *** [ke=
rnel/xenomai/nucleus] Error 2<BR>make[2]: *** [kernel/xenomai] Error 2<BR>m=
ake[1]: *** [kernel] Error 2<BR>make[1]: *** Waiting for unfinished jobs...=
.<BR><BR><BR>Please can anyone help me to solve this problem?<BR><BR><BR><B=
R>Thank you in advance.<BR><BR>Gianpaolo Rizzi<BR>&nbsp;</PRE>
------=_Part_314624_7892787.1287339120062--


