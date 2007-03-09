Message-ID: <bc4264770703090717u2a64c148g6000d0d64a488058@domain.hid>
Date: Fri, 9 Mar 2007 15:17:57 +0000
From: "roland Tollenaar" <rolandtollenaar@domain.hid>
Subject: Re: [Xenomai-help] RTCAN and tsc
In-Reply-To: <E1HPfGn-0003K5-RF@mailer.emlix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <bc4264770703060706x5dafb942weec4d4c2c5756427@domain.hid>
	<E1HPclZ-0004Yo-QD@mailer.emlix.com> <45F1425E.90604@domain.hid>
	<E1HPfGn-0003K5-RF@mailer.emlix.com>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Sebastian Smolorz <ssm@domain.hid>
Cc: xenomai@xenomai.org, Bernard Dautrevaux <bernard.dautrevaux@domain.hid>

On 3/9/07, Sebastian Smolorz <ssm@domain.hid> wrote:
> Gilles Chanteperdrix wrote:
> > Sebastian Smolorz wrote:
> > > Gilles Chanteperdrix wrote:
> > >>Sebastian Smolorz wrote:
> > >>>Gilles Chanteperdrix wrote:
> > >>>>Sebastian Smolorz wrote:
> > >>>>>If an RX interrupt appears it it necessary to read out up to 14
> > >>>>> SJA1000 regs and write one register before a CAN message can be
> > >>>>> distributed to the sockets. Do you really suggest that the reading of
> > >>>>> the SJA1000 registers should be interruptible? One step towards
> > >>>>> chaos, I would say.
> > >>>>
> > >>>>Maybe it would make sense to handle the message reception in a thread
> > >>>> (a kind of bottom half), and to only disable the CAN irq when doing
> > >>>> the reception work. This way, the system would still be able to handle
> > >>>> other events while the can reception takes place.
> > >>>
> > >>>The SJA1000 interrupt handler consists of several parts:
> > >>>1. Read out the interrupt register to determine which kind of CAN
> > >>>interrupt raised
> > >>>2. Check for the different kind of interrupts (error, TX, RX)
> > >>>3. If RX:
> > >>>3a. read out HW registers
> > >>>3b. Distribute to sockets
> > >>>
> > >>>It seems that an extended amount of time is spent for 3a. If we do this
> > >>>in a bottom-half we have to deal with things like priority inversion and
> > >>>under certain circumstances with lost CAN messages due to a full HW RX
> > >>>buffer of the CAN controller.
> > >>
> > >>So, maybe it is possible to simply enable interrupts in the interrupt
> > >>handler with only the CAN interrupt disabled ?
> > >
> > > This requires a detailed review of the driver code because every access
> > > to the CAN HW registers are protected by a rtdm_lock_get_irqsave and the
> > > SJA1000 IRQ handler relies on all IRQs being off.
> >
> > RTnet documentation recommends to use
> >       rtdm_irq_disable(&priv->irq_handle);
> >       rtdm_lock_get(&priv->lock);
> >
> > instead of rtdm_lock_get_irqsave(&priv->lock);
> > when the critical section is about to be long. The point is that the can
> > irq would still be off, it is unlikely that you have to protect from irq
> > handlers of other drivers.
>
> The point is to make some code area atomic. If several tasks and an interrupt
> handler could access the registers of the CAN controller, it is wise to let
> them do it in an ordered manner from defined controller states.
>
> > > But as far as I see, the PI and the HW buffer overflow problems would
> > > still exist.
> >
> > I do not see what you mean.
>
> If a high-priority task blocks on an rt_dev_recv and the IRQ handler would be
> interrupted by a task of lower priority while getting an received CAN
> messages out of the registers we would face priority inversion. So we have to
> give the interrupt handler a priority.
>
> The CAN controller receive buffer would overflow if the RX interrupt routine
> would be interrupted and, before being finished, the controller would receive
> more messages than its buffer can hold.

What is the effect of the buffer overflow? Only messages being lost or
are there more serious consequences? Error states of some kind?

What I gather is that allowing the CAN-RX interrupt handler to be
interruptible could lead to undesirably long delays while reading out
the registers which would either result in buffer overflow or/and,
changed register content before the previously read values are
written?

If it is also not possible to optimize the code further then IMHO  we
are looking at a fundamental hardware constraint.

If the latter is true then to be of any use in a RT environment, it
must be possible to retain more control over the message receiving in
at least one respect. It must be possible to either block the CAN-RX
interrupt or the reaction to it of the ISR. Obviously at the cost of
loosing messages but in some cases (like mine) loosing messages is not
that much of a problem. Having excessive latencies on the other hand
is.

What would probably work in my case is to allow the Rx ISR to be
interrupted by the rt tasks in such a manner that when the ISR is
interrupted the ISR is exited with no values written to the the
sockets. Obviously the current message in the registers of the SJA
will be lost but there is no risk of corrupt messages.







>
> --
> Sebastian
>

