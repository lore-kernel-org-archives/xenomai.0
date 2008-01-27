Message-ID: <479CA23F.7000601@domain.hid>
Date: Sun, 27 Jan 2008 16:24:47 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4788C279.1020607@domain.hid> <479A5D78.6040701@domain.hid>
In-Reply-To: <479A5D78.6040701@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA5C9AC89DBF2E22D47ABF4ED"
Sender: jan.kiszka@domain.hid
Subject: Re: [Adeos-main] [BUG] evsync is not SMP-safe
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA5C9AC89DBF2E22D47ABF4ED
Content-Type: multipart/mixed;
 boundary="------------090902070502020109040207"

This is a multi-part message in MIME format.
--------------090902070502020109040207
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Jan Kiszka wrote:
>> Philippe,
>>
>> this
>>
>> int fastcall __ipipe_dispatch_event (unsigned event, void *data)
>> ...
>> 	ipipe_cpudom_var(next_domain, evsync) |=3D (1LL << event);
>> 	local_irq_restore_hw(flags);
>> 	propagate =3D !evhand(event, start_domain, data);
>> 	local_irq_save_hw(flags);
>> 	ipipe_cpudom_var(next_domain, evsync) &=3D ~(1LL << event);
>>
>> doesn't fly on SMP. While the invoked event handler is running, it may=

>> happen that the caller gets migrated to another CPU. The result is an
>> inconsistent evsync state that causes ipipe_catch_event to stall (test=

>> case: invoke Jerome's system() test a few times, them try to unload
>> Xenomai skins and nucleus).
>>
>> First idea (I've nothing implemented to far, would happily leave it to=

>> someone else's hand): Track event handler entry/exit with an, say, 8 b=
it
>> per-cpu counter. On event deregistration, just summarize over the
>> per-cpu counters and wait for the sum to become 0. This has just the
>> drawback that it may cause livelocks on large SMP boxes when trying to=

>> wait for a busy event. I've no perfect idea so far.
>=20
> Second approach to solve this (currently) last known ipipe issue cleanl=
y:
>=20
> As long as some task in the system has __ipipe_dispatch_event (and thus=

> some of the registered event handlers) on its stack, it is not safe to
> unregister some handler. For simplicity reasons, I don't think we shoul=
d
> make any difference which handlers are precisely busy. So, how to find
> out if there are such tasks?
>=20
> I checked the code and derived three classes of preconditions for the
> invocation of __ipipe_dispatch_event:
>=20
>  1) ipipe_init_notify and ipipe_cleanup_notify -> no preconditions
>=20
>  2) ipipe_trap_notify -> some Linux task has PF_EVNOTIFY set or
>                          there are tasks with custom stacks present
>=20
>  3) all other invocations -> some Linux task has PF_EVNOTIFY set
>=20
> This means by walking the full Linux task list and checking that are no=

> more PF_EVNOTIFY-tasks present, we can easily exclude 3). In fact, 2)
> can also be excluded this way because we can reasonably demand that any=

> I-pipe user fiddling with event handlers has killed all non-Linux tasks=

> beforehand. This leaves us with 1) which should be handled via classic
> RCU as Linux offers it. Viable? It would even shorten the fast path a b=
it!
>=20
> Still no code, I would like to collect feedback on this new idea first.=


OK, here is some code. Seems to work fine (now that I fixed the cleanup
race in Xenomai as well - the issue happened to pop up right after
applying this patch :-/).

Jan

--------------090902070502020109040207
Content-Type: text/x-patch;
 name="rework-event-deregistration.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="rework-event-deregistration.patch"

---
 include/linux/ipipe.h        |   11 +++++++++--
 include/linux/ipipe_percpu.h |    1 -
 kernel/ipipe/core.c          |   42 ++++++++++++++++++++++++------------=
------
 3 files changed, 33 insertions(+), 21 deletions(-)

Index: linux-2.6.24-xeno_64/include/linux/ipipe_percpu.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.24-xeno_64.orig/include/linux/ipipe_percpu.h
+++ linux-2.6.24-xeno_64/include/linux/ipipe_percpu.h
@@ -33,7 +33,6 @@ struct ipipe_percpu_domain_data {
 	unsigned long irqpend_lomask[IPIPE_IRQ_IWORDS];
 	unsigned long irqheld_mask[IPIPE_IRQ_IWORDS];
 	unsigned long irqall[IPIPE_NR_IRQS];
-	u64 evsync;
 };
=20
 #ifdef CONFIG_SMP
Index: linux-2.6.24-xeno_64/kernel/ipipe/core.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.24-xeno_64.orig/kernel/ipipe/core.c
+++ linux-2.6.24-xeno_64/kernel/ipipe/core.c
@@ -260,8 +260,6 @@ void __ipipe_init_stage(struct ipipe_dom
=20
 		for (n =3D 0; n < IPIPE_NR_IRQS; n++)
 			ipipe_percpudom(ipd, irqall, cpu)[n] =3D 0;
-
-		ipipe_percpudom(ipd, evsync, cpu) =3D 0;
 	}
