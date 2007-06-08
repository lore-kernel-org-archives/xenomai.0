Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7A9D6.48853A4E"
Date: Fri, 8 Jun 2007 16:07:00 +0200
Message-ID: <403B28AE6257B548B66BB88414AC78330174BC39@domain.hid>
From: "BOUIN Alexandre" <abouin@domain.hid>
Subject: [Xenomai-core] periodic mode in adeos-ipipe for arm at91 ...
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org, adeos-main@gna.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C7A9D6.48853A4E
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

		We (Adeneo) are working on a ARM AT91 RTAI. We encountered some =
difficulties such tsc one : in periodic mode, we reload our timer =
automatically in order to avoid reprogramming it. TC timer increments a =
16 byte register, which is not enough for a tsc (64 bytes). tsc need to =
be emulated on ARM.
		With oneshot mode, tsc is updating the 4 least significant bytes and =
then increments other bytes each time counter go back to zero value.

		With our periodic mode, timer reloads himself so we need to change tsc =
emulation by incrementing tsc like this : tsc +=3D period.
		We made some evolutions on ipipe which will be applied to a hal patch.

		Are you interrested in a such patch for a periodic mode on ARM ?


------_=_NextPart_001_01C7A9D6.48853A4E
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7650.28">
<TITLE>periodic mode in adeos-ipipe for arm at91 ...</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->
<UL><UL>
<P><FONT SIZE=3D2 FACE=3D"Arial">We (Adeneo) are working on a ARM AT91 =
RTAI. We encountered some difficulties such tsc one : in periodic mode, =
we reload our timer automatically in order to avoid reprogramming it. TC =
timer increments a 16 byte register, which is not enough for a tsc (64 =
bytes). tsc need to be emulated on ARM.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">With oneshot mode, tsc is updating the =
4 least significant bytes and then increments other bytes each time =
counter go back to zero value.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">With our periodic mode, timer reloads =
himself so we need to change tsc emulation by incrementing tsc like this =
: tsc +=3D period.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">We made some evolutions on ipipe which =
will be applied to a hal patch.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Are you interrested in a such patch for =
a periodic mode on ARM ?</FONT>
</P>
</UL></UL>
</BODY>
</HTML>
------_=_NextPart_001_01C7A9D6.48853A4E--

