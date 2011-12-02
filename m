Message-ID: <4ED8EEB1.1040904@domain.hid>
Date: Fri, 02 Dec 2011 16:28:49 +0100
From: Kurt Geebelen <kurt.geebelen@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] Xenomai installation: high latencies
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Dear all,

I've tried installing Xenomai, following these instructions:

http://www.xenomai.org/index.php/Building_Debian_packages

but then for the latest version (xenomai 2.6.0, and kernel 2.6.38.8 and=20
for 64 bit) .

For configuring the kernel, I followed these instructions:

http://www.xenomai.org/index.php/Configuring_x86_kernels

All that is stated on these websites works without problems, and I am=20
able to boot in the installed xenomai kernel. However, when I perform=20
the latency-test (latency in /usr/lib/xenomai), I get latencies of more=20
than 1400 microseconds.

The system I have is the following:

Dell=99 Precision=99 T1500
One=AE Intel=99 Core i7-860 (2.8GHz, 8MB L3, 95W, Quad Core)
6GB DDR3 non-ECC Memory (1333MHz, 3x2GB)
512MB PCIe x16 NVIDIA Quadro FX 580 Graphics Card
Intel Solid-State Drive 320 Series 120GB

I have tried reinstalling the kernel several times, but I always end up=20
with high latencies.
I also have consulted with others, who followed the same guidelines as I=20
did, and their latencies are about 100 times lower.

Is there somebody who knows what the problem might be? Might it be a=20
hardware-related problem?

Many thanks in advance,
Best regards,
Kurt Geebelen

