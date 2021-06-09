References: <7bd62ff7-0f90-d881-4a5f-7a80091aa321@siemens.com>
 <87eedb6n9q.fsf@xenomai.org>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: dovetail: DEBUG_LOCKS_WARN_ON(!lockdep_stage_disabled())
In-reply-to: <87eedb6n9q.fsf@xenomai.org>
Date: Wed, 09 Jun 2021 18:03:47 +0200
Message-ID: <87bl8f6n4s.fsf@xenomai.org>
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


Philippe Gerum <rpm@xenomai.org> writes:

> Jan Kiszka <jan.kiszka@siemens.com> writes:
>
>> Hi Philippe,
>>
>> currently trying to understand [1]: The check in
>> lockdep_hardirqs_on_prepare triggers, e.g. over exc_int3 ->
>> do_int3_user, and then on cond_local_irq_enable().
>>
>> Where should have the current stage be stalled after exc_int3 so that
>> lockdep is happy?
>>
>
> Nowhere. v5.8 introduced irqentry_enter_from_user_mode() which raw
> (debug) traps invoke directly, and this one does not reconcile the hard
> irq state with the stall bit.
>
>> Interestingly, I do not get this with my local .config, and I still
>> didn't find the switches that make the difference.
>>
>> Jan
>>
>> [1] https://source.denx.de/Xenomai/xenomai-images/-/jobs/276895#L946

Something like this may help:

diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 4e81c0c03e5726a..b52f4ac50fd04bb 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -343,6 +343,8 @@ __visible noinstr void syscall_exit_to_user_mode(struct pt_regs *regs)
 
 noinstr void irqentry_enter_from_user_mode(struct pt_regs *regs)
 {
+	WARN_ON_ONCE(irq_pipeline_debug() && irqs_disabled());
+	stall_inband_nocheck();
 	enter_from_user_mode(regs);
 }
 
@@ -373,8 +375,6 @@ noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
 
 	if (user_mode(regs)) {
 #ifdef CONFIG_IRQ_PIPELINE
-		WARN_ON_ONCE(irq_pipeline_debug() && irqs_disabled());
-		stall_inband_nocheck();
 		ret.stage_info = IRQENTRY_INBAND_UNSTALLED;
 #endif
 		irqentry_enter_from_user_mode(regs);

-- 
Philippe.

