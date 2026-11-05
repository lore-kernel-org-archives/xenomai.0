Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.136.64.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793908837;
	b=cdrY0vk+HJ/fQX6OTUPKcOBtr8Na6p2u0MdXVRu3xUTWNSLEETadbEbFBxCNYNf4yfpj
	 blypn8t052Vh+mB/T9KvlP4KJWh10PisZsT9R2DaVnO3/ou4pewxgMXs5WW/2crZTwj/2
	 VHqnIBtJkuBF8P5EWq2g6JXQTCNfWddg/FLFqYeICmJWaaQD9+2b8uIlGl0F5YdIHn8LO
	 UUftTwTXtCHi5XjgSdP5mh+VDFbampKSShoKPqu1u6BAaJAeL/XFstMO215EG7dtJqskn
	 VdI/Y+n3sXezD1slzxJtjPGPYbJDQ8JNka4pYvCRLQnrufBbVmunlXYDHuuwdbZghlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793908837;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 MIME-Version:X-Flowmailer-Platform:Feedback-ID;
	bh=PCTVdDAQ4qVVImTr8yebRb1ZE/UXX1bIfCmD9fS3IEg=;
	b=K/E/eiAsEXoIr1TtxaSuW3LNzKZ7bvqbyh/lTRJtmbgHAjiHKG2Zgv3blAfkt4PLKBFr
	 U29LfydeE9SEQMG0+lN19ZiZGQGO5vtRS4kQ9iWZB1PXMiNHR61L41B9a4gfH14CUdhZx
	 wI2ry5jEOo7vE7oPakR1liL2OK6u+O4u2v1BI887kpcU5bNe36Y4VpZHzQSCGIXYKQmTz
	 yAx/Vy27ZxhDewuo/T+AhXNi+I5klwaLZNJ3+OzYwmJfvW0DnuIPRbQ8UQbpfRFWAVQiu
	 1h1anrU3NVNyNfFES5YdSkeQ5klkdg/gp84AXVLeYLCN+ybhCMVG0PcefqZ+9k22wlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=rts-flowmailer.siemens.com;
	dkim=pass header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm2 header.b=gmZDw+0I;
	arc=none smtp.remote-ip=185.136.64.225
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30113606A32F
	for <xenomai@lists.linux.dev>; Thu,  5 Nov 2026 20:00:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30113606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm2 header.b=gmZDw+0I
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202611052000263d8df224e700020738
        for <xenomai@lists.linux.dev>;
        Thu, 05 Nov 2026 21:00:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=PCTVdDAQ4qVVImTr8yebRb1ZE/UXX1bIfCmD9fS3IEg=;
 b=gmZDw+0IDzHCD5M5KHMW595oTI/B85WBQz3uSTqdXER/sfWkQVBSZJlXR2IcgJ3TwjcoH7
 Y8e9+6g2PqEMRPZK7WuFTHnY/qqu72HlrKLUKk0966Hs8/7yzduxvWJET9fM9qNCUK59cRYf
 BnECm4wVi7SgBTJjePDNyenASkEJU0s5C/iJ9kXP3iE3p65heXtbnd+VeEojoWibYnOmAtfL
 Z2kGvOkvQKaUZ27/MyTqxHE+79pPCJAd1gWcgCBjLUtj2Q6rv6Qwhsvi1Yuibn/DQYj2WAlX
 MCOCdhZqV8EbNdoVhjgJbdFTqt6thcaTIiWlS7zZn1EU4Qhn88lVTtbw==;
Message-ID: <7636bed28170d3058f4d8db55fd6e4f997617332.camel@siemens.com>
Subject: Re: BUG at system boot
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: =?ISO-8859-1?Q?Fran=E7ois?= Legal <francois.legal@eventlab.fr>, 
	xenomai@lists.linux.dev
Cc: rpm@xenomai.org, jan.kiszka@siemens.com
Date: Thu, 05 Nov 2026 21:00:25 +0100
In-Reply-To: <1207-6aeca000-53-3e404bc0@80379397>
References: <1207-6aeca000-53-3e404bc0@80379397>
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

