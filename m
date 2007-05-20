Message-ID: <465030CD.8030906@domain.hid>
Date: Sun, 20 May 2007 13:28:13 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigCC09A5AD291CBE29FD8887DF"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] Refactor nucleus timer IRQ path
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCC09A5AD291CBE29FD8887DF
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

The timer IRQ currently goes through a dedicated trampoline
(xnintr_clock_handler), the generic xnintr_irq_handler which handles it
via a special nkclock xnintr_t object, then xnpod_announce_tick, until
it finally ends in xntimer_tick_aperiodic.

This patch refactors this path so that we now have only a specialised
xnintr_clock_handler which incorporates all previously scattered steps.
Furthermore, tick-specific handling is removed from xnintr_irq_handler
and nkclock is now only required when statistic are generated. This
refactoring results in a tiny, but measurable performance gain on i386,
other archs with small caches may benefit more significantly.

[Note that the patch also contains some LTT-related changes around the
tick IRQ. They only serve as a reminder, the final LTTng marker
format and the probe modules will look differently.]

Jan


---
 include/nucleus/pod.h   |    2 -
 ksrc/nucleus/intr.c     |   51 +++++++++++++++++++++++++++++++----------=

 ksrc/nucleus/ltt.c      |    4 +--
 ksrc/nucleus/pod.c      |   59 ++++-------------------------------------=
-------
 ksrc/nucleus/timebase.c |    3 ++
 5 files changed, 50 insertions(+), 69 deletions(-)

Index: xenomai/ksrc/nucleus/intr.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/nucleus/intr.c
+++ xenomai/ksrc/nucleus/intr.c
@@ -41,9 +41,8 @@
=20
 DEFINE_PRIVATE_XNLOCK(intrlock);
=20
-xnintr_t nkclock;
-
 #ifdef CONFIG_XENO_OPT_STATS
+xnintr_t nkclock;	/* Only for statistics */
 int xnintr_count =3D 1;	/* Number of attached xnintr objects + nkclock *=
/
 int xnintr_list_rev;	/* Modification counter of xnintr list */
=20
@@ -113,6 +112,42 @@ static void xnintr_irq_handler(unsigned=20
 	if (--sched->inesting =3D=3D 0 && xnsched_resched_p())
 		xnpod_schedule();
=20
+	xnltt_log_event(xeno_ev_iexit, irq);
+	xnstat_runtime_switch(sched, prev);
+}
+
+/* Low-level clock irq handler. */
+
+void xnintr_clock_handler(void)
+{
+	xnsched_t *sched =3D xnpod_current_sched();
+	xnstat_runtime_t *prev;
+	xnticks_t start;
+
+	xnarch_memory_barrier();
+
+	prev  =3D xnstat_runtime_get_current(sched);
+	start =3D xnstat_runtime_now();
+
+	xnarch_announce_tick();
+
+	xnltt_log_event(xeno_ev_ienter, XNARCH_TIMER_IRQ);
+	xnltt_log_event(xeno_ev_tstick, nktbase.name,
+			xnpod_current_thread()->name);
+
+	++sched->inesting;
+
+	xnlock_get(&nklock);
+	xntimer_tick_aperiodic();
+	xnlock_put(&nklock);
+
+	xnstat_counter_inc(&nkclock.stat[xnsched_cpu(sched)].hits);
+	xnstat_runtime_lazy_switch(sched,
+		&nkclock.stat[xnsched_cpu(sched)].account, start);
+
+	if (--sched->inesting =3D=3D 0 && xnsched_resched_p())
+		xnpod_schedule();
+
 	/* Since the host tick is low priority, we can wait for returning
 	   from the rescheduling procedure before actually calling the
 	   propagation service, if it is pending. */
@@ -122,18 +157,10 @@ static void xnintr_irq_handler(unsigned=20
 		xnarch_relay_tick();
 	}
=20
-	xnltt_log_event(xeno_ev_iexit, irq);
+	xnltt_log_event(xeno_ev_iexit, XNARCH_TIMER_IRQ);
 	xnstat_runtime_switch(sched, prev);
 }
=20
-/* Low-level clock irq handler. */
-
-void xnintr_clock_handler(void)
-{
-	xnarch_announce_tick();
-	xnintr_irq_handler(nkclock.irq, &nkclock);
-}
-
 /* Optional support for shared interrupts. */
=20
 #if defined(CONFIG_XENO_OPT_SHIRQ_LEVEL) || defined(CONFIG_XENO_OPT_SHIR=
Q_EDGE)
@@ -809,7 +836,7 @@ int xnintr_irq_proc(unsigned int irq, ch
 		p +=3D sprintf(p, "         [virtual]");
 		return p - str;
 	} else if (irq =3D=3D XNARCH_TIMER_IRQ) {
-		p +=3D sprintf(p, "         %s", nkclock.name);
+		p +=3D sprintf(p, "         [timer]");
 		return p - str;
 	}
=20
Index: xenomai/include/nucleus/pod.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/nucleus/pod.h
+++ xenomai/include/nucleus/pod.h
@@ -438,8 +438,6 @@ static inline void xnpod_unlock_sched(vo
 	xnlock_put_irqrestore(&nklock, s);
 }
=20
-int xnpod_announce_tick(struct xnintr *intr);
-
 void xnpod_activate_rr(xnticks_t quantum);
=20
 void xnpod_deactivate_rr(void);
Index: xenomai/ksrc/nucleus/pod.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/nucleus/pod.c
+++ xenomai/ksrc/nucleus/pod.c
@@ -3004,12 +3004,11 @@ int xnpod_enable_timesource(void)
=20
 	xnltt_log_event(xeno_ev_tsenable);
