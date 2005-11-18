Message-ID: <437E044E.1030503@domain.hid>
Date: Fri, 18 Nov 2005 18:41:50 +0200
From: Heikki Lindholm <holindho@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090001030404040803000901"
Subject: [Xenomai-core] [PATCH] xenomai 2.1 ppc64 i-pipe support
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
--------------090001030404040803000901
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Xenomai 2.1:

- Add ppc64 I-pipe kernel support

-- Heikki Lindholm

--------------090001030404040803000901
Content-Type: text/plain; x-mac-type="0"; x-mac-creator="0";
	name="xenomai2.1-051118-ipipe-ppc64.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xenomai2.1-051118-ipipe-ppc64.patch"

diff -Nru xenomai/include/asm-powerpc/system.h xenomai-devel/include/asm-powerpc/system.h
--- xenomai/include/asm-powerpc/system.h	2005-11-08 09:43:39.000000000 +0200
+++ xenomai-devel/include/asm-powerpc/system.h	2005-11-17 12:51:47.000000000 +0200
@@ -127,10 +127,17 @@
 #endif /* CONFIG_PPC64 */
 #else /* !CONFIG_ADEOS_CORE */
 #define xnarch_fault_pf_p(fi)   ((fi)->exception == IPIPE_TRAP_ACCESS)
+#ifdef CONFIG_PPC64
+#define xnarch_fault_bp_p(fi)   ((current->ptrace & PT_PTRACED) && \
+				 ((fi)->exception == IPIPE_TRAP_IABR || \
+				  (fi)->exception == IPIPE_TRAP_SSTEP || \
+				  (fi)->exception == IPIPE_TRAP_PERFMON))
+#else /* !CONFIG_PPC64 */
 #define xnarch_fault_bp_p(fi)   ((current->ptrace & PT_PTRACED) && \
 				 ((fi)->exception == IPIPE_TRAP_IABR || \
 				  (fi)->exception == IPIPE_TRAP_SSTEP || \
 				  (fi)->exception == IPIPE_TRAP_DEBUG))
+#endif /* CONFIG_PPC64 */
 #endif /* CONFIG_ADEOS_CORE */
 
 #define xnarch_fault_notify(fi) (!xnarch_fault_bp_p(fi))
diff -Nru xenomai/ksrc/arch/powerpc/switch_64.S xenomai-devel/ksrc/arch/powerpc/switch_64.S
--- xenomai/ksrc/arch/powerpc/switch_64.S	2005-11-08 09:44:47.000000000 +0200
+++ xenomai-devel/ksrc/arch/powerpc/switch_64.S	2005-11-17 12:52:06.000000000 +0200
@@ -24,7 +24,6 @@
 #include <asm/processor.h>
 #include <asm/cputable.h>
 #include <asm/page.h>
-#include <asm/offsets.h>
 #include <asm/ppc_asm.h>
 
 #define RTHAL_SAVEREG(reg, pos)	std reg,STACK_FRAME_OVERHEAD+8*(pos)(r1)

--------------090001030404040803000901--

