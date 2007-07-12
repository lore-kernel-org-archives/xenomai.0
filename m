Message-ID: <4696A8C6.4010509@domain.hid>
Date: Fri, 13 Jul 2007 00:18:46 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig167FEDE799E648AFF6C0FC42"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH 2/3] Refactor xnstat_runtime to
	xnstat_exectime
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig167FEDE799E648AFF6C0FC42
Content-Type: multipart/mixed;
 boundary="------------000701060604030004040605"

This is a multi-part message in MIME format.
--------------000701060604030004040605
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Meanwhile, "runtime" appears to me like the wrong term for what we
provide with the xnstat API. Let's refactor every xnstat_exectime
occurrence to xnstat_exectime (and a few more spots).

Jan

--------------000701060604030004040605
Content-Type: text/x-patch;
 name="refactor-xnstat_exectime-v2.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="refactor-xnstat_exectime-v2.patch"

---
 include/nucleus/intr.h   |    6 ++--
 include/nucleus/pod.h    |    2 -
 include/nucleus/stat.h   |   68 +++++++++++++++++++++++-----------------=
-------
 include/nucleus/thread.h |    8 ++---
 ksrc/nucleus/intr.c      |   50 +++++++++++++++++-----------------
 ksrc/nucleus/module.c    |   12 ++++----
 ksrc/nucleus/pod.c       |   10 +++---
 ksrc/skins/native/task.c |    2 -
 8 files changed, 79 insertions(+), 79 deletions(-)

Index: xenomai/include/nucleus/intr.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/nucleus/intr.h
+++ xenomai/include/nucleus/intr.h
@@ -64,8 +64,8 @@ typedef struct xnintr {
     const char *name;	/* !< Symbolic name. */
=20
     struct {
-	xnstat_counter_t hits;	  /* !< Number of handled receipts since attachm=
ent. */
-	xnstat_runtime_t account; /* !< Runtime accounting entity */
+	xnstat_counter_t hits; /* !< Number of handled receipts since attachmen=
t. */
+	xnstat_exectime_t account; /* !< Execution time accounting entity */
     } stat[XNARCH_NR_CPUS];
=20
 } xnintr_t;
@@ -110,7 +110,7 @@ xnarch_cpumask_t xnintr_affinity(xnintr_
                                  xnarch_cpumask_t cpumask);
=20
 int xnintr_query(int irq, int *cpu, xnintr_t **prev, int revision, char =
*name,
-		 unsigned long *hits, xnticks_t *runtime,
+		 unsigned long *hits, xnticks_t *exectime,
 		 xnticks_t *account_period);
=20
 #ifdef __cplusplus
