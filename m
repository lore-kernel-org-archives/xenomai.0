Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8A65B.CF28C1B7"
Date: Thu, 24 Apr 2008 18:37:42 -0400
Message-ID: <51B669A8A7D2914E9AB2B3F40AC6553E646F2F@afsexc01.aurora.aero>
References: <51B669A8A7D2914E9AB2B3F40AC6553E646F13@domain.hid><2ff1a98a0804230730t44382de9i813b23d235ece2e3@domain.hid><51B669A8A7D2914E9AB2B3F40AC6553E646F19@domain.hid><18447.31623.723753.421351@domain.hid><51B669A8A7D2914E9AB2B3F40AC6553E646F1D@afsexc01.aurora.aero><18447.43488.713144.166771@domain.hid><51B669A8A7D2914E9AB2B3F40AC6553E646F21@domain.hid><18448.11276.526008.229326@domain.hid><48103103.7020005@domain.hid><51B669A8A7D2914E9AB2B3F40AC6553E646F23@domain.hid><2ff1a98a0804240730w36d69599q8ed98c1657365cb@domain.hid><51B669A8A7D2914E9AB2B3F40AC6553E646F2A@afsexc01.aurora.aero>
	<18448.49233.523862.911803@domain.hid>
From: "Karch, Joshua" <jkarch@domain.hid>
Subject: Re: [Xenomai-help] serial port overrun problem RT TASK geode
	latencies too high
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

------_=_NextPart_001_01C8A65B.CF28C1B7
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Gilles,

The framebuffer support was added to the kernel, and magically the =
latency is now down to the 1300 range. I modprobed the timerbench module =
and so the number 1340 is the worst I've seen.   The next thing to do is =
to play around with the outb and SMI. I got to the point where I haven't =
found any errors in a two minute test.

Take care,

Josh


-----Original Message-----
From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
Sent: Thu 4/24/2008 1:16 PM
To: Karch, Joshua
Cc: Jan Kiszka; xenomai@xenomai.org
Subject: RE: [Xenomai-help] serial port overrun problem RT TASK
=20
Karch, Joshua wrote:
 >=20
 > Gilles, Jan,
 >=20
 > I tried idle=3Dpoll and disabling smi in a new kernel, and that =
brought the error rate down to once every 30 seconds  Worst case latency =
dropped to 1763 uS

A worst case latency of 1ms is way too high. You still have an hardware
issue. How do you disable SMI ? Do you use the outbs from the link I
sent ? Maybe they are for Geode GX1, and you have a Geode GX2. You
should look for the proper outb in a geode GX2 datasheet.

Have you kept away from the CPUFREQ and ACPI_PROCESSOR options ? Did you
check the BIOS settings ?

Also, what about the graphical problem ? Did you switch to framebuffer ?

 >=20
 > This Geode GX500 (GX2) seems to have some compatibility problems with =
the Xenomai system.

These are just problems due to power saving, but there should hopefully
be workarounds. Also notes that these problems are not specific to
Xenomai, they also happen with Linux. Only, they are not considered
abnormal. There are people actually using happily Xenomai on Geode
processors.

 >=20
 > I'm still unable to open the benchmark device code -19 when running =
latency -t 2

Have you enabled the timerbench driver in xenomai configuration ?

--=20


					    Gilles.


------_=_NextPart_001_01C8A65B.CF28C1B7
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
<TITLE>RE: [Xenomai-help] serial port overrun problem RT TASK geode =
latencies too high</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Gilles,<BR>
<BR>
The framebuffer support was added to the kernel, and magically the =
latency is now down to the 1300 range. I modprobed the timerbench module =
and so the number 1340 is the worst I've seen.&nbsp;&nbsp; The next =
thing to do is to play around with the outb and SMI. I got to the point =
where I haven't found any errors in a two minute test.<BR>
<BR>
Take care,<BR>
<BR>
Josh<BR>
<BR>
<BR>
-----Original Message-----<BR>
From: Gilles Chanteperdrix [<A =
HREF=3D"mailto:gilles.chanteperdrix@xenomai.org">mailto:gilles.chanteperdri=
x@domain.hid</A>]<BR>
Sent: Thu 4/24/2008 1:16 PM<BR>
To: Karch, Joshua<BR>
Cc: Jan Kiszka; xenomai@xenomai.org<BR>
Subject: RE: [Xenomai-help] serial port overrun problem RT TASK<BR>
<BR>
Karch, Joshua wrote:<BR>
&nbsp;&gt;<BR>
&nbsp;&gt; Gilles, Jan,<BR>
&nbsp;&gt;<BR>
&nbsp;&gt; I tried idle=3Dpoll and disabling smi in a new kernel, and =
that brought the error rate down to once every 30 seconds&nbsp; Worst =
case latency dropped to 1763 uS<BR>
<BR>
A worst case latency of 1ms is way too high. You still have an =
hardware<BR>
issue. How do you disable SMI ? Do you use the outbs from the link I<BR>
sent ? Maybe they are for Geode GX1, and you have a Geode GX2. You<BR>
should look for the proper outb in a geode GX2 datasheet.<BR>
<BR>
Have you kept away from the CPUFREQ and ACPI_PROCESSOR options ? Did =
you<BR>
check the BIOS settings ?<BR>
<BR>
Also, what about the graphical problem ? Did you switch to framebuffer =
?<BR>
<BR>
&nbsp;&gt;<BR>
&nbsp;&gt; This Geode GX500 (GX2) seems to have some compatibility =
problems with the Xenomai system.<BR>
<BR>
These are just problems due to power saving, but there should =
hopefully<BR>
be workarounds. Also notes that these problems are not specific to<BR>
Xenomai, they also happen with Linux. Only, they are not considered<BR>
abnormal. There are people actually using happily Xenomai on Geode<BR>
processors.<BR>
<BR>
&nbsp;&gt;<BR>
&nbsp;&gt; I'm still unable to open the benchmark device code -19 when =
running latency -t 2<BR>
<BR>
Have you enabled the timerbench driver in xenomai configuration ?<BR>
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
------_=_NextPart_001_01C8A65B.CF28C1B7--

