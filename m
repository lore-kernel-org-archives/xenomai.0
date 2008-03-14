Message-ID: <d6c8ef150803140241s438d6d5bo6240a406fc988ffa@domain.hid>
Date: Fri, 14 Mar 2008 10:41:57 +0100
From: "Bosko Radivojevic" <bosko.radivojevic@domain.hid>
In-Reply-To: <2ff1a98a0803131051v43dea811r67b5a81e7d32ba62@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <2ff1a98a0803120923m76f75bder857abac049c22e4d@domain.hid>
	<d6c8ef150803130409g2a618d30gbede878d6a09e470@domain.hid>
	<d6c8ef150803131013p152b79fah70d97ee1429e86e9@domain.hid>
	<2ff1a98a0803131051v43dea811r67b5a81e7d32ba62@domain.hid>
Subject: Re: [Adeos-main] New I-pipe patch for ARM.
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>

On Thu, Mar 13, 2008 at 6:51 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:

>  Ok. The code which does this is __ipipe_mach_demux_irq in
>  arch/arm/mach-at91/gpio.c. Could you check if at least it triggers ?

I put the following code into __ipipe_mach_demux_irq() in mach-at91/gpio.c:

[..]
	void __iomem	*pio;
	u32		isr;

printk (KERN_INFO "__ipipe_mach_demux_irq: irq=%d\n", irq);
	pio = get_irq_chip_data(irq);
printk (KERN_INFO "__ipipe_mach_demux_irq: pio=%x\n", pio);
[..]
	for (;;) {
		isr = __raw_readl(pio + PIO_ISR) & __raw_readl(pio + PIO_IMR);
printk (KERN_INFO "__ipipe_mach_demux_irq: isr=%x\n", isr);
		if (!isr) {
printk (KERN_INFO "__ipipe_mach_demux_irq: !isr\n");
			break;
		}
		pin = (unsigned) get_irq_data(irq);
printk (KERN_INFO "__ipipe_mach_demux_irq: pin: %d\n", pin);
[...]

And all I get is just once (first time I send a packet):
__ipipe_mach_demux_irq: irq=3
__ipipe_mach_demux_irq: pio=c02203d8
__ipipe_mach_demux_irq: isr=0
__ipipe_mach_demux_irq: !isr

Maybe pio is wrongly calculated in get_irq_chip_data()?

