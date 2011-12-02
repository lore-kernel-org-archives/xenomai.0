In-Reply-To: <4ED8EEB1.1040904@domain.hid>
MIME-Version: 1.0
From: George Broz <GBroz@domain.hid>
Message-ID: <OF1C198BB6.C4E6BFC2-ON8825795A.0072F29D-8825795A.00740639@domain.hid>
Date: Fri, 2 Dec 2011 13:07:16 -0800
Content-Type: multipart/alternative;
	boundary="=_alternative 0074057B8825795A_="
Subject: Re: [Xenomai-help] Xenomai installation: high latencies
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Kurt Geebelen <kurt.geebelen@domain.hid>
Cc: xenomai@xenomai.org

--=_alternative 0074057B8825795A_=
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Kurt,

I had to disable all CPU throttling mechanisms in the BIOS settings like=20
Intel's SpeedStep and ACPI 3.0 T-states. Make sure you have adequate=20
cooling if you do so!

Regards,
George

<xenomai-help-bounces@domain.hid> wrote on 12/02/2011 07:28:49 AM:

> Dear all,
>=20
> I've tried installing Xenomai, following these instructions:
>=20
> http://www.xenomai.org/index.php/Building=5FDebian=5Fpackages
>=20
> but then for the latest version (xenomai 2.6.0, and kernel 2.6.38.8 and=20
> for 64 bit) .
>=20
> For configuring the kernel, I followed these instructions:
>=20
> http://www.xenomai.org/index.php/Configuring=5Fx86=5Fkernels
>=20
> All that is stated on these websites works without problems, and I am=20
> able to boot in the installed xenomai kernel. However, when I perform=20
> the latency-test (latency in /usr/lib/xenomai), I get latencies of more=20
> than 1400 microseconds.
>=20
> The system I have is the following:
>=20
> Dell? Precision? T1500
> One=AE Intel? Core i7-860 (2.8GHz, 8MB L3, 95W, Quad Core)
> 6GB DDR3 non-ECC Memory (1333MHz, 3x2GB)
> 512MB PCIe x16 NVIDIA Quadro FX 580 Graphics Card
> Intel Solid-State Drive 320 Series 120GB
>=20
> I have tried reinstalling the kernel several times, but I always end up=20
> with high latencies.
> I also have consulted with others, who followed the same guidelines as I =


> did, and their latencies are about 100 times lower.
>=20
> Is there somebody who knows what the problem might be? Might it be a=20
> hardware-related problem?
>=20
> Many thanks in advance,
> Best regards,
> Kurt Geebelen
>=20
> =5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>=20

--=_alternative 0074057B8825795A_=
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable


<br><font size=3D2 face=3D"sans-serif">Hi Kurt,</font>
<br>
<br><font size=3D2 face=3D"sans-serif">I had to disable all CPU throttling
mechanisms in the BIOS settings like Intel's SpeedStep and ACPI 3.0 T-state=
s.
Make sure you have adequate cooling if you do so!</font>
<br>
<br><font size=3D2 face=3D"sans-serif">Regards,</font>
<br><font size=3D2 face=3D"sans-serif">George<br>
</font>
<br><tt><font size=3D2>&lt;xenomai-help-bounces@domain.hid&gt; wrote on 12/02/=
2011
07:28:49 AM:<br>
<br>
&gt; Dear all,<br>
&gt; <br>
&gt; I've tried installing Xenomai, following these instructions:<br>
&gt; <br>
&gt; http://www.xenomai.org/index.php/Building=5FDebian=5Fpackages<br>
&gt; <br>
&gt; but then for the latest version (xenomai 2.6.0, and kernel 2.6.38.8
and <br>
&gt; for 64 bit) .<br>
&gt; <br>
&gt; For configuring the kernel, I followed these instructions:<br>
&gt; <br>
&gt; http://www.xenomai.org/index.php/Configuring=5Fx86=5Fkernels<br>
&gt; <br>
&gt; All that is stated on these websites works without problems, and I
am <br>
&gt; able to boot in the installed xenomai kernel. However, when I perform
<br>
&gt; the latency-test (latency in /usr/lib/xenomai), I get latencies of
more <br>
&gt; than 1400 microseconds.<br>
&gt; <br>
&gt; The system I have is the following:<br>
&gt; <br>
&gt; Dell&#8482; Precision&#8482; T1500<br>
&gt; One=AE Intel&#8482; Core i7-860 (2.8GHz, 8MB L3, 95W, Quad Core)<br>
&gt; 6GB DDR3 non-ECC Memory (1333MHz, 3x2GB)<br>
&gt; 512MB PCIe x16 NVIDIA Quadro FX 580 Graphics Card<br>
&gt; Intel Solid-State Drive 320 Series 120GB<br>
&gt; <br>
&gt; I have tried reinstalling the kernel several times, but I always end
up <br>
&gt; with high latencies.<br>
&gt; I also have consulted with others, who followed the same guidelines
as I <br>
&gt; did, and their latencies are about 100 times lower.<br>
&gt; <br>
&gt; Is there somebody who knows what the problem might be? Might it be
a <br>
&gt; hardware-related problem?<br>
&gt; <br>
&gt; Many thanks in advance,<br>
&gt; Best regards,<br>
&gt; Kurt Geebelen<br>
&gt; <br>
&gt; =5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F<br>
&gt; Xenomai-help mailing list<br>
&gt; Xenomai-help@domain.hid<br>
&gt; https://mail.gna.org/listinfo/xenomai-help<br>
&gt; <br>
</font></tt>
--=_alternative 0074057B8825795A_=--

