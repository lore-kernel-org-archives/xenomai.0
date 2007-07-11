Date: Wed, 11 Jul 2007 18:55:29 +0200
From: Daniel Simon <Daniel.Simon@domain.hid>
Message-ID: <20070711185529.62544380@domain.hid>
In-Reply-To: <4694FD99.3030405@domain.hid>
References: <2404.194.199.21.225.1181233422.squirrel@domain.hid>
	<4668440F.7020706@domain.hid>
	<20070608124927.1b789a9e@domain.hid>
	<46693B6B.1010201@domain.hid>
	<20070625175107.438849fa@domain.hid>
	<467FF391.8020401@domain.hid>
	<20070627105726.7db7a459@domain.hid>
	<46825054.7030800@domain.hid>
	<20070629164326.15579570@domain.hid>
	<4690B86C.1000907@domain.hid>
	<20070711155932.4b88699e@domain.hid>
	<4694E96B.5020801@domain.hid>
	<20070711173545.709225f1@domain.hid>
	<4694FD99.3030405@domain.hid>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_vA/_fWHLiNd2ZHbPvz2RtfT"
Subject: Re: [Xenomai-core] measuring tasks execution time
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

--MP_vA/_fWHLiNd2ZHbPvz2RtfT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wed, 11 Jul 2007 17:56:09 +0200
Jan Kiszka <jan.kiszka@domain.hid> wrote:

> Let's find a compromise: I will try to role out -v2 of this patch with
> your fixes soon. And you will try to do the in-depth tests of exectime
> reporting once you have a Xenomai box again? Hacking is cheap, testing
> takes the time... :) Or does the test code you once submitted report
> clear results /wrt the correctness of the exectime data?

What I mean is that I can perform tests _only on a Pentium3 UP_, and on this
machine I upto now get consistent results on the basic tests using the last
fixes (and I will do further testing with various applications).

I cannot (and will not be able in a previsible future) perform tests
neither on a SMP nor on not_i386 architectures...

In attachment: 
the full exectime-V2.patch (including all the fixes we discussed
today) against a vanilla 2758 release, which compiled and behaves well on my
basic examples and UP machine. (it also patches with no hunk against
last release 2764), 
and the add-on against your original patch (I don't know what
is the easiest way for you...)

	Daniel

-- 
       Daniel SIMON    Projet NeCS  INRIA Rhone-Alpes
        Inovallee, 655 avenue de l'Europe, Montbonnot
             38 334 Saint Ismier Cedex France
 Daniel.Simon@domain.hid Phone:(33)476615328 Fax:(33)476615252
          http://necs.inrialpes.fr/people/simon/



--MP_vA/_fWHLiNd2ZHbPvz2RtfT
Content-Type: text/x-patch; name=2758-exectime.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=2758-exectime.patch

diff -urN xenomai/include/native/task.h xenomai-2758-V2/include/native/task.h
--- xenomai/include/native/task.h	2007-07-09 13:06:54.000000000 +0200
+++ xenomai-2758-V2/include/native/task.h	2007-07-11 09:55:02.000000000 +0200
@@ -90,6 +90,14 @@
     
     char name[XNOBJECT_NAME_LEN];  /**< Symbolic name assigned at creation. */
 
+    RTIME exectime; /**< Execution time in primary mode in nanoseconds. */
+
+    int modeswitches; /**< Number of primary->secondary mode switches. */
+
+    int ctxswitches; /**< Number of context switches. */
+
+    int pagefaults; /**< Number of triggered page faults. */
+
 } RT_TASK_INFO;
 
 #define RT_MCB_FSTORE_LIMIT  64
