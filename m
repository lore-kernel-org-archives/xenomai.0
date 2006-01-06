Message-ID: <43BE4091.4020806@domain.hid>
Date: Fri, 06 Jan 2006 11:04:01 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: [PATCH] latency tracer update
References: <43BC4FFB.8040709@domain.hid> <43BCF891.1080402@domain.hid>
	<43BCFFBB.1080303@domain.hid>
In-Reply-To: <43BCFFBB.1080303@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2D87EB5BD11773E0676BB5F3"
Sender: jan.kiszka@domain.hid
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
Cc: adeos-main@gna.org, xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2D87EB5BD11773E0676BB5F3
Content-Type: multipart/mixed; boundary="------------020100080707090402080106"

This is a multi-part message in MIME format.
--------------020100080707090402080106
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Jan Kiszka wrote:
> ...
> Meanwhile I found a solution for the described unterminated trace (put
> an explicite trace_end at the end of __ipipe_unstall_iret_root),
> included the irq number in the begin/end report, and stumbled over some
> other remaining unterminated trace on a different machine. So, no need
> to hurry with the merge (not the review! ;) ), I will publish a second
> revision first.
> 

And here comes this revision finally. Should apply (almost) cleanly
against latest ipipe versions. Additionally to the changes of the first
revision this one addresses the following topics:

 o fix trace overrun handling
 o report IRQ number to tracer on IRQ entry/exit
 o fix virtually leaking IRQs-off in __ipipe_unstall_iret_root()
 o fix another potential NMI race
 o really trace the maximum IRQs-off time, not the maximum time of
   consecutive IRQs-off times (that scenario will soon be addressed
   instead  in the latency benchmark tool => reset&freeze the maximum
   latency from the user's point of view)
 o remove the ipipe_trace_special reporting in local_irq_xxx trace
   points (cleans up the traces inside IRQ-off paths)

The tracer has undergone a significant number of tests now and it really
looks like it is stable. I will now have to fix/improve some minor
issues on the Xenomai side regarding tracing.

Jan

--------------020100080707090402080106
Content-Type: text/plain;
 name="ipipe_tracer.update3"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ipipe_tracer.update3"

--- linux-2.6.14.3/arch/i386/kernel/entry.S.orig	2006-01-03 19:30:15.000000000 +0100
+++ linux-2.6.14.3/arch/i386/kernel/entry.S	2006-01-05 03:37:24.000000000 +0100
@@ -106,6 +106,33 @@ VM_MASK		= 0x00020000
 				call __ipipe_divert_exception ; \
 				testl %eax,%eax	; \
 				jnz restore_raw
+
+#ifdef CONFIG_IPIPE_TRACE_IRQSOFF
+# ifdef CONFIG_REGPARM
+#  define LOAD_ARG
+#  define REMOVE_ARG
+# else  /* !CONFIG_REGPARM */
+#  define LOAD_ARG      pushl %eax
+#  define REMOVE_ARG    addl $4, %esp
+# endif /* CONFIG_REGPARM */
+# define IPIPE_TRACE_IRQ_ENTER \
+	lea EIP-4(%esp), %ebp; \
+	movl ORIG_EAX(%esp), %eax; \
+	LOAD_ARG; \
+	call ipipe_trace_begin; \
+	REMOVE_ARG
+# define IPIPE_TRACE_IRQ_EXIT \
+	pushl %eax; \
+	movl ORIG_EAX+4(%esp), %eax; \
+	LOAD_ARG; \
+	call ipipe_trace_end; \
+	REMOVE_ARG; \
+	popl %eax
+#else  /* !CONFIG_IPIPE_TRACE_IRQSOFF */
+# define IPIPE_TRACE_IRQ_ENTER
+# define IPIPE_TRACE_IRQ_EXIT
+#endif /* CONFIG_IPIPE_TRACE_IRQSOFF */
+
 #else  /* !CONFIG_IPIPE */
 #define CLI                     cli
 #define STI                     sti
@@ -474,7 +501,9 @@ vector=vector+1
 	ALIGN
 common_interrupt:
 	SAVE_ALL
+	IPIPE_TRACE_IRQ_ENTER; \
 	call __ipipe_handle_irq
+	IPIPE_TRACE_IRQ_EXIT; \
 	testl %eax,%eax
 	jnz  ret_from_intr
 	RESTORE_REGS
@@ -485,7 +514,9 @@ common_interrupt:
 ENTRY(name)				\
 	pushl $nr-288;	/* nr - (256 + FIRST_EXTERNAL_VECTOR) */ \
 	SAVE_ALL;			\
+	IPIPE_TRACE_IRQ_ENTER; \
 	call __ipipe_handle_irq;	\
+	IPIPE_TRACE_IRQ_EXIT; \
 	testl %eax,%eax;		\
 	jnz  ret_from_intr;		\
 	RESTORE_REGS;			\
--- linux-2.6.14.3/arch/i386/kernel/ipipe-root.c.orig	2006-01-02 20:42:58.000000000 +0100
+++ linux-2.6.14.3/arch/i386/kernel/ipipe-root.c	2006-01-06 02:47:31.000000000 +0100
@@ -283,7 +283,7 @@ asmlinkage int __ipipe_kpreempt_root(str
 	}
 
 	__ipipe_stall_root();
-	local_irq_enable_hw();
+	local_irq_enable_hw_notrace();
 
 	return 1;		/* Ok, may reschedule now. */
 }
