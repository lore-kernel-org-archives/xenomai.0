Message-ID: <50CC9E64.4030901@xenomai.org>
Date: Sat, 15 Dec 2012 16:59:32 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <7385E066AECB78449EEDFA7EE2A2B2B60A052D7D@DB3PRD0410MB355.eurprd04.prod.outlook.com>,
	<50CC6B1E.8070102@xenomai.org>	<7385E066AECB78449EEDFA7EE2A2B2B60A052DA8@DB3PRD0410MB355.eurprd04.prod.outlook.com>	<50CC819F.7010009@xenomai.org>,
	<50CC83E8.1070408@xenomai.org>
	<7385E066AECB78449EEDFA7EE2A2B2B60A052DCB@DB3PRD0410MB355.eurprd04.prod.outlook.com>,
	<50CC8F3E.30908@xenomai.org>
	<7385E066AECB78449EEDFA7EE2A2B2B60A052E0D@DB3PRD0410MB355.eurprd04.prod.outlook.com>
In-Reply-To: <7385E066AECB78449EEDFA7EE2A2B2B60A052E0D@DB3PRD0410MB355.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Xenomai-help] Latency calculation on da850 (Omap
	L138)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: GUGLIELMO NAVARRA <guglielmo.navarra@studenti.uniparthenope.it>
Cc: Xenomai <xenomai@xenomai.org>

On 12/15/2012 04:45 PM, GUGLIELMO NAVARRA wrote:

> Da: Gilles Chanteperdrix [gilles.chanteperdrix@xenomai.org]
> Inviato: sabato 15 dicembre 2012 15.54
>> Anyway, I also asked you to run the "tsc" test, what does this test tell
>> you?


You are quoting the part about the tsc test, did you try and run it?

> 
> In the structure tsc_info must assign addresses (phy and virt) of timer assigned to clocksource or clockevent?



The tsc is a clocksource. If the tsc is based on a free running counter,
what should be accessed in user-space is the free running counter.
The counter which value changes at 27MHz.
The aim is to have an idea of the current time by reading this register.
I do not know how to explain this in any other way.

> I have assigned the offset of timer assigned to clockevent

> (base address is the same because the timer is 64-bit)

The tsc emulation code does not give a damn about any base address. It
simply needs the address of the counter. Nothing else, nothing more.

> 
> 
> static void l138_xenomai_tsc_init(void)
> {
>    struct davinci_soc_info *soc_info = &davinci_soc_info;
>    struct davinci_timer_instance *dtip = soc_info->timer_info->timers;
>    void __iomem *base;
>    base = ioremap(dtip[0].base, SZ_4K);
>    tsc_info.type = IPIPE_TSC_TYPE_FREERUNNING;
>    tsc_info.freq = l138_clock_tick_rate;
>    tsc_info.counter_vaddr = (unsigned long)(base + TIM12);
>    tsc_info.u.counter_paddr = dtip[0].base + TIM12;
>    tsc_info.u.fr.mask = 0xffffffff;
>    __ipipe_tsc_register(&tsc_info);
> }


If the registers are already ioremapped, please do not remap them a
second time. Also, if the tsc emulation was running correctly in
kernel-space, chances are the kernel-space virtual address was already
correct.

And please keep the mailing list in copy.

-- 
                                                                Gilles.

