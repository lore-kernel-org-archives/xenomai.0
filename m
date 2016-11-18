References: <cb8e640f-bb94-2870-1fb6-e73f1f728560@sigmatek.at>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <d72bb593-549e-f51b-8dc6-bb217561b43e@xenomai.org>
Date: Fri, 18 Nov 2016 19:06:42 +0100
MIME-Version: 1.0
In-Reply-To: <cb8e640f-bb94-2870-1fb6-e73f1f728560@sigmatek.at>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] i.mx6 gpio_set_value correct locking
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: johann.obermayr@sigmatek.at, xenomai@xenomai.org

On 11/16/2016 01:06 PM, Johann Obermayr wrote:
> Hello,
> 
> Is it allowed/save to call the function "gpio_set_value" from a primary
> domain task ?
> 
> This is the function called from gpio_set_value.
> 
> static void mxc_gpio_set(struct gpio_chip *chip, unsigned offset, int
> value)
> {
>     struct mxc_gpio_port *port =
>         container_of(chip, struct mxc_gpio_port, chip);
>     void __iomem *reg = port->base + GPIO_DR;
>     u32 l;
>     unsigned long flags;
> 
>     spin_lock_irqsave(&port->lock, flags);
>     l = (__raw_readl(reg) & (~(1 << offset))) | (!!value << offset);
>     __raw_writel(l, reg);
>     spin_unlock_irqrestore(&port->lock, flags);
> }
> 
> and port->lock is a ipipe_spinlock_t
> 

Looks ok.

-- 
Philippe.

