Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8669D.BD9F0C92"
Date: Sun, 3 Feb 2008 12:48:25 -0700
Message-ID: <51CAD0CE1504444DBE77CBBE51A0135D3768B2@domain.hid>
From: "Steven Seeger" <sseeger@domain.hid>
Subject: [Xenomai-help] periodic issues/watchdog
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

------_=_NextPart_001_01C8669D.BD9F0C92
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

So with rt_timer_set_periodic(125000) on and my sound task running, I
still trip the watchdog. /proc/xenomai/stat is showing 9.5% usage by the
sound task and a whopping 16.5% by IRQ0. (This amount seems considerably
lower when watchdog support is not compiled in.) The weird thing is that
the watchdog keeps killing the thread even though it isn't at all
locking up the system.  (ROOT using 82%.)

=20

I changed my code to use this:

=20

if(rt_task_wait_period(0)) rt_task_wait_period(0);

=20

This was intended to catch the -ETIMEDOUT return value in case it did
time out. I figure this maybe was causing the hard lockup I was seeing
before.

=20

Gilles's patch did work for me regarding the rt_timer_set_mode()
problem.

=20

It seems that for now, I'll have to disable the watchdog as I see this
behavior with periodic mode or aperiodic mode. (My watchdog timeout is
set for 1 second.)

=20

Steven

=20


------_=_NextPart_001_01C8669D.BD9F0C92
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
font-family:Arial'>So with rt_timer_set_periodic(125000) on and my sound =
task
running, I still trip the watchdog. /proc/xenomai/stat is showing 9.5% =
usage by
the sound task and a whopping 16.5% by IRQ0. (This amount seems =
considerably
lower when watchdog support is not compiled in.) The weird thing is that =
the
watchdog keeps killing the thread even though it isn&#8217;t at all =
locking up
the system. &nbsp;(ROOT using 82%.)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I changed my code to use =
this:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>if(rt_task_wait_period(0)) =
rt_task_wait_period(0);<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>This was intended to catch the &#8211;ETIMEDOUT =
return value
in case it did time out. I figure this maybe was causing the hard lockup =
I was
seeing before.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Gilles&#8217;s patch did work for me regarding the
rt_timer_set_mode() problem.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>It seems that for now, I&#8217;ll have to disable the
watchdog as I see this behavior with periodic mode or aperiodic mode. =
(My
watchdog timeout is set for 1 second.)<o:p></o:p></span></font></p>

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

------_=_NextPart_001_01C8669D.BD9F0C92--