diff -urN xenomai/include/nucleus/stat.h xenomai-2758-V2/include/nucleus/stat.h
--- xenomai/include/nucleus/stat.h	2007-07-09 13:07:01.000000000 +0200
+++ xenomai-2758-V2/include/nucleus/stat.h	2007-07-11 15:09:38.000000000 +0200
@@ -42,7 +42,7 @@
 do { \
 	(sched)->current_account->total += \
 		date - (sched)->last_account_switch; \
-	(sched)->last_account_switch = date; \
+	(sched)->last_account_switch = (sched)->current_account->start = date; \
 	/* All changes must be committed before changing the current_account \
 	   reference in sched (required for xnintr_sync_stat_references) */ \
 	xnarch_memory_barrier(); \
@@ -67,6 +67,13 @@
 	(sched)->current_account = (new_account); \
 } while (0)
 
+/* Obtain content of xnstat_runtime_t */
+#define xnstat_runtime_get_start(account)	((account)->start)
+#define xnstat_runtime_get_total(account)	((account)->total)
+
+/* Obtain last time something has been switched */
+#define xnstat_runtime_get_last_switch(sched)	((sched)->last_account_switch)
+
 /* Reset statistics from inside the accounted entity (e.g. after CPU
    migration). */
 #define xnstat_runtime_reset_stats(stat) \
@@ -104,9 +111,12 @@
 
 #define xnstat_runtime_now()					({ 0; })
 #define xnstat_runtime_update(sched, date)			do { } while (0)
-#define xnstat_runtime_set_current(sched, new_account)	({ (void)sched; NULL; })
+#define xnstat_runtime_set_current(sched, new_account)		({ (void)sched; NULL; })
 #define xnstat_runtime_get_current(sched)			({ (void)sched; NULL; })
 #define xnstat_runtime_finalize(sched, new_account)		do { } while (0)
+#define xnstat_runtime_get_start(account)			({ 0; })
+#define xnstat_runtime_get_total(account)			({ 0; })
+#define xnstat_runtime_get_last_switch(sched)			({ 0; })
 #define xnstat_runtime_reset_stats(account)			do { } while (0)
 
 typedef struct xnstat_counter {
diff -urN xenomai/include/nucleus/thread.h xenomai-2758-V2/include/nucleus/thread.h
--- xenomai/include/nucleus/thread.h	2007-07-09 13:07:01.000000000 +0200
+++ xenomai-2758-V2/include/nucleus/thread.h	2007-07-11 14:28:15.000000000 +0200
@@ -205,7 +205,8 @@
 	xnstat_counter_t ssw;	/* Primary -> secondary mode switch count */
 	xnstat_counter_t csw;	/* Context switches (includes secondary -> primary switches) */
 	xnstat_counter_t pf;	/* Number of page faults */
-	xnstat_runtime_t account; /* Runtime accounting entity */
+	xnstat_runtime_t account; /* Execution time accounting entity */
+	xnstat_runtime_t lastperiod; /* Interval marker for execution time reports */
     } stat;
 
     int errcode;		/* Local errno */
@@ -235,8 +236,6 @@
 
     char name[XNOBJECT_NAME_LEN]; /* Symbolic name of thread */
 
-    xnticks_t stime;		/* Start time */
-
     void (*entry)(void *cookie); /* Thread entry routine */
 
     void *cookie;		/* Cookie to pass to the entry routine */
@@ -294,6 +293,8 @@
     0 : xnarch_user_pid(xnthread_archtcb(thread)))
 #define xnthread_affinity(thread)          ((thread)->affinity)
 #define xnthread_affine_p(thread, cpu)     xnarch_cpu_isset(cpu, (thread)->affinity)
+#define xnthread_get_exectime(thread)      xnstat_runtime_get_total(&(thread)->stat.account)
+#define xnthread_get_lastswitch(thread)    xnstat_runtime_get_last_switch((thread)->sched)
 
 /* Class-level operations for threads. */
 static inline int xnthread_get_denormalized_prio(xnthread_t *t)
