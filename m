Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8C194.1C843328"
Date: Thu, 29 May 2008 09:56:41 -0400
Message-ID: <51B669A8A7D2914E9AB2B3F40AC6553E646FC7@domain.hid>
References: <51B669A8A7D2914E9AB2B3F40AC6553E646FC3@domain.hid><2ff1a98a0805290621r361ceb3dh601e41768983fb27@domain.hid><51B669A8A7D2914E9AB2B3F40AC6553E646FC5@domain.hid>
	<2ff1a98a0805290654w33623528yf34c610f11015220@domain.hid>
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

------_=_NextPart_001_01C8C194.1C843328
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Gilles,

Any potential problem with MlockAll and dynamically linked in libraries?

The standalone, non Xenomai application works with no hitches.  I =
essentially took the main loop from the net comms program and put it =
into an RT-Task thread object with minimum (1) priority and now it =
doesn't work.

Take care,

Josh

-----Original Message-----
From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
Sent: Thu 5/29/2008 9:54 AM
To: Karch, Joshua
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai-help] Xenomai and SDL NET sockets 1.2
=20
On Thu, May 29, 2008 at 3:49 PM, Karch, Joshua <jkarch@domain.hid> =
wrote:
>
> Gilles,
>
> good thing-- I just got gdb installed and I ended up getting a =
Segmentation
> fault
> 0xb7e38f0d in SDLNet_CheckSockets () from /usr/lib/libSDL_net-1.2.so.0
>
> In my makefile, how would I compile for the posix skin for Xenomai?  I
> haven't explicitly specified a skin.
> I'm using rt_tasks and timers, synchronous messaging, as well as =
message
> queues considerably throughout my application now and don't want to =
lose any
> of that functionality.

I thought that the problem could be due to your application using
Xenomai posix skin services instead of using plain Linux services. But
if you do not compile for xenomai posix skin, this can not happen. So,
the problem is elsewhere.


--=20
 Gilles


------_=_NextPart_001_01C8C194.1C843328
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

<P><FONT SIZE=3D2>Gilles,<BR>
<BR>
Any potential problem with MlockAll and dynamically linked in =
libraries?<BR>
<BR>
The standalone, non Xenomai application works with no hitches.&nbsp; I =
essentially took the main loop from the net comms program and put it =
into an RT-Task thread object with minimum (1) priority and now it =
doesn't work.<BR>
<BR>
Take care,<BR>
<BR>
Josh<BR>
<BR>
-----Original Message-----<BR>
From: Gilles Chanteperdrix [<A =
HREF=3D"mailto:gilles.chanteperdrix@xenomai.org">mailto:gilles.chanteperdri=
x@domain.hid</A>]<BR>
Sent: Thu 5/29/2008 9:54 AM<BR>
To: Karch, Joshua<BR>
Cc: xenomai@xenomai.org<BR>
Subject: Re: [Xenomai-help] Xenomai and SDL NET sockets 1.2<BR>
<BR>
On Thu, May 29, 2008 at 3:49 PM, Karch, Joshua =
&lt;jkarch@domain.hid&gt; wrote:<BR>
&gt;<BR>
&gt; Gilles,<BR>
&gt;<BR>
&gt; good thing-- I just got gdb installed and I ended up getting a =
Segmentation<BR>
&gt; fault<BR>
&gt; 0xb7e38f0d in SDLNet_CheckSockets () from =
/usr/lib/libSDL_net-1.2.so.0<BR>
&gt;<BR>
&gt; In my makefile, how would I compile for the posix skin for =
Xenomai?&nbsp; I<BR>
&gt; haven't explicitly specified a skin.<BR>
&gt; I'm using rt_tasks and timers, synchronous messaging, as well as =
message<BR>
&gt; queues considerably throughout my application now and don't want to =
lose any<BR>
&gt; of that functionality.<BR>
<BR>
I thought that the problem could be due to your application using<BR>
Xenomai posix skin services instead of using plain Linux services. =
But<BR>
if you do not compile for xenomai posix skin, this can not happen. =
So,<BR>
the problem is elsewhere.<BR>
<BR>
<BR>
--<BR>
&nbsp;Gilles<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C8C194.1C843328--

