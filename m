Message-ID: <47BEA5C3.9050100@domain.hid>
Date: Fri, 22 Feb 2008 11:36:51 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010603070206030507040309"
Subject: [Adeos-main] [PATCH] tracer: use per-cpu trace buffers
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>

This is a multi-part message in MIME format.
--------------010603070206030507040309
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

This patch addresses two issues:

 - fixes boot hang with CONFIG_IPIPE_TRACE, !CONFIG_IPIPE_TRACE_VMALLOC,
   and large CONFIG_NR_CPUS (due to the huge trace buffers this implies,
   even if the system has only a few CPUs in fact)

 - improves NUMA performance by allocating the buffers node-local
   (hackbench indicates a speed-up of 2 on a 8-way box when the tracer
   is armed)

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

--------------010603070206030507040309
Content-Type: text/x-patch;
 name="per-cpu-trace-buffer.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="per-cpu-trace-buffer.patch"

---
 kernel/ipipe/tracer.c |  150 +++++++++++++++++++++++---------------------------
 1 file changed, 71 insertions(+), 79 deletions(-)

Index: b/kernel/ipipe/tracer.c
===================================================================
--- a/kernel/ipipe/tracer.c
+++ b/kernel/ipipe/tracer.c
@@ -2,7 +2,7 @@
  * kernel/ipipe/tracer.c
  *
  * Copyright (C) 2005 Luotao Fu.
- *               2005-2007 Jan Kiszka.
+ *               2005-2008 Jan Kiszka.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -64,8 +64,7 @@
 #define IPIPE_TFLG_CURRENT_DOMAIN(point) \
 	((point->flags & IPIPE_TFLG_CURRDOM_MASK) >> IPIPE_TFLG_CURRDOM_SHIFT)
 
