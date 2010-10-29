From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1288356408.1816.173.camel@domain.hid>
References: <4CC998FB.3070102@domain.hid>  <4CC9CBE1.6030006@domain.hid>
	<1288294469.1816.107.camel@domain.hid>  <4CCA70F1.3010501@domain.hid>
	<1288340853.1816.146.camel@domain.hid>  <4CCA8E53.5040500@domain.hid>
	<1288353650.1816.152.camel@domain.hid>  <4CCAB990.6020609@domain.hid>
	<1288356408.1816.173.camel@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 29 Oct 2010 14:58:56 +0200
Message-ID: <1288357136.1816.177.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] arm: Unprotected access to irq_desc field?
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai core <Xenomai-core@domain.hid>

On Fri, 2010-10-29 at 14:46 +0200, Philippe Gerum wrote:
> On Fri, 2010-10-29 at 14:09 +0200, Jan Kiszka wrote:
> > Am 29.10.2010 14:00, Philippe Gerum wrote:
> > > On Fri, 2010-10-29 at 11:05 +0200, Jan Kiszka wrote:
> > >> Am 29.10.2010 10:27, Philippe Gerum wrote:
> > >>> On Fri, 2010-10-29 at 09:00 +0200, Jan Kiszka wrote:
> > >>>> Am 28.10.2010 21:34, Philippe Gerum wrote:
> > >>>>> On Thu, 2010-10-28 at 21:15 +0200, Gilles Chanteperdrix wrote:
> > >>>>>> Jan Kiszka wrote:
> > >>>>>>> Gilles,
> > >>>>>>>
> > >>>>>>> I happened to come across rthal_mark_irq_disabled/enabled on arm. On
> > >>>>>>> first glance, it looks like these helpers manipulate irq_desc::status
> > >>>>>>> non-atomically, i.e. without holding irq_desc::lock. Isn't this fragile?
> > >>>>>>
> > >>>>>> I have no idea. How do the other architectures do? As far as I know,
> > >>>>>> this code has been copied from there.
> > >>>>>
> > >>>>> Other archs do the same, simply because once an irq is managed by the
> > >>>>> hal, it may not be shared in any way with the regular kernel. So locking
> > >>>>> is pointless.
> > >>>>
> > >>>> Indeed, I missed that all the other archs have this uninlined in hal.c.
> > >>>>
> > >>>> However, this leaves at least a race between xnintr_disable/enable and
> > >>>> XN_ISR_PROPAGATE (ie. the related Linux path) behind.
> > >>>
> > >>> I can't see why XN_ISR_PROPAGATE would be involved here. This service
> > >>> pends an interrupt in the pipeline log.
> > >>
> > >> And this finally lets Linux code run that fiddles with irq_desc::status
> > >> as well - potentially in parallel to an unsyncrhonized
> > >> xnintr_irq_disable in a different context. That's the problem.
> > > 
> > > Propagation happens in primary domain. When is this supposed to conflict
> > > on the same CPU with linux?
> > 
> > The propagation triggers the delivery of this IRQ to the Linux domain,
> > thus at some point there will be Linux accessing the descriptor while
> > there might be xnintr_irq_enable/disable running on some other CPU (or
> > it was preempted at the wrong point on the very same CPU).
> 
> The point is that XN_ISR_PROPAGATE, as a mean to force sharing of an IRQ
> between both domains is plain wrong. Remove this, and no conflict
> remains; this is what needs to be addressed. The potential issue between
> xnintr_enable/disable and the hal routines does not exist, if those
> callers handle locking properly.
> 

In any case, I don't think we could accept that sharing, so flipping the
bits in the hal is in fact pointless. To match the linux locking, we
should iron the irq_desc::lock, which we won't since this would cause
massive jittery. We should stick to the basic logic: no sharing,
therefore no tracking need for the irqflags. I'll kill XN_ISR_PROPAGATE
in forge at some point, for sure.

> > 
> > > 
> > >>
> > >>>
> > >>>>  Not sure if it
> > >>>> matters practically - but risking silent breakage for this micro
> > >>>> optimization?
> > >>>
> > >>> It was not meant as an optimization; we may not grab the linux
> > >>> descriptor lock in this context because we may enter it in primary mode.
> > >>
> > >> Oh, that lock isn't harden as I somehow assumed. This of course
> > >> complicates things.
> > >>
> > >>>
> > >>>>  Is disabling/enabling really in the highly
> > >>>> latency-critical anywhere? Otherwise, I would suggest to just plug this
> > >>>> by adding the intended lock for this field.
> > >>>
> > >>> The caller is expected to manage locking; AFAICS the only one who does
> > >>> not is the RTAI skin, which is obsolete and removed in 2.6.x, so no big
> > >>> deal.
> > >>
> > >> The problem is that IRQ forwarding to Linux may let this manipulation
> > >> race with plain Linux code, thus has to synchronize with it. It is a
> > >> corner case (no one is supposed to pass IRQs down blindly anyway - if at
> > >> all), but it should at least be documented ("Don't use disable/enable
> > >> together with IRQ forwarding unless you acquire the descriptor lock
> > >> properly!").
> > >>
> > >> BTW, do we need to track the descriptor state in primary mode at all?
> > >>
> > > 
> > > That is the real issue. I don't see the point of doing this with the
> > > current kernel code.
> > 
> > Do we need to keep the status in synch with the hardware state for the
> > case Linux may take over the descriptor again? Or will Linux test the
> > state when processing a forwarded IRQ? These are the two potential
> > scenarios that come to my mind. For former could be deferred, but the
> > latter would be critical again.
> > 
> > Jan
> > 
> 
> -- 
> Philippe.
> 
> 
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core

-- 
Philippe.



