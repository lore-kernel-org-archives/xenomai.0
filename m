Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6EE60.23445835"
Date: Thu, 12 Oct 2006 17:40:10 -0700
Message-ID: <FA9961D07FD27B4EB6058C0F35F3D0D124112A@CSGMX.es.xeroxlabs.com>
From: "Chau, Ngaiman" <Ngaiman.Chau@domain.hid>
Subject: [Xenomai-core] Build problems with xenomai PPC vxworks skin for
	target TQM8555 board
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
Cc: "Chau, Ngaiman" <Ngaiman.Chau@domain.hid>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6EE60.23445835
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Dear Xenomai,

           =20

I am currently trying to run Xenomai vxWork skins on PPC  MPC8555
target board(TQM8555) and has run into problems can anyone   help on the
subjects.

           =20

I am using  the following software release:

    Linux version 2.6.18-rc2;=20

   ELDK from Denx PPC Linux x86 Target PPC (FSL) Release 4.0
(2006-01-11);

  U-Boot 1.1.4-gd10afb39 (Aug 11 2006 - 12:27:28) and=20

              //svn.gna.org/daily/xenomai-snapshot.tar.gz

        With  adeos-ipipe-2.6.18-rc7-ppc-1.3-07-pre.patch from Denx

The Hardware Platform I am using is TQM8555 PPC starter kit

=20

=20

NFSbooting results:=20

>    ## Booting image at 00200000 ...

>    Image Name:   Linux-2.6.18-rc2

>    Created:      2006-10-11  18:28:46 UTC

>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)

>    Data Size:    1306095 Bytes =3D  1.2 MB

>    Load Address: 00000000

>    Entry Point:  00000000

>    Verifying Checksum ... OK

>    Uncompressing Kernel Image ... OK

>    Memory CAM mapping: CAM0=3D256Mb, CAM1=3D0Mb, CAM2=3D0Mb residual: =
0Mb =20

> ...

>   Xenomai: hal/powerpc started.

>   Xenomai: real-time nucleus v2.3-devel  (Baroque) loaded.=20

>   Xenomai: starting native API service

>   Xenomai: starting POSIX services.

>   Xenomai: starting RTDM services.

>   Xenomai: starting VxWorks services.

> ...=20

> bash-3.00# cd /home/nchau/xenomai

> bash-3.00# export LD_LIBRARY_PATH=3D/home/nchau/xenomai/lib

> bash-3.00# cd /home/nchau/xenomai/vxworks/app

=20

> bash-3.00# ./satch

> Now playing Surfing With The Alien...

> sz=3D=3D -1

> Now playing Lords of Karma...

> Now playing Banana Mango...

> Now playing Flying In

> Now playing Ride...

> sz=3D=3D -1

=20

  Question 1)

>     The Satch runs ok except the size return from the msqQRecive() is=20

> always -1, not sure why? (vxwork api size return should be the number
of bytes

> received)

=20

> Question 2)

>     I try and proceed to add the Koan.c file to the Makefile, however,


> it runs into compilation error even thought I add the main() and=20

> RootTask as in Satch.c does.

> [root@domain.hid xenomai]# cd /temp/Denx1/xenomai/ksrc/skins/vxworks/demos

> [root@domain.hid demos]# export DESTDIR=3D/temp/Denx1/eldk/ppc_85xx=20

> [root@domain.hid demos]# export PATH=3D$PATH:$DESTDIR/home/nchau/xenomai/bin

> [root@domain.hid demos]# export CC=3D`xeno-config --cc` =20

> [root@domain.hid demos]# make clean

>   rm -f -f *.o *_sim.o satch  koan satch_sim koan_sim

> [root@domain.hid demos]# make

>  ppc-linux-gcc -o satch satch.c -I.

> -I/temp/Denx1/eldk/ppc_85xx/home/nchau/xenomai/include -O2=20

> -D_GNU_SOURCE -D_REENTRANT -D__XENO__ -Wall -pipe=20

> -L/temp/Denx1/eldk/ppc_85xx/home/nchau/xenomai/lib -lpthread -rdynamic


> -lvxworks ppc-linux-gcc -o koan koan.c -I.

> -I/temp/Denx1/eldk/ppc_85xx/home/nchau/xenomai/include -O2=20

> -D_GNU_SOURCE -D_REENTRANT -D__XENO__ -Wall -pipe=20

