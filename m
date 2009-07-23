Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CA0B7C.6250802C"
Date: Thu, 23 Jul 2009 12:00:18 +0200
Message-ID: <EB48F2CADC239E44A8598CC0B0571102E4A99E@XVS-DCFR-21.europe.corp.altran.com>
References: <EB48F2CADC239E44A8598CC0B0571102E4A99D@XVS-DCFR-21.europe.corp.altran.com>
	<4A6829D6.9060301@domain.hid>
From: =?iso-8859-1?Q?Berruer_S=E9bastien?= <sebastien.berruer@domain.hid>
Subject: [Xenomai-help] =?iso-8859-1?q?RE=A0=3A__State_of_implementation_o?=
	=?iso-8859-1?q?f_CAN=2C_CANOpen_in_Xenomai?=
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>, xenomai@xenomai.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01CA0B7C.6250802C
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I'm on the first step of the project and I have to choose a complete =
system for my customer. I looking at the constraints both for hardware =
and software and the possibly dependency between them.



> I'm asking for the current state of the CAN implementation. Is it a
> partial or a
> complete implementation of the CAN standard? What are the guarantee
> about real
> time latency?

What exactly do you mean with CAN standard? RT-Socket-CAN allows
low-level access the CAN controller to send and receive messages, handle
errors and set the bit-timing. Standard, extended and RTR frames are
supported.

Sorry, I've made a misunderstood about the CAN organization. In fact, =
the RT-Socket-CAN is a kind of user API for ease the use of CAN bus, =
isn't it? It seems that, generally, the handling of protocol, like the =
access to media or arbitration, is done in the chip.



> I explored briefly the sources of Xenomai, and I read the file
> "ksrc/drivers/can/README". Is it up-to-date? Is there really only
> support for
> the controllers listed in it?

Mainly yes, what CAN controller would you like to use? Writing a
RT-Socket-CAN driver is usually not a big deal.

I asked this to point at the dependency between the software and the =
hardware. For time, the most part of boards that I've seen had the =
SJA100 controller, so that won't be a problem.



> I've read in "RTDM and applications" that there would be an effort for
> implementing a CANOpen profile. But, the implementation of CANOpen
> protocol is
> let to users? I can't find any newer reference for that in sources or =
in the
> documentation of Xenomai. What is the state of this project?

If you are looking for a free CANopen implementation, CANfestival might
be an option, which also supports RT-Socket-CAN, IIRC. Check
http://canfestival.org/ for further information.

My client asks for a complete implementation of the CANOpen protocol. I =
will take all a look at this site and if it's clear for that use.=20



> I've seen that there is currently only one implementation of a RT =
driver
> for the
> 16550A serial controller. Has anybody implemented it for other chip?

What chip/hardware do you have in mind?

Similarly to CAN hardware, almost the hardware that I've seen yet use =
this controller or a 8250 chip.



Best regards, and really thanks for help,

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
| BERRUER S=E9bastien             |
| Trainee at Altran Ouest       |
| Centre d'Affaires Alphasis    |
| 35760 Saint-Gr=E9goire - FRANCE |
| Tel: 06-76-35-29-55           |
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D






------_=_NextPart_001_01CA0B7C.6250802C
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7654.12">
<TITLE>RE=A0: [Xenomai-help] State of implementation of CAN, CANOpen in =
Xenomai</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>I'm on the first step of the project and I have to =
choose a complete system for my customer. I looking at the constraints =
both for hardware and software and the possibly dependency between =
them.<BR>
<BR>
<BR>
<BR>
&gt; I'm asking for the current state of the CAN implementation. Is it =
a<BR>
&gt; partial or a<BR>
&gt; complete implementation of the CAN standard? What are the =
guarantee<BR>
&gt; about real<BR>
&gt; time latency?<BR>
<BR>
What exactly do you mean with CAN standard? RT-Socket-CAN allows<BR>
low-level access the CAN controller to send and receive messages, =
handle<BR>
errors and set the bit-timing. Standard, extended and RTR frames are<BR>
supported.<BR>
<BR>
Sorry, I've made a misunderstood about the CAN organization. In fact, =
the RT-Socket-CAN is a kind of user API for ease the use of CAN bus, =
isn't it? It seems that, generally, the handling of protocol, like the =
access to media or arbitration, is done in the chip.<BR>
<BR>
<BR>
<BR>
&gt; I explored briefly the sources of Xenomai, and I read the file<BR>
&gt; &quot;ksrc/drivers/can/README&quot;. Is it up-to-date? Is there =
really only<BR>
&gt; support for<BR>
&gt; the controllers listed in it?<BR>
<BR>
Mainly yes, what CAN controller would you like to use? Writing a<BR>
RT-Socket-CAN driver is usually not a big deal.<BR>
<BR>
I asked this to point at the dependency between the software and the =
hardware. For time, the most part of boards that I've seen had the =
SJA100 controller, so that won't be a problem.<BR>
<BR>
<BR>
<BR>
&gt; I've read in &quot;RTDM and applications&quot; that there would be =
an effort for<BR>
&gt; implementing a CANOpen profile. But, the implementation of =
CANOpen<BR>
&gt; protocol is<BR>
&gt; let to users? I can't find any newer reference for that in sources =
or in the<BR>
&gt; documentation of Xenomai. What is the state of this project?<BR>
<BR>
If you are looking for a free CANopen implementation, CANfestival =
might<BR>
be an option, which also supports RT-Socket-CAN, IIRC. Check<BR>
<A HREF=3D"http://canfestival.org/">http://canfestival.org/</A> for =
further information.<BR>
<BR>
My client asks for a complete implementation of the CANOpen protocol. I =
will take all a look at this site and if it's clear for that use.<BR>
<BR>
<BR>
<BR>
&gt; I've seen that there is currently only one implementation of a RT =
driver<BR>
&gt; for the<BR>
&gt; 16550A serial controller. Has anybody implemented it for other =
chip?<BR>
<BR>
What chip/hardware do you have in mind?<BR>
<BR>
Similarly to CAN hardware, almost the hardware that I've seen yet use =
this controller or a 8250 chip.<BR>
<BR>
<BR>
<BR>
Best regards, and really thanks for help,<BR>
<BR>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D<BR>
| BERRUER =
S=E9bastien&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; |<BR>
| Trainee at Altran Ouest&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<BR>
| Centre d'Affaires Alphasis&nbsp;&nbsp;&nbsp; |<BR>
| 35760 Saint-Gr=E9goire - FRANCE |<BR>
| Tel: =
06-76-35-29-55&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; |<BR>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01CA0B7C.6250802C--

