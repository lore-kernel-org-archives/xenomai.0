Message-Id: <200710031504.l93F4ku4020241@domain.hid>
From: "Patrick" <kpa_info@domain.hid>
Date: Wed, 3 Oct 2007 17:04:50 +0200
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0024_01C805DF.827DFD80"
In-Reply-To: <2ff1a98a0710030642q5ff5cdd7ke2b12bb2ac35016c@domain.hid>
Subject: Re: [Xenomai-help] rt_task crash kernel
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: 'Gilles Chanteperdrix' <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.

------=_NextPart_000_0024_01C805DF.827DFD80
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

The timer is ticking but stops after some times

I have enabled all debug options in menuconfig but no message is printed
before the crash.

I try to patch new kernel with 2.6.20-arm-1.7-02 patch but is the same.

=20

For the 2.6.15 kernel I hadn=92t eabi toolchain and the kernel was not
compiled with eabi.=20

For 2.6.20 kernel I have an eabi toolchain and the kernel is compiled =
with
eabi.=20

=20

In yours PXA270 board 2.6.20 kernel with xenomai 2.3.4 works?

=20

Thank=92s

=20

-----Message d'origine-----
De : Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org
Envoy=E9 : mercredi, 3. octobre 2007 15:43
=C0 : Patrick
Cc : xenomai@xenomai.org
Objet : Re: [Xenomai-help] rt_task crash kernel

=20

On 10/3/07, Patrick <kpa_info@domain.hid> wrote:

> Ok, some messages occur on the console with latency.

=20

Continuously, or does it stop ? If the timer is still ticking, it is

surprising that latency does not print anything. If the timer stops,

then we have a problem. You may also want to enable all Xenomai/I-pipe

debugging options in order to see if it prints something before

locking up.

=20

>=20

> For information I have successfully installed and used Xenomai 2.3.1 =
with

> 2.6.15 kernel on the same board.

=20

But for the 2.6.15, you had no EABI, have you tried compiling the

v2.3.4 without EABI ? Another thing that you could try is to compile

v2.3.4 with the patch

http://download.gna.org/adeos/patches/v2.6/arm/older/adeos-ipipe-2.6.20-a=
rm-
1.7-02.patch.

=20

This patch was the last patch before reworking the tsc emulation,

knowing whether it works could help find what part of the patch is

causing the issue you observe.

=20

--=20

                                               Gilles Chanteperdrix


------=_NextPart_000_0024_01C805DF.827DFD80
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
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
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";}
@page Section1
	{size:595.3pt 841.9pt;
	margin:70.85pt 69.6pt 70.85pt 69.6pt;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DFR link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-GB
style=3D'font-size:10.0pt'>The timer is ticking but stops after some =
times<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-GB
style=3D'font-size:10.0pt'>I have enabled all debug options in =
menuconfig but no
message is printed before the crash.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-GB
style=3D'font-size:10.0pt'>I try to patch new kernel with =
2.6.20-arm-1.7-02 patch
but is the same.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-GB
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-GB
style=3D'font-size:10.0pt'>For the 2.6.15 kernel I hadn&#8217;t eabi =
toolchain
and the kernel was not compiled with eabi. <o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-GB
style=3D'font-size:10.0pt'>For 2.6.20 kernel I have an eabi toolchain =
and the
kernel is compiled with eabi. <o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-GB
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-GB
style=3D'font-size:10.0pt'>In yours PXA270 board 2.6.20 kernel with =
xenomai 2.3.4
works?<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-GB
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-GB
style=3D'font-size:10.0pt'>Thank&#8217;s<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-GB
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>-----Message d'origine-----<br>
De&nbsp;: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org] =
<br>
Envoy=E9&nbsp;: mercredi, 3. octobre 2007 15:43<br>
=C0&nbsp;: Patrick<br>
Cc&nbsp;: xenomai@xenomai.org<br>
Objet&nbsp;: Re: [Xenomai-help] rt_task crash kernel</span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>On 10/3/07, Patrick &lt;kpa_info@domain.hid&gt; =
wrote:<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt; Ok, some messages occur on the console with =
latency.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>Continuously, or does it stop ? If the timer is still ticking, =
it is<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>surprising that latency does not print anything. If the timer =
stops,<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>then we have a problem. You may also want to enable all =
Xenomai/I-pipe<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>debugging options in order to see if it prints something =
before<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>locking up.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;<o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt; For information I have successfully installed and used =
Xenomai
2.3.1 with<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt; 2.6.15 kernel on the same =
board.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>But for the 2.6.15, you had no EABI, have you tried compiling =
the<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>v2.3.4 without EABI ? Another thing that you could try is to =
compile<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>v2.3.4 with the patch<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>http://download.gna.org/adeos/patches/v2.6/arm/older/adeos-ipipe-=
2.6.20-arm-1.7-02.patch.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>This patch was the last patch before reworking the tsc =
emulation,<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>knowing whether it works could help find what part of the patch =
is<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>causing the issue you observe.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>-- <o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
Gilles Chanteperdrix<o:p></o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_0024_01C805DF.827DFD80--


