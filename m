Message-ID: <1DE138B7F8CE402AB05AC211D832BE49@domain.hid>
From: Alessandro Avanzi <a.avanzi@domain.hid>
Date: Fri, 12 Mar 2010 14:57:16 +0100
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0040_01CAC1F4.4E754650"
Subject: [Xenomai-help] Testsuite syntax error on Virtex5 PPC440
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

------=_NextPart_000_0040_01CAC1F4.4E754650
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello. I installed Xenomai kernel support on the 2.6.32.3 kernel =
provided by
Xilinx using a mod. DENX patch. Then I installed the user support on a =
ramdisk,
and packed the kernel, the ramdisk and the device tree all togheter in =
an .elf file
to be dowloaded on the board (based on Xilinx Virtex5 FXT with PPC440).
At booting I got the following =20

#
rootfs image is not initramfs (no cpio magic); looks like an initrd
Freeing initrd memory: 2902k freed
I-pipe: Domain Xenomai registered.
Xenomai: hal/powerpc started.
Xenomai: scheduling class idle registered.
Xenomai: scheduling class rt registered.
Xenomai: scheduling class tp registered.
Xenomai: real-time nucleus v2.5.1 (Speed Of Light) loaded.
Xenomai: starting native API services.
Xenomai: starting POSIX services.
Xenomai: starting RTDM services.
Xenomai: starting pSOS+ services.
Xenomai: starting VRTX services.
Xenomai: starting VxWorks services.
Xenomai: starting uITRON services.
Xenomai: starting RTAI emulator.
ROMFS MTD (C) 2007 Red Hat, Inc.
msgmni has been set to 120
#

but then, when I try to run some tests, such as xeno-test or something
from the testsuite, everything I got is #Syntax error# and nothing else.
Executing xeno-info, I got the following

#
root:/usr/xenomai/bin> ./xeno-info
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

BusyBox v1.3.0 (2007-01-22 01:17:40 MET) multi-call binary
Linux (none) 2.6.32 #1 PREEMPT Fri Mar 12 14:15:38 CET 2010 ppc unknown

module-init-tools      found
e2fsprogs              not
sed: unmatched '/'
Modules Loaded
root:/usr/xenomai/bin>
#

Any suggestion? Thanks,

Alessandro



------=_NextPart_000_0040_01CAC1F4.4E754650
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META content=3D"text/html; charset=3Diso-8859-1" =
http-equiv=3DContent-Type>
<META name=3DGENERATOR content=3D"MSHTML 8.00.6001.18882">
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV>Hello. I installed Xenomai kernel support&nbsp;on the 2.6.32.3 =
kernel=20
provided by</DIV>
<DIV>Xilinx using a mod. DENX patch. Then I installed the user =
support&nbsp;on a=20
ramdisk,</DIV>
<DIV>and packed the kernel, the&nbsp;ramdisk and the&nbsp;device tree =
all=20
togheter in an .elf file</DIV>
<DIV>to be dowloaded on the board (based on Xilinx Virtex5 FXT with=20
PPC440).</DIV>
<DIV>At booting I got the following &nbsp;</DIV>
<DIV>&nbsp;</DIV>
<DIV>#</DIV>
<DIV>rootfs image is not initramfs (no cpio magic); looks like an=20
initrd<BR>Freeing initrd memory: 2902k freed<BR>I-pipe: Domain Xenomai=20
registered.<BR>Xenomai: hal/powerpc started.<BR>Xenomai: scheduling =
class idle=20
registered.<BR>Xenomai: scheduling class rt registered.<BR>Xenomai: =
scheduling=20
class tp registered.<BR>Xenomai: real-time nucleus v2.5.1 (Speed Of =
Light)=20
loaded.<BR>Xenomai: starting native API services.<BR>Xenomai: starting =
POSIX=20
services.<BR>Xenomai: starting RTDM services.<BR>Xenomai: starting pSOS+ =

services.<BR>Xenomai: starting VRTX services.<BR>Xenomai: starting =
VxWorks=20
services.<BR>Xenomai: starting uITRON services.<BR>Xenomai: starting =
RTAI=20
emulator.<BR>ROMFS MTD (C) 2007 Red Hat, Inc.<BR>msgmni has been set to=20
120</DIV>
<DIV>#</DIV>
<DIV>&nbsp;</DIV>
<DIV>but then, when I try to run some tests, such as xeno-test or=20
something</DIV>
<DIV>from the testsuite, everything I got is #Syntax error# and nothing=20
else.</DIV>
<DIV>Executing xeno-info, I got the following</DIV>
<DIV>&nbsp;</DIV>
<DIV>#</DIV>
<DIV>root:/usr/xenomai/bin&gt; ./xeno-info<BR>If some fields are empty =
or look=20
unusual you may have an old version.<BR>Compare to the current minimal=20
requirements in Documentation/Changes.</DIV>
<DIV>&nbsp;</DIV>
<DIV>BusyBox v1.3.0 (2007-01-22 01:17:40 MET) multi-call binary<BR>Linux =
(none)=20
2.6.32 #1 PREEMPT Fri Mar 12 14:15:38 CET 2010 ppc unknown</DIV>
<DIV>&nbsp;</DIV>
<DIV>module-init-tools&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
found<BR>e2fsprogs&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;=20
not<BR>sed: unmatched '/'<BR>Modules =
Loaded<BR>root:/usr/xenomai/bin&gt;</DIV>
<DIV>#</DIV>
<DIV>&nbsp;</DIV>
<DIV>Any suggestion? Thanks,</DIV>
<DIV>&nbsp;</DIV>
<DIV>Alessandro</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;</DIV></BODY></HTML>

------=_NextPart_000_0040_01CAC1F4.4E754650--

