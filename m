Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CA753C.943B2182"
Date: Fri, 4 Dec 2009 17:50:40 -0600
Message-ID: <181804936ABC2349BE503168465576460CFD20DE@exchserver.basler.com>
From: "Steve Deiters" <SteveDeiters@domain.hid>
Subject: [Xenomai-help] xeno-config --xeno-ldflags does not add -lnative
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

------_=_NextPart_001_01CA753C.943B2182
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

When I run the command mentioned in the subject, it does not include a
switch for -lnative.  I have to add this to the LDFLAGS in my Makefile
manually in order to link.  Is this expected or do I just have something
configured wrong?  The output I get is:
=20
"-L/usr/xenomai/lib -lpthread"
=20
I am using the xeno-config that comes with Xenomai 2.4.10.
=20
Thanks.
=20
=20

------_=_NextPart_001_01CA753C.943B2182
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii=
">
<META content=3D"MSHTML 6.00.6000.16809" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D808334623-04122009>When=
 I run the=20
command mentioned in the subject, it does not include a switch for=20
-lnative.&nbsp; I have to add this to the LDFLAGS in my Makefile manuall=
y in=20
order to link.&nbsp; Is this expected or do I just have something config=
ured=20
wrong?&nbsp; The output I get is:</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D808334623-04122009></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D808334623-04122009>"-L/us=
r/xenomai/lib=20
-lpthread"</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D808334623-04122009></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D808334623-04122009>I am=
 using the=20
xeno-config that comes with Xenomai 2.4.10.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D808334623-04122009></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D808334623-04122009>Thanks.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D808334623-04122009></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D808334623-04122009></SPAN></FONT>&nbsp;</DIV></BODY></HTML>

------_=_NextPart_001_01CA753C.943B2182--