Index: xenomai/include/nucleus/pod.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/nucleus/pod.h
+++ xenomai/include/nucleus/pod.h
@@ -134,7 +134,7 @@ typedef struct xnsched {
 #ifdef CONFIG_XENO_OPT_STATS
 	xnticks_t last_account_switch;	/*!< Last account switch date (ticks). *=
/
=20
-	xnstat_runtime_t *current_account;	/*!< Currently active account */
+	xnstat_exectime_t *current_account;	/*!< Currently active account */
 #endif	/* CONFIG_XENO_OPT_STATS */
=20
 	xntimer_t htimer;	/*!< Host timer. */
Index: xenomai/include/nucleus/stat.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/nucleus/stat.h
+++ xenomai/include/nucleus/stat.h
@@ -25,20 +25,20 @@
=20
 #include <nucleus/types.h>
=20
-typedef struct xnstat_runtime {
+typedef struct xnstat_exectime {
=20
 	xnticks_t start;   /* Start of execution time accumulation */
=20
 	xnticks_t total; /* Accumulated execution time */
=20
-} xnstat_runtime_t;
+} xnstat_exectime_t;
=20
 /* Return current date which can be passed to other xnstat services for
    immediate or lazy accounting. */
-#define xnstat_runtime_now() xnarch_get_cpu_tsc()
+#define xnstat_exectime_now() xnarch_get_cpu_tsc()
=20
-/* Accumulate runtime of the current account until the given date. */
-#define xnstat_runtime_update(sched, date) \
+/* Accumulate exectime of the current account until the given date. */
+#define xnstat_exectime_update(sched, date) \
 do { \
 	(sched)->current_account->total +=3D \
 		date - (sched)->last_account_switch; \
@@ -49,34 +49,34 @@ do { \
 } while (0)
=20
 /* Update the current account reference, returning the previous one. */
-#define xnstat_runtime_set_current(sched, new_account) \
+#define xnstat_exectime_set_current(sched, new_account) \
 ({ \
-	xnstat_runtime_t *__prev; \
+	xnstat_exectime_t *__prev; \
 	__prev =3D xnarch_atomic_xchg(&(sched)->current_account, (new_account))=
; \
 	__prev; \
 })
=20
 /* Return the currently active accounting entity. */
-#define xnstat_runtime_get_current(sched) ((sched)->current_account)
+#define xnstat_exectime_get_current(sched) ((sched)->current_account)
=20
-/* Finalize an account (no need to accumulate the runtime, just mark the=

+/* Finalize an account (no need to accumulate the exectime, just mark th=
e
    switch date and set the new account). */
-#define xnstat_runtime_finalize(sched, new_account) \
+#define xnstat_exectime_finalize(sched, new_account) \
 do { \
 	(sched)->last_account_switch =3D xnarch_get_cpu_tsc(); \
 	(sched)->current_account =3D (new_account); \
 } while (0)
=20
-/* Obtain content of xnstat_runtime_t */
-#define xnstat_runtime_get_start(account)	((account)->start)
-#define xnstat_runtime_get_total(account)	((account)->total)
+/* Obtain content of xnstat_exectime_t */
+#define xnstat_exectime_get_start(account)	((account)->start)
+#define xnstat_exectime_get_total(account)	((account)->total)
=20
 /* Obtain last account switch date of considered sched */
-#define xnstat_runtime_get_last_switch(sched)	((sched)->last_account_swi=
tch)
+#define xnstat_exectime_get_last_switch(sched)	((sched)->last_account_sw=
itch)
=20
 /* Reset statistics from inside the accounted entity (e.g. after CPU
    migration). */
-#define xnstat_runtime_reset_stats(stat) \
+#define xnstat_exectime_reset_stats(stat) \
 do { \
 	(stat)->total =3D 0; \
 	(stat)->start =3D xnarch_get_cpu_tsc(); \
@@ -103,21 +103,21 @@ static inline void xnstat_counter_set(xn
 }
=20
 #else /* !CONFIG_XENO_OPT_STATS */
-typedef struct xnstat_runtime {
+typedef struct xnstat_exectime {
 #ifdef __XENO_SIM__
     int dummy;
 #endif /* __XENO_SIM__ */
-} xnstat_runtime_t;
+} xnstat_exectime_t;
=20
-#define xnstat_runtime_now()					({ 0; })
-#define xnstat_runtime_update(sched, date)			do { } while (0)
-#define xnstat_runtime_set_current(sched, new_account)		({ (void)sched; =
NULL; })
-#define xnstat_runtime_get_current(sched)			({ (void)sched; NULL; })
-#define xnstat_runtime_finalize(sched, new_account)		do { } while (0)
-#define xnstat_runtime_get_start(account)			({ 0; })
-#define xnstat_runtime_get_total(account)			({ 0; })
-#define xnstat_runtime_get_last_switch(sched)			({ 0; })
-#define xnstat_runtime_reset_stats(account)			do { } while (0)
+#define xnstat_exectime_now()					({ 0; })
+#define xnstat_exectime_update(sched, date)			do { } while (0)
+#define xnstat_exectime_set_current(sched, new_account)		({ (void)sched;=
 NULL; })
