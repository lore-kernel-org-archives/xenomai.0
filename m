Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8DD11.E3C8D7B2"
Date: Thu, 3 Jul 2008 09:32:10 -0400
Message-ID: <51B669A8A7D2914E9AB2B3F40AC6553E647064@domain.hid>
References: <51B669A8A7D2914E9AB2B3F40AC6553E647060@domain.hid>
	<486BC042.5030300@domain.hid>
	<51B669A8A7D2914E9AB2B3F40AC6553E647061@domain.hid>
	<486BC7AD.3060108@domain.hid>
	<51B669A8A7D2914E9AB2B3F40AC6553E647062@domain.hid>
	<486C811F.2050801@domain.hid>
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

------_=_NextPart_001_01C8DD11.E3C8D7B2
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Gilles,

thank you for your advice with this-- this is my first time using GDB =
outside of the eclipse front end so it will take some time to learn the =
commands.  I appreciate your help with this-- it would be nice to be =
able to visualize and pause the main loops of my RT Tasks, and view =
variables at breakpoints.  Until now I've debugged loop code outside of =
the Xenomai framework before inserting it, or have used printf =
statements with great care(or data logging threads) to surmise if the =
system is working.  So far I've been lucky, but as time goes on it would =
be much better to learn to debug properly.

Cheers,

Josh

-----Original Message-----
From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
Sent: Thu 7/3/2008 3:34 AM
To: Karch, Joshua
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai-help] remote gdb debugging and Xenomai
=20
Karch, Joshua wrote:
> Gilles,
>=20
> so I installed the same version of gdb (6.4.90) which is older but is
> part of the debian distro I am using.  I've tried using gdbserver to
> connect as well as gdb.
>=20
> When I use a version of gdbserver and gdb on the target machine, I
> can debug and set breakpoints without issues on the target machine.
> The Xenomai libraries have the symbols necessary for debugging.=20
> However, on my desktop, I don't have those libraries installed.
>=20
> I'm running eclipse with GDB set to gdbserver Debugger.  I also NFS
> mounted the Xenomai target machine and under the "Shared Libraries"
> of Debug from project properties in Eclipse I included the /lib,
> /usr/lib, and /usr/xenomai/lib directories.  I am using ssh tunneling
> to do "make" and the compile works fine.  I've also tried setting GDB
> to "remote gdb/Mi" through ssh, but I am unable to make that work.
> If I could run gdb over ssh tunneling through Eclipse, all of the
> proper symbols would be loaded, and I would be able to debug
> properly.  I keep getting tunnel errors if I try that method.  My
> only other option is using gdbserver, but that requires me to have
> the same version of gdb on both the Xenomai machine and my desktop,
> plus the libraries.  My issue in this case is I can't get the
> libraries off the Xenomai machine to be loaded by GDB on my desktop
> so I can debug.
>=20
> Any ideas?

I know nothing about eclipse, sorry, after all, this is Xenomai
mailing-list, not eclipse mailing list.
However, what I can tell you is that the best way I have found to work
with gdb on targets, is to use gdb's solib-absolute-prefix.

All you have to do is to install all your packages with full debug
symbols in a staging directory, at the place they will be on the target.
And either use directly this directory via NFS on your target, or
generate another directory where all binaries and libraries are stripped
but at the same place as in the non-stripped staging directory, using
that second directory to generate your target system image. Then, when
running gdb with gdb server do:
set solib-absolute-prefix /path/to/non-stripped/staging/dir
After that, when gdbserver will open a (maybe stripped) file on the
target, gdb will look in the non-stripped staging dir for the same lib
with debug symbols and find it.

I suggest you understand and learn to use gdb without frontends before
using it through frontends, this will let you a lot understanding why
frontends do not work as you would expect.

--=20


					    Gilles.


