Message-ID: <505B15BE.2010500@xenomai.org>
Date: Thu, 20 Sep 2012 15:10:22 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <505AF205.6010206@siemens.com> <505AF49D.6020905@xenomai.org>
	<505AF641.6030604@siemens.com> <505AF687.9010002@siemens.com>
	<505AFACC.1050802@siemens.com>
In-Reply-To: <505AFACC.1050802@siemens.com>
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

On 09/20/2012 01:15 PM, Jan Kiszka wrote:
> On 2012-09-20 12:57, Jan Kiszka wrote:
>> On 2012-09-20 12:56, Jan Kiszka wrote:
>>> On 2012-09-20 12:49, Philippe Gerum wrote:
>>>> On 09/20/2012 12:37 PM, Jan Kiszka wrote:
>>>>> This reverts commit 073ff1e8045d0311b8cf390687c0ba3619681672.
>>>>>
>>>>> Both service are NOT just root-only services. E.g., rtdm_irq_request
>>>>> requires by specification support also over non-Linux contexts.
>>>>
>>>> Nack. We can't run the enable code for MSIs over non-root, and
>>>> that code typically follows the irq request. Besides, we want to mask
>>>> the source upon irq free to handle the SMP case properly, which we could
>>>> not do from non-root with MSIs.
>>>>
>>>> So either we have both request+enable and free usable over non-root, or
>>>> there is no point.
>>>
>>> OK, I get the point with legacy MSI. Then we have two other bugs to solve:
>>>  - in I-pipe as it holds a hardened spin lock across enable/disable (of
>>>    MSIs)
> 
> I think this bug may only manifest over ARM as that arch does
> enable/disable_irq() inside __ipipe_enable/disable_irqdesc - unless
> something prevents that enabling will ever happen for interrupts that
> need Linux locks to work. Is that assured?

I'm not referring to enable_irqdesc, but to the common programming
pattern of calling ipipe_request_irq from the same context than
ipipe_enable_irq (or directly the underlying irqchip handler for unmasking).

> 
>>>  - in Xenomai 2.6 (at least, didn't check forge) as it calls with a
>>>    hardened spin lock held into ipipe_virtualize_irq
> 
> This problem is something I vaguely recall we discussed before already
> in the past. I think there was no good solution for the Xenomai 2
> architecture.
> 

The main issue was about de-registering a handler, passing NULL. To
solve the SMP-specific issue of interrupt synchronization on all CPUs,
we would have to be able to disable the source, which may entail running
regular code, therefore restricting the valid calling context to root.

> In this light, let's remove those checks nevertheless.
> Enabling/disabling the IRQ are separate calls, and those should be
> instrumented as those cause the restriction.
> 

I don't see it this way, because we can't predict what will be the
constraints we might have for hooking irqs on all archs we will support.
Maybe we will have to run more mainline code in some cases. In any case,
we have to fold masking into the de-registration code for proper SMP
support - this fix was never finalized precisely because we could not
guarantee a root calling context in that case.

These checks are there to express the fact that calling from non-root is
inherently unsafe. We might find a (ugly) way to tag irq descriptors,
for knowing whether this is safe to call from non-root and test this
conditionally. But at the end of the day, we would still end up with
checking for arch-specific constraints in a generic API, which would be
wrong by design.

I put these checks when refactoring the pipeline API for the very same
reason than you agree to update the RTDM spec regarding
rtdm_request_irq: no sane code should have called ipipe_virtualize_irq()
from a non-root context. This is just about formalizing this fact.

>>
>> Sorry, three bugs:
>>  - in the RTDM spec as it always allowed rtdm_irq_request over RT task
>>    contexts
> 
> Changing the spec and adding a runtime check will likely be no issue. No
> sane driver should have made use of that option. I will file a patch.
> 

Ack.

> Jan
> 


-- 
Philippe.

