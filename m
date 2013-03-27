Message-ID: <5152C814.5010109@xenomai.org>
Date: Wed, 27 Mar 2013 11:21:08 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <5151F44F.3050306@siemens.com>
In-Reply-To: <5151F44F.3050306@siemens.com>
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

On 03/26/2013 08:17 PM, Jan Kiszka wrote:
> Hi Philippe,
>
> I'm trying to understand how the new Linux-to-RT migration process works
> under forge and specifically I-pipe core. It currently looks to me like
> we are delaying this needlessly:
>
> - __ipipe_migrate_head() suspends the calling Linux thread and triggers
>    a context switch
> - after the switch, __ipipe_switch_tail and then
>    complete_domain_migration is invoked
> - complete_domain_migration stalls head and calls ipipe_migration_hook.
>    We are still running over the root domain.
> - ipipe_migration_hook in forge wakes up the RT thread and calls
>    xnpod_schedule
> - as we are in root, xnarch_escalate triggers and calls ipipe_raise_irq
> - as the head domain is stalled, dispatch_irq_head just marks the
>    escalation VIRQ pending, not handler is called, no actual RT
>    rescheduling can be performed on its return
> - we eventually return to complete_domain_migration and simply clear
>    the stall flag. No pending IRQs are process, again no VIRQ is
>    delivered
> - only when we receive the next IRQ or have some other reason for
>    checking the head domain's IRQ log, the pending VIRQ will finally be
>    processed
>
> Did I miss something or should we actually perform some
> __ipipe_sync_stage in complete_domain_migration to accelerate the switch?
>

Yep. The current code wrongly assumes that we are covered by a root 
unstall from finish_task_switch -> finish_lock_switch, but we are not 
since the pipeline won't consider the head domain log when deciding 
whether irqs should be synced.

-- 
Philippe.

