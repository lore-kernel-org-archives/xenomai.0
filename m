From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 2/2] x86: irq_pipeline: resolve conflict among users of HV
 callback vector
Date: Sat,  2 Apr 2022 12:47:11 +0200
Message-Id: <20220402104711.720244-2-rpm@xenomai.org>
In-Reply-To: <20220402104711.720244-1-rpm@xenomai.org>
References: <20220402104711.720244-1-rpm@xenomai.org>
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

Dovetail does not cope well with paravirtualization ATM, which is why
XEN depends on !IRQ_PIPELINE. For the same reason, there is no point
in adding any IRQ trampoline code for XEN_PVHVM.

Also, prevent CONFIG_HYPERV from being built if interrupt pipeling is
enabled, since the former depends on paravirtualization too.

Reported-by: Hongzhan Chen <hongzhan.chen@intel.com>
Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 arch/x86/kernel/irq_pipeline.c | 20 --------------------
 drivers/hv/Kconfig             |  3 ++-
 2 files changed, 2 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kernel/irq_pipeline.c b/arch/x86/kernel/irq_pipeline.c
index 56b28082c5ac..b05acd3db023 100644
--- a/arch/x86/kernel/irq_pipeline.c
+++ b/arch/x86/kernel/irq_pipeline.c
@@ -155,31 +155,11 @@ static void do_sysvec_inband(struct irq_desc *desc, struct pt_regs *regs)
 					regs);
 		break;
 #endif
-#ifdef CONFIG_HYPERV
-	case HYPERVISOR_CALLBACK_VECTOR:
-		run_sysvec_on_irqstack_cond(__sysvec_hyperv_callback,
-					regs);
-		break;
-	case HYPERV_REENLIGHTENMENT_VECTOR:
-		run_sysvec_on_irqstack_cond(__sysvec_hyperv_reenlightenment,
-					regs);
-		break;
-	case HYPERV_STIMER0_VECTOR:
-		run_sysvec_on_irqstack_cond(__sysvec_hyperv_stimer0,
-					regs);
-		break;
-#endif
 #ifdef CONFIG_ACRN_GUEST
 	case HYPERVISOR_CALLBACK_VECTOR:
 		run_sysvec_on_irqstack_cond(__sysvec_acrn_hv_callback,
 					regs);
 		break;
-#endif
-#ifdef CONFIG_XEN_PVHVM
-	case HYPERVISOR_CALLBACK_VECTOR:
-		run_sysvec_on_irqstack_cond(__sysvec_xen_hvm_callback,
-					regs);
-		break;
 #endif
 	case LOCAL_TIMER_VECTOR:
 		run_sysvec_on_irqstack_cond(__sysvec_apic_timer_interrupt,
diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index 0747a8f1fcee..9e7b1bb4084f 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -4,7 +4,8 @@ menu "Microsoft Hyper-V guest support"
 
 config HYPERV
 	tristate "Microsoft Hyper-V client drivers"
-	depends on ACPI && ((X86 && X86_LOCAL_APIC && HYPERVISOR_GUEST) \
+	depends on ACPI && !IRQ_PIPIPELINE && \
+		((X86 && X86_LOCAL_APIC && HYPERVISOR_GUEST) \
 		|| (ARM64 && !CPU_BIG_ENDIAN))
 	select PARAVIRT
 	select X86_HV_CALLBACK_VECTOR if X86
-- 
2.34.1


