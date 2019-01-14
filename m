From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH 1/5] cobalt/intr: vfile: do not assume all irqs are
 cobalt-managed
Date: Mon, 14 Jan 2019 18:35:18 +0100
Message-Id: <20190114173522.25750-1-rpm@xenomai.org>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>

Non-cobalt kernel code may hook interrupts using ipipe_request_irq()
directly, which means that xnintr_vec_first() cannot assume that
__ipipe_irq_cookie() always returns a valid xnintr struct for all
irqs.

We need to detect those irqs while iterating over the interrupt
namespace when pulling data from /proc files not to dereference
invalid memory.

Fixes:
/proc/xenomai/irq
/proc/xenomai/sched/stat
/proc/xenomai/sched/acct

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/cobalt/intr.c | 48 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 38 insertions(+), 10 deletions(-)

diff --git a/kernel/cobalt/intr.c b/kernel/cobalt/intr.c
index 184ffad13..ba6409ebb 100644
--- a/kernel/cobalt/intr.c
+++ b/kernel/cobalt/intr.c
@@ -449,6 +449,17 @@ out:
 	}
 }
 
+static inline bool cobalt_owns_irq(int irq)
+{
+	ipipe_irq_handler_t h;
+
+	h = __ipipe_irq_handler(&xnsched_realtime_domain, irq);
+
+	return h == xnintr_vec_handler ||
+		h == xnintr_edge_vec_handler ||
+		h == xnintr_irq_handler;
+}
+
 static inline int xnintr_irq_attach(struct xnintr *intr)
 {
 	struct xnintr_vector *vec = vectors + intr->irq;
@@ -538,9 +549,19 @@ struct xnintr_vector {
 
 static struct xnintr_vector vectors[IPIPE_NR_IRQS];
 
+static inline bool cobalt_owns_irq(int irq)
+{
+	ipipe_irq_handler_t h;
+
+	h = __ipipe_irq_handler(&xnsched_realtime_domain, irq);
+
+	return h == xnintr_irq_handler;
+}
+
 static inline struct xnintr *xnintr_vec_first(unsigned int irq)
 {
-	return __ipipe_irq_cookie(&xnsched_realtime_domain, irq);
+	return cobalt_owns_irq(irq) ?
+		__ipipe_irq_cookie(&xnsched_realtime_domain, irq) : NULL;
 }
 
 static inline struct xnintr *xnintr_vec_next(struct xnintr *prev)
@@ -1067,6 +1088,7 @@ static inline int format_irq_proc(unsigned int irq,
 				  struct xnvfile_regular_iterator *it)
 {
 	struct xnintr *intr;
+	struct irq_desc *d;
 	int cpu;
 
 	for_each_realtime_cpu(cpu)
@@ -1100,15 +1122,21 @@ static inline int format_irq_proc(unsigned int irq,
 
 	mutex_lock(&intrlock);
 
-	intr = xnintr_vec_first(irq);
-	if (intr) {
-		xnvfile_puts(it, "        ");
-
-		do {
-			xnvfile_putc(it, ' ');
-			xnvfile_puts(it, intr->name);
-			intr = xnintr_vec_next(intr);
-		} while (intr);
+	if (!cobalt_owns_irq(irq)) {
+		xnvfile_puts(it, "         ");
+		d = irq_to_desc(irq);
+		xnvfile_puts(it, d && d->name ? d->name : "-");
+	} else {
+		intr = xnintr_vec_first(irq);
+		if (intr) {
+			xnvfile_puts(it, "        ");
+
+			do {
+				xnvfile_putc(it, ' ');
+				xnvfile_puts(it, intr->name);
+				intr = xnintr_vec_next(intr);
+			} while (intr);
+		}
 	}
 
 	mutex_unlock(&intrlock);
-- 
2.17.2


