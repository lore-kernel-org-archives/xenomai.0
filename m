Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8A62D.06588285"
Date: Thu, 24 Apr 2008 12:58:40 -0400
Message-ID: <51B669A8A7D2914E9AB2B3F40AC6553E646F2A@afsexc01.aurora.aero>
References: <51B669A8A7D2914E9AB2B3F40AC6553E646F13@domain.hid>
	<2ff1a98a0804230730t44382de9i813b23d235ece2e3@domain.hid>
	<51B669A8A7D2914E9AB2B3F40AC6553E646F19@domain.hid>
	<18447.31623.723753.421351@domain.hid>
	<51B669A8A7D2914E9AB2B3F40AC6553E646F1D@afsexc01.aurora.aero>
	<18447.43488.713144.166771@domain.hid>
	<51B669A8A7D2914E9AB2B3F40AC6553E646F21@domain.hid>
	<18448.11276.526008.229326@domain.hid>
	<48103103.7020005@domain.hid>
	<51B669A8A7D2914E9AB2B3F40AC6553E646F23@domain.hid>
	<2ff1a98a0804240730w36d69599q8ed98c1657365cb@domain.hid>
From: "Karch, Joshua" <jkarch@domain.hid>
Subject: Re: [Xenomai-help] serial port overrun problem RT TASK
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

------_=_NextPart_001_01C8A62D.06588285
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Gilles, Jan,

I tried idle=3Dpoll and disabling smi in a new kernel, and that brought =
the error rate down to once every 30 seconds  Worst case latency dropped =
to 1763 uS

This Geode GX500 (GX2) seems to have some compatibility problems with =
the Xenomai system.

I'm still unable to open the benchmark device code -19 when running =
latency -t 2


Thank you,
Joshua Karch.


-----Original Message-----
From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
Sent: Thu 4/24/2008 10:30 AM
To: Karch, Joshua
Cc: Jan Kiszka; xenomai@xenomai.org
Subject: Re: [Xenomai-help] serial port overrun problem RT TASK
=20
On Thu, Apr 24, 2008 at 4:16 PM, Karch, Joshua <jkarch@domain.hid> =
wrote:
>  RTD|     -56.153|     -38.553|    1951.085|    2319|     -62.020|
> 2055.847
>
>  Any ideas?

You definitely have a hardware issue. Geode are known for at least two =
things:
- they may stop their tsc when idle, this is bad since Xenomai relies
on a continuously ticking tsc, AFAIK, this can be worked around by
passing the idle=3Dpoll parameter on the kernel command line;
- they may use SMI, fortunately SMIs may be disabled with a few outbs,
as explained in this
https://mail.rtai.org/pipermail/rtai/2005-July/012474.html

ISTR that there are issues with graphic mode, and the workaround may
be to switch to framebuffer mode, but I am not sure.

Look for geode in RTAI mailing list archives to find additional =
informations.
When this is done, it would be nice if you could create a page about
Geode on Xenomai wiki summarizing your findings.

--=20
 Gilles


------_=_NextPart_001_01C8A62D.06588285
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
<TITLE>RE: [Xenomai-help] serial port overrun problem RT TASK</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->
<BR>

<P><FONT SIZE=3D2>Gilles, Jan,<BR>
<BR>
I tried idle=3Dpoll and disabling smi in a new kernel, and that brought =
the error rate down to once every 30 seconds&nbsp; Worst case latency =
dropped to 1763 uS<BR>
<BR>
This Geode GX500 (GX2) seems to have some compatibility problems with =
the Xenomai system.<BR>
<BR>
I'm still unable to open the benchmark device code -19 when running =
latency -t 2<BR>
<BR>
<BR>
Thank you,<BR>
Joshua Karch.<BR>
<BR>
<BR>
-----Original Message-----<BR>
From: Gilles Chanteperdrix [<A =
HREF=3D"mailto:gilles.chanteperdrix@xenomai.org">mailto:gilles.chanteperdri=
x@domain.hid</A>]<BR>
Sent: Thu 4/24/2008 10:30 AM<BR>
To: Karch, Joshua<BR>
Cc: Jan Kiszka; xenomai@xenomai.org<BR>
Subject: Re: [Xenomai-help] serial port overrun problem RT TASK<BR>
<BR>
On Thu, Apr 24, 2008 at 4:16 PM, Karch, Joshua =
&lt;jkarch@domain.hid&gt; wrote:<BR>
&gt;&nbsp; RTD|&nbsp;&nbsp;&nbsp;&nbsp; -56.153|&nbsp;&nbsp;&nbsp;&nbsp; =
-38.553|&nbsp;&nbsp;&nbsp; 1951.085|&nbsp;&nbsp;&nbsp; =
2319|&nbsp;&nbsp;&nbsp;&nbsp; -62.020|<BR>
&gt; 2055.847<BR>
&gt;<BR>
&gt;&nbsp; Any ideas?<BR>
<BR>
You definitely have a hardware issue. Geode are known for at least two =
things:<BR>
- they may stop their tsc when idle, this is bad since Xenomai =
relies<BR>
on a continuously ticking tsc, AFAIK, this can be worked around by<BR>
passing the idle=3Dpoll parameter on the kernel command line;<BR>
- they may use SMI, fortunately SMIs may be disabled with a few =
outbs,<BR>
as explained in this<BR>
<A =
HREF=3D"https://mail.rtai.org/pipermail/rtai/2005-July/012474.html">https=
://mail.rtai.org/pipermail/rtai/2005-July/012474.html</A><BR>
<BR>
ISTR that there are issues with graphic mode, and the workaround may<BR>
be to switch to framebuffer mode, but I am not sure.<BR>
<BR>
Look for geode in RTAI mailing list archives to find additional =
informations.<BR>
When this is done, it would be nice if you could create a page about<BR>
Geode on Xenomai wiki summarizing your findings.<BR>
<BR>
--<BR>
&nbsp;Gilles<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C8A62D.06588285--

