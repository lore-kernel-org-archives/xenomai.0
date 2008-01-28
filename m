Message-ID: <479D7D48.1050200@domain.hid>
Date: Mon, 28 Jan 2008 07:59:20 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4788C279.1020607@domain.hid> <479A5D78.6040701@domain.hid>
	<479CA23F.7000601@domain.hid>
In-Reply-To: <479CA23F.7000601@domain.hid>
Content-Type: multipart/mixed; boundary="------------030803010003010508020009"
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Adeos-main] [BUG] evsync is not SMP-safe
Reply-To: rpm@xenomai.org
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main <adeos-main@gna.org>

This is a multi-part message in MIME format.
--------------030803010003010508020009
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Jan Kiszka wrote:
> Jan Kiszka wrote:
>> Jan Kiszka wrote:
>>> Philippe,
>>>
>>> this
>>>
>>> int fastcall __ipipe_dispatch_event (unsigned event, void *data)
>>> ...
>>> 	ipipe_cpudom_var(next_domain, evsync) |= (1LL << event);
>>> 	local_irq_restore_hw(flags);
>>> 	propagate = !evhand(event, start_domain, data);
>>> 	local_irq_save_hw(flags);
>>> 	ipipe_cpudom_var(next_domain, evsync) &= ~(1LL << event);
>>>
>>> doesn't fly on SMP. While the invoked event handler is running, it may
>>> happen that the caller gets migrated to another CPU. The result is an
>>> inconsistent evsync state that causes ipipe_catch_event to stall (test
>>> case: invoke Jerome's system() test a few times, them try to unload
>>> Xenomai skins and nucleus).
>>>
>>> First idea (I've nothing implemented to far, would happily leave it to
>>> someone else's hand): Track event handler entry/exit with an, say, 8 bit
>>> per-cpu counter. On event deregistration, just summarize over the
>>> per-cpu counters and wait for the sum to become 0. This has just the
>>> drawback that it may cause livelocks on large SMP boxes when trying to
>>> wait for a busy event. I've no perfect idea so far.
>> Second approach to solve this (currently) last known ipipe issue cleanly:
>>
>> As long as some task in the system has __ipipe_dispatch_event (and thus
>> some of the registered event handlers) on its stack, it is not safe to
>> unregister some handler. For simplicity reasons, I don't think we should
>> make any difference which handlers are precisely busy. So, how to find
>> out if there are such tasks?
>>
>> I checked the code and derived three classes of preconditions for the
>> invocation of __ipipe_dispatch_event:
>>
>>  1) ipipe_init_notify and ipipe_cleanup_notify -> no preconditions
>>
>>  2) ipipe_trap_notify -> some Linux task has PF_EVNOTIFY set or
>>                          there are tasks with custom stacks present
>>
>>  3) all other invocations -> some Linux task has PF_EVNOTIFY set

4) ipipe_syscall_watched_p used in syscall pipelining -> PF_EVNOTIFY ||
non-regular syscall

>>
>> This means by walking the full Linux task list and checking that are no
>> more PF_EVNOTIFY-tasks present, we can easily exclude 3). In fact, 2)
>> can also be excluded this way because we can reasonably demand that any
>> I-pipe user fiddling with event handlers has killed all non-Linux tasks
>> beforehand.
>> This leaves us with 1) which should be handled via classic
>> RCU as Linux offers it. Viable? It would even shorten the fast path a bit!
>>
>> Still no code, I would like to collect feedback on this new idea first.
> 
> OK, here is some code. Seems to work fine (now that I fixed the cleanup
> race in Xenomai as well - the issue happened to pop up right after
> applying this patch :-/).
> 

This patch changes the predicate from "a given registered handler should
no be currently running" to "no task in the system should be currently
asking for any kind of I-pipe notification", which has not quite the
same scope. For instance, we could no more deregister a handler only for
a particular event leaving others installed. It becomes an "all or
nothing" test, even if that still remains compatible with the way
Xenomai works though.

However, we have a real problem with the syscall event. This one has an
additional precondition to PF_EVNOTIFY which is unfortunately dynamic,
i.e. syscall_nr >= NR_SYSCALL. This is used to relay non-regular
syscalls to whoever it may concern in the pipeline, when PF_EVNOTIFY is
not set. Xenomai uses this property for its shadow binding syscall,
which will eventually set PF_EVNOTIFY for the caller. IOW, an attempt to
bind to the skin from userland while the nucleus is deregistering the
syscall handler would escape the RCU sync with the current patch.

