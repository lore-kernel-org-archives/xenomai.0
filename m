Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C746D0.A3DCDA8F"
Subject: AW: [Xenomai-help] rt_dev_open() returns -EBUSY
Date: Fri, 2 Feb 2007 14:47:11 +0100
Message-ID: <AD78122AD7C05B4B936EBAD7F49738C0AB2B9A@square.bfh.ch>
In-Reply-To: <AD78122AD7C05B4B936EBAD7F49738C0AB2B99@domain.hid>
References: <AD78122AD7C05B4B936EBAD7F49738C0AB2B99@domain.hid>
From: "Lauener Nathan" <Nathan.Lauener@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Lauener Nathan <Nathan.Lauener@domain.hid>
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C746D0.A3DCDA8F
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,
=20
I solved the problem. I had to recompile the kernel with "local APCI on
uniprocessor" enabled.=20
Now I have an other problem. As soon as I open a parallel port device my
system slows down dramatically, even without really using the opened
driver. Any ideas are welcome.=20
=20
Nathan

________________________________

Von: xenomai-help-bounces@domain.hid [mailto:xenomai-help-bounces@domain.hid]
Im Auftrag von Lauener Nathan
Gesendet: Freitag, 2. Februar 2007 11:22
An: xenomai@xenomai.org
Betreff: [Xenomai-help] rt_dev_open() returns -EBUSY



Hi,=20

A couple of days ago I updated my system from Xenomai 2.2.0 and kernel
2.6.17.8 to Xenomai 2.3.0 and kernel 2.6.19.2. Everything worked well
until I tried to open my driver for the parallel port. The function
rt_dev_open() always returns -EBUSY even after loading the module and
trying to open the device for the first time. I had been using the
driver for several weeks without any problems and havn't touched the
code. Any hints?

Regards=20
Nathan =20


------_=_NextPart_001_01C746D0.A3DCDA8F
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD><TITLE>rt_dev_open() returns -EBUSY</TITLE>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.3020" name=3DGENERATOR></HEAD>
<BODY>
<DIV dir=3Dltr align=3Dleft><FONT face=3DArial color=3D#0000ff =
size=3D2><SPAN=20
class=3D790404113-02022007>Hi,</SPAN></FONT></DIV>
<DIV dir=3Dltr align=3Dleft><FONT face=3DArial color=3D#0000ff =
size=3D2><SPAN=20
class=3D790404113-02022007></SPAN></FONT>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><FONT face=3DArial color=3D#0000ff =
size=3D2><SPAN=20
class=3D790404113-02022007>I solved the problem. I had to recompile the =
kernel=20
with "local APCI on uniprocessor" enabled. </SPAN></FONT></DIV>
<DIV dir=3Dltr align=3Dleft><FONT face=3DArial color=3D#0000ff =
size=3D2><SPAN=20
class=3D790404113-02022007>Now I have an other problem. As soon as =
I&nbsp;open a=20
parallel port device my system&nbsp;slows&nbsp;down dramatically, even =
without=20
really using the opened&nbsp;driver. Any ideas&nbsp;are=20
welcome.&nbsp;</SPAN></FONT></DIV>
<DIV dir=3Dltr align=3Dleft><FONT face=3DArial color=3D#0000ff =
size=3D2><SPAN=20
class=3D790404113-02022007></SPAN></FONT>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><FONT face=3DArial color=3D#0000ff =
size=3D2><SPAN=20
class=3D790404113-02022007>Nathan</SPAN></FONT></DIV><BR>
<DIV class=3DOutlookMessageHeader lang=3Dde dir=3Dltr align=3Dleft>
<HR tabIndex=3D-1>
<FONT face=3DTahoma size=3D2><B>Von:</B> xenomai-help-bounces@domain.hid
[mailto:xenomai-help-bounces@domain.hid] <B>Im Auftrag von </B>Lauener=20
Nathan<BR><B>Gesendet:</B> Freitag, 2. Februar 2007 11:22<BR><B>An:</B>=20
xenomai@xenomai.org<BR><B>Betreff:</B> [Xenomai-help] rt_dev_open() =
returns=20
-EBUSY<BR></FONT><BR></DIV>
<DIV></DIV><!-- Converted from text/rtf format -->
<P><FONT face=3DArial size=3D2>Hi,</FONT> </P>
<P><FONT face=3DArial size=3D2>A couple of days ago I updated my system =
from Xenomai=20
2.2.0 and kernel 2.6.17.8 to Xenomai 2.3.0 and kernel 2.6.19.2. =
Everything=20
worked well until I tried to open my driver for the parallel port. The =
function=20
rt_dev_open() always returns -EBUSY even after loading the module and =
trying to=20
open the device for the first time. I had been using the driver for =
several=20
weeks without any problems and havn't touched the code. Any =
hints?</FONT></P>
<P><FONT face=3DArial size=3D2>Regards</FONT> <BR><FONT face=3DArial=20
size=3D2>Nathan&nbsp; </FONT></P></BODY></HTML>

------_=_NextPart_001_01C746D0.A3DCDA8F--

