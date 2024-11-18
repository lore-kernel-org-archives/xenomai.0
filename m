Received: from redirect.mail.gandi.net (relay14.mail.gandi.net [217.70.178.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C848319AD7E
	for <xenomai@lists.linux.dev>; Mon, 18 Nov 2024 15:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731943399; cv=none; b=WiwzacFq8K3pSi06FyBu0w1RymyQ+lWwFWCyJkbv/hpcHumplem5Xx/+oLxAUUNgNdRAQ7TSmjQMPBEocGkmStbSZvBCT5Gtl5wg6rksP47pg+tnMxIkmj8v3PcO0RSUUIsEOrA/1IsHJqWVLUkZx3+cYS9D4gFW3HFUQDEY4fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731943399; c=relaxed/simple;
	bh=lwx/4vqVR/BCsh+08QfvhYRZO0wE8EWCcjp0sxV9JG8=;
	h=From:In-Reply-To:Content-Type:Date:Cc:To:MIME-Version:Message-ID:
	 Subject; b=dRvntV50jqSivH5EOB8u9ixwFrwO02DDno/P/uqux0R2iwn0Waou9DjOLwSi8zMRqR0MbOcjsziZGHr3alrCLzStaGu3YYq3DzSxZyIvJd7FqNNWGb3t7XkTXyIKALCRfcSXsvAukCZAC/snPBowPXs1iehHNG0ydPZuOqYxVRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thom.fr.eu.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=permerror (0-bit key) header.d=thom.fr.eu.org header.i=@thom.fr.eu.org header.b=wMIvC1Hy; arc=none smtp.client-ip=217.70.178.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thom.fr.eu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=thom.fr.eu.org header.i=@thom.fr.eu.org header.b="wMIvC1Hy"
Received: from spool.mail.gandi.net (spool3.mail.gandi.net [217.70.178.212])
	by relay14.mail.gandi.net (Postfix) with ESMTPS id BBBC61A0004;
	Mon, 18 Nov 2024 15:23:12 +0000 (UTC)
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [IPv6:2a01:e0c:1:1599::14])
	by spool.mail.gandi.net (Postfix) with ESMTPS id B1D88AC14B7;
	Mon, 18 Nov 2024 15:23:11 +0000 (UTC)
Received: from mail.thom.fr.eu.org (unknown [82.64.149.25])
	by smtp5-g21.free.fr (Postfix) with ESMTPS id 3768360137;
	Mon, 18 Nov 2024 16:23:11 +0100 (CET)
Received: from localhost ([127.0.0.1])
	by mail.thom.fr.eu.org (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTP id 4AIFMvGc2728126;
	Mon, 18 Nov 2024 16:23:04 +0100
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple; d=thom.fr.eu.org;
	s=default; t=1731943390;
	bh=lwx/4vqVR/BCsh+08QfvhYRZO0wE8EWCcjp0sxV9JG8=;
	h=From:In-Reply-To:Date:Cc:To:Subject;
	b=wMIvC1Hy8r3GhEbvQ1CMzhUV29O54lce2jH7wxRI0GxH3CTEry7XEX9LhNINX3gH3
	 m2JfqtHuF5mtNKpmKou6R0KV7QSOzNBWDzLqtzEjQzLadVuHqurQd13iT9DQYXWkXP
	 VD2mac/+3uHkd57iNXKt/RRn2t6q1i38H7MsWMbquUs/IWoEElzJaegyc6vQRjEBtp
	 qrwKVa18AVDe3x98P899RUo56+VlLN6llH0kerQQZjqg2550yCojZVorB7Ao2guYf+
	 aGqhDcOk8jjDa6XgKpgjCdT3dewFCpoM4aVrazXUBLaZK6q/pAZcSa50bKUpDaBEdV
	 lRv9S1jL0z7PA==
From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
In-Reply-To: <871pz8k35t.fsf@xenomai.org>
Content-Type: text/plain; charset="utf-8"
X-Forward: 217.109.173.233, 194.9.98.110
Date: Mon, 18 Nov 2024 16:22:57 +0100
Cc: "Florian Bezdeka" <florian.bezdeka@siemens.com>,
        "Jan Kiszka" <jan.kiszka@siemens.com>, xenomai@xenomai.org,
        =?utf-8?q?=E5=AD=99=E6=B6=9B?= <suntaoworks@163.com>
To: "Philippe Gerum" <rpm@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <1017-673b5c00-37-2c5d8800@259496998>
Subject: =?utf-8?q?Re=3A?= Switching from xenomai 3.2 IPIPE to xenomai 3.3 Dovetail
User-Agent: SOGoMail 5.0.1
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.10 at tls-srv-03
X-Virus-Status: Clean
Authentication-Results: spool.mail.gandi.net;
	dkim=fail ("headers rsa verify failed") header.d=thom.fr.eu.org header.s=default header.b=wMIvC1Hy;
	dmarc=none;
	spf=pass (spool.mail.gandi.net: domain of devel@thom.fr.eu.org designates 2a01:e0c:1:1599::14 as permitted sender) smtp.mailfrom=devel@thom.fr.eu.org

Le Lundi, Novembre 18, 2024 15:49 CET, Philippe Gerum <rpm@xenomai.org>=
 a =C3=A9crit: 
 
> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
> 
> > On Mon, 2024-11-18 at 14:37 +0100, Philippe Gerum wrote:
> >> Fran=C3=A7ois Legal <devel@thom.fr.eu.org> writes:
> >> 
> >> > Le Lundi, Novembre 18, 2024 13:06 CET, Florian Bezdeka <florian.=
bezdeka@siemens.com> a =C3=A9crit: 
> >> >  
> >> > > 
> >> > > [ Updated CC list to merge both mail threads ]
> >> > > 
> >> > > On Mon, 2024-11-18 at 12:37 +0100, Philippe Gerum wrote:
> >> > > > Fran=C3=A7ois Legal <devel@thom.fr.eu.org> writes:
> >> > > > 
> >> > > > > Le Lundi, Novembre 18, 2024 11:32 CET, Florian Bezdeka <fl=
orian.bezdeka@siemens.com> a =C3=A9crit: 
> >> > > > > =C2=A0 
> >> > > > > > On Mon, 2024-11-18 at 11:21 +0100, Fran=C3=A7ois Legal w=
rote:
> >> > > > > > > Le Lundi, Novembre 18, 2024 10:01 CET, Jan Kiszka <jan=
.kiszka@siemens.com> a =C3=A9crit: 
> >> > > > > > > =C2=A0
> >> > > > > > > > On 18.11.24 09:50, Fran=C3=A7ois Legal wrote:
> >> > > > > > > > > Hello,
> >> > > > > > > > > 
> >> > > > > > > > > running on an Arm v7 cortex A9 platform, I'm tryin=
g to switch from xenomai 3.2 (linux 5.4 IPIPE) to xenomai 3.3 (linux 5.=
15 Dovetail).
> >> > > > > > > > > 
> >> > > > > > > > > I can successfully boot my system with linux 5.15 =
+ CONFIG=5FDOVETAIL, but as soon as I enable Xenomai (CONFIG=5FXENOMAI)=
, I got stuck at boot in a do=5Fidle loop. Did I miss anything ?
> >> > > > > > > > > 
> >> > > > > > > > > Attached is my config.
> >> > > > > > > > 
> >> > > > > > > > Can you factor out from it what the SoC is, if you p=
atched the kernel
> >> > > > > > > > for it (in the past and now), if you had to adopt Do=
vetail etc.?
> >> > > > > > > > 
> >> > > > > > > > Jan
> >> > > > > > > 
> >> > > > > > > The SoC is Xilinx zynq 7000. I have custom patches for=
 custom FPGA peripherals (which most of them have been successfully por=
ted to 5.15).
> >> > > > > > 
> >> > > > > > We had a similar report for the zynq 7020 a couple of da=
ys ago.
> >> > > > > > See [1].
> >> > > > > > 
> >> > > > > > What happens if you disable CONFIG=5FSMP? (Not that this=
 should be the
> >> > > > > > final solution, but it might help to track the issue dow=
n...)
> >> > > > > > 
> >> > > > > > Florian
> >> > > > > > 
> >> > > > > 
> >> > > > > Disabling config SMP makes my system boot again.
> >> > > > > How can I help working this out ?
> >> > > > > 
> >> > > > > Fran=C3=A7ois
> >> > > > > 
> >> > > > 
> >> > > > This looks like an issue with the proxy tick device. First t=
hing is to
> >> > > > disable CONFIG=5FXENOMAI, enabling CONFIG=5FIRQ=5FPIPELINE=5F=
TORTURE=5FTEST. If
> >> > > > the kernel still hangs, we may have a hint about the reason
> >> > > > why. Alternatively, you could keep CONFIG=5FXENOMAI in, boot=
ing the kernel
> >> > > > with "xenomai.state=3Dstopped". If no hang occurs at boot an=
ymore, there
> >> > > > may be an issue with proxying the timer device on this SoC.
> >> > > > 
> >> > 
> >> > CONFIG=5FIRQ=5FPIPELINE=5FTORTURE=5FTEST seems to report OK (att=
ached bootlog CONFIG=5FIRQ=5FPIPELINE=5FTORTURE=5FTEST.boot
> >> > 
> >> > Starting with "xenomai.state=3Dstopped" works (attached boolog x=
enomai.state-stopped.boot)
> >> > Starting up xenomai with coreclk afterwards seem to work and not=
 hang system :
> >> > root@Arkens=5FSV:~# /usr/xenomai/sbin/corectl -start
> >> > [  117.328878] CPU1: proxy tick device registered (333.33MHz)
> >> > [  117.328883] CPU0: proxy tick device registered (333.33MHz)
> >> > [  117.339995] [Xenomai] services started
> >> > 
> >> > 
> >> 
> >> Ok, so another usual suspect for this issue: some weirdness in the=
 CPU
> >> idling code, which causes a (timer) interrupt to linger indefinite=
ly in
> >> some per-CPU interrupt log. A typical scenario is as follows:
> >> 
> >> CPUx
> >> ----
> >> 
> >>      default=5Fidle=5Fcall() {
> >> 
> >>       ...
> >> <IRQ> -> logged because local=5Firq=5Fdisable() in effect, =5Fhowe=
ver=5F we do NOT
> >>          expect hard irqs to be enabled [1] before entering the id=
le call
> >>          next =3D> issue is there.
> >>       arch=5Fcpu=5Fidle();
> >>       ...
> >>       /* per-CPU log is not flushed, because of [1] */
> >>      }
> >> 
> >> At the end of the day, the (most likely) timer IRQ is marked as pe=
nding
> >> in the log, but never played, so the kernel activity stalls on tha=
t CPU,
> >> especially if the boot CPU is involved.
> >> 
> >
> > Taken from the boot log:
> >
> > [    0.000024] clocksource: arm=5Fglobal=5Ftimer: freq: 166666665 H=
z, mask: 0xffffffffffffffff max=5Fcycles: 0x26703d7dd8, max=5Fidle=5Fns=
: 440795208065 ns
> > [    0.012959] clocksource: jiffies: freq: 0 Hz, mask: 0xffffffff m=
ax=5Fcycles: 0xffffffff, max=5Fidle=5Fns: 19112604462750000 ns
> > [    0.587268] clocksource: Switched to clocksource arm=5Fglobal=5F=
timer
> > [    1.065121] clocksource: ttc=5Fclocksource: freq: 54253 Hz, mask=
: 0xffff max=5Fcycles: 0xffff, max=5Fidle=5Fns: 537538477 ns
> >
> > So the last active clocksource is ttc=5Fclocksource
> > (drivers/clocksource/timer-cadence-ttc.c).
> > If I'm correct the OOB enablement is missing for this driver.
> >
> > Philippe already pointed us to
> > https://v4.xenomai.org/dovetail/porting/timer/.
> >
> > Could someone try that? I have matching HW at hand...
> >
> 
> The following code is a 100%, happily untested attempt to enable the =
ttc
> device for pipelining (timer events and reading its clock source
> directly from user-space via mmio as well). I don't have any zynq hw =
at
> hand to test it either.
> 
> diff --git a/drivers/clocksource/timer-cadence-ttc.c b/drivers/clocks=
ource/timer-cadence-ttc.c
> index 0d52e28fea4de..fcab778448bba 100644
> --- a/drivers/clocksource/timer-cadence-ttc.c
> +++ b/drivers/clocksource/timer-cadence-ttc.c
> @@ -84,11 +84,11 @@ struct ttc=5Ftimer=5Fclocksource {
>  	u32			scale=5Fclk=5Fctrl=5Freg=5Fold;
>  	u32			scale=5Fclk=5Fctrl=5Freg=5Fnew;
>  	struct ttc=5Ftimer	ttc;
> -	struct clocksource	cs;
> +	struct clocksource=5Fuser=5Fmmio	cs;
>  };
>  
>  #define to=5Fttc=5Ftimer=5Fclksrc(x) \
> -		container=5Fof(x, struct ttc=5Ftimer=5Fclocksource, cs)
> +		container=5Fof(x, struct ttc=5Ftimer=5Fclocksource, cs.mmio.clksrc=
)
>  
>  struct ttc=5Ftimer=5Fclockevent {
>  	struct ttc=5Ftimer		ttc;
> @@ -143,24 +143,11 @@ static irqreturn=5Ft ttc=5Fclock=5Fevent=5Finte=
rrupt(int irq, void *dev=5Fid)
>  	/* Acknowledge the interrupt and call event handler */
>  	readl=5Frelaxed(timer->base=5Faddr + TTC=5FISR=5FOFFSET);
>  
> -	ttce->ce.event=5Fhandler(&ttce->ce);
> +	clockevents=5Fhandle=5Fevent(&ttce->ce);
>  
>  	return IRQ=5FHANDLED;
>  }
>  
> -/**
> - * =5F=5Fttc=5Fclocksource=5Fread - Reads the timer counter register=

> - *
> - * returns: Current timer counter register value
> - **/
> -static u64 =5F=5Fttc=5Fclocksource=5Fread(struct clocksource *cs)
> -{
> -	struct ttc=5Ftimer *timer =3D &to=5Fttc=5Ftimer=5Fclksrc(cs)->ttc;
> -
> -	return (u64)readl=5Frelaxed(timer->base=5Faddr +
> -				TTC=5FCOUNT=5FVAL=5FOFFSET);
> -}
> -
>  static u64 notrace ttc=5Fsched=5Fclock=5Fread(void)
>  {
>  	return readl=5Frelaxed(ttc=5Fsched=5Fclock=5Fval=5Freg);
> @@ -320,6 +307,7 @@ static int ttc=5Frate=5Fchange=5Fclocksource=5Fcb=
(struct notifier=5Fblock *nb,
>  static int =5F=5Finit ttc=5Fsetup=5Fclocksource(struct clk *clk, voi=
d =5F=5Fiomem *base,
>  					 u32 timer=5Fwidth)
>  {
> +	struct clocksource=5Fmmio=5Fregs mmr =3D { 0 };
>  	struct ttc=5Ftimer=5Fclocksource *ttccs;
>  	int err;
>  
> @@ -347,11 +335,11 @@ static int =5F=5Finit ttc=5Fsetup=5Fclocksource=
(struct clk *clk, void =5F=5Fiomem *base,
>  		pr=5Fwarn("Unable to register clock notifier.\n");
>  
>  	ttccs->ttc.base=5Faddr =3D base;
> -	ttccs->cs.name =3D "ttc=5Fclocksource";
> -	ttccs->cs.rating =3D 200;
> -	ttccs->cs.read =3D =5F=5Fttc=5Fclocksource=5Fread;
> -	ttccs->cs.mask =3D CLOCKSOURCE=5FMASK(timer=5Fwidth);
> -	ttccs->cs.flags =3D CLOCK=5FSOURCE=5FIS=5FCONTINUOUS;
> +	ttccs->cs.mmio.clksrc.name =3D "ttc=5Fclocksource";
> +	ttccs->cs.mmio.clksrc.rating =3D 200;
> +	ttccs->cs.mmio.clksrc.read =3D clocksource=5Fmmio=5Freadl=5Fup,
> +	ttccs->cs.mmio.clksrc.mask =3D CLOCKSOURCE=5FMASK(timer=5Fwidth);
> +	ttccs->cs.mmio.clksrc.flags =3D CLOCK=5FSOURCE=5FIS=5FCONTINUOUS;
>  
>  	/*
>  	 * Setup the clock source counter to be an incrementing counter
> @@ -364,7 +352,10 @@ static int =5F=5Finit ttc=5Fsetup=5Fclocksource(=
struct clk *clk, void =5F=5Fiomem *base,
>  	writel=5Frelaxed(CNT=5FCNTRL=5FRESET,
>  		     ttccs->ttc.base=5Faddr + TTC=5FCNT=5FCNTRL=5FOFFSET);
>  
> -	err =3D clocksource=5Fregister=5Fhz(&ttccs->cs, ttccs->ttc.freq / P=
RESCALE);
> +	mmr.reg=5Flower =3D ttccs->ttc.base=5Faddr + TTC=5FCOUNT=5FVAL=5FOF=
FSET;
> +	mmr.bits=5Flower =3D 32;
> +
> +	err =3D clocksource=5Fuser=5Fmmio=5Finit(&ttccs->cs, &mmr, ttccs->t=
tc.freq / PRESCALE);
>  	if (err) {
>  		kfree(ttccs);
>  		return err;
> @@ -431,7 +422,8 @@ static int =5F=5Finit ttc=5Fsetup=5Fclockevent(st=
ruct clk *clk,
>  
>  	ttcce->ttc.base=5Faddr =3D base;
>  	ttcce->ce.name =3D "ttc=5Fclockevent";
> -	ttcce->ce.features =3D CLOCK=5FEVT=5FFEAT=5FPERIODIC | CLOCK=5FEVT=5F=
FEAT=5FONESHOT;
> +	ttcce->ce.features =3D CLOCK=5FEVT=5FFEAT=5FPERIODIC | \
> +		CLOCK=5FEVT=5FFEAT=5FONESHOT | CLOCK=5FEVT=5FFEAT=5FPIPELINE;
>  	ttcce->ce.set=5Fnext=5Fevent =3D ttc=5Fset=5Fnext=5Fevent;
>  	ttcce->ce.set=5Fstate=5Fshutdown =3D ttc=5Fshutdown;
>  	ttcce->ce.set=5Fstate=5Fperiodic =3D ttc=5Fset=5Fperiodic;
> 
> -- 

I just gave it a try, but with no success. I hadtried a patch of mine t=
oo with the same result.
I wonder however if this is really the problem here as when I get stuck=
 at boot, the last declare time source is the Arm GT :

Here :
[    0.614817] clocksource: Switched to clocksource arm=5Fglobal=5Ftime=
r

[    0.628544] NET: Registered PF=5FINET protocol family
[    0.633699] IP idents hash table entries: 16384 (order: 5, 131072 by=
tes, linear)
[    0.642170] tcp=5Flisten=5Fportaddr=5Fhash hash table entries: 512 (=
order: 0, 4096 bytes, linear)
[    0.650587] Table-perturb hash table entries: 65536 (order: 6, 26214=
4 bytes, linear)
[    0.658339] TCP established hash table entries: 8192 (order: 3, 3276=
8 bytes, linear)
[    0.666173] TCP bind hash table entries: 8192 (order: 4, 65536 bytes=
, linear)
[    0.673540] TCP: Hash tables configured (established 8192 bind 8192)=

[    0.679986] UDP hash table entries: 512 (order: 2, 16384 bytes, line=
ar)
[    0.686665] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes,=
 linear)
[    0.693937] NET: Registered PF=5FUNIX/PF=5FLOCAL protocol family
[    0.700355] RPC: Registered named UNIX socket transport module.
[    0.706274] RPC: Registered udp transport module.
[    0.710989] RPC: Registered tcp transport module.
[    0.715691] RPC: Registered tcp NFSv4.1 backchannel transport module=
.
[    0.722914] [Xenomai] scheduling class idle registered.
[    0.728138] [Xenomai] scheduling class rt registered.
[    0.733243] IRQ pipeline: high-priority Xenomai stage added.
[    0.740572] CPU0: proxy tick device registered (333.33MHz)
[    0.740575] CPU1: proxy tick device registered (333.33MHz)
[    0.752600] [Xenomai] Cobalt v3.3
[    0.756129] workingset: timestamp=5Fbits=3D30 max=5Forder=3D18 bucke=
t=5Forder=3D0
[    0.879595] NET: Registered PF=5FALG protocol family
[    0.884507] bounce: pool size: 64 pages
[    0.888358] io scheduler mq-deadline registered
[    0.896523] dma-pl330 f8003000.dmac: Loaded driver for PL330 DMAC-24=
1330
[    0.903234] dma-pl330 f8003000.dmac:         DBUFF-128x8bytes Num=5F=
Chans-8 Num=5FPeri-4 Num=5FEvents-16
[    0.919795] brd: module loaded

then hung from here

Fran=C3=A7ois

> Philippe.

