Message-ID: <452E9AD3.3030206@domain.hid>
Date: Thu, 12 Oct 2006 21:43:15 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040109070602060905090609"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH 1/3] Introduce xnstat subsystem
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>, xenomai-core <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------040109070602060905090609
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

This patch adds the new abstraction xnstat_counter (event counter) and
xnstat_runtime (runtime accumulator) and related services to maintain
and query this data. The whole subsystem evaluates to void if
XENO_OPT_STATS is not selected.

Moreover, the patch moves the existing thread statistics (exec_time and
various counters) over the new infrastructure.

Jan

--------------040109070602060905090609
Content-Type: text/plain;
 name="introduce_xnstat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="introduce_xnstat.patch"

---
 include/nucleus/pod.h    |   38 +---------------
 include/nucleus/stat.h   |  106 +++++++++++++++++++++++++++++++++++++++++++++++
 include/nucleus/thread.h |   24 ++--------
 ksrc/nucleus/module.c    |   59 ++++++++++++--------------
 ksrc/nucleus/pod.c       |   18 ++++---
 ksrc/nucleus/shadow.c    |    3 -
 ksrc/nucleus/thread.c    |    9 ---
 7 files changed, 157 insertions(+), 100 deletions(-)

Index: xenomai/include/nucleus/pod.h
===================================================================
--- xenomai.orig/include/nucleus/pod.h
+++ xenomai/include/nucleus/pod.h
@@ -146,7 +146,9 @@ typedef struct xnsched {
     xnthread_t rootcb;          /*!< Root thread control block. */
 
 #ifdef CONFIG_XENO_OPT_STATS
-    xnticks_t last_csw;         /*!< Last context switch (ticks). */
+    xnticks_t last_account_switch; /*!< Last account switch date (ticks). */
+
+    xnstat_runtime_t *current_account;  /*!< Currently active account */
 #endif /* CONFIG_XENO_OPT_STATS */
 
 } xnsched_t;
@@ -544,40 +546,6 @@ static inline void xnpod_delete_self (vo
     xnpod_delete_thread(xnpod_current_thread());
 }
 
-#ifdef CONFIG_XENO_OPT_STATS
-static inline void xnpod_acc_exec_time(xnsched_t *sched, xnthread_t *thread)
-{
-    xnticks_t now = xnarch_get_cpu_tsc();
-
-    thread->stat.exec_time += now - sched->last_csw;
-    sched->last_csw = now;
-}
-
-static inline void xnpod_reset_exec_stats(xnthread_t *thread)
-{
-    thread->stat.exec_time = 0;
-    thread->stat.exec_start = xnarch_get_cpu_tsc();
-}
-
-static inline void xnpod_update_csw_date(xnsched_t *sched)
-{
-    sched->last_csw = xnarch_get_cpu_tsc();
-}
-
-#else /* !CONFIG_XENO_OPT_STATS */
-static inline void xnpod_acc_exec_time(xnsched_t *sched, xnthread_t *thread)
-{
-}
-
-static inline void xnpod_reset_exec_stats(xnthread_t *thread)
-{
-}
-
-static inline void xnpod_update_csw_date(xnsched_t *sched)
-{
-}
-#endif /* CONFIG_XENO_OPT_STATS */
-
 #ifdef __cplusplus
 }
 #endif
