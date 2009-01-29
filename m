Message-ID: <CDD78C600C124BCC853CDDDEEDDB1749@domain.hid>
From: "newsgroup" <newsgroup@domain.hid>
Date: Thu, 29 Jan 2009 11:24:31 +0100
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0014_01C98204.27E09700"
Subject: [Xenomai-help] rt_pipe_read returns -ENOBUFS
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

------=_NextPart_000_0014_01C98204.27E09700
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,

ive got an userspace process running in realtime and try to communicate =
to another process unsing the Pipes.
rt_pipe_write() to the non realtime process works fine. ich can read the =
/dev/rtp1 without problems.

Now i try to write from this process to the realtime process using the =
/dev/rtp2.
The rt_pipe_read() returns a -ENOBUFS.

here the call (dirty copy):=20

struct struct_FIFO_Header {
 unsigned short ID;
 unsigned short Size;
 };

struct_FIFO_Header _Header;
   =20
ret =3D rt_pipe_read(&pipe_read,&_Header,sizeof(_Header),TM_NONBLOCK );

ret is now -ENOBUFS

Ive done similar the same using rtai without problems.
anone an idea why it occours?

Greets
  Maveric



------=_NextPart_000_0014_01C98204.27E09700
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.6000.16788" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>Hello,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>ive got an userspace process running in =
realtime=20
and try to communicate to another process unsing the Pipes.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>rt_pipe_write()&nbsp;to the non =
realtime process=20
works fine. ich can read the /dev/rtp1 without problems.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Now i try to write from this process to =
the=20
realtime process using the /dev/rtp2.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>The rt_pipe_read() returns a =
-ENOBUFS.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>here the call (dirty copy): =
</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>struct =
struct_FIFO_Header&nbsp;{<BR>&nbsp;unsigned=20
short ID;<BR>&nbsp;unsigned short Size;<BR>&nbsp;};<BR></FONT></DIV>
<DIV><FONT face=3DArial =
size=3D2>struct_FIFO_Header&nbsp;_Header;</DIV></FONT>
<DIV><FONT face=3DArial size=3D2>&nbsp;&nbsp;&nbsp; </DIV></FONT>
<DIV><FONT face=3DArial size=3D2>ret =3D=20
rt_pipe_read(&amp;pipe_read,&amp;_Header,sizeof(_Header),TM_NONBLOCK=20
);</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>ret is now -ENOBUFS</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>
<DIV><FONT face=3DArial size=3D2>Ive done similar the same using rtai =
without=20
problems.</FONT></DIV></FONT></DIV>
<DIV><FONT face=3DArial size=3D2>anone an idea why it =
occours?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Greets</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp; Maveric</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV></BODY></HTML>

------=_NextPart_000_0014_01C98204.27E09700--


