Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.136.64.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793626041;
	b=cwfDOJSFlb/5GU/mWf/IdiO1HSWf4gNp/fvuID6BL9kuEUJIcfjgnbk5AB967aNVrhrC
	 8lKyy/BFrkk7KWsIQGTJX8WGVmmOQZ0mIaRTHuLvuhMr8N0NerMtJczO82SXqG2g9GjLl
	 cCgayfiAMt/xxD/4FslDSjAvxPbth5WBqMGj0HfMZMZIefCbSc3PKoANbRiif8Hasm1JQ
	 j2lb6hVeNOXy1idUHtIxuahdI0afn2RLFH0aNKpwhjm6nxZVyBj+I0Qp3RWBRhI6elN3Z
	 DhtrZFrTrNZigcOmRZGwOgoGMHVdWMDmG0zW6a89rn9JOYaZjIp9BJMzFlILjHQqbyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793626041;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 MIME-Version:X-Flowmailer-Platform:Feedback-ID;
	bh=aYGgZDtsN9QWWuRCzPX9tklxYF2ZzOxK3nmC9LNvaIc=;
	b=QVSvqYavflon876Xmbkga48LFPj2of+8Bobv5YXeYiPcBP3eK7EcZPRrtcpqI8DugcAp
	 LZkP1JpktBhXO1qGbVCFqn/ZThm1m0Z3pcn8ii+fE+8+yEwsQ/CuAn2n/ZeMQzUzVYcJy
	 Sm7CFSiadKRgr6L6pQx2B2bftHv5xNUQGNtv3fRPoS2XdYaZlBaD4Kd8Do8Z4xA1wRpVu
	 huz8TqmzkSICARLcSvDo08F9fwbJ2iBZtTVXkEzKUFZ/0dbV3QYpJCf75CLaOALcmQHjz
	 qdfrsYk0g0d2QbFoJ52n4ZNx22KZwTJxQxZsX2zPQui9yNrig8vfgNf9qdjmUKQ/2lQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=rts-flowmailer.siemens.com;
	dkim=pass header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm2 header.b=E+Ecko9b;
	arc=none smtp.remote-ip=185.136.64.226
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32407606A324
	for <xenomai@lists.linux.dev>; Mon,  2 Nov 2026 13:27:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32407606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm2 header.b=E+Ecko9b
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202611021327117297f0b6c60002078c
        for <xenomai@lists.linux.dev>;
        Mon, 02 Nov 2026 14:27:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=aYGgZDtsN9QWWuRCzPX9tklxYF2ZzOxK3nmC9LNvaIc=;
 b=E+Ecko9b0BpLWQBt55m2+/PeF9CbdQjIXKy5WdvP2s8oZj6/7YU+R4PxPuzGh5eojAukcE
 O16C4x80xGmPscmrH9NckyoAnSvHZbr/4BnpgDVIsmzNb9zt6traDtHKLT6Iuk9nHT5vYOOX
 5gHzvtmKmt+c9v+6qKZXQcpgKl1lCmM6J1KwlS88qXyA92k92GKoIu8oxurR4Rs1lxv0V0cG
 FHDUTcwHKlW8q4mVfJZqS43dFjor5eiT4kVqvlv3KjwCVf+7OqTkAYGeXbYAaCIr+CXM8ILK
 Fnem2SOlOfrV1Dy4FkDdslk6c0s5goBUGhGXx56Lp84O8vZpPCfAd/AA==;
Message-ID: <8bce78d242be8c494e814ea5602a40524507bfd3.camel@siemens.com>
Subject: Re: BUG at system boot
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: =?ISO-8859-1?Q?Fran=E7ois?= Legal <francois.legal@eventlab.fr>
Cc: xenomai@lists.linux.dev, Philippe Gerum <rpm@xenomai.org>, Jan Kiszka
	 <jan.kiszka@siemens.com>
Date: Mon, 02 Nov 2026 14:27:11 +0100
In-Reply-To: <115efd-6ae46d80-d-36f80d40@211094600>
References: <115efd-6ae46d80-d-36f80d40@211094600>
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