@@ -320,6 +320,9 @@ asmlinkage void __ipipe_unstall_iret_roo
 		     irq_pending_hi & IPIPE_IRQMASK_VIRT) != 0)
 			__ipipe_sync_stage(IPIPE_IRQMASK_VIRT);
 	}
+#ifdef CONFIG_IPIPE_TRACE_IRQSOFF
+	ipipe_trace_end(0x8000000D);
+#endif /* CONFIG_IPIPE_TRACE_IRQSOFF */
 }
 
 asmlinkage int __ipipe_syscall_root(struct pt_regs regs)
--- linux-2.6.14.3/kernel/ipipe/tracer.c.orig	2006-01-02 20:44:21.000000000 +0100
+++ linux-2.6.14.3/kernel/ipipe/tracer.c	2006-01-06 02:35:08.000000000 +0100
@@ -47,8 +47,10 @@
 
 #define IPIPE_TFLG_NMI_LOCK         0x0001
 #define IPIPE_TFLG_NMI_HIT          0x0002
-#define IPIPE_TFLG_HWIRQ_OFF        0x0004
-#define IPIPE_TFLG_FREEZING         0x0008
+#define IPIPE_TFLG_NMI_FREEZE_REQ   0x0004
+
+#define IPIPE_TFLG_HWIRQ_OFF        0x0100
+#define IPIPE_TFLG_FREEZING         0x0200
 
 
 struct ipipe_trace_point{
@@ -63,10 +65,13 @@ struct ipipe_trace_point{
 struct ipipe_trace_path{
 	volatile int flags;
 	int dump_lock; /* separated from flags due to cross-cpu access */
-	int trace_pos;
-	int begin, end;
-	int post_trace;
-	unsigned long long length;
+	int trace_pos; /* next point to fill */
+	int begin, end; /* finalised path begin and end */
+	int post_trace; /* non-zero when in post-trace phase */
+	unsigned long long length; /* max path length in cycles */
+	unsigned long nmi_saved_eip; /* for deferred requests from NMIs */
+	unsigned long nmi_saved_parent_eip;
+	unsigned long nmi_saved_v;
 	struct ipipe_trace_point point[IPIPE_TRACE_POINTS];
 } ____cacheline_aligned_in_smp;
 
@@ -84,8 +89,10 @@ int ipipe_trace_enable = 1;
 
 static struct ipipe_trace_path trace_paths[NR_CPUS][IPIPE_TRACE_PATHS] =
 	{ [0 ... NR_CPUS-1] =
-		{ [ IPIPE_DEFAULT_ACTIVE ] = {.begin = -1, .end = -1 },
-		  [ IPIPE_DEFAULT_FROZEN ] = {.begin = -1, .end = -1 } } };
+		{ [0 ... IPIPE_TRACE_PATHS-1] =
+			{ .begin = -1, .end = -1 }
+		}
+	};
 static int active_path[NR_CPUS] =
 	{ [0 ... NR_CPUS-1] = IPIPE_DEFAULT_ACTIVE };
 static int max_path[NR_CPUS] =
@@ -133,7 +140,7 @@ __ipipe_migrate_pre_trace(struct ipipe_t
 		       sizeof(struct ipipe_trace_point));
 }
 
