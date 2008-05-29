Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8C192.C6ACA90E"
Date: Thu, 29 May 2008 09:49:12 -0400
Message-ID: <51B669A8A7D2914E9AB2B3F40AC6553E646FC5@domain.hid>
References: <51B669A8A7D2914E9AB2B3F40AC6553E646FC3@domain.hid>
	<2ff1a98a0805290621r361ceb3dh601e41768983fb27@domain.hid>
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

------_=_NextPart_001_01C8C192.C6ACA90E
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Gilles,

good thing-- I just got gdb installed and I ended up getting a =
Segmentation fault
0xb7e38f0d in SDLNet_CheckSockets () from /usr/lib/libSDL_net-1.2.so.0

In my makefile, how would I compile for the posix skin for Xenomai?  I =
haven't explicitly specified a skin. =20
I'm using rt_tasks and timers, synchronous messaging, as well as message =
queues considerably throughout my application now and don't want to lose =
any of that functionality.

Would MlockAll cause a problem potentially?  It appears to be using a =
dynamic library.

The error appears to occur in this snippet of code

	int numready =3D SDLNet_CheckSockets(socketSet,0);
	if( numready =3D=3D -1 )
	{
		printf("SDLNet_CheckSockets: %s",SDLNet_GetError());
		return -1;
	}

Thank you,

Josh





-----Original Message-----
From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
Sent: Thu 5/29/2008 9:21 AM
To: Karch, Joshua
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai-help] Xenomai and SDL NET sockets 1.2
=20
On Thu, May 29, 2008 at 5:44 AM, Karch, Joshua <jkarch@domain.hid> =
wrote:
>
> To whom it may concern::
> we are interested in merging our real-time tasks with Xenomai with a
> low-priority RT_TASK that uses SDL-NET to communicate from real-time =
tasks
> over ethernet. Unfortunately, running an RT_TASK with SDL-NET seems to =
have
> caused a tough-to-identify segmentation fault.

What does gdb say ?

>  The problem I am having is
> that I have been asked to add another team-member's non-realtime work =
which
> uses networking sockets within a low-priority RT Task.  That code uses =
SDL
> NET 1.2
>
> Is it possible to use SDL NET for TCP/IP communication within an =
RT-Task, or
> is it typically difficult to adapt a program communicating over TCP/IP =
into
> RTnet?

First you have to make sure that your program use the services it
think it uses. Do you compile your application for the posix skin ?
Does this SDL NET (library I assume) come as a dynamic shared object ?
or as a static archive ?

--=20
 Gilles


------_=_NextPart_001_01C8C192.C6ACA90E
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
good thing-- I just got gdb installed and I ended up getting a =
Segmentation fault<BR>
0xb7e38f0d in SDLNet_CheckSockets () from =
/usr/lib/libSDL_net-1.2.so.0<BR>
<BR>
In my makefile, how would I compile for the posix skin for =
Xenomai?&nbsp; I haven't explicitly specified a skin.&nbsp;<BR>
I'm using rt_tasks and timers, synchronous messaging, as well as message =
queues considerably throughout my application now and don't want to lose =
any of that functionality.<BR>
<BR>
Would MlockAll cause a problem potentially?&nbsp; It appears to be using =
a dynamic library.<BR>
<BR>
The error appears to occur in this snippet of code<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int numready =3D =
SDLNet_CheckSockets(socketSet,0);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if( numready =3D=3D -1 )<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
printf(&quot;SDLNet_CheckSockets: %s&quot;,SDLNet_GetError());<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -1;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
<BR>
Thank you,<BR>
<BR>
Josh<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
-----Original Message-----<BR>
From: Gilles Chanteperdrix [<A =
HREF=3D"mailto:gilles.chanteperdrix@xenomai.org">mailto:gilles.chanteperdri=
x@domain.hid</A>]<BR>
Sent: Thu 5/29/2008 9:21 AM<BR>
To: Karch, Joshua<BR>
Cc: xenomai@xenomai.org<BR>
Subject: Re: [Xenomai-help] Xenomai and SDL NET sockets 1.2<BR>
<BR>
On Thu, May 29, 2008 at 5:44 AM, Karch, Joshua =
&lt;jkarch@domain.hid&gt; wrote:<BR>
&gt;<BR>
&gt; To whom it may concern::<BR>
&gt; we are interested in merging our real-time tasks with Xenomai with =
a<BR>
&gt; low-priority RT_TASK that uses SDL-NET to communicate from =
real-time tasks<BR>
&gt; over ethernet. Unfortunately, running an RT_TASK with SDL-NET seems =
to have<BR>
&gt; caused a tough-to-identify segmentation fault.<BR>
<BR>
What does gdb say ?<BR>
<BR>
&gt;&nbsp; The problem I am having is<BR>
&gt; that I have been asked to add another team-member's non-realtime =
work which<BR>
&gt; uses networking sockets within a low-priority RT Task.&nbsp; That =
code uses SDL<BR>
&gt; NET 1.2<BR>
&gt;<BR>
&gt; Is it possible to use SDL NET for TCP/IP communication within an =
RT-Task, or<BR>
&gt; is it typically difficult to adapt a program communicating over =
TCP/IP into<BR>
&gt; RTnet?<BR>
<BR>
First you have to make sure that your program use the services it<BR>
think it uses. Do you compile your application for the posix skin ?<BR>
Does this SDL NET (library I assume) come as a dynamic shared object =
?<BR>
or as a static archive ?<BR>
<BR>
--<BR>
&nbsp;Gilles<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C8C192.C6ACA90E--

