Content-class: urn:content-classes:message
Date: Tue, 11 Dec 2007 17:36:26 -0700
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C83C57.078877F2"
Message-ID: <51CAD0CE1504444DBE77CBBE51A0135D376097@domain.hid>
From: "Steven Seeger" <sseeger@domain.hid>
Subject: [Xenomai-help] 2.6.23.9 and geode
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

------_=_NextPart_001_01C83C57.078877F2
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I think I solved the problem with the Geode TSC issue and Xenomai.
Apparently, someone discovered that a macro used to set some stuff up in
the geode in arch/i386/kernel/cpu/cyrix.c was wrong. After fixing this,
2.6.23.9 actually turns on the suspend on halt feature. This causes
xenomai to act funny. Commenting out the line that enables suspend on
halt fixes the issue. That means that while optimum power save won't be
there, it will work properly without disabling TSC. It should be noted
that if you were previously running a Geode in TSC mode without the 27
mhz timer option (my cpu doesn't seem to have it) then you actually
weren't getting suspend on halt before either.

=20

Steven

=20


------_=_NextPart_001_01C83C57.078877F2
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
font-family:Arial'>I think I solved the problem with the Geode TSC issue =
and
Xenomai. Apparently, someone discovered that a macro used to set some =
stuff up
in the geode in arch/i386/kernel/cpu/cyrix.c was wrong. After fixing =
this,
2.6.23.9 actually turns on the suspend on halt feature. This causes =
xenomai to
act funny. Commenting out the line that enables suspend on halt fixes =
the
issue. That means that while optimum power save won&#8217;t be there, it =
will
work properly without disabling TSC. It should be noted that if you were
previously running a Geode in TSC mode without the 27 mhz timer option =
(my cpu
doesn&#8217;t seem to have it) then you actually weren&#8217;t getting =
suspend
on halt before either.<o:p></o:p></span></font></p>

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

------_=_NextPart_001_01C83C57.078877F2--

