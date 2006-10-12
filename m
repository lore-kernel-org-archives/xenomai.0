Message-ID: <452E9ADB.6000700@domain.hid>
Date: Thu, 12 Oct 2006 21:43:23 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040004030805090806070409"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH 2/3] Migrate and enhance IRQ statistics
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
--------------040004030805090806070409
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

This patch migrates the xnintr hits statistics to the new xnstat
subsystem and introduces per-CPU runtime statistics to xnintr entities.
The latter allows to differentiate between ISR and thread activity under
/proc/xenomai/stat.

For querying the xnintr statistics, a scalable service based on IRQ list
revisions is introduced (xnintr_query), just like it already exists for
threads.

Accounting model:
 - hits are only counted if the ISR returns XN_ISR_HANDLED
 - runtime is accounted over each ISR invocation, independent of its
   return value

As a hopefully not critical side effect, the native intr services now
only reports non-zero hit counters if XENO_OPT_STATS in enabled. This
fact is documented in the rt_intr_info structure.

Jan

--------------040004030805090806070409
Content-Type: text/plain;
 name="migrate_and_enhance_irq_stats.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="migrate_and_enhance_irq_stats.patch"

---
 include/native/intr.h    |    3 -
 include/nucleus/intr.h   |   19 +++++-
 ksrc/nucleus/intr.c      |  131 ++++++++++++++++++++++++++++++++++++++++++++---
 ksrc/nucleus/module.c    |   35 ++++++++++++
 ksrc/skins/native/intr.c |   28 +++++++---
 5 files changed, 196 insertions(+), 20 deletions(-)

Index: xenomai/include/nucleus/intr.h
===================================================================
--- xenomai.orig/include/nucleus/intr.h
+++ xenomai/include/nucleus/intr.h
@@ -39,6 +39,8 @@
 
 #if defined(__KERNEL__) || defined(__XENO_SIM__)
 
