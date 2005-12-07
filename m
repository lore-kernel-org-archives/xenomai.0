Message-ID: <4396CD86.6050904@domain.hid>
Date: Wed, 07 Dec 2005 13:54:46 +0200
From: Heikki Lindholm <holindho@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000308020900000908050503"
Subject: [Xenomai-core] [PATCH] Xenomai 2.1: Add SMP timer support for
	powerpc
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
--------------000308020900000908050503
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Add SMP timer support code for the powerpc arch in Xenomai 2.1. Still a 
bit rough, but I'll clean it up as I go. Compiled and tested on G5 UP, 
SMP (I-pipe 2.6.14 0.9-02) and G4 UP (I-pipe 2.6.14 1.0-07). Doesn't 
seem to break anything. On a G5, SMP seems to bring a 2-3usec latency 
penalty.

-- Heikki Lindholm

--------------000308020900000908050503
Content-Type: text/plain; x-mac-type="0"; x-mac-creator="0";
	name="xenomai-powerpc-smp-timers-051206.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="xenomai-powerpc-smp-timers-051206.patch"

diff -Nru xenomai/include/asm-powerpc/hal.h xenomai-devel/include/asm-powerpc/hal.h
--- xenomai/include/asm-powerpc/hal.h	2005-12-04 12:21:36.000000000 +0200
+++ xenomai-devel/include/asm-powerpc/hal.h	2005-12-06 13:15:35.000000000 +0200
@@ -138,6 +138,10 @@
 #define RTHAL_TIMER_IRQ   ADEOS_TIMER_VIRQ
 #else /* !CONFIG_ADEOS_CORE */
 #define RTHAL_TIMER_IRQ   IPIPE_TIMER_VIRQ
+#ifdef CONFIG_SMP
+#define RTHAL_TIMER_IPI		IPIPE_SERVICE_IPI3
+#define RTHAL_HOST_TIMER_IPI	IPIPE_SERVICE_IPI4
+#endif /* CONFIG_SMP */
 #endif /* CONFIG_ADEOS_CORE */
 
 #define rthal_irq_descp(irq)	(&irq_desc[(irq)])
@@ -204,7 +208,7 @@
 #ifdef CONFIG_40x
     mtspr(SPRN_PIT,delay);
 #else /* !CONFIG_40x */
-    set_dec(delay);
+    set_dec((int)delay); /* decrementer is only 32-bits */
 #endif /* CONFIG_40x */
 }
 
diff -Nru xenomai/include/asm-powerpc/system.h xenomai-devel/include/asm-powerpc/system.h
--- xenomai/include/asm-powerpc/system.h	2005-12-04 12:21:36.000000000 +0200
+++ xenomai-devel/include/asm-powerpc/system.h	2005-12-06 13:18:11.000000000 +0200
@@ -581,12 +581,11 @@
 }
 
 static inline int xnarch_send_timer_ipi (xnarch_cpumask_t mask)
-
 {
 #ifdef CONFIG_SMP
-    return -1;		/* FIXME */
+	return rthal_send_ipi(RTHAL_TIMER_IPI, mask);
 #else /* ! CONFIG_SMP */
-    return 0;
+	return 0;
 #endif /* CONFIG_SMP */
 }
 
@@ -595,9 +594,12 @@
 #ifdef XENO_INTR_MODULE
 
 static inline void xnarch_relay_tick (void)
-
 {
-    rthal_irq_host_pend(RTHAL_TIMER_IRQ);
+#ifdef CONFIG_SMP
+	rthal_send_ipi(RTHAL_HOST_TIMER_IPI, cpu_online_map);
+#else /* !CONFIG_SMP */
+	rthal_irq_host_pend(RTHAL_TIMER_IRQ);
+#endif /* CONFIG_SMP */
 }
 
 static inline void xnarch_announce_tick(void)
