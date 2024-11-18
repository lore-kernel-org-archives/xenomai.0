Received: from redirect.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F321991A5
	for <xenomai@lists.linux.dev>; Mon, 18 Nov 2024 14:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731941381; cv=none; b=f0Vc4nuOK9dWzilPllYl8+PADSl1MXLTY1zvq4zk5DVDPIKURE6dGm9UeAi3hjJdXmDPvYNQ7pU6jVLD49hC5yeCAsphlwd9QU69dvqP9bvitWfWLyfBWxUX5QUVwauW7+vEMLyrBavxgsKcOtXKTX68i5x19RTnMk3xMhg/Z+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731941381; c=relaxed/simple;
	bh=miqWC25sDMGnLwprX30sDiR2xmKgWS7gSvQsV3kwBhE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fC1uzfEEUCOy6LGpnYqpiqDmFzMcjk6IazzmgkG+HBmzwij0JY18GHoYMwAgHiSkVh2Uwo8uHuECtVz/gvf2zB7dq25ged+/jFCrouZVZidWc1AK6ON/xsG2X3GuXMBuizY8/F3qn7z7w9HMymkAKlkUjGdwmUB1kGSQAOLWRzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net; arc=none smtp.client-ip=217.70.178.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Received: from spool.mail.gandi.net (spool1.mail.gandi.net [217.70.178.210])
	by relay12.mail.gandi.net (Postfix) with ESMTPS id D3127200003
	for <xenomai@lists.linux.dev>; Mon, 18 Nov 2024 14:49:36 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 132F4941991
	for <xenomai@xenomai.org>; Mon, 18 Nov 2024 14:49:36 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-382442b7d9aso970541f8f.1
        for <xenomai@xenomai.org>; Mon, 18 Nov 2024 06:49:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731941375; x=1732546175;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c8oOhS0HbHSi72O4ibEjZJ1hcmIyPAmYAXxhvMLEqzI=;
        b=B6E5jqjmq3u1TJZBquzgqdl7pa3Ej9OV6EgI3g/g8zE+yxG+rYjQkcooq8/1b9WA4e
         5M1ANIVn7KsppgSeTf+aLXiP23wxurq6jZdkLz62x3x00i4z3c6oy4XLmJME8UI0b52W
         3PbtDq4sBUYqJPjAQs8Wnlinm8Oi+yeWa2bPGsuc+SlBL+SJ19vtVui2Uhs578bYUF72
         vU62Vb6UecSttlcYEpAXQ/OHl/fd04PSLaEK99C1j8if2owklQtfz90aKjgZm3DwFKV/
         v51c8nbE1h00womTH1kts17cPV1n8XNU5IfkJpE47+llNeS/sz9LxmPozsS0uQ6OGsE5
         i65A==
X-Forwarded-Encrypted: i=1; AJvYcCXa1AofeA28+aPs2wGzmgasO197v3YAYLChFV8KQeHip+tb09W5HuLhxbfHcoCxES8isSAPMZV5@xenomai.org
X-Gm-Message-State: AOJu0YyDklm7AzJScw5MQ3av2Ffhm3kovg4rU0CT9exTQOvchcl1FdyA
	Z9b3SYMpXpp/vCBQzcqQV25jb0vmyPUyTRoKJbpqLqPHvojY6wxg
X-Google-Smtp-Source: AGHT+IH50b9UOkjVI5QQlMUgrOUsrUagUvEhakoyZ8VtJ+7psahWZGQ+31dWD44jTCOKD/m2/ke0oQ==
X-Received: by 2002:a5d:5d89:0:b0:37d:4527:ba1c with SMTP id ffacd0b85a97d-38225aa4a68mr9204778f8f.49.1731941375364;
        Mon, 18 Nov 2024 06:49:35 -0800 (PST)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38232ec369fsm8264685f8f.70.2024.11.18.06.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 06:49:34 -0800 (PST)
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: =?utf-8?Q?Fran=C3=A7ois?= Legal <devel@thom.fr.eu.org>,  Jan Kiszka
 <jan.kiszka@siemens.com>,  xenomai@xenomai.org,  =?utf-8?B?5a2Z5rab?=
 <suntaoworks@163.com>
