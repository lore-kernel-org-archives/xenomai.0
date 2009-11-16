Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CA66D0.99C79DC6"
Date: Mon, 16 Nov 2009 09:22:24 -0600
Message-ID: <181804936ABC2349BE503168465576460CBA4A79@domain.hid>
From: "Steve Deiters" <SteveDeiters@domain.hid>
Subject: [Xenomai-help] Killing Xenomai task on kernel shutdown
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

------_=_NextPart_001_01CA66D0.99C79DC6
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Are Xenomai tasks supposed to outlive the kernel?  I have a Xenomai task
that continues to run after the kernel is shut down.
=20
I have a PowerPC board which has an external watchdog.  To keep this
happy I have a periodic Xenomai task that I create early in the kernel
startup with an initcall.  However, when the kernel shuts down I would
like to stop/delete the task so that the watchdog will restart the
processor.  Right now it seems that the task continues to run after
kernel shutdown.  If nothing else I can just manually stop it on
shutdown.
=20
I'm not sure if there's a way to hook into the kernel shutdown.  I have
found the exitcall macros, but they seem to be only used for module
unloading and do not seem to be called on a regular shutdown.  The
initcall is in a board specific startup file.  If possible, I'd like to
keep the task deletion also in the same file.  I just do not know if
there is a hook available for this.
=20
Thanks.

------_=_NextPart_001_01CA66D0.99C79DC6
Content-Type: text/html; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii=
">
<META content=3D"MSHTML 6.00.6000.16809" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D567241015-16112009>Are=
 Xenomai tasks=20
supposed to outlive the kernel?&nbsp; I have a Xenomai task that continu=
es to=20
run after the kernel is shut down.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D567241015-16112009></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D567241015-16112009>I have=
 a PowerPC=20
board which has an external watchdog.&nbsp; To keep this happy I have=
 a periodic=20
Xenomai task that I create early in the kernel startup with an initcall.=
&nbsp;=20
However, when the kernel shuts down I would like to stop/delete&nbsp;the=
 task so=20
that the watchdog will restart the processor.&nbsp; Right now it seems=
 that the=20
task continues to run after kernel shutdown.&nbsp; If nothing else I can=
 just=20
manually stop it on shutdown.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D567241015-16112009></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D567241015-16112009>I'm=
 not sure if=20
there's a way to hook into the kernel shutdown.&nbsp; I have found the=
 exitcall=20
macros, but they seem to be only used for module unloading and do not=
 seem to be=20
called on a regular shutdown.&nbsp; </SPAN></FONT><FONT face=3DArial siz=
e=3D2><SPAN=20
class=3D567241015-16112009>The initcall is in a board specific startup=
 file.&nbsp;=20
If possible, I'd like to keep the task deletion also in the same file.&n=
bsp; I=20
just do not know if there is a hook available for this.</SPAN></FONT></D=
IV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D567241015-16112009></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D567241015-16112009>Thanks.</SPAN></FONT></DIV></BODY></HTML>

------_=_NextPart_001_01CA66D0.99C79DC6--


