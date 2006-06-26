Message-Id: <20060626172118.347530000@domain.hid>
References: <20060626172116.019532000@domain.hid>
Date: Mon, 26 Jun 2006 19:21:18 +0200
From: jan.kiszka@domain.hid
Content-Disposition: inline; filename=enhance-kernel-fault-report.patch
Subject: [Xenomai-core] [PATCH 2/6] Improve fault report
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

Introduce xnarch_fault_um() to test if a fault happened in user-mode and applies the new feature to report core and driver crashes more verbosely. 

---
 include/asm-generic/system.h |    5 +++++
 include/asm-sim/system.h     |    1 +
 include/asm-uvm/system.h     |    1 +
 ksrc/nucleus/pod.c           |   11 ++++++++++-
 4 files changed, 17 insertions(+), 1 deletion(-)

Index: xenomai/include/asm-generic/system.h
===================================================================
--- xenomai.orig/include/asm-generic/system.h
+++ xenomai/include/asm-generic/system.h
@@ -35,6 +35,7 @@
 #include <asm/uaccess.h>
 #include <asm/param.h>
 #include <asm/mmu_context.h>
+#include <asm/ptrace.h>
 #include <linux/config.h>
 #include <asm/xenomai/hal.h>
 #include <asm/xenomai/atomic.h>
@@ -52,6 +53,10 @@
 #define xnarch_trace_panic_freeze()	rthal_trace_panic_freeze()
 #define xnarch_trace_panic_dump()	rthal_trace_panic_dump()
 
+#ifndef xnarch_fault_um
+#define xnarch_fault_um(fi) user_mode(fi->regs)
+#endif
+
 #define module_param_value(parm) (parm)
 
 typedef unsigned long spl_t;
Index: xenomai/include/asm-sim/system.h
===================================================================
--- xenomai.orig/include/asm-sim/system.h
+++ xenomai/include/asm-sim/system.h
@@ -56,6 +56,7 @@ typedef void *xnarch_fltinfo_t;	/* Unuse
 #define xnarch_fault_code(fi)   0
 #define xnarch_fault_pc(fi)     0L
 #define xnarch_fault_notify(fi) 1
+#define xnarch_fault_um(fi)     0
 
 typedef int spl_t;
 
Index: xenomai/include/asm-uvm/system.h
===================================================================
--- xenomai.orig/include/asm-uvm/system.h
+++ xenomai/include/asm-uvm/system.h
@@ -192,6 +192,7 @@ typedef void *xnarch_fltinfo_t;	/* Unuse
 #define xnarch_fault_code(fi)   0
 #define xnarch_fault_pc(fi)     0L
 #define xnarch_fault_notify(fi) 1
+#define xnarch_fault_um(fi)     0
 
 typedef struct xnarch_heapcb {
 
Index: xenomai/ksrc/nucleus/pod.c
===================================================================
--- xenomai.orig/ksrc/nucleus/pod.c
+++ xenomai/ksrc/nucleus/pod.c
@@ -194,7 +194,16 @@ static int xnpod_fault_handler(xnarch_fl
 
 	if (xnpod_shadow_p()) {
 #ifdef CONFIG_XENO_OPT_DEBUG
-		if (xnarch_fault_notify(fltinfo))	/* Don't report debug traps */
+		if (!xnarch_fault_um(fltinfo)) {
+			xnarch_trace_panic_freeze();
+			xnprintf
+			    ("Switching %s to secondary mode after exception #%u in "
+			     "kernel-space at 0x%lx (pid %d)\n", thread->name,
+			     xnarch_fault_trap(fltinfo),
+			     xnarch_fault_pc(fltinfo),
+			     xnthread_user_pid(thread));
+			xnarch_trace_panic_dump();
+		} else if (xnarch_fault_notify(fltinfo)) /* Don't report debug traps */
 			xnprintf
 			    ("Switching %s to secondary mode after exception #%u from "
 			     "user-space at 0x%lx (pid %d)\n", thread->name,

--

