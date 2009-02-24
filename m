From: "Wayne Call" <wcall@domain.hid>
Date: Tue, 24 Feb 2009 10:15:09 -0700
Message-ID: <004601c996a3$723e7020$56bb5060$@com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0047_01C99668.C5DF9820"
Content-Language: en-us
Subject: [Xenomai-help] xenomai build
Reply-To: wcall@domain.hid
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

This is a multipart message in MIME format.

------=_NextPart_000_0047_01C99668.C5DF9820
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

I have the source for Xenomai in the folder:

xenomai-2.3.1

 

I have xenomai folders within the Linux source in the following folders:

include

kernel

drivers,

include/asm-generic

include/asm-blackfin

include/asm

arch/blackfin

 

When I execute a make for a user application, I get the following error:

"cannot find -lnative"

 

The LDFLAGS in the Makefile is the following:

LDFLAGS =  -L$(XENOMAI_ROOT)/lib/  -lnative  -lpthread  -lrtdm  -lm

 

The xenomai-2.3.1/build/src/skins/native folder does not have the
libnative.la file, and other similar files.  What build process do I need to
execute to recreate the .la, .o, .lo, and other similar files?  Or is there
something else I'm missing?

 

Wayne

 


------=_NextPart_000_0047_01C99668.C5DF9820
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
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
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
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
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

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal>I have the source for Xenomai in the =
folder:<o:p></o:p></p>

<p class=3DMsoNormal>xenomai-2.3.1<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>I have xenomai folders within the Linux source in =
the
following folders:<o:p></o:p></p>

<p class=3DMsoNormal>include<o:p></o:p></p>

<p class=3DMsoNormal>kernel<o:p></o:p></p>

<p class=3DMsoNormal>drivers,<o:p></o:p></p>

<p class=3DMsoNormal>include/asm-generic<o:p></o:p></p>

<p class=3DMsoNormal>include/asm-blackfin<o:p></o:p></p>

<p class=3DMsoNormal>include/asm<o:p></o:p></p>

<p class=3DMsoNormal>arch/blackfin<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>When I execute a make for a user application, I get =
the
following error:<o:p></o:p></p>

<p class=3DMsoNormal>&#8220;cannot find =
&#8211;lnative&#8221;<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>The LDFLAGS in the Makefile is the =
following:<o:p></o:p></p>

<p class=3DMsoNormal>LDFLAGS =3D &nbsp;-L$(XENOMAI_ROOT)/lib/&nbsp; =
-lnative&nbsp;
-lpthread&nbsp; -lrtdm&nbsp; -lm<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>The xenomai-2.3.1/build/src/skins/native folder =
does not
have the libnative.la file, and other similar files.&nbsp; What build =
process
do I need to execute to recreate the .la, .o, .lo, and other similar
files?&nbsp; Or is there something else I&#8217;m =
missing?<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Wayne<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

</div>

</body>

</html>

------=_NextPart_000_0047_01C99668.C5DF9820--


