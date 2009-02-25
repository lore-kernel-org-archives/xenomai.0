Message-ID: <49A501D7.6070905@domain.hid>
Date: Wed, 25 Feb 2009 09:31:19 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: jan.kiszka@domain.hid
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-core] [RESEND][PATCH] Rework x86 NMI watchdog pass-through
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

Currently, Xenomai's NMI watchdog handler assumes to be called only on
watchdog events. Other reasons are considered spurious, and a TSC-based
method is used to detect such conditions. This has several issues
 - the return code of the Linux handler is ignored
 - KGDB's NMI events (CPU roundups) are not passed through
 - early_shot mechanism suffers from a signedness bug and misses too
   early shots
 - printk from NMI can cause lock-ups, but we also support non-fatal
   reports (ipipe tracer active)

This patch therefore switches to the watchdog detection pattern that
Linux uses: Check for the highest perfctr bit being zero for true
timeouts. In case the watchdog did not time out, the Linux handler is
invoked and its return code is properly forwarded. Finally, the
early_shot reporting is dropped as it becomes pointless when KGDB is in
use.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

 ksrc/arch/x86/nmi.c |   95 +++++++++++++++++++++++----------------------=
------
 1 files changed, 42 insertions(+), 53 deletions(-)

diff --git a/ksrc/arch/x86/nmi.c b/ksrc/arch/x86/nmi.c
index 69a392a..a9d9380 100644
--- a/ksrc/arch/x86/nmi.c
+++ b/ksrc/arch/x86/nmi.c
@@ -65,13 +65,11 @@
 typedef union {
 	struct {
 		/* Xenomai watchdog data. */
-		unsigned int flags;
-		unsigned long perfctr_msr;
 		unsigned long long next_linux_check;
+		unsigned long perfctr_msr;
+		u64 perfctr_checkmask;
 		unsigned int p4_cccr_val;
-
-		unsigned early_shots;
-		unsigned long long tick_date;
+		unsigned int flags;
 	};
 	char __pad[SMP_CACHE_BYTES];
 } rthal_nmi_wd_t ____cacheline_aligned;
@@ -82,6 +80,15 @@ static void (*rthal_nmi_emergency) (struct pt_regs *);
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,19)
 #define MSR_ARCH_PERFMON_PERFCTR0	0xc1
 #define MSR_ARCH_PERFMON_PERFCTR1	0xc2
+union cpuid10_eax {
+	struct {
+		unsigned int version_id:8;
+		unsigned int num_counters:8;
+		unsigned int bit_width:8;
+		unsigned int mask_length:8;
+	} split;
+	unsigned int full;
+};
 static void (*rthal_linux_nmi_tick) (struct pt_regs *);
=20
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0)
@@ -105,28 +112,28 @@ static int (*rthal_linux_nmi_tick) (struct pt_regs =
*, unsigned);
 #endif /* Linux >=3D 2.6.19 */
=20
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,19)
-#define CALL_LINUX_NMI		rthal_linux_nmi_tick(regs)
-#define NMI_RETURN		return
+#define CALL_LINUX_NMI		({ rthal_linux_nmi_tick(regs); 1; })
+#define NMI_RETURN(code)	return
 static void rthal_nmi_watchdog_tick(struct pt_regs *regs)
 #else /* Linux >=3D 2.6.19 */
 #define CALL_LINUX_NMI		rthal_linux_nmi_tick(regs, reason)
-#define NMI_RETURN		return 1
+#define NMI_RETURN(code)	return (code)
 static int rthal_nmi_watchdog_tick(struct pt_regs *regs, unsigned reason=
)
 #endif /* Linux >=3D 2.6.19 */
 {
 	int cpu =3D rthal_processor_id();
 	rthal_nmi_wd_t *wd =3D &rthal_nmi_wds[cpu];
 	unsigned long long now;
+	u64 perfctr;
=20
-	if (wd->flags & NMI_WD_ARMED) {
-		if (rthal_rdtsc() - wd->tick_date < rthal_maxlat_tsc) {
-			++wd->early_shots;
-			wd->next_linux_check =3D wd->tick_date + rthal_maxlat_tsc;
-		} else {
-			printk("NMI early shots: %d\n", wd->early_shots);
-			rthal_nmi_emergency(regs);
-		}
-	}
+	rdmsrl(wd->perfctr_msr, perfctr);
+
+	if (perfctr & wd->perfctr_checkmask)
+		/* No watchdog tick, let Linux handle it. */
+		NMI_RETURN(CALL_LINUX_NMI);
+
+	if (wd->flags & NMI_WD_ARMED)
+		rthal_nmi_emergency(regs);
=20
 	now =3D rthal_rdtsc();
=20
@@ -162,36 +169,14 @@ static int rthal_nmi_watchdog_tick(struct pt_regs *=
regs, unsigned reason)
 	else
 		wrmsrl(wd->perfctr_msr, now - wd->next_linux_check);
=20
-	NMI_RETURN;
+	NMI_RETURN(1);
 }
