Subject: Re: [Xenomai-core] No hardware interrupts with xenomai on ppc405
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4507FBD7.5010008@domain.hid>
References: <4503EB88.2040309@domain.hid>
	<200609111904.16512.matthias.fuchs@domain.hid>
	<4505A75B.8000601@domain.hid>
	<200609120932.20196.matthias.fuchs@domain.hid>
	<45068DFE.3090408@domain.hid> <1158141962.5066.17.camel@domain.hid>
	<4507DEB6.3070808@domain.hid>  <1158147361.5066.25.camel@domain.hid>
	<1158147598.5066.30.camel@domain.hid>  <4507FBD7.5010008@domain.hid>
Content-Type: text/plain
Date: Wed, 13 Sep 2006 14:45:21 +0200
Message-Id: <1158151521.5066.35.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

On Wed, 2006-09-13 at 14:38 +0200, Wolfgang Grandegger wrote:
> Philippe Gerum wrote:
> > On Wed, 2006-09-13 at 13:36 +0200, Philippe Gerum wrote:
> >> On Wed, 2006-09-13 at 12:34 +0200, Wolfgang Grandegger wrote:
> >>> Philippe Gerum wrote:
> >>>> On Tue, 2006-09-12 at 12:37 +0200, Wolfgang Grandegger wrote:
> >>>>> Matthias Fuchs wrote:
> >>>>>> On Monday 11 September 2006 20:13, Wolfgang Grandegger wrote:
> >>>>>>> In 2.6 the interrupts are disabled by default. Then the attached patch 
> >>>>>>> for Xenomai should help.
> >>>>>>>
> >>>>>>> Wolfgang.
> >>>>>>>
> >>>>>> Your patch also works fine. Now what's the recommended solution? I noticed 
> >>>>>> that Philippe already checked in an Adeos fix.
> >>>>> As mentioned, in Linux 2.6 (generic IRQ layer), IRQs are disabled by 
> >>>>> default in kernel/irq/handle.c:
> >>>>>
> >>>>>    irq_desc_t irq_desc[NR_IRQS] __cacheline_aligned = {
> >>>>>          [0 ... NR_IRQS-1] = {
> >>>>>                  .status = IRQ_DISABLED,
> >>>>>                  .handler = &no_irq_type,
> >>>>>                  .lock = SPIN_LOCK_UNLOCKED
> >>>>>          }
> >>>>>    };
> >>>>>
> >>>>> Till now, I haven't found IPIPE/Xenomai related code removing the 
> >>>>> IRQ_DISABLED bit. But I wonder why it's working for x86. Maybe I have 
> >>>>> missed something.
> >>>>>
> >>>>> In Linux 2.4, the "status" field is initialized to 0 (in 
> >>>>> arch/ppc/kernel/irq.c) not making trouble:
> >>>>>
> >>>>>    irq_desc_t irq_desc[NR_IRQS] __cacheline_aligned =
> >>>>>          { [0 ... NR_IRQS-1] = { 0, NULL, NULL, 0, SPIN_LOCK_UNLOCKED}};
> >>>>>
> >>>>> At least my CAN PCI card on a MPC5200 works fine.
> >>>>>
> >>>>> Philippe, do we really need these ugly PIC patches?
> >>>> Not anymore, since we decided to stop supporting a tortuous use case
> >>>> where some IRQ channel could be shared between a Xenomai ISR and a Linux
> >>>> handler for handling mixed RT/non-RT devices (which was something of a
> >>>> bugous design anyway). Doing so, the patch was about preventing
> >>>> IRQ_INPROGRESS to block IRQ reenabling requests issued from a Xenomai
> >>>> ISR (i.e. in case a RT interrupt preempts the regular Linux handler for
> >>>> the same IRQ channel).
> >>>>
> >>>> The problem I see now, is that removing the work-arounds from the
> >>>> various PIC code would void the ability to use recent Adeos patches with
> >>>> older Xenomai releases. I'm not opposed to that, provided we backport
> >>>> your fix to 2.1.x and above, but this is an issue we should keep in
> >>>> mind. Perhaps the next Adeos patches should even make un-fixed Xenomai
> >>>> releases choke at compilation time.
> >>> We could also set the relevant status field bits to 0 somewhere in the 
> >>> IPIPE-patch when the IRQ is requested or overtaken. I think this is a 
> >>> general issue (not only on PowerPC).
> >> This would not clear the issue for IRQ_INPROGRESS, which is raised upon
> >> IRQ handling.
> > 
> > I mean this would not fix all the use cases, but this would be
> > sufficient to solve the non-tortuous ones, I agree. So yes, IRQ_DISABLED
> > could just be cleared in ipipe_virtualize_irq_from(), and that should be
> > enough.
> 
> Ok, should I fix that and remove all PowerPC PIC patches already for the 
> Adeos iPipe PPC patch for 2.6.18rc6 I'm currently working on?
> 

I think so. I'm also going to apply the suggested fix to the Xenomai
HAL, so that new Xenomai revs will work over old Adeos patches, and the
other way around too. TIA,

> Wolfgang.
-- 
Philippe.



