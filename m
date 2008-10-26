Resent-To: xenomai-core <xenomai@xenomai.org>
Resent-Message-Id: <490482DC.2090908@domain.hid>
Message-Id: <20081026144352.338906449@domain.hid>
Date: Sun, 26 Oct 2008 15:43:53 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
References: <20081026144351.950914436@domain.hid>
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH 2/3] NMI watchdog support for x86-64
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
Cc: Jan Kiszka <jan.kiszka@domain.hid>


No need to lock the NMI away from x86-64 boxes, it just takes a bit
refactoring.

NOTE: Whoever applies this to SVN, make sure to MOVE nmi_32.c to nmi.c!

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 include/asm-x86/hal.h      |    2 
 include/asm-x86/hal_32.h   |    2 
 ksrc/arch/x86/Kconfig      |    4 
 ksrc/arch/x86/Makefile     |    4 
 ksrc/arch/x86/hal-common.c |   49 ++++++
 ksrc/arch/x86/hal_32.c     |   45 ------
 ksrc/arch/x86/nmi.c        |  326 +++++++++++++++++++++++++++++++++++++++++++++
 ksrc/arch/x86/nmi_32.c     |  326 ---------------------------------------------
 8 files changed, 379 insertions(+), 379 deletions(-)

Index: b/include/asm-x86/hal.h
===================================================================
--- a/include/asm-x86/hal.h
+++ b/include/asm-x86/hal.h
@@ -69,6 +69,8 @@ typedef int (*compat_emutick_t)(unsigned
 
 extern enum rthal_ktimer_mode rthal_ktimer_saved_mode;
 
+void rthal_latency_above_max(struct pt_regs *regs);
+
 #ifdef __i386__
 #include "hal_32.h"
 #else
Index: b/include/asm-x86/hal_32.h
===================================================================
--- a/include/asm-x86/hal_32.h
+++ b/include/asm-x86/hal_32.h
@@ -228,6 +228,4 @@ static inline void rthal_setup_oneshot_a
 
 long rthal_strncpy_from_user(char *dst, const char __user * src, long count);
 
-void rthal_latency_above_max(struct pt_regs *regs);
-
 #endif /* !_XENO_ASM_X86_HAL_32_H */
Index: b/ksrc/arch/x86/Kconfig
===================================================================
--- a/ksrc/arch/x86/Kconfig
+++ b/ksrc/arch/x86/Kconfig
@@ -26,8 +26,6 @@ config XENO_HW_FPU
 	Float-Point Unit on the x86 platform at the following URL:
 	http://www.intel.com/design/intarch/techinfo/Pentium/fpu.htm
 
-if !X86_64
-
 menu "NMI watchdog"
 
 config XENO_HW_NMI_DEBUG_LATENCY
@@ -58,8 +56,6 @@ config XENO_HW_NMI_DEBUG_LATENCY_MAX
 
 endmenu
 
-endif
-
 menu "SMI workaround"
 
 config XENO_HW_SMI_DETECT_DISABLE
Index: b/ksrc/arch/x86/hal_32.c
===================================================================
--- a/ksrc/arch/x86/hal_32.c
+++ b/ksrc/arch/x86/hal_32.c
@@ -97,51 +97,6 @@ unsigned long rthal_timer_calibrate(void
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
-void die_nmi(struct pt_regs *regs, const char *msg)
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
-#endif /* Linux < 2.6 */
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
-		die_nmi(regs, buf);
-	}
-}
-
-#endif /* CONFIG_XENO_HW_NMI_DEBUG_LATENCY */
-
 #else /* !CONFIG_X86_LOCAL_APIC */
 
 unsigned long rthal_timer_calibrate(void)
