Message-ID: <4696A8BB.40708@domain.hid>
Date: Fri, 13 Jul 2007 00:18:35 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD11AF8601510784D4BCD0338"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH 1/3] Enhanced xnthread & native task stats
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
--------------enigD11AF8601510784D4BCD0338
Content-Type: multipart/mixed;
 boundary="------------030405070500000107010807"

This is a multi-part message in MIME format.
--------------030405070500000107010807
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Basically, this patch enhances the statistics one can obtain via
rt_task_inquire. It adds the task's

 - accumulated execution time
 - context switches
 - mode switches
 - page faults

to RT_TASK_INFO. To provide this data, our existing exectime stats had
to be extended so that the collected data no longer gets reset upon dump
of /proc/xenomai/stat. At this change, the patch also removes the unused
xnthread::stime.

Credits go to Daniel Simon for writing the initial version and
contributing to the succeeding revisions I made.

Jan

PS: Patches and Changelog fragments can also be found at the usual
place: http://www.rts.uni-hannover.de/rtaddon/patches/xenomai

--------------030405070500000107010807
Content-Type: text/x-patch;
 name="enhance-thread-stats-v2.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="enhance-thread-stats-v2.patch"

---
 include/native/task.h    |   19 +++++++++++++++----
 include/nucleus/stat.h   |   12 +++++++++++-
 include/nucleus/thread.h |    7 ++++---
 ksrc/nucleus/module.c    |    9 +++++----
 ksrc/nucleus/pod.c       |    6 +++---
 ksrc/nucleus/thread.c    |    1 -
 ksrc/skins/native/task.c |    9 +++++++++
 7 files changed, 47 insertions(+), 16 deletions(-)

Index: xenomai/include/native/task.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/native/task.h
+++ xenomai/include/native/task.h
@@ -77,19 +77,30 @@ struct rt_task;
 /** Structure containing task-information useful to users.
  *
  *  @see rt_task_inquire()
+ *
+ *  @note Marked (*) fields will be set to 0 by rt_task_inquire() if
+ *  statistics support is disabled in the nucleus.
  */
 typedef struct rt_task_info {
-   =20
+
     int bprio;  /**< Base priority. */
=20
     int cprio; /**< Current priority. May change through Priority Inheri=
tance.*/
-   =20
+
     unsigned status; /**< Task's status. @see native_task_status */=20
-   =20
+
     RTIME relpoint; /**< Time of next release.*/=20
-   =20
+
     char name[XNOBJECT_NAME_LEN];  /**< Symbolic name assigned at creati=
on. */
=20
+    RTIME exectime; /**< Execution time in primary mode in nanoseconds (=
*). */
+
+    int modeswitches; /**< Number of primary->secondary mode switches (*=
). */
+
+    int ctxswitches; /**< Number of context switches (*). */
+
+    int pagefaults; /**< Number of triggered page faults (*). */
+
 } RT_TASK_INFO;
=20
 #define RT_MCB_FSTORE_LIMIT  64
Index: xenomai/include/nucleus/stat.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/nucleus/stat.h
+++ xenomai/include/nucleus/stat.h
@@ -67,6 +67,13 @@ do { \
 	(sched)->current_account =3D (new_account); \
 } while (0)
=20
+/* Obtain content of xnstat_runtime_t */
+#define xnstat_runtime_get_start(account)	((account)->start)
+#define xnstat_runtime_get_total(account)	((account)->total)
+
+/* Obtain last account switch date of considered sched */
+#define xnstat_runtime_get_last_switch(sched)	((sched)->last_account_swi=
tch)
+
 /* Reset statistics from inside the accounted entity (e.g. after CPU
    migration). */
 #define xnstat_runtime_reset_stats(stat) \
@@ -104,9 +111,12 @@ typedef struct xnstat_runtime {
=20
 #define xnstat_runtime_now()					({ 0; })
 #define xnstat_runtime_update(sched, date)			do { } while (0)
-#define xnstat_runtime_set_current(sched, new_account)	({ (void)sched; N=
ULL; })
+#define xnstat_runtime_set_current(sched, new_account)		({ (void)sched; =
NULL; })
 #define xnstat_runtime_get_current(sched)			({ (void)sched; NULL; })
 #define xnstat_runtime_finalize(sched, new_account)		do { } while (0)
+#define xnstat_runtime_get_start(account)			({ 0; })
+#define xnstat_runtime_get_total(account)			({ 0; })
+#define xnstat_runtime_get_last_switch(sched)			({ 0; })
 #define xnstat_runtime_reset_stats(account)			do { } while (0)
=20
 typedef struct xnstat_counter {
Index: xenomai/include/nucleus/thread.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/nucleus/thread.h
+++ xenomai/include/nucleus/thread.h
@@ -205,7 +205,8 @@ typedef struct xnthread {
 	xnstat_counter_t ssw;	/* Primary -> secondary mode switch count */
 	xnstat_counter_t csw;	/* Context switches (includes secondary -> primar=
y switches) */
 	xnstat_counter_t pf;	/* Number of page faults */
-	xnstat_runtime_t account; /* Runtime accounting entity */
+	xnstat_runtime_t account; /* Execution time accounting entity */
+	xnstat_runtime_t lastperiod; /* Interval marker for execution time repo=
rts */
     } stat;
=20
     int errcode;		/* Local errno */
@@ -235,8 +236,6 @@ typedef struct xnthread {
=20
     char name[XNOBJECT_NAME_LEN]; /* Symbolic name of thread */
=20
-    xnticks_t stime;		/* Start time */
-
     void (*entry)(void *cookie); /* Thread entry routine */
=20
     void *cookie;		/* Cookie to pass to the entry routine */
@@ -294,6 +293,8 @@ typedef struct xnhook {
     0 : xnarch_user_pid(xnthread_archtcb(thread)))
 #define xnthread_affinity(thread)          ((thread)->affinity)
 #define xnthread_affine_p(thread, cpu)     xnarch_cpu_isset(cpu, (thread=
)->affinity)
+#define xnthread_get_exectime(thread)      xnstat_runtime_get_total(&(th=
read)->stat.account)
+#define xnthread_get_lastswitch(thread)    xnstat_runtime_get_last_switc=
h((thread)->sched)
=20
 /* Class-level operations for threads. */
 static inline int xnthread_get_denormalized_prio(xnthread_t *t)
