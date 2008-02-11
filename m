Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C86CE7.F39411EE"
Date: Mon, 11 Feb 2008 12:54:45 -0700
Message-ID: <51CAD0CE1504444DBE77CBBE51A0135D376AFD@slcmail.slc.mew.int>
From: "Steven Seeger" <sseeger@domain.hid>
Subject: [Xenomai-help] irq0
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

------_=_NextPart_001_01C86CE7.F39411EE
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I used the idle=3Dpoll option so I'm running the tsc now, and irq0 =
handler
still has a lot of overhead.=20

=20

CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME

  0  0      0          2          0     00500080   94.2  ROOT

  0  0      0          1          0     00100082    0.0  sound task

  0  0      0          1          0     00100082    0.0  tone task

0  0      0          775585     0     00000000    5.6  IRQ0: [timer]

=20

I'm seeing about 17,000 context switches a second for IRQ0. Sound task
and tone task are doing nothing. They're just blocked.

=20

Steven

=20


------_=_NextPart_001_01C86CE7.F39411EE
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:"MS Mincho";
	panose-1:2 2 6 9 4 2 5 8 3 4;}
@font-face
	{font-family:"\@MS Mincho";
	panose-1:2 2 6 9 4 2 5 8 3 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:Arial;
	color:windowtext;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I used the idle=3Dpoll option so I&#8217;m running =
the tsc
now, and irq0 handler still has a lot of overhead. =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>CPU&nbsp; PID&nbsp;&nbsp;&nbsp; =
MSW&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
CSW&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PF&nbsp;&nbsp;&nbsp; =
STAT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; %CPU&nbsp;
NAME<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp; 0&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0&nbsp;&nbsp;&nbsp;&nbsp; 00500080&nbsp;&nbsp; 94.2&nbsp;
ROOT<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp; 0&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0&nbsp;&nbsp;&nbsp;&nbsp; 00100082&nbsp;&nbsp;&nbsp; 0.0&nbsp;
sound task<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp; 0&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0&nbsp;&nbsp;&nbsp;&nbsp; 00100082&nbsp;&nbsp;&nbsp; 0.0&nbsp;
tone task<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-indent:6.0pt'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>0&nbsp; =
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
775585&nbsp;&nbsp;&nbsp;&nbsp;
0&nbsp;&nbsp;&nbsp;&nbsp; 00000000&nbsp;&nbsp;&nbsp; 5.6&nbsp; IRQ0: =
[timer]<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-indent:6.0pt'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></fo=
nt></p>

<p class=3DMsoNormal style=3D'text-indent:6.0pt'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>I&#8217;m seeing about =
17,000
context switches a second for IRQ0. Sound task and tone task are doing =
nothing.
They&#8217;re just blocked.<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-indent:6.0pt'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></fo=
nt></p>

<p class=3DMsoNormal style=3D'text-indent:6.0pt'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>Steven<o:p></o:p></span></fo=
nt></p>

<p class=3DMsoNormal style=3D'text-indent:6.0pt'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></fo=
nt></p>

</div>

</body>

</html>

------_=_NextPart_001_01C86CE7.F39411EE--

