From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 1/4] cobalt/intr: Fix cpumask argument type of xnintr_affinity
Date: Fri,  2 Jul 2021 16:27:44 +0200
Message-Id: <5df66fc604cd5643559ea7b174ec80f866bb6746.1625236067.git.jan.kiszka@siemens.com>
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

Passing a potentially large mask by value was a bad idea of I-pipe.
Dovetail uses the kernel API, and that does it right. So adjust our
internal abstraction - which is unused so far anyway.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/cobalt/kernel/intr.h  | 2 +-
 kernel/cobalt/dovetail/intr.c | 4 ++--
 kernel/cobalt/ipipe/intr.c    | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/cobalt/kernel/intr.h b/include/cobalt/kernel/intr.h
index 2636c2cbc5..6db4cfd905 100644
--- a/include/cobalt/kernel/intr.h
+++ b/include/cobalt/kernel/intr.h
@@ -125,7 +125,7 @@ void xnintr_enable(struct xnintr *intr);
 void xnintr_disable(struct xnintr *intr);
 
 void xnintr_affinity(struct xnintr *intr,
-		     cpumask_t cpumask);
+		     const cpumask_t *cpumask);
 
 #ifdef CONFIG_XENO_OPT_STATS_IRQS
 
diff --git a/kernel/cobalt/dovetail/intr.c b/kernel/cobalt/dovetail/intr.c
index 60d5bf882c..7953050fb0 100644
--- a/kernel/cobalt/dovetail/intr.c
+++ b/kernel/cobalt/dovetail/intr.c
@@ -118,12 +118,12 @@ void xnintr_disable(struct xnintr *intr)
 }
 EXPORT_SYMBOL_GPL(xnintr_disable);
 
-void xnintr_affinity(struct xnintr *intr, cpumask_t cpumask)
+void xnintr_affinity(struct xnintr *intr, const cpumask_t *cpumask)
 {
 	int ret;
 
 	secondary_mode_only();
-	ret = irq_set_affinity_hint(intr->irq, &cpumask);
+	ret = irq_set_affinity_hint(intr->irq, cpumask);
 
 	WARN_ON_ONCE(ret);
 }
diff --git a/kernel/cobalt/ipipe/intr.c b/kernel/cobalt/ipipe/intr.c
index 0c1cc4be45..0d2c515af8 100644
--- a/kernel/cobalt/ipipe/intr.c
+++ b/kernel/cobalt/ipipe/intr.c
@@ -992,11 +992,11 @@ EXPORT_SYMBOL_GPL(xnintr_disable);
  *
  * @coretags{secondary-only}
  */
-void xnintr_affinity(struct xnintr *intr, cpumask_t cpumask)
+void xnintr_affinity(struct xnintr *intr, const cpumask_t *cpumask)
 {
 	secondary_mode_only();
 #ifdef CONFIG_SMP
-	ipipe_set_irq_affinity(intr->irq, cpumask);
+	ipipe_set_irq_affinity(intr->irq, *cpumask);
 #endif
 }
 EXPORT_SYMBOL_GPL(xnintr_affinity);
-- 
2.26.2


