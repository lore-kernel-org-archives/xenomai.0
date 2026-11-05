Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.27.42.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793892346;
	b=agSSBST1I16NNT6W7SaOjYaVAzYysp66Aq43oXiLp8rxHah7vYOT+y+iMmKyYj4VsCxm
	 NkTJxi0bdgMVXCaKBGXhS9jX1XvpOrFE0wAMIehi8210+F6HSQTVmg8X4XY6EhMCcEoXM
	 S5H5B/vJ6oqYQoa/8PohAA2w3ZjMAkIx/hJ91Ti14EuS2fP/Ls9+8kSeRaN8GPEaYsWzn
	 82ZJGgWzdfYTYbtLlVIYc240DiOoAIbScKCOOjnZ3oKkE7dB6UCT+VVBYhJ/kcwLecHlX
	 xfe1kW+uxz8P4+2ZJgLt0V4Hj4oQIckMTrPEt/IlX7gcb1oSNwDmSAuALBmY279uo+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793892346;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Content-Type:
	 X-Forward:Date:Cc:To:MIME-Version:Message-ID:Subject:User-Agent:
	 Content-Transfer-Encoding:X-Virus-Scanned:X-Virus-Status;
	bh=fbKJl6zG9FQySWu1FiLeA37Msjtv6Gn1VS7/MvKADHc=;
	b=mzN++wwWWpJP6MXjx5dMyvVnd6lHE4GuKnOWciMkJvkWxkqknoV4w79AKBMKRcju9ei3
	 1VZQ0lnCYY14aSvi4vnq5IBjf4OcL3hnsAyG1prgvWNp8490JLyfJ49KGGRStnz1KM8vL
	 tWe+OcXbZWQZCMhGeR4Mf1QzfDEupsdKLzc8HlbA3IPSJhYRTFKLtevgXXjtJbfCO47c6
	 tPNnGG8KcICZ1tmRduet7i+ePm3ctDMtX3PgV9zdozB/wJfL25Z+D3lSOlQLrULH7BEna
	 C1lQFAjQweHSqpanVIq8bkhKRaXlaq0HbmyVP6UYUTQ2DeQBfAM2GnD/Bv1CVGUa9EQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=eventlab.fr;
	spf=pass smtp.mailfrom=eventlab.fr;
	dkim=permerror header.d=eventlab.fr header.i=@eventlab.fr header.a=ed25519-sha256 header.s=default header.b=fn1CYogo;
	arc=none smtp.remote-ip=212.27.42.6
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC1B606A328
	for <xenomai@lists.linux.dev>; Thu,  5 Nov 2026 15:25:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABC1B606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eventlab.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eventlab.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror header.d=eventlab.fr header.i=@eventlab.fr header.a=ed25519-sha256 header.s=default header.b=fn1CYogo
Received: from mail.thom.fr.eu.org (unknown [82.64.149.25])
	by smtp6-g21.free.fr (Postfix) with ESMTPS id 9A41E780316;
	Thu,  5 Nov 2026 16:25:39 +0100 (CET)
Authentication-Results: smtp6-g21.free.fr;
	dkim=permerror header.d=eventlab.fr header.i=@eventlab.fr header.a=ed25519-sha256 header.s=default header.b=fn1CYogo;
	dkim-atps=neutral