=20
-#ifdef CONFIG_PROC_FS
-static int earlyshots_read_proc(char *page,
-				char **start,
-				off_t off, int count, int *eof, void *data)
-{
-	int i, len =3D 0;
-
-	for_each_online_cpu(i)
-		len +=3D sprintf(page + len, "CPU#%d: %u\n",
-			       i, rthal_nmi_wds[i].early_shots);
-	len -=3D off;
-	if (len <=3D off + count)
-		*eof =3D 1;
-	*start =3D page + off;
-	if (len > count)
-		len =3D count;
-	if (len < 0)
-		len =3D 0;
-
-	return len;
-}
-#endif /* CONFIG_PROC_FS */
-
 int rthal_nmi_request(void (*emergency) (struct pt_regs *))
 {
 	unsigned long long next_linux_check;
 	unsigned long perfctr_msr;
+	u64 perfctr_checkmask;
 	unsigned int wd_flags =3D 0;
 	unsigned int p4_cccr_val =3D 0;
 	int i;
@@ -205,23 +190,30 @@ int rthal_nmi_request(void (*emergency) (struct pt_=
regs *))
 	switch (boot_cpu_data.x86_vendor) {
         case X86_VENDOR_AMD:
 		perfctr_msr =3D MSR_K7_PERFCTR0;
+		perfctr_checkmask =3D 1ULL << 47;
 		break;
         case X86_VENDOR_INTEL:
 		if (cpu_has(&boot_cpu_data, X86_FEATURE_ARCH_PERFMON)) {
+			union cpuid10_eax eax;
+
 			if (boot_cpu_data.x86 =3D=3D 6 &&
 			    boot_cpu_data.x86_model =3D=3D 14)
 				perfctr_msr =3D MSR_ARCH_PERFMON_PERFCTR0;
 			else
 				perfctr_msr =3D MSR_ARCH_PERFMON_PERFCTR1;
+			cpuid(10, &eax.full, &i, &i, &i);
+			perfctr_checkmask =3D 1ULL << (eax.split.bit_width - 1);
 			wd_flags =3D NMI_WD_P6_OR_LATER | NMI_WD_31BITS;
 		} else
 			switch (boot_cpu_data.x86) {
 	                case 6:
 				perfctr_msr =3D MSR_P6_PERFCTR0;
+				perfctr_checkmask =3D 1ULL << 39;
 				wd_flags =3D NMI_WD_P6_OR_LATER | NMI_WD_31BITS;
 				break;
 	                case 15:
 				perfctr_msr =3D MSR_P4_IQ_COUNTER0;
+				perfctr_checkmask =3D 1ULL << 39;
 				p4_cccr_val =3D P4_NMI_IQ_CCCR0;
 #ifdef CONFIG_SMP
 				if (smp_num_siblings =3D=3D 2)
@@ -244,6 +236,7 @@ int rthal_nmi_request(void (*emergency) (struct pt_re=
gs *))
=20
 		wd->flags =3D wd_flags;
 		wd->perfctr_msr =3D perfctr_msr;
+		wd->perfctr_checkmask =3D perfctr_checkmask;
 		wd->p4_cccr_val =3D p4_cccr_val;
 		wd->next_linux_check =3D next_linux_check;
 	}
@@ -252,12 +245,6 @@ int rthal_nmi_request(void (*emergency) (struct pt_r=
egs *))
 	wmb();
 	nmi_watchdog_tick =3D &rthal_nmi_watchdog_tick;
=20
-#ifdef CONFIG_PROC_FS
-	rthal_add_proc_leaf("nmi_early_shots",
-			    &earlyshots_read_proc,
-			    NULL, NULL, rthal_proc_root);
-#endif /* CONFIG_PROC_FS */
-
 	return 0;
 }
=20
@@ -269,10 +256,6 @@ void rthal_nmi_release(void)
 	if (!rthal_linux_nmi_tick)
 		return;
=20
-#ifdef CONFIG_PROC_FS
-	remove_proc_entry("nmi_early_shots", rthal_proc_root);
-#endif /* CONFIG_PROC_FS */
-
 	if (wd->flags & NMI_WD_31BITS)
 		wrmsr(wd->perfctr_msr, (u32)(0 - RTHAL_CPU_FREQ), 0);
 	else
@@ -299,6 +282,10 @@ void rthal_nmi_arm(unsigned long delay)
 		/* Protect from an interrupt handler calling rthal_nmi_arm. */
 		rthal_local_irq_save(flags);
 		wd->flags &=3D ~NMI_WD_ARMED;
+		/*
+		 * Our watchdog must be declared unarmed before we triger the
+		 * Linux watchdog NMI, entering rthal_nmi_watchdog_tick.
+		 */
 		wmb();
 		if (wd->flags & NMI_WD_31BITS)
 			wrmsr(wd->perfctr_msr, (u32)-1, 0);
@@ -308,12 +295,14 @@ void rthal_nmi_arm(unsigned long delay)
 		rthal_local_irq_restore(flags);
 	}
=20
-	wd->tick_date =3D rthal_rdtsc() + (delay - rthal_maxlat_tsc);
-	wmb();
 	if (wd->flags & NMI_WD_31BITS)
 		wrmsr(wd->perfctr_msr, (u32)(0 - delay), 0);
 	else
 		wrmsrl(wd->perfctr_msr, 0 - delay);
+	/*
+	 * New perfctr must have been written before we can declare the
+	 * watchdog armed (avoid race with previously programmed value).
+	 */
 	wmb();
 	wd->flags |=3D NMI_WD_ARMED;
 }

