Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.136.65.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793918815;
	b=DxcSGNWSCcRsTg5IVwQF0PqtMvjuQALYJGmQdzFJuKwev5AZ7rYMK4TqpA+X/yk6cA6N
	 dSMpU6BeeDUUnAsYVa5fEqTR73V9Sc0M64N0WwBBvKWkt1CMQ0pgbTTFXxIeR1IGdRLJR
	 p1WOn/ojdAoiiLmAZg2jkAQIgsyYRYm6X+NCZp+2KqWW7Aa1wGjrGKRVzpr9MMkQa1TcV
	 3sJLGVJ5XHpRyeQ4XHEyrOHLZV8+54Z8jXlqcaOzUBum9X/weR0QHFpdkFyHFA2/4ylaf
	 xliwEcRVVwTOS+mgXlVlPVOQtKmY1rxprImIwFUhjqAQNVJ2IeY6XqUSeLT2gGlIw1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793918815;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 MIME-Version:X-Flowmailer-Platform:Feedback-ID;
	bh=8Y/TkriMnmxuTx3a4W5HbJwEnOJp1CoAQ/CmcAELXEI=;
	b=cCAd401Z7pd/iKzLnrq0Jt+hSqJZR02M6ifbtMjLafoCAtI1m77m3hLUZlZYU0TNsNHL
	 8w88EZKJthd7afJjhllDNQDFTPEW11JEqIeUlHHnBAtLBXwZbW6qyv5BcTnlktxGbGkdm
	 2hhDoygokmwmYJKxpVW7Kw3cp9ULzKk0ziFaR/LCZWjRISPNOMiaaep63PPOYZ/JKuPjs
	 G9jc2+Oshd3bHqruaGAbzooK9AmaQWlIs/Dlb1rxO1W6R20CfcPG328a8tFshsu/fAezY
	 w1et7INl18rOTv8frZjXyUGtb2exNiHMmwk25ZS98ykbriwxtEzcRMl2N3k6r3YTuDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=rts-flowmailer.siemens.com;
	dkim=pass header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm2 header.b=FWSVA1Pr;
	arc=none smtp.remote-ip=185.136.65.226
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69338606A31B
	for <xenomai@lists.linux.dev>; Thu,  5 Nov 2026 22:46:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69338606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm2 header.b=FWSVA1Pr
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202611052246514464debb4b000207e3
        for <xenomai@lists.linux.dev>;
        Thu, 05 Nov 2026 23:46:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=8Y/TkriMnmxuTx3a4W5HbJwEnOJp1CoAQ/CmcAELXEI=;
 b=FWSVA1PrCuzMrJyn6NRBDP2/GqlTs76jymo8xuGvZknWvx88r7KU1r0AAnIP7VnHY4MmM1
 Hb8E1ZiD6I03rZ7DRrJsVNhUOkh9IWBn7X89X3BoMuXuoURXLkCyuovRosTGtFgCx3vOhuDN
 w62Q9RfhzExw+gsQGqkuU9U13PWONX8vRf19tg64WmVtt2ZcoUGQOc87VQbxwhkTgaxSJOwV
 mOjiVRsXlBh5gFEsSS8hwQaHQDA3rfdM2tHr1NrCtDf8xpcWbbGB/d5fSIXLvmnNZCBD8qup
 M6/1LE4qIEuMGrkaXBxKU8d1FcmX06F3smt5ahAGm1W7HQm5ibbbiQdw==;
Message-ID: <58f2f4501e0160436bc72c36f61e592dead7ae81.camel@siemens.com>
Subject: Re: BUG at system boot
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: =?ISO-8859-1?Q?Fran=E7ois?= Legal <francois.legal@eventlab.fr>, 
	xenomai@lists.linux.dev
Cc: rpm@xenomai.org, jan.kiszka@siemens.com
Date: Thu, 05 Nov 2026 23:46:50 +0100
In-Reply-To: <7636bed28170d3058f4d8db55fd6e4f997617332.camel@siemens.com>
References: <1207-6aeca000-53-3e404bc0@80379397>
	 <7636bed28170d3058f4d8db55fd6e4f997617332.camel@siemens.com>
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

