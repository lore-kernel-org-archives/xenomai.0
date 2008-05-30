Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8C212.4B6247F6"
Date: Fri, 30 May 2008 00:59:35 -0400
Message-ID: <51B669A8A7D2914E9AB2B3F40AC6553E646FD6@domain.hid>
References: <51B669A8A7D2914E9AB2B3F40AC6553E646FC3@domain.hid>
	<2ff1a98a0805290621r361ceb3dh601e41768983fb27@domain.hid>
	<51B669A8A7D2914E9AB2B3F40AC6553E646FC5@domain.hid>
	<2ff1a98a0805290654w33623528yf34c610f11015220@domain.hid>
	<51B669A8A7D2914E9AB2B3F40AC6553E646FC7@domain.hid>
	<2ff1a98a0805290730m2fb0aa02o50c4b317f83aaa00@domain.hid>
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

------_=_NextPart_001_01C8C212.4B6247F6
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Gilles,

I've been given a potential lead in this situation-- stacksize.  What is =
the default stacksize?  This might be the cause of segfaults.

Take care,

Josh

-----Original Message-----
From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
To: Karch, Joshua
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai-help] Xenomai and SDL NET sockets 1.2
=20
On Thu, May 29, 2008 at 3:56 PM, Karch, Joshua <jkarch@domain.hid> =
wrote:
> Gilles,
>
> Any potential problem with MlockAll and dynamically linked in =
libraries?

No.

>
> The standalone, non Xenomai application works with no hitches.  I
> essentially took the main loop from the net comms program and put it =
into an
> RT-Task thread object with minimum (1) priority and now it doesn't =
work.

Since you are able to see the segmentation fault with gdb, why not
using gdb to find the bug ?


--=20
 Gilles



------_=_NextPart_001_01C8C212.4B6247F6
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
I've been given a potential lead in this situation-- stacksize.&nbsp; =
What is the default stacksize?&nbsp; This might be the cause of =
segfaults.<BR>
<BR>
Take care,<BR>
<BR>
Josh<BR>
<BR>
-----Original Message-----<BR>
From: Gilles Chanteperdrix [<A =
HREF=3D"mailto:gilles.chanteperdrix@xenomai.org">mailto:gilles.chanteperdri=
x@domain.hid</A>]<BR>
To: Karch, Joshua<BR>
Cc: xenomai@xenomai.org<BR>
Subject: Re: [Xenomai-help] Xenomai and SDL NET sockets 1.2<BR>
<BR>
On Thu, May 29, 2008 at 3:56 PM, Karch, Joshua =
&lt;jkarch@domain.hid&gt; wrote:<BR>
&gt; Gilles,<BR>
&gt;<BR>
&gt; Any potential problem with MlockAll and dynamically linked in =
libraries?<BR>
<BR>
No.<BR>
<BR>
&gt;<BR>
&gt; The standalone, non Xenomai application works with no =
hitches.&nbsp; I<BR>
&gt; essentially took the main loop from the net comms program and put =
it into an<BR>
&gt; RT-Task thread object with minimum (1) priority and now it doesn't =
work.<BR>
<BR>
Since you are able to see the segmentation fault with gdb, why not<BR>
using gdb to find the bug ?<BR>
<BR>
<BR>
--<BR>
&nbsp;Gilles<BR>
<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C8C212.4B6247F6--

