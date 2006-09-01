Subject: Re: [Xenomai-help] IRQ Enable/Disable
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <44F8379E.4040801@domain.hid>
References: <44F6E774.2000701@domain.hid>
	<44F72F35.4070109@domain.hid> <1157099348.4322.32.camel@domain.hid>
	<44F8379E.4040801@domain.hid>
Content-Type: text/plain
Date: Fri, 01 Sep 2006 16:21:54 +0200
Message-Id: <1157120514.4981.4.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On Fri, 2006-09-01 at 15:37 +0200, Jan Kiszka wrote:
> Philippe Gerum wrote:
> > On Thu, 2006-08-31 at 20:49 +0200, Jan Kiszka wrote:
> >> Marcelo Coelho wrote:
> >>> Hi!
> >>>
> >>>
> >>> I've found out in RTAI's 16550a driver, that uses RTDM, the following
> >>> comment:
> >>>
> >>>     /*We should disable the line now, but this requires counting
> >>>      * enable/disable, something not yet implemented by the core.
> >>>      * At the moment this call could starve other users sharing the
> >>>      * same line.
> >>>     rtdm_irq_disable(&ctx->irq_handle);*/
> >>>     rtdm_irq_free(&ctx->irq_handle);
> >> In fact, you find the same in Xenomai as RTAI just mirrors the original. :)
> >>
> >>> Is this still true? I mean, if i free the device at device close, should
> >>> i expect that i need to request the irq again?
> >> It is still true. Xenomai does not support a nesting counter for
> >> irq_disable/enable yet, therefore RTDM did not change its interface in
> >> this regard as well.
> >>
> >>> I'm trying to ckeck what to expect about these calls.
> >>>
> >> For now the situation is like this: rtdm_irq_request allocates an IRQ,
> >> but doesn't necessarily enables it. So you have to call rtdm_irq_enable
> >> afterwards. To release it, just switch off IRQ generation in your device
> >> and call rtdm_irq_free.
> >>
> >> That's true unless the IRQ is shared. Then some other driver may have
> >> already enabled it (which doesn't releases your from the duty to do it
> >> again - you cannot predict the load order). Therefore, if writing a
> >> driver with shared IRQ support, you should not rely on the fact that the
> >> IRQ line is disabled right after rtdm_irq_request. Neither should you
> >> disable the line on release (only in the hardware). Otherwise, you would
> >> cut off persisting users of that line.
> >>
> >>
> >> Mmh, your question makes me wonder if we shouldn't enable the line in
> >> rtdm_irq_request automatically. I do not recall any urging use-case for
> >> the current behaviour... Does anyone else?
> >>
> >> Dmitry, Philippe, what's the reason for the split up in the core? Does
> >> any skin require this?
> >>
> > 
> > In short, the split up is there because the nucleus is expected to
> > provide mechanisms, not policies, and enabling the channel implicitely
> > upon attachment would impose some kind of policy downstream. Since
> > finding a standard for interrupt handling among OS and platforms is
> > impossible, the core only provides the LEGO bricks, it's up to the upper
> > layers to build the big and flashy red fireman truck with those...
> > 
> 
> Ok, makes sense for the core (though it prevents nested
> irq_enable/disable).

More precisely, it asks the upper layer to deal with it, which I agree
is not that comfortable, since all upper layers should still use a
common interface for enabling/disabling IRQs and sharing the nesting
counter. But the nucleus provides such common interface already, so
manipulating the nesting counter there is likely more appropriate than
anywhere else. 

>  But I'm convinced now, also when considering RTDM
> over -rt, that RTDM should undergo a change: rtdm_irq_request should
> always return the line enabled.
> 
> The first step is now to move rtdm_irq_request and rtdm_irq_enabled
> close to each other in all existing (and publicly known) drivers. Then
> we will see, if this change can be part of 2.3 or is rather something
> for a farther release.
> 
> Jan
> 
-- 
Philippe.



