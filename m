Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.27.42.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793112273;
	b=aZNEf0IwQWKZgv5F0Q5PDItsl94Nw9hyuUEMNvcFDQJZP7h4SCxhCCwtwWudX3cSCoWB
	 lRk3FJZwgYR3Xm1afY7aVcmOGnMIswOAJLivh5xCzuzzz0qxUq95n0UZeVIv8tp7f8qqi
	 WLZAWXShgo8QB0eAp6yelPRSnVJXxBH2CFuqmxuPZHc0QvqtclWt2nh+lAW4+16wdkn4A
	 8sX7D9/XomRx8okcZh8B5mOZDPdWZECE9I6gohyHmsAokhtTLNYjk9CRSy/v65VLimlLr
	 94Uvqxz8p6Q0iz3Dr5oIMrQX35rQ3Jf3azkexHGHZ4as8fSoZuoMEChc3TzMCbjeU0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793112273;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:User-Agent:
	 MIME-Version:Date:Subject:Message-ID:X-Forward:Content-Type:
	 Content-Transfer-Encoding:X-Virus-Scanned:X-Virus-Status;
	bh=w1XIr6uPRRwmwiLfzOkw599+IW1p4hVv1Ax/BteY3F4=;
	b=U5OaoyRfq6d3yrsNzUOTDZ8HoOX3hx56grQCZ7cKm1LG++bWtU3SJSsNwT/N7lzO5bwV
	 NnalsTlKpnxIoYQMCViXEufgnyil0xyXG6pkASFMxpH9FSGfX4Z+bZIzZuQb14rqd4VR7
	 0gaTep65L6Z3nb0ZjXHLABX7t8DUdRIkwUbfhmphrE6niatGnQvdka7YeVC+Go40UQf/E
	 Cv3bnK/e8MbElHhN2L/DGimOjbPoiWr8KVz1HB9Hgxi+YGOE+0ezInN5Dxtp/zhSibzVH
	 oPNaRuNUcXQLIQ15T4c5+jEPNOBg9mUToQMW0gmD/SI2b4HKrqwuWftANzIhz19unEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=eventlab.fr;
	spf=pass smtp.mailfrom=eventlab.fr;
	dkim=permerror header.d=eventlab.fr header.i=@eventlab.fr header.a=ed25519-sha256 header.s=default header.b=BAGxMmyS;
	arc=none smtp.remote-ip=212.27.42.6
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CB7606A31B
	for <xenomai@lists.linux.dev>; Tue, 27 Oct 2026 14:44:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49CB7606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eventlab.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eventlab.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror header.d=eventlab.fr header.i=@eventlab.fr header.a=ed25519-sha256 header.s=default header.b=BAGxMmyS
Received: from mail.thom.fr.eu.org (unknown [82.64.149.25])
	by smtp6-g21.free.fr (Postfix) with ESMTPS id 427B7780368
	for <xenomai@lists.linux.dev>; Tue, 27 Oct 2026 15:44:30 +0100 (CET)
Authentication-Results: smtp6-g21.free.fr;
	dkim=permerror header.d=eventlab.fr header.i=@eventlab.fr header.a=ed25519-sha256 header.s=default header.b=BAGxMmyS;
	dkim-atps=neutral
