Message-ID: <4FD1A689.8050107@xenomai.org>
Date: Fri, 08 Jun 2012 09:15:21 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <623784B6C75D274389918D358E89E8BB0B7FF136@OPTELIAN5.optelian.local>
In-Reply-To: <623784B6C75D274389918D358E89E8BB0B7FF136@OPTELIAN5.optelian.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] GPIO irq handler on powerpc.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Chris Stone <chris.stone@optelian.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 06/07/2012 11:16 PM, Chris Stone wrote:
> I am using Xenomai 2.6.0 on kernel 3.0.13, with adeos-ipipe-3.0.13-powerpc-2.13-06 applied. My target CPU 
> is Freescale MPC8378.
> 
> On a powerpc, GPIO's are mapped to virtual irqs. Thus, in order to install an irq handler for a gpio 
> interrupt, one must do the following in the kernel:
> 
> 	err = gpio_request(HYPHY_IRQ_GPIO, NULL);
> 	if (err<0) {
> 		printk(KERN_ERR "%s: could not request gpio %d, rc %d\n", __func__, HYPHY_IRQ_GPIO, err);
> 		return err;
> 	}
> 	err = gpio_direction_input(HYPHY_IRQ_GPIO);
> 	if (err<0) {
> 		printk(KERN_ERR "%s: could not set gpio %d to input, rc %d\n", __func__, HYPHY_IRQ_GPIO, err);
> 		return err;
> 	}
> 
> 	virq = __gpio_to_irq(HYPHY_IRQ_GPIO);
> 	if (virq < 0) {
> 		printk(KERN_ERR "%s: could not map gpio %d to virq \n", __func__, HYPHY_IRQ_GPIO);
> 		return virq;
> 	}
>       err = request_irq(virq, hyphy20G_irq, 0, hyphy20G_dev.name, &hyphy20G_dev);
> 
> In other words, you install the irq handler on the virtual irq number returned from __gpio_to_irq. The above 
> code works in my system, i.e., the hyphy20G_irq handler is called on an interrupt.
> 
> However, if I use:
> 
> err = rt_intr_create(intrObj, "HyPhyIRQ", virq, hyphy20G_irq, NULL, 0);
> rt_intr_enable(intrObj);
> 
> then the hyphy20G_irq handler is not called on an interrupt. 

This is a bug.

> I realize that interrupt handlers are 
> recommended to be implemented in user space, but a user space implementation does not work either, 

Definitely not. Interrupts handlers in user-space are not recommended.
At all.

> so I moved into the kernel to see if I could get something to work.
> 
> Is it possible to install an Xenomai ISR on a powerpc virtual irq? 

Normally it should be. If the GPIO interrupts are multiplexed (several
GPIOs on the same parent irq), you should look for the parent irq
handler and see that:
- its code is safe to be called from xenomai domain
- it calls ipipe_handle_chained_irq for the individual demultiplexed
gpio interrupts instead of generic_handle_irq

Note that a bug in multiplexed GPIO interrupts has been fixed very
recently. You may want to upgrade to the I-pipe core for linux 3.2,
currently only available as a git repository:

git://git.denx.de/ipipe.git branch core-3.2

Which also requires xenomai sources from the git repository:

git://git.xenomai.org/xenomai-2.6.git branch master

-- 
                                                                Gilles.

