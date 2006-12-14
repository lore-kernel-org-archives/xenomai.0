Message-ID: <4581526A.7010304@domain.hid>
Date: Thu, 14 Dec 2006 14:32:26 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Registering Interrupt Handler [Scanned]
References: <45814504.7050905@domain.hid>
In-Reply-To: <45814504.7050905@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Niklaus Burren <niklaus.burren@domain.hid>
Cc: xenomai@xenomai.org

Niklaus Burren wrote:
> Hello
> 
> I try to register an interrupt handler for an externel interrupt(GPIO 
> 105) in a xenomai (2.2.2) kernel module on a ARM processor (PXA 270).
> I create a interrupt object with the rt_intr_create() function without 
> an error. After that I enable the interrupt with rt_intr_enable(). When 
> I run the kernel module on the PXA270 board and put a square signal to 
> the GPIO 105 pin the interrupt handler is never called.
> 
> // Interrupt Handler
> int int_handler(struct xnintr *intr)
> {
>     printk("Interrupt detected\n");
>     return RT_INTR_HANDLED;
> }
> 
> ----
> 
> // Enalbe Interrupt in init_module()
> err = rt_intr_create(&intr_desc, "GPIO_INT", 10, &int_handler, NULL, NULL);
> 
> rt_intr_enable(&intr_desc);
> 
> On PXA270 all externel interrupts on GPIO's have the same interrupt 
> number (10). Is that a problem? When I get the pin status from the pin 
> level register GPLR3 I can detect the square signal at the pin. But the 
> interrupt handler function int_handler() is never called.

The I-pipe code demultiplexes the IRQ 10 and triggers handlers for irq
numbers after 34. The macro IRQ_GPIO, defined in
include/asm-arm/arch-pxa/irqs.h allow you to get the irq number
associated with a particular GPIO.

So, if you want to be notified of an interrupt on GPIO105, you should
register an handler for irq IRQ_GPIO(105).

-- 
                                                 Gilles Chanteperdrix

