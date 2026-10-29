Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.136.65.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793280414;
	b=GQH8DqixKK325XmmDumASiCuPQVHIt72ew08JldN/5DqY1ir0HiNlffvGnzA+mk47TvJ
	 CynNKdAONOuEaCDY6PXjSMDcumZGQAkz1Zp86fOZNte7Tr/yPRwhI5ODFnrxhSkF0aD8M
	 PMRUvFfAwXceDFARKg4W10Wkl2ZSUDXDTCm7w4FDOKN1CxcFRdUUvaCCRHcV6CoRLAK8g
	 S+l2VQhlTrhQRP8X/e4gsxi4DMAqal37oYlpAkWfA8XpEJEPIGGeMVtvGOgCBmi1B11ZS
	 oHPECnfuAvbcy4Xe7JT/PQODuYjUzJllh73bB7U16tFIRRcDYX7rIjGhBX4qvigrjPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793280414;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 MIME-Version:X-Flowmailer-Platform:Feedback-ID;
	bh=KXy1OhQPGrbSW4U31KCm53Omhut26b2jDIfXdFu72OQ=;
	b=TSBbpSaLSlM0c+lh0UEY3zwTnT2Xa/pwCIhFcplc8P0hYSLl5T6UconeHRbAVGNx1uWT
	 MuicNtPW9A7nTugQwHHIUPz9hPeljbrwjAftyofAYcDHSufwZPdn6OV84wVQTOfUnRrh1
	 QHmQFzRNutNuzl6zZKTDPLcIWoD5RMvbnuZpLFyczFGWs+Zb7M7500F9SzGxEipM43x2L
	 KK/enCI/HJidykI2uGeciLKzzvVugE4DUKt8dJW2WoyyzMXe6YN3tz67Fy64zDmeaOTGt
	 1lZQSs4IXD3bldI+fIFejiuacdTrram+L2WKPR6qMGV1gF3vLyXyDJKEz61pIL8tQHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=rts-flowmailer.siemens.com;
	dkim=pass header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm2 header.b=KlVDOK8H;
	arc=none smtp.remote-ip=185.136.65.225
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E8C606A31A
	for <xenomai@lists.linux.dev>; Thu, 29 Oct 2026 13:26:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24E8C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm2 header.b=KlVDOK8H
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202610291326387c7286db2400020702
        for <xenomai@lists.linux.dev>;
        Thu, 29 Oct 2026 14:26:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=KXy1OhQPGrbSW4U31KCm53Omhut26b2jDIfXdFu72OQ=;
 b=KlVDOK8HD6YKuWJ1bJQWTUD9LXLphbFD//zHbQwyDymSxnvMVFoQofh1QQc705xp4WAeET
 TqDi2Ha1KDpF2kQTi9iRvTCKi5Fa3XwvFOkBvEljONobIyvWj5YS2QUeIjnmX8aHOIdAxP+e
 ogyEU0ZdYz564ptUV3bBwytK2/KwpcaRqW8IQjrVXkN28lNmPJsHJ/3O+RxZRs8YqAFsu2GI
 49Dz01nuAzz40yJycxCld6HT9KOyd+vIGVcaLK5GXbVC73uH8n7yvCGdWktsQP0q1mboxQYk
 rv5jvtJlIiHEimySGRg2OBaOSMTSC5/a3lb5OQNkbnyMfC8nEJxoyNqg==;
Message-ID: <ed8230d5c3679c614ec848d006e8ec1b40c9b894.camel@siemens.com>
Subject: Re: BUG at system boot
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: =?ISO-8859-1?Q?Fran=E7ois?= Legal <francois.legal@eventlab.fr>
Cc: xenomai@lists.linux.dev, Philippe Gerum <rpm@xenomai.org>
Date: Thu, 29 Oct 2026 14:26:38 +0100
In-Reply-To: <1209-6ae22500-15f-5a2d1100@131697610>
References: <1209-6ae22500-15f-5a2d1100@131697610>
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

