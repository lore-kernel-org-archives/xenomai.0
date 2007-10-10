Message-ID: <2ff1a98a0710100236x12d66b57q47540715195f2fd6@domain.hid>
Date: Wed, 10 Oct 2007 11:36:14 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <1192008492.22917.172.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <305035a40710091019n77e1a453gd0d349dc1eebc15d@domain.hid>
	<470BC537.8010200@domain.hid>
	<305035a40710091207j4038c62s5fb81903ce843910@domain.hid>
	<305035a40710091207l185a8fcm8baf715e0a0ef2b3@domain.hid>
	<470BDA72.8070908@domain.hid>
	<18187.63871.791885.643837@domain.hid>
	<470C6D48.3070109@domain.hid> <1192005928.22917.160.camel@domain.hid>
	<2ff1a98a0710100154g2a919344ra4f910e249b2187f@domain.hid>
	<1192008492.22917.172.camel@domain.hid>
Subject: Re: [Xenomai-core] Fwd: RTAI and Xenomai latency in kernel mode on
	AT91SAM9261-EK
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

On 10/10/07, Philippe Gerum <rpm@xenomai.org> wrote:
> On Wed, 2007-10-10 at 10:54 +0200, Gilles Chanteperdrix wrote:
> > On 10/10/07, Philippe Gerum <rpm@xenomai.org> wrote:
> > > On Wed, 2007-10-10 at 08:12 +0200, Jan Kiszka wrote:
> > > > Gilles Chanteperdrix wrote:
> > > > > Jan Kiszka wrote:
> > > > >  > Again, the priority should not be the issue. The issue is likely that a
> > > > >  > pending or just being handled non-RT IRQ can stall some RT IRQ at
> > > > >  > hardware level. That must not happen. I-pipe rather has to log,
> > > > >  > acknowledge, and possibly mask that line quickly so that RT IRQs can be
> > > > >  > delivered again.
> > > > >
> > > > > Thinking a bit more about my ethernet vs timer issue. If, when an
> > > > > ethernet interrupt is pending, adeos is not aware that there is also a
> > > > > timer interrupt pending, it will call the ethernet interrupt handler
> > > > > immediately then unmask the interrupt. So, Adeos will never have a
> > > > > chance to handle the timer interrupt before another ethernet interrupt
> > > > > is handled. Ergo, giving the timer interrupt the highest priority is
> > > > > what must be done.
> > > >
> > > > No. Adeos will first start to dispatch the Ethernet IRQ. It will
> > > > ack&mask it and then re-enable the IRQ delivery before calling into the
> > > > handler.
> > >
> > > Only if the ethernet interrupt is not a real-time event.
> > >
> > > >  At this point the hardware can report the timer IRQ, and Adeos
> > > > will immediately start to deliver that one instead.
> > > >
> > > > With IRQ hardware priorities, you only optimise the case when both
> > > > interrupts are pending in the hardware at the same time. The worst-case
> > > > remains that the Ethernet IRQ comes first, Adeos starts to handle it,
> > > > and _then_ the timer IRQ arrives. This is something the hardware can in
> > > > no way avoid (without looking into the future...).
> > > >
> > >
> > > When the processor has a notion of internal priority level which it does
> > > inherit from the level of the event it currently processes, the above
> > > assumption is wrong. In such a case, the next interrupt to be serviced
> > > would be equivalent to pending_IRQ_mask & CPU_interrupt_mask &
> > > processor_level, i.e. multiple high priority interrupts would be
> > > processed before a low priority one is eventually triggered. So in that
> > > case, Gilles's assertion does make a lot of sense.
> >
> > The AT91 interrupts need an EOI, I wonder if we are not simply doing
> > the EOI too late. That is, the EOI should be done when the interrupt
> > has been acked, before it is handled, so that other interrupts can be
> > delivered.
> >
>
> The EOI would lower the priority barrier for interrupts, so this makes
> sense.
>
> Looking at the I-pipe code for AT91RM9200 for instance, I only see the
> AIC being asked to mask the IRQ source as a result of the fast I-pipe
> acknowledge being called, nothing more. If the AIC needs explicit EOI to
> lower the priority level which is not covered by the previous action,
> then it's indeed missing.
>
> The latest fix regarding the fasteoi interrupt flow would not have any
> impact, since AFAICS, we are solely dealing with level interrupts here.

The EOI is done by the irq_finish macro, which is called after ipipe_handle_irq.

-- 
                                               Gilles Chanteperdrix

