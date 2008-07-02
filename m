Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8DC96.1EE51F98"
Date: Wed, 2 Jul 2008 18:51:10 -0400
Message-ID: <51B669A8A7D2914E9AB2B3F40AC6553E647062@domain.hid>
References: <51B669A8A7D2914E9AB2B3F40AC6553E647060@domain.hid>
	<486BC042.5030300@domain.hid>
	<51B669A8A7D2914E9AB2B3F40AC6553E647061@domain.hid>
	<486BC7AD.3060108@domain.hid>
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

------_=_NextPart_001_01C8DC96.1EE51F98
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Gilles,

so I installed the same version of gdb (6.4.90) which is older but is =
part of the debian distro I am using.  I've tried using gdbserver to =
connect as well as gdb.

When I use a version of gdbserver and gdb on the target machine, I can =
debug and set breakpoints without issues on the target machine.  The =
Xenomai libraries have the symbols necessary for debugging. =20
However, on my desktop, I don't have those libraries installed.

I'm running eclipse with GDB set to gdbserver Debugger.  I also NFS =
mounted the Xenomai target machine and under the "Shared Libraries" of =
Debug from project properties in Eclipse I included the /lib, /usr/lib, =
and /usr/xenomai/lib directories.  I am using ssh tunneling to do "make" =
and the compile works fine.  I've also tried setting GDB to "remote =
gdb/Mi" through ssh, but I am unable to make that work.  If I could run =
gdb over ssh tunneling through Eclipse, all of the proper symbols would =
be loaded, and I would be able to debug properly.  I keep getting tunnel =
errors if I try that method.  My only other option is using gdbserver, =
but that requires me to have the same version of gdb on both the Xenomai =
machine and my desktop, plus the libraries.  My issue in this case is I =
can't get the libraries off the Xenomai machine to be loaded by GDB on =
my desktop so I can debug.

Any ideas?

Thank you,

Josh

-----Original Message-----
From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
Sent: Wed 7/2/2008 2:23 PM
To: Karch, Joshua
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai-help] remote gdb debugging and Xenomai
=20
Karch, Joshua wrote:
> Gilles,
>=20
> Regarding GDB, from what I saw in README.INSTALL,  I have to get the
> GDB sources and compile a custom version of GDB/GDB server for my
> target machine, right?

I was referring to Xenomai README.INSTALL explaining how to enable debug
symbols in Xenomai libraries.

 I simply apt-get installed gdb on this machine
> so I don't have a custom version.

The problem is that if you have gdb 6.5 on the host and gdbserver 6.4 on
the target it will not work. You have to use exactly the same version.

--=20


					    Gilles.


------_=_NextPart_001_01C8DC96.1EE51F98
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
so I installed the same version of gdb (6.4.90) which is older but is =
part of the debian distro I am using.&nbsp; I've tried using gdbserver =
to connect as well as gdb.<BR>
<BR>
When I use a version of gdbserver and gdb on the target machine, I can =
debug and set breakpoints without issues on the target machine.&nbsp; =
The Xenomai libraries have the symbols necessary for =
debugging.&nbsp;<BR>
However, on my desktop, I don't have those libraries installed.<BR>
<BR>
I'm running eclipse with GDB set to gdbserver Debugger.&nbsp; I also NFS =
mounted the Xenomai target machine and under the &quot;Shared =
Libraries&quot; of Debug from project properties in Eclipse I included =
the /lib, /usr/lib, and /usr/xenomai/lib directories.&nbsp; I am using =
ssh tunneling to do &quot;make&quot; and the compile works fine.&nbsp; =
I've also tried setting GDB to &quot;remote gdb/Mi&quot; through ssh, =
but I am unable to make that work.&nbsp; If I could run gdb over ssh =
tunneling through Eclipse, all of the proper symbols would be loaded, =
and I would be able to debug properly.&nbsp; I keep getting tunnel =
errors if I try that method.&nbsp; My only other option is using =
gdbserver, but that requires me to have the same version of gdb on both =
the Xenomai machine and my desktop, plus the libraries.&nbsp; My issue =
in this case is I can't get the libraries off the Xenomai machine to be =
loaded by GDB on my desktop so I can debug.<BR>
<BR>
Any ideas?<BR>
<BR>
Thank you,<BR>
<BR>
Josh<BR>
<BR>
-----Original Message-----<BR>
From: Gilles Chanteperdrix [<A =
HREF=3D"mailto:gilles.chanteperdrix@xenomai.org">mailto:gilles.chanteperd=
rix@domain.hid</A>]<BR>
Sent: Wed 7/2/2008 2:23 PM<BR>
To: Karch, Joshua<BR>
Cc: xenomai@xenomai.org<BR>
Subject: Re: [Xenomai-help] remote gdb debugging and Xenomai<BR>
<BR>
Karch, Joshua wrote:<BR>
&gt; Gilles,<BR>
&gt;<BR>
&gt; Regarding GDB, from what I saw in README.INSTALL,&nbsp; I have to =
get the<BR>
&gt; GDB sources and compile a custom version of GDB/GDB server for =
my<BR>
&gt; target machine, right?<BR>
<BR>
I was referring to Xenomai README.INSTALL explaining how to enable =
debug<BR>
symbols in Xenomai libraries.<BR>
<BR>
&nbsp;I simply apt-get installed gdb on this machine<BR>
&gt; so I don't have a custom version.<BR>
<BR>
The problem is that if you have gdb 6.5 on the host and gdbserver 6.4 =
on<BR>
the target it will not work. You have to use exactly the same =
version.<BR>
<BR>
--<BR>
<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =
Gilles.<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C8DC96.1EE51F98--