On Thu, 2026-11-05 at 21:00 +0100, Florian Bezdeka wrote:
> On Thu, 2026-11-05 at 16:25 +0100, Fran=C3=A7ois Legal wrote:
> > Le Jeudi, Novembre 05, 2026 11:54 CET, Fran=C3=A7ois Legal <francois.le=
gal@eventlab.fr> a =C3=A9crit:=20
> > =C2=A0
> > > Le Lundi, Novembre 02, 2026 14:27 CET, Florian Bezdeka <florian.bezde=
ka@siemens.com> a =C3=A9crit:=20
> > > =C2=A0=20
> > > > On Fri, 2026-10-30 at 11:11 +0100, Fran=C3=A7ois Legal wrote:
> > > > > Le Jeudi, Octobre 29, 2026 14:26 CET, Florian Bezdeka <florian.be=
zdeka@siemens.com> a =C3=A9crit:=20
> > > > > =C2=A0=20
> > > > > > On Wed, 2026-10-28 at 17:37 +0100, Fran=C3=A7ois Legal wrote:
> > > > > > > Le Mercredi, Octobre 28, 2026 11:15 CET, Florian Bezdeka <flo=
rian.bezdeka@siemens.com> a =C3=A9crit:=20
> > > > > > > =C2=A0
> > > > > > > > On Wed, 2026-10-28 at 09:36 +0100, Fran=C3=A7ois Legal wrot=
e:> > > > > > Le Mardi, Octobre 27, 2026 16:08 CET, Florian Bezdeka <floria=
n.bezdeka@siemens.com> a =C3=A9crit:=20
> > > > > > > > > =C2=A0
> > > > > > > > > > On Tue, 2026-10-27 at 15:44 +0100, Fran=C3=A7ois Legal =
wrote:
> > > > > > > > > > > Switching my setup from linux 5.4 Ipipe + Xenomai 3.2=
 to Linux 6.12 + dovetail + Xenomai 3.3, I experience the follwing BUG() at=
 system boot. Machine is zynq7000 SoC :
> > > > > > > > > > >=20
> > > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C: platform modifies =
aux control register: 0x02060000 -> 0x02460000
> > > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C: DT/platform modifi=
es aux control register: 0x02060000 -> 0x02460000
> > > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C-310 enabling early =
BRESP for Cortex-A9
> > > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C-310 full line of ze=
ros enabled for Cortex-A9
> > > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C-310 dynamic clock g=
ating enabled, standby mode enabled
> > > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C-310 cache controlle=
r enabled, 8 ways, 512 kB
> > > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C-310: CACHE_ID 0x410=
000c8, AUX_CTRL 0x46460001
> > > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] ------------[ cut here =
]------------
> > > > > > > > > >=20
> > > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] WARNING: CPU: 0 PID: 0 =
at kernel/irq/pipeline.c:1873 irq_pipeline_init+0x40/0x158
> > > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] CPU: 0 UID: 0 PID: 0 Co=
mm: swapper/0 Not tainted 6.12.90-cip24-yocto-standard-arksv #1
> > > > > > > > > >=20
> > > > > > > > > > That version is a bit outdated already. Could you pleas=
e repeat the test
> > > > > > > > > > with the current version in the v6.12.y-cip-dovetail-re=
base branch, just
> > > > > > > > > > to make sure the problem has not already been fixed.
> > > > > > > > > >=20
> > > > > > > > > > On first glance that looks like an IRQ pipeline state c=
orruption. I
> > > > > > > > > > fixed some of them recently, so please give it a try.
> > > > > > > > > >=20
> > > > > > > > > > The non-rebase branch - the version you are using - has=
 not been updated
> > > > > > > > > > yet. Let's wait for your test results. If successful we=
 can ask Jan to
> > > > > > > > > > do a stable release.
> > > > > > > > > >=20
> > > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] Hardware name: Xilinx Z=
ynq Platform
> > > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] IRQ stage: Linux
> > > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] Call trace:=20
> > > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 dump_backtrace fr=
om show_stack+0x18/0x1c
> > > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r7:c0c08f40 r6:c0=
a94cc8 r5:00000000 r4:00000080
> > > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 show_stack from d=
ump_stack_lvl+0x94/0xc8
> > > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 dump_stack_lvl fr=
om dump_stack+0x18/0x1c
> > > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r7:00000751 r6:00=
000009 r5:c0b0e65c r4:c0a65b0c
> > > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 dump_stack from _=
_warn+0x80/0xe0
> > > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 __warn from warn_=
slowpath_fmt+0x1b0/0x1bc
> > > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r7:00000000 r6:c0=
a65b0c r5:c0c08f40 r4:c0b4268c
> > > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 warn_slowpath_fmt=
 from irq_pipeline_init+0x40/0x158
> > > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r8:1eb76000 r7:00=
000000 r6:00000000 r5:c0c97038 r4:c0c97000
> > > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 irq_pipeline_init=
 from start_kernel+0x3f8/0x568
> > > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r5:c0c97038 r4:c0=
c97000
> > > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 start_kernel from=
 0x0
> > > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r7:00000000
> > > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] ---[ end trace 00000000=
00000000 ]---
> > > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] IRQ pipeline enabled
> > > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] rcu: srcu_init: Setting=
 srcu_struct sizes based on contention.
> > > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] zynq_clock_init: clkc s=
tarts at (ptrval)
> > > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] Zynq clock init
> > > > > > > > > > >=20
> > > > > > > > > > > I don't really know how to chase this.
> > > > > > > > > > >=20
> > > > > > > > > > > Fran=C3=A7ois
> > > > > > > > > =C2=A0
> > > > > > > > > =C2=A0I switched to the tip of that branch. I get the sam=
e result :
> > > > > > > > >=20
> > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C-310 dynamic clock gatin=
g enabled, standby mode enabled
> > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C-310 cache controller en=
abled, 8 ways, 512 kB
> > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C-310: CACHE_ID 0x410000c=
8, AUX_CTRL 0x46460001
> > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] ------------[ cut here ]---=
---------
> > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] WARNING: CPU: 0 PID: 0 at k=
ernel/irq/pipeline.c:1866 irq_pipeline_init+0x40/0x158
> > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] CPU: 0 UID: 0 PID: 0 Comm: =
swapper/0 Not tainted 6.12.96-cip28-yocto-standard-arksv #1
> > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] Hardware name: Xilinx Zynq =
Platform
> > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] IRQ stage: Linux
> > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] Call trace:
> > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 dump_backtrace from s=
how_stack+0x18/0x1c
> > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r7:c0c08f40 r6:c0a951=
a4 r5:00000000 r4:00000080
> > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 show_stack from dump_=
stack_lvl+0x94/0xc8
> > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 dump_stack_lvl from d=
ump_stack+0x18/0x1c
> > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r7:0000074a r6:000000=
09 r5:c0b0e65c r4:c0a65fe8
> > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 dump_stack from __war=
n+0x80/0xe0
> > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 __warn from warn_slow=
path_fmt+0x1b0/0x1bc
> > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r7:00000000 r6:c0a65f=
e8 r5:c0c08f40 r4:c0b4268c
> > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 warn_slowpath_fmt fro=
m irq_pipeline_init+0x40/0x158
> > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r8:1eb76000 r7:000000=
00 r6:00000000 r5:c0c97038 r4:c0c97000
> > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 irq_pipeline_init fro=
m start_kernel+0x3f8/0x568
> > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r5:c0c97038 r4:c0c970=
00> > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 start_kernel from 0x0> > =
> > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r7:00000000
> > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] ---[ end trace 000000000000=
0000 ]---
> > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] IRQ pipeline enabled
> > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] rcu: srcu_init: Setting src=
u_struct sizes based on contention.
> > > > > > > > >=20
> > > > > > > > >=20
> > > > > > > >=20
> > > > > > > > Might be related:=20
> > > > > > > > https://lore.kernel.org/xenomai/CAKndYJGo5Yu7Ak694tX=3DcqRj=
tJneXs22DPjz=3DUDVkUcNJMWyOA@mail.gmail.com/
> > > > > > > >=20
> > > > > > > > Quote:
> > > > > > > >=20
> > > > > > > > > It actually booted as soon as I disabled the "scutimer" c=
lock source
> > > > > > > > > via the DTB.=C2=A0 This made the kernel fall back to "arm=
_global_timer" and
> > > > > > > > > now it boots properly.
> > > > > > > >=20
> > > > > > >=20
> > > > > > > Well, I had this problem a while back at my first dovetail at=
tempt (was on linux 5.15 IIRC). Switching to 6.12, the system started corre=
ctly at first try (except for that BUG signaled).
> > > > > > > I even experience pretty good RT performance (about the same =
I had with IPIPE)
> > > > > > >=20
> > > > > > > > There are a couple of "hacks" mentioned in the mail thread =
that you
> > > > > > > > could try and report back.
> > > > > > > >=20
> > > > > > > > Couple of questions:
> > > > > > > >=20
> > > > > > > > - Does the board boot up with CONFIG_IRQ_PIPELINE disabled?
> > > > > > > > - Have you tried enabling=20
> > > > > > > > =C2=A0=C2=A0=C2=A0 - CONFIG_DEBUG_IRQ_PIPELINE
> > > > > > > > =C2=A0=C2=A0=C2=A0 - CONFIG_IRQ_PIPELINE_TORTURE_TEST> > > =
> >=20
> > > > > > > > Best regards,
> > > > > > > > Florian
> > > > > > > =C2=A0
> > > > > > > I can see no differences with these options activated (apart =
from custom kernel driver that need to be fixed, but that will be another t=
hread if I can't fix it myself).
> > > > > > > You can find the complete bootlog attached.
> > > > > > >=20
> > > > > >=20
> > > > > > The hardware IRQ state is unexpected in your case. Hard IRQs ar=
e enabled
> > > > > > where they are expected to be disabled. Quite early in the boot=
 process.
> > > > > >=20
> > > > > > It might help to enable CONFIG_PROVE_LOCKING (enable lockdep). =
That
> > > > > > might tell us where hard IRQs were enabled before we reached th=
e check.=20
> > > > > >=20
> > > > >=20
> > > > > I just tried the CONFIG_PROVE_LOCKING option. Unfortunately, it s=
eems the detector gets activated way after the inital BUG occurs.
> > > > >=20
> > > > > I also reviewed the Zynq clock init part, however, I'm not really=
 sur to know what I'm looking for. I can tell that this is registering the =
clock tree elements within the kernel, and that some couples of spin_lock_i=
rqsave/spin_lock_irqrestore are in the way.
> > > > >=20
> > > >=20
> > > > I just send out a patch [1] for another trap handling issue that Ja=
n
> > > > found while trying to do some stable updates. I have no other idea =
ATM.
> > > >=20
> > > > [1] https://lore.kernel.org/xenomai/20261102125420.702769-1-florian=
.bezdeka@siemens.com/T/#u
> > > >=20
> > > > Any further ideas from Philippe or Jan?
> > > =C2=A0=20
> > > The patch did not help. Same result. So I checked what happens inmain=
 before calling=C2=A0 irq_pipeline_init
> > > IRQs are disabled until the call to init_IRQ(), after which there ena=
bled. I don't checked where (and possibly why it is so) nor if it's expecte=
d.
> > >=20
> > > I'll post updates.
> > >=20
> >=20
> > Here it is, coming from init_IRQ(), I get the follwing call trace
> >=20
> > stop_machine_cpuslocked
> > patch_text
> > __arch_jump_label_transform
> > arch_jump_label_transform
> > jump_label_cmp
> > static_key_disable_cpuslocked
> > gic_of_init
> > of_irq_init
> > irq_chip_init
> > zynq_irq_init
> > init_IRQ
> >=20
> > And there, in stop_machine_cpuslocked, I see a cpsie i (which enables t=
he interrupts to the core) and a then a call to __inband_irq_enable.
> > >=20
>=20
> This stop_machine_cpuslocked() is unconditionally enabling hard IRQs. It
> seems this call is unexpected at this stage, even before initializing
> the pipelining core, which is expecting hard IRQs off at initialization.
>=20
> Maybe worth a try:
>=20
> diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
> index cc7a2c6431ea6..912adf6016acc 100644
> --- a/kernel/stop_machine.c
> +++ b/kernel/stop_machine.c
> @@ -601,15 +601,16 @@ int stop_machine_cpuslocked(cpu_stop_fn_t fn, void =
*data,
>  		 * early in boot before stop_machine() has been
>  		 * initialized.
>  		 */
> +		unsigned long irqflags;
>  		unsigned long flags;
>  		int ret;
> =20
>  		WARN_ON_ONCE(msdata.num_threads !=3D 1);
> =20
>  		local_irq_save(flags);
> -		hard_irq_disable();
> +		irqflags =3D hard_cond_local_irq_save();
>  		ret =3D (*fn)(data);
> -		hard_irq_enable();
> +		hard_cond_local_irq_restore(irqflags);
>  		local_irq_restore(flags);
> =20
>  		return ret;

In addition, I forgot the !SMP case:

diff --git a/include/linux/stop_machine.h b/include/linux/stop_machine.h
index 1ec7ad5314748..ba7ee4c9c0674 100644
--- a/include/linux/stop_machine.h
+++ b/include/linux/stop_machine.h
@@ -165,13 +165,14 @@ int stop_machine_from_inactive_cpu(cpu_stop_fn_t fn, =
void *data,
 static __always_inline int stop_machine_cpuslocked(cpu_stop_fn_t fn, void =
*data,
 					  const struct cpumask *cpus)
 {
+	unsigned long irqflags;
 	unsigned long flags;
 	int ret;
 	local_irq_save(flags);
-	hard_irq_disable();
+	irqflags =3D hard_cond_local_irq_disable();
 	ret =3D fn(data);
 	hard_irq_enable();
-	local_irq_restore(flags);
+	hard_cond_local_irq_restore(irqflags);
 	return ret;
 }
