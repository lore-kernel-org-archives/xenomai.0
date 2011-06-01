Message-ID: <528683.58306.qm@domain.hid>
Date: Tue, 31 May 2011 22:35:08 -0700 (PDT)
From: sanjay anvekar <sanjayanvekar@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-2079389687-1306906508=:58306"
Subject: [Xenomai-help] help-IntelAtom
Reply-To: sanjay anvekar <sanjayanvekar@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

--0-2079389687-1306906508=:58306
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,=0A=A0=A0=A0=A0 I am facing problem running Xenomai test programs and it=
 gives me following error.=0A>clocktest=0A>/usr/xenomai/bin/clocktest: erro=
r while loading shared libraries: /usr/xenomai/lib/libpthread_rt.so.1: ELF =
file OS ABI invalid=0A=0Asimilar error is seen when I try to run latency or=
 any other Xenomai test program.=0A=0A=0AI am using Xenomai 2.5.6 patched t=
o Kernel 2.6.37. When I do uname and dmesg following are the output=0A=0A>u=
name -a=0A=0ALinux (none) 2.6.37-ipipe #2 SMP PREEMPT Mon May 30 15:28:24 I=
ST 2011 i686 unknown=0A=0A>dmesg | grep I-pipe=0A=0A[=A0=A0=A0 0.000] I-pip=
e 2.9-0: pipeline enabled.=0A[=A0=A0=A0 2.330] I-pipe: Domain Xenomai regis=
tered.=0A=0A>dmesg | grep Xenomai=0A[=A0=A0=A0 2.330] I-pipe: Domain Xenoma=
i registered.=0A[=A0=A0=A0 2.336] Xenomai: hal/i36 started.=0A[=A0=A0=A0 2.=
339] Xenomai: scheduling class idle registered.=0A[=A0=A0=A0 2.330] Xenomai=
: scheduling class rt registered.=0A[=A0=A0=A0 2.302] Xenomai: real-time nu=
cleus v2.5.6 (Wormhole Wizards) loaded.=0A[=A0=A0=A0 2.307] Xenomai: SMI-en=
abled chipset found=0A[=A0=A0=A0 2.309] Xenomai: SMI workaround enabled=0A[=
=A0=A0=A0 2.305] Xenomai: starting native API services.=0A[=A0=A0=A0 2.306]=
 Xenomai: starting POSIX services.=0A[=A0=A0=A0 2.302] Xenomai: starting RT=
DM services.=0A=0AWhat I tried-=0A- Tried setting LD_LIBRARY_PATH=3D/usr/xe=
nomai/lib/=0A- Tried rebuilding xenomai with=0A=A0=A0=A0=A0 --enable-x86-se=
p --enable-smp --host=3Di686-linux CFLAGS=3D"-m32 -O2" LDFLAGS=3D"-m32" opt=
ion=0A=A0=A0=A0 and also only --enable-x86-sep --enable-smp options=0A=0A- =
Tried building and running 'rtprint' example program and had same error.=0A=
- Tried to statically link the 'rtprint' example program and got following =
error=0A=0Agcc -static -I/media/New1/Linux/xenomai/install/usr/xenomai/incl=
ude -D_GNU_SOURCE -Wall -pipe -D__XENO__ -L/media/New1/Linux/xenomai/instal=
l/usr/xenomai/lib -Xlinker -rpath -Xlinker /media/New1/Linux/xenomai/instal=
l/usr/xenomai/lib -o rtprint rtprint.o -lnative -lxenomai -lpthread_rt -lrt=
dk=0A/usr/bin/ld: cannot find -lc=0Acollect2: ld returned 1 exit status=0Am=
ake: *** [rtprint] Error 1=0A=0APlease help me to solve this problem.=0A=0A=
Thanks & Best regards,=0ASanjay=0A
--0-2079389687-1306906508=:58306
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"color:#000; background-color:#fff; font-family:ti=
mes new roman, new york, times, serif;font-size:12pt"><div>Hi,</div><div><s=
pan>&nbsp;&nbsp;&nbsp;&nbsp; I am facing problem running Xenomai test progr=
ams and it gives me following error.</span></div><div><span>&gt;clocktest<b=
r>&gt;/usr/xenomai/bin/clocktest: error while loading shared libraries: /us=
r/xenomai/lib/libpthread_rt.so.1: ELF file OS ABI invalid</span></div><div>=
<br><span></span></div><div><span>similar error is seen when I try to run l=
atency or any other Xenomai test program.<br></span></div><div><br><span></=
span></div><div><span>I am using Xenomai 2.5.6 patched to Kernel 2.6.37. Wh=
en I do uname and dmesg following are the output</span></div><div><span><br=
></span></div><div>&gt;uname -a<br></div><div>Linux (none) 2.6.37-ipipe #2 =
SMP PREEMPT Mon May 30 15:28:24 IST 2011 i686 unknown</div><div><br><span><=
/span></div><div><span>&gt;dmesg | grep
 I-pipe<br></span></div><div><span>[&nbsp;&nbsp;&nbsp; 0.000] I-pipe 2.9-0:=
 pipeline enabled.<br>[&nbsp;&nbsp;&nbsp; 2.330] I-pipe: Domain Xenomai reg=
