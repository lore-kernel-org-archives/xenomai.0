Received: from redirect.mail.gandi.net (relay13.mail.gandi.net [217.70.178.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE1F1B6CF1
	for <xenomai@lists.linux.dev>; Mon, 18 Nov 2024 15:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731944046; cv=none; b=ckc0sp7ZvDK+uH2IiQed8Lf4jbX36mmjPHIAUT8e1s4ocAr7elvb39oVkwZeONsMMUssjyoGaEXLMxBojNbyoRDjpa6838P6AtBHO8jQiJybTpeAVSfZphlroGavFy4EmD6rGGp1/jsekQ5umZMg6yOgEFXUrlAPlUPlRhXSykc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731944046; c=relaxed/simple;
	bh=QT5b0sbWEhsBq8BLLNxsnLVJPvYL7X+Y0+dsXwwdOUc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hapgN4aDYVMk8TMu59kcfCpqrJdpZFFBIQHy2I22rMIYNduvulDGgiyfftzROgLiRXyAOV8H+ppDMZiJOJZc6C3I+8vWLnjd2OoQWYPxPl+iKrqBc3b4rZqTs0/DQgKfhJXB+OwDS2mKvGmRsafOOOSDBuu65EakoLdmIfpDqhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net; arc=none smtp.client-ip=217.70.178.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Received: from spool.mail.gandi.net (spool5.mail.gandi.net [217.70.178.214])
	by relay13.mail.gandi.net (Postfix) with ESMTPS id A89C180002
	for <xenomai@lists.linux.dev>; Mon, 18 Nov 2024 15:34:01 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	by spool.mail.gandi.net (Postfix) with ESMTPS id E33E7D8048F
	for <xenomai@xenomai.org>; Mon, 18 Nov 2024 15:34:00 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4315e9e9642so26620325e9.0
        for <xenomai@xenomai.org>; Mon, 18 Nov 2024 07:34:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731944040; x=1732548840;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=shjomvd5Nj6y6Q5+ibVRTQb9f0DYaam1Kc4d/cflEMo=;
        b=q3bpI0me/tWOIjpdJJeR1qvdy8toQHrvh5P9mkooapGpuDE/4UwwhFXY0eno+64sXi
         dKs3ABPQ6rPfcOLP1PjwDEfKb7h6e1yFvPLBJjWQUC1JRJxQYT8+AotIhf6Tg//ArMbm
         FsfsfV6fAYbleMI7YFIwbIWLg6q6Cj671Dtl08OXpU/byIm2eJGQdaT2DeqC7d7rP/DC
         QPAmV359jLAxMq2oEhQLznZVhwVPgRsZfmxci5U9jYF6woUA61GDRANOjfl2UsTpjWw/
         Z0bx416tJjABXz3mTLeqvMvEIRzY3EVxqkRiKXC9qbYqVor0MPcl+8P6W/CoHaoWGASt
         ifMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUO2AeYxzoSqYCAl+rPpiad3jVBxOIbP69PBuzlZnmrvpkXgSIvHDglqgRHg8qJGOrxi9wTehzI@xenomai.org
X-Gm-Message-State: AOJu0YwXMKZ5Ae8PWOD35jAe0/KjyO1mhMeanWKg6sIzs74KyHug12Gp
	aohlRborAV7jctpqtb/OeHx0mRbVcFM5IYbUc1r3F6UXvpdSVeGG
X-Google-Smtp-Source: AGHT+IGZ6dfMDLWPxGu4Rs9ppOi9/2UIeWeuX9CVY+bm8Qz67NnH7ahdDvtQTm1v9OxKmJmph6QGdw==
X-Received: by 2002:a05:600c:190f:b0:431:3c67:fb86 with SMTP id 5b1f17b1804b1-432df792e3dmr99930125e9.33.1731944040241;
        Mon, 18 Nov 2024 07:34:00 -0800 (PST)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab80a10sm157950165e9.26.2024.11.18.07.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 07:33:59 -0800 (PST)
From: Philippe Gerum <rpm@xenomai.org>
To: =?utf-8?Q?Fran=C3=A7ois?= Legal <devel@thom.fr.eu.org>
Cc: "Florian Bezdeka" <florian.bezdeka@siemens.com>,  "Jan Kiszka"
 <jan.kiszka@siemens.com>,  xenomai@xenomai.org,  =?utf-8?B?5a2Z5rab?=
 <suntaoworks@163.com>
Subject: Re: Switching from xenomai 3.2 IPIPE to xenomai 3.3 Dovetail
In-Reply-To: <1017-673b5c00-37-2c5d8800@259496998> (=?utf-8?Q?=22Fran?=
 =?utf-8?Q?=C3=A7ois?= Legal"'s message
	of "Mon, 18 Nov 2024 16:22:57 +0100")
References: <1017-673b5c00-37-2c5d8800@259496998>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Mon, 18 Nov 2024 16:33:58 +0100
Message-ID: <87v7wkimjd.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Authentication-Results: spool.mail.gandi.net;
	dkim=none;
	spf=pass (spool.mail.gandi.net: domain of philippegerum@gmail.com designates 209.85.128.47 as permitted sender) smtp.mailfrom=philippegerum@gmail.com;
	dmarc=none

Fran=C3=A7ois Legal <devel@thom.fr.eu.org> writes:

> Le Lundi, Novembre 18, 2024 15:49 CET, Philippe Gerum <rpm@xenomai.org> a=
 =C3=A9crit:=20
>=20=20
>> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>>=20
>> > On Mon, 2024-11-18 at 14:37 +0100, Philippe Gerum wrote:
>> >> Fran=C3=A7ois Legal <devel@thom.fr.eu.org> writes:
>> >>=20
>> >> > Le Lundi, Novembre 18, 2024 13:06 CET, Florian Bezdeka <florian.bez=
deka@siemens.com> a =C3=A9crit:=20
>> >> >=20=20
>> >> > >=20
>> >> > > [ Updated CC list to merge both mail threads ]
>> >> > >=20
>> >> > > On Mon, 2024-11-18 at 12:37 +0100, Philippe Gerum wrote:
>> >> > > > Fran=C3=A7ois Legal <devel@thom.fr.eu.org> writes:
>> >> > > >=20
>> >> > > > > Le Lundi, Novembre 18, 2024 11:32 CET, Florian Bezdeka <flori=
an.bezdeka@siemens.com> a =C3=A9crit:=20
>> >> > > > > =C2=A0=20
>> >> > > > > > On Mon, 2024-11-18 at 11:21 +0100, Fran=C3=A7ois Legal wrot=
e:
>> >> > > > > > > Le Lundi, Novembre 18, 2024 10:01 CET, Jan Kiszka <jan.ki=
szka@siemens.com> a =C3=A9crit:=20
>> >> > > > > > > =C2=A0
>> >> > > > > > > > On 18.11.24 09:50, Fran=C3=A7ois Legal wrote:
>> >> > > > > > > > > Hello,
>> >> > > > > > > > >=20
>> >> > > > > > > > > running on an Arm v7 cortex A9 platform, I'm trying t=
o switch from xenomai 3.2 (linux 5.4 IPIPE) to xenomai 3.3 (linux 5.15 Dove=
tail).
>> >> > > > > > > > >=20
>> >> > > > > > > > > I can successfully boot my system with linux 5.15 + C=
ONFIG_DOVETAIL, but as soon as I enable Xenomai (CONFIG_XENOMAI), I got stu=
ck at boot in a do_idle loop. Did I miss anything ?
>> >> > > > > > > > >=20
>> >> > > > > > > > > Attached is my config.
>> >> > > > > > > >=20
>> >> > > > > > > > Can you factor out from it what the SoC is, if you patc=
hed the kernel
>> >> > > > > > > > for it (in the past and now), if you had to adopt Dovet=
ail etc.?
>> >> > > > > > > >=20
>> >> > > > > > > > Jan
>> >> > > > > > >=20
>> >> > > > > > > The SoC is Xilinx zynq 7000. I have custom patches for cu=
stom FPGA peripherals (which most of them have been successfully ported to =
5.15).
>> >> > > > > >=20
>> >> > > > > > We had a similar report for the zynq 7020 a couple of days =
ago.
>> >> > > > > > See [1].
>> >> > > > > >=20
>> >> > > > > > What happens if you disable CONFIG_SMP? (Not that this shou=
ld be the
>> >> > > > > > final solution, but it might help to track the issue down..=
.)
>> >> > > > > >=20
>> >> > > > > > Florian
>> >> > > > > >=20
>> >> > > > >=20
>> >> > > > > Disabling config SMP makes my system boot again.
>> >> > > > > How can I help working this out ?
>> >> > > > >=20
>> >> > > > > Fran=C3=A7ois
>> >> > > > >=20
>> >> > > >=20
>> >> > > > This looks like an issue with the proxy tick device. First thin=
g is to
>> >> > > > disable CONFIG_XENOMAI, enabling CONFIG_IRQ_PIPELINE_TORTURE_TE=
ST. If
>> >> > > > the kernel still hangs, we may have a hint about the reason
>> >> > > > why. Alternatively, you could keep CONFIG_XENOMAI in, booting t=
he kernel
>> >> > > > with "xenomai.state=3Dstopped". If no hang occurs at boot anymo=
re, there
>> >> > > > may be an issue with proxying the timer device on this SoC.
>> >> > > >=20
>> >> >=20
>> >> > CONFIG_IRQ_PIPELINE_TORTURE_TEST seems to report OK (attached bootl=
og CONFIG_IRQ_PIPELINE_TORTURE_TEST.boot
>> >> >=20
>> >> > Starting with "xenomai.state=3Dstopped" works (attached boolog xeno=
mai.state-stopped.boot)
>> >> > Starting up xenomai with coreclk afterwards seem to work and not ha=
ng system :
>> >> > root@Arkens_SV:~# /usr/xenomai/sbin/corectl -start
>> >> > [  117.328878] CPU1: proxy tick device registered (333.33MHz)
>> >> > [  117.328883] CPU0: proxy tick device registered (333.33MHz)
>> >> > [  117.339995] [Xenomai] services started
>> >> >=20
>> >> >=20
>> >>=20
>> >> Ok, so another usual suspect for this issue: some weirdness in the CPU
>> >> idling code, which causes a (timer) interrupt to linger indefinitely =
in
>> >> some per-CPU interrupt log. A typical scenario is as follows:
>> >>=20
>> >> CPUx
>> >> ----
>> >>=20
>> >>      default_idle_call() {
>> >>=20
>> >>       ...
>> >> <IRQ> -> logged because local_irq_disable() in effect, _however_ we d=
o NOT
>> >>          expect hard irqs to be enabled [1] before entering the idle =
call
>> >>          next =3D> issue is there.
>> >>       arch_cpu_idle();
>> >>       ...
>> >>       /* per-CPU log is not flushed, because of [1] */
>> >>      }
>> >>=20
>> >> At the end of the day, the (most likely) timer IRQ is marked as pendi=
ng
>> >> in the log, but never played, so the kernel activity stalls on that C=
PU,
>> >> especially if the boot CPU is involved.
>> >>=20
>> >
>> > Taken from the boot log:
>> >
>> > [    0.000024] clocksource: arm_global_timer: freq: 166666665 Hz, mask=
: 0xffffffffffffffff max_cycles: 0x26703d7dd8, max_idle_ns: 440795208065 ns
>> > [    0.012959] clocksource: jiffies: freq: 0 Hz, mask: 0xffffffff max_=
cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
>> > [    0.587268] clocksource: Switched to clocksource arm_global_timer
>> > [    1.065121] clocksource: ttc_clocksource: freq: 54253 Hz, mask: 0xf=
fff max_cycles: 0xffff, max_idle_ns: 537538477 ns
>> >
>> > So the last active clocksource is ttc_clocksource
>> > (drivers/clocksource/timer-cadence-ttc.c).
>> > If I'm correct the OOB enablement is missing for this driver.
>> >
>> > Philippe already pointed us to
>> > https://v4.xenomai.org/dovetail/porting/timer/.
>> >
>> > Could someone try that? I have matching HW at hand...
>> >
>>=20
>> The following code is a 100%, happily untested attempt to enable the ttc
>> device for pipelining (timer events and reading its clock source
>> directly from user-space via mmio as well). I don't have any zynq hw at
>> hand to test it either.
>>=20
>> diff --git a/drivers/clocksource/timer-cadence-ttc.c b/drivers/clocksour=
ce/timer-cadence-ttc.c
>> index 0d52e28fea4de..fcab778448bba 100644
>> --- a/drivers/clocksource/timer-cadence-ttc.c
>> +++ b/drivers/clocksource/timer-cadence-ttc.c
>> @@ -84,11 +84,11 @@ struct ttc_timer_clocksource {
>>  	u32			scale_clk_ctrl_reg_old;
>>  	u32			scale_clk_ctrl_reg_new;
>>  	struct ttc_timer	ttc;
>> -	struct clocksource	cs;
>> +	struct clocksource_user_mmio	cs;
>>  };
>>=20=20
>>  #define to_ttc_timer_clksrc(x) \
>> -		container_of(x, struct ttc_timer_clocksource, cs)
>> +		container_of(x, struct ttc_timer_clocksource, cs.mmio.clksrc)
>>=20=20
>>  struct ttc_timer_clockevent {
>>  	struct ttc_timer		ttc;
>> @@ -143,24 +143,11 @@ static irqreturn_t ttc_clock_event_interrupt(int i=
rq, void *dev_id)
>>  	/* Acknowledge the interrupt and call event handler */
>>  	readl_relaxed(timer->base_addr + TTC_ISR_OFFSET);
>>=20=20
>> -	ttce->ce.event_handler(&ttce->ce);
>> +	clockevents_handle_event(&ttce->ce);
>>=20=20
>>  	return IRQ_HANDLED;
>>  }
>>=20=20
>> -/**
>> - * __ttc_clocksource_read - Reads the timer counter register
>> - *
>> - * returns: Current timer counter register value
>> - **/
>> -static u64 __ttc_clocksource_read(struct clocksource *cs)
>> -{
>> -	struct ttc_timer *timer =3D &to_ttc_timer_clksrc(cs)->ttc;
>> -
>> -	return (u64)readl_relaxed(timer->base_addr +
>> -				TTC_COUNT_VAL_OFFSET);
>> -}
>> -
>>  static u64 notrace ttc_sched_clock_read(void)
>>  {
>>  	return readl_relaxed(ttc_sched_clock_val_reg);
>> @@ -320,6 +307,7 @@ static int ttc_rate_change_clocksource_cb(struct not=
ifier_block *nb,
>>  static int __init ttc_setup_clocksource(struct clk *clk, void __iomem *=
base,
>>  					 u32 timer_width)
>>  {
>> +	struct clocksource_mmio_regs mmr =3D { 0 };
>>  	struct ttc_timer_clocksource *ttccs;
>>  	int err;
>>=20=20
>> @@ -347,11 +335,11 @@ static int __init ttc_setup_clocksource(struct clk=
 *clk, void __iomem *base,
>>  		pr_warn("Unable to register clock notifier.\n");
>>=20=20
>>  	ttccs->ttc.base_addr =3D base;
>> -	ttccs->cs.name =3D "ttc_clocksource";
>> -	ttccs->cs.rating =3D 200;
>> -	ttccs->cs.read =3D __ttc_clocksource_read;
>> -	ttccs->cs.mask =3D CLOCKSOURCE_MASK(timer_width);
>> -	ttccs->cs.flags =3D CLOCK_SOURCE_IS_CONTINUOUS;
>> +	ttccs->cs.mmio.clksrc.name =3D "ttc_clocksource";
>> +	ttccs->cs.mmio.clksrc.rating =3D 200;
>> +	ttccs->cs.mmio.clksrc.read =3D clocksource_mmio_readl_up,
>> +	ttccs->cs.mmio.clksrc.mask =3D CLOCKSOURCE_MASK(timer_width);
>> +	ttccs->cs.mmio.clksrc.flags =3D CLOCK_SOURCE_IS_CONTINUOUS;
>>=20=20
>>  	/*
>>  	 * Setup the clock source counter to be an incrementing counter
>> @@ -364,7 +352,10 @@ static int __init ttc_setup_clocksource(struct clk =
*clk, void __iomem *base,
>>  	writel_relaxed(CNT_CNTRL_RESET,
>>  		     ttccs->ttc.base_addr + TTC_CNT_CNTRL_OFFSET);
>>=20=20
>> -	err =3D clocksource_register_hz(&ttccs->cs, ttccs->ttc.freq / PRESCALE=
);
>> +	mmr.reg_lower =3D ttccs->ttc.base_addr + TTC_COUNT_VAL_OFFSET;
>> +	mmr.bits_lower =3D 32;
>> +
>> +	err =3D clocksource_user_mmio_init(&ttccs->cs, &mmr, ttccs->ttc.freq /=
 PRESCALE);
>>  	if (err) {
>>  		kfree(ttccs);
>>  		return err;
>> @@ -431,7 +422,8 @@ static int __init ttc_setup_clockevent(struct clk *c=
lk,
>>=20=20
>>  	ttcce->ttc.base_addr =3D base;
>>  	ttcce->ce.name =3D "ttc_clockevent";
>> -	ttcce->ce.features =3D CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHO=
T;
>> +	ttcce->ce.features =3D CLOCK_EVT_FEAT_PERIODIC | \
>> +		CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_PIPELINE;
>>  	ttcce->ce.set_next_event =3D ttc_set_next_event;
>>  	ttcce->ce.set_state_shutdown =3D ttc_shutdown;
>>  	ttcce->ce.set_state_periodic =3D ttc_set_periodic;
>>=20
>> --=20
>
> I just gave it a try, but with no success. I hadtried a patch of mine too=
 with the same result.
> I wonder however if this is really the problem here as when I get stuck a=
t boot, the last declare time source is the Arm GT :
>
> Here :
> [    0.614817] clocksource: Switched to clocksource arm_global_timer
>
> [    0.628544] NET: Registered PF_INET protocol family
> [    0.633699] IP idents hash table entries: 16384 (order: 5, 131072 byte=
s, linear)
> [    0.642170] tcp_listen_portaddr_hash hash table entries: 512 (order: 0=
, 4096 bytes, linear)
> [    0.650587] Table-perturb hash table entries: 65536 (order: 6, 262144 =
bytes, linear)
> [    0.658339] TCP established hash table entries: 8192 (order: 3, 32768 =
bytes, linear)
> [    0.666173] TCP bind hash table entries: 8192 (order: 4, 65536 bytes, =
linear)
> [    0.673540] TCP: Hash tables configured (established 8192 bind 8192)
> [    0.679986] UDP hash table entries: 512 (order: 2, 16384 bytes, linear)
> [    0.686665] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes, l=
inear)
> [    0.693937] NET: Registered PF_UNIX/PF_LOCAL protocol family
> [    0.700355] RPC: Registered named UNIX socket transport module.
> [    0.706274] RPC: Registered udp transport module.
> [    0.710989] RPC: Registered tcp transport module.
> [    0.715691] RPC: Registered tcp NFSv4.1 backchannel transport module.
> [    0.722914] [Xenomai] scheduling class idle registered.
> [    0.728138] [Xenomai] scheduling class rt registered.
> [    0.733243] IRQ pipeline: high-priority Xenomai stage added.
> [    0.740572] CPU0: proxy tick device registered (333.33MHz)
> [    0.740575] CPU1: proxy tick device registered (333.33MHz)
> [    0.752600] [Xenomai] Cobalt v3.3
> [    0.756129] workingset: timestamp_bits=3D30 max_order=3D18 bucket_orde=
r=3D0
> [    0.879595] NET: Registered PF_ALG protocol family
> [    0.884507] bounce: pool size: 64 pages
> [    0.888358] io scheduler mq-deadline registered
> [    0.896523] dma-pl330 f8003000.dmac: Loaded driver for PL330 DMAC-2413=
30
> [    0.903234] dma-pl330 f8003000.dmac:         DBUFF-128x8bytes Num_Chan=
s-8 Num_Peri-4 Num_Events-16
> [    0.919795] brd: module loaded
>
> then hung from here
>

What if you disable CONFIG_CPUIDLE?

--=20
Philippe.
