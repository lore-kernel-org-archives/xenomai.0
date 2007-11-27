Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C83105.6AD38DDE"
Date: Tue, 27 Nov 2007 07:54:31 -0700
Message-ID: <51CAD0CE1504444DBE77CBBE51A0135D375D6B@slcmail.slc.mew.int>
From: "Steven Seeger" <sseeger@domain.hid>
Subject: [Xenomai-help] wathcdog
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

------_=_NextPart_001_01C83105.6AD38DDE
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Nobody responded to me on any ideas to detect a task that has locked up
without being intrusive to the code. So, I decided to just write a
simple library for my userspace programs that they can call with a high
and low priority, and it'll create two handshaking threads. The problem
is if the higher priority thread doesn't get his expected handshake
after so many iterations, it can't seem to shut down the program. I even
made that thread crash with (*(volatile unsigned int*)0) =3D 123; =
however,
this did not work either.=20

=20

The old approach I took was to wrap the thread creation routine and then
keep state for the thread so I could go through and suspend all threads
under the watchdog. The problem with this method is that it's somewhat
intrusive to the code. I want to be able to have a watchdog that kills a
userspace application only, but will leave other userspace applications
running. I was hoping to just make the program quit. Any ideas?

=20

I can't find any documentation on the NMI watchdog but I don't think it
does what I want it to do.

=20

Thanks.

=20

Steven

=20


------_=_NextPart_001_01C83105.6AD38DDE
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
font-family:Arial'>Nobody responded to me on any ideas to detect a task =
that
has locked up without being intrusive to the code. So, I decided to just =
write
a simple library for my userspace programs that they can call with a =
high and
low priority, and it&#8217;ll create two handshaking threads. The =
problem is if
the higher priority thread doesn&#8217;t get his expected handshake =
after so
many iterations, it can&#8217;t seem to shut down the program. I even =
made that
thread crash with (*(volatile unsigned int*)0) =3D 123; however, this =
did not
work either. <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>The old approach I took was to wrap the thread =
creation
routine and then keep state for the thread so I could go through and =
suspend
all threads under the watchdog. The problem with this method is that =
it&#8217;s
somewhat intrusive to the code. I want to be able to have a watchdog =
that kills
a userspace application only, but will leave other userspace =
applications
running. I was hoping to just make the program quit. Any =
ideas?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I can&#8217;t find any documentation on the NMI =
watchdog but
I don&#8217;t think it does what I want it to =
do.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Thanks.<o:p></o:p></span></font></p>

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

------_=_NextPart_001_01C83105.6AD38DDE--

