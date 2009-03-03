From: "Wayne Call" <wcall@domain.hid>
Date: Tue, 3 Mar 2009 11:55:46 -0700
Message-ID: <000001c99c31$aa5d46a0$ff17d3e0$@com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0001_01C99BF6.FDFE6EA0"
Content-Language: en-us
Subject: [Xenomai-help] Segmentation Fault
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
To: "'Xenomai-help@domain.hid'" <xenomai@xenomai.org>

This is a multipart message in MIME format.

------=_NextPart_000_0001_01C99BF6.FDFE6EA0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

When the Xenomai is built, there is a segmentation fault.  What are the
possible scenarios that would cause this error?  There is an "ld terminated
with signal 11" error associated with this fault. 

 

Making all in cyclic

make[3]: Entering directory
`/home/jordanelle/3Star/potomac/Software/magnolia/Kryptic/xenomai-2.3.1/src/
testsuite/cyclic'

/bin/sh ../../../libtool --tag=CC --mode=link bfin-linux-uclibc-gcc     -o
cyclictest
-Wl,@/home/jordanelle/3Star/potomac/Software/magnolia/Kryptic/xenomai-2.3.1/
src/skins/posix/posix.wrappers -D_GNU_SOURCE -D_REENTRANT -Wall -pipe
-mfdpic -mfdpic cyclictest-cyclictest.o ../../skins/posix/libpthread_rt.la
-lpthread -lrt

bfin-linux-uclibc-gcc -o .libs/cyclictest
-Wl,@/home/jordanelle/3Star/potomac/Software/magnolia/Kryptic/xenomai-2.3.1/
src/skins/posix/posix.wrappers -D_GNU_SOURCE -D_REENTRANT -Wall -pipe
-mfdpic -mfdpic cyclictest-cyclictest.o
../../skins/posix/.libs/libpthread_rt.so -lpthread -lrt -Wl,--rpath
-Wl,/usr/xenomai/lib

collect2: ld terminated with signal 11 [Segmentation fault]

/opt/uClinux/bfin-linux-uclibc/lib/gcc/bfin-linux-uclibc/4.1.1/../../../../b
fin-linux-uclibc/bin/ld: make[3]: *** [cyclictest] Error 1

make[3]: Leaving directory
`/home/jordanelle/3Star/potomac/Software/magnolia/Kryptic/xenomai-2.3.1/src/
testsuite/cyclic'

make[2]: *** [all-recursive] Error 1

make[2]: Leaving directory
`/home/jordanelle/3Star/potomac/Software/magnolia/Kryptic/xenomai-2.3.1/src/
testsuite'

make[1]: *** [all-recursive] Error 1

make[1]: Leaving directory
`/home/jordanelle/3Star/potomac/Software/magnolia/Kryptic/xenomai-2.3.1/src'

make: *** [all-recursive] Error 1

 

Wayne

 


------=_NextPart_000_0001_01C99BF6.FDFE6EA0
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

<p class=3DMsoNormal>Hi,<o:p></o:p></p>

<p class=3DMsoNormal>When the Xenomai is built, there is a segmentation
fault.&nbsp; What are the possible scenarios that would cause this =
error?&nbsp;
There is an &#8220;ld terminated with signal 11&#8221; error associated =
with
this fault. <o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Making all in cyclic<o:p></o:p></p>

<p class=3DMsoNormal>make[3]: Entering directory
`/home/jordanelle/3Star/potomac/Software/magnolia/Kryptic/xenomai-2.3.1/s=
rc/testsuite/cyclic'<o:p></o:p></p>

<p class=3DMsoNormal>/bin/sh ../../../libtool --tag=3DCC --mode=3Dlink =
bfin-linux-uclibc-gcc&nbsp;&nbsp;&nbsp;&nbsp;
-o cyclictest
-Wl,@/home/jordanelle/3Star/potomac/Software/magnolia/Kryptic/xenomai-2.3=
.1/src/skins/posix/posix.wrappers
-D_GNU_SOURCE -D_REENTRANT -Wall -pipe -mfdpic -mfdpic =
cyclictest-cyclictest.o
../../skins/posix/libpthread_rt.la -lpthread -lrt<o:p></o:p></p>

<p class=3DMsoNormal>bfin-linux-uclibc-gcc -o .libs/cyclictest
-Wl,@/home/jordanelle/3Star/potomac/Software/magnolia/Kryptic/xenomai-2.3=
.1/src/skins/posix/posix.wrappers
-D_GNU_SOURCE -D_REENTRANT -Wall -pipe -mfdpic -mfdpic
cyclictest-cyclictest.o&nbsp; ../../skins/posix/.libs/libpthread_rt.so
-lpthread -lrt -Wl,--rpath -Wl,/usr/xenomai/lib<o:p></o:p></p>

<p class=3DMsoNormal>collect2: ld terminated with signal 11 =
[Segmentation fault]<o:p></o:p></p>

<p =
class=3DMsoNormal>/opt/uClinux/bfin-linux-uclibc/lib/gcc/bfin-linux-uclib=
c/4.1.1/../../../../bfin-linux-uclibc/bin/ld:
make[3]: *** [cyclictest] Error 1<o:p></o:p></p>

<p class=3DMsoNormal>make[3]: Leaving directory
`/home/jordanelle/3Star/potomac/Software/magnolia/Kryptic/xenomai-2.3.1/s=
rc/testsuite/cyclic'<o:p></o:p></p>

<p class=3DMsoNormal>make[2]: *** [all-recursive] Error 1<o:p></o:p></p>

<p class=3DMsoNormal>make[2]: Leaving directory
`/home/jordanelle/3Star/potomac/Software/magnolia/Kryptic/xenomai-2.3.1/s=
rc/testsuite'<o:p></o:p></p>

<p class=3DMsoNormal>make[1]: *** [all-recursive] Error 1<o:p></o:p></p>

<p class=3DMsoNormal>make[1]: Leaving directory
`/home/jordanelle/3Star/potomac/Software/magnolia/Kryptic/xenomai-2.3.1/s=
rc'<o:p></o:p></p>

<p class=3DMsoNormal>make: *** [all-recursive] Error 1<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Wayne<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

</div>

</body>

</html>

------=_NextPart_000_0001_01C99BF6.FDFE6EA0--


