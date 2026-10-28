Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.27.42.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793176617;
	b=TmWD1UNaK1lWJJsyKvVkUrQ2YOO9TUNrRfPm6vHt0lWV2Q+gmww9eq/mV19lPtQthkM4
	 rq/6u9IvgV/buCLD/yO+3zcxEnt0dKui0sigIy2VYCJyaLBS82Ouq+OrXwV8fth3hxpsb
	 6urLq09OZv9Se6chw7Q9rvTwq/bAZHfMUmH1ZgS78Tp+PfQdzUcV6spHOtgBh1qSoBbsN
	 pLu/P8/QXSQLFBT1i6vu4r72NwWCxWzagiVCmaOSnv36ESia8Gr+vN20SetMf0N9/ydQ5
	 JItp0G+246h5jivMLtPVHa+jKcrhXrsxpQF0LCVUxoIlaX8L5TrraJbjNJT5isaVxbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793176617;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:In-Reply-To:
	 Content-Type:X-Forward:Date:Cc:To:MIME-Version:Message-ID:Subject:
	 User-Agent:Content-Transfer-Encoding:X-Virus-Scanned:X-Virus-Status;
	bh=x2RqZUkAaPOU1kisogkH1Q5xMWP7sGszba2NvJfFygc=;
	b=QfiJKURE/paNl1/E3rcpqNHAbVqw4zdNsPU5RXhBr5w5jr9wMrZpR1A6NytgyhZzOWk9
	 f2iCY7kIXb7o3H6cOBgb2b6m5aa20rbPX5UiRayXN6ZKJqxMHDn15Zq0exlE5u+TZQlq/
	 aSlu31uu56YdUrvvN/N/KqX4c6PqUb0CjDNg9XZE6KpFLxk5WCQdup3JaGwSlTxQWMwaz
	 CXFmLxJ7/SQZn42mdRGt7H+hDvo727Xv5bmVIVxLZDhevkVvXiHYi1AegmwQYdb7G9p4C
	 oHqv2Jl410ZTSqGl3tcn10LGgg2Spq8tYbQM99SYBKlBQaChDgTTAuUxjFi6N5+OX+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=eventlab.fr;
	spf=pass smtp.mailfrom=eventlab.fr;
	dkim=permerror header.d=eventlab.fr header.i=@eventlab.fr header.a=ed25519-sha256 header.s=default header.b=joUsRuqn;
	arc=none smtp.remote-ip=212.27.42.6
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23065606A31D
	for <xenomai@lists.linux.dev>; Wed, 28 Oct 2026 08:36:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23065606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eventlab.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eventlab.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror header.d=eventlab.fr header.i=@eventlab.fr header.a=ed25519-sha256 header.s=default header.b=joUsRuqn
Received: from mail.thom.fr.eu.org (unknown [82.64.149.25])
	by smtp6-g21.free.fr (Postfix) with ESMTPS id B3F27780375;
	Wed, 28 Oct 2026 09:36:51 +0100 (CET)
Authentication-Results: smtp6-g21.free.fr;
	dkim=permerror header.d=eventlab.fr header.i=@eventlab.fr header.a=ed25519-sha256 header.s=default header.b=joUsRuqn;
	dkim-atps=neutral
