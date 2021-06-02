References: <d38b6799-ed3e-f384-a70e-51c2d5170c73@siemens.com>
 <d4d00a44-a155-663d-d6c9-7135d2beedb8@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: Dovetail/x86 still broken /wrt exception fixups
In-reply-to: <d4d00a44-a155-663d-d6c9-7135d2beedb8@siemens.com>
Date: Wed, 02 Jun 2021 19:43:38 +0200
Message-ID: <87bl8ogo1h.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>


Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 01.06.21 23:24, Jan Kiszka via Xenomai wrote:
>> Hi Philippe,
>> 
>> we are leaking the inband stall state into user land when the kernel
>> takes a fixable exception in oob. The problem is either
>> cond_disable_irqs() or its (missing?) counterpart. Where is the stall
>> bit set in handle_page_fault->cond_disable_irqs supposed to be cleared
>> again?
>> 
>> I-pipe is fine in that regard, but it took us many years to get it into
>> that state - and it didn't have to deal with the impact of ca4c6a9858
>> ("x86/traps: Make interrupt enable/disable symmetric in C code") anymore...
>> 
>
> A first attempt to fix the issue, but I'm only half-way through with 
> understanding the related logic in dovetail:
>
> diff --git a/kernel/entry/common.c b/kernel/entry/common.c
> index 5e33248453e7..9f8c51e5f51c 100644
> --- a/kernel/entry/common.c
> +++ b/kernel/entry/common.c
> @@ -526,7 +526,8 @@ noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
>  	 * irqentry_enter() raised it in order to mirror the hardware
>  	 * state.
>  	 */
> -	if (state.stage_info & IRQENTRY_INBAND_STALLED)
> +	if (state.stage_info == IRQENTRY_INBAND_STALLED ||
> +	    (running_inband() && state.stage_info == IRQENTRY_OOB_ENTRY))
>  		unstall_inband();

You can drop the check for running_inband(), this is always true at this
point.

>  #endif
>  	return;
>
> State seems now consistent again.
>

Yes, that should cover the case described earlier.

> BTW, all those tests for bits in stage_info should likely be converted 
> to testing for the state - IRQENTRY_INBAND_STALLED and IRQENTRY_OOB_ENTRY 
> are mutually exclusive. Would make the code more readable.
>

Ack.

-- 
Philippe.