Index: b/ksrc/arch/x86/hal-common.c
===================================================================
--- a/ksrc/arch/x86/hal-common.c
+++ b/ksrc/arch/x86/hal-common.c
@@ -278,6 +278,55 @@ void rthal_timer_release(int cpu)
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
+void die_nmi(struct pt_regs *regs, const char *msg)
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
+#endif /* Linux < 2.6 */
+
+#ifdef CONFIG_X86_64
+#include <asm/nmi.h>
+#define die_nmi(regs, msg)	die_nmi(msg, regs, 1)
+#endif /* CONFIG_X86_64 */
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
+		die_nmi(regs, buf);
+	}
+}
+
+#endif /* CONFIG_XENO_HW_NMI_DEBUG_LATENCY */
 
 #endif /* CONFIG_X86_LOCAL_APIC */
 
Index: b/ksrc/arch/x86/Makefile
===================================================================
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
 
Index: b/ksrc/arch/x86/nmi.c
===================================================================
--- /dev/null
+++ b/ksrc/arch/x86/nmi.c
@@ -0,0 +1,326 @@
+/**
+ *   @ingroup hal
+ *   @file
+ *
+ *   NMI watchdog for x86, from linux/arch/i386/kernel/nmi.c
+ *
+ *   Original authors:
+ *   Ingo Molnar, Mikael Pettersson, Pavel Machek.
+ *
+ *   Adaptation to Xenomai by Gilles Chanteperdrix
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation, Inc., 675 Mass Ave, Cambridge MA 02139,
+ *   USA; either version 2 of the License, or (at your option) any later
+ *   version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program; if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ */
+
+#include <linux/module.h>
+#include <linux/version.h>
+#include <linux/nmi.h>
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,19)
+#include <asm/intel_arch_perfmon.h>
+#endif /* Linux < 2.6.19 */
+#include <asm/nmi.h>
+#endif /* Linux < 2.6 */
+#include <asm/msr.h>
+#include <asm/xenomai/hal.h>
+
+#define NMI_WD_ARMED		0x0001
+#define NMI_WD_31BITS		0x1000
+#define NMI_WD_P4		0x2000
+#define NMI_WD_P6_OR_LATER	0x4000
+
+#define P4_ESCR_EVENT_SELECT(N) ((N)<<25)
+#define P4_ESCR_OS              (1<<3)
+#define P4_ESCR_USR             (1<<2)
+#define P4_CCCR_OVF_PMI0        (1<<26)
+#define P4_CCCR_OVF_PMI1        (1<<27)
+#define P4_CCCR_THRESHOLD(N)    ((N)<<20)
+#define P4_CCCR_COMPLEMENT      (1<<19)
+#define P4_CCCR_COMPARE         (1<<18)
+#define P4_CCCR_REQUIRED        (3<<16)
+#define P4_CCCR_ESCR_SELECT(N)  ((N)<<13)
+#define P4_CCCR_ENABLE          (1<<12)
+/* Set up IQ_COUNTER0 to behave like a clock, by having IQ_CCCR0 filter
+   CRU_ESCR0 (with any non-null event selector) through a complemented
+   max threshold. [IA32-Vol3, Section 14.9.9] */
+#define MSR_P4_IQ_COUNTER0      0x30C
+#define P4_NMI_CRU_ESCR0        (P4_ESCR_EVENT_SELECT(0x3F)|P4_ESCR_OS|P4_ESCR_USR)
+#define P4_NMI_IQ_CCCR0                                                 \
+	(P4_CCCR_OVF_PMI0|P4_CCCR_THRESHOLD(15)|P4_CCCR_COMPLEMENT|	\
+	 P4_CCCR_COMPARE|P4_CCCR_REQUIRED|P4_CCCR_ESCR_SELECT(4)|P4_CCCR_ENABLE)
+
+typedef union {
+	struct {
+		/* Xenomai watchdog data. */
+		unsigned int flags;
+		unsigned long perfctr_msr;
+		unsigned long long next_linux_check;
+		unsigned int p4_cccr_val;
+
+		unsigned early_shots;
+		unsigned long long tick_date;
+	};
+	char __pad[SMP_CACHE_BYTES];
+} rthal_nmi_wd_t ____cacheline_aligned;
+
+static rthal_nmi_wd_t rthal_nmi_wds[NR_CPUS];
+static void (*rthal_nmi_emergency) (struct pt_regs *);
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,19)
+#define MSR_ARCH_PERFMON_PERFCTR0	0xc1
+#define MSR_ARCH_PERFMON_PERFCTR1	0xc2
+static void (*rthal_linux_nmi_tick) (struct pt_regs *);
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0)
+#define MSR_P4_IQ_CCCR0		0x36C
+#define rthal_nmi_active (nmi_watchdog != NMI_NONE)
+static inline void wrmsrl(unsigned long msr, unsigned long long val)
+{
+	unsigned long lo, hi;
+	lo = (unsigned long)val;
+	hi = val >> 32;
+	wrmsr(msr, lo, hi);
+}
+#else /* Linux 2.6.0..18 */
+extern int nmi_active;
+#define rthal_nmi_active	nmi_active
+#endif /* Linux 2.6.0..18 */
+
+#else /* Linux >= 2.6.19 */
+static int (*rthal_linux_nmi_tick) (struct pt_regs *, unsigned);
+#define rthal_nmi_active	atomic_read(&nmi_active)
+#endif /* Linux >= 2.6.19 */
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,19)
+#define CALL_LINUX_NMI		rthal_linux_nmi_tick(regs)
+#define NMI_RETURN		return
+static void rthal_nmi_watchdog_tick(struct pt_regs *regs)
+#else /* Linux >= 2.6.19 */
+#define CALL_LINUX_NMI		rthal_linux_nmi_tick(regs, reason)
+#define NMI_RETURN		return 1
+static int rthal_nmi_watchdog_tick(struct pt_regs *regs, unsigned reason)
+#endif /* Linux >= 2.6.19 */
+{
+	int cpu = rthal_processor_id();
+	rthal_nmi_wd_t *wd = &rthal_nmi_wds[cpu];
+	unsigned long long now;
+
+	if (wd->flags & NMI_WD_ARMED) {
+		if (rthal_rdtsc() - wd->tick_date < rthal_maxlat_tsc) {
+			++wd->early_shots;
+			wd->next_linux_check = wd->tick_date + rthal_maxlat_tsc;
+		} else {
+			printk("NMI early shots: %d\n", wd->early_shots);
+			rthal_nmi_emergency(regs);
+		}
+	}
+
+	now = rthal_rdtsc();
+
+	if ((long long)(now - wd->next_linux_check) >= 0) {
+
+		CALL_LINUX_NMI;
+
+		do {
+			wd->next_linux_check += RTHAL_CPU_FREQ;
+		} while ((long long)(now - wd->next_linux_check) >= 0);
+	}
+
+	if (wd->flags & NMI_WD_P4) {
+		/*
+		 * P4 quirks:
+		 * - An overflown perfctr will assert its interrupt
+		 *   until the OVF flag in its CCCR is cleared.
+		 * - LVTPC is masked on interrupt and must be
+		 *   unmasked by the LVTPC handler.
+		 */
+		wrmsr(MSR_P4_IQ_CCCR0, wd->p4_cccr_val, 0);
+		apic_write(APIC_LVTPC, APIC_DM_NMI);
+	} else if (wd->flags & NMI_WD_P6_OR_LATER) {
+		/* P6 based Pentium M need to re-unmask
+		 * the apic vector but it doesn't hurt
+		 * other P6 variant.
+		 * ArchPerfom/Core Duo also needs this */
+		apic_write(APIC_LVTPC, APIC_DM_NMI);
+	}
+
+	if (wd->flags & NMI_WD_31BITS)
+		wrmsr(wd->perfctr_msr, (u32)(now - wd->next_linux_check), 0);
+	else
+		wrmsrl(wd->perfctr_msr, now - wd->next_linux_check);
+
+	NMI_RETURN;
+}
+
+#ifdef CONFIG_PROC_FS
+static int earlyshots_read_proc(char *page,
+				char **start,
+				off_t off, int count, int *eof, void *data)
+{
+	int i, len = 0;
+
+	for_each_online_cpu(i)
+		len += sprintf(page + len, "CPU#%d: %u\n",
+			       i, rthal_nmi_wds[i].early_shots);
+	len -= off;
+	if (len <= off + count)
+		*eof = 1;
+	*start = page + off;
+	if (len > count)
+		len = count;
+	if (len < 0)
+		len = 0;
+
+	return len;
+}
+#endif /* CONFIG_PROC_FS */
+
+int rthal_nmi_request(void (*emergency) (struct pt_regs *))
+{
+	unsigned long long next_linux_check;
+	unsigned long perfctr_msr;
+	unsigned int wd_flags = 0;
+	unsigned int p4_cccr_val = 0;
+	int i;
+
+	if (!rthal_nmi_active || !nmi_watchdog_tick)
+		return -ENODEV;
+
+	if (rthal_linux_nmi_tick)
+		return -EBUSY;
+
+	switch (boot_cpu_data.x86_vendor) {
+        case X86_VENDOR_AMD:
+		perfctr_msr = MSR_K7_PERFCTR0;
+		break;
+        case X86_VENDOR_INTEL:
+		if (cpu_has(&boot_cpu_data, X86_FEATURE_ARCH_PERFMON)) {
+			if (boot_cpu_data.x86 == 6 &&
+			    boot_cpu_data.x86_model == 14)
+				perfctr_msr = MSR_ARCH_PERFMON_PERFCTR0;
+			else
+				perfctr_msr = MSR_ARCH_PERFMON_PERFCTR1;
+			wd_flags = NMI_WD_P6_OR_LATER | NMI_WD_31BITS;
+		} else
+			switch (boot_cpu_data.x86) {
+	                case 6:
+				perfctr_msr = MSR_P6_PERFCTR0;
+				wd_flags = NMI_WD_P6_OR_LATER | NMI_WD_31BITS;
+				break;
+	                case 15:
+				perfctr_msr = MSR_P4_IQ_COUNTER0;
+				p4_cccr_val = P4_NMI_IQ_CCCR0;
+#ifdef CONFIG_SMP
+				if (smp_num_siblings == 2)
+					p4_cccr_val |= P4_CCCR_OVF_PMI1;
+#endif
+				break;
+	                default:
+				return -ENODEV;
+			}
+		break;
+        default:
+		return -ENODEV;
+	}
+
+	rthal_nmi_emergency = emergency;
+
+	next_linux_check = rthal_rdtsc() + RTHAL_CPU_FREQ;
+	for (i = 0; i < NR_CPUS; i++) {
+		rthal_nmi_wd_t *wd = &rthal_nmi_wds[i];
+
+		wd->flags = wd_flags;
+		wd->perfctr_msr = perfctr_msr;
+		wd->p4_cccr_val = p4_cccr_val;
+		wd->next_linux_check = next_linux_check;
+	}
+
+	rthal_linux_nmi_tick = nmi_watchdog_tick;
+	wmb();
+	nmi_watchdog_tick = &rthal_nmi_watchdog_tick;
+
+#ifdef CONFIG_PROC_FS
+	rthal_add_proc_leaf("nmi_early_shots",
+			    &earlyshots_read_proc,
+			    NULL, NULL, rthal_proc_root);
+#endif /* CONFIG_PROC_FS */
+
+	return 0;
+}
+
+void rthal_nmi_release(void)
+{
+	rthal_nmi_wd_t *wd = &rthal_nmi_wds[rthal_processor_id()];
+
+	if (!rthal_linux_nmi_tick)
+		return;
+
+#ifdef CONFIG_PROC_FS
+	remove_proc_entry("nmi_early_shots", rthal_proc_root);
+#endif /* CONFIG_PROC_FS */
+
+	if (wd->flags & NMI_WD_31BITS)
+		wrmsr(wd->perfctr_msr, (u32)(0 - RTHAL_CPU_FREQ), 0);
+	else
+		wrmsrl(wd->perfctr_msr, 0 - RTHAL_CPU_FREQ);
+	touch_nmi_watchdog();
+	wmb();
+	nmi_watchdog_tick = rthal_linux_nmi_tick;
+	rthal_linux_nmi_tick = NULL;
+}
+
+void rthal_nmi_arm(unsigned long delay)
+{
+	rthal_nmi_wd_t *wd = &rthal_nmi_wds[rthal_processor_id()];
+
+	if (!wd->perfctr_msr)
+		return;
+
+	/* If linux watchdog could tick now, make it tick now. */
+	if ((long long) (rthal_rdtsc() - wd->next_linux_check) >= 0) {
+		unsigned long flags;
+
+		/* Protect from an interrupt handler calling rthal_nmi_arm. */
+		rthal_local_irq_save(flags);
+		wd->flags &= ~NMI_WD_ARMED;
+		wmb();
+		if (wd->flags & NMI_WD_31BITS)
+			wrmsr(wd->perfctr_msr, (u32)-1, 0);
+		else
+			wrmsrl(wd->perfctr_msr, -1);
+		asm("nop");
+		rthal_local_irq_restore(flags);
+	}
+
+	wd->tick_date = rthal_rdtsc() + (delay - rthal_maxlat_tsc);
+	wmb();
+	if (wd->flags & NMI_WD_31BITS)
+		wrmsr(wd->perfctr_msr, (u32)(0 - delay), 0);
+	else
+		wrmsrl(wd->perfctr_msr, 0 - delay);
+	wmb();
+	wd->flags |= NMI_WD_ARMED;
+}
+
+void rthal_nmi_disarm(void)
+{
+	rthal_nmi_wds[rthal_processor_id()].flags &= ~NMI_WD_ARMED;
+}
+
+EXPORT_SYMBOL(rthal_nmi_request);
+EXPORT_SYMBOL(rthal_nmi_release);
+EXPORT_SYMBOL(rthal_nmi_arm);
+EXPORT_SYMBOL(rthal_nmi_disarm);
Index: b/ksrc/arch/x86/nmi_32.c
===================================================================
--- a/ksrc/arch/x86/nmi_32.c
+++ /dev/null
@@ -1,326 +0,0 @@
-/**
- *   @ingroup hal
- *   @file
- *
- *   NMI watchdog for x86, from linux/arch/i386/kernel/nmi.c
- *
- *   Original authors:
- *   Ingo Molnar, Mikael Pettersson, Pavel Machek.
- *
- *   Adaptation to Xenomai by Gilles Chanteperdrix
- *
- *   This program is free software; you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation, Inc., 675 Mass Ave, Cambridge MA 02139,
- *   USA; either version 2 of the License, or (at your option) any later
- *   version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY; without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *   GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program; if not, write to the Free Software
- *   Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
- */
-
-#include <linux/module.h>
-#include <linux/version.h>
-#include <linux/nmi.h>
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,19)
-#include <asm/intel_arch_perfmon.h>
-#endif /* Linux < 2.6.19 */
-#include <asm/nmi.h>
-#endif /* Linux < 2.6 */
-#include <asm/msr.h>
-#include <asm/xenomai/hal.h>
-
-#define NMI_WD_ARMED		0x0001
-#define NMI_WD_31BITS		0x1000
-#define NMI_WD_P4		0x2000
-#define NMI_WD_P6_OR_LATER	0x4000
-
-#define P4_ESCR_EVENT_SELECT(N) ((N)<<25)
-#define P4_ESCR_OS              (1<<3)
-#define P4_ESCR_USR             (1<<2)
-#define P4_CCCR_OVF_PMI0        (1<<26)
-#define P4_CCCR_OVF_PMI1        (1<<27)
-#define P4_CCCR_THRESHOLD(N)    ((N)<<20)
-#define P4_CCCR_COMPLEMENT      (1<<19)
-#define P4_CCCR_COMPARE         (1<<18)
-#define P4_CCCR_REQUIRED        (3<<16)
-#define P4_CCCR_ESCR_SELECT(N)  ((N)<<13)
-#define P4_CCCR_ENABLE          (1<<12)
-/* Set up IQ_COUNTER0 to behave like a clock, by having IQ_CCCR0 filter
-   CRU_ESCR0 (with any non-null event selector) through a complemented
-   max threshold. [IA32-Vol3, Section 14.9.9] */
-#define MSR_P4_IQ_COUNTER0      0x30C
-#define P4_NMI_CRU_ESCR0        (P4_ESCR_EVENT_SELECT(0x3F)|P4_ESCR_OS|P4_ESCR_USR)
-#define P4_NMI_IQ_CCCR0                                                 \
-	(P4_CCCR_OVF_PMI0|P4_CCCR_THRESHOLD(15)|P4_CCCR_COMPLEMENT|	\
-	 P4_CCCR_COMPARE|P4_CCCR_REQUIRED|P4_CCCR_ESCR_SELECT(4)|P4_CCCR_ENABLE)
-
-typedef union {
-	struct {
-		/* Xenomai watchdog data. */
-		unsigned int flags;
-		unsigned long perfctr_msr;
-		unsigned long long next_linux_check;
-		unsigned int p4_cccr_val;
-
-		unsigned early_shots;
-		unsigned long long tick_date;
-	};
-	char __pad[SMP_CACHE_BYTES];
-} rthal_nmi_wd_t ____cacheline_aligned;
-
-static rthal_nmi_wd_t rthal_nmi_wds[NR_CPUS];
-static void (*rthal_nmi_emergency) (struct pt_regs *);
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,19)
-#define MSR_ARCH_PERFMON_PERFCTR0	0xc1
-#define MSR_ARCH_PERFMON_PERFCTR1	0xc2
-static void (*rthal_linux_nmi_tick) (struct pt_regs *);
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0)
-#define MSR_P4_IQ_CCCR0		0x36C
-#define rthal_nmi_active (nmi_watchdog != NMI_NONE)
-static inline void wrmsrl(unsigned long msr, unsigned long long val)
-{
-	unsigned long lo, hi;
-	lo = (unsigned long)val;
-	hi = val >> 32;
-	wrmsr(msr, lo, hi);
-}
-#else /* Linux 2.6.0..18 */
-extern int nmi_active;
-#define rthal_nmi_active	nmi_active
-#endif /* Linux 2.6.0..18 */
-
-#else /* Linux >= 2.6.19 */
-static int (*rthal_linux_nmi_tick) (struct pt_regs *, unsigned);
-#define rthal_nmi_active	atomic_read(&nmi_active)
-#endif /* Linux >= 2.6.19 */
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,19)
-#define CALL_LINUX_NMI		rthal_linux_nmi_tick(regs)
-#define NMI_RETURN		return
-static void rthal_nmi_watchdog_tick(struct pt_regs *regs)
-#else /* Linux >= 2.6.19 */
-#define CALL_LINUX_NMI		rthal_linux_nmi_tick(regs, reason)
-#define NMI_RETURN		return 1
-static int rthal_nmi_watchdog_tick(struct pt_regs *regs, unsigned reason)
-#endif /* Linux >= 2.6.19 */
-{
-	int cpu = rthal_processor_id();
-	rthal_nmi_wd_t *wd = &rthal_nmi_wds[cpu];
-	unsigned long long now;
-
-	if (wd->flags & NMI_WD_ARMED) {
-		if (rthal_rdtsc() - wd->tick_date < rthal_maxlat_tsc) {
-			++wd->early_shots;
-			wd->next_linux_check = wd->tick_date + rthal_maxlat_tsc;
-		} else {
-			printk("NMI early shots: %d\n", wd->early_shots);
-			rthal_nmi_emergency(regs);
-		}
-	}
-
-	now = rthal_rdtsc();
-
-	if ((long long)(now - wd->next_linux_check) >= 0) {
-
-		CALL_LINUX_NMI;
-
-		do {
-			wd->next_linux_check += RTHAL_CPU_FREQ;
-		} while ((long long)(now - wd->next_linux_check) >= 0);
-	}
-
-	if (wd->flags & NMI_WD_P4) {
-		/*
-		 * P4 quirks:
-		 * - An overflown perfctr will assert its interrupt
-		 *   until the OVF flag in its CCCR is cleared.
-		 * - LVTPC is masked on interrupt and must be
-		 *   unmasked by the LVTPC handler.
-		 */
-		wrmsr(MSR_P4_IQ_CCCR0, wd->p4_cccr_val, 0);
-		apic_write(APIC_LVTPC, APIC_DM_NMI);
-	} else if (wd->flags & NMI_WD_P6_OR_LATER) {
-		/* P6 based Pentium M need to re-unmask
-		 * the apic vector but it doesn't hurt
-		 * other P6 variant.
-		 * ArchPerfom/Core Duo also needs this */
-		apic_write(APIC_LVTPC, APIC_DM_NMI);
-	}
-
-	if (wd->flags & NMI_WD_31BITS)
-		wrmsr(wd->perfctr_msr, (u32)(now - wd->next_linux_check), 0);
-	else
-		wrmsrl(wd->perfctr_msr, now - wd->next_linux_check);
-
-	NMI_RETURN;
-}
-
-#ifdef CONFIG_PROC_FS
-static int earlyshots_read_proc(char *page,
-				char **start,
-				off_t off, int count, int *eof, void *data)
-{
-	int i, len = 0;
-
-	for_each_online_cpu(i)
-		len += sprintf(page + len, "CPU#%d: %u\n",
-			       i, rthal_nmi_wds[i].early_shots);
-	len -= off;
-	if (len <= off + count)
-		*eof = 1;
-	*start = page + off;
-	if (len > count)
-		len = count;
-	if (len < 0)
-		len = 0;
-
-	return len;
-}
-#endif /* CONFIG_PROC_FS */
-
-int rthal_nmi_request(void (*emergency) (struct pt_regs *))
-{
-	unsigned long long next_linux_check;
-	unsigned long perfctr_msr;
-	unsigned int wd_flags = 0;
-	unsigned int p4_cccr_val = 0;
-	int i;
-
-	if (!rthal_nmi_active || !nmi_watchdog_tick)
-		return -ENODEV;
-
-	if (rthal_linux_nmi_tick)
-		return -EBUSY;
-
-	switch (boot_cpu_data.x86_vendor) {
-        case X86_VENDOR_AMD:
-		perfctr_msr = MSR_K7_PERFCTR0;
-		break;
-        case X86_VENDOR_INTEL:
-		if (cpu_has(&boot_cpu_data, X86_FEATURE_ARCH_PERFMON)) {
-			if (boot_cpu_data.x86 == 6 &&
-			    boot_cpu_data.x86_model == 14)
-				perfctr_msr = MSR_ARCH_PERFMON_PERFCTR0;
-			else
-				perfctr_msr = MSR_ARCH_PERFMON_PERFCTR1;
-			wd_flags = NMI_WD_P6_OR_LATER | NMI_WD_31BITS;
-		} else
-			switch (boot_cpu_data.x86) {
-	                case 6:
-				perfctr_msr = MSR_P6_PERFCTR0;
-				wd_flags = NMI_WD_P6_OR_LATER | NMI_WD_31BITS;
-				break;
-	                case 15:
-				perfctr_msr = MSR_P4_IQ_COUNTER0;
-				p4_cccr_val = P4_NMI_IQ_CCCR0;
-#ifdef CONFIG_SMP
-				if (smp_num_siblings == 2)
-					p4_cccr_val |= P4_CCCR_OVF_PMI1;
-#endif
-				break;
-	                default:
-				return -ENODEV;
-			}
-		break;
-        default:
-		return -ENODEV;
-	}
-
-	rthal_nmi_emergency = emergency;
-
-	next_linux_check = rthal_rdtsc() + RTHAL_CPU_FREQ;
-	for (i = 0; i < NR_CPUS; i++) {
-		rthal_nmi_wd_t *wd = &rthal_nmi_wds[i];
-
-		wd->flags = wd_flags;
-		wd->perfctr_msr = perfctr_msr;
-		wd->p4_cccr_val = p4_cccr_val;
-		wd->next_linux_check = next_linux_check;
-	}
-
-	rthal_linux_nmi_tick = nmi_watchdog_tick;
-	wmb();
-	nmi_watchdog_tick = &rthal_nmi_watchdog_tick;
-
-#ifdef CONFIG_PROC_FS
-	rthal_add_proc_leaf("nmi_early_shots",
-			    &earlyshots_read_proc,
-			    NULL, NULL, rthal_proc_root);
-#endif /* CONFIG_PROC_FS */
-
-	return 0;
-}
-
-void rthal_nmi_release(void)
-{
-	rthal_nmi_wd_t *wd = &rthal_nmi_wds[rthal_processor_id()];
-
-	if (!rthal_linux_nmi_tick)
-		return;
-
-#ifdef CONFIG_PROC_FS
-	remove_proc_entry("nmi_early_shots", rthal_proc_root);
-#endif /* CONFIG_PROC_FS */
-
-	if (wd->flags & NMI_WD_31BITS)
-		wrmsr(wd->perfctr_msr, (u32)(0 - RTHAL_CPU_FREQ), 0);
-	else
-		wrmsrl(wd->perfctr_msr, 0 - RTHAL_CPU_FREQ);
-	touch_nmi_watchdog();
-	wmb();
-	nmi_watchdog_tick = rthal_linux_nmi_tick;
-	rthal_linux_nmi_tick = NULL;
-}
-
-void rthal_nmi_arm(unsigned long delay)
-{
-	rthal_nmi_wd_t *wd = &rthal_nmi_wds[rthal_processor_id()];
-
-	if (!wd->perfctr_msr)
-		return;
-
-	/* If linux watchdog could tick now, make it tick now. */
-	if ((long long) (rthal_rdtsc() - wd->next_linux_check) >= 0) {
-		unsigned long flags;
-
-		/* Protect from an interrupt handler calling rthal_nmi_arm. */
-		rthal_local_irq_save(flags);
-		wd->flags &= ~NMI_WD_ARMED;
-		wmb();
-		if (wd->flags & NMI_WD_31BITS)
-			wrmsr(wd->perfctr_msr, (u32)-1, 0);
-		else
-			wrmsrl(wd->perfctr_msr, -1);
-		asm("nop");
-		rthal_local_irq_restore(flags);
-	}
-
-	wd->tick_date = rthal_rdtsc() + (delay - rthal_maxlat_tsc);
-	wmb();
-	if (wd->flags & NMI_WD_31BITS)
-		wrmsr(wd->perfctr_msr, (u32)(0 - delay), 0);
-	else
-		wrmsrl(wd->perfctr_msr, 0 - delay);
-	wmb();
-	wd->flags |= NMI_WD_ARMED;
-}
-
-void rthal_nmi_disarm(void)
-{
-	rthal_nmi_wds[rthal_processor_id()].flags &= ~NMI_WD_ARMED;
-}
-
-EXPORT_SYMBOL(rthal_nmi_request);
-EXPORT_SYMBOL(rthal_nmi_release);
-EXPORT_SYMBOL(rthal_nmi_arm);
-EXPORT_SYMBOL(rthal_nmi_disarm);


