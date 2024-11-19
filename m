Received: from redirect.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0839E19C553
	for <xenomai@lists.linux.dev>; Tue, 19 Nov 2024 09:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732008391; cv=none; b=N4oxdVwkTxriaOPtoqNMbowSa10D6DbxK4FPQ6+RIfYeFPI4kvj0Gk5r4IOkfuT/dDlLmXxbHeDGLa13R60XjF14NESwHj5ohm4x3IYZ+zsd2KNI0w78s1iyjiyLpRmBxs5XXo0Q43Belff1QxqA3Xevs7YCxIgIYI7/eMIj2Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732008391; c=relaxed/simple;
	bh=O5FVUf6+W2GR2DSTpU+RtFBBLVHdVElyNMp2vtPEkXw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=QFB4CZXikKQg/JG74/h0IKQgMsKFyWP/wZG7ZmWMcYNimNYMYDcMdq7sZXSLZTgMv84NBdjZZm+3otd0QMpVmJVAWElvFOfkOqL0Ah32VCMXwBLEEi2ar4F9zlZ3QRAVz5gLRUYKafhNJCzGqj/D16cxlpV4+0SZ6SaFtkqIF3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b=Rn267HDM; arc=none smtp.client-ip=217.70.178.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b="Rn267HDM"
Received: from spool.mail.gandi.net (spool1.mail.gandi.net [217.70.178.210])
	by relay11.mail.gandi.net (Postfix) with ESMTPS id 2391F100003
	for <xenomai@lists.linux.dev>; Tue, 19 Nov 2024 09:26:26 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 5BB9E94147B
	for <xenomai@xenomai.org>; Tue, 19 Nov 2024 09:26:25 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-4316cce103dso41517585e9.3
        for <xenomai@xenomai.org>; Tue, 19 Nov 2024 01:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1732008384; x=1732613184; darn=xenomai.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NxGwFW5lGWYs/4uXiH3hT0Fa58Diu12rucXEk2HE2hE=;
        b=Rn267HDMCMDdZ+Vx4EZ7IDpI1GlxPGke+pFdkBPZN7FP76Ik/Z9HMEvPCDg0m2APi2
         0IYirQVarEMnwMWdBzAOItSodyTry8SrxCFbmRmH99LeOh/pewVry5izhfbkPwJIG7AS
         OLdXgfY/NedGiOjCxBk4rwEaUDTnIcwav046M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732008384; x=1732613184;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NxGwFW5lGWYs/4uXiH3hT0Fa58Diu12rucXEk2HE2hE=;
        b=PKoZkau1rlRZ9NPNjvGLwM+SlpZOWZ5SwrfizlgSI94YO+/LSEtC4amcXUm6RssLlW
         F0GMT3FRhurPGkra8UDMnqzX7BVBBccNAnijfmNic1DnRiQ/7E4LcWrcwlKAM6hrIu9T
         V59ZSXWT5Y3GBpXKrQHsFp5U1BkRTY6iqJn0Yh5SVOfX8JIYE11pH0Z7DejWGsrGQ/SV
         ntLppSYPXmbmPclf6Q/H4ZaUcGw+4oh9OVZJyAy+C7mySuP5vOXVDtHWxOmWypC0bEUf
         1jlFdNQiJAtJM3g7flb6Mt3GBsdL3mnd3Gr+7Jccfpxua5NhebHLxyWJQe5MqhJ3Cykg
         rKyA==
X-Gm-Message-State: AOJu0YxgBKBtBdO3vS8pmmbaSF97NZ0VApLnCXwtV0H3oNRQbatEWPPE
	pwi8zHJwRe90JyrV/pGM722/70hetwa/ol7dMAb8GdTW1lgD3530ka5CwibpPhqrowDCohJGxCg
	n
X-Google-Smtp-Source: AGHT+IHhG2HnonISMY0rMV5JVIEZNjpIBQ5xip7XPYXk0UjdyRoReJRisoglpwWzUEWwQk+vC4dxCg==
X-Received: by 2002:a05:600c:5125:b0:42f:8229:a09e with SMTP id 5b1f17b1804b1-432df7937c9mr155783515e9.29.1732008384217;
        Tue, 19 Nov 2024 01:26:24 -0800 (PST)
