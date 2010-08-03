From: "Martin Kremenak" <m.kremenak@domain.hid>
Date: Tue, 3 Aug 2010 18:03:46 +0200
Message-ID: <4c583de0.5396cc0a.3011.ffffd8a9@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0001_01CB3336.38D14340"
Content-Language: de-at
Subject: [Xenomai-help] Some questions about Xenomai
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

------=_NextPart_000_0001_01CB3336.38D14340
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi, 

 

I want to realize control system based on real time Linux. So I decide me
for Xenomai. 

After some research I found a Code Generator for Xenomai from Evidence:
http://www.evidence.eu.com/content/view/175/216 which I can generate Code
from Scilab/Scicos for Xenoami.

I read the readme-file from Evidence and the recommended Xenomai 2.4.3.

 

So I tried to install Xenomai 2.4.3 with Kernel 2.6.24/2.6.24.2/2.6.24.1 on
my System. 

I tried this quick build guide:
http://www.xenomai.org/index.php/Xenomai_quick_build_quide

On the point where I compile the Kernel I got following error:

debXenomai:/usr/src/linux-2.6.24.2# make 
scripts/kconfig/conf -s arch/x86/Kconfig 
   CHK     include/linux/version.h 
   CHK     include/linux/utsrelease.h 
   CALL    scripts/checksyscalls.sh 
   CHK     include/linux/compile.h 
   AS      arch/x86/kernel/entry_32.o 
 arch/x86/kernel/entry_32.S: Assembler messages: 
 arch/x86/kernel/entry_32.S:270: Error: invalid character '_' in mnemonic 
 arch/x86/kernel/entry_32.S:321: Error: invalid character '_' in mnemonic 
 arch/x86/kernel/entry_32.S:351: Error: invalid character '_' in mnemonic 
 arch/x86/kernel/entry_32.S:521: Error: invalid character '_' in mnemonic 
 arch/x86/kernel/entry_32.S:536: Error: invalid character '_' in mnemonic 
 make[1]: *** [arch/x86/kernel/entry_32.o] Fehler 1 
 make: *** [arch/x86/kernel] Fehler 2 

Have anybody the same problem or a solution to fix the problem?

 

Maybe anyone have experience with the Code Generator from Evidence and newer
versions from Xenomai? It is possible to use a newer version?

The Evidence wiki and forum is down. Maybe the project is adjusted, so I can
not ask some people from Evidence. 

 

I also searched for Kernel-Configs for an x86 Intel-System (CoreDuo2),
please post your experience. 

 

Another open point is the graphical interface. I search for something like
xrtailab or  something else. 

 

Regards,

 

Martin K.

 


------=_NextPart_000_0001_01CB3336.38D14340
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 12 (filtered medium)">
<style>
<!--
 /* Font Definitions */
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
code
	{mso-style-priority:99;
	font-family:"Courier New";}
span.E-MailFormatvorlage17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
span.codenr
	{mso-style-name:codenr;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:70.85pt 70.85pt 2.0cm 70.85pt;}
div.WordSection1
	{page:WordSection1;}
-->
</style>
<!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]-->
</head>

<body lang=3DDE-AT link=3Dblue vlink=3Dpurple>

<div class=3DWordSection1>

<p class=3DMsoNormal><span lang=3DEN-US>Hi, <o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>I want to realize control system =
based on
real time Linux. So I decide me for Xenomai. <o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>After some research I found a =
Code
Generator for Xenomai from Evidence: <a
href=3D"http://www.evidence.eu.com/content/view/175/216">http://www.evide=
nce.eu.com/content/view/175/216</a>
which I can generate Code from Scilab/Scicos for =
Xenoami.<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>I read the readme-file from =
Evidence and
the recommended Xenomai 2.4.3.<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>So I tried to install Xenomai =
2.4.3 with
Kernel 2.6.24/2.6.24.2/2.6.24.1 on my System. <o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>I tried this quick build guide: =
<a
href=3D"http://www.xenomai.org/index.php/Xenomai_quick_build_quide">http:=
//www.xenomai.org/index.php/Xenomai_quick_build_quide</a><o:p></o:p></spa=
n></p>

<p class=3DMsoNormal><span lang=3DEN-US>On the point where I compile the =
Kernel I
got following error:<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-bottom:12.0pt'><code><span =
lang=3DEN-US
style=3D'font-size:10.0pt;color:#0000BB'>debXenomai</span></code><code><s=
pan
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#007700'>:/</span></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#0000BB'>usr</span></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#007700'>/</span></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#0000BB'>src</span></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#007700'>/</span></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#0000BB'>linux</span></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#007700'>-</span></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#0000BB'>2.6.24.2</span></code><code><spa=
n
lang=3DEN-US style=3D'font-size:10.0pt;color:#FF8000'>#&nbsp;make =
</span></code><span
lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Courier =
New";color:#FF8000'><br>
</span><code><span lang=3DEN-US =
style=3D'font-size:10.0pt;color:#0000BB'>scripts</span></code><code><span=

