Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C70A74.67F1F50D"
Date: Fri, 17 Nov 2006 18:15:47 -0000
Message-ID: <DD39B5C3F4963040ADC9768BE7E430CB015D4828@domain.hid>
From: "Daniel Schnell" <daniel.schnell@domain.hid>
Subject: [Xenomai-help] VM killer
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

------_=_NextPart_001_01C70A74.67F1F50D
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,
=20
I know this is somewhat not related to Xenomai. But as I encountered
this while actually testing the memory allocation with Xenomai, maybe
there is some common sense here, as there are many people having to do
with embedded systems, where something like that matters.
=20
Everytime the system comes to its limits and some process uses up all
the memory the vm systems kills (more or less randomly) one or more
processes. Even system processes. I would really like to get rid of this
behaviour, but having disabled CONFIG_OOM_KILLER inside the linux kernel
doesn't help.
=20
I use ELDK4.0 with 2.4.25 Denx Kernel.
=20
Any hints ?
=20
=20
Best regards,
=20
Daniel.

------_=_NextPart_001_01C70A74.67F1F50D
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.2963" name=3DGENERATOR></HEAD>
<BODY>
<DIV><SPAN class=3D755580218-17112006><FONT face=3DArial=20
size=3D2>Hi,</FONT></SPAN></DIV>
<DIV><SPAN class=3D755580218-17112006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D755580218-17112006><FONT face=3DArial =
size=3D2>I&nbsp;know this is=20
somewhat not related&nbsp;to Xenomai. But as I encountered this while =
actually=20
testing the memory allocation with Xenomai, maybe there is some common =
sense=20
here, as there are&nbsp;many people having to do with&nbsp;embedded =
systems,=20
where something like that matters.</FONT></SPAN></DIV>
<DIV><SPAN class=3D755580218-17112006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D755580218-17112006><FONT face=3DArial =
size=3D2>Everytime the system=20
comes to its limits and some process uses up all the memory the vm =
systems kills=20
(more or less randomly) one or more processes. Even system processes. I =
would=20
really like to get rid of this behaviour, but having disabled =
CONFIG_OOM_KILLER=20
inside the linux kernel doesn't help.</FONT></SPAN></DIV>
<DIV><SPAN class=3D755580218-17112006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D755580218-17112006><FONT face=3DArial size=3D2>I use =
ELDK4.0 with=20
2.4.25 Denx Kernel.</FONT></SPAN></DIV>
<DIV><SPAN class=3D755580218-17112006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D755580218-17112006><FONT face=3DArial size=3D2>Any =
hints=20
?</FONT></SPAN></DIV>
<DIV><SPAN class=3D755580218-17112006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D755580218-17112006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D755580218-17112006><FONT face=3DArial size=3D2>Best=20
regards,</FONT></SPAN></DIV>
<DIV><SPAN class=3D755580218-17112006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D755580218-17112006><FONT face=3DArial=20
size=3D2>Daniel.</FONT></SPAN></DIV></BODY></HTML>

------_=_NextPart_001_01C70A74.67F1F50D--

