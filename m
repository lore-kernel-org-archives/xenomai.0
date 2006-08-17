From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ZOSqkkA7uD"
Content-Transfer-Encoding: 7bit
Message-ID: <17636.56428.140050.265677@domain.hid>
Date: Thu, 17 Aug 2006 23:15:24 +0200
Subject: [Xenomai-core] [rfc, patch] allow timer interrupt to be shared.
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


--ZOSqkkA7uD
Content-Type: text/plain; charset=us-ascii
Content-Description: message body and .signature
Content-Transfer-Encoding: 7bit


Hi, 

For review, you will find attached to this mail a patch which allows
Xenomai to run on ARM platforms where the timer interrupt is
shared. Such a platform have to define the constant
IPIPE_HAVE_SHARED_TIMER_IRQ, as well as two functions or macros:
- ipipe_timer_irq_p(), used by xnpod_announce_tick to test  whether a
timer interrupt is pending, in which case it is handled, otherwise
xnpod_announce_tick returns with the XN_ISR_PROPAGATE so that the
interrupt is propagated to the Linux domain.
- ipipe_mark_root_timer_irq(), used by xnarch_relay_tick so that the
interrupt propagated by xnarch_relay_tick is treated by the root domain
as a timer irq. As a matter of fact, since the interrupt is shared, the
root domain has to know whether the irq is a timer irq, and since this
interrupt is forged, the root domain can not rely on the same hardware
mechanism as the xenomai domain irq.

The patch also contains a tiny patch of Xenomai syslib so that
__tickAnnounce has the same return value as xnpod_announce_tick.



-- 


					    Gilles Chanteperdrix.

--ZOSqkkA7uD
Content-Type: text/plain
Content-Disposition: inline;
	filename="xeno-shared-timer-irq.diff"
Content-Transfer-Encoding: 7bit

Index: include/asm-generic/hal.h
===================================================================
--- include/asm-generic/hal.h	(revision 1451)
+++ include/asm-generic/hal.h	(working copy)
@@ -679,6 +679,12 @@
 
 #endif /* CONFIG_IPIPE_TRACE */
 
+#ifdef IPIPE_HAVE_SHARED_TIMER_IRQ
+#define RTHAL_HAVE_SHARED_TIMER_IRQ
+#define rthal_timer_irq_p()         ipipe_timer_irq_p()
+#define rthal_mark_root_timer_irq() ipipe_mark_root_timer_irq()
+#endif /* IPIPE_SHARED_TIMER_IRQ */
+
 #ifdef __cplusplus
 }
 #endif /* __cplusplus */
Index: include/asm-generic/system.h
===================================================================
--- include/asm-generic/system.h	(revision 1451)
+++ include/asm-generic/system.h	(working copy)
@@ -487,4 +487,9 @@
 #define xnarch_post_graph(obj,state)
 #define xnarch_post_graph_if(obj,state,cond)
 
+#ifdef RTHAL_HAVE_SHARED_TIMER_IRQ
+#define XNARCH_HAVE_SHARED_TIMER_IRQ
+#define xnarch_timer_irq_p()         rthal_timer_irq_p()
+#endif /* IPIPE_SHARED_TIMER_IRQ */
+
 #endif /* !_XENO_ASM_GENERIC_SYSTEM_H */
Index: include/asm-arm/bits/intr.h
===================================================================
--- include/asm-arm/bits/intr.h	(revision 1451)
+++ include/asm-arm/bits/intr.h	(working copy)
@@ -27,6 +27,9 @@
 
 static inline void xnarch_relay_tick(void)
 {
+#ifdef RTHAL_HAVE_SHARED_TIMER_IRQ
+	rthal_mark_root_timer_irq();
+#endif /* RTHAL_HAVE_SHARED_TIMER_IRQ */
 	rthal_irq_host_pend(RTHAL_TIMER_IRQ);
 }
 
Index: ksrc/skins/vxworks/sysLib.c
===================================================================
--- ksrc/skins/vxworks/sysLib.c	(revision 1451)
+++ ksrc/skins/vxworks/sysLib.c	(working copy)
@@ -24,19 +24,20 @@
 
 static wind_tick_handler_t tick_handler;
 static long tick_handler_arg;
+static int tick_status [XNARCH_NR_CPUS];
 
 void tickAnnounce(void)
 {
 	if (tick_handler != NULL)
 		tick_handler(tick_handler_arg);
 
-	xnpod_announce_tick(&nkclock);
+	tick_status[xnarch_current_cpu()] = xnpod_announce_tick(&nkclock);
 }
 
 static int __tickAnnounce(xnintr_t *intr)
 {
 	tickAnnounce();
-	return XN_ISR_HANDLED | XN_ISR_NOENABLE;
+	return tick_status[xnarch_current_cpu()];
 }
 
 int wind_sysclk_init(u_long init_rate)
Index: ksrc/nucleus/pod.c
===================================================================
--- ksrc/nucleus/pod.c	(revision 1451)
+++ ksrc/nucleus/pod.c	(working copy)
@@ -3249,6 +3249,11 @@
 {
 	xnsched_t *sched;
 
+#ifdef XNARCH_HAVE_SHARED_TIMER_IRQ
+	if (!xnarch_timer_irq_p())
+		return XN_ISR_NONE | XN_ISR_NOENABLE | XN_ISR_PROPAGATE;
+#endif /* XNARCH_HAVE_SHARED_TIMER_IRQ */
+	
 	sched = xnpod_current_sched();
 
 	xnlock_get(&nklock);

--ZOSqkkA7uD--

