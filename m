Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7C8C1.2315E761"
Date: Wed, 18 Jul 2007 00:23:44 +0200
Message-ID: <760425846A1BC44B8BD24361EF2E3451A69749@domain.hid>
From: "Renner Johannes" <rennj1@domain.hid>
Subject: [Xenomai-help] Writing from user space direct to IO Ports without
	mode switches
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

------_=_NextPart_001_01C7C8C1.2315E761
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello everyone,

The outb functions to control parallel ports in my user mode RT task =
causing inacceptable jitter and make the task unstable(-110) at =
higher(10khz) output frequencies. I believe this is due to mode switches =
form Primary to the Secondary mode.
I tried to access the ports via /dev/mem and mmap() (method from =
xenomai/examples/common/hw_direct_io.c) but thus mapping is successful, =
writing -whatever- to the mapped pointer does not set any IO's on my =
x86.
I have read that some Xenomai RT testing with the Parallel port at =
frequencies above 200khz showed excellent results. Which functions are =
used for such precise timings and are they only available in kernel =
space?

Thanks in advance=20

Johannes

------_=_NextPart_001_01C7C8C1.2315E761
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7652.24">
<TITLE>Writing from user space direct to IO Ports without mode =
switches</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Hello everyone,<BR>
<BR>
The outb functions to control parallel ports in my user mode RT task =
causing inacceptable jitter and make the task unstable(-110) at =
higher(10khz) output frequencies. I believe this is due to mode switches =
form Primary to the Secondary mode.<BR>
I tried to access the ports via /dev/mem and mmap() (method from =
xenomai/examples/common/hw_direct_io.c) but thus mapping is successful, =
writing -whatever- to the mapped pointer does not set any IO's on my =
x86.<BR>
I have read that some Xenomai RT testing with the Parallel port at =
frequencies above 200khz showed excellent results. Which functions are =
used for such precise timings and are they only available in kernel =
space?<BR>
<BR>
Thanks in advance<BR>
<BR>
Johannes</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C7C8C1.2315E761--

