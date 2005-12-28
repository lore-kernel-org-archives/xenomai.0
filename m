Message-ID: <43B2AF57.10004@domain.hid>
Date: Wed, 28 Dec 2005 16:29:27 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig93B751F60945AA58DBFCDE24"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] ipipe-tracer-v5
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
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig93B751F60945AA58DBFCDE24
Content-Type: multipart/mixed; boundary="------------080401040000010909040704"

This is a multi-part message in MIME format.
--------------080401040000010909040704
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Hi Philippe,

this is a revised version of the tracer patch, addressing your concerns
hopefully in the right way. Changes since the previous release:

 * move __ipipe_init_trace_proc() declaration to linux/ipipe.h
 * define __BUILTIN_RETURN_ADDRESSx in linux/ipipe.h unless some arch
   defines BROKEN_BUILTIN_RETURN_ADDRESS and provides its own variants
 * improve ipipe_tsc2ns() for i386 so that it makes use of do_div (and
   also accepts 64 bit input)
 * move ipipe_tsc2us() to asm-i386/ipipe.h
 * fix a display bug in the output of "frozen"
 * reformatting
 * remove inclusion of linux/ipipe_trace.h from linux/sched.h

NOTE: The last change makes the local inclusion of ipipe_trace.h
necessary when instrumenting some code. Previous instrumentation patches
are likely broken now.

I think it should be ready for apply now, shouldn't it?

Jan

--------------080401040000010909040704
Content-Type: text/plain;
 name="ipipe_trace.patch-v5"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ipipe_trace.patch-v5"

--- linux-2.6.14.3/arch/i386/boot/compressed/misc.c.orig	2005-11-24 23:10:21.000000000 +0100
+++ linux-2.6.14.3/arch/i386/boot/compressed/misc.c	2005-12-28 16:12:43.000000000 +0100
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
@@ -112,7 +118,7 @@
 #define INPLACE_MOVE_ROUTINE  0x1000
 #define LOW_BUFFER_START      0x2000
 #define LOW_BUFFER_MAX       0x90000
-#define HEAP_SIZE             0x3000
+#define HEAP_SIZE             0x4000
 static unsigned int low_buffer_end, low_buffer_size;
 static int high_loaded =0;
 static uch *high_buffer_start /* = (uch *)(((ulg)&end) + HEAP_SIZE)*/;
@@ -125,6 +131,7 @@
 static void * xquad_portio = NULL;
 #endif
 
+#define ZLIB_INFLATE_NO_INFLATE_LOCK
 #include "../../../../lib/inflate.c"
 
 static void *malloc(int size)
--- linux-2.6.14.3/arch/i386/kernel/ipipe-mcount.S.orig	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.14.3/arch/i386/kernel/ipipe-mcount.S	2005-12-28 16:12:43.000000000 +0100
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
--- linux-2.6.14.3/arch/i386/kernel/Makefile.orig	2005-12-17 14:08:23.000000000 +0100
+++ linux-2.6.14.3/arch/i386/kernel/Makefile	2005-12-28 16:12:43.000000000 +0100
@@ -31,6 +31,7 @@
 obj-$(CONFIG_MODULES)		+= module.o
 obj-y				+= sysenter.o vsyscall.o
 obj-$(CONFIG_IPIPE)		+= ipipe-core.o ipipe-root.o
+obj-$(CONFIG_IPIPE_TRACE)	+= ipipe-mcount.o
 obj-$(CONFIG_ACPI_SRAT) 	+= srat.o
 obj-$(CONFIG_HPET_TIMER) 	+= time_hpet.o
 obj-$(CONFIG_EFI) 		+= efi.o efi_stub.o
--- linux-2.6.14.3/Makefile.orig	2005-11-24 23:10:21.000000000 +0100
+++ linux-2.6.14.3/Makefile	2005-12-28 16:12:43.000000000 +0100
@@ -517,11 +517,15 @@
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
--- linux-2.6.14.3/kernel/ipipe/Makefile.orig	2005-12-17 14:08:23.000000000 +0100
+++ linux-2.6.14.3/kernel/ipipe/Makefile	2005-12-28 16:12:43.000000000 +0100
@@ -1,2 +1,3 @@
 
 obj-$(CONFIG_IPIPE)	+= core.o generic.o
