From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 06/12] cobalt/trace: add tracing call to notify of a latency
 peak
Date: Fri,  4 Jun 2021 12:05:16 +0200
Message-Id: <9dbd0ff9f31dad361b9ace5444fdffd8f6b4266c.1622801122.git.jan.kiszka@siemens.com>
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

When running on top of Dovetail, we may want to perform a specific
sequence of actions upon notification of a latency peak by some
application. Let's create a dedicated trace call in the API to handle
this particular case, instead of relying on the generic "user_freeze"
event.

NOTE: the new trace call does not return any value, because there is
nothing valuable to receive from a trace call. If required,
xntrace_enabled() should be tested beforehand to figure out whether
the kernel tracer is enabled.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/cobalt/kernel/dovetail/pipeline/trace.h |  8 +++++++-
 include/cobalt/kernel/ipipe/pipeline/trace.h    |  5 +++++
 include/cobalt/trace.h                          |  2 ++
 include/cobalt/uapi/kernel/trace.h              |  1 +
 include/mercury/boilerplate/trace.h             |  4 ++++
 kernel/cobalt/posix/syscall.c                   |  6 ++++++
 kernel/cobalt/trace/cobalt-core.h               | 14 ++++++++++++++
 kernel/drivers/testing/timerbench.c             |  2 +-
 lib/cobalt/trace.c                              |  5 +++++
 testsuite/latency/latency.c                     |  2 +-
 10 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/include/cobalt/kernel/dovetail/pipeline/trace.h b/include/cobalt/kernel/dovetail/pipeline/trace.h
index e39fdfa7c..513d9b48b 100644
--- a/include/cobalt/kernel/dovetail/pipeline/trace.h
+++ b/include/cobalt/kernel/dovetail/pipeline/trace.h
@@ -58,10 +58,16 @@ static inline int xntrace_user_stop(unsigned long v)
 static inline int xntrace_user_freeze(unsigned long v, int once)
 {
 	trace_cobalt_trace_longval(0, v);
-	trace_cobalt_trigger("freeze");
+	trace_cobalt_trigger("user-freeze");
 	return 0;
 }
 
+static inline void xntrace_latpeak_freeze(int delay)
+{
+	trace_cobalt_latpeak(delay);
+	trace_cobalt_trigger("latency-freeze");
+}
+
 static inline int xntrace_special(unsigned char id, unsigned long v)
 {
 	trace_cobalt_trace_longval(id, v);
diff --git a/include/cobalt/kernel/ipipe/pipeline/trace.h b/include/cobalt/kernel/ipipe/pipeline/trace.h
index d92e57a63..a28b83a48 100644
--- a/include/cobalt/kernel/ipipe/pipeline/trace.h
+++ b/include/cobalt/kernel/ipipe/pipeline/trace.h
@@ -65,6 +65,11 @@ static inline int xntrace_user_freeze(unsigned long v, int once)
 	return ret;
 }
 
+static inline void xntrace_latpeak_freeze(int delay)
+{
+	xntrace_user_freeze(delay, 0);
+}
+
 static inline int xntrace_special(unsigned char id, unsigned long v)
 {
 	ipipe_trace_special(id, v);
diff --git a/include/cobalt/trace.h b/include/cobalt/trace.h
index 172c0dc38..b2f9d954f 100644
--- a/include/cobalt/trace.h
+++ b/include/cobalt/trace.h
@@ -40,6 +40,8 @@ int xntrace_special(unsigned char id, unsigned long v);
 
 int xntrace_special_u64(unsigned char id, unsigned long long v);
 
+void xntrace_latpeak_freeze(int delay);
+
 int xnftrace_vprintf(const char *format, va_list args);
 int xnftrace_printf(const char *format, ...);
 
diff --git a/include/cobalt/uapi/kernel/trace.h b/include/cobalt/uapi/kernel/trace.h
index 95fd07e76..a1add3013 100644
--- a/include/cobalt/uapi/kernel/trace.h
+++ b/include/cobalt/uapi/kernel/trace.h
@@ -26,5 +26,6 @@
 #define __xntrace_op_user_freeze	5
 #define __xntrace_op_special		6
 #define __xntrace_op_special_u64	7
+#define __xntrace_op_latpeak_freeze	8
 
 #endif /* !_COBALT_UAPI_KERNEL_TRACE_H */
diff --git a/include/mercury/boilerplate/trace.h b/include/mercury/boilerplate/trace.h
index 223e36429..787b088e3 100644
--- a/include/mercury/boilerplate/trace.h
+++ b/include/mercury/boilerplate/trace.h
@@ -50,6 +50,10 @@ static inline int xntrace_user_freeze(unsigned long v, int once)
 	return -ENOSYS;
 }
 
