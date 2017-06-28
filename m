From: Nitin Kulkarni <nitink@kth.se>
Date: Wed, 28 Jun 2017 10:47:20 +0000
Message-ID: <1498646840487.52373@kth.se>
References: <mailman.117.1496166485.4225.xenomai@xenomai.org>
 <1496167354451.78382@kth.se>
 <e1ed397b-c902-7b7d-5d1c-e78d9c5f8bf0@xenomai.org>
 <1496226896420.15161@kth.se>
 <78c2df60-f9d8-ff4e-a53d-1b64e4af5c4a@xenomai.org>
 <1497222185664.65276@kth.se> <1497265336521.90775@kth.se>
 <af63a95f-4cb0-508c-7939-eea5b2f3c62d@xenomai.org>
 <1497445019861.76883@kth.se>,
 <5e092673-0f50-a2d0-662a-c6702f732f20@xenomai.org>
In-Reply-To: <5e092673-0f50-a2d0-662a-c6702f732f20@xenomai.org>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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
To: Philippe Gerum <rpm@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi Philippe,=0A=
Thanks for the review and you comments are very helpful.=0A=
I think my fix-up would just be fine for us as we just need one gpio interr=
upt to process SPI transfers=0A=
with an XMOS microcontroller.=0A=
=0A=
Hence my next challenge is to do SPI communication in real-time domain (My =
colleague=0A=
Stefano once had a discussion over emails with you I think about streaming =
audio over SPI in realtime domain),=0A=
I know that I will have to port the spi-pxa2xx platform driver to RTDM. =0A=
i was looking at the bcm2835 spi driver that you have ported for RTDM. =0A=
Is this a good reference to start ? =0A=
  =0A=
Thanks and regards,=0A=
Nitin =0A=
____________________________=0A=
From: Philippe Gerum <rpm@xenomai.org>=0A=
Sent: Sunday, June 25, 2017 3:59 PM=0A=
To: Nitin Kulkarni; xenomai@xenomai.org=0A=
Subject: Re: [Xenomai] Problem with gpio interrupts for xenomai3 on Intel j=
oule=0A=
=0A=
On 06/14/2017 02:57 PM, Nitin Kulkarni wrote:=0A=
> Major change is use of handle_level_irq flow handler instead of handle_si=
mple_irq=0A=
> & calling the ack function manually in ipipe_irq_cascade.=0A=
> Here is the Patch :=0A=
>=0A=
> diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/inte=
l/pinctrl-intel.c=0A=
> index 3b19ef0..4f41532 100644=0A=
>=0A=
> +static struct intel_pinctrl *hack_pctrl;=0A=
> +=0A=
>  static void intel_gpio_irq_enable(struct irq_data *d)=0A=
>  {=0A=
> +     hack_pctrl =3D pctrl;=0A=
>=0A=
=0A=
The interrupt pipeline does not support shared IRQs with regular=0A=
drivers, that is the basic issue. The problem with handler data being=0A=
overwritten stems from this one, since we cannot support multiple IRQ=0A=
actions on a single interrupt channel in pipelined interrupt mode.=0A=
=0A=
You could share an IRQ strictly in real-time mode between multiple=0A=
devices only with a Xenomai driver, at the expense of implementing all=0A=
the driver's logic on the RTDM side. Conversely, there is no problem in=0A=
sharing IRQs between multiple devices in non-rt mode as well, although a=0A=
way would have to be found in order to fix the handler data issue=0A=
discussed earlier.=0A=
=0A=
The problem starts with mixing real-time and non-rt activities on a=0A=
single interrupt channel. Your fix up here simply restricts the usage to=0A=
having a single pin controller active in the system, the one that gets=0A=
enabled. So in effect, you stop sharing the IRQ between multiple gpio=0A=
controller devices, which makes things somewhat usable in your case -=0A=
assuming that you only need to enable a single gpio module.=0A=
=0A=
> +static void ipipe_irq_cascade(struct irq_desc *desc)=0A=
> +{=0A=
> +=0A=
> +#ifdef CONFIG_IPIPE=0A=
> +     struct intel_pinctrl *pctrl =3D hack_pctrl;=0A=
> +     int irq =3D irq_desc_get_irq(desc);=0A=
> +=0A=
> +     desc->irq_data.chip->irq_ack(&desc->irq_data);=0A=
=0A=
Correct. A chained IRQ handler should ack the event in the interrupt=0A=
controller when the pipeline is enabled.=0A=
=0A=
>       ret =3D gpiochip_irqchip_add(&pctrl->chip, &intel_gpio_irqchip, 0,=
=0A=
> -                                handle_simple_irq, IRQ_TYPE_NONE);=0A=
> +                                handle_level_irq, IRQ_TYPE_NONE);=0A=
=0A=
Correct too. The level flow handler must be used for the pipelined=0A=
interrupt, since the IRQ handler on the linux stage may be delayed until=0A=
the real-time core relinquishes the CPU, so we need masking to prevent=0A=
an IRQ storm when the interrupts are enabled again in the meantime.=0A=
=0A=
That also explains why sharing an IRQ between linux and Xenomai to serve=0A=
devices with mismatching "priorities" won't work:=0A=
=0A=
the IRQ would be masked on receipt, then delivered to a real-time=0A=
handler for probing. The real-time side would want to enable it back=0A=
asap, not to delay any further (real-time) IRQ from the same device.=0A=
Which means it could not wait for the linux flow handlers to eventually=0A=
unmask it, "at some point later".=0A=
=0A=
But, unmasking the interrupt immediately would cause an IRQ storm if the=0A=
current request could not be handled by the real-time driver, but should=0A=
wait until a linux driver later in the chain accepts it. In the=0A=
meantime, the CPU would have resumed accepting interrupts again.=0A=
=0A=
--=0A=
Philippe.=0A=

