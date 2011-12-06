Message-ID: <4EDE5AFA.2050503@domain.hid>
Date: Tue, 06 Dec 2011 19:12:10 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4ED8EEB1.1040904@domain.hid>
In-Reply-To: <4ED8EEB1.1040904@domain.hid>
Content-Type: text/plain; charset=UTF-8
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

On 12/02/2011 04:28 PM, Kurt Geebelen wrote:
> Dear all,
>=20
> I've tried installing Xenomai, following these instructions:
>=20
> http://www.xenomai.org/index.php/Building_Debian_packages
>=20
> but then for the latest version (xenomai 2.6.0, and kernel 2.6.38.8 and=
=20
> for 64 bit) .
>=20
> For configuring the kernel, I followed these instructions:
>=20
> http://www.xenomai.org/index.php/Configuring_x86_kernels
>=20
> All that is stated on these websites works without problems, and I am=20
> able to boot in the installed xenomai kernel. However, when I perform=20
> the latency-test (latency in /usr/lib/xenomai), I get latencies of more=
=20
> than 1400 microseconds.
>=20
> The system I have is the following:
>=20
> Dell=E2=84=A2 Precision=E2=84=A2 T1500
> One=C2=AE Intel=E2=84=A2 Core i7-860 (2.8GHz, 8MB L3, 95W, Quad Core)
> 6GB DDR3 non-ECC Memory (1333MHz, 3x2GB)
> 512MB PCIe x16 NVIDIA Quadro FX 580 Graphics Card
> Intel Solid-State Drive 320 Series 120GB
>=20
> I have tried reinstalling the kernel several times, but I always end up=
=20
> with high latencies.
> I also have consulted with others, who followed the same guidelines as =
I=20
> did, and their latencies are about 100 times lower.
>=20
> Is there somebody who knows what the problem might be? Might it be a=20
> hardware-related problem?

It is already written in the URL you mention, but I will repeat it
nevertheless, if enabling SMI workaround, have you checked the kernel
logs to see whether the SMI workaround actually works?

--=20
					    Gilles.


