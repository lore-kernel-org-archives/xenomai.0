Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8DC6F.2C2C3B13"
Date: Wed, 2 Jul 2008 14:12:22 -0400
Message-ID: <51B669A8A7D2914E9AB2B3F40AC6553E647061@domain.hid>
References: <51B669A8A7D2914E9AB2B3F40AC6553E647060@domain.hid>
	<486BC042.5030300@domain.hid>
From: "Karch, Joshua" <jkarch@domain.hid>
Subject: Re: [Xenomai-help] remote gdb debugging and Xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C8DC6F.2C2C3B13
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Gilles,

Regarding GDB, from what I saw in README.INSTALL,  I have to get the GDB =
sources and compile a custom version of GDB/GDB server for my target =
machine, right?
I simply apt-get installed gdb on this machine so I don't have a custom =
version.

Also, the Desktop machine has a different version of GDB.  Would I have =
to get a custom version of GDB for the Desktop too?
Is this all based on adding cross-compile support?

Thank you,

Josh


-----Original Message-----
From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
Sent: Wed 7/2/2008 1:52 PM
To: Karch, Joshua
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai-help] remote gdb debugging and Xenomai
=20
Karch, Joshua wrote:
> Hi,
>=20
> I began using GDB to debug rt-tasks in addition to pthreads and I
> found that placing a breakpoint within an RT-Task causes a
> termination of the debug session
>=20
> "Child terminated with signal =3D 5 " is the error I get from =
gdbserver
> on the target device
>=20
> In the Eclipse environment on my non-Xeno desktop, I receive the
> following error: <terminated>gdbserver Debugger (7/2/08 1:27 PM)
> (Exited. Signal 'SIGTRAP' received. Description: Trace/breakpoint
> trap.)
>=20
>=20
> I did some googling and found out I need symbol information available
> to GDB for Xenomai functions (in addition to PThreads). Where can I
> find libraries with the symbols?

Read README.INSTALL

> Is there anything else I need to know to be able to set breakpoints
> within RT- Tasks for debugging?  I haven't used GDB until now, so
> this is still new to me.

The main reason for such kind of errors is not using the same version of
gdb and gdbserver.

--=20
                                                  Gilles.


------_=_NextPart_001_01C8DC6F.2C2C3B13
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
<TITLE>RE: [Xenomai-help] remote gdb debugging and Xenomai</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->
<BR>

<P><FONT SIZE=3D2>Gilles,<BR>
<BR>
Regarding GDB, from what I saw in README.INSTALL,&nbsp; I have to get =
the GDB sources and compile a custom version of GDB/GDB server for my =
target machine, right?<BR>
I simply apt-get installed gdb on this machine so I don't have a custom =
version.<BR>
<BR>
Also, the Desktop machine has a different version of GDB.&nbsp; Would I =
have to get a custom version of GDB for the Desktop too?<BR>
Is this all based on adding cross-compile support?<BR>
<BR>
Thank you,<BR>
<BR>
Josh<BR>
<BR>
<BR>
-----Original Message-----<BR>
From: Gilles Chanteperdrix [<A =
HREF=3D"mailto:gilles.chanteperdrix@xenomai.org">mailto:gilles.chanteperd=
rix@domain.hid</A>]<BR>
Sent: Wed 7/2/2008 1:52 PM<BR>
To: Karch, Joshua<BR>
Cc: xenomai@xenomai.org<BR>
Subject: Re: [Xenomai-help] remote gdb debugging and Xenomai<BR>
<BR>
Karch, Joshua wrote:<BR>
&gt; Hi,<BR>
&gt;<BR>
&gt; I began using GDB to debug rt-tasks in addition to pthreads and =
I<BR>
&gt; found that placing a breakpoint within an RT-Task causes a<BR>
&gt; termination of the debug session<BR>
&gt;<BR>
&gt; &quot;Child terminated with signal =3D 5 &quot; is the error I get =
from gdbserver<BR>
&gt; on the target device<BR>
&gt;<BR>
&gt; In the Eclipse environment on my non-Xeno desktop, I receive =
the<BR>
&gt; following error: &lt;terminated&gt;gdbserver Debugger (7/2/08 1:27 =
PM)<BR>
&gt; (Exited. Signal 'SIGTRAP' received. Description: =
Trace/breakpoint<BR>
&gt; trap.)<BR>
&gt;<BR>
&gt;<BR>
&gt; I did some googling and found out I need symbol information =
available<BR>
&gt; to GDB for Xenomai functions (in addition to PThreads). Where can =
I<BR>
&gt; find libraries with the symbols?<BR>
<BR>
Read README.INSTALL<BR>
<BR>
&gt; Is there anything else I need to know to be able to set =
breakpoints<BR>
&gt; within RT- Tasks for debugging?&nbsp; I haven't used GDB until now, =
so<BR>
&gt; this is still new to me.<BR>
<BR>
The main reason for such kind of errors is not using the same version =
of<BR>
gdb and gdbserver.<BR>
<BR>
--<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; Gilles.<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C8DC6F.2C2C3B13--