On Fri, 2026-10-30 at 11:11 +0100, Fran=C3=A7ois Legal wrote:
> Le Jeudi, Octobre 29, 2026 14:26 CET, Florian Bezdeka <florian.bezdeka@si=
emens.com> a =C3=A9crit:=20
> =20
> > On Wed, 2026-10-28 at 17:37 +0100, Fran=C3=A7ois Legal wrote:
> > > Le Mercredi, Octobre 28, 2026 11:15 CET, Florian Bezdeka <florian.bez=
deka@siemens.com> a =C3=A9crit:=20
> > > =C2=A0
> > > > On Wed, 2026-10-28 at 09:36 +0100, Fran=C3=A7ois Legal wrote:
> > > > > Le Mardi, Octobre 27, 2026 16:08 CET, Florian Bezdeka <florian.be=
zdeka@siemens.com> a =C3=A9crit:=20
> > > > > =C2=A0
> > > > > > On Tue, 2026-10-27 at 15:44 +0100, Fran=C3=A7ois Legal wrote:
> > > > > > > Switching my setup from linux 5.4 Ipipe + Xenomai 3.2 to Linu=
x 6.12 + dovetail + Xenomai 3.3, I experience the follwing BUG() at system =
boot. Machine is zynq7000 SoC :
> > > > > > >=20
> > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C: platform modifies aux cont=
rol register: 0x02060000 -> 0x02460000
> > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C: DT/platform modifies aux c=
ontrol register: 0x02060000 -> 0x02460000
> > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C-310 enabling early BRESP fo=
r Cortex-A9
> > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C-310 full line of zeros enab=
led for Cortex-A9
> > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C-310 dynamic clock gating en=
abled, standby mode enabled
> > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C-310 cache controller enable=
d, 8 ways, 512 kB
> > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C-310: CACHE_ID 0x410000c8, A=
UX_CTRL 0x46460001
> > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] ------------[ cut here ]-------=
-----
> > > > > >=20
> > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] WARNING: CPU: 0 PID: 0 at kerne=
l/irq/pipeline.c:1873 irq_pipeline_init+0x40/0x158
> > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] CPU: 0 UID: 0 PID: 0 Comm: swap=
per/0 Not tainted 6.12.90-cip24-yocto-standard-arksv #1
> > > > > >=20
> > > > > > That version is a bit outdated already. Could you please repeat=
 the test
> > > > > > with the current version in the v6.12.y-cip-dovetail-rebase bra=
nch, just
> > > > > > to make sure the problem has not already been fixed.
> > > > > >=20
> > > > > > On first glance that looks like an IRQ pipeline state corruptio=
n. I
> > > > > > fixed some of them recently, so please give it a try.
> > > > > >=20
> > > > > > The non-rebase branch - the version you are using - has not bee=
n updated
> > > > > > yet. Let's wait for your test results. If successful we can ask=
 Jan to
> > > > > > do a stable release.
> > > > > >=20
> > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] Hardware name: Xilinx Zynq Plat=
form
> > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] IRQ stage: Linux
> > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] Call trace:=20
> > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 dump_backtrace from show_=
stack+0x18/0x1c
> > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r7:c0c08f40 r6:c0a94cc8 r=
5:00000000 r4:00000080
> > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 show_stack from dump_stac=
k_lvl+0x94/0xc8
> > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 dump_stack_lvl from dump_=
stack+0x18/0x1c
> > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r7:00000751 r6:00000009 r=
5:c0b0e65c r4:c0a65b0c
> > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 dump_stack from __warn+0x=
80/0xe0
> > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 __warn from warn_slowpath=
_fmt+0x1b0/0x1bc
> > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r7:00000000 r6:c0a65b0c r=
5:c0c08f40 r4:c0b4268c
> > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 warn_slowpath_fmt from ir=
q_pipeline_init+0x40/0x158
> > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r8:1eb76000 r7:00000000 r=
6:00000000 r5:c0c97038 r4:c0c97000
> > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 irq_pipeline_init from st=
art_kernel+0x3f8/0x568
> > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r5:c0c97038 r4:c0c97000
> > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 start_kernel from 0x0
> > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r7:00000000
> > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] ---[ end trace 0000000000000000=
 ]---
> > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] IRQ pipeline enabled
> > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] rcu: srcu_init: Setting srcu_st=
ruct sizes based on contention.
> > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] zynq_clock_init: clkc starts at=
 (ptrval)
> > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] Zynq clock init
> > > > > > >=20
> > > > > > > I don't really know how to chase this.
> > > > > > >=20
> > > > > > > Fran=C3=A7ois
> > > > > =C2=A0
> > > > > =C2=A0I switched to the tip of that branch. I get the same result=
 :
> > > > >=20
> > > > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C-310 dynamic clock gating enable=
d, standby mode enabled
> > > > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C-310 cache controller enabled, 8=
 ways, 512 kB
> > > > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C-310: CACHE_ID 0x410000c8, AUX_C=
TRL 0x46460001
> > > > > [=C2=A0=C2=A0=C2=A0 0.000000] ------------[ cut here ]-----------=
-
> > > > > [=C2=A0=C2=A0=C2=A0 0.000000] WARNING: CPU: 0 PID: 0 at kernel/ir=
q/pipeline.c:1866 irq_pipeline_init+0x40/0x158
> > > > > [=C2=A0=C2=A0=C2=A0 0.000000] CPU: 0 UID: 0 PID: 0 Comm: swapper/=
0 Not tainted 6.12.96-cip28-yocto-standard-arksv #1
> > > > > [=C2=A0=C2=A0=C2=A0 0.000000] Hardware name: Xilinx Zynq Platform
> > > > > [=C2=A0=C2=A0=C2=A0 0.000000] IRQ stage: Linux
> > > > > [=C2=A0=C2=A0=C2=A0 0.000000] Call trace:
> > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 dump_backtrace from show_stac=
k+0x18/0x1c
> > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r7:c0c08f40 r6:c0a951a4 r5:00=
000000 r4:00000080
> > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 show_stack from dump_stack_lv=
l+0x94/0xc8
> > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 dump_stack_lvl from dump_stac=
k+0x18/0x1c
> > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r7:0000074a r6:00000009 r5:c0=
b0e65c r4:c0a65fe8
> > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 dump_stack from __warn+0x80/0=
xe0
> > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 __warn from warn_slowpath_fmt=
+0x1b0/0x1bc
> > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r7:00000000 r6:c0a65fe8 r5:c0=
c08f40 r4:c0b4268c
> > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 warn_slowpath_fmt from irq_pi=
peline_init+0x40/0x158
> > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r8:1eb76000 r7:00000000 r6:00=
000000 r5:c0c97038 r4:c0c97000
> > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 irq_pipeline_init from start_=
kernel+0x3f8/0x568
> > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r5:c0c97038 r4:c0c97000
> > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 start_kernel from 0x0
> > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r7:00000000
> > > > > [=C2=A0=C2=A0=C2=A0 0.000000] ---[ end trace 0000000000000000 ]--=
-
> > > > > [=C2=A0=C2=A0=C2=A0 0.000000] IRQ pipeline enabled
> > > > > [=C2=A0=C2=A0=C2=A0 0.000000] rcu: srcu_init: Setting srcu_struct=
 sizes based on contention.
> > > > >=20
> > > > >=20
> > > >=20
> > > > Might be related:=20
> > > > https://lore.kernel.org/xenomai/CAKndYJGo5Yu7Ak694tX=3DcqRjtJneXs22=
DPjz=3DUDVkUcNJMWyOA@mail.gmail.com/
> > > >=20
> > > > Quote:
> > > >=20
> > > > > It actually booted as soon as I disabled the "scutimer" clock sou=
rce
> > > > > via the DTB.=C2=A0 This made the kernel fall back to "arm_global_=
timer" and
> > > > > now it boots properly.
> > > >=20
> > >=20
> > > Well, I had this problem a while back at my first dovetail attempt (w=
as on linux 5.15 IIRC). Switching to 6.12, the system started correctly at =
first try (except for that BUG signaled).
> > > I even experience pretty good RT performance (about the same I had wi=
th IPIPE)
> > >=20
> > > > There are a couple of "hacks" mentioned in the mail thread that you
> > > > could try and report back.
> > > >=20
> > > > Couple of questions:
> > > >=20
> > > > - Does the board boot up with CONFIG_IRQ_PIPELINE disabled?
> > > > - Have you tried enabling=20
> > > > =C2=A0=C2=A0=C2=A0 - CONFIG_DEBUG_IRQ_PIPELINE
> > > > =C2=A0=C2=A0=C2=A0 - CONFIG_IRQ_PIPELINE_TORTURE_TEST
> > > >=20
> > > > Best regards,
> > > > Florian
> > > =C2=A0
> > > I can see no differences with these options activated (apart from cus=
tom kernel driver that need to be fixed, but that will be another thread if=
 I can't fix it myself).
> > > You can find the complete bootlog attached.
> > >=20
> >=20
> > The hardware IRQ state is unexpected in your case. Hard IRQs are enable=
d
> > where they are expected to be disabled. Quite early in the boot process=
.
> >=20
> > It might help to enable CONFIG_PROVE_LOCKING (enable lockdep). That
> > might tell us where hard IRQs were enabled before we reached the check.=
=20
> >=20
>=20
> I just tried the CONFIG_PROVE_LOCKING option. Unfortunately, it seems the=
 detector gets activated way after the inital BUG occurs.
>=20
> I also reviewed the Zynq clock init part, however, I'm not really sur to =
know what I'm looking for. I can tell that this is registering the clock tr=
ee elements within the kernel, and that some couples of spin_lock_irqsave/s=
pin_lock_irqrestore are in the way.
>=20

I just send out a patch [1] for another trap handling issue that Jan
found while trying to do some stable updates. I have no other idea ATM.

[1] https://lore.kernel.org/xenomai/20261102125420.702769-1-florian.bezdeka=
@siemens.com/T/#u

Any further ideas from Philippe or Jan?
