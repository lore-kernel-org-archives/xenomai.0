Message-ID: <499C5705.2070001@domain.hid>
Date: Wed, 18 Feb 2009 19:44:21 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [RFC][PATCH] Exclude CPUs from Xenomai use
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

This patch mitigates the scalability issue Xenomai faces due to global
locks, primarily nklock.

If you want to run Xenomai on a larger multicore platform side by side
with non-RT load, you may want to restrict RT tasks to a certain CPU
subset anyway. With this patch it is additionally possible to avoid any
Xenomai locking overhead on the non-RT CPUs that would otherwise be
caused by redirecting the host timer ticks through Xenomai's timer
subsystem. And the patch prevents that anyone can accidentally push an
RT task to an unsupported CPU by adjusting the possible affinity mask.
So in theory, you could scale the CPU number up to Linux' limits as long
as Xenomai is restricted to a reasonably small set of CPUs.

The set of supported Xenomai CPUs is controlled via a kernel parameter
of the HAL: xeno_hal.supported_cpus (CPU mask, initially set to all
CPUs). Dynamical adjustment is not supported in order to keep things
simple and minimally invasive.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

 include/asm-generic/hal.h    |   16 ++++++++++++++++
 include/asm-generic/system.h |    3 +++
 include/asm-sim/system.h     |    3 +++
 ksrc/arch/generic/hal.c      |   18 ++++++++++++++++++
 ksrc/arch/x86/hal-common.c   |   11 ++++++++---
 ksrc/nucleus/module.c        |   31 +++++++++++++++++++------------
 ksrc/nucleus/pod.c           |    9 +++++++--
 ksrc/nucleus/shadow.c        |   15 +++++++++++----
 8 files changed, 85 insertions(+), 21 deletions(-)

