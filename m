Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CA0B6E.0A210954"
Date: Thu, 23 Jul 2009 10:17:37 +0200
Message-ID: <EB48F2CADC239E44A8598CC0B0571102E4A99D@XVS-DCFR-21.europe.corp.altran.com>
From: =?iso-8859-1?Q?Berruer_S=E9bastien?= <sebastien.berruer@domain.hid>
Subject: [Xenomai-help] State of implementation of CAN, CANOpen in Xenomai
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

------_=_NextPart_001_01CA0B6E.0A210954
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,

I'm reviewing the feasibility of a project that would require the =
driving of
devices with real time constrains.

I'm asking for the current state of the CAN implementation. Is it a =
partial or a
complete implementation of the CAN standard? What are the guarantee =
about real
time latency?

I explored briefly the sources of Xenomai, and I read the file
"ksrc/drivers/can/README". Is it up-to-date? Is there really only =
support for
the controllers listed in it?

I've read in "RTDM and applications" that there would be an effort for
implementing a CANOpen profile. But, the implementation of CANOpen =
protocol is
let to users? I can't find any newer reference for that in sources or in =
the
documentation of Xenomai. What is the state of this project?

I've seen that there is currently only one implementation of a RT driver =
for the
16550A serial controller. Has anybody implemented it for other chip?

If I finally decide to choose a RT-Patch, instead of Xenomai, I will =
have the
CAN implementation that will use the Linux networking stack. But I will =
not have
any guarantee about its real time implementation, isn't it?

I hope that somebody can answer my questions. May I ask those directly =
to
Wolfgang Grandegger or Sebastian Smolorz? Or on the "SocketCan" mailing =
list?

Best regards,

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
| BERRUER S=E9bastien             |
| Trainee at Altran Ouest       |
| Centre d'Affaires Alphasis    |
| 35760 Saint-Gr=E9goire - FRANCE |
| Tel: 06-76-35-29-55           |
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D



------_=_NextPart_001_01CA0B6E.0A210954
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
<TITLE>State of implementation of CAN, CANOpen in Xenomai</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Hello,<BR>
<BR>
I'm reviewing the feasibility of a project that would require the =
driving of<BR>
devices with real time constrains.<BR>
<BR>
I'm asking for the current state of the CAN implementation. Is it a =
partial or a<BR>
complete implementation of the CAN standard? What are the guarantee =
about real<BR>
time latency?<BR>
<BR>
I explored briefly the sources of Xenomai, and I read the file<BR>
&quot;ksrc/drivers/can/README&quot;. Is it up-to-date? Is there really =
only support for<BR>
the controllers listed in it?<BR>
<BR>
I've read in &quot;RTDM and applications&quot; that there would be an =
effort for<BR>
implementing a CANOpen profile. But, the implementation of CANOpen =
protocol is<BR>
let to users? I can't find any newer reference for that in sources or in =
the<BR>
documentation of Xenomai. What is the state of this project?<BR>
<BR>
I've seen that there is currently only one implementation of a RT driver =
for the<BR>
16550A serial controller. Has anybody implemented it for other chip?<BR>
<BR>
If I finally decide to choose a RT-Patch, instead of Xenomai, I will =
have the<BR>
CAN implementation that will use the Linux networking stack. But I will =
not have<BR>
any guarantee about its real time implementation, isn't it?<BR>
<BR>
I hope that somebody can answer my questions. May I ask those directly =
to<BR>
Wolfgang Grandegger or Sebastian Smolorz? Or on the =
&quot;SocketCan&quot; mailing list?<BR>
<BR>
Best regards,<BR>
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
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01CA0B6E.0A210954--

