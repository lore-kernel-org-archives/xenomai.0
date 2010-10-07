Date: Thu, 7 Oct 2010 13:57:28 +0200
From: Pavel Machek <pma@domain.hid>
Message-ID: <20101007115728.GA24500@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Xenomai-help] kernel oopses when killing realtime task
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi!

I have... quite an interesting setup here.

SMP machine, with special PCI card; that card has GPIOs and serial
ports. Unfortunately, there's only one interrupt, shared between
serials and GPIO pins, and serials are way too complex to be handled
by realtime layer.

So I ended up with

        // we also have an interrupt handler:                                                                                                                 
        ret = rtdm_irq_request(&my_context->irq_handle,
        gpio_rt_config.irq, demo_interrupt,
                               RTDM_IRQTYPE_SHARED,
        context->device->proc_name, my_context);

and 

static int demo_interrupt(rtdm_irq_t *irq_context)
{
        struct demodrv_context *ctx;
        int           dev_id;
        int           ret = RTDM_IRQ_HANDLED; // usual return value                                                                                           
        unsigned pending, output;

        ctx = rtdm_irq_get_arg(irq_context, struct demodrv_context);
        dev_id    = ctx->dev_id;

        if (!ctx->ready) {
                printk(KERN_CRIT "Unexpected interrupt\n");
                return XN_ISR_PROPAGATE;
        }               

        rtdm_lock_get(&ctx->lock);

        pending = pgread(GPIO_IRQ_ID);
        pgwrite(0, GPIO_IRQ_ID);
        output = pgread(GPIO_STATUS_OUT);
        output ^= (1<<3);
        pgwrite(output, GPIO_STATUS_OUT);

        // do stuff                                                                                                                                           
        if (events > 1000) {
                rtdm_event_signal(&ctx->irq_event);
                events = 0;
        }
        events++;
        
        rtdm_lock_put(&ctx->lock);
 
        /* We need to propagate the interrupt, so that PMC-6L serials                                                                                         
           work. Result is that interrupt latencies can't be                                                                                                  
           guaranteed when serials are in use.  */

         return RTDM_IRQ_HANDLED;
}

Unregistration is:
        my_context->ready = 0;
        rtdm_irq_disable(&my_context->irq_handle);


Unfortunately, when the userspace app is ran and killed repeatedly (so
that interrupt is registered/unregistered all the time), I get
oopses in __ipipe_dispatch_wired() -- it seems to call into the NULL
pointer.

I decided that "wired" interrupt when the source is shared between
Linux and Xenomai, is wrong thing, so I disable "wired" interrupts
altogether, but that only moved oops to __virq_end. 

I'm using 2.6.27.21-ELinOS-46 with xenomai-2.4.7 . Problem does go
away if I boot with maxcpus=1.

Any ideas? (Besides using non-historic kernel; but that's
unfortunately not exactly easy here.)

								Pavel


