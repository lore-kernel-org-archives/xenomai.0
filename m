From: hongzha1 <hongzhan.chen@intel.com>
Subject: [PATCH 7/8] dovetail/tick: pipeline: impmement
 pipeline_must_force_program_tick
Date: Thu, 14 Jan 2021 20:16:38 -0500
Message-Id: <20210115011639.15390-8-hongzhan.chen@intel.com>
In-Reply-To: <20210115011639.15390-1-hongzhan.chen@intel.com>
References: <20210115011639.15390-1-hongzhan.chen@intel.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

1. set XNTSTOP to force to program tick after the ONESHOT_STOPPED
   state
2. implement pipeline_must_force_program_tick for dovetail

Signed-off-by: hongzha1 <hongzhan.chen@intel.com>

diff --git a/include/cobalt/kernel/dovetail/pipeline/tick.h b/include/cobalt/kernel/dovetail/pipeline/tick.h
index 409581a3c..8ac4760ec 100644
--- a/include/cobalt/kernel/dovetail/pipeline/tick.h
+++ b/include/cobalt/kernel/dovetail/pipeline/tick.h
@@ -9,4 +9,8 @@ int pipeline_install_tick_proxy(void);
 
 void pipeline_uninstall_tick_proxy(void);
 
+struct xnsched;
+
+inline bool pipeline_must_force_program_tick(struct xnsched *sched);
+
 #endif /* !_COBALT_KERNEL_IPIPE_TICK_H */
diff --git a/kernel/cobalt/dovetail/tick.c b/kernel/cobalt/dovetail/tick.c
index bf267b9d9..8d6dc1812 100644
--- a/kernel/cobalt/dovetail/tick.c
+++ b/kernel/cobalt/dovetail/tick.c
@@ -96,6 +96,11 @@ void xn_core_tick(struct clock_event_device *dummy) /* hard irqs off */
 	xnintr_core_clock_handler();
 }
 
+inline bool pipeline_must_force_program_tick(struct xnsched *sched)
+{
+	return sched->lflags & XNTSTOP;
+}
+
 static int proxy_set_oneshot_stopped(struct clock_event_device *proxy_dev)
 {
 	struct clock_event_device *real_dev;
@@ -117,7 +122,7 @@ static int proxy_set_oneshot_stopped(struct clock_event_device *proxy_dev)
 	xnlock_get_irqsave(&nklock, s);
 	sched = xnsched_current();
 	xntimer_stop(&sched->htimer);
-	//sched->lflags |= XNTSTOP;
+	sched->lflags |= XNTSTOP;
 
 	if (sched->lflags & XNIDLE) {
 		real_dev = dev->real_device;
-- 
2.17.1


