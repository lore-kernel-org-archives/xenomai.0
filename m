From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Date: Tue, 29 Sep 2015 03:26:36 +0200
Message-Id: <1443489996-3001-1-git-send-email-gilles.chanteperdrix@xenomai.org>
In-Reply-To: <20150929012542.GC15767@hermes.click-hack.org>
References: <20150929012542.GC15767@hermes.click-hack.org>
Subject: [Xenomai] [PATCH] ipipe/tracer: allow hrclock late init
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

On some platforms (notably some AT91), the tsc may come late in the boot
process. Get the I-pipe tracer to also work in that case. Also get panic
traces working without a tsc; in that case, print all timestamps
differences as zero.
---
 arch/arm/kernel/ipipe_tsc.c |  2 ++
 include/linux/ipipe_trace.h |  2 ++
 kernel/ipipe/tracer.c       | 59 ++++++++++++++++++++++++++++++---------------
 3 files changed, 44 insertions(+), 19 deletions(-)

diff --git a/arch/arm/kernel/ipipe_tsc.c b/arch/arm/kernel/ipipe_tsc.c
index d42ceee..2e48631 100644
--- a/arch/arm/kernel/ipipe_tsc.c
+++ b/arch/arm/kernel/ipipe_tsc.c
@@ -165,6 +165,8 @@ void __init __ipipe_tsc_register(struct __ipipe_tscinfo *info)
 	ipipe_tsc_update_timer.function = __ipipe_tsc_update_fn;
 	mod_timer(&ipipe_tsc_update_timer,
 		jiffies + ipipe_tsc_update_timer.data);
+
+	__ipipe_tracer_hrclock_initialized();
 }
 
 void __ipipe_mach_get_tscinfo(struct __ipipe_tscinfo *info)
diff --git a/include/linux/ipipe_trace.h b/include/linux/ipipe_trace.h
index deb0a47..edea346 100644
--- a/include/linux/ipipe_trace.h
+++ b/include/linux/ipipe_trace.h
@@ -32,6 +32,7 @@
 #define __BUILTIN_RETURN_ADDRESS1 ((unsigned long)__builtin_return_address(1))
 #endif /* !BUILTIN_RETURN_ADDRESS */
 
+void __ipipe_tracer_hrclock_initialized(void);
 void ipipe_trace_begin(unsigned long v);
 void ipipe_trace_end(unsigned long v);
 void ipipe_trace_freeze(unsigned long v);
@@ -43,6 +44,7 @@ int ipipe_trace_frozen_reset(void);
 
 #else /* !CONFIG_IPIPE_TRACE */
 
+#define __ipipe_tracer_hrclock_initialized()	do { } while(0)
 #define ipipe_trace_begin(v)			do { (void)(v); } while(0)
 #define ipipe_trace_end(v)			do { (void)(v); } while(0)
 #define ipipe_trace_freeze(v)			do { (void)(v); } while(0)
diff --git a/kernel/ipipe/tracer.c b/kernel/ipipe/tracer.c
index 5cce0bc..8388671 100644
--- a/kernel/ipipe/tracer.c
+++ b/kernel/ipipe/tracer.c
@@ -745,6 +745,9 @@ static long __ipipe_signed_tsc2us(long long tsc)
 	unsigned long long abs_tsc;
 	long us;
 
+	if (!__ipipe_hrclock_ok())
+		return 0;
+
 	/* ipipe_tsc2us works on unsigned => handle sign separately */
 	abs_tsc = (tsc >= 0) ? tsc : -tsc;
 	us = ipipe_tsc2us(abs_tsc);
@@ -947,6 +950,11 @@ static void *__ipipe_max_prtrace_start(struct seq_file *m, loff_t *pos)
 
 		__ipipe_global_path_unlock(flags);
 
+		if (!__ipipe_hrclock_ok()) {
+			seq_printf(m, "No hrclock available, dumping traces disabled\n");
+			return NULL;
+		}
+
 		/* does this path actually contain data? */
 		if (print_path->end == print_path->begin)
 			return NULL;
@@ -1117,6 +1125,11 @@ static void *__ipipe_frozen_prtrace_start(struct seq_file *m, loff_t *pos)
 		if (!print_path)
 			return NULL;
 
+		if (!__ipipe_hrclock_ok()) {
+			seq_printf(m, "No hrclock available, dumping traces disabled\n");
+			return NULL;
+		}
+
 		/* back- and post-tracing length, post-trace length was frozen
 		   in __ipipe_trace, back-trace may have to be reduced due to
 		   buffer overrun */
@@ -1366,18 +1379,38 @@ static const struct file_operations __ipipe_rw_enable_ops = {
 
 extern struct proc_dir_entry *ipipe_proc_root;
 
-void __init __ipipe_init_tracer(void)
+void __init __ipipe_tracer_hrclock_initialized(void)
 {
-	struct proc_dir_entry *trace_dir;
 	unsigned long long start, end, min = ULLONG_MAX;
 	int i;
+
+#ifdef CONFIG_IPIPE_TRACE_VMALLOC
+	if (!per_cpu(trace_path, 0))
+		return;
+#endif
+	/* Calculate minimum overhead of __ipipe_trace() */
+	hard_local_irq_disable();
+	for (i = 0; i < 100; i++) {
+		ipipe_read_tsc(start);
+		__ipipe_trace(IPIPE_TRACE_FUNC, __BUILTIN_RETURN_ADDRESS0,
+			      __BUILTIN_RETURN_ADDRESS1, 0);
+		ipipe_read_tsc(end);
+
+		end -= start;
+		if (end < min)
+			min = end;
+	}
+	hard_local_irq_enable();
+	trace_overhead = ipipe_tsc2ns(min);
+}
+
+void __init __ipipe_init_tracer(void)
+{
+	struct proc_dir_entry *trace_dir;
 #ifdef CONFIG_IPIPE_TRACE_VMALLOC
 	int cpu, path;
 #endif /* CONFIG_IPIPE_TRACE_VMALLOC */
 
-	if (!__ipipe_hrclock_ok())
-		return;
-
 #ifdef CONFIG_IPIPE_TRACE_VMALLOC
 	for_each_possible_cpu(cpu) {
 		struct ipipe_trace_path *tp_buf;
@@ -1399,20 +1432,8 @@ void __init __ipipe_init_tracer(void)
 	}
 #endif /* CONFIG_IPIPE_TRACE_VMALLOC */
 
-	/* Calculate minimum overhead of __ipipe_trace() */
-	hard_local_irq_disable();
-	for (i = 0; i < 100; i++) {
-		ipipe_read_tsc(start);
-		__ipipe_trace(IPIPE_TRACE_FUNC, __BUILTIN_RETURN_ADDRESS0,
-			      __BUILTIN_RETURN_ADDRESS1, 0);
-		ipipe_read_tsc(end);
-
-		end -= start;
-		if (end < min)
-			min = end;
-	}
-	hard_local_irq_enable();
-	trace_overhead = ipipe_tsc2ns(min);
+	if (__ipipe_hrclock_ok() && !trace_overhead)
+		__ipipe_tracer_hrclock_initialized();
 
 #ifdef CONFIG_IPIPE_TRACE_ENABLE
 	ipipe_trace_enable = 1;
-- 
1.8.4


