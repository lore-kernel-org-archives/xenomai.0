From: Dirk Roloff <roloff@domain.hid>
Subject: Re: [Adeos-main] interrupt latency
Date: Tue, 24 Feb 2004 04:48:27 +0100
References: <200402230035.16494.roloff@domain.hid>
	<200402231906.13627.roloff@domain.hid>
	<1077566019.646.50.camel@domain.hid>
In-Reply-To: <1077566019.646.50.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402240448.27736.roloff@domain.hid>
List-Id: <adeos-main.nongnu.org>
List-Unsubscribe: <http://mail.nongnu.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <http://mail.gnu.org/pipermail/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <http://mail.nongnu.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

Am Montag, 23. Februar 2004 20:53 schrieb Philippe Gerum:

Hi Philippe 
> Ok. However, r11 behaves exactely the same way than r10 for the part we
> are talking of (most of the work between r10 and the current r11
> candidates is SMP-related). Shared IRQs might not be what you need here
> (i.e. you don't have to share a single IRQ line shared by several
> devices handled by different Adeos domains).

OK 


> >                                      [Your processing]
> >                                 => !!!!  should leave the pipe because
> > linux stalls it right ?
>
> Yes. But still, keep in mind that the IRQ syncer (__adeos_sync_stage())
> can be re-entered safely by an IRQ. This is needed because some Linux
> IRQ drivers (namely the PC keyboard one using IRQ #1) sit in a busy loop
> waiting for subsequent interrupts on behalf of their own interrupt
> handler...

Yes ... a closer look at this function brings light in the dark.
If i remove the SA_INTERRUPT in request_irq() it works as it should.
With SA_INTERRUPT adding a sti()/cli() to the realtime handler will also work.
Its too late to follow whats going on there - and using heavy printk in the 
realtime handler will lock up the system completly.

> > handler] will not entered - why ? !!!!  no realtime_handler(irq) calls
> > are counted
>
> I'd bet that Adeos primary handler is actually entered, but your domain
> might be stalled, so no interrupt could be delivered to it.

Think you win the bet - looks like its stalled by __adeos_sync_stage. 
Very confusing.  

> >
> > in __adeos_sync_stage
> > check and set the mask bit just before calling irq_handler and after this
> > clears it. This should save us to do not call the same irq handler twice
> > for the same IRQ.
> >
> > Mhhh ... what about SMP ... maybe the mask should be a per domain per cpu
> > field.
> >
> > Let me know what you think about this.
>
> There is a mechanism implemented in Adeos that actually handles the
> enable/disable IRQ ops on a per-domain basis. I've posted some
> information about this to the RTAI mailing list once, maybe you want to
> have a look at it, so we can further discuss this stuff:
> https://mail.rtai.org/pipermail/rtai/2003-November/005623.html

Yes great post - i found it already googlin around. But this time i read it 
twice. :-)

> > > If you want to re-enable the IRQ line earlier in the process (i.e.
> > > before Linux's regular handler is run), then you can do this by calling
> > > adeos_control_irq(irq,0,IPIPE_ENABLE_MASK) in your real-time handler.

I think that was the wrong way.

I will do some more research tomorow. Now i will interrupt my work for a few 
hours sleep.

Dirk.