Index: xenomai/include/nucleus/stat.h
===================================================================
--- /dev/null
+++ xenomai/include/nucleus/stat.h
@@ -0,0 +1,106 @@
+/*
+ * Copyright (C) 2006 Jan Kiszka <jan.kiszka@domain.hid>.
+ * Copyright (C) 2006 Dmitry Adamushko <dmitry.adamushko@domain.hid>.
+ *
+ * Xenomai is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published
+ * by the Free Software Foundation; either version 2 of the License,
+ * or (at your option) any later version.
+ *
+ * Xenomai is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with Xenomai; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
+ * 02111-1307, USA.
+ */
+
+#ifndef _XENO_NUCLEUS_STAT_H
+#define _XENO_NUCLEUS_STAT_H
+
+#ifdef CONFIG_XENO_OPT_STATS
+
+typedef struct xnstat_runtime {
+
+	xnticks_t start;   /* Start of execution time accumulation */
+
+	xnticks_t total; /* Accumulated execution time */
+
+} xnstat_runtime_t;
+
+/* Account runtime of current account up to now, but don't set a new
+   account yet. */
+#define xnstat_runtime_update(sched) \
+do { \
+	xnticks_t now = xnarch_get_cpu_tsc(); \
+	(sched)->current_account->total += \
+		now - (sched)->last_account_switch; \
+	(sched)->last_account_switch = now; \
+} while (0)
+
+/* Update the current account reference, returning the previous one. */
+#define xnstat_runtime_set_current(sched, new_account) \
+({ \
+	xnstat_runtime_t *__prev; \
+	__prev = xchg(&(sched)->current_account, (new_account)); \
+	__prev; \
+})
+
+/* Return the currently active accounting entity. */
+#define xnstat_runtime_get_current(sched) ((sched)->current_account)
+
+/* Finalize an account (no need to do further accounting, just mark the
+   switch date). */
+#define xnstat_runtime_finalize(sched) \
+	(sched)->last_account_switch = xnarch_get_cpu_tsc()
+
+/* Reset statistics from inside the accounted entity (e.g. after CPU
+   migration). */
+#define xnstat_runtime_reset_stats(stat) \
+do { \
+	(stat)->total = 0; \
+	(stat)->start = xnarch_get_cpu_tsc(); \
+} while (0)
+
+
+typedef struct xnstat_counter {
+	int counter;
+} xnstat_counter_t;
+
+static inline int xnstat_counter_inc(xnstat_counter_t *c) {
+	return c->counter++;
+}
+
+static inline int xnstat_counter_get(xnstat_counter_t *c) {
+	return c->counter;
+}
+
+#else /* !CONFIG_XENO_OPT_STATS */
+typedef struct xnstat_runtime {
+} xnstat_runtime_t;
+
+#define xnstat_runtime_update(sched)                         do { } while (0)
+#define xnstat_runtime_set_current(sched, new_account)       ({ NULL; })
+#define xnstat_runtime_get_current(sched)                    ({ NULL; })
+#define xnstat_runtime_finalize(sched)                       do { } while (0)
+#define xnstat_runtime_reset_stats(account)                  do { } while (0)
+
+typedef struct xnstat_counter {
+} xnstat_counter_t;
+
+static inline int xnstat_counter_inc(xnstat_counter_t *c) { return 0; }
+static inline int xnstat_counter_get(xnstat_counter_t *c) { return 0; }
+#endif /* CONFIG_XENO_OPT_STATS */
+
+/* Switch to new_account, accounting the runtime of the current one until now
+   and returning the previous account. */
+#define xnstat_runtime_switch(sched, new_account) \
+({ \
+	xnstat_runtime_update(sched); \
+	xnstat_runtime_set_current(sched, new_account); \
+})
+
+#endif /* !_XENO_NUCLEUS_STAT_H */
Index: xenomai/include/nucleus/thread.h
===================================================================
--- xenomai.orig/include/nucleus/thread.h
+++ xenomai/include/nucleus/thread.h
@@ -105,6 +105,8 @@
 
 #if defined(__KERNEL__) || defined(__XENO_SIM__)
 
+#include <nucleus/stat.h>
+
 #ifdef __XENO_SIM__
 /* Pseudo-status (must not conflict with other bits) */
 #define XNRUNNING  XNTHREAD_SPARE0
