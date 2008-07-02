Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8DC6B.BB15025C"
Date: Wed, 2 Jul 2008 13:47:43 -0400
Message-ID: <51B669A8A7D2914E9AB2B3F40AC6553E647060@domain.hid>
From: "Karch, Joshua" <jkarch@domain.hid>
Subject: [Xenomai-help] remote gdb debugging and Xenomai
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

------_=_NextPart_001_01C8DC6B.BB15025C
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hi,

I began using GDB to debug rt-tasks in addition to pthreads and I found =
that placing a breakpoint within an RT-Task causes a termination of the =
debug session

"Child terminated with signal =3D 5 " is the error I get from gdbserver =
on the target device

In the Eclipse environment on my non-Xeno desktop, I receive the =
following error:
<terminated>gdbserver Debugger (7/2/08 1:27 PM) (Exited. Signal =
'SIGTRAP' received. Description: Trace/breakpoint trap.)=09


I did some googling and found out I need symbol information available to =
GDB for Xenomai functions (in addition to PThreads). Where can I find =
libraries with the symbols?  Is there anything else I need to know to be =
able to set breakpoints within RT- Tasks for debugging?  I haven't used =
GDB until now, so this is still new to me.

Thank you,

Joshua Karch.


------_=_NextPart_001_01C8DC6B.BB15025C
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7651.59">
<TITLE>remote gdb debugging and Xenomai</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->
<BR>

<P><FONT SIZE=3D2>Hi,<BR>
<BR>
I began using GDB to debug rt-tasks in addition to pthreads and I found =
that placing a breakpoint within an RT-Task causes a termination of the =
debug session<BR>
<BR>
&quot;Child terminated with signal =3D 5 &quot; is the error I get from =
gdbserver on the target device<BR>
<BR>
In the Eclipse environment on my non-Xeno desktop, I receive the =
following error:<BR>
&lt;terminated&gt;gdbserver Debugger (7/2/08 1:27 PM) (Exited. Signal =
'SIGTRAP' received. Description: Trace/breakpoint =
trap.)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
<BR>
<BR>
I did some googling and found out I need symbol information available to =
GDB for Xenomai functions (in addition to PThreads). Where can I find =
libraries with the symbols?&nbsp; Is there anything else I need to know =
to be able to set breakpoints within RT- Tasks for debugging?&nbsp; I =
haven't used GDB until now, so this is still new to me.<BR>
<BR>
Thank you,<BR>
<BR>
Joshua Karch.<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C8DC6B.BB15025C--