Received: from ?IPV6:2001:861:4dc0:3640::815? ([2001:861:4dc0:3640::815])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da265f28sm191645485e9.17.2024.11.19.01.26.23
        for <xenomai@xenomai.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2024 01:26:23 -0800 (PST)
Message-ID: <ef026338-cfb5-4519-b361-bb6dd4bc501d@smile.fr>
Date: Tue, 19 Nov 2024 10:26:23 +0100
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Julien Aube <julien.aube@smile.fr>
Subject: Re: Switching from xenomai 3.2 IPIPE to xenomai 3.3 Dovetail
To: xenomai@xenomai.org
References: <1017-673c3d80-39-2c5d8800@259497031>
Content-Language: fr
In-Reply-To: <1017-673c3d80-39-2c5d8800@259497031>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: spool.mail.gandi.net;
	dmarc=pass (policy=reject) header.from=smile.fr;
	spf=pass (spool.mail.gandi.net: domain of julien.aube@smile.fr designates 2a00:1450:4864:20::335 as permitted sender) smtp.mailfrom=julien.aube@smile.fr

Hello,

Reading this exchange it reminds me of a problem I had a few months ago 
on the same platform.

Here is the thead :

https://lore.kernel.org/xenomai/6814fa90-015e-91df-6941-db643e4d4229@smile.fr/#r


Conclusion was that disabling the scutimer(*) on DTS level was enough to 
restore the correct usage and I did not found
any bad behaviour after that. The product has passed all the rt-test 
afterward.


(*)
&scutimer {
     /* scutimer is forced to disabled since it does not work with 
Xenomai */
     status = "disabled";
};

Maybe i'm completely off the subject, but maybe it's worth having a look ?

Julien



