Message-ID: <4ED8F230.4050003@domain.hid>
Date: Fri, 02 Dec 2011 16:43:44 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4ED8EEB1.1040904@domain.hid>
In-Reply-To: <4ED8EEB1.1040904@domain.hid>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
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

On 2011-12-02 16:28, Kurt Geebelen wrote:
> Dear all,
>=20
> I've tried installing Xenomai, following these instructions:
>=20
> http://www.xenomai.org/index.php/Building_Debian_packages
>=20
> but then for the latest version (xenomai 2.6.0, and kernel 2.6.38.8 and
> for 64 bit) .
>=20
> For configuring the kernel, I followed these instructions:
>=20
> http://www.xenomai.org/index.php/Configuring_x86_kernels
>=20
> All that is stated on these websites works without problems, and I am
> able to boot in the installed xenomai kernel. However, when I perform
> the latency-test (latency in /usr/lib/xenomai), I get latencies of more
> than 1400 microseconds.

Sounds like wbinvd (cache flushing on DMA remappings).

>=20
> The system I have is the following:
>=20
> Dell=99 Precision=99 T1500
> One=AE Intel=99 Core i7-860 (2.8GHz, 8MB L3, 95W, Quad Core)
> 6GB DDR3 non-ECC Memory (1333MHz, 3x2GB)
> 512MB PCIe x16 NVIDIA Quadro FX 580 Graphics Card

Do you use the nvidia binary driver? It's known to kill latencies.


> Intel Solid-State Drive 320 Series 120GB
>=20
> I have tried reinstalling the kernel several times, but I always end up
> with high latencies.
> I also have consulted with others, who followed the same guidelines as =
I
> did, and their latencies are about 100 times lower.
>=20
> Is there somebody who knows what the problem might be? Might it be a
> hardware-related problem?
>=20
> Many thanks in advance,
> Best regards,
> Kurt Geebelen

Jan

--=20
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