lang=3DEN-US =
style=3D'font-size:10.0pt;color:#007700'>/</span></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#0000BB'>kconfig</span></code><code><span=

lang=3DEN-US =
style=3D'font-size:10.0pt;color:#007700'>/</span></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#0000BB'>conf&nbsp;</span></code><code><s=
pan
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#007700'>-</span></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#0000BB'>s&nbsp;arch</span></code><code><=
span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#007700'>/</span></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#0000BB'>x86</span></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#007700'>/</span></code><code><span
lang=3DEN-US style=3D'font-size:10.0pt;color:#0000BB'>Kconfig =
</span></code><span
lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Courier =
New";color:#0000BB'><br>
<span =
class=3Dcodenr>&nbsp;</span><code>&nbsp;&nbsp;CHK&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;</code></span><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#007700'>include/</span></code><code><spa=
n
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#0000BB'>linux</span></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#007700'>/</span></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#0000BB'>version</span></code><code><span=

lang=3DEN-US =
style=3D'font-size:10.0pt;color:#007700'>.</span></code><code><span
lang=3DEN-US style=3D'font-size:10.0pt;color:#0000BB'>h =
</span></code><span
lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Courier =
New";color:#0000BB'><br>
<span =
class=3Dcodenr>&nbsp;</span><code>&nbsp;&nbsp;CHK&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;</code></span><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#007700'>include/</span></code><code><spa=
n
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#0000BB'>linux</span></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#007700'>/</span></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#0000BB'>utsrelease</span></code><code><s=
pan
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#007700'>.</span></code><code><span
lang=3DEN-US style=3D'font-size:10.0pt;color:#0000BB'>h =
</span></code><span
lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Courier =
New";color:#0000BB'><br>
<span =
class=3Dcodenr>&nbsp;</span><code>&nbsp;&nbsp;CALL&nbsp;&nbsp;&nbsp;&nbsp=
;scripts</code></span><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#007700'>/</span></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#0000BB'>checksyscalls</span></code><code=
><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#007700'>.</span></code><code><span
lang=3DEN-US style=3D'font-size:10.0pt;color:#0000BB'>sh =
</span></code><span
lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Courier =
New";color:#0000BB'><br>
<span =
class=3Dcodenr>&nbsp;</span><code>&nbsp;&nbsp;CHK&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;</code></span><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#007700'>include/</span></code><code><spa=
n
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#0000BB'>linux</span></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#007700'>/</span></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#0000BB'>compile</span></code><code><span=

lang=3DEN-US =
style=3D'font-size:10.0pt;color:#007700'>.</span></code><code><span
lang=3DEN-US style=3D'font-size:10.0pt;color:#0000BB'>h =
</span></code><span
lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Courier =
New";color:#0000BB'><br>
<span =
class=3Dcodenr>&nbsp;</span><code>&nbsp;&nbsp;</code></span><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#007700'>AS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;</span></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#0000BB'>arch</span></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#007700'>/</span></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#0000BB'>x86</span></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#007700'>/</span></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#0000BB'>kernel</span></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#007700'>/</span></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#0000BB'>entry_32</span></code><code><spa=
n
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#007700'>.</span></code><code><span
lang=3DEN-US style=3D'font-size:10.0pt;color:#0000BB'>o =
</span></code><span
lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Courier =
New";color:#0000BB'><br>
<span class=3Dcodenr>&nbsp;</span><code>arch</code></span><code><span =
lang=3DEN-US
style=3D'font-size:10.0pt;color:#007700'>/</span></code><code><span =
lang=3DEN-US
style=3D'font-size:10.0pt;color:#0000BB'>x86</span></code><code><span =
lang=3DEN-US
style=3D'font-size:10.0pt;color:#007700'>/</span></code><code><span =
lang=3DEN-US
style=3D'font-size:10.0pt;color:#0000BB'>kernel</span></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#007700'>/</span></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#0000BB'>entry_32</span></code><code><spa=
n
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#007700'>.</span></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#0000BB'>S</span></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#007700'>:&nbsp;</span></code><code><span=

