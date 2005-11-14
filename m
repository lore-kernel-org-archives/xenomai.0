Message-ID: <43787801.5040101@domain.hid>
Date: Mon, 14 Nov 2005 13:41:53 +0200
From: Heikki Lindholm <holindho@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090400060501030801060200"
Subject: [Xenomai-core] [PATCH] Xenomai stable ppc64 I-pipe sync
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------090400060501030801060200
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Sync the ppc64 arch of the stable tree to work with I-pipe kernel also.

-- Heikki Lindholm

--------------090400060501030801060200
Content-Type: text/plain; x-mac-type="0"; x-mac-creator="0";
	name="xenomai-051108-ppc64-ipipe.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xenomai-051108-ppc64-ipipe.patch"

diff -Nru xenomai/arch/ppc64/hal/switch.S xenomai-devel/arch/ppc64/hal/switch.S
--- xenomai/arch/ppc64/hal/switch.S	2005-10-11 10:32:30.000000000 +0300
+++ xenomai-devel/arch/ppc64/hal/switch.S	2005-11-08 12:49:18.000000000 +0200
@@ -26,7 +26,6 @@
 #include <asm/processor.h>
 #include <asm/cputable.h>
 #include <asm/page.h>
-#include <asm/offsets.h>
 #include <asm/ppc_asm.h>
 #include <xeno_config.h> 
 
diff -Nru xenomai/include/nucleus/asm-ppc64/hal.h xenomai-devel/include/nucleus/asm-ppc64/hal.h
--- xenomai/include/nucleus/asm-ppc64/hal.h	2005-10-11 10:30:03.000000000 +0300
+++ xenomai-devel/include/nucleus/asm-ppc64/hal.h	2005-11-08 11:32:17.000000000 +0200
@@ -98,7 +98,11 @@
 #include <nucleus/asm/atomic.h>
 #include <asm/processor.h>
 
+#ifdef CONFIG_ADEOS_CORE
 #define RTHAL_TIMER_IRQ   ADEOS_TIMER_VIRQ
+#else /* !CONFIG_ADEOS_CORE */
+#define RTHAL_TIMER_IRQ   IPIPE_TIMER_VIRQ
+#endif /* CONFIG_ADEOS_CORE */
 
 #define rthal_irq_descp(irq)	(&irq_desc[(irq)])
 
diff -Nru xenomai/include/nucleus/asm-ppc64/system.h xenomai-devel/include/nucleus/asm-ppc64/system.h
--- xenomai/include/nucleus/asm-ppc64/system.h	2005-11-01 11:04:04.000000000 +0200
+++ xenomai-devel/include/nucleus/asm-ppc64/system.h	2005-11-08 11:35:38.000000000 +0200
@@ -31,10 +31,12 @@
 #include <linux/config.h>
 #include <linux/ptrace.h>
 
+#ifdef CONFIG_ADEOS_CORE
 #if ADEOS_RELEASE_NUMBER < 0x02060201
 #error "Adeos 2.6r2c1/ppc64 or above is required to run this software; please upgrade."
 #error "See http://download.gna.org/adeos/patches/v2.6/ppc64/"
 #endif
+#endif /* CONFIG_ADEOS_CORE */
 
 #define XNARCH_DEFAULT_TICK     1000000 /* ns, i.e. 1ms */
 #define XNARCH_HOST_TICK        (1000000000UL/HZ)
@@ -102,11 +104,19 @@
 
 /* The following predicates are only usable over a regular Linux stack
  *    context. */
+#ifdef CONFIG_ADEOS_CORE
 #define xnarch_fault_pf_p(fi)   ((fi)->exception == ADEOS_ACCESS_TRAP)
 #define xnarch_fault_bp_p(fi)   ((current->ptrace & PT_PTRACED) && \
 				((fi)->exception == ADEOS_IABR_TRAP || \
 				(fi)->exception == ADEOS_SSTEP_TRAP || \
 				(fi)->exception == ADEOS_PERFMON_TRAP))
+#else /* !CONFIG_ADEOS_CORE */
+#define xnarch_fault_pf_p(fi)   ((fi)->exception == IPIPE_TRAP_ACCESS)
+#define xnarch_fault_bp_p(fi)   ((current->ptrace & PT_PTRACED) && \
+				((fi)->exception == IPIPE_TRAP_IABR || \
+				(fi)->exception == IPIPE_TRAP_SSTEP || \
+				(fi)->exception == IPIPE_TRAP_PERFMON))
+#endif /* CONFIG_ADEOS_CORE */
 
 #define xnarch_fault_notify(fi) (!xnarch_fault_bp_p(fi))
 

--------------090400060501030801060200--

