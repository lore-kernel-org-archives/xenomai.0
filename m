Resent-To: xenomai-core <xenomai@xenomai.org>
Resent-Message-Id: <494B5F9E.70900@domain.hid>
From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Fri, 19 Dec 2008 09:44:47 +0100
Message-ID: <20081219084447.8148.16255.stgit@domain.hid>
In-Reply-To: <20081219084446.8148.89319.stgit@domain.hid>
References: <20081219084446.8148.89319.stgit@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH 1/3] Update NMI watchdog for latest Intel CPUs
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

Add performance-counter NMI watchdog support for recent Intel CPUs. This
should also fix potential overrun (corner) cases for P6-type CPUs as the
current code incorrectly assumes that more than 31 bits are available
as watchdog delay counter.

Refactor some dispatching paths at this chance.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

 include/asm-x86/bits/timer.h |    2 +-
 ksrc/arch/x86/nmi_32.c       |  128 ++++++++++++++++++++++++++----------------
 2 files changed, 81 insertions(+), 49 deletions(-)

diff --git a/include/asm-x86/bits/timer.h b/include/asm-x86/bits/timer.h
index b742763..d957c54 100644
--- a/include/asm-x86/bits/timer.h
+++ b/include/asm-x86/bits/timer.h
@@ -37,7 +37,7 @@ static inline void xnarch_program_timer_shot(unsigned long delay)
 #ifdef CONFIG_XENO_HW_NMI_DEBUG_LATENCY
 	{
 		extern unsigned long rthal_maxlat_tsc;
-		if (delay <= (ULONG_MAX - rthal_maxlat_tsc))
+		if (delay <= (LONG_MAX - rthal_maxlat_tsc))
 			rthal_nmi_arm(delay + rthal_maxlat_tsc);
 	}
 #endif /* CONFIG_XENO_HW_NMI_DEBUG_LATENCY */
diff --git a/ksrc/arch/x86/nmi_32.c b/ksrc/arch/x86/nmi_32.c
index f3b3290..78ba905 100644
--- a/ksrc/arch/x86/nmi_32.c
+++ b/ksrc/arch/x86/nmi_32.c
@@ -29,11 +29,19 @@
 #include <linux/version.h>
 #include <linux/nmi.h>
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,19)
+#include <asm/intel_arch_perfmon.h>
+#endif /* Linux < 2.6.19 */
 #include <asm/nmi.h>
 #endif /* Linux < 2.6 */
 #include <asm/msr.h>
 #include <asm/xenomai/hal.h>
 
+#define NMI_WD_ARMED		0x0001
+#define NMI_WD_31BITS		0x1000
+#define NMI_WD_P4		0x2000
+#define NMI_WD_P6_OR_LATER	0x4000
+
 #define P4_ESCR_EVENT_SELECT(N) ((N)<<25)
 #define P4_ESCR_OS              (1<<3)
 #define P4_ESCR_USR             (1<<2)
@@ -57,7 +65,7 @@
 typedef union {
 	struct {
 		/* Xenomai watchdog data. */
-		unsigned armed;
+		unsigned int flags;
 		unsigned long perfctr_msr;
 		unsigned long long next_linux_check;
 		unsigned int p4_cccr_val;
@@ -69,11 +77,11 @@ typedef union {
 } rthal_nmi_wd_t ____cacheline_aligned;
 
 static rthal_nmi_wd_t rthal_nmi_wds[NR_CPUS];
-static unsigned long rthal_nmi_perfctr_msr;
-static unsigned int rthal_nmi_p4_cccr_val;
 static void (*rthal_nmi_emergency) (struct pt_regs *);
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,19)
+#define MSR_ARCH_PERFMON_PERFCTR0	0xc1
+#define MSR_ARCH_PERFMON_PERFCTR1	0xc2
 static void (*rthal_linux_nmi_tick) (struct pt_regs *);
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0)
@@ -96,23 +104,6 @@ static int (*rthal_linux_nmi_tick) (struct pt_regs *, unsigned);
 #define rthal_nmi_active	atomic_read(&nmi_active)
 #endif /* Linux >= 2.6.19 */
 