lang=3DEN-US =
style=3D'font-size:10.0pt;color:#0000BB'>Assembler&nbsp;messages</span></=
code><code><span
lang=3DEN-US style=3D'font-size:10.0pt;color:#007700'>: =
</span></code><span
lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Courier =
New";color:#007700'><br>
<span class=3Dcodenr>&nbsp;</span></span><code><span lang=3DEN-US =
style=3D'font-size:
10.0pt;color:#0000BB'>arch</span></code><code><span lang=3DEN-US
style=3D'font-size:10.0pt;color:#007700'>/</span></code><code><span =
lang=3DEN-US
style=3D'font-size:10.0pt;color:#0000BB'>x86</span></code><code><span =
lang=3DEN-US
style=3D'font-size:10.0pt;color:#007700'>/</span></code><code><span =
lang=3DEN-US
style=3D'font-size:10.0pt;color:#0000BB'>kernel</span></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#007700'>/</span></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#0000BB'>entry_32</span></code><code><spa=
n
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#007700'>.</span></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#0000BB'>S</span></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#007700'>:</span></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#0000BB'>270</span></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#007700'>:&nbsp;</span></code><code><span=

lang=3DEN-US =
style=3D'font-size:10.0pt;color:#0000BB'>Error</span></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#007700'>:&nbsp;</span></code><code><span=

lang=3DEN-US =
style=3D'font-size:10.0pt;color:#0000BB'>invalid&nbsp;character&nbsp;</sp=
an></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#DD0000'>'_'&nbsp;</span></code><code><sp=
an
lang=3DEN-US style=3D'font-size:10.0pt;color:#0000BB'>in&nbsp;mnemonic =
</span></code><span
lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Courier =
New";color:#0000BB'><br>
<span class=3Dcodenr>&nbsp;</span><code>arch</code></span><code><span =
lang=3DEN-US
style=3D'font-size:10.0pt;color:#007700'>/</span></code><code><span =
lang=3DEN-US
style=3D'font-size:10.0pt;color:#0000BB'>x86</span></code><code><span =
lang=3DEN-US
style=3D'font-size:10.0pt;color:#007700'>/</span></code><code><span =
lang=3DEN-US
style=3D'font-size:10.0pt;color:#0000BB'>kernel</span></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#007700'>/</span></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#0000BB'>entry_32</span></code><code><spa=
n
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#007700'>.</span></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#0000BB'>S</span></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#007700'>:</span></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#0000BB'>321</span></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#007700'>:&nbsp;</span></code><code><span=

lang=3DEN-US =
style=3D'font-size:10.0pt;color:#0000BB'>Error</span></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#007700'>:&nbsp;</span></code><code><span=

lang=3DEN-US =
style=3D'font-size:10.0pt;color:#0000BB'>invalid&nbsp;character&nbsp;</sp=
an></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#DD0000'>'_'&nbsp;</span></code><code><sp=
an
lang=3DEN-US style=3D'font-size:10.0pt;color:#0000BB'>in&nbsp;mnemonic =
</span></code><span
lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Courier =
New";color:#0000BB'><br>
<span class=3Dcodenr>&nbsp;</span><code>arch</code></span><code><span =
lang=3DEN-US
style=3D'font-size:10.0pt;color:#007700'>/</span></code><code><span =
lang=3DEN-US
style=3D'font-size:10.0pt;color:#0000BB'>x86</span></code><code><span =
lang=3DEN-US
style=3D'font-size:10.0pt;color:#007700'>/</span></code><code><span =
lang=3DEN-US
style=3D'font-size:10.0pt;color:#0000BB'>kernel</span></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#007700'>/</span></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#0000BB'>entry_32</span></code><code><spa=
n
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#007700'>.</span></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#0000BB'>S</span></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#007700'>:</span></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#0000BB'>351</span></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#007700'>:&nbsp;</span></code><code><span=

lang=3DEN-US =
style=3D'font-size:10.0pt;color:#0000BB'>Error</span></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#007700'>:&nbsp;</span></code><code><span=

lang=3DEN-US =
style=3D'font-size:10.0pt;color:#0000BB'>invalid&nbsp;character&nbsp;</sp=
an></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#DD0000'>'_'&nbsp;</span></code><code><sp=
an
lang=3DEN-US style=3D'font-size:10.0pt;color:#0000BB'>in&nbsp;mnemonic =
</span></code><span
lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Courier =
New";color:#0000BB'><br>
<span class=3Dcodenr>&nbsp;</span><code>arch</code></span><code><span =
lang=3DEN-US
style=3D'font-size:10.0pt;color:#007700'>/</span></code><code><span =
lang=3DEN-US
style=3D'font-size:10.0pt;color:#0000BB'>x86</span></code><code><span =
lang=3DEN-US
style=3D'font-size:10.0pt;color:#007700'>/</span></code><code><span =
lang=3DEN-US
style=3D'font-size:10.0pt;color:#0000BB'>kernel</span></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#007700'>/</span></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#0000BB'>entry_32</span></code><code><spa=
n
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#007700'>.</span></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#0000BB'>S</span></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#007700'>:</span></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#0000BB'>521</span></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#007700'>:&nbsp;</span></code><code><span=

