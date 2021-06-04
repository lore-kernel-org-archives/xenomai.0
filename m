From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 05/12] cobalt/trace: dovetail: enable basic tracepoints
Date: Fri,  4 Jun 2021 12:05:15 +0200
Message-Id: <cd28df778372fc3143e0703809c82e33dd5e772c.1622801122.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1622801122.git.jan.kiszka@siemens.com>
References: <cover.1622801122.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Philippe Gerum <rpm@xenomai.org>

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
[Jan: add missing struct xnsched_quota_group declaration, style fixes]
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../cobalt/kernel/dovetail/pipeline/trace.h   | 52 ++++--------
 kernel/cobalt/trace/cobalt-core.h             | 84 +++++++++++++++++++
 2 files changed, 102 insertions(+), 34 deletions(-)

diff --git a/include/cobalt/kernel/dovetail/pipeline/trace.h b/include/cobalt/kernel/dovetail/pipeline/trace.h
index 819b8a713..e39fdfa7c 100644
--- a/include/cobalt/kernel/dovetail/pipeline/trace.h
+++ b/include/cobalt/kernel/dovetail/pipeline/trace.h
@@ -22,96 +22,80 @@
 #include <linux/types.h>
 #include <linux/kconfig.h>
 #include <cobalt/uapi/kernel/trace.h>
+#include <trace/events/cobalt-core.h>
+#include <cobalt/kernel/assert.h>
 
 static inline int xntrace_max_begin(unsigned long v)
 {
-//#chz: NTD
-	//ipipe_trace_begin(v);
+	TODO();
 	return 0;
 }
 
 static inline int xntrace_max_end(unsigned long v)
 {
-//#chz: NTD
-	//ipipe_trace_end(v);
+	TODO();
 	return 0;
 }
 
 static inline int xntrace_max_reset(void)
 {
-//#chz: NTD
-	//ipipe_trace_max_reset();
+	TODO();
 	return 0;
 }
 
 static inline int xntrace_user_start(void)
 {
-//#chz: NTD
-	//return ipipe_trace_frozen_reset();
+	TODO();
 	return 0;
 }
 
 static inline int xntrace_user_stop(unsigned long v)
 {
-//#chz: NTD
-	//ipipe_trace_freeze(v);
+	TODO();
 	return 0;
 }
 
 static inline int xntrace_user_freeze(unsigned long v, int once)
 {
-	int ret = 0;
-//#chz: NTD
-/*
-	if (!once)
-		ret = ipipe_trace_frozen_reset();
-
-	ipipe_trace_freeze(v);
-*/
-	return ret;
+	trace_cobalt_trace_longval(0, v);
+	trace_cobalt_trigger("freeze");
+	return 0;
 }
 
 static inline int xntrace_special(unsigned char id, unsigned long v)
 {
-//#chz: NTD
-//	ipipe_trace_special(id, v);
+	trace_cobalt_trace_longval(id, v);
 	return 0;
 }
 
 static inline int xntrace_special_u64(unsigned char id,
-					unsigned long long v)
+				unsigned long long v)
 {
-//#chz: NTD
-//	ipipe_trace_special(id, (unsigned long)(v >> 32));
-//	ipipe_trace_special(id, (unsigned long)(v & 0xFFFFFFFF));
+	trace_cobalt_trace_longval(id, v);
 	return 0;
 }
 
 static inline int xntrace_pid(pid_t pid, short prio)
 {
-//#chz: NTD
-//	ipipe_trace_pid(pid, prio);
+	trace_cobalt_trace_pid(pid, prio);
 	return 0;
 }
 