On Wed, 2026-10-28 at 17:37 +0100, Fran=C3=A7ois Legal wrote:
> Le Mercredi, Octobre 28, 2026 11:15 CET, Florian Bezdeka <florian.bezdeka=
@siemens.com> a =C3=A9crit:=20
> =C2=A0
> > On Wed, 2026-10-28 at 09:36 +0100, Fran=C3=A7ois Legal wrote:
> > > Le Mardi, Octobre 27, 2026 16:08 CET, Florian Bezdeka <florian.bezdek=
a@siemens.com> a =C3=A9crit:=20
> > > =C2=A0
> > > > On Tue, 2026-10-27 at 15:44 +0100, Fran=C3=A7ois Legal wrote:
> > > > > Switching my setup from linux 5.4 Ipipe + Xenomai 3.2 to Linux 6.=
12 + dovetail + Xenomai 3.3, I experience the follwing BUG() at system boot=
. Machine is zynq7000 SoC :
> > > > >=20
> > > > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C: platform modifies aux control =
register: 0x02060000 -> 0x02460000
> > > > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C: DT/platform modifies aux contr=
ol register: 0x02060000 -> 0x02460000
> > > > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C-310 enabling early BRESP for Co=
rtex-A9
> > > > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C-310 full line of zeros enabled =
for Cortex-A9
> > > > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C-310 dynamic clock gating enable=
d, standby mode enabled
> > > > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C-310 cache controller enabled, 8=
 ways, 512 kB
> > > > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C-310: CACHE_ID 0x410000c8, AUX_C=
TRL 0x46460001
> > > > > [=C2=A0=C2=A0=C2=A0 0.000000] ------------[ cut here ]-----------=
-
> > > >=20
> > > > > [=C2=A0=C2=A0=C2=A0 0.000000] WARNING: CPU: 0 PID: 0 at kernel/ir=
q/pipeline.c:1873 irq_pipeline_init+0x40/0x158
> > > > > [=C2=A0=C2=A0=C2=A0 0.000000] CPU: 0 UID: 0 PID: 0 Comm: swapper/=
0 Not tainted 6.12.90-cip24-yocto-standard-arksv #1
> > > >=20
> > > > That version is a bit outdated already. Could you please repeat the=
 test
> > > > with the current version in the v6.12.y-cip-dovetail-rebase branch,=
 just
> > > > to make sure the problem has not already been fixed.
> > > >=20
> > > > On first glance that looks like an IRQ pipeline state corruption. I
> > > > fixed some of them recently, so please give it a try.
> > > >=20
> > > > The non-rebase branch - the version you are using - has not been up=
dated
> > > > yet. Let's wait for your test results. If successful we can ask Jan=
 to
