From: Sebastian Smolorz <ssm@domain.hid>
Subject: Re: [Xenomai-help] RTCAN and tsc
Date: Fri, 9 Mar 2007 11:56:05 +0100
References: <bc4264770703060706x5dafb942weec4d4c2c5756427@domain.hid>
	<E1HPc72-0002bA-Ko@domain.hid> <45F1340C.20402@domain.hid>
In-Reply-To: <45F1340C.20402@domain.hid>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <E1HPclZ-0004Yo-QD@mailer.emlix.com>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org, Bernard Dautrevaux <bernard.dautrevaux@domain.hid>

Gilles Chanteperdrix wrote:
> Sebastian Smolorz wrote:
> > Gilles Chanteperdrix wrote:
> >>Sebastian Smolorz wrote:
> >>>If an RX interrupt appears it it necessary to read out up to 14 SJA1000
> >>>regs and write one register before a CAN message can be distributed to
> >>>the sockets. Do you really suggest that the reading of the SJA1000
> >>>registers should be interruptible? One step towards chaos, I would say.
> >>
> >>Maybe it would make sense to handle the message reception in a thread (a
> >>kind of bottom half), and to only disable the CAN irq when doing the
> >>reception work. This way, the system would still be able to handle other
> >>events while the can reception takes place.
> >
> > The SJA1000 interrupt handler consists of several parts:
> > 1. Read out the interrupt register to determine which kind of CAN
> > interrupt raised
> > 2. Check for the different kind of interrupts (error, TX, RX)
> > 3. If RX:
> > 3a. read out HW registers
> > 3b. Distribute to sockets
> >
> > It seems that an extended amount of time is spent for 3a. If we do this
> > in a bottom-half we have to deal with things like priority inversion and
> > under certain circumstances with lost CAN messages due to a full HW RX
> > buffer of the CAN controller.
>
> So, maybe it is possible to simply enable interrupts in the interrupt
> handler with only the CAN interrupt disabled ?

This requires a detailed review of the driver code because every access to the 
CAN HW registers are protected by a rtdm_lock_get_irqsave and the SJA1000 IRQ 
handler relies on all IRQs being off.

But as far as I see, the PI and the HW buffer overflow problems would still 
exist.

-- 
Sebastian

