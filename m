Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.136.64.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793182560;
	b=v7kAoChgnhwVppt4H6BH45p1pboMIV9DAj8nYTKWibhx6TrO43GEYaU+0Ubxl6JQOS5f
	 bHEsKnB/qN4+gGMaYNnOcNtJwbgmsOqhtRedEV60nykZi/8uykPqeHH4s48GEwHDBjLib
	 rSXA+Mfmg3LA40nZZDUmWXa9nzH5HslM5/P3Wlz2/szkflB8ohvYXh1Hcz3OGQsZGlzOu
	 rFVWZVXahJCCixDyxxt8Hc0N1hlxWOjx9fQ23nYvvh5i1cVEMxrmWMzgqZcs6auquY0xD
	 +uUBr1CSqUuJaVasRjj7za529dyREPSYFgzZPEU3mRLzlmYNfiWFJmvZkGDTPkpyUgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793182560;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 MIME-Version:X-Flowmailer-Platform:Feedback-ID;
	bh=JB9Dmv/bNdenBOZQnghyVhCRA0oEM4z6cIAZebKvfb8=;
	b=R/E+d22JUtDzt6vANbZriGLyWWUa1AGbcWHM2AGg+6h+SyFr2TAeYV3pjAPN8wwwbA2r
	 N/RrggXFg3E5ZExAsLdzpHmdk0A+0hPjxn+sHhi6tSJ3BdfywJ3kxYPHQ0y+DxOtZEQ7y
	 bjHVyhLGkiPbKrd4qSlXGKQydzH70+TM++6IMFPhHIVnnNjKgK/WMWE+k0y0Bl1FfbPAi
	 nsVBD/jW5I6qmv7XBUYeFUzYv0op3sICIiKvrx2SsKq4UQv2S7OYjS2JwvsPq8JZcv7JF
	 aoGVvI1cpcBvZBsTUUpX7/KVAhPBKyiZB+H+lbNFnGjNiQ42CFbPLtsT4vdr2X5rcVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=rts-flowmailer.siemens.com;
	dkim=pass header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm2 header.b="HE/OXAEW";
	arc=none smtp.remote-ip=185.136.64.226
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE3B606A31A
	for <xenomai@lists.linux.dev>; Wed, 28 Oct 2026 10:15:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CE3B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm2 header.b=HE/OXAEW
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20261028101554b4efdd55ce00020787
        for <xenomai@lists.linux.dev>;
        Wed, 28 Oct 2026 11:15:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=JB9Dmv/bNdenBOZQnghyVhCRA0oEM4z6cIAZebKvfb8=;
 b=HE/OXAEWk10EOwrc+ySgstuo8tqK+IKWXjFrLPAmctGZ4q6BrPcUMz1eCmBFPgUASWFwhC
 jy8PQomUq93bNnOsuL6607NzLeum3NxPW4Yz6skPSOMrO1e7wC0Fqd1hH4eeV3wpVw/SYT2A
 zibGSc1XzUAKZ1Tzrlwzi7ptfQohFECRgIWIEGO3KNZBezhko3GVfO6hGnTyFJKgMerlY7GG
 nujw8IkkeZW06Cp1zU3GLG8b5J+km8SONOyZiiyLRVITuz8wKFQKjZrWdG7ohahRF3i3y6Lj
 ORFN9sWoTsuyxEGNpCswAvHhjE7l5mib1tGF0VthI4g/a2M8vGD1AnxQ==;
Message-ID: <1ea0b90ff44fa65bd4dd254b2cffcc9491fc33b4.camel@siemens.com>
Subject: Re: BUG at system boot
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: =?ISO-8859-1?Q?Fran=E7ois?= Legal <francois.legal@eventlab.fr>
Cc: xenomai@lists.linux.dev, Philippe Gerum <rpm@xenomai.org>
Date: Wed, 28 Oct 2026 11:15:53 +0100
In-Reply-To: <1207-6ae1b400-4f-3e404bc0@80379298>
References: <1207-6ae1b400-4f-3e404bc0@80379298>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