=20
 	for (n =3D 0; n < IPIPE_NR_IRQS; n++) {
@@ -554,7 +552,6 @@ void fastcall __ipipe_walk_pipeline(stru
 				__ipipe_sync_pipeline(IPIPE_IRQMASK_ANY);
 			else {
=20
-				ipipe_cpudom_var(this_domain, evsync) =3D 0;
 				ipipe_current_domain =3D next_domain;
 				ipipe_suspend_domain();	/* Sync stage and propagate interrupts. */
=20
@@ -822,11 +819,9 @@ int fastcall __ipipe_dispatch_event (uns
=20
 		if (evhand !=3D NULL) {
 			ipipe_current_domain =3D next_domain;
-			ipipe_cpudom_var(next_domain, evsync) |=3D (1LL << event);
 			local_irq_restore_hw(flags);
 			propagate =3D !evhand(event, start_domain, data);
 			local_irq_save_hw(flags);
-			ipipe_cpudom_var(next_domain, evsync) &=3D ~(1LL << event);
 			if (ipipe_current_domain !=3D next_domain)
 				this_domain =3D ipipe_current_domain;
 		}
@@ -1252,7 +1247,7 @@ ipipe_event_handler_t ipipe_catch_event(
 {
 	ipipe_event_handler_t old_handler;
 	unsigned long flags;
-	int self =3D 0, cpu;
+	int self =3D 0;
=20
 	if (event & IPIPE_EVENT_SELF) {
 		event &=3D ~IPIPE_EVENT_SELF;
@@ -1293,20 +1288,31 @@ ipipe_event_handler_t ipipe_catch_event(
 		 * domain, we have to wait for any current invocation
 		 * to drain, since our caller might subsequently unmap
 		 * the target domain. To this aim, this code
-		 * synchronizes with __ipipe_dispatch_event(),
-		 * guaranteeing that either the dispatcher sees a null
-		 * handler in which case it discards the invocation
-		 * (which also prevents from entering a livelock), or
-		 * finds a valid handler and calls it. Symmetrically,
-		 * ipipe_catch_event() ensures that the called code
-		 * won't be unmapped under our feet until the event
-		 * synchronization flag is cleared for the given event
-		 * on all CPUs.
+		 * synchronizes on RCU sections to ensure that event
+		 * handlers protected by this mechanisms were all left.
+		 * Moreover, it is checked that there are no more tasks
+		 * in system which have the PF_EVNOTIFY flag set, i.e.
+		 * may still have the deregistered handler on their
+		 * stack.
 		 */
=20
-		for_each_online_cpu(cpu) {
-			while (ipipe_percpudom(ipd, evsync, cpu) & (1LL << event))
-				schedule_timeout_interruptible(HZ / 50);
+		synchronize_rcu();
+
+		while (1) {
+			int evnotify_tasks =3D 0;
+			struct task_struct *p, *t;
+
+			read_lock(&tasklist_lock);
+			do_each_thread(p, t) {
+				if (t->flags & PF_EVNOTIFY)
+					evnotify_tasks++;
+			} while_each_thread(p, t);
+			read_unlock(&tasklist_lock);
+
+			if (!evnotify_tasks)
+				break;
+
+			schedule_timeout_interruptible(HZ / 50);
 		}
 	}
=20
Index: linux-2.6.24-xeno_64/include/linux/ipipe.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.24-xeno_64.orig/include/linux/ipipe.h
+++ linux-2.6.24-xeno_64/include/linux/ipipe.h
@@ -27,6 +27,7 @@
 #include <linux/percpu.h>
 #include <linux/mutex.h>
 #include <linux/linkage.h>
+#include <linux/rcupdate.h>
 #include <linux/ipipe_base.h>
 #include <linux/ipipe_compat.h>
 #include <asm/ipipe.h>
@@ -294,16 +295,22 @@ do {									\
=20
 static inline void ipipe_init_notify(struct task_struct *p)
 {
-	if (__ipipe_event_monitored_p(IPIPE_EVENT_INIT))
+	if (__ipipe_event_monitored_p(IPIPE_EVENT_INIT)) {
+		rcu_read_lock();
 		__ipipe_dispatch_event(IPIPE_EVENT_INIT,p);
+		rcu_read_unlock();
+	}
 }
=20
 struct mm_struct;
=20
 static inline void ipipe_cleanup_notify(struct mm_struct *mm)
 {
-	if (__ipipe_event_monitored_p(IPIPE_EVENT_CLEANUP))
+	if (__ipipe_event_monitored_p(IPIPE_EVENT_CLEANUP)) {
+		rcu_read_lock();
 		__ipipe_dispatch_event(IPIPE_EVENT_CLEANUP,mm);
+		rcu_read_unlock();
+	}
 }
=20
 /* Public interface */

--------------090902070502020109040207--

--------------enigA5C9AC89DBF2E22D47ABF4ED
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD4DBQFHnKJCniDOoMHTA+kRArA/AJdYN7sIUQtrHnIrfCldR9RHgH9WAKCBZBxZ
IkEVSsCfNyb+H5gX0bkvFg==
=rRl/
-----END PGP SIGNATURE-----

--------------enigA5C9AC89DBF2E22D47ABF4ED--