diff --git a/include/asm-generic/hal.h b/include/asm-generic/hal.h
index ad9011d..7628fff 100644
--- a/include/asm-generic/hal.h
+++ b/include/asm-generic/hal.h
@@ -465,6 +465,22 @@ int rthal_timer_request(void (*tick_handler)(void),
 
 void rthal_timer_release(int cpu);
 
+#ifdef CONFIG_SMP
+extern cpumask_t rthal_supported_cpus;
+
+static inline int rthal_cpu_supported(int cpu)
+{
+	return cpu_isset(cpu, rthal_supported_cpus);
+}
+#else  /* !CONFIG_SMP */
+#define rthal_supported_cpus CPU_MASK_ALL
+
+static inline int rthal_cpu_supported(int cpu)
+{
+	return 1;
+}
+#endif /* !CONFIG_SMP */
+
 #ifdef CONFIG_PROC_FS
 #include <linux/proc_fs.h>
 
diff --git a/include/asm-generic/system.h b/include/asm-generic/system.h
index ee66cca..91e896a 100644
--- a/include/asm-generic/system.h
+++ b/include/asm-generic/system.h
@@ -263,6 +263,9 @@ typedef cpumask_t xnarch_cpumask_t;
 #define xnarch_first_cpu(mask)			first_cpu(mask)
 #define XNARCH_CPU_MASK_ALL			CPU_MASK_ALL
 
+#define xnarch_supported_cpus			rthal_supported_cpus
+#define xnarch_cpu_supported(cpu)		rthal_cpu_supported(cpu)
+
 struct xnheap;
 
 typedef struct xnarch_heapcb {
diff --git a/include/asm-sim/system.h b/include/asm-sim/system.h
index cf3bee6..5162bef 100644
--- a/include/asm-sim/system.h
+++ b/include/asm-sim/system.h
@@ -120,6 +120,9 @@ typedef unsigned long xnarch_cpumask_t;
 #define xnarch_first_cpu(mask)           (ffnz(mask))
 #define XNARCH_CPU_MASK_ALL              (~0UL)
 
+#define xnarch_supported_cpus            (~0UL)
+#define xnarch_cpu_supported(cpu)        1
+
 #define xnarch_ullmod(ull,uld,rem)   ((*rem) = ((ull) % (uld)))
 #define xnarch_uldivrem(ull,uld,rem) ((u_long)xnarch_ulldiv((ull),(uld),(rem)))
 #define xnarch_uldiv(ull, d)         xnarch_uldivrem(ull, d, NULL)
diff --git a/ksrc/arch/generic/hal.c b/ksrc/arch/generic/hal.c
index 63304cb..99eca80 100644
--- a/ksrc/arch/generic/hal.c
+++ b/ksrc/arch/generic/hal.c
@@ -58,6 +58,14 @@ module_param_named(cpufreq, rthal_cpufreq_arg, ulong, 0444);
 unsigned long rthal_timerfreq_arg;
 module_param_named(timerfreq, rthal_timerfreq_arg, ulong, 0444);
 
+#ifdef CONFIG_SMP
+static unsigned long supported_cpus_arg = -1;
+module_param_named(supported_cpus, supported_cpus_arg, ulong, 0444);
+
+cpumask_t rthal_supported_cpus;
+EXPORT_SYMBOL(rthal_supported_cpus);
+#endif /* CONFIG_SMP */
+
 static struct {
 
     void (*handler) (void *cookie);
@@ -778,6 +786,16 @@ int rthal_init(void)
     if (err)
         goto out;
 
+#ifdef CONFIG_SMP
+    {
+        int cpu;
+        cpus_clear(rthal_supported_cpus);
+        for (cpu = 0; cpu < BITS_PER_LONG; cpu++)
+            if (supported_cpus_arg & (1 << cpu))
+                cpu_set(cpu, rthal_supported_cpus);
+    }
+#endif /* CONFIG_SMP */
+
     /* The arch-dependent support must have updated the frequency args
        as required. */
     rthal_tunables.cpu_freq = rthal_cpufreq_arg;
diff --git a/ksrc/arch/x86/hal-common.c b/ksrc/arch/x86/hal-common.c
index 43d97b7..19637b4 100644
--- a/ksrc/arch/x86/hal-common.c
+++ b/ksrc/arch/x86/hal-common.c
@@ -46,6 +46,8 @@ static struct {
 
 static void rthal_critical_sync(void)
 {
+	if (!rthal_cpu_supported(rthal_processor_id()))
+		return;
 	switch (rthal_sync_op) {
 	case RTHAL_SET_ONESHOT_XENOMAI:
 		rthal_setup_oneshot_apic(RTHAL_APIC_TIMER_VECTOR);
@@ -70,12 +72,14 @@ static void rthal_timer_set_oneshot(int rt_mode)
 	flags = rthal_critical_enter(rthal_critical_sync);
 	if (rt_mode) {
 		rthal_sync_op = RTHAL_SET_ONESHOT_XENOMAI;
-		rthal_setup_oneshot_apic(RTHAL_APIC_TIMER_VECTOR);
+		if (rthal_cpu_supported(rthal_processor_id()))
+			rthal_setup_oneshot_apic(RTHAL_APIC_TIMER_VECTOR);
 		if (rthal_ktimer_saved_mode != KTIMER_MODE_UNUSED)
 			__ipipe_tick_irq = RTHAL_TIMER_IRQ;
 	} else {
 		rthal_sync_op = RTHAL_SET_ONESHOT_LINUX;
-		rthal_setup_oneshot_apic(LOCAL_TIMER_VECTOR);
+		if (rthal_cpu_supported(rthal_processor_id()))
+			rthal_setup_oneshot_apic(LOCAL_TIMER_VECTOR);
 		__ipipe_tick_irq = RTHAL_HOST_TICK_IRQ;
 		/* We need to keep the timing cycle alive for the kernel. */
 		rthal_trigger_irq(RTHAL_HOST_TICK_IRQ);
@@ -89,7 +93,8 @@ static void rthal_timer_set_periodic(void)
 
 	flags = rthal_critical_enter(&rthal_critical_sync);
 	rthal_sync_op = RTHAL_SET_PERIODIC;
-	rthal_setup_periodic_apic(RTHAL_APIC_ICOUNT, LOCAL_TIMER_VECTOR);
+	if (rthal_cpu_supported(rthal_processor_id()))
+		rthal_setup_periodic_apic(RTHAL_APIC_ICOUNT, LOCAL_TIMER_VECTOR);
 	__ipipe_tick_irq = RTHAL_HOST_TICK_IRQ;
 	rthal_critical_exit(flags);
 }
diff --git a/ksrc/nucleus/module.c b/ksrc/nucleus/module.c
index 597ff50..1507e5e 100644
--- a/ksrc/nucleus/module.c
+++ b/ksrc/nucleus/module.c
@@ -418,17 +418,22 @@ static int __stat_seq_open(struct inode *inode,
 				break; /* line unused or end of chain */
 			}
 
-			stat_info->cpu = intr_iter.cpu;
-			stat_info->csw = intr_iter.hits;
-			stat_info->exectime_period = intr_iter.exectime_period;
-			stat_info->account_period = intr_iter.account_period;
-			stat_info->exectime_total = intr_iter.exectime_total;
-			stat_info->pid = 0;
-			stat_info->state =  0;
-			stat_info->ssw = 0;
-			stat_info->pf = 0;
-
-			iter->nentries++;
+			if (xnarch_cpu_supported(intr_iter.cpu)) {
+				stat_info->cpu = intr_iter.cpu;
+				stat_info->csw = intr_iter.hits;
+				stat_info->exectime_period =
+					intr_iter.exectime_period;
+				stat_info->account_period =
+					intr_iter.account_period;
+				stat_info->exectime_total =
+					intr_iter.exectime_total;
+				stat_info->pid = 0;
+				stat_info->state =  0;
+				stat_info->ssw = 0;
+				stat_info->pf = 0;
+
+				iter->nentries++;
+			}
 		}
 
 	seq = file->private_data;
@@ -1022,7 +1027,7 @@ static int affinity_write_proc(struct file *file,
 	for (cpu = 0; cpu < sizeof(val) * 8; cpu++, val >>= 1)
 		if (val & 1)
 			xnarch_cpu_set(cpu, new_affinity);
-	nkaffinity = new_affinity;
+	xnarch_cpus_and(nkaffinity, new_affinity, xnarch_supported_cpus);
 
 	return count;
 }
@@ -1237,6 +1242,8 @@ int __init __xeno_sys_init(void)
 
 	xeno_nucleus_status = 0;
 
+	xnarch_cpus_and(nkaffinity, nkaffinity, xnarch_supported_cpus);
+
 	return 0;
 
 #ifdef __KERNEL__
diff --git a/ksrc/nucleus/pod.c b/ksrc/nucleus/pod.c
index 842222d..7811df5 100644
--- a/ksrc/nucleus/pod.c
+++ b/ksrc/nucleus/pod.c
@@ -414,7 +414,8 @@ int xnpod_init(void)
 	for (cpu = 0; cpu < nr_cpus; ++cpu) {
 		sched = &pod->sched[cpu];
 		xnsched_init(sched, cpu);
-		appendq(&pod->threadq, &sched->rootcb.glink);
+		if (xnarch_cpu_supported(cpu))
+			appendq(&pod->threadq, &sched->rootcb.glink);
 	}
 
 	xnarch_hook_ipi(&xnpod_schedule_handler);
@@ -2653,6 +2654,9 @@ int xnpod_enable_timesource(void)
 
 	for (cpu = 0; cpu < xnarch_num_online_cpus(); cpu++) {
 
+		if (!xnarch_cpu_supported(cpu))
+			continue;
+
 		sched = xnpod_sched_slot(cpu);
 
 		htickval = xnarch_start_timer(&xnintr_clock_handler, cpu);
@@ -2743,7 +2747,8 @@ void xnpod_disable_timesource(void)
 	   timer, since this could cause deadlock situations to arise
 	   on SMP systems. */
 	for (cpu = 0; cpu < xnarch_num_online_cpus(); cpu++)
-		xnarch_stop_timer(cpu);
+		if (xnarch_cpu_supported(cpu))
+			xnarch_stop_timer(cpu);
 
 	xntimer_freeze();
 
diff --git a/ksrc/nucleus/shadow.c b/ksrc/nucleus/shadow.c
index 4a0f021..1dedd85 100644
--- a/ksrc/nucleus/shadow.c
+++ b/ksrc/nucleus/shadow.c
@@ -1222,6 +1222,11 @@ int xnshadow_map(xnthread_t *thread, xncompletion_t __user *u_completion,
 		}
 	}
 
+	/* Restrict affinity to a single CPU of nkaffinity & current set. */
+	xnarch_cpus_and(affinity, current->cpus_allowed, nkaffinity);
+	affinity = xnarch_cpumask_of_cpu(xnarch_first_cpu(affinity));
+	set_cpus_allowed(current, affinity);
+
 	trace_mark(xn_nucleus_shadow_map,
 		   "thread %p thread_name %s pid %d priority %d",
 		   thread, xnthread_name(thread), current->pid,
@@ -1243,10 +1248,6 @@ int xnshadow_map(xnthread_t *thread, xncompletion_t __user *u_completion,
 	xnthread_set_state(thread, XNMAPPED);
 	xnpod_suspend_thread(thread, XNRELAX, XN_INFINITE, XN_RELATIVE, NULL);
 
-	/* Restrict affinity to a single CPU of nkaffinity & current set. */
-	xnarch_cpus_and(affinity, current->cpus_allowed, nkaffinity);
-	affinity = xnarch_cpumask_of_cpu(xnarch_first_cpu(affinity));
-	set_cpus_allowed(current, affinity);
 	thread->u_mode = u_mode;
 
 	if (u_completion) {
@@ -2592,6 +2593,9 @@ int xnshadow_mount(void)
 	    rthal_apc_alloc("lostage_handler", &lostage_handler, NULL);
 
 	for_each_online_cpu(cpu) {
+		if (!xnarch_cpu_supported(cpu))
+			continue;
+
 		sched = &nkpod_struct.sched[cpu];
 		sema_init(&sched->gksync, 0);
 		xnarch_memory_barrier();
@@ -2655,6 +2659,9 @@ void xnshadow_cleanup(void)
 	rthal_catch_hisyscall(NULL);
 
 	for_each_online_cpu(cpu) {
+		if (!xnarch_cpu_supported(cpu))
+			continue;
+
 		sched = &nkpod_struct.sched[cpu];
 		down(&sched->gksync);
 		sched->gktarget = NULL;

