From: Josh Karch <jkarch@FirstMode.com>
Subject: Re: xeno-gpio-xilinx causes gpio-xilinx's IRQ
 callback(xgpio_irqhandler) to trigger rather than gpio-core's
 "gpio_pin_interrupt"
Date: Tue, 14 Jul 2020 21:45:45 +0000
Message-ID: <MN2PR19MB3967E78B93B7125847B8E7B1D5610@MN2PR19MB3967.namprd19.prod.outlook.com>
References: <MN2PR19MB396729DFBDCB6D5C5E72B494D5600@MN2PR19MB3967.namprd19.prod.outlook.com>
 <CALLqZ8QGmES1-V7chCo8igEXW3hEKt7GZu7zR04NYLzFfKifTw@mail.gmail.com>
 <MN2PR19MB39672CE35203CC81FBEF95A6D5600@MN2PR19MB3967.namprd19.prod.outlook.com>
 <CALLqZ8To9o0hNzdgsu7Y-jJrZa57rhjnh9mmGnAMgGTq7cUD1A@mail.gmail.com>
 <MN2PR19MB396729C2504DF1A85A6D5402D5610@MN2PR19MB3967.namprd19.prod.outlook.com>,
 <CALLqZ8RLdVDWPeoJJO9jvEPyHQxXk81wcRcdAT4Wvb=Qbs6Mgg@mail.gmail.com>
In-Reply-To: <CALLqZ8RLdVDWPeoJJO9jvEPyHQxXk81wcRcdAT4Wvb=Qbs6Mgg@mail.gmail.com>
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

Hi Greg,

________________________________
From: Greg Gallagher <greg@embeddedgreg.com>
Sent: Tuesday, July 14, 2020 6:46 AM
To: Josh Karch <jkarch@FirstMode.com>
Cc: Xenomai@xenomai.org <xenomai@xenomai.org>
Subject: Re: xeno-gpio-xilinx causes gpio-xilinx's IRQ callback(xgpio_irqha=
ndler) to trigger rather than gpio-core's "gpio_pin_interrupt"

Hi,

On Tue, Jul 14, 2020 at 9:37 AM Josh Karch <jkarch@firstmode.com<mailto:jka=
rch@firstmode.com>> wrote:


________________________________
From: Greg Gallagher <greg@embeddedgreg.com<mailto:greg@embeddedgreg.com>>
Sent: Monday, July 13, 2020 9:14 PM
To: Josh Karch <jkarch@FirstMode.com>
Cc: Xenomai@xenomai.org<mailto:Xenomai@xenomai.org> <xenomai@xenomai.org<ma=
ilto:xenomai@xenomai.org>>
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

Hi Greg, so here are the things that I did with the gpio-xilinx driver:

#include <linux/ipipe.h>

spin_lock_irqsave(&chip->gpio_lock, flags) was replaced by raw_spin_lock_ir=
qsave(&xilinx_gpio_lock, flags);

Same thing for the irqrestore function:

I also added the following
static IPIPE_DEFINE_RAW_SPINLOCK(xilinx_gpio_lock);

I did not edit the
static int xgpio_irq_setup(struct device_node *np, struct xgpio_instance *c=
hip).

I also set xgpio_irqchip struct with
".flags =3D IRQCHIP_PIPELINE_SAFE,"

With IRQ_Mask function I did the following:
raw_spin_lock_irqsave(&xilinx_gpio_lock, flags);
ipipe_lock_irq(irq_data->irq);

and in the IRQ unmask function I did:
ipipe_unlock_irq(irq_data->irq);
raw_spin_unlock_irqrestore(&xilinx_gpio_lock, flags);

Anything else I am missing?

Best,
Josh

 You'll also need to look at the interrupt flow handlers and see if they ne=
ed to be fixed up or changed at all.
https://gitlab.denx.de/Xenomai/ipipe-arm/-/blob/ipipe/master/Documentation/=
ipipe-arm.rst

-Greg

Thanks for the above link-- so it looks like in the handler I had to replac=
e "generic_handle_irq" with "ipipe_handle_demuxed_irq."  Adding this functi=
on caused the following error:  No warnings appeared in the linker during m=
ake modules... Thoughts?

# modprobe gpio_xilinx
[  122.865480] gpio_xilinx: Unknown symbol __ipipe_dispatch_irq (err -2)
modprobe: ERROR: could not insert 'gpio_xilinx': Unknown symbol in module, =
or
 unknown parameter (see dmesg)

Code section from Xilinx:
/**
 * xgpio_irqhandler - Gpio interrupt service routine
 * @desc: Pointer to interrupt description
 */
static void xgpio_irqhandler(struct irq_desc *desc)
{
unsigned int irq =3D irq_desc_get_irq(desc);

struct xgpio_instance *chip =3D (struct xgpio_instance *)
irq_get_handler_data(irq);
struct of_mm_gpio_chip *mm_gc =3D &chip->mmchip;
struct irq_chip *irqchip =3D irq_desc_get_chip(desc);
int offset;
unsigned long val;

chained_irq_enter(irqchip, desc);

val =3D xgpio_readreg(mm_gc->regs + chip->offset);
/* Only rising edge is supported */
val &=3D chip->irq_enable;

for_each_set_bit(offset, &val, chip->mmchip.gc.ngpio) {
ipipe_handle_demuxed_irq(chip->irq_base + offset);
}

xgpio_writereg(mm_gc->regs + XGPIO_IPISR_OFFSET,
  chip->offset / XGPIO_CHANNEL_OFFSET + 1);

chained_irq_exit(irqchip, desc);
}

