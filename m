From: "Jonas Witt" <Jonas@domain.hid>
Date: Thu, 10 May 2007 14:53:42 +0200
Message-ID: <000b01c79302$3cf11a40$c67ba8c0@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_000C_01C79313.0079EA40"
Subject: [Xenomai-help] Serial Port Driver (rtser): No RTSER_RTIOC_WAIT_EVENT
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

------=_NextPart_000_000C_01C79313.0079EA40
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi everybody,

=20

i am having a problem with the serial port driver in xenomai for a while
now..

=20

I have tried different programs like
http://www.captain.at/xenomai-serial-port-example.php

=20

I have also changed the code of cross-link.c to use the same port for
writing and reading (as i only have one serial port in my computer). =
Opening
a port and writing the configuration seems to work form e.. also =
writing.
The Problem stems from the call to:

=20

rt_dev_ioctl(read_fd, RTSER_RTIOC_WAIT_EVENT, &rx_event);

=20

which keeps waiting forever and never receives an interrupt. I tried a
self-made loopback-adapter and a sensor with a serial interface (so at =
least
_something_ should come back). Nothing worked. The serial port is =
working
fine with the linux-driver, though. I already figured that the calls to
rt_dev_write do not work from non-xenomai-tasks (which should really be
emphasized in the documentation..)

=20

I am already pretty much behind my schedule with the project that i am
undertaking.. any (preferably fast ;) ) input is very much appreciated. =
I
think i will update the serial driver documentation when i am through =
with
my initial problems. I think that is desperately needed for other people
that are new to xenomai.

=20

Thanks in advance!

Cheers, Jonas


------=_NextPart_000_000C_01C79313.0079EA40
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">


<meta name=3DGenerator content=3D"Microsoft Word 10 (filtered)">

<style>
<!--
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
span.emailformatvorlage17
	{font-family:Arial;
	color:windowtext;}
span.EmailFormatvorlage18
	{font-family:Arial;
	color:windowtext;}
@page Section1
	{size:595.3pt 841.9pt;
	margin:70.85pt 70.85pt 2.0cm 70.85pt;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DDE link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D3 face=3DArial><span =
style=3D'font-size:12.0pt;
font-family:Arial'>Hi everybody,</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DArial><span =
style=3D'font-size:12.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DArial><span =
style=3D'font-size:12.0pt;
font-family:Arial'>i am having a problem with the serial port driver in =
xenomai
for a while now..</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DArial><span =
style=3D'font-size:12.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DArial><span =
style=3D'font-size:12.0pt;
font-family:Arial'>I have tried different programs like <a
href=3D"http://www.captain.at/xenomai-serial-port-example.php">http://www=
.captain.at/xenomai-serial-port-example.php</a></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DArial><span =
style=3D'font-size:12.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DArial><span =
style=3D'font-size:12.0pt;
font-family:Arial'>I have also changed the code of cross-link.c to use =
the same
port for writing and reading (as i only have one serial port in my =
computer).
Opening a port and writing the configuration seems to work form e.. also
writing. The Problem stems from the call to:</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DArial><span =
style=3D'font-size:12.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:black'>rt_dev_ioctl</span></font><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-family:"Courier New"'>(<font
color=3Dblack><span style=3D'color:black'>read_fd</span></font>, <font =
color=3Dblack><span
style=3D'color:black'>RTSER_RTIOC_WAIT_EVENT</span></font>, &amp;<font
color=3Dblack><span =
style=3D'color:black'>rx_event</span></font>);</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DArial><span =
style=3D'font-size:12.0pt;
font-family:Arial'>which keeps waiting forever and never receives an =
interrupt.
I tried a self-made loopback-adapter and a sensor with a serial =
interface (so
at least _<i><span style=3D'font-style:italic'>something</span></i>_ =
should come
back). Nothing worked. The serial port is working fine with the =
linux-driver,
though. I already figured that the calls to rt_dev_write do not work =
from
non-xenomai-tasks (which should really be emphasized in the =
documentation..)</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DArial><span =
style=3D'font-size:12.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DArial><span =
style=3D'font-size:12.0pt;
font-family:Arial'>I am already pretty much behind my schedule with the =
project
that i am undertaking.. any (preferably fast ;) ) input is very much
appreciated. I think i will update the serial driver documentation when =
i am
through with my initial problems. I think that is desperately needed for =
other people
that are new to xenomai.</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DArial><span =
style=3D'font-size:12.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DArial><span =
style=3D'font-size:12.0pt;
font-family:Arial'>Thanks in advance!</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DArial><span =
style=3D'font-size:12.0pt;
font-family:Arial'>Cheers, Jonas</span></font></p>

</div>

</body>

</html>

------=_NextPart_000_000C_01C79313.0079EA40--


