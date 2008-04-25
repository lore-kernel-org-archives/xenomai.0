Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8A6ED.F9FADF40"
Date: Fri, 25 Apr 2008 12:04:01 -0400
Message-ID: <51B669A8A7D2914E9AB2B3F40AC6553E646F36@domain.hid>
References: <51B669A8A7D2914E9AB2B3F40AC6553E646F13@domain.hid><2ff1a98a0804230730t44382de9i813b23d235ece2e3@domain.hid><51B669A8A7D2914E9AB2B3F40AC6553E646F19@domain.hid><18447.31623.723753.421351@domain.hid><51B669A8A7D2914E9AB2B3F40AC6553E646F1D@afsexc01.aurora.aero><18447.43488.713144.166771@domain.hid><51B669A8A7D2914E9AB2B3F40AC6553E646F21@domain.hid><18448.11276.526008.229326@domain.hid><48103103.7020005@domain.hid><51B669A8A7D2914E9AB2B3F40AC6553E646F23@domain.hid><2ff1a98a0804240730w36d69599q8ed98c1657365cb@domain.hid><51B669A8A7D2914E9AB2B3F40AC6553E646F2A@afsexc01.aurora.aero><18448.49233.523862.911803@domain.hid><51B669A8A7D2914E9AB2B3F40AC6553E646F2F@afsexc01.aurora.aero>
	<18449.4281.679002.804576@domain.hid>
From: "Karch, Joshua" <jkarch@domain.hid>
Subject: [Xenomai-help] Geode Latency Problem (Was: serial port overrun
	problem)
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
Cc: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C8A6ED.F9FADF40
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Gilles, Jan,

we disabled "System Management Mode" in the Geode GX500 (Versalogic =
Puma) bios which disables USB, all Video, ethernet-- everything.  We =
enabled the Getty serial console and boot from serial in Grub, and =
booted linux off of the serial port which we'd eventually like to use =
for our sensor acquisition.  However, upon running latency -t2, our =
latencies dropped to 40 usec max.  Amazing!    We used VGA mode 791 in =
the kernel options before and got a reduction by 400 usec.  The thing =
is-- we still need ethernet, and we need our serial port for our RT =
work.  Also, in order to get out of System Management Mode we have to =
reset the bios by jumper since there is no serial menu.  Any ideas?

We looked through all of the forums and were not able to find any more =
information as to how to selectively disable the unwanted SMI calls that =
are causing the latency.  We definitely would like basic video, though =
primarily we only need ethernet and serial, and then we can ssh in.

Sincerely,

Joshua Karch



-----Original Message-----
From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
Sent: Thu 4/24/2008 6:59 PM
To: Karch, Joshua
Cc: Jan Kiszka; xenomai@xenomai.org
Subject: RE: [Xenomai-help] serial port overrun problem RT TASK geode =
latencies too high
=20
Karch, Joshua wrote:
 > Gilles,
 >=20
 > The framebuffer support was added to the kernel, and magically the =
latency is now down to the 1300 range. I modprobed the timerbench module =
and so the number 1340 is the worst I've seen.   The next thing to do is =
to play around with the outb and SMI. I got to the point where I haven't =
found any errors in a two minute test.

1300 is still way too high. A normal latency is something less than
100us, probably even less than 50us.=20

--=20


					    Gilles.


------_=_NextPart_001_01C8A6ED.F9FADF40
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
<TITLE>Geode Latency Problem (Was: serial port overrun problem)</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Gilles, Jan,<BR>
<BR>
we disabled &quot;System Management Mode&quot; in the Geode GX500 =
(Versalogic Puma) bios which disables USB, all Video, ethernet-- =
everything.&nbsp; We enabled the Getty serial console and boot from =
serial in Grub, and booted linux off of the serial port which we'd =
eventually like to use for our sensor acquisition.&nbsp; However, upon =
running latency -t2, our latencies dropped to 40 usec max.&nbsp; =
Amazing!&nbsp;&nbsp;&nbsp; We used VGA mode 791 in the kernel options =
before and got a reduction by 400 usec.&nbsp; The thing is-- we still =
need ethernet, and we need our serial port for our RT work.&nbsp; Also, =
in order to get out of System Management Mode we have to reset the bios =
by jumper since there is no serial menu.&nbsp; Any ideas?<BR>
<BR>
We looked through all of the forums and were not able to find any more =
information as to how to selectively disable the unwanted SMI calls that =
are causing the latency.&nbsp; We definitely would like basic video, =
though primarily we only need ethernet and serial, and then we can ssh =
in.<BR>
<BR>
Sincerely,<BR>
<BR>
Joshua Karch<BR>
<BR>
<BR>
<BR>
-----Original Message-----<BR>
From: Gilles Chanteperdrix [<A =
HREF=3D"mailto:gilles.chanteperdrix@xenomai.org">mailto:gilles.chanteperdri=
x@domain.hid</A>]<BR>
Sent: Thu 4/24/2008 6:59 PM<BR>
To: Karch, Joshua<BR>
Cc: Jan Kiszka; xenomai@xenomai.org<BR>
Subject: RE: [Xenomai-help] serial port overrun problem RT TASK geode =
latencies too high<BR>
<BR>
Karch, Joshua wrote:<BR>
&nbsp;&gt; Gilles,<BR>
&nbsp;&gt;<BR>
&nbsp;&gt; The framebuffer support was added to the kernel, and =
magically the latency is now down to the 1300 range. I modprobed the =
timerbench module and so the number 1340 is the worst I've =
seen.&nbsp;&nbsp; The next thing to do is to play around with the outb =
and SMI. I got to the point where I haven't found any errors in a two =
minute test.<BR>
<BR>
1300 is still way too high. A normal latency is something less than<BR>
100us, probably even less than 50us.<BR>
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
------_=_NextPart_001_01C8A6ED.F9FADF40--