> > > > do a stable release.
> > > >=20
> > > > > [=C2=A0=C2=A0=C2=A0 0.000000] Hardware name: Xilinx Zynq Platform
> > > > > [=C2=A0=C2=A0=C2=A0 0.000000] IRQ stage: Linux
> > > > > [=C2=A0=C2=A0=C2=A0 0.000000] Call trace:=20
> > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 dump_backtrace from show_stac=
k+0x18/0x1c
> > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r7:c0c08f40 r6:c0a94cc8 r5:00=
000000 r4:00000080
> > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 show_stack from dump_stack_lv=
l+0x94/0xc8
> > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 dump_stack_lvl from dump_stac=
k+0x18/0x1c
> > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r7:00000751 r6:00000009 r5:c0=
b0e65c r4:c0a65b0c
> > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 dump_stack from __warn+0x80/0=
xe0
> > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 __warn from warn_slowpath_fmt=
+0x1b0/0x1bc
> > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r7:00000000 r6:c0a65b0c r5:c0=
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
> > > > > [=C2=A0=C2=A0=C2=A0 0.000000] zynq_clock_init: clkc starts at (pt=
rval)
> > > > > [=C2=A0=C2=A0=C2=A0 0.000000] Zynq clock init
> > > > >=20
> > > > > I don't really know how to chase this.
> > > > >=20
> > > > > Fran=C3=A7ois
> > > =C2=A0
> > > =C2=A0I switched to the tip of that branch. I get the same result :
> > >=20
> > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C-310 dynamic clock gating enabled, s=
tandby mode enabled
> > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C-310 cache controller enabled, 8 way=
s, 512 kB
> > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C-310: CACHE_ID 0x410000c8, AUX_CTRL =
0x46460001
> > > [=C2=A0=C2=A0=C2=A0 0.000000] ------------[ cut here ]------------
> > > [=C2=A0=C2=A0=C2=A0 0.000000] WARNING: CPU: 0 PID: 0 at kernel/irq/pi=
peline.c:1866 irq_pipeline_init+0x40/0x158
> > > [=C2=A0=C2=A0=C2=A0 0.000000] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 No=
t tainted 6.12.96-cip28-yocto-standard-arksv #1
> > > [=C2=A0=C2=A0=C2=A0 0.000000] Hardware name: Xilinx Zynq Platform
> > > [=C2=A0=C2=A0=C2=A0 0.000000] IRQ stage: Linux
> > > [=C2=A0=C2=A0=C2=A0 0.000000] Call trace:
> > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 dump_backtrace from show_stack+0x=
18/0x1c
> > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r7:c0c08f40 r6:c0a951a4 r5:000000=
00 r4:00000080
> > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 show_stack from dump_stack_lvl+0x=
94/0xc8
> > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 dump_stack_lvl from dump_stack+0x=
18/0x1c
> > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r7:0000074a r6:00000009 r5:c0b0e6=
5c r4:c0a65fe8
> > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 dump_stack from __warn+0x80/0xe0
> > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 __warn from warn_slowpath_fmt+0x1=
b0/0x1bc
> > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r7:00000000 r6:c0a65fe8 r5:c0c08f=
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
> > >=20
> > >=20
> >=20
> > Might be related:=20
> > https://lore.kernel.org/xenomai/CAKndYJGo5Yu7Ak694tX=3DcqRjtJneXs22DPjz=
=3DUDVkUcNJMWyOA@mail.gmail.com/
> >=20
> > Quote:
> >=20
> > > It actually booted as soon as I disabled the "scutimer" clock source
> > > via the DTB.=C2=A0 This made the kernel fall back to "arm_global_time=
r" and
> > > now it boots properly.
> >=20
>=20
> Well, I had this problem a while back at my first dovetail attempt (was o=
n linux 5.15 IIRC). Switching to 6.12, the system started correctly at firs=
t try (except for that BUG signaled).
> I even experience pretty good RT performance (about the same I had with I=
PIPE)
>=20
> > There are a couple of "hacks" mentioned in the mail thread that you
> > could try and report back.
> >=20
> > Couple of questions:
> >=20
> > - Does the board boot up with CONFIG_IRQ_PIPELINE disabled?
> > - Have you tried enabling=20
> > =C2=A0=C2=A0=C2=A0 - CONFIG_DEBUG_IRQ_PIPELINE
> > =C2=A0=C2=A0=C2=A0 - CONFIG_IRQ_PIPELINE_TORTURE_TEST
> >=20
> > Best regards,
> > Florian
> =C2=A0
> I can see no differences with these options activated (apart from custom =
kernel driver that need to be fixed, but that will be another thread if I c=
an't fix it myself).
> You can find the complete bootlog attached.
>=20

The hardware IRQ state is unexpected in your case. Hard IRQs are enabled
where they are expected to be disabled. Quite early in the boot process.

It might help to enable CONFIG_PROVE_LOCKING (enable lockdep). That
might tell us where hard IRQs were enabled before we reached the check.=20

Maybe it's related to the "Zynq clock init" line, but that's just a wild
guess ATM.
