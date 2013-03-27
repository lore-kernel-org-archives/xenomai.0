Message-ID: <5152C8FC.10705@xenomai.org>
Date: Wed, 27 Mar 2013 11:25:00 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <5151F44F.3050306@siemens.com> <5151F730.4090507@siemens.com>
In-Reply-To: <5151F730.4090507@siemens.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] New domain migration process with ipipe-core and forge
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On 03/26/2013 08:29 PM, Jan Kiszka wrote:
> On 2013-03-26 20:17, Jan Kiszka wrote:
>> Hi Philippe,
>>
>> I'm trying to understand how the new Linux-to-RT migration process works
>> under forge and specifically I-pipe core. It currently looks to me like
>> we are delaying this needlessly:
>>
>> - __ipipe_migrate_head() suspends the calling Linux thread and triggers
>>    a context switch
>> - after the switch, __ipipe_switch_tail and then
>>    complete_domain_migration is invoked
>> - complete_domain_migration stalls head and calls ipipe_migration_hook.
>>    We are still running over the root domain.
>> - ipipe_migration_hook in forge wakes up the RT thread and calls
>>    xnpod_schedule
>> - as we are in root, xnarch_escalate triggers and calls ipipe_raise_irq
>> - as the head domain is stalled, dispatch_irq_head just marks the
>>    escalation VIRQ pending, not handler is called, no actual RT
>>    rescheduling can be performed on its return
>> - we eventually return to complete_domain_migration and simply clear
>>    the stall flag. No pending IRQs are process, again no VIRQ is
>>    delivered
>> - only when we receive the next IRQ or have some other reason for
>>    checking the head domain's IRQ log, the pending VIRQ will finally be
>>    processed
>>
>> Did I miss something or should we actually perform some
>> __ipipe_sync_stage in complete_domain_migration to accelerate the switch?
>
> Or rather this:
>
> diff --git a/kernel/ipipe/core.c b/kernel/ipipe/core.c
> index 53e82ef..d164b4c 100644
> --- a/kernel/ipipe/core.c
> +++ b/kernel/ipipe/core.c
> @@ -1102,6 +1102,7 @@ static void complete_domain_migration(void) /* hw IRQs off */
>   	__set_bit(IPIPE_STALL_FLAG, &p->status);
>   	ipipe_migration_hook(t);
>   	__clear_bit(IPIPE_STALL_FLAG, &p->status);
> +	__ipipe_do_sync_pipeline(p->domain);
>   }
>
>   #endif /* !CONFIG_IPIPE_LEGACY */
>

Nitpicking: in theory, the code should expect the migration hook to have 
actually done the work, and not delayed it like Xenomai currently does 
in practice. A safer check would be as follows, allowing further 
arch-dependent handling in case the migration did succeed (typically for 
Blackfin):

diff --git a/kernel/ipipe/core.c b/kernel/ipipe/core.c
index 96b3a98..c4598ad 100644
--- a/kernel/ipipe/core.c
+++ b/kernel/ipipe/core.c
@@ -1102,6 +1102,8 @@ static void complete_domain_migration(void) /* hw 
IRQs off */
  	__set_bit(IPIPE_STALL_FLAG, &p->status);
  	ipipe_migration_hook(t);
  	__clear_bit(IPIPE_STALL_FLAG, &p->status);
+	if (__ipipe_ipending_p(p))
+		__ipipe_sync_pipeline(p->domain);
  }

  #endif /* !CONFIG_IPIPE_LEGACY */

-- 
Philippe.

