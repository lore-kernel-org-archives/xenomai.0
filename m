From: Sebastian Smolorz <ssm@domain.hid>
Subject: Re: [Xenomai-help] RTCAN and tsc
Date: Fri, 9 Mar 2007 15:45:25 +0100
References: <bc4264770703060706x5dafb942weec4d4c2c5756427@domain.hid>
	<E1HPfGn-0003K5-RF@mailer.emlix.com>
	<b647ffbd0703090608m41d22703ua540c5910cca5315@domain.hid>
In-Reply-To: <b647ffbd0703090608m41d22703ua540c5910cca5315@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <E1HPgLW-0006Nf-20@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>, Bernard Dautrevaux <bernard.dautrevaux@domain.hid>

Dmitry Adamushko wrote:
> On 09/03/07, Sebastian Smolorz <ssm@domain.hid> wrote:
> > > ...
> > > instead of rtdm_lock_get_irqsave(&priv->lock);
> > > when the critical section is about to be long. The point is that the
> > > can irq would still be off, it is unlikely that you have to protect
> > > from irq handlers of other drivers.
> >
> > The point is to make some code area atomic. If several tasks and an
> > interrupt handler could access the registers of the CAN controller, it is
> > wise to let them do it in an ordered manner from defined controller
> > states.
>
> To say just "atomic" is not enough, it always involves /against what/.
> One doesn't need to be more "atomic" than necessary.

There are several places in the SJA1000 driver where HW registers are read or 
written.  If those code pathes would be interrupted before e.g. the read 
values are stored properly they could lead to wrong effects.

> > > > But as far as I see, the PI and the HW buffer overflow problems would
> > > > still exist.
> > >
> > > I do not see what you mean.
> >
> > If a high-priority task blocks on an rt_dev_recv and the IRQ handler
> > would be interrupted by a task of lower priority while getting an
> > received CAN messages out of the registers we would face priority
> > inversion. So we have to give the interrupt handler a priority.
>
> How come a RT ISR (I suppose we are talking about the RT driver - the
> primary domain ISR) can be interrupted by /any/ task? Do you have some
> special threading IRQ handling mechanism in RTDM (or maybe a patch
> that comes with RTCAN) that allows it?

Maybe I'm mixing things up or am just thinking too far. The initial problem 
was: The RTCAN interrupt handling seems to last too long so that RT tasks may 
be delayed inappropriately. So the proposed solution was: Make a bottom-half 
so that another RT task could run. That was the base for my speculations how 
to change the RTCAN code best. But it's only a thought experiment. No code, 
no patch. And I'm open for any findings coming out during this 
discussion. :-)

-- 
Sebastian

