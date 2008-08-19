Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C90217.B0FB3F54"
Date: Tue, 19 Aug 2008 18:21:52 +0200
Message-ID: <406CC9939904F143B9D42CEEA3E56E56431F57@domain.hid>
From: "Filip Van Rillaer" <Filip.VanRillaer@domain.hid>
Subject: [Xenomai-help] uClinux write to pipe returning -ENOMEM
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

------_=_NextPart_001_01C90217.B0FB3F54
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,
=20
I am opening the uClinux side of a Xenomai pipe like (so in blocking
mode):
FdPipe =3D open(PipeName, O_RDWR);
After some writes to FdPipe I get the returnvalue -ENOMEM.
I can understand that the internal buffer gets full as my application is
writing data faster than the Xenomai side is consuming, but I don't
expect to see a returnvalue -ENOMEM : the calling writing-thread should
block, isn't it?  Please comment.
=20
(When adding the O_SYNC flag things get even worse)
=20
Why is the code for xnpipe_write saying:
if (!mh)=20
  /* Cannot sleep. */   <--- ???????????????????
  return -ENOMEM;
=20
I am using svn version 4105.
=20
Best regards,
Filip

------_=_NextPart_001_01C90217.B0FB3F54
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.6000.16705" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D804051116-19082008>Hello,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D804051116-19082008></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D804051116-19082008>I am =
opening the=20
uClinux side of a Xenomai&nbsp;pipe&nbsp;like (so in blocking=20
mode):</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D804051116-19082008>FdPipe =
=3D=20
open(PipeName, O_RDWR);</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D804051116-19082008>After =
some writes to=20
FdPipe I get the returnvalue -ENOMEM.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D804051116-19082008>I can =
understand=20
that the internal buffer gets full as my application is writing data =
faster than=20
the Xenomai side is consuming, but I don't expect to see a returnvalue =
-ENOMEM :=20
the calling writing-thread should block, isn't it?&nbsp; Please=20
comment.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D804051116-19082008></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D804051116-19082008>(When =
adding the=20
O_SYNC flag things get even worse)</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D804051116-19082008></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D804051116-19082008>Why is =
the code for=20
xnpipe_write saying:</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D804051116-19082008>if =
(!mh)=20
</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D804051116-19082008>&nbsp; =
/* Cannot=20
sleep. */&nbsp;&nbsp; &lt;--- ???????????????????</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D804051116-19082008>&nbsp; =
return=20
-ENOMEM;</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D804051116-19082008></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D804051116-19082008>I am =
using=20
svn&nbsp;version 4105.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D804051116-19082008></SPAN></FONT><FONT=20
face=3DArial size=3D2><SPAN =
class=3D804051116-19082008></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D804051116-19082008>Best=20
regards,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D804051116-19082008>Filip</SPAN></FONT></DIV></BODY></HTML>

------_=_NextPart_001_01C90217.B0FB3F54--

