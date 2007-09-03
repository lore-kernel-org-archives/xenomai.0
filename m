Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7EE23.976B2164"
Date: Mon, 3 Sep 2007 14:11:43 +0200
Message-ID: <FDBBB5CC70676540B3EF7CFE83FD94E099942B@EINT11.einet.ad.eivd.ch>
From: "ROSSIER Daniel" <Daniel.Rossier@domain.hid>
Subject: [Xenomai-core] Activation of IRQ handler in the Linux domain
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C7EE23.976B2164
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,

=20

I'm doing a small RT application using the I2C driver from Linux.=20

At a certain time, when the task is activated and data are written to
the I2C bus,

the driver waits for a IRQ that confirmed the data have been sent out.
The write function

actually polls a variable state until a timeout or a state change
occurring on reception of that IRQ (done by the handler).

=20

However, since driver functions are called from the Xenomai domain, the
IRQ handler is not processed

at the reception since the hander belongs to the Linux domain. It ends
up with a timeout=20

during the write.

=20

I implemented a local ISR within the Xenomai application, but the
propagation of IRQ is not performed

while the task is running. Is there a way to tell Adeos to forward the
IRQ to the Linux domain with no delay

so that the Linux handler can be called? or do I need to re-implement
the ISR in the Xenomai application?

=20

Thanks for any hints.

=20

Daniel

=20


------_=_NextPart_001_01C7EE23.976B2164
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
	margin:70.85pt 70.85pt 70.85pt 70.85pt;}
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

<body lang=3DFR-CH link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal>Hello,<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal><span lang=3DEN-US>I'm doing a small RT application =
using the
I2C driver from Linux. <o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>At a certain time, when the task =
is
activated and data are written to the I2C bus,<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>the driver waits for a IRQ that =
confirmed
the data have been sent out. The write function<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>actually polls a variable state =
until a timeout
or a state change occurring on reception of that IRQ (done by the =
handler).<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>However, since driver functions =
are called
from the Xenomai domain, the IRQ handler is not =
processed<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>at the reception since the =
hander belongs
to the Linux domain. It ends up with a timeout <o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>during the =
write.<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>I implemented a local ISR within =
the
Xenomai application, but the propagation of IRQ is not =
performed<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>while the task is running. Is =
there a way
to tell Adeos to forward the IRQ to the Linux domain with no =
delay<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>so that the Linux handler can be =
called? or
do I need to re-implement the ISR in the Xenomai =
application?<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>Thanks for any =
hints.<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>Daniel<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

</div>

</body>

</html>

------_=_NextPart_001_01C7EE23.976B2164--

