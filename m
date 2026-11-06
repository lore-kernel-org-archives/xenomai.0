Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.27.42.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793955754;
	b=W7O8RX7RfoZn2BtSiCTgrW3gyGYqYVi+BxyjhyoQM5yDyjhdsqtcRUPrQmQSyrOYCRwd
	 w+V0W03WsY1gvUD/to09td6SmUdR89URF5V9au0/KzeCboJ3jeXclaysqJYcMgDZrWgo9
	 1OavkmpC4TJskwbk+oC0x0Um8dRDjmI4X9fN6XP8ifHZ/PC7tm/IO9hST9Eyt+BoSt8PJ
	 ONagM7xkJc5+lg6OYeuql3oCrGM1yByRj28OF6fy0c61t/Im22OmXKWXsKCbHOFOpCH/y
	 Vv1ouLb9kj31Ca+Urxcy/qGnvzRAPcOVp8vpn8ljGm5oQTft3jgosCMJMkiTxN/Ot8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793955754;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:In-Reply-To:
	 Content-Type:X-Forward:Date:Cc:To:MIME-Version:Message-ID:Subject:
	 User-Agent:Content-Transfer-Encoding:X-Virus-Scanned:X-Virus-Status;
	bh=bMhRHcG7RneS0nJbZUsoIDZ4zRdRVQ3qF3Hs9JXeFxo=;
	b=aRoBWdJtn6QbbPDx8BBjf0JTPvFmmMYtuTNL44nsvGF8YBY/MWjQ6YC70bPq8LHFssJ/
	 vu8fuLZFZoGmkLX3/1dWjGX7wYL1gilOfol8rKSJyo+nO2V/IdD6RseeSaj7WvJdnU66s
	 c7si1yvo7WD0VvIQlQgFQJhtmt+JS+32yuNUdYVDjNsqjd40F+I33S23ICR/FWyP2aUg6
	 t603nK3vaomKDcJPr5GBlA0ae9xIW4GwqcppW5wJz6r7I7MsHbkw+wv8ZglCWd5ybKZBk
	 UQ5WJjA1KJawMu90UcJVTBahJeZuCWuZoAsVHxbOga1838ecYRHDGY0puPzDXc/BRAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=eventlab.fr;
	spf=pass smtp.mailfrom=eventlab.fr;
	dkim=permerror header.d=eventlab.fr header.i=@eventlab.fr header.a=ed25519-sha256 header.s=default header.b=QaNHTAAU;
	arc=none smtp.remote-ip=212.27.42.6
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653AF606A328
	for <xenomai@lists.linux.dev>; Fri,  6 Nov 2026 09:02:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 653AF606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eventlab.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eventlab.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror header.d=eventlab.fr header.i=@eventlab.fr header.a=ed25519-sha256 header.s=default header.b=QaNHTAAU
Received: from mail.thom.fr.eu.org (unknown [82.64.149.25])
	by smtp6-g21.free.fr (Postfix) with ESMTPS id 988627803A2;
	Fri,  6 Nov 2026 10:02:25 +0100 (CET)
Authentication-Results: smtp6-g21.free.fr;
	dkim=permerror header.d=eventlab.fr header.i=@eventlab.fr header.a=ed25519-sha256 header.s=default header.b=QaNHTAAU;
	dkim-atps=neutral
