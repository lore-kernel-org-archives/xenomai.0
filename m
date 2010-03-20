Content-Transfer-Encoding: 7bit
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CAC865.F39A72E2"
Date: Sat, 20 Mar 2010 20:45:53 +0100
Message-ID: <1183078C0D064042B3AD2D03E3859EF1078598@domain.hid>
In-reply-to: <658708.64699.qm@domain.hid>
References: <658708.64699.qm@domain.hid>
From: <thomas.debes@domain.hid>
Subject: Re: [Xenomai-help] Simulink and RTDM device driver
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: menege1@domain.hid, xenomai@xenomai.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01CAC865.F39A72E2
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

=20

just add the calls to your driver in the corresponding mdl* callbacks in =
your s-function. Take care of the calling context rt/nrt. Depending on =
your target (e.g. simulation, generic realtime, embedded) it might be =
better to provide a tlc file instead of a s-function mex-file.

=20

Thomas=20

=20

=20

Von: xenomai-help-bounces@domain.hid [mailto:xenomai-help-bounces@domain.hid] =
Im Auftrag von egemen kaleli
Gesendet: Samstag, 20. M=C3=A4rz 2010 16:25
An: xenomai@xenomai.org
Betreff: [Xenomai-help] Simulink and RTDM device driver

=20

Hello;

=20

I developed a real-time driver with rtdm for a PCI I/O board.My next aim =
is to incorporate this driver into Simulink S-functions.For example, I =
will create a DAC,an ADC,a TIMER Simulink device driver block and these =
driver blocks will use my rtdm driver. How can I achieve this?Thanks for =
help in advance.

=20

Egemen KALEL=C4=B0,Gebze Institute of Technology

TURKEY

--------------------------------------------------------
manroland AG
Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus =
Rall, Paul Steidle  =20
Sitz der Gesellschaft: Offenbach am Main, Registergericht: Amtsgericht =
Offenbach HRB-Nr. 42592
USt-Ident-Nr. DE 250200933

------_=_NextPart_001_01CAC865.F39A72E2
Content-Type: text/html;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<HTML >
<HEAD>
<META http-equiv=3D"Content-Type" content=3D"text/html; =
charset=3Dutf-8">



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
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.E-MailFormatvorlage18
	{mso-style-type:personal-reply;
	font-family:"Arial","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page Section1
	{size:612.0pt 792.0pt;
	margin:70.85pt 70.85pt 2.0cm 70.85pt;}
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
</HEAD>
<BODY lang=3DDE link=3Dblue vlink=3Dpurple>
<DIV>

<div class=3DSection1>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:11.0pt;font-family:"Arial","sans-serif"'>Hi,<o:p></o:p=
></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:11.0pt;font-family:"Arial","sans-serif"'><o:p>&nbsp;</=
o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:11.0pt;font-family:"Arial","sans-serif"'>just
add the calls to your driver in the corresponding mdl* callbacks in your
s-function. Take care of the calling context rt/nrt. Depending on your =
target
(e.g. simulation, generic realtime, embedded) it might be better to =
provide a
tlc file instead of a s-function mex-file.<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:11.0pt;font-family:"Arial","sans-serif"'><o:p>&nbsp;</=
o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:11.0pt;font-family:"Arial","sans-serif"'>Thomas
<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:11.0pt;font-family:"Arial","sans-serif"'><o:p>&nbsp;</=
o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:11.0pt;font-family:"Arial","sans-serif"'><o:p>&nbsp;</=
o:p></span></p>

<div style=3D'border:none;border-left:solid blue 1.5pt;padding:0cm 0cm =
0cm 4.0pt'>

<div>

<div style=3D'border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt =
0cm 0cm 0cm'>

<p class=3DMsoNormal><b><span =
style=3D'font-size:10.0pt;font-family:"Tahoma","sans-serif"'>Von:</span><=
/b><span
style=3D'font-size:10.0pt;font-family:"Tahoma","sans-serif"'>
xenomai-help-bounces@domain.hid [mailto:xenomai-help-bounces@domain.hid] <b>Im
Auftrag von </b>egemen kaleli<br>
<b>Gesendet:</b> Samstag, 20. M&#228;rz 2010 16:25<br>
<b>An:</b> xenomai@xenomai.org<br>
<b>Betreff:</b> [Xenomai-help] Simulink and RTDM device =
driver<o:p></o:p></span></p>

</div>

</div>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<table class=3DMsoNormalTable border=3D0 cellspacing=3D0 =
cellpadding=3D0>
 <tr>
  <td valign=3Dtop style=3D'padding:0cm 0cm 0cm 0cm'>
  <div>
  <p class=3DMsoNormal>Hello;<o:p></o:p></p>
  </div>
  <div>
  <p class=3DMsoNormal>&nbsp;<o:p></o:p></p>
  </div>
  <div>
  <p class=3DMsoNormal>I developed a real-time driver with rtdm for a =
PCI I/O
  board.My next aim is to incorporate this driver into Simulink =
S-functions.For
  example, I will create a DAC,an ADC,a TIMER Simulink device driver =
block and <strong>these
  driver blocks will use my rtdm driver</strong>.&nbsp;How can I achieve
  this?Thanks for help in advance.<o:p></o:p></p>
  </div>
  <div>
  <p class=3DMsoNormal>&nbsp;<o:p></o:p></p>
  </div>
  <div>
  <p class=3DMsoNormal>Egemen KALEL&#304;,Gebze Institute of =
Technology<o:p></o:p></p>
  </div>
  <div>
  <p class=3DMsoNormal>TURKEY<o:p></o:p></p>
  </div>
  <div>
  <p class=3DMsoNormal>&nbsp;<o:p></o:p></p>
  </div>
  </td>
 </tr>
</table>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;font-family:"Calibri","sans-serif"'><o:p>&nbsp;=
</o:p></span></p>

</div>

</div>

</DIV><BR><STRONG><SPAN STYLE=3D"FONT-FAMILY: =
Arial"></SPAN></STRONG><PRE><SPAN STYLE=3D"FONT-SIZE: 7.5pt; =
FONT-FAMILY: Arial"><HR ALIGN=3D"center" WIDTH=3D"100%" =
SIZE=3D"2"></SPAN><SPAN STYLE=3D"FONT-SIZE: 7.5pt; FONT-FAMILY: =
Arial">manroland AG<BR>Vorsitzender des Aufsichtsrates: Hanno C. =
Fiedler<BR>Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. =
Markus Rall, Paul Steidle   <BR>Sitz der Gesellschaft: Offenbach am =
Main, Registergericht: Amtsgericht Offenbach HRB-Nr. =
42592<BR>USt-Ident-Nr. DE 250200933<BR></SPAN></PRE>
<P>
</P>
<P>
</P>
<P>
</P>
<P>
</P></BODY></HTML>
			
------_=_NextPart_001_01CAC865.F39A72E2--