istered.</span></div><div><br><span></span></div><div><span>&gt;dmesg | gre=
p Xenomai</span></div><div><span>[&nbsp;&nbsp;&nbsp; 2.330] I-pipe: Domain =
Xenomai registered.<br>[&nbsp;&nbsp;&nbsp; 2.336] Xenomai: hal/i36 started.=
<br>[&nbsp;&nbsp;&nbsp; 2.339] Xenomai: scheduling class idle registered.<b=
r>[&nbsp;&nbsp;&nbsp; 2.330] Xenomai: scheduling class rt registered.<br>[&=
nbsp;&nbsp;&nbsp; 2.302] Xenomai: real-time nucleus v2.5.6 (Wormhole Wizard=
s) loaded.<br>[&nbsp;&nbsp;&nbsp; 2.307] Xenomai: SMI-enabled chipset found=
<br>[&nbsp;&nbsp;&nbsp; 2.309] Xenomai: SMI workaround enabled<br>[&nbsp;&n=
bsp;&nbsp; 2.305] Xenomai: starting native API services.<br>[&nbsp;&nbsp;&n=
bsp; 2.306] Xenomai: starting POSIX services.<br>[&nbsp;&nbsp;&nbsp; 2.302]=
 Xenomai: starting RTDM
 services.</span></div><div><br><span></span></div><div><span>What I tried-=
</span></div><div><span>- Tried setting LD_LIBRARY_PATH=3D/usr/xenomai/lib/=
</span></div><div><span>- Tried rebuilding xenomai with</span></div><div><s=
pan>&nbsp;&nbsp;&nbsp;&nbsp; --enable-x86-sep --enable-smp --host=3Di686-li=
nux CFLAGS=3D"-m32 -O2" LDFLAGS=3D"-m32" option</span></div><div><span>&nbs=
p;&nbsp;&nbsp; and also only --enable-x86-sep --enable-smp options<br></spa=
n></div><div><span>- Tried building and running 'rtprint' example program a=
nd had same error.</span></div><div><span>- Tried to statically link the 'r=
tprint' example program and got following error</span></div><div><span><br>=
gcc -static -I/media/New1/Linux/xenomai/install/usr/xenomai/include -D_GNU_=
SOURCE -Wall -pipe -D__XENO__ -L/media/New1/Linux/xenomai/install/usr/xenom=
ai/lib -Xlinker -rpath -Xlinker /media/New1/Linux/xenomai/install/usr/xenom=
ai/lib -o rtprint rtprint.o -lnative -lxenomai -lpthread_rt
 -lrtdk<br>/usr/bin/ld: cannot find -lc<br>collect2: ld returned 1 exit sta=
tus<br>make: *** [rtprint] Error 1</span></div><div><br><span></span></div>=
<div>Please help me to solve this problem.</div><div><br></div><div>Thanks =
&amp; Best regards,</div><div>Sanjay<br><span></span></div></div></body></h=
tml>
--0-2079389687-1306906508=:58306--

