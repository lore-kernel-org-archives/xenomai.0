From: hongzha1 <hongzhan.chen@intel.com>
Subject: [PATCH][dovetail/wip] cobalt/init: init escalate irq with dovetail
 synthetic_irq_domain
Date: Sun, 11 Oct 2020 23:06:51 -0400
Message-Id: <20201012030651.8157-1-hongzhan.chen@intel.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, jan.kiszka@siemens.com

alloc escalate irq with dovetail synthetic_irq_domain and init and
raise it with irq_post_oob

Signed-off-by: hongzha1 <hongzhan.chen@intel.com>

diff --git a/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h b/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h
index 721d19537..af3433e8e 100644
--- a/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h
+++ b/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h
@@ -88,6 +88,11 @@ static inline void xnarch_enter_root(struct xnthread *root) { }
 
 static inline int xnarch_escalate(void)
 {
+	if (running_inband()) {
+		/* orginal xenomai domain equals oob stage */
+		irq_post_oob(cobalt_pipeline.escalate_virq);
+		return 1;
+	}
 /*	if (ipipe_root_p) {
 		ipipe_raise_irq(cobalt_pipeline.escalate_virq);
 		return 1;
diff --git a/kernel/cobalt/init.c b/kernel/cobalt/init.c
index ac3f45f67..bdf37f34a 100644
--- a/kernel/cobalt/init.c
+++ b/kernel/cobalt/init.c
@@ -30,11 +30,15 @@
 #include <cobalt/kernel/pipe.h>
 #include <cobalt/kernel/select.h>
 #include <cobalt/kernel/vdso.h>
+#include <linux/irqdomain.h>
+#include <linux/irq_pipeline.h>
 #include <rtdm/fd.h>
 #include "rtdm/internal.h"
 #include "posix/internal.h"
 #include "procfs.h"
 
+
+static DEFINE_PER_CPU(int, cobalt_escalate_devid);
 /**
  * @defgroup cobalt Cobalt
  *
@@ -134,10 +138,17 @@ static void sys_shutdown(void)
 	xnheap_vfree(membase);
 }
 
+static irqreturn_t cobalt_escalate_irq_handler(int sirq, void *dev_id)
+{
+	__xnsched_run_handler();
+
+	return IRQ_HANDLED;
+}
+
 static int __init mach_setup(void)
 {
 //	struct ipipe_sysinfo sysinfo;
-	int ret/*, virq*/;
+	int ret, virq;
 
 /*	ret = ipipe_select_timers(&xnsched_realtime_cpus);
 	if (ret < 0)
@@ -170,6 +181,25 @@ static int __init mach_setup(void)
 	}*/
 
 #warning TODO: irq init
+	/* init escalate irq */
+	ret = -EAGAIN;
+	virq = irq_create_direct_mapping(synthetic_irq_domain);
+	if (WARN_ON(virq == 0))
+		return ret;
+
+	ret = __request_percpu_irq(virq,
+			cobalt_escalate_irq_handler,
+			IRQF_OOB,
+			"cobalt escalate",
+			&cobalt_escalate_devid);
+	if (WARN_ON(ret)) {
+		irq_dispose_mapping(virq);
+		return ret;
+	}
+
+	cobalt_pipeline.escalate_virq = virq;
+
+
 /*	ipipe_register_head(&xnsched_realtime_domain, "Xenomai");
 
 	ret = -EBUSY;
@@ -203,6 +233,9 @@ static int __init mach_setup(void)
 	return 0;
 
 fail_clock:
+	free_percpu_irq(cobalt_pipeline.escalate_virq,
+			&cobalt_escalate_devid);
+	irq_dispose_mapping(cobalt_pipeline.escalate_virq);
 /*	ipipe_free_irq(&xnsched_realtime_domain,
 		       cobalt_pipeline.escalate_virq);
 	ipipe_free_virq(cobalt_pipeline.escalate_virq);
-- 
2.17.1


