From: hongzha1 <hongzhan.chen@intel.com>
Subject: [PATCH 2/4][wip/dovetail] cobalt/timer: create and register
 TIMER_OOB_IPI handler
Date: Tue, 20 Oct 2020 03:15:10 -0400
Message-Id: <20201020071510.22908-1-hongzhan.chen@intel.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, jan.kiszka@siemens.com

1.create and register TIMER_OOB_IPI handler.
2.declare global xn_machine_cpudata so that it can be shared with
other irq request.

Signed-off-by: hongzha1 <hongzhan.chen@intel.com>

diff --git a/include/cobalt/kernel/sched.h b/include/cobalt/kernel/sched.h
index 1f5714fe0..d4f449e4a 100644
--- a/include/cobalt/kernel/sched.h
+++ b/include/cobalt/kernel/sched.h
@@ -31,6 +31,12 @@
 #include <cobalt/kernel/assert.h>
 #include <asm/xenomai/machine.h>
 
+
+struct xn_machine_cpudata {
+};
+
+DECLARE_PER_CPU(struct xn_machine_cpudata, xn_machine_cpudata);
+
 /**
  * @addtogroup cobalt_core_sched
  * @{
diff --git a/kernel/cobalt/init.c b/kernel/cobalt/init.c
index 9b1651528..563832738 100644
--- a/kernel/cobalt/init.c
+++ b/kernel/cobalt/init.c
@@ -37,6 +37,8 @@
 #include "posix/internal.h"
 #include "procfs.h"
 
+DEFINE_PER_CPU(struct xn_machine_cpudata, xn_machine_cpudata);
+EXPORT_PER_CPU_SYMBOL_GPL(xn_machine_cpudata);
 
 static DEFINE_PER_CPU(int, cobalt_escalate_devid);
 /**
diff --git a/kernel/cobalt/sched.c b/kernel/cobalt/sched.c
index 0a40d58d7..9f4e03919 100644
--- a/kernel/cobalt/sched.c
+++ b/kernel/cobalt/sched.c
@@ -30,11 +30,6 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/cobalt-core.h>
 
-struct xn_machine_cpudata {
-};
-
-DEFINE_PER_CPU(struct xn_machine_cpudata, xn_machine_cpudata);
-
 static void xnsched_destroy(struct xnsched *sched);
 
 /**
diff --git a/kernel/cobalt/timer.c b/kernel/cobalt/timer.c
index bcfe832d1..3a1f8e545 100644
--- a/kernel/cobalt/timer.c
+++ b/kernel/cobalt/timer.c
@@ -576,6 +576,13 @@ void __xntimer_set_affinity(struct xntimer *timer, struct xnsched *sched)
 }
 EXPORT_SYMBOL_GPL(__xntimer_set_affinity);
 
+static irqreturn_t clock_ipi_handler(int irq, void *dev_id)
+{
+	xnintr_core_clock_handler();
+
+	return IRQ_HANDLED;
+}
+
 int xntimer_setup_ipi(void)
 {
 #warning TODO
@@ -583,12 +590,18 @@ int xntimer_setup_ipi(void)
 				 IPIPE_HRTIMER_IPI,
 				 (ipipe_irq_handler_t)xnintr_core_clock_handler,
 				 NULL, NULL);*/
+	return __request_percpu_irq(TIMER_OOB_IPI,
+			clock_ipi_handler,
+			IRQF_OOB, "Xenomai timer IPI",
+			&xn_machine_cpudata);
 }
 
 void xntimer_release_ipi(void)
 {
 #warning TODO
 	//ipipe_free_irq(&xnsched_realtime_domain, IPIPE_HRTIMER_IPI);
+	free_percpu_irq(TIMER_OOB_IPI,
+			&xn_machine_cpudata);
 }
 
 #endif /* CONFIG_SMP */
-- 
2.17.1