+#include <nucleus/stat.h>
+
 typedef struct xnintr {
 
 #if defined(CONFIG_XENO_OPT_SHIRQ_LEVEL) || defined(CONFIG_XENO_OPT_SHIRQ_EDGE)
@@ -51,8 +53,6 @@ typedef struct xnintr {
 
     void *cookie;	/* !< User-defined cookie value. */
 
-    unsigned long hits;	/* !< Number of receipts (since attachment). */
-
     xnflags_t flags; 	/* !< Creation flags. */
 
     unsigned irq;	/* !< IRQ number. */
@@ -61,9 +61,18 @@ typedef struct xnintr {
 
     const char *name;	/* !< Symbolic name. */
 
+    struct {
+	xnstat_counter_t hits;	  /* !< Number of handled receipts since attachment. */
+	xnstat_runtime_t account; /* !< Runtime accounting entity */
+    } stat[RTHAL_NR_CPUS];
+
 } xnintr_t;
 
 extern xnintr_t nkclock;
+#ifdef CONFIG_XENO_OPT_STATS
+extern int xnintr_count;
+extern int xnintr_list_rev;
+#endif
 
 #ifdef __cplusplus
 extern "C" {
@@ -94,10 +103,14 @@ int xnintr_detach(xnintr_t *intr);
 int xnintr_enable(xnintr_t *intr);
 
 int xnintr_disable(xnintr_t *intr);
-    
+
 xnarch_cpumask_t xnintr_affinity(xnintr_t *intr,
                                  xnarch_cpumask_t cpumask);
 
+int xnintr_query(int irq, int *cpu, xnintr_t **prev, int revision, char *name,
+		 unsigned long *hits, xnticks_t *runtime,
+		 xnticks_t *account_period);
+
 #ifdef __cplusplus
 }
 #endif
Index: xenomai/ksrc/nucleus/intr.c
===================================================================
--- xenomai.orig/ksrc/nucleus/intr.c
+++ xenomai/ksrc/nucleus/intr.c
@@ -34,6 +34,7 @@
 #include <nucleus/pod.h>
 #include <nucleus/intr.h>
 #include <nucleus/ltt.h>
+#include <nucleus/stat.h>
 #include <asm/xenomai/bits/intr.h>
 
 #define XNINTR_MAX_UNHANDLED	1000
@@ -44,6 +45,11 @@ xnlock_t intrlock;
 
 xnintr_t nkclock;
 
+#ifdef CONFIG_XENO_OPT_STATS
+int xnintr_count = 1;	/* Number of attached xnintr objects + nkclock */
+int xnintr_list_rev;	/* Modification counter of xnintr list */
+#endif /* CONFIG_XENO_OPT_STATS */
+
 /*
  * Low-level interrupt handler dispatching the ISRs -- Called with
  * interrupts off.
@@ -53,15 +59,19 @@ static void xnintr_irq_handler(unsigned 
 {
 	xnsched_t *sched = xnpod_current_sched();
 	xnintr_t *intr = (xnintr_t *)cookie;
+	xnstat_runtime_t *prev;
 	int s;
 
 	xnarch_memory_barrier();
 
 	xnltt_log_event(xeno_ev_ienter, irq);
+	prev = xnstat_runtime_switch(sched,
+				     &intr->stat[xnsched_cpu(sched)].account);
 
 	++sched->inesting;
 	s = intr->isr(intr);
-	++intr->hits;
+
+	xnstat_runtime_switch(sched, prev);
 
 	if (unlikely(s == XN_ISR_NONE)) {
 		if (++intr->unhandled == XNINTR_MAX_UNHANDLED) {
@@ -69,8 +79,10 @@ static void xnintr_irq_handler(unsigned 
 				 "line.\n", __FUNCTION__, irq);
 			s |= XN_ISR_NOENABLE;
 		}
-	} else
+	} else {
+		xnstat_counter_inc(&intr->stat[xnsched_cpu(sched)].hits);
 		intr->unhandled = 0;
+	}
 
 	if (s & XN_ISR_PROPAGATE)
 		xnarch_chain_irq(irq);
@@ -149,12 +161,14 @@ void xnintr_synchronize(xnintr_t *intr)
 static void xnintr_shirq_handler(unsigned irq, void *cookie)
 {
 	xnsched_t *sched = xnpod_current_sched();
+	xnstat_runtime_t *prev;
 	xnintr_shirq_t *shirq = &xnshirqs[irq];
 	xnintr_t *intr;
 	int s = 0;
 
 	xnarch_memory_barrier();
 
+	prev = xnstat_runtime_get_current(sched);
 	xnltt_log_event(xeno_ev_ienter, irq);
 
 	++sched->inesting;
@@ -163,11 +177,23 @@ static void xnintr_shirq_handler(unsigne
 	intr = shirq->handlers;
 
 	while (intr) {
-		s |= intr->isr(intr);
-		++intr->hits;
+		int ret;
+
+		xnstat_runtime_switch(sched,
+			&intr->stat[xnsched_cpu(sched)].account);
+
+		ret = intr->isr(intr);
+		s |= ret;
+
+		if (ret & XN_ISR_HANDLED)
+			xnstat_counter_inc(
+				&intr->stat[xnsched_cpu(sched)].hits);
+
 		intr = intr->next;
 	}
 
+	xnstat_runtime_switch(sched, prev);
+
 	xnintr_shirq_unlock(shirq);
 
 	if (unlikely(s == XN_ISR_NONE)) {
@@ -203,12 +229,14 @@ static void xnintr_edge_shirq_handler(un
 	const int MAX_EDGEIRQ_COUNTER = 128;
 
 	xnsched_t *sched = xnpod_current_sched();
+	xnstat_runtime_t *prev;
 	xnintr_shirq_t *shirq = &xnshirqs[irq];
 	xnintr_t *intr, *end = NULL;
 	int s = 0, counter = 0;
 
 	xnarch_memory_barrier();
 
+	prev = xnstat_runtime_get_current(sched);
 	xnltt_log_event(xeno_ev_ienter, irq);
 
 	++sched->inesting;
@@ -219,13 +247,17 @@ static void xnintr_edge_shirq_handler(un
 	while (intr != end) {
 		int ret, code;
 
+		xnstat_runtime_switch(sched,
+			&intr->stat[xnsched_cpu(sched)].account);
+
 		ret = intr->isr(intr);
 		code = ret & ~XN_ISR_BITMASK;
 		s |= ret;
 
 		if (code == XN_ISR_HANDLED) {
-			++intr->hits;
 			end = NULL;
+			xnstat_counter_inc(
+				&intr->stat[xnsched_cpu(sched)].hits);
 		} else if (code == XN_ISR_NONE && end == NULL)
 			end = intr;
 
@@ -236,6 +268,8 @@ static void xnintr_edge_shirq_handler(un
 			intr = shirq->handlers;
 	}
 
+	xnstat_runtime_switch(sched, prev);
+
 	xnintr_shirq_unlock(shirq);
 
 	if (counter > MAX_EDGEIRQ_COUNTER)
@@ -489,10 +523,10 @@ int xnintr_init(xnintr_t *intr,
 	intr->isr = isr;
 	intr->iack = iack;
 	intr->cookie = NULL;
-	intr->hits = 0;
 	intr->name = name;
 	intr->flags = flags;
 	intr->unhandled = 0;
+	memset(&intr->stat, 0, sizeof(intr->stat));
 #if defined(CONFIG_XENO_OPT_SHIRQ_LEVEL) || defined(CONFIG_XENO_OPT_SHIRQ_EDGE)
 	intr->next = NULL;
 #endif /* CONFIG_XENO_OPT_SHIRQ_LEVEL || CONFIG_XENO_OPT_SHIRQ_EDGE */
@@ -572,7 +606,6 @@ int xnintr_attach(xnintr_t *intr, void *
 	int err;
 	spl_t s;
 
-	intr->hits = 0;
 	intr->cookie = cookie;
 
 	xnlock_get_irqsave(&intrlock, s);
@@ -581,6 +614,14 @@ int xnintr_attach(xnintr_t *intr, void *
 
 	xnlock_put_irqrestore(&intrlock, s);
 
+#ifdef CONFIG_XENO_OPT_STATS
+	if (!err) {
+		memset(&intr->stat, 0, sizeof(intr->stat));
+		xnintr_count++;
+		xnintr_list_rev++;
+	}
+#endif /* CONFIG_XENO_OPT_STATS */
+
 	return err;
 }
 
@@ -624,6 +665,14 @@ int xnintr_detach(xnintr_t *intr)
 
 	xnlock_put_irqrestore(&intrlock, s);
 
+#ifdef CONFIG_XENO_OPT_STATS
+	if (!err) {
+		xnintr_count--;
+		xnintr_list_rev++;
+	}
+#endif /* CONFIG_XENO_OPT_STATS */
+
+
 	/* The idea here is to keep a detached interrupt object valid as long
 	   as the corresponding irq handler is running. This is one of the
 	   requirements to iterate over the xnintr_shirq_t::handlers list in
@@ -761,6 +810,74 @@ int xnintr_irq_proc(unsigned int irq, ch
 }
 #endif /* CONFIG_PROC_FS */
 
+#ifdef CONFIG_XENO_OPT_STATS
+int xnintr_query(int irq, int *cpu, xnintr_t **prev, int revision, char *name,
+		 unsigned long *hits, xnticks_t *runtime,
+		 xnticks_t *account_period)
+{
+	xnintr_t *intr;
+	xnticks_t last_switch;
+	int head;
+	int cpu_no = *cpu;
+	int err = 0;
+	spl_t s;
+
+	head = snprintf(name, XNOBJECT_NAME_LEN, "IRQ%d: ", irq);
+	name += head;
+
+	xnlock_get_irqsave(&nklock, s);
+
+	if (revision != xnintr_list_rev) {
+		err = -EAGAIN;
+		goto unlock_and_exit;
+	}
+
+#if defined(CONFIG_XENO_OPT_SHIRQ_LEVEL) || defined(CONFIG_XENO_OPT_SHIRQ_EDGE)
+	if (*prev)
+		intr = (*prev)->next;
+	else if (irq == XNARCH_TIMER_IRQ)
+		intr = &nkclock;
+	else
+		intr = xnshirqs[irq].handlers;
+#else /* !CONFIG_XENO_OPT_SHIRQ_LEVEL && !CONFIG_XENO_OPT_SHIRQ_EDGE */
+	if (*prev)
+		intr = NULL;
+	else if (irq == XNARCH_TIMER_IRQ)
+		intr = &nkclock;
+	else
+		intr = rthal_irq_cookie(&rthal_domain, irq);
+#endif /* CONFIG_XENO_OPT_SHIRQ_LEVEL || CONFIG_XENO_OPT_SHIRQ_EDGE */
+
+	if (!intr) {
+		err = -ENODEV;
+		goto unlock_and_exit;
+	}
+
+	strncpy(name, intr->name, XNOBJECT_NAME_LEN-head);
+
+	*hits = xnstat_counter_get(&intr->stat[cpu_no].hits);
+
+	last_switch = xnpod_sched_slot(cpu_no)->last_account_switch;
+
+	*runtime        = intr->stat[cpu_no].account.total;
+	*account_period = last_switch - intr->stat[cpu_no].account.start;
+
+	intr->stat[cpu_no].account.total  = 0;
+	intr->stat[cpu_no].account.start = last_switch;
+
+	if (++cpu_no == xnarch_num_online_cpus()) {
+		cpu_no = 0;
+		*prev  = intr;
+	}
+	*cpu = cpu_no;
+
+     unlock_and_exit:
+	xnlock_put_irqrestore(&nklock, s);
+
+	return err;
+}
+#endif /* CONFIG_XENO_OPT_STATS */
+
 EXPORT_SYMBOL(xnintr_attach);
 EXPORT_SYMBOL(xnintr_destroy);
 EXPORT_SYMBOL(xnintr_detach);
Index: xenomai/ksrc/nucleus/module.c
===================================================================
--- xenomai.orig/ksrc/nucleus/module.c
+++ xenomai/ksrc/nucleus/module.c
@@ -351,7 +351,7 @@ static int stat_seq_open(struct inode *i
 	struct seq_file *seq;
 	xnholder_t *holder;
 	struct stat_seq_info *stat_info;
-	int err, count, thrq_rev;
+	int err, count, thrq_rev, intr_rev, irq;
 	spl_t s;
 
 	if (!nkpod)
@@ -364,6 +364,9 @@ static int stat_seq_open(struct inode *i
 	holder = getheadq(&nkpod->threadq);
 	thrq_rev = nkpod->threadq_rev;
 
+	count += xnintr_count * RTHAL_NR_CPUS;
+	intr_rev = xnintr_list_rev;
+
 	xnlock_put_irqrestore(&nklock, s);
 
 	if (iter)
@@ -425,6 +428,36 @@ static int stat_seq_open(struct inode *i
 		xnlock_put_irqrestore(&nklock, s);
 	}
 
+	/* Iterate over all IRQ numbers, ... */
+	for (irq = 0; irq < RTHAL_NR_IRQS; irq++) {
+		xnintr_t *prev = NULL;
+		int cpu = 0;
+		int err;
+
+		/* ...over all shared IRQs on all CPUs */
+		while (1) {
+			stat_info = &iter->stat_info[iter->nentries];
+			stat_info->cpu = cpu;
+
+			err = xnintr_query(irq, &cpu, &prev, intr_rev,
+					   stat_info->name,
+					   &stat_info->csw,
+					   &stat_info->runtime,
+					   &stat_info->account_period);
+			if (err == EAGAIN)
+				goto restart;
+			if (err)
+				break; /* line unused or end of chain */
+
+			stat_info->pid = 0;
+			stat_info->status =  0;
+			stat_info->ssw = 0;
+			stat_info->pf = 0;
+
+			iter->nentries++;
+		};
+	}
+
 	seq = (struct seq_file *)file->private_data;
 	seq->private = iter;
 
Index: xenomai/include/native/intr.h
===================================================================
--- xenomai.orig/include/native/intr.h
+++ xenomai/include/native/intr.h
@@ -36,7 +36,8 @@ typedef struct rt_intr_info {
 
     unsigned irq;	/* !< Interrupt request number. */
 
-    unsigned long hits;	/* !< Number of receipts (since attachment). */
+    unsigned long hits;	/* !< Number of receipts (since attachment), 0 if
+                              statistics support is disable in the nucleus. */
 
     char name[XNOBJECT_NAME_LEN]; /* !< Symbolic name. */
 
Index: xenomai/ksrc/skins/native/intr.c
===================================================================
--- xenomai.orig/ksrc/skins/native/intr.c
+++ xenomai/ksrc/skins/native/intr.c
@@ -47,6 +47,17 @@ void __native_intr_pkg_cleanup(void)
 		rt_intr_delete(link2intr(holder));
 }
 
+static unsigned long __intr_get_hits(RT_INTR *intr)
+{
+	unsigned long sum = 0;
+	int cpu;
+
+	for (cpu = 0; cpu < XNARCH_NR_CPUS; cpu++)
+		sum += xnstat_counter_get(&intr->intr_base.stat[cpu].hits);
+
+	return sum;
+}
+
 #ifdef CONFIG_XENO_EXPORT_REGISTRY
 
 static int __intr_read_proc(char *page,
@@ -56,16 +67,17 @@ static int __intr_read_proc(char *page,
 	RT_INTR *intr = (RT_INTR *)data;
 	char *p = page;
 	int len;
+	spl_t s;
+
+	xnlock_get_irqsave(&nklock, s);
 
 #ifdef CONFIG_XENO_OPT_PERVASIVE
 	{
 		xnpholder_t *holder;
-		spl_t s;
-
-		xnlock_get_irqsave(&nklock, s);
 
 		p += sprintf(p, "hits=%lu, pending=%u, mode=0x%x\n",
-			     intr->intr_base.hits, intr->pending, intr->mode);
+			     __intr_get_hits(intr), intr->pending,
+			     intr->mode);
 
 		/* Pended interrupt -- dump waiters. */
 
@@ -78,13 +90,13 @@ static int __intr_read_proc(char *page,
 			    nextpq(xnsynch_wait_queue(&intr->synch_base),
 				   holder);
 		}
-
-		xnlock_put_irqrestore(&nklock, s);
 	}
 #else /* !CONFIG_XENO_OPT_PERVASIVE */
-	p += sprintf(p, "hits=%lu\n", intr->intr_base.hits);
+	p += sprintf(p, "hits=%lu\n", __intr_get_hits(intr));
 #endif /* CONFIG_XENO_OPT_PERVASIVE */
 
+	xnlock_put_irqrestore(&nklock, s);
+
 	len = (p - page) - off;
 	if (len <= off + count)
 		*eof = 1;
@@ -512,7 +524,7 @@ int rt_intr_inquire(RT_INTR *intr, RT_IN
 	}
 
 	strcpy(info->name, intr->name);
-	info->hits = intr->intr_base.hits;
+	info->hits = __intr_get_hits(intr);
 	info->irq = intr->intr_base.irq;
 
       unlock_and_exit:

--------------040004030805090806070409--

