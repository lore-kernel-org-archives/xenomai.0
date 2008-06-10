Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8CA9C.6716DC5B"
Date: Mon, 9 Jun 2008 21:49:55 -0400
Message-ID: <51B669A8A7D2914E9AB2B3F40AC6553E64700F@afsexc01.aurora.aero>
References: <51B669A8A7D2914E9AB2B3F40AC6553E646FC3@domain.hid><2ff1a98a0805290621r361ceb3dh601e41768983fb27@domain.hid><51B669A8A7D2914E9AB2B3F40AC6553E646FC5@domain.hid><2ff1a98a0805290654w33623528yf34c610f11015220@domain.hid><51B669A8A7D2914E9AB2B3F40AC6553E646FC7@domain.hid><2ff1a98a0805290730m2fb0aa02o50c4b317f83aaa00@domain.hid><51B669A8A7D2914E9AB2B3F40AC6553E646FD6@domain.hid><18495.46374.740367.243739@domain.hid><51B669A8A7D2914E9AB2B3F40AC6553E64700A@afsexc01.aurora.aero>
	<18508.1979.979971.360938@domain.hid>
From: "Karch, Joshua" <jkarch@domain.hid>
Subject: Re: [Xenomai-help] Xenomai and SDL NET sockets 1.2
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

------_=_NextPart_001_01C8CA9C.6716DC5B
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Gilles,

since I didn't know how big the stacksize had to be, I decided to put it =
on the heap for now.  It works, but it would be much nicer to put it on =
the stack and make the stack size big enough for next time--

Josh

-----Original Message-----
From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
Sent: Sun 6/8/2008 12:24 PM
To: Karch, Joshua
Cc: xenomai@xenomai.org
Subject: RE: [Xenomai-help] Xenomai and SDL NET sockets 1.2
=20
Karch, Joshua wrote:
 >=20
 > Gilles,
 >=20
 > by the way, I resolved the program by declaring the SDL net sockets =
on the heap.  The socketsets were too big for Xenomai to handle in a =
task, so I declared them in the main and passed them in as parameters =
and everything worked.

There should be no stack size too big for Xenomai. What do you observe
when you ask for a large enough stack size ?

--=20


					    Gilles.


------_=_NextPart_001_01C8CA9C.6716DC5B
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
<TITLE>RE: [Xenomai-help] Xenomai and SDL NET sockets 1.2</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->
<BR>

<P><FONT SIZE=3D2>Gilles,<BR>
<BR>
since I didn't know how big the stacksize had to be, I decided to put it =
on the heap for now.&nbsp; It works, but it would be much nicer to put =
it on the stack and make the stack size big enough for next time--<BR>
<BR>
Josh<BR>
<BR>
-----Original Message-----<BR>
From: Gilles Chanteperdrix [<A =
HREF=3D"mailto:gilles.chanteperdrix@xenomai.org">mailto:gilles.chanteperdri=
x@domain.hid</A>]<BR>
Sent: Sun 6/8/2008 12:24 PM<BR>
To: Karch, Joshua<BR>
Cc: xenomai@xenomai.org<BR>
Subject: RE: [Xenomai-help] Xenomai and SDL NET sockets 1.2<BR>
<BR>
Karch, Joshua wrote:<BR>
&nbsp;&gt;<BR>
&nbsp;&gt; Gilles,<BR>
&nbsp;&gt;<BR>
&nbsp;&gt; by the way, I resolved the program by declaring the SDL net =
sockets on the heap.&nbsp; The socketsets were too big for Xenomai to =
handle in a task, so I declared them in the main and passed them in as =
parameters and everything worked.<BR>
<BR>
There should be no stack size too big for Xenomai. What do you =
observe<BR>
when you ask for a large enough stack size ?<BR>
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
------_=_NextPart_001_01C8CA9C.6716DC5B--

