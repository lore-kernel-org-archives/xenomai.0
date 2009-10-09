Message-ID: <4ACEFE77.30206@domain.hid>
Date: Fri, 09 Oct 2009 11:12:23 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1f3e02580910080127k766f2407o317ae8a2ce088b4a@domain.hid>	
	<4ACDA5A9.6070408@domain.hid>
	<1f3e02580910081909j1cb4fe90yd4f22aad11d51441@domain.hid>
In-Reply-To: <1f3e02580910081909j1cb4fe90yd4f22aad11d51441@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Support for ARCH_MV88F6290
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Didenko Sergey <didenkos@domain.hid>
Cc: xenomai@xenomai.org

Didenko Sergey wrote:
> 
> 
> 2009/10/8 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org
> <mailto:gilles.chanteperdrix@xenomai.org>>
> 
>     Didenko Sergey wrote:
>     > Dear Xenomai Experts,
>     >
>     > So far I did not progress too much.
>     >
>     > What I have now is that patched Linux is starting to boot as original
>     > kernel and it hangs right after line
>     > [42949373.240000] ata1: SATA max UDMA/133 irq 27
>     > As you can see after line
>     >
>     > [42949373.230000] ?^<6>Xenomai: real-time nucleus v2.4.9.1 (Big Bad
>     > Moon) loaded.
>     >
>     > System does not go to timer_interrupt() function any more.
> 
>     That is expected. Once Xenomai runs, it takes over the timer interrupt.
> 
>     >
>     > What I'm worring about is that the system has 2 timers, one is
>     > free-running with disabled interrupts, second one is interrupt-driven
>     > clockevent timer.
> 
>     No problem. Use the clockevent timer for hardware timer, use the
>     free-running counter for tsc emulation.
> 
>     >
>     > =========================== Code - Start
>     > (...)
>     > =========================== Code - End
>     >
>     > According to HOWTO Xenomai needs free-running counter, in my case
>     it is
>     > Timer 0, but all functions are configured to work with Timer 1,
>     which is
>     > not free running.
>     >
>     > What would you suggest to do?
> 
>     No, the howto does not say that you need a free-running counter. It
>     shows the example of a free-running counter and tell you to look at the
>     integrator or s3cxxxx code if you want to know how to implement the
>     I-pipe support for a decrementer. The reason being that I wrote the
>     howto, and I never had to work with a decrementer.
> 
>  
> If you never worked with decrementer, I do not want to use it if there
> is any other way...
> For example can I:
> - Enable interrupts for free-running Timer0?
> - Add one more timer with proper functionality for Xenomai (system has 2
> more timers which are not initialized) ?

I do not know the details of your architecture, only you know that. But
if your architecture only supports a decrementer, you will have to use
the decrementer. You will find this kind of details in the processor
datasheet, and then you will know if you have a choice.

Also note that what makes the implementation of the I-pipe support a bit
complicated on integrator and S3Cxxx is that the tsc emulation is based
on the decrementer. But if you have have a decrementer and a
free-running counter, you can use the free-running counter for the tsc
emulation, and the decrementer for the timer implementation. The omap3
I-pipe support works that way for instance.

> 
>     If you really want us to help you should show us the code that you
>     added, not the code that we can already find in the linux kernel
>     sources.
> 
> 
> Of course I really want...
> 
> The code I added is under XENOMAI_SUPPORT_DSV definition

Bad idea. You should follow the howto and only use CONFIG_IPIPE. This
way, you can select the I-pipe support by enabling the option in the
kernel configuration. Besides, calling the XENOMAI_somehting is a bit of
a misnomer, since what you are implementing is the I-pipe support, not
xenomai support.

> /*
>  * Program the hardware timer to trig an interrupt in 'delay' hardware
> timer ticks.
>  */
> void __ipipe_mach_set_dec(unsigned long delay)
> {
>     u32 u;
> 
>     XEN_PRINT("-")
> 
>     if (delay > MIN_OSCR_DELTA) {

Please use define names which are meaningful for your architecture, do
not reuse the PXA define names.

>         unsigned long flags;
> 
>         local_irq_save(flags);
> 
>                               //  OSCR             //OSMR0
>         writel(delay + readl(TIMER1_VAL), TIMER1_RELOAD);

As discussed earlier, this looks wrong if your hardware timer is based
on a decrementer.

> static irqreturn_t orion_timer_interrupt(int irq, void *dev_id)
> {
>     /*
>      * ACK timer interrupt
>      */
>     writel(BRIDGE_INT_TIMER1_CLR, BRIDGE_CAUSE);

This is wrong. When I-pipe is enabled, this acknowledgement is done in
the ipipe_mach_acktimer function, and should no longer be done in the
timer interrupt. Look at pxa_timer_interrupt implementation in the howto.

> BTW, how can I know how much the MIN_OSCR_DELTA value should be for MV
> 88F6290 platfrom?

As I already told you MIN_OSCR_DELTA is called that way because on PXA,
the hardware timer is based on a register called OSCR. You should try
and find a name meaningful for your architecture. Anyway, this value
should be documented in the datasheet of your processor.

-- 
                                          Gilles


