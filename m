MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="5UZdiMnAhH"
Content-Transfer-Encoding: 7bit
Message-ID: <17470.21416.517240.286135@domain.hid>
Date: Thu, 13 Apr 2006 15:35:36 +0200
Subject: Re: [Xenomai-core] latency -t 1 crashes on SMP.
In-Reply-To: <4439233D.4050800@domain.hid>
References: <17465.8101.106079.634470@domain.hid>
	<4439233D.4050800@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
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
Cc: xenomai@xenomai.org


--5UZdiMnAhH
Content-Type: text/plain; charset=us-ascii
Content-Description: message body and .signature
Content-Transfer-Encoding: 7bit

Jan Kiszka wrote:
 > o instrument the xenomai exception handler with an ipipe_trace_freeze()
 >   (something which should be merged into SVN later)

The I-pipe tracer as well as Linux NMI handling have the same issue
which is the cause for the exceptions 14: they rely on a correct
"current" to read the processor id. The first attached patch, to be
applied after the ipipe patch, add an ipipe_processor_id_notrace
function, which is called instead of raw_smp_processor_id() in the
second, I-pipe tracer, attached patch.

-- 


					    Gilles Chanteperdrix.

--5UZdiMnAhH
Content-Type: text/plain
Content-Disposition: inline;
	filename="notrace-processor-id.patch"
Content-Transfer-Encoding: 7bit

--- linux/arch/i386/kernel/ipipe-root.c~	2006-04-13 15:21:05.000000000 +0200
+++ linux/arch/i386/kernel/ipipe-root.c	2006-04-13 14:55:29.000000000 +0200
@@ -107,6 +107,30 @@ int (*__ipipe_logical_cpuid)(void) = &__
 
 EXPORT_SYMBOL(__ipipe_logical_cpuid);
 
+#ifdef CONFIG_IPIPE_TRACE
+
+static notrace int __ipipe_boot_cpuid_notrace(void)
+{
+        return 0;
+}
+
+static notrace int __ipipe_hard_cpuid_notrace(void)
+{
+	unsigned long flags;
+	int cpu;
+
+	local_irq_save_hw_notrace(flags);
+	cpu = __ipipe_apicid_2_cpu[GET_APIC_ID(apic_read(APIC_ID))];
+	local_irq_restore_hw_notrace(flags);
+	return cpu;
+}
+
+int (*__ipipe_logical_cpuid_notrace)(void) = &__ipipe_boot_cpuid_notrace;
+
+EXPORT_SYMBOL(__ipipe_logical_cpuid_notrace);
+
+#endif
+
 #endif /* CONFIG_SMP */
 
 #endif	/* CONFIG_X86_LOCAL_APIC */