=20
-	/* The clock interrupt does not need to be attached since the
-	   timer service will handle the arch-dependent setup. The IRQ
-	   source will be attached directly by the arch-dependent layer
-	   (xnarch_start_timer). */
-
-	xnintr_init(&nkclock, "[timer]", XNARCH_TIMER_IRQ, &xnpod_announce_tick=
, NULL, 0);
+#ifdef CONFIG_XENO_OPT_STATS
+	/* Only for statistical purpose, the clock interrupt will be attached
+	   directly by the arch-dependent layer (xnarch_start_timer). */
+	xnintr_init(&nkclock, "[timer]", XNARCH_TIMER_IRQ, NULL, NULL, 0);
+#endif /* CONFIG_XENO_OPT_STATS */
=20
 	nktbase.status =3D XNTBRUN;
=20
@@ -3109,51 +3108,7 @@ void xnpod_disable_timesource(void)
 	   resource is associated with this object. */
 }
=20
-/*!=20
- * \fn int xnpod_announce_tick(xnintr_t *intr)
- *
- * \brief Announce a new clock tick.
- *
- * This is the default service routine for clock ticks which performs
- * the necessary housekeeping chores for time-related services managed
- * by the nucleus. In a way or another, this routine must be called
- * to announce each incoming clock tick to the nucleus.
- *
- * @param intr The descriptor address of the interrupt object
- * associated to the timer interrupt.
- *
- * Side-effect: Since this routine manages the round-robin scheduling,
- * the running thread (which has been preempted by the timer
- * interrupt) can be switched out as a result of its time credit being
- * exhausted. The nucleus always calls the rescheduling procedure
- * after the outer interrupt has been processed.
- *
- * @return XN_ISR_HANDLED|XN_ISR_NOENABLE is always returned.
- *
- * Environments:
- *
- * This service can be called from:
- *
- * - Interrupt service routine, must be called with interrupts off.
- *
- * Rescheduling: possible.
- *
- */
-
-int xnpod_announce_tick(xnintr_t *intr)
-{
-	xnlock_get(&nklock);
-
-	xnltt_log_event(xeno_ev_tstick, xnpod_current_thread()->name);
-
-	xntimer_tick_aperiodic(); /* Update the master time base. */
-
-	xnlock_put(&nklock);
-
-	return XN_ISR_HANDLED | XN_ISR_NOENABLE;
-}
-
-/*!=20
+/*!
  * \fn int xnpod_set_thread_periodic(xnthread_t *thread,xnticks_t idate,=
xnticks_t period)
  * \brief Make a thread periodic.
  *
@@ -3368,7 +3323,6 @@ int xnpod_wait_thread_period(unsigned lo
=20
 EXPORT_SYMBOL(xnpod_activate_rr);
 EXPORT_SYMBOL(xnpod_add_hook);
-EXPORT_SYMBOL(xnpod_announce_tick);
 EXPORT_SYMBOL(xnpod_check_context);
 EXPORT_SYMBOL(xnpod_deactivate_rr);
 EXPORT_SYMBOL(xnpod_delete_thread);
@@ -3395,7 +3349,6 @@ EXPORT_SYMBOL(xnpod_unblock_thread);
 EXPORT_SYMBOL(xnpod_wait_thread_period);
 EXPORT_SYMBOL(xnpod_welcome_thread);
=20
-EXPORT_SYMBOL(nkclock);
 EXPORT_SYMBOL(nkpod);
=20
 #ifdef CONFIG_SMP
Index: xenomai/ksrc/nucleus/ltt.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/nucleus/ltt.c
+++ xenomai/ksrc/nucleus/ltt.c
@@ -123,8 +123,8 @@ struct xnltt_evmap xnltt_evtable[] =3D {
 	    {"Xenomai sigdispatch", "thread=3D%s, sigpend=3D0x%x", -1, xeno_eva=
ll},
 	[xeno_ev_thrboot] =3D
 	    {"Xenomai thread begin", "thread=3D%s", -1, xeno_evthr},
-	[xeno_ev_tstick] =3D
-	    {"Xenomai time source tick", "runthread=3D%s", -1, xeno_evirq},
+	[xeno_ev_tstick] =3D {"Xenomai time source tick",
+			    "base=3D%s, runthread=3D%s", -1, xeno_evirq},
 	[xeno_ev_sleepon] =3D
 	    {"Xenomai sleepon", "thread=3D%s, sync=3D%p", -1, xeno_evthr},
 	[xeno_ev_wakeup1] =3D
Index: xenomai/ksrc/nucleus/timebase.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/nucleus/timebase.c
+++ xenomai/ksrc/nucleus/timebase.c
@@ -433,6 +433,9 @@ void xntbase_tick(xntbase_t *base)
=20
 	xnlock_get_irqsave(&nklock, s);
=20
+	xnltt_log_event(xeno_ev_tstick, base->name,
+			xnpod_current_thread()->name);
+
 	if (base =3D=3D &nktbase)
 		xntimer_tick_aperiodic();
 	else {


--------------enigCC09A5AD291CBE29FD8887DF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFGUDDNniDOoMHTA+kRAhIEAJwIXcApmMlUSnKUE/QcPJnU77O2gQCcDXOA
3xpR0qj17dXsb8BwmY5aidc=
=vrfB
-----END PGP SIGNATURE-----

--------------enigCC09A5AD291CBE29FD8887DF--

