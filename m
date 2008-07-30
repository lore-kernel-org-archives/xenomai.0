Message-ID: <489026E5.1010801@domain.hid>
Date: Wed, 30 Jul 2008 10:31:33 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <487E1BE8.1000306@domain.hid>	
	<f5e14e470807200925h3ac5d321x1a6d7629dd03fb0e@domain.hid>	
	<488DD994.8020501@domain.hid> <488F2749.9010605@domain.hid>
	<f5e14e470807291515j19e7d34v3b9a1579bc10377f@domain.hid>
In-Reply-To: <f5e14e470807291515j19e7d34v3b9a1579bc10377f@domain.hid>
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
> On Tue, Jul 29, 2008 at 4:20 PM, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org> wrote:
>> Gilles Chanteperdrix wrote:
>>> Ulrich Schwab wrote:
>>>> why not checking for irq origin like this:
>>>> int my_isr_handler (xnintr_t *irq)
>>>> {
>>>>  if ( ! test_my_card_for_irq_origin )
>>>>     return XN_ISR_NONE | XN_ISR_PROPAGATE;
>>>>   ... /* handling */
>>>>  return XN_ISR_HANDLED;
>>>> }
>>>>
>>>> this way XN_ISR_PROPAGATE is never returned in the not-shared case.
>>> I think this idea needs an answer; the answer is no: it will not work.
>>> Because the IRQ will remain masked until Linux handles it, which
>>> basically means that the RT irq will wait for non-RT activity, you loose
>>> real-time response.
>> It will not work, but not for the reason I mention: Adeos WILL re-enable
>> the IRQ at interrupt controller level after the end of this handler,
>> however, since the interrupt was not cleared on the peripheral side, the
>> peripheral will reassert the interrupt when the interrupt is unmasked at
>> interrupt controller level, so the CPU will enter an infinite loop
>> invoking the ISR.
>>
>> --
>>                                                 Gilles.
>>
> Are You sure?
> IIRC the infinte loop You describe occurs when XN_ISR_PROPAGATE is
> removed from the code above.

Actually, no, I was not sure, so, I had a look at the code, all IRQs
handlers do:

        if (s & XN_ISR_PROPAGATE)
                xnarch_chain_irq(irq);
        else if (!(s & XN_ISR_NOENABLE))
                xnarch_end_irq(irq);

It means that when XN_ISR_PROPAGATE is set the IRQ does not get unmasked
at interrupt controller level, and your solution does not cause the
system to enter the infinite loop, however you loose the RT response, as
was (correctly) said in my first answer.

It also means that my solution has the same issue. So, we should add a
call to xnarch_end_irq in the non-rt driver RT stub. So, the solution
becomes:

int driver2_nrt_irq_pending;

int driver2_rt_isr_handler(xnintr_t *irq)
{
   if (!test_driver2_hard_irq_pending())
 	return XN_ISR_NONE;

   clear_driver2_hard_irq();
   driver2_nrt_irq_pending = 1;

   xnarch_end_irq(irq->irq);

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
#ifndef CONFIG_IPIPE
	/* The old code checking and clearing hardware irqs. */
        if (!test_drive2_hard_irq_pending())
		return IRQ_NONE;

	clear_drive2_hard_irq();
#else /* IPIPE */
	/* Replaced by this code. */
	if (!driver2_nrt_irq_pending)
		return IRQ_NONE;

	driver2_nrt_irq_pending = 0;
#endif /* IPIPE */

	/* driver2 irq handling. */

	return IRQ_HANDLED;
}

-- 
                                                 Gilles.

