Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C87A19.B67FE31D"
Date: Thu, 28 Feb 2008 07:53:43 -0700
Message-ID: <51CAD0CE1504444DBE77CBBE51A0135D3D0829@domain.hid>
From: "Steven Seeger" <sseeger@domain.hid>
Subject: [Xenomai-help] problems solved
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

------_=_NextPart_001_01C87A19.B67FE31D
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

So, my CPU usage problems with tasks were due to my heavy use of mutex
recursion. I got it for free in the kernel, so it made sense to do the
same in userspace. But, syscall overhead was a big problem so I wrapped
them with a simple class that seems to have solved the issue.

=20

The reason I have a lot of mutex recursion is that there are many layers
of functions that talk to certain pieces of hardware, and you may call
them at the top or at the bottom. So, the mutex must be protected at
every step.

=20

This change reduced a 2ms periodic task from 25% cpu usage down to about
16.7%. A 22% usage 500 us periodic task was reduced to 15%. These two
tasks work together to move and control a stepper motor and read all of
its sensors and inputs. The same functionality in the old system with
RTAI used about 25% of the CPU as measured by RTAI's stats stuff.
(Perhaps this wasn't very accurate.) So I'm very pleased with the
results, and feel there can probably be further optimization. (Obviously
we expect some overhead in userspace.) This usage is down from over 50%
CPU usage between the two tasks.

=20

Steven

=20

=20


------_=_NextPart_001_01C87A19.B67FE31D
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
font-family:Arial'>So, my CPU usage problems with tasks were due to my =
heavy
use of mutex recursion. I got it for free in the kernel, so it made =
sense to do
the same in userspace. But, syscall overhead was a big problem so I =
wrapped
them with a simple class that seems to have solved the =
issue.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>The reason I have a lot of mutex recursion is that =
there are
many layers of functions that talk to certain pieces of hardware, and =
you may
call them at the top or at the bottom. So, the mutex must be protected =
at every
step.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>This change reduced a 2ms periodic task from 25% cpu =
usage
down to about 16.7%. A 22% usage 500 us periodic task was reduced to =
15%. These
two tasks work together to move and control a stepper motor and read all =
of its
sensors and inputs. The same functionality in the old system with RTAI =
used
about 25% of the CPU as measured by RTAI&#8217;s stats stuff. (Perhaps =
this
wasn&#8217;t very accurate.) So I&#8217;m very pleased with the results, =
and
feel there can probably be further optimization. (Obviously we expect =
some
overhead in userspace.) This usage is down from over 50% CPU usage =
between the
two tasks.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Steven<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;<o:p></o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C87A19.B67FE31D--