On Thu, 2026-11-05 at 16:25 +0100, Fran=C3=A7ois Legal wrote:
> Le Jeudi, Novembre 05, 2026 11:54 CET, Fran=C3=A7ois Legal <francois.lega=
l@eventlab.fr> a =C3=A9crit:=20
> =C2=A0
> > Le Lundi, Novembre 02, 2026 14:27 CET, Florian Bezdeka <florian.bezdeka=
@siemens.com> a =C3=A9crit:=20
> > =C2=A0=20
> > > On Fri, 2026-10-30 at 11:11 +0100, Fran=C3=A7ois Legal wrote:
> > > > Le Jeudi, Octobre 29, 2026 14:26 CET, Florian Bezdeka <florian.bezd=
eka@siemens.com> a =C3=A9crit:=20
> > > > =C2=A0=20
> > > > > On Wed, 2026-10-28 at 17:37 +0100, Fran=C3=A7ois Legal wrote:
> > > > > > Le Mercredi, Octobre 28, 2026 11:15 CET, Florian Bezdeka <flori=
an.bezdeka@siemens.com> a =C3=A9crit:=20
> > > > > > =C2=A0
> > > > > > > On Wed, 2026-10-28 at 09:36 +0100, Fran=C3=A7ois Legal wrote:=
> > > > > > Le Mardi, Octobre 27, 2026 16:08 CET, Florian Bezdeka <florian.=
bezdeka@siemens.com> a =C3=A9crit:=20
> > > > > > > > =C2=A0
> > > > > > > > > On Tue, 2026-10-27 at 15:44 +0100, Fran=C3=A7ois Legal wr=
ote:
> > > > > > > > > > Switching my setup from linux 5.4 Ipipe + Xenomai 3.2 t=
o Linux 6.12 + dovetail + Xenomai 3.3, I experience the follwing BUG() at s=
ystem boot. Machine is zynq7000 SoC :
> > > > > > > > > >=20
> > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C: platform modifies au=
x control register: 0x02060000 -> 0x02460000
> > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C: DT/platform modifies=
 aux control register: 0x02060000 -> 0x02460000
> > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C-310 enabling early BR=
ESP for Cortex-A9
> > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C-310 full line of zero=
s enabled for Cortex-A9
> > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C-310 dynamic clock gat=
ing enabled, standby mode enabled
> > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C-310 cache controller =
enabled, 8 ways, 512 kB
> > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C-310: CACHE_ID 0x41000=
0c8, AUX_CTRL 0x46460001
> > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] ------------[ cut here ]-=
-----------
> > > > > > > > >=20
> > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] WARNING: CPU: 0 PID: 0 at=
 kernel/irq/pipeline.c:1873 irq_pipeline_init+0x40/0x158
> > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] CPU: 0 UID: 0 PID: 0 Comm=
: swapper/0 Not tainted 6.12.90-cip24-yocto-standard-arksv #1
> > > > > > > > >=20
> > > > > > > > > That version is a bit outdated already. Could you please =
repeat the test
> > > > > > > > > with the current version in the v6.12.y-cip-dovetail-reba=
se branch, just
> > > > > > > > > to make sure the problem has not already been fixed.
> > > > > > > > >=20
> > > > > > > > > On first glance that looks like an IRQ pipeline state cor=
ruption. I
> > > > > > > > > fixed some of them recently, so please give it a try.
> > > > > > > > >=20
> > > > > > > > > The non-rebase branch - the version you are using - has n=
ot been updated
> > > > > > > > > yet. Let's wait for your test results. If successful we c=
an ask Jan to
> > > > > > > > > do a stable release.
> > > > > > > > >=20
> > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] Hardware name: Xilinx Zyn=
q Platform
> > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] IRQ stage: Linux
> > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] Call trace:=20
> > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 dump_backtrace from=
 show_stack+0x18/0x1c
> > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r7:c0c08f40 r6:c0a9=
4cc8 r5:00000000 r4:00000080
> > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 show_stack from dum=
p_stack_lvl+0x94/0xc8
> > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 dump_stack_lvl from=
 dump_stack+0x18/0x1c
> > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r7:00000751 r6:0000=
0009 r5:c0b0e65c r4:c0a65b0c
> > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 dump_stack from __w=
arn+0x80/0xe0
> > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 __warn from warn_sl=
owpath_fmt+0x1b0/0x1bc
> > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r7:00000000 r6:c0a6=
5b0c r5:c0c08f40 r4:c0b4268c
> > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 warn_slowpath_fmt f=
rom irq_pipeline_init+0x40/0x158
> > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r8:1eb76000 r7:0000=
0000 r6:00000000 r5:c0c97038 r4:c0c97000
> > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 irq_pipeline_init f=
rom start_kernel+0x3f8/0x568
> > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r5:c0c97038 r4:c0c9=
7000
> > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 start_kernel from 0=
x0
> > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r7:00000000
> > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] ---[ end trace 0000000000=
000000 ]---
> > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] IRQ pipeline enabled
> > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] rcu: srcu_init: Setting s=
rcu_struct sizes based on contention.
> > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] zynq_clock_init: clkc sta=
rts at (ptrval)
> > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] Zynq clock init
> > > > > > > > > >=20
> > > > > > > > > > I don't really know how to chase this.
> > > > > > > > > >=20
> > > > > > > > > > Fran=C3=A7ois
> > > > > > > > =C2=A0
> > > > > > > > =C2=A0I switched to the tip of that branch. I get the same =
result :
> > > > > > > >=20
> > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C-310 dynamic clock gating =
enabled, standby mode enabled
> > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C-310 cache controller enab=
led, 8 ways, 512 kB
> > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C-310: CACHE_ID 0x410000c8,=
 AUX_CTRL 0x46460001
> > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] ------------[ cut here ]-----=
-------
> > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] WARNING: CPU: 0 PID: 0 at ker=
nel/irq/pipeline.c:1866 irq_pipeline_init+0x40/0x158
> > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] CPU: 0 UID: 0 PID: 0 Comm: sw=
apper/0 Not tainted 6.12.96-cip28-yocto-standard-arksv #1
> > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] Hardware name: Xilinx Zynq Pl=
atform
> > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] IRQ stage: Linux
> > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] Call trace:
> > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 dump_backtrace from sho=
w_stack+0x18/0x1c
> > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r7:c0c08f40 r6:c0a951a4=
 r5:00000000 r4:00000080
> > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 show_stack from dump_st=
ack_lvl+0x94/0xc8
> > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 dump_stack_lvl from dum=
p_stack+0x18/0x1c
> > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r7:0000074a r6:00000009=
 r5:c0b0e65c r4:c0a65fe8
> > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 dump_stack from __warn+=
0x80/0xe0
> > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 __warn from warn_slowpa=
th_fmt+0x1b0/0x1bc
> > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r7:00000000 r6:c0a65fe8=
 r5:c0c08f40 r4:c0b4268c
> > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 warn_slowpath_fmt from =
irq_pipeline_init+0x40/0x158
> > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r8:1eb76000 r7:00000000=
 r6:00000000 r5:c0c97038 r4:c0c97000
> > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 irq_pipeline_init from =
start_kernel+0x3f8/0x568
> > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r5:c0c97038 r4:c0c97000=
> > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 start_kernel from 0x0> > > =
> > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r7:00000000
> > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] ---[ end trace 00000000000000=
00 ]---
> > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] IRQ pipeline enabled
> > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] rcu: srcu_init: Setting srcu_=
struct sizes based on contention.
> > > > > > > >=20
> > > > > > > >=20
> > > > > > >=20
> > > > > > > Might be related:=20
> > > > > > > https://lore.kernel.org/xenomai/CAKndYJGo5Yu7Ak694tX=3DcqRjtJ=
neXs22DPjz=3DUDVkUcNJMWyOA@mail.gmail.com/
> > > > > > >=20
> > > > > > > Quote:
> > > > > > >=20
> > > > > > > > It actually booted as soon as I disabled the "scutimer" clo=
ck source
> > > > > > > > via the DTB.=C2=A0 This made the kernel fall back to "arm_g=
lobal_timer" and
> > > > > > > > now it boots properly.
> > > > > > >=20
> > > > > >=20
> > > > > > Well, I had this problem a while back at my first dovetail atte=
mpt (was on linux 5.15 IIRC). Switching to 6.12, the system started correct=
ly at first try (except for that BUG signaled).
> > > > > > I even experience pretty good RT performance (about the same I =
had with IPIPE)
> > > > > >=20
> > > > > > > There are a couple of "hacks" mentioned in the mail thread th=
at you
> > > > > > > could try and report back.
> > > > > > >=20
> > > > > > > Couple of questions:
> > > > > > >=20
> > > > > > > - Does the board boot up with CONFIG_IRQ_PIPELINE disabled?
> > > > > > > - Have you tried enabling=20
> > > > > > > =C2=A0=C2=A0=C2=A0 - CONFIG_DEBUG_IRQ_PIPELINE
> > > > > > > =C2=A0=C2=A0=C2=A0 - CONFIG_IRQ_PIPELINE_TORTURE_TEST> > > > =
>=20
> > > > > > > Best regards,
> > > > > > > Florian
> > > > > > =C2=A0
> > > > > > I can see no differences with these options activated (apart fr=
om custom kernel driver that need to be fixed, but that will be another thr=
ead if I can't fix it myself).
> > > > > > You can find the complete bootlog attached.
> > > > > >=20
> > > > >=20
> > > > > The hardware IRQ state is unexpected in your case. Hard IRQs are =
enabled
> > > > > where they are expected to be disabled. Quite early in the boot p=
rocess.
> > > > >=20
> > > > > It might help to enable CONFIG_PROVE_LOCKING (enable lockdep). Th=
at
> > > > > might tell us where hard IRQs were enabled before we reached the =
check.=20
> > > > >=20
> > > >=20
> > > > I just tried the CONFIG_PROVE_LOCKING option. Unfortunately, it see=
ms the detector gets activated way after the inital BUG occurs.
> > > >=20
> > > > I also reviewed the Zynq clock init part, however, I'm not really s=
ur to know what I'm looking for. I can tell that this is registering the cl=
ock tree elements within the kernel, and that some couples of spin_lock_irq=
save/spin_lock_irqrestore are in the way.
> > > >=20
> > >=20
> > > I just send out a patch [1] for another trap handling issue that Jan
> > > found while trying to do some stable updates. I have no other idea AT=
M.
> > >=20
> > > [1] https://lore.kernel.org/xenomai/20261102125420.702769-1-florian.b=
ezdeka@siemens.com/T/#u
> > >=20
> > > Any further ideas from Philippe or Jan?
> > =C2=A0=20
> > The patch did not help. Same result. So I checked what happens inmain b=
efore calling=C2=A0 irq_pipeline_init
> > IRQs are disabled until the call to init_IRQ(), after which there enabl=
ed. I don't checked where (and possibly why it is so) nor if it's expected.
> >=20
> > I'll post updates.
> >=20
>=20
> Here it is, coming from init_IRQ(), I get the follwing call trace
>=20
> stop_machine_cpuslocked
> patch_text
> __arch_jump_label_transform
> arch_jump_label_transform
> jump_label_cmp
> static_key_disable_cpuslocked
> gic_of_init
> of_irq_init
> irq_chip_init
> zynq_irq_init
> init_IRQ
>=20
> And there, in stop_machine_cpuslocked, I see a cpsie i (which enables the=
 interrupts to the core) and a then a call to __inband_irq_enable.
> >=20

This stop_machine_cpuslocked() is unconditionally enabling hard IRQs. It
seems this call is unexpected at this stage, even before initializing
the pipelining core, which is expecting hard IRQs off at initialization.

Maybe worth a try:

diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index cc7a2c6431ea6..912adf6016acc 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -601,15 +601,16 @@ int stop_machine_cpuslocked(cpu_stop_fn_t fn, void *d=
ata,
 		 * early in boot before stop_machine() has been
 		 * initialized.
 		 */
+		unsigned long irqflags;
 		unsigned long flags;
 		int ret;
=20
 		WARN_ON_ONCE(msdata.num_threads !=3D 1);
=20
 		local_irq_save(flags);
-		hard_irq_disable();
+		irqflags =3D hard_cond_local_irq_save();
 		ret =3D (*fn)(data);
-		hard_irq_enable();
+		hard_cond_local_irq_restore(irqflags);
 		local_irq_restore(flags);
=20
 		return ret;
