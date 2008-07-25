Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8EE71.7212B6AA"
Date: Fri, 25 Jul 2008 18:13:59 +0200
Message-ID: <406CC9939904F143B9D42CEEA3E56E563ABBC9@domain.hid>
From: "Filip Van Rillaer" <Filip.VanRillaer@domain.hid>
Subject: Re: [Xenomai-help] V2.4.4 on blackfin
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

------_=_NextPart_001_01C8EE71.7212B6AA
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

=20
Hello,=20
=20
<<=20

rt_event_wait seems not to work properly if one specifies a timeout :
the functioncall returns after the specified of time, but it returns 0,
instead of -ETIMEDOUT.=20

>>

In the mean time I found the bug : ksrc/skins/native/syscall.c:

the last line of the function __rt_event_wait should be

return err;

instead of

return 0;

Best regards,

Filip


=20


------_=_NextPart_001_01C8EE71.7212B6AA
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.6000.16674" name=3DGENERATOR></HEAD>
<BODY>
<DIV dir=3Dltr align=3Dleft><FONT face=3DArial color=3D#0000ff=20
size=3D2></FONT>&nbsp;</DIV>
<DIV class=3DOutlookMessageHeader lang=3Den-us dir=3Dltr =
align=3Dleft><SPAN=20
class=3D772274310-25072008><FONT face=3DArial><FONT size=3D2>Hello,<SPAN =

class=3D090270816-25072008><FONT=20
color=3D#0000ff>&nbsp;</FONT></SPAN></FONT></FONT></SPAN></DIV>
<DIV class=3DOutlookMessageHeader lang=3Den-us dir=3Dltr =
align=3Dleft><SPAN=20
class=3D772274310-25072008><FONT face=3DArial><FONT size=3D2><SPAN=20
class=3D090270816-25072008></SPAN></FONT></FONT></SPAN>&nbsp;</DIV>
<DIV class=3DOutlookMessageHeader lang=3Den-us dir=3Dltr =
align=3Dleft><SPAN=20
class=3D772274310-25072008><FONT face=3DArial><FONT size=3D2><SPAN=20
class=3D090270816-25072008><FONT=20
color=3D#0000ff>&lt;&lt;</FONT>&nbsp;</SPAN></FONT></FONT></DIV>
<DIV>
<P><FONT face=3DArial size=3D2>rt_event_wait seems not to work =
properly&nbsp;if one=20
specifies a timeout : the functioncall returns after the specified of =
time, but=20
it returns 0, instead of -ETIMEDOUT.<SPAN =
class=3D090270816-25072008><FONT=20
color=3D#0000ff>&nbsp;</FONT></SPAN></FONT></P>
<P><FONT face=3DArial size=3D2><SPAN class=3D090270816-25072008><FONT=20
color=3D#0000ff>&gt;&gt;</FONT></SPAN></FONT></P>
<P><FONT face=3DArial size=3D2><SPAN class=3D090270816-25072008><FONT =
color=3D#0000ff>In=20
the mean time I found the bug :=20
ksrc/skins/native/syscall.c:</FONT></SPAN></FONT></P>
<P><FONT face=3DArial color=3D#0000ff size=3D2><SPAN =
class=3D090270816-25072008>the last=20
line of the function __rt_event_wait should be</SPAN></FONT></P>
<P><FONT face=3DArial color=3D#0000ff size=3D2><SPAN =
class=3D090270816-25072008>return=20
err;</SPAN></FONT></P>
<P><FONT face=3DArial color=3D#0000ff size=3D2><SPAN =
class=3D090270816-25072008>instead=20
of</SPAN></FONT></P>
<P><FONT face=3DArial color=3D#0000ff size=3D2><SPAN =
class=3D090270816-25072008>return=20
0;</SPAN></FONT></P>
<P><FONT face=3DArial color=3D#0000ff size=3D2><SPAN =
class=3D090270816-25072008>Best=20
regards,</SPAN></FONT></P>
<P><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=20
class=3D090270816-25072008>Filip</SPAN></FONT></P>
<P><FONT face=3DArial size=3D2><SPAN class=3D090270816-25072008><FONT=20
color=3D#0000ff></FONT></SPAN><BR>&nbsp;</P></FONT></SPAN></DIV></BODY></=
HTML>

------_=_NextPart_001_01C8EE71.7212B6AA--

