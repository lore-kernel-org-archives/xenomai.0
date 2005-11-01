Message-ID: <4367543F.9050700@domain.hid>
Date: Tue, 01 Nov 2005 12:40:47 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [RFC] support for sharing IRQs
References: <OF52EBEF44.18C1609B-ONC12570AB.004913D2-C12570AB.004F9693@domain.hid>
In-Reply-To: <OF52EBEF44.18C1609B-ONC12570AB.004913D2-C12570AB.004F9693@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Dmitry Adamushko wrote:
> 
> Hi Jan,
> 
>  >
>  > I have some code hanging around here which implements IRQ sharing at
>  > skin level for an experimental in-house development over Xenomai. The
>  > code is smart enough to register an IRQ sharing trampoline handler only
>  > in case sharing is actually practiced for a specific line.
> 
> Could you be a bit more specific on what is meant by "...sharing is 
> actually practiced for a specific line"?
> 
> To my knowledge, the matter is only about whether a certain device 
> (driver) permits the earlier obtained irq line to be shared with other 
> devices.
> i.e. a driver [1] may succeed with an irq registration request in case 
> another driver [2] already holds this line but both [1] and [2] have 
> specified a SA_SHIRQ flag.
> 
> 
>  > I think it would be possible to break this out and generate a mainline
>  > patch. Anyway, the question for me is where to put this best, at skin
>  > (RTDM?) or at nucleus level? Both is technically feasible, but which way
>  > is desired? (I would vote for the nucleus...)
> 
> If we have a policy that all the drivers should be implemented on top of 
> RTDM, then, it can be done there. If no (and I guess so), this feature 
> should be common and I'd vote for the nucleus.

Actually, now that we have a decent driver model built in, I will enforce the 
rule that all Xenomai mainline drivers must be based on RTDM, because we do need 
such a common platform to prevent braindamage calling interfaces hysteria. This 
will be a good opportunity to see how flexible the thing is when confronted to 
the needs of various hw and semantics.

> It seems to me now, that some parts of the hal will be involved 
> (rthal_irq_request/release()) since the nucleus itself doesn't keep 
> track of registered irqs.
> 
> 
>  >
>  > Jan
>  >
> 
> ---
> Best regards,
> Dmitry
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


-- 

Philippe.

