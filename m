Message-ID: <SNT119-W494F38A017E8C5258B4B21B0FB0@domain.hid>
Content-Type: multipart/alternative;
	boundary="_a5b070fb-94f6-446b-ad98-60c23835baa6_"
From: federico lolli <federicololli@domain.hid>
Date: Wed, 12 May 2010 15:00:52 +0200
MIME-Version: 1.0
Subject: [Xenomai-help] xenomai test problem
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

--_a5b070fb-94f6-446b-ad98-60c23835baa6_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


 Hi all=2CI'm trying to install Xenomai on ARM sam9g20.
I compiled the kernel with Xenomai patch and create the filesystem with bui=
ldroot.
crosscompiling Xenomai with these commands:

fede@domain.hid$ ./configure --host=3Darm-linux-=
gnueabi --enable-arm-eabi --enable-arm-mach=3Dat91sam9 --disable-arm-tsc --=
enable-static
make DESTDIR=3D/home/fede/foxg20/kernel/l/ install
I copy the file in the arm-filesystem
but when I try to run / usr / Xenomai / bin
for example=2C the file latency
get:
./latency
-sh: ./latency:not found
any suggestions?

Federico Lolli
Tel:+39  3476802428
E-mail: federicololli@domain.hid
web: www.federicololli.com


 		 	   		 =20
_________________________________________________________________
Importa i tuoi amici di Facebook su Messenger
http://www.windowslive.it/importaAmici.aspx=

--_a5b070fb-94f6-446b-ad98-60c23835baa6_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px=3B
padding:0px
}
body.hmmessage
{
font-size: 10pt=3B
font-family:Verdana
}
--></style>
</head>
<body class=3D'hmmessage'>
<pre> Hi all=2C</pre><span id=3D"result_box" class=3D"short_text"><span sty=
le=3D"" title=3D"">I'm trying to install Xenomai on ARM sam9g20.<br></span>=
</span><span id=3D"result_box" class=3D"short_text"><span style=3D"backgrou=
nd-color: rgb(235=2C 239=2C 249)=3B" title=3D"">I compiled the kernel with =
Xenomai patch and create the filesystem with buildroot.<br></span></span><s=
pan id=3D"result_box" class=3D"short_text"><span style=3D"" title=3D"">cros=
scompiling Xenomai with these commands</span></span>:<br><br>fede@domain.hid=
op:~/Scrivania/xenomai-2.5.3$ ./configure --host=3Darm-linux-gnueabi --enab=
le-arm-eabi --enable-arm-mach=3Dat91sam9 --disable-arm-tsc --enable-static<=
br>make DESTDIR=3D/home/fede/foxg20/kernel/l/ install<br><span id=3D"result=
_box" class=3D"short_text"><span style=3D"background-color: rgb(235=2C 239=
=2C 249)=3B" title=3D"">I copy the file in the arm-filesystem<br></span></s=
pan><span id=3D"result_box" class=3D"short_text"><span style=3D"background-=
color: rgb(235=2C 239=2C 249)=3B" title=3D"">but when I try to run / usr / =
Xenomai / bin<br></span></span><span id=3D"result_box" class=3D"short_text"=
><span style=3D"background-color: rgb(235=2C 239=2C 249)=3B" title=3D"">for=
 example=2C the file latency<br>get:<br>./latency<br>-sh: ./latency:not fou=
nd<br></span></span><span id=3D"result_box" class=3D"short_text"><span styl=
e=3D"" title=3D"">any suggestions?<br><br></span></span>Federico Lolli<br>T=
el:+39&nbsp=3B 3476802428<br>E-mail: federicololli@domain.hid<br>web: www.=
federicololli.com<br><br><br> 		 	   		  <br /><hr />Un mondo di personaliz=
zazioni <a href=3D'http://www.pimpit.it/' target=3D'_new'>per Messenger=2C =
PC e cellulare</a></body>
</html>=

--_a5b070fb-94f6-446b-ad98-60c23835baa6_--

