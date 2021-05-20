From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 20/25] cobalt/tick: dovetail: flatten the call stack to
 pipeline services
Date: Thu, 20 May 2021 23:44:30 +0200
Message-Id: <7252907b0fb3555abdb59a48832f7cae5651fa50.1621547075.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1621547075.git.jan.kiszka@siemens.com>
References: <cover.1621547075.git.jan.kiszka@siemens.com>
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

From: Philippe Gerum <rpm@xenomai.org>

Since we are dealing with pipeline specific code, we may flatten the
call stack by using the Dovetail API directly.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../kernel/dovetail/pipeline/pipeline.h       | 43 +------------------
 kernel/cobalt/dovetail/sched.c                |  8 ++++
 kernel/cobalt/dovetail/tick.c                 | 26 ++++++-----
 3 files changed, 26 insertions(+), 51 deletions(-)

diff --git a/include/cobalt/kernel/dovetail/pipeline/pipeline.h b/include/cobalt/kernel/dovetail/pipeline/pipeline.h
index bbd45d13b3..3cc7268d00 100644
--- a/include/cobalt/kernel/dovetail/pipeline/pipeline.h
+++ b/include/cobalt/kernel/dovetail/pipeline/pipeline.h
@@ -12,8 +12,6 @@
 
 typedef unsigned long spl_t;
 
-void xnintr_core_clock_handler(void);
-
 /*
  * We only keep the LSB when testing in SMP mode in order to strip off
  * the recursion marker (0x2) the nklock may store there.
@@ -33,19 +31,13 @@ void xnintr_core_clock_handler(void);
 
 #ifdef CONFIG_SMP
 
-static irqreturn_t reschedule_interrupt_handler(int irq, void *dev_id)
-{
-
-	/* Will reschedule from irq_exit_pipeline. */
-
-	return IRQ_HANDLED;
-}
+irqreturn_t pipeline_reschedule_ipi_handler(int irq, void *dev_id);
 
 static inline int pipeline_request_resched_ipi(void (*handler)(void))
 {
 	/* Trap the out-of-band rescheduling interrupt. */
 	return __request_percpu_irq(RESCHEDULE_OOB_IPI,
-			reschedule_interrupt_handler,
+			pipeline_reschedule_ipi_handler,
 			IRQF_OOB,
 			"Xenomai reschedule",
 			&cobalt_machine_cpudata);
@@ -66,28 +58,6 @@ static inline void pipeline_send_resched_ipi(const struct cpumask *dest)
 	irq_send_oob_ipi(RESCHEDULE_OOB_IPI, dest);
 }
 
-static irqreturn_t timer_ipi_interrupt_handler(int irq, void *dev_id)
-{
-	xnintr_core_clock_handler();
-
-	return IRQ_HANDLED;
-}
-
-static inline int pipeline_request_timer_ipi(void (*handler)(void))
-{
-	/* Trap the out-of-band timer interrupt. */
-	return __request_percpu_irq(TIMER_OOB_IPI,
-			timer_ipi_interrupt_handler,
-			IRQF_OOB, "Xenomai timer IPI",
-			&cobalt_machine_cpudata);
-}
-
-static inline void pipeline_free_timer_ipi(void)
-{
-	/* Release the out-of-band timer interrupt. */
-	free_percpu_irq(TIMER_OOB_IPI, &cobalt_machine_cpudata);
-}
-
 static inline void pipeline_send_timer_ipi(const struct cpumask *dest)
 {
 	/*
@@ -108,15 +78,6 @@ static inline void pipeline_free_resched_ipi(void)
 {
 }
 
-static inline int pipeline_request_timer_ipi(void (*handler)(void))
-{
-	return 0;
-}
-
-static inline void pipeline_free_timer_ipi(void)
-{
-}
-
 #endif	/* CONFIG_SMP */
 
 static inline void pipeline_prepare_panic(void)
diff --git a/kernel/cobalt/dovetail/sched.c b/kernel/cobalt/dovetail/sched.c
index 82e29136ca..de7c43b70c 100644
--- a/kernel/cobalt/dovetail/sched.c
+++ b/kernel/cobalt/dovetail/sched.c
@@ -75,3 +75,11 @@ void pipeline_clear_mayday(void) /* May solely affect current. */
 {
 	clear_thread_flag(TIF_MAYDAY);
 }
+
+irqreturn_t pipeline_reschedule_ipi_handler(int irq, void *dev_id)
+{
+
+	/* Will reschedule from irq_exit_pipeline(). */
+
+	return IRQ_HANDLED;
+}
diff --git a/kernel/cobalt/dovetail/tick.c b/kernel/cobalt/dovetail/tick.c
index 502ec27b22..81eaab84a8 100644
--- a/kernel/cobalt/dovetail/tick.c
+++ b/kernel/cobalt/dovetail/tick.c
@@ -79,12 +79,7 @@ static int proxy_set_next_ktime(ktime_t expires,
 	return ret ? -ETIME : 0;
 }
 
-void xn_core_tick(struct clock_event_device *dummy) /* hard irqs off */
-{
-	xnintr_core_clock_handler();
-}
-
-inline bool pipeline_must_force_program_tick(struct xnsched *sched)
+bool pipeline_must_force_program_tick(struct xnsched *sched)
 {
 	return sched->lflags & XNTSTOP;
 }
@@ -126,7 +121,8 @@ static void setup_proxy(struct clock_proxy_device *dev)
 {
 	struct clock_event_device *proxy_dev = &dev->proxy_device;
 
-	dev->handle_oob_event = xn_core_tick;
+	dev->handle_oob_event = (typeof(dev->handle_oob_event))
+		xnintr_core_clock_handler;
 	proxy_dev->features |= CLOCK_EVT_FEAT_KTIME;
 	proxy_dev->set_next_ktime = proxy_set_next_ktime;
 	if (proxy_dev->set_state_oneshot_stopped)
@@ -134,11 +130,21 @@ static void setup_proxy(struct clock_proxy_device *dev)
 	__this_cpu_write(proxy_device, dev);
 }
 
+static irqreturn_t tick_ipi_handler(int irq, void *dev_id)
+{
+	xnintr_core_clock_handler();
+
+	return IRQ_HANDLED;
+}
+
 int pipeline_install_tick_proxy(void)
 {
 	int ret;
 
-	ret = pipeline_request_timer_ipi(xnintr_core_clock_handler);
+	ret = __request_percpu_irq(TIMER_OOB_IPI,
+				tick_ipi_handler,
+				IRQF_OOB, "Xenomai timer IPI",
+				&cobalt_machine_cpudata);
 	if (ret)
 		return ret;
 
@@ -150,7 +156,7 @@ int pipeline_install_tick_proxy(void)
 	return 0;
 
 fail_proxy:
-	pipeline_free_timer_ipi();
+	free_percpu_irq(TIMER_OOB_IPI, &cobalt_machine_cpudata);
 
 	return ret;
 }
@@ -160,5 +166,5 @@ void pipeline_uninstall_tick_proxy(void)
 	/* Uninstall the proxy tick device. */
 	tick_uninstall_proxy(&xnsched_realtime_cpus);
 
-	pipeline_free_timer_ipi();
+	free_percpu_irq(TIMER_OOB_IPI, &cobalt_machine_cpudata);
 }
-- 
2.26.2


