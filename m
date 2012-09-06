Message-ID: <50485E80.6050800@xenomai.org>
Date: Thu, 06 Sep 2012 10:27:44 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAHue_TVRdTsre3E7NxHtb=6XfxkL7_36nsLLxSkiF3kUJAJ5Vw@mail.gmail.com>	<5022B5E4.7040101@xenomai.org>	<CAHue_TWodrVNxhsxXZ6_xcOGWHDqVGe41qbY0=R3RhFjBedG+g@mail.gmail.com>	<50339840.1070202@xenomai.org>	<CAHue_TVSGuatTqL4fRFoOABo4KTm8dFPmRFp7QJNmpk=ZU7NtQ@mail.gmail.com>	<CAHue_TUKTiusLqfXK59O+PVoxONKAE2xQyBYOgjDh=dZZ2-b3w@mail.gmail.com>	<504503DC.4040908@xenomai.org>	<CAHue_TX3+pr39Mso1SXA83NWVRNoeocD-zDcLPk5mKn-XCkQKQ@mail.gmail.com>	<50453DCE.5020601@xenomai.org>
	<CAHue_TUfY4f4CdCXyEYQ5mPFNiCazwZLgv9yy29W5r78tfftYA@mail.gmail.com>
In-Reply-To: <CAHue_TUfY4f4CdCXyEYQ5mPFNiCazwZLgv9yy29W5r78tfftYA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Cortex-a9 - please fix xenomai-fix-lfs-issue.patch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?TWFyY2luIEt1xZtrYQ==?= <marckuska@gmail.com>
Cc: xenomai@xenomai.org

On 09/06/2012 10:00 AM, Marcin Kuśka wrote:
>> Well, maybe some kernel debug option causes an issue.
>>
> 
>> Please try disabling oprofile, tracepoints and profiling.
>>
> 
> oprofile and profiling disabled - tracepoints not set
> 
> Never tested that on ARM, always run with VMSPLIT_3G.
>>
> 
> Changed.
> 
> 
>> Disable FTRACE. You should also remove all these kernel debugging
>> options, they probably have nothing to do with the issue you are seeing.
>>
> 
> ftrace disabled and all debug options also.
> 
> After disabling all the debugs the xeno-test with a dohell test looks like
> this:

Like what, no kernel message ? I guess you should re-enable the debug
then. And please do not forget what I asked you:
- what of the SLAB issue?
- what of the disassembly of the address where the fault happens?

> 
> As you said "A Cortex-A9 (in MP mode) should use the "global timer" clock
> source," but in the startup log the twd_timer_setup return a "no clock
> found" message.
> 
> The code in smp_twd.c:
> 
> if (twd_clk == NULL) {
>         twd_clk = clk_get(NULL, "smp_twd");
>         if (IS_ERR(twd_clk))
>             pr_warn("%s: no clock found\n", __func__);
>         else
>             clk_enable(twd_clk);
>     }
> 
> That's probably because the clock is not registered in v2m.c (as I suppose
> it should be).

That is a non fatal error, it simply results in an imprecise timer
frequency, but the system works.

> The initialization function looks like this:
> 
> static void __init v2m_timer_init(void)
> {
>     u32 scctrl;
> 
>     /* Select 1MHz TIMCLK as the reference clock for SP804 timers */
>     scctrl = readl(MMIO_P2V(V2M_SYSCTL + SCCTRL));
>     scctrl |= SCCTRL_TIMEREN0SEL_TIMCLK;
>     scctrl |= SCCTRL_TIMEREN1SEL_TIMCLK;
>     writel(scctrl, MMIO_P2V(V2M_SYSCTL + SCCTRL));
> 
>     writel(0, MMIO_P2V(V2M_TIMER0) + TIMER_CTRL);
>     writel(0, MMIO_P2V(V2M_TIMER1) + TIMER_CTRL);
> 
>     sp804_clocksource_init(MMIO_P2V(V2M_TIMER1), V2M_TIMER1, "v2m-timer1");
>     sp804_clockevents_init(MMIO_P2V(V2M_TIMER0),
> IRQ_V2M_TIMER0,"v2m-timer0");
> }
> 
> I'm not sure about what addresses should I pass to sp804_clocksource_init()
> and sp804_clockevents_init() functions. I tried with v2m-timer2 but it
> didn't work.

The first address is the virtual address of the timer registers base the
result of ioremap or of a static mapping by iotable_init), and the
second is the physical address for the same address. Normally the I-pipe
core code is already modified to call these functions with the right
parameter, but since this code is untested, you are right to double
check it.

> 
> I also added to v2m.c following code:
> 
> static struct clk smp_twd = {
>     .rate   = 2000000,
> };

2MHz ? Normally the clock runs at half the core frequency, your ARM core
is running at 4MHz?

> I following the I-pipe-core:ArmPorting document.

Good, what about the call to gt_setup ?

http://www.xenomai.org/index.php/I-pipe-core:ArmPorting#The_Cortex_A9_case

It will allow you to use the global timer as clocksource instead of the
sp804. In order to check the tsc emulation, you can run the xenomai
regression test named "tsc".

-- 
					    Gilles.

