References: <AM0PR04MB4211273F120B170AAEBBA391800B0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <f0344a17-e6ea-32a0-25d2-00781428ce21@xenomai.org>
 <AM0PR04MB4211596E8B94D8BCDD15BF50800B0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <d7abf9bf-a2f1-9157-d2fc-64ad244ecb12@xenomai.org>
 <AM0PR04MB4211A53BF9E080D93D36B3B6800B0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <ffd862c5-e29d-4f8b-7d1c-367155fa76ec@xenomai.org>
 <AM0PR04MB4211D9D2754835F588EBAE5E800B0@AM0PR04MB4211.eurprd04.prod.outlook.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <dce6d7a9-bbb4-886f-93b7-c57581ff4b44@xenomai.org>
Date: Mon, 27 Aug 2018 18:46:37 +0200
MIME-Version: 1.0
In-Reply-To: <AM0PR04MB4211D9D2754835F588EBAE5E800B0@AM0PR04MB4211.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] IPIPE issue causes kernel warning when
 CONFIG_DEBUG_MUTEXES enabled
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "A.s. Dong" <aisheng.dong@nxp.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 08/27/2018 06:34 PM, A.s. Dong wrote:
>> -----Original Message-----
>> From: Philippe Gerum [mailto:rpm@xenomai.org]
>> Sent: Tuesday, August 28, 2018 12:00 AM
>> To: A.s. Dong <aisheng.dong@nxp.com>; xenomai@xenomai.org
>> Subject: Re: IPIPE issue causes kernel warning when CONFIG_DEBUG_MUTEXES
>> enabled
>>
>> On 08/27/2018 05:48 PM, A.s. Dong wrote:
>>>> -----Original Message-----
>>>> From: Philippe Gerum [mailto:rpm@xenomai.org]
>>>> Sent: Monday, August 27, 2018 11:32 PM
>>>> To: A.s. Dong <aisheng.dong@nxp.com>; xenomai@xenomai.org
>>>> Subject: Re: IPIPE issue causes kernel warning when
>>>> CONFIG_DEBUG_MUTEXES enabled
>>>>
>>>> On 08/27/2018 05:17 PM, A.s. Dong wrote:
>>>>>> -----Original Message-----
>>>>>> From: Philippe Gerum [mailto:rpm@xenomai.org]
>>>>>> Sent: Monday, August 27, 2018 10:46 PM
>>>>>> To: A.s. Dong <aisheng.dong@nxp.com>; xenomai@xenomai.org
>>>>>> Subject: Re: IPIPE issue causes kernel warning when
>>>>>> CONFIG_DEBUG_MUTEXES enabled
>>>>>>
>>>>>> On 08/27/2018 02:40 PM, A.s. Dong wrote:
>>>>>>> Hi Xenomai Experts,
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> We met the following kernel warning on a MX6Q SDB board with
>>>>>>> Xenomai enabled 4.9 kernel.
>>>>>>>
>>>>>>> (CONFIG_DEBUG_MUTEXES is enabled).
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> After some debug, I found it seems to be caused by IPIPE calling
>>>>>>> sleepable function in interrupt context.
>>>>>>>
>>>>>>> arch/arm/kernel/ipipe_tsc.c:
>>>>>>>
>>>>>>> int cpufreq_transition_handler()
>>>>>>>
>>>>>>> {
>>>>>>>
>>>>>>>        .
>>>>>>>
>>>>>>>        smp_call_function_single(freqs->cpu, update_timer_freq,
>>>>>>> &freq, 1);
>>>>>>>
>>>>>>> }
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> Where update_timer_freq is not allowed to be sleep. But it will
>>>>>>> finally call clk_get_rate
>>>>>>>
>>>>>>> In twd_refresh_freq which has a mutex and then trigger the
>>>>>>> following warning.
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> My questions is:
>>>>>>>
>>>>>>> Does Xenomai support CONFIG_DEBUG_MUTEXES?
>>>>>>>
>>>>>>> Should we disable it to avoid such issue?
>>>>>>
>>>>>> No, the underlying bug reported by the might_sleep() assertion
>>>>>> would still be there anyway, right?
>>>>>
>>>>> Yes, you're right.
>>>>>
>>>>>> Fixing it is the only sane way to go. This could be done by first
>>>>>> collecting the new per-cpu timer frequencies in the cpufreq
>>>>>> transition handler, then applying the change via update_timer_freq,
>>>>>> passing the per-cpu array of frequencies just collected. That would
>>>>>> spare us the need to retrieve them by a call to
>>>>>> clk_get_rate() in the leaf handler.
>>>>>>
>>>>>
>>>>> Is there a quick fix?
>>>>> I'm not quite familiar with Xenomai/IPIPE implementation. It seems
>>>>> there're two Timers, tsc and ipipe_timer. Not sure can do a proper
>>>>> fix according to your above suggestions.
>>>>>
>>>>
>>>> That was the quick fix. The real and complex fix would be to stop
>>>> expressing delays based on clock and timer frequencies for internal
>>>> Xenomai timings, but as counts of nanoseconds exclusively.
>>>>
>>>> The ugly fix would be as follows: if you can tell u-boot to switch
>>>> the boot CPU of your i.MX6 to the highest frequency available before
>>>> branching to the kernel, then you could just disable CONFIG_CPU_FREQ,
>>>> compiling the offending code out.
>>>>
>>>> This code we have been discussing is a kludge to make sure CPUFREQ's
>>>> performance policy governor is allowed to change the CPU, hence the
>>>> TWD frequency once and only once at boot time, without wrecking
>>>> Xenomai's idea of time, so that the CPUs run at the highest available
>> frequency.
>>>
>>> Thanks for the info.
>>> The current uboot seems does not support it. But in theory, it can be hacked.
>>> Do we have to use arm global timer? E.g. for high accuracy or something
>> else?
>>> If not, imx has another GPT timer which is not affected by cpufreq.
>>
>> As a clocksource, mxc1 would do. Not as a clockevent device though, we need
>> a per-cpu beast for latency reasons.
> 
> Imx gpt as clocksource and twd is still clockevent devices.
> 
> It seems arm smp_twd has its own twd_rate_change() based on clk notifier.
> A bit strange why arm global timer does not implement it (latest mainline also
> not support). Don't know too much history about it.
> IMX issue is trigger by using arm global timer which is registerd as ipipe_tsc timer
> and having refresh_freq.
> 
> Not quit understand the relationship between ipipe_tsc timer and per-cpu timers
> Used in Xenomai.
>

Xenomai unfortunately expresses delays as counts of ticks from a
hardware clock source, historically the x86 TSC, hence the ipipe_tsc
naming that stuck from that era. ipipe_tsc is the ARM-specific framework
the I-pipe provides for interfacing the generic pipeline core with
truckloads of timer clock source chip variants found in the ARM(32) world.

Because Xenomai expresses delays as clock(source) ticks, the conversion
from clock ticks to hardware timer ticks must be done at some point in
the process of programming the next shot (e.g. poking some decrementer).
The I-pipe somewhat piggybacks its hardware timer logic on the regular
clockevent object, interposing on the clock_event_device handlers, hence
the relationship between ipipe_tsc and the per-cpu timers.

> BTW the lastest mainline kernel seems have the same issue as reported in this mail
> If COMMON_CLK is not enabled. (see: twd_cpufreq_transition()).
> 

Yes, this is going to be a recurring issue.

-- 
Philippe.