+#define xnstat_exectime_get_current(sched)			({ (void)sched; NULL; })
+#define xnstat_exectime_finalize(sched, new_account)		do { } while (0)
+#define xnstat_exectime_get_start(account)			({ 0; })
+#define xnstat_exectime_get_total(account)			({ 0; })
+#define xnstat_exectime_get_last_switch(sched)			({ 0; })
+#define xnstat_exectime_reset_stats(account)			do { } while (0)
=20
 typedef struct xnstat_counter {
 #ifdef __XENO_SIM__
@@ -130,20 +130,20 @@ typedef struct xnstat_counter {
 #define xnstat_counter_set(c, value) do { } while (0)
 #endif /* CONFIG_XENO_OPT_STATS */
=20
-/* Account the runtime of the current account until now, switch to
+/* Account the exectime of the current account until now, switch to
    new_account, and return the previous one. */
-#define xnstat_runtime_switch(sched, new_account) \
+#define xnstat_exectime_switch(sched, new_account) \
 ({ \
-	xnstat_runtime_update(sched, xnstat_runtime_now()); \
-	xnstat_runtime_set_current(sched, new_account); \
+	xnstat_exectime_update(sched, xnstat_exectime_now()); \
+	xnstat_exectime_set_current(sched, new_account); \
 })
=20
-/* Account the runtime of the current account until given start time, sw=
itch
+/* Account the exectime of the current account until given start time, s=
witch
    to new_account, and return the previous one. */
-#define xnstat_runtime_lazy_switch(sched, new_account, date) \
+#define xnstat_exectime_lazy_switch(sched, new_account, date) \
 ({ \
-	xnstat_runtime_update(sched, date); \
-	xnstat_runtime_set_current(sched, new_account); \
+	xnstat_exectime_update(sched, date); \
+	xnstat_exectime_set_current(sched, new_account); \
 })
=20
 #endif /* !_XENO_NUCLEUS_STAT_H */
Index: xenomai/include/nucleus/thread.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/nucleus/thread.h
+++ xenomai/include/nucleus/thread.h
@@ -205,8 +205,8 @@ typedef struct xnthread {
 	xnstat_counter_t ssw;	/* Primary -> secondary mode switch count */
 	xnstat_counter_t csw;	/* Context switches (includes secondary -> primar=
y switches) */
 	xnstat_counter_t pf;	/* Number of page faults */
-	xnstat_runtime_t account; /* Execution time accounting entity */
-	xnstat_runtime_t lastperiod; /* Interval marker for execution time repo=
rts */
+	xnstat_exectime_t account; /* Execution time accounting entity */
+	xnstat_exectime_t lastperiod; /* Interval marker for execution time rep=
orts */
     } stat;
=20
     int errcode;		/* Local errno */
@@ -293,8 +293,8 @@ typedef struct xnhook {
     0 : xnarch_user_pid(xnthread_archtcb(thread)))
 #define xnthread_affinity(thread)          ((thread)->affinity)
 #define xnthread_affine_p(thread, cpu)     xnarch_cpu_isset(cpu, (thread=
)->affinity)
-#define xnthread_get_exectime(thread)      xnstat_runtime_get_total(&(th=
read)->stat.account)
-#define xnthread_get_lastswitch(thread)    xnstat_runtime_get_last_switc=
h((thread)->sched)
+#define xnthread_get_exectime(thread)      xnstat_exectime_get_total(&(t=
hread)->stat.account)
+#define xnthread_get_lastswitch(thread)    xnstat_exectime_get_last_swit=
ch((thread)->sched)
=20
 /* Class-level operations for threads. */
 static inline int xnthread_get_denormalized_prio(xnthread_t *t)
