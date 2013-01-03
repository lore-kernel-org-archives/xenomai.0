Message-ID: <50E59112.6080005@siemens.com>
Date: Thu, 03 Jan 2013 15:09:22 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <50E47751.1070005@siemens.com>
In-Reply-To: <50E47751.1070005@siemens.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [PATCH v3] nucleus: Convert intrlock to a sleeping Linux
	lock
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>
Cc: "Mauerer, Wolfgang" <wolfgang.mauerer@siemens.com>

Conceptually, all users of this lock are supposed to run over Linux
context already. Moreover, latest I-pipe patches complain that
ipipe_virtualize_irq is called with the Xenomai domain stalled which
invalidates that useful internal bug check.

So rework the locking for dumping scheduling statistics and convert
intrlock to a sleeping Linux variant to avoid the alarm. And to simplify
some code paths.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes in v3:
 - Fix OPT_STATS-less build

 include/nucleus/intr.h |    4 ++
 ksrc/nucleus/intr.c    |   84 +++++++++++++----------------------------------
 ksrc/nucleus/sched.c   |    6 +++
 3 files changed, 33 insertions(+), 61 deletions(-)

diff --git a/include/nucleus/intr.h b/include/nucleus/intr.h
index 20a625d..4105122 100644
--- a/include/nucleus/intr.h
+++ b/include/nucleus/intr.h
@@ -131,6 +131,10 @@ void xnintr_affinity(xnintr_t *intr,
 
 int xnintr_query_init(xnintr_iterator_t *iterator);
 
+void xnintr_put_query_lock(struct xnvfile *vfile);
+
+int xnintr_get_query_lock(struct xnvfile *vfile);
+
 int xnintr_query_next(int irq, xnintr_iterator_t *iterator,
 		      char *name_buf);
 
diff --git a/ksrc/nucleus/intr.c b/ksrc/nucleus/intr.c
index c75fcac..e623372 100644
--- a/ksrc/nucleus/intr.c
+++ b/ksrc/nucleus/intr.c
@@ -39,30 +39,12 @@
 
 #define XNINTR_MAX_UNHANDLED	1000
 
-DEFINE_PRIVATE_XNLOCK(intrlock);
+static DEFINE_BINARY_SEMAPHORE(intrlock);
 
-#ifdef CONFIG_XENO_OPT_STATS
-xnintr_t nkclock;	     /* Only for statistics */
 static int xnintr_count = 1; /* Number of attached xnintr objects + nkclock */
-static int xnintr_list_rev;  /* Modification counter of xnintr list */
-
-/* Both functions update xnintr_list_rev at the very end.
- * This guarantees that module.c::stat_seq_open() won't get
- * an up-to-date xnintr_list_rev and old xnintr_count. */
-
-static inline void xnintr_stat_counter_inc(void)
-{
-	xnintr_count++;
-	xnarch_memory_barrier();
-	xnintr_list_rev++;
-}
 
-static inline void xnintr_stat_counter_dec(void)
-{
-	xnintr_count--;
-	xnarch_memory_barrier();
-	xnintr_list_rev++;
-}
+#ifdef CONFIG_XENO_OPT_STATS
+xnintr_t nkclock;	     /* Only for statistics */
 
 static inline void xnintr_sync_stat_references(xnintr_t *intr)
 {
@@ -76,8 +58,6 @@ static inline void xnintr_sync_stat_references(xnintr_t *intr)
 	}
 }
 #else
-static inline void xnintr_stat_counter_inc(void) {}
-static inline void xnintr_stat_counter_dec(void) {}
 static inline void xnintr_sync_stat_references(xnintr_t *intr) {}
 #endif /* CONFIG_XENO_OPT_STATS */
 
