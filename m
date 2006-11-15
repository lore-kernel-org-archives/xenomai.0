Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C708A9.0D6ED20D"
Date: Wed, 15 Nov 2006 11:27:36 -0000
Message-ID: <DD39B5C3F4963040ADC9768BE7E430CB0154EEEB@is-hdq-exchange.marel.net>
From: "Daniel Schnell" <daniel.schnell@domain.hid>
Subject: [Xenomai-help] pthread_setname_np
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

------_=_NextPart_001_01C708A9.0D6ED20D
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,
=20
this function does not change the name inside /proc/xenomai/stat or
sched for user space Posix threads. As I understand the other function
pthread_attr_setname_np() is only valid (and available) for Kernel level
threads.
=20
Is there any way that works correctly to name a thread to something
different than simply the executable name ?
=20
=20
Best regards,
=20
Daniel Schnell.

------_=_NextPart_001_01C708A9.0D6ED20D
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.2963" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D789072111-15112006>Hi,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D789072111-15112006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D789072111-15112006>this =
function does=20
not change the name inside /proc/xenomai/stat or sched for user space =
Posix=20
threads. As I understand the other function pthread_attr_setname_np() is =
only=20
valid (and available) for Kernel level threads.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D789072111-15112006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D789072111-15112006>Is =
there any way=20
that works correctly to name a thread to something different =
than&nbsp;simply=20
the executable name ?</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D789072111-15112006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D789072111-15112006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D789072111-15112006>Best=20
regards,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D789072111-15112006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D789072111-15112006>Daniel =

Schnell.</SPAN></FONT></DIV></BODY></HTML>

------_=_NextPart_001_01C708A9.0D6ED20D--

