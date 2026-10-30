Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.27.42.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793355116;
	b=Mp9S5f+esldzuc+zSWV4/syXJTB9OR6PCOcDQ8/E/FKah0FG/q8Bym6o/orUXUgMSTNw
	 OnlcyckPuh6fzcldQn9Qnw+uyZNF3JLrjJkRJs3ftleV80jEDuvPMBFuC4HOapLvFimv2
	 Bj0w1qh+pEntvrURhz5CBvbCsbKkB0j2nfgtkt7nTeiGUvQTTnutAuLBbGWI7dOZ6FRlL
	 PobV9ogG8WIDpApwwGWYC6XgOHUopVf9de0Gno0gMGu8ZGIX2a6OjuTVBYi0G2bSATwDj
	 Dw952BVqQUxI375Uxd1DK/dBZYbC9HnwBCNDj4wzFrADUZT5+WvrsdFH+jgSiK/8DUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793355116;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:In-Reply-To:
	 Content-Type:X-Forward:Date:Cc:To:MIME-Version:Message-ID:Subject:
	 User-Agent:Content-Transfer-Encoding:X-Virus-Scanned:X-Virus-Status;
	bh=GtKuqzQTpesMvFSoCATylNPEtP0Fjy6n4u0E0yrTZa0=;
	b=O2kiZQtz4zLkx/cETou186JxDfqbH0BF5hwCxF3hd6QeaS30khvo1zugPQYAbBjam5Sc
	 O4TRgnBmDfPjKcvkVFXhPwTIdmyY0VVzFiNwD97WBObKOl60JxdsmflGUx1TN1BzMMRin
	 9P/GFWydv9KyNq4YpD6fsmsqN75jA5tTvv3RBre19gSsEHz2UYW+eyVoGm+7F3/G/fScN
	 QQGWrcesb50heYZIq0HfyRzUAi2+OZrFsl/pJ0c+9dYNu1f1q5hO22fSSCy/d0iGulB8f
	 58vS+Pk1lWbenjoCf8bPyfZ79Iy4nPJzoSE4jfKM2QvTiSVfND5S04JT0kpckIz2daA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=eventlab.fr;
	spf=pass smtp.mailfrom=eventlab.fr;
	dkim=permerror header.d=eventlab.fr header.i=@eventlab.fr header.a=ed25519-sha256 header.s=default header.b=VMvkX+tp;
	arc=none smtp.remote-ip=212.27.42.6
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122A0606A31A
	for <xenomai@lists.linux.dev>; Fri, 30 Oct 2026 10:11:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 122A0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eventlab.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eventlab.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror header.d=eventlab.fr header.i=@eventlab.fr header.a=ed25519-sha256 header.s=default header.b=VMvkX+tp
Received: from mail.thom.fr.eu.org (unknown [82.64.149.25])
	by smtp6-g21.free.fr (Postfix) with ESMTPS id 07F68780518;
	Fri, 30 Oct 2026 11:11:42 +0100 (CET)
Authentication-Results: smtp6-g21.free.fr;
	dkim=permerror header.d=eventlab.fr header.i=@eventlab.fr header.a=ed25519-sha256 header.s=default header.b=VMvkX+tp;
	dkim-atps=neutral
