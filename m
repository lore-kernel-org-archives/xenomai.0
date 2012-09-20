Message-ID: <505B2466.6010304@xenomai.org>
Date: Thu, 20 Sep 2012 16:12:54 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <505AF205.6010206@siemens.com> <505AF49D.6020905@xenomai.org>
	<505AF641.6030604@siemens.com> <505AF687.9010002@siemens.com>
	<505AFACC.1050802@siemens.com> <505B13B0.9020302@xenomai.org>
	<505B16EB.3040800@siemens.com>
In-Reply-To: <505B16EB.3040800@siemens.com>
Content-Type: text/plain; charset=UTF-8
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

On 09/20/2012 03:15 PM, Jan Kiszka wrote:
> On 2012-09-20 15:01, Gilles Chanteperdrix wrote:
>> On 09/20/2012 01:15 PM, Jan Kiszka wrote:
>>
>>> On 2012-09-20 12:57, Jan Kiszka wrote:
>>>> On 2012-09-20 12:56, Jan Kiszka wrote:
>>>>> On 2012-09-20 12:49, Philippe Gerum wrote:
>>>>>> On 09/20/2012 12:37 PM, Jan Kiszka wrote:
>>>>>>> This reverts commit 073ff1e8045d0311b8cf390687c0ba3619681672.
>>>>>>>
>>>>>>> Both service are NOT just root-only services. E.g., rtdm_irq_request
>>>>>>> requires by specification support also over non-Linux contexts.
>>>>>>
>>>>>> Nack. We can't run the enable code for MSIs over non-root, and
>>>>>> that code typically follows the irq request. Besides, we want to mask
>>>>>> the source upon irq free to handle the SMP case properly, which we could
>>>>>> not do from non-root with MSIs.
>>>>>>
>>>>>> So either we have both request+enable and free usable over non-root, or
>>>>>> there is no point.
>>>>>
>>>>> OK, I get the point with legacy MSI. Then we have two other bugs to solve:
>>>>>  - in I-pipe as it holds a hardened spin lock across enable/disable (of
>>>>>    MSIs)
>>>
>>> I think this bug may only manifest over ARM as that arch does
>>> enable/disable_irq() inside __ipipe_enable/disable_irqdesc - unless
>>> something prevents that enabling will ever happen for interrupts that
>>> need Linux locks to work. Is that assured?
>>
>>
>> ARM does that because otherwise interrupts are not enabled after a call
>> to eg. rtdm_irq_request, and calling rtdm_irq_enable does not work,
>> calling request_irq is required to get them working.
> 
> The generic pattern Xenomai currently uses is xnintr_attach +
> xnintr_enable. The latter happens to be rtdm_irq_enable as well. So,
> doesn't xnintr_enable work at all?

No. It has in fact, never worked before the I-pipe core. People had to
call request_irq before xnintr_attach.

> Or is it only not suited as interrupt
> startup? Then, is that a new issue or something core-3.x specific?
> Finally, can't we address it in xnarch_enable_irq?

This is a very old issue, that I had forgotten, and that bit me when I
tried to use a separate timer for Xenomai and Linux on omap3: because
the timer interrupt of a different timer has no corresponding linux
interrupt.

The problem is that irqs which are also used by Linux have to be treated
differently from irqs which are registered only for the linux domain.

-- 
					    Gilles.

