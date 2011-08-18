From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <alpine.DEB.1.10.1108181127560.27787@domain.hid>
References: <alpine.DEB.1.10.1108171557300.25850@domain.hid>
	<1313591180.18802.9.camel@domain.hid>
	<alpine.DEB.1.10.1108180933150.27510@domain.hid>
	<alpine.DEB.1.10.1108181127560.27787@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 18 Aug 2011 11:52:10 +0200
Message-ID: <1313661130.18802.33.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Freeze with gpio-keys with Xenomai on Blackfin
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Kolja Waschk <xenoka09@domain.hid>
Cc: xenomai@xenomai.org

On Thu, 2011-08-18 at 11:30 +0200, Kolja Waschk wrote:
> >> Backtrace stopped: previous frame inner to this frame (corrupt stack?)
> 
> Sorry, I had FP off. Now, when pressing any key (irq 79) and then attaching gdb it says
> 
> handle_IRQ_event (irq=79, action=0x0) at kernel/irq/handle.c:427
> 427		local_irq_disable();
> (gdb) bt
> #0  handle_IRQ_event (irq=79, action=0x0) at kernel/irq/handle.c:427
> #1  0x000392ee in handle_level_irq (irq=79, desc=0x6e6be4) at kernel/irq/chip.c:500
> #2  0xffa00378 in asm_do_IRQ (irq=79, regs=<value optimized out>) at include/linux/irq.h:320
> #3  0x0003beee in __ipipe_sync_stage () at kernel/ipipe/core.c:1213
> #4  0x0000653c in ___ipipe_sync_pipeline () at arch/blackfin/kernel/ipipe.c:322
> #5  0x000065b4 in __ipipe_sync_root () at arch/blackfin/kernel/ipipe.c:311
> #6  0xffa01016 in __ipipe_call_irqtail () at include/linux/thread_info.h:86
> 
> 
> I'm curious why it uses "handle_level_irq" although they should be configured as edge-triggered. I'll have a look.
> 

This is required to have it this way, albeit strange at first. The basic
issue is that interrupt delivery to the linux handler can be deferred by
the pipeline, until the high priority domain idles (typically Xenomai).
Since IRQs are re-enabled during this delay, we don't want the device to
hammer us with more interrupts for the same cause, so we want masking
+acknowledge early, then unmasking when handled, maybe significantly
later. Depending on hw behavior, we may need this for edge interrupts as
well. IIRC, Blackfin's internal IRQs require this, otherwise an
interrupt storm surely happens.

This IRQ storm is very likely what bites you. The GPIO IRQ does not seem
to be properly masked upon arrival, or maybe re-enabled too early,
before it has a chance to be delivered to the linux handler. The
platform code should end up running __fixup_irq_handler() for the GPIO
irqs as well, to interpose on the normal IRQ flow handlers.

> 
> Kolja
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

-- 
Philippe.



