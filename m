Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C70EF8.7D939E28"
Date: Thu, 23 Nov 2006 12:11:21 -0000
Message-ID: <DD39B5C3F4963040ADC9768BE7E430CB015D51BC@is-hdq-exchange.marel.net>
From: "Daniel Schnell" <daniel.schnell@domain.hid>
Subject: [Xenomai-help] RTCAN: multiple sockets on one device
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

------_=_NextPart_001_01C70EF8.7D939E28
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,
=20
If one opens two sockets to one CAN port and wants to use one socket
file descriptor for reading and the other for writing, is it possible to
limit the writing socket to _write only_, so it doesn't receive messages
?
=20
Background: if using this kind of approach, both sockets will get a copy
of the received data. So the writing only socket gets a receive buffer
overflow, because it doesn't read the data from the socket. If one could
somehow set this socket to a write only state, the buffer overflow would
probably not happen.
=20
Best regards,
=20
Daniel.

------_=_NextPart_001_01C70EF8.7D939E28
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.2963" name=3DGENERATOR></HEAD>
<BODY>
<DIV><SPAN class=3D181015711-23112006><FONT face=3DArial=20
size=3D2>Hi,</FONT></SPAN></DIV>
<DIV><SPAN class=3D181015711-23112006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D181015711-23112006><FONT face=3DArial size=3D2>If one =
opens two=20
sockets to one&nbsp;CAN port and wants to use one socket file descriptor =
for=20
reading and the other for writing, is it possible to limit the writing =
socket to=20
_write only_, so it doesn't receive messages ?</FONT></SPAN></DIV>
<DIV><SPAN class=3D181015711-23112006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D181015711-23112006><FONT face=3DArial =
size=3D2>Background: if using=20
this kind of approach, both sockets will get a copy of the received =
data. So the=20
writing only socket gets a&nbsp;receive&nbsp;buffer overflow, because it =
doesn't=20
read the data from the socket. If one could somehow set this socket to a =
write=20
only state, the buffer overflow would probably not =
happen.</FONT></SPAN></DIV>
<DIV><SPAN class=3D181015711-23112006><FONT face=3DArial =
size=3D2></FONT></SPAN><SPAN=20
class=3D181015711-23112006><FONT face=3DArial =
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D181015711-23112006><FONT face=3DArial size=3D2>Best=20
regards,</FONT></SPAN></DIV>
<DIV><SPAN class=3D181015711-23112006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D181015711-23112006><FONT face=3DArial=20
size=3D2>Daniel.</FONT></SPAN></DIV></BODY></HTML>

------_=_NextPart_001_01C70EF8.7D939E28--