Received: from localhost ([127.0.0.1])
	by mail.thom.fr.eu.org (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTP id 69REiT6t1367244
	for <xenomai@lists.linux.dev>; Tue, 27 Oct 2026 15:44:29 +0100
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple; d=eventlab.fr;
	s=default; t=1793112269;
	bh=gc6P0fW4LbGhJWrE4g2tX/C3+meyhnv7NVubalEteX4=;
	h=From:To:Date:Subject;
	b=BAGxMmyS3f+pduMmizf/XF4ugcDC1DtJLZ0ixLaEBVD/f9tbiz5LoR9iPYiR69pDr
	 n1X1+8+dpSIOjUJ8zhmxuuRkr2gDChL7B9gH+w6yN4Hw+7IKpsGCdAZDhiWxHJnXnZ
	 zK6Q7lb6qx6NjJj6BjxkA/IY/y2I3qhjk6q+c49aKJwMFKeYTvNom+UgidKc4sHeW6
	 wwPH1F72x/lDiaZ9Fhrr5JX4PLYTMUR7yD0bz4ILx9nQbx40c+EWdn+/yAs6HvpTK8
	 KydQJa/OUCKalKy5lHJuNAozuIqQ9g3/pP59mS5gysD5aPcx6ohB//SVTfVxNAhNnD
	 6ALMz+vZLg9Zg==
From: =?utf-8?q?Fran=C3=A7ois_Legal?= <francois.legal@eventlab.fr>
To: xenomai@lists.linux.dev
User-Agent: SOGoMail 5.0.1
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Date: Tue, 27 Oct 2026 15:44:29 +0100
Subject: BUG at system boot
Message-ID: <1209-6ae0b900-157-5a2d1100@131697478>
X-Forward: 217.109.173.233, 194.9.103.72
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 1.4.3 at tls-srv-02
X-Virus-Status: Clean

Switching my setup from linux 5.4 Ipipe + Xenomai 3.2 to Linux 6.12 + d=
ovetail + Xenomai 3.3, I experience the follwing BUG() at system boot. =
Machine is zynq7000 SoC :

[    0.000000] L2C: platform modifies aux control register: 0x02060000 =
-> 0x02460000
[    0.000000] L2C: DT/platform modifies aux control register: 0x020600=
00 -> 0x02460000
[    0.000000] L2C-310 enabling early BRESP for Cortex-A9
[    0.000000] L2C-310 full line of zeros enabled for Cortex-A9
[    0.000000] L2C-310 dynamic clock gating enabled, standby mode enabl=
ed
[    0.000000] L2C-310 cache controller enabled, 8 ways, 512 kB
[    0.000000] L2C-310: CACHE=5FID 0x410000c8, AUX=5FCTRL 0x46460001
[    0.000000] ------------[ cut here ]------------
[    0.000000] WARNING: CPU: 0 PID: 0 at kernel/irq/pipeline.c:1873 irq=
=5Fpipeline=5Finit+0x40/0x158
[    0.000000] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.12.90=
-cip24-yocto-standard-arksv #1
[    0.000000] Hardware name: Xilinx Zynq Platform
[    0.000000] IRQ stage: Linux
[    0.000000] Call trace: 
[    0.000000]  dump=5Fbacktrace from show=5Fstack+0x18/0x1c
[    0.000000]  r7:c0c08f40 r6:c0a94cc8 r5:00000000 r4:00000080
[    0.000000]  show=5Fstack from dump=5Fstack=5Flvl+0x94/0xc8
[    0.000000]  dump=5Fstack=5Flvl from dump=5Fstack+0x18/0x1c
[    0.000000]  r7:00000751 r6:00000009 r5:c0b0e65c r4:c0a65b0c
[    0.000000]  dump=5Fstack from =5F=5Fwarn+0x80/0xe0
[    0.000000]  =5F=5Fwarn from warn=5Fslowpath=5Ffmt+0x1b0/0x1bc
[    0.000000]  r7:00000000 r6:c0a65b0c r5:c0c08f40 r4:c0b4268c
[    0.000000]  warn=5Fslowpath=5Ffmt from irq=5Fpipeline=5Finit+0x40/0=
x158
[    0.000000]  r8:1eb76000 r7:00000000 r6:00000000 r5:c0c97038 r4:c0c9=
7000
[    0.000000]  irq=5Fpipeline=5Finit from start=5Fkernel+0x3f8/0x568
[    0.000000]  r5:c0c97038 r4:c0c97000
[    0.000000]  start=5Fkernel from 0x0
[    0.000000]  r7:00000000
[    0.000000] ---[ end trace 0000000000000000 ]---
[    0.000000] IRQ pipeline enabled
[    0.000000] rcu: srcu=5Finit: Setting srcu=5Fstruct sizes based on c=
ontention.
[    0.000000] zynq=5Fclock=5Finit: clkc starts at (ptrval)
[    0.000000] Zynq clock init

I don't really know how to chase this.

Fran=C3=A7ois

