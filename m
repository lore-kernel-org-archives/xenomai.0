Date: Wed, 23 Mar 2016 12:12:34 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160323111234.GB22286@hermes.click-hack.org>
References: <56EBDBCE.3030800@sigmatek.at>
 <20160318111030.GE6555@hermes.click-hack.org>
 <56EBF155.6010006@sigmatek.at>
 <20160318122826.GA3345@hermes.click-hack.org>
 <56F2776D.7060800@sigmatek.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56F2776D.7060800@sigmatek.at>
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

On Wed, Mar 23, 2016 at 12:01:01PM +0100, Johann Obermayr wrote:
> Am 18.03.2016 um 13:28 schrieb Gilles Chanteperdrix:
> > On Fri, Mar 18, 2016 at 01:15:17PM +0100, Johann Obermayr wrote:
> >> Am 18.03.2016 um 12:10 schrieb Gilles Chanteperdrix:
> >>> On Fri, Mar 18, 2016 at 11:43:26AM +0100, Johann Obermayr wrote:
> >>>> Hello,
> >>>>
> >>>> in the the git branch ipipe-3.0-imx6q
> >>> This I-pipe patch is really old now. Any chance to use a current
> >>> version of Xenomai?
> >> Not now. but we have started to change to 3.10.x with newer xenomai
> >>>> in the file arch/arm/plat-mxc/gpio.c
> >>>>
> >>>> there is follow function.
> >>>>
> >>>> void __ipipe_mach_enable_irqdesc(struct ipipe_domain *ipd, unsigned irq)
> >>>> {
> >>>>        struct irq_desc *desc = irq_to_desc(irq);
> >>>>        struct irq_data *idata = irq_desc_get_irq_data(desc);
> >>>>        struct irq_chip *chip = irq_data_get_irq_chip(idata);
> >>>>
> >>>>        if (chip == &gpio_irq_chip) {
> >>>>            /* It is a gpio. */
> >>>>            u32 gpio = irq_to_gpio(irq);
> >>>>            struct mxc_gpio_port *port = &mxc_gpio_ports[gpio / 32];
> >>>>
> >>>>            if (ipd != &ipipe_root) {
> >>>>                port->nonroot_gpios |= (1 << (gpio % 32));
> >>>>                if (port->nonroot_gpios == (1 << (gpio % 32))) {
> >>>>                    __ipipe_irqbits[(port->irq / 32)]
> >>>>                        &= ~(1 << (port->irq % 32));
> >>>>                    set_irq_prio(port->irq, 1);
> >>>>                }
> >>>>            }
> >>>>        } else
> >>>>            set_irq_prio(irq, ipd != &ipipe_root);
> >>>> }
> >>>>
> >>>> But there is missing  set_irq_prio for the port->irq_high.
> >>>> to add
> >>>>                    if (port->irq_high > 0)
> >>>>                        set_irq_prio(port->irq_high, 1);
> >>>> is not my problem.
> >>>>
> >>>> my problem is, that i don't known if  __ipipe_irqbits is handled
> >>>> correct.
> >>> Well, if you want to set port->irq_high, you have to clear the
> >>> corresponding bit in __ipipe_irqbits, as is done for port->irq.
> >>>
> >> Thank you Gilles.
> >>
> >> i've also take a part from newer version.
> >> void __ipipe_mach_enable_irqdesc(struct ipipe_domain *ipd, unsigned irq)
> >> {
> >>       struct irq_desc *desc = irq_to_desc(irq);
> >>       struct irq_data *idata = irq_desc_get_irq_data(desc);
> >>       struct irq_chip *chip = irq_data_get_irq_chip(idata);
> >>
> >>       if (chip == &gpio_irq_chip) {
> >>           /* It is a gpio. */
> >>           u32 gpio = irq_to_gpio(irq);
> >>           struct mxc_gpio_port *port = &mxc_gpio_ports[gpio / 32];
> >>
> >>           if (ipd == &ipipe_root) {
> >>               port->nonroot_gpios &= ~(1 << (gpio % 32));
> >>               if (port->nonroot_gpios == 0) {
> >>                   __ipipe_irqbits[(port->irq / 32)] &= ~(1 << (port->irq
> >> % 32));
> >>                   __ipipe_irqbits[(port->irq_high / 32)] &= ~(1 <<
> >> (port->irq_high % 32));
> >>                   set_irq_prio(port->irq, 0);
> >>                   if (port->irq_high > 0)
> >>                       set_irq_prio(port->irq_high, 0);
> >>               }
> >>           } else {
> >>               port->nonroot_gpios |= (1 << (gpio % 32));
> >>               if (port->nonroot_gpios == (1 << (gpio % 32))) {
> >>                   __ipipe_irqbits[(port->irq / 32)] &= ~(1 << (port->irq
> >> % 32));
> >>                   __ipipe_irqbits[(port->irq_high / 32)] &= ~(1 <<
> >> (port->irq_high % 32));
> >>                   set_irq_prio(port->irq, 1);
> >>                   if (port->irq_high > 0)
> >>                       set_irq_prio(port->irq_high, 1);
> >>               }
> >>           }
> >>       } else
> >>           set_irq_prio(irq, ipd != &ipipe_root);
> >> }
> >>
> >> is this correct to clear the the bit in __ipipe_irqbits also for ipd ==
> >> ipipe_root ?
> > It is useless, __ipipe_mach_enable_irqdesc for root irqs is called
> > only once at boot time, when the bits are already cleared.
> >
> Here are my patches for imx.6 gpio irq handling.
> also add patch for using edge select bit (irq raise/fall detection) on 
> imx.6
> 
> Regards
>     Johann
> 
> -------------- next part --------------
> From b806dcf59ec3cf1abc18318cce090b78e396dec6 Mon Sep 17 00:00:00 2001
> From: Johann Obermayr <johann.obermayr@sigmatek.at>
> Date: Fri, 18 Mar 2016 16:04:38 +0100
> Subject: [PATCH] high irq for GPIO input not working.
> 
> ---
>  arch/arm/plat-mxc/gpio.c |   14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/plat-mxc/gpio.c b/arch/arm/plat-mxc/gpio.c
> index 87b643e..3f5925a 100755
> --- a/arch/arm/plat-mxc/gpio.c
> +++ b/arch/arm/plat-mxc/gpio.c
> @@ -426,9 +426,12 @@ void __ipipe_mach_enable_irqdesc(struct ipipe_domain *ipd, unsigned irq)
>  		if (ipd != &ipipe_root) {
>  			port->nonroot_gpios |= (1 << (gpio % 32));
>  			if (port->nonroot_gpios == (1 << (gpio % 32))) {
> -				__ipipe_irqbits[(port->irq / 32)]
> -					&= ~(1 << (port->irq % 32));
> +				__ipipe_irqbits[(port->irq / 32)] &= ~(1 << (port->irq % 32));
>  				set_irq_prio(port->irq, 1);
> +				if (port->irq_high > 0) {
> +					__ipipe_irqbits[(port->irq_high / 32)] &= ~(1 << (port->irq_high % 32));
> +					set_irq_prio(port->irq_high, 1);
> +				}
>  			}
>  		}
>  	} else
> @@ -450,8 +453,11 @@ void __ipipe_mach_disable_irqdesc(struct ipipe_domain *ipd, unsigned irq)
>  			port->nonroot_gpios &= ~(1 << (gpio % 32));
>  			if (!port->nonroot_gpios) {
>  				set_irq_prio(port->irq, 0);
> -				__ipipe_irqbits[(port->irq / 32)]
> -					|= (1 << (port->irq % 32));
> +				__ipipe_irqbits[(port->irq / 32)] |= (1 << (port->irq % 32));
> +				if (port->irq_high > 0) {
> +					set_irq_prio(port->irq_high, 0);
> +					__ipipe_irqbits[(port->irq_high / 32)] |= (1 << (port->irq_high % 32));
> +				}
>  			}
>  		}
>  	} else if (ipd != &ipipe_root)
> -- 
> 1.7.9.5

