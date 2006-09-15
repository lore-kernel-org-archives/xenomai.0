From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <b647ffbd0609141512t47b1835em49c9873985aa5fb3@domain.hid>
References: <58168.129.217.4.64.1158067468.squirrel@domain.hid>
	<1158091876.5020.8.camel@domain.hid>
	<b647ffbd0609121358v5b5bff80o6e4e08c859eb110a@domain.hid>
	<450727D1.6060203@domain.hid> <4507C49A.5070909@domain.hid>
	<b647ffbd0609140055t328fec1fi3b5d86da178d790e@domain.hid>
	<1158223595.5040.16.camel@domain.hid>
	<b647ffbd0609141512t47b1835em49c9873985aa5fb3@domain.hid>
Content-Type: text/plain
Date: Fri, 15 Sep 2006 10:21:51 +0200
Message-Id: <1158308512.5009.35.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: [Xenomai-help] Bad EIP kernel-Oops
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

On Fri, 2006-09-15 at 00:12 +0200, Dmitry Adamushko wrote:

[...]

> 
> And it's not a good idea to get ipipe_catch_event() buzy spinning as
> (as I understand) ipipe_dispatch_event() may take, in general, an
> unbounded amount of time.
> 

Actually, this is not an issue, since there is no requirement for
bounded execution time in ipipe_catch_event(). This call is part of the
initialization chores, it is not meant as being deterministic.

