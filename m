Message-ID: <53676D14.4050502@xenomai.org>
Date: Mon, 05 May 2014 12:51:00 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <53661901.8090400@cantastic.org> <53666383.9010302@xenomai.org>
 <536741B1.8010800@cantastic.org>
In-Reply-To: <536741B1.8010800@cantastic.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Testing on Freescale i.MX6
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ralf Roesch <xenomai@cantastic.org>, xenomai@xenomai.org

On 05/05/2014 09:45 AM, Ralf Roesch wrote:
> On Sun May 04 2014 17:57:55 GMT+0200 (CEST), Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org> wrote:
>> On 05/04/2014 12:40 PM, Ralf Roesch wrote:
>>> Hi,
>>>
>>> based on your suggestions from thread "[Xenomai] ipipe-core-3.10 patch
>>> for arm"
>>> I started testing Xenomai on an i.MX6 board [1].
>>>
>>>   * checked out branch imx_3.10.17_1.0.0_ga from linux-2.6-imx.git [2]
>>>   * merged vanilla v3.10.32 tag
>>>     resolved 3 conflicts:
>>>     drivers/net/can/flexcan.c
>>>     drivers/usb/host/ehci.h
>>>     sound/soc/codecs/wm8962.c
>>>   * applied ipipe-v3.10.32.patch
>>>     resolved 4 conflicts:
>>>     arch/arm/mach-imx/clk-imx6q.c
>>>     arch/arm/mach-imx/mach-imx6q.c
>>>     arch/arm/mach-imx/mm-imx27.c
>>>     arch/arm/mach-imx/mm-imx3.c
>>>   * applied xenomai-2.6 support (prepare-kernel.sh)
>>>
>>> My box boots without errors and seems to be quiet stable at the first
>>> glance.
>>> Linux arm 3.10.32-xenomai-armv7-x1 #24 SMP Sun May 4 12:17:10 CEST 2014
>>> armv7l GNU/Linux
>>>
>>> The first thing I observed is a system time problem:
>>> the RTC and system time clocks get out of phase very quickly.
>>> I do compare the timers (end - start) on console by calling:
>>>     - hwclock && date (start)
>>>     - wait an hour or more
>>>     - hwclock && date (end)
>>> The hwclock time is always o.k. but the system time reported by date is
>>> roughly 25% faster.
>>> Do you have an idea what could go wrong here?
>> The timer frequency. Did you not forget to disable CONFIG_CPU_FREQ? Do
>> you have the same issue without the I-pipe patch?
>>
>>
> Thanks Gilles, I had not disabled the CONFIG_CPU_FREQ.
> After disabling I had also to disable CONFIG_PM, because I got a lot of
> unresolved linker errors.
> More fixes  had to be made in various modules where CONFIG_PM was not
> taken into account.
> In the end I had a bootable kernel, where the "out of phase of timer
> problem"  has been resolved.
> Both timers keep in sync now.
> 
> The kernel without I-pipe patch did work correctly, sorry for not
> mentioning that before.
> 
> I have some more questions regarding timer frequency:
> 
>   * I prefer to leave CONFIG_CPU_FREQ enabled,
>     because in this case I can use the CPUFreq governor (cpufrequtils
>     package)
>     to use the highest frequency, i.e. "performance"
>   * if the governer is set to "performance" a frequency switch shoud not
>     be possible
>     (because the processor is fixed to the high rate)
>   * without governer I can not use the highest rate of the processor:
>     - the frequency (now) without CONFIG_CPU_FREQ is 792MHz
>     - when CONFIG_CPU_FREQ is enabled (before) and governer set to
>     performance it is 996MHz
> 
> If I compare this both frequencies (792MHz vs. 996MHz) I estimate there
> is a wrong scaling factor responsible for the "out of phase" problem.

Look at the mx6 patch for 3.0.43, it solves a similar issue. We support
mainline, and freescale 3.0.35, not freescale 3.10, so, you may have a
lot of issues with this version which were solved for 3.0.43 but are not
in the patch for mainline 3.10. If I remember correctly, there were
multiple such issues such as idle thread and broadcast timer.

-- 
                                                                Gilles.

