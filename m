Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.27.42.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793876075;
	b=ggcbyKFagL4azGDfoNWS+F/pjbA6Pipv1IJeqqK6dRrfZOYHvQGcbJhq2Sa/z/sC24YE
	 i7FKy6WC7NpEwB38YTWI63nKKl+u+Mwv/5jwHCLrn1hvvEA2uthlEP1gnDF1Um8uoqbUf
	 u6JbQwC+VCjfwFPIOghaXJuaYIRY6euxKlzQ1NoEevABDFSdwJYm/mrPfLgXQ2l56GfOt
	 Cl6lEjYmV0IAZatWdYxe1Vn2YvPYy4vY2jAY6iomA16Kh1sMizXO5thBx7Y/anWUZSMZn
	 k3hGU6z3FoAnwqxbLagGhmO5v3s/QpxZXFnuk2Za8kLGDaB5cAqL/CiqH7LY6Z95EMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793876075;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:In-Reply-To:
	 Content-Type:X-Forward:Date:Cc:To:MIME-Version:Message-ID:Subject:
	 User-Agent:Content-Transfer-Encoding:X-Virus-Scanned:X-Virus-Status;
	bh=fLdDbxxAe81KvK3Vk/1f41rHuyR34tK79G8+wn5NYmM=;
	b=AcK7WhAm1haSc7YKbfWzyViEWmnne3qdW63IWdnwPKGcyV5ctOPjaacZ4PmyKmS16EDQ
	 MijknwaSs+qwho87nGpmSFeMvJ0/+Gd9T2PcLoEexuuL6oqTILGF3UeDn2pPP/wGcsiBZ
	 v2v73t+0UrotRIYwGKDKOM9wdCVRYyefnPEsI23bZWoBmFgUUlb2myTMbnzS/mhY8bxs2
	 4sK5El2PxF7iLpRMlscmfpirjEy6vNKX0j7otefz2njVDBzpT105+wEwwqJmqFWJSqoa5
	 5aeZ9usTEweczUPta9ZukdKfTzc0KIKPNvmzoDsuEhFvvk8yG1tOAXbgL76/l/XOHGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=eventlab.fr;
	spf=pass smtp.mailfrom=eventlab.fr;
	dkim=permerror header.d=eventlab.fr header.i=@eventlab.fr header.a=ed25519-sha256 header.s=default header.b=pcDtbM65;
	arc=none smtp.remote-ip=212.27.42.6
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2ACD606A31B
	for <xenomai@lists.linux.dev>; Thu,  5 Nov 2026 10:54:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2ACD606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eventlab.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eventlab.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror header.d=eventlab.fr header.i=@eventlab.fr header.a=ed25519-sha256 header.s=default header.b=pcDtbM65
Received: from mail.thom.fr.eu.org (unknown [82.64.149.25])
	by smtp6-g21.free.fr (Postfix) with ESMTPS id 4B885780331;
	Thu,  5 Nov 2026 11:54:20 +0100 (CET)
Authentication-Results: smtp6-g21.free.fr;
	dkim=permerror header.d=eventlab.fr header.i=@eventlab.fr header.a=ed25519-sha256 header.s=default header.b=pcDtbM65;
	dkim-atps=neutral
