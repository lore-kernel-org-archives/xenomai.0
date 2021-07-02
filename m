From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 2/4] cobalt/intr: Add error handling to xnintr_affinity
Date: Fri,  2 Jul 2021 16:27:45 +0200
Message-Id: <502f94fbd239762ad8f783f83eb78f233d8441cd.1625236067.git.jan.kiszka@siemens.com>
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

This function should respect the supported cpu set and report an error
if the specified set has no intersection with it. It should also return
potential errors for the underlying pipeline code.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/cobalt/kernel/intr.h  |  3 +--
 kernel/cobalt/dovetail/intr.c | 11 +++++++----
 kernel/cobalt/ipipe/intr.c    | 16 +++++++++++++---
 3 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/include/cobalt/kernel/intr.h b/include/cobalt/kernel/intr.h
index 6db4cfd905..9177141cba 100644
--- a/include/cobalt/kernel/intr.h
+++ b/include/cobalt/kernel/intr.h
@@ -124,8 +124,7 @@ void xnintr_enable(struct xnintr *intr);
 
 void xnintr_disable(struct xnintr *intr);
 
-void xnintr_affinity(struct xnintr *intr,
-		     const cpumask_t *cpumask);
+int xnintr_affinity(struct xnintr *intr, const cpumask_t *cpumask);
 
 #ifdef CONFIG_XENO_OPT_STATS_IRQS
 
diff --git a/kernel/cobalt/dovetail/intr.c b/kernel/cobalt/dovetail/intr.c
index 7953050fb0..da36f74462 100644
--- a/kernel/cobalt/dovetail/intr.c
+++ b/kernel/cobalt/dovetail/intr.c
@@ -118,13 +118,16 @@ void xnintr_disable(struct xnintr *intr)
 }
 EXPORT_SYMBOL_GPL(xnintr_disable);
 
-void xnintr_affinity(struct xnintr *intr, const cpumask_t *cpumask)
+int xnintr_affinity(struct xnintr *intr, const cpumask_t *cpumask)
 {
-	int ret;
+	cpumask_t effective_mask;
 
 	secondary_mode_only();
-	ret = irq_set_affinity_hint(intr->irq, cpumask);
 
-	WARN_ON_ONCE(ret);
+	cpumask_and(&effective_mask, &xnsched_realtime_cpus, cpumask);
+	if (cpumask_empty(&effective_mask))
+		return -EINVAL;
+
+	return irq_set_affinity_hint(intr->irq, &effective_mask);
 }
 EXPORT_SYMBOL_GPL(xnintr_affinity);
diff --git a/kernel/cobalt/ipipe/intr.c b/kernel/cobalt/ipipe/intr.c
index 0d2c515af8..29adf1a7ae 100644
--- a/kernel/cobalt/ipipe/intr.c
+++ b/kernel/cobalt/ipipe/intr.c
@@ -992,11 +992,21 @@ EXPORT_SYMBOL_GPL(xnintr_disable);
  *
  * @coretags{secondary-only}
  */
-void xnintr_affinity(struct xnintr *intr, const cpumask_t *cpumask)
+int xnintr_affinity(struct xnintr *intr, const cpumask_t *cpumask)
 {
-	secondary_mode_only();
 #ifdef CONFIG_SMP
-	ipipe_set_irq_affinity(intr->irq, *cpumask);
+	cpumask_t effective_mask;
+
+	secondary_mode_only();
+
+	cpumask_and(&effective_mask, &xnsched_realtime_cpus, cpumask);
+	if (cpumask_empty(&effective_mask))
+		return -EINVAL;
+
+	return ipipe_set_irq_affinity(intr->irq, effective_mask);
+#else
+	secondary_mode_only();
+	return 0;
 #endif
 }
 EXPORT_SYMBOL_GPL(xnintr_affinity);
-- 
2.26.2