Index: xenomai/ksrc/skins/native/task.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/skins/native/task.c
+++ xenomai/ksrc/skins/native/task.c
@@ -1147,7 +1147,7 @@ int rt_task_inquire(RT_TASK *task, RT_TA
 	info->relpoint =3D xntimer_get_date(&task->thread_base.ptimer);
 	raw_exectime =3D xnthread_get_exectime(&task->thread_base);
 	if (task->thread_base.sched->runthread =3D=3D &task->thread_base)
-		raw_exectime +=3D xnstat_runtime_now() -
+		raw_exectime +=3D xnstat_exectime_now() -
 			xnthread_get_lastswitch(&task->thread_base);
 	info->exectime =3D xnarch_tsc_to_ns(raw_exectime);
 	info->modeswitches =3D xnstat_counter_get(&task->thread_base.stat.ssw);=

Index: xenomai/ksrc/nucleus/intr.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/nucleus/intr.c
+++ xenomai/ksrc/nucleus/intr.c
@@ -90,11 +90,11 @@ static void xnintr_irq_handler(unsigned=20
 void xnintr_clock_handler(void)
 {
 	xnsched_t *sched =3D xnpod_current_sched();
-	xnstat_runtime_t *prev;
+	xnstat_exectime_t *prev;
 	xnticks_t start;
=20
-	prev  =3D xnstat_runtime_get_current(sched);
-	start =3D xnstat_runtime_now();
+	prev  =3D xnstat_exectime_get_current(sched);
+	start =3D xnstat_exectime_now();
=20
 	xnarch_announce_tick();
=20
@@ -109,7 +109,7 @@ void xnintr_clock_handler(void)
 	xnlock_put(&nklock);
=20
 	xnstat_counter_inc(&nkclock.stat[xnsched_cpu(sched)].hits);
-	xnstat_runtime_lazy_switch(sched,
+	xnstat_exectime_lazy_switch(sched,
 		&nkclock.stat[xnsched_cpu(sched)].account, start);
=20
 	if (--sched->inesting =3D=3D 0 && xnsched_resched_p())
@@ -125,7 +125,7 @@ void xnintr_clock_handler(void)
 	}
=20
 	xnltt_log_event(xeno_ev_iexit, XNARCH_TIMER_IRQ);
-	xnstat_runtime_switch(sched, prev);
+	xnstat_exectime_switch(sched, prev);
 }
=20
 /* Optional support for shared interrupts. */
@@ -160,14 +160,14 @@ static inline xnintr_t *xnintr_shirq_nex
 static void xnintr_shirq_handler(unsigned irq, void *cookie)
 {
 	xnsched_t *sched =3D xnpod_current_sched();
-	xnstat_runtime_t *prev;
+	xnstat_exectime_t *prev;
 	xnticks_t start;
 	xnintr_irq_t *shirq =3D &xnirqs[irq];
 	xnintr_t *intr;
 	int s =3D 0;
=20
-	prev  =3D xnstat_runtime_get_current(sched);
-	start =3D xnstat_runtime_now();
+	prev  =3D xnstat_exectime_get_current(sched);
+	start =3D xnstat_exectime_now();
 	xnltt_log_event(xeno_ev_ienter, irq);
=20
 	++sched->inesting;
@@ -184,10 +184,10 @@ static void xnintr_shirq_handler(unsigne
 		if (ret & XN_ISR_HANDLED) {
 			xnstat_counter_inc(
 				&intr->stat[xnsched_cpu(sched)].hits);
-			xnstat_runtime_lazy_switch(sched,
+			xnstat_exectime_lazy_switch(sched,
 				&intr->stat[xnsched_cpu(sched)].account,
 				start);
-			start =3D xnstat_runtime_now();
+			start =3D xnstat_exectime_now();
 		}
=20
 		intr =3D intr->next;
@@ -213,7 +213,7 @@ static void xnintr_shirq_handler(unsigne
 		xnpod_schedule();
=20
 	xnltt_log_event(xeno_ev_iexit, irq);
-	xnstat_runtime_switch(sched, prev);
+	xnstat_exectime_switch(sched, prev);
 }
=20
 /*
@@ -225,14 +225,14 @@ static void xnintr_edge_shirq_handler(un
 	const int MAX_EDGEIRQ_COUNTER =3D 128;
=20
 	xnsched_t *sched =3D xnpod_current_sched();
-	xnstat_runtime_t *prev;
+	xnstat_exectime_t *prev;
 	xnticks_t start;
 	xnintr_irq_t *shirq =3D &xnirqs[irq];
 	xnintr_t *intr, *end =3D NULL;
 	int s =3D 0, counter =3D 0;
=20
-	prev  =3D xnstat_runtime_get_current(sched);
-	start =3D xnstat_runtime_now();
+	prev  =3D xnstat_exectime_get_current(sched);
+	start =3D xnstat_exectime_now();
 	xnltt_log_event(xeno_ev_ienter, irq);
=20
 	++sched->inesting;
@@ -243,7 +243,7 @@ static void xnintr_edge_shirq_handler(un
 	while (intr !=3D end) {
 		int ret, code;
=20
-		xnstat_runtime_switch(sched,
+		xnstat_exectime_switch(sched,
 			&intr->stat[xnsched_cpu(sched)].account);
=20
 		ret =3D intr->isr(intr);
@@ -255,10 +255,10 @@ static void xnintr_edge_shirq_handler(un
 				end =3D shirq->handlers;
 			xnstat_counter_inc(
 				&intr->stat[xnsched_cpu(sched)].hits);
-			xnstat_runtime_lazy_switch(sched,
+			xnstat_exectime_lazy_switch(sched,
 				&intr->stat[xnsched_cpu(sched)].account,
 				start);
-			start =3D xnstat_runtime_now();
+			start =3D xnstat_exectime_now();
 		}
=20
 		if (counter++ > MAX_EDGEIRQ_COUNTER)
@@ -293,7 +293,7 @@ static void xnintr_edge_shirq_handler(un
 		xnpod_schedule();
=20
 	xnltt_log_event(xeno_ev_iexit, irq);
-	xnstat_runtime_switch(sched, prev);
+	xnstat_exectime_switch(sched, prev);
 }
=20
 static inline int xnintr_irq_attach(xnintr_t *intr)
@@ -437,12 +437,12 @@ static void xnintr_irq_handler(unsigned=20
 {
 	xnsched_t *sched =3D xnpod_current_sched();
 	xnintr_t *intr;
-	xnstat_runtime_t *prev;
+	xnstat_exectime_t *prev;
 	xnticks_t start;
 	int s;
=20
-	prev  =3D xnstat_runtime_get_current(sched);
-	start =3D xnstat_runtime_now();
+	prev  =3D xnstat_exectime_get_current(sched);
+	start =3D xnstat_exectime_now();
 	xnltt_log_event(xeno_ev_ienter, irq);
=20
 	++sched->inesting;
@@ -471,7 +471,7 @@ static void xnintr_irq_handler(unsigned=20
 		}
 	} else {
 		xnstat_counter_inc(&intr->stat[xnsched_cpu(sched)].hits);
-		xnstat_runtime_lazy_switch(sched,
+		xnstat_exectime_lazy_switch(sched,
 			&intr->stat[xnsched_cpu(sched)].account,
 			start);
 		intr->unhandled =3D 0;
@@ -491,7 +491,7 @@ static void xnintr_irq_handler(unsigned=20
 		xnpod_schedule();
=20
 	xnltt_log_event(xeno_ev_iexit, irq);
-	xnstat_runtime_switch(sched, prev);
+	xnstat_exectime_switch(sched, prev);
 }
=20
 int xnintr_mount(void)
@@ -884,7 +884,7 @@ int xnintr_irq_proc(unsigned int irq, ch
=20
 #ifdef CONFIG_XENO_OPT_STATS
 int xnintr_query(int irq, int *cpu, xnintr_t **prev, int revision, char =
*name,
-		 unsigned long *hits, xnticks_t *runtime,
+		 unsigned long *hits, xnticks_t *exectime,
 		 xnticks_t *account_period)
 {
 	xnintr_t *intr;
@@ -922,7 +922,7 @@ int xnintr_query(int irq, int *cpu, xnin
=20
 	last_switch =3D xnpod_sched_slot(cpu_no)->last_account_switch;
=20
-	*runtime        =3D intr->stat[cpu_no].account.total;
+	*exectime       =3D intr->stat[cpu_no].account.total;
 	*account_period =3D last_switch - intr->stat[cpu_no].account.start;
=20
 	intr->stat[cpu_no].account.total  =3D 0;
Index: xenomai/ksrc/nucleus/module.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/nucleus/module.c
+++ xenomai/ksrc/nucleus/module.c
@@ -272,7 +272,7 @@ struct stat_seq_iterator {
 		unsigned long ssw;
 		unsigned long csw;
 		unsigned long pf;
-		xnticks_t runtime;
+		xnticks_t exectime;
 		xnticks_t account_period;
 	} stat_info[1];
 };
@@ -319,11 +319,11 @@ static int stat_seq_show(struct seq_file
=20
 		if (p->account_period) {
 			while (p->account_period > 0xFFFFFFFF) {
-				p->runtime >>=3D 16;
+				p->exectime >>=3D 16;
 				p->account_period >>=3D 16;
 			}
 			usage =3D
-			    xnarch_ulldiv(p->runtime * 1000LL +
+			    xnarch_ulldiv(p->exectime * 1000LL +
 					  (p->account_period >> 1),
 					  p->account_period, NULL);
 		}
@@ -423,10 +423,10 @@ static int stat_seq_open(struct inode *i
=20
 		period =3D sched->last_account_switch - thread->stat.lastperiod.start;=

 		if (!period && thread =3D=3D sched->runthread) {
-			stat_info->runtime =3D 1;
+			stat_info->exectime =3D 1;
 			stat_info->account_period =3D 1;
 		} else {
-			stat_info->runtime =3D thread->stat.account.total -
+			stat_info->exectime =3D thread->stat.account.total -
 				thread->stat.lastperiod.total;
 			stat_info->account_period =3D period;
 		}
@@ -452,7 +452,7 @@ static int stat_seq_open(struct inode *i
 			err =3D xnintr_query(irq, &cpu, &prev, intr_rev,
 					   stat_info->name,
 					   &stat_info->csw,
-					   &stat_info->runtime,
+					   &stat_info->exectime,
 					   &stat_info->account_period);
 			if (err =3D=3D -EAGAIN)
 				goto restart_unlocked;
Index: xenomai/ksrc/nucleus/pod.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/nucleus/pod.c
+++ xenomai/ksrc/nucleus/pod.c
@@ -407,7 +407,7 @@ int xnpod_init(void)
=20
 		sched->rootcb.affinity =3D xnarch_cpumask_of_cpu(cpu);
=20
-		xnstat_runtime_set_current(sched, &sched->rootcb.stat.account);
+		xnstat_exectime_set_current(sched, &sched->rootcb.stat.account);
 	}
=20
 	xnarch_hook_ipi(&xnpod_schedule_handler);
@@ -572,7 +572,7 @@ static inline void xnpod_switch_zombie(x
=20
 	xnthread_cleanup_tcb(threadout);
=20
-	xnstat_runtime_finalize(sched, &threadin->stat.account);
+	xnstat_exectime_finalize(sched, &threadin->stat.account);
=20
 	xnarch_finalize_and_switch(xnthread_archtcb(threadout),
 				   xnthread_archtcb(threadin));
@@ -1782,7 +1782,7 @@ int xnpod_migrate_thread(int cpu)
=20
 	/* Reset execution time measurement period so that we don't mess up
 	   per-CPU statistics. */
-	xnstat_runtime_reset_stats(&thread->stat.lastperiod);
+	xnstat_exectime_reset_stats(&thread->stat.lastperiod);
=20
       unlock_and_exit:
=20
@@ -2376,7 +2376,7 @@ void xnpod_schedule(void)
 		xnarch_enter_root(xnthread_archtcb(threadin));
 	}
=20
-	xnstat_runtime_switch(sched, &threadin->stat.account);
+	xnstat_exectime_switch(sched, &threadin->stat.account);
 	xnstat_counter_inc(&threadin->stat.csw);
=20
 	xnarch_switch_to(xnthread_archtcb(threadout),
@@ -2551,7 +2551,7 @@ void xnpod_schedule_runnable(xnthread_t=20
 		nkpod->schedhook(runthread, XNREADY);
 #endif /* __XENO_SIM__ */
=20
-	xnstat_runtime_switch(sched, &threadin->stat.account);
+	xnstat_exectime_switch(sched, &threadin->stat.account);
 	xnstat_counter_inc(&threadin->stat.csw);
=20
 	xnarch_switch_to(xnthread_archtcb(runthread),

--------------000701060604030004040605--

--------------enig167FEDE799E648AFF6C0FC42
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFGlqjGniDOoMHTA+kRAsbkAJ46jrKERQQ3O5upDLnKtVYlFk7ITACePC2F
z5rgUeU7Zf2sO/acsgj/Ph8=
=k5U3
-----END PGP SIGNATURE-----

--------------enig167FEDE799E648AFF6C0FC42--