Le 19/11/2024 à 08:26, François Legal a écrit :
> Le Lundi, Novembre 18, 2024 16:33 CET, Philippe Gerum<rpm@xenomai.org> a écrit:
>   
>> François Legal<devel@thom.fr.eu.org> writes:
>>
>>> Le Lundi, Novembre 18, 2024 15:49 CET, Philippe Gerum<rpm@xenomai.org> a écrit:
>>>   
>>>> Florian Bezdeka<florian.bezdeka@siemens.com> writes:
>>>>
>>>>> On Mon, 2024-11-18 at 14:37 +0100, Philippe Gerum wrote:
>>>>>> François Legal<devel@thom.fr.eu.org> writes:
>>>>>>
>>>>>>> Le Lundi, Novembre 18, 2024 13:06 CET, Florian Bezdeka<florian.bezdeka@siemens.com> a écrit:
>>>>>>>   
>>>>>>>> [ Updated CC list to merge both mail threads ]
>>>>>>>>
>>>>>>>> On Mon, 2024-11-18 at 12:37 +0100, Philippe Gerum wrote:
>>>>>>>>> François Legal<devel@thom.fr.eu.org> writes:
>>>>>>>>>
>>>>>>>>>> Le Lundi, Novembre 18, 2024 11:32 CET, Florian Bezdeka<florian.bezdeka@siemens.com> a écrit:
>>>>>>>>>>    
>>>>>>>>>>> On Mon, 2024-11-18 at 11:21 +0100, François Legal wrote:
>>>>>>>>>>>> Le Lundi, Novembre 18, 2024 10:01 CET, Jan Kiszka<jan.kiszka@siemens.com> a écrit:
>>>>>>>>>>>>   
>>>>>>>>>>>>> On 18.11.24 09:50, François Legal wrote:
>>>>>>>>>>>>>> Hello,
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> running on an Arm v7 cortex A9 platform, I'm trying to switch from xenomai 3.2 (linux 5.4 IPIPE) to xenomai 3.3 (linux 5.15 Dovetail).
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> I can successfully boot my system with linux 5.15 + CONFIG_DOVETAIL, but as soon as I enable Xenomai (CONFIG_XENOMAI), I got stuck at boot in a do_idle loop. Did I miss anything ?
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Attached is my config.
>>>>>>>>>>>>> Can you factor out from it what the SoC is, if you patched the kernel
>>>>>>>>>>>>> for it (in the past and now), if you had to adopt Dovetail etc.?
>>>>>>>>>>>>>
>>>>>>>>>>>>> Jan
>>>>>>>>>>>> The SoC is Xilinx zynq 7000. I have custom patches for custom FPGA peripherals (which most of them have been successfully ported to 5.15).
>>>>>>>>>>> We had a similar report for the zynq 7020 a couple of days ago.
>>>>>>>>>>> See [1].
>>>>>>>>>>>
>>>>>>>>>>> What happens if you disable CONFIG_SMP? (Not that this should be the
>>>>>>>>>>> final solution, but it might help to track the issue down...)
>>>>>>>>>>>
>>>>>>>>>>> Florian
>>>>>>>>>>>
>>>>>>>>>> Disabling config SMP makes my system boot again.
>>>>>>>>>> How can I help working this out ?
>>>>>>>>>>
>>>>>>>>>> François
>>>>>>>>>>
>>>>>>>>> This looks like an issue with the proxy tick device. First thing is to
>>>>>>>>> disable CONFIG_XENOMAI, enabling CONFIG_IRQ_PIPELINE_TORTURE_TEST. If
>>>>>>>>> the kernel still hangs, we may have a hint about the reason
>>>>>>>>> why. Alternatively, you could keep CONFIG_XENOMAI in, booting the kernel
>>>>>>>>> with "xenomai.state=stopped". If no hang occurs at boot anymore, there
>>>>>>>>> may be an issue with proxying the timer device on this SoC.
>>>>>>>>>
>>>>>>> CONFIG_IRQ_PIPELINE_TORTURE_TEST seems to report OK (attached bootlog CONFIG_IRQ_PIPELINE_TORTURE_TEST.boot
>>>>>>>
>>>>>>> Starting with "xenomai.state=stopped" works (attached boolog xenomai.state-stopped.boot)
>>>>>>> Starting up xenomai with coreclk afterwards seem to work and not hang system :
>>>>>>> root@Arkens_SV:~# /usr/xenomai/sbin/corectl -start
>>>>>>> [  117.328878] CPU1: proxy tick device registered (333.33MHz)
>>>>>>> [  117.328883] CPU0: proxy tick device registered (333.33MHz)
>>>>>>> [  117.339995] [Xenomai] services started
>>>>>>>
>>>>>>>
>>>>>> Ok, so another usual suspect for this issue: some weirdness in the CPU
>>>>>> idling code, which causes a (timer) interrupt to linger indefinitely in
>>>>>> some per-CPU interrupt log. A typical scenario is as follows:
>>>>>>
>>>>>> CPUx
>>>>>> ----
>>>>>>
>>>>>>       default_idle_call() {
>>>>>>
>>>>>>        ...
>>>>>> <IRQ> -> logged because local_irq_disable() in effect, _however_ we do NOT
>>>>>>           expect hard irqs to be enabled [1] before entering the idle call
>>>>>>           next => issue is there.
>>>>>>        arch_cpu_idle();
>>>>>>        ...
>>>>>>        /* per-CPU log is not flushed, because of [1] */
>>>>>>       }
>>>>>>
>>>>>> At the end of the day, the (most likely) timer IRQ is marked as pending
>>>>>> in the log, but never played, so the kernel activity stalls on that CPU,
>>>>>> especially if the boot CPU is involved.
>>>>>>
>>>>> Taken from the boot log:
>>>>>
>>>>> [    0.000024] clocksource: arm_global_timer: freq: 166666665 Hz, mask: 0xffffffffffffffff max_cycles: 0x26703d7dd8, max_idle_ns: 440795208065 ns
>>>>> [    0.012959] clocksource: jiffies: freq: 0 Hz, mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
>>>>> [    0.587268] clocksource: Switched to clocksource arm_global_timer
>>>>> [    1.065121] clocksource: ttc_clocksource: freq: 54253 Hz, mask: 0xffff max_cycles: 0xffff, max_idle_ns: 537538477 ns
>>>>>
>>>>> So the last active clocksource is ttc_clocksource
>>>>> (drivers/clocksource/timer-cadence-ttc.c).
>>>>> If I'm correct the OOB enablement is missing for this driver.
>>>>>
>>>>> Philippe already pointed us to
>>>>> https://v4.xenomai.org/dovetail/porting/timer/.
>>>>>
>>>>> Could someone try that? I have matching HW at hand...
>>>>>
>>>> The following code is a 100%, happily untested attempt to enable the ttc
>>>> device for pipelining (timer events and reading its clock source
>>>> directly from user-space via mmio as well). I don't have any zynq hw at
>>>> hand to test it either.
>>>>
>>>> diff --git a/drivers/clocksource/timer-cadence-ttc.c b/drivers/clocksource/timer-cadence-ttc.c
>>>> index 0d52e28fea4de..fcab778448bba 100644
>>>> --- a/drivers/clocksource/timer-cadence-ttc.c
>>>> +++ b/drivers/clocksource/timer-cadence-ttc.c
>>>> @@ -84,11 +84,11 @@ struct ttc_timer_clocksource {
>>>>   	u32			scale_clk_ctrl_reg_old;
>>>>   	u32			scale_clk_ctrl_reg_new;
>>>>   	struct ttc_timer	ttc;
>>>> -	struct clocksource	cs;
>>>> +	struct clocksource_user_mmio	cs;
>>>>   };
>>>>   
>>>>   #define to_ttc_timer_clksrc(x) \
>>>> -		container_of(x, struct ttc_timer_clocksource, cs)
>>>> +		container_of(x, struct ttc_timer_clocksource, cs.mmio.clksrc)
>>>>   
>>>>   struct ttc_timer_clockevent {
>>>>   	struct ttc_timer		ttc;
>>>> @@ -143,24 +143,11 @@ static irqreturn_t ttc_clock_event_interrupt(int irq, void *dev_id)
>>>>   	/* Acknowledge the interrupt and call event handler */
>>>>   	readl_relaxed(timer->base_addr + TTC_ISR_OFFSET);
>>>>   
>>>> -	ttce->ce.event_handler(&ttce->ce);
>>>> +	clockevents_handle_event(&ttce->ce);
>>>>   
>>>>   	return IRQ_HANDLED;
>>>>   }
>>>>   
>>>> -/**
>>>> - * __ttc_clocksource_read - Reads the timer counter register
>>>> - *
>>>> - * returns: Current timer counter register value
>>>> - **/
>>>> -static u64 __ttc_clocksource_read(struct clocksource *cs)
>>>> -{
>>>> -	struct ttc_timer *timer = &to_ttc_timer_clksrc(cs)->ttc;
>>>> -
>>>> -	return (u64)readl_relaxed(timer->base_addr +
>>>> -				TTC_COUNT_VAL_OFFSET);
>>>> -}
>>>> -
>>>>   static u64 notrace ttc_sched_clock_read(void)
>>>>   {
>>>>   	return readl_relaxed(ttc_sched_clock_val_reg);
>>>> @@ -320,6 +307,7 @@ static int ttc_rate_change_clocksource_cb(struct notifier_block *nb,
>>>>   static int __init ttc_setup_clocksource(struct clk *clk, void __iomem *base,
>>>>   					 u32 timer_width)
>>>>   {
>>>> +	struct clocksource_mmio_regs mmr = { 0 };
>>>>   	struct ttc_timer_clocksource *ttccs;
>>>>   	int err;
>>>>   
>>>> @@ -347,11 +335,11 @@ static int __init ttc_setup_clocksource(struct clk *clk, void __iomem *base,
>>>>   		pr_warn("Unable to register clock notifier.\n");
>>>>   
>>>>   	ttccs->ttc.base_addr = base;
>>>> -	ttccs->cs.name = "ttc_clocksource";
>>>> -	ttccs->cs.rating = 200;
>>>> -	ttccs->cs.read = __ttc_clocksource_read;
>>>> -	ttccs->cs.mask = CLOCKSOURCE_MASK(timer_width);
>>>> -	ttccs->cs.flags = CLOCK_SOURCE_IS_CONTINUOUS;
>>>> +	ttccs->cs.mmio.clksrc.name = "ttc_clocksource";
>>>> +	ttccs->cs.mmio.clksrc.rating = 200;
>>>> +	ttccs->cs.mmio.clksrc.read = clocksource_mmio_readl_up,
>>>> +	ttccs->cs.mmio.clksrc.mask = CLOCKSOURCE_MASK(timer_width);
>>>> +	ttccs->cs.mmio.clksrc.flags = CLOCK_SOURCE_IS_CONTINUOUS;
>>>>   
>>>>   	/*
>>>>   	 * Setup the clock source counter to be an incrementing counter
>>>> @@ -364,7 +352,10 @@ static int __init ttc_setup_clocksource(struct clk *clk, void __iomem *base,
>>>>   	writel_relaxed(CNT_CNTRL_RESET,
>>>>   		     ttccs->ttc.base_addr + TTC_CNT_CNTRL_OFFSET);
>>>>   
>>>> -	err = clocksource_register_hz(&ttccs->cs, ttccs->ttc.freq / PRESCALE);
>>>> +	mmr.reg_lower = ttccs->ttc.base_addr + TTC_COUNT_VAL_OFFSET;
>>>> +	mmr.bits_lower = 32;
>>>> +
>>>> +	err = clocksource_user_mmio_init(&ttccs->cs, &mmr, ttccs->ttc.freq / PRESCALE);
>>>>   	if (err) {
>>>>   		kfree(ttccs);
>>>>   		return err;
>>>> @@ -431,7 +422,8 @@ static int __init ttc_setup_clockevent(struct clk *clk,
>>>>   
>>>>   	ttcce->ttc.base_addr = base;
>>>>   	ttcce->ce.name = "ttc_clockevent";
>>>> -	ttcce->ce.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
>>>> +	ttcce->ce.features = CLOCK_EVT_FEAT_PERIODIC | \
>>>> +		CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_PIPELINE;
>>>>   	ttcce->ce.set_next_event = ttc_set_next_event;
>>>>   	ttcce->ce.set_state_shutdown = ttc_shutdown;
>>>>   	ttcce->ce.set_state_periodic = ttc_set_periodic;
>>>>
>>>> -- 
>>> I just gave it a try, but with no success. I hadtried a patch of mine too with the same result.
>>> I wonder however if this is really the problem here as when I get stuck at boot, the last declare time source is the Arm GT :
>>>
>>> Here :
>>> [    0.614817] clocksource: Switched to clocksource arm_global_timer
>>>
>>> [    0.628544] NET: Registered PF_INET protocol family
>>> [    0.633699] IP idents hash table entries: 16384 (order: 5, 131072 bytes, linear)
>>> [    0.642170] tcp_listen_portaddr_hash hash table entries: 512 (order: 0, 4096 bytes, linear)
>>> [    0.650587] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
>>> [    0.658339] TCP established hash table entries: 8192 (order: 3, 32768 bytes, linear)
>>> [    0.666173] TCP bind hash table entries: 8192 (order: 4, 65536 bytes, linear)
>>> [    0.673540] TCP: Hash tables configured (established 8192 bind 8192)
>>> [    0.679986] UDP hash table entries: 512 (order: 2, 16384 bytes, linear)
>>> [    0.686665] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes, linear)
>>> [    0.693937] NET: Registered PF_UNIX/PF_LOCAL protocol family
>>> [    0.700355] RPC: Registered named UNIX socket transport module.
>>> [    0.706274] RPC: Registered udp transport module.
>>> [    0.710989] RPC: Registered tcp transport module.
>>> [    0.715691] RPC: Registered tcp NFSv4.1 backchannel transport module.
>>> [    0.722914] [Xenomai] scheduling class idle registered.
>>> [    0.728138] [Xenomai] scheduling class rt registered.
>>> [    0.733243] IRQ pipeline: high-priority Xenomai stage added.
>>> [    0.740572] CPU0: proxy tick device registered (333.33MHz)
>>> [    0.740575] CPU1: proxy tick device registered (333.33MHz)
>>> [    0.752600] [Xenomai] Cobalt v3.3
>>> [    0.756129] workingset: timestamp_bits=30 max_order=18 bucket_order=0
>>> [    0.879595] NET: Registered PF_ALG protocol family
>>> [    0.884507] bounce: pool size: 64 pages
>>> [    0.888358] io scheduler mq-deadline registered
>>> [    0.896523] dma-pl330 f8003000.dmac: Loaded driver for PL330 DMAC-241330
>>> [    0.903234] dma-pl330 f8003000.dmac:         DBUFF-128x8bytes Num_Chans-8 Num_Peri-4 Num_Events-16
>>> [    0.919795] brd: module loaded
>>>
>>> then hung from here
>>>
>> What if you disable CONFIG_CPUIDLE?
> It's already disabled.
>
> François
>
>> -- 
>> Philippe.
-- 
SMILE <https://www.smile.eu/>

	
*Julien AUBÉ*
Tech Expert 1

email julien.aube@smile.fr
phone +33 6 99 11 76 08

Twitter Facebook LinkedIn Github



eco Pour la planète, n'imprimez ce mail que si c'est nécessaire
