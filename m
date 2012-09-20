Message-ID: <505B3333.20507@xenomai.org>
Date: Thu, 20 Sep 2012 17:16:03 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <505AF205.6010206@siemens.com> <505AF49D.6020905@xenomai.org>
	<505AF641.6030604@siemens.com> <505AF687.9010002@siemens.com>
	<505AFACC.1050802@siemens.com> <505B15BE.2010500@xenomai.org>
	<505B2026.6010707@siemens.com> <505B22A3.8020408@xenomai.org>
	<505B3142.4060600@siemens.com>
In-Reply-To: <505B3142.4060600@siemens.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] Revert "ipipe: ipipe_request_irq(),
 ipipe_free_irq() are root-only services"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "Mauerer, Wolfgang" <wolfgang.mauerer@siemens.com>, Xenomai <xenomai@xenomai.org>

On 09/20/2012 05:07 PM, Jan Kiszka wrote:
> On 2012-09-20 16:05, Philippe Gerum wrote:
>>>>> In this light, let's remove those checks nevertheless.
>>>>> Enabling/disabling the IRQ are separate calls, and those should be
>>>>> instrumented as those cause the restriction.
>>>>>
>>>>
>>>> I don't see it this way, because we can't predict what will be the
>>>> constraints we might have for hooking irqs on all archs we will support.
>>>> Maybe we will have to run more mainline code in some cases. In any case,
>>>> we have to fold masking into the de-registration code for proper SMP
>>>> support - this fix was never finalized precisely because we could not
>>>> guarantee a root calling context in that case.
>>>>
>>>> These checks are there to express the fact that calling from non-root is
>>>> inherently unsafe. We might find a (ugly) way to tag irq descriptors,
>>>> for knowing whether this is safe to call from non-root and test this
>>>> conditionally. But at the end of the day, we would still end up with
>>>> checking for arch-specific constraints in a generic API, which would be
>>>> wrong by design.
>>>>
>>>> I put these checks when refactoring the pipeline API for the very same
>>>> reason than you agree to update the RTDM spec regarding
>>>> rtdm_request_irq: no sane code should have called ipipe_virtualize_irq()
>>>> from a non-root context. This is just about formalizing this fact.
>>>
>>> ...at the wrong point. Plus it is breaking our instrumentation. Again:
>>> this belongs where we can asses the problem better, i.e. in the higher
>>> layer and in those functions that do break when called from RT context.
>>
>> I don't think so.
> 
> I do agree that the caller of ipipe_request_irq should not be called
> over RT context. However, ipipe_request_irq itself _is_ called under an
> RT spin lock with hardirqs disabled, both under Xenomai 2.6 and upcoming
> 3. And this triggers CONFIG_IPIPE_DEBUG_CONTEXT, clearly showing that
> things are still broken here. What do you suggest to fix all this?
> 

Fix the callers in the upcoming Xenomai releases, and provide an open
coded implementation of ipipe_request_irq in ipipe_virtualize_irq when
CONFIG_IPIPE_LEGACY is enabled, which will take care of the broken legacy.

-- 
Philippe.

