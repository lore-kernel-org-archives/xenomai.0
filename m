Message-ID: <501EDE60.5050307@xenomai.org>
Date: Sun, 05 Aug 2012 22:58:08 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <501B08FA.5090909@xenomai.org> <501BDD0F.20109@xenomai.org>
In-Reply-To: <501BDD0F.20109@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] I-pipe core 3.4
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <Xenomai@xenomai.org>

On 08/03/2012 04:15 PM, Philippe Gerum wrote:

> On 08/03/2012 01:10 AM, Gilles Chanteperdrix wrote:
>>
>> Hi Philippe,
>>
>> please find at the usual place:
>>
>> git://git.xenomai.org/ipipe-gch.git, branch for-core-3.4
>>
>> The current state of the I-pipe core patch for Linux 3.4 running on x86
>> and ARM. Compared to the last mail:
>> * several issues were fixed on ARM (with a severe one in switch_mm)
>> * some optimizations were made on x86 reducing drastically the latencies
>> on atom N230:
>> - the irq_hold handler for ioapic masks the irq line before sending the
>> eoi, avoiding the irq to be retriggered when the irq is of the level type
> 
> Gasp. This is a regression which sneaked in with the introduction of the 
> irq_hold handler in the 3.2 series.
> 
>> - the fpu is never restored during linux context switches, as it
>> increases the context switch irq masking time. I tried to further
>> decrease the context switch critical section by splitting the context
>> switch in three parts, and even by trying to run the context switch with
>> irqs on, to no avail.
>> * the I-pipe core API was changed, so the API revision was incremented
>> from 1 to 2:
>> - ipipe_timers_request now takes a cpumask argument specifying on which
>> cpus the timers should be requested
>> - the delay passed to ipipe_timer_set is now converted from clock
>> frequency to timer frequency, without a division, by the I-pipe.
>>
>> Issues observed:
>> - when running with the I-pipe tracer on on x86, and
>> CONFIG_IPIPE_TRACE_IRQSOFF is enabled, we get a kernel oops. That is
>> because the definition of the "interrupt" macros makes use of the "rbp"
>> register to restore some other registers values after the call to the
>> interrupt function, but rbp is set to 0 on irq entry starting with linux 3.4
> 
> Jan, would you have a fix for that one already in your local patch queue?
> 
>> - pic muting has an issue with unlocked context switches: when a context
>> swich from xenomai domain to root domain happens, low priorities irqs
>> are unmasked before the unmasked context switch, so may trigger, with a
>> timer interrupt at the same time triggering in fact a re-switch to the
>> xenomai domain. The cure seems to be, in __xnpod_schedule, to only call
>> xnarch_reenter_root after the test at the end of the unlocked switch, I
>> tried that, but got lockups on AT91. So, I must be missing something.
>>
> 
> Can't be a missing unmute in the shadow epilogue?
> 


No, the shadow epilogue is the epilogue of a call to schedule, not of a 
call to xnpod_schedule, so we can safely skip the xnarch_reenter root 
in that case. 

The problem is that the way at91 pic muting functions are written, each 
mute operation should be paired with an unmute operation. muting the 
gpios twice breaks everything. Skipping the xnarch_enter_root when we 
restart the context switch is not an option either because it breaks 
VFP floating points: since the restart is done after the call to 
__xnpod_switch_fpu, xnarch_leave_root must be called when restarting 
the context switch in order to take the new VFP state into account.

So the current solution is:
diff --git a/ksrc/nucleus/pod.c b/ksrc/nucleus/pod.c
index 5f53002..7ece686 100644
--- a/ksrc/nucleus/pod.c
+++ b/ksrc/nucleus/pod.c
@@ -2233,11 +2233,6 @@ reschedule:
 	(void)shadow;
 #endif /* CONFIG_XENO_OPT_PERVASIVE */
 
-	if (xnthread_test_state(next, XNROOT)) {
-		xnsched_reset_watchdog(sched);
-		xnfreesync();
-	}
-
 	if (zombie)
 		xnsched_zombie_hooks(prev);
 
@@ -2245,13 +2240,6 @@ reschedule:
 
 	if (xnthread_test_state(prev, XNROOT))
 		xnarch_leave_root(xnthread_archtcb(prev));
-	else if (xnthread_test_state(next, XNROOT)) {
-		if (testbits(sched->lflags, XNHTICK))
-			xnintr_host_tick(sched);
-		if (testbits(sched->lflags, XNHDEFER))
-			xntimer_next_local_shot(sched);
-		xnarch_enter_root(xnthread_archtcb(next));
-	}
 
 	xnstat_exectime_switch(sched, &next->stat.account);
 	xnstat_counter_inc(&next->stat.csw);
@@ -2306,9 +2294,24 @@ reschedule:
 	if (xnthread_signaled_p(curr))
 		xnpod_dispatch_signals();
 
-	if (switched &&
-	    xnsched_maybe_resched_after_unlocked_switch(sched))
-		goto reschedule;
+	if (switched) {
+		int is_root = xnthread_test_state(curr, XNROOT);
+
+		if (is_root)
+			xnarch_enter_root(xnthread_archtcb(curr));
+			
+		if (xnsched_maybe_resched_after_unlocked_switch(sched))
+			goto reschedule;
+
+		if (is_root) {
+			xnsched_reset_watchdog(sched);
+			xnfreesync();
+			if (testbits(sched->lflags, XNHTICK))
+				xnintr_host_tick(sched);
+			if (testbits(sched->lflags, XNHDEFER))
+				xntimer_next_local_shot(sched);
+		}
+	}
 
 	xnlock_put_irqrestore(&nklock, s);
 

Next step is to try moving the test and reschedule to a point 
prior to __xnpo_switch_fpu, so as to be able to skip 
xnarch_leave_root when restarting xnpod_schedule, to see if 
it gains anything.

-- 
                                                                Gilles.