@@ -223,6 +247,10 @@ void __init __ipipe_enable_pipeline(void
 	 * trap_init(), so it's safe to use it. */
 
 	__ipipe_logical_cpuid = &__ipipe_hard_cpuid;
+#ifdef CONFIG_IPIPE_TRACE
+        __ipipe_logical_cpuid_notrace = &__ipipe_hard_cpuid_notrace;
+#endif
+
 
 #endif	/* CONFIG_SMP */
 
--- linux/include/asm-i386/ipipe.h~	2006-04-13 15:21:34.000000000 +0200
+++ linux/include/asm-i386/ipipe.h	2006-04-13 14:49:03.000000000 +0200
@@ -103,6 +103,15 @@ static inline int ipipe_processor_id(voi
 	return __ipipe_logical_cpuid();
 }
 
+#ifdef CONFIG_IPIPE_TRACE
+static notrace inline int ipipe_processor_id_notrace(void)
+{
+	extern int (*__ipipe_logical_cpuid_notrace)(void);
+	return __ipipe_logical_cpuid_notrace();
+}
+
+#endif
+
 extern u8 __ipipe_apicid_2_cpu[];
 
 #define ipipe_note_apicid(apicid,cpu)  \

--5UZdiMnAhH
Content-Type: text/plain
Content-Disposition: inline; filename="ipipe-tracer-2.6.16-i386-1.2-02.patch"
Content-Transfer-Encoding: 7bit

--- common/kernel/ipipe/Kconfig
+++ /home/rpm/gna/adeos/ipipe/v2.6/common/kernel/ipipe/Kconfig.trace	2006-01-09 03:41:35.000000000 +0100
@@ -13,3 +13,24 @@ config IPIPE_STATS
 	  Activate this option if you want runtime statistics to be collected
 	  while the I-pipe is operating. This option adds a small overhead, but
 	  is useful to detect unexpected latency spots.
+
+config IPIPE_TRACE
+ 	bool "Latency Tracing"
+	depends on IPIPE && PROC_FS
+	select FRAME_POINTER
+	default n
+	---help---
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
--- 2.6.16/Makefile	2006-03-20 06:53:29.000000000 +0100
+++ 2.6.16-ipipe/Makefile	2006-03-21 14:52:40.000000000 +0100
@@ -511,11 +511,15 @@ CFLAGS		+= $(call add-align,CONFIG_CC_AL
 CFLAGS		+= $(call add-align,CONFIG_CC_ALIGN_LOOPS,-loops)
 CFLAGS		+= $(call add-align,CONFIG_CC_ALIGN_JUMPS,-jumps)
 
+ifdef CONFIG_IPIPE_TRACE
+CFLAGS          += -pg -fno-omit-frame-pointer $(call cc-option,-fno-optimize-sibling-calls,)
+else
 ifdef CONFIG_FRAME_POINTER
 CFLAGS		+= -fno-omit-frame-pointer $(call cc-option,-fno-optimize-sibling-calls,)
 else
 CFLAGS		+= -fomit-frame-pointer
 endif
+endif
 
 ifdef CONFIG_DEBUG_INFO
 CFLAGS		+= -g
--- 2.6.16/include/linux/ipipe_trace.h	1970-01-01 01:00:00.000000000 +0100
+++ 2.6.16-ipipe/include/linux/ipipe_trace.h	2006-01-31 09:06:32.000000000 +0100
@@ -0,0 +1,37 @@
+/* -*- linux-c -*-
+ * include/linux/ipipe_trace.h
+ *
+ * Copyright (C) 2005 Luotao Fu.
+ *               2005 Jan Kiszka.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, Inc., 675 Mass Ave, Cambridge MA 02139,
+ * USA; either version 2 of the License, or (at your option) any later
+ * version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ */
+
+#ifndef _LINUX_IPIPE_TRACE_H
+#define _LINUX_IPIPE_TRACE_H
+
+void ipipe_trace_begin(unsigned long v);
+void ipipe_trace_end(unsigned long v);
+void ipipe_trace_freeze(unsigned long v);
+void ipipe_trace_special(unsigned char special_id, unsigned long v);
+
+int ipipe_trace_max_reset(void);
+int ipipe_trace_frozen_reset(void);
+
+void ipipe_trace_panic_freeze(void);
+void ipipe_trace_panic_dump(void);
+
+#endif	/* !__LINUX_IPIPE_H */
--- 2.6.16/include/linux/linkage.h	2006-03-20 06:53:29.000000000 +0100
+++ 2.6.16-ipipe/include/linux/linkage.h	2006-03-21 14:53:07.000000000 +0100
@@ -51,4 +51,8 @@
 #define fastcall
 #endif
 
+#ifndef notrace
+#define notrace		__attribute__((no_instrument_function))
+#endif
+
 #endif
--- 2.6.16/kernel/ipipe/tracer.c	1970-01-01 01:00:00.000000000 +0100
+++ 2.6.16-ipipe/kernel/ipipe/tracer.c	2006-01-31 09:06:32.000000000 +0100
@@ -0,0 +1,1048 @@
+/* -*- linux-c -*-
+ * kernel/ipipe/tracer.c
+ *
+ * Copyright (C) 2005 Luotao Fu.
+ *               2005 Jan Kiszka.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, Inc., 675 Mass Ave, Cambridge MA 02139,
+ * USA; either version 2 of the License, or (at your option) any later
+ * version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/version.h>
+#include <linux/kallsyms.h>
+#include <linux/seq_file.h>
+#include <linux/proc_fs.h>
+#include <linux/ctype.h>
+#include <linux/ipipe_trace.h>
+#include <asm/uaccess.h>
+
+#define IPIPE_TRACE_PATHS           4
+#define IPIPE_DEFAULT_ACTIVE        0
+#define IPIPE_DEFAULT_MAX           1
+#define IPIPE_DEFAULT_FROZEN        2
+
+#define IPIPE_TRACE_POINTS          16*1024
+#define WRAP_POINT_NO(point)        ((point) & (IPIPE_TRACE_POINTS-1))
+
+#define IPIPE_DEFAULT_PRE_TRACE     10
+#define IPIPE_DEFAULT_POST_TRACE    10
+#define IPIPE_DEFAULT_BACK_TRACE    30
+
+#define IPIPE_DELAY_NOTE            1000  /* in nanoseconds */
+#define IPIPE_DELAY_WARN            10000 /* in nanoseconds */
+
+#define IPIPE_TFLG_NMI_LOCK         0x0001
+#define IPIPE_TFLG_NMI_HIT          0x0002
+#define IPIPE_TFLG_NMI_FREEZE_REQ   0x0004
+
+#define IPIPE_TFLG_HWIRQ_OFF        0x0100
+#define IPIPE_TFLG_FREEZING         0x0200
+
+
+struct ipipe_trace_point{
+	short type;
+	short flags;
+	unsigned long eip;
+	unsigned long parent_eip;
+	unsigned long v;
+	unsigned long long timestamp;
+};
+
+struct ipipe_trace_path{
+	volatile int flags;
+	int dump_lock; /* separated from flags due to cross-cpu access */
+	int trace_pos; /* next point to fill */
+	int begin, end; /* finalised path begin and end */
+	int post_trace; /* non-zero when in post-trace phase */
+	unsigned long long length; /* max path length in cycles */
+	unsigned long nmi_saved_eip; /* for deferred requests from NMIs */
+	unsigned long nmi_saved_parent_eip;
+	unsigned long nmi_saved_v;
+	struct ipipe_trace_point point[IPIPE_TRACE_POINTS];
+} ____cacheline_aligned_in_smp;
+
+enum ipipe_trace_type
+{
+	IPIPE_TRACE_FN = 0,
+	IPIPE_TRACE_BEGIN,
+	IPIPE_TRACE_END,
+	IPIPE_TRACE_FREEZE,
+	IPIPE_TRACE_SPECIAL,
+};
+
+
+int ipipe_trace_enable = 1;
+
+static struct ipipe_trace_path trace_paths[NR_CPUS][IPIPE_TRACE_PATHS] =
+	{ [0 ... NR_CPUS-1] =
+		{ [0 ... IPIPE_TRACE_PATHS-1] =
+			{ .begin = -1, .end = -1 }
+		}
+	};
+static int active_path[NR_CPUS] =
+	{ [0 ... NR_CPUS-1] = IPIPE_DEFAULT_ACTIVE };
+static int max_path[NR_CPUS] =
+	{ [0 ... NR_CPUS-1] = IPIPE_DEFAULT_MAX };
+static int frozen_path[NR_CPUS] =
+	{ [0 ... NR_CPUS-1] = IPIPE_DEFAULT_FROZEN };
+static ipipe_spinlock_t global_path_lock = IPIPE_SPIN_LOCK_UNLOCKED;
+static int pre_trace = IPIPE_DEFAULT_PRE_TRACE;
+static int post_trace = IPIPE_DEFAULT_POST_TRACE;
+static int back_trace = IPIPE_DEFAULT_BACK_TRACE;
+static int verbose_trace = 0;
+
+static DECLARE_MUTEX(out_mutex);
+static struct ipipe_trace_path *print_path;
+static struct ipipe_trace_path *panic_path;
+static int print_pre_trace;
+static int print_post_trace;
+
+
+static long __ipipe_signed_tsc2us(long long tsc);
+static void
+__ipipe_trace_point_type(char *buf, struct ipipe_trace_point *point);
+static void __ipipe_print_symname(struct seq_file *m, unsigned long eip);
+
+
+static notrace int __ipipe_get_free_trace_path(int old, int cpu_id)
+{
+	int new_active = old;
+	struct ipipe_trace_path *tp;
+
+	do {
+		if (++new_active == IPIPE_TRACE_PATHS)
+			new_active = 0;
+		tp = &trace_paths[cpu_id][new_active];
+	} while ((new_active == max_path[cpu_id]) ||
+	         (new_active == frozen_path[cpu_id]) ||
+	         tp->dump_lock);
+
+	return new_active;
+}
+
+static notrace void
+__ipipe_migrate_pre_trace(struct ipipe_trace_path *new_tp,
+                          struct ipipe_trace_path *old_tp, int old_pos)
+{
+	int i;
+
+	new_tp->trace_pos = pre_trace+1;
+
+	for (i = new_tp->trace_pos; i > 0; i--)
+		memcpy(&new_tp->point[WRAP_POINT_NO(new_tp->trace_pos-i)],
+		       &old_tp->point[WRAP_POINT_NO(old_pos-i)],
+		       sizeof(struct ipipe_trace_point));
+
+	/* mark the end (i.e. the point before point[0]) invalid */
+	new_tp->point[IPIPE_TRACE_POINTS-1].eip = 0;
+}
+
+static notrace struct ipipe_trace_path *
+__ipipe_trace_end(int cpu_id, struct ipipe_trace_path *tp, int pos)
+{
+	struct ipipe_trace_path *old_tp = tp;
+	long active = active_path[cpu_id];
+	unsigned long long length;
+
+	/* do we have a new worst case? */
+	length = tp->point[tp->end].timestamp -
+	         tp->point[tp->begin].timestamp;
+	if (length > (trace_paths[cpu_id][max_path[cpu_id]]).length) {
+		/* we need protection here against other cpus trying
+		   to start a proc dump */
+		spin_lock_hw(&global_path_lock);
+
+		/* active path holds new worst case */
+		tp->length = length;
+		max_path[cpu_id] = active;
+
+		/* find next unused trace path */
+		active = __ipipe_get_free_trace_path(active, cpu_id);
+
+		spin_unlock_hw(&global_path_lock);
+
+		tp = &trace_paths[cpu_id][active];
+
+		/* migrate last entries for pre-tracing */
+		__ipipe_migrate_pre_trace(tp, old_tp, pos);
+	}
+
+	return tp;
+}
+
+static notrace struct ipipe_trace_path *
+__ipipe_trace_freeze(int cpu_id, struct ipipe_trace_path *tp, int pos)
+{
+	struct ipipe_trace_path *old_tp = tp;
+	long active = active_path[cpu_id];
+	int i;
+
+	/* frozen paths have no core (begin=end) */
+	tp->begin = tp->end;
+
+	/* we need protection here against other cpus trying
+	 * to set their frozen path or to start a proc dump */
+	spin_lock_hw(&global_path_lock);
+
+	frozen_path[cpu_id] = active;
+
+	/* find next unused trace path */
+	active = __ipipe_get_free_trace_path(active, cpu_id);
+
+	/* check if this is the first frozen path */
+	for_each_online_cpu(i) {
+		if ((i != cpu_id) &&
+		    (trace_paths[i][frozen_path[i]].end >= 0))
+			tp->end = -1;
+	}
+
+	spin_unlock_hw(&global_path_lock);
+
+	tp = &trace_paths[cpu_id][active];
+
+	/* migrate last entries for pre-tracing */
+	__ipipe_migrate_pre_trace(tp, old_tp, pos);
+
+	return tp;
+}
+
+void notrace
+__ipipe_trace(enum ipipe_trace_type type, unsigned long eip,
+              unsigned long parent_eip, unsigned long v)
+{
+	struct ipipe_trace_path *tp, *old_tp;
+	int pos, next_pos, begin;
+	struct ipipe_trace_point *point;
+	unsigned long flags;
+	int cpu_id;
+
+	local_irq_save_hw_notrace(flags);
+
+	cpu_id = ipipe_processor_id_notrace();
+restart:
+	tp = old_tp = &trace_paths[cpu_id][active_path[cpu_id]];
+
+	/* here starts a race window with NMIs - catched below */
+
+	/* check for NMI recursion */
+	if (unlikely(tp->flags & IPIPE_TFLG_NMI_LOCK)) {
+		tp->flags |= IPIPE_TFLG_NMI_HIT;
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
+		return; /* no need for restoring flags inside IRQ */
+	}
+
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
+
+	/* get the point buffer */
+	pos = tp->trace_pos;
+	point = &tp->point[pos];
+
+	/* store all trace point data */
+	point->type = type;
+	point->flags = local_test_iflag_hw(flags) ? 0 : IPIPE_TFLG_HWIRQ_OFF;
+	point->eip = eip;
+	point->parent_eip = parent_eip;
+	point->v = v;
+	ipipe_read_tsc(point->timestamp);
+
+	/* forward to next point buffer */
+	next_pos = WRAP_POINT_NO(pos+1);
+	tp->trace_pos = next_pos;
+
+	/* only mark beginning if we haven't started yet */
+	begin = tp->begin;
+	if (unlikely(type == IPIPE_TRACE_BEGIN) && (begin < 0))
+		tp->begin = pos;
+
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
+	}
+
+	/* enforce end of trace in case of overflow */
+	if (unlikely(WRAP_POINT_NO(next_pos + 1) == begin)) {
+		tp->end = pos;
+		goto enforce_end;
+	}
+
+	/* stop tracing this path if we are in post-trace and
+	 *  a) that phase is over now or
+	 *  b) a new TRACE_BEGIN came in but we are not freezing this path */
+	if (unlikely((tp->post_trace > 0) && ((--tp->post_trace == 0) ||
+	             ((type == IPIPE_TRACE_BEGIN) &&
+	              !(tp->flags & IPIPE_TFLG_FREEZING))))) {
+		/* store the path's end (i.e. excluding post-trace) */
+		tp->end = WRAP_POINT_NO(pos - post_trace + tp->post_trace);
+
+enforce_end:
+		if (tp->flags & IPIPE_TFLG_FREEZING)
+			tp = __ipipe_trace_freeze(cpu_id, tp, pos);
+		else
+			tp = __ipipe_trace_end(cpu_id, tp, pos);
+
+		/* reset the active path, maybe already start a new one */
+		tp->begin = (type == IPIPE_TRACE_BEGIN) ?
+			WRAP_POINT_NO(tp->trace_pos - 1) : -1;
+		tp->end = -1;
+		tp->post_trace = 0;
+		tp->flags = 0;
+
+		/* update active_path not earlier to avoid races with NMIs */
+		active_path[cpu_id] = tp - trace_paths[cpu_id];
+	}
+
+	/* we still have old_tp and point,
+	 * let's reset NMI lock and check for catches */
+	old_tp->flags &= ~IPIPE_TFLG_NMI_LOCK;
+	if (unlikely(old_tp->flags & IPIPE_TFLG_NMI_HIT)) {
+		/* well, this late tagging may not immediately be visible for
+		 * other cpus already dumping this path - a minor issue */
+		point->flags |= IPIPE_TFLG_NMI_HIT;
+
+		/* handle deferred freezing from NMI context */
+		if (old_tp->flags & IPIPE_TFLG_NMI_FREEZE_REQ)
+			__ipipe_trace(IPIPE_TRACE_FREEZE, old_tp->nmi_saved_eip,
+			              old_tp->nmi_saved_parent_eip,
+			              old_tp->nmi_saved_v);
+	}
+
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
+	cpu_id = ipipe_processor_id_notrace();
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
+	cpu_id = ipipe_processor_id_notrace();
+	tp = &trace_paths[cpu_id][active_path[cpu_id]];
+
+	tp->flags &= ~IPIPE_TFLG_NMI_LOCK;
+
+	/* handle deferred freezing from NMI context */
+	if (tp->flags & IPIPE_TFLG_NMI_FREEZE_REQ)
+		__ipipe_trace(IPIPE_TRACE_FREEZE, tp->nmi_saved_eip,
+		              tp->nmi_saved_parent_eip, tp->nmi_saved_v);
+
+	local_irq_restore_hw(flags);
+}
+
+void notrace mcount(void);
+EXPORT_SYMBOL(mcount);
+
+void notrace ipipe_trace_begin(unsigned long v)
+{
+	if (!ipipe_trace_enable)
+		return;
+	__ipipe_trace(IPIPE_TRACE_BEGIN, __BUILTIN_RETURN_ADDRESS0,
+	              __BUILTIN_RETURN_ADDRESS1, v);
+}
+EXPORT_SYMBOL(ipipe_trace_begin);
+
+void notrace ipipe_trace_end(unsigned long v)
+{
+	if (!ipipe_trace_enable)
+		return;
+	__ipipe_trace(IPIPE_TRACE_END, __BUILTIN_RETURN_ADDRESS0,
+	              __BUILTIN_RETURN_ADDRESS1, v);
+}
+EXPORT_SYMBOL(ipipe_trace_end);
+
+void notrace ipipe_trace_freeze(unsigned long v)
+{
+	if (!ipipe_trace_enable)
+		return;
+	__ipipe_trace(IPIPE_TRACE_FREEZE, __BUILTIN_RETURN_ADDRESS0,
+	              __BUILTIN_RETURN_ADDRESS1, v);
+}
+EXPORT_SYMBOL(ipipe_trace_freeze);
+
+void notrace ipipe_trace_special(unsigned char id, unsigned long v)
+{
+	if (!ipipe_trace_enable)
+		return;
+	__ipipe_trace(IPIPE_TRACE_SPECIAL + id, __BUILTIN_RETURN_ADDRESS0,
+	              __BUILTIN_RETURN_ADDRESS1, v);
+}
+EXPORT_SYMBOL(ipipe_trace_special);
+
+int ipipe_trace_max_reset(void)
+{
+	int cpu_id;
+	unsigned long flags;
+	struct ipipe_trace_path *path;
+	int ret = 0;
+
+	flags = __ipipe_global_path_lock();
+
+	for_each_cpu(cpu_id) {
+		path = &trace_paths[cpu_id][max_path[cpu_id]];
+
+		if (path->dump_lock) {
+			ret = -EBUSY;
+			break;
+		}
+
+		path->begin     = -1;
+		path->end       = -1;
+		path->trace_pos = 0;
+		path->length    = 0;
+	}
+
+	__ipipe_global_path_unlock(flags);
+
+	return ret;
+}
+EXPORT_SYMBOL(ipipe_trace_max_reset);
+
+int ipipe_trace_frozen_reset(void)
+{
+	int cpu_id;
+	unsigned long flags;
+	struct ipipe_trace_path *path;
+	int ret = 0;
+
+	flags = __ipipe_global_path_lock();
+
+	for_each_cpu(cpu_id) {
+		path = &trace_paths[cpu_id][frozen_path[cpu_id]];
+
+		if (path->dump_lock) {
+			ret = -EBUSY;
+			break;
+		}
+
+		path->begin = -1;
+		path->end = -1;
+		path->trace_pos = 0;
+		path->length    = 0;
+	}
+
+	__ipipe_global_path_unlock(flags);
+
+	return ret;
+}
+EXPORT_SYMBOL(ipipe_trace_frozen_reset);
+
+void ipipe_trace_panic_freeze(void)
+{
+	unsigned long flags;
+	int cpu_id;
+
+	ipipe_trace_enable = 0;
+	local_irq_save_hw_notrace(flags);
+
+	cpu_id = ipipe_processor_id_notrace();
+
+	panic_path = &trace_paths[cpu_id][active_path[cpu_id]];
+
+	local_irq_restore_hw(flags);
+}
+EXPORT_SYMBOL(ipipe_trace_panic_freeze);
+
+void ipipe_trace_panic_dump(void)
+{
+	int cnt = back_trace;
+	int start, pos;
+
+	printk("I-pipe tracer log (%d points):\n", cnt);
+
+	start = pos = WRAP_POINT_NO(panic_path->trace_pos-1);
+
+	while (cnt-- > 0) {
+		struct ipipe_trace_point *point = &panic_path->point[pos];
+		long time;
+		char buf[16];
+
+		if (!point->eip)
+			printk("-<invalid>-\n");
+		else {
+			__ipipe_trace_point_type(buf, point);
+			printk(buf);
+
+			if (point->type != IPIPE_TRACE_FN)
+				printk("0x%08lx ", point->v);
+			else
+				printk("           ");
+
+			time = __ipipe_signed_tsc2us(point->timestamp -
+				panic_path->point[start].timestamp);
+			printk(" %5ld ", time);
+
+			__ipipe_print_symname(NULL, point->eip);
+			printk(" (");
+			__ipipe_print_symname(NULL, point->parent_eip);
+			printk(")\n");
+		}
+		pos = WRAP_POINT_NO(pos - 1);
+	}
+}
+EXPORT_SYMBOL(ipipe_trace_panic_dump);
+
+
+/* --- /proc output --- */
+
+static notrace int __ipipe_in_critical_trpath(long point_no)
+{
+	return ((WRAP_POINT_NO(point_no-print_path->begin) <
+	         WRAP_POINT_NO(print_path->end-print_path->begin)) ||
+	        ((print_path->end == print_path->begin) &&
+	         (WRAP_POINT_NO(point_no-print_path->end) >
+	          print_post_trace)));
+}
+
+static long __ipipe_signed_tsc2us(long long tsc)
+{
+        unsigned long long abs_tsc;
+        long us;
+
+	/* ipipe_tsc2us works on unsigned => handle sign separately */
+        abs_tsc = (tsc >= 0) ? tsc : -tsc;
+        us = ipipe_tsc2us(abs_tsc);
+        if (tsc < 0)
+                return -us;
+        else
+                return us;
+}
+
+static void
+__ipipe_trace_point_type(char *buf, struct ipipe_trace_point *point)
+{
+	switch (point->type) {
+		case IPIPE_TRACE_FN:
+			strcpy(buf, "fn     ");
+			break;
+
+		case IPIPE_TRACE_BEGIN:
+			strcpy(buf, "begin  ");
+			break;
+
+		case IPIPE_TRACE_END:
+			strcpy(buf, "end    ");
+			break;
+
+		case IPIPE_TRACE_FREEZE:
+			strcpy(buf, "freeze ");
+			break;
+
+		default: /* IPIPE_TRACE_SPECIAL */
+			sprintf(buf, "(0x%02x) ",
+			        point->type - IPIPE_TRACE_SPECIAL);
+	}
+}
+
+static void
+__ipipe_print_pathmark(struct seq_file *m, struct ipipe_trace_point *point)
+{
+	char mark = ' ';
+	int point_no = point - print_path->point;
+
+	if (print_path->end == point_no)
+		mark = '<';
+	else if (print_path->begin == point_no)
+		mark = '>';
+	else if (__ipipe_in_critical_trpath(point_no))
+		mark = ':';
+	seq_printf(m, "%c%c", mark,
+	           (point->flags & IPIPE_TFLG_HWIRQ_OFF) ? '|' : ' ');
+}
+
+static void
+__ipipe_print_delay(struct seq_file *m, struct ipipe_trace_point *point)
+{
+	unsigned long delay = 0;
+	int next;
+	char *mark = "  ";
+
+	next = WRAP_POINT_NO(point+1 - print_path->point);
+
+	if (next != print_path->trace_pos)
+		delay = ipipe_tsc2ns(print_path->point[next].timestamp -
+		                     point->timestamp);
+
+	if (__ipipe_in_critical_trpath(point - print_path->point)) {
+		if (delay > IPIPE_DELAY_WARN)
+			mark = "! ";
+		else if (delay > IPIPE_DELAY_NOTE)
+			mark = "+ ";
+	}
+	seq_puts(m, mark);
+
+	if (verbose_trace)
+		seq_printf(m, "%3lu.%03lu%c ", delay/1000, delay%1000,
+		           (point->flags & IPIPE_TFLG_NMI_HIT) ? 'N' : ' ');
+	else
+		seq_puts(m, " ");
+}
+
+static void __ipipe_print_symname(struct seq_file *m, unsigned long eip)
+{
+	char namebuf[KSYM_NAME_LEN+1];
+	unsigned long size, offset;
+	const char *sym_name;
+	char *modname;
+
+	sym_name = kallsyms_lookup(eip, &size, &offset, &modname, namebuf);
+
+	/* printing to /proc? */
+	if (m) {
+		if (sym_name) {
+			if (verbose_trace) {
+				seq_printf(m, "%s+0x%lx", sym_name, offset);
+				if (modname)
+					seq_printf(m, " [%s]", modname);
+			} else
+				seq_puts(m, sym_name);
+		} else
+			seq_printf(m, "<%08lx>", eip);
+	} else {
+		/* panic dump */
+		if (sym_name) {
+			printk("%s+0x%lx", sym_name, offset);
+			if (modname)
+				printk(" [%s]", modname);
+		}
+	}
+}
+
+#if defined(CONFIG_XENO_OPT_DEBUG) || defined(CONFIG_DEBUG_PREEMPT)
+static void __ipipe_print_dbgwarning(struct seq_file *m)
+{
+	seq_puts(m, "\n******** WARNING ********\n"
+		"The following debugging options will increase the observed "
+		"latencies:\n"
+#ifdef CONFIG_XENO_OPT_DEBUG
+		" o CONFIG_XENO_OPT_DEBUG\n"
+#endif /* CONFIG_XENO_OPT_DEBUG */
+#ifdef CONFIG_DEBUG_PREEMPT
+		" o CONFIG_DEBUG_PREEMPT\n"
+#endif /* CONFIG_DEBUG_PREEMPT */
+		"\n");
+}
+#else /* !WARN_ON_DEBUGGING_LATENCIES */
+# define __ipipe_print_dbgwarning(m)
+#endif /* WARN_ON_DEBUGGING_LATENCIES */
+
+static void __ipipe_print_headline(struct seq_file *m)
+{
+	seq_puts(m, verbose_trace ?
+		"  Type   User Val.   Time    Delay  Function (Parent)\n" :
+		"  Type    Time   Function (Parent)\n");
+}
+
+static void *__ipipe_max_prtrace_start(struct seq_file *m, loff_t *pos)
+{
+	loff_t n = *pos;
+
+	down(&out_mutex);
+
+	if (!n) {
+		struct ipipe_trace_path *path;
+		unsigned long length_usecs;
+		int points, i;
+		unsigned long flags;
+
+		/* protect against max_path/frozen_path updates while we
+		 * haven't locked our target path, also avoid recursively
+		 * taking global_path_lock from NMI context */
+		flags = __ipipe_global_path_lock();
+
+		/* find the longest of all per-cpu paths */
+		print_path = NULL;
+		for_each_online_cpu(i) {
+			path = &trace_paths[i][max_path[i]];
+			if ((print_path == NULL) ||
+			    (path->length > print_path->length))
+				print_path = path;
+		}
+		print_path->dump_lock = 1;
+
+		__ipipe_global_path_unlock(flags);
+
+		/* does this path actually contain data? */
+		if (print_path->end == print_path->begin)
+			return NULL;
+
+		/* number of points inside the critical path */
+		points = WRAP_POINT_NO(print_path->end-print_path->begin+1);
+
+		/* pre- and post-tracing length, post-trace length was frozen
+		   in __ipipe_trace, pre-trace may have to be reduced due to
+		   buffer overrun */
+		print_pre_trace  = pre_trace;
+		print_post_trace = WRAP_POINT_NO(print_path->trace_pos -
+		                                 print_path->end - 1);
+		if (points+pre_trace+print_post_trace > IPIPE_TRACE_POINTS - 1)
+			print_pre_trace = IPIPE_TRACE_POINTS - 1 - points -
+				print_post_trace;
+
+		length_usecs = ipipe_tsc2us(print_path->length);
+		seq_printf(m, "I-pipe worst-case tracing service on %s/ipipe-%s\n"
+			"------------------------------------------------------------\n",
+			UTS_RELEASE, IPIPE_ARCH_STRING);
+		__ipipe_print_dbgwarning(m);
+		seq_printf(m, "Begin: %lld cycles, Trace Points: %d (-%d/+%d), "
+			"Length: %lu us\n\n",
+			print_path->point[print_path->begin].timestamp,
+			points, print_pre_trace, print_post_trace, length_usecs);
+		__ipipe_print_headline(m);
+	}
+
+	/* check if we are inside the trace range */
+	if (n >= WRAP_POINT_NO(print_path->end - print_path->begin + 1 +
+	                       print_pre_trace + print_post_trace))
+		return NULL;
+
+	/* return the next point to be shown */
+	return &print_path->point[WRAP_POINT_NO(print_path->begin -
+	                                        print_pre_trace + n)];
+}
+
+static void *__ipipe_prtrace_next(struct seq_file *m, void *p, loff_t *pos)
+{
+	loff_t n = ++*pos;
+
+	/* check if we are inside the trace range with the next entry */
+	if (n >= WRAP_POINT_NO(print_path->end - print_path->begin + 1 +
+	                       print_pre_trace + print_post_trace))
+		return NULL;
+
+	/* return the next point to be shown */
+	return &print_path->point[WRAP_POINT_NO(print_path->begin -
+	                                        print_pre_trace + *pos)];
+}
+
+static void __ipipe_prtrace_stop(struct seq_file *m, void *p)
+{
+	if (print_path)
+		print_path->dump_lock = 0;
+	up(&out_mutex);
+}
+
+static int __ipipe_prtrace_show(struct seq_file *m, void *p)
+{
+	long time;
+	struct ipipe_trace_point *point = p;
+	char buf[16];
+
+	if (!point->eip) {
+		seq_puts(m, "-<invalid>-\n");
+		return 0;
+	}
+
+	__ipipe_print_pathmark(m, point);
+	__ipipe_trace_point_type(buf, point);
+	seq_puts(m, buf);
+	if (verbose_trace) {
+		if (point->type != IPIPE_TRACE_FN)
+			seq_printf(m, "0x%08lx ", point->v);
+		else
+			seq_puts(m, "           ");
+	}
+
+	time = __ipipe_signed_tsc2us(point->timestamp -
+		print_path->point[print_path->begin].timestamp);
+	seq_printf(m, "%5ld", time);
+
+	__ipipe_print_delay(m, point);
+	__ipipe_print_symname(m, point->eip);
+	seq_puts(m, " (");
+	__ipipe_print_symname(m, point->parent_eip);
+	seq_puts(m, ")\n");
+
+	return 0;
+}
+
+static struct seq_operations __ipipe_max_ptrace_ops = {
+	.start = __ipipe_max_prtrace_start,
+	.next  = __ipipe_prtrace_next,
+	.stop  = __ipipe_prtrace_stop,
+	.show  = __ipipe_prtrace_show
+};
+
+static int __ipipe_max_prtrace_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &__ipipe_max_ptrace_ops);
+}
+
+static ssize_t
+__ipipe_max_reset(struct file *file, const char __user *pbuffer,
+                  size_t count, loff_t *data)
+{
+	down(&out_mutex);
+	ipipe_trace_max_reset();
+	up(&out_mutex);
+
+	return count;
+}
+
+struct file_operations __ipipe_max_prtrace_fops = {
+	.open       = __ipipe_max_prtrace_open,
+	.read       = seq_read,
+	.write      = __ipipe_max_reset,
+	.llseek     = seq_lseek,
+	.release    = seq_release,
+};
+
+static void *__ipipe_frozen_prtrace_start(struct seq_file *m, loff_t *pos)
+{	
+	loff_t n = *pos;
+
+	down(&out_mutex);
+
+	if (!n) {
+		struct ipipe_trace_path *path;
+		int i;
+		unsigned long flags;
+
+		/* protect against max_path/frozen_path updates while we
+		 * haven't locked our target path, also avoid recursively
+		 * taking global_path_lock from NMI context */
+		flags = __ipipe_global_path_lock();
+
+		/* find the first of all per-cpu frozen paths */
+		print_path = NULL;
+		for_each_online_cpu(i) {
+			path = &trace_paths[i][frozen_path[i]];
+			if (path->end >= 0)
+				print_path = path;
+		}
+		if (print_path)
+			print_path->dump_lock = 1;
+
+		__ipipe_global_path_unlock(flags);
+
+		if (!print_path)
+			return NULL;
+
+		/* back- and post-tracing length, post-trace length was frozen
+		   in __ipipe_trace, back-trace may have to be reduced due to
+		   buffer overrun */
+		print_pre_trace  = back_trace-1; /* substract freeze point */
+		print_post_trace = WRAP_POINT_NO(print_path->trace_pos -
+		                                 print_path->end - 1);
+		if (1+pre_trace+print_post_trace > IPIPE_TRACE_POINTS - 1)
+			print_pre_trace = IPIPE_TRACE_POINTS - 2 -
+				print_post_trace;
+
+		seq_printf(m, "I-pipe frozen back-tracing service on %s/ipipe-%s\n"
+			"------------------------------------------------------"
+			"------\n",
+			UTS_RELEASE, IPIPE_ARCH_STRING);
+		__ipipe_print_dbgwarning(m);
+		seq_printf(m, "Freeze: %lld cycles, Trace Points: %d (+%d)\n\n",
+			print_path->point[print_path->begin].timestamp,
+			print_pre_trace+1, print_post_trace);
+
+		seq_puts(m, verbose_trace ?
+			"  Type   User Val.   Time    Delay  Function (Parent)\n" :
+			"  Type    Time   Function (Parent)\n");
+	}
+
+	/* check if we are inside the trace range */
+	if (n >= print_pre_trace + 1 + print_post_trace)
+		return NULL;
+
+	/* return the next point to be shown */
+	return &print_path->point[WRAP_POINT_NO(print_path->begin-
+	                                        print_pre_trace+n)];
+}
+
+static struct seq_operations __ipipe_frozen_ptrace_ops = {
+	.start = __ipipe_frozen_prtrace_start,
+	.next  = __ipipe_prtrace_next,
+	.stop  = __ipipe_prtrace_stop,
+	.show  = __ipipe_prtrace_show
+};
+
+static int __ipipe_frozen_prtrace_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &__ipipe_frozen_ptrace_ops);
+}
+
+static ssize_t
+__ipipe_frozen_reset(struct file *file, const char __user *pbuffer,
+                     size_t count, loff_t *data)
+{
+	down(&out_mutex);
+	ipipe_trace_frozen_reset();
+	up(&out_mutex);
+
+	return count;
+}
+
+struct file_operations __ipipe_frozen_prtrace_fops = {
+	.open       = __ipipe_frozen_prtrace_open,
+	.read       = seq_read,
+	.write      = __ipipe_frozen_reset,
+	.llseek     = seq_lseek,
+	.release    = seq_release,
+};
+
+static int __ipipe_rd_proc_val(char *page, char **start, off_t off,
+                               int count, int *eof, void *data)
+{
+	int len;
+
+	len = sprintf(page, "%u\n", *(int *)data);
+	len -= off;
+	if (len <= off + count)
+		*eof = 1;
+	*start = page + off;
+	if (len > count)
+		len = count;
+	if (len < 0)
+		len = 0;
+
+	return len;
+}
+
+static int __ipipe_wr_proc_val(struct file *file, const char __user *buffer,
+                               unsigned long count, void *data)
+{
+	char *end, buf[16];
+	int val;
+	int n;
+
+	n = (count > sizeof(buf) - 1) ? sizeof(buf) - 1 : count;
+
+	if (copy_from_user(buf, buffer, n))
+		return -EFAULT;
+
+	buf[n] = '\0';
+	val = simple_strtol(buf, &end, 0);
+
+	if (((*end != '\0') && !isspace(*end)) || (val < 0))
+		return -EINVAL;
+
+	down(&out_mutex);
+	*(int *)data = val;
+	up(&out_mutex);
+
+	return count;
+}
+
+extern struct proc_dir_entry *ipipe_proc_root;
+
+static void __init
+__ipipe_create_trace_proc_val(struct proc_dir_entry *trace_dir,
+                              const char *name, int *value_ptr)
+{
+	struct proc_dir_entry *entry;
+
+	entry = create_proc_entry(name, 0644, trace_dir);
+	if (entry) {
+		entry->data = value_ptr;
+		entry->read_proc = __ipipe_rd_proc_val;
+		entry->write_proc = __ipipe_wr_proc_val;
+		entry->owner = THIS_MODULE;
+	}
+}
+
+void __init __ipipe_init_trace_proc(void)
+{
+	struct proc_dir_entry *trace_dir;
+	struct proc_dir_entry *entry;
+
+	trace_dir = create_proc_entry("trace", S_IFDIR, ipipe_proc_root);
+
+	entry = create_proc_entry("max", 0644, trace_dir);
+	if (entry)
+		entry->proc_fops = &__ipipe_max_prtrace_fops;
+
+	entry = create_proc_entry("frozen", 0644, trace_dir);
+	if (entry)
+		entry->proc_fops = &__ipipe_frozen_prtrace_fops;
+
+	__ipipe_create_trace_proc_val(trace_dir, "pre_trace_points",
+	                              &pre_trace);
+	__ipipe_create_trace_proc_val(trace_dir, "post_trace_points",
+	                              &post_trace);
+	__ipipe_create_trace_proc_val(trace_dir, "back_trace_points",
+	                              &back_trace);
+	__ipipe_create_trace_proc_val(trace_dir, "verbose",
+	                              &verbose_trace);
+	__ipipe_create_trace_proc_val(trace_dir, "enable",
+	                              &ipipe_trace_enable);
+}
--- 2.6.16/arch/i386/boot/compressed/misc.c	2006-03-20 06:53:29.000000000 +0100
+++ 2.6.16-ipipe/arch/i386/boot/compressed/misc.c	2006-03-21 14:52:55.000000000 +0100
@@ -15,6 +15,12 @@
 #include <asm/io.h>
 #include <asm/page.h>
 
