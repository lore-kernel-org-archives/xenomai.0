From: VEYSSIERE Nicolas <nicolas.veyssiere@domain.hid>
Date: Wed, 22 Jun 2011 15:48:37 +0200
Message-ID: <18303_1308750518_4E01F2B6_18303_10863_1_ECB646CBB62FD044927FDEDF0252D3E701E388B3666A@THSONEA01CMS03P.one.grp>
References: <BANLkTinOEhJtFVTL6DM5u+J4BJrkEyBqKA@mail.gmail.com>
In-Reply-To: <BANLkTinOEhJtFVTL6DM5u+J4BJrkEyBqKA@mail.gmail.com>
Content-Language: fr-FR
Content-Type: multipart/alternative;
	boundary="_000_ECB646CBB62FD044927FDEDF0252D3E701E388B3666ATHSONEA01CM_"
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Problem during compilation
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Adrien LEMAITRE <adrien.lemaitre@domain.hid>, "xenomai@xenomai.org" <xenomai@xenomai.org>

--_000_ECB646CBB62FD044927FDEDF0252D3E701E388B3666ATHSONEA01CM_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

>From Philippe Gerum, a little earlier :


Support for latency watchdog is discontinued starting from 2.6.38.

diff --git a/ksrc/arch/x86/hal_32.c b/ksrc/arch/x86/hal_32.c
index 5f5ff2c..de21c90 100644
--- a/ksrc/arch/x86/hal_32.c
+++ b/ksrc/arch/x86/hal_32.c
@@ -337,7 +337,7 @@ int rthal_arch_init(void)
                rthal_smi_restore();
                return -ENODEV;
        }
