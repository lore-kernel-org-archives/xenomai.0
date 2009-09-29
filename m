Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CA4155.C2BF361B"
Date: Tue, 29 Sep 2009 17:39:50 -0500
Message-ID: <181804936ABC2349BE503168465576460C477B17@domain.hid>
From: "Steve Deiters" <SteveDeiters@domain.hid>
Subject: [Xenomai-help] Supressing kernel ring messages on standard output
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

------_=_NextPart_001_01CA4155.C2BF361B
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I am running a program with Xenomai and using the POSIX skin.  When the
program exits, I get messages from the kernel ring buffer on the
terminal, such as:
"Xenomai: Posix: destroying mutex df9c1000".
=20
This is interfering with data the program is also printing.  Is there=
 a
way to disable or redirect this?
=20
I am using an embedded PowerPC evaluation board with kernel 2.6.24.6 and
Xenomai 2.4.9.1 and the terminal is through a serial port if that makes
a difference.
=20
Thanks.

------_=_NextPart_001_01CA4155.C2BF361B
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii=
">
<META content=3D"MSHTML 6.00.6000.16809" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D410053622-29092009>I am=
 running a=20
program with Xenomai and using the POSIX skin.&nbsp; When the program=
 exits, I=20
get messages from the kernel ring buffer on the terminal, such=20
as:</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D410053622-29092009>"Xenom=
ai: Posix:=20
destroying mutex df9c1000".</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D410053622-29092009></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D410053622-29092009>This=
 is interfering=20
with data the program is also printing.&nbsp; Is there a way to disable=
 or=20
redirect this?</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D410053622-29092009></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D410053622-29092009>I am=
 using an=20
embedded&nbsp;PowerPC evaluation board with kernel 2.6.24.6 and Xenomai=
 2.4.9.1=20
and the terminal is through a serial port if that makes a=20
difference.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D410053622-29092009></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D410053622-29092009>Thanks.</SPAN></FONT></DIV></BODY></HTML>

------_=_NextPart_001_01CA4155.C2BF361B--