Received: from localhost ([127.0.0.1])
	by mail.thom.fr.eu.org (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTP id 6A692MDN1879901;
	Fri, 6 Nov 2026 10:02:24 +0100
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple; d=eventlab.fr;
	s=default; t=1793955745;
	bh=cbcFhe7S24V66YrCajOAJ4mcboT/Y/cDK79n72K+6TY=;
	h=From:In-Reply-To:Date:Cc:To:Subject;
	b=QaNHTAAU5XsXiROFD5gpBbsmJNoVhreHz4GLIbV1n9nUH3+FZaahdiVIPbuSZDSAh
	 27WzDBm9VCLoczCS+TlHSQYJT/EWLl6zE3ptZxCqiGBoUO81M2dXq5qlc3vNxyIVDQ
	 6XmF10SfsCMGXLzG49sOFacBXhP4xSSAUovcZdieOCLq3iJ3eExYkOscwBO5JMCHhl
	 2MppbM11AsvOMzoW/eRRjmDLQvuPlrlXsQxm0+9TgrYMaLjkevvnRWNYvbPmbwt66u
	 g2ELUtWB3XTPql4uckTUP3IkBK3sgMKFWleRIZzEXQAQsBNRaeCpyofTRf7lViboqt
	 keP0jZJazXT3g==
From: =?utf-8?q?Fran=C3=A7ois_Legal?= <francois.legal@eventlab.fr>
In-Reply-To: <58f2f4501e0160436bc72c36f61e592dead7ae81.camel@siemens.com>
Content-Type: text/plain; charset="utf-8"
X-Forward: 217.109.173.233, 194.9.103.72
Date: Fri, 06 Nov 2026 10:02:22 +0100
Cc: xenomai@lists.linux.dev, rpm@xenomai.org, jan.kiszka@siemens.com
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
Message-ID: <1207-6aed9780-55-3e404bc0@80379430>
Subject: =?utf-8?q?Re=3A?= BUG at system boot
User-Agent: SOGoMail 5.0.1
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 1.4.3 at tls-srv-02
X-Virus-Status: Clean

Le Jeudi, Novembre 05, 2026 23:46 CET, Florian Bezdeka <florian.bezdeka=
@siemens.com> a =C3=A9crit: 
 
> On Thu, 2026-11-05 at 21:00 +0100, Florian Bezdeka wrote:
> > On Thu, 2026-11-05 at 16:25 +0100, Fran=C3=A7ois Legal wrote:
> > > Le Jeudi, Novembre 05, 2026 11:54 CET, Fran=C3=A7ois Legal <franc=
ois.legal@eventlab.fr> a =C3=A9crit: 
> > > =C2=A0
> > > > Le Lundi, Novembre 02, 2026 14:27 CET, Florian Bezdeka <florian=
.bezdeka@siemens.com> a =C3=A9crit: 
> > > > =C2=A0 
> > > > > On Fri, 2026-10-30 at 11:11 +0100, Fran=C3=A7ois Legal wrote:=

> > > > > > Le Jeudi, Octobre 29, 2026 14:26 CET, Florian Bezdeka <flor=
ian.bezdeka@siemens.com> a =C3=A9crit: 
> > > > > > =C2=A0 
> > > > > > > On Wed, 2026-10-28 at 17:37 +0100, Fran=C3=A7ois Legal wr=
ote:
> > > > > > > > Le Mercredi, Octobre 28, 2026 11:15 CET, Florian Bezdek=
a <florian.bezdeka@siemens.com> a =C3=A9crit: 
> > > > > > > > =C2=A0
> > > > > > > > > On Wed, 2026-10-28 at 09:36 +0100, Fran=C3=A7ois Lega=
l wrote:> > > > > > Le Mardi, Octobre 27, 2026 16:08 CET, Florian Bezde=
ka <florian.bezdeka@siemens.com> a =C3=A9crit: 
> > > > > > > > > > =C2=A0
> > > > > > > > > > > On Tue, 2026-10-27 at 15:44 +0100, Fran=C3=A7ois =
Legal wrote:
> > > > > > > > > > > > Switching my setup from linux 5.4 Ipipe + Xenom=
ai 3.2 to Linux 6.12 + dovetail + Xenomai 3.3, I experience the follwin=
g BUG() at system boot. Machine is zynq7000 SoC :
> > > > > > > > > > > > 
> > > > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C: platform mod=
ifies aux control register: 0x02060000 -> 0x02460000
> > > > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C: DT/platform =
modifies aux control register: 0x02060000 -> 0x02460000
> > > > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C-310 enabling =
early BRESP for Cortex-A9
> > > > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C-310 full line=
 of zeros enabled for Cortex-A9
> > > > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C-310 dynamic c=
lock gating enabled, standby mode enabled
> > > > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C-310 cache con=
troller enabled, 8 ways, 512 kB
> > > > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C-310: CACHE=5F=
ID 0x410000c8, AUX=5FCTRL 0x46460001
> > > > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] ------------[ cut=
 here ]------------
> > > > > > > > > > > 
> > > > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] WARNING: CPU: 0 P=
ID: 0 at kernel/irq/pipeline.c:1873 irq=5Fpipeline=5Finit+0x40/0x158
> > > > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] CPU: 0 UID: 0 PID=
: 0 Comm: swapper/0 Not tainted 6.12.90-cip24-yocto-standard-arksv #1
> > > > > > > > > > > 
> > > > > > > > > > > That version is a bit outdated already. Could you=
 please repeat the test
