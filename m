From: Josh Karch <jkarch@FirstMode.com>
Subject: Re: xeno-gpio-xilinx causes gpio-xilinx's IRQ
 callback(xgpio_irqhandler) to trigger rather than gpio-core's
 "gpio_pin_interrupt"
Date: Tue, 14 Jul 2020 13:41:47 +0000
Message-ID: <MN2PR19MB39678ADF1C39F1B65E8BAA62D5610@MN2PR19MB3967.namprd19.prod.outlook.com>
References: <MN2PR19MB396729DFBDCB6D5C5E72B494D5600@MN2PR19MB3967.namprd19.prod.outlook.com>
 <CALLqZ8QGmES1-V7chCo8igEXW3hEKt7GZu7zR04NYLzFfKifTw@mail.gmail.com>
 <MN2PR19MB39672CE35203CC81FBEF95A6D5600@MN2PR19MB3967.namprd19.prod.outlook.com>,
 <CALLqZ8To9o0hNzdgsu7Y-jJrZa57rhjnh9mmGnAMgGTq7cUD1A@mail.gmail.com>
In-Reply-To: <CALLqZ8To9o0hNzdgsu7Y-jJrZa57rhjnh9mmGnAMgGTq7cUD1A@mail.gmail.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>



________________________________
From: Greg Gallagher <greg@embeddedgreg.com>
Sent: Monday, July 13, 2020 9:14 PM
To: Josh Karch <jkarch@FirstMode.com>
Cc: Xenomai@xenomai.org <xenomai@xenomai.org>
Subject: Re: xeno-gpio-xilinx causes gpio-xilinx's IRQ callback(xgpio_irqha=
ndler) to trigger rather than gpio-core's "gpio_pin_interrupt"

HI,

On Mon, Jul 13, 2020 at 6:54 PM Josh Karch <jkarch@firstmode.com<mailto:jka=
rch@firstmode.com>> wrote:


________________________________
From: Greg Gallagher <greg@embeddedgreg.com<mailto:greg@embeddedgreg.com>>
Sent: Monday, July 13, 2020 3:43 PM
To: Josh Karch <jkarch@FirstMode.com>
Cc: Xenomai@xenomai.org<mailto:Xenomai@xenomai.org> <xenomai@xenomai.org<ma=
ilto:xenomai@xenomai.org>>
Subject: Re: xeno-gpio-xilinx causes gpio-xilinx's IRQ callback(xgpio_irqha=
ndler) to trigger rather than gpio-core's "gpio_pin_interrupt"

Hi Josh,


On Mon., Jul. 13, 2020, 6:37 p.m. Josh Karch via Xenomai <xenomai@xenomai.o=
rg<mailto:xenomai@xenomai.org>> wrote:
Hi,

With the CAN bus issues resolved, I now have a situation where the xeno-gpi=
o-xilinx driver (gpio-core.c) causes a complete system lockup when IRQs are=
 enabled and a GPIO toggle triggers the IRQ event.

Here's what I know:  I instrumented the NRT driver to see how deeply entren=
ched and intertwined the real-time and non real-time drivers are:

(1) xeno-gpio-xilinx calls gpio-core which piggybacks upon the Xilinx "gpio=
-xilinx" driver.
(2)It uses the OF scan information to create /dev/rtdm/gpio@address/gpioxxx=
 driver pins.

When enabling interrupts:
(1)It uses the  NRT "Xgpio-request" function to request a gpio pin and set =
the pin to an input, though for some reason it calls the set gpio as input =
function twice
(2) It then calls xgpio-toirq twice for some reason
(3) It sets the IRQ type.  Only the rising edge IRQ is supported with the X=
ilinx Driver
(4) It uses the unmask function in the non RT driver to unmask the IRQ
(5) It then sets the gpio as input again. I think this is a side effect of =
calling the IOCTL to enable IRQ and then to block file descriptors on inter=
rupt.
(6) Once the interrupt is triggered, on occasion the Non realtime xgpio_irq=
handler gets called rather than the gpio_pin_interrupt function.  This make=
s me think the NRT driver is not properly setting the interrupt up to work =
with the Xenomai handler.  Once the non realtime xgpio_irqhandler gets call=
ed the code gets stuck in an infinite loop and crashes.

Sometimes the system freezes before using the handler, other times it runs =
the handler but it's not possible to break.

The following is a transcript of a time when the nrt handler is not called.=
    Otherwise you'd see a message when IRQ is triggered that the system con=
tinually is in a nrt IRQ handler loop.

So the question is: why is the non-rt handler being called and not the gpio=
-core rt_gpio "gpio-pin-interrupt"?


