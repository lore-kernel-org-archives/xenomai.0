Message-ID: <f5e14e470807291515j19e7d34v3b9a1579bc10377f@domain.hid>
Date: Wed, 30 Jul 2008 00:15:39 +0200
From: "Ulrich Schwab" <uli.schwab@domain.hid>
In-Reply-To: <488F2749.9010605@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <487E1BE8.1000306@domain.hid>
	<f5e14e470807200925h3ac5d321x1a6d7629dd03fb0e@domain.hid>
	<488DD994.8020501@domain.hid> <488F2749.9010605@domain.hid>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

On Tue, Jul 29, 2008 at 4:20 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> Gilles Chanteperdrix wrote:
>> Ulrich Schwab wrote:
>>> why not checking for irq origin like this:
>>> int my_isr_handler (xnintr_t *irq)
>>> {
>>>  if ( ! test_my_card_for_irq_origin )
>>>     return XN_ISR_NONE | XN_ISR_PROPAGATE;
>>>   ... /* handling */
>>>  return XN_ISR_HANDLED;
>>> }
>>>
>>> this way XN_ISR_PROPAGATE is never returned in the not-shared case.
>>
>> I think this idea needs an answer; the answer is no: it will not work.
>> Because the IRQ will remain masked until Linux handles it, which
>> basically means that the RT irq will wait for non-RT activity, you loose
>> real-time response.
>
> It will not work, but not for the reason I mention: Adeos WILL re-enable
> the IRQ at interrupt controller level after the end of this handler,
> however, since the interrupt was not cleared on the peripheral side, the
> peripheral will reassert the interrupt when the interrupt is unmasked at
> interrupt controller level, so the CPU will enter an infinite loop
> invoking the ISR.
>
> --
>                                                 Gilles.
>
Are You sure?
IIRC the infinte loop You describe occurs when XN_ISR_PROPAGATE is
removed from the code above.


Ulrich

