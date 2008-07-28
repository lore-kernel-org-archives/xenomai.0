Message-ID: <488DD994.8020501@domain.hid>
Date: Mon, 28 Jul 2008 16:37:08 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <487E1BE8.1000306@domain.hid>
	<f5e14e470807200925h3ac5d321x1a6d7629dd03fb0e@domain.hid>
In-Reply-To: <f5e14e470807200925h3ac5d321x1a6d7629dd03fb0e@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Error propagating ISR to Linux domain
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Ulrich Schwab <uli.schwab@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Ulrich Schwab wrote:
> why not checking for irq origin like this:
> int my_isr_handler (xnintr_t *irq)
> {
>  if ( ! test_my_card_for_irq_origin )
>     return XN_ISR_NONE | XN_ISR_PROPAGATE;
>   ... /* handling */
>  return XN_ISR_HANDLED;
> }
> 
> this way XN_ISR_PROPAGATE is never returned in the not-shared case.

I think this idea needs an answer; the answer is no: it will not work.
Because the IRQ will remain masked until Linux handles it, which
basically means that the RT irq will wait for non-RT activity, you loose
real-time response.

The only approach that works is, detailing a bit more what Jan
suggested, assuming that driver1 is RT and driver2 is non RT:

int driver2_nrt_irq_pending;

int driver2_rt_isr_handler(xnintr_t *irq)
{
   if (!test_driver2_hard_irq_pending())
 	return XN_ISR_NONE;

   clear_driver2_hard_irq();
   driver2_nrt_irq_pending = 1;

   return XN_ISR_HANDLED | XN_ISR_PROPAGATE;
}

int driver1_rt_isr_handler(xnintr_t *irq)
{
   if (!test_driver1_irq_pending())
	return XN_ISR_NONE;

   /* driver1 handling */

   return XN_ISR_HANDLED;
}

int driver2_nrt_isr_handler(int irq, void *dev_id)
{
#if 0
	/* The old code checking and clearing hardware irqs. */
        if (!test_drive2_hard_irq_pending())
		return IRQ_NONE;

	clear_drive2_hard_irq();
#else
	/* Replaced by this code. */
	if (!driver2_nrt_irq_pending)
		return IRQ_NONE;

	driver2_nrt_irq_pending = 0;
#endif

	/* driver2 irq handling. */

	return IRQ_HANDLED;
}

-- 
                                                 Gilles.