> -L/temp/Denx1/eldk/ppc_85xx/home/nchau/xenomai/lib -lpthread -rdynamic


> -lvxworks -lnative

> koan.c: In function 'usrClock':

> koan.c:132: warning: implicit declaration of function 'tickAnnounce'

> koan.c: In function 'koan_sysClkInit':

> koan.c:144: warning: implicit declaration of function 'sysClkConnect'

> /tmp/cc3GdKes.o: In function `usrClock':

> koan.c:(.text+0x258): undefined reference to `tickAnnounce'

> /tmp/cc3GdKes.o: In function `koan_sysClkInit':

> koan.c:(.text+0x2a4): undefined reference to `sysClkConnect'

> collect2: ld returned 1 exit status

> make: *** [koan] Error 1

=20

 Can anyone shed some light to why that happened,  Koan.c is  from the
vxworks skin demo directory that come with the xenomai package.

=20

Thx

Ngaiman

=20

=20


------_=_NextPart_001_01C6EE60.23445835
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered)">

<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:PMingLiU;
	panose-1:2 2 3 0 0 0 0 0 0 0;}
@font-face
	{font-family:"\@PMingLiU";
	panose-1:2 2 3 0 0 0 0 0 0 0;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
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
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";}
span.EmailStyle17
	{font-family:Arial;
	color:windowtext;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Dear Xenomai,</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;
</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I am currently trying to run Xenomai vxWork skins on =
PPC
&nbsp;MPC8555 &nbsp;target board(TQM8555) and has run into problems can =
anyone
&nbsp;&nbsp;help on the subjects.</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;
</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I am using &nbsp;the following software =
release:</span></font></p>

<p class=3DMsoNormal style=3D'text-indent:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;Linu=
x
version 2.6.18-rc2; </span></font></p>

<p class=3DMsoNormal style=3D'text-indent:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;</span></f=
ont><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-family:"Courier New"'>ELDK
from Denx PPC Linux x86 Target PPC (FSL) Release 4.0 =
(2006-01-11);</span></font></p>

<p class=3DMsoNormal style=3D'text-indent:.5in'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;</span></font><font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;U-Boot
1.1.4-gd10afb39 (Aug 11 2006 - 12:27:28) and </span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;
&nbsp;</span></font>&nbsp;//svn.gna.org/daily/xenomai-snapshot.tar.gz</p>=


<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; With
&nbsp;adeos-ipipe-2.6.18-rc7-ppc-1.3-07-pre.patch from =
Denx</span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>The Hardware Platform I am using is TQM8555 PPC starter =
kit</span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&nbsp;</span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>NFSbooting results: </span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&gt;&nbsp;&nbsp;&nbsp; ## Booting image at =
00200000
...</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&gt;&nbsp;&nbsp;&nbsp; Image =
Name:&nbsp;&nbsp;
Linux-2.6.18-rc2</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&gt;&nbsp;&nbsp;&nbsp;
Created:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2006-10-11&nbsp; 18:28:46 =
UTC</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&gt;&nbsp;&nbsp;&nbsp; Image =
Type:&nbsp;&nbsp;
PowerPC Linux Kernel Image (gzip compressed)</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&gt;&nbsp;&nbsp;&nbsp; Data =
Size:&nbsp;&nbsp;&nbsp;
1306095 Bytes =3D&nbsp; 1.2 MB</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&gt;&nbsp;&nbsp;&nbsp; Load Address: =
00000000</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&gt;&nbsp;&nbsp;&nbsp; Entry Point:&nbsp; =
00000000</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&gt;&nbsp;&nbsp;&nbsp; Verifying Checksum ... =
OK</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&gt;&nbsp;&nbsp;&nbsp; Uncompressing Kernel =
Image
... OK</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&gt;&nbsp;&nbsp;&nbsp; Memory CAM mapping:
CAM0=3D256Mb, CAM1=3D0Mb, CAM2=3D0Mb residual: 0Mb&nbsp; =
</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&gt; ...</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&gt;&nbsp;&nbsp; Xenomai: hal/powerpc =
started.</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&gt;&nbsp;&nbsp; Xenomai: real-time nucleus
v2.3-devel&nbsp; (Baroque) loaded. </span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&gt;&nbsp;&nbsp; Xenomai: starting native API
service</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&gt;&nbsp;&nbsp; Xenomai: starting POSIX =
services.</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&gt;&nbsp;&nbsp; Xenomai: starting RTDM =
services.</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&gt;&nbsp;&nbsp; Xenomai: starting VxWorks =
services.</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&gt; ... </span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&gt; bash-3.00# cd =
/home/nchau/xenomai</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&gt; bash-3.00# export =
LD_LIBRARY_PATH=3D/home/nchau/xenomai/lib</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&gt; bash-3.00# cd =
/home/nchau/xenomai/vxworks/app</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&gt; bash-3.00# ./satch</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&gt; Now playing Surfing With The =
Alien...</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&gt; sz=3D=3D -1</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&gt; Now playing Lords of =
Karma...</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&gt; Now playing Banana =
Mango...</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&gt; Now playing Flying In</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&gt; Now playing Ride...</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&gt; sz=3D=3D -1</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&nbsp;&nbsp;Question 1)</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&gt; &nbsp;&nbsp;&nbsp; The Satch runs ok =
except the
size return from the msqQRecive() is </span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&gt; always -1, not sure why? (vxwork api =
size
return should be the number of bytes</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&gt; received)</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&gt; Question 2)</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&gt; &nbsp;&nbsp;&nbsp; I try and proceed to =
add the
Koan.c file to the Makefile, however, </span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&gt; it runs into compilation error even =
thought I
add the main() and </span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&gt; RootTask as in Satch.c =
does.</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&gt; [root@domain.hid xenomai]# cd
/temp/Denx1/xenomai/ksrc/skins/vxworks/demos</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&gt; [root@domain.hid demos]# export =
DESTDIR=3D/temp/Denx1/eldk/ppc_85xx
</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&gt; [root@domain.hid demos]# export
PATH=3D$PATH:$DESTDIR/home/nchau/xenomai/bin</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DPT-BR
style=3D'font-size:10.0pt;font-family:"Courier New"'>&gt; [root@domain.hid =
demos]#
export CC=3D`xeno-config --cc`&nbsp; </span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&gt; [root@domain.hid demos]# make =
clean</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&gt; &nbsp;&nbsp;rm -f -f *.o *_sim.o =
satch&nbsp;
koan satch_sim koan_sim</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&gt; [root@domain.hid demos]# =
make</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&gt; &nbsp;ppc-linux-gcc -o satch satch.c =
-I.</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&gt;
-I/temp/Denx1/eldk/ppc_85xx/home/nchau/xenomai/include -O2 =
</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&gt; -D_GNU_SOURCE -D_REENTRANT -D__XENO__ =
-Wall
-pipe </span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&gt;
-L/temp/Denx1/eldk/ppc_85xx/home/nchau/xenomai/lib -lpthread -rdynamic =
</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&gt; -lvxworks ppc-linux-gcc -o koan koan.c =
-I.</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&gt;
-I/temp/Denx1/eldk/ppc_85xx/home/nchau/xenomai/include -O2 =
</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&gt; -D_GNU_SOURCE -D_REENTRANT -D__XENO__ =
-Wall
-pipe </span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&gt;
-L/temp/Denx1/eldk/ppc_85xx/home/nchau/xenomai/lib -lpthread -rdynamic =
</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&gt; -lvxworks -lnative</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&gt; koan.c: In function =
'usrClock':</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&gt; koan.c:132: warning: implicit =
declaration of
function 'tickAnnounce'</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&gt; koan.c: In function =
'koan_sysClkInit':</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&gt; koan.c:144: warning: implicit =
declaration of
function 'sysClkConnect'</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&gt; /tmp/cc3GdKes.o: In function =
`usrClock':</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&gt; koan.c:(.text+0x258): undefined =
reference to
`tickAnnounce'</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&gt; /tmp/cc3GdKes.o: In function =
`koan_sysClkInit':</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&gt; koan.c:(.text+0x2a4): undefined =
reference to
`sysClkConnect'</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&gt; collect2: ld returned 1 exit =
status</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&gt; make: *** [koan] Error =
1</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&nbsp;Can anyone shed some light to why that
happened, &nbsp;Koan.c is &nbsp;from the &nbsp;vxworks skin demo =
directory that
come with the xenomai package.</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>Thx</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>Ngaiman</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C6EE60.23445835--

