From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 19/25] cobalt/timer: dovetail: handle ONESHOT_STOPPED mode
Date: Thu, 20 May 2021 23:44:29 +0200
Message-Id: <f657ad6aff37bd5a2038163fa11b25309e4a0e3a.1621547075.git.jan.kiszka@siemens.com>
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

From: Hongzhan Chen <hongzhan.chen@intel.com>

Force the next tick to be programmed in the hardware as a result of
leaving the ONESHOT_STOPPED

Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/cobalt/kernel/dovetail/pipeline/tick.h | 4 ++++
 kernel/cobalt/dovetail/tick.c                  | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/include/cobalt/kernel/dovetail/pipeline/tick.h b/include/cobalt/kernel/dovetail/pipeline/tick.h
index 409581a3cb..8ac4760ecd 100644
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
index 41aaa151a8..502ec27b22 100644
--- a/kernel/cobalt/dovetail/tick.c
+++ b/kernel/cobalt/dovetail/tick.c
@@ -84,6 +84,11 @@ void xn_core_tick(struct clock_event_device *dummy) /* hard irqs off */
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
@@ -105,6 +110,7 @@ static int proxy_set_oneshot_stopped(struct clock_event_device *proxy_dev)
 	xnlock_get_irqsave(&nklock, s);
 	sched = xnsched_current();
 	xntimer_stop(&sched->htimer);
+	sched->lflags |= XNTSTOP;
 
 	if (sched->lflags & XNIDLE) {
 		real_dev = dev->real_device;
-- 
2.26.2


