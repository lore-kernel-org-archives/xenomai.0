From: hongzha1 <hongzhan.chen@intel.com>
Subject: [PATCH] cobalt/x86: raise escalate virq with irq_inject_pipeline
 instead of irq_post_oob
Date: Tue, 13 Oct 2020 03:45:59 -0400
Message-Id: <20201013074559.4535-1-hongzhan.chen@intel.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, jan.kiszka@siemens.com

Before calling irq_post_oob, interrupts must be hard disabled
in the cpu. But irq_inject_pipeline would handle it internally.

Signed-off-by: hongzha1 <hongzhan.chen@intel.com>

diff --git a/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h b/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h
index af3433e8e..46294036b 100644
--- a/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h
+++ b/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h
@@ -23,6 +23,7 @@
 #include <asm-generic/xenomai/thread.h>
 #include <asm/xenomai/wrappers.h>
 #include <asm/traps.h>
+#include <linux/irq_pipeline.h>
 
 #ifndef IPIPE_X86_FPU_EAGER
 #if LINUX_VERSION_CODE < KERNEL_VERSION(4,4,0)
@@ -90,7 +91,7 @@ static inline int xnarch_escalate(void)
 {
 	if (running_inband()) {
 		/* orginal xenomai domain equals oob stage */
-		irq_post_oob(cobalt_pipeline.escalate_virq);
+		irq_inject_pipeline(cobalt_pipeline.escalate_virq);
 		return 1;
 	}
 /*	if (ipipe_root_p) {
-- 
2.17.1


