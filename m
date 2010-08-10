Message-ID: <4C6151AC.1000708@domain.hid>
Date: Tue, 10 Aug 2010 15:18:36 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4C5A26C4.3050702@domain.hid>	<4C5A631B.1040604@domain.hid>	<4C5CC360.7070707@domain.hid>
	<AANLkTikC5DvkOQDfGFWL7b8KXFYd+1OkZrQ0Gc+GzzZr@domain.hid>
	<4C60A3B8.2000603@domain.hid>
In-Reply-To: <4C60A3B8.2000603@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] RTDM driver structure - an update
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Bob Feretich <bob.feretich@domain.hid>
Cc: xenomai@xenomai.org

Bob Feretich wrote:
>   I am porting the the ADIS SPI driver now. The GPIO interrupt problem 
> that I reported is from the Data Ready interrupt from the sensor.
> 
> The OMAP3 chip has 6 GPIO interrupt modules. Each module merges 32 GPIO 
> interrupt channels (1 channel per GPIO pin). Interrupts on these 
> channels can be routed to either the ARM MPU or to the graphics 
> subsystem (IVA). Only the channels that are mapped to the MPU are of 
> interest to Adeos.
> MPU_IRQ  GPIO_module  GPIO_pins_in_module
>   IRQ29   GPIO1        31-0
>   IRQ30   GPIO2        63-34,33,32
>   IRQ31   GPIO3        95-83,82,81,80,79-64
>   IRQ32   GPIO4        127,126-96
>   IRQ33   GPIO5        159-128
>   IRQ34   GPIO6        191-160
> The breaks in the above ranges indicate slightly different capabilities. 
> A signal change on any GPIO pin can cause an interrupt to occur for the 
> group. There are several 32-bit control registers (discussed below) 
> associated with each group. The bits in the control registers are mapped 
> one to one with the interrupt channels of the group.
> 
> The Linux interrupt handler receives the IRQ 29-34 GPIO_module 
> interrupts, determines which channel caused it and calls the interrupt 
> handler associated with that channel by mapping the interrupt to an IRQ 
> in the IRQ 160 to 351 range. (These IRQs don't go through the twl family 
> chips.)
> 
> The below registers should be used by Adeos to detect and process 
> interrupts:
> GPIOn_IRQSTATUS1
> GPIOn_IRQENABLE1 aliases (GPIO_SETIRQENABLE1, GPIOn_CLEARIRQENABLE1)
> 
> The below registers need to be configured by the driver, to tell the 
> hardware when to initiate an interrupt:
> GPIOn_LEVELDETECT0   (0x1: enable the IRQ assertion on low level detect)
> GPIOn_LEVELDETECT1   (0x1: enable the IRQ assertion on high level detect)
> GPIOn_RISINGDETECT    (0x1: enable IRQ/Wakeup on rising edge detect)
> GPIOn_FALLINGDETECT (0x1: enable IRQ/Wakeup on falling edge detect)
> All the bits in the above xxxDETECT  registers are set to zeroes at 
> processor initialization. If they remain zero, all GPIO Channel 
> interrupts are effectively disabled. I'm sure this is what is occurring 
> in my situation.
> 
> For standard Linux drivers, I configure the xxxDETECT registers by 
> setting flags in the request_irq() call. These flags are not present in 
> the rtdm_irq_request() parameters.
> There is a RTDM_IRQTYPE_EDGE flag, but there is no description of what 
> it does or when to use it. It is not sufficient to determine the 
> settings of the xxxDETECT registers.

The RTDM_IRQTYPE_EDGE is documented in RTDM API documentation: "Mark IRQ
as edge-triggered, relevant for correct handling of shared
edge-triggered IRQs. " Here:
http://www.xenomai.org/documentation/xenomai-2.5/html/api/group__rtdmirq.html

It does not cause the hardware to be configured, it just has an effect
on what "flow handler" xenomai uses for this interrupt, in much the same
way as set_irq_handler(irq, handle_edge_irq) for Linux interrupts.

> Also, the documentation is not clear whether an IRQ requested via 
> rtdm_irq_request() is initially enabled or disabled (disabled would be 
> better).

I would guess it is enabled, like when requesting one with request_irq.

> 
> Setting values in the xxxDETECT registers has a scope that effects any 
> driver listening to that IRQ (both Xenomai and Linux). In this case, it 
> is appropriate that I request/reserve the IRQ in both environments and 
> hold my reservation in both environments until my driver is unloaded. I 
> can then configure these registers via my call to request_irq().
> First, I will request the GPIO Channel IRQ in Linux, but keep it disabled.
> Then, I will request it in Xenomai via rtdm_irq_request().
> Then enable the IRQ only in Xenomai.
> 
> Will that screw up the IRQs handling in the Adeos pipe?
> I assume that Adeos can handle interrupts occurring on either or both edges.
> 
> How should I set the flags on the rtdm_irq_request()?
> Do the flags in an active request_irq() have an effect on a subsequent 
> rtdm_irq_request()?

As explained by Philippe, rtdm_request_irq fails to do what request_irq
does when xxxDETECT bits are set, or when you call set_irq_type. But you
may be able to call set_irq_type for an IRQ registered with
rtdm_request_irq (from reading the code, nothing seems to prevent it).

Anyway, you can also call free_irq after request_irq and before
rtdm_request_irq, the hardware registers will probably stay configured.

> Do I need to mark the IRQ SHARED in the request_irq()?
> Does executing a rtdm_irq_request(), without the SHARED flag, fail if 
> the IRQ was reserved via request_irq()? (The purpose of the flag is not 
> documented in the API manual.)
> Do I need to specify the SHARED flag in both request_irq() and 
> rtdm_irq_request()? I'd rather not allow any other driver access to my IRQ.

the rtdm_request_irq "SHARED" flag, works the same way as IRQF_SHARED
for Linux interrupts. It means that Xenomai will be able to register
several handlers for the same interrupt, much like Linux will be able to
register several handlers with the SHARED flag. Its documentation is:
"Enable IRQ-sharing with other real-time drivers."

> 
> Per Gilles comment, Linux should not allow me to execute a 
> "set_irq_type" without holding a reservation to the IRQ. And, if I am 
> holding the reservation, then I could have configured the irq type via 
> the request_irq().

I am not so sure about that, from reading the code, it seems that
set_irq_type should work even for an irq which you have not requested
with request_irq.

But the long term solution is to do something at RTDM level to handle
this case.


-- 
					    Gilles.