> > > > > > > > > > > with the current version in the v6.12.y-cip-dovet=
ail-rebase branch, just
> > > > > > > > > > > to make sure the problem has not already been fix=
ed.
> > > > > > > > > > > 
> > > > > > > > > > > On first glance that looks like an IRQ pipeline s=
tate corruption. I
> > > > > > > > > > > fixed some of them recently, so please give it a =
try.
> > > > > > > > > > > 
> > > > > > > > > > > The non-rebase branch - the version you are using=
 - has not been updated
> > > > > > > > > > > yet. Let's wait for your test results. If success=
ful we can ask Jan to
> > > > > > > > > > > do a stable release.
> > > > > > > > > > > 
> > > > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] Hardware name: Xi=
linx Zynq Platform
> > > > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] IRQ stage: Linux
> > > > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] Call trace: 
> > > > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 dump=5Fback=
trace from show=5Fstack+0x18/0x1c
> > > > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r7:c0c08f40=
 r6:c0a94cc8 r5:00000000 r4:00000080
> > > > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 show=5Fstac=
k from dump=5Fstack=5Flvl+0x94/0xc8
> > > > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 dump=5Fstac=
k=5Flvl from dump=5Fstack+0x18/0x1c
> > > > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r7:00000751=
 r6:00000009 r5:c0b0e65c r4:c0a65b0c
> > > > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 dump=5Fstac=
k from =5F=5Fwarn+0x80/0xe0
> > > > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 =5F=5Fwarn =
from warn=5Fslowpath=5Ffmt+0x1b0/0x1bc
> > > > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r7:00000000=
 r6:c0a65b0c r5:c0c08f40 r4:c0b4268c
> > > > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 warn=5Fslow=
path=5Ffmt from irq=5Fpipeline=5Finit+0x40/0x158
> > > > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r8:1eb76000=
 r7:00000000 r6:00000000 r5:c0c97038 r4:c0c97000
> > > > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 irq=5Fpipel=
ine=5Finit from start=5Fkernel+0x3f8/0x568
> > > > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r5:c0c97038=
 r4:c0c97000
> > > > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 start=5Fker=
nel from 0x0
> > > > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r7:00000000=

> > > > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] ---[ end trace 00=
00000000000000 ]---
> > > > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] IRQ pipeline enab=
led
> > > > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] rcu: srcu=5Finit:=
 Setting srcu=5Fstruct sizes based on contention.
> > > > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] zynq=5Fclock=5Fin=
it: clkc starts at (ptrval)
> > > > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] Zynq clock init
> > > > > > > > > > > > 
> > > > > > > > > > > > I don't really know how to chase this.
> > > > > > > > > > > > 
> > > > > > > > > > > > Fran=C3=A7ois
> > > > > > > > > > =C2=A0
> > > > > > > > > > =C2=A0I switched to the tip of that branch. I get t=
he same result :
> > > > > > > > > > 
> > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C-310 dynamic clock=
 gating enabled, standby mode enabled
> > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C-310 cache control=
ler enabled, 8 ways, 512 kB
> > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C-310: CACHE=5FID 0=
x410000c8, AUX=5FCTRL 0x46460001
> > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] ------------[ cut her=
e ]------------
> > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] WARNING: CPU: 0 PID: =
0 at kernel/irq/pipeline.c:1866 irq=5Fpipeline=5Finit+0x40/0x158
> > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] CPU: 0 UID: 0 PID: 0 =
Comm: swapper/0 Not tainted 6.12.96-cip28-yocto-standard-arksv #1
> > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] Hardware name: Xilinx=
 Zynq Platform
> > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] IRQ stage: Linux
> > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] Call trace:
> > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 dump=5Fbacktrac=
e from show=5Fstack+0x18/0x1c
> > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r7:c0c08f40 r6:=
c0a951a4 r5:00000000 r4:00000080
> > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 show=5Fstack fr=
om dump=5Fstack=5Flvl+0x94/0xc8
> > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 dump=5Fstack=5F=
lvl from dump=5Fstack+0x18/0x1c
> > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r7:0000074a r6:=
00000009 r5:c0b0e65c r4:c0a65fe8
> > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 dump=5Fstack fr=
om =5F=5Fwarn+0x80/0xe0
> > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 =5F=5Fwarn from=
 warn=5Fslowpath=5Ffmt+0x1b0/0x1bc
> > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r7:00000000 r6:=
c0a65fe8 r5:c0c08f40 r4:c0b4268c
> > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 warn=5Fslowpath=
=5Ffmt from irq=5Fpipeline=5Finit+0x40/0x158
> > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r8:1eb76000 r7:=
00000000 r6:00000000 r5:c0c97038 r4:c0c97000
> > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 irq=5Fpipeline=5F=
init from start=5Fkernel+0x3f8/0x568
> > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r5:c0c97038 r4:=
c0c97000> > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 start=5Fkernel =
from 0x0> > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r7:00000000
> > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] ---[ end trace 000000=
0000000000 ]---
> > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] IRQ pipeline enabled
> > > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] rcu: srcu=5Finit: Set=
ting srcu=5Fstruct sizes based on contention.
> > > > > > > > > > 
> > > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > Might be related: 
> > > > > > > > > https://lore.kernel.org/xenomai/CAKndYJGo5Yu7Ak694tX=3D=
cqRjtJneXs22DPjz=3DUDVkUcNJMWyOA@mail.gmail.com/
> > > > > > > > > 
> > > > > > > > > Quote:
> > > > > > > > > 
> > > > > > > > > > It actually booted as soon as I disabled the "scuti=
mer" clock source
> > > > > > > > > > via the DTB.=C2=A0 This made the kernel fall back t=
o "arm=5Fglobal=5Ftimer" and
> > > > > > > > > > now it boots properly.
> > > > > > > > > 
> > > > > > > > 
> > > > > > > > Well, I had this problem a while back at my first dovet=
ail attempt (was on linux 5.15 IIRC). Switching to 6.12, the system sta=
rted correctly at first try (except for that BUG signaled).
> > > > > > > > I even experience pretty good RT performance (about the=
 same I had with IPIPE)
> > > > > > > > 
> > > > > > > > > There are a couple of "hacks" mentioned in the mail t=
hread that you
> > > > > > > > > could try and report back.
> > > > > > > > > 
> > > > > > > > > Couple of questions:
> > > > > > > > > 
> > > > > > > > > - Does the board boot up with CONFIG=5FIRQ=5FPIPELINE=
 disabled?
