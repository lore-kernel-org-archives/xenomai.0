Message-ID: <464766E6.8060301@domain.hid>
Date: Sun, 13 May 2007 21:28:38 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB7296F14ECBB12020D5AA092"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [RFC][PATCH] Kill ipipe_processor_id completely
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
Cc: adeos-main <adeos-main@gna.org>, xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB7296F14ECBB12020D5AA092
Content-Type: multipart/mixed;
 boundary="------------090007090001080403030003"

This is a multi-part message in MIME format.
--------------090007090001080403030003
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

you have been warned, here it is: my radical janitor work to remove any
trace of ipipe_processor_id from the I-pipe patch. =3D8)

It's still RFC, comes in big blobs, and most probably leaves a few
corner cases behind, but it already survived light testing on qemu smp
boxes. Features:

 - Far less reasons to handle smp_processor_id() calls special when
   being used also over non-root domains -- thus less patch hunks.
 - (Almost) fully functional debug_smp_processor_id() for all I-pipe
   domains. The only restriction comes from the fact that domain-
   internal preempt_disable variants are not known to the generic code
   and still require special handling (raw_smp_processor_id()).
 - Micro-optimisations for UP (killed a few cpuid parameter passings).
 - Remove also ipipe_safe_current(), we should demand non-stack-based
   current for all archs now. As ipipe-kdgb is still stalled for recent
   kernels (I wonder if kgdb will EVER make it into mainline - a pity),
   no damage is caused.

To-do:
 - Review and test for more corner cases in which debug_smp_processor_id
   may give false positives.
 - Check if xntimer_init is actually fine.
 - Port to other archs.

Here is the patch list:
 [I-pipe 1.8-01, dependencies: trace_panic-only-once.patch]
 1. remove-safe-current.patch
 2. remove-ipipe_processor_id.patch
 3. remove-ipipe_processor_id-i386.patch

 [Xenomai trunk]
 4. xeno-kill-ipipe_processor_id.patch

Comments welcome!

Jan

--------------090007090001080403030003
Content-Type: text/x-patch;
 name="remove-safe-current.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="remove-safe-current.patch"

---
 include/linux/ipipe.h |   11 -----------
 1 file changed, 11 deletions(-)

Index: linux-2.6.20/include/linux/ipipe.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20.orig/include/linux/ipipe.h
+++ linux-2.6.20/include/linux/ipipe.h
@@ -588,16 +588,6 @@ static inline void ipipe_clear_foreign_s
 	__clear_bit(IPIPE_NOSTACK_FLAG, &ipd->cpudata[cpuid].status);
 }
=20
-#define ipipe_safe_current()					\
-({								\
-	ipipe_declare_cpuid;					\
-	struct task_struct *p;					\
-	ipipe_load_cpuid();					\
-	p =3D test_bit(IPIPE_NOSTACK_FLAG,			\
-		     &per_cpu(ipipe_percpu_domain, cpuid)->cpudata[cpuid].status) ? &i=
nit_task : current; \
-	p; \
-})
-
 ipipe_event_handler_t ipipe_catch_event(struct ipipe_domain *ipd,
 					unsigned event,
 					ipipe_event_handler_t handler);
@@ -686,7 +676,6 @@ int ipipe_disable_ondemand_mappings(stru
 #define ipipe_irq_unlock(irq)		do { } while(0)
=20
 #define ipipe_root_domain_p		1
-#define ipipe_safe_current		current
=20
 #define local_irq_disable_head()	local_irq_disable()
=20

--------------090007090001080403030003
Content-Type: text/x-patch;
 name="remove-ipipe_processor_id.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="remove-ipipe_processor_id.patch"

---
 include/linux/ipipe.h      |   17 +++-----
 include/linux/smp.h        |    8 ---
 kernel/ipipe/Kconfig.debug |   11 ++++-
 kernel/ipipe/core.c        |   16 ++++---
 kernel/ipipe/tracer.c      |   91 +++++++++++++++++++++++---------------=
-------
 lib/smp_processor_id.c     |   17 +++++++-
 6 files changed, 90 insertions(+), 70 deletions(-)

Index: linux-2.6.20/include/linux/ipipe.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20.orig/include/linux/ipipe.h
+++ linux-2.6.20/include/linux/ipipe.h
@@ -96,16 +96,17 @@
 #define IPIPE_NR_CPUS		NR_CPUS
 #define ipipe_declare_cpuid	int cpuid
 #define ipipe_load_cpuid()	do { \
-					cpuid =3D ipipe_processor_id();	\
+					cpuid =3D smp_processor_id();	\
 				} while(0)
 #define ipipe_lock_cpu(flags)	do { \
 					local_irq_save_hw(flags); \
-					cpuid =3D ipipe_processor_id(); \
+					cpuid =3D smp_processor_id(); \
 				} while(0)
 #define ipipe_unlock_cpu(flags)	local_irq_restore_hw(flags)
 #define ipipe_get_cpu(flags)	ipipe_lock_cpu(flags)
 #define ipipe_put_cpu(flags)	ipipe_unlock_cpu(flags)
-#define ipipe_current_domain	per_cpu(ipipe_percpu_domain, ipipe_processo=
r_id())
+#define ipipe_current_domain \
+	per_cpu(ipipe_percpu_domain, raw_smp_processor_id())
=20
 #else /* !CONFIG_SMP */
