Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C86D10.91F40970"
Date: Mon, 11 Feb 2008 17:45:31 -0700
Message-ID: <51CAD0CE1504444DBE77CBBE51A0135D376B33@domain.hid>
From: "Steven Seeger" <sseeger@domain.hid>
Subject: [Xenomai-help] pit
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

------_=_NextPart_001_01C86D10.91F40970
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I compiled the kernel for 586 and am running the PIT timer. I still get
the 17000-18000 context switches per second, and now the irq0 handler is
taking up 11% of the CPU instead of only 5% when the two 8000Hz tasks
are loaded but delayed on events. I think that the problem isn't with
pit, but with the tasks being periodic even though they are blocked.=20

=20

Running in PIT mode with periodic timing on uses only 9.5% of the CPU. I
show about 9000 context switches per second. (the 2 8000 hz tasks and
the 1000 hz linux interrupt.)

=20

With periodic timing, it's 5.4% when the tasks idle and about 9000
context switches a second. When one of them becomes active, the irq0
handler is using 10% of the CPU and the sound task is using about 8%.
These are two kernel tasks.

=20

Userspace stack size is set to 64k. I forgot to mention this to Philippe
earlier.

=20

Perhaps the problem is the overhead that the timer handler introduces
being able to support multiple skins with individual timebases. It
sounds like in order to save some cpu cycles, I may want to turn off
periodicity while threads are idle and also avoid setting threads
periodic when they can be driven some other way.=20

=20

Steven

=20


------_=_NextPart_001_01C86D10.91F40970
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
font-family:Arial'>I compiled the kernel for 586 and am running the PIT =
timer. I
still get the 17000-18000 context switches per second, and now the irq0 =
handler
is taking up 11% of the CPU instead of only 5% when the two 8000Hz tasks =
are
loaded but delayed on events. I think that the problem isn&#8217;t with =
pit,
but with the tasks being periodic even though they are blocked. =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Running in PIT mode with periodic timing on uses only =
9.5%
of the CPU. I show about 9000 context switches per second. (the 2 8000 =
hz tasks
and the 1000 hz linux interrupt.)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>With periodic timing, it&#8217;s 5.4% when the tasks =
idle
and about 9000 context switches a second. When one of them becomes =
active, the
irq0 handler is using 10% of the CPU and the sound task is using about =
8%. These
are two kernel tasks.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Userspace stack size is set to 64k. I forgot to =
mention this
to Philippe earlier.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Perhaps the problem is the overhead that the timer =
handler
introduces being able to support multiple skins with individual =
timebases. It
sounds like in order to save some cpu cycles, I may want to turn off
periodicity while threads are idle and also avoid setting threads =
periodic when
they can be driven some other way. <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Steven<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C86D10.91F40970--

