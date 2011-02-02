From: "Franz Engel" <franz_lambert_engel@domain.hid>
Date: Wed, 2 Feb 2011 21:05:49 +0100
Message-ID: <000701cbc314$969f5de0$c3de19a0$@de>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0008_01CBC31C.F863C5E0"
Content-Language: de
Subject: [Xenomai-help] [    1.954665] Xenomai: native skin init failed,
	code -19
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

This is a multi-part message in MIME format.

------=_NextPart_000_0008_01CBC31C.F863C5E0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

I have a little problem. I'm a Xenomai newbie (that is not the problem). My
problem begun with the installation. I installed Xenomai on my PC at work
(Intel, 64 Bit Ubuntu). Now I try to install Xenomai also on my home PC (AMD
Phenom II X6, 64 Bit Ubuntu). On my PC at work there is no problem. But at
home I have no chance.
I already read about this problem. When I start the latency test I get this
message:
Xenomai: native skin or CONFIG_XENO_OPT_PERVASIVE disabled.
(modprobe xeno_native?)

Furthermore my log contains the following message:
[    1.457598] I-pipe: Domain Xenomai registered.
[    1.458017] Xenomai: hal/x86_64 started.
[    1.458154] Xenomai: scheduling class idle registered.
[    1.458210] Xenomai: scheduling class rt registered.
[    1.462730] Xenomai: real-time nucleus v2.5.5.2 (Ghosts) loaded.
[    1.954665] Xenomai: native skin init failed, code -19.
[    1.954752] Xenomai: starting POSIX services.
[    2.454765] Xenomai: POSIX skin init failed, code -19.
[    2.954863] Xenomai: RTDM skin init failed, code -19.

I read that the APIC could be a problem. So I insert "lapic" to my GRUB 2
boot file (I know, it is not good to change this file):
linux    /boot/vmlinuz-2.6.32.7-xenomai
root=UUID=03b334bf-d381-4065-bdc1-64c267d32c4c ro lapic

But nothing happens.

I tried to change the following lines in my kernel ".config":
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y

But even when I change this lines they set back when I make "make
menuconfig".

When I used the Xenomai-Skript:
./prepare-kernel.sh --linux=/usr/src/linux

I choose the default parameter "X86_64" (I use a 64 Bit Ubuntu) and I tried
different processor configurations on my kernel (Opteron/Athlon64/Hammer/K8
and Generic-x86-64). Does somewhere know what I made wrong? Do I have to
change the prepare-kernel.sh parameter from x86_64 to something else?

Best regards,
   Franz




------=_NextPart_000_0008_01CBC31C.F863C5E0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40"><head><META =
HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii"><meta name=3DGenerator content=3D"Microsoft Word 12 =
(filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.E-MailFormatvorlage17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:70.85pt 70.85pt 2.0cm 70.85pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DDE link=3Dblue =
vlink=3Dpurple><div class=3DWordSection1><p class=3DMsoNormal><span =
lang=3DEN-US>Hello,<br><br>I have a little problem. I'm a Xenomai newbie =
(that is not the problem). My problem begun with the installation. I =
installed Xenomai on my PC at work (Intel, 64 Bit Ubuntu). Now I try to =
install Xenomai also on my home PC (AMD Phenom II X6, 64 Bit Ubuntu). On =
my PC at work there is no problem. But at home I have no chance.<br>I =
already read about this problem. When I start the latency test I get =
this message:<br>Xenomai: native skin or CONFIG_XENO_OPT_PERVASIVE =
disabled.<br>(modprobe xeno_native?)<br><br>Furthermore my log contains =
the following message:<br>[&nbsp;&nbsp;&nbsp; 1.457598] I-pipe: Domain =
Xenomai registered.<br>[&nbsp;&nbsp;&nbsp; 1.458017] Xenomai: hal/x86_64 =
started.<br>[&nbsp;&nbsp;&nbsp; 1.458154] Xenomai: scheduling class idle =
registered.<br>[&nbsp;&nbsp;&nbsp; 1.458210] Xenomai: scheduling class =
rt registered.<br>[&nbsp;&nbsp;&nbsp; 1.462730] Xenomai: real-time =
nucleus v2.5.5.2 (Ghosts) loaded.<br>[&nbsp;&nbsp;&nbsp; 1.954665] =
Xenomai: native skin init failed, code -19.<br>[&nbsp;&nbsp;&nbsp; =
1.954752] Xenomai: starting POSIX services.<br>[&nbsp;&nbsp;&nbsp; =
2.454765] Xenomai: POSIX skin init failed, code =
-19.<br>[&nbsp;&nbsp;&nbsp; 2.954863] Xenomai: RTDM skin init failed, =
code -19.<br><br>I read that the APIC could be a problem. So I insert =
&quot;lapic&quot; to my GRUB 2 boot file (I know, it is not good to =
change this file):<br>linux&nbsp;&nbsp;&nbsp; =
/boot/vmlinuz-2.6.32.7-xenomai =
root=3DUUID=3D03b334bf-d381-4065-bdc1-64c267d32c4c ro lapic<br><br>But =
nothing happens.<br><br>I tried to change the following lines in my =
kernel =
&quot;.config&quot;:<br>CONFIG_X86_LOCAL_APIC=3Dy<br>CONFIG_X86_IO_APIC=3D=
y<br><br>But even when I change this lines they set back when I make =
&quot;make menuconfig&quot;.<br><br>When I used the =
Xenomai-Skript:<br>./prepare-kernel.sh --linux=3D/usr/src/linux<br><br>I =
choose the default parameter &quot;X86_64&quot; (I use a 64 Bit Ubuntu) =
and I tried different processor configurations on my kernel =
(Opteron/Athlon64/Hammer/K8 and Generic-x86-64). Does somewhere know =
what I made wrong? Do I have to change the prepare-kernel.sh parameter =
from x86_64 to something else?<br><br></span>Best =
regards,<br>&nbsp;&nbsp; Franz<br><br><o:p></o:p></p></div></body></html>
------=_NextPart_000_0008_01CBC31C.F863C5E0--


