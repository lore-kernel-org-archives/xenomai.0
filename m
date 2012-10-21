Message-ID: <50843EFC.2070409@xenomai.org>
Date: Sun, 21 Oct 2012 20:29:16 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <50812949.5040403@openwide.fr> <50814532.5090408@xenomai.org>
	<5082CD5C.1040409@openwide.fr> <5082DED2.1050405@xenomai.org>
	<50835162.5020401@openwide.fr>
In-Reply-To: <50835162.5020401@openwide.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] s3c24xx with clocksource/clockevent (kernel 3.2.21)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Romain Naour <romain.naour@openwide.fr>
Cc: xenomai@xenomai.org

On 10/21/2012 03:35 AM, Romain Naour wrote:

>>> Until now, I used the latest supported kernel 3.2.21 with Xenomai 2.6.1.
>>> Without rework timer system with clocksource and clockevent,
>>> I need to set "s3c2410_itimer.min_delay_ticks" value
>>> (s3c24xx_fix_itimer.patch)
>>> Otherwise the timer hangs.
>>> And also, the last patch of my previous mail.
>>
>> You mean the patch for the UART ? I can not take that patch. You have to
>> understand what goes wrong in the I-pipe core, or irq chip callbacks
>> implementation for this processor, and fix it there, not in the irq
>> handler for the serial interrupt.
> I think there is a problem when Linux unmask an IRQ line with 
> irq_enable() and when there is an IRQ pending behind.
> I made some comments on the ipipe-tracer log 
> (UART-samsung-bug-ipipe-tracer.txt)
> 
> What do you think of this ?


Without looking at the trace, if the irqs need to be off during the
execution of an irq chip callback, we usually do this inside the chip
callback. When there is a spinlock, simply turn it into an ipipe
spinlock and use spin_lock_irqsave_cond, as explained here:
http://www.xenomai.org/index.php/I-pipe-core:ArmPorting#call-backs_implementation

> Are we need to disable IRQs before call  irq_enable() ?
Usually not.

-- 
                                                                Gilles.