But holding a read-side RCU lock to postpone the quiescent RCU
state won't fly, since the syscall handler may reschedule Linux-wise.

Looking back at the actual issue, we only have a single case to handle
for the current code to be correct: detect when a handler appears to
linger indefinitely on a given CPU (albeit it does not really), due to a
migration.

This should be done in a way that does not require complex
locking/tracking on the fast path since we are really dealing with a
corner case here. The attached patch does this by allowing a grace
period before assuming that the handler will never complete on the
current CPU, looking for some quiescent state. The latter part is almost
overkill, since clearing the handler in the domain struct already avoids
livelocking and would prevent such a handler to be fired quite early
anyway. The underlying assumption is that tasks which should be notified
of system events will be killed before someone attempts to deregister
the event handlers they rely on, so they should not be able to run/sleep
more than the grace period on behalf of the notifier.

Does this patch also fix the case you pointed out?

-- 
Philippe.








--------------030803010003010508020009
Content-Type: text/x-diff;
 name="evsync.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="evsync.patch"

diff --git a/include/linux/ipipe_percpu.h b/include/linux/ipipe_percpu.h
index 4b4d1f5..5d1b88d 100644
--- a/include/linux/ipipe_percpu.h
+++ b/include/linux/ipipe_percpu.h
@@ -34,6 +34,7 @@ struct ipipe_percpu_domain_data {
 	unsigned long irqheld_mask[IPIPE_IRQ_IWORDS];
 	unsigned long irqall[IPIPE_NR_IRQS];
 	u64 evsync;
+	int evstamp;
 };
 
 #ifdef CONFIG_SMP
diff --git a/kernel/ipipe/core.c b/kernel/ipipe/core.c
index 3a7b4d9..3baa443 100644
--- a/kernel/ipipe/core.c
+++ b/kernel/ipipe/core.c
@@ -262,6 +262,7 @@ void __ipipe_init_stage(struct ipipe_domain *ipd)
 			ipipe_percpudom(ipd, irqall, cpu)[n] = 0;
 
 		ipipe_percpudom(ipd, evsync, cpu) = 0;
+		ipipe_percpudom(ipd, evstamp, cpu) = 0;
 	}
 
 	for (n = 0; n < IPIPE_NR_IRQS; n++) {
@@ -827,6 +828,7 @@ int fastcall __ipipe_dispatch_event (unsigned event, void *data)
 			propagate = !evhand(event, start_domain, data);
 			local_irq_save_hw(flags);
 			ipipe_cpudom_var(next_domain, evsync) &= ~(1LL << event);
+			ipipe_cpudom_var(next_domain, evstamp)++;
 			if (ipipe_current_domain != next_domain)
 				this_domain = ipipe_current_domain;
 		}
@@ -1251,8 +1253,8 @@ ipipe_event_handler_t ipipe_catch_event(struct ipipe_domain *ipd,
 					ipipe_event_handler_t handler)
 {
 	ipipe_event_handler_t old_handler;
+	int self = 0, cpu, evstamp;
 	unsigned long flags;
-	int self = 0, cpu;
 
 	if (event & IPIPE_EVENT_SELF) {
 		event &= ~IPIPE_EVENT_SELF;
@@ -1305,8 +1307,18 @@ ipipe_event_handler_t ipipe_catch_event(struct ipipe_domain *ipd,
 		 */
 
 		for_each_online_cpu(cpu) {
-			while (ipipe_percpudom(ipd, evsync, cpu) & (1LL << event))
+			/*
+			 * We allow a grace period of 1s for the
+			 * handler to complete, before assuming that
+			 * it will never do so on the current CPU
+			 * because of a migration.
+			 */
+			evstamp = ipipe_percpudom(ipd, evstamp, cpu);
+			do {
+				if ((ipipe_percpudom(ipd, evsync, cpu) & (1LL << event)) == 0)
+					break;
 				schedule_timeout_interruptible(HZ / 50);
+			} while(++evstamp - ipipe_percpudom(ipd, evstamp, cpu) < 50);
 		}
 	}
 

--------------030803010003010508020009--

