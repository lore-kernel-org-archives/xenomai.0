Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7EA47.A7A38A90"
Date: Wed, 29 Aug 2007 16:19:47 +0200
Message-ID: <E5E9C6CC7DC8844A8DA7A9EFE7B5350E08F1F1@domain.hid>
From: "Markus Osterried (BA/EDD)" <markus.osterried@domain.hid>
Subject: [Xenomai-core] RTDM timeout value
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C7EA47.A7A38A90
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

it seems that in the RTDM API, all the timeout functions which use
nanosecs_rel_t have a strange behaviour.
The timeout in nanoseconds is converted to ticks and the number of ticks
is rounded down. So when we want to wait e.g. 500000 nanoseconds and the
timertick is 1 ms, xnpod_ns2ticks() rounds down to 0. But 0 is the
special value RTDM_TIMEOUT_INFINITE, so we wait forever. I use Xenomai
2.3.1, but I think it's basically the same in trunk.
Wouldn't it be better to round up the ticks instead of round it down?


Thanks
Markus


------_=_NextPart_001_01C7EA47.A7A38A90
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7652.24">
<TITLE>RTDM timeout value</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><FONT SIZE=3D2 FACE=3D"Arial">Hi,</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">it seems that in the RTDM API, all the =
timeout functions which use nanosecs_rel_t have a strange =
behaviour.</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">The timeout in nanoseconds is =
converted to ticks and the number of ticks is rounded down. So when we =
want to wait e.g. 500000 nanoseconds and the timertick is 1 ms, =
xnpod_ns2ticks() rounds down to 0. But 0 is the special value =
RTDM_TIMEOUT_INFINITE, so we wait forever. I use Xenomai 2.3.1, but I =
think it's basically the same in trunk.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Wouldn't it be better to round up the =
ticks instead of round it down?</FONT>
</P>
<BR>

<P><FONT SIZE=3D2 FACE=3D"Arial">Thanks</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Markus</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C7EA47.A7A38A90--

