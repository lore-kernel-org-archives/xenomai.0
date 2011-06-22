From: VEYSSIERE Nicolas <nicolas.veyssiere@domain.hid>
Date: Wed, 22 Jun 2011 10:55:35 +0200
Message-ID: <2157_1308732935_4E01AE07_2157_14293_1_ECB646CBB62FD044927FDEDF0252D3E701E388AD6F15@domain.hid>
Content-Language: fr-FR
Content-Type: multipart/alternative;
	boundary="_000_ECB646CBB62FD044927FDEDF0252D3E701E388AD6F15THSONEA01CM_"
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Xenomai 2.5.6 and 2.6.38.8 kernel
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

--_000_ECB646CBB62FD044927FDEDF0252D3E701E388AD6F15THSONEA01CM_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Same thing here, I tried to patch linux 2.6.38 with the latest adeos patch =
(http://download.gna.org/adeos/patches/v2.6/x86/adeos-ipipe-2.6.38.8-x86-2.=
10-00.patch) but the kernel compilation failed :


......
  LD      arch/x86/pci/built-in.o
  CC      arch/x86/power/cpu.o
  CC      arch/x86/power/hibernate_32.o
  AS      arch/x86/power/hibernate_asm_32.o
  LD      arch/x86/power/built-in.o
  CC      arch/x86/video/fbdev.o
  LD      arch/x86/video/built-in.o
  CC      arch/x86/xenomai/hal_32.o
arch/x86/xenomai/hal_32.c: In function 'rthal_arch_init':
arch/x86/xenomai/hal_32.c:341: error: 'nmi_watchdog' undeclared (first use =
in this function)
arch/x86/xenomai/hal_32.c:341: error: (Each undeclared identifier is report=
ed only once
arch/x86/xenomai/hal_32.c:341: error: for each function it appears in.)
arch/x86/xenomai/hal_32.c:341: error: 'NMI_IO_APIC' undeclared (first use i=
n this function)
At top level:
cc1: warning: unrecognized command line option "-Wno-unused-but-set-variabl=
e"
make[1]: *** [arch/x86/xenomai/hal_32.o] Error 1
make: *** [arch/x86/xenomai] Error 2



Can someone tell me what to do ?

Thanks.

Regards,

--
Nicolas VEYSSIERE


--_000_ECB646CBB62FD044927FDEDF0252D3E701E388AD6F15THSONEA01CM_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Dus-ascii"=
>
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

<body lang=3DFR link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal>Same thing here, I tried to patch linux 2.6.38 with th=
e
latest adeos patch (<a
href=3D"http://download.gna.org/adeos/patches/v2.6/x86/adeos-ipipe-2.6.38.8=
-x86-2.10-00.patch">http://download.gna.org/adeos/patches/v2.6/x86/adeos-ip=
ipe-2.6.38.8-x86-2.10-00.patch</a>)
but the kernel compilation failed :<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>&#8230;&#8230;<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp; LD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; arch/x86/pci/b=
uilt-in.o<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp; CC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; arch/x86/power=
/cpu.o<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp; CC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; arch/x86/power=
/hibernate_32.o<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp; AS&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;arch/x86/power=
/hibernate_asm_32.o<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp; LD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; arch/x86/power=
/built-in.o<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp; CC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; arch/x86/video=
/fbdev.o<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp; LD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; arch/x86/video=
/built-in.o<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp; CC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; arch/x86/xenom=
ai/hal_32.o<o:p></o:p></p>

<p class=3DMsoNormal>arch/x86/xenomai/hal_32.c: In function 'rthal_arch_ini=
t':<o:p></o:p></p>

<p class=3DMsoNormal>arch/x86/xenomai/hal_32.c:341: error: 'nmi_watchdog'
undeclared (first use in this function)<o:p></o:p></p>

<p class=3DMsoNormal>arch/x86/xenomai/hal_32.c:341: error: (Each undeclared
identifier is reported only once<o:p></o:p></p>

<p class=3DMsoNormal>arch/x86/xenomai/hal_32.c:341: error: for each functio=
n it
appears in.)<o:p></o:p></p>

<p class=3DMsoNormal>arch/x86/xenomai/hal_32.c:341: error: 'NMI_IO_APIC'
undeclared (first use in this function)<o:p></o:p></p>

<p class=3DMsoNormal>At top level:<o:p></o:p></p>

<p class=3DMsoNormal>cc1: warning: unrecognized command line option
&quot;-Wno-unused-but-set-variable&quot;<o:p></o:p></p>

<p class=3DMsoNormal>make[1]: *** [arch/x86/xenomai/hal_32.o] Error 1<o:p><=
/o:p></p>

<p class=3DMsoNormal>make: *** [arch/x86/xenomai] Error 2<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Can someone tell me what to do ?<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Thanks.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Regards,<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal style=3D'line-height:9.0pt;mso-line-height-rule:exactl=
y'><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>-- </span><span
style=3D'font-size:10.0pt;font-family:"Courier New"'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'line-height:9.0pt;mso-line-height-rule:exactl=
y'><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Nicolas VEYSSIERE</spa=
n><o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

</div>

</body>

</html>

--_000_ECB646CBB62FD044927FDEDF0252D3E701E388AD6F15THSONEA01CM_--

