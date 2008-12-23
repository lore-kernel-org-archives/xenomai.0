Resent-To: xenomai-core <xenomai@xenomai.org>
Resent-Message-Id: <49513831.9090608@domain.hid>
From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Tue, 23 Dec 2008 20:06:49 +0100
Message-ID: <20081223190649.26094.74676.stgit@domain.hid>
In-Reply-To: <20081223190649.26094.61372.stgit@domain.hid>
References: <20081223190649.26094.61372.stgit@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH v2 4/5] NMI watchdog support for x86-64
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

No need to lock the NMI away from x86-64 boxes, it just takes a bit
refactoring.

NOTE: Whoever applies this to SVN, make sure to MOVE nmi_32.c to nmi.c!

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

 include/asm-x86/hal.h             |    2 +
 include/asm-x86/hal_32.h          |    2 -
 ksrc/arch/x86/Kconfig             |    4 ---
 ksrc/arch/x86/Makefile            |    4 +-
 ksrc/arch/x86/hal-common.c        |   48 ++++++++++++++++++++++++++++++++++++
 ksrc/arch/x86/hal_32.c            |   49 -------------------------------------
 ksrc/arch/x86/{nmi_32.c => nmi.c} |    0 
 7 files changed, 52 insertions(+), 57 deletions(-)
 rename ksrc/arch/x86/{nmi_32.c => nmi.c} (100%)

diff --git a/include/asm-x86/hal.h b/include/asm-x86/hal.h
index 4df6bf6..158e3e6 100644
--- a/include/asm-x86/hal.h
+++ b/include/asm-x86/hal.h
@@ -69,6 +69,8 @@ typedef int (*compat_emutick_t)(unsigned long evt,
 
 extern enum rthal_ktimer_mode rthal_ktimer_saved_mode;
 
+void rthal_latency_above_max(struct pt_regs *regs);
+
 #ifdef __i386__
 #include "hal_32.h"
 #else
diff --git a/include/asm-x86/hal_32.h b/include/asm-x86/hal_32.h
index ddcec08..9a707d0 100644
--- a/include/asm-x86/hal_32.h
+++ b/include/asm-x86/hal_32.h
@@ -234,6 +234,4 @@ static inline void rthal_setup_oneshot_apic(int vector)
 
 long rthal_strncpy_from_user(char *dst, const char __user * src, long count);
 
-void rthal_latency_above_max(struct pt_regs *regs);
-
 #endif /* !_XENO_ASM_X86_HAL_32_H */
diff --git a/ksrc/arch/x86/Kconfig b/ksrc/arch/x86/Kconfig
index 865ade7..ad8a5de 100644
--- a/ksrc/arch/x86/Kconfig
+++ b/ksrc/arch/x86/Kconfig
@@ -27,8 +27,6 @@ config XENO_HW_FPU
 	Float-Point Unit on the x86 platform at the following URL:
 	http://www.intel.com/design/intarch/techinfo/Pentium/fpu.htm
 
-if !X86_64
-
 menu "NMI watchdog"
 
 config XENO_HW_NMI_DEBUG_LATENCY
@@ -59,8 +57,6 @@ config XENO_HW_NMI_DEBUG_LATENCY_MAX
 
 endmenu
 
-endif
-
 menu "SMI workaround"
 
 config XENO_HW_SMI_DETECT_DISABLE
diff --git a/ksrc/arch/x86/Makefile b/ksrc/arch/x86/Makefile
index 71cc8ec..3296206 100644
--- a/ksrc/arch/x86/Makefile
+++ b/ksrc/arch/x86/Makefile
@@ -12,7 +12,7 @@ obj-$(CONFIG_XENOMAI) += xeno_hal.o
 
 xeno_hal-y := hal_$(X86_MODE).o hal-common.o usercopy_$(X86_MODE).o
 
-xeno_hal-$(CONFIG_XENO_HW_NMI_DEBUG_LATENCY) += nmi_$(X86_MODE).o
+xeno_hal-$(CONFIG_XENO_HW_NMI_DEBUG_LATENCY) += nmi.o
 
 xeno_hal-$(CONFIG_XENO_HW_SMI_DETECT) += smi.o
 
@@ -28,7 +28,7 @@ O_TARGET := built-in.o
 
 obj-y := hal_32.o hal-common.o
 
-obj-$(CONFIG_XENO_HW_NMI_DEBUG_LATENCY) += nmi_32.o
+obj-$(CONFIG_XENO_HW_NMI_DEBUG_LATENCY) += nmi.o
 
 obj-$(CONFIG_XENO_HW_SMI_DETECT) += smi.o
 
diff --git a/ksrc/arch/x86/hal-common.c b/ksrc/arch/x86/hal-common.c
index 2b04dcf..315ce2a 100644
--- a/ksrc/arch/x86/hal-common.c
+++ b/ksrc/arch/x86/hal-common.c
@@ -278,6 +278,54 @@ void rthal_timer_release(int cpu)
 		rthal_timer_set_oneshot(0);
 }
 
