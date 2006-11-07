Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C70272.AE142F27"
Date: Tue, 7 Nov 2006 13:43:16 -0000
Message-ID: <DD39B5C3F4963040ADC9768BE7E430CB014DEFC4@domain.hid>
From: "Daniel Schnell" <daniel.schnell@domain.hid>
Subject: [Xenomai-help] RT-SocketCan + Xenomai on MPC5200B
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

------_=_NextPart_001_01C70272.AE142F27
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,
=20
I am struggling with Xenomai latest SVN and RT-Socket-CAN on a MPC5200B
with MSCAN driver inside a Denx 2.4.25 kernel.
=20
Does anybody have this configuration actively running ? How do you use
the provided rtcansend/rtcanreceive functions, so they actually transfer
data over the wires ?
=20
I was doing the following:
rtcanconfig rtcan0 -b 125000 start
rtcansend rtcan0 -i 0 0x1 0x0
(returns)
rtcansend rtcan0 -i 0x1 0x0
(hangs, never comes back)
=20
=20
Actually the first rtcansend command does not seem to work, because a
connected CAN IO unit doesn't show any reaction.
=20
=20
Any ideas ?
=20
Regards,
=20
Daniel Schnell.

------_=_NextPart_001_01C70272.AE142F27
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.2963" name=3DGENERATOR></HEAD>
<BODY>
<DIV><SPAN class=3D290353413-07112006><FONT face=3DArial=20
size=3D2>Hi,</FONT></SPAN></DIV>
<DIV><SPAN class=3D290353413-07112006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D290353413-07112006><FONT face=3DArial size=3D2>I am =
struggling with=20
Xenomai latest SVN and RT-Socket-CAN on a MPC5200B with MSCAN =
driver&nbsp;inside=20
a Denx 2.4.25 kernel.</FONT></SPAN></DIV>
<DIV><SPAN class=3D290353413-07112006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D290353413-07112006><FONT face=3DArial size=3D2>Does =
anybody have=20
this configuration actively running ? How do you use the provided=20
rtcansend/rtcanreceive functions, so they actually transfer data over =
the wires=20
?</FONT></SPAN></DIV>
<DIV><SPAN class=3D290353413-07112006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D290353413-07112006><FONT face=3DArial size=3D2>I was =
doing the=20
following:</FONT></SPAN></DIV>
<DIV><SPAN class=3D290353413-07112006><FONT face=3DArial =
size=3D2>rtcanconfig rtcan0=20
-b 125000 start</FONT></SPAN></DIV>
<DIV><SPAN class=3D290353413-07112006><FONT face=3DArial =
size=3D2>rtcansend rtcan0 -i=20
0 0x1 0x0</FONT></SPAN></DIV>
<DIV><SPAN class=3D290353413-07112006><FONT face=3DArial=20
size=3D2>(returns)</FONT></SPAN></DIV>
<DIV><SPAN class=3D290353413-07112006><FONT face=3DArial =
size=3D2>rtcansend rtcan0 -i=20
0x1 0x0</FONT></SPAN></DIV>
<DIV><SPAN class=3D290353413-07112006><FONT face=3DArial =
size=3D2>(hangs, never comes=20
back)</FONT></SPAN></DIV>
<DIV><SPAN class=3D290353413-07112006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D290353413-07112006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D290353413-07112006><FONT face=3DArial =
size=3D2>Actually the first=20
rtcansend command does not seem to work, because a connected CAN IO unit =
doesn't=20
show any reaction.</FONT></SPAN></DIV>
<DIV><SPAN class=3D290353413-07112006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D290353413-07112006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D290353413-07112006><FONT face=3DArial size=3D2>Any =
ideas=20
?</FONT></SPAN></DIV>
<DIV><SPAN class=3D290353413-07112006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D290353413-07112006><FONT face=3DArial=20
size=3D2>Regards,</FONT></SPAN></DIV>
<DIV><SPAN class=3D290353413-07112006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D290353413-07112006><FONT face=3DArial size=3D2>Daniel =

Schnell.</FONT></SPAN></DIV></BODY></HTML>

------_=_NextPart_001_01C70272.AE142F27--