diff -urN xenomai/ksrc/nucleus/module.c xenomai-2758-V2/ksrc/nucleus/module.c
--- xenomai/ksrc/nucleus/module.c	2007-07-09 13:07:18.000000000 +0200
+++ xenomai-2758-V2/ksrc/nucleus/module.c	2007-07-11 09:55:02.000000000 +0200
@@ -421,16 +421,17 @@
 		stat_info->csw = xnstat_counter_get(&thread->stat.csw);
 		stat_info->pf = xnstat_counter_get(&thread->stat.pf);
 
-		period = sched->last_account_switch - thread->stat.account.start;
+		period = sched->last_account_switch - thread->stat.lastperiod.start;
 		if (!period && thread == sched->runthread) {
 			stat_info->runtime = 1;
 			stat_info->account_period = 1;
 		} else {
-			stat_info->runtime = thread->stat.account.total;
+			stat_info->runtime = thread->stat.account.total -
+				thread->stat.lastperiod.total;
 			stat_info->account_period = period;
 		}
-		thread->stat.account.total = 0;
-		thread->stat.account.start = sched->last_account_switch;
+		thread->stat.lastperiod.total = thread->stat.account.total;
+		thread->stat.lastperiod.start = sched->last_account_switch;
 
 		holder = nextq(&nkpod->threadq, holder);
 
diff -urN xenomai/ksrc/nucleus/pod.c xenomai-2758-V2/ksrc/nucleus/pod.c
--- xenomai/ksrc/nucleus/pod.c	2007-07-09 13:07:18.000000000 +0200
+++ xenomai-2758-V2/ksrc/nucleus/pod.c	2007-07-11 09:55:02.000000000 +0200
@@ -832,7 +832,6 @@
 	thread->imode = (mode & XNTHREAD_MODE_BITS);
 	thread->entry = entry;
 	thread->cookie = cookie;
-	thread->stime = xnarch_get_cpu_time();
 
 	if (xnthread_test_state(thread, XNRRB))
 		thread->rrcredit = thread->rrperiod;
@@ -1781,8 +1780,9 @@
 
 	xnpod_schedule();
 
-	/* Reset execution time stats due to unsync'ed TSCs */
-	xnstat_runtime_reset_stats(&thread->stat.account);
+	/* Reset execution time measurement period so that we don't mess up
+	   per-CPU statistics. */
+	xnstat_runtime_reset_stats(&thread->stat.lastperiod);
 
       unlock_and_exit:
 
diff -urN xenomai/ksrc/nucleus/thread.c xenomai-2758-V2/ksrc/nucleus/thread.c
--- xenomai/ksrc/nucleus/thread.c	2007-07-09 13:07:18.000000000 +0200
+++ xenomai-2758-V2/ksrc/nucleus/thread.c	2007-07-11 09:55:02.000000000 +0200
@@ -103,7 +103,6 @@
 	thread->imode = 0;
 	thread->entry = NULL;
 	thread->cookie = 0;
-	thread->stime = 0;
 	thread->ops = ops;
 
 	inith(&thread->glink);
diff -urN xenomai/ksrc/skins/native/task.c xenomai-2758-V2/ksrc/skins/native/task.c
--- xenomai/ksrc/skins/native/task.c	2007-07-09 13:07:13.000000000 +0200
+++ xenomai-2758-V2/ksrc/skins/native/task.c	2007-07-11 15:22:10.000000000 +0200
@@ -1144,6 +1144,16 @@
 	info->cprio = xnthread_current_priority(&task->thread_base);
 	info->status = xnthread_state_flags(&task->thread_base);
 	info->relpoint = xntimer_get_date(&task->thread_base.ptimer);
+	if(task == xeno_current_task())
+	info->exectime = xnarch_tsc_to_ns(
+		xnthread_get_exectime(&task->thread_base) +
+		xnstat_runtime_now() -
+		xnthread_get_lastswitch(&task->thread_base));
+	else 
+	  info->exectime = xnarch_tsc_to_ns(xnthread_get_exectime(&task->thread_base));
+	info->modeswitches = xnstat_counter_get(&task->thread_base.stat.ssw);
+	info->ctxswitches = xnstat_counter_get(&task->thread_base.stat.csw);
+	info->pagefaults = xnstat_counter_get(&task->thread_base.stat.pf);
 
       unlock_and_exit:
 