Received: from localhost ([127.0.0.1])
	by mail.thom.fr.eu.org (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTP id 69UABeMg1505083;
	Fri, 30 Oct 2026 11:11:41 +0100
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple; d=eventlab.fr;
	s=default; t=1793355102;
	bh=Bbnd9QscFeGoe1jy60y143jHJGU/gQPw74LQvxHlG3E=;
	h=From:In-Reply-To:Date:Cc:To:Subject;
	b=VMvkX+tpeujNX6pUyNL7nuZGmsAoDHFLkA5y998XQWV2yZoHxRNc3nIwJVVLPN7H0
	 CL1OdRbrOh6a1mkZL8ND8UEXgF30HsjPH6aci/+61c94SSo7CQQ+odu4G8FqDZ8LEx
	 mfRHYTALNMag0G4UlWtkssl9lE2GsVDscRJ6/28iv25G4PhRSMt/DdmVgNlt6oWKyR
	 z3WXLL+V3kySeRWFKN8TAgOBKC7PCiyQU3sd1IJlkXztZm2DDVaUmjmZNDibw/Bdej
	 R0TDyFniSor36CvWUFLqzmxRMGgPJsKIIcA6EotM8F5HlbJvXsI/l/xxov8FB97fW8
	 JY5/0Zg5nl5PA==
From: =?utf-8?q?Fran=C3=A7ois_Legal?= <francois.legal@eventlab.fr>
In-Reply-To: <ed8230d5c3679c614ec848d006e8ec1b40c9b894.camel@siemens.com>
Content-Type: text/plain; charset="utf-8"
X-Forward: 217.109.173.233, 194.9.103.72
Date: Fri, 30 Oct 2026 11:11:40 +0100
Cc: xenomai@lists.linux.dev, "Philippe Gerum" <rpm@xenomai.org>
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
Message-ID: <115efd-6ae46d80-d-36f80d40@211094600>
Subject: =?utf-8?q?Re=3A?= BUG at system boot
User-Agent: SOGoMail 5.0.1
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 1.4.3 at tls-srv-02
X-Virus-Status: Clean

Le Jeudi, Octobre 29, 2026 14:26 CET, Florian Bezdeka <florian.bezdeka@=
siemens.com> a =C3=A9crit: 
 
> On Wed, 2026-10-28 at 17:37 +0100, Fran=C3=A7ois Legal wrote:
> > Le Mercredi, Octobre 28, 2026 11:15 CET, Florian Bezdeka <florian.b=
ezdeka@siemens.com> a =C3=A9crit: 
> > =C2=A0
> > > On Wed, 2026-10-28 at 09:36 +0100, Fran=C3=A7ois Legal wrote:
> > > > Le Mardi, Octobre 27, 2026 16:08 CET, Florian Bezdeka <florian.=
bezdeka@siemens.com> a =C3=A9crit: 
> > > > =C2=A0
> > > > > On Tue, 2026-10-27 at 15:44 +0100, Fran=C3=A7ois Legal wrote:=

> > > > > > Switching my setup from linux 5.4 Ipipe + Xenomai 3.2 to Li=
nux 6.12 + dovetail + Xenomai 3.3, I experience the follwing BUG() at s=
ystem boot. Machine is zynq7000 SoC :
> > > > > > 
> > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C: platform modifies aux co=
ntrol register: 0x02060000 -> 0x02460000
> > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C: DT/platform modifies aux=
 control register: 0x02060000 -> 0x02460000
> > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C-310 enabling early BRESP =
for Cortex-A9
> > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C-310 full line of zeros en=
abled for Cortex-A9
> > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C-310 dynamic clock gating =
enabled, standby mode enabled
> > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C-310 cache controller enab=
led, 8 ways, 512 kB
> > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C-310: CACHE=5FID 0x410000c=
8, AUX=5FCTRL 0x46460001
> > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] ------------[ cut here ]-----=
-------
> > > > > 
> > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] WARNING: CPU: 0 PID: 0 at ker=
nel/irq/pipeline.c:1873 irq=5Fpipeline=5Finit+0x40/0x158
> > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] CPU: 0 UID: 0 PID: 0 Comm: sw=
apper/0 Not tainted 6.12.90-cip24-yocto-standard-arksv #1
> > > > > 
> > > > > That version is a bit outdated already. Could you please repe=
at the test
> > > > > with the current version in the v6.12.y-cip-dovetail-rebase b=
ranch, just
> > > > > to make sure the problem has not already been fixed.
> > > > > 
> > > > > On first glance that looks like an IRQ pipeline state corrupt=
ion. I
> > > > > fixed some of them recently, so please give it a try.
> > > > > 
> > > > > The non-rebase branch - the version you are using - has not b=
een updated
> > > > > yet. Let's wait for your test results. If successful we can a=
sk Jan to
> > > > > do a stable release.
> > > > > 
> > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] Hardware name: Xilinx Zynq Pl=
atform
> > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] IRQ stage: Linux
> > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] Call trace: 
> > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 dump=5Fbacktrace from s=
how=5Fstack+0x18/0x1c
> > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r7:c0c08f40 r6:c0a94cc8=
 r5:00000000 r4:00000080
> > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 show=5Fstack from dump=5F=
stack=5Flvl+0x94/0xc8
> > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 dump=5Fstack=5Flvl from=
 dump=5Fstack+0x18/0x1c
> > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r7:00000751 r6:00000009=
 r5:c0b0e65c r4:c0a65b0c
> > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 dump=5Fstack from =5F=5F=
warn+0x80/0xe0
> > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 =5F=5Fwarn from warn=5F=
slowpath=5Ffmt+0x1b0/0x1bc
> > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r7:00000000 r6:c0a65b0c=
 r5:c0c08f40 r4:c0b4268c
> > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 warn=5Fslowpath=5Ffmt f=
rom irq=5Fpipeline=5Finit+0x40/0x158
> > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r8:1eb76000 r7:00000000=
 r6:00000000 r5:c0c97038 r4:c0c97000
> > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 irq=5Fpipeline=5Finit f=
rom start=5Fkernel+0x3f8/0x568
> > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r5:c0c97038 r4:c0c97000=

> > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 start=5Fkernel from 0x0=

> > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r7:00000000
> > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] ---[ end trace 00000000000000=
00 ]---
> > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] IRQ pipeline enabled
> > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] rcu: srcu=5Finit: Setting src=
u=5Fstruct sizes based on contention.
> > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] zynq=5Fclock=5Finit: clkc sta=
rts at (ptrval)
> > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] Zynq clock init
> > > > > > 
> > > > > > I don't really know how to chase this.
> > > > > > 
> > > > > > Fran=C3=A7ois
> > > > =C2=A0
> > > > =C2=A0I switched to the tip of that branch. I get the same resu=
lt :
> > > > 
> > > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C-310 dynamic clock gating enab=
led, standby mode enabled
> > > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C-310 cache controller enabled,=
 8 ways, 512 kB
> > > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C-310: CACHE=5FID 0x410000c8, A=
UX=5FCTRL 0x46460001
> > > > [=C2=A0=C2=A0=C2=A0 0.000000] ------------[ cut here ]---------=
---
> > > > [=C2=A0=C2=A0=C2=A0 0.000000] WARNING: CPU: 0 PID: 0 at kernel/=
irq/pipeline.c:1866 irq=5Fpipeline=5Finit+0x40/0x158
> > > > [=C2=A0=C2=A0=C2=A0 0.000000] CPU: 0 UID: 0 PID: 0 Comm: swappe=
r/0 Not tainted 6.12.96-cip28-yocto-standard-arksv #1
> > > > [=C2=A0=C2=A0=C2=A0 0.000000] Hardware name: Xilinx Zynq Platfo=
rm
> > > > [=C2=A0=C2=A0=C2=A0 0.000000] IRQ stage: Linux
> > > > [=C2=A0=C2=A0=C2=A0 0.000000] Call trace:
> > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 dump=5Fbacktrace from show=5F=
stack+0x18/0x1c
> > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r7:c0c08f40 r6:c0a951a4 r5:=
00000000 r4:00000080
> > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 show=5Fstack from dump=5Fst=
ack=5Flvl+0x94/0xc8
> > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 dump=5Fstack=5Flvl from dum=
p=5Fstack+0x18/0x1c
> > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r7:0000074a r6:00000009 r5:=
c0b0e65c r4:c0a65fe8
> > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 dump=5Fstack from =5F=5Fwar=
n+0x80/0xe0
> > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 =5F=5Fwarn from warn=5Fslow=
path=5Ffmt+0x1b0/0x1bc
> > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r7:00000000 r6:c0a65fe8 r5:=
c0c08f40 r4:c0b4268c
> > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 warn=5Fslowpath=5Ffmt from =
irq=5Fpipeline=5Finit+0x40/0x158
> > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r8:1eb76000 r7:00000000 r6:=
00000000 r5:c0c97038 r4:c0c97000
> > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 irq=5Fpipeline=5Finit from =
start=5Fkernel+0x3f8/0x568
> > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r5:c0c97038 r4:c0c97000
> > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 start=5Fkernel from 0x0
> > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r7:00000000
> > > > [=C2=A0=C2=A0=C2=A0 0.000000] ---[ end trace 0000000000000000 ]=
---
> > > > [=C2=A0=C2=A0=C2=A0 0.000000] IRQ pipeline enabled
> > > > [=C2=A0=C2=A0=C2=A0 0.000000] rcu: srcu=5Finit: Setting srcu=5F=
struct sizes based on contention.
> > > > 
> > > > 
> > > 
> > > Might be related: 
> > > https://lore.kernel.org/xenomai/CAKndYJGo5Yu7Ak694tX=3DcqRjtJneXs=
22DPjz=3DUDVkUcNJMWyOA@mail.gmail.com/
> > > 
> > > Quote:
> > > 
> > > > It actually booted as soon as I disabled the "scutimer" clock s=
ource
> > > > via the DTB.=C2=A0 This made the kernel fall back to "arm=5Fglo=
bal=5Ftimer" and
> > > > now it boots properly.
> > > 
> > 
> > Well, I had this problem a while back at my first dovetail attempt =
(was on linux 5.15 IIRC). Switching to 6.12, the system started correct=
ly at first try (except for that BUG signaled).
> > I even experience pretty good RT performance (about the same I had =
with IPIPE)
> > 
> > > There are a couple of "hacks" mentioned in the mail thread that y=
ou
> > > could try and report back.
> > > 
> > > Couple of questions:
> > > 
> > > - Does the board boot up with CONFIG=5FIRQ=5FPIPELINE disabled?
> > > - Have you tried enabling 
> > > =C2=A0=C2=A0=C2=A0 - CONFIG=5FDEBUG=5FIRQ=5FPIPELINE
> > > =C2=A0=C2=A0=C2=A0 - CONFIG=5FIRQ=5FPIPELINE=5FTORTURE=5FTEST
> > > 
> > > Best regards,
> > > Florian
> > =C2=A0
> > I can see no differences with these options activated (apart from c=
ustom kernel driver that need to be fixed, but that will be another thr=
ead if I can't fix it myself).
> > You can find the complete bootlog attached.
> > 
> 
> The hardware IRQ state is unexpected in your case. Hard IRQs are enab=
led
> where they are expected to be disabled. Quite early in the boot proce=
ss.
> 
> It might help to enable CONFIG=5FPROVE=5FLOCKING (enable lockdep). Th=
at
> might tell us where hard IRQs were enabled before we reached the chec=
k. 
> 

I just tried the CONFIG=5FPROVE=5FLOCKING option. Unfortunately, it see=
ms the detector gets activated way after the inital BUG occurs.

I also reviewed the Zynq clock init part, however, I'm not really sur t=
o know what I'm looking for. I can tell that this is registering the cl=
ock tree elements within the kernel, and that some couples of spin=5Flo=
ck=5Firqsave/spin=5Flock=5Firqrestore are in the way.

Fran=C3=A7ois
> Maybe it's related to the "Zynq clock init" line, but that's just a w=
ild
> guess ATM.