On Wed, 2026-10-28 at 09:36 +0100, Fran=C3=A7ois Legal wrote:
> Le Mardi, Octobre 27, 2026 16:08 CET, Florian Bezdeka <florian.bezdeka@si=
emens.com> a =C3=A9crit:=20
> =C2=A0
> > On Tue, 2026-10-27 at 15:44 +0100, Fran=C3=A7ois Legal wrote:
> > > Switching my setup from linux 5.4 Ipipe + Xenomai 3.2 to Linux 6.12 +=
 dovetail + Xenomai 3.3, I experience the follwing BUG() at system boot. Ma=
chine is zynq7000 SoC :
> > >=20
> > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C: platform modifies aux control regi=
ster: 0x02060000 -> 0x02460000
> > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C: DT/platform modifies aux control r=
egister: 0x02060000 -> 0x02460000
> > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C-310 enabling early BRESP for Cortex=
-A9
> > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C-310 full line of zeros enabled for =
Cortex-A9
> > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C-310 dynamic clock gating enabled, s=
tandby mode enabled
> > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C-310 cache controller enabled, 8 way=
s, 512 kB
> > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C-310: CACHE_ID 0x410000c8, AUX_CTRL =
0x46460001
> > > [=C2=A0=C2=A0=C2=A0 0.000000] ------------[ cut here ]------------
> >=20
> > > [=C2=A0=C2=A0=C2=A0 0.000000] WARNING: CPU: 0 PID: 0 at kernel/irq/pi=
peline.c:1873 irq_pipeline_init+0x40/0x158
> > > [=C2=A0=C2=A0=C2=A0 0.000000] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 No=
t tainted 6.12.90-cip24-yocto-standard-arksv #1
> >=20
> > That version is a bit outdated already. Could you please repeat the tes=
t
> > with the current version in the v6.12.y-cip-dovetail-rebase branch, jus=
t
> > to make sure the problem has not already been fixed.
> >=20
> > On first glance that looks like an IRQ pipeline state corruption. I
> > fixed some of them recently, so please give it a try.
> >=20
> > The non-rebase branch - the version you are using - has not been update=
d
> > yet. Let's wait for your test results. If successful we can ask Jan to
> > do a stable release.
> >=20
> > > [=C2=A0=C2=A0=C2=A0 0.000000] Hardware name: Xilinx Zynq Platform
> > > [=C2=A0=C2=A0=C2=A0 0.000000] IRQ stage: Linux
> > > [=C2=A0=C2=A0=C2=A0 0.000000] Call trace:=20
> > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 dump_backtrace from show_stack+0x=
18/0x1c
> > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r7:c0c08f40 r6:c0a94cc8 r5:000000=
00 r4:00000080
> > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 show_stack from dump_stack_lvl+0x=
94/0xc8
> > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 dump_stack_lvl from dump_stack+0x=
18/0x1c
> > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r7:00000751 r6:00000009 r5:c0b0e6=
5c r4:c0a65b0c
> > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 dump_stack from __warn+0x80/0xe0
> > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 __warn from warn_slowpath_fmt+0x1=
b0/0x1bc
> > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r7:00000000 r6:c0a65b0c r5:c0c08f=
40 r4:c0b4268c
> > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 warn_slowpath_fmt from irq_pipeli=
ne_init+0x40/0x158
> > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r8:1eb76000 r7:00000000 r6:000000=
00 r5:c0c97038 r4:c0c97000
> > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 irq_pipeline_init from start_kern=
el+0x3f8/0x568
> > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r5:c0c97038 r4:c0c97000
> > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 start_kernel from 0x0
> > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r7:00000000
> > > [=C2=A0=C2=A0=C2=A0 0.000000] ---[ end trace 0000000000000000 ]---
> > > [=C2=A0=C2=A0=C2=A0 0.000000] IRQ pipeline enabled
> > > [=C2=A0=C2=A0=C2=A0 0.000000] rcu: srcu_init: Setting srcu_struct siz=
es based on contention.
> > > [=C2=A0=C2=A0=C2=A0 0.000000] zynq_clock_init: clkc starts at (ptrval=
)
> > > [=C2=A0=C2=A0=C2=A0 0.000000] Zynq clock init
> > >=20
> > > I don't really know how to chase this.
> > >=20
> > > Fran=C3=A7ois
> =C2=A0
> =C2=A0I switched to the tip of that branch. I get the same result :
>=20
> [=C2=A0=C2=A0=C2=A0 0.000000] L2C-310 dynamic clock gating enabled, stand=
by mode enabled
> [=C2=A0=C2=A0=C2=A0 0.000000] L2C-310 cache controller enabled, 8 ways, 5=
12 kB
> [=C2=A0=C2=A0=C2=A0 0.000000] L2C-310: CACHE_ID 0x410000c8, AUX_CTRL 0x46=
460001
> [=C2=A0=C2=A0=C2=A0 0.000000] ------------[ cut here ]------------
> [=C2=A0=C2=A0=C2=A0 0.000000] WARNING: CPU: 0 PID: 0 at kernel/irq/pipeli=
ne.c:1866 irq_pipeline_init+0x40/0x158
> [=C2=A0=C2=A0=C2=A0 0.000000] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not ta=
inted 6.12.96-cip28-yocto-standard-arksv #1
> [=C2=A0=C2=A0=C2=A0 0.000000] Hardware name: Xilinx Zynq Platform
> [=C2=A0=C2=A0=C2=A0 0.000000] IRQ stage: Linux
> [=C2=A0=C2=A0=C2=A0 0.000000] Call trace:
> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 dump_backtrace from show_stack+0x18/0=
x1c
> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r7:c0c08f40 r6:c0a951a4 r5:00000000 r=
4:00000080
> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 show_stack from dump_stack_lvl+0x94/0=
xc8
> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 dump_stack_lvl from dump_stack+0x18/0=
x1c
> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r7:0000074a r6:00000009 r5:c0b0e65c r=
4:c0a65fe8
> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 dump_stack from __warn+0x80/0xe0
> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 __warn from warn_slowpath_fmt+0x1b0/0=
x1bc
> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r7:00000000 r6:c0a65fe8 r5:c0c08f40 r=
4:c0b4268c
> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 warn_slowpath_fmt from irq_pipeline_i=
nit+0x40/0x158
> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r8:1eb76000 r7:00000000 r6:00000000 r=
5:c0c97038 r4:c0c97000
> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 irq_pipeline_init from start_kernel+0=
x3f8/0x568
> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r5:c0c97038 r4:c0c97000
> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 start_kernel from 0x0
> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r7:00000000
> [=C2=A0=C2=A0=C2=A0 0.000000] ---[ end trace 0000000000000000 ]---
> [=C2=A0=C2=A0=C2=A0 0.000000] IRQ pipeline enabled
> [=C2=A0=C2=A0=C2=A0 0.000000] rcu: srcu_init: Setting srcu_struct sizes b=
ased on contention.
>=20
>=20

Might be related:=20
https://lore.kernel.org/xenomai/CAKndYJGo5Yu7Ak694tX=3DcqRjtJneXs22DPjz=3DU=
DVkUcNJMWyOA@mail.gmail.com/

Quote:

> It actually booted as soon as I disabled the "scutimer" clock source
> via the DTB.  This made the kernel fall back to "arm_global_timer" and
> now it boots properly.

There are a couple of "hacks" mentioned in the mail thread that you
could try and report back.

Couple of questions:

- Does the board boot up with CONFIG_IRQ_PIPELINE disabled?
- Have you tried enabling=20
   - CONFIG_DEBUG_IRQ_PIPELINE
   - CONFIG_IRQ_PIPELINE_TORTURE_TEST

Best regards,
Florian
