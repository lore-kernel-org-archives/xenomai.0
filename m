References: <54778F5D.1060009@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <9f57cb14-de95-2cae-3eb7-d204cc17201b@siemens.com>
Date: Thu, 8 Dec 2016 18:07:57 +0100
MIME-Version: 1.0
In-Reply-To: <54778F5D.1060009@siemens.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] x86/ipipe: Fix root state on return from
 certain exceptions
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>, Philippe Gerum <rpm@xenomai.org>

On 2014-11-27 21:53, Jan Kiszka wrote:
> do_stack_segment, do_int3 and do_debug disable interrupts of the root
> domain before returning the exception trampoline code. However, I-ipipe
> does not update the root state before returning from exceptions. So we
> erroneously stalled root this way, specifically during gdb sessions. The
> issue was easily triggerable by enabling CONFIG_DEBUG_ATOMIC_SLEEP and
> then trying to debug a program.
> 
> This now simply disables physical interrupts and leaves the root state
> untouched across exception return.
> 
> Note: There is also conditional_cli, but that's unused by Linux.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
> 
> For review. Still not totally sure if there aren't more of such corner
> cases or if this can have some side effect.
> 
>  arch/x86/kernel/traps.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index c086b59..f78f79c 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -102,7 +102,16 @@ static inline void conditional_cli(struct pt_regs *regs)
>  static inline void preempt_conditional_cli(struct pt_regs *regs)
>  {
>  	if (regs->flags & X86_EFLAGS_IF)
> -		local_irq_disable();
> +		/*
> +		 * I-pipe doesn't virtualize the IRQ flags in the entry code.
> +		 * Therefore we cannot call the original local_irq_disable here
> +		 * because there will be no pairing IRQ enable for the root
> +		 * domain. So just disable interrupts physically.
> +		 *
> +		 * There is also no I-pipe hard-irq tracing on return from the
> +		 * exception, so do not trace here either.
> +		 */
> +		hard_local_irq_disable_notrace();
>  	preempt_count_dec();
>  }
>  
> 

Just noticed, after debugging the same issue over 4.4 again, that this
patch never made it into anything but 3.14. Only fair that it hits me
again, I should have pushed harder back then...

Loosing such fixes between the maintained stable branches is too easy
when patches aren't filed against a development head first, and only
ported back afterwards.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux

