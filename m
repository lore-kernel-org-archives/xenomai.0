From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <470C6D48.3070109@domain.hid>
References: <305035a40710091019n77e1a453gd0d349dc1eebc15d@domain.hid>
	<470BC537.8010200@domain.hid>
	<305035a40710091207j4038c62s5fb81903ce843910@domain.hid>
	<305035a40710091207l185a8fcm8baf715e0a0ef2b3@domain.hid>
	<470BDA72.8070908@domain.hid>
	<18187.63871.791885.643837@domain.hid>
	<470C6D48.3070109@domain.hid>
Content-Type: text/plain
Date: Wed, 10 Oct 2007 10:45:28 +0200
Message-Id: <1192005928.22917.160.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] Fwd: RTAI and Xenomai latency in kernel mode
	on	AT91SAM9261-EK
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 2007-10-10 at 08:12 +0200, Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
> > Jan Kiszka wrote:
> >  > Again, the priority should not be the issue. The issue is likely that a
> >  > pending or just being handled non-RT IRQ can stall some RT IRQ at
> >  > hardware level. That must not happen. I-pipe rather has to log,
> >  > acknowledge, and possibly mask that line quickly so that RT IRQs can be
> >  > delivered again.
> > 
> > Thinking a bit more about my ethernet vs timer issue. If, when an
> > ethernet interrupt is pending, adeos is not aware that there is also a
> > timer interrupt pending, it will call the ethernet interrupt handler
> > immediately then unmask the interrupt. So, Adeos will never have a
> > chance to handle the timer interrupt before another ethernet interrupt
> > is handled. Ergo, giving the timer interrupt the highest priority is
> > what must be done.
> 
> No. Adeos will first start to dispatch the Ethernet IRQ. It will
> ack&mask it and then re-enable the IRQ delivery before calling into the
> handler.

Only if the ethernet interrupt is not a real-time event.

>  At this point the hardware can report the timer IRQ, and Adeos
> will immediately start to deliver that one instead.
> 
> With IRQ hardware priorities, you only optimise the case when both
> interrupts are pending in the hardware at the same time. The worst-case
> remains that the Ethernet IRQ comes first, Adeos starts to handle it,
> and _then_ the timer IRQ arrives. This is something the hardware can in
> no way avoid (without looking into the future...).
> 

When the processor has a notion of internal priority level which it does
inherit from the level of the event it currently processes, the above
assumption is wrong. In such a case, the next interrupt to be serviced
would be equivalent to pending_IRQ_mask & CPU_interrupt_mask &
processor_level, i.e. multiple high priority interrupts would be
processed before a low priority one is eventually triggered. So in that
case, Gilles's assertion does make a lot of sense.

> Jan
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
-- 
Philippe.



