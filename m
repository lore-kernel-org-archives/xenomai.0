From: Hongzhan Chen <hongzhan.chen@intel.com>
Subject: [linux-dovetail PATCH 1/2] x86: fix duplication definication issue in
 making allyesconfig
Date: Fri,  1 Apr 2022 23:09:18 -0400
Message-Id: <20220402030919.5104-1-hongzhan.chen@intel.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

When making allyesconfig, there is duplication definication issue.
To fix it, make them exclusive each other.

Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
---
 arch/x86/kernel/irq_pipeline.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/irq_pipeline.c b/arch/x86/kernel/irq_pipeline.c
index 8daac9f78ebe..624fad67fe56 100644
--- a/arch/x86/kernel/irq_pipeline.c
+++ b/arch/x86/kernel/irq_pipeline.c
@@ -138,13 +138,11 @@ static void do_sysvec_inband(struct irq_desc *desc)
 	case HYPERV_STIMER0_VECTOR:
 		__sysvec_hyperv_stimer0(regs);
 		break;
-#endif
-#ifdef CONFIG_ACRN_GUEST
+#elif defined CONFIG_ACRN_GUEST
 	case HYPERVISOR_CALLBACK_VECTOR:
 		__sysvec_acrn_hv_callback(regs);
 		break;
-#endif
-#ifdef CONFIG_XEN_PVHVM
+#elif defined CONFIG_XEN_PVHVM
 	case HYPERVISOR_CALLBACK_VECTOR:
 		__sysvec_xen_hvm_callback(regs);
 		break;
-- 
2.17.1