lang=3DEN-US =
style=3D'font-size:10.0pt;color:#0000BB'>Error</span></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#007700'>:&nbsp;</span></code><code><span=

lang=3DEN-US =
style=3D'font-size:10.0pt;color:#0000BB'>invalid&nbsp;character&nbsp;</sp=
an></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#DD0000'>'_'&nbsp;</span></code><code><sp=
an
lang=3DEN-US style=3D'font-size:10.0pt;color:#0000BB'>in&nbsp;mnemonic =
</span></code><span
lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Courier =
New";color:#0000BB'><br>
<span class=3Dcodenr>&nbsp;</span><code>arch</code></span><code><span =
lang=3DEN-US
style=3D'font-size:10.0pt;color:#007700'>/</span></code><code><span =
lang=3DEN-US
style=3D'font-size:10.0pt;color:#0000BB'>x86</span></code><code><span =
lang=3DEN-US
style=3D'font-size:10.0pt;color:#007700'>/</span></code><code><span =
lang=3DEN-US
style=3D'font-size:10.0pt;color:#0000BB'>kernel</span></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#007700'>/</span></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#0000BB'>entry_32</span></code><code><spa=
n
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#007700'>.</span></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#0000BB'>S</span></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#007700'>:</span></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#0000BB'>536</span></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#007700'>:&nbsp;</span></code><code><span=

lang=3DEN-US =
style=3D'font-size:10.0pt;color:#0000BB'>Error</span></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#007700'>:&nbsp;</span></code><code><span=

lang=3DEN-US =
style=3D'font-size:10.0pt;color:#0000BB'>invalid&nbsp;character&nbsp;</sp=
an></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#DD0000'>'_'&nbsp;</span></code><code><sp=
an
lang=3DEN-US style=3D'font-size:10.0pt;color:#0000BB'>in&nbsp;mnemonic =
</span></code><span
lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Courier =
New";color:#0000BB'><br>
<span class=3Dcodenr>&nbsp;</span><code>make</code></span><code><span =
lang=3DEN-US
style=3D'font-size:10.0pt;color:#007700'>[</span></code><code><span =
lang=3DEN-US
style=3D'font-size:10.0pt;color:#0000BB'>1</span></code><code><span =
lang=3DEN-US
style=3D'font-size:10.0pt;color:#007700'>]:&nbsp;***&nbsp;[</span></code>=
<code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#0000BB'>arch</span></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#007700'>/</span></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#0000BB'>x86</span></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#007700'>/</span></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#0000BB'>kernel</span></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#007700'>/</span></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#0000BB'>entry_32</span></code><code><spa=
n
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#007700'>.</span></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#0000BB'>o</span></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#007700'>]&nbsp;</span></code><code><span=

lang=3DEN-US style=3D'font-size:10.0pt;color:#0000BB'>Fehler&nbsp;1 =
</span></code><span
lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Courier =
New";color:#0000BB'><br>
<span class=3Dcodenr>&nbsp;</span><code>make</code></span><code><span =
lang=3DEN-US
style=3D'font-size:10.0pt;color:#007700'>:&nbsp;***&nbsp;[</span></code><=
code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#0000BB'>arch</span></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#007700'>/</span></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#0000BB'>x86</span></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#007700'>/</span></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#0000BB'>kernel</span></code><code><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:#007700'>]&nbsp;</span></code><code><span=

lang=3DEN-US style=3D'font-size:10.0pt;color:#0000BB'>Fehler&nbsp;2 =
</span></code><span
lang=3DEN-US><o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>Have anybody the same problem or =
a solution
to fix the problem?<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>Maybe anyone have experience =
with the Code
Generator from Evidence and newer versions from Xenomai? It is possible =
to use
a newer version?<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>The Evidence wiki and forum is =
down. Maybe
the project is adjusted, so I can not ask some people from Evidence. =
<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>I also searched for =
Kernel-Configs for an
x86 Intel-System (CoreDuo2), please post your experience. =
<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>Another open point is the =
graphical
interface. I search for something like xrtailab or &nbsp;something else. =
<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>Regards,<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>Martin K.<o:p></o:p></span></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

</div>

</body>

</html>

------=_NextPart_000_0001_01CB3336.38D14340--


