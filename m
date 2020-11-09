From: hongzha1 <hongzhan.chen@intel.com>
Subject: [PATCH 01/15] cobalt/sched: init RESCHEDULE_OOB_IPI and register
 interrupt handler
Date: Mon,  9 Nov 2020 02:50:13 -0500
Message-Id: <20201109075027.14760-1-hongzhan.chen@intel.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: jan.kiszka@siemens.com, xenomai@xenomai.org

create and register RESCHEDULE_OOB_IPI interrupt handler

Signed-off-by: hongzha1 <hongzhan.chen@intel.com>
---
 kernel/cobalt/sched.c | 38 +++++++++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 7 deletions(-)

diff --git a/kernel/cobalt/sched.c b/kernel/cobalt/sched.c
index f39becb90..36eff09d4 100644
--- a/kernel/cobalt/sched.c
+++ b/kernel/cobalt/sched.c
@@ -30,6 +30,13 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/cobalt-core.h>
 
+struct xn_machine_cpudata {
+};
+
+DEFINE_PER_CPU(struct xn_machine_cpudata, xn_machine_cpudata);
+
+static void xnsched_destroy(struct xnsched *sched);
+
 /**
  * @ingroup cobalt_core
  * @defgroup cobalt_core_sched Thread scheduling control
@@ -224,10 +231,18 @@ static void xnsched_init(struct xnsched *sched, int cpu)
 #endif /* CONFIG_XENO_OPT_WATCHDOG */
 }
 
+static irqreturn_t reschedule_interrupt(int irq, void *dev_id)
+{
+	__xnsched_run_handler();
+
+	return IRQ_HANDLED;
+}
+
 void xnsched_init_all(void)
 {
 	struct xnsched *sched;
 	int cpu;
+	int ret;
 
 	for_each_online_cpu(cpu) {
 		sched = &per_cpu(nksched, cpu);
@@ -235,12 +250,22 @@ void xnsched_init_all(void)
 	}
 
 #ifdef CONFIG_SMP
-#warning TODO
-/*	ipipe_request_irq(&xnsched_realtime_domain,
-			  IPIPE_RESCHEDULE_IPI,
-			  (ipipe_irq_handler_t)__xnsched_run_handler,
-			  NULL, NULL);*/
+	ret = __request_percpu_irq(RESCHEDULE_OOB_IPI,
+			reschedule_interrupt,
+			IRQF_OOB,
+			"Xenomai reschedule",
+			&xn_machine_cpudata);
+	if (ret)
+		goto cleanup_sched;
 #endif
+	return;
+
+cleanup_sched:
+	for_each_online_cpu(cpu) {
+		sched = xnsched_struct(cpu);
+		xnsched_destroy(sched);
+	}
+
 }
 
 static void xnsched_destroy(struct xnsched *sched)
@@ -262,8 +287,7 @@ void xnsched_destroy_all(void)
 	spl_t s;
 
 #ifdef CONFIG_SMP
-#warning TODO
-//	ipipe_free_irq(&xnsched_realtime_domain, IPIPE_RESCHEDULE_IPI);
+	free_percpu_irq(RESCHEDULE_OOB_IPI, &xn_machine_cpudata);
 #endif
 
 	xnlock_get_irqsave(&nklock, s);
-- 
2.17.1


