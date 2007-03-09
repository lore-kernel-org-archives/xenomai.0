Message-ID: <b647ffbd0703090717v6e4e918h140b1785f6528110@domain.hid>
Date: Fri, 9 Mar 2007 16:17:17 +0100
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-help] RTCAN and tsc
In-Reply-To: <E1HPgLW-0006Nf-20@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <bc4264770703060706x5dafb942weec4d4c2c5756427@domain.hid>
	<E1HPfGn-0003K5-RF@mailer.emlix.com>
	<b647ffbd0703090608m41d22703ua540c5910cca5315@domain.hid>
	<E1HPgLW-0006Nf-20@domain.hid>
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
Cc: Xenomai help <xenomai@xenomai.org>, Bernard Dautrevaux <bernard.dautrevaux@domain.hid>

On 09/03/07, Sebastian Smolorz <ssm@domain.hid> wrote:
> Dmitry Adamushko wrote:
> > On 09/03/07, Sebastian Smolorz <ssm@domain.hid> wrote:
> > > > ...
> > > > instead of rtdm_lock_get_irqsave(&priv->lock);
> > > > when the critical section is about to be long. The point is that the
> > > > can irq would still be off, it is unlikely that you have to protect
> > > > from irq handlers of other drivers.
> > >
> > > The point is to make some code area atomic. If several tasks and an
> > > interrupt handler could access the registers of the CAN controller, it is
> > > wise to let them do it in an ordered manner from defined controller
> > > states.
> >
> > To say just "atomic" is not enough, it always involves /against what/.
> > One doesn't need to be more "atomic" than necessary.
>
> There are several places in the SJA1000 driver where HW registers are read or
> written.  If those code pathes would be interrupted before e.g. the read
> values are stored properly they could lead to wrong effects.

Well, I suppose, we all know how important synch-safe code is. So no
need to repeat mere generic ideas again :) I was pointing into
particular synch scenarious btw.

The point I made (and earlier Gilles) is that an ISR in the primary
domain cannot be interrupted by anything if irqs are *off*.
If irqs are *on* but the line on which this ISR resides is *off*, it
can be interrupted only by another ISR. And hence we come to the
point:

"The point is that the can irq would still be off, it is unlikely that
you have to protect from irq
handlers of other drivers."

So if you don't have another (or even the same) ISR sitting on
*another* irq line and accessing the same set of can registers you
don't need to keep all the interrupts *masked* - esp. if you know that
processing may take quite some time.

If you want to synch against ISRs from some code in the thread context then use

spinlock + irqs off.

Yes, spinlock + only a particular irq line being off would be ok as
well (and less strong restriction) but the point is that:

(1) irqs masking/unmasking is normally way faster than
disabling/enabling a given line.
that's important as long as (2) is true;
(2) such "atomic section" is normally supposed to be short, time-wise.


-- 
Best regards,
Dmitry Adamushko