+obj-$(CONFIG_IPIPE_TRACE) += tracer.o
--- linux-2.6.14.3/kernel/ipipe/core.c.orig	2005-12-17 14:08:23.000000000 +0100
+++ linux-2.6.14.3/kernel/ipipe/core.c	2005-12-28 16:12:43.000000000 +0100
@@ -415,7 +415,7 @@
 
 #include <linux/proc_fs.h>
 
-static struct proc_dir_entry *ipipe_proc_root;
+struct proc_dir_entry *ipipe_proc_root;
 
 static int __ipipe_version_info_proc(char *page,
 				     char **start,
@@ -657,6 +657,7 @@
 {
 	ipipe_proc_root = create_proc_entry("ipipe",S_IFDIR, 0);
 	create_proc_read_entry("version",0444,ipipe_proc_root,&__ipipe_version_info_proc,NULL);
+	__ipipe_init_trace_proc();
 	__ipipe_add_domain_proc(ipipe_root_domain);
 }
 
--- linux-2.6.14.3/kernel/ipipe/tracer.c.orig	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.14.3/kernel/ipipe/tracer.c	2005-12-28 16:12:43.000000000 +0100
@@ -0,0 +1,823 @@
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
+#define IPIPE_TFLG_HWIRQ_OFF        0x0004
+#define IPIPE_TFLG_FREEZING         0x0008
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
+	int trace_pos;
+	int begin, end;
+	int post_trace;
+	unsigned long long length;
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
+		{ [ IPIPE_DEFAULT_ACTIVE ] = {.begin = -1, .end = -1 },
+		  [ IPIPE_DEFAULT_FROZEN ] = {.begin = -1, .end = -1 } } };
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
+static int print_pre_trace;
+static int print_post_trace;
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
+	for (i = new_tp->trace_pos; i > 0; i--)
+		memcpy(&new_tp->point[WRAP_POINT_NO(new_tp->trace_pos-i)],
+		       &old_tp->point[WRAP_POINT_NO(old_pos-i)],
+		       sizeof(struct ipipe_trace_point));
+}
+
+static inline struct ipipe_trace_path *
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
+static inline struct ipipe_trace_path *
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
+	local_irq_save_hw(flags);
+
+	cpu_id = raw_smp_processor_id();
+	tp = old_tp = &trace_paths[cpu_id][active_path[cpu_id]];
+
+	/* check for NMI recursion */
+	if (tp->flags & IPIPE_TFLG_NMI_LOCK) {
+		tp->flags |= IPIPE_TFLG_NMI_HIT;
+		return; /* no need for restoring flags inside IRQ */
+	}
+
+	/* clear NMI warning and set lock (atomically per cpu) */
+	tp->flags = (tp->flags & ~IPIPE_TFLG_NMI_HIT) | IPIPE_TFLG_NMI_LOCK;
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
+	if ((type == IPIPE_TRACE_BEGIN) && (begin < 0))
+		tp->begin = pos;
+
+	/* skip END and FREEZE request during post-trace */
+	if (!tp->post_trace) {
+		/* end of critical path, start post-trace */
+		if ((type == IPIPE_TRACE_END) && (begin >= 0))
+			tp->post_trace = post_trace + 1;
+
+		/* freeze only if the slot is free */
+		if ((type == IPIPE_TRACE_FREEZE) &&
+		    (trace_paths[cpu_id][frozen_path[cpu_id]].begin < 0)) {
+			tp->post_trace = post_trace + 1;
+			tp->flags |= IPIPE_TFLG_FREEZING;
+		}
+	}
+
+	/* enforce end of trace in case of overflow */
+	if (WRAP_POINT_NO(next_pos + 1) == begin)
+		tp->post_trace = 1;
+
+	/* stop tracing this path if we are in post-trace and
+	 *  a) that phase is over now or
+	 *  b) a new TRACE_BEGIN came in but we are not freezing this path */
+	if ((tp->post_trace > 0) && ((--tp->post_trace == 0) ||
+	    ((type == IPIPE_TRACE_BEGIN) &&
+	    !(tp->flags & IPIPE_TFLG_FREEZING)))) {
+		/* store the path's end (i.e. excluding post-trace) */
+		tp->end = WRAP_POINT_NO(pos - post_trace + tp->post_trace);
+
+		if (tp->flags & IPIPE_TFLG_FREEZING)
+			tp = __ipipe_trace_freeze(cpu_id, tp, pos);
+		else
+			tp = __ipipe_trace_end(cpu_id, tp, pos);
+
+		/* reset the active path, maybe already start a new one */
+		tp->begin = (type == IPIPE_TRACE_BEGIN) ?
+			tp->trace_pos-1 : -1;
+		tp->end = -1;
+		tp->post_trace = 0;
+
+		/* update active_path not earlier to avoid races with NMIs */
+		active_path[cpu_id] = tp - trace_paths[cpu_id];
+	}
+
+	/* we still have old_tp and point,
+	 * let's reset NMI lock and check for noise */
+	old_tp->flags &= ~IPIPE_TFLG_NMI_LOCK;
+	if (old_tp->flags & IPIPE_TFLG_NMI_HIT) {
+		/* well, this late tagging may not immediately be visible for
+		 * other cpus already dumping this path - a minor issue */
+		point->flags |= IPIPE_TFLG_NMI_HIT;
+	}
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
+	if (sym_name) {
+		if (verbose_trace) {
+			seq_printf(m, "%s+0x%lx", sym_name, offset);
+			if (modname)
+				seq_printf(m, " [%s]", modname);
+		} else
+			seq_puts(m, sym_name);
+	} else
+		seq_printf(m, "<%08lx>", eip);
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
+		 * haven't locked our target path */
+		spin_lock_irqsave_hw(&global_path_lock, flags);
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
+		spin_unlock_irqrestore_hw(&global_path_lock, flags);
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
+	long long delta;
+	unsigned long long abs_delta;
+	struct ipipe_trace_point *point = p;
+
+	if (!point->eip)
+		return 0;
+
+	/* ipipe_tsc2us works on unsigned => handle sign separately */
+	delta = point->timestamp -
+		print_path->point[print_path->begin].timestamp;
+	abs_delta = (delta >= 0) ? delta : -delta;
+	time = ipipe_tsc2us(abs_delta);
+	if (delta < 0)
+		time = -time;
+
+	__ipipe_print_pathmark(m, point);
+	switch (point->type) {
+		case IPIPE_TRACE_FN:
+			seq_puts(m, "fn     ");
+			break;
+
+		case IPIPE_TRACE_BEGIN:
+			seq_puts(m, "begin  ");
+			break;
+
+		case IPIPE_TRACE_END:
+			seq_puts(m, "end    ");
+			break;
+
+		case IPIPE_TRACE_FREEZE:
+			seq_puts(m, "freeze ");
+			break;
+
+		default: /* IPIPE_TRACE_SPECIAL */
+			seq_printf(m, "(0x%02x) ",
+			           point->type - IPIPE_TRACE_SPECIAL);
+	}
+	if (verbose_trace) {
+		if (point->type != IPIPE_TRACE_FN)
+			seq_printf(m, "0x%08lx ", point->v);
+		else
+			seq_puts(m, "           ");
+	}
+	seq_printf(m, "%5ld", time);
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
+	int cpu_id;
+	unsigned long flags;
+	struct ipipe_trace_path *path;
+
+	down(&out_mutex);
+	spin_lock_irqsave_hw(&global_path_lock, flags);
+
+	for_each_cpu(cpu_id) {
+		path = &trace_paths[cpu_id][max_path[cpu_id]];
+		path->begin     = 0;
+		path->end       = 0;
+		path->trace_pos = 0;
+		path->length    = 0;
+	}
+
+	spin_unlock_irqrestore_hw(&global_path_lock, flags);
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
+		 * haven't locked our target path */
+		spin_lock_irqsave_hw(&global_path_lock, flags);
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
+		spin_unlock_irqrestore_hw(&global_path_lock, flags);
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
+		__ipipe_print_dbgwarning();
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
+	int cpu_id;
+	unsigned long flags;
+	struct ipipe_trace_path *path;
+
+	down(&out_mutex);
+	spin_lock_irqsave_hw(&global_path_lock, flags);
+
+	for_each_cpu(cpu_id) {
+		path = &trace_paths[cpu_id][frozen_path[cpu_id]];
+		path->begin = -1;
+		path->end = -1;
+	}
+
+	spin_unlock_irqrestore_hw(&global_path_lock, flags);
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
--- linux-2.6.14.3/kernel/ipipe/Kconfig.orig	2005-12-17 14:08:23.000000000 +0100
+++ linux-2.6.14.3/kernel/ipipe/Kconfig	2005-12-28 16:12:43.000000000 +0100
@@ -14,5 +14,13 @@
 	  while the I-pipe is operating. This option adds a small overhead, but
 	  is useful to detect unexpected latency points.
 
