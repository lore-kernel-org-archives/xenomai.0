Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8C644.65B5C9DF"
Date: Wed, 4 Jun 2008 15:10:44 +0200
Message-ID: <E5E9C6CC7DC8844A8DA7A9EFE7B5350E025B28C5@domain.hid>
From: "Markus Osterried" <markus.osterried@domain.hid>
Subject: [Xenomai-core] system hangs with "ifconfig eth0 down"
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai-core@domain.hid

This is a multi-part message in MIME format.

------_=_NextPart_001_01C8C644.65B5C9DF
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,
=20
I am using Xenomai with pSOS-skin.
The application and the whole system crashes when I call the following
statement from a pSOS-thread:
=20
system("ifconfig eth0 down");
=20
Any other call to system(), e.g. system("ls") works fine.
On the other hand, if I call "ifconfig eth0 down" from a shell outside
the Xenomai-application, it works also fine.
=20
I have reduced the whole application to only one pSOS-thread which only
call system(), it crashes.
If I call system() in the main() function before creating/starting the
pSOS-thread, it works fine.
=20
Anybody any idea why this call to system() doesn't work from inside the
application?
=20
Thanks.
=20
Markus
=20

------_=_NextPart_001_01C8C644.65B5C9DF
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2800.1595" name=3DGENERATOR></HEAD>
<BODY>
<DIV><SPAN class=3D784154312-04062008><FONT face=3DArial=20
size=3D2>Hi,</FONT></SPAN></DIV>
<DIV><SPAN class=3D784154312-04062008><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D784154312-04062008><FONT face=3DArial size=3D2>I =
am&nbsp;using=20
Xenomai with pSOS-skin.</FONT></SPAN></DIV>
<DIV><SPAN class=3D784154312-04062008><FONT face=3DArial =
size=3D2>The&nbsp;application=20
and the whole system crashes when I&nbsp;call the following statement =
from a=20
pSOS-thread:</FONT></SPAN></DIV>
<DIV><SPAN class=3D784154312-04062008><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D784154312-04062008><FONT face=3DArial =
size=3D2>system("ifconfig=20
eth0 down");</FONT></SPAN></DIV>
<DIV><SPAN class=3D784154312-04062008><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D784154312-04062008><FONT face=3DArial size=3D2>Any =
other call to=20
system(), e.g. system("ls") works fine.</FONT></SPAN></DIV>
<DIV><SPAN class=3D784154312-04062008><FONT face=3DArial size=3D2>On the =
other hand,=20
if I&nbsp;call "ifconfig eth0 down" from a shell outside the=20
Xenomai-application, it works also fine.</FONT></SPAN></DIV>
<DIV><SPAN class=3D784154312-04062008><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D784154312-04062008><FONT face=3DArial size=3D2>I have =
reduced the=20
whole application to only one pSOS-thread which only call system(), it=20
crashes.</FONT></SPAN></DIV>
<DIV><SPAN class=3D784154312-04062008><FONT face=3DArial size=3D2>If I =
call system()=20
in the main() function before creating/starting the pSOS-thread, it =
works=20
fine.</FONT></SPAN></DIV>
<DIV><SPAN class=3D784154312-04062008><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D784154312-04062008><FONT face=3DArial size=3D2>
<DIV><SPAN class=3D784154312-04062008><FONT face=3DArial =
size=3D2>Anybody any idea=20
why&nbsp;this call to system() doesn't work from inside the=20
application?</FONT></SPAN></DIV>
<DIV><SPAN class=3D784154312-04062008></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D784154312-04062008>Thanks.</SPAN></DIV>
<DIV><SPAN class=3D784154312-04062008></SPAN><SPAN=20
class=3D784154312-04062008></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D784154312-04062008>Markus</SPAN></DIV>
<DIV></FONT></SPAN><FONT face=3DArial=20
size=3D2></FONT>&nbsp;</DIV></DIV></BODY></HTML>

------_=_NextPart_001_01C8C644.65B5C9DF--