@@ -709,7 +689,6 @@ EXPORT_SYMBOL_GPL(xnintr_destroy);
 int xnintr_attach(xnintr_t *intr, void *cookie)
 {
 	int ret;
-	spl_t s;
 
 	trace_mark(xn_nucleus, irq_attach, "irq %u name %s",
 		   intr->irq, intr->name);
@@ -721,7 +700,7 @@ int xnintr_attach(xnintr_t *intr, void *cookie)
 	xnarch_set_irq_affinity(intr->irq, nkaffinity);
 #endif /* CONFIG_SMP */
 
-	xnlock_get_irqsave(&intrlock, s);
+	down(&intrlock);
 
 	if (__testbits(intr->flags, XN_ISR_ATTACHED)) {
 		ret = -EBUSY;
@@ -733,9 +712,9 @@ int xnintr_attach(xnintr_t *intr, void *cookie)
 		goto out;
 
 	__setbits(intr->flags, XN_ISR_ATTACHED);
-	xnintr_stat_counter_inc();
+	xnintr_count++;
 out:
-	xnlock_put_irqrestore(&intrlock, s);
+	up(&intrlock);
 
 	return ret;
 }
@@ -775,11 +754,10 @@ EXPORT_SYMBOL_GPL(xnintr_attach);
 int xnintr_detach(xnintr_t *intr)
 {
 	int ret;
-	spl_t s;
 
 	trace_mark(xn_nucleus, irq_detach, "irq %u", intr->irq);
 
-	xnlock_get_irqsave(&intrlock, s);
+	down(&intrlock);
 
 	if (!__testbits(intr->flags, XN_ISR_ATTACHED)) {
 		ret = -EINVAL;
@@ -792,9 +770,9 @@ int xnintr_detach(xnintr_t *intr)
 	if (ret)
 		goto out;
 
-	xnintr_stat_counter_dec();
+	xnintr_count--;
  out:
-	xnlock_put_irqrestore(&intrlock, s);
+	up(&intrlock);
 
 	return ret;
 }
@@ -894,23 +872,21 @@ void xnintr_affinity(xnintr_t *intr, xnarch_cpumask_t cpumask)
 EXPORT_SYMBOL_GPL(xnintr_affinity);
 
 #ifdef CONFIG_XENO_OPT_STATS
+int xnintr_get_query_lock(struct xnvfile *vfile)
+{
+	return down_interruptible(&intrlock) ? -ERESTARTSYS : 0;
+}
+
+void xnintr_put_query_lock(struct xnvfile *vfile)
+{
+	up(&intrlock);
+}
+
 int xnintr_query_init(xnintr_iterator_t *iterator)
 {
 	iterator->cpu = -1;
 	iterator->prev = NULL;
 
-	/* The order is important here: first xnintr_list_rev then
-	 * xnintr_count.  On the other hand, xnintr_attach/detach()
-	 * update xnintr_count first and then xnintr_list_rev.  This
-	 * should guarantee that we can't get an up-to-date
-	 * xnintr_list_rev and old xnintr_count here. The other way
-	 * around is not a problem as xnintr_query() will notice this
-	 * fact later.  Should xnintr_list_rev change later,
-	 * xnintr_query() will trigger an appropriate error below. */
-
-	iterator->list_rev = xnintr_list_rev;
-	xnarch_memory_barrier();
-
 	return xnintr_count;
 }
 
@@ -919,20 +895,11 @@ int xnintr_query_next(int irq, xnintr_iterator_t *iterator, char *name_buf)
 	xnintr_t *intr;
 	xnticks_t last_switch;
 	int cpu_no = iterator->cpu + 1;
-	int err = 0;
-	spl_t s;
 
 	if (cpu_no == xnarch_num_online_cpus())
 		cpu_no = 0;
 	iterator->cpu = cpu_no;
 
-	xnlock_get_irqsave(&intrlock, s);
-
-	if (iterator->list_rev != xnintr_list_rev) {
-		err = -EAGAIN;
-		goto unlock_and_exit;
-	}
-
 	if (!iterator->prev) {
 		if (irq == XNARCH_TIMER_IRQ)
 			intr = &nkclock;
@@ -944,8 +911,7 @@ int xnintr_query_next(int irq, xnintr_iterator_t *iterator, char *name_buf)
 	if (!intr) {
 		cpu_no = -1;
 		iterator->prev = NULL;
-		err = -ENODEV;
-		goto unlock_and_exit;
+		return -ENODEV;
 	}
 
 	snprintf(name_buf, XNOBJECT_NAME_LEN, "IRQ%d: %s", irq, intr->name);
@@ -968,10 +934,7 @@ int xnintr_query_next(int irq, xnintr_iterator_t *iterator, char *name_buf)
 	if (cpu_no + 1 == xnarch_num_online_cpus())
 		iterator->prev = intr;
 
-     unlock_and_exit:
-	xnlock_put_irqrestore(&intrlock, s);
-
-	return err;
+	return 0;
 }
 #endif /* CONFIG_XENO_OPT_STATS */
 
@@ -983,7 +946,6 @@ static inline int format_irq_proc(unsigned int irq,
 				  struct xnvfile_regular_iterator *it)
 {
 	struct xnintr *intr;
-	spl_t s;
 
 	if (irq == XNARCH_TIMER_IRQ) {
 		xnvfile_puts(it, "         [timer]");
@@ -1005,7 +967,7 @@ static inline int format_irq_proc(unsigned int irq,
 		return 0;
 	}
 
-	xnlock_get_irqsave(&intrlock, s);
+	down(&intrlock);
 
 	intr = xnintr_shirq_first(irq);
 	if (intr) {
@@ -1018,7 +980,7 @@ static inline int format_irq_proc(unsigned int irq,
 		} while (intr);
 	}
 
-	xnlock_put_irqrestore(&intrlock, s);
+	up(&intrlock);
 
 	return 0;
 }
diff --git a/ksrc/nucleus/sched.c b/ksrc/nucleus/sched.c
index 61957e6..16a59f8 100644
--- a/ksrc/nucleus/sched.c
+++ b/ksrc/nucleus/sched.c
@@ -839,11 +839,17 @@ struct vfile_stat_data {
 
 static struct xnvfile_snapshot_ops vfile_stat_ops;
 
+static struct xnvfile_lock_ops vfile_stat_lockops = {
+	.get = xnintr_get_query_lock,
+	.put = xnintr_put_query_lock,
+};
+
 static struct xnvfile_snapshot stat_vfile = {
 	.privsz = sizeof(struct vfile_stat_priv),
 	.datasz = sizeof(struct vfile_stat_data),
 	.tag = &nkpod_struct.threadlist_tag,
 	.ops = &vfile_stat_ops,
+	.entry = { .lockops = &vfile_stat_lockops },
 };
 
 static int vfile_stat_rewind(struct xnvfile_snapshot_iterator *it)
-- 
1.7.3.4

