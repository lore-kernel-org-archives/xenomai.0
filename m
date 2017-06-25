References: <mailman.117.1496166485.4225.xenomai@xenomai.org>
 <1496167354451.78382@kth.se>
 <e1ed397b-c902-7b7d-5d1c-e78d9c5f8bf0@xenomai.org>
 <1496226896420.15161@kth.se>
 <78c2df60-f9d8-ff4e-a53d-1b64e4af5c4a@xenomai.org>
 <1497222185664.65276@kth.se> <1497265336521.90775@kth.se>
 <af63a95f-4cb0-508c-7939-eea5b2f3c62d@xenomai.org>
 <1497445019861.76883@kth.se>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <5e092673-0f50-a2d0-662a-c6702f732f20@xenomai.org>
Date: Sun, 25 Jun 2017 15:59:53 +0200
MIME-Version: 1.0
In-Reply-To: <1497445019861.76883@kth.se>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Problem with gpio interrupts for xenomai3 on Intel
 joule
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Nitin Kulkarni <nitink@kth.se>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 06/14/2017 02:57 PM, Nitin Kulkarni wrote:
> Major change is use of handle_level_irq flow handler instead of handle_simple_irq
> & calling the ack function manually in ipipe_irq_cascade.
> Here is the Patch :
> 
> diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
> index 3b19ef0..4f41532 100644
>  
> +static struct intel_pinctrl *hack_pctrl;
> +
>  static void intel_gpio_irq_enable(struct irq_data *d)
>  {
> +	hack_pctrl = pctrl;
>

The interrupt pipeline does not support shared IRQs with regular
drivers, that is the basic issue. The problem with handler data being
overwritten stems from this one, since we cannot support multiple IRQ
actions on a single interrupt channel in pipelined interrupt mode.

You could share an IRQ strictly in real-time mode between multiple
devices only with a Xenomai driver, at the expense of implementing all
the driver's logic on the RTDM side. Conversely, there is no problem in
sharing IRQs between multiple devices in non-rt mode as well, although a
way would have to be found in order to fix the handler data issue
discussed earlier.

The problem starts with mixing real-time and non-rt activities on a
single interrupt channel. Your fix up here simply restricts the usage to
having a single pin controller active in the system, the one that gets
enabled. So in effect, you stop sharing the IRQ between multiple gpio
controller devices, which makes things somewhat usable in your case -
assuming that you only need to enable a single gpio module.

> +static void ipipe_irq_cascade(struct irq_desc *desc)
> +{
> +
> +#ifdef CONFIG_IPIPE
> +	struct intel_pinctrl *pctrl = hack_pctrl;
> +	int irq = irq_desc_get_irq(desc);
> +
> +	desc->irq_data.chip->irq_ack(&desc->irq_data);

Correct. A chained IRQ handler should ack the event in the interrupt
controller when the pipeline is enabled.

>  	ret = gpiochip_irqchip_add(&pctrl->chip, &intel_gpio_irqchip, 0,
> -				   handle_simple_irq, IRQ_TYPE_NONE);
> +				   handle_level_irq, IRQ_TYPE_NONE);

Correct too. The level flow handler must be used for the pipelined
interrupt, since the IRQ handler on the linux stage may be delayed until
the real-time core relinquishes the CPU, so we need masking to prevent
an IRQ storm when the interrupts are enabled again in the meantime.

That also explains why sharing an IRQ between linux and Xenomai to serve
devices with mismatching "priorities" won't work:

the IRQ would be masked on receipt, then delivered to a real-time
handler for probing. The real-time side would want to enable it back
asap, not to delay any further (real-time) IRQ from the same device.
Which means it could not wait for the linux flow handlers to eventually
unmask it, "at some point later".

But, unmasking the interrupt immediately would cause an IRQ storm if the
current request could not be handled by the real-time driver, but should
wait until a linux driver later in the chain accepts it. In the
meantime, the CPU would have resumed accepting interrupts again.

-- 
Philippe.

