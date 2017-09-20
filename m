Date: Wed, 20 Sep 2017 11:33:29 +0200
From: Gwenhael Goavec-Merou <gwenj@trabucayre.com>
Message-ID: <20170920113329.3d58bcf3@x230.trabucayre.com>
In-Reply-To: <d87682ff-2b35-fb67-2171-a5b5bb91aaa6@xenomai.org>
References: <20170920104047.52e779c4@x230.trabucayre.com>
 <d87682ff-2b35-fb67-2171-a5b5bb91aaa6@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] gpio irq problem on Zynq
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On Wed, 20 Sep 2017 11:07:33 +0200
Philippe Gerum <rpm@xenomai.org> wrote:

> On 09/20/2017 10:40 AM, Gwenhael Goavec-Merou wrote:
> > Hi,
> > 
> > I use a Zynq with the latest Xenomai/Ipipe version and I've
> > problems> when using GPIO interrupts. Currently, my tests are only
> > problems> in the Linux domain.
> > 
> > 1/ When using gpiolib the system freeze after gpio's configuration
> > through /sys/class/gpio/xxx . I suspect the corresponding IRQ
> > not masked or not acquitted.
> > 2/ With a driver the ISR is never called but the system is not
> > freezed.
> > 
> > I've looked on gpio-zynq.c but I've no idea about the reason why the
> > system has these wrong behaviour.
> > 
> > Thank you for all comment/advises about my issue.
> >   
> 
> Assuming kernel 4.9.x, maybe this helps:
Yes, sorry it's a 4.9.38
> 
> diff --git a/drivers/gpio/gpio-zynq.c b/drivers/gpio/gpio-zynq.c
> index 1675284..47c1a9a 100644
> --- a/drivers/gpio/gpio-zynq.c
> +++ b/drivers/gpio/gpio-zynq.c
> @@ -503,10 +503,12 @@ static void zynq_gpio_hold_irq(struct irq_data
> *irq_data) 
>  	device_pin_num = irq_data->hwirq;
>  	zynq_gpio_get_bank_pin(device_pin_num, &bank_num,
> &bank_pin_num, gpio);
> +	raw_spin_lock(&zynq_gpio_lock);
>  	writel_relaxed(BIT(bank_pin_num),
>  		       gpio->base_addr +
> ZYNQ_GPIO_INTDIS_OFFSET(bank_num)); writel_relaxed(BIT(bank_pin_num),
>  		       gpio->base_addr +
> ZYNQ_GPIO_INTSTS_OFFSET(bank_num));
> +	raw_spin_unlock(&zynq_gpio_lock);
>  }
>  
>  static void zynq_gpio_release_irq(struct irq_data *irq_data)
> @@ -570,7 +572,7 @@ static void zynq_gpio_handle_bank_irq(struct
> zynq_gpio *gpio, unsigned int gpio_irq;
>  
>  		gpio_irq = irq_find_mapping(irqdomain, offset +
> bank_offset);
> -		generic_handle_irq(gpio_irq);
> +		ipipe_handle_demuxed_irq(gpio_irq);
>  	}
>  }
> -- 
> Philippe.
This modification fix my issue.

Thanks

Gwenhael