-static void rthal_touch_nmi_watchdog(void)
-{
-	unsigned long long next_linux_check;
-	int i;
-
-	next_linux_check = rthal_rdtsc() + RTHAL_CPU_FREQ;
-
-	for (i = 0; i < NR_CPUS; i++) {
-		rthal_nmi_wd_t *wd = &rthal_nmi_wds[i];
-
-		wd->perfctr_msr = rthal_nmi_perfctr_msr;
-		wd->p4_cccr_val = rthal_nmi_p4_cccr_val;
-		wd->armed = 0;
-		wd->next_linux_check = next_linux_check;
-	}
-}
-
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,19)
 #define CALL_LINUX_NMI		rthal_linux_nmi_tick(regs)
 #define NMI_RETURN		return
@@ -127,7 +118,7 @@ static int rthal_nmi_watchdog_tick(struct pt_regs *regs, unsigned reason)
 	rthal_nmi_wd_t *wd = &rthal_nmi_wds[cpu];
 	unsigned long long now;
 
-	if (wd->armed) {
+	if (wd->flags & NMI_WD_ARMED) {
 		if (rthal_rdtsc() - wd->tick_date < rthal_maxlat_tsc) {
 			++wd->early_shots;
 			wd->next_linux_check = wd->tick_date + rthal_maxlat_tsc;
@@ -148,7 +139,7 @@ static int rthal_nmi_watchdog_tick(struct pt_regs *regs, unsigned reason)
 		} while ((long long)(now - wd->next_linux_check) >= 0);
 	}
 
-	if (wd->perfctr_msr == MSR_P4_IQ_COUNTER0) {
+	if (wd->flags & NMI_WD_P4) {
 		/*
 		 * P4 quirks:
 		 * - An overflown perfctr will assert its interrupt
@@ -158,14 +149,19 @@ static int rthal_nmi_watchdog_tick(struct pt_regs *regs, unsigned reason)
 		 */
 		wrmsr(MSR_P4_IQ_CCCR0, wd->p4_cccr_val, 0);
 		apic_write(APIC_LVTPC, APIC_DM_NMI);
-	} else if (rthal_nmi_perfctr_msr == MSR_P6_PERFCTR0) {
-		/* Only P6 based Pentium M need to re-unmask
+	} else if (wd->flags & NMI_WD_P6_OR_LATER) {
+		/* P6 based Pentium M need to re-unmask
 		 * the apic vector but it doesn't hurt
-		 * other P6 variant */
+		 * other P6 variant.
+		 * ArchPerfom/Core Duo also needs this */
 		apic_write(APIC_LVTPC, APIC_DM_NMI);
 	}
-	
-	wrmsrl(wd->perfctr_msr, now - wd->next_linux_check);
+
+	if (wd->flags & NMI_WD_31BITS)
+		wrmsr(wd->perfctr_msr, (u32)(now - wd->next_linux_check), 0);
+	else
+		wrmsrl(wd->perfctr_msr, now - wd->next_linux_check);
+
 	NMI_RETURN;
 }
 
@@ -194,6 +190,12 @@ static int earlyshots_read_proc(char *page,
 
 int rthal_nmi_request(void (*emergency) (struct pt_regs *))
 {
+	unsigned long long next_linux_check;
+	unsigned long perfctr_msr;
+	unsigned int wd_flags = 0;
+	unsigned int p4_cccr_val = 0;
+	int i;
+
 	if (!rthal_nmi_active || !nmi_watchdog_tick)
 		return -ENODEV;
 
@@ -202,31 +204,50 @@ int rthal_nmi_request(void (*emergency) (struct pt_regs *))
 
 	switch (boot_cpu_data.x86_vendor) {
         case X86_VENDOR_AMD:
-		rthal_nmi_perfctr_msr = MSR_K7_PERFCTR0;
+		perfctr_msr = MSR_K7_PERFCTR0;
 		break;
         case X86_VENDOR_INTEL:
-		switch (boot_cpu_data.x86) {
-                case 6:
-			rthal_nmi_perfctr_msr = MSR_P6_PERFCTR0;
-			break;
-                case 15:
-			rthal_nmi_perfctr_msr = MSR_P4_IQ_COUNTER0;
-			rthal_nmi_p4_cccr_val = P4_NMI_IQ_CCCR0;
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
 #ifdef CONFIG_SMP
-			if (smp_num_siblings == 2)
-				rthal_nmi_p4_cccr_val |= P4_CCCR_OVF_PMI1;
+				if (smp_num_siblings == 2)
+					p4_cccr_val |= P4_CCCR_OVF_PMI1;
 #endif
-			break;
-                default:
-			return -ENODEV;
-		}
+				break;
+	                default:
+				return -ENODEV;
+			}
 		break;
         default:
 		return -ENODEV;
 	}
 
 	rthal_nmi_emergency = emergency;
-	rthal_touch_nmi_watchdog();
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
 	rthal_linux_nmi_tick = nmi_watchdog_tick;
 	wmb();
 	nmi_watchdog_tick = &rthal_nmi_watchdog_tick;
@@ -242,6 +263,8 @@ int rthal_nmi_request(void (*emergency) (struct pt_regs *))
 
 void rthal_nmi_release(void)
 {
+	rthal_nmi_wd_t *wd = &rthal_nmi_wds[rthal_processor_id()];
+
 	if (!rthal_linux_nmi_tick)
 		return;
 
@@ -249,7 +272,10 @@ void rthal_nmi_release(void)
 	remove_proc_entry("nmi_early_shots", rthal_proc_root);
 #endif /* CONFIG_PROC_FS */
 
-	wrmsrl(rthal_nmi_perfctr_msr, 0 - RTHAL_CPU_FREQ);
+	if (wd->flags & NMI_WD_31BITS)
+		wrmsr(wd->perfctr_msr, (u32)(0 - RTHAL_CPU_FREQ), 0);
+	else
+		wrmsrl(wd->perfctr_msr, 0 - RTHAL_CPU_FREQ);
 	touch_nmi_watchdog();
 	wmb();
 	nmi_watchdog_tick = rthal_linux_nmi_tick;
@@ -269,23 +295,29 @@ void rthal_nmi_arm(unsigned long delay)
 
 		/* Protect from an interrupt handler calling rthal_nmi_arm. */
 		rthal_local_irq_save(flags);
-		wd->armed = 0;
+		wd->flags &= ~NMI_WD_ARMED;
 		wmb();
-		wrmsrl(wd->perfctr_msr, -1);
+		if (wd->flags & NMI_WD_31BITS)
+			wrmsr(wd->perfctr_msr, (u32)-1, 0);
+		else
+			wrmsrl(wd->perfctr_msr, -1);
 		asm("nop");
 		rthal_local_irq_restore(flags);
 	}
 
 	wd->tick_date = rthal_rdtsc() + (delay - rthal_maxlat_tsc);
 	wmb();
-	wrmsrl(wd->perfctr_msr, 0 - delay);
+	if (wd->flags & NMI_WD_31BITS)
+		wrmsr(wd->perfctr_msr, (u32)(0 - delay), 0);
+	else
+		wrmsrl(wd->perfctr_msr, 0 - delay);
 	wmb();
-	wd->armed = 1;
+	wd->flags |= NMI_WD_ARMED;
 }
 
 void rthal_nmi_disarm(void)
 {
-	rthal_nmi_wds[rthal_processor_id()].armed = 0;
+	rthal_nmi_wds[rthal_processor_id()].flags &= ~NMI_WD_ARMED;
 }
 
 EXPORT_SYMBOL(rthal_nmi_request);


