Message-ID: <2ff1a98a0712280202q522beccfp1feeee25d9b80f38@domain.hid>
Date: Fri, 28 Dec 2007 11:02:30 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <20071228082907.GA27638@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20071219150622.GA15974@domain.hid>
	<2ff1a98a0712190838n68ea4dacs9a27834e07de4939@domain.hid>
	<20071221082724.GA9091@domain.hid>
	<18290.52429.871263.495255@domain.hid>
	<20071228082907.GA27638@domain.hid>
Subject: Re: [Xenomai-help] PIOX irq problems with at91sam9260
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Juan Antonio Garcia Redondo <juan-antonio.garcia@domain.hid>
Cc: jagarcia@domain.hid, xenomai@xenomai.org

On Dec 28, 2007 9:29 AM, Juan Antonio Garcia Redondo
<juan-antonio.garcia@domain.hid> wrote:
> On 26/12/07 22:51, Gilles Chanteperdrix wrote:
> > Juan Antonio Garcia Redondo wrote:
> >  > I've found a workaround for my problem, but I'm not sure if is the
> >  > correct solution.
> >  >
> >  > First, my test program test_irq.c had an error, after request the irq,
> >  > it have be enabled; anyway the problem persists because the
> >  > __ipipe_mach_demux_irq find the irq disabled (gpio->depth = 1).
> >
> > You should not have to enable irqs, this should be done automatically
> > when requesting the irq. Which irq did you have to enable, the gpio irq
> > ? Or the multiplexed one ?
>
> I'm using the PIOB_11 as gpio and programming it as input before run the
> test_irq.
> I have to enable the irq by mean of rt_intr_enable,

You say "the irq", but there are really two irqs involved: the
multiplexed irq, and the decoded irq, which one are you talking about
?

> otherwise the
> correspondent bit of IMR (Interrupt Mask Register) is disabled. Moreover
> the rt_intr_create documentation says:
>
> Note:
>         The interrupt source associated to the interrupt descriptor remains
>         masked upon creation. rt_intr_enable() should be called for the new
>         interrupt object to unmask it.

It seems that when requesting an interrupt with the RTDM skin, it is
not necessary to enable it, but it is still necessary with the native
skin.

>
> Anyway, I would like to know your opinion about my patch. As I said in
> my previous mail, althought the irq is enabled, the correspondent
> handler is not called because the __ipipe_mach_demux_irq function
> (arch/arm/mach-at91rm9200/gpio.c) asks for the depth field of the struct irq_desc.
>
>         if (isr & 1) {
>                 if (unlikely(gpio->depth)) {
>                         /*
>                          * The core ARM interrupt
>                          * handler lazily disables IRQs
>                          * so
>                          * another IRQ must be generated
>                          * before it actually gets
>                          * here to be disabled on the
>                          * GPIO controller.
>                          */
>                         gpio_irq_mask(pin);
>                         }
>                 else
>                         __ipipe_handle_irq(pin, regs);
>                 }
>
> I've attached the patch again because the previous patch had an error.

I will look at your patch.

-- 
                                               Gilles Chanteperdrix

