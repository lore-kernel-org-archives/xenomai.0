From: Johann Obermayr <johann.obermayr@sigmatek.at>
Message-ID: <cb8e640f-bb94-2870-1fb6-e73f1f728560@sigmatek.at>
Date: Wed, 16 Nov 2016 13:06:27 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] i.mx6 gpio_set_value correct locking
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

Is it allowed/save to call the function "gpio_set_value" from a primary 
domain task ?

This is the function called from gpio_set_value.

static void mxc_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
{
     struct mxc_gpio_port *port =
         container_of(chip, struct mxc_gpio_port, chip);
     void __iomem *reg = port->base + GPIO_DR;
     u32 l;
     unsigned long flags;

     spin_lock_irqsave(&port->lock, flags);
     l = (__raw_readl(reg) & (~(1 << offset))) | (!!value << offset);
     __raw_writel(l, reg);
     spin_unlock_irqrestore(&port->lock, flags);
}

and port->lock is a ipipe_spinlock_t

Thanks
   Regards
     Johann Obermayr