+#ifdef CONFIG_XENO_HW_NMI_DEBUG_LATENCY
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0)
+
+#include <linux/vt_kern.h>
+
+extern void show_registers(struct pt_regs *regs);
+
+extern spinlock_t nmi_print_lock;
+
+void die_nmi(const char *msg, struct pt_regs *regs, int do_panic)
+{
+	spin_lock(&nmi_print_lock);
+	/*
+	 * We are in trouble anyway, lets at least try
+	 * to get a message out.
+	 */
+	bust_spinlocks(1);
+	printk(msg);
+	show_registers(regs);
+	printk("console shuts up ...\n");
+	console_silent();
+	spin_unlock(&nmi_print_lock);
+	bust_spinlocks(0);
+	do_exit(SIGSEGV);
+}
+
+#elif LINUX_VERSION_CODE < KERNEL_VERSION(2,6,27) && defined(CONFIG_X86_32)
+#define die_nmi(msg, regs, do_panic)	die_nmi(regs, msg)
+#else /* Linux >= 2.6.27 || CONFIG_X86_64 */
+#include <asm/nmi.h>
+#endif /* Linux >= 2.6.27 || CONFIG_X86_64*/
+
+void rthal_latency_above_max(struct pt_regs *regs)
+{
+	/* Try to report via latency tracer first, then fall back to panic. */
+	if (rthal_trace_user_freeze(rthal_maxlat_us, 1) < 0) {
+		char buf[128];
+
+		snprintf(buf,
+			 sizeof(buf),
+			 "NMI watchdog detected timer latency above %u us\n",
+			 rthal_maxlat_us);
+		die_nmi(buf, regs, 1);
+	}
+}
+
+#endif /* CONFIG_XENO_HW_NMI_DEBUG_LATENCY */
 
 #endif /* CONFIG_X86_LOCAL_APIC */
 
diff --git a/ksrc/arch/x86/hal_32.c b/ksrc/arch/x86/hal_32.c
index 79b7c83..026b03f 100644
--- a/ksrc/arch/x86/hal_32.c
+++ b/ksrc/arch/x86/hal_32.c
@@ -97,55 +97,6 @@ unsigned long rthal_timer_calibrate(void)
 	return rthal_imuldiv(dt, 20, RTHAL_CPU_FREQ);
 }
 
-#ifdef CONFIG_XENO_HW_NMI_DEBUG_LATENCY
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0)
-
-#include <linux/vt_kern.h>
-
-extern void show_registers(struct pt_regs *regs);
-
-extern spinlock_t nmi_print_lock;
-
-void die_nmi(const char *msg, struct pt_regs *regs, int do_panic)
-{
-	spin_lock(&nmi_print_lock);
-	/*
-	 * We are in trouble anyway, lets at least try
-	 * to get a message out.
-	 */
-	bust_spinlocks(1);
-	printk(msg);
-	show_registers(regs);
-	printk("console shuts up ...\n");
-	console_silent();
-	spin_unlock(&nmi_print_lock);
-	bust_spinlocks(0);
-	do_exit(SIGSEGV);
-}
-
-#elif LINUX_VERSION_CODE < KERNEL_VERSION(2,6,27)
-#define die_nmi(msg, regs, do_panic)	die_nmi(regs, msg)
-#else /* Linux >= 2.6.27 */
-#include <asm/nmi.h>
-#endif /* Linux >= 2.6.27 */
-
-void rthal_latency_above_max(struct pt_regs *regs)
-{
-	/* Try to report via latency tracer first, then fall back to panic. */
-	if (rthal_trace_user_freeze(rthal_maxlat_us, 1) < 0) {
-		char buf[128];
-
-		snprintf(buf,
-			 sizeof(buf),
-			 "NMI watchdog detected timer latency above %u us\n",
-			 rthal_maxlat_us);
-		die_nmi(buf, regs, 1);
-	}
-}
-
-#endif /* CONFIG_XENO_HW_NMI_DEBUG_LATENCY */
-
 #else /* !CONFIG_X86_LOCAL_APIC */
 
 unsigned long rthal_timer_calibrate(void)
diff --git a/ksrc/arch/x86/nmi_32.c b/ksrc/arch/x86/nmi.c
similarity index 100%
rename from ksrc/arch/x86/nmi_32.c
rename to ksrc/arch/x86/nmi.c