> > > > > > > > > - Have you tried enabling 
> > > > > > > > > =C2=A0=C2=A0=C2=A0 - CONFIG=5FDEBUG=5FIRQ=5FPIPELINE
> > > > > > > > > =C2=A0=C2=A0=C2=A0 - CONFIG=5FIRQ=5FPIPELINE=5FTORTUR=
E=5FTEST> > > > > 
> > > > > > > > > Best regards,
> > > > > > > > > Florian
> > > > > > > > =C2=A0
> > > > > > > > I can see no differences with these options activated (=
apart from custom kernel driver that need to be fixed, but that will be=
 another thread if I can't fix it myself).
> > > > > > > > You can find the complete bootlog attached.
> > > > > > > > 
> > > > > > > 
> > > > > > > The hardware IRQ state is unexpected in your case. Hard I=
RQs are enabled
> > > > > > > where they are expected to be disabled. Quite early in th=
e boot process.
> > > > > > > 
> > > > > > > It might help to enable CONFIG=5FPROVE=5FLOCKING (enable =
lockdep). That
> > > > > > > might tell us where hard IRQs were enabled before we reac=
hed the check. 
> > > > > > > 
> > > > > > 
> > > > > > I just tried the CONFIG=5FPROVE=5FLOCKING option. Unfortuna=
tely, it seems the detector gets activated way after the inital BUG occ=
urs.
> > > > > > 
> > > > > > I also reviewed the Zynq clock init part, however, I'm not =
really sur to know what I'm looking for. I can tell that this is regist=
ering the clock tree elements within the kernel, and that some couples =
of spin=5Flock=5Firqsave/spin=5Flock=5Firqrestore are in the way.
> > > > > > 
> > > > > 
> > > > > I just send out a patch [1] for another trap handling issue t=
hat Jan
> > > > > found while trying to do some stable updates. I have no other=
 idea ATM.
> > > > > 
> > > > > [1] https://lore.kernel.org/xenomai/20261102125420.702769-1-f=
lorian.bezdeka@siemens.com/T/#u
> > > > > 
> > > > > Any further ideas from Philippe or Jan?
> > > > =C2=A0 
> > > > The patch did not help. Same result. So I checked what happens =
inmain before calling=C2=A0 irq=5Fpipeline=5Finit
> > > > IRQs are disabled until the call to init=5FIRQ(), after which t=
here enabled. I don't checked where (and possibly why it is so) nor if =
it's expected.
> > > > 
> > > > I'll post updates.
> > > > 
> > > 
> > > Here it is, coming from init=5FIRQ(), I get the follwing call tra=
ce
> > > 
> > > stop=5Fmachine=5Fcpuslocked
> > > patch=5Ftext
> > > =5F=5Farch=5Fjump=5Flabel=5Ftransform
> > > arch=5Fjump=5Flabel=5Ftransform
> > > jump=5Flabel=5Fcmp
> > > static=5Fkey=5Fdisable=5Fcpuslocked
> > > gic=5Fof=5Finit
> > > of=5Firq=5Finit
> > > irq=5Fchip=5Finit
> > > zynq=5Firq=5Finit
> > > init=5FIRQ
> > > 
> > > And there, in stop=5Fmachine=5Fcpuslocked, I see a cpsie i (which=
 enables the interrupts to the core) and a then a call to =5F=5Finband=5F=
irq=5Fenable.
> > > > 
> > 
> > This stop=5Fmachine=5Fcpuslocked() is unconditionally enabling hard=
 IRQs. It
> > seems this call is unexpected at this stage, even before initializi=
ng
> > the pipelining core, which is expecting hard IRQs off at initializa=
tion.
> > 
> > Maybe worth a try:
> > 
> > diff --git a/kernel/stop=5Fmachine.c b/kernel/stop=5Fmachine.c
> > index cc7a2c6431ea6..912adf6016acc 100644
> > --- a/kernel/stop=5Fmachine.c
> > +++ b/kernel/stop=5Fmachine.c
> > @@ -601,15 +601,16 @@ int stop=5Fmachine=5Fcpuslocked(cpu=5Fstop=5F=
fn=5Ft fn, void *data,
> >  		 * early in boot before stop=5Fmachine() has been
> >  		 * initialized.
> >  		 */
> > +		unsigned long irqflags;
> >  		unsigned long flags;
> >  		int ret;
> >  
> >  		WARN=5FON=5FONCE(msdata.num=5Fthreads !=3D 1);
> >  
> >  		local=5Firq=5Fsave(flags);
> > -		hard=5Firq=5Fdisable();
> > +		irqflags =3D hard=5Fcond=5Flocal=5Firq=5Fsave();
> >  		ret =3D (*fn)(data);
> > -		hard=5Firq=5Fenable();
> > +		hard=5Fcond=5Flocal=5Firq=5Frestore(irqflags);
> >  		local=5Firq=5Frestore(flags);
> >  
> >  		return ret;
> 
> In addition, I forgot the !SMP case:
> 
> diff --git a/include/linux/stop=5Fmachine.h b/include/linux/stop=5Fma=
chine.h
> index 1ec7ad5314748..ba7ee4c9c0674 100644
> --- a/include/linux/stop=5Fmachine.h
> +++ b/include/linux/stop=5Fmachine.h
> @@ -165,13 +165,14 @@ int stop=5Fmachine=5Ffrom=5Finactive=5Fcpu(cpu=5F=
stop=5Ffn=5Ft fn, void *data,
>  static =5F=5Falways=5Finline int stop=5Fmachine=5Fcpuslocked(cpu=5Fs=
top=5Ffn=5Ft fn, void *data,
>  					  const struct cpumask *cpus)
>  {
> +	unsigned long irqflags;
>  	unsigned long flags;
>  	int ret;
>  	local=5Firq=5Fsave(flags);
> -	hard=5Firq=5Fdisable();
> +	irqflags =3D hard=5Fcond=5Flocal=5Firq=5Fdisable();
>  	ret =3D fn(data);
>  	hard=5Firq=5Fenable();
> -	local=5Firq=5Frestore(flags);
> +	hard=5Fcond=5Flocal=5Firq=5Frestore(irqflags);
>  	return ret;
>  }
 
 
 
Thanks. That fixes the bug. With a minor correction in your patch :
 @@ -165,11 +165,12 @@ int stop=5Fmachine=5Ffrom=5Finactive=5Fcpu(cpu=5F=
stop=5Ffn=5Ft fn, void *data,

Fran=C3=A7ois

