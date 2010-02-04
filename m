From: "Ivan Kalatchev" <ivan.kalatchev@domain.hid>
Date: Thu, 4 Feb 2010 08:43:00 -0500
Message-ID: <004b01caa59f$f82b2280$e8816780$@kalatchev@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_004C_01CAA576.0F551A80"
Content-Language: en-ca
Subject: [Xenomai-help] Problem compiling 2.5.1
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

------=_NextPart_000_004C_01CAA576.0F551A80
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

I have compiler error when compiling xenomai-2.5.1. Again probably because
my tool chain is outdated - gcc 3.4.4.

 

make[3]: Entering directory
`/mnt/drive-1/build/xenomai-2.5.1/src/skins/native'

/bin/sh ../../../libtool --tag=CC   --mode=compile arm-linux-gcc
-DHAVE_CONFIG_H -I. -I../../../src/include  -O2 -D_GNU_SOURCE -D_REENTRANT
-Wall -pipe -march=armv5 -D__XENO__ -D__IN_XENO__ -Wstrict-prototypes
-I../../../include    -MT libnative_la-timer.lo -MD -MP -MF
.deps/libnative_la-timer.Tpo -c -o libnative_la-timer.lo `test -f 'timer.c'
|| echo './'`timer.c

libtool: compile:  arm-linux-gcc -DHAVE_CONFIG_H -I. -I../../../src/include
-O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -march=armv5 -D__XENO__
-D__IN_XENO__ -Wstrict-prototypes -I../../../include -MT
libnative_la-timer.lo -MD -MP -MF .deps/libnative_la-timer.Tpo -c timer.c
-fPIC -DPIC -o .libs/libnative_la-timer.o

{standard input}: Assembler messages:

{standard input}:102: Error: bad instruction `lsrs sl,r7,#30'

make[3]: *** [libnative_la-timer.lo] Error 1

make[3]: Leaving directory
`/mnt/drive-1/build/xenomai-2.5.1/src/skins/native'

make[2]: *** [all-recursive] Error 1

make[2]: Leaving directory `/mnt/drive-1/build/xenomai-2.5.1/src/skins'

make[1]: *** [all-recursive] Error 1

make[1]: Leaving directory `/mnt/drive-1/build/xenomai-2.5.1/src'

make: *** [all-recursive] Error 1

 

Is there way to modify assembler code so that code would compile ?  

 

Regards,

 

Ivan Kalatchev

Senior Software Developer

ESG Canada Inc.

 

20 Hyperion Court, 

Kingston, ON, Canada

K7K 7K2

Tel: 1 613 548-8287 ext. 247

 


------=_NextPart_000_004C_01CAA576.0F551A80
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
	{font-family:"Arial Unicode MS";
	panose-1:2 11 6 4 2 2 2 2 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@Arial Unicode MS";
	panose-1:2 11 6 4 2 2 2 2 2 4;}
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

<p class=3DMsoNormal>I have compiler error when compiling xenomai-2.5.1. =
Again
probably because my tool chain is outdated - gcc 3.4.4.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>make[3]: Entering directory
`/mnt/drive-1/build/xenomai-2.5.1/src/skins/native'<o:p></o:p></span></p>=


<p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>/bin/sh ../../../libtool =
--tag=3DCC&nbsp;&nbsp;
--mode=3Dcompile arm-linux-gcc -DHAVE_CONFIG_H -I. =
-I../../../src/include&nbsp;
-O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -march=3Darmv5 -D__XENO__
-D__IN_XENO__ -Wstrict-prototypes -I../../../include&nbsp;&nbsp;&nbsp; =
-MT
libnative_la-timer.lo -MD -MP -MF .deps/libnative_la-timer.Tpo -c -o
libnative_la-timer.lo `test -f 'timer.c' || echo =
'./'`timer.c<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>libtool: compile:&nbsp; arm-linux-gcc
-DHAVE_CONFIG_H -I. -I../../../src/include -O2 -D_GNU_SOURCE =
-D_REENTRANT -Wall
-pipe -march=3Darmv5 -D__XENO__ -D__IN_XENO__ -Wstrict-prototypes
-I../../../include -MT libnative_la-timer.lo -MD -MP -MF
.deps/libnative_la-timer.Tpo -c timer.c&nbsp; -fPIC -DPIC -o
.libs/libnative_la-timer.o<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>{standard input}: Assembler =
messages:<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>{standard input}:102: Error: bad instruction =
`lsrs
sl,r7,#30'<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>make[3]: *** [libnative_la-timer.lo] Error =
1<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>make[3]: Leaving directory
`/mnt/drive-1/build/xenomai-2.5.1/src/skins/native'<o:p></o:p></span></p>=


<p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>make[2]: *** [all-recursive] Error =
1<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>make[2]: Leaving directory
`/mnt/drive-1/build/xenomai-2.5.1/src/skins'<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>make[1]: *** [all-recursive] Error =
1<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>make[1]: Leaving directory
`/mnt/drive-1/build/xenomai-2.5.1/src'<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>make: *** [all-recursive] Error =
1<o:p></o:p></span></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Is there way to modify assembler code so that code =
would
compile ? &nbsp;<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Regards,<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;font-family:"Arial","sans-serif"'>Ivan
Kalatchev<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;font-family:"Arial","sans-serif"'>Senior
Software Developer<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;font-family:"Arial","sans-serif"'>ESG
Canada Inc.<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;font-family:"Arial","sans-serif"'><o:p>&nbsp;</=
o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;font-family:"Arial","sans-serif"'>20
Hyperion Court, <o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;font-family:"Arial","sans-serif"'>Kingston,
ON, Canada<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;font-family:"Arial","sans-serif"'>K7K
7K2<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;font-family:"Arial","sans-serif"'>Tel:
1 613 548-8287 ext. 247</span><b><i><o:p></o:p></i></b></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

</div>

</body>

</html>

------=_NextPart_000_004C_01CAA576.0F551A80--