Received: from localhost ([127.0.0.1])
	by mail.thom.fr.eu.org (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTP id 69S8anmf1401002;
	Wed, 28 Oct 2026 09:36:50 +0100
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple; d=eventlab.fr;
	s=default; t=1793176610;
	bh=PrIMSsVp64MFBswutq3sB8CIY9KSAhQ4zJcBqMB3PsA=;
	h=From:In-Reply-To:Date:Cc:To:Subject;
	b=joUsRuqnqaN4FL2S8gS9Z4CIGXjcH6arFS+GL1aYCm/E25ODs5b1snO72WtcrJHMu
	 6QZ/VsbTqvHt4HQbxduQEdXury8nFnbpF808EgUkCk/g09qoqrbFtbZuw51cj8i7yA
	 W+Y3nw9J84D92y9PYfAsfFE7YqVaLIaRG1f6ba2ly9kOys4VmeUjQ+jUQt93jghiau
	 timFIixZ9/qDtJltmNEypC6PJMDKkE1+mV7s20WdsoMAdDCsSrvqXbSK4/G2GC4NwJ
	 vRyAuyUfNivOaK/KNJvmCsmEP42GNKBodPOZxj/A+dke/7uA+Tw3Ja2mQFa+GaHTkY
	 tH4AXoDBQMJXQ==
From: =?utf-8?q?Fran=C3=A7ois_Legal?= <francois.legal@eventlab.fr>
In-Reply-To: <7c081db4d744ccbcc8ab6c92e3cf48d46a2ec3aa.camel@siemens.com>
Content-Type: text/plain; charset="utf-8"
X-Forward: 217.109.173.233, 194.9.103.72
Date: Wed, 28 Oct 2026 09:36:49 +0100
Cc: xenomai@lists.linux.dev
To: "Florian Bezdeka" <florian.bezdeka@siemens.com>
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Message-ID: <1207-6ae1b400-4f-3e404bc0@80379298>
Subject: =?utf-8?q?Re=3A?= BUG at system boot
User-Agent: SOGoMail 5.0.1
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 1.4.3 at tls-srv-02
X-Virus-Status: Clean

Le Mardi, Octobre 27, 2026 16:08 CET, Florian Bezdeka <florian.bezdeka@=
siemens.com> a =C3=A9crit: 
 
> On Tue, 2026-10-27 at 15:44 +0100, Fran=C3=A7ois Legal wrote:
> > Switching my setup from linux 5.4 Ipipe + Xenomai 3.2 to Linux 6.12=
 + dovetail + Xenomai 3.3, I experience the follwing BUG() at system bo=
ot. Machine is zynq7000 SoC :
> > 
> > [=C2=A0=C2=A0=C2=A0 0.000000] L2C: platform modifies aux control re=
gister: 0x02060000 -> 0x02460000
> > [=C2=A0=C2=A0=C2=A0 0.000000] L2C: DT/platform modifies aux control=
 register: 0x02060000 -> 0x02460000
> > [=C2=A0=C2=A0=C2=A0 0.000000] L2C-310 enabling early BRESP for Cort=
ex-A9
> > [=C2=A0=C2=A0=C2=A0 0.000000] L2C-310 full line of zeros enabled fo=
r Cortex-A9
> > [=C2=A0=C2=A0=C2=A0 0.000000] L2C-310 dynamic clock gating enabled,=
 standby mode enabled
> > [=C2=A0=C2=A0=C2=A0 0.000000] L2C-310 cache controller enabled, 8 w=
ays, 512 kB
> > [=C2=A0=C2=A0=C2=A0 0.000000] L2C-310: CACHE=5FID 0x410000c8, AUX=5F=
CTRL 0x46460001
> > [=C2=A0=C2=A0=C2=A0 0.000000] ------------[ cut here ]------------
> 
> > [=C2=A0=C2=A0=C2=A0 0.000000] WARNING: CPU: 0 PID: 0 at kernel/irq/=
pipeline.c:1873 irq=5Fpipeline=5Finit+0x40/0x158
> > [=C2=A0=C2=A0=C2=A0 0.000000] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 =
Not tainted 6.12.90-cip24-yocto-standard-arksv #1
> 
> That version is a bit outdated already. Could you please repeat the t=
est
> with the current version in the v6.12.y-cip-dovetail-rebase branch, j=
ust
> to make sure the problem has not already been fixed.
> 
> On first glance that looks like an IRQ pipeline state corruption. I
> fixed some of them recently, so please give it a try.
> 
> The non-rebase branch - the version you are using - has not been upda=
ted
> yet. Let's wait for your test results. If successful we can ask Jan t=
o
> do a stable release.
> 
> > [=C2=A0=C2=A0=C2=A0 0.000000] Hardware name: Xilinx Zynq Platform
> > [=C2=A0=C2=A0=C2=A0 0.000000] IRQ stage: Linux
> > [=C2=A0=C2=A0=C2=A0 0.000000] Call trace: 
> > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 dump=5Fbacktrace from show=5Fst=
ack+0x18/0x1c
> > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r7:c0c08f40 r6:c0a94cc8 r5:0000=
0000 r4:00000080
> > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 show=5Fstack from dump=5Fstack=5F=
lvl+0x94/0xc8
> > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 dump=5Fstack=5Flvl from dump=5F=
stack+0x18/0x1c
> > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r7:00000751 r6:00000009 r5:c0b0=
e65c r4:c0a65b0c
> > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 dump=5Fstack from =5F=5Fwarn+0x=
80/0xe0
> > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 =5F=5Fwarn from warn=5Fslowpath=
=5Ffmt+0x1b0/0x1bc
> > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r7:00000000 r6:c0a65b0c r5:c0c0=
8f40 r4:c0b4268c
> > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 warn=5Fslowpath=5Ffmt from irq=5F=
pipeline=5Finit+0x40/0x158
> > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r8:1eb76000 r7:00000000 r6:0000=
0000 r5:c0c97038 r4:c0c97000
> > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 irq=5Fpipeline=5Finit from star=
t=5Fkernel+0x3f8/0x568
> > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r5:c0c97038 r4:c0c97000
> > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 start=5Fkernel from 0x0
> > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r7:00000000
> > [=C2=A0=C2=A0=C2=A0 0.000000] ---[ end trace 0000000000000000 ]---
> > [=C2=A0=C2=A0=C2=A0 0.000000] IRQ pipeline enabled
> > [=C2=A0=C2=A0=C2=A0 0.000000] rcu: srcu=5Finit: Setting srcu=5Fstru=
ct sizes based on contention.
> > [=C2=A0=C2=A0=C2=A0 0.000000] zynq=5Fclock=5Finit: clkc starts at (=
ptrval)
> > [=C2=A0=C2=A0=C2=A0 0.000000] Zynq clock init
> > 
> > I don't really know how to chase this.
> > 
> > Fran=C3=A7ois
 
 I switched to the tip of that branch. I get the same result :

[    0.000000] L2C-310 dynamic clock gating enabled, standby mode enabl=
ed
[    0.000000] L2C-310 cache controller enabled, 8 ways, 512 kB
[    0.000000] L2C-310: CACHE=5FID 0x410000c8, AUX=5FCTRL 0x46460001
[    0.000000] ------------[ cut here ]------------
[    0.000000] WARNING: CPU: 0 PID: 0 at kernel/irq/pipeline.c:1866 irq=
=5Fpipeline=5Finit+0x40/0x158
[    0.000000] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.12.96=
-cip28-yocto-standard-arksv #1
[    0.000000] Hardware name: Xilinx Zynq Platform
[    0.000000] IRQ stage: Linux
[    0.000000] Call trace:
[    0.000000]  dump=5Fbacktrace from show=5Fstack+0x18/0x1c
[    0.000000]  r7:c0c08f40 r6:c0a951a4 r5:00000000 r4:00000080
[    0.000000]  show=5Fstack from dump=5Fstack=5Flvl+0x94/0xc8
[    0.000000]  dump=5Fstack=5Flvl from dump=5Fstack+0x18/0x1c
[    0.000000]  r7:0000074a r6:00000009 r5:c0b0e65c r4:c0a65fe8
[    0.000000]  dump=5Fstack from =5F=5Fwarn+0x80/0xe0
[    0.000000]  =5F=5Fwarn from warn=5Fslowpath=5Ffmt+0x1b0/0x1bc
[    0.000000]  r7:00000000 r6:c0a65fe8 r5:c0c08f40 r4:c0b4268c
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

Fran=C3=A7ois