-static inline struct ipipe_trace_path *
+static notrace struct ipipe_trace_path *
 __ipipe_trace_end(int cpu_id, struct ipipe_trace_path *tp, int pos)
 {
 	struct ipipe_trace_path *old_tp = tp;
@@ -166,7 +173,7 @@ __ipipe_trace_end(int cpu_id, struct ipi
 	return tp;
 }
 
-static inline struct ipipe_trace_path *
+static notrace struct ipipe_trace_path *
 __ipipe_trace_freeze(int cpu_id, struct ipipe_trace_path *tp, int pos)
 {
 	struct ipipe_trace_path *old_tp = tp;
@@ -212,19 +219,45 @@ __ipipe_trace(enum ipipe_trace_type type
 	unsigned long flags;
 	int cpu_id;
 
-	local_irq_save_hw(flags);
+	local_irq_save_hw_notrace(flags);
 
 	cpu_id = raw_smp_processor_id();
+restart:
 	tp = old_tp = &trace_paths[cpu_id][active_path[cpu_id]];
 
+	/* here starts a race window with NMIs - catched below */
+
 	/* check for NMI recursion */
-	if (tp->flags & IPIPE_TFLG_NMI_LOCK) {
+	if (unlikely(tp->flags & IPIPE_TFLG_NMI_LOCK)) {
 		tp->flags |= IPIPE_TFLG_NMI_HIT;
+
+		/* first freeze request from NMI context? */
+		if ((type == IPIPE_TRACE_FREEZE) &&
+		    !(tp->flags & IPIPE_TFLG_NMI_FREEZE_REQ)) {
+			/* save arguments and mark deferred freezing */
+			tp->flags |= IPIPE_TFLG_NMI_FREEZE_REQ;
+			tp->nmi_saved_eip = eip;
+			tp->nmi_saved_parent_eip = parent_eip;
+			tp->nmi_saved_v = v;
+		}
 		return; /* no need for restoring flags inside IRQ */
 	}
 
-	/* clear NMI warning and set lock (atomically per cpu) */
-	tp->flags = (tp->flags & ~IPIPE_TFLG_NMI_HIT) | IPIPE_TFLG_NMI_LOCK;
+	/* clear NMI events and set lock (atomically per cpu) */
+	tp->flags = (tp->flags & ~(IPIPE_TFLG_NMI_HIT |
+	                           IPIPE_TFLG_NMI_FREEZE_REQ))
+	                       | IPIPE_TFLG_NMI_LOCK;
+
+	/* check active_path again - some nasty NMI may have switched
+	 * it meanwhile */
+	if (unlikely(tp != &trace_paths[cpu_id][active_path[cpu_id]])) {
+		/* release lock on wrong path and restart */
+		tp->flags &= ~IPIPE_TFLG_NMI_LOCK;
+
+		/* there is no chance that the NMI got deferred
+		 * => no need to check for pending freeze requests */
+		goto restart;
+	}
 
 	/* get the point buffer */
 	pos = tp->trace_pos;
@@ -244,36 +277,38 @@ __ipipe_trace(enum ipipe_trace_type type
 
 	/* only mark beginning if we haven't started yet */
 	begin = tp->begin;
-	if ((type == IPIPE_TRACE_BEGIN) && (begin < 0))
+	if (unlikely(type == IPIPE_TRACE_BEGIN) && (begin < 0))
 		tp->begin = pos;
 
-	/* skip END and FREEZE request during post-trace */
-	if (!tp->post_trace) {
-		/* end of critical path, start post-trace */
-		if ((type == IPIPE_TRACE_END) && (begin >= 0))
-			tp->post_trace = post_trace + 1;
-
-		/* freeze only if the slot is free */
-		if ((type == IPIPE_TRACE_FREEZE) &&
-		    (trace_paths[cpu_id][frozen_path[cpu_id]].begin < 0)) {
-			tp->post_trace = post_trace + 1;
-			tp->flags |= IPIPE_TFLG_FREEZING;
-		}
+	/* end of critical path, start post-trace if not already started */
+	if (unlikely(type == IPIPE_TRACE_END) &&
+	    (begin >= 0) && !tp->post_trace)
+		tp->post_trace = post_trace + 1;
+
+	/* freeze only if the slot is free and we are not already freezing */
+	if (unlikely(type == IPIPE_TRACE_FREEZE) &&
+	    (trace_paths[cpu_id][frozen_path[cpu_id]].begin < 0) &&
+	    !(tp->flags & IPIPE_TFLG_FREEZING)) {
+		tp->post_trace = post_trace + 1;
+		tp->flags |= IPIPE_TFLG_FREEZING;
 	}
 
 	/* enforce end of trace in case of overflow */
-	if (WRAP_POINT_NO(next_pos + 1) == begin)
-		tp->post_trace = 1;
+	if (unlikely(WRAP_POINT_NO(next_pos + 1) == begin)) {
+		tp->end = pos;
+		goto enforce_end;
+	}
 
 	/* stop tracing this path if we are in post-trace and
 	 *  a) that phase is over now or
 	 *  b) a new TRACE_BEGIN came in but we are not freezing this path */
-	if ((tp->post_trace > 0) && ((--tp->post_trace == 0) ||
-	    ((type == IPIPE_TRACE_BEGIN) &&
-	    !(tp->flags & IPIPE_TFLG_FREEZING)))) {
+	if (unlikely((tp->post_trace > 0) && ((--tp->post_trace == 0) ||
+	             ((type == IPIPE_TRACE_BEGIN) &&
+	              !(tp->flags & IPIPE_TFLG_FREEZING))))) {
 		/* store the path's end (i.e. excluding post-trace) */
 		tp->end = WRAP_POINT_NO(pos - post_trace + tp->post_trace);
 
+enforce_end:
 		if (tp->flags & IPIPE_TFLG_FREEZING)
 			tp = __ipipe_trace_freeze(cpu_id, tp, pos);
 		else
@@ -281,23 +316,84 @@ __ipipe_trace(enum ipipe_trace_type type
 
 		/* reset the active path, maybe already start a new one */
 		tp->begin = (type == IPIPE_TRACE_BEGIN) ?
-			tp->trace_pos-1 : -1;
+			WRAP_POINT_NO(tp->trace_pos - 1) : -1;
 		tp->end = -1;
 		tp->post_trace = 0;
+		tp->flags = 0;
 
 		/* update active_path not earlier to avoid races with NMIs */
 		active_path[cpu_id] = tp - trace_paths[cpu_id];
 	}
 
 	/* we still have old_tp and point,
-	 * let's reset NMI lock and check for noise */
+	 * let's reset NMI lock and check for catches */
 	old_tp->flags &= ~IPIPE_TFLG_NMI_LOCK;
-	if (old_tp->flags & IPIPE_TFLG_NMI_HIT) {
+	if (unlikely(old_tp->flags & IPIPE_TFLG_NMI_HIT)) {
 		/* well, this late tagging may not immediately be visible for
 		 * other cpus already dumping this path - a minor issue */
 		point->flags |= IPIPE_TFLG_NMI_HIT;
+
+		/* handle deferred freezing from NMI context */
+		if (old_tp->flags & IPIPE_TFLG_NMI_FREEZE_REQ)
+			__ipipe_trace(IPIPE_TRACE_FREEZE, old_tp->nmi_saved_eip,
+			              old_tp->nmi_saved_parent_eip,
+			              old_tp->nmi_saved_v);
 	}
 
+	local_irq_restore_hw_notrace(flags);
+}
+
+static unsigned long __ipipe_global_path_lock(void)
+{
+	unsigned long flags;
+	int cpu_id;
+	struct ipipe_trace_path *tp;
+
+	spin_lock_irqsave_hw(&global_path_lock, flags);
+
+	cpu_id = raw_smp_processor_id();
+restart:
+	tp = &trace_paths[cpu_id][active_path[cpu_id]];
+
+	/* here is small race window with NMIs - catched below */
+
+	/* clear NMI events and set lock (atomically per cpu) */
+	tp->flags = (tp->flags & ~(IPIPE_TFLG_NMI_HIT |
+	                           IPIPE_TFLG_NMI_FREEZE_REQ))
+	                       | IPIPE_TFLG_NMI_LOCK;
+
+	/* check active_path again - some nasty NMI may have switched
+	 * it meanwhile */
+	if (tp != &trace_paths[cpu_id][active_path[cpu_id]]) {
+		/* release lock on wrong path and restart */
+		tp->flags &= ~IPIPE_TFLG_NMI_LOCK;
+
+		/* there is no chance that the NMI got deferred
+		 * => no need to check for pending freeze requests */
+		goto restart;
+	}
+
+	return flags;
+}
+
+static void __ipipe_global_path_unlock(unsigned long flags)
+{
+	int cpu_id;
+	struct ipipe_trace_path *tp;
+
+	/* release spinlock first - it's not involved in the NMI issue */
+	spin_unlock_hw(&global_path_lock);
+
+	cpu_id = raw_smp_processor_id();
+	tp = &trace_paths[cpu_id][active_path[cpu_id]];
+
+	tp->flags &= ~IPIPE_TFLG_NMI_LOCK;
+
+	/* handle deferred freezing from NMI context */
+	if (tp->flags & IPIPE_TFLG_NMI_FREEZE_REQ)
+		__ipipe_trace(IPIPE_TRACE_FREEZE, tp->nmi_saved_eip,
+		              tp->nmi_saved_parent_eip, tp->nmi_saved_v);
+
 	local_irq_restore_hw(flags);
 }
 
@@ -340,6 +436,58 @@ void notrace ipipe_trace_special(unsigne
 }
 EXPORT_SYMBOL(ipipe_trace_special);
 
+void ipipe_trace_max_reset(void)
+{
+	int cpu_id;
+	unsigned long flags;
+	struct ipipe_trace_path *path;
+
+	/* only allowed from root domain (we sync with /proc routines) */
+	if (ipipe_current_domain != ipipe_root_domain)
+		return;
+
+	down(&out_mutex);
+	flags = __ipipe_global_path_lock();
+
+	for_each_cpu(cpu_id) {
+		path = &trace_paths[cpu_id][max_path[cpu_id]];
+		path->begin     = -1;
+		path->end       = -1;
+		path->trace_pos = 0;
+		path->length    = 0;
+	}
+
+	__ipipe_global_path_unlock(flags);
+	up(&out_mutex);
+}
+EXPORT_SYMBOL(ipipe_trace_max_reset);
+
+void ipipe_trace_frozen_reset(void)
+{
+	int cpu_id;
+	unsigned long flags;
+	struct ipipe_trace_path *path;
+
+	/* only allowed from root domain (we sync with /proc routines) */
+	if (ipipe_current_domain != ipipe_root_domain)
+		return;
+
+	down(&out_mutex);
+	flags = __ipipe_global_path_lock();
+
+	for_each_cpu(cpu_id) {
+		path = &trace_paths[cpu_id][frozen_path[cpu_id]];
+		path->begin = -1;
+		path->end = -1;
+		path->trace_pos = 0;
+		path->length    = 0;
+	}
+
+	__ipipe_global_path_unlock(flags);
+	up(&out_mutex);
+}
+EXPORT_SYMBOL(ipipe_trace_frozen_reset);
+
 
 /* --- /proc output --- */
 
@@ -453,8 +601,9 @@ static void *__ipipe_max_prtrace_start(s
 		unsigned long flags;
 
 		/* protect against max_path/frozen_path updates while we
-		 * haven't locked our target path */
-		spin_lock_irqsave_hw(&global_path_lock, flags);
+		 * haven't locked our target path, also avoid recursively
+		 * taking global_path_lock from NMI context */
+		flags = __ipipe_global_path_lock();
 
 		/* find the longest of all per-cpu paths */
 		print_path = NULL;
@@ -466,7 +615,7 @@ static void *__ipipe_max_prtrace_start(s
 		}
 		print_path->dump_lock = 1;
 
-		spin_unlock_irqrestore_hw(&global_path_lock, flags);
+		__ipipe_global_path_unlock(flags);
 
 		/* does this path actually contain data? */
 		if (print_path->end == print_path->begin)
@@ -600,24 +749,7 @@ static ssize_t
 __ipipe_max_reset(struct file *file, const char __user *pbuffer,
                   size_t count, loff_t *data)
 {
-	int cpu_id;
-	unsigned long flags;
-	struct ipipe_trace_path *path;
-
-	down(&out_mutex);
-	spin_lock_irqsave_hw(&global_path_lock, flags);
-
-	for_each_cpu(cpu_id) {
-		path = &trace_paths[cpu_id][max_path[cpu_id]];
-		path->begin     = 0;
-		path->end       = 0;
-		path->trace_pos = 0;
-		path->length    = 0;
-	}
-
-	spin_unlock_irqrestore_hw(&global_path_lock, flags);
-	up(&out_mutex);
-
+	ipipe_trace_max_reset();
 	return count;
 }
 
@@ -641,8 +773,9 @@ static void *__ipipe_frozen_prtrace_star
 		unsigned long flags;
 
 		/* protect against max_path/frozen_path updates while we
-		 * haven't locked our target path */
-		spin_lock_irqsave_hw(&global_path_lock, flags);
+		 * haven't locked our target path, also avoid recursively
+		 * taking global_path_lock from NMI context */
+		flags = __ipipe_global_path_lock();
 
 		/* find the first of all per-cpu frozen paths */
 		print_path = NULL;
@@ -654,7 +787,7 @@ static void *__ipipe_frozen_prtrace_star
 		if (print_path)
 			print_path->dump_lock = 1;
 
-		spin_unlock_irqrestore_hw(&global_path_lock, flags);
+		__ipipe_global_path_unlock(flags);
 
 		if (!print_path)
 			return NULL;
@@ -708,22 +841,7 @@ static ssize_t
 __ipipe_frozen_reset(struct file *file, const char __user *pbuffer,
                      size_t count, loff_t *data)
 {
-	int cpu_id;
-	unsigned long flags;
-	struct ipipe_trace_path *path;
-
-	down(&out_mutex);
-	spin_lock_irqsave_hw(&global_path_lock, flags);
-
-	for_each_cpu(cpu_id) {
-		path = &trace_paths[cpu_id][frozen_path[cpu_id]];
-		path->begin = -1;
-		path->end = -1;
-	}
-
-	spin_unlock_irqrestore_hw(&global_path_lock, flags);
-	up(&out_mutex);
-
+	ipipe_trace_frozen_reset();
 	return count;
 }
 
--- linux-2.6.14.3/kernel/ipipe/Kconfig.orig	2006-01-02 20:44:21.000000000 +0100
+++ linux-2.6.14.3/kernel/ipipe/Kconfig	2006-01-04 04:19:53.000000000 +0100
@@ -15,9 +15,21 @@ config IPIPE_STATS
 	  is useful to detect unexpected latency spots.
 
 config IPIPE_TRACE
-	bool "Trace interrupt latencies"
+	bool "Latency Tracing"
 	depends on IPIPE && PROC_FS
 	default n
 	---help---
-	  Activate this option if I-pipe shall trace the longest stalled path
-	  of the domain with the highest priority.
+	  Activate this option if you want to use per-function tracing of
+	  the kernel. The tracer will collect data via instrumentation
+	  features like the one below or with the help of explicite calls
+	  of ipipe_trace_xxx(). See include/linux/ipipe_trace.h for the
+	  in-kernel tracing API. The collected data and runtime control
+	  is available via /proc/ipipe/trace/*.
+
+config IPIPE_TRACE_IRQSOFF
+	bool "Trace IRQs-off times"
+	depends on IPIPE_TRACE
+	default y
+	---help---
+	  Activate this option if I-pipe shall trace the longest path
+	  with hard-IRQs switched off.
--- linux-2.6.14.3/include/linux/ipipe_trace.h.orig	2006-01-02 20:44:21.000000000 +0100
+++ linux-2.6.14.3/include/linux/ipipe_trace.h	2006-01-03 17:06:09.000000000 +0100
@@ -28,4 +28,7 @@ void ipipe_trace_end(unsigned long v);
 void ipipe_trace_freeze(unsigned long v);
 void ipipe_trace_special(unsigned char special_id, unsigned long v);
 
+void ipipe_trace_max_reset(void);
+void ipipe_trace_frozen_reset(void);
+
 #endif	/* !__LINUX_IPIPE_H */
--- linux-2.6.14.3/include/asm-i386/system.h.orig	2006-01-03 19:05:32.000000000 +0100
+++ linux-2.6.14.3/include/asm-i386/system.h	2006-01-06 02:44:13.000000000 +0100
@@ -481,18 +481,76 @@ void fastcall __ipipe_restore_root(unsig
 
 #define irqs_disabled()		__ipipe_test_root()
 
+#define halt()	__asm__ __volatile__("hlt": : :"memory")
+
+#ifdef CONFIG_IPIPE_TRACE_IRQSOFF
+
+#include <linux/ipipe_trace.h>
+
 #define safe_halt() do { \
-    __ipipe_unstall_root(); \
-    __asm__ __volatile__("sti; hlt": : :"memory"); \
+	__ipipe_unstall_root(); \
+	ipipe_trace_end(0x8000000E); \
+	__asm__ __volatile__("sti; hlt": : :"memory"); \
 } while(0)
 
-#define halt()	__asm__ __volatile__("hlt": : :"memory")
+#define ipipe_hw_save_flags_and_sti(x) do { \
+	ipipe_trace_end(0x8000000F); \
+	__asm__ __volatile__("pushfl ; popl %0 ; sti":"=g" (x): /* no input */ :"memory"); \
+} while (0)
+#define local_irq_disable_hw() do { \
+	if (!irqs_disabled_hw()) { \
+		__asm__ __volatile__("cli": : :"memory"); \
+		ipipe_trace_begin(0x80000000); \
+	} \
+} while (0)
+#define local_irq_enable_hw() do { \
+	if (irqs_disabled_hw()) { \
+		ipipe_trace_end(0x80000000); \
+		__asm__ __volatile__("sti": : :"memory"); \
+	} \
+} while (0)
+#define local_irq_save_hw(x) do { \
+	local_save_flags_hw(x); \
+	if (local_test_iflag_hw(x)) { \
+		__asm__ __volatile__("cli": : :"memory"); \
+		ipipe_trace_begin(0x80000001); \
+	} \
+} while (0)
+#define local_irq_restore_hw(x) do { \
+	if (local_test_iflag_hw(x)) \
+		ipipe_trace_end(0x80000001); \
+	__asm__ __volatile__("pushl %0 ; popfl": /* no output */ :"g" (x):"memory", "cc"); \
+} while (0)
+
+#define local_irq_disable_hw_notrace() \
+	__asm__ __volatile__("cli": : :"memory")
+#define local_irq_enable_hw_notrace() \
+	__asm__ __volatile__("sti": : :"memory")
+#define local_irq_save_hw_notrace(x) \
+	__asm__ __volatile__("pushfl ; popl %0 ; cli":"=g" (x): /* no input */ :"memory")
+#define local_irq_restore_hw_notrace(x) \
+	__asm__ __volatile__("pushl %0 ; popfl": /* no output */ :"g" (x):"memory", "cc")
+
+#else /* !CONFIG_IPIPE_TRACE_IRQSOFF */
+
+#define safe_halt() do { \
+	__ipipe_unstall_root(); \
+	__asm__ __volatile__("sti; hlt": : :"memory"); \
+} while(0)
 
 #define ipipe_hw_save_flags_and_sti(x)	__asm__ __volatile__("pushfl ; popl %0 ; sti":"=g" (x): /* no input */ :"memory")
 #define local_irq_disable_hw() 			__asm__ __volatile__("cli": : :"memory")
 #define local_irq_enable_hw()			__asm__ __volatile__("sti": : :"memory")
 #define local_irq_save_hw(x)    __asm__ __volatile__("pushfl ; popl %0 ; cli":"=g" (x): /* no input */ :"memory")
 #define local_irq_restore_hw(x) __asm__ __volatile__("pushl %0 ; popfl": /* no output */ :"g" (x):"memory", "cc")
+
+#define local_irq_disable_hw_notrace    local_irq_disable_hw
+#define local_irq_enable_hw_notrace     local_irq_enable_hw
+#define local_irq_save_hw_notrace       local_irq_save_hw
+#define local_irq_restore_hw_notrace    local_irq_restore_hw
+
+#endif /* CONFIG_IPIPE_TRACE_IRQSOFF */
+
 #define local_save_flags_hw(x)   __asm__ __volatile__("pushfl ; popl %0":"=g" (x): /* no input */)
 #define local_test_iflag_hw(x)   ((x) & (1<<9))
 #define irqs_disabled_hw()	\

--------------020100080707090402080106--

--------------enig2D87EB5BD11773E0676BB5F3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDvkCWniDOoMHTA+kRAkA+AJ0ZHiTKP4voMuRTccZ7eJitfP/14wCfeitz
Tr6EGO+7/riY5B7MWFAIHUU=
=AS7Y
-----END PGP SIGNATURE-----

--------------enig2D87EB5BD11773E0676BB5F3--