+static inline void xntrace_latpeak_freeze(int delay)
+{
+}
+
 static inline int xntrace_special(unsigned char id, unsigned long v)
 {
 	return -ENOSYS;
diff --git a/kernel/cobalt/posix/syscall.c b/kernel/cobalt/posix/syscall.c
index c6fe737e6..30c33dda6 100644
--- a/kernel/cobalt/posix/syscall.c
+++ b/kernel/cobalt/posix/syscall.c
@@ -177,6 +177,12 @@ static COBALT_SYSCALL(trace, current,
 		ret = xntrace_special_u64(a1 & 0xFF,
 					  (((u64) a2) << 32) | a3);
 		break;
+
+	case __xntrace_op_latpeak_freeze:
+		xntrace_latpeak_freeze(a1);
+		ret = 0;
+		break;
+
 	}
 	return ret;
 }
diff --git a/kernel/cobalt/trace/cobalt-core.h b/kernel/cobalt/trace/cobalt-core.h
index 76240d245..88ed5700d 100644
--- a/kernel/cobalt/trace/cobalt-core.h
+++ b/kernel/cobalt/trace/cobalt-core.h
@@ -839,6 +839,20 @@ TRACE_EVENT(cobalt_trace_pid,
 	TP_printk("pid=%d, prio=%d", __entry->pid, __entry->prio)
 );
 
+TRACE_EVENT(cobalt_latpeak,
+	TP_PROTO(int latmax_ns),
+	TP_ARGS(latmax_ns),
+	TP_STRUCT__entry(
+		 __field(int, latmax_ns)
+	),
+	TP_fast_assign(
+		__entry->latmax_ns = latmax_ns;
+	),
+	TP_printk("** latency peak: %d.%.3d us **",
+		  __entry->latmax_ns / 1000,
+		  __entry->latmax_ns % 1000)
+);
+
 /* Basically cobalt_trace() + trigger point */
 TRACE_EVENT(cobalt_trigger,
 	TP_PROTO(const char *issuer),
diff --git a/kernel/drivers/testing/timerbench.c b/kernel/drivers/testing/timerbench.c
index 31f0bea76..68e50a241 100644
--- a/kernel/drivers/testing/timerbench.c
+++ b/kernel/drivers/testing/timerbench.c
@@ -82,8 +82,8 @@ static void eval_inner_loop(struct rt_tmbench_context *ctx, __s32 dt)
 		ctx->freeze_max &&
 		(dt > ctx->result.overall.max) &&
 		!ctx->warmup) {
-		xntrace_user_freeze(dt, false);
 		ctx->result.overall.max = dt;
+		xntrace_latpeak_freeze(dt);
 	}
 
 	ctx->date += ctx->period;
diff --git a/lib/cobalt/trace.c b/lib/cobalt/trace.c
index 42e139f13..8d9c18902 100644
--- a/lib/cobalt/trace.c
+++ b/lib/cobalt/trace.c
@@ -53,6 +53,11 @@ int xntrace_user_freeze(unsigned long v, int once)
 				v, once);
 }
 
+void xntrace_latpeak_freeze(int delay)
+{
+	XENOMAI_SYSCALL2(sc_cobalt_trace, __xntrace_op_latpeak_freeze, delay);
+}
+
 int xntrace_special(unsigned char id, unsigned long v)
 {
 	return XENOMAI_SYSCALL3(sc_cobalt_trace, __xntrace_op_special, id, v);
diff --git a/testsuite/latency/latency.c b/testsuite/latency/latency.c
index 5304342ff..a0e6f4826 100644
--- a/testsuite/latency/latency.c
+++ b/testsuite/latency/latency.c
@@ -192,7 +192,7 @@ static void *latency(void *cookie)
 
 			if (freeze_max && (dt > gmaxjitter)
 			    && !(finished || warmup)) {
-				xntrace_user_freeze(dt, 0);
+				xntrace_latpeak_freeze(dt);
 				gmaxjitter = dt;
 			}
 
-- 
2.26.2


