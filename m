From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] cobalt: Add sched-quota tracepoints
Message-ID: <8f073b61-94c1-1500-a315-12068a36730b@siemens.com>
Date: Tue, 26 Feb 2019 10:18:49 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

This instruments the sched-quota scheduling policy to track which groups
exit, with which settings, and which threads belong to them.

As trace_cobalt_schedquota_add_thread may be invoked before a thread is
fully initialized, we need to trace also the thread address.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/sched-quota.c       | 15 ++++++
 kernel/cobalt/trace/cobalt-core.h | 96 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 111 insertions(+)

diff --git a/kernel/cobalt/sched-quota.c b/kernel/cobalt/sched-quota.c
index b2f24cbb9a..79b9e5c907 100644
--- a/kernel/cobalt/sched-quota.c
+++ b/kernel/cobalt/sched-quota.c
@@ -20,6 +20,7 @@
 #include <cobalt/kernel/sched.h>
 #include <cobalt/kernel/arith.h>
 #include <cobalt/uapi/sched.h>
+#include <trace/events/cobalt-core.h>
 
 /*
  * With this policy, each per-CPU scheduler slot maintains a list of
@@ -155,6 +156,8 @@ static void quota_refill_handler(struct xntimer *timer)
 	XENO_BUG_ON(COBALT, list_empty(&qs->groups));
 	sched = container_of(qs, struct xnsched, quota);
 
+	trace_cobalt_schedquota_refill(0);
+
 	list_for_each_entry(tg, &qs->groups, next) {
 		/* Allot a new runtime budget for the group. */
 		replenish_budget(qs, tg);
@@ -254,6 +257,9 @@ static bool xnsched_quota_setparam(struct xnthread *thread,
 			list_del(&thread->quota_next);
 			thread->quota->nr_threads--;
 		}
+
+		trace_cobalt_schedquota_add_thread(tg, thread);
+
 		thread->quota = tg;
 		list_add(&thread->quota_next, &tg->members);
 		tg->nr_threads++;
@@ -330,6 +336,8 @@ static int xnsched_quota_chkparam(struct xnthread *thread,
 
 static void xnsched_quota_forget(struct xnthread *thread)
 {
+	trace_cobalt_schedquota_remove_thread(thread->quota, thread);
+
 	thread->quota->nr_threads--;
 	XENO_BUG_ON(COBALT, thread->quota->nr_threads < 0);
 	list_del(&thread->quota_next);
@@ -525,6 +533,8 @@ int xnsched_quota_create_group(struct xnsched_quota_group *tg,
 	INIT_LIST_HEAD(&tg->members);
 	INIT_LIST_HEAD(&tg->expired);
 
+	trace_cobalt_schedquota_create_group(tg);
+
 	if (list_empty(&qs->groups))
 		xntimer_start(&qs->refill_timer,
 			      qs->period_ns, qs->period_ns, XN_RELATIVE);
@@ -555,6 +565,8 @@ int xnsched_quota_destroy_group(struct xnsched_quota_group *tg,
 		}
 	}
 
+	trace_cobalt_schedquota_destroy_group(tg);
+
 	list_del(&tg->next);
 	__clear_bit(tg->tgid, group_map);
 
@@ -577,6 +589,9 @@ void xnsched_quota_set_limit(struct xnsched_quota_group *tg,
 
 	atomic_only();
 
+	trace_cobalt_schedquota_set_limit(tg, quota_percent,
+					  quota_peak_percent);
+
 	if (quota_percent < 0 || quota_percent > 100) { /* Quota off. */
 		quota_percent = 100;
 		tg->quota_ns = qs->period_ns;
diff --git a/kernel/cobalt/trace/cobalt-core.h b/kernel/cobalt/trace/cobalt-core.h
index 3448da9109..6b328c6272 100644
--- a/kernel/cobalt/trace/cobalt-core.h
+++ b/kernel/cobalt/trace/cobalt-core.h
@@ -203,6 +203,102 @@ TRACE_EVENT(cobalt_switch_context,
 		  __get_str(next_name), __entry->next_pid, __entry->next_prio)
 );
 
+TRACE_EVENT(cobalt_schedquota_refill,
+	TP_PROTO(int dummy),
+	TP_ARGS(dummy),
+
+	TP_STRUCT__entry(
+		__array(char, dummy, 0)
+	),
+
+	TP_fast_assign(
+		(void)dummy;
+	),
+
+	TP_printk("%s", "")
+);
+
+DECLARE_EVENT_CLASS(schedquota_group_event,
+	TP_PROTO(struct xnsched_quota_group *tg),
+	TP_ARGS(tg),
+
+	TP_STRUCT__entry(
+		__field(int, tgid)
+	),
+
+	TP_fast_assign(
+		__entry->tgid = tg->tgid;
+	),
+
+	TP_printk("tgid=%d",
+		  __entry->tgid)
+);
+
+DEFINE_EVENT(schedquota_group_event, cobalt_schedquota_create_group,
+	TP_PROTO(struct xnsched_quota_group *tg),
+	TP_ARGS(tg)
+);
+
+DEFINE_EVENT(schedquota_group_event, cobalt_schedquota_destroy_group,
+	TP_PROTO(struct xnsched_quota_group *tg),
+	TP_ARGS(tg)
+);
+
+TRACE_EVENT(cobalt_schedquota_set_limit,
+	TP_PROTO(struct xnsched_quota_group *tg,
+		 int percent,
+		 int peak_percent),
+	TP_ARGS(tg, percent, peak_percent),
+
+	TP_STRUCT__entry(
+		__field(int, tgid)
+		__field(int, percent)
+		__field(int, peak_percent)
+	),
+
+	TP_fast_assign(
+		__entry->tgid = tg->tgid;
+		__entry->percent = percent;
+		__entry->peak_percent = peak_percent;
+	),
+
+	TP_printk("tgid=%d percent=%d peak_percent=%d",
+		  __entry->tgid, __entry->percent, __entry->peak_percent)
+);
+
+DECLARE_EVENT_CLASS(schedquota_thread_event,
+	TP_PROTO(struct xnsched_quota_group *tg,
+		 struct xnthread *thread),
+	TP_ARGS(tg, thread),
+
+	TP_STRUCT__entry(
+		__field(int, tgid)
+		__field(struct xnthread *, thread)
+		__field(pid_t, pid)
+	),
+
+	TP_fast_assign(
+		__entry->tgid = tg->tgid;
+		__entry->thread = thread;
+		__entry->pid = xnthread_host_pid(thread);
+	),
+
+	TP_printk("tgid=%d thread=%p pid=%d",
+		  __entry->tgid, __entry->thread, __entry->pid)
+);
+
+DEFINE_EVENT(schedquota_thread_event, cobalt_schedquota_add_thread,
+	TP_PROTO(struct xnsched_quota_group *tg,
+		 struct xnthread *thread),
+	TP_ARGS(tg, thread)
+);
+
+DEFINE_EVENT(schedquota_thread_event, cobalt_schedquota_remove_thread,
+	TP_PROTO(struct xnsched_quota_group *tg,
+		 struct xnthread *thread),
+	TP_ARGS(tg, thread)
+);
+
 TRACE_EVENT(cobalt_thread_init,
 	TP_PROTO(struct xnthread *thread,
 		 const struct xnthread_init_attr *attr,
-- 
2.16.4

