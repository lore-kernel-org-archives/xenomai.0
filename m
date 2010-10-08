From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1286528239.13186.104.camel@domain.hid>
References: <20101007115728.GA24500@domain.hid>
	<4CADBDC2.8080600@domain.hid>  <20101008070148.GB2255@domain.hid>
	<1286525848.13186.93.camel@domain.hid>
	<4CAED93C.20500@domain.hid>
	<1286528239.13186.104.camel@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 08 Oct 2010 11:00:05 +0200
Message-ID: <1286528405.13186.106.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] kernel oopses when killing realtime task
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Fri, 2010-10-08 at 10:57 +0200, Philippe Gerum wrote:
> On Fri, 2010-10-08 at 10:41 +0200, Jan Kiszka wrote:
> > Am 08.10.2010 10:17, Philippe Gerum wrote:
> > > On Fri, 2010-10-08 at 09:01 +0200, Pavel Machek wrote:
> > >> Hi!
> > >>
> > >>>> I have... quite an interesting setup here.
> > >>>>
> > >>>> SMP machine, with special PCI card; that card has GPIOs and serial
> > >>>> ports. Unfortunately, there's only one interrupt, shared between
> > >>>> serials and GPIO pins, and serials are way too complex to be handled
> > >>>> by realtime layer.
> > >>>>
> > >>>> So I ended up with
> > >>>>
> > >>>>         // we also have an interrupt handler:                                                                                                                 
> > >>>>         ret = rtdm_irq_request(&my_context->irq_handle,
> > >>>>         gpio_rt_config.irq, demo_interrupt,
> > >>>>                                RTDM_IRQTYPE_SHARED,
> > >>>>         context->device->proc_name, my_context);
> > >>>>
> > >>>> and 
> > >>>>
> > >>>> static int demo_interrupt(rtdm_irq_t *irq_context)
> > >>>> {
> > >>>>         struct demodrv_context *ctx;
> > >>>>         int           dev_id;
> > >>>>         int           ret = RTDM_IRQ_HANDLED; // usual return value                                                                                           
> > >>>>         unsigned pending, output;
> > >>>>
> > >>>>         ctx = rtdm_irq_get_arg(irq_context, struct demodrv_context);
> > >>>>         dev_id    = ctx->dev_id;
> > >>>>
> > >>>>         if (!ctx->ready) {
> > >>>>                 printk(KERN_CRIT "Unexpected interrupt\n");
> > >>>>                 return XN_ISR_PROPAGATE;
> > >>>
> > >>> Who sets ready and when? Looks racy.
> > >>
> > >> Debugging aid; yes, this one is racy.
> > >>
> > >>>>         rtdm_lock_put(&ctx->lock);
> > >>>>  
> > >>>>         /* We need to propagate the interrupt, so that PMC-6L serials                                                                                         
> > >>>>            work. Result is that interrupt latencies can't be                                                                                                  
> > >>>>            guaranteed when serials are in use.  */
> > >>>>
> > >>>>          return RTDM_IRQ_HANDLED;
> > >>>> }
> > >>>>
> > >>>> Unregistration is:
> > >>>>         my_context->ready = 0;
> > >>>>         rtdm_irq_disable(&my_context->irq_handle);
> > >>>
> > >>> Where is rtdm_irq_free? Again, this ready flag looks racy.
> > >>
> > >> Aha, sorry, I quoted wrong snippet. rtdm_irq_free() follows
> > >> immediately, like this:
> > >>
> > >> int demo_close_rt(struct rtdm_dev_context   *context,
> > >>                   rtdm_user_info_t          *user_info)
> > >> {
> > >>         struct demodrv_context  *my_context;
> > >>         rtdm_lockctx_t          lock_ctx;
> > >>         // get the context                                                                                                                                    
> > >>         my_context = (struct demodrv_context *)context->dev_private;
> > >>
> > >>         // if we need to do some stuff with preemption disabled:                                                                                              
> > >>         rtdm_lock_get_irqsave(&my_context->lock, lock_ctx);
> > >>
> > >>         my_context->ready = 0;
> > >>         rtdm_irq_disable(&my_context->irq_handle);
> > >>
> > >>
> > >>         // free irq in RTDM                                                                                                                                   
> > >>         rtdm_irq_free(&my_context->irq_handle);
> > >>
> > >>         // destroy our interrupt signal/event                                                                                                                 
> > >>         rtdm_event_destroy(&my_context->irq_event);
> > >>
> > >>         // other stuff here                                                                                                                                   
> > >>         rtdm_lock_put_irqrestore(&my_context->lock, lock_ctx);
> > >>
> > >>         return 0;
> > >> }
> > >>
> > >> Now... I'm aware that lock_get/put around irq_free should be
> > >> unneccessary, as should be irq_disable and my ->ready flag. Those were
> > >> my attempts to work around the problem. I'll attach the full source at
> > >> the end.
> > >>
> > >>>> Unfortunately, when the userspace app is ran and killed repeatedly (so
> > >>>> that interrupt is registered/unregistered all the time), I get
> > >>>> oopses in __ipipe_dispatch_wired() -- it seems to call into the NULL
> > >>>> pointer.
> > >>>>
> > >>>> I decided that "wired" interrupt when the source is shared between
> > >>>> Linux and Xenomai, is wrong thing, so I disable "wired" interrupts
> > >>>> altogether, but that only moved oops to __virq_end. 
> > >>>
> > >>> This is wrong. The only way to get a determistically shared IRQs across
> > >>> domains is via the wired path, either using the pattern Gilles cited or,
> > >>> in a slight variation, signaling down via a separate rtdm_nrtsig.
> > >>
> > >> For now, I'm trying to get it not to oops; deterministic latencies are
> > >> the next topic :-(.
> > > 
> > > The main issue is that we don't lock our IRQ descriptors (the pipeline
> > > ones) when running the handlers, so another CPU clearing them via
> > > ipipe_virtualize_irq() may well sink the boat...
> > > 
> > > The unwritten rule has always been to assume that drivers would stop
> > > _and_ drain interrupts on all CPUs before unregistering handlers, then
> > > exiting the code. Granted, that's a bit much.
> > 
> > IIRC, we drain at nucleus-level if statistic are enabled. I guess we
> > should make this unconditional.
> 
> Draining is currently performed after the descriptor release via
> rthal_irq_release() in this code, and it depends on the stat counters to
> determine whether the IRQ handler is still running on any CPU it seems.
> A saner way would be to define a draining service in the pipeline, and
> have rtdm_irq_free() invoke it early.

s,rtdm_irq_free,xnintr_detach,

> 

-- 
Philippe.