Received: from localhost ([127.0.0.1])
	by mail.thom.fr.eu.org (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTP id 6A5FPcPr1846273;
	Thu, 5 Nov 2026 16:25:38 +0100
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple; d=eventlab.fr;
	s=default; t=1793892339;
	bh=vBPne6RKKZIxMYuzJf/YMZdMFOrWPnxx3XUptvY4Ug0=;
	h=From:Date:Cc:To:Subject;
	b=fn1CYogorXWlNz1d1r9xKsc0uhKc/PT/yeZ/miVuAq7Cgv3TbbDBteVp8a3EjFaeL
	 1M97WVp2KveAIu3lIcDqh+4QoTpBw+sMsEnu9XC5TaxqmHAHZ0+F0AxHVCvxqDfNjx
	 bVDfLoqEKzOgZSCDW73U8mLdwI+UnRl9csNox/AWm08q3/rR9tvXS+z+zmhNq4RuAH
	 xrRuaK5mTf0U4vFTgUY3eQHGEFenO69D7ZAUy2mIf68GD9+EQ1j5CvK5M540G+gm+7
	 t57isbdQ1+9DbL2mqEcTUynSMS4yVW3xoiid3MNNl1LLJEgAD47Zw116zZFh9gYvya
	 e2phDAOejCRYQ==
From: =?utf-8?q?Fran=C3=A7ois_Legal?= <francois.legal@eventlab.fr>
Content-Type: text/plain; charset="utf-8"
X-Forward: 217.109.173.233, 194.9.103.72
Date: Thu, 05 Nov 2026 16:25:38 +0100
Cc: florian.bezdeka@siemens.com, rpm@xenomai.org, jan.kiszka@siemens.com
To: xenomai@lists.linux.dev
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Message-ID: <1207-6aeca000-53-3e404bc0@80379397>
Subject: =?utf-8?q?Re=3A?= BUG at system boot
User-Agent: SOGoMail 5.0.1
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 1.4.3 at tls-srv-02
X-Virus-Status: Clean

Le Jeudi, Novembre 05, 2026 11:54 CET, Fran=C3=A7ois Legal <francois.le=
gal@eventlab.fr> a =C3=A9crit: 
 
> Le Lundi, Novembre 02, 2026 14:27 CET, Florian Bezdeka <florian.bezde=
ka@siemens.com> a =C3=A9crit: 
>  
> > On Fri, 2026-10-30 at 11:11 +0100, Fran=C3=A7ois Legal wrote:
> > > Le Jeudi, Octobre 29, 2026 14:26 CET, Florian Bezdeka <florian.be=
zdeka@siemens.com> a =C3=A9crit: 
> > >  
> > > > On Wed, 2026-10-28 at 17:37 +0100, Fran=C3=A7ois Legal wrote:
> > > > > Le Mercredi, Octobre 28, 2026 11:15 CET, Florian Bezdeka <flo=
rian.bezdeka@siemens.com> a =C3=A9crit: 
> > > > > =C2=A0
> > > > > > On Wed, 2026-10-28 at 09:36 +0100, Fran=C3=A7ois Legal wrot=
e:> > > > > > Le Mardi, Octobre 27, 2026 16:08 CET, Florian Bezdeka <fl=
orian.bezdeka@siemens.com> a =C3=A9crit: 
> > > > > > > =C2=A0
> > > > > > > > On Tue, 2026-10-27 at 15:44 +0100, Fran=C3=A7ois Legal =
wrote:
> > > > > > > > > Switching my setup from linux 5.4 Ipipe + Xenomai 3.2=
 to Linux 6.12 + dovetail + Xenomai 3.3, I experience the follwing BUG(=
) at system boot. Machine is zynq7000 SoC :
> > > > > > > > > 
> > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C: platform modifies =
aux control register: 0x02060000 -> 0x02460000
> > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C: DT/platform modifi=
es aux control register: 0x02060000 -> 0x02460000
> > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C-310 enabling early =
BRESP for Cortex-A9
> > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C-310 full line of ze=
ros enabled for Cortex-A9
> > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C-310 dynamic clock g=
ating enabled, standby mode enabled
> > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C-310 cache controlle=
r enabled, 8 ways, 512 kB
> > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C-310: CACHE=5FID 0x4=
10000c8, AUX=5FCTRL 0x46460001
> > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] ------------[ cut here =
]------------
> > > > > > > > 
> > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] WARNING: CPU: 0 PID: 0 =
at kernel/irq/pipeline.c:1873 irq=5Fpipeline=5Finit+0x40/0x158
> > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] CPU: 0 UID: 0 PID: 0 Co=
mm: swapper/0 Not tainted 6.12.90-cip24-yocto-standard-arksv #1
> > > > > > > > 
> > > > > > > > That version is a bit outdated already. Could you pleas=
e repeat the test
> > > > > > > > with the current version in the v6.12.y-cip-dovetail-re=
base branch, just
> > > > > > > > to make sure the problem has not already been fixed.
> > > > > > > > 
> > > > > > > > On first glance that looks like an IRQ pipeline state c=
orruption. I
> > > > > > > > fixed some of them recently, so please give it a try.
> > > > > > > > 
> > > > > > > > The non-rebase branch - the version you are using - has=
 not been updated
> > > > > > > > yet. Let's wait for your test results. If successful we=
 can ask Jan to
