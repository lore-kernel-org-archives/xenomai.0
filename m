Message-ID: <5051AA22.2030107@xenomai.org>
Date: Thu, 13 Sep 2012 11:40:50 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1347469235-17712-1-git-send-email-wolfgang.mauerer@siemens.com>
	<1347469235-17712-4-git-send-email-wolfgang.mauerer@siemens.com>
	<505180A8.2010100@xenomai.org> <50519D74.1060801@siemens.com>
In-Reply-To: <50519D74.1060801@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH 3/3] Fix IRQs-off-tracer for x86_64
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wolfgang Mauerer <wolfgang.mauerer@siemens.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 09/13/2012 10:46 AM, Wolfgang Mauerer wrote:
> On 13/09/12 08:43, Gilles Chanteperdrix wrote:
>> On 09/12/2012 07:00 PM, Wolfgang Mauerer wrote:
>>
>>> Earlier kernels abused the frame pointer to store the
>>> old stack pointer in SAVE_ARGS_IRQ. This behaviour was
>>> changed in upstream commit a2bbe75089d, which breaks
>>> the IRQs-off tracing code for x86_64.
>>>
>>> Fix this by basing the argument calculations for
>>> ipipe_trace_begin and ipipe_trace_end on the base
>>> pointer stored in %rsi.
>>>
>>> Signed-off-by: Wolfgang Mauerer <wolfgang.mauerer@siemens.com>
>>> Tested-by: Gernot Hillier <gernot.hillier@siemens.com>
>>> ---
>>>  arch/x86/kernel/entry_64.S |    8 ++++++--
>>>  1 files changed, 6 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/x86/kernel/entry_64.S b/arch/x86/kernel/entry_64.S
>>> index b523908..693ad08 100644
>>> --- a/arch/x86/kernel/entry_64.S
>>> +++ b/arch/x86/kernel/entry_64.S
>>> @@ -869,6 +869,7 @@ END(interrupt)
>>>  	CFI_ADJUST_CFA_OFFSET ORIG_RAX-RBP
>>>  	SAVE_ARGS_IRQ
>>>  #ifdef CONFIG_IPIPE_TRACE_IRQSOFF
>>> +	/* SAVE_ARGS_IRQ places the frame pointer into %rdi */
>>>  	pushq %rbp
>>>  	leaq RIP-8(%rdi), %rbp	# make interrupted address show up in trace
>>>  	pushq %rdi
>>> @@ -877,13 +878,16 @@ END(interrupt)
>>>  	call ipipe_trace_begin
>>>  	popq %rdi
>>>  	popq %rbp
>>> +	pushq %rdi # Preserve the frame pointer...
>>>  
>>>  	call \func
>>>  
>>> +	popq %rdi # ...  across the function call
>>>  	pushq %rbp
>>>  	pushq %rax
>>> -	movq 8-ARGOFFSET+ORIG_RAX(%rbp), %rdi
>>> -	leaq 8-ARGOFFSET+RIP-8(%rbp), %rbp
>>> +	/* Show interrupted address and IRQ number in the trace, as before */
>>> +	leaq RIP-8(%rdi), %rbp
>>> +	movq ORIG_RAX(%rdi), %rdi
>>>  	notq %rdi
>>>  	call ipipe_trace_end
>>>  	popq %rax
>>
>>
>> Looking at that again, it seems we do not need to push %rbp or %rdi, 
>> %rdi can be computed from %rsp and %rbp was already saved on stack by 
>> SAVE_ARGS_IRQ.
>>
>> So, I propose the following:
>> /* 0(%rsp): ~(interrupt number) */
>> 	.macro interrupt func
>> 	/* reserve pt_regs for scratch regs and rbp */
>> 	subq $ORIG_RAX-RBP, %rsp
>> 	CFI_ADJUST_CFA_OFFSET ORIG_RAX-RBP
>> 	SAVE_ARGS_IRQ
>> #ifdef CONFIG_IPIPE_TRACE_IRQSOFF
>> 	/* pt_regs is %rdi or %rsp + 8-RBP */
>> 	movq ORIG_RAX+8-RBP(%rsp), %rdi # IRQ number
>> 	leaq RIP-8+8-RBP(%rsp), %rbp  # make interrupted address show up in trace
>> 	notq %rdi			# IRQ number is inverted, fix up
>> 	call ipipe_trace_begin
>> 	leaq 8-RBP(%rsp),%rdi
>> 	movq RBP+8-RBP(%rsp), %rbp
>>
>> 	call \func
>>
>> 	/* Show interrupted address and IRQ number in the trace, as before */
>> 	movq ORIG_RAX+8-RBP(%rsp), %rdi
>> 	leaq RIP-8+8-RBP(%rsp), %rbp
>> 	pushq %rax
>> 	notq %rdi
>> 	call ipipe_trace_end
>> 	popq %rax
>> 	movq RBP+8-RBP(%rsp), %rbp
>> #else
>> 	call \func
>> #endif
>> 	.endm
>>
> 
> that fixes the bug, too -- thanks. However, I deliberately spent some
> extra assembler code (5 insns compared to your approach) to make the
> code easier to  understand (the overall size of the resulting kernel
> binary is identical for both approaches on my machine, btw.). Since the
> overhead of 5 instructions is negligible compared to the two calls of
> __ipipe_trace that are necessary in any case, I'd argue that the more
> straightforward code is beneficial in the long run, but that's for the
> maintainers to decide.

To the contrary, the profusion of pushq and popq looked confusing to me,
I wondered why so many were needed, so, I guess it is all a matter of taste.

-- 
					    Gilles.