------_=_NextPart_001_01C8DD11.E3C8D7B2
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
thank you for your advice with this-- this is my first time using GDB =
outside of the eclipse front end so it will take some time to learn the =
commands.&nbsp; I appreciate your help with this-- it would be nice to =
be able to visualize and pause the main loops of my RT Tasks, and view =
variables at breakpoints.&nbsp; Until now I've debugged loop code =
outside of the Xenomai framework before inserting it, or have used =
printf statements with great care(or data logging threads) to surmise if =
the system is working.&nbsp; So far I've been lucky, but as time goes on =
it would be much better to learn to debug properly.<BR>
<BR>
Cheers,<BR>
<BR>
Josh<BR>
<BR>
-----Original Message-----<BR>
From: Gilles Chanteperdrix [<A =
HREF=3D"mailto:gilles.chanteperdrix@xenomai.org">mailto:gilles.chanteperd=
rix@domain.hid</A>]<BR>
Sent: Thu 7/3/2008 3:34 AM<BR>
To: Karch, Joshua<BR>
Cc: xenomai@xenomai.org<BR>
Subject: Re: [Xenomai-help] remote gdb debugging and Xenomai<BR>
<BR>
Karch, Joshua wrote:<BR>
&gt; Gilles,<BR>
&gt;<BR>
&gt; so I installed the same version of gdb (6.4.90) which is older but =
is<BR>
&gt; part of the debian distro I am using.&nbsp; I've tried using =
gdbserver to<BR>
&gt; connect as well as gdb.<BR>
&gt;<BR>
&gt; When I use a version of gdbserver and gdb on the target machine, =
I<BR>
&gt; can debug and set breakpoints without issues on the target =
machine.<BR>
&gt; The Xenomai libraries have the symbols necessary for debugging.<BR>
&gt; However, on my desktop, I don't have those libraries installed.<BR>
&gt;<BR>
&gt; I'm running eclipse with GDB set to gdbserver Debugger.&nbsp; I =
also NFS<BR>
&gt; mounted the Xenomai target machine and under the &quot;Shared =
Libraries&quot;<BR>
&gt; of Debug from project properties in Eclipse I included the =
/lib,<BR>
&gt; /usr/lib, and /usr/xenomai/lib directories.&nbsp; I am using ssh =
tunneling<BR>
&gt; to do &quot;make&quot; and the compile works fine.&nbsp; I've also =
tried setting GDB<BR>
&gt; to &quot;remote gdb/Mi&quot; through ssh, but I am unable to make =
that work.<BR>
&gt; If I could run gdb over ssh tunneling through Eclipse, all of =
the<BR>
&gt; proper symbols would be loaded, and I would be able to debug<BR>
&gt; properly.&nbsp; I keep getting tunnel errors if I try that =
method.&nbsp; My<BR>
&gt; only other option is using gdbserver, but that requires me to =
have<BR>
&gt; the same version of gdb on both the Xenomai machine and my =
desktop,<BR>
&gt; plus the libraries.&nbsp; My issue in this case is I can't get =
the<BR>
&gt; libraries off the Xenomai machine to be loaded by GDB on my =
desktop<BR>
&gt; so I can debug.<BR>
&gt;<BR>
&gt; Any ideas?<BR>
<BR>
I know nothing about eclipse, sorry, after all, this is Xenomai<BR>
mailing-list, not eclipse mailing list.<BR>
However, what I can tell you is that the best way I have found to =
work<BR>
with gdb on targets, is to use gdb's solib-absolute-prefix.<BR>
<BR>
All you have to do is to install all your packages with full debug<BR>
symbols in a staging directory, at the place they will be on the =
target.<BR>
And either use directly this directory via NFS on your target, or<BR>
generate another directory where all binaries and libraries are =
stripped<BR>
but at the same place as in the non-stripped staging directory, =
using<BR>
that second directory to generate your target system image. Then, =
when<BR>
running gdb with gdb server do:<BR>
set solib-absolute-prefix /path/to/non-stripped/staging/dir<BR>
After that, when gdbserver will open a (maybe stripped) file on the<BR>
target, gdb will look in the non-stripped staging dir for the same =
lib<BR>
with debug symbols and find it.<BR>
<BR>
I suggest you understand and learn to use gdb without frontends =
before<BR>
using it through frontends, this will let you a lot understanding =
why<BR>
frontends do not work as you would expect.<BR>
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
------_=_NextPart_001_01C8DD11.E3C8D7B2--

