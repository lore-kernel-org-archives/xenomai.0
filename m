Message-Id: <200710011212.l91CCO7w006791@domain.hid>
From: "Patrick" <kpa_info@domain.hid>
Date: Mon, 1 Oct 2007 14:12:26 +0200
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_001A_01C80435.186D4050"
In-Reply-To: <2ff1a98a0710010238v47eb1778tfc6779285116c64b@domain.hid>
Subject: [Xenomai-core] ARM compiling error
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: 'xenomai-core' <xenomai@xenomai.org>

This is a multi-part message in MIME format.

------=_NextPart_000_001A_01C80435.186D4050
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hy,

 

I install Xenomai 2.3.4 for ARM on 2.6.20 kernel. The prepare-kernel script
work well.

When I compiling my kernel I have the error message above:

 

  CC      kernel/xenomai/arch/generic/hal.o

  LD      kernel/xenomai/arch/generic/xeno_hal.o

  LD      kernel/xenomai/arch/generic/built-in.o

  LD      kernel/xenomai/arch/built-in.o

  CC      kernel/xenomai/nucleus/heap.o

  CC      kernel/xenomai/nucleus/intr.o

kernel/xenomai/nucleus/intr.c:60: warning: 'xnirqs' defined but not used

  CC      kernel/xenomai/nucleus/module.o

  CC      kernel/xenomai/nucleus/pod.o

  CC      kernel/xenomai/nucleus/synch.o

  CC      kernel/xenomai/nucleus/thread.o

  CC      kernel/xenomai/nucleus/timer.o

  CC      kernel/xenomai/nucleus/shadow.o

In file included from kernel/xenomai/nucleus/shadow.c:56:

include/asm/xenomai/bits/shadow.h: In function 'xnarch_local_syscall':

include/asm/xenomai/bits/shadow.h:180: error: 'struct <anonymous>' has no
member named 'counter'

include/asm/xenomai/bits/shadow.h:181: error: 'struct <anonymous>' has no
member named 'mask'

include/asm/xenomai/bits/shadow.h:182: error: 'struct <anonymous>' has no
member named 'last_cnt'

include/asm/xenomai/bits/shadow.h:183: error: 'struct <anonymous>' has no
member named 'tsc'

make[3]: *** [kernel/xenomai/nucleus/shadow.o] Erreur 1

make[2]: *** [kernel/xenomai/nucleus] Erreur 2

make[1]: *** [kernel/xenomai] Erreur 2

make: *** [kernel] Erreur 2

 

 

Do you have a solution for fix this problem?

 

Thanks in advance

 

Patrick


