Date: Fri, 29 Jun 2007 16:43:26 +0200
From: Daniel Simon <Daniel.Simon@domain.hid>
Message-ID: <20070629164326.15579570@domain.hid>
In-Reply-To: <46825054.7030800@domain.hid>
References: <2404.194.199.21.225.1181233422.squirrel@domain.hid>
	<4668440F.7020706@domain.hid>
	<20070608124927.1b789a9e@domain.hid>
	<46693B6B.1010201@domain.hid>
	<20070625175107.438849fa@domain.hid>
	<467FF391.8020401@domain.hid>
	<20070627105726.7db7a459@domain.hid>
	<46825054.7030800@domain.hid>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=MP_bCq94vpFD.WLTXQ.zETcRIp
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

--MP_bCq94vpFD.WLTXQ.zETcRIp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wed, 27 Jun 2007 13:56:04 +0200
Jan Kiszka <jan.kiszka@domain.hid> wrote:

> > On Mon, 25 Jun 2007 18:55:45 +0200
> > Jan Kiszka <jan.kiszka@domain.hid> wrote:

> >> My idea was to keep a persistent version the existing xnstat_runtime_t
> >> instance in xnthread (and later on also xnintr). That one shall not be
> >> reset on readout via /proc.
> > Is it necessary to keep also the reset one?
> 
> Yep, at least virtually (as in my proposal): We are dumping CPU share
> percentages in /proc, and those need to be calculated over the same
> measurement period. Thus we restart the measurement each time the user
> reads the stats.
> 
> >> Let's try it like this: Change Xenomai so that it leaves the existing
> >> xnthread_t::stat.account untouched when it reads /proc. Rather add
> >> something like " last;" to xnthread_t::stat. On readout
> >> for /proc output, 

> That's one spot, the other is xnpod_migrate_thread()
> (xnstat_runtime_reset_stats()) IIRC.

ok, i've found only these two reset points.

the account structure is also partially touched by  xnstat_runtime_finalize()
in pod.c, I don't understand when and why...

> >> account into last. For your task exectime, you can then read
> >> xnthread_t::stat.account directly, because it will always reflect the
> >> full task history. Would't this work better?
> Jan
> 
please find attached a new patch following these ideas:
 (patch against svn trunk Revision: 2672) 

account is now persistent, its "start" field is the last_switch time, and the
new xnstat_runtime_t "lastperiod" handles the past values necessary to compute
the runtime values plot at snapshot time.

from a few trials, it seems that /proc/xenomai/stat still behaves normally (i.e.
like in the original version where the first reading of stat does gives nothing
for the tasks runtime?)

exectime returns likely values when a task is measured by another one, but self
measurement (with the NULL task calling parameter in rt_task_inquire) sometime
provides incoherent values (e.g. returns the period rather than the exectime,
or returns non-monotonic exectime values...). 
I could not manage to fix this bug upto now. 
And unfortunately i'll be away and probably far from any xenomai-capable
machine next week...

Looking forward,
			Daniel

-- 
       Daniel SIMON    Projet NeCS  INRIA Rhone-Alpes
        Inovallee, 655 avenue de l'Europe, Montbonnot
             38 334 Saint Ismier Cedex France
 Daniel.Simon@domain.hid Phone:(33)476615328 Fax:(33)476615252
          http://necs.inrialpes.fr/people/simon/



--MP_bCq94vpFD.WLTXQ.zETcRIp
Content-Type: text/x-patch; name=2672-exectime.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=2672-exectime.patch

diff -urN xenomai-orig/include/native/task.h xenomai/include/native/task.h
--- xenomai-orig/include/native/task.h	2007-06-28 10:19:19.000000000 +0200
+++ xenomai/include/native/task.h	2007-06-29 15:07:08.000000000 +0200
@@ -90,6 +90,8 @@
     
     char name[XNOBJECT_NAME_LEN];  /**< Symbolic name assigned at creation. */
 
+    RTIME exectime; /**<execution time in tsc ticks since the task spawned (primary mode only) */
+
 } RT_TASK_INFO;
 
 #define RT_MCB_FSTORE_LIMIT  64
diff -urN xenomai-orig/include/nucleus/stat.h xenomai/include/nucleus/stat.h
--- xenomai-orig/include/nucleus/stat.h	2007-06-28 10:19:37.000000000 +0200
+++ xenomai/include/nucleus/stat.h	2007-06-28 17:19:58.000000000 +0200
@@ -42,7 +42,7 @@
 do { \
 	(sched)->current_account->total += \
 		date - (sched)->last_account_switch; \
-	(sched)->last_account_switch = date; \
+	(sched)->last_account_switch = (sched)->current_account->start = date; \
 } while (0)
 
 /* Update the current account reference, returning the previous one. */
diff -urN xenomai-orig/include/nucleus/thread.h xenomai/include/nucleus/thread.h
--- xenomai-orig/include/nucleus/thread.h	2007-06-28 10:19:37.000000000 +0200
+++ xenomai/include/nucleus/thread.h	2007-06-28 12:46:11.000000000 +0200
@@ -204,7 +204,8 @@
 	xnstat_counter_t ssw;	/* Primary -> secondary mode switch count */
 	xnstat_counter_t csw;	/* Context switches (includes secondary -> primary switches) */
 	xnstat_counter_t pf;	/* Number of page faults */
