From: "Ivan Kalatchev" <ivan.kalatchev@domain.hid>
Date: Mon, 11 Jan 2010 13:22:15 -0500
Message-ID: <000101ca92eb$0146fdc0$03d4f940$@kalatchev@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0002_01CA92C1.1870F5C0"
Content-Language: en-ca
Subject: [Xenomai-help] Viper board (ARM XScale) problems with Xenomai-2.4.10
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai-help@domain.hid

This is a multi-part message in MIME format.

------=_NextPart_000_0002_01CA92C1.1870F5C0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

 

I was trying to upgrade my application running on Viper (2.6.16.28 kernel
with xenomai 2.3.1)  to 

kernel 2.6.30.10 with xenomai 2.4.10 and ran into couple of problems.

 

1. My application uses real-time hook to CPLD interrupt, which is chained
interrupt.

   Xenomai 2.4.10 for some reason assigns general purpose interrupt handler
to I-pipe  acknowledgment handler :

 

in kernel/irq/chip.c:

 

               

 


------=_NextPart_000_0002_01CA92C1.1870F5C0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 12 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page Section1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.Section1
	{page:Section1;}
-->
</style>
<!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]-->
</head>

<body lang=3DEN-CA link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal>Hi,<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>I was trying to upgrade my application running on =
Viper
(2.6.16.28 kernel with xenomai 2.3.1)&nbsp; to <o:p></o:p></p>

<p class=3DMsoNormal>kernel 2.6.30.10 with xenomai 2.4.10 and ran into =
couple of
problems.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>1. My application uses real-time hook to CPLD =
interrupt,
which is chained interrupt.<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp;&nbsp; Xenomai 2.4.10 for some reason assigns =
general
purpose interrupt handler to I-pipe &nbsp;acknowledgment handler =
:<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>in kernel/irq/chip.c:<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

</div>

</body>

</html>

------=_NextPart_000_0002_01CA92C1.1870F5C0--


