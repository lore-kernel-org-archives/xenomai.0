Date: Fri, 18 Mar 2016 12:10:30 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160318111030.GE6555@hermes.click-hack.org>
References: <56EBDBCE.3030800@sigmatek.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56EBDBCE.3030800@sigmatek.at>
Subject: Re: [Xenomai] ipipe bug in gpio/irq for mx6
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Johann Obermayr <johann.obermayr@sigmatek.at>
Cc: xenomai@xenomai.org

On Fri, Mar 18, 2016 at 11:43:26AM +0100, Johann Obermayr wrote:
> Hello,
> 
> in the the git branch ipipe-3.0-imx6q

This I-pipe patch is really old now. Any chance to use a current
version of Xenomai?

> in the file arch/arm/plat-mxc/gpio.c
> 
> there is follow function.
> 
> void __ipipe_mach_enable_irqdesc(struct ipipe_domain *ipd, unsigned irq)
> {
>      struct irq_desc *desc = irq_to_desc(irq);
>      struct irq_data *idata = irq_desc_get_irq_data(desc);
>      struct irq_chip *chip = irq_data_get_irq_chip(idata);
> 
>      if (chip == &gpio_irq_chip) {
>          /* It is a gpio. */
>          u32 gpio = irq_to_gpio(irq);
>          struct mxc_gpio_port *port = &mxc_gpio_ports[gpio / 32];
> 
>          if (ipd != &ipipe_root) {
>              port->nonroot_gpios |= (1 << (gpio % 32));
>              if (port->nonroot_gpios == (1 << (gpio % 32))) {
>                  __ipipe_irqbits[(port->irq / 32)]
>                      &= ~(1 << (port->irq % 32));
>                  set_irq_prio(port->irq, 1);
>              }
>          }
>      } else
>          set_irq_prio(irq, ipd != &ipipe_root);
> }
> 
> But there is missing  set_irq_prio for the port->irq_high.
> to add
>                  if (port->irq_high > 0)
>                      set_irq_prio(port->irq_high, 1);
> is not my problem.
> 
> my problem is, that i don't known if  __ipipe_irqbits is handled
> correct.

Well, if you want to set port->irq_high, you have to clear the
corresponding bit in __ipipe_irqbits, as is done for port->irq.

-- 
					    Gilles.
https://click-hack.org