Subject: Re: Switching from xenomai 3.2 IPIPE to xenomai 3.3 Dovetail
In-Reply-To: <cdadf4a26e6ee96beee6788eea1d9bf8b567fc5c.camel@siemens.com>
	(Florian Bezdeka's message of "Mon, 18 Nov 2024 14:57:32 +0100")
References: <1017-673b3f80-2f-2c5d8800@259496866> <87cyisk6ia.fsf@xenomai.org>
	<cdadf4a26e6ee96beee6788eea1d9bf8b567fc5c.camel@siemens.com>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Mon, 18 Nov 2024 15:49:34 +0100
Message-ID: <871pz8k35t.fsf@xenomai.org>
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
	dmarc=none;
	spf=pass (spool.mail.gandi.net: domain of philippegerum@gmail.com designates 209.85.221.50 as permitted sender) smtp.mailfrom=philippegerum@gmail.com

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> On Mon, 2024-11-18 at 14:37 +0100, Philippe Gerum wrote:
>> Fran=C3=A7ois Legal <devel@thom.fr.eu.org> writes:
>>=20
>> > Le Lundi, Novembre 18, 2024 13:06 CET, Florian Bezdeka <florian.bezdek=
a@siemens.com> a =C3=A9crit:=20
>> >=20=20
>> > >=20
>> > > [ Updated CC list to merge both mail threads ]
>> > >=20
>> > > On Mon, 2024-11-18 at 12:37 +0100, Philippe Gerum wrote:
>> > > > Fran=C3=A7ois Legal <devel@thom.fr.eu.org> writes:
>> > > >=20
>> > > > > Le Lundi, Novembre 18, 2024 11:32 CET, Florian Bezdeka <florian.=
bezdeka@siemens.com> a =C3=A9crit:=20
>> > > > > =C2=A0=20
>> > > > > > On Mon, 2024-11-18 at 11:21 +0100, Fran=C3=A7ois Legal wrote:
>> > > > > > > Le Lundi, Novembre 18, 2024 10:01 CET, Jan Kiszka <jan.kiszk=
a@siemens.com> a =C3=A9crit:=20
>> > > > > > > =C2=A0
>> > > > > > > > On 18.11.24 09:50, Fran=C3=A7ois Legal wrote:
>> > > > > > > > > Hello,
>> > > > > > > > >=20
>> > > > > > > > > running on an Arm v7 cortex A9 platform, I'm trying to s=
witch from xenomai 3.2 (linux 5.4 IPIPE) to xenomai 3.3 (linux 5.15 Dovetai=
l).
>> > > > > > > > >=20
>> > > > > > > > > I can successfully boot my system with linux 5.15 + CONF=
IG_DOVETAIL, but as soon as I enable Xenomai (CONFIG_XENOMAI), I got stuck =
at boot in a do_idle loop. Did I miss anything ?
>> > > > > > > > >=20
>> > > > > > > > > Attached is my config.
>> > > > > > > >=20
>> > > > > > > > Can you factor out from it what the SoC is, if you patched=
 the kernel
>> > > > > > > > for it (in the past and now), if you had to adopt Dovetail=
 etc.?
>> > > > > > > >=20
>> > > > > > > > Jan
>> > > > > > >=20
>> > > > > > > The SoC is Xilinx zynq 7000. I have custom patches for custo=
m FPGA peripherals (which most of them have been successfully ported to 5.1=
5).
>> > > > > >=20
>> > > > > > We had a similar report for the zynq 7020 a couple of days ago.
>> > > > > > See [1].
>> > > > > >=20
>> > > > > > What happens if you disable CONFIG_SMP? (Not that this should =
be the
>> > > > > > final solution, but it might help to track the issue down...)
>> > > > > >=20
>> > > > > > Florian
>> > > > > >=20
>> > > > >=20
>> > > > > Disabling config SMP makes my system boot again.
>> > > > > How can I help working this out ?
>> > > > >=20
>> > > > > Fran=C3=A7ois
>> > > > >=20
>> > > >=20
>> > > > This looks like an issue with the proxy tick device. First thing i=
s to
>> > > > disable CONFIG_XENOMAI, enabling CONFIG_IRQ_PIPELINE_TORTURE_TEST.=
 If
>> > > > the kernel still hangs, we may have a hint about the reason
>> > > > why. Alternatively, you could keep CONFIG_XENOMAI in, booting the =
kernel
>> > > > with "xenomai.state=3Dstopped". If no hang occurs at boot anymore,=
 there
>> > > > may be an issue with proxying the timer device on this SoC.
>> > > >=20
>> >=20
>> > CONFIG_IRQ_PIPELINE_TORTURE_TEST seems to report OK (attached bootlog =
CONFIG_IRQ_PIPELINE_TORTURE_TEST.boot
>> >=20
>> > Starting with "xenomai.state=3Dstopped" works (attached boolog xenomai=
.state-stopped.boot)
>> > Starting up xenomai with coreclk afterwards seem to work and not hang =
system :
>> > root@Arkens_SV:~# /usr/xenomai/sbin/corectl -start
>> > [  117.328878] CPU1: proxy tick device registered (333.33MHz)
>> > [  117.328883] CPU0: proxy tick device registered (333.33MHz)
>> > [  117.339995] [Xenomai] services started
>> >=20
>> >=20
>>=20
>> Ok, so another usual suspect for this issue: some weirdness in the CPU
>> idling code, which causes a (timer) interrupt to linger indefinitely in
>> some per-CPU interrupt log. A typical scenario is as follows:
>>=20
>> CPUx
>> ----
>>=20
>>      default_idle_call() {
>>=20
>>       ...
>> <IRQ> -> logged because local_irq_disable() in effect, _however_ we do N=
OT
>>          expect hard irqs to be enabled [1] before entering the idle call
>>          next =3D> issue is there.
>>       arch_cpu_idle();
>>       ...
>>       /* per-CPU log is not flushed, because of [1] */
>>      }
>>=20
>> At the end of the day, the (most likely) timer IRQ is marked as pending
>> in the log, but never played, so the kernel activity stalls on that CPU,
>> especially if the boot CPU is involved.
>>=20
>
> Taken from the boot log:
>
> [    0.000024] clocksource: arm_global_timer: freq: 166666665 Hz, mask: 0=
xffffffffffffffff max_cycles: 0x26703d7dd8, max_idle_ns: 440795208065 ns
> [    0.012959] clocksource: jiffies: freq: 0 Hz, mask: 0xffffffff max_cyc=
les: 0xffffffff, max_idle_ns: 19112604462750000 ns
> [    0.587268] clocksource: Switched to clocksource arm_global_timer
> [    1.065121] clocksource: ttc_clocksource: freq: 54253 Hz, mask: 0xffff=
 max_cycles: 0xffff, max_idle_ns: 537538477 ns
>
> So the last active clocksource is ttc_clocksource
> (drivers/clocksource/timer-cadence-ttc.c).
> If I'm correct the OOB enablement is missing for this driver.
>
> Philippe already pointed us to
> https://v4.xenomai.org/dovetail/porting/timer/.
>
> Could someone try that? I have matching HW at hand...
>

The following code is a 100%, happily untested attempt to enable the ttc
device for pipelining (timer events and reading its clock source
directly from user-space via mmio as well). I don't have any zynq hw at
hand to test it either.

diff --git a/drivers/clocksource/timer-cadence-ttc.c b/drivers/clocksource/=
timer-cadence-ttc.c
index 0d52e28fea4de..fcab778448bba 100644
--- a/drivers/clocksource/timer-cadence-ttc.c
+++ b/drivers/clocksource/timer-cadence-ttc.c
@@ -84,11 +84,11 @@ struct ttc_timer_clocksource {
 	u32			scale_clk_ctrl_reg_old;
 	u32			scale_clk_ctrl_reg_new;
 	struct ttc_timer	ttc;
-	struct clocksource	cs;
+	struct clocksource_user_mmio	cs;
 };
=20
 #define to_ttc_timer_clksrc(x) \
-		container_of(x, struct ttc_timer_clocksource, cs)
+		container_of(x, struct ttc_timer_clocksource, cs.mmio.clksrc)
=20
 struct ttc_timer_clockevent {
 	struct ttc_timer		ttc;
@@ -143,24 +143,11 @@ static irqreturn_t ttc_clock_event_interrupt(int irq,=
 void *dev_id)
 	/* Acknowledge the interrupt and call event handler */
 	readl_relaxed(timer->base_addr + TTC_ISR_OFFSET);
=20
-	ttce->ce.event_handler(&ttce->ce);
+	clockevents_handle_event(&ttce->ce);
=20
 	return IRQ_HANDLED;
 }
=20
-/**
- * __ttc_clocksource_read - Reads the timer counter register
- *
- * returns: Current timer counter register value
- **/
-static u64 __ttc_clocksource_read(struct clocksource *cs)
-{
-	struct ttc_timer *timer =3D &to_ttc_timer_clksrc(cs)->ttc;
-
-	return (u64)readl_relaxed(timer->base_addr +
-				TTC_COUNT_VAL_OFFSET);
-}
-
 static u64 notrace ttc_sched_clock_read(void)
 {
 	return readl_relaxed(ttc_sched_clock_val_reg);
@@ -320,6 +307,7 @@ static int ttc_rate_change_clocksource_cb(struct notifi=
er_block *nb,
 static int __init ttc_setup_clocksource(struct clk *clk, void __iomem *bas=
e,
 					 u32 timer_width)
 {
+	struct clocksource_mmio_regs mmr =3D { 0 };
 	struct ttc_timer_clocksource *ttccs;
 	int err;
=20
@@ -347,11 +335,11 @@ static int __init ttc_setup_clocksource(struct clk *c=
lk, void __iomem *base,
 		pr_warn("Unable to register clock notifier.\n");
=20
 	ttccs->ttc.base_addr =3D base;
-	ttccs->cs.name =3D "ttc_clocksource";
-	ttccs->cs.rating =3D 200;
-	ttccs->cs.read =3D __ttc_clocksource_read;
-	ttccs->cs.mask =3D CLOCKSOURCE_MASK(timer_width);
-	ttccs->cs.flags =3D CLOCK_SOURCE_IS_CONTINUOUS;
+	ttccs->cs.mmio.clksrc.name =3D "ttc_clocksource";
+	ttccs->cs.mmio.clksrc.rating =3D 200;
+	ttccs->cs.mmio.clksrc.read =3D clocksource_mmio_readl_up,
+	ttccs->cs.mmio.clksrc.mask =3D CLOCKSOURCE_MASK(timer_width);
+	ttccs->cs.mmio.clksrc.flags =3D CLOCK_SOURCE_IS_CONTINUOUS;
=20
 	/*
 	 * Setup the clock source counter to be an incrementing counter
@@ -364,7 +352,10 @@ static int __init ttc_setup_clocksource(struct clk *cl=
k, void __iomem *base,
 	writel_relaxed(CNT_CNTRL_RESET,
 		     ttccs->ttc.base_addr + TTC_CNT_CNTRL_OFFSET);
=20
-	err =3D clocksource_register_hz(&ttccs->cs, ttccs->ttc.freq / PRESCALE);
+	mmr.reg_lower =3D ttccs->ttc.base_addr + TTC_COUNT_VAL_OFFSET;
+	mmr.bits_lower =3D 32;
+
+	err =3D clocksource_user_mmio_init(&ttccs->cs, &mmr, ttccs->ttc.freq / PR=
ESCALE);
 	if (err) {
 		kfree(ttccs);
 		return err;
@@ -431,7 +422,8 @@ static int __init ttc_setup_clockevent(struct clk *clk,
=20
 	ttcce->ttc.base_addr =3D base;
 	ttcce->ce.name =3D "ttc_clockevent";
-	ttcce->ce.features =3D CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
+	ttcce->ce.features =3D CLOCK_EVT_FEAT_PERIODIC | \
+		CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_PIPELINE;
 	ttcce->ce.set_next_event =3D ttc_set_next_event;
 	ttcce->ce.set_state_shutdown =3D ttc_shutdown;
 	ttcce->ce.set_state_periodic =3D ttc_set_periodic;

--=20
Philippe.