+config IPIPE_TRACE
+	bool "Trace IRQ latencies"
+	depends on IPIPE && PROC_FS
+	default n
+	---help---
+	  Activate this option if I-pipe shall trace the longest stalled path
+	  of the domain with the highest priority.
+
 config IPIPE_EXTENDED
 	def_bool IPIPE
--- linux-2.6.14.3/include/linux/ipipe.h.orig	2005-12-23 02:38:35.000000000 +0100
+++ linux-2.6.14.3/include/linux/ipipe.h	2005-12-28 16:12:43.000000000 +0100
@@ -33,6 +33,11 @@
 				 (IPIPE_MINOR_NUMBER <<  8) | \
 				 (IPIPE_PATCH_NUMBER))
 
+#ifndef BROKEN_BUILTIN_RETURN_ADDRESS
+#define __BUILTIN_RETURN_ADDRESS0 ((unsigned long)__builtin_return_address(0))
+#define __BUILTIN_RETURN_ADDRESS1 ((unsigned long)__builtin_return_address(1))
+#endif /* !BUILTIN_RETURN_ADDRESS */
+
 #define IPIPE_ROOT_PRIO		100
 #define IPIPE_ROOT_ID		0
 #define IPIPE_ROOT_NPTDKEYS	4	/* Must be <= BITS_PER_LONG */