> Ok, some more weird thoughts on top of my mind. I hope the idea is
> clear, notwithstanding my description that can be not that clear but
> hey... it's a late hour :)
> 
> ----
> 
> ipipe_dispatch_event()
> {
> 
> ...
> 
>    ipipe_lock_cpu(flags);
> 
>    start_domain = this_domain = ipipe_percpu_domain[cpuid];
> 
>    list_for_each_safe(pos,npos,&__ipipe_pipeline) {
> 
>         next_domain = list_entry(pos,struct ipipe_domain,p_link);
> 
> +       event_handler = next_domain->evhand[event];
> 
>         if (next_domain->evhand[event] != NULL) {
>                 ipipe_percpu_domain[cpuid] = next_domain;
> +               atomic_inc(&somewhere_stored->counter);
>                 ipipe_unlock_cpu(flags);
> 
> -               propagate = !
> next_domain->evhand[event](event,start_domain,data);
> +               propagate = !event_handler(...);
> 
> 
>               ipipe_lock_cpu(flags);
> +               if (atomic_dec(&somewhere_stored->counter) == 0)
> +                               send_virtual_irq(virt_irq, EVENT_TYPE,
> arg); // do it per interested domain
> ...

This is going to hurt whenever the handler suspends or even kills the
current context, e.g. think of a fault handling in xnpod_trap_fault over
a kernel-based Xenomai thread context. In such a case, the counter would
never be decremented; we could clear the counter/flag of the outgoing
domain upon domain switch, so that it disappears when it is not relevant
anymore.

> }
> 
> then ipipe_catch_event(..., NULL); should do something along the
> following lines :
> 
> ipipe_catch_event()
> {
> ...
> 
>         lock() ; // not sure, it's even necessary
> 

We could take the critical lock, just for the section that actually
clears the handler and resets the event flags, so that either
__ipipe_dispatch_event on any CPU sees a null handler and discards the
invocation, or a non-null one and fires it, with the added guarantee
that the target code won't be unmapped under its feet. The locking would
not cover the event handler invocation proper, to keep latencies low.

>         set ipd->evhand[event] to NULL;
> 
>         unlock();
> 
> 
>         // gets blocked
>         ipipe_get_synched(EVENT_TYPE, arg);
> 
> ...
> }
> 
> ipipe_gets_synched()
> -  lock
> -  if somewhere_stored->counter != 0
> - adds a caller to some wait queue (impl. depends on domain)
> - unlock
> 
> - gets blocked.
> 
> 
> virtual_irq_handler()
> 
> - lock
> - wakeup_all_blocked for a given EVENT_TYPE and domain
> - unlock

The virtual IRQ looks overkill, if we admit that we only want to solve
the Linux domain + null handler case in ipipe_catch_event(); the latter
could simply poll the counter using schedule_timeout(), since we don't
care how long it needs to complete anyway. Another idea is to provide a
per-CPU, per-event flag for detecting undergoing calls to each event
handler, that we could test in ipipe_catch_event(); once a handler has
been cleared, the associated flag could never be raised again,
protecting the code against livelocking (unless some guy spuriously
calls ipipe_catch_event again for the same event with a non-null handler
in the meantime, but in such a case, it would be more like a usage
issue, not an Adeos bug).

Here is a tentative implementation that seems to work on UP, but still
needs to be tested over SMP. Patch is against 2.6.17-1.3-10:

--- 2.6.17-ipipe-1.3-10/include/linux/ipipe.h	2006-09-15 10:13:15.000000000 +0200
+++ 2.6.17-ipipe/include/linux/ipipe.h	2006-09-14 20:06:38.000000000 +0200
@@ -50,12 +50,14 @@
 #define IPIPE_SPRINTK_FLAG	0	/* Synchronous printk() allowed */
 #define IPIPE_AHEAD_FLAG	1	/* Domain always heads the pipeline */
 
+/* Per-cpu pipeline status */
 #define IPIPE_STALL_FLAG	0	/* Stalls a pipeline stage -- guaranteed at bit #0 */
 #define IPIPE_SYNC_FLAG	1	/* The interrupt syncer is running for the domain */
 #define IPIPE_NOSTACK_FLAG	2	/* Domain currently runs on a foreign stack */
 
 #define IPIPE_SYNC_MASK		(1 << IPIPE_SYNC_FLAG)
 
+/* Interrupt control bits */
 #define IPIPE_HANDLE_FLAG	0
 #define IPIPE_PASS_FLAG		1
 #define IPIPE_ENABLE_FLAG	2
@@ -149,6 +151,7 @@ struct ipipe_domain {
 			unsigned long pending_hits;
 			unsigned long total_hits;
 		} irq_counters[IPIPE_NR_IRQS];
+		unsigned long long evsync;
 	} ____cacheline_aligned_in_smp cpudata[IPIPE_NR_CPUS];
 
 	struct {
@@ -409,6 +412,7 @@ static inline void __ipipe_switch_to(str
 	 * pipeline (and obviously different).
 	 */
 
+	out->cpudata[cpuid].evsync = 0LL;
 	ipipe_percpu_domain[cpuid] = in;
 
 	ipipe_suspend_domain();	/* Sync stage and propagate interrupts. */
diff -uNrp 2.6.17-ipipe-1.3-10/kernel/ipipe/core.c 2.6.17-ipipe/kernel/ipipe/core.c
--- 2.6.17-ipipe-1.3-10/kernel/ipipe/core.c	2006-09-15 10:13:15.000000000 +0200
+++ 2.6.17-ipipe/kernel/ipipe/core.c	2006-09-14 20:09:22.000000000 +0200
@@ -105,6 +105,8 @@ void __ipipe_init_stage(struct ipipe_dom
 			ipd->cpudata[cpuid].irq_counters[n].total_hits = 0;
 			ipd->cpudata[cpuid].irq_counters[n].pending_hits = 0;
 		}
+
+		ipd->cpudata[cpuid].evsync = 0LL;
 	}
 
 	for (n = 0; n < IPIPE_NR_IRQS; n++) {
@@ -116,7 +118,7 @@ void __ipipe_init_stage(struct ipipe_dom
 	for (n = 0; n < IPIPE_NR_EVENTS; n++)
 		ipd->evhand[n] = NULL;
 
-	ipd->evself = 0;
+	ipd->evself = 0LL;
 
 #ifdef CONFIG_SMP
 	ipd->irqs[IPIPE_CRITICAL_IPI].acknowledge = &__ipipe_ack_system_irq;
@@ -565,20 +567,22 @@ int ipipe_virtualize_irq(struct ipipe_do
 	ipd->irqs[irq].acknowledge = acknowledge;
 	ipd->irqs[irq].control = modemask;
 
-	if (irq < NR_IRQS &&
-	    handler != NULL &&
-	    !ipipe_virtual_irq_p(irq) && (modemask & IPIPE_ENABLE_MASK) != 0) {
-		if (ipd != ipipe_current_domain) {
-			/* IRQ enable/disable state is domain-sensitive, so we may
-			   not change it for another domain. What is allowed
-			   however is forcing some domain to handle an interrupt
-			   source, by passing the proper 'ipd' descriptor which
-			   thus may be different from ipipe_current_domain. */
-			err = -EPERM;
-			goto unlock_and_exit;
-		}
+	if (irq < NR_IRQS && handler != NULL && !ipipe_virtual_irq_p(irq)) {
+		__ipipe_enable_irqdesc(irq);
 
-		__ipipe_enable_irq(irq);
+		if ((modemask & IPIPE_ENABLE_MASK) != 0) {
+			if (ipd != ipipe_current_domain) {
+				/* IRQ enable/disable state is domain-sensitive, so we may
+				   not change it for another domain. What is allowed
+				   however is forcing some domain to handle an interrupt
+				   source, by passing the proper 'ipd' descriptor which
+				   thus may be different from ipipe_current_domain. */
+				err = -EPERM;
+				goto unlock_and_exit;
+			}
+			
+			__ipipe_enable_irq(irq);
+		}
 	}
 
 	err = 0;
@@ -638,6 +642,7 @@ int ipipe_control_irq(unsigned irq, unsi
 int fastcall __ipipe_dispatch_event (unsigned event, void *data)
 {
 	struct ipipe_domain *start_domain, *this_domain, *next_domain;
+	ipipe_event_handler_t evhand;
 	struct list_head *pos, *npos;
 	unsigned long flags;
 	ipipe_declare_cpuid;
@@ -649,8 +654,6 @@ int fastcall __ipipe_dispatch_event (uns
 
 	list_for_each_safe(pos,npos,&__ipipe_pipeline) {
 
-		next_domain = list_entry(pos,struct ipipe_domain,p_link);
-
 		/*
 		 * Note: Domain migration may occur while running
 		 * event or interrupt handlers, in which case the
@@ -659,11 +662,22 @@ int fastcall __ipipe_dispatch_event (uns
 		 * care for that, always tracking the current domain
 		 * descriptor upon return from those handlers.
 		 */
-		if (next_domain->evhand[event] != NULL)	{
+		next_domain = list_entry(pos,struct ipipe_domain,p_link);
+
+		/*
+		 * Keep a cached copy of the handler's address since
+		 * ipipe_catch_event() may clear it under our feet.
+		 */
+
+		evhand = next_domain->evhand[event];
+
+		if (evhand != NULL) {
 			ipipe_percpu_domain[cpuid] = next_domain;
+			next_domain->cpudata[cpuid].evsync |= (1LL << event);
 			ipipe_unlock_cpu(flags);
-			propagate = !next_domain->evhand[event](event,start_domain,data);
+			propagate = !evhand(event,start_domain,data);
 			ipipe_lock_cpu(flags);
+			next_domain->cpudata[cpuid].evsync &= ~(1LL << event);
 			if (ipipe_percpu_domain[cpuid] != next_domain)
 				this_domain = ipipe_percpu_domain[cpuid];
 		}
diff -uNrp 2.6.17-ipipe-1.3-10/kernel/ipipe/generic.c 2.6.17-ipipe/kernel/ipipe/generic.c
--- 2.6.17-ipipe-1.3-10/kernel/ipipe/generic.c	2006-09-15 10:13:15.000000000 +0200
+++ 2.6.17-ipipe/kernel/ipipe/generic.c	2006-09-14 20:09:09.000000000 +0200
@@ -269,7 +269,8 @@ ipipe_event_handler_t ipipe_catch_event(
 					ipipe_event_handler_t handler)
 {
 	ipipe_event_handler_t old_handler;
-	int self = 0;
+	unsigned long flags;
+	int self = 0, cpuid;
 
 	if (event & IPIPE_EVENT_SELF) {
 		event &= ~IPIPE_EVENT_SELF;
@@ -279,6 +280,8 @@ ipipe_event_handler_t ipipe_catch_event(
 	if (event >= IPIPE_NR_EVENTS)
 		return NULL;
 
+	flags = ipipe_critical_enter(NULL);
+
 	if (!(old_handler = xchg(&ipd->evhand[event],handler)))	{
 		if (handler) {
 			if (self)
@@ -299,6 +302,31 @@ ipipe_event_handler_t ipipe_catch_event(
 			__ipipe_event_monitors[event]--;
 			ipd->evself |= (1LL << event);
 	}
+	
+	ipipe_critical_exit(flags);
+
+	if (!handler && ipipe_root_domain_p) {
+		/*
+		 * If we cleared a handler on behalf of the root
+		 * domain, we have to wait for any current invocation
+		 * to drain, since our caller might subsequently unmap
+		 * the target domain. To this aim, this code
+		 * synchronizes with __ipipe_dispatch_event(),
+		 * guaranteeing that either the dispatcher sees a null
+		 * handler in which case it discards the invocation
+		 * (which also prevents from entering a livelock), or
+		 * finds a valid handler and calls it. Symmetrically,
+		 * ipipe_catch_event() ensures that the called code
+		 * won't be unmapped under our feet until the event
+		 * synchronization flag is cleared for the given event
+		 * on all CPUs.
+		 */
+
+		for_each_online_cpu(cpuid) {
+			while (ipd->cpudata[cpuid].evsync & (1LL << event))
+				schedule_timeout_interruptible(HZ / 50);
+		}
+	}
 
 	return old_handler;
 }



-- 
Philippe.



