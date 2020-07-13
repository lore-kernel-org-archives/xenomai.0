MIME-Version: 1.0
References: <MN2PR19MB396729DFBDCB6D5C5E72B494D5600@MN2PR19MB3967.namprd19.prod.outlook.com>
In-Reply-To: <MN2PR19MB396729DFBDCB6D5C5E72B494D5600@MN2PR19MB3967.namprd19.prod.outlook.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Mon, 13 Jul 2020 18:43:35 -0400
Message-ID: <CALLqZ8QGmES1-V7chCo8igEXW3hEKt7GZu7zR04NYLzFfKifTw@mail.gmail.com>
Subject: Re: xeno-gpio-xilinx causes gpio-xilinx's IRQ
 callback(xgpio_irqhandler)
 to trigger rather than gpio-core's "gpio_pin_interrupt"
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Josh Karch <jkarch@firstmode.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Hi Josh,


On Mon., Jul. 13, 2020, 6:37 p.m. Josh Karch via Xenomai <
xenomai@xenomai.org> wrote:

> Hi,
>
> With the CAN bus issues resolved, I now have a situation where the
> xeno-gpio-xilinx driver (gpio-core.c) causes a complete system lockup when
> IRQs are enabled and a GPIO toggle triggers the IRQ event.
>
> Here's what I know:  I instrumented the NRT driver to see how deeply
> entrenched and intertwined the real-time and non real-time drivers are:
>
> (1) xeno-gpio-xilinx calls gpio-core which piggybacks upon the Xilinx
> "gpio-xilinx" driver.
> (2)It uses the OF scan information to create /dev/rtdm/gpio@address/gpioxxx
> driver pins.
>
> When enabling interrupts:
> (1)It uses the  NRT "Xgpio-request" function to request a gpio pin and set
> the pin to an input, though for some reason it calls the set gpio as input
> function twice
> (2) It then calls xgpio-toirq twice for some reason
> (3) It sets the IRQ type.  Only the rising edge IRQ is supported with the
> Xilinx Driver
> (4) It uses the unmask function in the non RT driver to unmask the IRQ
> (5) It then sets the gpio as input again. I think this is a side effect of
> calling the IOCTL to enable IRQ and then to block file descriptors on
> interrupt.
> (6) Once the interrupt is triggered, on occasion the Non realtime
> xgpio_irqhandler gets called rather than the gpio_pin_interrupt function.
> This makes me think the NRT driver is not properly setting the interrupt up
> to work with the Xenomai handler.  Once the non realtime xgpio_irqhandler
> gets called the code gets stuck in an infinite loop and crashes.
>
> Sometimes the system freezes before using the handler, other times it runs
> the handler but it's not possible to break.
>
> The following is a transcript of a time when the nrt handler is not
> called.    Otherwise you'd see a message when IRQ is triggered that the
> system continually is in a nrt IRQ handler loop.
>
> So the question is: why is the non-rt handler being called and not the
> gpio-core rt_gpio "gpio-pin-interrupt"?
>
>
> [  303.900487] requesting GPIO
> [  303.903419] setting gpio 0 as input
> [  303.907004] setting gpio 0 as input
> [  303.910549] called xgpio to irq
> [  303.913768] called xgpio to irq
> [  303.916913] setting irq type 1
> [  303.919990] unmasking IRQ
> [  303.922600] setting gpio 0 as input
> [  324.917162] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> [  324.923100] rcu:     0-...0: (1 ticks this GP)
> idle=66e/1/0x4000000000000000
> softirq=8388/8389 fqs=2247
> [  324.932321] rcu:     (detected by 3, t=5252 jiffies, g=12713, q=188)
> [  324.938411] Task dump for CPU 0:
> [  324.941629] xeno_gpio_teste R  running task        0   433    388
> 0x00000202
> [  324.948682] Call trace:
> [  324.951126]  __switch_to+0x94/0xf0
> [  324.954522]  0xffffff8008dea658
>
> Best,
>
> Josh Karch
>

Do you have have the gic and the IRQ handlers in place for the xilinx-gpio
xenomai driver?  The current implementation doesn't support interrupts.

Thanks

Greg

>
