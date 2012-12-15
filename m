Message-ID: <50CC83E8.1070408@xenomai.org>
Date: Sat, 15 Dec 2012 15:06:32 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <7385E066AECB78449EEDFA7EE2A2B2B60A052D7D@DB3PRD0410MB355.eurprd04.prod.outlook.com>,
	<50CC6B1E.8070102@xenomai.org>	<7385E066AECB78449EEDFA7EE2A2B2B60A052DA8@DB3PRD0410MB355.eurprd04.prod.outlook.com>
	<50CC819F.7010009@xenomai.org>
In-Reply-To: <50CC819F.7010009@xenomai.org>
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
To: guglielmo.navarra@studenti.uniparthenope.it
Cc: Xenomai <xenomai@xenomai.org>

On 12/15/2012 02:56 PM, Gilles Chanteperdrix wrote:

> On 12/15/2012 02:31 PM, GUGLIELMO NAVARRA wrote:
> 
>> Thanks for your reply,
>> my tsc_info definition is:
>>
>> /*------------------------------------------------
>>   Timer che utilizza IPIPE
>>  -------------------------------------------------*/
>> #ifdef CONFIG_IPIPE
>> static struct __ipipe_tscinfo tsc_info = {
>>         .type = IPIPE_TSC_TYPE_FREERUNNING,
>>        .u = {
>>                 {
>>                         .mask = 0xffffffff,
>>                 },
>>         },
>> };
>>
>> static void l138_xenomai_tsc_init(void)
>> {
>>    struct timer_s *t = &timers[TID_CLOCKSOURCE];
>>   
>>    tsc_info.type = IPIPE_TSC_TYPE_FREERUNNING;
>>    tsc_info.freq = l138_clock_tick_rate;
> 
>>    tsc_info.counter_vaddr = (unsigned long)(t->base + t->tim_off);
> 
>>    tsc_info.u.counter_paddr = DAVINCI_TIMER0_BASE + TIM12;
> 
> 
> What about t->tim_off ?


Also, if t->base can be something else than the result of an
ioremap(DAVINCI_TIMER0_BASE), then you should not hardcode
DAVINCI_TIMER0_BASE, as other boards may pass a different value, rather,
you should add a phys_base to "struct timer_s", and set it correctly for
each possible physical address.

-- 
                                                                Gilles.

