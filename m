content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6C508.1240E2E3"
Date: Mon, 21 Aug 2006 11:56:28 +0200
Message-ID: <E443EE6E95070D46896C24F5C44EA7F53A1624@domain.hid>
From: "Harkema, G.A." <G.A.Harkema@domain.hid>
Subject: [Xenomai-core] rtdm_irq_request
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6C508.1240E2E3
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,

=20

I' am having some problems with using the rtdm_irq_request() function. I
disabled my local APIC support in the kernel (2.6.17, xenomai 2.2.0). My
device (USB-HOST controller) shares his IRQ with the Ethernet
card(e1000). After calling rtdm_irq_request() my system hangs. I tried
to unload the e1000 module first and it seems to work fine. Can I share
non-realtime interrupts whit real-time interrupts. If yes, what went
wrong.

=20

Who can help me.

=20

Kind regards,=20

=20

Gerard


------_=_NextPart_001_01C6C508.1240E2E3
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
span.E-mailStijl17
	{mso-style-type:personal-compose;
	font-family:Arial;
	color:windowtext;}
@page Section1
	{size:595.45pt 841.7pt;
	margin:70.55pt 72.0pt 89.3pt 72.0pt;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DNL link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Hello,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>I&#8217; am having some problems with using =
the
rtdm_irq_request() function. I disabled my local APIC support in the =
kernel (2.6.17,
xenomai 2.2.0). My device (USB-HOST controller) shares his IRQ with the =
Ethernet
card(e1000). After calling rtdm_irq_request() my system hangs. I tried =
to unload
the e1000 module first and it seems to work fine. Can I share =
non-realtime
interrupts whit real-time interrupts. If yes, what went =
wrong.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>Who can help me.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>Kind regards, <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dblue face=3DArial><span =
lang=3DEN-US
style=3D'font-size:10.0pt;font-family:Arial;color:blue'>Gerard<o:p></o:p>=
</span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C6C508.1240E2E3--