-static inline int xntrace_tick(unsigned long delay_ticks)
+static inline int xntrace_tick(unsigned long delay_ticks) /* ns */
 {
-//#chz: NTD
-//	ipipe_trace_event(0, delay_ticks);
+	trace_cobalt_tick_shot(delay_ticks);
 	return 0;
 }
 
 static inline int xntrace_panic_freeze(void)
 {
-//#chz: NTD
-//	ipipe_trace_panic_freeze();
+	TODO();
 	return 0;
 }
 
 static inline int xntrace_panic_dump(void)
 {
-//#chz: NTD
-//	ipipe_trace_panic_dump();
+	TODO();
 	return 0;
 }
 
diff --git a/kernel/cobalt/trace/cobalt-core.h b/kernel/cobalt/trace/cobalt-core.h
index 96eec3664..76240d245 100644
--- a/kernel/cobalt/trace/cobalt-core.h
+++ b/kernel/cobalt/trace/cobalt-core.h
@@ -24,6 +24,16 @@
 #define _TRACE_COBALT_CORE_H
 
 #include <linux/tracepoint.h>
+#include <linux/math64.h>
+#include <cobalt/kernel/timer.h>
+#include <cobalt/uapi/kernel/types.h>
+
+struct xnsched;
+struct xnthread;
+struct xnsynch;
+struct xnsched_class;
+struct xnsched_quota_group;
+struct xnthread_init_attr;
 
 DECLARE_EVENT_CLASS(thread_event,
 	TP_PROTO(struct xnthread *thread),
@@ -768,6 +778,80 @@ DEFINE_EVENT(synch_post_event, cobalt_synch_forget,
 	TP_ARGS(synch)
 );
 
+TRACE_EVENT(cobalt_tick_shot,
+	TP_PROTO(s64 delta),
+	TP_ARGS(delta),
+
+	TP_STRUCT__entry(
+		__field(u64, secs)
+		__field(u32, nsecs)
+		__field(s64, delta)
+	),
+
+	TP_fast_assign(
+		__entry->delta = delta;
+		__entry->secs = div_u64_rem(trace_clock_local() + delta,
+					    NSEC_PER_SEC, &__entry->nsecs);
+	),
+
+	TP_printk("next tick at %Lu.%06u (delay: %Ld us)",
+		  (unsigned long long)__entry->secs,
+		  __entry->nsecs / 1000, div_s64(__entry->delta, 1000))
+);
+
+TRACE_EVENT(cobalt_trace,
+	TP_PROTO(const char *msg),
+	TP_ARGS(msg),
+	TP_STRUCT__entry(
+		__string(msg, msg)
+	),
+	TP_fast_assign(
+		__assign_str(msg, msg);
+	),
+	TP_printk("%s", __get_str(msg))
+);
+
+TRACE_EVENT(cobalt_trace_longval,
+	TP_PROTO(int id, u64 val),
+	TP_ARGS(id, val),
+	TP_STRUCT__entry(
+		__field(int, id)
+		__field(u64, val)
+	),
+	TP_fast_assign(
+		__entry->id = id;
+		__entry->val = val;
+	),
+	TP_printk("id=%#x, v=%llu", __entry->id, __entry->val)
+);
+
+TRACE_EVENT(cobalt_trace_pid,
+	TP_PROTO(pid_t pid, int prio),
+	TP_ARGS(pid, prio),
+	TP_STRUCT__entry(
+		__field(pid_t, pid)
+		__field(int, prio)
+	),
+	TP_fast_assign(
+		__entry->pid = pid;
+		__entry->prio = prio;
+	),
+	TP_printk("pid=%d, prio=%d", __entry->pid, __entry->prio)
+);
+
+/* Basically cobalt_trace() + trigger point */
+TRACE_EVENT(cobalt_trigger,
+	TP_PROTO(const char *issuer),
+	TP_ARGS(issuer),
+	TP_STRUCT__entry(
+		__string(issuer, issuer)
+	),
+	TP_fast_assign(
+		__assign_str(issuer, issuer);
+	),
+	TP_printk("%s", __get_str(issuer))
+);
+
 #endif /* _TRACE_COBALT_CORE_H */
 
 /* This part must be outside protection */
-- 
2.26.2