--MP_vA/_fWHLiNd2ZHbPvz2RtfT
Content-Type: text/x-patch; name=exectime-add-on.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=exectime-add-on.patch

diff -urN xenomai-2758/include/nucleus/stat.h xenomai-exectime-V2/include/nucleus/stat.h
--- xenomai-2758/include/nucleus/stat.h	2007-07-11 18:47:11.000000000 +0200
+++ xenomai-exectime-V2/include/nucleus/stat.h	2007-07-11 18:22:53.000000000 +0200
@@ -71,6 +71,9 @@
 #define xnstat_runtime_get_start(account)	((account)->start)
 #define xnstat_runtime_get_total(account)	((account)->total)
 
+/*Get last account switch date on considered sched */
+#define xnstat_runtime_get_last_switch(sched)	((sched)->last_account_switch)
+
 /* Reset statistics from inside the accounted entity (e.g. after CPU
    migration). */
 #define xnstat_runtime_reset_stats(stat) \
@@ -113,6 +116,7 @@
 #define xnstat_runtime_finalize(sched, new_account)		do { } while (0)
 #define xnstat_runtime_get_start(account)			({ 0; })
 #define xnstat_runtime_get_total(account)			({ 0; })
+#define xnstat_runtime_get_last_switch(sched)			({ 0; })
 #define xnstat_runtime_reset_stats(account)			do { } while (0)
 
 typedef struct xnstat_counter {
diff -urN xenomai-2758/include/nucleus/thread.h xenomai-exectime-V2/include/nucleus/thread.h
--- xenomai-2758/include/nucleus/thread.h	2007-07-11 18:47:11.000000000 +0200
+++ xenomai-exectime-V2/include/nucleus/thread.h	2007-07-11 14:28:15.000000000 +0200
@@ -294,7 +294,7 @@
 #define xnthread_affinity(thread)          ((thread)->affinity)
 #define xnthread_affine_p(thread, cpu)     xnarch_cpu_isset(cpu, (thread)->affinity)
 #define xnthread_get_exectime(thread)      xnstat_runtime_get_total(&(thread)->stat.account)
-#define xnthread_get_lastswitch(thread)    xnstat_runtime_get_start(&(thread)->stat.account)
+#define xnthread_get_lastswitch(thread)    xnstat_runtime_get_last_switch((thread)->sched)
 
 /* Class-level operations for threads. */
 static inline int xnthread_get_denormalized_prio(xnthread_t *t)
diff -urN xenomai-2758/ksrc/skins/native/task.c xenomai-exectime-V2/ksrc/skins/native/task.c
--- xenomai-2758/ksrc/skins/native/task.c	2007-07-11 18:47:11.000000000 +0200
+++ xenomai-exectime-V2/ksrc/skins/native/task.c	2007-07-11 18:10:12.000000000 +0200
@@ -1144,10 +1144,13 @@
 	info->cprio = xnthread_current_priority(&task->thread_base);
 	info->status = xnthread_state_flags(&task->thread_base);
 	info->relpoint = xntimer_get_date(&task->thread_base.ptimer);
+	if (task->thread_base.sched->runthread == &task->thread_base)
 	info->exectime = xnarch_tsc_to_ns(
 		xnthread_get_exectime(&task->thread_base) +
 		xnstat_runtime_now() -
 		xnthread_get_lastswitch(&task->thread_base));
+	else 
+	  info->exectime = xnarch_tsc_to_ns(xnthread_get_exectime(&task->thread_base));
 	info->modeswitches = xnstat_counter_get(&task->thread_base.stat.ssw);
 	info->ctxswitches = xnstat_counter_get(&task->thread_base.stat.csw);
 	info->pagefaults = xnstat_counter_get(&task->thread_base.stat.pf);

--MP_vA/_fWHLiNd2ZHbPvz2RtfT--