[  303.900487] requesting GPIO
[  303.903419] setting gpio 0 as input
[  303.907004] setting gpio 0 as input
[  303.910549] called xgpio to irq
[  303.913768] called xgpio to irq
[  303.916913] setting irq type 1
[  303.919990] unmasking IRQ
[  303.922600] setting gpio 0 as input
[  324.917162] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
[  324.923100] rcu:     0-...0: (1 ticks this GP) idle=3D66e/1/0x4000000000=
000000
softirq=3D8388/8389 fqs=3D2247
[  324.932321] rcu:     (detected by 3, t=3D5252 jiffies, g=3D12713, q=3D18=
8)
[  324.938411] Task dump for CPU 0:
[  324.941629] xeno_gpio_teste R  running task        0   433    388 0x0000=
0202
[  324.948682] Call trace:
[  324.951126]  __switch_to+0x94/0xf0
[  324.954522]  0xffffff8008dea658

Best,

Josh Karch

Do you have have the gic and the IRQ handlers in place for the xilinx-gpio =
xenomai driver?  The current implementation doesn't support interrupts.

Thanks

Greg


Hi Greg, so the only changes between the "gpio-core.c"  from stock Xenomai =
and the driver I'm working with is the section of code which adds dual-chan=
nel functionality to the Xilinx driver in "rtdm_gpiochip_scan_of."
These are the functions in gpio-core.  It seems there are a lot of function=
s in gpio-core dealing with interrupts.  The Xilinx stock driver provided b=
y Xilinx has interrupt functions in there.  What else is missing?

Did you add the pieces to the gpio-xilinx driver to make it pipeline aware?=
  Right now the current xeno-gpio-xilinx driver is meant to work with the m=
ainline kernel which doesn't have the axi gpios as an interrupt source.

thanks

Greg

>>Hi Greg,
also please note  this is the starting source code for the gpio-xilinx.c dr=
iver, it comes directly from the folks at Xilinx but has not made it into t=
he mainline kernel.
https://github.com/Xilinx/linux-xlnx/blob/master/drivers/gpio/gpio-xilinx.c
The mods I did applied regarding raw_spin_lock_irqsave, restore, ipipe_lock=
_irq, and ipipe_unlock_irq were applied to this driver.

Best,

Josh

static int gpio_pin_interrupt(rtdm_irq_t *irqh)
{
struct rtdm_gpio_pin *pin;
pin =3D rtdm_irq_get_arg(irqh, struct rtdm_gpio_pin);
pin->timestamp =3D rtdm_clock_read_monotonic();
rtdm_event_signal(&pin->event);
return RTDM_IRQ_HANDLED;
}
static int request_gpio_irq(unsigned int gpio, struct rtdm_gpio_pin *pin,
struct rtdm_gpio_chan *chan,
int trigger)
{
int ret, irq_trigger, irq;
if (trigger & ~GPIO_TRIGGER_MASK)
return -EINVAL;
if (!chan->requested) {
ret =3D gpio_request(gpio, pin->name);
if (ret) {
if (ret !=3D -EPROBE_DEFER)
printk(XENO_ERR
"can not request GPIO%d\n", gpio);
return ret;
}
chan->requested =3D true;
}
ret =3D gpio_direction_input(gpio);
if (ret) {
printk(XENO_ERR "cannot set GPIO%d as input\n", gpio);
goto fail;
}
chan->has_direction =3D true;
gpio_export(gpio, true);
rtdm_event_clear(&pin->event);
/*
* Attempt to hook the interrupt associated to that pin. We
* might fail getting a valid IRQ number, in case the GPIO
* chip did not define any mapping handler (->to_irq). If so,
* just assume that either we have no IRQ indeed, or interrupt
* handling may be open coded elsewhere.
*/
irq =3D gpio_to_irq(gpio);
if (irq < 0)
goto done;
irq_trigger =3D 0;
if (trigger & GPIO_TRIGGER_EDGE_RISING)
irq_trigger |=3D IRQ_TYPE_EDGE_RISING;
if (trigger & GPIO_TRIGGER_EDGE_FALLING)
irq_trigger |=3D IRQ_TYPE_EDGE_FALLING;
if (trigger & GPIO_TRIGGER_LEVEL_HIGH)
irq_trigger |=3D IRQ_TYPE_LEVEL_HIGH;
if (trigger & GPIO_TRIGGER_LEVEL_LOW)
irq_trigger |=3D IRQ_TYPE_LEVEL_LOW;
if (irq_trigger)
irq_set_irq_type(irq, irq_trigger);
ret =3D rtdm_irq_request(&pin->irqh, irq, gpio_pin_interrupt,
0, pin->name, pin);
if (ret) {
printk(XENO_ERR "cannot request GPIO%d interrupt\n", gpio);
goto fail;
}
rtdm_irq_enable(&pin->irqh);
done:
chan->is_interrupt =3D true;
return 0;
fail:
gpio_free(gpio);
chan->requested =3D false;
return ret;
}













