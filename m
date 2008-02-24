Message-ID: <47C18933.2040906@domain.hid>
Date: Sun, 24 Feb 2008 16:11:47 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <47C16C8E.8020700@domain.hid>
In-Reply-To: <47C16C8E.8020700@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] BF537-Stamp pushbutton interrupts
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Andras Garzo <garzoand@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Andras Garzo wrote:
> Hi all,
> 
> I'm trying to handle the BF537-STAMP pushbutton interrupts with rtdm, but
> my system hangs when calling rtdm_irq_request with the following message:
> 
> BUG: failure at arch/blackfin/kernel/bfin_gpio.c:504/set_gpio_maska()!
> Kernel panic - not syncing: BUG!
> 
> I'm using linux kernel 2.6.22 and Xenomai 2.4.1. It could be a kernel bug?
> The following code worked well on 2.6.19 with Xenomai 2.3.2:
> 
> #include <linux/list.h>
> #include <linux/init.h>
> #include <linux/types.h>
> #include <linux/interrupt.h>
> #include <linux/module.h>
> #include <linux/fs.h>
> #include <linux/kernel.h>
> #include <linux/time.h>
> #include <asm/irq.h>
> #include <rtdm/rtdm.h>
> #include <rtdm/rtdm_driver.h>
> 
> #define PPSMOD_IRQ IRQ_PF4
> 
> 
> struct ppsmod_dev
> {
>     unsigned int irqnum;
> };
> 
> rtdm_irq_t irq_handle;
> 
> static int ppsmod_irqhandler(rtdm_irq_t *handle)
> {
>     printk(KERN_WARNING "ppsmod: PPS interrupt triggered.\n");
>     return IRQ_HANDLED;
> }
> 
> static int __init ppsmod_init(void)
> {
>     int alloc_size = sizeof(struct ppsmod_dev);
>     struct ppsmod_dev *dev = (struct ppsmod_dev*)kmalloc(alloc_size, 
> GFP_KERNEL);
>     int ret;
>    
>     printk(KERN_WARNING "ppsmod: module loaded.\n");
>    
>     // installing IRQ handler
>     if(rtdm_irq_request(&irq_handle, PPSMOD_IRQ, &ppsmod_irqhandler, 
> RTDM_IRQTYPE_EDGE, NULL, dev))
>     {
>         printk(KERN_WARNING "ppsmod: PF4 irq is not free.\n");
>         return -EBUSY;
>     }
>     printk(KERN_WARNING "ppsmod: 23231\n");
>     set_irq_type(IRQ_PF4, IRQF_TRIGGER_RISING);

Try setting the irq type before calling rtdm_irq_request().

>     rtdm_irq_enable(&irq_handle);
>     printk(KERN_WARNING "ppsmod: PF4 interrupt handler installed.\n");
>    
> 
>     return 0;
> }
> 
> void __exit ppsmod_exit(void)
> {
>     rtdm_irq_free(&irq_handle);
>     printk(KERN_WARNING "ppsmod: module unloaded.\n");
> }
> 
> module_init(ppsmod_init);
> module_exit(ppsmod_exit);
> 
> Thanks,
> Andras
> 
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 


-- 
Philippe.

