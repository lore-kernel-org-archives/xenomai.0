Subject: Re: [Adeos-main] interrupt latency
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <200402230322.13218.roloff@domain.hid>
References: <200402230035.16494.roloff@domain.hid>
	<1077493972.18998.2.camel@domain.hid>
	<200402230322.13218.roloff@domain.hid>
Content-Type: text/plain
Message-Id: <1077526102.637.36.camel@domain.hid>
Mime-Version: 1.0
Date: Mon, 23 Feb 2004 09:48:22 +0100
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

On Mon, 2004-02-23 at 03:22, Dirk Roloff wrote:
> Am Montag, 23. Februar 2004 00:52 schrieb Philippe Gerum:
> > On Mon, 2004-02-23 at 00:35, Dirk Roloff wrote:
> > > Hi List,
> > >
> > > I ve got the following problem:
> > >
> > > I have to write a driver for linux for a receiver-board.
> --- schnipp ---- 
> >
> > It would be interesting to know the flags passed to
> > adeos_virtualize_irq(). In any case, either the 4th arg should pass
> > IPIPE_PASS_MASK, or you realtime_handler() routine should call
> > adeos_propagate_irq(irq).
> Philippe:
> 
> the exactly code is:
>       if( 0 != adeos_virtualize_irq( irq[i], &rt_amcc_irq_handler, NULL, 
> IPIPE_PASS_MASK | IPIPE_HANDLE_MASK) )
> 
> i want to handle and pass it down the pipe.
> 
> But i give propagate a try ... not realy better ... 

> Now a second IRQ 4 will be delivert to the linux handler.


That's normal. Either set IPIPE_PASS_MASK if you want Adeos to propagate
the incoming IRQ unconditionally, _or_ don't set it if you want your
handler to decide dynamically of whether the propagation should take
place or not on a per-IRQ basis using adeos_propagate_irq().

> Only one IRQ 1 to the realtime (its masked out in PIC  when entering the 
> realtime)

That's ok too. By default on the x86 port, IRQs are mask & acked upon
receipt before the IRQ flows down the pipeline, except the 8254 timer
which is only acked.

> Could it be that this will block all other IRQ at PIC level ?
> 

Here are the typical actions taken upon IRQ receipt with a single
prioritary domain running above Linux in the pipeline:

hw IRQ =>
	[Adeos primary handler]
		=> mask and ack (from now, IRQ is masked at 8259 level)
		=> pipeline walk (all pending IRQs)
			=> realtime_handler(irq)
				[Your processing]
				adeos_propagate_irq(irq) (unless you set 						              
IPIPE_PASS_MASK)
			=> Linux handler()
				[Linux's do_IRQ(irq)]
				end_irq() (which re-enables the IRQ 					    line at the 8259 level)

If you want to re-enable the IRQ line earlier in the process (i.e.
before Linux's regular handler is run), then you can do this by calling
adeos_control_irq(irq,0,IPIPE_ENABLE_MASK) in your real-time handler. 

You may want to have a look at the Adeos CVS, under linux/examples:
there are a set of testing and measurement programs illustrating how the
pipeline shall be controlled.

Btw: which Adeos version are you using? 

> Dirk.
> 
> 
> 
> 
> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> http://mail.nongnu.org/mailman/listinfo/adeos-main
-- 

Philippe.



