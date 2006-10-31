Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6FCE4.7DC3F0ED"
Date: Tue, 31 Oct 2006 12:02:51 -0000
Message-ID: <DD39B5C3F4963040ADC9768BE7E430CB0144D625@domain.hid>
From: "Daniel Schnell" <daniel.schnell@domain.hid>
Subject: [Xenomai-help] Xenoami Kernel Configuration Description
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

------_=_NextPart_001_01C6FCE4.7DC3F0ED
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,
=20
I would like to contribute the Xenomai Kernel configuration help
documentation and therefore will ask here a lot of annoying questions
probably.
=20
I am working to port an existing pSoS application to the POSIX Xenomai
Skin. Unfortunately the application so far works much better on NPTL
threads under a 2.6.17 based Kernel (without rt capability) than on the
Xenomai enabled 2.4.25 Denx PPC Kernel for our MPC5200B based board
where we have Kernel Oopses and lockups. I think my understanding of the
Xenomai principles and limitations is not far enough to be able to
understand the problems that we are facing here so I would like to start
with the basics: the Xenomai kernel configuration and the meaning of all
options.
Some of these are self explanatory but most of them not. Especially I am
interested about the magic number tuning options like heap size, number
of registry slots, number of pipe devices etc. and how they correlate to
the behaviour or limitations of the other parts.
=20
Is there any documentation already available ?
=20
=20
Daniel.

------_=_NextPart_001_01C6FCE4.7DC3F0ED
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.2963" name=3DGENERATOR></HEAD>
<BODY>
<DIV><SPAN class=3D008153911-31102006><FONT face=3DArial=20
size=3D2>Hi,</FONT></SPAN></DIV>
<DIV><SPAN class=3D008153911-31102006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D008153911-31102006><SPAN =
class=3D008153911-31102006><FONT=20
face=3DArial size=3D2>I&nbsp;would like to contribute the Xenomai Kernel =

configuration help documentation and therefore will ask here a lot of =
annoying=20
questions probably.</FONT></SPAN></SPAN></DIV>
<DIV><SPAN class=3D008153911-31102006><SPAN =
class=3D008153911-31102006><FONT=20
face=3DArial size=3D2></FONT></SPAN></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D008153911-31102006><SPAN =
class=3D008153911-31102006><FONT=20
face=3DArial size=3D2>I am working to port an existing pSoS application =
to the POSIX=20
Xenomai Skin. Unfortunately the application so far&nbsp;works much =
better on=20
NPTL threads under a 2.6.17 based Kernel (without rt capability) than on =
the=20
Xenomai enabled 2.4.25 Denx PPC Kernel for our MPC5200B based board =
where we=20
have Kernel Oopses and lockups. I think my understanding of the Xenomai=20
principles and limitations is not far enough to be able to understand =
the=20
problems that we are facing here so&nbsp;I would like to start with the =
basics:=20
the Xenomai kernel configuration and the meaning of all=20
options.</FONT></SPAN></SPAN></DIV>
<DIV><SPAN class=3D008153911-31102006><FONT face=3DArial size=3D2>Some =
of=20
these&nbsp;are self explanatory but most of them not. Especially I am =
interested=20
about the magic number tuning options like heap size, number of registry =
slots,=20
number of pipe devices etc. and how they correlate to the behaviour or=20
limitations of the other parts.</FONT></SPAN></DIV>
<DIV><SPAN class=3D008153911-31102006><FONT face=3DArial =
size=3D2></FONT></SPAN><SPAN=20
class=3D008153911-31102006><FONT face=3DArial =
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D008153911-31102006><FONT face=3DArial size=3D2>Is =
there any=20
documentation already available ?</FONT></SPAN></DIV>
<DIV><SPAN class=3D008153911-31102006></SPAN><SPAN =
class=3D008153911-31102006><FONT=20
face=3DArial size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D008153911-31102006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D008153911-31102006><FONT face=3DArial=20
size=3D2>Daniel.</FONT></SPAN></DIV></BODY></HTML>

------_=_NextPart_001_01C6FCE4.7DC3F0ED--

