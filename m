Message-ID: <4B4BADDD.7070900@domain.hid>
Date: Tue, 12 Jan 2010 00:01:49 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <001101ca930a$1052fa70$30f8ef50$@kalatchev@domain.hid>
In-Reply-To: <001101ca930a$1052fa70$30f8ef50$@kalatchev@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Viper board (ARM XScale) problems with
	Xenomai-2.4.10
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Ivan Kalatchev <ivan.kalatchev@domain.hid>
Cc: Xenomai-help@domain.hid

Ivan Kalatchev wrote:
> Hi,
> 
>  
> 
> I was trying to upgrade my application running on Viper (2.6.16.28 kernel
> with xenomai 2.3.1)  to 
> 
> kernel 2.6.30.10 with xenomai 2.4.10 and ran into couple of problems.

Yes good idea, old patches contain a deadly bug which has been fixed
only recently. Going one step further, I think you should try Xenomai
2.5.0. It really has interesting features for ARM, such as unlocked
context switch, which really decreases interrupt latency.

> 
>  
> 
> 1. My application uses real-time hook to CPLD interrupt, which is chained
> interrupt.
> 
>    In Xenomai 2.4.10 for some reason general purpose interrupt handler for
> chained interrupt is assigned  to I-pipe  acknowledgment handler during
> board initialization:
> 
>  
> 
> in kernel/irq/chip.c:  
> 
>  
> 
> _set_irq_hanler(...
> 
>  
> 
> #ifdef CONFIG_IPIPE
> 
>                else if (is_chained) {
> 
>                desc->ipipe_ack = handle;
> 
>                desc->ipipe_end = &__ipipe_noend_irq;
> 
>                handle = &__ipipe_noack_irq;
> 
> #endif    
> 
>  
> 
> As a result, when CPLD interrupt happened, general purpose interrupt from
> Linux domain is executed as part of ipipe interrupt acknowledgment. After
> that my real-time interrupt handler gets executed. This is not normal, as my
> handler supposed to replace general purpose handler, which should not be
> executed at all, unless I want it to be executed.  I  fixed this problem by
> reassigning ipipe acknowledgment to __ipipe_ack_edge_irq, and not changing
> handler at all, and it worked in my case. But this probably can break some
> other code.

It looks like the I-pipe generic code is trying to get a generic demux
code, whereas on arm, the demux code is done another way. So, the two
solutions collide.

However, the new solution is more attractive, since it avoids
duplicating the irq demux code in ipipe mode. Will fix.

Actually, the fix is simple, remove completely ipipe_mach_demux_irq and
get the linux demux code to call __ipipe_handle_irq instead of
handle_irq, with an #ifdef CONFIG_IPIPE. Like:

#ifndef CONFIG_IPIPE
	handle_irq(whatever);
#else
	__ipipe_handle_irq(whatever else);
#endif

> 2. USB on Viepr is not working with I-pipe.  
> 
>  
> 
> I found the cause of this problem. Again for some reason, I-pipe patch
> changes type of the USB and all other multiplexed interrupts from edge to
> level interrupt, which they are in original Linux kernel. Of course, this
> breaks everything. I fixed USB by changing back interrupts type from level
> to edge in arch/arm/plat-pxa/gpio.c:
> 
>  
> 
> void __intit pxa_init_gpio(
> 
>                instead of 
> 
> #ifndef CONFIG_IPIPE
> 
>                set_irq_handler(irq,handle_edge_irq);
> 
> #else
> 
>                set_irq_handler(irq,handle_level_irq);
> 
> #endif
> 
>  
> 
> I'm using just 
> 
>                set_irq_handler(irq,handle_edge_irq);
> 
> , as it was in original Linux code and everything works fine.
> 
>  
> 
> Shouldn't changes to interrupt code in Xenomai depend on particular board
> and not be part of the common code? 

handle_edge_irq is a misnomer, it should be called
"handle_edge_irq_by_bogus_interrupt_controller"
handle_level_irq is perfectly fine for edge irqs if the interrupt
controller does not loose edge irqs when they are masked.

The point is that handle_edge_irq is incompatible with Xenomai. So, we
replace handle_edge_irq with handle_level_irq in the hope that your edge
controller is not buggy. I did not invent this, I read it on the linux
arm kernel mailing list, and for the sake of preempt_rt, people are
doing the same thing (only without a #ifdef) in the mainline kernel,
they maybe even did it in 2.6.33, or it is pending for 2.6.34.

The point is: you think that everything works fine, but I really doubt
it. Normally, with handle_edge_irq, the I-pipes receives the irq, acks
it, does not mask it, and then go to some other business with irqs on,
the problem is that since the interrupt handler was not run, the
peripheral from which originates the interrupt may trigger it again, and
then you get a lock-up. This is what the code you disabled fixes. And
this is the only fix we have at hand for now.

The interrupt controller depends on the SOC you are using, so normally,
if the PXA controller is not buggy, it should not be buggy on any PXA.
Now, if it does not work for your board, it may be for several reasons,
I would appreciate if you could trace the reason why handle_level_irq
does not work, because it should.

I would also be curious to know why handle_edge_irq works with USB
driver. Maybe the USB driver has some quirks for this case?

-- 
Gilles Chanteperdrix, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