-	xnstat_runtime_t account; /* Runtime accounting entity */
+	xnstat_runtime_t account; /* Exectime accounting entity */
+	xnstat_runtime_t lastperiod;  /* Runtime accounting entity */
     } stat;
 
     int errcode;		/* Local errno */
@@ -291,7 +292,8 @@
 #define xnthread_user_pid(thread) \
     (xnthread_test_state((thread),XNROOT) || !xnthread_user_task(thread) ? \
     0 : xnarch_user_pid(xnthread_archtcb(thread)))
-
+#define xnthread_get_exectime(thread)      ((thread)->stat.account.total)
+#define xnthread_get_lastswitch(thread)    ((thread)->stat.account.start)
 /* Class-level operations for threads. */
 static inline int xnthread_get_denormalized_prio(xnthread_t *t)
 {
diff -urN xenomai-orig/ksrc/nucleus/module.c xenomai/ksrc/nucleus/module.c
--- xenomai-orig/ksrc/nucleus/module.c	2007-06-28 10:20:36.000000000 +0200
+++ xenomai/ksrc/nucleus/module.c	2007-06-28 15:07:40.000000000 +0200
@@ -421,16 +421,16 @@
 		stat_info->csw = xnstat_counter_get(&thread->stat.csw);
 		stat_info->pf = xnstat_counter_get(&thread->stat.pf);
 
-		period = sched->last_account_switch - thread->stat.account.start;
+		period = sched->last_account_switch - thread->stat.lastperiod.start;
 		if (!period && thread == sched->runthread) {
 			stat_info->runtime = 1;
 			stat_info->account_period = 1;
 		} else {
-			stat_info->runtime = thread->stat.account.total;
+			stat_info->runtime = thread->stat.account.total - thread->stat.lastperiod.total;
 			stat_info->account_period = period;
 		}
-		thread->stat.account.total = 0;
-		thread->stat.account.start = sched->last_account_switch;
+		thread->stat.lastperiod.total = thread->stat.account.total;
+		thread->stat.lastperiod.start = sched->last_account_switch;
 
 		holder = nextq(&nkpod->threadq, holder);
 
diff -urN xenomai-orig/ksrc/nucleus/pod.c xenomai/ksrc/nucleus/pod.c
--- xenomai-orig/ksrc/nucleus/pod.c	2007-06-28 10:20:36.000000000 +0200
+++ xenomai/ksrc/nucleus/pod.c	2007-06-28 12:10:09.000000000 +0200
@@ -1772,7 +1772,7 @@
 	xnpod_schedule();
 
 	/* Reset execution time stats due to unsync'ed TSCs */
-	xnstat_runtime_reset_stats(&thread->stat.account);
+	xnstat_runtime_reset_stats(&thread->stat.lastperiod);
 
       unlock_and_exit:
 
diff -urN xenomai-orig/ksrc/nucleus/thread.c xenomai/ksrc/nucleus/thread.c
--- xenomai-orig/ksrc/nucleus/thread.c	2007-06-28 10:20:36.000000000 +0200
+++ xenomai/ksrc/nucleus/thread.c	2007-06-28 12:40:51.000000000 +0200
@@ -97,7 +97,12 @@
 	thread->registry.waitkey = NULL;
 #endif /* CONFIG_XENO_OPT_REGISTRY */
 	memset(&thread->stat, 0, sizeof(thread->stat));
-
+#ifdef CONFIG_XENO_OPT_STATS
+	thread->stat.account.total = 0;
+	thread->stat.account.start = 0;
+	thread->stat.lastperiod.total = 0;
+	thread->stat.lastperiod.start = 0;
+#endif
 	/* These will be filled by xnpod_start_thread() */
 	thread->imask = 0;
 	thread->imode = 0;
diff -urN xenomai-orig/ksrc/skins/native/task.c xenomai/ksrc/skins/native/task.c
--- xenomai-orig/ksrc/skins/native/task.c	2007-06-28 10:20:17.000000000 +0200
+++ xenomai/ksrc/skins/native/task.c	2007-06-28 17:20:29.000000000 +0200
@@ -1144,7 +1144,10 @@
 	info->cprio = xnthread_current_priority(&task->thread_base);
 	info->status = xnthread_state_flags(&task->thread_base);
 	info->relpoint = xntimer_get_date(&task->thread_base.ptimer);
-
+	if(task == xeno_current_task())
+	  info->exectime = xnthread_get_exectime(&task->thread_base) + (xnstat_runtime_now() - xnthread_get_lastswitch(&task->thread_base));
+	else 
+	  info->exectime = xnthread_get_exectime(&task->thread_base);
       unlock_and_exit:
 
 	xnlock_put_irqrestore(&nklock, s);

--MP_bCq94vpFD.WLTXQ.zETcRIp--