-#ifdef CONFIG_GENERIC_CLOCKEVENTS
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,38) &&
defined(CONFIG_GENERIC_CLOCKEVENTS)
        if (nmi_watchdog =3D=3D NMI_IO_APIC) {
                printk("Xenomai: NMI kernel watchdog set to NMI_IO_APIC
(nmi_watchdog=3D1).\n"
                       "         This will disable the LAPIC as a clock
device, and\n"



--
Nicolas VEYSSIERE

De : xenomai-help-bounces@domain.hid [mailto:xenomai-help-bounces@domain.hid] De =
la part de Adrien LEMAITRE
Envoy=E9 : mercredi 22 juin 2011 15:46
=C0 : xenomai@xenomai.org
Objet : [Xenomai-help] Problem during compilation

Hello,

i would like to install xenomai on x86 pc, but during compilation i have th=
is error:
arch/x86/xenomai/hal_32.c: In function 'rthal_arch_init':
arch/x86/xenomai/hal_32.c:348: error: 'nmi_watchdog' undeclared (first use =
in this function)
arch/x86/xenomai/hal_32.c:348: error: (Each undeclared identifier is report=
ed only once
arch/x86/xenomai/hal_32.c:348: error: for each function it appears in.)
arch/x86/xenomai/hal_32.c:348: error: 'NMI_IO_APIC' undeclared (first use i=
n this function)
make[1]: *** [arch/x86/xenomai/hal_32.o] Erreur 1
make: *** [arch/x86/xenomai] Erreur 2

I use for this compilation adeos-ipipe-2.6.38.8-x86-2.10-00.patch with linu=
x-2.6.38.8 and xenomai-2.5.6.
I tried with i386_defconfig configuration and with my computer's configurat=
ion (/boot/config-2.6.32-24-generic).
In these cases always the same error.

Is it an incompatibility of version between linux and xenomai or a problem =
with configuration?

do you have an idea?


thanks,

Adrien Lema=EEtre.

--_000_ECB646CBB62FD044927FDEDF0252D3E701E388B3666ATHSONEA01CM_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Diso-8859-=
1">
<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">

<head>

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
pre
	{mso-style-priority:99;
	mso-style-link:"Pr=E9format=E9 HTML Car";
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";}
span.EmailStyle17
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
span.PrformatHTMLCar
	{mso-style-name:"Pr=E9format=E9 HTML Car";
	mso-style-priority:99;
	mso-style-link:"Pr=E9format=E9 HTML";
	font-family:"Courier New";}
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

<p class=3DMsoNormal><span style=3D'font-size:11.0pt;font-family:"Calibri",=
"sans-serif";
color:#1F497D'>From Philippe Gerum, a little earlier :<o:p></o:p></span></p=
>

<p class=3DMsoNormal><span style=3D'font-size:11.0pt;font-family:"Calibri",=
"sans-serif";
color:#1F497D'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-size:11.0pt;font-family:"Calibri",=
"sans-serif";
color:#1F497D'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-size:10.0pt;font-family:"Courier N=
ew"'>Support
for latency watchdog is discontinued starting from 2.6.38.<o:p></o:p></span=
></p>

<p class=3DMsoNormal><span style=3D'font-size:10.0pt;font-family:"Courier N=
ew"'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-size:10.0pt;font-family:"Courier N=
ew"'>diff
--git a/ksrc/arch/x86/hal_32.c b/ksrc/arch/x86/hal_32.c<o:p></o:p></span></=
p>

<p class=3DMsoNormal><span style=3D'font-size:10.0pt;font-family:"Courier N=
ew"'>index
5f5ff2c..de21c90 100644<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-size:10.0pt;font-family:"Courier N=
ew"'>---
a/ksrc/arch/x86/hal_32.c<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-size:10.0pt;font-family:"Courier N=
ew"'>+++
b/ksrc/arch/x86/hal_32.c<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-size:10.0pt;font-family:"Courier N=
ew"'>@@
-337,7 +337,7 @@ int rthal_arch_init(void)<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-size:10.0pt;font-family:"Courier N=
ew"'>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
rthal_smi_restore();<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-size:10.0pt;font-family:"Courier N=
ew"'>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
return -ENODEV;<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-size:10.0pt;font-family:"Courier N=
ew"'>=A0=A0=A0=A0=A0=A0=A0
}<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-size:10.0pt;font-family:"Courier N=
ew"'>-#ifdef
CONFIG_GENERIC_CLOCKEVENTS<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-size:10.0pt;font-family:"Courier N=
ew"'>+#if
LINUX_VERSION_CODE &lt; KERNEL_VERSION(2,6,38) &amp;&amp; <o:p></o:p></span=
></p>

<p class=3DMsoNormal><span style=3D'font-size:10.0pt;font-family:"Courier N=
ew"'>defined(CONFIG_GENERIC_CLOCKEVENTS)<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-size:10.0pt;font-family:"Courier N=
ew"'>=A0=A0=A0=A0=A0=A0=A0
if (nmi_watchdog =3D=3D NMI_IO_APIC) {<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-size:10.0pt;font-family:"Courier N=
ew"'>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
printk(&quot;Xenomai: NMI kernel watchdog set to NMI_IO_APIC <o:p></o:p></s=
pan></p>

<p class=3DMsoNormal><span style=3D'font-size:10.0pt;font-family:"Courier N=
ew"'>(nmi_watchdog=3D1).\n&quot;<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-size:10.0pt;font-family:"Courier N=
ew"'>=A0=A0=A0=A0=A0=A0
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0&quot;=A0=A0=A0=A0=A0=A0=A0=
=A0 This will disable the LAPIC as a clock <o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-size:10.0pt;font-family:"Courier N=
ew"'>device,
and\n&quot;<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-size:11.0pt;font-family:"Calibri",=
"sans-serif";
color:#1F497D'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-size:11.0pt;font-family:"Calibri",=
"sans-serif";
color:#1F497D'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-size:11.0pt;font-family:"Calibri",=
"sans-serif";
color:#1F497D'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal style=3D'line-height:9.0pt;mso-line-height-rule:exactl=
y'><span
style=3D'font-size:10.0pt;font-family:"Courier New";color:#1F497D'>-- </spa=
n><span
style=3D'font-size:10.0pt;font-family:"Courier New";color:#1F497D'><o:p></o=
:p></span></p>

<p class=3DMsoNormal style=3D'line-height:9.0pt;mso-line-height-rule:exactl=
y'><span
style=3D'font-size:10.0pt;font-family:"Courier New";color:#1F497D'>Nicolas
VEYSSIERE</span><span style=3D'font-size:11.0pt;font-family:"Calibri","sans=
-serif";
color:#1F497D'><o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-size:11.0pt;font-family:"Calibri",=
"sans-serif";
color:#1F497D'><o:p>&nbsp;</o:p></span></p>

<div style=3D'border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0cm =
0cm 0cm'>

<p class=3DMsoNormal><b><span style=3D'font-size:10.0pt;font-family:"Tahoma=
","sans-serif"'>De&nbsp;:</span></b><span
style=3D'font-size:10.0pt;font-family:"Tahoma","sans-serif"'>
xenomai-help-bounces@domain.hid [mailto:xenomai-help-bounces@domain.hid] <b>De la
part de</b> Adrien LEMAITRE<br>
<b>Envoy=E9&nbsp;:</b> mercredi 22 juin 2011 15:46<br>
<b>=C0&nbsp;:</b> xenomai@xenomai.org<br>
<b>Objet&nbsp;:</b> [Xenomai-help] Problem during compilation<o:p></o:p></s=
pan></p>

</div>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal style=3D'margin-bottom:12.0pt'>Hello,<br>
<br>
i would like to install xenomai on x86 pc, but during compilation i have th=
is
error:<o:p></o:p></p>

<div style=3D'margin-left:30.0pt'>

<p class=3DMsoNormal>arch/x86/xenomai/hal_32.c: In function &#8216;rthal_ar=
ch_init&#8217;:<br>
arch/x86/xenomai/hal_32.c:348: error: &#8216;nmi_watchdog&#8217; undeclared=
 (first use in
this function)<br>
arch/x86/xenomai/hal_32.c:348: error: (Each undeclared identifier is report=
ed
only once<br>
arch/x86/xenomai/hal_32.c:348: error: for each function it appears in.)<br>
arch/x86/xenomai/hal_32.c:348: error: &#8216;NMI_IO_APIC&#8217; undeclared =
(first use in
this function)<br>
make[1]: *** [arch/x86/xenomai/hal_32.o] Erreur 1<br>
make: *** [arch/x86/xenomai] Erreur 2<o:p></o:p></p>

</div>

<p class=3DMsoNormal><br>
I use for this compilation adeos-ipipe-2.6.38.8-x86-2.10-00.patch with
linux-2.6.38.8 and xenomai-2.5.6.<br>
I tried with i386_defconfig configuration and with my computer's configurat=
ion
(/boot/config-2.6.32-24-generic).<br>
In these cases always the same error. <br>
<br>
Is it an incompatibility of version between linux and xenomai or a problem =
with
configuration?<br>
<br>
do you have an idea?<br>
<br>
<br>
thanks,<br>
<br>
Adrien Lema=EEtre.<o:p></o:p></p>

</div>

</body>

</html>

--_000_ECB646CBB62FD044927FDEDF0252D3E701E388B3666ATHSONEA01CM_--

