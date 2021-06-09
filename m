References: <e3039175-369c-4be9-c3c6-02f4756aff77@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [dovetail][PATCH] irq_pipeline: Mark inband stalled also on
 exceptions
In-reply-to: <e3039175-369c-4be9-c3c6-02f4756aff77@siemens.com>
Date: Wed, 09 Jun 2021 18:40:42 +0200
Message-ID: <875yyn6lf9.fsf@xenomai.org>
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

> From: Philippe Gerum <rpm@xenomai.org>
>
> Make sure that inband is marked stalled when entering from user mode,
> taking an exception.
>
> This affects x86 which is currently the only arch using generic
> irqentry_enter_from_user_mode on exceptions. It fixes this lockdep
> warning:
>
> DEBUG_LOCKS_WARN_ON(!lockdep_stage_disabled())
> WARNING: CPU: 2 PID: 1477 at ../kernel/locking/lockdep.c:4129 lockdep_hardirqs_on_prepare+0x160/0x1a0
>
> Signed-off-by: Philippe Gerum <rpm@xenomai.org>
> Tested-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>
> Works as it should here. If the wording is fine, please add.
>
>  kernel/entry/common.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/entry/common.c b/kernel/entry/common.c
> index 995123075375..51af58e61cb8 100644
> --- a/kernel/entry/common.c
> +++ b/kernel/entry/common.c
> @@ -343,6 +343,8 @@ __visible noinstr void syscall_exit_to_user_mode(struct pt_regs *regs)
>  
>  noinstr void irqentry_enter_from_user_mode(struct pt_regs *regs)
>  {
> +	WARN_ON_ONCE(irq_pipeline_debug() && irqs_disabled());
> +	stall_inband_nocheck();
>  	enter_from_user_mode(regs);
>  }
>  
> @@ -373,8 +375,6 @@ noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
>  
>  	if (user_mode(regs)) {
>  #ifdef CONFIG_IRQ_PIPELINE
> -		WARN_ON_ONCE(irq_pipeline_debug() && irqs_disabled());
> -		stall_inband_nocheck();
>  		ret.stage_info = IRQENTRY_INBAND_UNSTALLED;
>  #endif
>  		irqentry_enter_from_user_mode(regs);

Ok, picked it. Thanks.

-- 
Philippe.

