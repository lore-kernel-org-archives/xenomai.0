From: Chris Stone <chris.stone@optelian.com>
Date: Thu, 7 Jun 2012 21:16:09 +0000
Message-ID: <623784B6C75D274389918D358E89E8BB0B7FF136@OPTELIAN5.optelian.local>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] GPIO irq handler on powerpc.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

I am using Xenomai 2.6.0 on kernel 3.0.13, with adeos-ipipe-3.0.13-powerpc-2.13-06 applied. My target CPU 
is Freescale MPC8378.

On a powerpc, GPIO's are mapped to virtual irqs. Thus, in order to install an irq handler for a gpio 
interrupt, one must do the following in the kernel:

	err = gpio_request(HYPHY_IRQ_GPIO, NULL);
	if (err<0) {
		printk(KERN_ERR "%s: could not request gpio %d, rc %d\n", __func__, HYPHY_IRQ_GPIO, err);
		return err;
	}
	err = gpio_direction_input(HYPHY_IRQ_GPIO);
	if (err<0) {
		printk(KERN_ERR "%s: could not set gpio %d to input, rc %d\n", __func__, HYPHY_IRQ_GPIO, err);
		return err;
	}

	virq = __gpio_to_irq(HYPHY_IRQ_GPIO);
	if (virq < 0) {
		printk(KERN_ERR "%s: could not map gpio %d to virq \n", __func__, HYPHY_IRQ_GPIO);
		return virq;
	}
      err = request_irq(virq, hyphy20G_irq, 0, hyphy20G_dev.name, &hyphy20G_dev);

In other words, you install the irq handler on the virtual irq number returned from __gpio_to_irq. The above 
code works in my system, i.e., the hyphy20G_irq handler is called on an interrupt.

However, if I use:

err = rt_intr_create(intrObj, "HyPhyIRQ", virq, hyphy20G_irq, NULL, 0);
rt_intr_enable(intrObj);

then the hyphy20G_irq handler is not called on an interrupt. I realize that interrupt handlers are 
recommended to be implemented in user space, but a user space implementation does not work either, 
so I moved into the kernel to see if I could get something to work.

Is it possible to install an Xenomai ISR on a powerpc virtual irq? 

I have attached the full driver code.

Chris Stone
Embedded Linux Architect
Optelian
1 Brewer Hunt Way
Ottawa, Ontario K2K 2B5

Phone: 613-287-2000 x2106

www.optelian.com

-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: hyphypcie.c
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20120607/b899a195/attachment.c>
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: hyphypcie.h
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20120607/b899a195/attachment.h>