I am fine with this patch. Will merge it in recent kernels if
possible.

> 
> -------------- next part --------------
> From 962417f6870aec76188f391a708fc05d54f6d94c Mon Sep 17 00:00:00 2001
> From: Johann Obermayr <johann.obermayr@sigmatek.at>
> Date: Mon, 21 Mar 2016 17:14:18 +0100
> Subject: [PATCH] use edge select bit to activate raise/fall irq detection.
> 
> ---
>  arch/arm/plat-mxc/gpio.c |   51 ++++++++++++++++++++++++++++++++--------------
>  1 file changed, 36 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm/plat-mxc/gpio.c b/arch/arm/plat-mxc/gpio.c
> index 3f5925a..c1caa6b 100755
> --- a/arch/arm/plat-mxc/gpio.c
> +++ b/arch/arm/plat-mxc/gpio.c
> @@ -31,6 +31,7 @@
>  
>  static struct mxc_gpio_port *mxc_gpio_ports;
>  static int gpio_table_size;
> +static int GPIO_EDGE_SEL = -1;

All capital names are reserved to macros.

I am fine with this patch patch though I do not understand why it is
needed, if Linux is able to detect both edges so should Xenomai with
the same code. Also, if the patch is for the 3.0-imx6q branch, this
branch has been abandoned a long time ago. The 3.0 kernel has been
EOL for a long time now (last release dates back from october 2013).
So, I do not plan to issue any new patches for this kernel.

-- 
					    Gilles.
https://click-hack.org