+#ifdef CONFIG_IPIPE_TRACE
+void __attribute__ ((no_instrument_function)) mcount(void)
+{
+}
+#endif
+
 /*
  * gzip declarations
  */
@@ -112,7 +118,7 @@ static long free_mem_end_ptr;
 #define INPLACE_MOVE_ROUTINE  0x1000
 #define LOW_BUFFER_START      0x2000
 #define LOW_BUFFER_MAX       0x90000
-#define HEAP_SIZE             0x3000
+#define HEAP_SIZE             0x4000
 static unsigned int low_buffer_end, low_buffer_size;
 static int high_loaded =0;
 static uch *high_buffer_start /* = (uch *)(((ulg)&end) + HEAP_SIZE)*/;
--- 2.6.16/arch/i386/kernel/ipipe-mcount.S	1970-01-01 01:00:00.000000000 +0100
+++ 2.6.16-ipipe/arch/i386/kernel/ipipe-mcount.S	2005-12-29 14:04:04.000000000 +0100
@@ -0,0 +1,45 @@
+/*
+ *  linux/arch/i386/ipipe-mcount.S
+ *
+ *  Copyright (C) 2005 Jan Kiszka
+ */
+
+#include <linux/config.h>
+
+.globl mcount
+mcount:
+        cmpl $0,ipipe_trace_enable
+        je out
+
+        pushl %ebp
+        movl %esp,%ebp
+
+        pushl %eax
+        pushl %ecx
+        pushl %edx
+
+        pushl $0                # no additional value (v)
+#ifdef CONFIG_REGPARM
+        movl (%ebp),%eax
+        movl 0x4(%ebp),%edx     # __CALLER_ADDR0
+        movl 0x4(%eax),%ecx     # __CALLER_ADDR1
+        movl $0,%eax            # IPIPE_TRACE_FN
+        call __ipipe_trace
+        popl %eax
+#else /* !CONFIG_REGPARM */
+        movl (%ebp),%eax
+        movl 0x4(%eax),%eax
+        pushl %eax              # __CALLER_ADDR1
+        movl 0x4(%ebp),%eax
+        pushl %eax              # __CALLER_ADDR0
+        pushl $0                # IPIPE_TRACE_FN
+        call __ipipe_trace
+        addl $0x10,%esp
+#endif /* CONFIG_REGPARM */
+
+        popl %edx
+        popl %ecx
+        popl %eax
+        popl %ebp
+out:
+        ret

--5UZdiMnAhH--

