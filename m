Subject: Re: [Adeos-main] interrupt latency
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <200402231906.13627.roloff@domain.hid>
References: <200402230035.16494.roloff@domain.hid>
	<200402230322.13218.roloff@domain.hid>
	<1077526102.637.36.camel@domain.hid>
	<200402231906.13627.roloff@domain.hid>
Content-Type: text/plain
Message-Id: <1077566019.646.50.camel@domain.hid>
Mime-Version: 1.0
Date: Mon, 23 Feb 2004 20:53:40 +0100
Content-Transfer-Encoding: 7bit
List-Id: <adeos-main.nongnu.org>
List-Unsubscribe: <http://mail.nongnu.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <http://mail.gnu.org/pipermail/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <http://mail.nongnu.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Dirk Roloff <roloff@domain.hid>
Cc: adeos-main@gna.org

Hi Dirk,

On Mon, 2004-02-23 at 19:06, Dirk Roloff wrote:
> Philippe :
> the last question was the best ....
> 
> > Btw: which Adeos version are you using?
> 
> 2.4r10/x86 on a 2.4.24 fresh kernel fom kernel.org.
> It was part of the RTAI - i will check the cvs entry ... ops ...
> after writing this mail i had a look at cvs ... is see r11 is out and there is a new 
> IPIPE_SHARED_MASK - i will have a closer look at this now ....
> 

Ok. However, r11 behaves exactely the same way than r10 for the part we
are talking of (most of the work between r10 and the current r11
candidates is SMP-related). Shared IRQs might not be what you need here
(i.e. you don't have to share a single IRQ line shared by several
devices handled by different Adeos domains).

> > >
> > > Now a second IRQ 4 will be delivert to the linux handler.
> >
> > That's normal. Either set IPIPE_PASS_MASK if you want Adeos to propagate
> > the incoming IRQ unconditionally, _or_ don't set it if you want your
> > handler to decide dynamically of whether the propagation should take
> > place or not on a per-IRQ basis using adeos_propagate_irq().
> 
> Ok - so set PASS_MASK or use adeos_propagate_irq() should do the same.
> But this looks like i miss on IRQ 4 without propagate. I will check this once again.
> 

Ack.

> >
> > > Only one IRQ 1 to the realtime (its masked out in PIC  when entering the
> > > realtime)
> >
> > That's ok too. By default on the x86 port, IRQs are mask & acked upon
> > receipt before the IRQ flows down the pipeline, except the 8254 timer
> > which is only acked.
> >
> > > Could it be that this will block all other IRQ at PIC level ?
> >
> > Here are the typical actions taken upon IRQ receipt with a single
> > prioritary domain running above Linux in the pipeline:
> >
> hw IRQ 4 =>
>     [Adeos primary handler]
>         => mask and ack (from now, IRQ is masked at 8259 level)
>         => pipeline walk (all pending IRQs)
>             => realtime_handler(irq)
>                  [Your processing]
>                  adeos_propagate_irq(irq) ( ok dont need have IPIPE_PASS_MASK set)
> 
>             => [Linux's do_IRQ(irq)]
>                 => start Linux handler()
> 
>                     ** interupted by hw IRQ 1 =>
> 
>                         [Adeos primary handler]
>                             => mask and ack (from now, IRQ 4 and 1 is masked at 8259 level)
>                             => pipeline walk (all pending IRQs)
>                                 => realtime_handler(irq)
>                                      [Your processing]
>                                 => !!!!  should leave the pipe because linux stalls it right ?

Yes. But still, keep in mind that the IRQ syncer (__adeos_sync_stage())
can be re-entered safely by an IRQ. This is needed because some Linux
IRQ drivers (namely the PC keyboard one using IRQ #1) sit in a busy loop
waiting for subsequent interrupts on behalf of their own interrupt
handler...

>                                      !!!!  IRQ 1 is marked out so no other IRQ 1 will be delivered by pic
>                                      !!!!  shouldnt adeos unmask it ??
> 

Adeos does not re-enable the IRQ line at PIC level because this could
not be the right thing to do under some circumstances: i.e.
level-triggered IRQs. In such a case, re-enabling the IRQs too early may
result in a flood of interrupts until the recipient domain shuts the
source. So the decision to re-enable the IRQ "physically" is left to the
domains, and if no non-Linux domain did it, at least the Linux one does
this by calling the end() method of the interrupt descriptor as usual,
at the end of do_IRQ().

Therefore re-enabling all the interrupt sources in your domain handler
may not be an option. It all depends on the domain logic wrt to the
managed device. The crash you experienced while re-enabling all IRQs
might be related to this fact.

>                     ** another interupt by hw IRQ 12 (not masked) =>
>                         !!!!  Here it looks like adeos [Adeos primary handler] will not entered - why ?
>                         !!!!  no realtime_handler(irq) calls are counted
> 

I'd bet that Adeos primary handler is actually entered, but your domain
might be stalled, so no interrupt could be delivered to it.

>                     ** another interupt by hw IRQ 4 again  (is masked so will be hold by PIC) =>
> 
>                 => end of Linux handler()
>                 => end_irq() (which re-enables the IRQ 4 line at the 8259 level)
> 	    => back in pipeline walk - maybe the second IRQ 4 was delivered to 
> 
> 
> So if i undertud this right - adeos dose not take control over the PIC enable/disable funktion in a per domain manner.
> So until linux reenable an interrupt its be disabled for other high prio domains.
> i just implented a short hack - catch all irqs in realtime and enable them on pic level in there.
> Ok i i need a hard reset to bring the system back - I think that dosent work, because linux could not 
> handle another irq while in the handler.
> So what do you think about a per domain bitmask that will mirror the pic IMR.
> 
> in mask_and_ack_8259A() delete 
> outb(cached_A1,0xA1); 
> and 
> outb(cached_21,0x21);
> so it dose not mask the IRQ

> in __adeos_sync_stage
> check and set the mask bit just before calling irq_handler and after this clears it.
> This should save us to do not call the same irq handler twice for the same IRQ.
> 
> Mhhh ... what about SMP ... maybe the mask should be a per domain per cpu field.
> 
> Let me know what you think about this.
> 

There is a mechanism implemented in Adeos that actually handles the
enable/disable IRQ ops on a per-domain basis. I've posted some
information about this to the RTAI mailing list once, maybe you want to
have a look at it, so we can further discuss this stuff:
https://mail.rtai.org/pipermail/rtai/2003-November/005623.html

> >
> > If you want to re-enable the IRQ line earlier in the process (i.e.
> > before Linux's regular handler is run), then you can do this by calling
> > adeos_control_irq(irq,0,IPIPE_ENABLE_MASK) in your real-time handler.
> 
> thats ok for my board IRQ but i could not enable all IRQs and so another isr running
> in linux will disalow other realtime irqs. see above.

> >
> > You may want to have a look at the Adeos CVS, under linux/examples:
> > there are a set of testing and measurement programs illustrating how the
> > pipeline shall be controlled.
> >
> 
> Dirk.
> 
> 
> 
> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> http://mail.nongnu.org/mailman/listinfo/adeos-main
-- 

Philippe.



