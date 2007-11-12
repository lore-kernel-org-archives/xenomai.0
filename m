Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C824C4.3A1C079E"
Date: Sun, 11 Nov 2007 17:37:38 -0700
Message-ID: <51CAD0CE1504444DBE77CBBE51A0135D3285CE@slcmail.slc.mew.int>
From: "Steven Seeger" <sseeger@domain.hid>
Subject: [Xenomai-help] thread aware watchdog
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

------_=_NextPart_001_01C824C4.3A1C079E
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I want to make a watchdog program that can run in userspace. It would
consist of a lower priority thread that pings a high priority thread,
and if the high priority thread doesn't receive its message it will shut
down the application and log the error. I want to make it aware of the
thread that hung up, however. The only way I can think of is to keep a
list of all threads and every so often iterate over all of them and
compare the time spent in primary mode executing code. However, this is
kind of nasty. I wonder if there's a better way.

=20

The xenomai watchdog doesn't seem to know which thread is causing the
issue, but I didn't find any docs for it so I'm only going off what I
see in the code.

=20

Does anyone have any ideas on how to do this?

=20

Thanks,

Steven

=20


------_=_NextPart_001_01C824C4.3A1C079E
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
font-family:Arial'>I want to make a watchdog program that can run in =
userspace.
It would consist of a lower priority thread that pings a high priority =
thread,
and if the high priority thread doesn&#8217;t receive its message it =
will shut
down the application and log the error. I want to make it aware of the =
thread
that hung up, however. The only way I can think of is to keep a list of =
all
threads and every so often iterate over all of them and compare the time =
spent
in primary mode executing code. However, this is kind of nasty. I wonder =
if
there&#8217;s a better way.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>The xenomai watchdog doesn&#8217;t seem to know which =
thread
is causing the issue, but I didn&#8217;t find any docs for it so =
I&#8217;m only
going off what I see in the code.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Does anyone have any ideas on how to do =
this?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Thanks,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Steven<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;<o:p></o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C824C4.3A1C079E--