-
-struct ipipe_trace_point{
+struct ipipe_trace_point {
 	short type;
 	short flags;
 	unsigned long eip;
@@ -74,7 +73,7 @@ struct ipipe_trace_point{
 	unsigned long long timestamp;
 };
 
-struct ipipe_trace_path{
+struct ipipe_trace_path {
 	volatile int flags;
 	int dump_lock; /* separated from flags due to cross-cpu access */
 	int trace_pos; /* next point to fill */
@@ -100,29 +99,18 @@ enum ipipe_trace_type
 #define IPIPE_TYPE_MASK             0x0007
 #define IPIPE_TYPE_BITS             3
 
-
 #ifdef CONFIG_IPIPE_TRACE_VMALLOC
-
-static struct ipipe_trace_path *trace_paths[NR_CPUS];
-
+static DEFINE_PER_CPU(struct ipipe_trace_path *, trace_path);
 #else /* !CONFIG_IPIPE_TRACE_VMALLOC */
-
-static struct ipipe_trace_path trace_paths[NR_CPUS][IPIPE_TRACE_PATHS] =
-	{ [0 ... NR_CPUS-1] =
-		{ [0 ... IPIPE_TRACE_PATHS-1] =
-			{ .begin = -1, .end = -1 }
-		}
-	};
+static DEFINE_PER_CPU(struct ipipe_trace_path, trace_path[IPIPE_TRACE_PATHS]) =
+	{ [0 ... IPIPE_TRACE_PATHS-1] = { .begin = -1, .end = -1 } };
 #endif /* CONFIG_IPIPE_TRACE_VMALLOC */
 
 int ipipe_trace_enable = 0;
 
-static int active_path[NR_CPUS] =
-	{ [0 ... NR_CPUS-1] = IPIPE_DEFAULT_ACTIVE };
-static int max_path[NR_CPUS] =
-	{ [0 ... NR_CPUS-1] = IPIPE_DEFAULT_MAX };
-static int frozen_path[NR_CPUS] =
-	{ [0 ... NR_CPUS-1] = IPIPE_DEFAULT_FROZEN };
+static DEFINE_PER_CPU(int, active_path) = { IPIPE_DEFAULT_ACTIVE };
+static DEFINE_PER_CPU(int, max_path) = { IPIPE_DEFAULT_MAX };
+static DEFINE_PER_CPU(int, frozen_path) = { IPIPE_DEFAULT_FROZEN };
 static IPIPE_DEFINE_SPINLOCK(global_path_lock);
 static int pre_trace = IPIPE_DEFAULT_PRE_TRACE;
 static int post_trace = IPIPE_DEFAULT_POST_TRACE;
@@ -169,7 +157,7 @@ __ipipe_store_domain_states(struct ipipe
 	}
 }
 
-static notrace int __ipipe_get_free_trace_path(int old, int cpu_id)
+static notrace int __ipipe_get_free_trace_path(int old, int cpu)
 {
 	int new_active = old;
 	struct ipipe_trace_path *tp;
@@ -177,9 +165,9 @@ static notrace int __ipipe_get_free_trac
 	do {
 		if (++new_active == IPIPE_TRACE_PATHS)
 			new_active = 0;
-		tp = &trace_paths[cpu_id][new_active];
-	} while ((new_active == max_path[cpu_id]) ||
-	         (new_active == frozen_path[cpu_id]) ||
+		tp = &per_cpu(trace_path, cpu)[new_active];
+	} while (new_active == per_cpu(max_path, cpu) ||
+	         new_active == per_cpu(frozen_path, cpu) ||
 	         tp->dump_lock);
 
 	return new_active;
@@ -203,30 +191,30 @@ __ipipe_migrate_pre_trace(struct ipipe_t
 }
 
 static notrace struct ipipe_trace_path *
-__ipipe_trace_end(int cpu_id, struct ipipe_trace_path *tp, int pos)
+__ipipe_trace_end(int cpu, struct ipipe_trace_path *tp, int pos)
 {
 	struct ipipe_trace_path *old_tp = tp;
-	long active = active_path[cpu_id];
+	long active = per_cpu(active_path, cpu);
 	unsigned long long length;
 
 	/* do we have a new worst case? */
 	length = tp->point[tp->end].timestamp -
 	         tp->point[tp->begin].timestamp;
-	if (length > (trace_paths[cpu_id][max_path[cpu_id]]).length) {
+	if (length > per_cpu(trace_path, cpu)[per_cpu(max_path, cpu)].length) {
 		/* we need protection here against other cpus trying
 		   to start a proc dump */
 		spin_lock(&global_path_lock);
 
 		/* active path holds new worst case */
 		tp->length = length;
-		max_path[cpu_id] = active;
+		per_cpu(max_path, cpu) = active;
 
 		/* find next unused trace path */
-		active = __ipipe_get_free_trace_path(active, cpu_id);
+		active = __ipipe_get_free_trace_path(active, cpu);
 
 		spin_unlock(&global_path_lock);
 
-		tp = &trace_paths[cpu_id][active];
+		tp = &per_cpu(trace_path, cpu)[active];
 
 		/* migrate last entries for pre-tracing */
 		__ipipe_migrate_pre_trace(tp, old_tp, pos);
@@ -236,11 +224,11 @@ __ipipe_trace_end(int cpu_id, struct ipi
 }
 
 static notrace struct ipipe_trace_path *
-__ipipe_trace_freeze(int cpu_id, struct ipipe_trace_path *tp, int pos)
+__ipipe_trace_freeze(int cpu, struct ipipe_trace_path *tp, int pos)
 {
 	struct ipipe_trace_path *old_tp = tp;
-	long active = active_path[cpu_id];
-	int i;
+	long active = per_cpu(active_path, cpu);
+	int n;
 
 	/* frozen paths have no core (begin=end) */
 	tp->begin = tp->end;
@@ -249,21 +237,21 @@ __ipipe_trace_freeze(int cpu_id, struct 
 	 * to set their frozen path or to start a proc dump */
 	spin_lock(&global_path_lock);
 
-	frozen_path[cpu_id] = active;
+	per_cpu(frozen_path, cpu) = active;
 
 	/* find next unused trace path */
-	active = __ipipe_get_free_trace_path(active, cpu_id);
+	active = __ipipe_get_free_trace_path(active, cpu);
 
 	/* check if this is the first frozen path */
-	for (i = 0; i < NR_CPUS && trace_paths[i] != NULL; i++) {
-		if ((i != cpu_id) &&
-		    (trace_paths[i][frozen_path[i]].end >= 0))
+	for_each_possible_cpu(n) {
+		if (n != cpu &&
+		    per_cpu(trace_path, n)[per_cpu(frozen_path, n)].end >= 0)
 			tp->end = -1;
 	}
 
 	spin_unlock(&global_path_lock);
 
-	tp = &trace_paths[cpu_id][active];
+	tp = &per_cpu(trace_path, cpu)[active];
 
 	/* migrate last entries for pre-tracing */
 	__ipipe_migrate_pre_trace(tp, old_tp, pos);
@@ -279,13 +267,13 @@ __ipipe_trace(enum ipipe_trace_type type
 	int pos, next_pos, begin;
 	struct ipipe_trace_point *point;
 	unsigned long flags;
-	int cpu_id;
+	int cpu;
 
 	local_irq_save_hw_notrace(flags);
 
-	cpu_id = ipipe_processor_id();
+	cpu = ipipe_processor_id();
  restart:
-	tp = old_tp = &trace_paths[cpu_id][active_path[cpu_id]];
+	tp = old_tp = &per_cpu(trace_path, cpu)[per_cpu(active_path, cpu)];
 
 	/* here starts a race window with NMIs - catched below */
 
@@ -312,7 +300,8 @@ __ipipe_trace(enum ipipe_trace_type type
 
 	/* check active_path again - some nasty NMI may have switched
 	 * it meanwhile */
-	if (unlikely(tp != &trace_paths[cpu_id][active_path[cpu_id]])) {
+	if (unlikely(tp !=
+		     &per_cpu(trace_path, cpu)[per_cpu(active_path, cpu)])) {
 		/* release lock on wrong path and restart */
 		tp->flags &= ~IPIPE_TFLG_NMI_LOCK;
 
@@ -353,7 +342,7 @@ __ipipe_trace(enum ipipe_trace_type type
 	if ((unlikely(type == IPIPE_TRACE_FREEZE) ||
 	     (unlikely(eip >= trigger_begin && eip <= trigger_end) &&
 	     type == IPIPE_TRACE_FUNC)) &&
-	    (trace_paths[cpu_id][frozen_path[cpu_id]].begin < 0) &&
+	    per_cpu(trace_path, cpu)[per_cpu(frozen_path, cpu)].begin < 0 &&
 	    !(tp->flags & IPIPE_TFLG_FREEZING)) {
 		tp->post_trace = post_trace + 1;
 		tp->flags |= IPIPE_TFLG_FREEZING;
@@ -376,9 +365,9 @@ __ipipe_trace(enum ipipe_trace_type type
 
  enforce_end:
 		if (tp->flags & IPIPE_TFLG_FREEZING)
-			tp = __ipipe_trace_freeze(cpu_id, tp, pos);
+			tp = __ipipe_trace_freeze(cpu, tp, pos);
 		else
-			tp = __ipipe_trace_end(cpu_id, tp, pos);
+			tp = __ipipe_trace_end(cpu, tp, pos);
 
 		/* reset the active path, maybe already start a new one */
 		tp->begin = (type == IPIPE_TRACE_BEGIN) ?
@@ -388,7 +377,7 @@ __ipipe_trace(enum ipipe_trace_type type
 		tp->flags = 0;
 
 		/* update active_path not earlier to avoid races with NMIs */
-		active_path[cpu_id] = tp - trace_paths[cpu_id];
+		per_cpu(active_path, cpu) = tp - per_cpu(trace_path, cpu);
 	}
 
 	/* we still have old_tp and point,
@@ -412,14 +401,14 @@ __ipipe_trace(enum ipipe_trace_type type
 static unsigned long __ipipe_global_path_lock(void)
 {
 	unsigned long flags;
-	int cpu_id;
+	int cpu;
 	struct ipipe_trace_path *tp;
 
 	spin_lock_irqsave(&global_path_lock, flags);
 
-	cpu_id = ipipe_processor_id();
+	cpu = ipipe_processor_id();
  restart:
-	tp = &trace_paths[cpu_id][active_path[cpu_id]];
+	tp = &per_cpu(trace_path, cpu)[per_cpu(active_path, cpu)];
 
 	/* here is small race window with NMIs - catched below */
 
@@ -430,7 +419,7 @@ static unsigned long __ipipe_global_path
 
 	/* check active_path again - some nasty NMI may have switched
 	 * it meanwhile */
-	if (tp != &trace_paths[cpu_id][active_path[cpu_id]]) {
+	if (tp != &per_cpu(trace_path, cpu)[per_cpu(active_path, cpu)]) {
 		/* release lock on wrong path and restart */
 		tp->flags &= ~IPIPE_TFLG_NMI_LOCK;
 
@@ -444,14 +433,14 @@ static unsigned long __ipipe_global_path
 
 static void __ipipe_global_path_unlock(unsigned long flags)
 {
-	int cpu_id;
+	int cpu;
 	struct ipipe_trace_path *tp;
 
 	/* release spinlock first - it's not involved in the NMI issue */
 	__ipipe_spin_unlock_irqbegin(&global_path_lock);
 
-	cpu_id = ipipe_processor_id();
-	tp = &trace_paths[cpu_id][active_path[cpu_id]];
+	cpu = ipipe_processor_id();
+	tp = &per_cpu(trace_path, cpu)[per_cpu(active_path, cpu)];
 
 	tp->flags &= ~IPIPE_TFLG_NMI_LOCK;
 
@@ -513,15 +502,15 @@ EXPORT_SYMBOL(ipipe_trace_pid);
 
 int ipipe_trace_max_reset(void)
 {
-	int cpu_id;
+	int cpu;
 	unsigned long flags;
 	struct ipipe_trace_path *path;
 	int ret = 0;
 
 	flags = __ipipe_global_path_lock();
 
-	for (cpu_id = 0; cpu_id < NR_CPUS && trace_paths[cpu_id] != NULL; cpu_id++) {
-		path = &trace_paths[cpu_id][max_path[cpu_id]];
+	for_each_possible_cpu(cpu) {
+		path = &per_cpu(trace_path, cpu)[per_cpu(max_path, cpu)];
 
 		if (path->dump_lock) {
 			ret = -EBUSY;
@@ -542,15 +531,15 @@ EXPORT_SYMBOL(ipipe_trace_max_reset);
 
 int ipipe_trace_frozen_reset(void)
 {
-	int cpu_id;
+	int cpu;
 	unsigned long flags;
 	struct ipipe_trace_path *path;
 	int ret = 0;
 
 	flags = __ipipe_global_path_lock();
 
-	for_each_online_cpu(cpu_id) {
-		path = &trace_paths[cpu_id][frozen_path[cpu_id]];
+	for_each_online_cpu(cpu) {
+		path = &per_cpu(trace_path, cpu)[per_cpu(frozen_path, cpu)];
 
 		if (path->dump_lock) {
 			ret = -EBUSY;
@@ -606,7 +595,7 @@ __ipipe_get_task_info(char *task_info, s
 void ipipe_trace_panic_freeze(void)
 {
 	unsigned long flags;
-	int cpu_id;
+	int cpu;
 
 	if (!ipipe_trace_enable)
 		return;
@@ -614,9 +603,9 @@ void ipipe_trace_panic_freeze(void)
 	ipipe_trace_enable = 0;
 	local_irq_save_hw_notrace(flags);
 
-	cpu_id = ipipe_processor_id();
+	cpu = ipipe_processor_id();
 
-	panic_path = &trace_paths[cpu_id][active_path[cpu_id]];
+	panic_path = &per_cpu(trace_path, cpu)[per_cpu(active_path, cpu)];
 
 	local_irq_restore_hw(flags);
 }
@@ -889,7 +878,7 @@ static void *__ipipe_max_prtrace_start(s
 	mutex_lock(&out_mutex);
 
 	if (!n) {
-		struct ipipe_trace_path *path;
+		struct ipipe_trace_path *tp;
 		unsigned long length_usecs;
 		int points, cpu;
 		unsigned long flags;
@@ -902,10 +891,10 @@ static void *__ipipe_max_prtrace_start(s
 		/* find the longest of all per-cpu paths */
 		print_path = NULL;
 		for_each_online_cpu(cpu) {
-			path = &trace_paths[cpu][max_path[cpu]];
+			tp = &per_cpu(trace_path, cpu)[per_cpu(max_path, cpu)];
 			if ((print_path == NULL) ||
-			    (path->length > print_path->length)) {
-				print_path = path;
+			    (tp->length > print_path->length)) {
+				print_path = tp;
 				break;
 			}
 		}
@@ -1052,7 +1041,7 @@ static void *__ipipe_frozen_prtrace_star
 	mutex_lock(&out_mutex);
 
 	if (!n) {
-		struct ipipe_trace_path *path;
+		struct ipipe_trace_path *tp;
 		int cpu;
 		unsigned long flags;
 
@@ -1064,9 +1053,9 @@ static void *__ipipe_frozen_prtrace_star
 		/* find the first of all per-cpu frozen paths */
 		print_path = NULL;
 		for_each_online_cpu(cpu) {
-			path = &trace_paths[cpu][frozen_path[cpu]];
-			if (path->end >= 0) {
-				print_path = path;
+			tp = &per_cpu(trace_path, cpu)[per_cpu(frozen_path, cpu)];
+			if (tp->end >= 0) {
+				print_path = tp;
 				break;
 			}
 		}
@@ -1282,19 +1271,22 @@ void __init __ipipe_init_tracer(void)
 	int cpu, path;
 
 	for_each_possible_cpu(cpu) {
-		trace_paths[cpu] = vmalloc(
-			sizeof(struct ipipe_trace_path) * IPIPE_TRACE_PATHS);
-		if (trace_paths[cpu] == NULL) {
+		struct ipipe_trace_path *tp_buf;
+
+		tp_buf = vmalloc_node(sizeof(struct ipipe_trace_path) *
+				      IPIPE_TRACE_PATHS, cpu_to_node(cpu));
+		if (!tp_buf) {
 			printk(KERN_ERR "I-pipe: "
 			       "insufficient memory for trace buffer.\n");
 			return;
 		}
-		memset(trace_paths[cpu], 0,
-			sizeof(struct ipipe_trace_path) * IPIPE_TRACE_PATHS);
+		memset(tp_buf, 0,
+		       sizeof(struct ipipe_trace_path) * IPIPE_TRACE_PATHS);
 		for (path = 0; path < IPIPE_TRACE_PATHS; path++) {
-			trace_paths[cpu][path].begin = -1;
-			trace_paths[cpu][path].end   = -1;
+			tp_buf[path].begin = -1;
+			tp_buf[path].end   = -1;
 		}
+		per_cpu(trace_path, cpu) = tp_buf;
 	}
 #endif /* CONFIG_IPIPE_TRACE_VMALLOC */
 	ipipe_trace_enable = CONFIG_IPIPE_TRACE_ENABLE_VALUE;

--------------010603070206030507040309--

