References: <1457983382.28082.11.camel@henry-ThinkCentre-M93p>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <56E71CC1.5070600@xenomai.org>
Date: Mon, 14 Mar 2016 21:19:13 +0100
MIME-Version: 1.0
In-Reply-To: <1457983382.28082.11.camel@henry-ThinkCentre-M93p>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Reentrant Interrupts on Freescale LS1021A
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henry Bausley <hbausley@deltatau.com>, xenomai@xenomai.org

On 03/14/2016 08:23 PM, Henry Bausley wrote:
> 
> For many years we have had a reentrant interrupt routine that has run on
> our single core AMCC460EX for ~7-8yrs.  We received instructions on how
> to do this many years ago.  See the link below
> 
> 
> https://www.mail-archive.com/search?l=xenomai-help@gna.org&q=subject:%
> 22Re%5C%3A+%5C%5BXenomai%5C-help%5C%5D+Recurring+Interrupts%
> 22&o=newest&f=1
> 
> We have now changed to a Freescale dual core LS1021A ARM CPU.  It now
> hangs on the LS1021A ARM.  Is there anyway we can support reentrant
> interrupts on the LS1021A design?
> 
> We currently do this as we were instructed:
> 
> int your_isr(xnintr_t *intr)
> {
> unsigned long flags;
> 
> xnlock_clear_irqon(nklock);
> 
> ... your code ...
> 
> xnlock_get_irqsave(nklock, flags); /* must re-lock on exit */
> }
> 
> We are using xenomai-2.6.4 w/ linux 3.14.28
> 
> Any help would be greatly appreciated.
> 

There is a per-IRQ lock since 2.3, so you should drop the code fiddling
with the superlock, it's not locked on entry, and locking it on exit
causes the hang.

You could try:

your_isr()
{
	hard_local_irq_enable();
	your code;
	hard_local_irq_disable();
}

That should be SMP-safe on your dual core board provided you don't
re-enable the IRQ line in the GIC for the ongoing IRQ in your handler,
of course. IOW, you won't be able to nest invocations of the same IRQ
handler using that hack, but only allow other IRQs to preempt your
handler. Hopefully this is what you are aiming at.

Btw, unless you changed the interrupt distributor settings for the
onboard GIC, CPU0 should take all IRQs anyway.

PS: re-enabling IRQs in a Xenomai interrupt context is undocumented, and
not officially supported. This is living on the edge, but I guess you
already know it.

-- 
Philippe.