diff -Nru xenomai/ksrc/arch/powerpc/hal.c xenomai-devel/ksrc/arch/powerpc/hal.c
--- xenomai/ksrc/arch/powerpc/hal.c	2005-12-04 12:21:43.000000000 +0200
+++ xenomai-devel/ksrc/arch/powerpc/hal.c	2005-12-06 13:33:54.000000000 +0200
@@ -31,6 +31,8 @@
  *
  *@{*/
 
+#undef DEBUG
+
 #include <linux/version.h>
 #include <linux/slab.h>
 #include <linux/errno.h>
@@ -51,6 +53,12 @@
 #endif /* CONFIG_PROC_FS */
 #include <stdarg.h>
 
+#ifdef DEBUG
+#define DBG(fmt...) udbg_printf(fmt)
+#else
+#define DBG(fmt...)
+#endif
+
 static struct {
 
     unsigned long flags;
@@ -58,69 +66,215 @@
 
 } rthal_linux_irq[IPIPE_NR_XIRQS];
 
-static int rthal_periodic_p;
+static int rthal_periodic_p[RTHAL_NR_CPUS];
 
-int rthal_timer_request (void (*handler)(void),
-			 unsigned long nstick)
+/* the following two functions are very much alike to the I-pipe tune_timer
+ * implementation, but tuned for crtitical_enter/exit usage
+ * 
+ * rthal_set_local_timer might come useful with processor hotplug events
+ */
+static void rthal_set_local_cpu_timer(void)
 {
-    unsigned long flags;
-    int err;
+	long ticks;
+	rthal_declare_cpuid;
 
-    flags = rthal_critical_enter(NULL);
+	rthal_load_cpuid();
 
-    if (nstick > 0)
-	{
-	/* Periodic setup --
-	   Use the built-in Adeos service directly. */
-	err = rthal_set_timer(nstick);
-	rthal_periodic_p = 1;
-	}
-    else
-	{
-	/* Oneshot setup. */
-	disarm_decr[rthal_processor_id()] = 1;
-	rthal_periodic_p = 0;
+	disarm_decr[cpuid] = (__ipipe_decr_ticks != tb_ticks_per_jiffy);
 #ifdef CONFIG_40x
-        mtspr(SPRN_TCR,mfspr(SPRN_TCR) & ~TCR_ARE); /* Auto-reload off. */
-#endif /* CONFIG_40x */
-	rthal_timer_program_shot(tb_ticks_per_jiffy);
+	/* Enable and set auto-reload. */
+	mtspr(SPRN_TCR, mfspr(SPRN_TCR) | TCR_ARE);
+	mtspr(SPRN_PIT, __ipipe_decr_ticks);
+#else	/* !CONFIG_40x */
+	ticks = (long)(__ipipe_decr_next[cpuid] - __ipipe_read_timebase());
+	set_dec(ticks > 0 ? ticks : 0);
+#endif	/* CONFIG_40x */
+	DBG("rthal_set_local_cpu_timer(%d): %ld\n", cpuid, ticks);
+}
+
+static int rthal_set_cpu_timers_unsafe(unsigned long ns)
+{
+	unsigned long ticks;
+	unsigned long offset, previous_tb;
+	int i;
+	rthal_declare_cpuid;
+
+	DBG("rthal_set_cpu_timers_unsafe: %lu\n", ns);
+	
+	if (ns == 0)
+		ticks = tb_ticks_per_jiffy;
+	else {
+		ticks = ns * tb_ticks_per_jiffy / (1000000000 / HZ);
+
+		if (ticks > tb_ticks_per_jiffy) {
+			DBG("rthal_set_cpu_timers_unsafe: -EINVAL (%lu)\n", ticks);
+			return -EINVAL;
+		}
 	}
 
-    rthal_irq_release(RTHAL_TIMER_IRQ);
-
-    err = rthal_irq_request(RTHAL_TIMER_IRQ,
-			    (rthal_irq_handler_t)handler,
-			    NULL,
-			    NULL);
+	/* space timers on SMP to prevent lock contention in the handler */
+	rthal_load_cpuid();
+	offset = ticks/cpus_weight(cpu_possible_map);
+	DBG("rthal_set_cpu_timers_unsafe(%d): ticks=%lu offset=%lu\n", cpuid, ticks, offset);
+
+	previous_tb = __ipipe_read_timebase() + ticks;
+	__ipipe_decr_next[cpuid] = previous_tb;
+	for_each_cpu(i) {
+		if (i != cpuid) {
+			__ipipe_decr_next[i] = previous_tb + offset;
+			previous_tb = __ipipe_decr_next[i];
+		}
+	}
+	__ipipe_decr_ticks = ticks;
 
-    rthal_critical_exit(flags);
+	return 0;
+}
 
-    return err;
+static void rthal_critical_sync(void) {
+	rthal_declare_cpuid;
+	
+	rthal_load_cpuid();
+	switch (rthal_sync_op) {
+		case 1:
+			/* timer_request */
+			if (rthal_periodic_p[cpuid]) 
+				rthal_set_local_cpu_timer();
+			
+			break;
+		case 2:
+			/* timer_release */
+			if (rthal_periodic_p[cpuid])
+				rthal_set_local_cpu_timer();
+			else
+				set_dec(tb_ticks_per_jiffy);
+			
+			break;
+		case 3:
+			/* cancel action */
+			break;
+	}
 }
 
-void rthal_timer_release (void)
+static void rthal_smp_relay_tick(unsigned irq, void *cookie)
+{
+	rthal_irq_host_pend(RTHAL_TIMER_IRQ);
+}
 
+int rthal_timer_request (void (*handler)(void), 
+		unsigned long nstick)
 {
-    unsigned long flags;
+	unsigned long flags;
+	int err = 0;
+	int i;
+	rthal_declare_cpuid;
 
-    flags = rthal_critical_enter(NULL);
+	flags = rthal_critical_enter(&rthal_critical_sync);
 
-    if (rthal_periodic_p)
-	rthal_reset_timer();
-    else
-	{
-	disarm_decr[rthal_processor_id()] = 0;
+	rthal_sync_op = 1;
+
+	if (nstick > 0) {
+		/* Periodic setup --
+		 * Use the built-in Adeos service directly. */
+		err = rthal_set_cpu_timers_unsafe(nstick);
+		for_each_present_cpu(i) {
+			rthal_periodic_p[i] = 1;
+		}
+	}
+	else {
+		/* Oneshot setup. */
+		for_each_present_cpu(i) {
+			disarm_decr[i] = 1;
+			rthal_periodic_p[i] = 0;
+		}
 #ifdef CONFIG_40x
-	mtspr(SPRN_TCR,mfspr(SPRN_TCR)|TCR_ARE); /* Auto-reload on. */
-	mtspr(SPRN_PIT,tb_ticks_per_jiffy);
-#else /* !CONFIG_40x */
-	set_dec(tb_ticks_per_jiffy);
+		mtspr(SPRN_TCR,mfspr(SPRN_TCR) & ~TCR_ARE); /* Auto-reload off. */
 #endif /* CONFIG_40x */
+		rthal_timer_program_shot(tb_ticks_per_jiffy);
+	}
+	if (err) 
+		goto out;
+	
+	rthal_load_cpuid();
+
+	rthal_irq_release(RTHAL_TIMER_IRQ);
+	if ((err = rthal_irq_request(RTHAL_TIMER_IRQ,
+			(rthal_irq_handler_t)handler,
+			NULL,
+			NULL)) < 0) {
+		goto out;
+	}
+
+#ifdef CONFIG_SMP
+	rthal_irq_release(RTHAL_TIMER_IPI);
+	if ((err = rthal_irq_request(RTHAL_TIMER_IPI,
+			(rthal_irq_handler_t)handler,
+			NULL,
+			NULL)) < 0) {
+		rthal_irq_release(RTHAL_TIMER_IRQ);
+		goto out;
+	}
+	rthal_irq_release(RTHAL_HOST_TIMER_IPI);
+	if ((err = rthal_irq_request(RTHAL_HOST_TIMER_IPI,
+			&rthal_smp_relay_tick,
+			NULL,
+			NULL)) < 0) {
+		rthal_irq_release(RTHAL_TIMER_IRQ);
+		goto out;
+	}
+#endif /* CONFIG_SMP */
+	
+	if (rthal_periodic_p[cpuid])
+		rthal_set_local_cpu_timer();
+	
+out:
+	if (err) {
+		rthal_sync_op = 3;
+		__ipipe_decr_ticks = tb_ticks_per_jiffy;
+		for_each_present_cpu(i) {
+			disarm_decr[i] = 0;
+		}
 	}
+	rthal_critical_exit(flags);
+	
+	return err;
+}
+
+void rthal_timer_release (void)
+{
+	unsigned long flags;
+	rthal_declare_cpuid;
 
-    rthal_irq_release(RTHAL_TIMER_IRQ);
+	flags = rthal_critical_enter(&rthal_critical_sync);
+    
+	rthal_sync_op = 2;
+
+	rthal_load_cpuid();
+    
+	if (rthal_periodic_p[cpuid])
+		rthal_set_cpu_timers_unsafe(0);
+	else {
+		int i;
+		for_each_present_cpu(i) {
+			disarm_decr[i] = 0;
+		}
+#ifdef CONFIG_40x
+		mtspr(SPRN_TCR,mfspr(SPRN_TCR)|TCR_ARE); /* Auto-reload on. */
+		mtspr(SPRN_PIT,tb_ticks_per_jiffy);
+#else /* !CONFIG_40x */
+		set_dec(tb_ticks_per_jiffy);
+#endif /* CONFIG_40x */
+	}
 
-    rthal_critical_exit(flags);
+#ifdef CONFIG_SMP
+	rthal_irq_release(RTHAL_HOST_TIMER_IPI);
+	rthal_irq_release(RTHAL_TIMER_IPI);
+#endif /* CONFIG_SMP */
+	rthal_irq_release(RTHAL_TIMER_IRQ);
+
+	if (rthal_periodic_p[cpuid])
+		rthal_set_local_cpu_timer();
+    
+	rthal_critical_exit(flags);
 }
 
 unsigned long rthal_timer_calibrate (void)

--------------000308020900000908050503--

