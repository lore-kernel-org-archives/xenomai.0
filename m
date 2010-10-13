From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <20101013092617.GB6902@domain.hid>
References: <20101007115728.GA24500@domain.hid>
	<4CADBDC2.8080600@domain.hid> <20101008070148.GB2255@domain.hid>
	<1286530884.13186.109.camel@domain.hid>
	<20101013090353.GA6902@domain.hid>
	<1286961375.1759.71.camel@domain.hid>
	<20101013092617.GB6902@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 13 Oct 2010 16:52:01 +0200
Message-ID: <1286981521.1759.83.camel@domain.hid>
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
To: Pavel Machek <pma@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

On Wed, 2010-10-13 at 11:26 +0200, Pavel Machek wrote:
> Hi!
> 
> > > Thanks!
> > > 
> > > I hope I applied the patch correctly, it was slightly
> > > tricky... Unfortunately, it causes hang at first attempt to kill
> > > realtime task :-(.
> > 
> > Ah. Weird. The IRQ drain code is supposed to be called only when an
> > interrupt is unregistered from the Xenomai layer, which is not directly
> > related to killing a task. Maybe some of the task cleanup code involves
> > unregistering IRQs though, so this might explain.
> 
> Task cleanup definitely unregisters IRQ, yes.
> 
> > > > +void ipipe_drain_interrupt(struct ipipe_domain *ipd, unsigned int irq)
> > > > +{
> > > > +	struct ipipe_percpu_domain_data *p;
> > > > +	unsigned long flags;
> > > > +	int cpu;
> > > > +
> > > > +	flags = ipipe_critical_enter(NULL);
> > > > +	clear_bit(IPIPE_HANDLE_FLAG, &ipd->irqs[irq].control);
> > > > +	clear_bit(IPIPE_STICKY_FLAG, &ipd->irqs[irq].control);
> > > > +	set_bit(IPIPE_PASS_FLAG, &ipd->irqs[irq].control);
> > > > +	ipipe_critical_exit(flags);
> > > > +
> > > > +	for_each_online_cpu(cpu) {
> > > > +		local_irq_save_hw(flags);
> > > > +		p = ipipe_percpudom_ptr(ipd, cpu);
> > > > +		do {
> > > > +			local_irq_restore_hw(flags);
> > > > +			cpu_relax();
> > > > +			local_irq_save_hw(flags);
> > > > +		} while (test_bit(irq, p->irqpend_lomask) ||
> > > > +			 test_bit(IPIPE_STALL_FLAG, &p->status));
> > > > +		local_irq_restore_hw(flags);
> > > > +	}
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(ipipe_drain_interrupt);
> > > > +
> > > 
> > > This is the interesting place, right?
> > 
> > Yes. I messed up. We need the test on the STALL bit to make 100% sure
> > that we are not about clearing the function pointer under the feet of
> > the wired IRQ dispatcher, but at the same time, we enter the drain
> > routine with the STALL bit set for the target domain. So this code is
> > plain silly (patent not granted, way too much prior art).
> 
> :-).
> 
> > As a quick check, you could try removing the second test_bit from the
> > end loop condition.
> 
> Yes, with IPIPE_STALL_FLAG test removed it "works", but I assume that
> at that point it is placebo patch ;-).

Basically, yes, since we have problems with wired IRQs, so...

> 
> Should we test IPIPE_STALL_FLAG on all but current CPUs?

That would solve this particular issue, but we should drain the pipeline
out of any Xenomai critical section. The way it is done now may induce a
deadlock (e.g. CPU0 waiting for CPU1 to acknowledge critical entry in
ipipe_enter_critical when getting some IPI, and CPU1 waiting hw IRQs off
for CPU0 to release the Xenomai lock that annoys us right now).

I'll come up with something hopefully better and tested in the next
days.

-- 
Philippe.



