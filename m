From: hongzha1 <hongzhan.chen@intel.com>
Subject: [PATCH 06/10] dovetail/pipeline: implement oob irq request and free
 and post for both TIMER_OOB_IPI and RESCHEDULE_OOB_IPI
Date: Mon, 11 Jan 2021 01:43:14 -0500
Message-Id: <20210111064318.6154-6-hongzhan.chen@intel.com>
In-Reply-To: <20210111064318.6154-1-hongzhan.chen@intel.com>
References: <20210111064318.6154-1-hongzhan.chen@intel.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai@xenomai.org

Signed-off-by: hongzha1 <hongzhan.chen@intel.com>
---
 .../kernel/dovetail/pipeline/pipeline.h       | 44 ++++++++++++++-----
 1 file changed, 34 insertions(+), 10 deletions(-)

diff --git a/include/cobalt/kernel/dovetail/pipeline/pipeline.h b/include/cobalt/kernel/dovetail/pipeline/pipeline.h
index 23c4a2c18..a345e1399 100644
--- a/include/cobalt/kernel/dovetail/pipeline/pipeline.h
+++ b/include/cobalt/kernel/dovetail/pipeline/pipeline.h
@@ -8,9 +8,12 @@
 #include <linux/irq_pipeline.h>
 #include <cobalt/kernel/assert.h>
 #include <asm/xenomai/features.h>
+#include <pipeline/machine.h>
 
 typedef unsigned long spl_t;
 
+extern void xnintr_core_clock_handler(void);
+
 /*
  * We only keep the LSB when testing in SMP mode in order to strip off
  * the recursion marker (0x2) the nklock may store there.
@@ -30,18 +33,29 @@ typedef unsigned long spl_t;
 
 #ifdef CONFIG_SMP
 
+static irqreturn_t reschedule_interrupt_handler(int irq, void *dev_id)
+{
+
+	/* Will reschedule from irq_exit_pipeline. */
+
+	return IRQ_HANDLED;
+}
+
+
 static inline int pipeline_request_resched_ipi(void (*handler)(void))
 {
 	/* Trap the out-of-band rescheduling interrupt. */
-	TODO();
-
-	return 0;
+	return __request_percpu_irq(RESCHEDULE_OOB_IPI,
+			reschedule_interrupt_handler,
+			IRQF_OOB,
+			"Xenomai reschedule",
+			&cobalt_machine_cpudata);
 }
 
 static inline void pipeline_free_resched_ipi(void)
 {
 	/* Release the out-of-band rescheduling interrupt. */
-	TODO();
+	free_percpu_irq(RESCHEDULE_OOB_IPI, &cobalt_machine_cpudata);
 }
 
 static inline void pipeline_send_resched_ipi(const struct cpumask *dest)
@@ -50,21 +64,31 @@ static inline void pipeline_send_resched_ipi(const struct cpumask *dest)
 	 * Trigger the out-of-band rescheduling interrupt on remote
 	 * CPU(s).
 	 */
-	TODO();
+	irq_pipeline_send_remote(RESCHEDULE_OOB_IPI, dest);
 }
 
+static irqreturn_t timer_ipi_interrupt_handler(int irq, void *dev_id)
+{
+	xnintr_core_clock_handler();
+
+	return IRQ_HANDLED;
+}
+
+
 static inline int pipeline_request_timer_ipi(void (*handler)(void))
 {
 	/* Trap the out-of-band timer interrupt. */
-	TODO();
-
-	return 0;
+	return __request_percpu_irq(TIMER_OOB_IPI,
+			timer_ipi_interrupt_handler,
+			IRQF_OOB, "Xenomai timer IPI",
+			&cobalt_machine_cpudata);
 }
 
 static inline void pipeline_free_timer_ipi(void)
 {
 	/* Release the out-of-band timer interrupt. */
-	TODO();
+	free_percpu_irq(TIMER_OOB_IPI,
+		&cobalt_machine_cpudata);
 }
 
 static inline void pipeline_send_timer_ipi(const struct cpumask *dest)
@@ -72,7 +96,7 @@ static inline void pipeline_send_timer_ipi(const struct cpumask *dest)
 	/*
 	 * Trigger the out-of-band timer interrupt on remote CPU(s).
 	 */
-	TODO();
+	irq_pipeline_send_remote(TIMER_OOB_IPI, dest);
 }
 
 #endif
-- 
2.17.1


