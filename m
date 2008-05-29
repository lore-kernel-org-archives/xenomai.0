Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8C13E.78E780F8"
Date: Wed, 28 May 2008 23:44:56 -0400
Message-ID: <51B669A8A7D2914E9AB2B3F40AC6553E646FC3@domain.hid>
From: "Karch, Joshua" <jkarch@domain.hid>
Subject: [Xenomai-help] Xenomai and SDL NET sockets 1.2
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

------_=_NextPart_001_01C8C13E.78E780F8
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


To whom it may concern::
we are interested in merging our real-time tasks with Xenomai with a =
low-priority RT_TASK that uses SDL-NET to communicate from real-time =
tasks over ethernet. Unfortunately, running an RT_TASK with SDL-NET =
seems to have caused a tough-to-identify segmentation fault.  The =
problem I am having is that I have been asked to add another =
team-member's non-realtime work which uses networking sockets within a =
low-priority RT Task.  That code uses SDL NET 1.2 =20

Is it possible to use SDL NET for TCP/IP communication within an =
RT-Task, or is it typically difficult to adapt a program communicating =
over TCP/IP into RTnet?

Thank you,

Joshua Karch

------_=_NextPart_001_01C8C13E.78E780F8
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
<TITLE>Xenomai and SDL NET sockets 1.2</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->
<BR>

<P><FONT SIZE=3D2>To whom it may concern::<BR>
we are interested in merging our real-time tasks with Xenomai with a =
low-priority RT_TASK that uses SDL-NET to communicate from real-time =
tasks over ethernet. Unfortunately, running an RT_TASK with SDL-NET =
seems to have caused a tough-to-identify segmentation fault.&nbsp; The =
problem I am having is that I have been asked to add another =
team-member's non-realtime work which uses networking sockets within a =
low-priority RT Task.&nbsp; That code uses SDL NET 1.2&nbsp;<BR>
<BR>
Is it possible to use SDL NET for TCP/IP communication within an =
RT-Task, or is it typically difficult to adapt a program communicating =
over TCP/IP into RTnet?<BR>
<BR>
Thank you,<BR>
<BR>
Joshua Karch<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C8C13E.78E780F8--