> > > > > > > > do a stable release.
> > > > > > > > 
> > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] Hardware name: Xilinx Z=
ynq Platform
> > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] IRQ stage: Linux
> > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] Call trace: 
> > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 dump=5Fbacktrace =
from show=5Fstack+0x18/0x1c
> > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r7:c0c08f40 r6:c0=
a94cc8 r5:00000000 r4:00000080
> > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 show=5Fstack from=
 dump=5Fstack=5Flvl+0x94/0xc8
> > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 dump=5Fstack=5Flv=
l from dump=5Fstack+0x18/0x1c
> > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r7:00000751 r6:00=
000009 r5:c0b0e65c r4:c0a65b0c
> > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 dump=5Fstack from=
 =5F=5Fwarn+0x80/0xe0
> > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 =5F=5Fwarn from w=
arn=5Fslowpath=5Ffmt+0x1b0/0x1bc
> > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r7:00000000 r6:c0=
a65b0c r5:c0c08f40 r4:c0b4268c
> > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 warn=5Fslowpath=5F=
fmt from irq=5Fpipeline=5Finit+0x40/0x158
> > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r8:1eb76000 r7:00=
000000 r6:00000000 r5:c0c97038 r4:c0c97000
> > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 irq=5Fpipeline=5F=
init from start=5Fkernel+0x3f8/0x568
> > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r5:c0c97038 r4:c0=
c97000
> > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 start=5Fkernel fr=
om 0x0
> > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r7:00000000
> > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] ---[ end trace 00000000=
00000000 ]---
> > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] IRQ pipeline enabled
> > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] rcu: srcu=5Finit: Setti=
ng srcu=5Fstruct sizes based on contention.
> > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] zynq=5Fclock=5Finit: cl=
kc starts at (ptrval)
> > > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] Zynq clock init
> > > > > > > > > 
> > > > > > > > > I don't really know how to chase this.
> > > > > > > > > 
> > > > > > > > > Fran=C3=A7ois
> > > > > > > =C2=A0
> > > > > > > =C2=A0I switched to the tip of that branch. I get the sam=
e result :
> > > > > > > 
> > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C-310 dynamic clock gatin=
g enabled, standby mode enabled
> > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C-310 cache controller en=
abled, 8 ways, 512 kB
> > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C-310: CACHE=5FID 0x41000=
0c8, AUX=5FCTRL 0x46460001
> > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] ------------[ cut here ]---=
---------
> > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] WARNING: CPU: 0 PID: 0 at k=
ernel/irq/pipeline.c:1866 irq=5Fpipeline=5Finit+0x40/0x158
> > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] CPU: 0 UID: 0 PID: 0 Comm: =
swapper/0 Not tainted 6.12.96-cip28-yocto-standard-arksv #1
> > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] Hardware name: Xilinx Zynq =
Platform
> > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] IRQ stage: Linux
> > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] Call trace:
> > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 dump=5Fbacktrace from=
 show=5Fstack+0x18/0x1c
> > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r7:c0c08f40 r6:c0a951=
a4 r5:00000000 r4:00000080
> > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 show=5Fstack from dum=
p=5Fstack=5Flvl+0x94/0xc8
> > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 dump=5Fstack=5Flvl fr=
om dump=5Fstack+0x18/0x1c
> > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r7:0000074a r6:000000=
09 r5:c0b0e65c r4:c0a65fe8
> > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 dump=5Fstack from =5F=
=5Fwarn+0x80/0xe0
> > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 =5F=5Fwarn from warn=5F=
slowpath=5Ffmt+0x1b0/0x1bc
> > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r7:00000000 r6:c0a65f=
e8 r5:c0c08f40 r4:c0b4268c
> > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 warn=5Fslowpath=5Ffmt=
 from irq=5Fpipeline=5Finit+0x40/0x158
> > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r8:1eb76000 r7:000000=
00 r6:00000000 r5:c0c97038 r4:c0c97000
> > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 irq=5Fpipeline=5Finit=
 from start=5Fkernel+0x3f8/0x568
> > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r5:c0c97038 r4:c0c970=
00> > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 start=5Fkernel from 0=
x0> > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r7:00000000
> > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] ---[ end trace 000000000000=
0000 ]---
> > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] IRQ pipeline enabled
> > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] rcu: srcu=5Finit: Setting s=
rcu=5Fstruct sizes based on contention.
> > > > > > > 
> > > > > > > 
> > > > > > 
> > > > > > Might be related: 
> > > > > > https://lore.kernel.org/xenomai/CAKndYJGo5Yu7Ak694tX=3DcqRj=
tJneXs22DPjz=3DUDVkUcNJMWyOA@mail.gmail.com/
> > > > > > 
> > > > > > Quote:
> > > > > > 
> > > > > > > It actually booted as soon as I disabled the "scutimer" c=
lock source
> > > > > > > via the DTB.=C2=A0 This made the kernel fall back to "arm=
=5Fglobal=5Ftimer" and
> > > > > > > now it boots properly.
> > > > > > 
> > > > > 
> > > > > Well, I had this problem a while back at my first dovetail at=
tempt (was on linux 5.15 IIRC). Switching to 6.12, the system started c=
orrectly at first try (except for that BUG signaled).
> > > > > I even experience pretty good RT performance (about the same =
I had with IPIPE)
> > > > > 
> > > > > > There are a couple of "hacks" mentioned in the mail thread =
that you
> > > > > > could try and report back.
> > > > > > 
> > > > > > Couple of questions:
> > > > > > 
> > > > > > - Does the board boot up with CONFIG=5FIRQ=5FPIPELINE disab=
led?
> > > > > > - Have you tried enabling 
> > > > > > =C2=A0=C2=A0=C2=A0 - CONFIG=5FDEBUG=5FIRQ=5FPIPELINE
> > > > > > =C2=A0=C2=A0=C2=A0 - CONFIG=5FIRQ=5FPIPELINE=5FTORTURE=5FTE=
ST> > > > > 
> > > > > > Best regards,
> > > > > > Florian
> > > > > =C2=A0
> > > > > I can see no differences with these options activated (apart =
from custom kernel driver that need to be fixed, but that will be anoth=
er thread if I can't fix it myself).
> > > > > You can find the complete bootlog attached.
> > > > > 
> > > > 
> > > > The hardware IRQ state is unexpected in your case. Hard IRQs ar=
e enabled
> > > > where they are expected to be disabled. Quite early in the boot=
 process.
> > > > 
> > > > It might help to enable CONFIG=5FPROVE=5FLOCKING (enable lockde=
p). That
> > > > might tell us where hard IRQs were enabled before we reached th=
e check. 
> > > > 
> > > 
> > > I just tried the CONFIG=5FPROVE=5FLOCKING option. Unfortunately, =
it seems the detector gets activated way after the inital BUG occurs.
> > > 
> > > I also reviewed the Zynq clock init part, however, I'm not really=
 sur to know what I'm looking for. I can tell that this is registering =
the clock tree elements within the kernel, and that some couples of spi=
n=5Flock=5Firqsave/spin=5Flock=5Firqrestore are in the way.
> > > 
> > 
> > I just send out a patch [1] for another trap handling issue that Ja=
n
> > found while trying to do some stable updates. I have no other idea =
ATM.
> > 
> > [1] https://lore.kernel.org/xenomai/20261102125420.702769-1-florian=
.bezdeka@siemens.com/T/#u
> > 
> > Any further ideas from Philippe or Jan?
>  
> The patch did not help. Same result. So I checked what happens inmain=
 before calling  irq=5Fpipeline=5Finit
> IRQs are disabled until the call to init=5FIRQ(), after which there e=
nabled. I don't checked where (and possibly why it is so) nor if it's e=
xpected.
> 
> I'll post updates.
> 

Here it is, coming from init=5FIRQ(), I get the follwing call trace

stop=5Fmachine=5Fcpuslocked
patch=5Ftext
=5F=5Farch=5Fjump=5Flabel=5Ftransform
arch=5Fjump=5Flabel=5Ftransform
jump=5Flabel=5Fcmp
static=5Fkey=5Fdisable=5Fcpuslocked
gic=5Fof=5Finit
of=5Firq=5Finit
irq=5Fchip=5Finit
zynq=5Firq=5Finit
init=5FIRQ

And there, in stop=5Fmachine=5Fcpuslocked, I see a cpsie i (which enabl=
es the interrupts to the core) and a then a call to =5F=5Finband=5Firq=5F=
enable.

> Fran=C3=A7ois
> 
>

