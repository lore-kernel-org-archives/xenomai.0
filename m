From: Johann Obermayr <johann.obermayr@sigmatek.at>
Message-ID: <56EBDBCE.3030800@sigmatek.at>
Date: Fri, 18 Mar 2016 11:43:26 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] ipipe bug in gpio/irq for mx6
Reply-To: johann.obermayr@sigmatek.at
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

in the the git branch ipipe-3.0-imx6q
in the file arch/arm/plat-mxc/gpio.c

there is follow function.

void __ipipe_mach_enable_irqdesc(struct ipipe_domain *ipd, unsigned irq)
{
     struct irq_desc *desc = irq_to_desc(irq);
     struct irq_data *idata = irq_desc_get_irq_data(desc);
     struct irq_chip *chip = irq_data_get_irq_chip(idata);

     if (chip == &gpio_irq_chip) {
         /* It is a gpio. */
         u32 gpio = irq_to_gpio(irq);
         struct mxc_gpio_port *port = &mxc_gpio_ports[gpio / 32];

         if (ipd != &ipipe_root) {
             port->nonroot_gpios |= (1 << (gpio % 32));
             if (port->nonroot_gpios == (1 << (gpio % 32))) {
                 __ipipe_irqbits[(port->irq / 32)]
                     &= ~(1 << (port->irq % 32));
                 set_irq_prio(port->irq, 1);
             }
         }
     } else
         set_irq_prio(irq, ipd != &ipipe_root);
}

But there is missing  set_irq_prio for the port->irq_high.
to add
                 if (port->irq_high > 0)
                     set_irq_prio(port->irq_high, 1);
is not my problem.

my problem is, that i don't known if  __ipipe_irqbits is handled correct.

regards
   Johann



