From: "Gideon Spreeth" <gideon@domain.hid>
Date: Wed, 10 Feb 2010 12:13:37 +0200
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0013_01CAAA4A.7CA3ECA0"
Message-Id: <E1Nf9fW-0008Fe-OI@linux.dcomt.com>
Subject: [Xenomai-help] ARM
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

------=_NextPart_000_0013_01CAAA4A.7CA3ECA0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi there,

 

I am using a AT91SAM9260-ek board to develop a multiplexing card. I built
Angstrom linux with kernel 2.6.27 and also built in Xenomai 2.4.91 (2.5
rc2). Xenomai features works ok, but I have a problem with the Xenomai uart
driver.. The xeno_16550A serial driver is not compatible with the ARM uarts
and I cant seem to find a compatible one except for writing my own. Also
linux app like setserial, does not work correctly, I also think as it does
not have support for Atmel serial. So the standard solution of killing
serial driver with setserial and then modprobe xeno_16550A does not work..

 

Does anyone have a xenomai serial driver for ARM? Any other help you might
give will be much appreciated..

Thanx

 

Gideon Spreeth

 

DCOMt


------=_NextPart_000_0013_01CAAA4A.7CA3ECA0
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
font-family:Arial'>Hi there,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I am using a AT91SAM9260-ek board to develop a =
multiplexing
card. I built Angstrom linux with kernel 2.6.27 and also built in =
Xenomai
2.4.91 (2.5 rc2). Xenomai features works ok, but I have a problem with =
the
Xenomai uart driver.. The xeno_16550A serial driver is not compatible =
with the
ARM uarts and I cant seem to find a compatible one except for writing my =
own. Also
linux app like setserial, does not work correctly, I also think as it =
does not
have support for Atmel serial. So the standard solution of killing =
serial
driver with setserial and then modprobe xeno_16550A does not =
work..<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Does anyone have a xenomai serial driver for ARM? Any =
other
help you might give will be much =
appreciated..<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Thanx<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Gideon Spreeth<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>DCOMt<o:p></o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_0013_01CAAA4A.7CA3ECA0--


