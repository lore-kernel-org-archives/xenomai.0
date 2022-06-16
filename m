From: Hongzhan Chen <hongzhan.chen@intel.com>
Subject: [Xenomai 3.1 PATCH v2] process: update clockfreq when receive
 corresponding event.
Date: Wed, 15 Jun 2022 20:18:49 -0400
Message-Id: <20220616001850.9276-1-hongzhan.chen@intel.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

1. When there is clockfreq param passed down via command line, we
   do not update clockfreq even if we receive event of updating clockfreq.
   Or else, we update the clockfreq with notified value.
2. At the same time, we would like to update clockfreq param showing
   in sys filesystem after apply updated clockfreq.

Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
---
 include/cobalt/kernel/init.h  |  2 ++
 kernel/cobalt/init.c          | 12 ++++++++++++
 kernel/cobalt/posix/process.c |  3 ++-
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/cobalt/kernel/init.h b/include/cobalt/kernel/init.h
index 41dd531a8..36d1ea290 100644
--- a/include/cobalt/kernel/init.h
+++ b/include/cobalt/kernel/init.h
@@ -51,4 +51,6 @@ void cobalt_remove_state_chain(struct notifier_block *nb);
 
 void cobalt_call_state_chain(enum cobalt_run_states newstate);
 
+void cobalt_update_clockfreq(unsigned long freq);
+
 #endif /* !_COBALT_KERNEL_INIT_H_ */
diff --git a/kernel/cobalt/init.c b/kernel/cobalt/init.c
index dbe321c3b..558030292 100644
--- a/kernel/cobalt/init.c
+++ b/kernel/cobalt/init.c
@@ -53,6 +53,16 @@ module_param_named(timerfreq, timerfreq_arg, ulong, 0444);
 static unsigned long clockfreq_arg;
 module_param_named(clockfreq, clockfreq_arg, ulong, 0444);
 
+static bool passed_clockfreq;
+
+void cobalt_update_clockfreq(unsigned long freq)
+{
+	if (!passed_clockfreq) {
+		xnclock_update_freq(freq);
+		clockfreq_arg = freq;
+	}
+}
+
 #ifdef CONFIG_SMP
 static unsigned long supported_cpus_arg = -1;
 module_param_named(supported_cpus, supported_cpus_arg, ulong, 0444);
@@ -150,6 +160,8 @@ static int __init mach_setup(void)
 
 	if (clockfreq_arg == 0)
 		clockfreq_arg = sysinfo.sys_hrclock_freq;
+	else
+		passed_clockfreq = clockfreq_arg != 0;
 
 	if (clockfreq_arg == 0) {
 		printk(XENO_ERR "null clock frequency? Aborting.\n");
diff --git a/kernel/cobalt/posix/process.c b/kernel/cobalt/posix/process.c
index 6d1c1c427..f762fef2e 100644
--- a/kernel/cobalt/posix/process.c
+++ b/kernel/cobalt/posix/process.c
@@ -38,6 +38,7 @@
 #include <linux/kallsyms.h>
 #include <linux/ipipe.h>
 #include <linux/ipipe_tickdev.h>
+#include <cobalt/kernel/init.h>
 #include <cobalt/kernel/sched.h>
 #include <cobalt/kernel/heap.h>
 #include <cobalt/kernel/synch.h>
@@ -1382,7 +1383,7 @@ static inline int handle_clockfreq_event(unsigned int *p)
 {
 	unsigned int newfreq = *p;
 
-	xnclock_update_freq(newfreq);
+	cobalt_update_clockfreq(newfreq);
 
 	return KEVENT_PROPAGATE;
 }
-- 
2.17.1


