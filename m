Message-ID: <1458666633.2713.2.camel@henry-ThinkCentre-M93p>
From: Henry Bausley <hbausley@deltatau.com>
Date: Tue, 22 Mar 2016 10:10:33 -0700
In-Reply-To: <1458260422.4930.2.camel@henry-ThinkCentre-M93p>
References: <1457983382.28082.11.camel@henry-ThinkCentre-M93p>
 <56E71CC1.5070600@xenomai.org>
 <1457990656.28082.20.camel@henry-ThinkCentre-M93p>
 <56E90784.7080702@xenomai.org>
 <1458260422.4930.2.camel@henry-ThinkCentre-M93p>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
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
To: xenomai@xenomai.org


On Thu, 2016-03-17 at 17:20 -0700, Henry Bausley wrote:
> On Wed, 2016-03-16 at 08:13 +0100, Philippe Gerum wrote:
> >  Content preview:  On 03/14/2016 10:24 PM, Henry Bausley wrote: > On Mon, 2016-03-14
> >     at 21:19 +0100, Philippe Gerum wrote: >> Content preview: On 03/14/2016 08:23
> >     PM, Henry Bausley wrote: > > For many >> years we have had a reentrant interrupt
> >     routine that has run on > our single >> core AMCC460EX for ~7-8yrs. We received
> >     instructions on how > to do this >> many years ago. See the link below >
> >    > > https://www.mail-archive.com/search?l=xenomai-help@gna.org&q=subject:%
> >     >> > 22Re%5C%3A+%5C%5BXenomai%5C-help%5C%5D+Recurring+Interrupts% > 22&o=newest&f=1
> >     >> > > We have now changed to a Freescale dual core LS1021A ARM CPU. It now
> >     >> > hangs on the LS1021A ARM. Is there anyway we can support reentrant >
> >     interrupts >> on the LS1021A design? > > We currently do this as we were
> >    instructed: > >> > int your_isr(xnintr_t *intr) > { > unsigned long flags;
> >     > > xnlock_clear_irqon(nklock); >> > > ... your code ... > > xnlock_get_irqsave(nklock,
> >     flags); /* must re-lock >> on exit */ > } > > We are using xenomai-2.6.4
> >    w/ linux 3.14.28 > > Any help >> would be greatly appreciated. > [...] >>
> >    >> Content analysis details: (-1.0 points, 5.0 required) >> >> pts rule name
> >     description >> ---- >> -1.0 ALL_TRUSTED Passed through trusted hosts only
> >     via SMTP >> X-Barracuda-Connect: sd-51317.xenomai.org[62.210.215.82] >> X-Barracuda-Start-Time:
> >     1457986755 >> X-Barracuda-URL: https://76.79.246.10:443/cgi-mod/mark.cgi
> >    >> X-Virus-Scanned: by bsmtpd at deltatau.com >> X-Barracuda-BRTS-Status:
> >    1 >> X-Barracuda-Spam-Score: 0.00 >> X-Barracuda-Spam-Status: No, SCORE=0.00
> >     using global scores of TAG_LEVEL=2.0 QUARANTINE_LEVEL=4.0 KILL_LEVEL=7.0
> >    tests= >> X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.27841
> >     >> Rule breakdown below >> pts rule name description >> ---- >> >> On 03/14/2016
> >     08:23 PM, Henry Bausley wrote: >>> >>> For many years we have had a reentrant
> >     interrupt routine that has run on >>> our single [...] 
> >  
> >  Content analysis details:   (-1.0 points, 5.0 required)
> >  
> >   pts rule name              description
> >  ---- ---------------------- --------------------------------------------------
> >  -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
> >   0.0 IP_LINK_PLUS           URI: Dotted-decimal IP address followed by CGI
> >   0.0 NORMAL_HTTP_TO_IP      URI: URI host has a public dotted-decimal IPv4
> >                              address
> > X-Barracuda-Connect: sd-51317.xenomai.org[62.210.215.82]
> > X-Barracuda-Start-Time: 1458112390
> > X-Barracuda-URL: https://76.79.246.10:443/cgi-mod/mark.cgi
> > X-Virus-Scanned: by bsmtpd at deltatau.com
> > X-Barracuda-BRTS-Status: 1
> > X-Barracuda-Spam-Score: 0.00
> > X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=2.0 QUARANTINE_LEVEL=4.0 KILL_LEVEL=7.0 tests=IP_LINK_PLUS, NORMAL_HTTP_TO_IP
> > X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.27890
> > 	Rule breakdown below
> > 	 pts rule name              description
> > 	---- ---------------------- --------------------------------------------------
> > 	0.00 NORMAL_HTTP_TO_IP      URI: Uses a dotted-decimal IP address in URL
> > 	0.00 IP_LINK_PLUS           URI: Dotted-decimal IP address followed by CGI
> > 
> > On 03/14/2016 10:24 PM, Henry Bausley wrote:
> > > On Mon, 2016-03-14 at 21:19 +0100, Philippe Gerum wrote:
> > >>  Content preview:  On 03/14/2016 08:23 PM, Henry Bausley wrote: > > For many
> > >>    years we have had a reentrant interrupt routine that has run on > our single
> > >>     core AMCC460EX for ~7-8yrs. We received instructions on how > to do this
> > >>    many years ago. See the link below > > > https://www.mail-archive.com/search?l=xenomai-help@gna.org&q=subject:%
> > >>     > 22Re%5C%3A+%5C%5BXenomai%5C-help%5C%5D+Recurring+Interrupts% > 22&o=newest&f=1
> > >>     > > We have now changed to a Freescale dual core LS1021A ARM CPU. It now
> > >>    > hangs on the LS1021A ARM. Is there anyway we can support reentrant > interrupts
> > >>     on the LS1021A design? > > We currently do this as we were instructed: >
> > >>    > int your_isr(xnintr_t *intr) > { > unsigned long flags; > > xnlock_clear_irqon(nklock);
> > >>     > > ... your code ... > > xnlock_get_irqsave(nklock, flags); /* must re-lock
> > >>     on exit */ > } > > We are using xenomai-2.6.4 w/ linux 3.14.28 > > Any help
> > >>     would be greatly appreciated. > [...] 
> > >>  
> > >>  Content analysis details:   (-1.0 points, 5.0 required)
> > >>  
> > >>   pts rule name              description
> > >>  ---- ---------------------- --------------------------------------------------
> > >>  -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
> > >> X-Barracuda-Connect: sd-51317.xenomai.org[62.210.215.82]
> > >> X-Barracuda-Start-Time: 1457986755
> > >> X-Barracuda-URL: https://76.79.246.10:443/cgi-mod/mark.cgi
> > >> X-Virus-Scanned: by bsmtpd at deltatau.com
> > >> X-Barracuda-BRTS-Status: 1
> > >> X-Barracuda-Spam-Score: 0.00
> > >> X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=2.0 QUARANTINE_LEVEL=4.0 KILL_LEVEL=7.0 tests=
> > >> X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.27841
> > >> 	Rule breakdown below
> > >> 	 pts rule name              description
> > >> 	---- ---------------------- --------------------------------------------------
> > >>
> > >> On 03/14/2016 08:23 PM, Henry Bausley wrote:
> > >>>
> > >>> For many years we have had a reentrant interrupt routine that has run on
> > >>> our single core AMCC460EX for ~7-8yrs.  We received instructions on how
> > >>> to do this many years ago.  See the link below
> > >>>
> > >>>
> > >>> https://www.mail-archive.com/search?l=xenomai-help@gna.org&q=subject:%
> > >>> 22Re%5C%3A+%5C%5BXenomai%5C-help%5C%5D+Recurring+Interrupts%
> > >>> 22&o=newest&f=1
> > >>>
> > >>> We have now changed to a Freescale dual core LS1021A ARM CPU.  It now
> > >>> hangs on the LS1021A ARM.  Is there anyway we can support reentrant
> > >>> interrupts on the LS1021A design?
> > >>>
> > >>> We currently do this as we were instructed:
> > >>>
> > >>> int your_isr(xnintr_t *intr)
> > >>> {
> > >>> unsigned long flags;
> > >>>
> > >>> xnlock_clear_irqon(nklock);
> > >>>
> > >>> ... your code ...
> > >>>
> > >>> xnlock_get_irqsave(nklock, flags); /* must re-lock on exit */
> > >>> }
> > >>>
> > >>> We are using xenomai-2.6.4 w/ linux 3.14.28
> > >>>
> > >>> Any help would be greatly appreciated.
> > >>>
> > >>
> > >> There is a per-IRQ lock since 2.3, so you should drop the code fiddling
> > >> with the superlock, it's not locked on entry, and locking it on exit
> > >> causes the hang.
> > >>
> > >> You could try:
> > >>
> > >> your_isr()
> > >> {
> > >> 	hard_local_irq_enable();
> > >> 	your code;
> > >> 	hard_local_irq_disable();
> > >> }
> > >>
> > >> That should be SMP-safe on your dual core board provided you don't
> > >> re-enable the IRQ line in the GIC for the ongoing IRQ in your handler,
> > >> of course. IOW, you won't be able to nest invocations of the same IRQ
> > >> handler using that hack, but only allow other IRQs to preempt your
> > >> handler. Hopefully this is what you are aiming at.
> > >>
> > >> Btw, unless you changed the interrupt distributor settings for the
> > >> onboard GIC, CPU0 should take all IRQs anyway.
> > >>
> > >> PS: re-enabling IRQs in a Xenomai interrupt context is undocumented, and
> > >> not officially supported. This is living on the edge, but I guess you
> > >> already know it.
> > >>
> > > 
> > > We have in deed been nesting invocations of the same IRQ handler and are
> > > trying to do the same.  Is there a different hack we can use to achieve
> > > that?
> > > 
> > > As you indicated calling
> > > hard_local_irq_enable()/hard_local_irq_disable() won't accomplish nested
> > > invocations of the same IRQ handler and our test confirmed that.
> > > 
> > > 
> > 
> > Check xnintr_irq_handler(). You would need to unlock xnirqs[irq].lock
> > prior to calling the handler, issue xnarch_end_irq() for enabling the
> > IRQ line, run the handler, then lock back the per-irq lock right after
> > it has returned.
> > 
> > This can only work with edge IRQs, CONFIG_XENO_OPT_SHIRQ must be off,
> > and this hack would open a race with the code detaching IRQ descriptors,
> > so you need a way to synchronize properly with your IRQ handler before
> > calling xnintr_detach().
> > 
> 
> I think I am following  instructions but still I am not reentering
> the ISR.  CONFIG_XENO_OPT_SHIRQ is not enabled.  Is there something I am
> missing I did the following. 
> 
> static void xnintr_irq_handler(unsigned irq, void *cookie)
> {
> .
> .
> .
>         if (irq == PHASEIRQ)                     
>         {                                            
>           xnlock_put(&xnirqs[PHASEIRQ].lock);
>           xnarch_end_irq(PHASEIRQ);
>         }          
>                     
> 	s = intr->isr(intr);
> 
>         if (irq == PHASEIRQ)
>           xnlock_get(&xnirqs[PHASEIRQ].lock);
> 	if (unlikely(s == XN_ISR_NONE)) {
> .
> .
> .
> 	
> 
> 
> 
> 
> 
> Outbound scan for Spam or Virus by Barracuda at Delta Tau
> 
> 
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai


What we are seeing is if we are in the intr->isr(intr) and another H/W
interrupt occurs it is replayed after the current intr->isr(intr) is
finished.  

What we are trying to accomplish is when a second H/W interrupt occurs
the current intr->isr(intr) is stopped and a second call to
intr->isr(intr) gets processed then when finished the original
intr->isr(intr) .  


Is there a way to accomplish what we are trying to do?