@@ -158,16 +160,12 @@ typedef struct xnthread {
 
     xnticks_t rrcredit;		/* Remaining round-robin time credit (ticks) */
 
-#ifdef CONFIG_XENO_OPT_STATS
     struct {
-	unsigned long ssw;	/* Primary -> secondary mode switch count */
-	unsigned long csw;	/* Context switches (includes
-				   secondary -> primary switches) */
-	unsigned long pf;	/* Number of page faults */
-       xnticks_t exec_time;    /* Accumulated execution time (tsc) */
-       xnticks_t exec_start;   /* Start of execution time accumulation (tsc) */
+	xnstat_counter_t ssw;	/* Primary -> secondary mode switch count */
+	xnstat_counter_t csw;	/* Context switches (includes secondary -> primary switches) */
+	xnstat_counter_t pf;	/* Number of page faults */
+	xnstat_runtime_t account; /* Runtime accounting entity */
     } stat;
-#endif /* CONFIG_XENO_OPT_STATS */
 
     int errcode;		/* Local errno */
 
@@ -248,16 +246,6 @@ typedef struct xnhook {
     (testbits((thread)->status,XNROOT) || !xnthread_user_task(thread) ? \
     0 : xnarch_user_pid(xnthread_archtcb(thread)))
 
-#ifdef CONFIG_XENO_OPT_STATS
-#define xnthread_inc_ssw(thread)     ++(thread)->stat.ssw
-#define xnthread_inc_csw(thread)     ++(thread)->stat.csw
-#define xnthread_inc_pf(thread)      ++(thread)->stat.pf
-#else /* CONFIG_XENO_OPT_STATS */
-#define xnthread_inc_ssw(thread)     do { } while(0)
-#define xnthread_inc_csw(thread)     do { } while(0)
-#define xnthread_inc_pf(thread)      do { } while(0)
-#endif /* CONFIG_XENO_OPT_STATS */
-
 #ifdef __cplusplus
 extern "C" {
 #endif
Index: xenomai/ksrc/nucleus/module.c
===================================================================
--- xenomai.orig/ksrc/nucleus/module.c
+++ xenomai/ksrc/nucleus/module.c
@@ -269,8 +269,8 @@ struct stat_seq_iterator {
 		unsigned long ssw;
 		unsigned long csw;
 		unsigned long pf;
-		xnticks_t exec_time;
-		xnticks_t exec_period;
+		xnticks_t runtime;
+		xnticks_t account_period;
 	} stat_info[1];
 };
 
@@ -319,15 +319,15 @@ static int stat_seq_show(struct seq_file
 		struct stat_seq_info *p = (struct stat_seq_info *)v;
 		int usage = 0;
 
-		if (p->exec_period) {
-			while (p->exec_period > 0xFFFFFFFF) {
-				p->exec_time >>= 16;
-				p->exec_period >>= 16;
+		if (p->account_period) {
+			while (p->account_period > 0xFFFFFFFF) {
+				p->runtime >>= 16;
+				p->account_period >>= 16;
 			}
 			usage =
-			    xnarch_ulldiv(p->exec_time * 1000LL +
-					  (p->exec_period >> 1), p->exec_period,
-					  NULL);
+			    xnarch_ulldiv(p->runtime * 1000LL +
+					  (p->account_period >> 1),
+					  p->account_period, NULL);
 		}
 		seq_printf(seq, "%3u  %-6d %-10lu %-10lu %-4lu  %.8lx  %3u.%u"
 			   "  %s\n",
@@ -350,7 +350,8 @@ static int stat_seq_open(struct inode *i
 	struct stat_seq_iterator *iter = NULL;
 	struct seq_file *seq;
 	xnholder_t *holder;
-	int err, count, rev;
+	struct stat_seq_info *stat_info;
+	int err, count, thrq_rev;
 	spl_t s;
 
 	if (!nkpod)
@@ -359,9 +360,9 @@ static int stat_seq_open(struct inode *i
       restart:
 	xnlock_get_irqsave(&nklock, s);
 
-	rev = nkpod->threadq_rev;
 	count = countq(&nkpod->threadq);	/* Cannot be empty (ROOT) */
 	holder = getheadq(&nkpod->threadq);
+	thrq_rev = nkpod->threadq_rev;
 
 	xnlock_put_irqrestore(&nklock, s);
 
@@ -389,37 +390,35 @@ static int stat_seq_open(struct inode *i
 		xnthread_t *thread;
 		xnsched_t *sched;
 		xnticks_t period;
-		int n;
 
 		xnlock_get_irqsave(&nklock, s);
 
-		if (nkpod->threadq_rev != rev)
+		if (nkpod->threadq_rev != thrq_rev)
 			goto restart;
-		rev = nkpod->threadq_rev;
 
 		thread = link2thread(holder, glink);
-		n = iter->nentries++;
+		stat_info = &iter->stat_info[iter->nentries++];
 
 		sched = thread->sched;
-		iter->stat_info[n].cpu = xnsched_cpu(sched);
-		iter->stat_info[n].pid = xnthread_user_pid(thread);
-		memcpy(iter->stat_info[n].name, thread->name,
-		       sizeof(iter->stat_info[n].name));
-		iter->stat_info[n].status = thread->status;
-		iter->stat_info[n].ssw = thread->stat.ssw;
-		iter->stat_info[n].csw = thread->stat.csw;
-		iter->stat_info[n].pf = thread->stat.pf;
+		stat_info->cpu = xnsched_cpu(sched);
+		stat_info->pid = xnthread_user_pid(thread);
+		memcpy(stat_info->name, thread->name,
+		       sizeof(stat_info->name));
+		stat_info->status = thread->status;
+		stat_info->ssw = xnstat_counter_get(&thread->stat.ssw);
+		stat_info->csw = xnstat_counter_get(&thread->stat.csw);
+		stat_info->pf = xnstat_counter_get(&thread->stat.pf);
 
-		period = sched->last_csw - thread->stat.exec_start;
+		period = sched->last_account_switch - thread->stat.account.start;
 		if (!period && thread == sched->runthread) {
-			iter->stat_info[n].exec_time = 1;
-			iter->stat_info[n].exec_period = 1;
+			stat_info->runtime = 1;
+			stat_info->account_period = 1;
 		} else {
-			iter->stat_info[n].exec_time = thread->stat.exec_time;
-			iter->stat_info[n].exec_period = period;
+			stat_info->runtime = thread->stat.account.total;
+			stat_info->account_period = period;
 		}
-		thread->stat.exec_time = 0;
-		thread->stat.exec_start = sched->last_csw;
+		thread->stat.account.total = 0;
+		thread->stat.account.start = sched->last_account_switch;
 
 		holder = nextq(&nkpod->threadq, holder);
 
Index: xenomai/ksrc/nucleus/pod.c
===================================================================
--- xenomai.orig/ksrc/nucleus/pod.c
+++ xenomai/ksrc/nucleus/pod.c
@@ -41,6 +41,7 @@
 #include <nucleus/registry.h>
 #include <nucleus/module.h>
 #include <nucleus/ltt.h>
+#include <nucleus/stat.h>
 #include <asm/xenomai/bits/pod.h>
 
 /* NOTE: We need to initialize the globals: remember that this code
@@ -213,7 +214,7 @@ static int xnpod_fault_handler(xnarch_fl
 			/* The page fault counter is not SMP-safe, but it's a
 			   simple indicator that something went wrong wrt memory
 			   locking anyway. */
-			xnthread_inc_pf(thread);
+			xnstat_counter_inc(&thread->stat.pf);
 
 		xnshadow_relax(xnarch_fault_notify(fltinfo));
 	}
@@ -503,6 +504,8 @@ int xnpod_init(xnpod_t *pod, int minpri,
 		sched->rootcb.sched = sched;
 
 		sched->rootcb.affinity = xnarch_cpumask_of_cpu(cpu);
+
+		xnstat_runtime_set_current(sched, &sched->rootcb.stat.account);
 	}
 
 	xnarch_hook_ipi(&xnpod_schedule_handler);
@@ -668,8 +671,7 @@ static inline void xnpod_switch_zombie(x
 
 	xnthread_cleanup_tcb(threadout);
 
-	/* no need to update stats of dying thread */
-	xnpod_update_csw_date(sched);
+	xnstat_runtime_finalize(sched);
 
 	xnarch_finalize_and_switch(xnthread_archtcb(threadout),
 				   xnthread_archtcb(threadin));
@@ -1896,7 +1898,7 @@ int xnpod_migrate_thread(int cpu)
 	xnpod_schedule();
 
 	/* Reset execution time stats due to unsync'ed TSCs */
-	xnpod_reset_exec_stats(thread);
+	xnstat_runtime_reset_stats(&thread->stat.account);
 
       unlock_and_exit:
 
@@ -2435,8 +2437,8 @@ void xnpod_schedule(void)
 		xnarch_enter_root(xnthread_archtcb(threadin));
 	}
 
-	xnpod_acc_exec_time(sched, threadout);
-	xnthread_inc_csw(threadin);
+	xnstat_runtime_switch(sched, &threadin->stat.account);
+	xnstat_counter_inc(&threadin->stat.csw);
 
 	xnarch_switch_to(xnthread_archtcb(threadout),
 			 xnthread_archtcb(threadin));
@@ -2607,8 +2609,8 @@ void xnpod_schedule_runnable(xnthread_t 
 		nkpod->schedhook(runthread, XNREADY);
 #endif /* __XENO_SIM__ */
 
-	xnpod_acc_exec_time(sched, runthread);
-	xnthread_inc_csw(threadin);
+	xnstat_runtime_switch(sched, &threadin->stat.account);
+	xnstat_counter_inc(&threadin->stat.csw);
 
 	xnarch_switch_to(xnthread_archtcb(runthread),
 			 xnthread_archtcb(threadin));
Index: xenomai/ksrc/nucleus/shadow.c
===================================================================
--- xenomai.orig/ksrc/nucleus/shadow.c
+++ xenomai/ksrc/nucleus/shadow.c
@@ -50,6 +50,7 @@
 #include <nucleus/jhash.h>
 #include <nucleus/ppd.h>
 #include <nucleus/trace.h>
+#include <nucleus/stat.h>
 #include <asm/xenomai/features.h>
 #include <asm/xenomai/syscall.h>
 #include <asm/xenomai/bits/shadow.h>
@@ -727,7 +728,7 @@ void xnshadow_relax(int notify)
 	rthal_reenter_root(get_switch_lock_owner(),
 			   cprio ? SCHED_FIFO : SCHED_NORMAL, cprio);
 
-	xnthread_inc_ssw(thread);	/* Account for secondary mode switch. */
+	xnstat_counter_inc(&thread->stat.ssw);	/* Account for secondary mode switch. */
 
 	if (notify && testbits(thread->status, XNTRAPSW))
 		/* Help debugging spurious relaxes. */
Index: xenomai/ksrc/nucleus/thread.c
===================================================================
--- xenomai.orig/ksrc/nucleus/thread.c
+++ xenomai/ksrc/nucleus/thread.c
@@ -86,14 +86,7 @@ int xnthread_init(xnthread_t *thread,
 	thread->registry.handle = XN_NO_HANDLE;
 	thread->registry.waitkey = NULL;
 #endif /* CONFIG_XENO_OPT_REGISTRY */
-
-#ifdef CONFIG_XENO_OPT_STATS
-	thread->stat.ssw = 0;
-	thread->stat.csw = 0;
-	thread->stat.pf = 0;
-	thread->stat.exec_time = 0;
-	thread->stat.exec_start = 0;
-#endif /* CONFIG_XENO_OPT_STATS */
+	memset(&thread->stat, 0, sizeof(thread->stat));
 
 	/* These will be filled by xnpod_start_thread() */
 	thread->imask = 0;

--------------040109070602060905090609--