------=_NextPart_000_001A_01C80435.186D4050
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Verdana;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";}
@page Section1
	{size:595.3pt 841.9pt;
	margin:70.85pt 69.6pt 70.85pt 69.6pt;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DFR link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoPlainText><font size=3D2 face=3DVerdana><span lang=3DFR-CH
style=3D'font-size:10.0pt;font-family:Verdana'>Hy,<o:p></o:p></span></fon=
t></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblack =
face=3DVerdana><span lang=3DFR-CH
style=3D'font-size:10.0pt;font-family:Verdana;color:black'><o:p>&nbsp;</o=
:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblack =
face=3DVerdana><span lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:Verdana;color:black'>I install =
Xenomai
2.3.4 for ARM on 2.6.20 kernel. The prepare-kernel script work =
well.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblack =
face=3DVerdana><span lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:Verdana;color:black'>When I =
compiling my
kernel I have the error message above:<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
lang=3DEN-GB =
style=3D'font-size:10.0pt;color:black'><o:p>&nbsp;</o:p></span></font></p=
>

<p class=3DMsoPlainText><font size=3D1 color=3Dblack face=3D"Courier =
New"><span
lang=3DDE-CH style=3D'font-size:8.0pt;color:black'>&nbsp; =
CC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
kernel/xenomai/arch/generic/hal.o<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 color=3Dblack face=3D"Courier =
New"><span
lang=3DDE-CH style=3D'font-size:8.0pt;color:black'>&nbsp; =
LD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
kernel/xenomai/arch/generic/xeno_hal.o<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 color=3Dblack face=3D"Courier =
New"><span
lang=3DDE-CH style=3D'font-size:8.0pt;color:black'>&nbsp; =
LD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
kernel/xenomai/arch/generic/built-in.o<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 color=3Dblack face=3D"Courier =
New"><span
lang=3DDE-CH style=3D'font-size:8.0pt;color:black'>&nbsp; =
LD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
kernel/xenomai/arch/built-in.o<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 color=3Dblack face=3D"Courier =
New"><span
lang=3DDE-CH style=3D'font-size:8.0pt;color:black'>&nbsp; =
</span></font><font
size=3D1 color=3Dblack><span lang=3DEN-GB =
style=3D'font-size:8.0pt;color:black'>CC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
kernel/xenomai/nucleus/heap.o<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 color=3Dblack face=3D"Courier =
New"><span
lang=3DEN-GB style=3D'font-size:8.0pt;color:black'>&nbsp;
CC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
kernel/xenomai/nucleus/intr.o<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 color=3Dblack face=3D"Courier =
New"><span
lang=3DEN-GB =
style=3D'font-size:8.0pt;color:black'>kernel/xenomai/nucleus/intr.c:60:
warning: &#8216;xnirqs&#8217; defined but not =
used<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 color=3Dblack face=3D"Courier =
New"><span
lang=3DEN-GB style=3D'font-size:8.0pt;color:black'>&nbsp;
CC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
kernel/xenomai/nucleus/module.o<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 color=3Dblack face=3D"Courier =
New"><span
lang=3DEN-GB style=3D'font-size:8.0pt;color:black'>&nbsp;
CC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
kernel/xenomai/nucleus/pod.o<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 color=3Dblack face=3D"Courier =
New"><span
lang=3DEN-GB style=3D'font-size:8.0pt;color:black'>&nbsp;
CC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
kernel/xenomai/nucleus/synch.o<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 color=3Dblack face=3D"Courier =
New"><span
lang=3DEN-GB style=3D'font-size:8.0pt;color:black'>&nbsp;
CC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
kernel/xenomai/nucleus/thread.o<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 color=3Dblack face=3D"Courier =
New"><span
lang=3DEN-GB style=3D'font-size:8.0pt;color:black'>&nbsp;
CC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
kernel/xenomai/nucleus/timer.o<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 color=3Dblack face=3D"Courier =
New"><span
lang=3DEN-GB style=3D'font-size:8.0pt;color:black'>&nbsp;
CC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
kernel/xenomai/nucleus/shadow.o<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 color=3Dblack face=3D"Courier =
New"><span
lang=3DEN-GB style=3D'font-size:8.0pt;color:black'>In file included from
kernel/xenomai/nucleus/shadow.c:56:<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 color=3Dblack face=3D"Courier =
New"><span
lang=3DEN-GB =
style=3D'font-size:8.0pt;color:black'>include/asm/xenomai/bits/shadow.h:
In function =
&#8216;xnarch_local_syscall&#8217;:<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 color=3Dblack face=3D"Courier =
New"><span
lang=3DEN-GB =
style=3D'font-size:8.0pt;color:black'>include/asm/xenomai/bits/shadow.h:1=
80:
error: &#8216;struct &lt;anonymous&gt;&#8217; has no member named
&#8216;counter&#8217;<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 color=3Dblack face=3D"Courier =
New"><span
lang=3DEN-GB =
style=3D'font-size:8.0pt;color:black'>include/asm/xenomai/bits/shadow.h:1=
81:
error: &#8216;struct &lt;anonymous&gt;&#8217; has no member named
&#8216;mask&#8217;<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 color=3Dblack face=3D"Courier =
New"><span
lang=3DEN-GB =
style=3D'font-size:8.0pt;color:black'>include/asm/xenomai/bits/shadow.h:1=
82:
error: &#8216;struct &lt;anonymous&gt;&#8217; has no member named
&#8216;last_cnt&#8217;<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 color=3Dblack face=3D"Courier =
New"><span
lang=3DEN-GB =
style=3D'font-size:8.0pt;color:black'>include/asm/xenomai/bits/shadow.h:1=
83:
error: &#8216;struct &lt;anonymous&gt;&#8217; has no member named
&#8216;tsc&#8217;<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 color=3Dblack face=3D"Courier =
New"><span
lang=3DEN-GB style=3D'font-size:8.0pt;color:black'>make[3]: ***
[kernel/xenomai/nucleus/shadow.o] Erreur 1<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 color=3Dblack face=3D"Courier =
New"><span
lang=3DEN-GB style=3D'font-size:8.0pt;color:black'>make[2]: ***
[kernel/xenomai/nucleus] Erreur 2<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 color=3Dblack face=3D"Courier =
New"><span
lang=3DEN-GB style=3D'font-size:8.0pt;color:black'>make[1]: *** =
[kernel/xenomai]
Erreur 2<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 color=3Dblack face=3D"Courier =
New"><span
lang=3DEN-GB style=3D'font-size:8.0pt;color:black'>make: *** [kernel] =
Erreur 2<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 color=3Dblack face=3D"Courier =
New"><span
lang=3DEN-GB =
style=3D'font-size:8.0pt;color:black'><o:p>&nbsp;</o:p></span></font></p>=


<p class=3DMsoPlainText><font size=3D1 color=3Dblack face=3D"Courier =
New"><span
lang=3DEN-GB =
style=3D'font-size:8.0pt;color:black'><o:p>&nbsp;</o:p></span></font></p>=


<p class=3DMsoPlainText><font size=3D2 color=3Dblack =
face=3DVerdana><span lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:Verdana;color:black'>Do you have a =
solution
for fix this problem?<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblack =
face=3DVerdana><span lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:Verdana;color:black'><o:p>&nbsp;</o=
:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblack =
face=3DVerdana><span lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:Verdana;color:black'>Thanks in =
advance<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblack =
face=3DVerdana><span lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:Verdana;color:black'><o:p>&nbsp;</o=
:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblack =
face=3DVerdana><span lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:Verdana;color:black'>Patrick<o:p></=
o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_001A_01C80435.186D4050--