Received: from localhost ([127.0.0.1])
	by mail.thom.fr.eu.org (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTP id 6A5AsIGf1836068;
	Thu, 5 Nov 2026 11:54:19 +0100
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple; d=eventlab.fr;
	s=default; t=1793876059;
	bh=E+EUIV6FCxadkSMkktxtWCbQnhQlNgF3D7yYEHKiMY0=;
	h=From:In-Reply-To:Date:Cc:To:Subject;
	b=pcDtbM65VflYUhdHUoCddwTHwbCovXGS3HCwcpawLVA9d96JCCFaMvjiFX6FLVkf9
	 iPkQ2EYYzEN5hpijDvy7zIbeghtYAHOMi8NtXAGMgUVsQT8Er74Rvu6rJSShW47vTh
	 VpWourhaxDUGRAfDKt0/5g2dv5xP8ZAydh7ceNt9mNKMLOfTj1UfUEt/pOmZU9WZRj
	 xeBzCmG23UuupjlbpQP8pMv6eX8bVH6Nwtb40iNLc86aP4kxoBwJpSxFW4Ch0iwPQ7
	 OmnraPTyEGfsbwf14MMvwjdpnW6oIlnIckG8l3ckhSwxyoRV+Y9MpnBCfKPPDgZ9X5
	 EEnfUifKbSWDQ==
From: =?utf-8?q?Fran=C3=A7ois_Legal?= <francois.legal@eventlab.fr>
In-Reply-To: <8bce78d242be8c494e814ea5602a40524507bfd3.camel@siemens.com>
Content-Type: text/plain; charset="utf-8"
X-Forward: 217.109.173.233, 194.9.103.72
Date: Thu, 05 Nov 2026 11:54:18 +0100
Cc: xenomai@lists.linux.dev, "Philippe Gerum" <rpm@xenomai.org>,
        "Jan Kiszka" <jan.kiszka@siemens.com>
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
Message-ID: <115efd-6aec6080-11-36f80d40@211094666>
Subject: =?utf-8?q?Re=3A?= BUG at system boot
User-Agent: SOGoMail 5.0.1
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 1.4.3 at tls-srv-02
X-Virus-Status: Clean

Le Lundi, Novembre 02, 2026 14:27 CET, Florian Bezdeka <florian.bezdeka=
@siemens.com> a =C3=A9crit: 
 
> On Fri, 2026-10-30 at 11:11 +0100, Fran=C3=A7ois Legal wrote:
> > Le Jeudi, Octobre 29, 2026 14:26 CET, Florian Bezdeka <florian.bezd=
eka@siemens.com> a =C3=A9crit: 
> >  
> > > On Wed, 2026-10-28 at 17:37 +0100, Fran=C3=A7ois Legal wrote:
> > > > Le Mercredi, Octobre 28, 2026 11:15 CET, Florian Bezdeka <flori=
an.bezdeka@siemens.com> a =C3=A9crit: 
> > > > =C2=A0
> > > > > On Wed, 2026-10-28 at 09:36 +0100, Fran=C3=A7ois Legal wrote:=

> > > > > > Le Mardi, Octobre 27, 2026 16:08 CET, Florian Bezdeka <flor=
ian.bezdeka@siemens.com> a =C3=A9crit: 
> > > > > > =C2=A0
> > > > > > > On Tue, 2026-10-27 at 15:44 +0100, Fran=C3=A7ois Legal wr=
ote:
> > > > > > > > Switching my setup from linux 5.4 Ipipe + Xenomai 3.2 t=
o Linux 6.12 + dovetail + Xenomai 3.3, I experience the follwing BUG() =
at system boot. Machine is zynq7000 SoC :
> > > > > > > > 
> > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C: platform modifies au=
x control register: 0x02060000 -> 0x02460000
> > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C: DT/platform modifies=
 aux control register: 0x02060000 -> 0x02460000
> > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C-310 enabling early BR=
ESP for Cortex-A9
> > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C-310 full line of zero=
s enabled for Cortex-A9
> > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C-310 dynamic clock gat=
ing enabled, standby mode enabled
> > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C-310 cache controller =
enabled, 8 ways, 512 kB
> > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C-310: CACHE=5FID 0x410=
000c8, AUX=5FCTRL 0x46460001
> > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] ------------[ cut here ]-=
-----------
> > > > > > > 
> > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] WARNING: CPU: 0 PID: 0 at=
 kernel/irq/pipeline.c:1873 irq=5Fpipeline=5Finit+0x40/0x158
> > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] CPU: 0 UID: 0 PID: 0 Comm=
: swapper/0 Not tainted 6.12.90-cip24-yocto-standard-arksv #1
> > > > > > > 
> > > > > > > That version is a bit outdated already. Could you please =
repeat the test
> > > > > > > with the current version in the v6.12.y-cip-dovetail-reba=
se branch, just
> > > > > > > to make sure the problem has not already been fixed.
> > > > > > > 
> > > > > > > On first glance that looks like an IRQ pipeline state cor=
ruption. I
> > > > > > > fixed some of them recently, so please give it a try.
> > > > > > > 
> > > > > > > The non-rebase branch - the version you are using - has n=
ot been updated
> > > > > > > yet. Let's wait for your test results. If successful we c=
an ask Jan to
> > > > > > > do a stable release.
> > > > > > > 
> > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] Hardware name: Xilinx Zyn=
q Platform
> > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] IRQ stage: Linux
> > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] Call trace: 
> > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 dump=5Fbacktrace fr=
om show=5Fstack+0x18/0x1c
> > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r7:c0c08f40 r6:c0a9=
4cc8 r5:00000000 r4:00000080
> > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 show=5Fstack from d=
ump=5Fstack=5Flvl+0x94/0xc8
> > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 dump=5Fstack=5Flvl =
from dump=5Fstack+0x18/0x1c
> > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r7:00000751 r6:0000=
0009 r5:c0b0e65c r4:c0a65b0c
> > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 dump=5Fstack from =5F=
=5Fwarn+0x80/0xe0
> > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 =5F=5Fwarn from war=
n=5Fslowpath=5Ffmt+0x1b0/0x1bc
> > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r7:00000000 r6:c0a6=
5b0c r5:c0c08f40 r4:c0b4268c
> > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 warn=5Fslowpath=5Ff=
mt from irq=5Fpipeline=5Finit+0x40/0x158
> > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r8:1eb76000 r7:0000=
0000 r6:00000000 r5:c0c97038 r4:c0c97000
> > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 irq=5Fpipeline=5Fin=
it from start=5Fkernel+0x3f8/0x568
> > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r5:c0c97038 r4:c0c9=
7000
> > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 start=5Fkernel from=
 0x0
> > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r7:00000000
> > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] ---[ end trace 0000000000=
000000 ]---
> > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] IRQ pipeline enabled
> > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] rcu: srcu=5Finit: Setting=
 srcu=5Fstruct sizes based on contention.
> > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] zynq=5Fclock=5Finit: clkc=
 starts at (ptrval)
> > > > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] Zynq clock init
> > > > > > > > 
> > > > > > > > I don't really know how to chase this.
> > > > > > > > 
> > > > > > > > Fran=C3=A7ois
> > > > > > =C2=A0
> > > > > > =C2=A0I switched to the tip of that branch. I get the same =
result :
> > > > > > 
> > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C-310 dynamic clock gating =
enabled, standby mode enabled
> > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C-310 cache controller enab=
led, 8 ways, 512 kB
> > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] L2C-310: CACHE=5FID 0x410000c=
8, AUX=5FCTRL 0x46460001
> > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] ------------[ cut here ]-----=
-------
> > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] WARNING: CPU: 0 PID: 0 at ker=
nel/irq/pipeline.c:1866 irq=5Fpipeline=5Finit+0x40/0x158
> > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] CPU: 0 UID: 0 PID: 0 Comm: sw=
apper/0 Not tainted 6.12.96-cip28-yocto-standard-arksv #1
> > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] Hardware name: Xilinx Zynq Pl=
atform
> > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] IRQ stage: Linux
> > > > > > [=C2=A0=C2=A0=C2=A0 0.000000] Call trace:
> > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 dump=5Fbacktrace from s=
how=5Fstack+0x18/0x1c
> > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r7:c0c08f40 r6:c0a951a4=
 r5:00000000 r4:00000080
> > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 show=5Fstack from dump=5F=
stack=5Flvl+0x94/0xc8
> > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 dump=5Fstack=5Flvl from=
 dump=5Fstack+0x18/0x1c
> > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r7:0000074a r6:00000009=
 r5:c0b0e65c r4:c0a65fe8
> > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 dump=5Fstack from =5F=5F=
warn+0x80/0xe0
> > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 =5F=5Fwarn from warn=5F=
slowpath=5Ffmt+0x1b0/0x1bc
> > > > > > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r7:00000000 r6:c0a65fe8=
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
> > > > > > 
> > > > > > 
> > > > > 
> > > > > Might be related: 
> > > > > https://lore.kernel.org/xenomai/CAKndYJGo5Yu7Ak694tX=3DcqRjtJ=
neXs22DPjz=3DUDVkUcNJMWyOA@mail.gmail.com/
> > > > > 
> > > > > Quote:
> > > > > 
> > > > > > It actually booted as soon as I disabled the "scutimer" clo=
ck source
> > > > > > via the DTB.=C2=A0 This made the kernel fall back to "arm=5F=
global=5Ftimer" and
> > > > > > now it boots properly.
> > > > > 
> > > > 
> > > > Well, I had this problem a while back at my first dovetail atte=
mpt (was on linux 5.15 IIRC). Switching to 6.12, the system started cor=
rectly at first try (except for that BUG signaled).
> > > > I even experience pretty good RT performance (about the same I =
had with IPIPE)
> > > > 
> > > > > There are a couple of "hacks" mentioned in the mail thread th=
at you
> > > > > could try and report back.
> > > > > 
> > > > > Couple of questions:
> > > > > 
> > > > > - Does the board boot up with CONFIG=5FIRQ=5FPIPELINE disable=
d?
> > > > > - Have you tried enabling 
> > > > > =C2=A0=C2=A0=C2=A0 - CONFIG=5FDEBUG=5FIRQ=5FPIPELINE
> > > > > =C2=A0=C2=A0=C2=A0 - CONFIG=5FIRQ=5FPIPELINE=5FTORTURE=5FTEST=

> > > > > 
> > > > > Best regards,
> > > > > Florian
> > > > =C2=A0
> > > > I can see no differences with these options activated (apart fr=
om custom kernel driver that need to be fixed, but that will be another=
 thread if I can't fix it myself).
> > > > You can find the complete bootlog attached.
> > > > 
> > > 
> > > The hardware IRQ state is unexpected in your case. Hard IRQs are =
enabled
> > > where they are expected to be disabled. Quite early in the boot p=
rocess.
> > > 
> > > It might help to enable CONFIG=5FPROVE=5FLOCKING (enable lockdep)=
. That
> > > might tell us where hard IRQs were enabled before we reached the =
check. 
> > > 
> > 
> > I just tried the CONFIG=5FPROVE=5FLOCKING option. Unfortunately, it=
 seems the detector gets activated way after the inital BUG occurs.
> > 
> > I also reviewed the Zynq clock init part, however, I'm not really s=
ur to know what I'm looking for. I can tell that this is registering th=
e clock tree elements within the kernel, and that some couples of spin=5F=
lock=5Firqsave/spin=5Flock=5Firqrestore are in the way.
> > 
> 
> I just send out a patch [1] for another trap handling issue that Jan
> found while trying to do some stable updates. I have no other idea AT=
M.
> 
> [1] https://lore.kernel.org/xenomai/20261102125420.702769-1-florian.b=
ezdeka@siemens.com/T/#u
> 
> Any further ideas from Philippe or Jan?
 
The patch did not help. Same result. So I checked what happens inmain b=
efore calling  irq=5Fpipeline=5Finit
IRQs are disabled until the call to init=5FIRQ(), after which there ena=
bled. I don't checked where (and possibly why it is so) nor if it's exp=
ected.

I'll post updates.

Fran=C3=A7ois

