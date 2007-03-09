Message-ID: <b647ffbd0703090608m41d22703ua540c5910cca5315@domain.hid>
Date: Fri, 9 Mar 2007 15:08:46 +0100
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
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
Cc: Xenomai help <xenomai@xenomai.org>, Bernard Dautrevaux <bernard.dautrevaux@domain.hid>

On 09/03/07, Sebastian Smolorz <ssm@domain.hid> wrote:
> > ...
> > instead of rtdm_lock_get_irqsave(&priv->lock);
> > when the critical section is about to be long. The point is that the can
> > irq would still be off, it is unlikely that you have to protect from irq
> > handlers of other drivers.
>
> The point is to make some code area atomic. If several tasks and an interrupt
> handler could access the registers of the CAN controller, it is wise to let
> them do it in an ordered manner from defined controller states.

To say just "atomic" is not enough, it always involves /against what/.
One doesn't need to be more "atomic" than necessary.

What Gilles pointed out is that if those registers are not accessable
from other ISRs, there is no need to keep all the interrupts off. ISR
may compete either with another ISRs on the same CPU (nested
interrupts) or against any other code on /another/ CPU. But that's why
you still have spinlocks in place.

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

How come a RT ISR (I suppose we are talking about the RT driver - the
primary domain ISR) can be interrupted by /any/ task? Do you have some
special threading IRQ handling mechanism in RTDM (or maybe a patch
that comes with RTCAN) that allows it?


-- 
Best regards,
Dmitry Adamushko

