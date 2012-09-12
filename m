Message-ID: <5050CF03.1080005@xenomai.org>
Date: Wed, 12 Sep 2012 20:05:55 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1347469235-17712-1-git-send-email-wolfgang.mauerer@siemens.com>
	<1347469235-17712-4-git-send-email-wolfgang.mauerer@siemens.com>
In-Reply-To: <1347469235-17712-4-git-send-email-wolfgang.mauerer@siemens.com>
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
Cc: xenomai@xenomai.org

On 09/12/2012 07:00 PM, Wolfgang Mauerer wrote:

> Earlier kernels abused the frame pointer to store the
> old stack pointer in SAVE_ARGS_IRQ. This behaviour was
> changed in upstream commit a2bbe75089d, which breaks
> the IRQs-off tracing code for x86_64.
> 
> Fix this by basing the argument calculations for
> ipipe_trace_begin and ipipe_trace_end on the base
> pointer stored in %rsi.
> 
> Signed-off-by: Wolfgang Mauerer <wolfgang.mauerer@siemens.com>
> Tested-by: Gernot Hillier <gernot.hillier@siemens.com>
> ---
>  arch/x86/kernel/entry_64.S |    8 ++++++--
>  1 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/entry_64.S b/arch/x86/kernel/entry_64.S
> index b523908..693ad08 100644
> --- a/arch/x86/kernel/entry_64.S
> +++ b/arch/x86/kernel/entry_64.S
> @@ -869,6 +869,7 @@ END(interrupt)
>  	CFI_ADJUST_CFA_OFFSET ORIG_RAX-RBP
>  	SAVE_ARGS_IRQ
>  #ifdef CONFIG_IPIPE_TRACE_IRQSOFF
> +	/* SAVE_ARGS_IRQ places the frame pointer into %rdi */
>  	pushq %rbp
>  	leaq RIP-8(%rdi), %rbp	# make interrupted address show up in trace
>  	pushq %rdi
> @@ -877,13 +878,16 @@ END(interrupt)
>  	call ipipe_trace_begin
>  	popq %rdi
>  	popq %rbp
> +	pushq %rdi # Preserve the frame pointer...


Can't we do better than that? This looks redundant
pushq %rbp
pushq %rdi
...
popq %rdi
popq %rbp
pushq %rdi

It seems if %rdi was pushed before %rbp we would not need to pop it then
repush it, we could have:

pushq %rdi
pushq %rbp
...
popq %rbp
/* %rdi is fine here */


-- 
                                                                Gilles.