Index: xenomai/ksrc/nucleus/module.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/nucleus/module.c
+++ xenomai/ksrc/nucleus/module.c
@@ -421,16 +421,17 @@ static int stat_seq_open(struct inode *i
 		stat_info->csw =3D xnstat_counter_get(&thread->stat.csw);
 		stat_info->pf =3D xnstat_counter_get(&thread->stat.pf);
=20
-		period =3D sched->last_account_switch - thread->stat.account.start;
+		period =3D sched->last_account_switch - thread->stat.lastperiod.start;=

 		if (!period && thread =3D=3D sched->runthread) {
 			stat_info->runtime =3D 1;
 			stat_info->account_period =3D 1;
 		} else {
-			stat_info->runtime =3D thread->stat.account.total;
+			stat_info->runtime =3D thread->stat.account.total -
+				thread->stat.lastperiod.total;
 			stat_info->account_period =3D period;
 		}
-		thread->stat.account.total =3D 0;
-		thread->stat.account.start =3D sched->last_account_switch;
+		thread->stat.lastperiod.total =3D thread->stat.account.total;
+		thread->stat.lastperiod.start =3D sched->last_account_switch;
=20
 		holder =3D nextq(&nkpod->threadq, holder);
=20
Index: xenomai/ksrc/nucleus/pod.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/nucleus/pod.c
+++ xenomai/ksrc/nucleus/pod.c
@@ -832,7 +832,6 @@ int xnpod_start_thread(xnthread_t *threa
 	thread->imode =3D (mode & XNTHREAD_MODE_BITS);
 	thread->entry =3D entry;
 	thread->cookie =3D cookie;
-	thread->stime =3D xnarch_get_cpu_time();
=20
 	if (xnthread_test_state(thread, XNRRB))
 		thread->rrcredit =3D thread->rrperiod;
@@ -1781,8 +1780,9 @@ int xnpod_migrate_thread(int cpu)
=20
 	xnpod_schedule();
=20
-	/* Reset execution time stats due to unsync'ed TSCs */
-	xnstat_runtime_reset_stats(&thread->stat.account);
+	/* Reset execution time measurement period so that we don't mess up
+	   per-CPU statistics. */
+	xnstat_runtime_reset_stats(&thread->stat.lastperiod);
=20
       unlock_and_exit:
=20
Index: xenomai/ksrc/nucleus/thread.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/nucleus/thread.c
+++ xenomai/ksrc/nucleus/thread.c
@@ -103,7 +103,6 @@ int xnthread_init(xnthread_t *thread,
 	thread->imode =3D 0;
 	thread->entry =3D NULL;
 	thread->cookie =3D 0;
-	thread->stime =3D 0;
 	thread->ops =3D ops;
=20
 	inith(&thread->glink);
Index: xenomai/ksrc/skins/native/task.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/skins/native/task.c
+++ xenomai/ksrc/skins/native/task.c
@@ -1121,6 +1121,7 @@ int rt_task_unblock(RT_TASK *task)
 int rt_task_inquire(RT_TASK *task, RT_TASK_INFO *info)
 {
 	int err =3D 0;
+	xnticks_t raw_exectime;
 	spl_t s;
=20
 	if (!task) {
@@ -1144,6 +1145,14 @@ int rt_task_inquire(RT_TASK *task, RT_TA
 	info->cprio =3D xnthread_current_priority(&task->thread_base);
 	info->status =3D xnthread_state_flags(&task->thread_base);
 	info->relpoint =3D xntimer_get_date(&task->thread_base.ptimer);
+	raw_exectime =3D xnthread_get_exectime(&task->thread_base);
+	if (task->thread_base.sched->runthread =3D=3D &task->thread_base)
+		raw_exectime +=3D xnstat_runtime_now() -
+			xnthread_get_lastswitch(&task->thread_base);
+	info->exectime =3D xnarch_tsc_to_ns(raw_exectime);
+	info->modeswitches =3D xnstat_counter_get(&task->thread_base.stat.ssw);=

+	info->ctxswitches =3D xnstat_counter_get(&task->thread_base.stat.csw);
+	info->pagefaults =3D xnstat_counter_get(&task->thread_base.stat.pf);
=20
       unlock_and_exit:
=20

--------------030405070500000107010807--

--------------enigD11AF8601510784D4BCD0338
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFGlqi/niDOoMHTA+kRAvbYAKCCQU179SpnAWa5lamdjNuogKMZGwCeN+Qf
ytvL/fPTRYN9IV+m7tmJo+g=
=3IwF
-----END PGP SIGNATURE-----

--------------enigD11AF8601510784D4BCD0338--

