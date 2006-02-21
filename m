Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C636D5.8B72504B"
Date: Tue, 21 Feb 2006 11:57:02 +0100
Message-ID: <FDBBB5CC70676540B3EF7CFE83FD94E0210D24@domain.hid>
From: "ROSSIER Daniel" <Daniel.Rossier@domain.hid>
Subject: [Xenomai-core] Timer and calibration
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C636D5.8B72504B
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,

=20

We are currently porting Adeos/Xenomai with Linux 2.6.14 on a ARM9-based
Freescale i.mx21 (litekit) development board.

We started from the available patch for the ARM-based Integrator board.

=20

We are now facing some interesting problems regarding clock/timer
frequencies with this board, but they are about to be solved :-)

=20

However, we have a question of understanding; as far as we know, ipipe
starts with an aperiodic (one-shot) timer at the initialization time,
and that before

the calibrate function has been called. So, we get one interrupt only
since the xenomai scheduler has not been registered (we understand

that the xenomai scheduler should give the next timer shot, but since it
is not registered yet, no timer reprogramming is achieved).

=20

So, how can the calibrate function can be invoked safely if no timer IRQ
is received since this kind of calibration comes before the xenomai
registration

(the calibrate function needs IRQ timers to calibrate the number of busy
loops between two jiffies) ?

=20

How is it realized with a x86 architecture (another timer source?)

=20

Is there any documentation - or discussion threads - which gives some
information about the use of timers/RTC/TSC with Xenomai?=20

=20

Thanks so much for your help

=20

Kind regards

=20

Daniel Rossier


------_=_NextPart_001_01C636D5.8B72504B
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:st1=3D"urn:schemas-microsoft-com:office:smarttags" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"PersonName"/>
<!--[if !mso]>
<style>
st1\:*{behavior:url(#default#ieooui) }
</style>
<![endif]-->
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
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
p
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	font-size:12.0pt;
	font-family:"Times New Roman";}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:Arial;
	color:windowtext;}
@page Section1
	{size:595.3pt 841.9pt;
	margin:70.85pt 70.85pt 70.85pt 70.85pt;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DFR link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Hello,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>We are currently porting Adeos/Xenomai with =
Linux
2.6.14 on a ARM9-based Freescale i.mx21 (litekit) development =
board.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>We started from the available patch for the =
ARM-based
Integrator board.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>We are now facing some interesting problems =
regarding
clock/timer frequencies with this board, but they are about to be solved =
</span></font><font
size=3D2 face=3DWingdings><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:
Wingdings'>J</span></font><font size=3D2 face=3DArial><span lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:Arial'><o:p></o:p></span></font></p=
>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>However, we have a question of understanding; =
as far
as we know, ipipe starts with an aperiodic (one-shot) timer at the
initialization time, and that before<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>the calibrate function has been called. So, we =
get
one interrupt only since the xenomai scheduler has not been registered =
(we
understand<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>that the xenomai scheduler should give the =
next timer
shot, but since it is not registered yet, no timer reprogramming is =
achieved).<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>So, how can the calibrate function can be =
invoked
safely if no timer IRQ is received since this kind of calibration comes =
before
the xenomai registration<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>(the calibrate function needs IRQ timers to =
calibrate
the number of busy loops between two jiffies) =
?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>How is it realized with a x86 architecture =
(another
timer source?)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>Is there any documentation &#8211; or =
discussion
threads - which gives some information about the use of timers/RTC/TSC =
with
Xenomai? <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>Thanks so much for your =
help<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>Kind regards<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><st1:PersonName ProductID=3D"Daniel Rossier" =
w:st=3D"on"><font
 size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:Arial'>Daniel
 Rossier</span></font></st1:PersonName><font size=3D2 face=3DArial><span
lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:Arial'><o:p></o:p></span></font></p=
>

</div>

</body>

</html>

------_=_NextPart_001_01C636D5.8B72504B--

