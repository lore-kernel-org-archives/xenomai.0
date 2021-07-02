From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 3/4] cobalt/intr: Enhance xnintr_attach with an initial cpumask
Date: Fri,  2 Jul 2021 16:27:46 +0200
Message-Id: <80351fde948c5a5eef253470b665ec92e5400559.1625236067.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1625236067.git.jan.kiszka@siemens.com>
References: <cover.1625236067.git.jan.kiszka@siemens.com>
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

From: Jan Kiszka <jan.kiszka@siemens.com>

This allows to start up interrupts with a specific affinity already set.
Will be used by a new RTDM service.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/cobalt/kernel/intr.h  |  2 +-
 kernel/cobalt/dovetail/intr.c | 13 +++++++++++--
 kernel/cobalt/ipipe/intr.c    | 20 ++++++++++++++++++--
 kernel/cobalt/rtdm/drvlib.c   |  2 +-
 4 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/include/cobalt/kernel/intr.h b/include/cobalt/kernel/intr.h
index 9177141cba..393ad96830 100644
--- a/include/cobalt/kernel/intr.h
+++ b/include/cobalt/kernel/intr.h
@@ -116,7 +116,7 @@ int xnintr_init(struct xnintr *intr,
 void xnintr_destroy(struct xnintr *intr);
 
 int xnintr_attach(struct xnintr *intr,
-		  void *cookie);
+		  void *cookie, const cpumask_t *cpumask);
 
 void xnintr_detach(struct xnintr *intr);
 
diff --git a/kernel/cobalt/dovetail/intr.c b/kernel/cobalt/dovetail/intr.c
index da36f74462..a9459b7a81 100644
--- a/kernel/cobalt/dovetail/intr.c
+++ b/kernel/cobalt/dovetail/intr.c
@@ -83,15 +83,24 @@ void xnintr_destroy(struct xnintr *intr)
 }
 EXPORT_SYMBOL_GPL(xnintr_destroy);
 
-int xnintr_attach(struct xnintr *intr, void *cookie)
+int xnintr_attach(struct xnintr *intr, void *cookie, const cpumask_t *cpumask)
 {
+	cpumask_t tmp_mask, *effective_mask;
 	int ret;
 
 	secondary_mode_only();
 
 	intr->cookie = cookie;
 
-	ret = irq_set_affinity_hint(intr->irq, &xnsched_realtime_cpus);
+	if (!cpumask) {
+		effective_mask = &xnsched_realtime_cpus;
+	} else {
+		effective_mask = &tmp_mask;
+		cpumask_and(effective_mask, &xnsched_realtime_cpus, cpumask);
+		if (cpumask_empty(effective_mask))
+			return -EINVAL;
+	}
+	ret = irq_set_affinity_hint(intr->irq, effective_mask);
 	if (ret)
 		return ret;
 
diff --git a/kernel/cobalt/ipipe/intr.c b/kernel/cobalt/ipipe/intr.c
index 29adf1a7ae..378c7f07d5 100644
--- a/kernel/cobalt/ipipe/intr.c
+++ b/kernel/cobalt/ipipe/intr.c
@@ -828,6 +828,9 @@ EXPORT_SYMBOL_GPL(xnintr_destroy);
  * @param cookie A user-defined opaque value which is stored into the
  * descriptor for further retrieval by the interrupt handler.
  *
+ * @param cpumask Initial CPU affinity of the interrupt. If NULL, affinity is
+ * set to all real-time CPUs.
+ *
  * @return 0 is returned on success. Otherwise:
  *
  * - -EINVAL is returned if an error occurred while attaching the
@@ -843,8 +846,11 @@ EXPORT_SYMBOL_GPL(xnintr_destroy);
  * @note Attaching an interrupt descriptor resets the tracked number
  * of IRQ receipts to zero.
  */
-int xnintr_attach(struct xnintr *intr, void *cookie)
+int xnintr_attach(struct xnintr *intr, void *cookie, const cpumask_t *cpumask)
 {
+#ifdef CONFIG_SMP
+	cpumask_t tmp_mask, *effective_mask;
+#endif
 	int ret;
 
 	secondary_mode_only();
@@ -854,7 +860,17 @@ int xnintr_attach(struct xnintr *intr, void *cookie)
 	clear_irqstats(intr);
 
 #ifdef CONFIG_SMP
-	ipipe_set_irq_affinity(intr->irq, xnsched_realtime_cpus);
+	if (!cpumask) {
+		effective_mask = &xnsched_realtime_cpus;
+	} else {
+		effective_mask = &tmp_mask;
+		cpumask_and(effective_mask, &xnsched_realtime_cpus, cpumask);
+		if (cpumask_empty(effective_mask))
+			return -EINVAL;
+	}
+	ret = ipipe_set_irq_affinity(intr->irq, *effective_mask);
+	if (ret)
+		return ret;
 #endif /* CONFIG_SMP */
 
 	raw_spin_lock(&intr->lock);
diff --git a/kernel/cobalt/rtdm/drvlib.c b/kernel/cobalt/rtdm/drvlib.c
index 2394212846..e97a475c9a 100644
--- a/kernel/cobalt/rtdm/drvlib.c
+++ b/kernel/cobalt/rtdm/drvlib.c
@@ -1455,7 +1455,7 @@ int rtdm_irq_request(rtdm_irq_t *irq_handle, unsigned int irq_no,
 	if (err)
 		return err;
 
-	err = xnintr_attach(irq_handle, arg);
+	err = xnintr_attach(irq_handle, arg, NULL);
 	if (err) {
 		xnintr_destroy(irq_handle);
 		return err;
-- 
2.26.2