@@ -309,6 +314,13 @@
 
 #ifdef CONFIG_PROC_FS
 void ipipe_init_proc(void);
+
+#ifdef CONFIG_IPIPE_TRACE
+void __ipipe_init_trace_proc(void);
+#else /* !CONFIG_IPIPE_TRACE */
+#define __ipipe_init_trace_proc()   do { } while(0)
+#endif /* CONFIG_IPIPE_TRACE */
+
 #else	/* !CONFIG_PROC_FS */
 #define ipipe_init_proc()	do { } while(0)
 #endif	/* CONFIG_PROC_FS */
--- linux-2.6.14.3/include/linux/ipipe_trace.h.orig	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.14.3/include/linux/ipipe_trace.h	2005-12-28 16:12:43.000000000 +0100
@@ -0,0 +1,31 @@
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
+#endif	/* !__LINUX_IPIPE_H */
--- linux-2.6.14.3/include/linux/linkage.h.orig	2005-11-24 23:10:21.000000000 +0100
+++ linux-2.6.14.3/include/linux/linkage.h	2005-12-28 16:12:43.000000000 +0100
@@ -51,4 +51,8 @@
 #define fastcall
 #endif
 
+#ifndef notrace
+#define notrace		__attribute__((no_instrument_function))
+#endif
+
 #endif
--- linux-2.6.14.3/include/asm-i386/ipipe.h.orig	2005-12-28 13:54:04.000000000 +0100
+++ linux-2.6.14.3/include/asm-i386/ipipe.h	2005-12-28 16:12:43.000000000 +0100
@@ -157,7 +157,20 @@
 
 #define ipipe_read_tsc(t)  __asm__ __volatile__("rdtsc" : "=A" (t))
 #define ipipe_cpu_freq() ({ unsigned long long __freq = cpu_has_tsc?(1000LL * cpu_khz):CLOCK_TICK_RATE; __freq; })
-#define ipipe_tsc2ns(t)  (((t) * 1000) / (cpu_khz / 1000))
+
+#define ipipe_tsc2ns(t) \
+({ \
+	unsigned long long delta = (t)*1000; \
+	do_div(delta, cpu_khz/1000+1); \
+	(unsigned long)delta; \
+})
+
+#define ipipe_tsc2us(t) \
+({ \
+    unsigned long long delta = (t); \
+    do_div(delta, cpu_khz/1000+1); \
+    (unsigned long)delta; \
+})
 
 /* Private interface -- Internal use only */
 

--------------080401040000010909040704--

--------------enig93B751F60945AA58DBFCDE24
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDsq9aniDOoMHTA+kRAkpDAJ4oNTUOZRWncgJNRo5fDVxewH8sfgCfQshM
UifrNzW+PmC0FfwUw/XLBGY=
=hovG
-----END PGP SIGNATURE-----

--------------enig93B751F60945AA58DBFCDE24--