=20
@@ -304,7 +305,7 @@ void __ipipe_remove_domain_proc(struct i
=20
 void __ipipe_flush_printk(unsigned irq, void *cookie);
=20
-void fastcall __ipipe_walk_pipeline(struct list_head *pos, int cpuid);
+void __ipipe_walk_pipeline(struct list_head *pos);
=20
 int fastcall __ipipe_schedule_irq(unsigned irq, struct list_head *head);=

=20
@@ -402,9 +403,8 @@ do {									\
=20
 #define ipipe_trap_notify(ex, regs)		\
 ({						\
-	ipipe_declare_cpuid;			\
+	int cpuid =3D raw_smp_processor_id();	\
 	int ret =3D 0;				\
-	ipipe_load_cpuid();			\
 	if ((test_bit(IPIPE_NOSTACK_FLAG, &ipipe_current_domain->cpudata[cpuid]=
=2Estatus) || \
 	     ((current)->flags & PF_EVNOTIFY)) &&			\
 	    __ipipe_event_monitored_p(ex))				\
@@ -529,7 +529,7 @@ static inline void ipipe_restore_pipelin
 	 * the truth value (if this is wrong, the failed optimization will
 	 * be caught in __ipipe_restore_pipeline_head() if
 	 * CONFIG_DEBUG_KERNEL is set). */
-	if ((x ^ test_bit(IPIPE_STALL_FLAG, &head->cpudata[ipipe_processor_id()=
].status)) & 1)
+	if ((x ^ test_bit(IPIPE_STALL_FLAG, &head->cpudata[smp_processor_id()].=
status)) & 1)
 		__ipipe_restore_pipeline_head(head,x);
 }
=20
@@ -635,8 +635,6 @@ int ipipe_disable_ondemand_mappings(stru
 			local_irq_disable_hw();		\
 	} while(0)
=20
-#define smp_processor_id_hw()				ipipe_processor_id()
-
 #define ipipe_irq_lock(irq)						\
 	do {								\
 		ipipe_declare_cpuid;					\
@@ -670,7 +668,6 @@ int ipipe_disable_ondemand_mappings(stru
 #define local_irq_disable_hw_cond()		do { } while(0)
 #define local_irq_save_hw_cond(flags)	do { (void)(flags); } while(0)
 #define local_irq_restore_hw_cond(flags)	do { } while(0)
-#define smp_processor_id_hw()			smp_processor_id()
=20
 #define ipipe_irq_lock(irq)		do { } while(0)
 #define ipipe_irq_unlock(irq)		do { } while(0)
Index: linux-2.6.20/kernel/ipipe/core.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20.orig/kernel/ipipe/core.c
+++ linux-2.6.20/kernel/ipipe/core.c
@@ -272,7 +272,7 @@ void fastcall ipipe_unstall_pipeline_fro
 	else
 		pos =3D __ipipe_pipeline.next;
=20
-	__ipipe_walk_pipeline(pos, cpuid);
+	__ipipe_walk_pipeline(pos);
=20
 	if (__ipipe_pipeline_head_p(ipd))
 		local_irq_enable_hw();
@@ -316,7 +316,7 @@ void ipipe_unstall_pipeline_head(void)
 		if (likely(head =3D=3D per_cpu(ipipe_percpu_domain, cpuid)))
 			__ipipe_sync_pipeline(IPIPE_IRQMASK_ANY);
 		else
-			__ipipe_walk_pipeline(&head->p_link, cpuid);
+			__ipipe_walk_pipeline(&head->p_link);
         }
=20
 	local_irq_enable_hw();
@@ -352,7 +352,7 @@ void fastcall __ipipe_restore_pipeline_h
 			if (likely(head =3D=3D per_cpu(ipipe_percpu_domain, cpuid)))
 				__ipipe_sync_pipeline(IPIPE_IRQMASK_ANY);
 			else
-				__ipipe_walk_pipeline(&head->p_link, cpuid);
+				__ipipe_walk_pipeline(&head->p_link);
 		}
 		local_irq_enable_hw();
 	}
@@ -361,9 +361,13 @@ void fastcall __ipipe_restore_pipeline_h
 /* __ipipe_walk_pipeline(): Plays interrupts pending in the log. Must
    be called with local hw interrupts disabled. */
=20
-void fastcall __ipipe_walk_pipeline(struct list_head *pos, int cpuid)
+void __ipipe_walk_pipeline(struct list_head *pos)
 {
-	struct ipipe_domain *this_domain =3D per_cpu(ipipe_percpu_domain, cpuid=
);
+	struct ipipe_domain *this_domain;
+	ipipe_declare_cpuid;
+
+	ipipe_load_cpuid();
+	this_domain =3D per_cpu(ipipe_percpu_domain, cpuid);
=20
 	while (pos !=3D &__ipipe_pipeline) {
 		struct ipipe_domain *next_domain =3D
@@ -810,7 +814,7 @@ void fastcall __ipipe_sync_stage(unsigne
 			__ipipe_run_isr(ipd, irq, cpuid);
 #ifdef CONFIG_SMP
 			{
-				int _cpuid =3D ipipe_processor_id();
+				int _cpuid =3D smp_processor_id();
=20
 				if (_cpuid !=3D cpuid) {	/* Handle CPU migration. */
 					/*
Index: linux-2.6.20/kernel/ipipe/tracer.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20.orig/kernel/ipipe/tracer.c
+++ linux-2.6.20/kernel/ipipe/tracer.c
@@ -144,19 +144,20 @@ static void __ipipe_print_symname(struct
=20
=20
 static notrace void
-__ipipe_store_domain_states(struct ipipe_trace_point *point, int cpu_id)=

+__ipipe_store_domain_states(struct ipipe_trace_point *point)
 {
 	struct list_head *pos;
 	int i =3D 0;
+	int cpuid =3D raw_smp_processor_id();
=20
 	list_for_each_prev(pos, &__ipipe_pipeline) {
 		struct ipipe_domain *ipd =3D
 			list_entry(pos, struct ipipe_domain, p_link);
=20
-		if (test_bit(IPIPE_STALL_FLAG, &ipd->cpudata[cpu_id].status))
+		if (test_bit(IPIPE_STALL_FLAG, &ipd->cpudata[cpuid].status))
 			point->flags |=3D 1 << (i + IPIPE_TFLG_DOMSTATE_SHIFT);
=20
-		if (ipd =3D=3D per_cpu(ipipe_percpu_domain, cpu_id))
+		if (ipd =3D=3D per_cpu(ipipe_percpu_domain, cpuid))
 			point->flags |=3D i << IPIPE_TFLG_CURRDOM_SHIFT;
=20
 		if (++i > IPIPE_TFLG_DOMSTATE_BITS)
@@ -164,17 +165,18 @@ __ipipe_store_domain_states(struct ipipe
 	}
 }
=20
-static notrace int __ipipe_get_free_trace_path(int old, int cpu_id)
+static notrace int __ipipe_get_free_trace_path(int old)
 {
 	int new_active =3D old;
 	struct ipipe_trace_path *tp;
+	int cpuid =3D raw_smp_processor_id();
=20
 	do {
 		if (++new_active =3D=3D IPIPE_TRACE_PATHS)
 			new_active =3D 0;
-		tp =3D &trace_paths[cpu_id][new_active];
-	} while ((new_active =3D=3D max_path[cpu_id]) ||
-	         (new_active =3D=3D frozen_path[cpu_id]) ||
+		tp =3D &trace_paths[cpuid][new_active];
+	} while ((new_active =3D=3D max_path[cpuid]) ||
+	         (new_active =3D=3D frozen_path[cpuid]) ||
 	         tp->dump_lock);
=20
 	return new_active;
@@ -198,30 +200,31 @@ __ipipe_migrate_pre_trace(struct ipipe_t
 }
=20
 static notrace struct ipipe_trace_path *
-__ipipe_trace_end(int cpu_id, struct ipipe_trace_path *tp, int pos)
+__ipipe_trace_end(struct ipipe_trace_path *tp, int pos)
 {
 	struct ipipe_trace_path *old_tp =3D tp;
-	long active =3D active_path[cpu_id];
 	unsigned long long length;
+	int cpuid =3D raw_smp_processor_id();
+	long active =3D active_path[cpuid];
=20
 	/* do we have a new worst case? */
 	length =3D tp->point[tp->end].timestamp -
 	         tp->point[tp->begin].timestamp;
-	if (length > (trace_paths[cpu_id][max_path[cpu_id]]).length) {
+	if (length > (trace_paths[cpuid][max_path[cpuid]]).length) {
 		/* we need protection here against other cpus trying
 		   to start a proc dump */
 		spin_lock(&global_path_lock);
=20
 		/* active path holds new worst case */
 		tp->length =3D length;
-		max_path[cpu_id] =3D active;
+		max_path[cpuid] =3D active;
=20
 		/* find next unused trace path */
-		active =3D __ipipe_get_free_trace_path(active, cpu_id);
+		active =3D __ipipe_get_free_trace_path(active);
=20
 		spin_unlock(&global_path_lock);
=20
-		tp =3D &trace_paths[cpu_id][active];
+		tp =3D &trace_paths[cpuid][active];
=20
 		/* migrate last entries for pre-tracing */
 		__ipipe_migrate_pre_trace(tp, old_tp, pos);
@@ -231,10 +234,11 @@ __ipipe_trace_end(int cpu_id, struct ipi
 }
=20
 static notrace struct ipipe_trace_path *
-__ipipe_trace_freeze(int cpu_id, struct ipipe_trace_path *tp, int pos)
+__ipipe_trace_freeze(struct ipipe_trace_path *tp, int pos)
 {
 	struct ipipe_trace_path *old_tp =3D tp;
-	long active =3D active_path[cpu_id];
+	int cpuid =3D raw_smp_processor_id();
+	long active =3D active_path[cpuid];
 	int i;
=20
 	/* frozen paths have no core (begin=3Dend) */
@@ -244,21 +248,21 @@ __ipipe_trace_freeze(int cpu_id, struct=20
 	 * to set their frozen path or to start a proc dump */
 	spin_lock(&global_path_lock);
=20
-	frozen_path[cpu_id] =3D active;
+	frozen_path[cpuid] =3D active;
=20
 	/* find next unused trace path */
-	active =3D __ipipe_get_free_trace_path(active, cpu_id);
+	active =3D __ipipe_get_free_trace_path(active);
=20
 	/* check if this is the first frozen path */
 	for_each_online_cpu(i) {
-		if ((i !=3D cpu_id) &&
+		if ((i !=3D cpuid) &&
 		    (trace_paths[i][frozen_path[i]].end >=3D 0))
 			tp->end =3D -1;
 	}
=20
 	spin_unlock(&global_path_lock);
=20
-	tp =3D &trace_paths[cpu_id][active];
+	tp =3D &trace_paths[cpuid][active];
=20
 	/* migrate last entries for pre-tracing */
 	__ipipe_migrate_pre_trace(tp, old_tp, pos);
@@ -274,13 +278,13 @@ __ipipe_trace(enum ipipe_trace_type type
 	int pos, next_pos, begin;
 	struct ipipe_trace_point *point;
 	unsigned long flags;
-	int cpu_id;
+	int cpuid;
=20
 	local_irq_save_hw_notrace(flags);
=20
-	cpu_id =3D ipipe_processor_id();
+	cpuid =3D raw_smp_processor_id();
  restart:
-	tp =3D old_tp =3D &trace_paths[cpu_id][active_path[cpu_id]];
+	tp =3D old_tp =3D &trace_paths[cpuid][active_path[cpuid]];
=20
 	/* here starts a race window with NMIs - catched below */
=20
@@ -307,7 +311,7 @@ __ipipe_trace(enum ipipe_trace_type type
=20
 	/* check active_path again - some nasty NMI may have switched
 	 * it meanwhile */
-	if (unlikely(tp !=3D &trace_paths[cpu_id][active_path[cpu_id]])) {
+	if (unlikely(tp !=3D &trace_paths[cpuid][active_path[cpuid]])) {
 		/* release lock on wrong path and restart */
 		tp->flags &=3D ~IPIPE_TFLG_NMI_LOCK;
=20
@@ -328,7 +332,7 @@ __ipipe_trace(enum ipipe_trace_type type
 	point->v =3D v;
 	ipipe_read_tsc(point->timestamp);
=20
-	__ipipe_store_domain_states(point, cpu_id);
+	__ipipe_store_domain_states(point);
=20
 	/* forward to next point buffer */
 	next_pos =3D WRAP_POINT_NO(pos+1);
@@ -346,7 +350,7 @@ __ipipe_trace(enum ipipe_trace_type type
=20
 	/* freeze only if the slot is free and we are not already freezing */
 	if (unlikely(type =3D=3D IPIPE_TRACE_FREEZE) &&
-	    (trace_paths[cpu_id][frozen_path[cpu_id]].begin < 0) &&
+	    (trace_paths[cpuid][frozen_path[cpuid]].begin < 0) &&
 	    !(tp->flags & IPIPE_TFLG_FREEZING)) {
 		tp->post_trace =3D post_trace + 1;
 		tp->flags |=3D IPIPE_TFLG_FREEZING;
@@ -369,9 +373,9 @@ __ipipe_trace(enum ipipe_trace_type type
=20
  enforce_end:
 		if (tp->flags & IPIPE_TFLG_FREEZING)
-			tp =3D __ipipe_trace_freeze(cpu_id, tp, pos);
+			tp =3D __ipipe_trace_freeze(tp, pos);
 		else
-			tp =3D __ipipe_trace_end(cpu_id, tp, pos);
+			tp =3D __ipipe_trace_end(tp, pos);
=20
 		/* reset the active path, maybe already start a new one */
 		tp->begin =3D (type =3D=3D IPIPE_TRACE_BEGIN) ?
@@ -381,7 +385,7 @@ __ipipe_trace(enum ipipe_trace_type type
 		tp->flags =3D 0;
=20
 		/* update active_path not earlier to avoid races with NMIs */
-		active_path[cpu_id] =3D tp - trace_paths[cpu_id];
+		active_path[cpuid] =3D tp - trace_paths[cpuid];
 	}
=20
 	/* we still have old_tp and point,
@@ -405,14 +409,14 @@ __ipipe_trace(enum ipipe_trace_type type
 static unsigned long __ipipe_global_path_lock(void)
 {
 	unsigned long flags;
-	int cpu_id;
 	struct ipipe_trace_path *tp;
+	int cpuid;
=20
 	spin_lock_irqsave(&global_path_lock, flags);
=20
-	cpu_id =3D ipipe_processor_id();
+	cpuid =3D raw_smp_processor_id();
  restart:
-	tp =3D &trace_paths[cpu_id][active_path[cpu_id]];
+	tp =3D &trace_paths[cpuid][active_path[cpuid]];
=20
 	/* here is small race window with NMIs - catched below */
=20
@@ -423,7 +427,7 @@ static unsigned long __ipipe_global_path
=20
 	/* check active_path again - some nasty NMI may have switched
 	 * it meanwhile */
-	if (tp !=3D &trace_paths[cpu_id][active_path[cpu_id]]) {
+	if (tp !=3D &trace_paths[cpuid][active_path[cpuid]]) {
 		/* release lock on wrong path and restart */
 		tp->flags &=3D ~IPIPE_TFLG_NMI_LOCK;
=20
@@ -437,14 +441,13 @@ static unsigned long __ipipe_global_path
=20
 static void __ipipe_global_path_unlock(unsigned long flags)
 {
-	int cpu_id;
 	struct ipipe_trace_path *tp;
+	int cpuid =3D raw_smp_processor_id();
=20
 	/* release spinlock first - it's not involved in the NMI issue */
 	spin_unlock(&global_path_lock);
=20
-	cpu_id =3D ipipe_processor_id();
-	tp =3D &trace_paths[cpu_id][active_path[cpu_id]];
+	tp =3D &trace_paths[cpuid][active_path[cpuid]];
=20
 	tp->flags &=3D ~IPIPE_TFLG_NMI_LOCK;
=20
@@ -505,15 +508,15 @@ EXPORT_SYMBOL(ipipe_trace_pid);
=20
 int ipipe_trace_max_reset(void)
 {
-	int cpu_id;
 	unsigned long flags;
 	struct ipipe_trace_path *path;
+	int cpuid;
 	int ret =3D 0;
=20
 	flags =3D __ipipe_global_path_lock();
=20
-	for_each_online_cpu(cpu_id) {
-		path =3D &trace_paths[cpu_id][max_path[cpu_id]];
+	for_each_online_cpu(cpuid) {
+		path =3D &trace_paths[cpuid][max_path[cpuid]];
=20
 		if (path->dump_lock) {
 			ret =3D -EBUSY;
@@ -534,15 +537,15 @@ EXPORT_SYMBOL(ipipe_trace_max_reset);
=20
 int ipipe_trace_frozen_reset(void)
 {
-	int cpu_id;
 	unsigned long flags;
 	struct ipipe_trace_path *path;
+	int cpuid;
 	int ret =3D 0;
=20
 	flags =3D __ipipe_global_path_lock();
=20
-	for_each_online_cpu(cpu_id) {
-		path =3D &trace_paths[cpu_id][frozen_path[cpu_id]];
+	for_each_online_cpu(cpuid) {
+		path =3D &trace_paths[cpuid][frozen_path[cpuid]];
=20
 		if (path->dump_lock) {
 			ret =3D -EBUSY;
@@ -564,7 +567,7 @@ EXPORT_SYMBOL(ipipe_trace_frozen_reset);
 void ipipe_trace_panic_freeze(void)
 {
 	unsigned long flags;
-	int cpu_id;
+	int cpuid;
=20
 	if (!ipipe_trace_enable)
 		return;
@@ -572,9 +575,9 @@ void ipipe_trace_panic_freeze(void)
 	ipipe_trace_enable =3D 0;
 	local_irq_save_hw_notrace(flags);
=20
-	cpu_id =3D ipipe_processor_id();
+	cpuid =3D raw_smp_processor_id();
=20
-	panic_path =3D &trace_paths[cpu_id][active_path[cpu_id]];
+	panic_path =3D &trace_paths[cpuid][active_path[cpuid]];
=20
 	local_irq_restore_hw(flags);
 }
Index: linux-2.6.20/include/linux/smp.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20.orig/include/linux/smp.h
+++ linux-2.6.20/include/linux/smp.h
@@ -109,8 +109,6 @@ static inline int smp_call_function_sing
=20
 #endif /* !SMP */
=20
-#include <linux/ipipe_base.h>
-
 /*
  * smp_processor_id(): get the current CPU ID.
  *
@@ -130,11 +128,7 @@ static inline int smp_call_function_sing
   extern unsigned int debug_smp_processor_id(void);
 # define smp_processor_id() debug_smp_processor_id()
 #else
-# define smp_processor_id()				\
-	({						\
-		ipipe_check_context(ipipe_root_domain);	\
-		raw_smp_processor_id();			\
-	})
+# define smp_processor_id() raw_smp_processor_id()
 #endif
=20
 #define get_cpu()		({ preempt_disable(); smp_processor_id(); })
Index: linux-2.6.20/lib/smp_processor_id.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20.orig/lib/smp_processor_id.c
+++ linux-2.6.20/lib/smp_processor_id.c
@@ -13,7 +13,22 @@ unsigned int debug_smp_processor_id(void
 	int this_cpu =3D raw_smp_processor_id();
 	cpumask_t this_mask;
=20
-	ipipe_check_context(ipipe_root_domain);
+#ifdef CONFIG_IPIPE
+	if (irqs_disabled_hw())
+		goto out;
+
+	if (unlikely(!ipipe_root_domain_p && !ipipe_test_pipeline())) {
+		ipipe_trace_panic_freeze();
+		printk(KERN_ERR "BUG: using smp_processor_id() in non-atomic "
+			"context. I-pipe domain: %s\n",
+			ipipe_current_domain->name);
+		print_symbol("caller is %s\n",
+			(long)__builtin_return_address(0));
+		dump_stack();
+		ipipe_trace_panic_dump();
+		goto out;
+	}
+#endif /* CONFIG_IPIPE */
=20
 	if (likely(preempt_count))
 		goto out;
Index: linux-2.6.20/kernel/ipipe/Kconfig.debug
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20.orig/kernel/ipipe/Kconfig.debug
+++ linux-2.6.20/kernel/ipipe/Kconfig.debug
@@ -2,9 +2,15 @@ config IPIPE_DEBUG
 	bool "I-pipe debugging"
 	depends on IPIPE
=20
+if IPIPE_DEBUG
+
+comment "HINT: Switch on DEBUG_PREEMPT in order to detect broken"
+	depends on !DEBUG_PREEMPT
+comment "usages of smp_processor_id() also over non-root domains."
+	depends on !DEBUG_PREEMPT
+
 config IPIPE_DEBUG_CONTEXT
 	bool "Check for illicit cross-domain calls"
-	depends on IPIPE_DEBUG
 	default y
 	---help---
 	  Enable this feature to arm checkpoints in the kernel that
@@ -14,7 +20,6 @@ config IPIPE_DEBUG_CONTEXT
=20
 config IPIPE_TRACE
 	bool "Latency tracing"
-	depends on IPIPE_DEBUG
 	select FRAME_POINTER
 	select KALLSYMS
 	select PROC_FS
@@ -78,3 +83,5 @@ config IPIPE_TRACE_ENABLE_VALUE
 	int
 	default 0 if !IPIPE_TRACE_ENABLE
 	default 1 if IPIPE_TRACE_ENABLE
+
+endif

--------------090007090001080403030003
Content-Type: text/x-patch;
 name="remove-ipipe_processor_id-i386.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="remove-ipipe_processor_id-i386.patch"

---
 arch/i386/kernel/ipipe.c                 |    2 +-
 arch/i386/kernel/nmi.c                   |    2 +-
 arch/i386/kernel/process.c               |    2 +-
 arch/i386/kernel/traps.c                 |    6 +-----
 include/asm-i386/desc.h                  |    2 +-
 include/asm-i386/ipipe.h                 |    2 --
 include/asm-i386/mach-bigsmp/mach_ipi.h  |    2 +-
 include/asm-i386/mach-default/mach_ipi.h |    2 +-
 include/asm-i386/mach-es7000/mach_apic.h |    2 +-
 include/asm-i386/mach-es7000/mach_ipi.h  |    2 +-
 include/asm-i386/mach-numaq/mach_ipi.h   |    2 +-
 include/asm-i386/mach-summit/mach_ipi.h  |    2 +-
 include/asm-i386/mmu_context.h           |    4 ++--
 include/asm-i386/processor.h             |    2 +-
 14 files changed, 14 insertions(+), 20 deletions(-)

Index: linux-2.6.20/arch/i386/kernel/ipipe.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20.orig/arch/i386/kernel/ipipe.c
+++ linux-2.6.20/arch/i386/kernel/ipipe.c
@@ -834,7 +834,7 @@ finalize:
 	 * current domain in the pipeline.
 	 */
=20
-	__ipipe_walk_pipeline(head, cpuid);
+	__ipipe_walk_pipeline(head);
=20
 	ipipe_load_cpuid();
=20
Index: linux-2.6.20/include/asm-i386/ipipe.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20.orig/include/asm-i386/ipipe.h
+++ linux-2.6.20/include/asm-i386/ipipe.h
@@ -86,8 +86,6 @@
 #include <linux/threads.h>
 #include <asm/ptrace.h>
=20
-#define ipipe_processor_id()   raw_smp_processor_id()
-
 #define prepare_arch_switch(next)		\
 do {						\
 	ipipe_schedule_notify(current, next);	\
Index: linux-2.6.20/arch/i386/kernel/nmi.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20.orig/arch/i386/kernel/nmi.c
+++ linux-2.6.20/arch/i386/kernel/nmi.c
@@ -896,7 +896,7 @@ static __kprobes int default_nmi_watchdo
 	 */
 	unsigned int sum;
 	int touched =3D 0;
-	int cpu =3D smp_processor_id_hw();
+	int cpu =3D smp_processor_id();
 	struct nmi_watchdog_ctlblk *wd =3D &__get_cpu_var(nmi_watchdog_ctlblk);=

 	u64 dummy;
 	int rc=3D0;
Index: linux-2.6.20/arch/i386/kernel/process.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20.orig/arch/i386/kernel/process.c
+++ linux-2.6.20/arch/i386/kernel/process.c
@@ -636,7 +636,7 @@ struct task_struct fastcall * __switch_t
 {
 	struct thread_struct *prev =3D &prev_p->thread,
 				 *next =3D &next_p->thread;
-	int cpu =3D raw_smp_processor_id();
+	int cpu =3D smp_processor_id();
 	struct tss_struct *tss =3D &per_cpu(init_tss, cpu);
=20
 	/* never put a printk in __switch_to... printk() calls wake_up*() indir=
ectly */
Index: linux-2.6.20/arch/i386/kernel/traps.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20.orig/arch/i386/kernel/traps.c
+++ linux-2.6.20/arch/i386/kernel/traps.c
@@ -725,7 +725,7 @@ static __kprobes void default_do_nmi(str
 	unsigned char reason =3D 0;
=20
 	/* Only the BSP gets external NMIs from the system.  */
-	if (!smp_processor_id_hw())
+	if (!smp_processor_id())
 		reason =3D get_nmi_reason();
 =20
 	if (!(reason & 0xc0)) {
@@ -764,11 +764,7 @@ fastcall __kprobes void do_nmi(struct pt
=20
 	nmi_enter();
=20
-#ifdef CONFIG_IPIPE
-	cpu =3D ipipe_processor_id();
-#else /* !CONFIG_IPIPE */
 	cpu =3D smp_processor_id();
-#endif /* !CONFIG_IPIPE */
=20
 	++nmi_count(cpu);
=20
Index: linux-2.6.20/include/asm-i386/mach-bigsmp/mach_ipi.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20.orig/include/asm-i386/mach-bigsmp/mach_ipi.h
+++ linux-2.6.20/include/asm-i386/mach-bigsmp/mach_ipi.h
@@ -11,7 +11,7 @@ static inline void send_IPI_mask(cpumask
 static inline void send_IPI_allbutself(int vector)
 {
 	cpumask_t mask =3D cpu_online_map;
-	cpu_clear(smp_processor_id_hw(), mask);
+	cpu_clear(smp_processor_id(), mask);
=20
 	if (!cpus_empty(mask))
 		send_IPI_mask(mask, vector);
Index: linux-2.6.20/include/asm-i386/mach-default/mach_ipi.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20.orig/include/asm-i386/mach-default/mach_ipi.h
+++ linux-2.6.20/include/asm-i386/mach-default/mach_ipi.h
@@ -19,7 +19,7 @@ static inline void __local_send_IPI_allb
 	if (no_broadcast || vector =3D=3D NMI_VECTOR) {
 		cpumask_t mask =3D cpu_online_map;
=20
-		cpu_clear(smp_processor_id_hw(), mask);
+		cpu_clear(smp_processor_id(), mask);
 		send_IPI_mask(mask, vector);
 	} else
 		__send_IPI_shortcut(APIC_DEST_ALLBUT, vector);
Index: linux-2.6.20/include/asm-i386/mach-es7000/mach_apic.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20.orig/include/asm-i386/mach-es7000/mach_apic.h
+++ linux-2.6.20/include/asm-i386/mach-es7000/mach_apic.h
@@ -16,7 +16,7 @@ static inline cpumask_t target_cpus(void
 #if defined CONFIG_ES7000_CLUSTERED_APIC
 	return CPU_MASK_ALL;
 #else
-	return cpumask_of_cpu(smp_processor_id_hw());
+	return cpumask_of_cpu(smp_processor_id());
 #endif
 }
 #define TARGET_CPUS	(target_cpus())
Index: linux-2.6.20/include/asm-i386/mach-es7000/mach_ipi.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20.orig/include/asm-i386/mach-es7000/mach_ipi.h
+++ linux-2.6.20/include/asm-i386/mach-es7000/mach_ipi.h
@@ -11,7 +11,7 @@ static inline void send_IPI_mask(cpumask
 static inline void send_IPI_allbutself(int vector)
 {
 	cpumask_t mask =3D cpu_online_map;
-	cpu_clear(smp_processor_id_hw(), mask);
+	cpu_clear(smp_processor_id(), mask);
 	if (!cpus_empty(mask))
 		send_IPI_mask(mask, vector);
 }
Index: linux-2.6.20/include/asm-i386/mach-numaq/mach_ipi.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20.orig/include/asm-i386/mach-numaq/mach_ipi.h
+++ linux-2.6.20/include/asm-i386/mach-numaq/mach_ipi.h
@@ -11,7 +11,7 @@ static inline void send_IPI_mask(cpumask
 static inline void send_IPI_allbutself(int vector)
 {
 	cpumask_t mask =3D cpu_online_map;
-	cpu_clear(smp_processor_id_hw(), mask);
+	cpu_clear(smp_processor_id(), mask);
=20
 	if (!cpus_empty(mask))
 		send_IPI_mask(mask, vector);
Index: linux-2.6.20/include/asm-i386/mach-summit/mach_ipi.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20.orig/include/asm-i386/mach-summit/mach_ipi.h
+++ linux-2.6.20/include/asm-i386/mach-summit/mach_ipi.h
@@ -11,7 +11,7 @@ static inline void send_IPI_mask(cpumask
 static inline void send_IPI_allbutself(int vector)
 {
 	cpumask_t mask =3D cpu_online_map;
-	cpu_clear(smp_processor_id_hw(), mask);
+	cpu_clear(smp_processor_id(), mask);
=20
 	if (!cpus_empty(mask))
 		send_IPI_mask(mask, vector);
Index: linux-2.6.20/include/asm-i386/mmu_context.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20.orig/include/asm-i386/mmu_context.h
+++ linux-2.6.20/include/asm-i386/mmu_context.h
@@ -16,7 +16,7 @@ void destroy_context(struct mm_struct *m
 static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_stru=
ct *tsk)
 {
 #ifdef CONFIG_SMP
-	unsigned cpu =3D smp_processor_id_hw();
+	unsigned cpu =3D smp_processor_id();
 	if (per_cpu(cpu_tlbstate, cpu).state =3D=3D TLBSTATE_OK)
 		per_cpu(cpu_tlbstate, cpu).state =3D TLBSTATE_LAZY;
 #endif
@@ -26,7 +26,7 @@ static inline void switch_mm(struct mm_s
 			     struct mm_struct *next,
 			     struct task_struct *tsk)
 {
-	int cpu =3D smp_processor_id_hw();
+	int cpu =3D smp_processor_id();
=20
 	if (likely(prev !=3D next)) {
 		/* stop flush ipis for the previous mm */
Index: linux-2.6.20/include/asm-i386/desc.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20.orig/include/asm-i386/desc.h
+++ linux-2.6.20/include/asm-i386/desc.h
@@ -101,7 +101,7 @@ static inline fastcall void native_set_l
 	if (likely(entries =3D=3D 0))
 		__asm__ __volatile__("lldt %w0"::"q" (0));
 	else {
-		unsigned cpu =3D smp_processor_id_hw();
+		unsigned cpu =3D smp_processor_id();
 		__u32 a, b;
=20
 		pack_descriptor(&a, &b, (unsigned long)addr,
Index: linux-2.6.20/include/asm-i386/processor.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20.orig/include/asm-i386/processor.h
+++ linux-2.6.20/include/asm-i386/processor.h
@@ -104,7 +104,7 @@ DECLARE_PER_CPU(struct tss_struct, init_
=20
 #ifdef CONFIG_SMP
 extern struct cpuinfo_x86 cpu_data[];
-#define current_cpu_data cpu_data[smp_processor_id_hw()]
+#define current_cpu_data cpu_data[smp_processor_id()]
 #else
 #define cpu_data (&boot_cpu_data)
 #define current_cpu_data boot_cpu_data

--------------090007090001080403030003
Content-Type: text/x-patch;
 name="xeno-kill-ipipe_processor_id.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="xeno-kill-ipipe_processor_id.patch"

---
 include/asm-generic/hal.h    |   18 ++++++++++++------
 include/asm-generic/system.h |    5 +++++
 include/asm-sim/system.h     |    1 +
 include/nucleus/pod.h        |   15 +++++++++------
 ksrc/nucleus/shadow.c        |   14 ++++++--------
 ksrc/nucleus/timer.c         |    3 ++-
 6 files changed, 35 insertions(+), 21 deletions(-)

Index: xenomai/include/asm-generic/hal.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/asm-generic/hal.h
+++ xenomai/include/asm-generic/hal.h
@@ -151,7 +151,7 @@ typedef rwlock_t rthal_rwlock_t;
 #define rthal_declare_cpuid		ipipe_declare_cpuid
=20
 #define rthal_load_cpuid()		ipipe_load_cpuid()
-#define rthal_suspend_domain()	ipipe_suspend_domain()
+#define rthal_suspend_domain()		ipipe_suspend_domain()
 #define rthal_grab_superlock(syncfn)	ipipe_critical_enter(syncfn)
 #define rthal_release_superlock(x)	ipipe_critical_exit(x)
 #define rthal_propagate_irq(irq)	ipipe_propagate_irq(irq)
@@ -160,10 +160,10 @@ typedef rwlock_t rthal_rwlock_t;
 #define rthal_virtualize_irq(dom,irq,isr,cookie,ackfn,mode) ipipe_virtua=
lize_irq(dom,irq,isr,cookie,ackfn,mode)
 #define rthal_alloc_virq()		ipipe_alloc_virq()
 #define rthal_free_virq(irq)		ipipe_free_virq(irq)
-#define rthal_trigger_irq(irq)	ipipe_trigger_irq(irq)
-#define rthal_get_sysinfo(ibuf)	ipipe_get_sysinfo(ibuf)
+#define rthal_trigger_irq(irq)		ipipe_trigger_irq(irq)
+#define rthal_get_sysinfo(ibuf)		ipipe_get_sysinfo(ibuf)
 #define rthal_alloc_ptdkey()		ipipe_alloc_ptdkey()
-#define rthal_free_ptdkey(key)	ipipe_free_ptdkey(key)
+#define rthal_free_ptdkey(key)		ipipe_free_ptdkey(key)
 #define rthal_send_ipi(irq,cpus)	ipipe_send_ipi(irq,cpus)
 #define rthal_lock_irq(dom,cpu,irq)	__ipipe_lock_irq(dom,cpu,irq)
 #define rthal_unlock_irq(dom,irq)	__ipipe_unlock_irq(dom,irq)
@@ -174,12 +174,18 @@ typedef rwlock_t rthal_rwlock_t;
 #define rthal_unlock_cpu(x)		ipipe_unlock_cpu(x)
 #define rthal_get_cpu(x)		ipipe_get_cpu(x)
 #define rthal_put_cpu(x)		ipipe_put_cpu(x)
+#ifdef ipipe_processor_id
 #define rthal_processor_id()		ipipe_processor_id()
+#define rthal_raw_processor_id()	ipipe_processor_id()
+#else
+#define rthal_processor_id()		smp_processor_id()
+#define rthal_raw_processor_id()	raw_smp_processor_id()
+#endif
=20
 #define rthal_setsched_root(t,pol,prio)	ipipe_setscheduler_root(t,pol,pr=
io)
 #define rthal_reenter_root(t,pol,prio)	ipipe_reenter_root(t,pol,prio)
-#define rthal_emergency_console()		ipipe_set_printk_sync(ipipe_current_d=
omain)
-#define rthal_read_tsc(v)			ipipe_read_tsc(v)
+#define rthal_emergency_console()	ipipe_set_printk_sync(ipipe_current_do=
main)
+#define rthal_read_tsc(v)		ipipe_read_tsc(v)
=20
 static inline unsigned long rthal_get_cpufreq(void)
 {
Index: xenomai/include/asm-generic/system.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/asm-generic/system.h
+++ xenomai/include/asm-generic/system.h
@@ -205,6 +205,11 @@ static inline unsigned xnarch_current_cp
     return rthal_processor_id();
 }
=20
+static inline unsigned xnarch_raw_current_cpu(void)
+{
+    return rthal_raw_processor_id();
+}
+
 #define xnarch_declare_cpuid  rthal_declare_cpuid
 #define xnarch_get_cpu(flags) rthal_get_cpu(flags)
 #define xnarch_put_cpu(flags) rthal_put_cpu(flags)
Index: xenomai/include/asm-sim/system.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/asm-sim/system.h
+++ xenomai/include/asm-sim/system.h
@@ -420,6 +420,7 @@ static inline void xnarch_sysfree (void=20
 }
=20
 #define xnarch_current_cpu()  0
+#define xnarch_raw_current_cpu() 0
 #define xnarch_declare_cpuid  const int cpuid =3D 0
 #define xnarch_get_cpu(x)     do  { (x) =3D (x); } while(0)
 #define xnarch_put_cpu(x)     do { } while(0)
Index: xenomai/include/nucleus/pod.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/nucleus/pod.h
+++ xenomai/include/nucleus/pod.h
@@ -153,7 +153,7 @@ typedef struct xnsched {
 #endif /* CONFIG_SMP */
=20
 #define xnsched_resched_mask() \
-    (xnpod_current_sched()->resched)
+    (xnpod_raw_current_sched()->resched)
=20
 #define xnsched_resched_p()                     \
     (!xnarch_cpus_empty(xnsched_resched_mask()))
@@ -261,17 +261,20 @@ static inline void xnpod_reset_watchdog(
 #define xnpod_current_sched() \
     xnpod_sched_slot(xnarch_current_cpu())
=20
+#define xnpod_raw_current_sched() \
+    xnpod_sched_slot(xnarch_raw_current_cpu())
+
 #define xnpod_interrupt_p() \
-    (xnpod_current_sched()->inesting > 0)
+    (xnpod_raw_current_sched()->inesting > 0)
=20
 #define xnpod_callout_p() \
-    (!!testbits(xnpod_current_sched()->status,XNKCOUT))
+    (!!testbits(xnpod_raw_current_sched()->status,XNKCOUT))
=20
 #define xnpod_asynch_p() \
     (xnpod_interrupt_p() || xnpod_callout_p())
=20
 #define xnpod_current_thread() \
-    (xnpod_current_sched()->runthread)
+    (xnpod_raw_current_sched()->runthread)
=20
 #define xnpod_current_root() \
     (&xnpod_current_sched()->rootcb)
@@ -412,7 +415,7 @@ void xnpod_dispatch_signals(void);
=20
 static inline void xnpod_lock_sched(void)
 {
-	xnthread_t *runthread =3D xnpod_current_sched()->runthread;
+	xnthread_t *runthread =3D xnpod_current_thread();
 	spl_t s;
=20
 	xnlock_get_irqsave(&nklock, s);
@@ -425,7 +428,7 @@ static inline void xnpod_lock_sched(void
=20
 static inline void xnpod_unlock_sched(void)
 {
-	xnthread_t *runthread =3D xnpod_current_sched()->runthread;
+	xnthread_t *runthread =3D xnpod_current_thread();
 	spl_t s;
=20
 	xnlock_get_irqsave(&nklock, s);
Index: xenomai/ksrc/nucleus/timer.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/nucleus/timer.c
+++ xenomai/ksrc/nucleus/timer.c
@@ -532,7 +532,8 @@ void xntimer_init(xntimer_t *timer, xntb
 	timer->status =3D XNTIMER_DEQUEUED;
 	timer->handler =3D handler;
 	timer->interval =3D 0;
-	timer->sched =3D xnpod_current_sched();
+	/*FIXME: Do we care about the correct initial sched or not? */
+	timer->sched =3D xnpod_raw_current_sched();
=20
 	xnarch_init_display_context(timer);
 }
Index: xenomai/ksrc/nucleus/shadow.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/nucleus/shadow.c
+++ xenomai/ksrc/nucleus/shadow.c
@@ -201,7 +201,7 @@ static void rpi_push(xnthread_t *thread)
 	int prio;
 	spl_t s;
=20
-	gk =3D &gatekeeper[rthal_processor_id()];
+	gk =3D &gatekeeper[smp_processor_id()];
=20
 	/* non-RT shadows and RT shadows which disabled RPI cause the
 	   root priority to be lowered to its base level. The purpose
@@ -235,7 +235,7 @@ static void rpi_pop(xnthread_t *thread)
 	int prio;
 	spl_t s;
=20
-	gk =3D &gatekeeper[rthal_processor_id()];
+	gk =3D &gatekeeper[smp_processor_id()];
=20
 	xnlock_get_irqsave(&rpilock, s);
=20
@@ -300,7 +300,7 @@ static inline void rpi_update(xnthread_t
=20
 	if (sched_emptypq_p(&thread->rpi->threadq)) {
 		int rcpu =3D container_of(thread->rpi, struct __gatekeeper, rpislot) -=
 gatekeeper;
-		if (rcpu !=3D rthal_processor_id()) {
+		if (rcpu !=3D smp_processor_id()) {
 			xnsched_t *rsched =3D xnpod_sched_slot(rcpu);
 			if (!testbits(rsched->status, XNRPICK)) {
 				xnarch_cpumask_t cpumask;
@@ -327,7 +327,7 @@ static inline void rpi_switch(struct tas
=20
 	threadout =3D xnshadow_thread(current);
 	threadin =3D xnshadow_thread(next);
-	gk =3D &gatekeeper[rthal_processor_id()];
+	gk =3D &gatekeeper[smp_processor_id()];
 	oldprio =3D xnthread_current_priority(xnpod_current_root());
=20
 	if (threadout &&
@@ -421,7 +421,7 @@ void xnshadow_rpi_check(void)
 	struct __gatekeeper *gk;
 	spl_t s;
=20
-	gk =3D &gatekeeper[rthal_processor_id()];
+	gk =3D &gatekeeper[smp_processor_id()];
=20
 	xnlock_get_irqsave(&rpilock, s);
=20
@@ -848,9 +848,7 @@ static void lostage_handler(void *cookie
=20
 static void schedule_linux_call(int type, struct task_struct *p, int arg=
)
 {
-	/* Do _not_ use smp_processor_id() here so we don't trigger Linux
-	   preemption debug traps inadvertently (see lib/smp_processor_id.c). *=
/
-	int cpuid =3D rthal_processor_id(), reqnum;
+	int cpuid =3D smp_processor_id(), reqnum;
 	struct __lostagerq *rq =3D &lostagerq[cpuid];
 	spl_t s;
=20

--------------090007090001080403030003--

--------------enigB7296F14ECBB12020D5AA092
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFGR2bmniDOoMHTA+kRAh9sAKCBwi4IeDAj6Fr6KnyEsumJTd324QCggm56
xHST40/XDg79kueAav5Rx2s=
=a7uJ
-----END PGP SIGNATURE-----

--------------enigB7296F14ECBB12020D5AA092--

